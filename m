Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B85606A31E
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Nov 2026 19:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WP5oEpPo
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWIWn-0002in-8O; Wed, 25 Nov 2026 14:19:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bogorodskiy@gmail.com>)
 id 1xWIV6-0001aT-UK
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 14:17:54 -0500
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bogorodskiy@gmail.com>)
 id 1xWIV3-0002NA-ET
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 14:17:52 -0500
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-c51bf011392so52764066b.3
 for <qemu-devel@nongnu.org>; Wed, 25 Nov 2026 11:17:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795634267; x=1796239067; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZfQBLhLXz2uN2bvtFkxkEonmZlRtoFfkSN2nfeiOytM=;
 b=WP5oEpPoDBw9/5ZB6mrwIjJuok6+Y9mx7Pd/EDrS5gFckB081ZpWs6wKB3WbfNpiCC
 n7JL2uTyC/hTXeLUK4Zr/YiJzO4Fm0t5qP5ArVJAzMMR8SxLAYkRcvHMBeBqn7RfpHgp
 O7quTmKIndnQYhdhWtvOlP/Ri9naggjwcg+shRO49+Ykg7YXGEk8h0GCSPrzV6RgApKH
 k50HlIYytMLKhTKp7XNOhmgoPt4QI+cjQkhnPyD9ubUDpVonImxXvlYWn17EefvSPqsp
 yUbU5nkjQyaNSmBvAySiWCS3A2Zu1GwuDjLki+XSBjckaqDuJuVDqq31ksFBM9KwZzJ9
 qi2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795634267; x=1796239067;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ZfQBLhLXz2uN2bvtFkxkEonmZlRtoFfkSN2nfeiOytM=;
 b=l4qqPgsR8JzukTfRqfB4gv381MbQMDJ24WuVR5aCTY8ghnPq8BW10l18FuZxZUUxPJ
 wG3G310kZlSLtfwFTt55fI2boDVYPDsHNZkwqqpsn4pDr6fK8YSu93jfG/fmyqBF2gP9
 WN3c+chuxXPCd96lEOGe8pi65YwULLdE/Ka3A96u/B7D3L4U23OSQf9vSsgct0xEmnTW
 9SKA153hcpwVXuQqxZ1ayQxOQCWLD3ImnP/BMK1SQ8RIaywoAxnWbtFQ6wOoJNaNLu+S
 NBdFpfP2oYIKy3WcAfVPX/Jo+Q/bvdikeJW4yOX2z4xjb1rVLzg72WxPb8F0zjP5NyeL
 NpQw==
X-Gm-Message-State: APuU4Z9DbogSqPoxp3j4Q/dmsKvzRLgTqeXKF9hhcuEcJQQJUaN5/BNz
 8vVke36uA70owVpp1+dj3DGNAy8uYLnxk75KKnFU+K/ErSCKSC8dtNfeevjJPE1qa4k=
X-Gm-Gg: AZFdTZfDbKEz2tDI5/YikR9Z599GaR+Log9YlwuCseihpktpkA7ngc6TSC23jy940M9
 rGNQ57tae201UfAMZq16Z9QsoeBIXRvemrZ/1g/0fpxw1XjVaRcEZ+uIhaaXpHJRvRXypY8BmhZ
 /lJRyl8faCJ7ToK8ZldlPGmWFYUzbNIBUbnL/lI3PL7/mVj6b026ji9hOUVFGpDf6u95BLanAp4
 4k2ekyE2UZrFG1wvD8B8StVghF/k67TuENVCzDiwtb6kbZ5C+Op4k/RAzYmhQuFxFPYMEwpPvaK
 h1U8aQjhQs30QaLXhwhItSw9QTQ1xvpniGpC0KAAseUlwwCF6bxqBgU29DqpNKUqEERHolvlG8m
 QfJOofahvS2uuiknZMWogNLbgputHUJlMeFW5sCFzq5pUeRM11hZKz2YBiz61JKPZm1pMiRtHDc
 R0kiaseGWzjvRsstevp2Z+3A/ohsQEBFtx05EBoFcOf22UsHcIkogv9Hr2rAMplTnx4/Y7zwqJW
 7HPH331WIcEbUnDihq3OxsMqXB8KszBgnzUbOqWrWLejibcG/49zTHyHsAfPPOQUTdCcjnHmG05
 N+bYYKh0shxQixld+iFf98LJxwZrYNr71R3unSXAnLmrVU7VE1LO63zwkW71ceCpP/TlXoV4yZW
 QFzsEtJSFciLeXe4f0E7m21YFR5xwYDUC21m8IVU=
X-Received: by 2002:a17:907:7b9b:b0:c4d:3208:5781 with SMTP id
 a640c23a62f3a-c513a4b1c1fmr1697082266b.1.1795634266667; 
 Wed, 25 Nov 2026 11:17:46 -0800 (PST)
Received: from tulp.my.domain
 (2001-1c02-1a15-3000-2727-f7d1-9628-aa81.cable.dynamic.v6.ziggo.nl.
 [2001:1c02:1a15:3000:2727:f7d1:9628:aa81])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c513b003eacsm672686266b.81.2026.11.25.11.17.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 11:17:46 -0800 (PST)
From: Roman Bogorodskiy <bogorodskiy@gmail.com>
To: qemu-devel@nongnu.org
Cc: Roman Bogorodskiy <bogorodskiy@gmail.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org (open list:Block layer core)
Subject: [PATCH v2 09/10] iotests: properly skip tests that require OFD
 locking support
Date: Wed, 25 Nov 2026 20:16:59 +0100
Message-ID: <20261125191701.93931-10-bogorodskiy@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261125191701.93931-1-bogorodskiy@gmail.com>
References: <20261125191701.93931-1-bogorodskiy@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=bogorodskiy@gmail.com; helo=mail-ej1-x629.google.com
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


