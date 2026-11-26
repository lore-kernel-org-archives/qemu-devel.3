Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD08606A31C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Nov 2026 19:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qhLfg73i
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWejm-0008VN-1k; Thu, 26 Nov 2026 14:02:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bogorodskiy@gmail.com>)
 id 1xWejB-00083A-HM
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 14:01:55 -0500
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bogorodskiy@gmail.com>)
 id 1xWej5-0005E7-IR
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 14:01:52 -0500
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-c51d158acc6so52259866b.0
 for <qemu-devel@nongnu.org>; Thu, 26 Nov 2026 11:01:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795719706; x=1796324506; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=K7vP6aq5S1QHw3j0QGlVlTkM+O+AFJvge5FV5v2pL/8=;
 b=qhLfg73ip7mv22QNH8bjcxCPK4Qn5eVWWKEe5kXBxAZErznfJCqEDPwa++d4vREFdi
 oC8hPV3Hdl7GuqRQSFPKxaxTLQXZDbyJy57c8EYZxzrl3EfxNzyRV/Jw9bh1TNxiDcHm
 4fqUVy5A11Uq34XDl9iUZl7jFNeqM0CdF50LFHf3lm2TpacH2iJWRE8l/D8Mw/MhSxap
 vstLe+JTAWmaPv0RcZeVuLSsbGlOLUNgHu/HaGa0Deg80Kzyju9Ppf7a38u6KdDu82Gr
 d80qogLHCWaVRabzY8afcwqWtxtoFEfMMcGr8JawnVTNdITjcFHRpDukRWlaGBUXTd8T
 6GwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795719706; x=1796324506;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=K7vP6aq5S1QHw3j0QGlVlTkM+O+AFJvge5FV5v2pL/8=;
 b=LnNINf6eVqr9iBxvEmeolHxVXengodt0SDciZ3pJRreHh3wrC6OYCzG78Eg8NmdA6Z
 TtDoMRzYT+KdzfCoZxax+6FHBeIOWBCSifwbyyfJ9FUz9cVI3u5xdcx3dwor+cazsWJr
 bljg2Thw/5vrhojPoIPQKQtW6TnocZiT17LZCeB1H6yssQCMLwtlhtkanaubVwPfJZqY
 kc8vcfG7aAQG+i1inXQNQaj026DXq9UEMt3YCkxJrEZv3oh1TZDG1qv4s85my+OCWN4p
 7bBbO0FIFTdPx91rSuuulep8WpzG0qu/VUS0vn5WP5Mj3HceEk1gnMRF4Cygb6pDm3+1
 cfsQ==
X-Gm-Message-State: APuU4Z9Ku28fvS+jbeN5W50ZpcaVJTU+J+s6vWvzMCP7W1biyI+DLMW4
 Mc+0PIRByPTE0oXWe2i10mEaq8DigfIbzjGpQRuoAvBliy3p1NlTm9ngfCU9kZRR5ec=
X-Gm-Gg: AZFdTZcMsYNJPGxQCgENpGirfhuekH8678QHy9gruYb+f9XowPxZIThfv7/Esdrsqzo
 6xkHeV8/Pz66Qd6M8ELARLy6Ogk399mKkTaVj/M5nz0bI2uJdCCbr+KHKWt32klPgR6UdqRwIKf
 laTDsZO+KFGjg2GD447po5nnPQ8z3v45LA82C9oFaT28qcx/KwiaMVibLqAxzW+oVNT6Rn5U5r+
 Kp9pHe4iGl/gMD47xk4a6qtIcGuwEvGvnBSfaavovVyidELotjIvB/2LMh1FZc+eatDqV3uFiSs
 fcnjruydbTmgUR6YQSSjI5oN641wFao3bwtLM920aeb2/UcpvQvLWMd/xfF3AmGgFvxIZI4YEsC
 Fjximjltjm0MhyhjIgefaJ+L+oBXl+FYXUJnwBF5KJymQyC0YTUB/mJNNYzUx8LxWjJPSdSgr72
 pf/krE0P5vUDuiW2NRiRgaqwP7Ed9X91F6c7qbp0K896flaK4Tx5g/b9Mbjm8Cr18LbGW6bHNd2
 AlJpyXPGMBpY2dh4Wbq3ZO9G4ngXLiL/NNEyFlwEoPU2wjXAeZ/T7AYaL282Ori8ZY4wORQi4Ee
 J/NkgkM942BLT5L4WFEwnV0Lj4FEdckcaq+2
X-Received: by 2002:a17:906:115a:b0:c3e:ee86:d2c with SMTP id
 a640c23a62f3a-c513a866684mr1583673066b.27.1795719705802; 
 Thu, 26 Nov 2026 11:01:45 -0800 (PST)
Received: from tulp.my.domain ([2001:1c02:1a15:3000:2727:f7d1:9628:aa81])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c513ae6663esm786278766b.21.2026.11.26.11.01.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Nov 2026 11:01:45 -0800 (PST)
From: Roman Bogorodskiy <bogorodskiy@gmail.com>
To: qemu-devel@nongnu.org
Cc: Roman Bogorodskiy <bogorodskiy@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org (open list:Block layer core)
Subject: [PATCH v3 09/10] iotests: properly skip tests that require OFD
 locking support
Date: Thu, 26 Nov 2026 20:00:52 +0100
Message-ID: <20261126190054.40844-10-bogorodskiy@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261126190054.40844-1-bogorodskiy@gmail.com>
References: <20261126190054.40844-1-bogorodskiy@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=bogorodskiy@gmail.com; helo=mail-ej1-x631.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Tests 296, qemu-iotests/tests/migration-permissions, and
tests/mirror-top-perms require OFD locking support and fail when
it's not available.

Add the supports_ofd_lock() and verify_ofd_lock() helpers and
use them to skip these tests when necessary.

Signed-off-by: Roman Bogorodskiy <bogorodskiy@gmail.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 tests/qemu-iotests/296                         |  1 +
 tests/qemu-iotests/iotests.py                  | 16 ++++++++++++++++
 tests/qemu-iotests/tests/migration-permissions |  3 +++
 tests/qemu-iotests/tests/mirror-top-perms      |  3 +++
 4 files changed, 23 insertions(+)

diff --git a/tests/qemu-iotests/296 b/tests/qemu-iotests/296
index 2b63cefff0..84fb8d0d9b 100755
--- a/tests/qemu-iotests/296
+++ b/tests/qemu-iotests/296
@@ -273,6 +273,7 @@ class EncryptionSetupTestCase(iotests.QMPTestCase):
 
 
 if __name__ == '__main__':
+    iotests.verify_ofd_lock()
     # support only raw luks since luks encrypted qcow2 is a proper
     # format driver which doesn't allow any sharing
     iotests.activate_logging()
diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index 7017d2016c..90f25272d4 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -1588,6 +1588,22 @@ def verify_qcow2_zstd_compression():
     if not supports_qcow2_zstd_compression():
         notrun('zstd compression not supported')
 
+def supports_ofd_lock() -> bool:
+    with FilePath('ofdlock.raw') as img_file:
+        qemu_img_create('-f', 'raw', img_file, '1M')
+        res = qemu_img('info', '--image-opts',
+                       f'driver=file,locking=on,filename={img_file}',
+                       check=False)
+        res.check_returncode()
+        if "falling back to POSIX file" in res.stdout:
+            return False
+        else:
+            return True
+
+def verify_ofd_lock():
+    if not supports_ofd_lock():
+        notrun('OFD locking is unavailable')
+
 def qemu_pipe(*args: str) -> str:
     """
     Run qemu with an option to print something and exit (e.g. a help option).
diff --git a/tests/qemu-iotests/tests/migration-permissions b/tests/qemu-iotests/tests/migration-permissions
index 0deaad2d3a..7f943113e9 100755
--- a/tests/qemu-iotests/tests/migration-permissions
+++ b/tests/qemu-iotests/tests/migration-permissions
@@ -30,6 +30,9 @@ mig_sock = os.path.join(iotests.sock_dir, 'mig.sock')
 
 class TestMigrationPermissions(iotests.QMPTestCase):
     def setUp(self):
+        if not iotests.supports_ofd_lock():
+            self.case_skip("OFD locking is unavailable")
+
         qemu_img_create('-f', imgfmt, test_img, '1M')
 
         # Set up two VMs (source and destination) accessing the same raw
diff --git a/tests/qemu-iotests/tests/mirror-top-perms b/tests/qemu-iotests/tests/mirror-top-perms
index fab9907e92..653f2e4a6d 100755
--- a/tests/qemu-iotests/tests/mirror-top-perms
+++ b/tests/qemu-iotests/tests/mirror-top-perms
@@ -33,6 +33,9 @@ source = os.path.join(iotests.test_dir, 'source.img')
 
 class TestMirrorTopPerms(iotests.QMPTestCase):
     def setUp(self):
+        if not iotests.supports_ofd_lock():
+            self.case_skip("OFD locking is unavailable")
+
         qemu_img('create', '-f', iotests.imgfmt, source, str(image_size))
         self.vm = iotests.VM()
         self.vm.add_drive(source)
-- 
2.56.0


