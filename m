Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CCCD606A6A0
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Nov 2026 16:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EqWGCLsO
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVAlX-0001qx-Oj; Sun, 22 Nov 2026 11:50:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bogorodskiy@gmail.com>)
 id 1xVAlJ-0001p4-49
 for qemu-devel@nongnu.org; Sun, 22 Nov 2026 11:49:57 -0500
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bogorodskiy@gmail.com>)
 id 1xVAlH-0001Xr-Aq
 for qemu-devel@nongnu.org; Sun, 22 Nov 2026 11:49:56 -0500
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-c5133831027so354241566b.2
 for <qemu-devel@nongnu.org>; Sun, 22 Nov 2026 08:49:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795366184; x=1795970984; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZfQBLhLXz2uN2bvtFkxkEonmZlRtoFfkSN2nfeiOytM=;
 b=EqWGCLsO2SenGyeqdNAWhtlVzIEhKje7uHR4K/IavMdo0zY5Bb5RycSL9mJUXWwkRI
 sNYUnLXGja4AbBQT96lBKov9j2NZegZz8I2Qi4bdVwfaP/fUn/PLtEWyIVhZRbANDQe0
 ewg8iG2WQ+oCTFJweos/GNVfK8mCoH8VOuv+Iul3RqmfPz8DwmefEyIU1Q7n9NTxZXgV
 5x3Xm7YPLcO081U0AhNJgM5GcKnFDCMMiRr0i8Ylx67LWtxopvFhA5fgEqN1Q/DopJxD
 AskPE+CvgMe43ibZmPQHMd7PXk8cnIxUWm4P2YO7YyGHDQCuX8SLQ0hQXCr2LfKmLlEW
 eoww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795366184; x=1795970984;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ZfQBLhLXz2uN2bvtFkxkEonmZlRtoFfkSN2nfeiOytM=;
 b=UbCLGrBbuQNpghPn97kpqEPvMQrGUTQ3W26ldQAqzRnCGbCcrcNS7JLvpjZPXYvIwr
 uS/8MxEAZRhrR6FzRgnOMgsXL8d1jWia03olD+BaH5a36opzVOSkYDaEsO1+qP2HNzc1
 sJZSsjaUSAyJbDB3lf/DBtHX0MXv1MA3ysKg2dpktYgBl4Rzt4fxCtCYWdq4o2b/LvyB
 wwxc2mu6Q9BvcIYmwpwhgAFVNS7dEgL2KeFjcFyDIpuN0lcKL7+ZGFOc3XmtQGzH5afh
 cT0QS+j+UNfRZFHroT15HvmgjqiPCMKTZPhStzm6Apxoxb1PfrfaodC7XFwi8R3V2P6f
 sylg==
X-Gm-Message-State: APuU4Z8rMevH1/btx/TIXcXd70RreyZEGrcsNziO2qRdt0wbIdL9+ZDH
 9zJEOHE5acKrBQsIfYMCTjfWjidxdFwfKUr5WbOMd6+IMOuDhgerbwYr8+APR3yDjN0=
X-Gm-Gg: AZFdTZeWFYpOYELHRjRTam/YOHGXx48poeq6Uk67tFAGlCLChnLfFxPDYV5wfxn770n
 +xjarH05wxU1l7t1TjiICaV1q+VRiFHWLwlEmogR0G4U795CYmTIixLNQLj4JW7ur3X/sMvslP4
 kv7v33xYq5hQWkNpGxwo9KxJlrL00K0PNkxDHr3CvtbodmZMHsds/OEy5skHY6XwBbBq+xOUISF
 zVLk4vG9svpAyX8Y9zrrIzFsHFLZMfvzoV/fnK2jJ9iSIa1HDLImXzoEhzehHN2sUpNcS8wYp2w
 Cg4gFCFo7xU3uvP8upsB+7yzHuoV7jaSChD4L/q6CFnHoyCJAZnzbmXWlMKahpYopr4/WlDywiH
 NFqtyGYf/Q7PQ260eF6Dx15rAmZsX3hLw34rfDmiNggW6o7boqvz9Ft0mtC6fp41eg9drg+jEvu
 dYu72d1TK9DVShI9ebjl1AZOja4Fcc+xUSrTNUpKEQHoxgfaw2aoUbHtlodunBB8Wvm4SeS+MyQ
 0RmqSMWqkA8dgssBZy178h5FpRswnahHwYFNqrsvW/M+0+7xH+hFYlV3yHDs02CrSOHAjAQLhSc
 ali8FJfrpsrpjpXe5vcA7RkCtudwvGNnACf11beUIX/xNL5BzWVFfG7qS1bkqqfzHvOLHw+XfSi
 bC3p+dOnSUFl27UQE71erczxtklkmhSOkY7L7KZkr
X-Received: by 2002:a17:907:a08a:b0:c51:5369:a3a9 with SMTP id
 a640c23a62f3a-c515369b921mr458274566b.44.1795366183618; 
 Sun, 22 Nov 2026 08:49:43 -0800 (PST)
Received: from tulp.my.domain
 (2001-1c02-1a15-3000-2727-f7d1-9628-aa81.cable.dynamic.v6.ziggo.nl.
 [2001:1c02:1a15:3000:2727:f7d1:9628:aa81])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c513afc2455sm325303166b.57.2026.11.22.08.49.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Nov 2026 08:49:42 -0800 (PST)
From: Roman Bogorodskiy <bogorodskiy@gmail.com>
To: qemu-devel@nongnu.org
Cc: Roman Bogorodskiy <bogorodskiy@gmail.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org (open list:Block layer core)
Subject: [PATCH 09/10] iotests: properly skip tests that require OFD locking
 support
Date: Sun, 22 Nov 2026 17:49:04 +0100
Message-ID: <20261122164905.59680-10-bogorodskiy@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261122164905.59680-1-bogorodskiy@gmail.com>
References: <20261122164905.59680-1-bogorodskiy@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=bogorodskiy@gmail.com; helo=mail-ej1-x62f.google.com
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
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Tests 296, qemu-iotests/tests/migration-permissions, and
tests/mirror-top-perms require OFD locking support and fail when
it's not available.

Add the supports_ofd_lock() and verify_ofd_lock() helpers and
use them to skip these tests when necessary.

Signed-off-by: Roman Bogorodskiy <bogorodskiy@gmail.com>
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


