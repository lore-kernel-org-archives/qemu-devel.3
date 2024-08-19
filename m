Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 933C4C3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2024 04:28:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sfu0G-0007TB-1x; Mon, 19 Aug 2024 00:28:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1sftuz-0007iA-1w
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 00:22:57 -0400
Received: from mail-oa1-x2f.google.com ([2001:4860:4864:20::2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1sftux-0004Mm-4c
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 00:22:56 -0400
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-2702ed1056bso1483265fac.3
 for <qemu-devel@nongnu.org>; Sun, 18 Aug 2024 21:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724041372; x=1724646172; darn=nongnu.org;
 h=content-transfer-encoding:content-language:in-reply-to:mime-version
 :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YNlpiX6ZjhJonIHprrBdtOd2a6QnQVc8x7RmgqoCj/I=;
 b=faak8httVbp1Pznyn+pX9ONSqHr8DbRjJkVPMAn0xSzyee4hRzZbQ7VMbA/zqSEpxK
 E2t377Q84zGU9F1s2dKrJFywn/gV2pCpVbOwvlBJWL3s6u++dX+8ItY4OGI89nIqCEZT
 qsgPefFl/Yj8pwsqGa4+op2Puf0iNW52/DCVjxUBnjlxMWFf6quTnCi7KMtjBASm9SvX
 Vqu79LSQ+kutz381DZbHADGjuwNrcBqBQ9oumZF16jTcTZXLCZdqrP58FxPsA9Nr1d/c
 p/tcANj1a6/aW9bZuezNlUElqSxwyt96lMr/V9Me4kWU/sjf4flhjeGukRgtV+AE+wjs
 T08Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724041372; x=1724646172;
 h=content-transfer-encoding:content-language:in-reply-to:mime-version
 :user-agent:date:message-id:from:references:cc:to:subject
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YNlpiX6ZjhJonIHprrBdtOd2a6QnQVc8x7RmgqoCj/I=;
 b=takn1/8Aou9j9OUtHAbsx+4nAukM441V/pCRtlchUklLzE6TK6M8kASB+rT2zwMHGz
 N/u2PsAA/nbTnDcmxSUvKipZyLrWtwX9g4/Y8dpeYMorhOwFZFXeNdyPllEjrApAa2qp
 C1SYHk5PMj5Uc0+dTP+HdHJjUeV9iOFF5OE26lv3eU3hc0lMjm1/DrxYpmXHvigK5rip
 lW1CUSCrZoix9UkBxMN4j5wowW8pjaAEL5X++EH3Bz5SXcBMNKr45vf7LzfH+xPpZImj
 wVyYngk0GtyPgDGtcyvgDpSMwlK9tFnAZGpFaxnq5yg/I6A4IvnsW9RlWKvPXnyZinVd
 WELw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVf6FfO0MB9joLhqqyRoQR/oVxaJrh3RI7s9+TaIN0vJkVRRhcy7WYav21FpheUvAN8uZha77a2XJD40A/Ua3itBzFm7o0=
X-Gm-Message-State: AOJu0YxEFrVUnwusvexHhRGuq9jpp70nCxXWPyrnNbK4x07R+e83PAac
 6GgGO4d2NTR8cibXQBTUXGWtqSC2wkW489Ec/OmUOB50Rth4o1xT+FF5wy45awc=
X-Google-Smtp-Source: AGHT+IHHqztJoSsF/4Bun+MTB3I6lsRAbu+IK7ae6YNv+UZtN9RznZXk/Mrh0C1uKABYTqZHUHZf6g==
X-Received: by 2002:a05:6870:a489:b0:250:7465:d221 with SMTP id
 586e51a60fabf-2701c3f73b9mr11020910fac.28.1724041372106; 
 Sun, 18 Aug 2024 21:22:52 -0700 (PDT)
Received: from [192.168.0.103] ([191.205.40.123])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7127ae0f466sm5848580b3a.53.2024.08.18.21.22.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 18 Aug 2024 21:22:51 -0700 (PDT)
Subject: Re: [PATCH 5/8] hw/pci-host/designware: Keep host reference in
 DesignwarePCIEViewport
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20231012121857.31873-1-philmd@linaro.org>
 <20231012121857.31873-6-philmd@linaro.org>
From: Gustavo Romero <gustavo.romero@linaro.org>
Message-ID: <dc7de9ff-5add-fb1f-a1b1-5c4db7d4e5e1@linaro.org>
Date: Mon, 19 Aug 2024 01:22:48 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20231012121857.31873-6-philmd@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2f;
 envelope-from=gustavo.romero@linaro.org; helo=mail-oa1-x2f.google.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.588,
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

Hi Phil,

I think the title of this patch is also a bit misleading.
The host reference is not present only in DesigwarePCIEViewport,
it's also present, for instance, in DesignwarePCIERoot after the
previous patch. This is also a back-pointer to host, so how about
something like:

"Add a back-pointer to the host in viewport"

Anyways,

Reviewed-by: Gustavo Romero <gustavo.romero@linaro.org>


Cheers,
Gustavo


On 10/12/23 9:18 AM, Philippe Mathieu-Daudé wrote:
> The PCI root function is irrelevant for the ViewPort; only
> a reference to the host bridge is required. Since we can
> directly access the PCI bus, remove the pci_get_bus() call.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/hw/pci-host/designware.h | 2 +-
>   hw/pci-host/designware.c         | 7 +++----
>   2 files changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/include/hw/pci-host/designware.h b/include/hw/pci-host/designware.h
> index 9e2caa04e9..e1952ad324 100644
> --- a/include/hw/pci-host/designware.h
> +++ b/include/hw/pci-host/designware.h
> @@ -32,7 +32,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(DesignwarePCIEHost, DESIGNWARE_PCIE_HOST)
>   OBJECT_DECLARE_SIMPLE_TYPE(DesignwarePCIERoot, DESIGNWARE_PCIE_ROOT)
>   
>   typedef struct DesignwarePCIEViewport {
> -    DesignwarePCIERoot *root;
> +    DesignwarePCIEHost *host;
>   
>       MemoryRegion cfg;
>       MemoryRegion mem;
> diff --git a/hw/pci-host/designware.c b/hw/pci-host/designware.c
> index fb46493a05..d12a36b628 100644
> --- a/hw/pci-host/designware.c
> +++ b/hw/pci-host/designware.c
> @@ -211,12 +211,11 @@ static uint64_t designware_pcie_root_data_access(void *opaque, hwaddr addr,
>                                                    uint64_t *val, unsigned len)
>   {
>       DesignwarePCIEViewport *viewport = opaque;
> -    DesignwarePCIERoot *root = viewport->root;
> +    PCIHostState *pci = PCI_HOST_BRIDGE(viewport->host);
>   
>       const uint8_t busnum = DESIGNWARE_PCIE_ATU_BUS(viewport->target);
>       const uint8_t devfn  = DESIGNWARE_PCIE_ATU_DEVFN(viewport->target);
> -    PCIBus    *pcibus    = pci_get_bus(PCI_DEVICE(root));
> -    PCIDevice *pcidev    = pci_find_device(pcibus, busnum, devfn);
> +    PCIDevice *pcidev    = pci_find_device(pci->bus, busnum, devfn);
>   
>       if (pcidev) {
>           addr &= pci_config_size(pcidev) - 1;
> @@ -445,7 +444,7 @@ static void designware_pcie_root_realize(PCIDevice *dev, Error **errp)
>           g_free(name);
>   
>           viewport = &root->viewports[DESIGNWARE_PCIE_VIEWPORT_OUTBOUND][i];
> -        viewport->root    = root;
> +        viewport->host    = host;
>           viewport->inbound = false;
>           viewport->base    = 0x0000000000000000ULL;
>           viewport->target  = 0x0000000000000000ULL;
> 

