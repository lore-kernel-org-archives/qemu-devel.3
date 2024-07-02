Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39E19C3065C
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 14:14:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOeDQ-0004yK-Ql; Tue, 02 Jul 2024 10:10:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOeDH-0004cT-Tv
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 10:10:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOeDC-0000Jg-JQ
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 10:10:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719929423;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wXu48vkZ7/C+tOxLrIxzTN9h9b+wSo5eOaPVc/4Fs+U=;
 b=DqDKiABuQj17XCJvaDf537MqywMzsGY+U5Pcsp8B8oeOPYGOufF+HU/OrEU2IX3UZTk/4B
 b9VxDwvOaa53a3yTCvjIDW6OaEXc9lPSLQYvA8B1Or0Kmr2ceB933Y4DkjAHPYYJgfsAk3
 W30cwcKqD9lS4epkuN4awu3p/GvKjSE=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-35-aTGA8Zv5O2ai31jmg2Mj6Q-1; Tue, 02 Jul 2024 10:10:22 -0400
X-MC-Unique: aTGA8Zv5O2ai31jmg2Mj6Q-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-52ce8969cf1so4161888e87.1
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 07:10:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719929420; x=1720534220;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wXu48vkZ7/C+tOxLrIxzTN9h9b+wSo5eOaPVc/4Fs+U=;
 b=t6kif7eA7wXVKpbe8stbFuLuYChnPwBq2Wxehagr6QIThRRATMkwvZh8ddUQrZkaph
 Hb+0DQgnEzhyB0T6e8y3MwkvGJ32QOuzMxX/VVB98vG768IePF22LNeXfsABQhSlCCVg
 U/OxCz+zLOblK98+H3Gs+eQxDI3AhzE59zly249cCMCvXU/bleyAbY1+01AbOOGuqLtq
 MDTyEDD+f3tRYQ8sTJ2rGwUd2e5MIIS8KYMr+YTfQ2p7MqCw9ePsEe4otcQpsGfCIRBz
 O2GhKcaIvG3mmlWTT2lCb4QW1nFn/gTyvSwJdmrd4RUNK2B9xykA9jjLNEpfNdsoeR+W
 0xOQ==
X-Gm-Message-State: AOJu0Yy12CR5vpavzmW60uhs/ny9taMOrJiKwpD6JeR2Wd+Wdxob4GgZ
 DhMQeYQbdjT1MzDQ274EcDaWDnNmJ5xl7910/FQOlakIMglNLaEzpcaacxfAfvzVNyefRflyijr
 nLsGcfADZORJR0utfG8Ah58NGakKMuzUn9zijMgFh15Fqzeoz1XNuzovmZUqYfjmzMyOX8msU/N
 yOPqNPyXRhMcaIiDoIcg+FfJIVv2QYCQ==
X-Received: by 2002:a05:6512:3da4:b0:52c:c5c4:43d2 with SMTP id
 2adb3069b0e04-52e826fb074mr6471126e87.47.1719929420428; 
 Tue, 02 Jul 2024 07:10:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHA4D0ZbXfKi20DsLWoHDU17tX15XCF6STsUfIryVz9NfNRFA+AodEo3+eLry67RPFaeHUcnw==
X-Received: by 2002:a05:6512:3da4:b0:52c:c5c4:43d2 with SMTP id
 2adb3069b0e04-52e826fb074mr6471076e87.47.1719929419601; 
 Tue, 02 Jul 2024 07:10:19 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f5:eadd:8c31:db01:9d01:7604])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256af5b61bsm201473875e9.17.2024.07.02.07.10.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 07:10:18 -0700 (PDT)
Date: Tue, 2 Jul 2024 10:10:16 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Sunil V L <sunilvl@ventanamicro.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 64/91] uefi-test-tools: Add support for python based build
 script
Message-ID: <c334e037c8e490a3ee8e83df21d6edacf206041b.1719929191.git.mst@redhat.com>
References: <cover.1719929191.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1719929191.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Sunil V L <sunilvl@ventanamicro.com>

edk2-funcs.sh which is used in this Makefile, was removed in the commit
c28a2891f3 ("edk2: update build script"). It is replaced with a python
based script. So, update the Makefile and add the configuration file as
required to support the python based build script.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Acked-by: Gerd Hoffmann <kraxel@redhat.com>
Acked-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <20240625150839.1358279-4-sunilvl@ventanamicro.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/uefi-test-tools/Makefile               | 19 +++----
 tests/uefi-test-tools/uefi-test-build.config | 52 ++++++++++++++++++++
 2 files changed, 59 insertions(+), 12 deletions(-)
 create mode 100644 tests/uefi-test-tools/uefi-test-build.config

diff --git a/tests/uefi-test-tools/Makefile b/tests/uefi-test-tools/Makefile
index 0c003f2877..f4eaebd8ff 100644
--- a/tests/uefi-test-tools/Makefile
+++ b/tests/uefi-test-tools/Makefile
@@ -12,7 +12,7 @@
 
 edk2_dir              := ../../roms/edk2
 images_dir            := ../data/uefi-boot-images
-emulation_targets     := arm aarch64 i386 x86_64
+emulation_targets     := arm aarch64 i386 x86_64 riscv64
 uefi_binaries         := bios-tables-test
 intermediate_suffixes := .efi .fat .iso.raw
 
@@ -56,7 +56,8 @@ Build/%.iso.raw: Build/%.fat
 # stripped from, the argument.
 map_arm_to_uefi     = $(subst arm,ARM,$(1))
 map_aarch64_to_uefi = $(subst aarch64,AA64,$(call map_arm_to_uefi,$(1)))
-map_i386_to_uefi    = $(subst i386,IA32,$(call map_aarch64_to_uefi,$(1)))
+map_riscv64_to_uefi = $(subst riscv64,RISCV64,$(call map_aarch64_to_uefi,$(1)))
+map_i386_to_uefi    = $(subst i386,IA32,$(call map_riscv64_to_uefi,$(1)))
 map_x86_64_to_uefi  = $(subst x86_64,X64,$(call map_i386_to_uefi,$(1)))
 map_to_uefi         = $(subst .,,$(call map_x86_64_to_uefi,$(1)))
 
@@ -70,7 +71,7 @@ Build/%.fat: Build/%.efi
 	uefi_bin_b=$$(stat --format=%s -- $<) && \
 		uefi_fat_kb=$$(( (uefi_bin_b * 11 / 10 + 1023) / 1024 )) && \
 		uefi_fat_kb=$$(( uefi_fat_kb >= 64 ? uefi_fat_kb : 64 )) && \
-		mkdosfs -C $@ -n $(basename $(@F)) -- $$uefi_fat_kb
+		mkdosfs -C $@ -n "bios-test" -- $$uefi_fat_kb
 	MTOOLS_SKIP_CHECK=1 mmd -i $@ ::EFI
 	MTOOLS_SKIP_CHECK=1 mmd -i $@ ::EFI/BOOT
 	MTOOLS_SKIP_CHECK=1 mcopy -i $@ -- $< \
@@ -95,15 +96,9 @@ Build/%.fat: Build/%.efi
 # we must mark the recipe manually as recursive, by using the "+" indicator.
 # This way, when the inner "make" starts a parallel build of the target edk2
 # module, it can communicate with the outer "make"'s job server.
-Build/bios-tables-test.%.efi: build-edk2-tools
-	+./build.sh $(edk2_dir) BiosTablesTest $* $@
-
-build-edk2-tools:
-	cd $(edk2_dir)/BaseTools && git submodule update --init --force
-	$(MAKE) -C $(edk2_dir)/BaseTools \
-		PYTHON_COMMAND=$${EDK2_PYTHON_COMMAND:-python3} \
-		EXTRA_OPTFLAGS='$(EDK2_BASETOOLS_OPTFLAGS)' \
-		EXTRA_LDFLAGS='$(EDK2_BASETOOLS_LDFLAGS)'
+Build/bios-tables-test.%.efi:
+	$(PYTHON) ../../roms/edk2-build.py --config uefi-test-build.config \
+		--match $*
 
 clean:
 	rm -rf Build Conf log
diff --git a/tests/uefi-test-tools/uefi-test-build.config b/tests/uefi-test-tools/uefi-test-build.config
new file mode 100644
index 0000000000..1f389ae541
--- /dev/null
+++ b/tests/uefi-test-tools/uefi-test-build.config
@@ -0,0 +1,52 @@
+[global]
+core = ../../roms/edk2
+
+####################################################################################
+# arm
+
+[build.arm]
+conf = UefiTestToolsPkg/UefiTestToolsPkg.dsc
+plat = UefiTestTools
+dest = ./Build
+arch = ARM
+cpy1 = ARM/BiosTablesTest.efi  bios-tables-test.arm.efi
+
+####################################################################################
+# aarch64
+
+[build.aarch64]
+conf = UefiTestToolsPkg/UefiTestToolsPkg.dsc
+plat = UefiTestTools
+dest = ./Build
+arch = AARCH64
+cpy1 = AARCH64/BiosTablesTest.efi  bios-tables-test.aarch64.efi
+
+####################################################################################
+# riscv64
+
+[build.riscv]
+conf = UefiTestToolsPkg/UefiTestToolsPkg.dsc
+plat = UefiTestTools
+dest = ./Build
+arch = RISCV64
+cpy1 = RISCV64/BiosTablesTest.efi  bios-tables-test.riscv64.efi
+
+####################################################################################
+# ia32
+
+[build.ia32]
+conf = UefiTestToolsPkg/UefiTestToolsPkg.dsc
+plat = UefiTestTools
+dest = ./Build
+arch = IA32
+cpy1 = IA32/BiosTablesTest.efi  bios-tables-test.i386.efi
+
+####################################################################################
+# x64
+
+[build.x64]
+conf = UefiTestToolsPkg/UefiTestToolsPkg.dsc
+plat = UefiTestTools
+dest = ./Build
+arch = X64
+cpy1 = X64/BiosTablesTest.efi  bios-tables-test.x86_64.efi
-- 
MST


