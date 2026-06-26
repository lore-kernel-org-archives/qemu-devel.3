Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6F5EC43458
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 13:17:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wd6Q3-0008O4-O5; Fri, 26 Jun 2026 09:16:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1wd6Pp-0008De-3B
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 09:16:18 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1wd6Pj-00010i-12
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 09:16:15 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-46f34d8f888so597557f8f.2
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 06:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782479769; x=1783084569; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=myfBXCt2K0eelQGeRMA7eEt1nCzzaHeqqBnY+kQMtPE=;
 b=EeH6684H3/Hc+1jdDKe4TUrFrtUReJoHCGZ3NfHBZsHKhd0YcSi1w8+nSYsXhSM2i0
 z/JkP2chCM31rmnxXt41rOtI+m3Z3530jly+QR7Ezl0/QtVcoRCgmCt+1jcm/EitRjoC
 wQqu/AVsCHXY9vjBO3+yjxMId1dY+i/2EbKsTpKIWRbx7nUk8zBxRWwFLDl6PYye3HFf
 WA94g2g3RRndgaQ1rUJxgTgC2Q5P4Ck1gEx1c6Al9h/N0kAcIFdbUiguBpFMMwskHAwN
 fqSjwGi4fB3+2x5RVVvSC/3V+eyxKXgJvTMnjwWL9XNV8eWnfV3SL7ZWMPVC/A3kSHyx
 +GwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782479769; x=1783084569;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=myfBXCt2K0eelQGeRMA7eEt1nCzzaHeqqBnY+kQMtPE=;
 b=mWxnt/61EL/CG7+AykNLCiuhjoxm7sh4Qjrz8p3W9/dPP3296ownb3W410J42Nt7fD
 4hjIDJNWio+bJX2g/OtIbQNto4yxGcSwzCB/CBxrbhEQ+ETZ+UiGpQbVrlxhL+E2Er4r
 Q2t7RJOJMJHuiGLM0FmD8A+qTYWdf8THp/B1/3wg9xXYA6zgeaTNqBy5IVZY0o7cq6yH
 dnKdmIn6XzNOiPCxnvEAI5V0R9X59LgN9MZyO67XIfwRkIf6M7IacPZTwRGXYyircp63
 pcDKtGsvq+/Y9c4tdc0cXeJ++ElBIYDj1Hms5mmWuhz/6T3gv59uAZzUA7aNgfhAoM8A
 Ib8w==
X-Gm-Message-State: AOJu0YxCdZcJhtPmx5z73mpZMylKbLDntQ5fNfxkKp1Qq1CBkj9in6bJ
 Q3n9nFlHbjCyvUjbliMVlxj2SOLWq0hLBSSsMiPXsoNNbZVxKUHNzmHUixQ7ig==
X-Gm-Gg: AfdE7cnY0cWIbCkFLkT7VR8pir0jYdPP79k4X0W6LZ0dk1quG7VJCKDP8iR+cWEG+vA
 uaroX9T4G/IDgzKCTIHIWMCdrCpY9GT3ZOotG+PDMR7NG3/Eu8wFOPLhDqJjxuURAAQhb0Ul0sW
 Ea9xNd4gj0fcTNyQ6dn5oL8Z92jb3ga5VeiaxgoHJZ+9Z54yl0SI9PmSCDxHhG3MNqQkBdXh83S
 ag/QPWG0gkRxSVbu9Us5gxPJanLU2heEy/5T5lVA2EH783P+NO8TP/a40mi82nObimv4Yiq0sYX
 YXxIM6I9kKb3ulUQCqGybaSVHUrFiEZNDduCnKvuuL6MTE7Lwzkmxdv41V5sIzN6h5yuxJYsfJx
 xmEaDT6w50oX/R1vyEr//Qd61DypLhXPJnfpgx0bJ1L0Bz1veDAVClutyJRspeNwkghdvCozbIV
 Nm1gQck3uOKLdKeydXen0+y2mytvFe2l8FsGw3kOhLHsj+Jg==
X-Received: by 2002:a05:6000:4913:b0:45e:ea68:523b with SMTP id
 ffacd0b85a97d-46dbf7d1902mr10235550f8f.10.1782479769360; 
 Fri, 26 Jun 2026 06:16:09 -0700 (PDT)
Received: from dobby ([2a02:8109:a394:4800:b369:c9c1:81a0:4afc])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46c2279b83fsm26093756f8f.29.2026.06.26.06.16.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2026 06:16:08 -0700 (PDT)
From: Sam Li <faithilikerun@gmail.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 cassel@kernel.org, dlemoal@kernel.org, qemu-block@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Eric Blake <eblake@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Sam Li <faithilikerun@gmail.com>
Subject: [PATCH v13 6/6] iotests: test the zoned format feature for qcow2 file
Date: Fri, 26 Jun 2026 15:15:55 +0200
Message-ID: <20260626131555.459792-7-faithilikerun@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260626131555.459792-1-faithilikerun@gmail.com>
References: <20260626131555.459792-1-faithilikerun@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=faithilikerun@gmail.com; helo=mail-wr1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The zoned format feature can be tested by:
$ tests/qemu-iotests/check -qcow2 zoned-qcow2

Signed-off-by: Sam Li <faithilikerun@gmail.com>
---
 tests/qemu-iotests/303.out                    |   4 +-
 tests/qemu-iotests/tests/qcow2-encryption.out |   4 +-
 tests/qemu-iotests/tests/zoned-qcow2          | 209 ++++++++++++++++++
 tests/qemu-iotests/tests/zoned-qcow2.out      | 191 ++++++++++++++++
 4 files changed, 404 insertions(+), 4 deletions(-)
 create mode 100755 tests/qemu-iotests/tests/zoned-qcow2
 create mode 100644 tests/qemu-iotests/tests/zoned-qcow2.out

diff --git a/tests/qemu-iotests/303.out b/tests/qemu-iotests/303.out
index b3c70827b7..684a481cae 100644
--- a/tests/qemu-iotests/303.out
+++ b/tests/qemu-iotests/303.out
@@ -47,7 +47,7 @@ header_length             112
 
 Header extension:
 magic                     0x6803f857 (Feature table)
-length                    384
+length                    432
 data                      <binary>
 
 Header extension:
@@ -133,7 +133,7 @@ wrote 1048576/1048576 bytes at offset 7340032
     {
         "name": "Feature table",
         "magic": 1745090647,
-        "length": 384,
+        "length": 432,
         "data_str": "<binary>"
     },
     {
diff --git a/tests/qemu-iotests/tests/qcow2-encryption.out b/tests/qemu-iotests/tests/qcow2-encryption.out
index 9b549dc2ab..8be3e57f6e 100644
--- a/tests/qemu-iotests/tests/qcow2-encryption.out
+++ b/tests/qemu-iotests/tests/qcow2-encryption.out
@@ -10,7 +10,7 @@ data                      <binary>
 
 Header extension:
 magic                     0x6803f857 (Feature table)
-length                    384
+length                    432
 data                      <binary>
 
 image: TEST_DIR/t.IMGFMT
@@ -24,7 +24,7 @@ No errors were found on the image.
 
 Header extension:
 magic                     0x6803f857 (Feature table)
-length                    384
+length                    432
 data                      <binary>
 
 qemu-img: Could not open 'TEST_DIR/t.IMGFMT': Missing CRYPTO header for crypt method 2
diff --git a/tests/qemu-iotests/tests/zoned-qcow2 b/tests/qemu-iotests/tests/zoned-qcow2
new file mode 100755
index 0000000000..d37100c8ab
--- /dev/null
+++ b/tests/qemu-iotests/tests/zoned-qcow2
@@ -0,0 +1,209 @@
+#!/usr/bin/env bash
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Test zone management operations for qcow2 file.
+#
+
+seq="$(basename $0)"
+echo "QA output created by $seq"
+status=1 # failure is the default!
+
+file_name="zbc.qcow2"
+_cleanup()
+{
+  _cleanup_test_img
+  _rm_test_img "$file_name"
+}
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+# get standard environment, filters and checks
+. ../common.rc
+. ../common.filter
+. ../common.qemu
+
+# This test only runs on Linux hosts with qcow2 image files.
+_supported_fmt qcow2
+_supported_proto file
+_supported_os Linux
+
+echo
+echo "=== Initial image setup ==="
+echo
+
+$QEMU_IMG create -f qcow2 $file_name -o size=768M -o zone.size=64M -o \
+zone.capacity=64M -o zone.conventional_zones=0 -o zone.max_append_bytes=32M \
+-o zone.max_open_zones=6 -o zone.max_active_zones=8 -o zone.mode=host-managed
+
+IMG="--image-opts -n driver=qcow2,file.driver=file,file.filename=$file_name"
+QEMU_IO_OPTIONS=$QEMU_IO_OPTIONS_NO_FMT
+
+echo
+echo "=== Testing a qcow2 img with zoned format ==="
+echo
+echo "case 1: test zone operations one by one"
+
+echo "(1) report zones[0]:"
+$QEMU_IO $IMG -c "zrp 0 1"
+echo
+echo "report zones[0~9]:"
+$QEMU_IO $IMG -c "zrp 0 10"
+echo
+echo "report zones[-1]:"  # zones[-1] dictates the last zone
+$QEMU_IO $IMG -c "zrp 0x2C000000 2" # 0x2C000000 / 512 = 0x160000
+echo
+echo
+echo "(2) open zones[0], zones[1], zones[-1] then close, finish, reset:"
+$QEMU_IO $IMG << EOF
+zo 0 0x4000000
+zrp 0 1
+zo 0x4000000 0x4000000
+zrp 0x4000000 1
+zo 0x2C000000 0x4000000
+zrp 0x2C000000 2
+zc 0 0x4000000
+zrp 0 1
+zc 0x4000000 0x4000000
+zrp 0x4000000 1
+zc 0x2C000000 0x4000000
+zrp 0x2C000000 2
+zf 0 0x4000000
+zrp 0 1
+zf 64M 64M
+zrp 0x4000000 2
+zf 0x2C000000 0x4000000
+zrp 0x2C000000 2
+zrs 0 0x4000000
+zrp 0 1
+zrs 0x4000000 0x4000000
+zrp 0x4000000 1
+zrs 0x2C000000 0x4000000
+zrp 0x2C000000 2
+EOF
+
+echo
+echo "(3) append write with (4k, 8k) data"
+$QEMU_IO $IMG -c "zrp 0 12" # the physical block size of the device is 4096
+echo "Append write zones[0], zones[1] twice"
+$QEMU_IO $IMG << EOF
+zap -p 0 0x1000 0x2000
+zrp 0 1
+zap -p 0 0x1000 0x2000
+zrp 0 1
+zap -p 0x4000000 0x1000 0x2000
+zrp 0x4000000 1
+zap -p 0x4000000 0x1000 0x2000
+zrp 0x4000000 1
+EOF
+
+echo
+echo "Reset all:"
+$QEMU_IO $IMG -c "zrp 0 12" -c "zrs 0 768M" -c "zrp 0 12"
+echo
+echo
+
+echo "case 2: test a sets of ops that works or not"
+echo "(1) append write (4k, 4k) and then write to full"
+$QEMU_IO $IMG << EOF
+zap -p 0 0x1000 0x1000
+zrp 0 1
+zap -p 0 0x1000 0x1ffd000
+zap -p 0 0x1000000 0x1000000
+zrp 0 1
+EOF
+
+echo "Reset zones[0]:"
+$QEMU_IO $IMG -c "zrs 0 64M" -c "zrp 0 1"
+
+echo "(2) write in zones[0], zones[3], zones[8], and then reset all"
+$QEMU_IO $IMG << EOF
+zap -p 0 0x1000 0x1000
+zap -p 0xc000000 0x1000 0x1000
+zap -p 0x20000000 0x1000 0x1000
+zrp 0 12
+zrs 0 768M
+zrp 0 12
+EOF
+
+echo "case 3: test zone resource management"
+echo "(1) write in zones[0], zones[1], zones[2] and then close it"
+$QEMU_IO $IMG << EOF
+zap -p 0 0x1000 0x1000
+zap -p 0x4000000 0x1000 0x1000
+zap -p 0x8000000 0x1000 0x1000
+zrp 0 12
+zc 0 64M
+zc 0x4000000 64M
+zc 0x8000000 64M
+zrp 0 12
+EOF
+
+echo "(2) reset all after 3(1)"
+$QEMU_IO $IMG << EOF
+zrs 0 768M
+zrp 0 12
+EOF
+
+echo
+echo "case 4: WP cache crash consistency under concurrent appends"
+echo "(1) concurrent writes to the same sequential zone (zone 5 @ 320M)"
+# Three concurrent aio_writes at WP, WP+4K, WP+8K. Data writes are
+# permitted to complete out of order
+$QEMU_IO $IMG <<EOF
+aio_write -q -P 0xa1 0x14000000 4k
+aio_write -q -P 0xa2 0x14001000 4k
+aio_write -q -P 0xa3 0x14002000 4k
+aio_flush
+zrp 0x14000000 1
+read -q -P 0xa1 0x14000000 4k
+read -q -P 0xa2 0x14001000 4k
+read -q -P 0xa3 0x14002000 4k
+EOF
+
+echo "(2) concurrent writes to different sequential zones (zones 6, 7, 9)"
+# Spread across three zones. No per-zone interaction; each zone's WP
+# must advance independently.
+$QEMU_IO $IMG <<EOF
+aio_write -q -P 0xb1 0x18000000 4k
+aio_write -q -P 0xb2 0x1C000000 4k
+aio_write -q -P 0xb3 0x24000000 4k
+aio_flush
+zrp 0x18000000 1
+zrp 0x1C000000 1
+zrp 0x24000000 1
+read -q -P 0xb1 0x18000000 4k
+read -q -P 0xb2 0x1C000000 4k
+read -q -P 0xb3 0x24000000 4k
+EOF
+
+echo "(3) reset zones with no in-flight writes (zones 5, 6)"
+# Reset zones 5 and 6 (which we wrote in (1) and (2)). WP should drop
+# back to zone_start; data reads must return zero (unallocated
+# post-reset).
+$QEMU_IO $IMG -c "zrs 0x14000000 64M" -c "zrs 0x18000000 64M" \
+              -c "zrp 0x14000000 1" -c "zrp 0x18000000 1" \
+              -c "read -q -P 0 0x14000000 4k" \
+              -c "read -q -P 0 0x18000000 4k"
+
+echo "(4) BLKRESETALL after concurrent writes"
+# Reset everything first, refill three zones with concurrent writes,
+# then RESETALL. Each zone's WP must return to its start.
+$QEMU_IO $IMG <<EOF
+zrs 0 768M
+aio_write -q -P 0xc1 0x14000000 4k
+aio_write -q -P 0xc2 0x18000000 4k
+aio_write -q -P 0xc3 0x1C000000 4k
+aio_flush
+zrp 0x14000000 1
+zrp 0x18000000 1
+zrp 0x1C000000 1
+zrs 0 768M
+zrp 0x14000000 1
+zrp 0x18000000 1
+zrp 0x1C000000 1
+EOF
+
+# success, all done
+echo "*** done"
+rm -f $seq.full
+status=0
diff --git a/tests/qemu-iotests/tests/zoned-qcow2.out b/tests/qemu-iotests/tests/zoned-qcow2.out
new file mode 100644
index 0000000000..2e2c65b6c0
--- /dev/null
+++ b/tests/qemu-iotests/tests/zoned-qcow2.out
@@ -0,0 +1,191 @@
+QA output created by zoned-qcow2
+
+=== Initial image setup ===
+
+Formatting 'zbc.qcow2', fmt=qcow2 cluster_size=65536 extended_l2=off compression_type=zlib zone.mode=host-managed zone.size=67108864 zone.capacity=67108864 zone.conventional_zones=0 zone.max_append_bytes=33554432 zone.max_active_zones=8 zone.max_open_zones=6 size=805306368 lazy_refcounts=off refcount_bits=16
+
+=== Testing a qcow2 img with zoned format ===
+
+case 1: test zone operations one by one
+(1) report zones[0]:
+start: 0x0, len 0x20000, cap 0x20000, wptr 0x0, zcond:1, [type: 2]
+
+report zones[0~9]:
+start: 0x0, len 0x20000, cap 0x20000, wptr 0x0, zcond:1, [type: 2]
+start: 0x20000, len 0x20000, cap 0x20000, wptr 0x20000, zcond:1, [type: 2]
+start: 0x40000, len 0x20000, cap 0x20000, wptr 0x40000, zcond:1, [type: 2]
+start: 0x60000, len 0x20000, cap 0x20000, wptr 0x60000, zcond:1, [type: 2]
+start: 0x80000, len 0x20000, cap 0x20000, wptr 0x80000, zcond:1, [type: 2]
+start: 0xa0000, len 0x20000, cap 0x20000, wptr 0xa0000, zcond:1, [type: 2]
+start: 0xc0000, len 0x20000, cap 0x20000, wptr 0xc0000, zcond:1, [type: 2]
+start: 0xe0000, len 0x20000, cap 0x20000, wptr 0xe0000, zcond:1, [type: 2]
+start: 0x100000, len 0x20000, cap 0x20000, wptr 0x100000, zcond:1, [type: 2]
+start: 0x120000, len 0x20000, cap 0x20000, wptr 0x120000, zcond:1, [type: 2]
+
+report zones[-1]:
+start: 0x160000, len 0x20000, cap 0x20000, wptr 0x160000, zcond:1, [type: 2]
+
+
+(2) open zones[0], zones[1], zones[-1] then close, finish, reset:
+qemu-io> qemu-io> start: 0x0, len 0x20000, cap 0x20000, wptr 0x0, zcond:3, [type: 2]
+qemu-io> qemu-io> start: 0x20000, len 0x20000, cap 0x20000, wptr 0x20000, zcond:3, [type: 2]
+qemu-io> qemu-io> start: 0x160000, len 0x20000, cap 0x20000, wptr 0x160000, zcond:3, [type: 2]
+qemu-io> qemu-io> start: 0x0, len 0x20000, cap 0x20000, wptr 0x0, zcond:1, [type: 2]
+qemu-io> qemu-io> start: 0x20000, len 0x20000, cap 0x20000, wptr 0x20000, zcond:1, [type: 2]
+qemu-io> qemu-io> start: 0x160000, len 0x20000, cap 0x20000, wptr 0x160000, zcond:1, [type: 2]
+qemu-io> qemu-io> start: 0x0, len 0x20000, cap 0x20000, wptr 0x20000, zcond:14, [type: 2]
+qemu-io> qemu-io> start: 0x20000, len 0x20000, cap 0x20000, wptr 0x40000, zcond:14, [type: 2]
+start: 0x40000, len 0x20000, cap 0x20000, wptr 0x40000, zcond:1, [type: 2]
+qemu-io> qemu-io> start: 0x160000, len 0x20000, cap 0x20000, wptr 0x180000, zcond:14, [type: 2]
+qemu-io> qemu-io> start: 0x0, len 0x20000, cap 0x20000, wptr 0x0, zcond:1, [type: 2]
+qemu-io> qemu-io> start: 0x20000, len 0x20000, cap 0x20000, wptr 0x20000, zcond:1, [type: 2]
+qemu-io> qemu-io> start: 0x160000, len 0x20000, cap 0x20000, wptr 0x160000, zcond:1, [type: 2]
+qemu-io>
+(3) append write with (4k, 8k) data
+start: 0x0, len 0x20000, cap 0x20000, wptr 0x0, zcond:1, [type: 2]
+start: 0x20000, len 0x20000, cap 0x20000, wptr 0x20000, zcond:1, [type: 2]
+start: 0x40000, len 0x20000, cap 0x20000, wptr 0x40000, zcond:1, [type: 2]
+start: 0x60000, len 0x20000, cap 0x20000, wptr 0x60000, zcond:1, [type: 2]
+start: 0x80000, len 0x20000, cap 0x20000, wptr 0x80000, zcond:1, [type: 2]
+start: 0xa0000, len 0x20000, cap 0x20000, wptr 0xa0000, zcond:1, [type: 2]
+start: 0xc0000, len 0x20000, cap 0x20000, wptr 0xc0000, zcond:1, [type: 2]
+start: 0xe0000, len 0x20000, cap 0x20000, wptr 0xe0000, zcond:1, [type: 2]
+start: 0x100000, len 0x20000, cap 0x20000, wptr 0x100000, zcond:1, [type: 2]
+start: 0x120000, len 0x20000, cap 0x20000, wptr 0x120000, zcond:1, [type: 2]
+start: 0x140000, len 0x20000, cap 0x20000, wptr 0x140000, zcond:1, [type: 2]
+start: 0x160000, len 0x20000, cap 0x20000, wptr 0x160000, zcond:1, [type: 2]
+Append write zones[0], zones[1] twice
+qemu-io> After zap done, the append sector is 0x0
+qemu-io> start: 0x0, len 0x20000, cap 0x20000, wptr 0x18, zcond:2, [type: 2]
+qemu-io> After zap done, the append sector is 0x18
+qemu-io> start: 0x0, len 0x20000, cap 0x20000, wptr 0x30, zcond:2, [type: 2]
+qemu-io> After zap done, the append sector is 0x20000
+qemu-io> start: 0x20000, len 0x20000, cap 0x20000, wptr 0x20018, zcond:2, [type: 2]
+qemu-io> After zap done, the append sector is 0x20018
+qemu-io> start: 0x20000, len 0x20000, cap 0x20000, wptr 0x20030, zcond:2, [type: 2]
+qemu-io>
+Reset all:
+start: 0x0, len 0x20000, cap 0x20000, wptr 0x30, zcond:4, [type: 2]
+start: 0x20000, len 0x20000, cap 0x20000, wptr 0x20030, zcond:4, [type: 2]
+start: 0x40000, len 0x20000, cap 0x20000, wptr 0x40000, zcond:1, [type: 2]
+start: 0x60000, len 0x20000, cap 0x20000, wptr 0x60000, zcond:1, [type: 2]
+start: 0x80000, len 0x20000, cap 0x20000, wptr 0x80000, zcond:1, [type: 2]
+start: 0xa0000, len 0x20000, cap 0x20000, wptr 0xa0000, zcond:1, [type: 2]
+start: 0xc0000, len 0x20000, cap 0x20000, wptr 0xc0000, zcond:1, [type: 2]
+start: 0xe0000, len 0x20000, cap 0x20000, wptr 0xe0000, zcond:1, [type: 2]
+start: 0x100000, len 0x20000, cap 0x20000, wptr 0x100000, zcond:1, [type: 2]
+start: 0x120000, len 0x20000, cap 0x20000, wptr 0x120000, zcond:1, [type: 2]
+start: 0x140000, len 0x20000, cap 0x20000, wptr 0x140000, zcond:1, [type: 2]
+start: 0x160000, len 0x20000, cap 0x20000, wptr 0x160000, zcond:1, [type: 2]
+start: 0x0, len 0x20000, cap 0x20000, wptr 0x0, zcond:1, [type: 2]
+start: 0x20000, len 0x20000, cap 0x20000, wptr 0x20000, zcond:1, [type: 2]
+start: 0x40000, len 0x20000, cap 0x20000, wptr 0x40000, zcond:1, [type: 2]
+start: 0x60000, len 0x20000, cap 0x20000, wptr 0x60000, zcond:1, [type: 2]
+start: 0x80000, len 0x20000, cap 0x20000, wptr 0x80000, zcond:1, [type: 2]
+start: 0xa0000, len 0x20000, cap 0x20000, wptr 0xa0000, zcond:1, [type: 2]
+start: 0xc0000, len 0x20000, cap 0x20000, wptr 0xc0000, zcond:1, [type: 2]
+start: 0xe0000, len 0x20000, cap 0x20000, wptr 0xe0000, zcond:1, [type: 2]
+start: 0x100000, len 0x20000, cap 0x20000, wptr 0x100000, zcond:1, [type: 2]
+start: 0x120000, len 0x20000, cap 0x20000, wptr 0x120000, zcond:1, [type: 2]
+start: 0x140000, len 0x20000, cap 0x20000, wptr 0x140000, zcond:1, [type: 2]
+start: 0x160000, len 0x20000, cap 0x20000, wptr 0x160000, zcond:1, [type: 2]
+
+
+case 2: test a sets of ops that works or not
+(1) append write (4k, 4k) and then write to full
+qemu-io> After zap done, the append sector is 0x0
+qemu-io> start: 0x0, len 0x20000, cap 0x20000, wptr 0x10, zcond:2, [type: 2]
+qemu-io> After zap done, the append sector is 0x10
+qemu-io> After zap done, the append sector is 0x10000
+qemu-io> start: 0x0, len 0x20000, cap 0x20000, wptr 0x20000, zcond:14, [type: 2]
+qemu-io> Reset zones[0]:
+start: 0x0, len 0x20000, cap 0x20000, wptr 0x0, zcond:1, [type: 2]
+(2) write in zones[0], zones[3], zones[8], and then reset all
+qemu-io> After zap done, the append sector is 0x0
+qemu-io> After zap done, the append sector is 0x60000
+qemu-io> After zap done, the append sector is 0x100000
+qemu-io> start: 0x0, len 0x20000, cap 0x20000, wptr 0x10, zcond:2, [type: 2]
+start: 0x20000, len 0x20000, cap 0x20000, wptr 0x20000, zcond:1, [type: 2]
+start: 0x40000, len 0x20000, cap 0x20000, wptr 0x40000, zcond:1, [type: 2]
+start: 0x60000, len 0x20000, cap 0x20000, wptr 0x60010, zcond:2, [type: 2]
+start: 0x80000, len 0x20000, cap 0x20000, wptr 0x80000, zcond:1, [type: 2]
+start: 0xa0000, len 0x20000, cap 0x20000, wptr 0xa0000, zcond:1, [type: 2]
+start: 0xc0000, len 0x20000, cap 0x20000, wptr 0xc0000, zcond:1, [type: 2]
+start: 0xe0000, len 0x20000, cap 0x20000, wptr 0xe0000, zcond:1, [type: 2]
+start: 0x100000, len 0x20000, cap 0x20000, wptr 0x100010, zcond:2, [type: 2]
+start: 0x120000, len 0x20000, cap 0x20000, wptr 0x120000, zcond:1, [type: 2]
+start: 0x140000, len 0x20000, cap 0x20000, wptr 0x140000, zcond:1, [type: 2]
+start: 0x160000, len 0x20000, cap 0x20000, wptr 0x160000, zcond:1, [type: 2]
+qemu-io> qemu-io> start: 0x0, len 0x20000, cap 0x20000, wptr 0x0, zcond:1, [type: 2]
+start: 0x20000, len 0x20000, cap 0x20000, wptr 0x20000, zcond:1, [type: 2]
+start: 0x40000, len 0x20000, cap 0x20000, wptr 0x40000, zcond:1, [type: 2]
+start: 0x60000, len 0x20000, cap 0x20000, wptr 0x60000, zcond:1, [type: 2]
+start: 0x80000, len 0x20000, cap 0x20000, wptr 0x80000, zcond:1, [type: 2]
+start: 0xa0000, len 0x20000, cap 0x20000, wptr 0xa0000, zcond:1, [type: 2]
+start: 0xc0000, len 0x20000, cap 0x20000, wptr 0xc0000, zcond:1, [type: 2]
+start: 0xe0000, len 0x20000, cap 0x20000, wptr 0xe0000, zcond:1, [type: 2]
+start: 0x100000, len 0x20000, cap 0x20000, wptr 0x100000, zcond:1, [type: 2]
+start: 0x120000, len 0x20000, cap 0x20000, wptr 0x120000, zcond:1, [type: 2]
+start: 0x140000, len 0x20000, cap 0x20000, wptr 0x140000, zcond:1, [type: 2]
+start: 0x160000, len 0x20000, cap 0x20000, wptr 0x160000, zcond:1, [type: 2]
+qemu-io> case 3: test zone resource management
+(1) write in zones[0], zones[1], zones[2] and then close it
+qemu-io> After zap done, the append sector is 0x0
+qemu-io> After zap done, the append sector is 0x20000
+qemu-io> After zap done, the append sector is 0x40000
+qemu-io> start: 0x0, len 0x20000, cap 0x20000, wptr 0x10, zcond:2, [type: 2]
+start: 0x20000, len 0x20000, cap 0x20000, wptr 0x20010, zcond:2, [type: 2]
+start: 0x40000, len 0x20000, cap 0x20000, wptr 0x40010, zcond:2, [type: 2]
+start: 0x60000, len 0x20000, cap 0x20000, wptr 0x60000, zcond:1, [type: 2]
+start: 0x80000, len 0x20000, cap 0x20000, wptr 0x80000, zcond:1, [type: 2]
+start: 0xa0000, len 0x20000, cap 0x20000, wptr 0xa0000, zcond:1, [type: 2]
+start: 0xc0000, len 0x20000, cap 0x20000, wptr 0xc0000, zcond:1, [type: 2]
+start: 0xe0000, len 0x20000, cap 0x20000, wptr 0xe0000, zcond:1, [type: 2]
+start: 0x100000, len 0x20000, cap 0x20000, wptr 0x100000, zcond:1, [type: 2]
+start: 0x120000, len 0x20000, cap 0x20000, wptr 0x120000, zcond:1, [type: 2]
+start: 0x140000, len 0x20000, cap 0x20000, wptr 0x140000, zcond:1, [type: 2]
+start: 0x160000, len 0x20000, cap 0x20000, wptr 0x160000, zcond:1, [type: 2]
+qemu-io> qemu-io> qemu-io> qemu-io> start: 0x0, len 0x20000, cap 0x20000, wptr 0x10, zcond:4, [type: 2]
+start: 0x20000, len 0x20000, cap 0x20000, wptr 0x20010, zcond:4, [type: 2]
+start: 0x40000, len 0x20000, cap 0x20000, wptr 0x40010, zcond:4, [type: 2]
+start: 0x60000, len 0x20000, cap 0x20000, wptr 0x60000, zcond:1, [type: 2]
+start: 0x80000, len 0x20000, cap 0x20000, wptr 0x80000, zcond:1, [type: 2]
+start: 0xa0000, len 0x20000, cap 0x20000, wptr 0xa0000, zcond:1, [type: 2]
+start: 0xc0000, len 0x20000, cap 0x20000, wptr 0xc0000, zcond:1, [type: 2]
+start: 0xe0000, len 0x20000, cap 0x20000, wptr 0xe0000, zcond:1, [type: 2]
+start: 0x100000, len 0x20000, cap 0x20000, wptr 0x100000, zcond:1, [type: 2]
+start: 0x120000, len 0x20000, cap 0x20000, wptr 0x120000, zcond:1, [type: 2]
+start: 0x140000, len 0x20000, cap 0x20000, wptr 0x140000, zcond:1, [type: 2]
+start: 0x160000, len 0x20000, cap 0x20000, wptr 0x160000, zcond:1, [type: 2]
+qemu-io> (2) reset all after 3(1)
+qemu-io> qemu-io> start: 0x0, len 0x20000, cap 0x20000, wptr 0x0, zcond:1, [type: 2]
+start: 0x20000, len 0x20000, cap 0x20000, wptr 0x20000, zcond:1, [type: 2]
+start: 0x40000, len 0x20000, cap 0x20000, wptr 0x40000, zcond:1, [type: 2]
+start: 0x60000, len 0x20000, cap 0x20000, wptr 0x60000, zcond:1, [type: 2]
+start: 0x80000, len 0x20000, cap 0x20000, wptr 0x80000, zcond:1, [type: 2]
+start: 0xa0000, len 0x20000, cap 0x20000, wptr 0xa0000, zcond:1, [type: 2]
+start: 0xc0000, len 0x20000, cap 0x20000, wptr 0xc0000, zcond:1, [type: 2]
+start: 0xe0000, len 0x20000, cap 0x20000, wptr 0xe0000, zcond:1, [type: 2]
+start: 0x100000, len 0x20000, cap 0x20000, wptr 0x100000, zcond:1, [type: 2]
+start: 0x120000, len 0x20000, cap 0x20000, wptr 0x120000, zcond:1, [type: 2]
+start: 0x140000, len 0x20000, cap 0x20000, wptr 0x140000, zcond:1, [type: 2]
+start: 0x160000, len 0x20000, cap 0x20000, wptr 0x160000, zcond:1, [type: 2]
+qemu-io>
+case 4: WP cache crash consistency under concurrent appends
+(1) concurrent writes to the same sequential zone (zone 5 @ 320M)
+qemu-io> qemu-io> qemu-io> qemu-io> qemu-io> start: 0xa0000, len 0x20000, cap 0x20000, wptr 0xa0018, zcond:2, [type: 2]
+qemu-io> qemu-io> qemu-io> qemu-io> (2) concurrent writes to different sequential zones (zones 6, 7, 9)
+qemu-io> qemu-io> qemu-io> qemu-io> qemu-io> start: 0xc0000, len 0x20000, cap 0x20000, wptr 0xc0008, zcond:2, [type: 2]
+qemu-io> start: 0xe0000, len 0x20000, cap 0x20000, wptr 0xe0008, zcond:2, [type: 2]
+qemu-io> start: 0x120000, len 0x20000, cap 0x20000, wptr 0x120008, zcond:2, [type: 2]
+qemu-io> qemu-io> qemu-io> qemu-io> (3) reset zones with no in-flight writes (zones 5, 6)
+start: 0xa0000, len 0x20000, cap 0x20000, wptr 0xa0000, zcond:1, [type: 2]
+start: 0xc0000, len 0x20000, cap 0x20000, wptr 0xc0000, zcond:1, [type: 2]
+(4) BLKRESETALL after concurrent writes
+qemu-io> qemu-io> qemu-io> qemu-io> qemu-io> qemu-io> start: 0xa0000, len 0x20000, cap 0x20000, wptr 0xa0008, zcond:2, [type: 2]
+qemu-io> start: 0xc0000, len 0x20000, cap 0x20000, wptr 0xc0008, zcond:2, [type: 2]
+qemu-io> start: 0xe0000, len 0x20000, cap 0x20000, wptr 0xe0008, zcond:2, [type: 2]
+qemu-io> qemu-io> start: 0xa0000, len 0x20000, cap 0x20000, wptr 0xa0000, zcond:1, [type: 2]
+qemu-io> start: 0xc0000, len 0x20000, cap 0x20000, wptr 0xc0000, zcond:1, [type: 2]
+qemu-io> start: 0xe0000, len 0x20000, cap 0x20000, wptr 0xe0000, zcond:1, [type: 2]
+qemu-io> *** done
-- 
2.53.0


