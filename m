Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58FFECD5BB0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 18:54:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQV0e-0000yC-ED; Fri, 22 May 2026 14:54:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wQV0a-0000t5-0X
 for qemu-devel@nongnu.org; Fri, 22 May 2026 14:54:08 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wQV0Y-0007JK-AS
 for qemu-devel@nongnu.org; Fri, 22 May 2026 14:54:07 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2be75f658f3so30881185ad.1
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 11:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779476044; x=1780080844; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=D5kB6tW1Xz66qPBLDXJwf09zq/Q6zRtszTSv2Ldr8jM=;
 b=FJ8ywXptz56QeQqqFeRdPwpPmpxXanb54D76YAhe3fyme4O3+pzYR/LJLt0669iNZH
 uKMRWasTnjSwK2BnoyQoMOolhbsqNgUShdFGRQcKcikqffVa4dRi8TGP6C2skPWqYGam
 MykRz3oBZDnfTHU4WY7HBSPGvc0tQEjnCgMXjcjos/0IHFWuUJ5wrqwtXkseSLZpCk8o
 1iuiPEcNIrHwJkCGXwfWXGlwNHReM5cYuyxz3Kuh+lMcB2qvMTGNkldehjPWhM6oT0nr
 zn3DRHRLcLyLCdMq38sqnCLHvEjHTg/TSKNMkayXFspAc0gtPZ4xUsmdINkxuXaSp3wn
 4MRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779476044; x=1780080844;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=D5kB6tW1Xz66qPBLDXJwf09zq/Q6zRtszTSv2Ldr8jM=;
 b=iZcWtweqvL9Ux/BdEoMwTcI18PPk9JonJT1qF3heJBGr3OtBNIqafY6qoX6MiOmaHQ
 EcBt9OHJr/DY3wV54c8LEnf4J1bFIrRbE7CxdoDkg8ijfGLsJLgI7rtluM9pPQ1VttaE
 rgwrmdB7MHazjEYSLUxTCsO6JnVhF1Y57dsDPwNJNMdshIWIa5WrMv841lYwCQQjK6xb
 4j6EbT26/rJMHjk63ye38wXS9Igopu0/eOK3FjVb+wrZ8VvVQ+/4X0qbWuCiqQik7iv8
 qlSmVSKfD14Zbiy3p8YL5/milvUomGGHrtGPjEPx7gPA5xXSFZqJuz/qypn5muoS1FtH
 HzOQ==
X-Gm-Message-State: AOJu0YymMpeDML2kFFKdGElTtIfNRe0hr1+ZcmQRzD6uIhOsB2XSFwTO
 3yshxRlegkmnsMC+ZCC/wRiIqo7KUkC/sCfYz54CPXG6sc7axSCBqFjnPHSxf/tW3MqgvtmgnJU
 xikdr
X-Gm-Gg: Acq92OEyAxtrythEoVEkXn6pAut6zLUrHNlNMlQMk1764mQL66JV7Asswfgiouherwv
 pgtkAy2if5uBdzF6p4j1Zk1XOlHXXta1Wx9SYXsqyKVDT6ikcRQPbe09Yust5utI6GmddB4h8Hs
 pcG/RU0Nq6YFKEbvgmmuFBCbN+7mpNzCpognwTVNUYWvSHMBsvDRTkeoIN/6bIb452ITPAei0Tz
 SGPoeDuu6bxVtNIMSs8t8gG0Z6kxC/DF8d1G3a9nsnnV2EnrnsWdr+zU7hAxWADtuFUptDzzo5y
 a2pLZfnBh0J0GdjWlrN7Dh657PXNfePw1abQ0NQES7ZkxK4g8qUNKmZgqqXlG+BzKdSQ7W4c6TQ
 zejygbuASFqEnBqJ/gc1TE9aTchr3cxFJ6cPYIGT1OGHd/e3+3c2ELyEmo6hn2zr80FUBNCTtPX
 6Ub4eA7qpBBopE5I3yJYb1sr13ssoLExtqHQ/ORgGc
X-Received: by 2002:a17:903:41c2:b0:2b4:6d92:b002 with SMTP id
 d9443c01a7336-2beb07db743mr52261015ad.37.1779476044385; 
 Fri, 22 May 2026 11:54:04 -0700 (PDT)
Received: from [192.168.64.111] ([50.78.183.177])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2beb58c69a0sm22840155ad.59.2026.05.22.11.54.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 May 2026 11:54:04 -0700 (PDT)
Message-ID: <0c17542d-d0c2-4630-9911-128915f4102a@linaro.org>
Date: Fri, 22 May 2026 11:54:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 04/64] target/arm: Implement FEAT_FAMINMAX for SVE
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <20260520182213.872945-1-richard.henderson@linaro.org>
 <20260520182213.872945-5-richard.henderson@linaro.org>
 <CAFEAcA_uZsqTZn7uGrkL=o86_kzjO7MXsieYdCsEqALs9ZSQRg@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <CAFEAcA_uZsqTZn7uGrkL=o86_kzjO7MXsieYdCsEqALs9ZSQRg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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

On 5/21/26 06:56, Peter Maydell wrote:
> On Wed, 20 May 2026 at 19:25, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> 
>> diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
>> index aa7d72a35e..db32230595 100644
>> --- a/target/arm/tcg/translate-sve.c
>> +++ b/target/arm/tcg/translate-sve.c
>> @@ -4253,6 +4253,8 @@ DO_ZPZZ_AH_FP(FABD, aa64_sme_or_sve, sve_fabd, sve_ah_fabd)
>>   DO_ZPZZ_FP(FSCALE, aa64_sme_or_sve, sve_fscalbn)
>>   DO_ZPZZ_FP(FDIV, aa64_sme_or_sve, sve_fdiv)
>>   DO_ZPZZ_FP(FMULX, aa64_sme_or_sve, sve_fmulx)
>> +DO_ZPZZ_FP(FAMAX, aa64_sme2_or_sve2_faminmax, sve2_famax)
>> +DO_ZPZZ_FP(FAMIN, aa64_sme2_or_sve2_faminmax, sve2_famin)
> 
> Does this get the "OK in streaming-SVE mode only if SME2" check
>   if IsFeatureImplemented(FEAT_SME2) then CheckSVEEnabled(); else
> CheckNonStreamingSVEEnabled(); end;
> right? I have lost track of how we do the streaming checks...

I missed that for these.
I added TRANS_FEAT_STREAMING_SME2() handle it.

r~

