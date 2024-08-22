Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 652C7C3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2024 21:50:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1shFgD-0005yS-IP; Thu, 22 Aug 2024 17:49:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1shFg2-0005uK-6B
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 17:49:08 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1shFg0-00050f-B4
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 17:49:05 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-202376301e6so10999075ad.0
 for <qemu-devel@nongnu.org>; Thu, 22 Aug 2024 14:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1724363342; x=1724968142; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FtsUucNCHDglRhSefy2tbAtsd+nDXJw6T4rDMkxM0V8=;
 b=dKey7dyxKxNThb3VvZJeFoxINb9YJbhAA/G/S9G+UVlzMiXVSIH8miIWc8nP8nYCHs
 TRbUPmEBcBcxVaASz5CfA02RIYeKcAI1kAUAOXsVH+rNmB8RzzalIE9SYFNl54fooHSD
 1/vI2Snje7QKINpHUD1hK4udBHGk7zznfJR7U2upxKj7Xt7qytiy+dp+Ubbv9d65cTG8
 ZCkWltzUcm9h8lGQzok4OoLH849gfKGjkuwtVB4wuJYB2rl/SBns8Td2G2KDgb1K9bvN
 LWIKbRuG1C/qKF3dzh6KLIxQPYcuyj46e1gmPp8r8i6bVCDAlUy/+hMYyNDMnmH1nePG
 ZQXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724363342; x=1724968142;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FtsUucNCHDglRhSefy2tbAtsd+nDXJw6T4rDMkxM0V8=;
 b=Z6mgh9ytDrJvBu4UhFHkTLNpNRvkkgQ9KFb3Ie4qqaC+HWAWccHVjg0cifqdDRhEoj
 2HL4S+a5BV4eRw3P92g5NiJlmT9gLzLURp0sRUk/kmQDzmzT4XwhNX8E26kt1KLX06Kx
 FgJH6AxTRH2vqMoVQHRz+zysm9YF5aNue3cgPVDp3aOY/xKiWCqX11vq4LpUCvhOQXFj
 +M6l3mANf/4cPJCinbmnfVmxg673QxBTojZTL6B1kdf2x6+OuNVP5Gxr7mfN080sMsVm
 wtpIQDqwMVIJCnTJtqrknOZYs6CEcsAeMMfu5NuWe/CA7NuORmSjbraftLtqW8Jk5VoM
 WBlw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVYsylzjpAosZ9UpPNyhs7Z4Lkm8DqzS4B3ffypEb0VIQdUUm+BdujP81kfzHIGOUdZXxUX2dX4xxR1@nongnu.org
X-Gm-Message-State: AOJu0YwKerQ8CNvwiDu6JnyyMDsIp4HnlhxtERtULPak+ybpbsd4w2rH
 ZE/pbM07d8rPS3mWGk0S/rdR67vwfu67NYf/K9J1ukXVI7IvTSaa9QuY0c3OHqs=
X-Google-Smtp-Source: AGHT+IESs0CFct9quSVI0Gy2B22nFpxPkVtwp8bJ3qEMdaRTEw9YuWpXXgLtuKpsnGU4qo7hVtYwIw==
X-Received: by 2002:a17:902:ced0:b0:202:1aee:e414 with SMTP id
 d9443c01a7336-2039e50d1fbmr1212415ad.41.1724363341498; 
 Thu, 22 Aug 2024 14:49:01 -0700 (PDT)
Received: from [192.168.68.110] ([179.133.97.250])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2038548c707sm17200475ad.0.2024.08.22.14.48.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Aug 2024 14:49:01 -0700 (PDT)
Message-ID: <7b23efde-3af7-4f18-8386-af5e29590d1a@ventanamicro.com>
Date: Thu, 22 Aug 2024 18:48:58 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/1] Add support for generating OpenSBI domains in the
 device tree
To: Gregor Haas <gregorhaas1997@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, atishp@rivosinc.com, alistair.francis@wdc.com
References: <20240805210444.497723-1-gregorhaas1997@gmail.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20240805210444.497723-1-gregorhaas1997@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x634.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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



On 8/5/24 6:04 PM, Gregor Haas wrote:
> This patch series adds support for specifying OpenSBI domains on the QEMU
> command line. A simple example of what this looks like is below, including
> mapping the board's UART into the secondary domain:
> 
> qemu-system-riscv64 -machine virt -bios fw_jump.bin -cpu max -smp 2 -m 4G -nographic \
>          -device opensbi-memregion,id=mem,base=0xBC000000,order=26,mmio=false \
>          -device opensbi-memregion,id=uart,base=0x10000000,order=12,mmio=true,device0="/soc/serial@10000000" \
>          -device opensbi-domain,id=domain,possible-harts=0-1,boot-hart=0x0,next-addr=0xBC000000,next-mode=1,region0=mem,perms0=0x3f,region1=uart,perms1=0x3f
> 
> As a result of the above configuration, QEMU will add the following subnodes to
> the device tree:
> 
> chosen {
>          opensbi-domains {
>                  compatible = "opensbi,domain,config";
> 
>                  domain {
>                          next-mode = <0x01>;
>                          next-addr = <0x00 0xbc000000>;
>                          boot-hart = <0x03>;
>                          regions = <0x8000 0x3f 0x8002 0x3f>;
>                          possible-harts = <0x03 0x01>;
>                          phandle = <0x8003>;
>                          compatible = "opensbi,domain,instance";
>                  };
> 
>                  uart {
>                          phandle = <0x8002>;
>                          devices = <0x1800000>;
>                          mmio;
>                          order = <0x0c>;
>                          base = <0x00 0x10000000>;
>                          compatible = "opensbi,domain,memregion";
>                  };
> 
>                  mem {
>                          phandle = <0x8000>;
>                          order = <0x1a>;
>                          base = <0x00 0xbc000000>;
>                          compatible = "opensbi,domain,memregion";
>                  };
>          };
> };
> 
> This results in OpenSBI output as below, where regions 01-03 are inherited from
> the root domain and regions 00 and 04 correspond to the user specified ones:
> 
> Domain1 Name              : domain
> Domain1 Boot HART         : 0
> Domain1 HARTs             : 0,1
> Domain1 Region00          : 0x0000000010000000-0x0000000010000fff M: (I,R,W,X) S/U: (R,W,X)
> Domain1 Region01          : 0x0000000002000000-0x000000000200ffff M: (I,R,W) S/U: ()
> Domain1 Region02          : 0x0000000080080000-0x000000008009ffff M: (R,W) S/U: ()
> Domain1 Region03          : 0x0000000080000000-0x000000008007ffff M: (R,X) S/U: ()
> Domain1 Region04          : 0x00000000bc000000-0x00000000bfffffff M: (R,W,X) S/U: (R,W,X)
> Domain1 Next Address      : 0x00000000bc000000
> Domain1 Next Arg1         : 0x0000000000000000
> Domain1 Next Mode         : S-mode
> Domain1 SysReset          : no
> Domain1 SysSuspend        : no

I believe we need OpenSBI patches for this output, don't we? If I try this example using stock
OpenSBI 1.5.1 from QEMU this happens:


OpenSBI v1.5.1
    ____                    _____ ____ _____
   / __ \                  / ____|  _ \_   _|
  | |  | |_ __   ___ _ __ | (___ | |_) || |
  | |  | | '_ \ / _ \ '_ \ \___ \|  _ < | |
  | |__| | |_) |  __/ | | |____) | |_) || |_
   \____/| .__/ \___|_| |_|_____/|____/_____|
         | |
         |_|

sbi_domain_finalize: platform domains_init() failed (error -3)
init_coldboot: domain finalize failed (error -3)
(--- hangs ---)

It's not a big deal or a blocker to have this merged in QEMU regardless, but it would be nice
to have this documented somewhere (perhaps a new doc file). This would prevent users from trying
to use the device without the proper support.

This can be done after this patch is queued though. Thanks,


Daniel


> 
> v3:
> - Addressed review comments from v2 by adding default values to new properties.
>    This results in concrete errors at QEMU configuration time if a mandatory
>    property (as mandated by the OpenSBI spec) is not provided.
> - Changed command line encoding for the possible-harts field from a CPU bitmask
>    (e.g. where bit X is set if CPU X is a possible hart) to a range format (e.g.
>    the possible harts should be CPUs X-Y, where Y >= X). This does constrain the
>    hart assignment to consecutive ranges of harts, but this constraint is also
>    present for other QEMU subsystems (such as NUMA).
> - Added create_fdt_one_device(), which is invoked when scanning the device tree
>    for a memregion's devices. This function allocates a phandle for a region's
>    device if one does not yet exist.
> 
> v2:
> - Addressed review comments from v1. Specifically, renamed domain.{c,h} ->
>    opensbi_domain.{c,h} to increase clarity of what these files do. Also, more
>    consistently use g_autofree for dynamically allocated variables
> - Added an "assign" flag to OpenSBIDomainState, which indicates whether to
>    assign the domain's boot hart to it at domain parsing time.
> 
> Gregor Haas (1):
>    Add support for generating OpenSBI domains in the device tree
> 
>   MAINTAINERS                       |   7 +
>   hw/riscv/Kconfig                  |   4 +
>   hw/riscv/meson.build              |   1 +
>   hw/riscv/opensbi_domain.c         | 542 ++++++++++++++++++++++++++++++
>   hw/riscv/virt.c                   |   3 +
>   include/hw/riscv/opensbi_domain.h |  50 +++
>   6 files changed, 607 insertions(+)
>   create mode 100644 hw/riscv/opensbi_domain.c
>   create mode 100644 include/hw/riscv/opensbi_domain.h
> 

