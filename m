Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70576CA5FCD
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 16:50:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBxVv-0006qV-3y; Wed, 30 Sep 2026 12:50:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1xBxVZ-0006SB-Ow
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 12:50:20 -0400
Received: from mail-wm2-x10.google.com ([2a00:1450:4864:31::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1xBxVW-0003X7-8u
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 12:50:17 -0400
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-4a00713639cso26676975e9.1
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 09:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1790787012; x=1791391812; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tX/eoVXGT9GlXWnw9X/ctJ6/ZvMghMZLPGwlqfRGtlg=;
 b=SZF4GLgNLHwI4ENfhTjycAgpjx814FynSa885ucm6f4pV0TWdhQzq8qc+PsFNYqPHw
 5yOn/YoqUCq7p3pLQy31XVSgV/q36MNeezQJvlaUxvLPs7Zu6rJTSPpe5cTbBOlG5WKr
 TkkOs2iOqCmb6g3oL1VRtEThWe+3Q08g1uTe3nLhbXfwr5rHsHCTS3CPw7rmnmTM0KrZ
 3GNiqzuTp6i8HeK9GmfQVSlBICR67pBwHm/G3WBuoVPYpY0HGpbKqu4bjJ/H95laEp+u
 znrQciEDbo7nQVw6Wqd/Tq173vzmdNNAK96B1kah1WLS3Mm6+xTbHxLURX0KAwh3x3FT
 WJ5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790787012; x=1791391812;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=tX/eoVXGT9GlXWnw9X/ctJ6/ZvMghMZLPGwlqfRGtlg=;
 b=gKkuwqIOwGsAI4CZnr8Nfeb12vEn8o+07ZTqBGyM3dq5GlXQcvq7+fpM6VvW4ktI5q
 9l27Dx2r7WUAlfj9KOhOcTkk/Zk/e4tQ7PMzLKz7aGqw5ZnqT3+AAUwkf74qNYB5wh/E
 rC2FECGB+aAxzxzi4NB8pFORvtUWOKyWULdUfdONmbSlclYfzy0gq87mylPtsv0sc6fb
 cyqjQ8doPFKV4cBqArcUkDRB8M+4M9Wjun+LiV3d+FOZ1j+vwZo8Rl02PYcn10iFlOgb
 lXMvBVd3KXy3sFIWRO4BeJkBrQc10kmV4gkRD/zpEVc2W3I56ytKdqBZ92lvNy0P4lxk
 CT7Q==
X-Gm-Message-State: AFuF++mNV1OGZd6MXjqtsztLKvoeu2aRp1e+6dGPsIaKFTMsNSIU5YRE
 vTuDoIhg6T4CwStSIvAMTfKpExhcwyqpdAGxYNMH/IAQ2OTXyP3c0i0Ucj7biZ9GHQ6Hx1gXgDz
 EYmo6
X-Gm-Gg: AYBFou1pGRfZNaK9R+zlD+kMl85jVn3cmO0UUGkClFF1ipQN6qRAQIJvGFCJAenxyzU
 gNTkH2WiNyEfQObgSAD5US51oRkFNekTIw8gjch4zFnjArJPtUfuBrjFr9qWzHyHhVSDY81PTUh
 FnNNQUF/bRwkziVxj660IPOLOJVdApu10fjG4AFOpLv3bfEHfTD5ft0WmKXqBfQfVELK0mleMCr
 VOzOgOE5+frrs3Ou84zDA2l+cCzEj2EI/bE16UMTIkxDJhTCwxquxUjhQNmFWjxjkOk7qC4SKyC
 ocZumAsToo8AAMFFzytJPUAbe5KBPKzm1Q1kgccxDUjxfE+HvvnCqrahLEFCmfKuJCWtQIL+rox
 O17TMnsFU2MeEuIciTEXz8RTGt3x8nacq0PjiAFkJ8Jkc+brx7b+UYpH+wLcNARS5J46M9vvlrE
 RLRTW1naWTh3Rx31U5ockcLa49QL2AiyBkF/P3o7JQpwh0Of2o0tOLG0nLOIu++bYNAVg=
X-Received: by 2002:a05:600c:8411:b0:49b:9202:6f80 with SMTP id
 5b1f17b1804b1-4a01affe5camr36956455e9.6.1790787011935; 
 Wed, 30 Sep 2026 09:50:11 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:c6b8:98e2:93f0:2de6])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a01eb71d57sm4144535e9.9.2026.09.30.09.50.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 09:50:11 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: den@openvz.org, qemu-block@nongnu.org,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: [PATCH 06/13] iotests/298: add testcase for async writes with
 preallocation filter
Date: Wed, 30 Sep 2026 18:49:52 +0200
Message-ID: <20260930165000.303236-7-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260930165000.303236-1-den@openvz.org>
References: <20260930165000.303236-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:31::10;
 envelope-from=den@openvz.org; helo=mail-wm2-x10.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>

The testcase creates a 64G image with 1M clusters, generates a list of
1M aligned offsets and feeds aio_write commands with those offsets to
qemu-io run with '--aio native --nocache'. Then we check the data
written at each of the offsets. Before this series this could result
in a race within the preallocation filter which would zeroize some
clusters after actually writing data to them.

Note: the test does not fail every time as there's a race involved, but
the failures are pretty consistent so it should be good enough for
detecting the problem.

Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Kevin Wolf <kwolf@redhat.com>
CC: Hanna Reitz <hreitz@redhat.com>
CC: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 tests/qemu-iotests/298     | 49 ++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/298.out |  4 ++--
 2 files changed, 51 insertions(+), 2 deletions(-)

diff --git a/tests/qemu-iotests/298 b/tests/qemu-iotests/298
index f2b94077f4..23e7789d09 100755
--- a/tests/qemu-iotests/298
+++ b/tests/qemu-iotests/298
@@ -20,8 +20,10 @@
 
 import os
 import iotests
+import random
 
 MiB = 1024 * 1024
+GiB = MiB * 1024
 disk = os.path.join(iotests.test_dir, 'disk')
 overlay = os.path.join(iotests.test_dir, 'overlay')
 refdisk = os.path.join(iotests.test_dir, 'refdisk')
@@ -176,6 +178,53 @@ class TestTruncate(iotests.QMPTestCase):
         self.do_test('off', '150M')
 
 
+class TestPreallocAsyncWrites(iotests.QMPTestCase):
+    def setUp(self):
+        # Make sure we get reproducible write patterns on each run
+        random.seed(42)
+        iotests.qemu_img_create('-f', iotests.imgfmt, disk, '-o',
+                                f'cluster_size={MiB},lazy_refcounts=on',
+                                str(64 * GiB))
+
+    def tearDown(self):
+        os.remove(disk)
+
+    def test_prealloc_async_writes(self):
+        def gen_write_pattern():
+            n = 0
+            while True:
+                yield '-P 0xaa' if n else '-z'
+                n = 1 - n
+
+        def gen_read_pattern():
+            n = 0
+            while True:
+                yield '-P 0xaa' if n else '-P 0x00'
+                n = 1 - n
+
+        requests = 2048 # Number of write/read requests to feed to qemu-io
+        total_clusters = 64 * 1024 # 64G / 1M
+
+        wpgen = gen_write_pattern()
+        rpgen = gen_read_pattern()
+
+        offsets = random.sample(range(0, total_clusters), requests)
+        aio_write_cmds = [f'aio_write {next(wpgen)} {off}M 1M' for off in offsets]
+        read_cmds = [f'read {next(rpgen)} {off}M 1M' for off in offsets]
+
+        proc = iotests.QemuIoInteractive('--aio', 'native', '--nocache',
+                                         '--image-opts', drive_opts)
+        for cmd in aio_write_cmds:
+            proc.cmd(cmd)
+        proc.close()
+
+        proc = iotests.QemuIoInteractive('-f', iotests.imgfmt, disk)
+        for cmd in read_cmds:
+            out = proc.cmd(cmd)
+            self.assertFalse('Pattern verification failed' in str(out))
+        proc.close()
+
+
 if __name__ == '__main__':
     iotests.main(supported_fmts=['qcow2'], required_fmts=['preallocate'],
                  require_hmp=True)
diff --git a/tests/qemu-iotests/298.out b/tests/qemu-iotests/298.out
index fa16b5ccef..6323079e08 100644
--- a/tests/qemu-iotests/298.out
+++ b/tests/qemu-iotests/298.out
@@ -1,5 +1,5 @@
-.............
+..............
 ----------------------------------------------------------------------
-Ran 13 tests
+Ran 14 tests
 
 OK
-- 
2.53.0


