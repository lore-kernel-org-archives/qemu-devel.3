Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADDFAC54798
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Mar 2024 09:07:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1risfX-0005pa-Md; Sat, 09 Mar 2024 04:07:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1risfU-0005p7-Sx
 for qemu-devel@nongnu.org; Sat, 09 Mar 2024 04:07:00 -0500
Received: from mail-ed1-f43.google.com ([209.85.208.43])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1risfS-00028n-Pi
 for qemu-devel@nongnu.org; Sat, 09 Mar 2024 04:07:00 -0500
Received: by mail-ed1-f43.google.com with SMTP id
 4fb4d7f45d1cf-563cb3ba9daso3161462a12.3
 for <qemu-devel@nongnu.org>; Sat, 09 Mar 2024 01:06:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709975216; x=1710580016;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iY7uGXfS14VEBoT2NGcCuMDbfzTMiVBjQP+YWcEvK4k=;
 b=Rh1NqxjJ0wwdxUNrvergI/LLwowHuwMZaAkA0eFgkMpIdXFruF1ykeDpm7mToTD+NR
 7NzjOOWkUrJjdjAwQ4++MyynDT36bwyjDVheYfqg1yyjdoMKSpP+NRpMBPi7zu2PSyFp
 1t3KuXybUJn/Ai5wFIHTgLpz7e42jeXSBghLAOqZhpmJeVJ4sHfe60AHnpBt7UUQkM+t
 WhTtfnmRkzkOMzUrVnwTvvA6WH63F1zLowom5TM/OKX3MuIrda2IgSFTjxlzRNaCQ/fp
 B6jGer+m+HSxwImPEZtMOJ0VKuqHoiNYKi2Oi9thfvP0I8Nfc7oevpfSz8a/dKeAIUJF
 ygsA==
X-Gm-Message-State: AOJu0Yx6TkRHv/zJeV5PrNZQMYmFfabweQOwsM/ba2YPgAVlVzohuEGY
 zWA96i9dugr2zzU4tM/0hzJGet2G1r3xadApo+r0tjIYJCZR7zBA6iGl7OCV
X-Google-Smtp-Source: AGHT+IFXV6GDWNneT4dpMtc+p5kH6W1ryQbVGXlOVgGnIT9T2BN48RjHyQyG7yocvYaLiP0+5eJu+Q==
X-Received: by 2002:a17:907:778e:b0:a45:b36c:55c8 with SMTP id
 ky14-20020a170907778e00b00a45b36c55c8mr633643ejc.38.1709975216193; 
 Sat, 09 Mar 2024 01:06:56 -0800 (PST)
Received: from fedora (ip-109-43-178-151.web.vodafone.de. [109.43.178.151])
 by smtp.gmail.com with ESMTPSA id
 h25-20020a1709070b1900b00a3e5adf11c7sm659532ejl.157.2024.03.09.01.06.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 Mar 2024 01:06:55 -0800 (PST)
Date: Sat, 9 Mar 2024 10:06:54 +0100
From: Thomas Huth <huth@tuxfamily.org>
To: Angelo Dureghello <angelo@kernel-space.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v2] hw/m68k/mcf5208: add support for reset
Message-ID: <20240309100654.24a89b54@fedora>
In-Reply-To: <20240308090812.1316635-1-angelo@kernel-space.org>
References: <20240308090812.1316635-1-angelo@kernel-space.org>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=209.85.208.43; envelope-from=th.huth@gmail.com;
 helo=mail-ed1-f43.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.248, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Am Fri,  8 Mar 2024 10:08:12 +0100
schrieb Angelo Dureghello <angelo@kernel-space.org>:

> Add reset support for mcf5208.
> 
> Signed-off-by: Angelo Dureghello <angelo@kernel-space.org>
> ---
>  hw/m68k/mcf5208.c | 49 ++++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 46 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/m68k/mcf5208.c b/hw/m68k/mcf5208.c
> index 0cfb806c20..d8a38274d0 100644
> --- a/hw/m68k/mcf5208.c
> +++ b/hw/m68k/mcf5208.c
> @@ -40,6 +40,8 @@
>  #define PCSR_PRE_SHIFT  8
>  #define PCSR_PRE_MASK   0x0f00
>  
> +#define RCR_SOFTRST     0x80
> +
>  typedef struct {
>      MemoryRegion iomem;
>      qemu_irq irq;
> @@ -185,13 +187,54 @@ static const MemoryRegionOps m5208_sys_ops = {
>      .endianness = DEVICE_NATIVE_ENDIAN,
>  };
>  
> -static void mcf5208_sys_init(MemoryRegion *address_space, qemu_irq *pic)
> +static uint64_t m5208_rcm_read(void *opaque, hwaddr addr,
> +                               unsigned size)
> +{
> +    qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset 0x%" HWADDR_PRIX "\n",
> +                  __func__, addr);

I'd maybe rather not print this message if the guest tries to read from RCR
or RSR - reading back a 0 should be fine here without logging a "bad
offset".

> +    return 0;
> +}
> +
> +static void m5208_rcm_write(void *opaque, hwaddr addr,
> +                            uint64_t value, unsigned size)
> +{
> +    M68kCPU *cpu = opaque;
> +    CPUState *cs = CPU(cpu);
> +    switch (addr) {
> +    case 0x0: /* RCR */
> +        if (value & RCR_SOFTRST) {
> +            cpu_reset(cs);
> +            cpu->env.aregs[7] = ldl_phys(cs->as, 0);
> +            cpu->env.pc = ldl_phys(cs->as, 4);
> +        }
> +        break;
> +    default:
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset 0x%" HWADDR_PRIX "\n",
> +                      __func__, addr);
> +        break;
> +    }
> +}
> +
> +static const MemoryRegionOps m5208_rcm_ops = {
> +    .read = m5208_rcm_read,
> +    .write = m5208_rcm_write,
> +    .endianness = DEVICE_NATIVE_ENDIAN,
> +};
> +
> +static void mcf5208_sys_init(MemoryRegion *address_space, qemu_irq *pic,
> +                             M68kCPU *cpu)
>  {
> -    MemoryRegion *iomem = g_new(MemoryRegion, 1);
> +    MemoryRegion *iomem;

I think it's more common coding style in the QEMU sources to have separate
variables for separate MemoryRegions instead of re-using one variable for
separate MemoryRegions like you do it below. See e.g.
microchip_pfsoc_soc_realize() in hw/riscv/microchip_pfsoc.c.

>      m5208_timer_state *s;
>      int i;
>  
> +    /* RCM */
> +    iomem = g_new(MemoryRegion, 1);
> +    memory_region_init_io(iomem, NULL, &m5208_rcm_ops, cpu,
> +                          "m5208-rcm", 0x00000080);
> +    memory_region_add_subregion(address_space, 0xfc0a0000, iomem);
>      /* SDRAMC.  */
> +    iomem = g_new(MemoryRegion, 1);
>      memory_region_init_io(iomem, NULL, &m5208_sys_ops, NULL, "m5208-sys", 0x00004000);
>      memory_region_add_subregion(address_space, 0xfc0a8000, iomem);
>      /* Timers.  */
> @@ -265,7 +308,7 @@ static void mcf5208evb_init(MachineState *machine)
>      mcf_uart_create_mmap(0xfc064000, pic[27], serial_hd(1));
>      mcf_uart_create_mmap(0xfc068000, pic[28], serial_hd(2));
>  
> -    mcf5208_sys_init(address_space_mem, pic);
> +    mcf5208_sys_init(address_space_mem, pic, cpu);
>  
>      mcf_fec_init(address_space_mem, 0xfc030000, pic + 36);

All in all, patch looks fine to me ... if you could update the above two
nits by Monday, I can try to get this merged before the next soft freeze of
QEMU (on Tuesday).

 Thanks,
  Thomas

