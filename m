Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A278C8302F
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 10:58:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWYh1-0000e5-PP; Tue, 01 Jul 2025 06:58:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uWYh0-0000dx-P3
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 06:58:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uWYgv-0002X4-Ob
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 06:58:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751367499;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=vaysZIU4o0SnKCiXfmsE+GY/I6OdRo57O2XTDSYmKDo=;
 b=cx1ImAcDBOjGyf0nGoTkKhww9yzboRULNYINWpPuxcbjsXXtT1PT6stKXH3J3zCGp6dq0j
 PUtNAcS3SZL5jgFYEXPhA8P/SvSeL4MBusyDKakYsw2ddRiLF0hc3Jl7iNTTEMsS81/Njr
 aM0yXVahjHYGYFOhTo78dvlSMG9Umr4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-241-UFSGaungM_aTaNtWzPWQlA-1; Tue,
 01 Jul 2025 06:58:16 -0400
X-MC-Unique: UFSGaungM_aTaNtWzPWQlA-1
X-Mimecast-MFC-AGG-ID: UFSGaungM_aTaNtWzPWQlA_1751367494
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5FF3818DA5C7; Tue,  1 Jul 2025 10:58:14 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.226.103])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 949F7180035C; Tue,  1 Jul 2025 10:58:11 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org, Radoslaw Biernacki <rad@semihalf.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-arm@nongnu.org, Leif Lindholm <leif.lindholm@oss.qualcomm.com>,
 Warner Losh <imp@bsdimp.com>
Subject: [PATCH] tests/functional/test_aarch64_sbsaref_freebsd: Fix the URL of
 the ISO image
Date: Tue,  1 Jul 2025 12:58:09 +0200
Message-ID: <20250701105809.366180-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Thomas Huth <thuth@redhat.com>

The original image has been removed from the server, so the test
currently fails if it has to fetch the asset, but we can still
download the ISO from the archive server. While we're at it, prefer
the XZ compressed image, it's much smaller and thus the download
should be faster.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/functional/test_aarch64_sbsaref_freebsd.py | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tests/functional/test_aarch64_sbsaref_freebsd.py b/tests/functional/test_aarch64_sbsaref_freebsd.py
index 26dfc5878bb..92ebc69c9b1 100755
--- a/tests/functional/test_aarch64_sbsaref_freebsd.py
+++ b/tests/functional/test_aarch64_sbsaref_freebsd.py
@@ -18,9 +18,9 @@
 class Aarch64SbsarefFreeBSD(QemuSystemTest):
 
     ASSET_FREEBSD_ISO = Asset(
-        ('https://download.freebsd.org/releases/arm64/aarch64/ISO-IMAGES/'
-         '14.1/FreeBSD-14.1-RELEASE-arm64-aarch64-bootonly.iso'),
-        '44cdbae275ef1bb6dab1d5fbb59473d4f741e1c8ea8a80fd9e906b531d6ad461')
+        ('http://ftp-archive.freebsd.org/pub/FreeBSD-Archive/old-releases/arm64'
+         '/aarch64/ISO-IMAGES/14.1/FreeBSD-14.1-RELEASE-arm64-aarch64-bootonly.iso.xz'),
+        '7313a4495ffd71ab77b49b1e83f571521c32756e1d75bf48bd890e0ab0f75827')
 
     # This tests the whole boot chain from EFI to Userspace
     # We only boot a whole OS for the current top level CPU and GIC
@@ -28,7 +28,7 @@ class Aarch64SbsarefFreeBSD(QemuSystemTest):
     def boot_freebsd14(self, cpu=None):
         fetch_firmware(self)
 
-        img_path = self.ASSET_FREEBSD_ISO.fetch()
+        img_path = self.uncompress(self.ASSET_FREEBSD_ISO)
 
         self.vm.set_console()
         self.vm.add_args(
-- 
2.50.0


