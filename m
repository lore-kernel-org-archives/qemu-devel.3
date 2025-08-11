Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64305CA0EC4
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Aug 2025 16:24:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ulVJK-0007DK-SM; Mon, 11 Aug 2025 12:23:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1ulVJ2-00070e-C1
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 12:23:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1ulVIz-0002C9-MI
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 12:23:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754929402;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=we3gJQ/CAiDgPKT0IIhbplUtp3LfQYT/UyMFQqofTs8=;
 b=TYU2sdcAtbzmpwb+Wh9VbjQi0BaHMCJcAOvpfv5vqYaSbdZREoAkXtwOtrTEnddggydMl/
 ZqJxlh3w5T28ohJ/Y1wH98ZP4NBuNZJO3FLuqEy655+j5C5gBCOEniaWQY+BCgNSoQWJUH
 03VWVsLH0HCJT4cf7GXxQAojiW++z94=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-282-6a2EEfe7MsCZmKxNpgaqGA-1; Mon,
 11 Aug 2025 12:23:18 -0400
X-MC-Unique: 6a2EEfe7MsCZmKxNpgaqGA-1
X-Mimecast-MFC-AGG-ID: 6a2EEfe7MsCZmKxNpgaqGA_1754929397
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 48466195605C; Mon, 11 Aug 2025 16:23:17 +0000 (UTC)
Received: from localhost (unknown [10.2.16.174])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 71AA518004D4; Mon, 11 Aug 2025 16:23:16 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Gustavo Romero <gustavo.romero@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH] tests/functional: fix URLs in PCI hotplug test for aarch64
Date: Mon, 11 Aug 2025 12:23:15 -0400
Message-ID: <20250811162315.59997-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Debian trixie has been released. The "stable" alias no longer refers to
the Debian bookworm release, so URLs referring to bookworm artifacts via
the "stable" alias no longer work.

Switch to explicit release naming ("bookworm") to make a permalink so
the test passes again.

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Fixes: 374a245573b8 ("tests/functional: Add PCI hotplug test for aarch64")
Resolves: #3073 ("PCI hotplug test for aarch64 fails due to broken Debian installer URL")
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 tests/functional/test_aarch64_hotplug_pci.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/functional/test_aarch64_hotplug_pci.py b/tests/functional/test_aarch64_hotplug_pci.py
index c9bb7f1d97..0c67991b89 100755
--- a/tests/functional/test_aarch64_hotplug_pci.py
+++ b/tests/functional/test_aarch64_hotplug_pci.py
@@ -15,12 +15,12 @@
 class HotplugPCI(LinuxKernelTest):
 
     ASSET_KERNEL = Asset(
-        ('https://ftp.debian.org/debian/dists/stable/main/installer-arm64/'
+        ('https://ftp.debian.org/debian/dists/bookworm/main/installer-arm64/'
          '20230607+deb12u11/images/netboot/debian-installer/arm64/linux'),
          'd92a60392ce1e379ca198a1a820899f8f0d39a62d047c41ab79492f81541a9d9')
 
     ASSET_INITRD = Asset(
-        ('https://ftp.debian.org/debian/dists/stable/main/installer-arm64/'
+        ('https://ftp.debian.org/debian/dists/bookworm/main/installer-arm64/'
          '20230607+deb12u11/images/netboot/debian-installer/arm64/initrd.gz'),
          '9f817f76951f3237bca8216bee35267bfb826815687f4b2fcdd5e6c2a917790c')
 
-- 
2.50.1


