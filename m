Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A088CF6495
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Sep 2024 13:02:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sutYY-0002dh-0q; Sun, 29 Sep 2024 09:01:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1sutYW-0002Wr-9H; Sun, 29 Sep 2024 09:01:44 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1sutYT-00043Q-Gx; Sun, 29 Sep 2024 09:01:43 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a8d446adf6eso590190266b.2; 
 Sun, 29 Sep 2024 06:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727614899; x=1728219699; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ySJ9m73fa5O5Qrv08pA7dpL1hTljmRlpVpiHdfgnF6M=;
 b=gFqpy1qLLBoSQJvodViMoXLpz1u6wx0NfeY99wHKY2fnzLEQoezFinT1cucILqw2Xq
 9hWHddlfK5veoSowJYXaAfhGBQKSDhXWCy+rT6mC3EBatZ7YgFhzfk93mDJpu9HPh8yv
 Qbrl2XnxeqqvXnxpuxlrM1bAkh+UosSV7GdCz0MSkl/aZukeCCkj3Zvxgu9wEmJ01n+g
 IwPDl9Zo+jrtn9vPhprwLg1e3u9ZpFOlHqIdLWQJW7S0qdRA5W7NiXh7ViekBP5UXTJ6
 1O0yycxYx6kLKTETLsI0PF4cwTFdDtv0APQEiklcBQA+nTxcH5Qolde17jWQR5e1hmIw
 QN/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727614899; x=1728219699;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ySJ9m73fa5O5Qrv08pA7dpL1hTljmRlpVpiHdfgnF6M=;
 b=ahsfkDn2JvX8Q8HwsIedh1lezGb6Oaw4h6chiDFZYaDyoPiFGpTw31C647owBXC9da
 AGQgdRCp6TwLKQW+uVApTlXUcYBkmp3mGU/v6I8hmOV6dzUfP2DoLO3b42v8nZLvMGGd
 lJM9YLv31VcaGbNRLLdxhSolB/uXS/JdlEvH5gJKYnRhQt/m+eqipXV2czqua7h2Yj9B
 k/p8HiTeEAvJbAqc/1/hviq8s71PKDyjuIxMfAAvzsgBHnNvqGrQRFisW8wTuYfD3mNw
 J5QYpmF2R2BOxa4DM7khq+7jYlSvw46tTCq/L8wX9x0wnZpF9A8uJGzVf+ElhRIwnaob
 lkMw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVlpVByJisNfFEsBMr27vFEks8o+Tb3xzD0RioEI2/yvXoJbm0AzsQVA/HAqBhvc/r1+kI3ooXOmGfw@nongnu.org
X-Gm-Message-State: AOJu0Yxl06e6yoS8j8I6qpcNbVborwdBh0k/Q4pj3T134oLlCWKxh0iu
 Fvej35cW4+4f+HoP5kr42W6Gsj8T+aNw8HvH5UXv0S9fNQkpS69y5zlaAdqJ
X-Google-Smtp-Source: AGHT+IHfAaR+BrBz3D3Ix4ncGVhQjPOqN3mrSrIH4+HLV7NUHIxMUBv2e8V3hm8faCl//lmZGpTD7Q==
X-Received: by 2002:a17:907:7207:b0:a8d:2b7a:ff44 with SMTP id
 a640c23a62f3a-a93c492a6aamr1091150966b.32.1727614899045; 
 Sun, 29 Sep 2024 06:01:39 -0700 (PDT)
Received: from groves.fkb.profitbricks.net
 (ip5f5af605.dynamic.kabel-deutschland.de. [95.90.246.5])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a93c27776cesm373146966b.40.2024.09.29.06.01.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 29 Sep 2024 06:01:38 -0700 (PDT)
From: Sam Li <faithilikerun@gmail.com>
X-Google-Original-From: Sam Li <jia.li@ionos.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, stefanha@redhat.com,
 Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>,
 dmitry.fomichev@wdc.com, Hanna Reitz <hreitz@redhat.com>,
 dlemoal@kernel.org, qemu-block@nongnu.org, hare@suse.de,
 Sam Li <faithilikerun@gmail.com>
Subject: [PATCH v8 4/4] iotests: test the zoned format feature for qcow2 file
Date: Sun, 29 Sep 2024 15:01:33 +0200
Message-Id: <20240929130133.535568-5-jia.li@ionos.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240929130133.535568-1-jia.li@ionos.com>
References: <20240929130133.535568-1-jia.li@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=faithilikerun@gmail.com; helo=mail-ej1-x629.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Sam Li <faithilikerun@gmail.com>

The zoned format feature can be tested by:
$ tests/qemu-iotests/check -qcow2 zoned-qcow2

Signed-off-by: Sam Li <faithilikerun@gmail.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 tests/qemu-iotests/tests/zoned-qcow2     | 148 +++++++++++++++++++
 tests/qemu-iotests/tests/zoned-qcow2.out | 173 +++++++++++++++++++++++
 2 files changed, 321 insertions(+)
 create mode 100755 tests/qemu-iotests/tests/zoned-qcow2
 create mode 100644 tests/qemu-iotests/tests/zoned-qcow2.out

diff --git a/tests/qemu-iotests/tests/zoned-qcow2 b/tests/qemu-iotests/tests/zoned-qcow2
new file mode 100755
index 0000000000..da5b8944c5
--- /dev/null
+++ b/tests/qemu-iotests/tests/zoned-qcow2
@@ -0,0 +1,148 @@
+#!/usr/bin/env bash
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
+# success, all done
+echo "*** done"
+rm -f $seq.full
+status=0
diff --git a/tests/qemu-iotests/tests/zoned-qcow2.out b/tests/qemu-iotests/tests/zoned-qcow2.out
new file mode 100644
index 0000000000..b62865a487
--- /dev/null
+++ b/tests/qemu-iotests/tests/zoned-qcow2.out
@@ -0,0 +1,173 @@
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
+qemu-io> *** done
-- 
2.34.1


