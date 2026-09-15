Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21E28C88E75
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 12:58:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6Sj7-0006QE-6K; Tue, 15 Sep 2026 08:57:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1x6Siq-0006L8-D7; Tue, 15 Sep 2026 08:57:22 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1x6Si6-0001kF-Gf; Tue, 15 Sep 2026 08:57:11 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 2AEDF5835EE;
 Tue, 15 Sep 2026 14:51:43 +0200 (CEST)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id RLClPjfK6M3T; Tue, 15 Sep 2026 14:51:40 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 886F35835EA; Tue, 15 Sep 2026 14:51:40 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 8676B5835F4;
 Tue, 15 Sep 2026 14:51:40 +0200 (CEST)
Date: Tue, 15 Sep 2026 14:51:40 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
cc: qemu-devel@nongnu.org, Cornelia Huck <cohuck@redhat.com>, 
 Jason Herne <jjherne@linux.ibm.com>, Ilya Leoshkevich <iii@linux.ibm.com>, 
 Richard Henderson <richard.henderson@linaro.org>, qemu-s390x@nongnu.org, 
 Zhuoying Cai <zycai@linux.ibm.com>, qemu-ppc@nongnu.org, 
 Eric Farman <farman@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 David Hildenbrand <david@kernel.org>, 
 Matthew Rosato <mjrosato@linux.ibm.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, 
 Jared Rossi <jrossi@linux.ibm.com>, 
 =?ISO-8859-15?Q?Daniel_P_=2E_Berrang=E9?= <berrange@redhat.com>, 
 =?ISO-8859-15?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH v2 2/6] roms/Makefile: add vofrom
In-Reply-To: <20260915004802.5749-3-pierrick.bouvier@oss.qualcomm.com>
Message-ID: <e0e2e072-e43a-cf80-284c-588d2b06cc9b@eik.bme.hu>
References: <20260915004802.5749-1-pierrick.bouvier@oss.qualcomm.com>
 <20260915004802.5749-3-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, 15 Sep 2026, Pierrick Bouvier wrote:
> Remove dependency on config.mak and simplify Makefile.
>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
> roms/Makefile     |  6 ++++++
> roms/vof/Makefile | 21 ++++++++-------------
> 2 files changed, 14 insertions(+), 13 deletions(-)
>
> diff --git a/roms/Makefile b/roms/Makefile
> index f15189a5409..84f22943d35 100644
> --- a/roms/Makefile
> +++ b/roms/Makefile
> @@ -63,6 +63,7 @@ default help:
> 	@echo "  pxerom             -- update nic roms (bios only)"
> 	@echo "  efirom             -- update nic roms (bios+efi)"
> 	@echo "  slof               -- update slof.bin"
> +	@echo "  vofrom             -- update vof.bin"

Is it a problem to call it just vof similar to slof? The name vofrom never 
appears anywhere else and is a bit confusing.

> 	@echo "  skiboot            -- update skiboot.lid"
> 	@echo "  u-boot.e500        -- update u-boot.e500"
> 	@echo "  u-boot.sam460      -- update u-boot.sam460"
> @@ -136,6 +137,10 @@ slof:
> 	$(MAKE) -C SLOF CROSS=$(powerpc64_cross_prefix) qemu
> 	cp SLOF/boot_rom.bin ../pc-bios/slof.bin
>
> +vofrom:
> +	$(MAKE) -C vof
> +	cp vof/vof.bin ../pc-bios/vof.bin
> +
> u-boot.e500:
> 	$(MAKE) -C u-boot O=build-e500 qemu-ppce500_config
> 	$(MAKE) -C u-boot CROSS_COMPILE=$(powerpc_cross_prefix) \
> @@ -217,6 +222,7 @@ clean:
> 	$(MAKE) -C edk2/BaseTools clean
> 	rm -rf edk2/Conf/{.cache,BuildEnv.sh,build_rule.txt,target.txt,tools_def.txt}
> 	$(MAKE) -C SLOF clean
> +	$(MAKE) -C vof clean
> 	rm -rf u-boot/build-e500
> 	$(MAKE) -C u-boot-sam460ex distclean
> 	$(MAKE) -C skiboot clean
> diff --git a/roms/vof/Makefile b/roms/vof/Makefile
> index d1eb6ced7ec..d5dbb374356 100644
> --- a/roms/vof/Makefile
> +++ b/roms/vof/Makefile
> @@ -1,27 +1,22 @@
> -include config.mak
> -VPATH=$(SRC_DIR)
> all: vof.bin
>
> -NULL :=
> -SPACE := $(NULL) #
> -TARGET_PREFIX := $(patsubst %/,%:$(SPACE),$(TARGET_DIR))
> -
> -quiet-@ = $(if $(V),,@$(if $1,,printf "%s\n" "$(TARGET_PREFIX)$1" && ))
> -quiet-command = $(call quiet-@,$2 $@)$1
> -
> +CROSS := $(or $(CROSS),powerpc-linux-gnu-)
> +CC := $(CROSS)gcc
> +LD := $(CROSS)ld
> +OBJCOPY := $(CROSS)objcopy
> EXTRA_CFLAGS += -mcpu=power4
>
> %.o: %.S
> -	$(call quiet-command, $(CC) $(EXTRA_CFLAGS) -c -o $@ $<,Assembling)
> +	$(CC) $(EXTRA_CFLAGS) -c -o $@ $<
>
> %.o: %.c
> -	$(call quiet-command, $(CC) $(EXTRA_CFLAGS) -c -fno-stack-protector -o $@ $<,Compiling)
> +	$(CC) $(EXTRA_CFLAGS) -c -fno-stack-protector -o $@ $<
>
> vof.elf: entry.o main.o ci.o bootmem.o libc.o
> -	$(call quiet-command, $(LD) -nostdlib -e_start -T$(SRC_DIR)/vof.lds -EB -o $@ $^,Linking)
> +	$(LD) -nostdlib -e_start -Tvof.lds -EB -o $@ $^
>
> %.bin: %.elf
> -	$(call quiet-command, $(OBJCOPY) -O binary -j .text -j .data -j .toc -j .got2 $^ $@,Extracting raw object)
> +	$(OBJCOPY) -O binary -j .text -j .data -j .toc -j .got2 $^ $@

Why are these losing quiet-command?

Regards,
BALATON Zoltan

>
> clean:
> 	rm -f *.o vof.bin vof.elf *~
>

