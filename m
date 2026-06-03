Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0A19CD6E6A
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 07:08:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUfi9-0002Tg-1H; Wed, 03 Jun 2026 03:08:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@mailo.com>) id 1wUfi3-0002TM-L2
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 03:08:16 -0400
Received: from msg-2.mailo.com ([213.182.54.12] helo=mailo.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@mailo.com>) id 1wUfi2-0000B7-3B
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 03:08:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailo.com; s=mailo;
 t=1780469589; bh=YQOilt3Vbcv4maJqUFiqg83iwTiJ4UUCxy4SV7Tsnec=;
 h=X-EA-Auth:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
 b=XvhZig/Bsfhkz732w0fOqHaYi7LYb39PUneW960RGaWjhae2ngrcFvQulBGgYjBhr
 GVz+510gmfrNjR6YAu6kNp6iPMAI007YJrCS+C+34neDYd0y5deVMS4nY/keDYXrHO
 fnuLw0paJLXnRaR9EMH8+jL3zQXPEo6gSW7Hiw6k=
Received: by be1-8.in.mailobj.net [192.168.91.18] with ESMTP
 via ip-20.mailobj.net [213.182.54.20]
 Wed,  3 Jun 2026 08:52:25 +0200 (CEST)
X-EA-Auth: PiGWVAyV0mShbThfLjqbO9kxbT9FH6KBSOlwLFz3R6CbiWy/3YOZuVMATuQCPhitbnhzH0ipm9IsBuZodG+jLPO6I+/3z9pt
Message-ID: <d6f30fab-eb87-45e7-bc5b-bd1f97afead8@mailo.com>
Date: Wed, 3 Jun 2026 08:52:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] hw/nvram/fw_cfg: Enforce standard layout for x86
 fw_cfg I/O ports
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Sergio Lopez <slp@redhat.com>, Song Gao <gaosong@loongson.cn>,
 Bibo Mao <maobibo@loongson.cn>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>
References: <20260529174639.451353-1-peter.maydell@linaro.org>
 <20260529174639.451353-4-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>
In-Reply-To: <20260529174639.451353-4-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=213.182.54.12; envelope-from=philmd@mailo.com;
 helo=mailo.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

On 29/5/26 19:46, Peter Maydell wrote:
> The fw_cfg_init_io_dma() function allows the caller to specify the
> base port number of the selector/data register and the base port
> number of the DMA address register separately. No caller actually
> uses this: they all pass in base + 4 for the dma_iobase.
> 
> To reduce the risk of unnecessary variation in what different x86
> machine types use as their fw_cfg register layout, remove the
> dma_iobase argument from fw_cfg_init_io_dma(), and have the function
> always use the same "DMA port is base port + 4" layout.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/i386/fw_cfg.c          |  3 +--
>   hw/i386/microvm.c         |  3 +--
>   hw/i386/pc.c              |  3 +--
>   hw/nvram/fw_cfg.c         |  8 ++++----
>   include/hw/nvram/fw_cfg.h | 17 +++++++++++++++--
>   5 files changed, 22 insertions(+), 12 deletions(-)


> diff --git a/include/hw/nvram/fw_cfg.h b/include/hw/nvram/fw_cfg.h
> index 45a3747908..be3fb5f8aa 100644
> --- a/include/hw/nvram/fw_cfg.h
> +++ b/include/hw/nvram/fw_cfg.h
> @@ -305,8 +305,21 @@ bool fw_cfg_add_file_from_generator(FWCfgState *s,
>                                       Object *parent, const char *part,
>                                       const char *filename, Error **errp);
>   
> -FWCfgState *fw_cfg_init_io_dma(uint32_t iobase, uint32_t dma_iobase,
> -                                AddressSpace *dma_as);
> +/**
> + * fw_cfg_init_io_dma:
> + * @iobase: x86 port number which is the base of the fw_cfg port range

s/x86/ISA/?

Anyway,
Reviewed-by: Philippe Mathieu-Daudé <philmd@mailo.com>

> + * @dma_as: the device will do DMA to/from this AddressSpace
> + *
> + * Create a fw_cfg device and map it into the specified I/O port range.
> + *
> + * This creates a device with the x86 PC standard port I/O layout:
> + * - Selector Register IOport: @iobase
> + * - Data Register IOport:     @iobase + 1
> + * - DMA Address IOport:       @iobase + 4
> + *
> + * Returns the device object.
> + */
> +FWCfgState *fw_cfg_init_io_dma(uint32_t iobase, AddressSpace *dma_as);
>   FWCfgState *fw_cfg_init_mem_nodma(hwaddr ctl_addr, hwaddr data_addr,
>                                     unsigned data_width);
>   /**



