Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 812ABC2BBCA
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2024 08:43:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sM1lT-0007hP-2l; Tue, 25 Jun 2024 04:42:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sM1lR-0007h1-Rq
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 04:42:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sM1lP-00080c-JS
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 04:42:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719304972;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=08qKOr8cHlB7UBSUb30uitrrrKzkUWBWOKCvsLF8vlY=;
 b=PtLsZ6DenJFOdrVy+YRM5QO/ih12qee2kERUPMaazOVjBo+ZBc4U43T3WoExzJV7LoMr+1
 Ico0RrQL4Cq1T5JyNoK88M8TKiErw5JE/pNwjpjiqbIqxWfqp3OsPCMwhu3z9dAigeq90Z
 80BupMFzlbAtqUqaQFh9JYPfbdncMus=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-377-7hgAKapSPpuPOJx-3aPBKg-1; Tue, 25 Jun 2024 04:42:51 -0400
X-MC-Unique: 7hgAKapSPpuPOJx-3aPBKg-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4218447b900so28377835e9.0
 for <qemu-devel@nongnu.org>; Tue, 25 Jun 2024 01:42:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719304969; x=1719909769;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=08qKOr8cHlB7UBSUb30uitrrrKzkUWBWOKCvsLF8vlY=;
 b=OZDQumhLMGq349DG+4JDFcCegDlci1sf6BEA1CCbFYOKrElWEFZgkn1aT/mZ7Qiedw
 IKTduez0AXxz2cRiTWiUu11y8ffm4Co7g+GzurJkz+sK998Nq0j2+JeuctyG3+yI2aOG
 iMgaBC2hBcCC/GRFoNc0371gXBuBneu8iLb/aRCMOaN9CyRMptsjWryOPgVcGMebYhjq
 sdZGdezppp6Xx9vVC8mP+tm3ycIjfpb4F/wAByhCBtp43QWehf0osrU282k4tD0ze+YO
 dPRdW56WlNwrn79Mt6uagx7m+mf2UWRgkKEKcbAW0ma+W3E07xImrCJHTS/6YiD93LhZ
 6wwQ==
X-Gm-Message-State: AOJu0Yzn2hGATy+zfCmxwZigRGgi8i5Iwj5gHAD70F7FPKAd6iZSKHl4
 iwvy3hjQDVdja9iKW1tPbUa9hnEspdrn3Cv+NjFqrd+ngAuUv00H/LbuYKSXU10xmjY/yyDCUki
 9gSOgOdNy0HtI5dH/71v5eD+6+rQ2I+GcYx1nE3m6c2IqUVU8hhVo
X-Received: by 2002:a05:600c:1604:b0:424:7443:e6d8 with SMTP id
 5b1f17b1804b1-424895dad6dmr70386195e9.9.1719304969127; 
 Tue, 25 Jun 2024 01:42:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGHm/o97jrwQTiGGDWCT3essWM3feFBLvlnMdnGqwnRBFU5o68GHGe6PBSB8xkZ/Ug6hx41/Q==
X-Received: by 2002:a05:600c:1604:b0:424:7443:e6d8 with SMTP id
 5b1f17b1804b1-424895dad6dmr70385965e9.9.1719304968705; 
 Tue, 25 Jun 2024 01:42:48 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-424817b5554sm167960325e9.26.2024.06.25.01.42.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Jun 2024 01:42:48 -0700 (PDT)
Date: Tue, 25 Jun 2024 10:42:47 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Sunil V L <sunilvl@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-riscv@nongnu.org, Paolo
 Bonzini <pbonzini@redhat.com>, =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau
 <marcandre.lureau@redhat.com>, "Daniel P . =?UTF-8?B?QmVycmFuZ8Op?="
 <berrange@redhat.com>, Thomas Huth <thuth@redhat.com>, Philippe
 =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>, "Michael S . Tsirkin"
 <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>, Laurent Vivier
 <lvivier@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Sia Jee Heng
 <jeeheng.sia@starfivetech.com>, Alistair Francis <alistair23@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Bin Meng <bmeng.cn@gmail.com>, Weiwei Li
 <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: Re: [PATCH v3 02/15] uefi-test-tools: Add support for python based
 build script
Message-ID: <20240625104247.54ea00ab@imammedo.users.ipa.redhat.com>
In-Reply-To: <20240621115906.1049832-3-sunilvl@ventanamicro.com>
References: <20240621115906.1049832-1-sunilvl@ventanamicro.com>
 <20240621115906.1049832-3-sunilvl@ventanamicro.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.207,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, 21 Jun 2024 17:28:53 +0530
Sunil V L <sunilvl@ventanamicro.com> wrote:

> edk2-funcs.sh which is used in this Makefile, was removed in the commit
> c28a2891f3 ("edk2: update build script"). It is replaced with a python
> based script. So, update the Makefile and add the configuration file as
> required to support the python based build script.
> 
> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>

Acked-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  tests/uefi-test-tools/Makefile               | 19 +++----
>  tests/uefi-test-tools/uefi-test-build.config | 52 ++++++++++++++++++++
>  2 files changed, 59 insertions(+), 12 deletions(-)
>  create mode 100644 tests/uefi-test-tools/uefi-test-build.config
> 
> diff --git a/tests/uefi-test-tools/Makefile b/tests/uefi-test-tools/Makefile
> index 0c003f2877..f4eaebd8ff 100644
> --- a/tests/uefi-test-tools/Makefile
> +++ b/tests/uefi-test-tools/Makefile
> @@ -12,7 +12,7 @@
>  
>  edk2_dir              := ../../roms/edk2
>  images_dir            := ../data/uefi-boot-images
> -emulation_targets     := arm aarch64 i386 x86_64
> +emulation_targets     := arm aarch64 i386 x86_64 riscv64
>  uefi_binaries         := bios-tables-test
>  intermediate_suffixes := .efi .fat .iso.raw
>  
> @@ -56,7 +56,8 @@ Build/%.iso.raw: Build/%.fat
>  # stripped from, the argument.
>  map_arm_to_uefi     = $(subst arm,ARM,$(1))
>  map_aarch64_to_uefi = $(subst aarch64,AA64,$(call map_arm_to_uefi,$(1)))
> -map_i386_to_uefi    = $(subst i386,IA32,$(call map_aarch64_to_uefi,$(1)))
> +map_riscv64_to_uefi = $(subst riscv64,RISCV64,$(call map_aarch64_to_uefi,$(1)))
> +map_i386_to_uefi    = $(subst i386,IA32,$(call map_riscv64_to_uefi,$(1)))
>  map_x86_64_to_uefi  = $(subst x86_64,X64,$(call map_i386_to_uefi,$(1)))
>  map_to_uefi         = $(subst .,,$(call map_x86_64_to_uefi,$(1)))
>  
> @@ -70,7 +71,7 @@ Build/%.fat: Build/%.efi
>  	uefi_bin_b=$$(stat --format=%s -- $<) && \
>  		uefi_fat_kb=$$(( (uefi_bin_b * 11 / 10 + 1023) / 1024 )) && \
>  		uefi_fat_kb=$$(( uefi_fat_kb >= 64 ? uefi_fat_kb : 64 )) && \
> -		mkdosfs -C $@ -n $(basename $(@F)) -- $$uefi_fat_kb
> +		mkdosfs -C $@ -n "bios-test" -- $$uefi_fat_kb
>  	MTOOLS_SKIP_CHECK=1 mmd -i $@ ::EFI
>  	MTOOLS_SKIP_CHECK=1 mmd -i $@ ::EFI/BOOT
>  	MTOOLS_SKIP_CHECK=1 mcopy -i $@ -- $< \
> @@ -95,15 +96,9 @@ Build/%.fat: Build/%.efi
>  # we must mark the recipe manually as recursive, by using the "+" indicator.
>  # This way, when the inner "make" starts a parallel build of the target edk2
>  # module, it can communicate with the outer "make"'s job server.
> -Build/bios-tables-test.%.efi: build-edk2-tools
> -	+./build.sh $(edk2_dir) BiosTablesTest $* $@
> -
> -build-edk2-tools:
> -	cd $(edk2_dir)/BaseTools && git submodule update --init --force
> -	$(MAKE) -C $(edk2_dir)/BaseTools \
> -		PYTHON_COMMAND=$${EDK2_PYTHON_COMMAND:-python3} \
> -		EXTRA_OPTFLAGS='$(EDK2_BASETOOLS_OPTFLAGS)' \
> -		EXTRA_LDFLAGS='$(EDK2_BASETOOLS_LDFLAGS)'
> +Build/bios-tables-test.%.efi:
> +	$(PYTHON) ../../roms/edk2-build.py --config uefi-test-build.config \
> +		--match $*
>  
>  clean:
>  	rm -rf Build Conf log
> diff --git a/tests/uefi-test-tools/uefi-test-build.config b/tests/uefi-test-tools/uefi-test-build.config
> new file mode 100644
> index 0000000000..1f389ae541
> --- /dev/null
> +++ b/tests/uefi-test-tools/uefi-test-build.config
> @@ -0,0 +1,52 @@
> +[global]
> +core = ../../roms/edk2
> +
> +####################################################################################
> +# arm
> +
> +[build.arm]
> +conf = UefiTestToolsPkg/UefiTestToolsPkg.dsc
> +plat = UefiTestTools
> +dest = ./Build
> +arch = ARM
> +cpy1 = ARM/BiosTablesTest.efi  bios-tables-test.arm.efi
> +
> +####################################################################################
> +# aarch64
> +
> +[build.aarch64]
> +conf = UefiTestToolsPkg/UefiTestToolsPkg.dsc
> +plat = UefiTestTools
> +dest = ./Build
> +arch = AARCH64
> +cpy1 = AARCH64/BiosTablesTest.efi  bios-tables-test.aarch64.efi
> +
> +####################################################################################
> +# riscv64
> +
> +[build.riscv]
> +conf = UefiTestToolsPkg/UefiTestToolsPkg.dsc
> +plat = UefiTestTools
> +dest = ./Build
> +arch = RISCV64
> +cpy1 = RISCV64/BiosTablesTest.efi  bios-tables-test.riscv64.efi
> +
> +####################################################################################
> +# ia32
> +
> +[build.ia32]
> +conf = UefiTestToolsPkg/UefiTestToolsPkg.dsc
> +plat = UefiTestTools
> +dest = ./Build
> +arch = IA32
> +cpy1 = IA32/BiosTablesTest.efi  bios-tables-test.i386.efi
> +
> +####################################################################################
> +# x64
> +
> +[build.x64]
> +conf = UefiTestToolsPkg/UefiTestToolsPkg.dsc
> +plat = UefiTestTools
> +dest = ./Build
> +arch = X64
> +cpy1 = X64/BiosTablesTest.efi  bios-tables-test.x86_64.efi


