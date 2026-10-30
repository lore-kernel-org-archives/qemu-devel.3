Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D225606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 16:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=smartx-com.20260707.gappssmtp.com header.i=@smartx-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=atwzXo1p
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMpLy-00043X-BH; Fri, 30 Oct 2026 12:21:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <haoqian.he@smartx.com>)
 id 1xMpLt-00042m-L5
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 12:21:14 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <haoqian.he@smartx.com>)
 id 1xMpLq-00079w-5l
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 12:21:13 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-c450ab1483cso144049566b.3
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 09:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20260707.gappssmtp.com; s=20260707; t=1793377267; x=1793982067;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OgvKXF3/zSlbzwq5w5PSXbuiN6HpLso+cBf1M57bjNM=;
 b=atwzXo1pG9x+m9jqIULbQyfRq9mtsg3GPvhwFzkRkVGEVu1iYI3X+cZ9UJh0w8CHzR
 W+LBXFohJgoHaOdVa7nbWZZZQHWHSlI/apWksSA434q0O1XvoaLAGPAObBNBvORSLtNK
 jrnVcDUU7TS19Sdt6aZ94GNEGc0b/b8ib8EYXpAHWmTXNMRB6zA3g/CiLecM61w0QEpV
 ALyOmGVTzfXrmZGhs+LLS0VmOlsG60EsckvynMxLcjBs+IAR7DZDGiXU9+lfDZAC6wow
 RCkPg6XiDb96tSbagHEqSiGd1ftaQyyplMg9CQgfCsmhp7bCbr/cnx1PWQrSZPt5I8rK
 rO4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793377267; x=1793982067;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=OgvKXF3/zSlbzwq5w5PSXbuiN6HpLso+cBf1M57bjNM=;
 b=vED/D//CMq8pluHB4Wiv/YqVNI9RJYG0FPM4HaGoXaJ6ROeGsuJu7PfqxbRb2n6deX
 iEQeGHU6hlxPawoeghQHNz3DPpQeIDp/+eCogvSItdP5/ntQifiEqnh/E2qpApjiBpmM
 Myu/rir2MgbgdcoV/oK0/hwk602Jynb6aDBhQHXU8XltpvrFW67d+rZdonO2zlCEIkEl
 gbGyMppzcapJC3FsARSRdDucLP+kxpVWoGFpmsWctkNPdZ/RVEeRMeYN7xEVfA8pBdEG
 AWkrY0cMALQ9bEWk2TnlfckG4eQDopBnXrJ9IyJJVQie2j3VY1S660c+M4BFpeBKZg2f
 k/lg==
X-Gm-Message-State: AFq9FYJL9voKkNhZQibieqTjP2oLhI7hQx4oYva8DLdADTUuYpqEwbFP
 a9LHK7rW7TUNtSFabxM3nNYfy4Dr1PaIkspOeZGvjsZ1dgVh+0mv8clFwTeFq/fIiWUY+ZoGT4n
 iRVTTdYQPGD3H/jjKAITkcc2h2+jHM6rqzPEf+/snUxJdPVbfKg==
X-Gm-Gg: AYBFou0woarHv8DzaExwQGpTVtBV/3fUf+DsVSMibRJYzJ2OuAeu3dUoEPSSlVXyshZ
 a9Ayhd+3E/fp0Pr6aIRTvEIj8ftfM4qvtI7DC3oB27DBINHf1dI3m0mxhUxETox/wD23rN5PIbX
 8HlQxCs/kqGiHLnvvh2wiy5wVNq6Odw29NUhVuEnDgIQY2hFTQUPjDj/vOCn3HpxZ+F3bb9w/TB
 eDgqJPlOxO8ii4x6bGYzCRkXHJzquISQQtgz1axND3InIdtBXGTdTxYdrEM4EQcK7HGyR4UYdDK
 TKiNdJZiGfG641J4A3f90N5bYkBLNV8un0vGiA/o4GD5e5Au2ejbRQM6xHlb0fby3MYjsdr6R5/
 fOtSYF3034R0EpXYKFS/XRuhAUuER9987helBHAYftjw4RSoTmekycQxviU5XjnpzKC1GfubKZl
 b4QtNKSklxpx/onVkEnzeiOGhs0S6GkQ34Sdj8+FuD5H8xS/CvZW6x9abFfTRK2mro2nNK8rQzI
 McNVXyHwFuvQ9Vex3wQISGMxPyYqdyMXB4rN3BVxv24Le1w+S9V9EzGjXlOdLG3Rc5VfFsYVxVs
 FI7D34EkVizH0fXTPaqTLOc+h57ju3AqD8nu2MF1WDtxEZ2jVJ4s7JA48/qFgaId69z4EKk3rCj
 GrBj3Zw==
X-Received: by 2002:a17:907:d406:b0:c29:f5d8:9c6b with SMTP id
 a640c23a62f3a-c4ca7aa01ebmr252158866b.26.1793377267157; 
 Fri, 30 Oct 2026 09:21:07 -0700 (PDT)
Received: from 9950x (47-147-0-185.lsan.ca.frontiernet.net. [47.147.0.185])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c4cabe4a7e5sm84965766b.57.2026.10.30.09.21.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 09:21:06 -0700 (PDT)
From: Haoqian He <haoqian.he@smartx.com>
To: kwolf@redhat.com
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, fengli@smartx.com,
 jsnow@redhat.com, vsementsov@yandex-team.ru, hreitz@redhat.com
Subject: [PATCH] iotests: cover discard passthrough during background mirror
Date: Sat, 31 Oct 2026 00:20:41 +0800
Message-ID: <20261030162041.3191556-1-haoqian.he@smartx.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <auR5f-cvvNgsMqxF@redhat.com>
References: <auR5f-cvvNgsMqxF@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=haoqian.he@smartx.com; helo=mail-ej1-x62d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

A mirror_top node without BDRV_O_UNMAP silently ignores discard
requests.

Add a regression test to verify that discard requests are not
ignored during background mirror.

Signed-off-by: Haoqian He <haoqian.he@smartx.com>
---
 tests/qemu-iotests/tests/mirror-discard     | 73 +++++++++++++++++++++
 tests/qemu-iotests/tests/mirror-discard.out |  5 ++
 2 files changed, 78 insertions(+)
 create mode 100755 tests/qemu-iotests/tests/mirror-discard
 create mode 100644 tests/qemu-iotests/tests/mirror-discard.out

diff --git a/tests/qemu-iotests/tests/mirror-discard b/tests/qemu-iotests/tests/mirror-discard
new file mode 100755
index 0000000000..4b89e9bc7d
--- /dev/null
+++ b/tests/qemu-iotests/tests/mirror-discard
@@ -0,0 +1,73 @@
+#!/usr/bin/env python3
+# group: rw auto quick
+#
+# Test that discard reaches the source through a blockdev-mirror filter.
+#
+# Copyright (C) 2026 SmartX, Inc.
+
+from pathlib import Path
+
+import iotests
+
+
+source = Path(iotests.test_dir, 'mirror-discard-source.qcow2')
+target = Path(iotests.test_dir, 'mirror-discard-target.qcow2')
+
+
+class TestMirrorDiscard(iotests.QMPTestCase):
+    def setUp(self):
+        for path in (source, target):
+            self.addCleanup(path.unlink, missing_ok=True)
+            iotests.qemu_img_create(
+                '-f', iotests.imgfmt,
+                '-o', 'compat=1.1,cluster_size=65536', str(path), '1M')
+
+        self.vm = iotests.VM()
+        # Cleanups run in reverse order: close the VM before removing images.
+        self.addCleanup(self.vm.shutdown)
+        self.vm.add_drive(str(source), opts='discard=unmap,node-name=src')
+        self.vm.add_blockdev(
+            f'driver={iotests.imgfmt},node-name=target,'
+            f'file.driver=file,file.filename={target}')
+        self.vm.launch()
+
+    def test_background_discard(self):
+        self.vm.cmd('x-qemu-io', device='drive0',
+                    command='write -q -P 0xab 0 192k')
+
+        # Check discard works before mirror_top is inserted, then restore data.
+        self.vm.cmd('x-qemu-io', device='drive0',
+                    command='discard -q 64k 64k')
+        self.vm.cmd('x-qemu-io', device='drive0',
+                    command='read -q -P 0x00 64k 64k')
+        self.vm.cmd('x-qemu-io', device='drive0',
+                    command='write -q -P 0xab 64k 64k')
+
+        self.vm.cmd('blockdev-mirror', job_id='mirror', device='drive0',
+                    target='target', sync='full', copy_mode='background')
+        self.wait_ready('mirror')
+        self.pause_job('mirror')
+
+        # Use the backend so the request passes through mirror_top to src.
+        self.vm.cmd('x-qemu-io', device='drive0',
+                    command='discard -q 64k 64k')
+        checks = (
+            'read -q -P 0x00 64k 64k',
+            'read -q -P 0xab 0 64k',
+            'read -q -P 0xab 128k 64k',
+        )
+        for command in checks:
+            self.vm.cmd('x-qemu-io', device='drive0', command=command)
+
+        self.vm.cmd('block-job-resume', device='mirror')
+        self.complete_and_wait('mirror', wait_ready=False)
+        self.vm.shutdown()
+
+        # Check both images independently after all writes have been flushed.
+        for path in (source, target):
+            for command in checks:
+                iotests.qemu_io('-f', iotests.imgfmt, '-c', command, str(path))
+
+
+if __name__ == '__main__':
+    iotests.main(supported_fmts=['qcow2'], supported_protocols=['file'])
diff --git a/tests/qemu-iotests/tests/mirror-discard.out b/tests/qemu-iotests/tests/mirror-discard.out
new file mode 100644
index 0000000000..ae1213e6f8
--- /dev/null
+++ b/tests/qemu-iotests/tests/mirror-discard.out
@@ -0,0 +1,5 @@
+.
+----------------------------------------------------------------------
+Ran 1 tests
+
+OK
-- 
2.53.0


