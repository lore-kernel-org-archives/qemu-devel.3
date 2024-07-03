Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18B24C2BD09
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 22:51:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sP8mw-00059p-EM; Wed, 03 Jul 2024 18:49:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sP8ms-0004p2-Mf
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 18:49:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sP8mk-0005sY-LJ
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 18:49:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720046950;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wXu48vkZ7/C+tOxLrIxzTN9h9b+wSo5eOaPVc/4Fs+U=;
 b=O8ZzZOWqIM1Q9OzBili2HlSxa6WJQBcBvP37XeHvADaHSBiLrsJoxXQDnhDnBVG+Z3E3DF
 k83WQKxY7bheZwZC8sJYnPoCu/JjIt/rQKOUDHqj0pWSpwHvVZhw8UxvaAMsdqnt2fGkRZ
 eyWsItTB+rujOrkhZ8S1FjaWI5DBSIo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-90-26da-2vkPaCC8s8efYIqmQ-1; Wed, 03 Jul 2024 18:49:08 -0400
X-MC-Unique: 26da-2vkPaCC8s8efYIqmQ-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-367960f4673so535709f8f.1
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2024 15:49:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720046947; x=1720651747;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wXu48vkZ7/C+tOxLrIxzTN9h9b+wSo5eOaPVc/4Fs+U=;
 b=fsN7e7LiK79M4kF8JcJOfxkDxFPcZ3f6BMO0BiCrg6oqdGrLsMI2m1NvxDAVl+OMza
 aRdm8PshhtaVmKuTI8teqR7OdzWjuiYB8bsBfgkm6hv70qAu7cUU/gP10mcw4YmqQp9F
 1TRzaUt9k8gctNngw0qbR6NSwRhC/94F4PMJ6igiiCrFLmcOojjbc8LFeiX3OHAwB97u
 kFCOFCGYRktVtGCVX6wnKF5z4wxtBRqIVhf+RvV0XetfKHwUlE9a5CbbRYXchFMfpxuX
 2mTzGqonWGcXqCJlhfxX7OpsAPmkg761C/va5dvVWordAtiGB3ApVGYt2wfIWKus3V3F
 fxeA==
X-Gm-Message-State: AOJu0Yxl7HxzsfEDq5VE2lypFN5fEC6mjR+PKHK74STAZnQFOb3SVKuo
 k5/KveXWSiGFeWVm3cssm6q/MGR/CsN70MeXKogq1IIraAHgqEkBZ1WgFaf27CoGrJGNxNRJiGQ
 FNYTquFl4uqheagqR8djVUedC4EfY6BYmPX3mamCQvlCsegryVfECW+9hzFXUOiIwlJnRZ3Ue1y
 p4d+AIqYQQjioxtAhqZUZpuJ2+NofYNw==
X-Received: by 2002:a05:600c:4f0c:b0:424:84fb:9fd2 with SMTP id
 5b1f17b1804b1-42640b6e086mr27145925e9.19.1720046947030; 
 Wed, 03 Jul 2024 15:49:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEWnl5KRGoJO02dkcidekGahK4zIsQQ5S6iCycyafTAJap5UPntX81nwoYOHPFb2EEwymqyAQ==
X-Received: by 2002:a05:600c:4f0c:b0:424:84fb:9fd2 with SMTP id
 5b1f17b1804b1-42640b6e086mr27145635e9.19.1720046946049; 
 Wed, 03 Jul 2024 15:49:06 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:441:91a8:a47d:5a9:c02f:92f2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36796351169sm1995299f8f.95.2024.07.03.15.49.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jul 2024 15:49:05 -0700 (PDT)
Date: Wed, 3 Jul 2024 18:49:02 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Sunil V L <sunilvl@ventanamicro.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL v3 61/85] uefi-test-tools: Add support for python based build
 script
Message-ID: <ad8560fa29fc18acda2e8cfc1fdd87f6c6cca122.1720046570.git.mst@redhat.com>
References: <cover.1720046570.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1720046570.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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


