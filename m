Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9E7AC54E67
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Mar 2024 10:27:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpQVH-0008Pg-CG; Wed, 27 Mar 2024 06:27:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1rpQTX-0007Hh-Ff
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 06:25:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1rpQTC-0007G0-B2
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 06:25:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711535119;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=P6PRkUOhBn7ufqzSGAyTkRNh5yPALC2fNtcgAgJTwiM=;
 b=DDsW4Y3M1WomiMa7TnKMQbO3s8yNEEEA+exWpB/QIOb1Gln+Ivf3J3V7jfmFOGtHFdRyLb
 SyWKU5lmEpF4s3pUBu5tA1QCBckk3SAgWSzWiJv8eqlL0eAYY9Q4k4RmMQKMTDp6zgq05j
 5c1bYn19raC5NtAVaGweEApEEPHv2mE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-501-cb_jk9sPNlOpHekEHInU2A-1; Wed, 27 Mar 2024 06:25:15 -0400
X-MC-Unique: cb_jk9sPNlOpHekEHInU2A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A609C101A523;
 Wed, 27 Mar 2024 10:25:15 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.194.77])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4A7152024517;
 Wed, 27 Mar 2024 10:25:15 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 5FBD91800D54; Wed, 27 Mar 2024 11:24:48 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 3/3] edk2/seabios: use common extra version
Date: Wed, 27 Mar 2024 11:24:47 +0100
Message-ID: <20240327102448.61877-4-kraxel@redhat.com>
In-Reply-To: <20240327102448.61877-1-kraxel@redhat.com>
References: <20240327102448.61877-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.088,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Bring a bit more consistency into the naming.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 roms/Makefile | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/roms/Makefile b/roms/Makefile
index 783a5cab4f4c..dfed2b216a1e 100644
--- a/roms/Makefile
+++ b/roms/Makefile
@@ -41,8 +41,8 @@ x86_64_cross_prefix := $(call find-cross-prefix,x86_64)
 riscv32_cross_prefix := $(call find-cross-prefix,riscv32)
 riscv64_cross_prefix := $(call find-cross-prefix,riscv64)
 
-# tag our seabios builds
-SEABIOS_EXTRAVERSION="-prebuilt.qemu.org"
+# tag our firmware builds
+FIRMWARE_EXTRAVERSION = -prebuilt.qemu.org
 
 #
 # EfiRom utility is shipped with edk2 / tianocore, in BaseTools/
@@ -93,12 +93,12 @@ build-seabios-config-%: config.%
 	mkdir -p seabios/builds/$*
 	cp $< seabios/builds/$*/.config
 	$(MAKE) -C seabios \
-		EXTRAVERSION=$(SEABIOS_EXTRAVERSION) \
+		EXTRAVERSION=$(FIRMWARE_EXTRAVERSION) \
 		CROSS_PREFIX=$(x86_64_cross_prefix) \
 		KCONFIG_CONFIG=$(CURDIR)/seabios/builds/$*/.config \
 		OUT=$(CURDIR)/seabios/builds/$*/ oldnoconfig
 	$(MAKE) -C seabios \
-		EXTRAVERSION=$(SEABIOS_EXTRAVERSION) \
+		EXTRAVERSION=$(FIRMWARE_EXTRAVERSION) \
 		CROSS_PREFIX=$(x86_64_cross_prefix) \
 		KCONFIG_CONFIG=$(CURDIR)/seabios/builds/$*/.config \
 		OUT=$(CURDIR)/seabios/builds/$*/ all
@@ -159,7 +159,7 @@ edk2-version: edk2
 
 efi: edk2-version
 	$(PYTHON) edk2-build.py --config edk2-build.config \
-		--version-override "$(EDK2_STABLE)-for-qemu" \
+		--version-override "$(EDK2_STABLE)$(FIRMWARE_EXTRAVERSION)" \
 		--release-date "$(EDK2_DATE)" \
 		--silent --no-logs
 	rm -f ../pc-bios/edk2-*.fd.bz2
-- 
2.44.0


