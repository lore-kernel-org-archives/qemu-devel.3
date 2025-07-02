Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B905C77B7C
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 17:04:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uX0rH-0003is-OI; Wed, 02 Jul 2025 13:02:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uX0rE-0003iT-QV
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 13:02:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uX0rB-0003by-IV
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 13:02:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751475768;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1i0iaIXHDEGoi5z+DHygo0dveZQA5WqCv7VuDzFqpmE=;
 b=g1l36bPkUfp1+ZFdMvrfrgdAWoZDVLntW8zkxRuKLIxlfrC36QwEyYZVhKxO8Nly3KsQL8
 zeA3JWS5r7Zfx7fAzTVSKcK1MCBd9QaGOVIcYHaWIFSO5tp1d/GNz7A4x1T8Irv0DGieSv
 KkjEdQunBHwA2RIuHamH6OFTJ/ynPN4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-493-utVkBv_MNdeSf2HLdKaGLQ-1; Wed,
 02 Jul 2025 13:02:47 -0400
X-MC-Unique: utVkBv_MNdeSf2HLdKaGLQ-1
X-Mimecast-MFC-AGG-ID: utVkBv_MNdeSf2HLdKaGLQ_1751475767
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 32EC1180ACD5
 for <qemu-devel@nongnu.org>; Wed,  2 Jul 2025 17:02:31 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.23])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AA3E9195608F; Wed,  2 Jul 2025 17:02:29 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 9/9] tests/functional/test_aarch64_sbsaref_freebsd: Fix the URL
 of the ISO image
Date: Wed,  2 Jul 2025 19:02:04 +0200
Message-ID: <20250702170206.212303-10-thuth@redhat.com>
In-Reply-To: <20250702170206.212303-1-thuth@redhat.com>
References: <20250702170206.212303-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Thomas Huth <thuth@redhat.com>

The original image has been removed from the server, so the test
currently fails if it has to fetch the asset, but we can still
download the ISO from the archive server. While we're at it, prefer
the XZ compressed image, it's much smaller and thus the download
should be faster.

Message-ID: <20250701105809.366180-1-thuth@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/functional/test_aarch64_sbsaref_freebsd.py | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tests/functional/test_aarch64_sbsaref_freebsd.py b/tests/functional/test_aarch64_sbsaref_freebsd.py
index 3cddc082f3b..7ef016fba62 100755
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
@@ -29,7 +29,7 @@ def boot_freebsd14(self, cpu=None):
         self.set_machine('sbsa-ref')
 
         fetch_firmware(self)
-        img_path = self.ASSET_FREEBSD_ISO.fetch()
+        img_path = self.uncompress(self.ASSET_FREEBSD_ISO)
 
         self.vm.set_console()
         self.vm.add_args(
-- 
2.50.0


