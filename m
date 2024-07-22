Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE3B1C3DA59
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 14:29:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVu2N-0007p8-F2; Mon, 22 Jul 2024 10:29:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sVu2L-0007oa-RC
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 10:29:13 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sVu2K-0005SG-2o
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 10:29:13 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4266b1f1b21so32719975e9.1
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 07:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721658550; x=1722263350; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4EGE6XShqi0/nfJLO/MS/xopgU6PUeNaRRk82ZPR41Q=;
 b=uhdSDeqt+RhTZP7Dk6NRPuh6AUq2uJ02Te+BNX2AbR8za7aeuYabSoBaVZfn5CvjHl
 hCEvIKoH8AC0Pkzdw0DbkuLWhFb/fYFXnv/1kLEv4A73QGXNffvTfaGdjDRwiCtwuKXn
 6Q4Ry6kLo31pIS7siV7eb8VIeKfgcPCOixxeT9PXz8Tpwtivzhi22WuJK+OCzShrniyx
 6zFCKlyE4R/qyPZL9tsg6LLbe9GNHJB+sS2/m26IslKBAEKS7851Ux2FTVB2T4XhReiQ
 VomBefUj1+knyu9Dj4uIavmh7uX2AO3L7M+ClIVJqioKMEiIbeGLo7VT75MwFPQBhRoz
 cLAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721658550; x=1722263350;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4EGE6XShqi0/nfJLO/MS/xopgU6PUeNaRRk82ZPR41Q=;
 b=c7tLyPl+8ds7jvvGi9gF3drdkUOzc3SBfkY99tGGkw6a3CMKhUzzY6LxAduWJ0JjQi
 ni6ttXpRdskA4MlKoZoOZoI84u1KnBFGlVjU+HFVyn2oyDWECAss4e4lTHbXwfUcbMlD
 jYG53V+u8xP0iXo9lrMb5oFuL68+/9f4532bJDfQnfUH3w++OCeI4CWRu/R+mL89aUhQ
 frq9GTnCJaYxPjwfeWvQuyK05ouK2zZt1MW7kxCtV8t6JLlm+WHMOoTlf8QQa3C29mbp
 3I/9X1cGO+C48CBe3kZHuKZobOlaia4WhkrztKPJdekWuNS47fHDw749686a5x1H1rEh
 S89w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXtUuPcmDXWzpABoTsW/Vn87Vzjc9hK3UhxpYQeSqwJB+uUOxqPFRxn9U9Tg0aAbuKaIv5ikSB1TGgC0kTJJ9+mtUgAnT4=
X-Gm-Message-State: AOJu0Yz2ZNufC22RptvQgRWRqiC0ZGtwtNGLV3D1Pv3ael2Rex7qU1oJ
 /3u9642QU3pbyFBT4yFNMKYVJNp1ILqga4Ar8BMYXYUni1bRZGalJbAbPNzvdig=
X-Google-Smtp-Source: AGHT+IEsNerB4pUlLzcDbayfNDZhx7veJcRZMAaHHhxfnF7uZgMjCx7A0bR9UeIDaPzwMm0JSU+D+A==
X-Received: by 2002:a05:600c:4e47:b0:426:6e8b:3dc5 with SMTP id
 5b1f17b1804b1-427dc56753emr54702105e9.32.1721658550311; 
 Mon, 22 Jul 2024 07:29:10 -0700 (PDT)
Received: from [192.168.69.100] (gen92-h02-176-184-20-254.dsl.sta.abo.bbox.fr.
 [176.184.20.254]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d8e68ba0sm121498795e9.21.2024.07.22.07.29.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Jul 2024 07:29:09 -0700 (PDT)
Message-ID: <21bed558-49d2-408d-baaf-97451780c53a@linaro.org>
Date: Mon, 22 Jul 2024 16:29:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] [PATCH] system/memory: Fix max access size
To: Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: TaiseiIto <taisei1212@outlook.jp>, qemu-devel@nongnu.org,
 peterx@redhat.com, david@redhat.com
References: <TY0PR0101MB4285D5A3587179A5788F3356A4AE2@TY0PR0101MB4285.apcprd01.prod.exchangelabs.com>
 <CAFEAcA_vY769Yws9t4WWitsShBK01Oua5zgarTj3YHgUuvpzTw@mail.gmail.com>
 <CABgObfbdXXXbygNn3DbN9Q7xB=kTFTFs5yxFQapSn6SAXdpQZw@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CABgObfbdXXXbygNn3DbN9Q7xB=kTFTFs5yxFQapSn6SAXdpQZw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 22/7/24 13:53, Paolo Bonzini wrote:
> On Sat, Jul 20, 2024 at 4:30 PM Peter Maydell <peter.maydell@linaro.org> wrote:
>> If the HPET timer device is supposed to permit 64 bit writes and it is not
>> doing so, then that needs to be fixed in the HPET timer device model, by
>> making sure that its read/write functions correctly handle the size=8 case
>> and then setting access_size_max =8 in its MemoryRegionOps struct.
> 
> It does, and I've started looking into it[1].
> 
> The replacement for this patch is simple (on top of that branch):
> 
> diff --git a/hw/timer/hpet.c b/hw/timer/hpet.c
> index 5e60fedc089..ac55dd1ebd6 100644
> --- a/hw/timer/hpet.c
> +++ b/hw/timer/hpet.c
> @@ -637,6 +637,10 @@ static const MemoryRegionOps hpet_ram_ops = {
>           .min_access_size = 4,
>           .max_access_size = 8,
>       },
> +    .impl = {
> +        .min_access_size = 4,
> +        .max_access_size = 8,

It seems this model could be simplified using .min_access_size = 8,
letting the core memory layer handle the % 4 byte accesses (the
read path is obvious, the write one a bit less). Nothing urgent,
possibly a BitSizedTask.

> +    },
>       .endianness = DEVICE_NATIVE_ENDIAN,
>   };
> 
> I'll now look into the other patch for interrupts. Thanks for testing
> my changes!
> 
> Paolo
> 
> [1] https://gitlab.com/bonzini/qemu/-/commits/hpet
> 


