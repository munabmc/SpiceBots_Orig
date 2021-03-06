module(..., package.seeall);

require('io')
require('os')
require('unix');

local volume = 25;

-- define speak queue file
fifo = '/tmp/speakFIFO'..(os.getenv('USER') or '');

-- clean up old fifo if it exists
unix.system('rm -f '..fifo);

-- create directory if needed
unix.system('mkdir -p /tmp/');

-- create the queue file (438 = 0666 permissions)
if (unix.mkfifo(fifo, 438) ~= 0) then
  error('Could not create FIFO: '..fifo);
end

-- open the fifo
fid = io.open(fifo, 'a+');
if not fid then
  error('could not open fifo: '..fifo);
end

-- start espeak background process
if (unix.system('(/usr/bin/env espeak --stdout -s 130 -a '..volume..' < '..fifo..' | aplay) > /dev/null 2>&1 &') ~= 0) then
  error('Could not run speak process');
end


function talk(text)
  print('Speak: '..text);
  fid:write(text..'\n');
  fid:flush()
end

function play(filename)
  unix.system('aplay '..filename..' &');
end

