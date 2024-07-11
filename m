Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F731C3DA47
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 10:45:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRrIn-0002TP-Fd; Thu, 11 Jul 2024 06:45:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1sRrIl-0002Rp-Ra
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 06:45:27 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1sRrIW-0002Gr-4R
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 06:45:27 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-57d05e0017aso995283a12.1
 for <qemu-devel@nongnu.org>; Thu, 11 Jul 2024 03:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720694707; x=1721299507; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:organization:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=UE/NP7N7sANvA9P+/e+vpBsvbUNFhs3RSO6Z6KkMYOM=;
 b=bwkgtAi41oo8o+JGiAG02QCBbhI/iQnZbWfPvz1KGD8dCdY1JADndb41NDsQfF+tbD
 7dRu4vRh0evjxKfl+IEoTwffkmTRMu9fnaSca4Mfpos2C3Zv1clgiXCdZWawatC1DiQ7
 ExyGirRROOmjJAoy+huZ/ZybozW6eS9uZL216He1orRyMJ6Uv8cxKDYsVJTIzDRaKhB+
 Tma3hrF8jixA+E46S+wr44jKuUSDRJoAegGNU6UW1F4Cf1NdT7Hf1A+TRmjWq9F0yqNL
 mZMp1YrO5AoNuxgwTs6/4B98L4X9bm6lDtrN9ScTBxLHxRBpKKq6qPgAkoasUvaK6bsX
 vDag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720694707; x=1721299507;
 h=content-transfer-encoding:in-reply-to:organization:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UE/NP7N7sANvA9P+/e+vpBsvbUNFhs3RSO6Z6KkMYOM=;
 b=HlTKReAPKgyqKyy5tjw7PYORbsvsl+VFe2a1V+gWNiikyVlDY8O8xxH7i7iMvYScyh
 4AyLPhgmUsWM35wQHaqTjzYbvfM9JemYpPLG7LAR5IgBa7d6ggVFwRP4fuv4FVUce82r
 kzw9UuLcEIWkE2p1WXHNmqIuDJc1VpvYUeUm2KfYM2U9J1TMbwcrH3dI/yWZ2O0LPaxZ
 /S7sLYC0in6mPJgccnVhJ4MkFXY5jITNrOM1RwBqHGdXByOScBliE9oat35L3yG4LRHF
 36J42hb1BTIYGRmcDwR03HL7Vy1+qJ1vxud0QTlGhnRikDxRkp9g7k+zDmHxhId1zxgi
 eLnw==
X-Gm-Message-State: AOJu0Yw3VzcAyeA7ejb2j1LiamdMV+Y0vBiYHW+lFDrHgpFDttMZYvdo
 UUaNPf0hujmHkGVZMtK1Abk3VXDL/B8FSskYeW4LLRmsgLoVk/M1Aewbgu3g8PV7qwKRNDcDeod
 dBK8=
X-Google-Smtp-Source: AGHT+IGO406bvmu4e39W4V05oWJQmjQQgt5Wa0BIe4XKgx7tw9zPez2YwgO/GZPJijBSh5yKB4HcYw==
X-Received: by 2002:aa7:c307:0:b0:57d:1e27:65ea with SMTP id
 4fb4d7f45d1cf-594bb869e59mr4914748a12.34.1720694707259; 
 Thu, 11 Jul 2024 03:45:07 -0700 (PDT)
Received: from [192.168.200.25] (83.8.74.165.ipv4.supernova.orange.pl.
 [83.8.74.165]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-594bc3efb13sm3310266a12.42.2024.07.11.03.45.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Jul 2024 03:45:06 -0700 (PDT)
Message-ID: <52707dcf-7f34-4573-b713-2d0f834d7f46@linaro.org>
Date: Thu, 11 Jul 2024 12:45:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] target/arm: calculate cache sizes properly
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <20240710173512.424547-1-marcin.juszkiewicz@linaro.org>
 <CAFEAcA-q8uUzHaF1KazB7uuhgpbtrTKdL153Btzwnz6pvuOPWA@mail.gmail.com>
From: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Content-Language: pl-PL, en-GB, en-HK
Organization: Linaro
In-Reply-To: <CAFEAcA-q8uUzHaF1KazB7uuhgpbtrTKdL153Btzwnz6pvuOPWA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=marcin.juszkiewicz@linaro.org; helo=mail-ed1-x535.google.com
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

On 11.07.2024 12:19, Peter Maydell wrote:
> On Wed, 10 Jul 2024 at 18:35, Marcin Juszkiewicz
> <marcin.juszkiewicz@linaro.org> wrote:
>>
>> Neoverse-V1 TRM says that NumSets are [27:13] not :32 like in code.
> 
> NumSets in fields [27:13] is the 32-bit CCSIDR_EL1 format
> (i.e. what you have when FEAT_CCIDX is not implemented).
> The make_ccsidr64() function provides the 64-bit CCSIDR_EL1
> format (i.e. the one when FEAT_CCIDX is implemented).
> 
> I would suspect this is an accidental error in the Neoverse-V1
> TRM -- if you have access to the real hardware and can dump
> the CCSIDR_EL1 value I would expect you'll see it matches
> what QEMU is implementing here (and that ID_AA64MMFR2_EL1.CCIDX
> also says that FEAT_CCIDX is implemented). See also the comment
> "The Neoverse-V1 r1p2 TRM lists 32-bit format CCSIDR_EL1 values"
> in aarch64_neoverse_v1_initfn() where we document that we
> don't trust what the TRM is saying here.
> 
> How did you run into this? Is there some guest software
> which is assuming the old 32-bit format and not checking
> ID_AA64MMFR2_EL1.CCIDX to see if it needs to use the new one?

I started adding cpu cache info into PPTT and so far the only code I 
used was old 32-bit format one:

https://openfw.io/edk2-devel/20240710-acpi65-v4-6-bc32224e4be4@linaro.org/


Will check for CCIDX and adapt proper way. But that has to wait for 
August due to vacation plans.

