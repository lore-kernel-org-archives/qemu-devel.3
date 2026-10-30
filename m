Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6582E606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 01:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=openvz.org header.i=@openvz.org header.a=rsa-sha256 header.s=google header.b=LTU+oGRr
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMb4w-0002HI-36; Thu, 29 Oct 2026 21:06:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1xMb4e-0002CN-Pv
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 21:06:35 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1xMb4b-0006EN-Mr
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 21:06:27 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-48c5358fc28so141248f8f.0
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 18:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1793322384; x=1793927184; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Tzcnv4iV/M0//lehS771fIWvmHTFMU4220mA9TA0Wtk=;
 b=LTU+oGRr9C59gJfxsi3rZKYdXli1dZFjD8z/xZFlDcbcpkePJTYUpYghk6f9zQStNZ
 nSD45RAwrTexIPbILymka1JxHeBlcgnhtStUVjQwcpTSn1uk9WmmeeWeAD87Dmokslc9
 mdMIS4Be9rsWMMjDL3RI0uZsa2OnihTm9TTdrdklbayF6vfldD/YUafOyrhdY9nb7FOa
 8/lXU7yeXFU7ZMIw/VJWnPemLpZ4YLtp6BStqw/rzDqc5tGRPOmaOkFc9xF/ZGiIClkX
 HWpKC6esDbF/muv1c1uvmAme1EWnr0j5DO2zybUX5ddw+Zfz3R96yx0hLwhWYb7PZRuM
 Q1Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793322384; x=1793927184;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Tzcnv4iV/M0//lehS771fIWvmHTFMU4220mA9TA0Wtk=;
 b=biTO/YcJdMo/u+VscqZtQX67Yb/9nl1c9LHXNVmq4XSNlmRPwIcvWhyr4egbnNbYr2
 EKV1qha4TrGg6fXj8NswrD+coSHWj+TN8jlEjPqe/sIbMLcLMQeJxnYfJRFPgip1ruaW
 Pqg1R5zKDj2EuvgPf4u1dRlh1K8LnHwzyhvoAWiuCrpncEGTZyfSRTsgLqxFzHfeQ7s5
 IS8PTiBJz6kLaYVf3KDGEFT5jTBMHqT8CDPyw/NZ7iaNae6icosAAodeRaN7P4sladj1
 Mn44vRYnhs2yK4COmejceFTNr9CIjYAN5epy6+uQctSsWSAhUYpIJ3Anbjbuq/mERUMb
 lllQ==
X-Gm-Message-State: AFq9FYIcuzEflaw95mT3029wnXxpuU5JRxZtjklqC4Av2Z13+7dPv9bg
 r/J+Ov9KO5DMXhWlWEmn8qZr/OFHKLjYLrT8FZwYkr/5/cIu4lqQDFz39Cx1lSehi2BksD9qO/Y
 qL4Md
X-Gm-Gg: AYBFou0TN4zTSq36vzVer724W+K4wn7heDqCiA9qQVI7YEMnt6PluMVAZVjLVeTDOL4
 RmbQff2FbHW7vo/oWpyymWR3CoOd27t4SI3f1nIcJkJCA3iw/PTGCRPIIpb1QZxfH8gDFb1E3Vy
 fVvGjz/eB4+R7J/npiADQ3vrJea8c/Hgom1FEe80zy7lFscfDNtDPIb0OL2phAx+/7tdxmtWhEk
 WDSEauFTe3/CsCxYdaWhqqJq5NPKOxIEAacvCUEhrH4IegCjaRPqIVV8MCFdL9KT306cS0kyb61
 6AY+5slwl6be+8+6/cSPZAnj7ilPZxqx4Bc2m760TixFUeyCTxLvU5Fk8UGyUKORK4G8tC5hzjO
 IqHcuFskYes4p0Ey73VG6j0Wj6bgyLKGUKmyIYCMgpJhZ9wxXwu2N99GuIfSsrmJ+Hos5EQL0Qc
 P3fKTPW7Kp0Sz8qWvBjr1JaNaRoCvA2koEG+s7IwBXKtp8A5BkLtsima+SQ3TWPlesm5Ug23e+q
 XTxpUpvWwfDpX9ljmK7wRxjDYK86axd3VDjoX1k9y2NkvpBxW8l5M4tXovfgoG8+kKMyBFQ5Mnr
 W/1tOu0LguZWyB1uFD3aGbslZS8mvtvJs+JngPE=
X-Received: by 2002:a05:6000:4b02:b0:48d:f99d:a0d2 with SMTP id
 ffacd0b85a97d-48e6e2e76famr2147601f8f.15.1793322384063; 
 Thu, 29 Oct 2026 18:06:24 -0700 (PDT)
Received: from athena ([2a06:5b06:b600:300:f4be:f111:4ee0:40d3])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b80333sm210023f8f.32.2026.10.29.18.06.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 18:06:23 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 John Snow <jsnow@redhat.com>
Subject: [PATCH v4 02/12] iotests/040: cover large and fragmented commit runs
Date: Fri, 30 Oct 2026 02:06:02 +0100
Message-ID: <20261030010613.1612771-3-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261030010613.1612771-1-den@openvz.org>
References: <20261030010613.1612771-1-den@openvz.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=den@openvz.org; helo=mail-wr1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Denis V. Lunev <den@openvz.org>

040 never commits runs long enough to span more than one block-status
query, so the answer that commit_iteration() is about to start caching
goes untested.

Add two cases on a base <- mid <- active chain, committing mid so the
job takes the regular commit path rather than active commit, and compare
base against a snapshot of mid taken before the commit. One case mixes
multi-megabyte data, zero and hole runs, the other fragments them down
to single clusters with every transition off the 512K boundary.

Reviewed-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
CC: John Snow <jsnow@redhat.com>
CC: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 tests/qemu-iotests/040     | 102 ++++++++++++++++++++++++++++++++++++-
 tests/qemu-iotests/040.out |   4 +-
 2 files changed, 103 insertions(+), 3 deletions(-)

diff --git a/tests/qemu-iotests/040 b/tests/qemu-iotests/040
index 5c18e413ec..e01c9385ba 100755
--- a/tests/qemu-iotests/040
+++ b/tests/qemu-iotests/040
@@ -25,13 +25,14 @@
 import time
 import os
 import iotests
-from iotests import qemu_img, qemu_io
+from iotests import qemu_img, qemu_img_create, qemu_io, compare_images
 import struct
 import errno
 
 backing_img = os.path.join(iotests.test_dir, 'backing.img')
 mid_img = os.path.join(iotests.test_dir, 'mid.img')
 test_img = os.path.join(iotests.test_dir, 'test.img')
+reference_img = os.path.join(iotests.test_dir, 'reference.img')
 
 class ImageCommitTestCase(iotests.QMPTestCase):
     '''Abstract base class for image commit test cases'''
@@ -951,6 +952,105 @@ class TestCommitWithOverriddenBacking(iotests.QMPTestCase):
         self.vm.qmp('block-job-complete', device='commit')
         self.vm.event_wait('BLOCK_JOB_COMPLETED')
 
+class TestCommitLargeRuns(iotests.QMPTestCase):
+    """Commit runs long enough to cross commit_iteration()'s cached span."""
+
+    MB = 1024 * 1024
+    CLUSTER = 64 * 1024
+
+    # Runs several COMMIT_BUFFER_SIZE (512K) chunks long, of every kind.
+    SIZE = 32 * MB
+    LAYOUT = [
+        (0, 4 * MB, 'data'),
+        (4 * MB, 6 * MB, 'hole'),
+        (10 * MB, 4 * MB, 'data'),
+        (14 * MB, 6 * MB, 'zero'),
+        (20 * MB, 4 * MB, 'data'),
+        (24 * MB, 8 * MB, 'hole'),
+    ]
+
+    # The same, with every transition off the 512K boundary.
+    SIZE_FRAGMENTED = 384 * CLUSTER  # 24M
+    LAYOUT_FRAGMENTED = [
+        (0, 45 * CLUSTER, 'data'),
+        (45 * CLUSTER, 55 * CLUSTER, 'hole'),
+        (100 * CLUSTER, CLUSTER, 'data'),
+        (101 * CLUSTER, 49 * CLUSTER, 'zero'),
+        (150 * CLUSTER, 80 * CLUSTER, 'data'),
+        (230 * CLUSTER, CLUSTER, 'hole'),
+        (231 * CLUSTER, 69 * CLUSTER, 'data'),
+        (300 * CLUSTER, 83 * CLUSTER, 'zero'),
+        (383 * CLUSTER, CLUSTER, 'hole'),
+    ]
+
+    def setUp(self):
+        self.vm = iotests.VM()
+        self.vm.launch()
+
+    def tearDown(self):
+        self.vm.shutdown()
+        for img in (backing_img, mid_img, test_img, reference_img):
+            if os.path.exists(img):
+                os.remove(img)
+
+    def build_images(self, layout, size):
+        # A pattern of its own in base, so a misplaced cluster shows up.
+        qemu_img_create('-f', iotests.imgfmt, backing_img, str(size))
+        qemu_io('-c', f'write -P 0x11 0 {size}', backing_img)
+
+        qemu_img_create('-f', iotests.imgfmt, '-b', backing_img, '-F',
+                        iotests.imgfmt, mid_img, str(size))
+        for offset, length, kind in layout:
+            if kind == 'data':
+                qemu_io('-c', f'write -P 0x22 {offset} {length}', mid_img)
+            elif kind == 'zero':
+                qemu_io('-c', f'write -z {offset} {length}', mid_img)
+
+        # What base must equal once mid is committed into it.
+        qemu_img('convert', '-f', iotests.imgfmt, '-O', iotests.imgfmt,
+                 mid_img, reference_img)
+
+        # An empty layer above mid, so top_node=mid is not the active one.
+        qemu_img_create('-f', iotests.imgfmt, '-b', mid_img, '-F',
+                        iotests.imgfmt, test_img, str(size))
+
+        self.vm.cmd('blockdev-add', {
+            'node-name': 'base',
+            'driver': iotests.imgfmt,
+            'file': {'driver': 'file', 'filename': backing_img},
+        })
+        self.vm.cmd('blockdev-add', {
+            'node-name': 'mid',
+            'driver': iotests.imgfmt,
+            'file': {'driver': 'file', 'filename': mid_img},
+            'backing': 'base',
+        })
+        self.vm.cmd('blockdev-add', {
+            'node-name': 'active',
+            'driver': iotests.imgfmt,
+            'file': {'driver': 'file', 'filename': test_img},
+            'backing': 'mid',
+        })
+
+    def commit_and_verify(self):
+        self.vm.cmd('block-commit', job_id='commit0', device='active',
+                    top_node='mid', base_node='base')
+        self.wait_until_completed(drive='commit0')
+
+        self.vm.cmd('blockdev-del', node_name='active')
+        self.vm.cmd('blockdev-del', node_name='mid')
+        self.vm.cmd('blockdev-del', node_name='base')
+        self.assertTrue(compare_images(reference_img, backing_img))
+
+    def test_commit_large_runs(self):
+        self.build_images(self.LAYOUT, self.SIZE)
+        self.commit_and_verify()
+
+    def test_commit_fragmented_runs(self):
+        self.build_images(self.LAYOUT_FRAGMENTED, self.SIZE_FRAGMENTED)
+        self.commit_and_verify()
+
+
 if __name__ == '__main__':
     iotests.main(supported_fmts=['qcow2', 'qed'],
                  supported_protocols=['file'])
diff --git a/tests/qemu-iotests/040.out b/tests/qemu-iotests/040.out
index 1bb1dc5f0e..d2e2a2d98f 100644
--- a/tests/qemu-iotests/040.out
+++ b/tests/qemu-iotests/040.out
@@ -1,5 +1,5 @@
-.................................................................
+...................................................................
 ----------------------------------------------------------------------
-Ran 65 tests
+Ran 67 tests
 
 OK
-- 
2.53.0


