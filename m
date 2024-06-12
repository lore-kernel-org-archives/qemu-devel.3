Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A7B6C27C53
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2024 11:25:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHM61-0007ly-0G; Wed, 12 Jun 2024 07:24:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sHM5z-0007lS-F2
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 07:24:51 -0400
Received: from mail-lj1-x232.google.com ([2a00:1450:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sHM5w-0006po-IJ
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 07:24:51 -0400
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2e724bc46c4so74063731fa.2
 for <qemu-devel@nongnu.org>; Wed, 12 Jun 2024 04:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718191486; x=1718796286; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=fBrUAJiB/4sFu48zDu8Q8qq3JBKzISNNAN1xf4/bAh8=;
 b=xREzlZRtRE9txjiorjHP0r66KK1pHfUD+Y6QZm8I3bY8muY7znnGKMYHdpqbeKl5Ci
 xeRDQIE1LFYFVH2VV48//E93/WudYcdWHNn67Y6sbwXIL38yaqBM80t5xYpwQDtnjV9b
 LHny6tHcXX/1+RQp67SYicGmTU+5sc3zwqn6J3ZJhs6ZvgEMysHDY9ljBU+c+2RxXju+
 adTllX1DQq7j7pFX7ljA0ocn6wX+sbS8MEqKfBQZk/lzovk61yzNyoNnuRzf11Sz0Q+N
 hh+evvgBFbexDrsl2dgNv4UJ2r0i2IRTeilE0oalMGWBNgzPVZnCMUPPGEm0b43XbpUd
 1Krw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718191486; x=1718796286;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fBrUAJiB/4sFu48zDu8Q8qq3JBKzISNNAN1xf4/bAh8=;
 b=nWB1M39FTyiUuUsY5UQxESuWEU2ybVwaTRL4RnFkptWnTXZSiApoLri8UmFSB5/B3A
 3hUx1diHoxXta/4AyotXbyUNA3PXXErYzFqSgndCHn8R4lwTl2Y1Il0pDkiYhup0h17i
 6rHarKiDrqjyW13BJftF9PnjARL5XhJY3WiBPw3VB9T0LMqFyJwMtvK3jdy37JbZd739
 oIrQNwjjATEUvcBlrFqxskG2jKSVQYdUnf8zVEmLbwKifP5d70S81cxwRzfXxfV8YZkI
 jiF9S9owBvK6xI8s9Cej0dtLjhtux83JbG4ozxpLLTJlh+zkVJ6ZVL8fMftuyUMWcI9W
 MSLA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUyvamU2iinou2z74szsuXFJ1uXu1J5YuPhkw7iYbetTpHY1uUQf69iRryHyKfXTuo2Om98DwY6IyCX6w2wktIS8jL1sa4=
X-Gm-Message-State: AOJu0YzoA46z1TyN8C7Kel6g4f82czhUJVp9RQH/zvFLYzYwgjVyGt6H
 C/ECBXE3QXHZUNKRnrR+7+/Xp3ygenVY45kkSNMa5f1L1ipf83Izu+vE/j5ehYQ=
X-Google-Smtp-Source: AGHT+IE7hhSqpeprj1wy7eWMvbXgY5ebWwgeHf8XxKgQSxBRZI4oCh4uzJdDSIDYSuvkZ1zj6ntdng==
X-Received: by 2002:a2e:a365:0:b0:2eb:f3dd:4cf4 with SMTP id
 38308e7fff4ca-2ebfc997f20mr8969261fa.33.1718191486205; 
 Wed, 12 Jun 2024 04:24:46 -0700 (PDT)
Received: from meli-email.org (adsl-33.37.6.162.tellas.gr. [37.6.162.33])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42286ff387csm22565595e9.12.2024.06.12.04.24.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Jun 2024 04:24:45 -0700 (PDT)
Date: Wed, 12 Jun 2024 14:00:19 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-block@nongnu.org, Alberto Garcia <berto@igalia.com>,
 qemu-devel@nongnu.org
Cc: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org,
 Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Czenczek <hreitz@redhat.com>, Madeeha Javed <javed@igalia.com>
Subject: Re: [PATCH] scripts/qcow2-to-stdout.py: Add script to write qcow2
 images to stdout
User-Agent: meli 0.8.6
References: <20240610144708.81351-1-berto@igalia.com>
In-Reply-To: <20240610144708.81351-1-berto@igalia.com>
Message-ID: <eyt18.e0s2rty6vd9y@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::232;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-lj1-x232.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, 10 Jun 2024 17:47, Alberto Garcia <berto@igalia.com> wrote:
>This tool converts a disk image to qcow2, writing the result directly
>to stdout. This can be used for example to send the generated file
>over the network.
>
>This is equivalent to using qemu-img to convert a file to qcow2 and
>then writing the result to stdout, with the difference that this tool
>does not need to create this temporary qcow2 file and therefore does
>not need any additional disk space.
>
>The input file is read twice. The first pass is used to determine
>which clusters contain non-zero data and that information is used to
>create the qcow2 header, refcount table and blocks, and L1 and L2
>tables. After all that metadata is created then the second pass is
>used to write the guest data.
>
>By default qcow2-to-stdout.py expects the input to be a raw file, but
>if qemu-storage-daemon is available then it can also be used to read
>images in other formats. Alternatively the user can also run qemu-ndb
>or qemu-storage-daemon manually instead.
>
>Signed-off-by: Alberto Garcia <berto@igalia.com>
>Signed-off-by: Madeeha Javed <javed@igalia.com>
>---
> scripts/qcow2-to-stdout.py | 330 +++++++++++++++++++++++++++++++++++++
> 1 file changed, 330 insertions(+)
> create mode 100755 scripts/qcow2-to-stdout.py
>

I recommend running the `black` formatter on this script, it makes the 
code more diff-friendly and uniform. Also it has become the de-facto 
python style.

Also, it's more pythonic to name constants in uppercase, like 
allocated_l2_tables. You can check such lints with pylint 
scripts/qcow2-to-stdout.py


>diff --git a/scripts/qcow2-to-stdout.py b/scripts/qcow2-to-stdout.py
>new file mode 100755
>index 0000000000..b9f75de690
>--- /dev/null
>+++ b/scripts/qcow2-to-stdout.py
>@@ -0,0 +1,330 @@
>+#!/usr/bin/env python3
>+
>+# This tool reads a disk image in any format and converts it to qcow2,
>+# writing the result directly to stdout.
>+#
>+# Copyright (C) 2024 Igalia, S.L.
>+#
>+# Authors: Alberto Garcia <berto@igalia.com>
>+#          Madeeha Javed <javed@igalia.com>
>+#
>+# SPDX-License-Identifier: GPL-2.0-or-later
>+#
>+# qcow2 files produced by this script are always arranged like this:
>+#
>+# - qcow2 header
>+# - refcount table
>+# - refcount blocks
>+# - L1 table
>+# - L2 tables
>+# - Data clusters
>+#
>+# A note about variable names: in qcow2 there is one refcount table
>+# and one (active) L1 table, although each can occupy several
>+# clusters. For the sake of simplicity the code sometimes talks about
>+# refcount tables and L1 tables when referring to those clusters.
>+
>+import argparse
>+import atexit
>+import math
>+import os
>+import signal
>+import struct
>+import sys
>+import subprocess
>+import tempfile
>+import time
>+
>+QCOW2_DEFAULT_CLUSTER_SIZE = 65536
>+QCOW2_DEFAULT_REFCOUNT_BITS = 16
>+QCOW2_DEFAULT_VERSION = 3
>+QCOW_OFLAG_COPIED = 1 << 63
>+
>+def bitmap_set(bitmap, idx):
>+    bitmap[int(idx / 8)] |= (1 << (idx % 8))
>+
>+def bitmap_test(bitmap, idx):
>+    return (bitmap[int(idx / 8)] & (1 << (idx % 8))) != 0
>+
>+# Kill the storage daemon on exit
>+def kill_storage_daemon(pid_file, raw_file, temp_dir):
>+    if os.path.exists(pid_file):
>+        with open(pid_file, 'r') as f:
>+            pid=int(f.readline())
>+        os.kill(pid, signal.SIGTERM)
>+        while os.path.exists(pid_file):
>+            time.sleep(0.1)
>+    os.unlink(raw_file)
>+    os.rmdir(temp_dir)
>+
>+def write_features(header):
>+    qcow2_features = [
>+        # Incompatible
>+        (0, 0, 'dirty bit'),
>+        (0, 1, 'corrupt bit'),
>+        (0, 2, 'external data file'),
>+        (0, 3, 'compression type'),
>+        (0, 4, 'extended L2 entries'),
>+        # Compatible
>+        (1, 0, 'lazy refcounts'),
>+        # Autoclear
>+        (2, 0, 'bitmaps'),
>+        (2, 1, 'raw external data')
>+    ]
>+    struct.pack_into('>I', header, 0x70, 0x6803f857)
>+    struct.pack_into('>I', header, 0x74, len(qcow2_features) * 48)
>+    cur_offset = 0x78

Minor comment: extract magic values/offsets into constant globals with 
descriptive names, it'd help the code be more readable and easier to 
maintain if ported in the future to other formats.

>+    for (feature_type, feature_bit, feature_name) in qcow2_features:
>+        struct.pack_into('>BB46s', header, cur_offset,
>+                         feature_type, feature_bit, feature_name.encode('ascii'))
>+        cur_offset += 48
>+


From here onwards put everything under a main block like so:

  if __name__ == "__main__":
      parser = argparse.ArgumentParser(
          description="This program converts a QEMU disk image to qcow2 "
          "and writes it to the standard output"
      )
      etc...

>+# Command-line arguments
>+parser = argparse.ArgumentParser(description='This program converts a QEMU disk image to qcow2 '
>+                                 'and writes it to the standard output')
>+parser.add_argument('input_file', help='name of the input file')

Suggestion:

-parser.add_argument('input_file', help='name of the input file')
+parser.add_argument('input_file', help='name of the input file', type=pathlib.Path, required=True)


>+parser.add_argument('-f', dest='input_format', metavar='input_format',
>+                    default='raw',
>+                    help='format of the input file (default: raw)')
>+parser.add_argument('-c', dest='cluster_size', metavar='cluster_size',
>+                    help=f'qcow2 cluster size (default: {QCOW2_DEFAULT_CLUSTER_SIZE})',
>+                    default=QCOW2_DEFAULT_CLUSTER_SIZE, type=int,
>+                    choices=[1 << x for x in range(9,22)])
>+parser.add_argument('-r', dest='refcount_bits', metavar='refcount_bits',
>+                    help=f'width of the reference count entries (default: {QCOW2_DEFAULT_REFCOUNT_BITS})',
>+                    default=QCOW2_DEFAULT_REFCOUNT_BITS, type=int,
>+                    choices=[1 << x for x in range(7)])
>+parser.add_argument('-v', dest='qcow2_version', metavar='qcow2_version',

Maybe -q instead of -v? No strong feelings on this one, it's just that 
-v is usually version. -q is also usually --quiet so not sure...

>+                    help=f'qcow2 version (default: {QCOW2_DEFAULT_VERSION})',
>+                    default=QCOW2_DEFAULT_VERSION, type=int, choices=[2, 3])
>+args = parser.parse_args()
>+
>+qcow2_cluster_size = args.cluster_size
>+qcow2_refcount_bits = args.refcount_bits
>+qcow2_version = args.qcow2_version
>+input_format = args.input_format
>+input_file = args.input_file
>+if not os.path.exists(input_file):
>+    print(f'[Error] Input file {input_file} does not exist', file=sys.stderr)
>+    sys.exit(1)
>+
>+if qcow2_refcount_bits != 16 and qcow2_version != 3:
>+    print(f'[Error] refcount_bits={qcow2_refcount_bits} is only supported with qcow2_version=3',
>+          file=sys.stderr)
>+    sys.exit(1)
>+
>+# Some basic values
>+l1_entries_per_table = int(qcow2_cluster_size / 8)
>+l2_entries_per_table = int(qcow2_cluster_size / 8)
>+refcounts_per_table  = int(qcow2_cluster_size / 8)
>+refcounts_per_block  = int(qcow2_cluster_size * 8 / qcow2_refcount_bits)
>+
>+# If the input file is not in raw format we can use
>+# qemu-storage-daemon to make it appear as such
>+if input_format != 'raw':
>+    temp_dir = tempfile.mkdtemp()

Consider using the tempfile.TemporaryDirectory as with... context 
manager so that the temp dir cleanup is performed automatically


>+    pid_file = temp_dir + "/pid"
>+    raw_file = temp_dir + "/raw"
>+    open(raw_file, 'wb').close()

Consider using a with open(...) open manager for opening the file


>+    atexit.register(kill_storage_daemon, pid_file, raw_file, temp_dir)

Hm, this too could be a context manager. Seems very C-like to use atexit 
here.

See 
https://docs.python.org/3/library/contextlib.html#contextlib.contextmanager

for an example which I paste here:


  from contextlib import contextmanager

  @contextmanager
  def managed_resource(*args, **kwds):
      # Code to acquire resource, e.g.:
      resource = acquire_resource(*args, **kwds)
      try:
          yield resource
      finally:
          # Code to release resource, e.g.:
          release_resource(resource)

  with managed_resource(timeout=3600) as resource:
      # Resource is released at the end of this block,
      # even if code in the block raises an exception


>+    ret = subprocess.run(["qemu-storage-daemon", "--daemonize", "--pidfile", pid_file,
>+                          "--blockdev", f"driver=file,node-name=file0,driver=file,filename={input_file},read-only=on",
>+                          "--blockdev", f"driver={input_format},node-name=disk0,file=file0,read-only=on",
>+                          "--export", f"type=fuse,id=export0,node-name=disk0,mountpoint={raw_file},writable=off"])

You can add shell=True, check=False arguments to subprocess.run() so 
that it captures the outputs. (check=False is the default behavior, but 
better make it explicit)


>+    if ret.returncode != 0:
>+        print('[Error] Could not start the qemu-storage-daemon', file=sys.stderr)
>+        sys.exit(1)
>+    input_file = raw_file
>+
>+# Virtual disk size, number of data clusters and L1 entries
>+disk_size = math.ceil(os.path.getsize(input_file) / 512) * 512 # Round up to the nearest multiple of 512
>+total_data_clusters = math.ceil(disk_size / qcow2_cluster_size)
>+l1_entries = math.ceil(total_data_clusters / l2_entries_per_table)
>+allocated_l1_tables = math.ceil(l1_entries / l1_entries_per_table)
>+
>+# Max L1 table size is 32 MB (QCOW_MAX_L1_SIZE in block/qcow2.h)
>+if ((l1_entries * 8) > (32 * 1024 *1024)):
>+    print('[Error] The image size is too large. Try using a larger cluster size',
>+          file=sys.stderr)
>+    sys.exit(1)
>+
>+# Two bitmaps indicating which L1 and L2 entries are set
>+l1_bitmap = bytearray(int(allocated_l1_tables * l1_entries_per_table / 8))
>+l2_bitmap = bytearray(int(allocated_l1_tables * l1_entries_per_table * l2_entries_per_table / 8))
>+allocated_l2_tables = 0
>+allocated_data_clusters = 0
>+with open(input_file, 'rb') as reader:
>+    zero_cluster = bytes(qcow2_cluster_size)
>+    # Read all clusters from the input file
>+    for idx in range(total_data_clusters):
>+        cluster = reader.read(qcow2_cluster_size)
>+        # If the last cluster is smaller than qcow2_cluster_size pad it with zeroes
>+        if (len(cluster) < qcow2_cluster_size):
>+            cluster += bytes(qcow2_cluster_size - len(cluster))
>+        # If a cluster has non-zero data then it must be allocated
>+        # in the output file and its L2 entry must be set
>+        if cluster != zero_cluster:
>+            bitmap_set(l2_bitmap, idx)
>+            allocated_data_clusters += 1
>+            # Allocated data clusters also need their corresponding L1 entry and L2 table
>+            l1_idx = math.floor(idx / l2_entries_per_table)
>+            if not bitmap_test(l1_bitmap, l1_idx):
>+                bitmap_set(l1_bitmap, l1_idx)
>+                allocated_l2_tables += 1
>+
>+# Total amount of allocated clusters excluding the refcount blocks and table
>+total_allocated_clusters = 1 + allocated_l1_tables + allocated_l2_tables + allocated_data_clusters
>+
>+# Clusters allocated for the refcount blocks and table
>+allocated_refcount_blocks = math.ceil(total_allocated_clusters  / refcounts_per_block)
>+allocated_refcount_tables = math.ceil(allocated_refcount_blocks / refcounts_per_table)
>+
>+# Now we have a problem because allocated_refcount_blocks and allocated_refcount_tables...
>+# (a) increase total_allocated_clusters, and
>+# (b) need to be recalculated when total_allocated_clusters is increased
>+# So we need to repeat the calculation as long as the numbers change
>+while True:
>+    new_total_allocated_clusters = total_allocated_clusters + allocated_refcount_tables + allocated_refcount_blocks
>+    new_allocated_refcount_blocks = math.ceil(new_total_allocated_clusters / refcounts_per_block)
>+    if new_allocated_refcount_blocks > allocated_refcount_blocks:
>+        allocated_refcount_blocks = new_allocated_refcount_blocks
>+        allocated_refcount_tables = math.ceil(allocated_refcount_blocks / refcounts_per_table)
>+    else:
>+        break
>+
>+# Now that we have the final numbers we can update total_allocated_clusters
>+total_allocated_clusters += allocated_refcount_tables + allocated_refcount_blocks
>+
>+# At this point we have the exact number of clusters that the output
>+# image is going to use so we can calculate all the offsets.
>+current_cluster_idx = 1
>+
>+refcount_table_offset = current_cluster_idx * qcow2_cluster_size
>+current_cluster_idx += allocated_refcount_tables
>+
>+refcount_block_offset = current_cluster_idx * qcow2_cluster_size
>+current_cluster_idx += allocated_refcount_blocks
>+
>+l1_table_offset = current_cluster_idx * qcow2_cluster_size
>+current_cluster_idx += allocated_l1_tables
>+
>+l2_table_offset = current_cluster_idx * qcow2_cluster_size
>+current_cluster_idx += allocated_l2_tables
>+
>+data_clusters_offset = current_cluster_idx * qcow2_cluster_size
>+
>+# Calculate some values used in the qcow2 header
>+if allocated_l1_tables == 0:
>+    l1_table_offset = 0
>+
>+hdr_cluster_bits = int(math.log2(qcow2_cluster_size))
>+hdr_refcount_bits = 0
>+hdr_length = 0
>+if qcow2_version == 3:
>+    hdr_refcount_bits = int(math.log2(qcow2_refcount_bits))
>+    hdr_length = 0x70
>+
>+### Write qcow2 header
>+cluster = bytearray(qcow2_cluster_size)
>+struct.pack_into('>4sIQIIQIIQQIIQQQQII', cluster, 0,
>+     b'QFI\xfb',            # QCOW magic string
>+     qcow2_version,
>+     0,                     # backing file offset
>+     0,                     # backing file sizes
>+     hdr_cluster_bits,
>+     disk_size,
>+     0,                     # encryption method
>+     l1_entries,
>+     l1_table_offset,
>+     refcount_table_offset,
>+     allocated_refcount_tables,
>+     0,                     # number of snapshots
>+     0,                     # snapshot table offset
>+     0,                     # compatible features
>+     0,                     # incompatible features
>+     0,                     # autoclear features
>+     hdr_refcount_bits,
>+     hdr_length)
>+
>+if qcow2_version == 3:
>+    write_features(cluster)
>+
>+sys.stdout.buffer.write(cluster)

Would it be a good idea to check if stdout is a tty and not a 
pipe/redirection? You can check it with isatty() and error out to 
prevent printing binary to the terminal.

>+
>+### Write refcount table
>+cur_offset = refcount_block_offset
>+remaining_refcount_table_entries = allocated_refcount_blocks # Each entry is a pointer to a refcount block
>+while remaining_refcount_table_entries > 0:
>+    cluster = bytearray(qcow2_cluster_size)
>+    to_write = min(remaining_refcount_table_entries, refcounts_per_table)
>+    remaining_refcount_table_entries -= to_write
>+    for idx in range(to_write):
>+        struct.pack_into('>Q', cluster, idx * 8, cur_offset)
>+        cur_offset += qcow2_cluster_size
>+    sys.stdout.buffer.write(cluster)
>+
>+### Write refcount blocks
>+remaining_refcount_block_entries = total_allocated_clusters # One entry for each allocated cluster
>+for tbl in range(allocated_refcount_blocks):
>+    cluster = bytearray(qcow2_cluster_size)
>+    to_write = min(remaining_refcount_block_entries, refcounts_per_block)
>+    remaining_refcount_block_entries -= to_write
>+    # All refcount entries contain the number 1. The only difference
>+    # is their bit width, defined when the image is created.
>+    for idx in range(to_write):
>+        if qcow2_refcount_bits == 64:
>+            struct.pack_into('>Q', cluster, idx * 8, 1)
>+        elif qcow2_refcount_bits == 32:
>+            struct.pack_into('>L', cluster, idx * 4, 1)
>+        elif qcow2_refcount_bits == 16:
>+            struct.pack_into('>H', cluster, idx * 2, 1)
>+        elif qcow2_refcount_bits == 8:
>+            cluster[idx] = 1
>+        elif qcow2_refcount_bits == 4:
>+            cluster[int(idx / 2)] |= 1 << ((idx % 2) * 4)
>+        elif qcow2_refcount_bits == 2:
>+            cluster[int(idx / 4)] |= 1 << ((idx % 4) * 2)
>+        elif qcow2_refcount_bits == 1:
>+            cluster[int(idx / 8)] |= 1 << (idx % 8)
>+    sys.stdout.buffer.write(cluster)
>+
>+### Write L1 table
>+cur_offset = l2_table_offset
>+for tbl in range(allocated_l1_tables):
>+    cluster = bytearray(qcow2_cluster_size)
>+    for idx in range(l1_entries_per_table):
>+        l1_idx = tbl * l1_entries_per_table + idx
>+        if bitmap_test(l1_bitmap, l1_idx):
>+            struct.pack_into('>Q', cluster, idx * 8, cur_offset | QCOW_OFLAG_COPIED)
>+            cur_offset += qcow2_cluster_size
>+    sys.stdout.buffer.write(cluster)
>+
>+### Write L2 tables
>+cur_offset = data_clusters_offset
>+for tbl in range(l1_entries):
>+    # Skip the empty L2 tables. We can identify them because
>+    # there is no L1 entry pointing at them.
>+    if bitmap_test(l1_bitmap, tbl):
>+        cluster = bytearray(qcow2_cluster_size)
>+        for idx in range(l2_entries_per_table):
>+            l2_idx = tbl * l2_entries_per_table + idx
>+            if bitmap_test(l2_bitmap, l2_idx):
>+                struct.pack_into('>Q', cluster, idx * 8, cur_offset | QCOW_OFLAG_COPIED)
>+                cur_offset += qcow2_cluster_size
>+        sys.stdout.buffer.write(cluster)
>+
>+### Write data clusters
>+with open(input_file, 'rb') as reader:
>+    skip = 0
>+    for idx in range(total_data_clusters):
>+        if bitmap_test(l2_bitmap, idx):
>+            if skip > 0:
>+                reader.seek(qcow2_cluster_size * skip, 1)
>+                skip = 0
>+            cluster = reader.read(qcow2_cluster_size)
>+            # If the last cluster is smaller than qcow2_cluster_size pad it with zeroes
>+            if (len(cluster) < qcow2_cluster_size):
>+                cluster += bytes(qcow2_cluster_size - len(cluster))
>+            sys.stdout.buffer.write(cluster)
>+        else:
>+            skip += 1
>-- 
>2.39.2
>
>

