Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D26BC31D97
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 20:31:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOjyW-0001Md-DE; Tue, 02 Jul 2024 16:19:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOjyV-0001KL-25
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 16:19:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOjyT-0001H7-5K
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 16:19:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719951576;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wXu48vkZ7/C+tOxLrIxzTN9h9b+wSo5eOaPVc/4Fs+U=;
 b=ZYRvlVAeD8N0nPcs7HXfFeViqHleeDmnLtOPOS0nFE+y1C449/lNbM4/BYbLK+Q8DjLzni
 PBVaHcJ5epP3BlXcgJRXM7UchNVatLDnmRe++YWZCeZGjis5r80MVfjcLjlaf+OjDex5tw
 4rhhpDMVIOaolyHuRoH4i6LqD7hIrX8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-255-wjO75nccPtGCmZtu-HWB0A-1; Tue, 02 Jul 2024 16:19:35 -0400
X-MC-Unique: wjO75nccPtGCmZtu-HWB0A-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-42566c4aa0fso37131545e9.1
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 13:19:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719951572; x=1720556372;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wXu48vkZ7/C+tOxLrIxzTN9h9b+wSo5eOaPVc/4Fs+U=;
 b=lh1YDOAAZEkEUPs4GhoZZfHzQifWMRQyjGOn7KW8WzM5v/XcQ0s60fNuewA4NETctt
 C3eeH5YiLD8rPg2LNij7YX5wf89uDCvDM8H2HGraO3NOghe607txUgB8RwLZ+yMyMP+q
 ib+M6ePsUaJ+u+pvtbrw/myZlB1xgKEn7McoxC+5H+inw4YJ/lXJnt+fjecpywYPhYeN
 mWSuT8KAzKmO+fBOT9Nctwsa85rO0RuxVWKCWA4bXM4ZevGuvYpPVG9h29ebKG8ez9xU
 PyuvdFtRXBUSFdFhqoiweVPWk7ouBYBaXl4XeUE+RnLzAykYuJGsexoypcgTTIgnXlbu
 jLdw==
X-Gm-Message-State: AOJu0YwyohIbKcV/hjHIwlPD+9jn9fGPlRZMH+/1ybZLGEHwO+6XuguT
 s9yh6XElvRMxNw+18VYCE/7ICA4iQBJ1zsP04bpILkUygiQoQ2RMb9MAggpLZACg9jqFpJIGwVs
 MlW+PRKRouSfnt6lMIMYBlAQeZerV6jW8R/WPaHu6rqtZI7jCjfgE2Ma+DXo8fCIs9CdhMCoKbB
 KMreh8aR2pNt78aA6+cKfX6nuUA0/MmQ==
X-Received: by 2002:a05:600c:4c14:b0:425:61df:b2fb with SMTP id
 5b1f17b1804b1-4257a03a931mr63498105e9.23.1719951572198; 
 Tue, 02 Jul 2024 13:19:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHqi/uN0c9Ki/xlGepSFBX4lcpuuiROv0c2hVbe4Nc58wjH/lFpToykxXpd3eKnYbLX+ODF6w==
X-Received: by 2002:a05:600c:4c14:b0:425:61df:b2fb with SMTP id
 5b1f17b1804b1-4257a03a931mr63497925e9.23.1719951571606; 
 Tue, 02 Jul 2024 13:19:31 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f5:eadd:8c31:db01:9d01:7604])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a10305fsm14052538f8f.96.2024.07.02.13.19.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 13:19:31 -0700 (PDT)
Date: Tue, 2 Jul 2024 16:19:27 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Sunil V L <sunilvl@ventanamicro.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL v2 64/88] uefi-test-tools: Add support for python based build
 script
Message-ID: <128a1e1267ec2b36895d2c72e108b6c8c0b78700.1719951168.git.mst@redhat.com>
References: <cover.1719951168.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1719951168.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
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


