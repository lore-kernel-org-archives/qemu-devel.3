Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BC25D597C5
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2024 02:01:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tB2gq-0001jq-Jv; Tue, 12 Nov 2024 21:01:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <takeshibaconsuzuki@gmail.com>)
 id 1tB0OV-0001HX-0z; Tue, 12 Nov 2024 18:34:00 -0500
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <takeshibaconsuzuki@gmail.com>)
 id 1tB0OR-0008So-DU; Tue, 12 Nov 2024 18:33:58 -0500
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-720be27db27so5278168b3a.2; 
 Tue, 12 Nov 2024 15:33:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731454433; x=1732059233; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=st/MPV2/1+Z8iOLeaTSiJNQxS708c/yTD2s3KbkH1AY=;
 b=SigUqxKvNqIVkFCX/iq/Pleqaoc91G3RN74CY+X0njrYZLuvSSZHCt6ZTnB8kfCxJ0
 X8s17nhwRd1iUdqE82P3jdmDPUSIcGG+Tyu4d5i0DX4xECN6mQ0MgNS+UXFLX5aIFLiO
 BZsbOC0uMMJol8bmcnteR8ofj+ifT7YPzJ6Prn6LA6VqDOY8qRskQItOsGSPpZAdncrc
 vQaNZbcmLYLolkoSN0vH0R56u8nc6CzWUqJ4ELiMeuF5I8oZ45hrNmSkUPOqQIoAEHrJ
 QbIUYjrb8eylkpgdED0Mj/V2PKTlEfsjLx1iF8K1nmWq2gR3+v5Rkd1O87n0oGvpgZye
 gHpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731454433; x=1732059233;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=st/MPV2/1+Z8iOLeaTSiJNQxS708c/yTD2s3KbkH1AY=;
 b=xPmVDbbPnBVl2ggHiHX5GJ+j+HlWs1lBG2isV6itd75/gG6R+4lBJiHZD1zoN2JUvz
 6Nh3CEyd3aQ2Zz8Lj6RQicUkdGPczNG3GEXuiHlAiUOCZY8GSwACAWBWVXzTcrxS+H+v
 HOtFuOX9hSMdfQVySz0/g48ENnn3Ns8L3XNIqlyLeaPK7Lj3uIQCYNJOtqFeOcTU7od1
 Z4cdewSxata1aqU8ynAmq0bLXYLOKxkVYMubNTLZv7BbqO/sNRKnj5N7HnlJNEo+uSDA
 mXuKbM6iup8PTlR/3YoBsAaBWHQ6JOUcosMtzgSuhFHegZ9ndeHu0FTLgZvuOmhnZHVv
 6H2A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVGTg2WCTFn7cruPBfN8s5WSCkCQI7mWQyY7pzWeZkpNUKxYvzpnfbRfAC9txoHwag6cv8RP2TEb4PL@nongnu.org
X-Gm-Message-State: AOJu0YzsAlsAp2/krTJFvyL3lMD8csehrGer0QmKp/uHk1uQvGGVBGqM
 R5To4ImHKM5giA+NKqGrWXs1DEFhNLqvbMvwEfANVqac+Ji9pIMIv3GHpaZyg9U=
X-Google-Smtp-Source: AGHT+IFs79WzD+MaZyfu6Tyc2zFB+obAby8BT7kSj7dCa1IhpFtJAdzjdtRzt/j8ZMDlU6bbcFWpgQ==
X-Received: by 2002:a05:6a21:99a8:b0:1db:d738:f2ff with SMTP id
 adf61e73a8af0-1dc5f8cbcccmr5686869637.2.1731454433315; 
 Tue, 12 Nov 2024 15:33:53 -0800 (PST)
Received: from localhost.colo.rubrik.com ([104.171.196.13])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-724078bfccfsm11963033b3a.82.2024.11.12.15.33.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Nov 2024 15:33:53 -0800 (PST)
From: Takeshi Suzuki <takeshibaconsuzuki@gmail.com>
To: qemu-devel@nongnu.org
Cc: codyprime@gmail.com, kwolf@redhat.com, hreitz@redhat.com,
 qemu-block@nongnu.org, Takeshi Suzuki <takeshibaconsuzuki@gmail.com>
Subject: [PATCH 2/2] Add iotest for 4k sector size vhdx
Date: Tue, 12 Nov 2024 23:33:04 +0000
Message-Id: <20241112233304.3300-3-takeshibaconsuzuki@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241112233304.3300-1-takeshibaconsuzuki@gmail.com>
References: <20241112233304.3300-1-takeshibaconsuzuki@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=takeshibaconsuzuki@gmail.com; helo=mail-pf1-x42c.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FREEMAIL_REPLY=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 12 Nov 2024 21:01:02 -0500
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

See
https://github.com/takeshibaconsuzuki/qemu/blob/vhdx_4k_rw/tests/qemu-iotests/sample_images/4k.vhdx.bz2
for binary file.

Signed-off-by: Takeshi Suzuki <takeshibaconsuzuki@gmail.com>
---
 tests/qemu-iotests/315                       |  65 +++++++++++++++++++
 tests/qemu-iotests/315.out                   |  20 ++++++
 tests/qemu-iotests/sample_images/4k.vhdx.bz2 | Bin 0 -> 37834 bytes
 3 files changed, 85 insertions(+)
 create mode 100644 tests/qemu-iotests/315
 create mode 100644 tests/qemu-iotests/315.out
 create mode 100644 tests/qemu-iotests/sample_images/4k.vhdx.bz2

diff --git a/tests/qemu-iotests/315 b/tests/qemu-iotests/315
new file mode 100644
index 0000000000..e5c4978c8c
--- /dev/null
+++ b/tests/qemu-iotests/315
@@ -0,0 +1,65 @@
+#!/usr/bin/env bash
+# group: rw quick
+#
+# Test VHDX read/write from a 4k sector size sample image created with Hyper-V
+#
+# Copyright (C) 2013 Red Hat, Inc.
+#
+# This program is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License as published by
+# the Free Software Foundation; either version 2 of the License, or
+# (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program.  If not, see <http://www.gnu.org/licenses/>.
+#
+
+# creator
+owner=takeshibaconsuzuki@gmail.com
+
+seq=`basename $0`
+echo "QA output created by $seq"
+
+status=1	# failure is the default!
+
+_cleanup()
+{
+    _cleanup_test_img
+}
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+# get standard environment, filters and checks
+. ./common.rc
+. ./common.filter
+
+_supported_fmt vhdx
+_supported_proto generic
+_supported_os Linux
+
+_use_sample_img 4k.vhdx.bz2
+
+echo
+echo "=== Verify pattern 0xaa, 1024MB - 1088MB ==="
+$QEMU_IO -r -c "read -pP 0xaa 1024M 64M" "$TEST_IMG" | _filter_qemu_io
+echo
+echo "=== Verify pattern 0x00, 1088MB - 1152MB ==="
+$QEMU_IO -r -c "read -pP 0x00 1088M 64M" "$TEST_IMG" | _filter_qemu_io
+
+echo
+echo "=== Verify pattern write, 0xbb 1072MB - 1104MB ==="
+$QEMU_IO -c "write -pP 0xbb 1072M 32M" "$TEST_IMG" | _filter_qemu_io
+# first verify we didn't write where we should not have
+$QEMU_IO -r -c "read -pP 0xaa 1024M 48M" "$TEST_IMG" | _filter_qemu_io
+$QEMU_IO -r -c "read -pP 0x00 1104M 48M" "$TEST_IMG" | _filter_qemu_io
+# now verify what we should have actually written
+$QEMU_IO -r -c "read -pP 0xbb 1072M 32M" "$TEST_IMG" | _filter_qemu_io
+
+# success, all done
+echo "*** done"
+rm -f $seq.full
+status=0
diff --git a/tests/qemu-iotests/315.out b/tests/qemu-iotests/315.out
new file mode 100644
index 0000000000..31dd48b223
--- /dev/null
+++ b/tests/qemu-iotests/315.out
@@ -0,0 +1,20 @@
+QA output created by 315
+
+=== Verify pattern 0xaa, 1024MB - 1088MB ===
+read 67108864/67108864 bytes at offset 1073741824
+64 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+=== Verify pattern 0x00, 1088MB - 1152MB ===
+read 67108864/67108864 bytes at offset 1140850688
+64 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+=== Verify pattern write, 0xbb 1072MB - 1104MB ===
+wrote 33554432/33554432 bytes at offset 1124073472
+32 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 50331648/50331648 bytes at offset 1073741824
+48 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 50331648/50331648 bytes at offset 1157627904
+48 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 33554432/33554432 bytes at offset 1124073472
+32 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+*** done
diff --git a/tests/qemu-iotests/sample_images/4k.vhdx.bz2 b/tests/qemu-iotests/sample_images/4k.vhdx.bz2
new file mode 100644
index 0000000000..6cc10919ab
Binary files /dev/null and b/tests/qemu-iotests/sample_images/4k.vhdx.bz2 differ
-- 
2.34.1


