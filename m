Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55DFCCA0FED
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Sep 2025 12:38:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvxbr-00084r-N1; Tue, 09 Sep 2025 08:38:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uvxbq-00083f-1a
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 08:38:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uvxbi-0000JS-Ep
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 08:38:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757421475;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=tFvgc4BRgfFtnf5plfrzI78O5kKWnmB9Y91Q1U1DpfU=;
 b=g2x5Og7x6jk9ZJMh5aQ66bIu4RCiUv4gkq+kYbh5XJ1iHMzO+23NkPBqeROZX+RcOJkQRz
 Ls6rZquQemGui0f4R2C6k1FrPKnynDqcSWiMBX6urKQlEVOL+RunFEkkrZwmIU6zhiCGnf
 5Hnzn2V+E9uUT6nO8WanVEDT56KEzmA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-168-0ekB5_iiPmWVsQ-vQ2IbRQ-1; Tue,
 09 Sep 2025 08:37:52 -0400
X-MC-Unique: 0ekB5_iiPmWVsQ-vQ2IbRQ-1
X-Mimecast-MFC-AGG-ID: 0ekB5_iiPmWVsQ-vQ2IbRQ_1757421471
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F0F43195608B; Tue,  9 Sep 2025 12:37:50 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.46])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7AD4E300018D; Tue,  9 Sep 2025 12:37:49 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Gustavo Romero <gustavo.romero@linaro.org>,
	qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org
Subject: [PATCH] tests/functional/aarch64: Fix assets of test_hotplug_pci
Date: Tue,  9 Sep 2025 14:37:47 +0200
Message-ID: <20250909123747.567480-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Thomas Huth <thuth@redhat.com>

The old bookworm URLs don't work anymore, resulting in a 404 error
now. Let's update the test to Debian Trixie to get it going again.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/functional/aarch64/test_hotplug_pci.py | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tests/functional/aarch64/test_hotplug_pci.py b/tests/functional/aarch64/test_hotplug_pci.py
index 0c67991b89e..bf677204319 100755
--- a/tests/functional/aarch64/test_hotplug_pci.py
+++ b/tests/functional/aarch64/test_hotplug_pci.py
@@ -15,14 +15,14 @@
 class HotplugPCI(LinuxKernelTest):
 
     ASSET_KERNEL = Asset(
-        ('https://ftp.debian.org/debian/dists/bookworm/main/installer-arm64/'
-         '20230607+deb12u11/images/netboot/debian-installer/arm64/linux'),
-         'd92a60392ce1e379ca198a1a820899f8f0d39a62d047c41ab79492f81541a9d9')
+        ('https://ftp.debian.org/debian/dists/trixie/main/installer-arm64/'
+         '20250803/images/netboot/debian-installer/arm64/linux'),
+         '93a6e4f9627d759375d28f863437a86a0659e125792a435f8e526dda006b7d5e')
 
     ASSET_INITRD = Asset(
-        ('https://ftp.debian.org/debian/dists/bookworm/main/installer-arm64/'
-         '20230607+deb12u11/images/netboot/debian-installer/arm64/initrd.gz'),
-         '9f817f76951f3237bca8216bee35267bfb826815687f4b2fcdd5e6c2a917790c')
+        ('https://ftp.debian.org/debian/dists/trixie/main/installer-arm64/'
+         '20250803/images/netboot/debian-installer/arm64/initrd.gz'),
+         'f6c78af7078ca67638ef3a50c926cd3c1485673243f8b37952e6bd854d6ba007')
 
     def test_hotplug_pci(self):
 
-- 
2.51.0


