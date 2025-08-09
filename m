Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40127C87FCF
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Aug 2025 12:13:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukiRX-0004jN-VA; Sat, 09 Aug 2025 08:12:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1ukiRL-0004iG-2d
 for qemu-devel@nongnu.org; Sat, 09 Aug 2025 08:12:48 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1ukiRH-00028s-Dz
 for qemu-devel@nongnu.org; Sat, 09 Aug 2025 08:12:45 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-23c8f179e1bso40571915ad.1
 for <qemu-devel@nongnu.org>; Sat, 09 Aug 2025 05:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1754741560; x=1755346360; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1Z/VirRQp9x5HIUEn152PrNpkGR+njVzvOtZvEJ551k=;
 b=BmaOlOv/mzRwbEtWoHQxntDMQDLA6vYVgr1CR+aZ6bbLObRHRhr56Tk+sQCRa5QPaC
 vV6HY17VhlH/nF2rHdCc2NmYZdHvHZ1sr+ho+asFgG5Kd9RdDVYs7RVeUY1TpXnw0pWX
 dvJ/umh0a6kAmNLKVVb7BDai8mjs+Ud1bXdMoIHDNG3/wc/GUxf3gMOgC0BJcVaWgwsp
 FxcZH4kZqC6G+OycDdeWr8zgow0R3BgbFKjPEV1X5EQetxvc/NidTu9ijRiONA6BnspP
 WVJdDtNX+KJPrd2KPTkp9hnIUK+Rqh59nnHStb59v+AKcBeRQvlVXzDms1hKS1NfOGlb
 1I8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754741560; x=1755346360;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1Z/VirRQp9x5HIUEn152PrNpkGR+njVzvOtZvEJ551k=;
 b=cJmHxK8QP7wqjinV+nqXzZ+cASLxb9KR4q6oSj4q+6sAyWSxafTNdBfyMauD0qWvIa
 P2aQt+CjyUud8RmhDARR7+q6EBdSIsM90Kuw2cloK8K9+n6WQsQDIZegj+Ac1WLyURy2
 IUVGE16Tz6bBPwqegjyEyCczVeCgTOGaZkB7njldaNw67tCc0c5Q9dI8m70lI7qPDXGn
 Rkax87i4cR+HZfUPQ0KCthM36fYKwun1VIN18LU7B1nz1kUw2ooDfDrwThp88HnESjaq
 c0VbPkNuqaektXR3gcT61WHlMZRA+iZsLoMBw9Z2ucPo8KHA2Mn7IrLqPHWQfSSG+LcI
 qyVw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWmQad3OMcFV/JDHpanNpulLmPcy2GNKMRbVAl6yE+v6xMw949W3excsEE0xkEzEEb4kP+1ijzd/7CW@nongnu.org
X-Gm-Message-State: AOJu0Yy/16HJpXX3G3zWJw4lcDFvdoULi0wZ/1Jk5Ik7x+ZOQ94UNg7p
 2s4S/kiFTxQu2NyZ0e+25pXKBNH+vmdmutqLfDEbo3Ottzwqcsv8RgkN4Sc+peb1jgE=
X-Gm-Gg: ASbGncvODJsOA2qs1F+iO2jpiYf4srZ810ZVhP2rzAiQtN2Ix9a1Q5e5ugB/LGbK94Z
 Fq2NwA4ecgSCKrCQqRYCrDKzFXhZzDf6938S52yoPHIwfNEJecEDo2YFPsyiK4KOQsp4b+za5JQ
 i62RxeIN3lkfffLWtaQpA5p9waN5mDCdKSkdK+qzePcrpkEy3seZ8SUJWtXPIlGWaBdg1RY8P0X
 X7XyBy8d/ywPMQ0/zIeGCBaqZ395qfLTFvjQFgBgZakBViDI81XFLhR1iIOdyucAYMXqnqrONEh
 uI5yfTHEmkTrL98Ur1CFZ76vVg9AsHLMRyrC5B1bivF/e6GQhQwmicXxWQRnVKunLoXSBvZJSug
 3Z4NP0MARxd7GSqO/3X0t7SaMV2sL9SIKiWPThQ==
X-Google-Smtp-Source: AGHT+IH5loBiDknf6qmpmM5+eYRcfoDNZ1Z8SdJvx+50XXjNRFHlZBRV0+v5kMXnh3HGA854mrv8mg==
X-Received: by 2002:a17:902:d50b:b0:240:10dc:b795 with SMTP id
 d9443c01a7336-242c1fdc662mr109610915ad.1.1754741560238; 
 Sat, 09 Aug 2025 05:12:40 -0700 (PDT)
Received: from [192.168.68.110] ([152.234.127.110])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-241d1ef6cb7sm227808275ad.26.2025.08.09.05.12.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 09 Aug 2025 05:12:39 -0700 (PDT)
Message-ID: <5a03a487-cd96-480c-b420-2ebfe4e15550@ventanamicro.com>
Date: Sat, 9 Aug 2025 09:12:35 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] aplic: fix mask for smsiaddrcfgh
To: Yang Jialong <z_bajeer@yeah.net>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Cc: yangjialong@rvcore.com, qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 Anup Patel <apatel@ventanamicro.com>
References: <20250807082346.3752212-1-z_bajeer@yeah.net>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Content-Language: en-US
In-Reply-To: <20250807082346.3752212-1-z_bajeer@yeah.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

CCing Anup

On 8/7/25 5:23 AM, Yang Jialong wrote:
> 4.5.4. Supervisor MSI address configuration (smsiaddrcfg and
>    smsiaddrcfgh)
> smsiaddrcfgh:
> 	bits 22:20 LHXS(WARL)
> 	bits 11:0  High Base PPN(WARL)
> 
> Signed-off-by: Yang Jialong <z_bajeer@yeah.net>
> ---

This patch is causing boot slowdowns in a setup I have with Ubuntu 25.04 and
iommu enabled. This is the command line I'm using:

qemu-system-riscv64 \
	-machine virt,iommu-sys=on,aia=aplic-imsic,aia-guests=5 -nographic -m 8G -smp 8 \
	-cpu rv64 \
	-kernel u-boot \
         -netdev bridge,id=bridge1,br=virbr0 -device virtio-net-pci,netdev=bridge1 \
         -device virtio-rng-pci \
         -drive file=ubuntu-25.04-preinstalled-server-riscv64.img,format=raw,if=virtio \
	-netdev user,id=net1,net=10.0.2.0/24 \
	-device e1000e,netdev=net1

A regular boot of this setup, without this patch, finishes around ~30 seconds:


(...)
[   29.831336] sh[798]: Completed socket interaction for boot stage final

Ubuntu 25.04 ubuntu ttyS0

ubuntu login:


With this patch I am experiencing a boot slowdown. Note the 'dmesg' timestamps:

(...)
[    8.167639] EXT4-fs (vda1): mounted filesystem fb804e3f-f59c-41d7-ab48-20c2af71ad1a ro with ordered data mode. Quota mode: disabled.
[   70.662648] systemd[1]: systemd 257.4-1ubuntu3.1 running in system mode (+PAM +AUDIT +SELINUX +APPARMOR +IMA +IPE +SMACK +SECCOMP +GCRYPT -GNUTLS +OPENSSL +ACL +BLKID +CURL +ELFUTILS +FIDO2 +IDN2 -IDN +IPTC +KMOD +LIBCRYPTSETUP +LIBCRYPTSETUP_PLUGINS +LIBFDISK +PCRE2 +PWQUALITY +P11KIT +QRENCODE +TPM2 +BZIP2 +LZ4 +XZ +ZLIB +ZSTD -BPF_FRAMEWORK -BTF -XKBCOMMON -UTMP +SYSVINIT +LIBARCHIVE)
[   70.665041] systemd[1]: Detected virtualization qemu.
[   70.665581] systemd[1]: Detected architecture riscv64.
[  101.384348] systemd[1]: Hostname set to <ubuntu>.
[  133.467012] systemd[1]: Queued start job for default target graphical.target.
[  133.573797] systemd[1]: Created slice system-modprobe.slice - Slice /system/modprobe.
[  164.889837] systemd[1]: Created slice system-serial\x2dgetty.slice - Slice /system/serial-getty.
[  195.608413] systemd[1]: Created slice system-systemd\x2dfsck.slice - Slice /system/systemd-fsck.
[  226.326764] systemd[1]: Created slice user.slice - User and Session Slice.
[  257.044684] systemd[1]: Started systemd-ask-password-wall.path - Forward Password Requests to Wall Directory Watch.
[  287.764541] systemd[1]: proc-sys-fs-binfmt_misc.automount - Arbitrary Executable File Formats File System Automount Point was skipped because of an unmet condition check (ConditionPathExists=/proc/sys/fs/binfmt_misc).
[  287.767418] systemd[1]: Expecting device dev-disk-by\x2dlabel-UEFI.device - /dev/disk/by-label/UEFI...
(...)


I haven't waited to see how long the login prompt would take.

The two codebases (with and without this patch) were tested around 10 times each to see if
the slowdowns were an emulation variance and so on. This behavior is consistent.

Anup is CC'ed in case he has something to add. This patch is either incorrect or Linux
isn't playing well with it, but either way we can't take the risk of breaking Linux.


Thanks,

Daniel


>   hw/intc/riscv_aplic.c | 10 +++++++---
>   1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/intc/riscv_aplic.c b/hw/intc/riscv_aplic.c
> index a1d9fa5085..174ccb3a64 100644
> --- a/hw/intc/riscv_aplic.c
> +++ b/hw/intc/riscv_aplic.c
> @@ -96,7 +96,7 @@
>       (APLIC_xMSICFGADDR_PPN_HHX_MASK(__hhxw) << \
>        APLIC_xMSICFGADDR_PPN_HHX_SHIFT(__hhxs))
>   
> -#define APLIC_xMSICFGADDRH_VALID_MASK   \
> +#define APLIC_MMSICFGADDRH_VALID_MASK   \
>       (APLIC_xMSICFGADDRH_L | \
>        (APLIC_xMSICFGADDRH_HHXS_MASK << APLIC_xMSICFGADDRH_HHXS_SHIFT) | \
>        (APLIC_xMSICFGADDRH_LHXS_MASK << APLIC_xMSICFGADDRH_LHXS_SHIFT) | \
> @@ -104,6 +104,10 @@
>        (APLIC_xMSICFGADDRH_LHXW_MASK << APLIC_xMSICFGADDRH_LHXW_SHIFT) | \
>        APLIC_xMSICFGADDRH_BAPPN_MASK)
>   
> +#define APLIC_SMSICFGADDRH_VALID_MASK   \
> +    ((APLIC_xMSICFGADDRH_LHXS_MASK << APLIC_xMSICFGADDRH_LHXS_SHIFT) | \
> +     APLIC_xMSICFGADDRH_BAPPN_MASK)
> +
>   #define APLIC_SETIP_BASE               0x1c00
>   #define APLIC_SETIPNUM                 0x1cdc
>   
> @@ -771,7 +775,7 @@ static void riscv_aplic_write(void *opaque, hwaddr addr, uint64_t value,
>       } else if (aplic->mmode && aplic->msimode &&
>                  (addr == APLIC_MMSICFGADDRH)) {
>           if (!(aplic->mmsicfgaddrH & APLIC_xMSICFGADDRH_L)) {
> -            aplic->mmsicfgaddrH = value & APLIC_xMSICFGADDRH_VALID_MASK;
> +            aplic->mmsicfgaddrH = value & APLIC_MMSICFGADDRH_VALID_MASK;
>           }
>       } else if (aplic->mmode && aplic->msimode &&
>                  (addr == APLIC_SMSICFGADDR)) {
> @@ -792,7 +796,7 @@ static void riscv_aplic_write(void *opaque, hwaddr addr, uint64_t value,
>                  (addr == APLIC_SMSICFGADDRH)) {
>           if (aplic->num_children &&
>               !(aplic->mmsicfgaddrH & APLIC_xMSICFGADDRH_L)) {
> -            aplic->smsicfgaddrH = value & APLIC_xMSICFGADDRH_VALID_MASK;
> +            aplic->smsicfgaddrH = value & APLIC_SMSICFGADDRH_VALID_MASK;
>           }
>       } else if ((APLIC_SETIP_BASE <= addr) &&
>               (addr < (APLIC_SETIP_BASE + aplic->bitfield_words * 4))) {


