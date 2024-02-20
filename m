Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51885C48BC3
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 06:33:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcJgL-0004zJ-CE; Tue, 20 Feb 2024 01:32:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rcJgJ-0004yo-IC
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 01:32:43 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rcJg9-000299-5U
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 01:32:43 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-33d6f26ff33so47871f8f.0
 for <qemu-devel@nongnu.org>; Mon, 19 Feb 2024 22:32:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708410750; x=1709015550; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=s6UIOu3zjO2XrlH1atX7urmDboET3znk4tekjypD/SY=;
 b=xy5FTl56h024vWkbJ8P+ezQ7XRPV3ag7p9UctcWF+YReLO2sANs/yj0nPirKQnfadv
 FncBjRpY1AUUyt67ssrAp4x+/MtNSxVnzaIA6ChZ11l9RzYAL6IzByDvBMHLhKO9OcwG
 tgyT8XkJp+Zz9i0ET5D9sdSKne3meJOvOTnlitR5+4RADJPRomw8h377HpNJEbukFGay
 ArTuGmq6HNWxGikpDE5m9IminM5TYpPFcjxgCj4OhRa1PvD9IC/eA2W4B7vEZ+x6nRoU
 qtQ2xDMMHnf37irOzgtjP2B7fflT6vNghiMhoZQJ3AMPsMespVH8zQTNjb9xEXyJz6Ye
 9A7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708410750; x=1709015550;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=s6UIOu3zjO2XrlH1atX7urmDboET3znk4tekjypD/SY=;
 b=lHTFTlxmvNG1WQbboNuVcdZ12qb0kmsXfXxzoMUVuQHhLROpgkfHJSXDVcYjsHCKYa
 Ra4oS2Y0ohBabcA8pTe49hgX+XxhobjLllc/gLxNmrrSI2KpDOp6keFYhjtiZ+I8VdtY
 aTmGg5iDZZsVx13F0/yX+42Ab9CP8J9qXmbX2wFzYi1D5nUuu8a6MLUeb1ROnwdvaB2Q
 LvNAA8SsXa06M/5my/WiX7KNnmQJTG3oFY1XubXRrbHGupTkUU4MVMxV/6V0n0ZBwXbE
 ZHuKfkS2QQrPLBWQi3TNOWQY87vCYlUfekoyGqh8ayLMTYaEhl23GpNYyidupoa9kgFW
 NhOQ==
X-Gm-Message-State: AOJu0YwoAnQQW9DVF+WPiDrzHLeZ1rOVg1suIQY5gjrgdr8/IZsREIjj
 fENoX1Cmji8zfqNKxTD1LRZLKVKtuSu6Wozo3ylH9V5QZ5iMa72Sw1+LgA67qgrkCA8nGx6HMcg
 x
X-Google-Smtp-Source: AGHT+IEEV92ChFQ1BpfOS+1MuV5GQWlhkCLaP9RIcSVaPCCjc+IsjsPz/KRKOFTFIk0yzNMKlzZnNw==
X-Received: by 2002:a05:6000:12d1:b0:33d:3a85:a5a2 with SMTP id
 l17-20020a05600012d100b0033d3a85a5a2mr3835254wrx.21.1708410750192; 
 Mon, 19 Feb 2024 22:32:30 -0800 (PST)
Received: from [192.168.69.100] (mek33-h02-176-184-23-7.dsl.sta.abo.bbox.fr.
 [176.184.23.7]) by smtp.gmail.com with ESMTPSA id
 k5-20020adfe3c5000000b0033b66c2d61esm12221709wrm.48.2024.02.19.22.32.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Feb 2024 22:32:29 -0800 (PST)
Message-ID: <d90dd6b2-92fc-4440-a546-bd3f558a425c@linaro.org>
Date: Tue, 20 Feb 2024 07:32:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/14] hw/acpi/ich9_tco: Restrict ich9_generate_smi()
 declaration
Content-Language: en-US
To: qemu-devel@nongnu.org, Bernhard Beschow <shentey@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>,
 BALATON Zoltan <balaton@eik.bme.hu>
References: <20240219163855.87326-1-philmd@linaro.org>
 <20240219163855.87326-6-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240219163855.87326-6-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 19/2/24 17:38, Philippe Mathieu-Daudé wrote:
> Only files including "hw/acpi/ich9_tco.h" require
> the ich9_generate_smi() declaration.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/hw/acpi/ich9_tco.h    | 1 +
>   include/hw/southbridge/ich9.h | 2 --
>   2 files changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/include/hw/acpi/ich9_tco.h b/include/hw/acpi/ich9_tco.h
> index 1c99781a79..68ee64942f 100644
> --- a/include/hw/acpi/ich9_tco.h
> +++ b/include/hw/acpi/ich9_tco.h
> @@ -76,6 +76,7 @@ typedef struct TCOIORegs {
>   } TCOIORegs;
>   
>   void ich9_acpi_pm_tco_init(TCOIORegs *tr, MemoryRegion *parent);
> +void ich9_generate_smi(void);

Bah it is only used in hw/acpi/ich9_tco.c, I'll declare it
statically there.


