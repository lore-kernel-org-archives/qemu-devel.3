Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C025C5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 08:16:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riVOl-0005gi-Kt; Fri, 08 Mar 2024 03:16:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1riVOg-0005Q4-MC
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 03:16:08 -0500
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1riVOe-00073F-Uk
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 03:16:06 -0500
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a4499ef8b5aso57616466b.0
 for <qemu-devel@nongnu.org>; Fri, 08 Mar 2024 00:16:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709885762; x=1710490562; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5LiI9/4gghPHeFZa6fXXBrZY3I/kGF66gogKcNOXDC4=;
 b=gcK/kIhlef+shEiC29bf4PDcaT1waXJXC2UXhHiUN9E1VkCMtqwbjRdyENKbHsui2C
 yrYSY2YyeJBMsWUikmXp4lf/HLlo1vRuy3B/LYsOCMIChWgOkZXwQGPAMu6JpXuLxJpT
 81ZFDRHp6SKheTVueE0L7hNZWVp8ImpEUawS27CKwqpCqLPs8XuIqthZdpvEVS4LIVzn
 94SH9DPL88wxzFPj3YXIPsUy0LLdIPiqXATKtXa8C7i5ts1YA990hi9qLFKwu1PNwLom
 aLQmahVah3wOFxLvYKeX3fFVyKz5Pur0H0QHpQ+ztManPuc1rw1/6AHbF1x6FCEMTukS
 YKDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709885762; x=1710490562;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5LiI9/4gghPHeFZa6fXXBrZY3I/kGF66gogKcNOXDC4=;
 b=epVF1bcNsxOTd2jgNaV+aZkk+bB8E30UIhDiBN+FSzEyKjzPlypAbwdJhseHd0tV0a
 yBqBhKV52dMNafKcM46ECNXJaYsG/upObXwYNrDsdQLJ+K3/VY1HbUoA6jQauqgWbyed
 wqY7xSC5qme04Nk3iFjdrthxEu71MH/QD0xqYEPL1u9Ts4Qx8hXLQ5w94xb9havP5HDx
 DWhytu4C+df8gpTPhUT4Qc6WD4d6AGS1TAC35Ci3SpwcF6sXbwREXnm8p9Att/YIrRys
 F9qdqVdueTwvx5A/7B7HMQznUH0M9Z7h32cqVjiNFEn4vR+7k9POO1TjmJfwyRrMuKwV
 VEkA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWlT6zc9AcNe/kHAy58cfCdxIjBovKEX4hSz5wnetk7HaFXs5oNpqk4wYWnxKTGKtxHFBVyDTDnKmimsaQRG1oZs8k6qJ0=
X-Gm-Message-State: AOJu0YxrbfWec4bEdlWMHmAMTNNS7LkpbQRtB6p5PIxb8n8fHH7rKViw
 13kep/OpPrKDHxG94U/2GlTkxgvxKhTfX5+SKWk//wh8cZIOnutZ/Y0Ob7baSqo=
X-Google-Smtp-Source: AGHT+IE3kF8pbmtbRi14XQGD3gC83Pm09uKzn6Ivs8fHzlNb36IcBI4MF1iLwoBVG/FEguuGEmcQkA==
X-Received: by 2002:a17:906:3c10:b0:a43:c0f7:d2cd with SMTP id
 h16-20020a1709063c1000b00a43c0f7d2cdmr13489592ejg.3.1709885762525; 
 Fri, 08 Mar 2024 00:16:02 -0800 (PST)
Received: from [192.168.69.100] (pir44-h02-176-184-37-132.dsl.sta.abo.bbox.fr.
 [176.184.37.132]) by smtp.gmail.com with ESMTPSA id
 z11-20020a05600c0a0b00b00412f428aedasm5163173wmp.46.2024.03.08.00.16.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 Mar 2024 00:16:02 -0800 (PST)
Message-ID: <b6dac65f-4ded-466e-9da8-7d2564d14ef9@linaro.org>
Date: Fri, 8 Mar 2024 09:16:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hmp: Add option to info qtree to omit details
Content-Language: en-US
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost
 <eduardo@habkost.net>, "Dr. David Alan Gilbert" <dave@treblig.org>,
 berrange@redhat.com
References: <20240307183812.0105D4E6004@zero.eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240307183812.0105D4E6004@zero.eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62c.google.com
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

On 1/3/24 19:01, BALATON Zoltan wrote:
> The output of info qtree monitor command is very long. Add an option
> to print a brief overview omitting all the details.
> 
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> Reviewed-by: Dr. David Alan Gilbert <dave@treblig.org>
> ---
> v2:
> - Change the variable name to deails too
> - Add braces to if (checkpatch did not warn for this so just noticed)
> 
>   hmp-commands-info.hx  |  6 +++---
>   system/qdev-monitor.c | 27 +++++++++++++++------------
>   2 files changed, 18 insertions(+), 15 deletions(-)

Thanks, patch queued.

