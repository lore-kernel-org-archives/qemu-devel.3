Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14EB8C52D7C
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2024 04:27:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sftzZ-0003xY-BZ; Mon, 19 Aug 2024 00:27:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1sftvU-0000ce-1r
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 00:23:28 -0400
Received: from mail-ot1-x334.google.com ([2607:f8b0:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1sftvS-0004To-3P
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 00:23:27 -0400
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-70968db52d0so4301028a34.3
 for <qemu-devel@nongnu.org>; Sun, 18 Aug 2024 21:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724041405; x=1724646205; darn=nongnu.org;
 h=content-transfer-encoding:content-language:in-reply-to:mime-version
 :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Nuq/AMvAxy3nR8GHaaLSwgI+50j2bTLxILd8fiUV20s=;
 b=gi17Ec62I0egx1Ke7Fk9d459shHF742geOG1w72Uw3i95Z6wK5FGWRVIUX8CPctyth
 zhSTvut/0wA1znDr7jLCQ0ejORAQbAiGFZTRgKOarw5IUMQao2PTGv9UagMNcw4GCwZk
 HbsyjMGQnOzH0GYLI0N2I7S05SBmgXqSqvHlVcgGZd1/PzM48Vu4/Eq+cBz66L5YQyOa
 /9fSIrfyymH5iEeLCR9Cw3zbjkN+7bbbb7xXp0sLMR3s7MOwZz3MA3qnMhHqeHIiiwmE
 59gHA2yNGqgeB+r7+h3qed+crHUm0Q3Lv0K7YpA6uzSj/6pIYmemLjmj8sBqqh7ZhG7a
 aPMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724041405; x=1724646205;
 h=content-transfer-encoding:content-language:in-reply-to:mime-version
 :user-agent:date:message-id:from:references:cc:to:subject
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Nuq/AMvAxy3nR8GHaaLSwgI+50j2bTLxILd8fiUV20s=;
 b=tNYqe0VSBN2ZIk+1iWy9EOkAP4f65MYK6GQcGx9tMsBL3zyfQe8qD6DiyU4fN1W0JC
 Nt/Mscn6lv6gpUJfx+0FFCaEfQSfViSa1aYFekuwgGP2tUy4Hf1LdaedWIz+jzJR8B+1
 AGeKvA99qRdzjF7Hqrrm6RpbpNcuY572OIjfEKbWfavc50hvoEKQYpUiTR7ItJkraYgJ
 GbLRk7vJuvZ2Yb9X1kdyW/scBjE4l9amf3pZ5kPJgLF+6uTPJnWC8dbp4rvO73CUbmsX
 BkL1ll/ks1Ir9YQoMCEu1g3PnDFxKQa8XhYJMZZapwUGhqt6rnKwzLKrGuerpdyy6r9B
 H02Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVN0HSq+l0Cb2AhA2EzqcUUU2PsL0/U+hSd6xWD4oFVPZh4q0dzBJoRdn2cFAa1bi0Liy4o7UCFfzvoJO9qN+FHWOYjG2w=
X-Gm-Message-State: AOJu0Yy28+s7peBb7+VK/PmbF/OpJIDsY5eVjQG07YgVKBAtc13/pTed
 wVLk/jGCR4ohDSSsjB/bX/Qk3QibuSJzx8De7si8gjuDGlKKVkImqIXKfEG3eJbc7WU1d4cPO/v
 x
X-Google-Smtp-Source: AGHT+IGKqEgysF5u4hYd/7tihG+Lxf5WNyMpBS+BiaFMvdCJcUD98ktTYeT/KqMAQi99VL21SOjHUA==
X-Received: by 2002:a05:6358:938f:b0:1ac:f346:735a with SMTP id
 e5c5f4694b2df-1b393315b20mr1431440155d.28.1724041404682; 
 Sun, 18 Aug 2024 21:23:24 -0700 (PDT)
Received: from [192.168.0.103] ([191.205.40.123])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7c6b61a6cffsm6840103a12.2.2024.08.18.21.23.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 18 Aug 2024 21:23:24 -0700 (PDT)
Subject: Re: [PATCH 6/8] hw/pci-host/designware: Move viewports from root func
 to host bridge
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20231012121857.31873-1-philmd@linaro.org>
 <20231012121857.31873-7-philmd@linaro.org>
From: Gustavo Romero <gustavo.romero@linaro.org>
Message-ID: <bd4f9669-cf91-3fe1-cc3c-bbc529aa4ce3@linaro.org>
Date: Mon, 19 Aug 2024 01:23:21 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20231012121857.31873-7-philmd@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::334;
 envelope-from=gustavo.romero@linaro.org; helo=mail-ot1-x334.google.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.588,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hi Phil,

On 10/12/23 9:18 AM, Philippe Mathieu-Daudé wrote:
> As mentioned in previous commit, the PCI root function is
> irrelevant for the ViewPorts. Move the fields to the host
> bridge state.
> 
> This is a migration compatibility break for the machines
> using the i.MX7 SoC (currently the mcimx7d-sabre machine).
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>

I also see the ATU Viewport registers closer to the host
bridge, so from a modeling perspective I think that makes
sense, even if it's hard to tell that for sure when looking
at the DW IP core docs (but of course QEMU model doesn't
have to mimic any verilog code etc).

Reviewed-by: Gustavo Romero <gustavo.romero@linaro.org>


Cheers,
Gustavo


> ---
>   include/hw/pci-host/designware.h | 13 ++++-----
>   hw/pci-host/designware.c         | 47 ++++++++++++++++----------------
>   2 files changed, 30 insertions(+), 30 deletions(-)
> 
> diff --git a/include/hw/pci-host/designware.h b/include/hw/pci-host/designware.h
> index e1952ad324..702777ab17 100644
> --- a/include/hw/pci-host/designware.h
> +++ b/include/hw/pci-host/designware.h
> @@ -63,13 +63,6 @@ typedef struct DesignwarePCIEMSI {
>   struct DesignwarePCIERoot {
>       PCIBridge parent_obj;
>   
> -    uint32_t atu_viewport;
> -
> -#define DESIGNWARE_PCIE_VIEWPORT_OUTBOUND    0
> -#define DESIGNWARE_PCIE_VIEWPORT_INBOUND     1
> -#define DESIGNWARE_PCIE_NUM_VIEWPORTS        4
> -
> -    DesignwarePCIEViewport viewports[2][DESIGNWARE_PCIE_NUM_VIEWPORTS];
>       DesignwarePCIEMSI msi;
>       DesignwarePCIEHost *host;
>   };
> @@ -79,6 +72,12 @@ struct DesignwarePCIEHost {
>   
>       DesignwarePCIERoot root;
>   
> +    uint32_t atu_viewport;
> +#define DESIGNWARE_PCIE_VIEWPORT_OUTBOUND    0
> +#define DESIGNWARE_PCIE_VIEWPORT_INBOUND     1
> +#define DESIGNWARE_PCIE_NUM_VIEWPORTS        4
> +    DesignwarePCIEViewport viewports[2][DESIGNWARE_PCIE_NUM_VIEWPORTS];
> +
>       struct {
>           AddressSpace address_space;
>           MemoryRegion address_space_root;
> diff --git a/hw/pci-host/designware.c b/hw/pci-host/designware.c
> index d12a36b628..2ef17137e2 100644
> --- a/hw/pci-host/designware.c
> +++ b/hw/pci-host/designware.c
> @@ -109,20 +109,21 @@ static void designware_pcie_root_update_msi_mapping(DesignwarePCIERoot *root)
>   }
>   
>   static DesignwarePCIEViewport *
> -designware_pcie_root_get_current_viewport(DesignwarePCIERoot *root)
> +designware_pcie_host_get_current_viewport(DesignwarePCIEHost *host)
>   {
> -    const unsigned int idx = root->atu_viewport & 0xF;
> +    const unsigned int idx = host->atu_viewport & 0xF;
>       const unsigned int dir =
> -        !!(root->atu_viewport & DESIGNWARE_PCIE_ATU_REGION_INBOUND);
> -    return &root->viewports[dir][idx];
> +        !!(host->atu_viewport & DESIGNWARE_PCIE_ATU_REGION_INBOUND);
> +    return &host->viewports[dir][idx];
>   }
>   
>   static uint32_t
>   designware_pcie_root_config_read(PCIDevice *d, uint32_t address, int len)
>   {
>       DesignwarePCIERoot *root = DESIGNWARE_PCIE_ROOT(d);
> +    DesignwarePCIEHost *host = root->host;
>       DesignwarePCIEViewport *viewport =
> -        designware_pcie_root_get_current_viewport(root);
> +        designware_pcie_host_get_current_viewport(host);
>   
>       uint32_t val;
>   
> @@ -170,7 +171,7 @@ designware_pcie_root_config_read(PCIDevice *d, uint32_t address, int len)
>           break;
>   
>       case DESIGNWARE_PCIE_ATU_VIEWPORT:
> -        val = root->atu_viewport;
> +        val = host->atu_viewport;
>           break;
>   
>       case DESIGNWARE_PCIE_ATU_LOWER_BASE:
> @@ -294,7 +295,7 @@ static void designware_pcie_root_config_write(PCIDevice *d, uint32_t address,
>       DesignwarePCIERoot *root = DESIGNWARE_PCIE_ROOT(d);
>       DesignwarePCIEHost *host = root->host;
>       DesignwarePCIEViewport *viewport =
> -        designware_pcie_root_get_current_viewport(root);
> +        designware_pcie_host_get_current_viewport(host);
>   
>       switch (address) {
>       case DESIGNWARE_PCIE_PORT_LINK_CONTROL:
> @@ -332,7 +333,7 @@ static void designware_pcie_root_config_write(PCIDevice *d, uint32_t address,
>           break;
>   
>       case DESIGNWARE_PCIE_ATU_VIEWPORT:
> -        root->atu_viewport = val;
> +        host->atu_viewport = val;
>           break;
>   
>       case DESIGNWARE_PCIE_ATU_LOWER_BASE:
> @@ -420,7 +421,7 @@ static void designware_pcie_root_realize(PCIDevice *dev, Error **errp)
>           const char *direction;
>           char *name;
>   
> -        viewport = &root->viewports[DESIGNWARE_PCIE_VIEWPORT_INBOUND][i];
> +        viewport = &host->viewports[DESIGNWARE_PCIE_VIEWPORT_INBOUND][i];
>           viewport->inbound = true;
>           viewport->base    = 0x0000000000000000ULL;
>           viewport->target  = 0x0000000000000000ULL;
> @@ -443,7 +444,7 @@ static void designware_pcie_root_realize(PCIDevice *dev, Error **errp)
>           memory_region_set_enabled(mem, false);
>           g_free(name);
>   
> -        viewport = &root->viewports[DESIGNWARE_PCIE_VIEWPORT_OUTBOUND][i];
> +        viewport = &host->viewports[DESIGNWARE_PCIE_VIEWPORT_OUTBOUND][i];
>           viewport->host    = host;
>           viewport->inbound = false;
>           viewport->base    = 0x0000000000000000ULL;
> @@ -490,7 +491,7 @@ static void designware_pcie_root_realize(PCIDevice *dev, Error **errp)
>        * NOTE: This will not work correctly for the case when first
>        * configured inbound window is window 0
>        */
> -    viewport = &root->viewports[DESIGNWARE_PCIE_VIEWPORT_INBOUND][0];
> +    viewport = &host->viewports[DESIGNWARE_PCIE_VIEWPORT_INBOUND][0];
>       viewport->cr[1] = DESIGNWARE_PCIE_ATU_ENABLE;
>       designware_pcie_update_viewport(root, viewport);
>   
> @@ -563,18 +564,10 @@ static const VMStateDescription vmstate_designware_pcie_viewport = {
>   
>   static const VMStateDescription vmstate_designware_pcie_root = {
>       .name = "designware-pcie-root",
> -    .version_id = 1,
> -    .minimum_version_id = 1,
> +    .version_id = 2,
> +    .minimum_version_id = 2,
>       .fields = (VMStateField[]) {
>           VMSTATE_PCI_DEVICE(parent_obj, PCIBridge),
> -        VMSTATE_UINT32(atu_viewport, DesignwarePCIERoot),
> -        VMSTATE_STRUCT_2DARRAY(viewports,
> -                               DesignwarePCIERoot,
> -                               2,
> -                               DESIGNWARE_PCIE_NUM_VIEWPORTS,
> -                               1,
> -                               vmstate_designware_pcie_viewport,
> -                               DesignwarePCIEViewport),
>           VMSTATE_STRUCT(msi,
>                          DesignwarePCIERoot,
>                          1,
> @@ -711,14 +704,22 @@ static void designware_pcie_host_realize(DeviceState *dev, Error **errp)
>   
>   static const VMStateDescription vmstate_designware_pcie_host = {
>       .name = "designware-pcie-host",
> -    .version_id = 1,
> -    .minimum_version_id = 1,
> +    .version_id = 2,
> +    .minimum_version_id = 2,
>       .fields = (VMStateField[]) {
>           VMSTATE_STRUCT(root,
>                          DesignwarePCIEHost,
>                          1,
>                          vmstate_designware_pcie_root,
>                          DesignwarePCIERoot),
> +        VMSTATE_UINT32(atu_viewport, DesignwarePCIEHost),
> +        VMSTATE_STRUCT_2DARRAY(viewports,
> +                               DesignwarePCIEHost,
> +                               2,
> +                               DESIGNWARE_PCIE_NUM_VIEWPORTS,
> +                               1,
> +                               vmstate_designware_pcie_viewport,
> +                               DesignwarePCIEViewport),
>           VMSTATE_END_OF_LIST()
>       }
>   };
> 

