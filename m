Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E0ECCCD1BF
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Oct 2025 23:32:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vCRFp-0006QS-Dv; Fri, 24 Oct 2025 19:31:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vCRFl-0006O3-U8; Fri, 24 Oct 2025 19:31:26 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vCRFf-0000GQ-FG; Fri, 24 Oct 2025 19:31:25 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id D925B597457;
 Sat, 25 Oct 2025 01:31:17 +0200 (CEST)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id qNtvuqeMTg1Q; Sat, 25 Oct 2025 01:31:15 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id DCF6C59744F; Sat, 25 Oct 2025 01:31:15 +0200 (CEST)
Message-ID: <275cd2d5074b76b4a504a01f658e85ed7994ea3e.1761346145.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1761346145.git.balaton@eik.bme.hu>
References: <cover.1761346145.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH 3/4] hw/ppc/pegasos2: Rename to pegasos
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Date: Sat, 25 Oct 2025 01:31:15 +0200 (CEST)
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Now that we also emulate pegasos1 it is not only about pegasos2 so
rename to a more generic name encompassing both.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 MAINTAINERS                             | 4 ++--
 configs/devices/ppc-softmmu/default.mak | 7 +++----
 hw/ppc/Kconfig                          | 2 +-
 hw/ppc/meson.build                      | 4 ++--
 hw/ppc/{pegasos2.c => pegasos.c}        | 0
 5 files changed, 8 insertions(+), 9 deletions(-)
 rename hw/ppc/{pegasos2.c => pegasos.c} (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index f33f95ceea..c85b79ad2d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1646,11 +1646,11 @@ F: roms/u-boot-sam460ex
 F: docs/system/ppc/amigang.rst
 F: tests/functional/ppc/test_sam460ex.py
 
-pegasos2
+pegasos
 M: BALATON Zoltan <balaton@eik.bme.hu>
 L: qemu-ppc@nongnu.org
 S: Maintained
-F: hw/ppc/pegasos2.c
+F: hw/ppc/pegasos.c
 F: hw/pci-host/mv64361.c
 F: hw/pci-host/mv643xx.h
 F: include/hw/pci-host/mv64361.h
diff --git a/configs/devices/ppc-softmmu/default.mak b/configs/devices/ppc-softmmu/default.mak
index 460d15e676..180ae31e2d 100644
--- a/configs/devices/ppc-softmmu/default.mak
+++ b/configs/devices/ppc-softmmu/default.mak
@@ -13,15 +13,14 @@
 # CONFIG_PPC440=n
 # CONFIG_VIRTEX=n
 
-# For Sam460ex
+# AmigaNG
+# CONFIG_AMIGAONE=n
+# CONFIG_PEGASOS=n
 # CONFIG_SAM460EX=n
 
 # For Macs
 # CONFIG_MAC_OLDWORLD=n
 # CONFIG_MAC_NEWWORLD=n
 
-# CONFIG_AMIGAONE=n
-# CONFIG_PEGASOS2=n
-
 # For PReP
 # CONFIG_PREP=n
diff --git a/hw/ppc/Kconfig b/hw/ppc/Kconfig
index 7091d72fd8..347dcce690 100644
--- a/hw/ppc/Kconfig
+++ b/hw/ppc/Kconfig
@@ -92,7 +92,7 @@ config AMIGAONE
     select VT82C686
     select SMBUS_EEPROM
 
-config PEGASOS2
+config PEGASOS
     bool
     default y
     depends on PPC
diff --git a/hw/ppc/meson.build b/hw/ppc/meson.build
index 6b7c1f4f49..f7dac87a2a 100644
--- a/hw/ppc/meson.build
+++ b/hw/ppc/meson.build
@@ -87,8 +87,8 @@ ppc_ss.add(when: 'CONFIG_E500', if_true: files(
 ppc_ss.add(when: 'CONFIG_VIRTEX', if_true: files('virtex_ml507.c'))
 # AmigaOne
 ppc_ss.add(when: 'CONFIG_AMIGAONE', if_true: files('amigaone.c'))
-# Pegasos2
-ppc_ss.add(when: 'CONFIG_PEGASOS2', if_true: files('pegasos2.c'))
+# Pegasos
+ppc_ss.add(when: 'CONFIG_PEGASOS', if_true: files('pegasos.c'))
 
 ppc_ss.add(when: 'CONFIG_VOF', if_true: files('vof.c'))
 ppc_ss.add(when: ['CONFIG_VOF', 'CONFIG_PSERIES'], if_true: files('spapr_vof.c'))
diff --git a/hw/ppc/pegasos2.c b/hw/ppc/pegasos.c
similarity index 100%
rename from hw/ppc/pegasos2.c
rename to hw/ppc/pegasos.c
-- 
2.41.3


