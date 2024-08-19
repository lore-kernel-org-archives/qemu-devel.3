Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 078F0C3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2024 04:27:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sftzH-0002ZQ-7u; Mon, 19 Aug 2024 00:27:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1sftuS-0005fW-Rr
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 00:22:26 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1sftuP-0004L5-HS
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 00:22:24 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1fee6435a34so24103955ad.0
 for <qemu-devel@nongnu.org>; Sun, 18 Aug 2024 21:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724041340; x=1724646140; darn=nongnu.org;
 h=content-transfer-encoding:content-language:in-reply-to:mime-version
 :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MhVjxKzlb1gPaM8MhyonnypDmhA1TCk3CvzcoD1WOGQ=;
 b=ctcRIuftkuMc9a73lKw4l3HcDHcxB39RPQhJ5njDd7aKDQsAqSw4QcThczNl2oDSfc
 uhIxvRcr5R0Ru+Nr+Gncvfrplgu57IYCXgz+9UETlMF3S0Gfy+FXf0odYsD3qMIXST4Y
 fdCSSskqlGjSfjuzHJ3GKD/nXoLFAt+YGkHo3H5kZ2YCX1YzIARwRZZJpmOFI8PvfSPC
 7OE8stYZDf8pPeJGXlHC0UdvwKtQ7zArGp88bcHWK5LVdFQktA3gkDEGNFmajO7t1N92
 ZuaoaUjEcWU3ZW49t+6HBFDDAAarwh+vI2ICc3+ojc04rav0WeZSxN8kQzRCJA26OBAb
 lWWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724041340; x=1724646140;
 h=content-transfer-encoding:content-language:in-reply-to:mime-version
 :user-agent:date:message-id:from:references:cc:to:subject
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MhVjxKzlb1gPaM8MhyonnypDmhA1TCk3CvzcoD1WOGQ=;
 b=pguYqWu0UmNpNWHZ4ImpQuG32EGbX+v2DaUsVjvQfAOmEg/82cVtdt0apbf9LGJq0Q
 Zxt6Fqv+Tx2kQhUiN/0vFqOpgtcb6BM6Ve2QZyLexVnIrY1SCFjryH3488iBA6KM6s4b
 nXA5yPLqW7FzVdicpSWJOliuENPHI84dWyn8x/j2E7NNoetjWFjvwbkX27XE/BRlo2FG
 Vj6LW7Vf+JnJJKR16Ero6QS229yw2LuVXhWVNmisuNsPliYy0vkRVo01uszK8grdmghV
 QJ66hsn3A8Z0ie51xdh/Edn0x40axdTqbV0ateEu2qDiQVykMvP/ewGh7aFRIyYeFgmJ
 0q4w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXEpE/MXE84AnIfsBj5wFBYbJxuXw8ONaI8Eu0cxL4idAhjM5cgEElK3mL4ziYcFV4YOZCeVB8p/m3HoFl76rlRQmQnRlU=
X-Gm-Message-State: AOJu0YyURw5uyEY5ohFCi5HbVqWieonx6zqe6zUZyE9jhJxxgeiqhyB4
 nfnUwPe2ZtFWzacMtidZ8jecweHSnXDVV2Sf4MJ58MYv0HnThoMcsrEF78u/9XI=
X-Google-Smtp-Source: AGHT+IE1C4U9w1NdIb2cQY3hu2h9LEHPkdW8Us72pIqEzN4ERGq6HyINNt8TJ8faLr7ZJ5F0IY7hiA==
X-Received: by 2002:a17:902:d4cb:b0:202:3617:d546 with SMTP id
 d9443c01a7336-2023617d843mr24060185ad.62.1724041339909; 
 Sun, 18 Aug 2024 21:22:19 -0700 (PDT)
Received: from [192.168.0.103] ([191.205.40.123])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20205a53767sm43743635ad.270.2024.08.18.21.22.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 18 Aug 2024 21:22:19 -0700 (PDT)
Subject: Re: [PATCH 4/8] hw/pci-host/designware: Hoist host controller in root
 function #0
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20231012121857.31873-1-philmd@linaro.org>
 <20231012121857.31873-5-philmd@linaro.org>
From: Gustavo Romero <gustavo.romero@linaro.org>
Message-ID: <f9299dfa-6e1a-b0cc-5b13-a8838351ea21@linaro.org>
Date: Mon, 19 Aug 2024 01:22:15 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20231012121857.31873-5-philmd@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pl1-x634.google.com
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

I think the title of this patch is bit misleading. You're not
moving host into root, but rather adding a reference of host
inside the root.

Maybe change it to something like:

  "Add a back-pointer to the host in the root"?


On 10/12/23 9:18 AM, Philippe Mathieu-Daudé wrote:
> There is always an unique root function for the host bridge
> controller. We create this function when the controller is
> realized, in designware_pcie_host_realize().
> 
> No need to call qdev_get_parent_bus() each time the root function
> want to resolve its host part. Hoist a pointer in its state. Set
> the pointer once when the function is realized.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/hw/pci-host/designware.h |  1 +
>   hw/pci-host/designware.c         | 15 +++++----------
>   2 files changed, 6 insertions(+), 10 deletions(-)
> 
> diff --git a/include/hw/pci-host/designware.h b/include/hw/pci-host/designware.h
> index c484e377a8..9e2caa04e9 100644
> --- a/include/hw/pci-host/designware.h
> +++ b/include/hw/pci-host/designware.h
> @@ -71,6 +71,7 @@ struct DesignwarePCIERoot {
>   
>       DesignwarePCIEViewport viewports[2][DESIGNWARE_PCIE_NUM_VIEWPORTS];
>       DesignwarePCIEMSI msi;
> +    DesignwarePCIEHost *host;

Because root is still defined in host and you're actually adding a
reference of host inside root this is a back-pointer to host, so do
you mind adding a comment above this like saying something like:

/* Convenient back-pointer for easy access to the host interface. */

Otherwise:

Reviewed-by: Gustavo Romero <gustavo.romero@linaro.org>


Cheers,
Gustavo


>   };
>   
>   struct DesignwarePCIEHost {
> diff --git a/hw/pci-host/designware.c b/hw/pci-host/designware.c
> index bacb2bdb2d..fb46493a05 100644
> --- a/hw/pci-host/designware.c
> +++ b/hw/pci-host/designware.c
> @@ -57,13 +57,6 @@
>   
>   #define DESIGNWARE_PCIE_IRQ_MSI                    3
>   
> -static DesignwarePCIEHost *
> -designware_pcie_root_to_host(DesignwarePCIERoot *root)
> -{
> -    BusState *bus = qdev_get_parent_bus(DEVICE(root));
> -    return DESIGNWARE_PCIE_HOST(bus->parent);
> -}
> -
>   static uint64_t designware_pcie_root_msi_read(void *opaque, hwaddr addr,
>                                                 unsigned size)
>   {
> @@ -85,7 +78,7 @@ static void designware_pcie_root_msi_write(void *opaque, hwaddr addr,
>                                              uint64_t val, unsigned len)
>   {
>       DesignwarePCIERoot *root = DESIGNWARE_PCIE_ROOT(opaque);
> -    DesignwarePCIEHost *host = designware_pcie_root_to_host(root);
> +    DesignwarePCIEHost *host = root->host;
>   
>       root->msi.intr[0].status |= BIT(val) & root->msi.intr[0].enable;
>   
> @@ -300,7 +293,7 @@ static void designware_pcie_root_config_write(PCIDevice *d, uint32_t address,
>                                                 uint32_t val, int len)
>   {
>       DesignwarePCIERoot *root = DESIGNWARE_PCIE_ROOT(d);
> -    DesignwarePCIEHost *host = designware_pcie_root_to_host(root);
> +    DesignwarePCIEHost *host = root->host;
>       DesignwarePCIEViewport *viewport =
>           designware_pcie_root_get_current_viewport(root);
>   
> @@ -392,7 +385,8 @@ static char *designware_pcie_viewport_name(const char *direction,
>   static void designware_pcie_root_realize(PCIDevice *dev, Error **errp)
>   {
>       DesignwarePCIERoot *root = DESIGNWARE_PCIE_ROOT(dev);
> -    DesignwarePCIEHost *host = designware_pcie_root_to_host(root);
> +    DesignwarePCIEHost *host = DESIGNWARE_PCIE_HOST(
> +                                    qdev_get_parent_bus(DEVICE(dev))->parent);
>       MemoryRegion *host_mem = get_system_memory();
>       MemoryRegion *address_space = &host->pci.memory;
>       PCIBridge *br = PCI_BRIDGE(dev);
> @@ -406,6 +400,7 @@ static void designware_pcie_root_realize(PCIDevice *dev, Error **errp)
>       size_t i;
>   
>       br->bus_name  = "dw-pcie";
> +    root->host = host;
>   
>       pci_set_word(dev->config + PCI_COMMAND,
>                    PCI_COMMAND_MEMORY | PCI_COMMAND_MASTER);
> 



