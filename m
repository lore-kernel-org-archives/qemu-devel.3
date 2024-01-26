Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1FADC47422
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jan 2024 15:49:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTORU-0003pS-6h; Fri, 26 Jan 2024 10:48:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rTORP-0003oi-1b
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 10:48:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rTORN-0001Pj-DS
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 10:48:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706284104;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=acPOsyveWHQ8a/iWNOcBVxzaDethCk84WFQfb8l/wQc=;
 b=Te9MxGSWyhKa7ZJq9/Y9AX7ikpiDM4govnQOvZG23h8ETPPJUOCScA+8oizclSq6mvwcjQ
 3tLl6EOHA307dsIpEn+2ZtS8X4ucIB5l/yNL64ib1tGF+Q8QFBOHTSVdQHdUUsi+yx19Pn
 +O+UCLkV0jJ696IFyA5ZeOpCqfSoi+s=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-197-EArpaBDjOtC8s8JKfvFR4w-1; Fri, 26 Jan 2024 10:48:22 -0500
X-MC-Unique: EArpaBDjOtC8s8JKfvFR4w-1
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-7816bea8d28so377964085a.0
 for <qemu-devel@nongnu.org>; Fri, 26 Jan 2024 07:48:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706284102; x=1706888902;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=acPOsyveWHQ8a/iWNOcBVxzaDethCk84WFQfb8l/wQc=;
 b=q6FW92q1F63f6Ffh27X4EpazaMum7wVwBX5yz+6Q2Qfe1+sJUYo5N9pJ8B321mltJa
 kXfbig5VQpp4Z6opt+Ml+T74A/ZrvA0+CegxxxWrcLBL/3e5r3KbV43C9dX5XNvmBnE/
 eeTgktlQndzIU+2iwFMQBm7J4iBt5NGtZ8ZwXKKhrxLqrSXs95JuosKg2wXT21njd4FR
 KOBK+IRvgBVvaw+F56awPXFmUmPibhtLJmuIr9n952sz4SuzKiTSM+lTOXYNVjnCOqRu
 5z+sjE7bcgTdASAsqE0gYlFdQI3iVBeLS7T8GuMBh61wGBZBUXzjNwMJniaFM9Sk/sT+
 Y51Q==
X-Gm-Message-State: AOJu0Yyn1BnW/tdC84ba+0ZGOfFoyHtzsv6nDegSP5Q1HW0OGxpWw7XP
 GPngsN3Ox8+gTk2Dnem9X8Jl5GD1OYEj5iKSbjNDMDqwXYhbFrzMkJAG4RrQ3G4huoBb3HcHEGt
 NUo3CWV3SDDyFVdt/rokWk1YZ3163SJk9cMtMUZO2RIvokHISAOSU
X-Received: by 2002:a05:620a:6221:b0:783:4bfe:b0e6 with SMTP id
 ou33-20020a05620a622100b007834bfeb0e6mr39020qkn.38.1706284102393; 
 Fri, 26 Jan 2024 07:48:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG3gBRwxmQTwTna7evmSfJ3Wy4ejDBAYohzmr6RdR8rpkZLIS9T3+RzJ/YJliio+Ks6/BQJuA==
X-Received: by 2002:a05:620a:6221:b0:783:4bfe:b0e6 with SMTP id
 ou33-20020a05620a622100b007834bfeb0e6mr39005qkn.38.1706284102155; 
 Fri, 26 Jan 2024 07:48:22 -0800 (PST)
Received: from [192.168.0.9] (ip-109-43-176-119.web.vodafone.de.
 [109.43.176.119]) by smtp.gmail.com with ESMTPSA id
 a23-20020a05620a067700b007838362da2dsm670485qkh.111.2024.01.26.07.48.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Jan 2024 07:48:21 -0800 (PST)
Message-ID: <3ccbe579-06d0-4da0-80fa-d989eac7809b@redhat.com>
Date: Fri, 26 Jan 2024 16:48:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 27/46] hw/arm/highbank: use qemu_create_nic_device()
Content-Language: en-US
To: David Woodhouse <dwmw2@infradead.org>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Rob Herring <robh@kernel.org>
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Jason Wang <jasowang@redhat.com>, qemu-arm@nongnu.org,
 David Woodhouse <dwmw@amazon.co.uk>
References: <20240108204909.564514-1-dwmw2@infradead.org>
 <20240108204909.564514-28-dwmw2@infradead.org>
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20240108204909.564514-28-dwmw2@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.313,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 08/01/2024 21.26, David Woodhouse wrote:
> From: David Woodhouse <dwmw@amazon.co.uk>
> 
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> ---
>   hw/arm/highbank.c | 12 +++++-------
>   1 file changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/hw/arm/highbank.c b/hw/arm/highbank.c
> index c21e18d08f..6a0e20e58d 100644
> --- a/hw/arm/highbank.c
> +++ b/hw/arm/highbank.c
> @@ -296,19 +296,17 @@ static void calxeda_init(MachineState *machine, enum cxmachines machine_id)
>   
>       sysbus_create_simple(TYPE_SYSBUS_AHCI, 0xffe08000, pic[83]);
>   
> -    if (nd_table[0].used) {
> -        qemu_check_nic_model(&nd_table[0], "xgmac");
> -        dev = qdev_new("xgmac");
> -        qdev_set_nic_properties(dev, &nd_table[0]);
> +    dev = qemu_create_nic_device("xgmac", true, NULL);
> +    if (dev) {
>           sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
>           sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, 0xfff50000);
>           sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, pic[77]);
>           sysbus_connect_irq(SYS_BUS_DEVICE(dev), 1, pic[78]);
>           sysbus_connect_irq(SYS_BUS_DEVICE(dev), 2, pic[79]);
> +    }
>   
> -        qemu_check_nic_model(&nd_table[1], "xgmac");
> -        dev = qdev_new("xgmac");
> -        qdev_set_nic_properties(dev, &nd_table[1]);
> +    dev = qemu_create_nic_device("xgmac", true, NULL);
> +    if (dev) {
>           sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
>           sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, 0xfff51000);
>           sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, pic[80]);

Reviewed-by: Thomas Huth <thuth@redhat.com>


