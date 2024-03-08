Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EB44C5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 08:08:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riVHK-00060A-1O; Fri, 08 Mar 2024 03:08:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1riVHF-0005zB-KN
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 03:08:26 -0500
Received: from mail-oi1-x22a.google.com ([2607:f8b0:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1riVHC-0004pd-1I
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 03:08:24 -0500
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-3c19b7d9de7so1035837b6e.2
 for <qemu-devel@nongnu.org>; Fri, 08 Mar 2024 00:08:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709885293; x=1710490093; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ar3p53HMsIx8zBL94B0eF4lW4BnIQ4joZmAkoo/PXiE=;
 b=dSn2ZDxdWXKz4HvedQdX8bbNiex/ASQG+yuU/Ug5j5Jj6VJovHw+XvVf6tiA+emzMD
 CSi2l3U8zwSmSMz9gSxCoGmGILMP+U3b1vk7STQ0dVg1tAZoBJkxSSHY96QY9A/0QX9p
 p2TF2fqNN0Sh2BV6GJ3pTYX6Nypdrh5DjaCNCc9EQ/CGUDqbUQJKp9cM33cM+IfO97Ia
 jJSLApKHwidC6+S+SAvoONUvZrVg43dUtIr6VWidDoh5EH/tlc87eRmBqeBppED8dbLe
 7uYbiHqNJZN/f7K0jEBhNSIeTKIH4XmtdYMDnXX0p5/ZO/+ta/7YSihrKOvgmzUvFpC4
 XM+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709885293; x=1710490093;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ar3p53HMsIx8zBL94B0eF4lW4BnIQ4joZmAkoo/PXiE=;
 b=ZpQRoucEszjKgEvhztjnnvIUU1Jk9cdNdSykH+rtT6acMqUE5W0hrZEHV5qW5+33sk
 5mrV3PL4xWYPA9zq20xB9f1d9Ck9A0OOtiIzzqfl6nk9QgdP0lahO9iuiC6Hqn+sCWL/
 ICA1Q1+CKAK8k9RT+y7KH92WTY7Nd4bq2RrjHA/GY/EXAgwGUe5V3OcSy5hrbFg05MpN
 zRHHOVUhDstZm0hkwo+L+pQxHVutqXlnb7klEZ6S6IGNzFmJGKd/YBczJ2AhkMYLOPRf
 +QQuLYnDL3Oa4oq+/pT5x0emqI7131IiqqjPCUqOmXc021x2IIy0NPrrGCzIBXuFT9Qe
 d5BQ==
X-Gm-Message-State: AOJu0YxdtxA+KOeXe1Vamrrjl6azIbojN/zsBGtGwXoMuLJkVO3TKqi6
 c74d41erzygL2Y2I9PXICHB3IXTA8oPKGtBsDzH3Et45qPGtquBcY9XqpXOHal8=
X-Google-Smtp-Source: AGHT+IGWZiC0Ct8tCDDzdCvzueg8OeBB8V4/2g1o1vl39cnKx6iJ5YHfjcOF74P9tVS7tlJpcFAv0A==
X-Received: by 2002:a05:6808:1d2:b0:3c2:16db:e955 with SMTP id
 x18-20020a05680801d200b003c216dbe955mr8613483oic.48.1709885292792; 
 Fri, 08 Mar 2024 00:08:12 -0800 (PST)
Received: from [192.168.69.100] (pir44-h02-176-184-37-132.dsl.sta.abo.bbox.fr.
 [176.184.37.132]) by smtp.gmail.com with ESMTPSA id
 lp14-20020a056a003d4e00b006e5eb3cba7asm10563659pfb.96.2024.03.08.00.08.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 Mar 2024 00:08:12 -0800 (PST)
Message-ID: <6be774d0-6277-4d50-b97b-a0177cad8fd8@linaro.org>
Date: Fri, 8 Mar 2024 09:08:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 4/5] hw/i386/q35: Wire virtual SMI# lines to ICH9
 chipset
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, Zhao Liu <zhao1.liu@intel.com>
Cc: qemu-devel@nongnu.org, "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Anton Johansson <anjo@rev.ng>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ani Sinha <anisinha@redhat.com>, Bernhard Beschow <shentey@gmail.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Laszlo Ersek <lersek@redhat.com>
References: <20240226164913.94077-1-philmd@linaro.org>
 <20240226164913.94077-5-philmd@linaro.org> <Zd9iz9aIwM3cOqwt@intel.com>
 <5a42a295-bb1e-49f6-ae1d-94aec1efb61c@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <5a42a295-bb1e-49f6-ae1d-94aec1efb61c@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22a;
 envelope-from=philmd@linaro.org; helo=mail-oi1-x22a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 7/3/24 20:43, Thomas Huth wrote:
> On 28/02/2024 17.43, Zhao Liu wrote:
>> Hi Philippe,
>>
>>> +/*
>>> + * Real ICH9 contains a single SMI output line and doesn't broadcast 
>>> CPUs.
>>> + * Virtualized ICH9 allows broadcasting upon negatiation with guest, 
>>> see
>>> + * commit 5ce45c7a2b.
>>> + */
>>> +enum {
>>> +    ICH9_VIRT_SMI_BROADCAST,
>>> +    ICH9_VIRT_SMI_CURRENT,
>>> +#define ICH9_VIRT_SMI_COUNT 2
>>> +};
>>> +
>>
>> Just quick look here. Shouldn't ICH9_VIRT_SMI_COUNT be defined outside of
>> enum {}?
> 
> Or even better, do it without a #define:
> 
> enum {
>      ICH9_VIRT_SMI_BROADCAST,
>      ICH9_VIRT_SMI_CURRENT,
>      ICH9_VIRT_SMI_COUNT

This form isn't recommended as it confuses static analyzers,
considering ICH9_VIRT_SMI_COUNT as part of the enum.

> };
> 
>   Thomas
> 


