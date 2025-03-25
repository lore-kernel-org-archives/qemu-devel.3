Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7E6AC35FFC
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Mar 2025 14:08:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tx4vx-0007cH-LA; Tue, 25 Mar 2025 10:07:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tx4vv-0007c3-MP
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 10:07:11 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tx4vt-0007rR-95
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 10:07:11 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-227d6b530d8so37719155ad.3
 for <qemu-devel@nongnu.org>; Tue, 25 Mar 2025 07:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742911627; x=1743516427; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RbQNz+6OeKZktN9Q3r8BX6Mq5YEh7BfEVEWtdcklxnA=;
 b=S2+8FQiLEIHovJRRFo/xg4GmbuXCeORBhtnsXgjTGSa49ElVggH7KHklC9909BYGdv
 80qjdhv9JJV6Q0G+JiiJRBEaerAZpf92YGUYw2H1lZPk0yYt3Q0YTmK97kKzGGcS+G/G
 AdUe5aFnYruIUJvR2mtUkJaazNX96baMkyyW6SfzUWLzatp3tg/Ovm1Ls4g2leyRLxC4
 etDwzqdm58gya5CC5kIWeImBNPml5MRnSgM9osvR7akQ6qSn+TovX1JVDfghzZ54ATPB
 XIZ72CoKwnhBa1aCgfnsHJuelO+78pcBkVHbUYf9JGzvbBrliWepR4LkLWNssFWeznbZ
 p3LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742911627; x=1743516427;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RbQNz+6OeKZktN9Q3r8BX6Mq5YEh7BfEVEWtdcklxnA=;
 b=MRKZJxT5/RIqyrEv0jaHt/BHGVWxara6q0K/afIM/nDXE7FPdwGIwVndkuY5hgdL4M
 LaDV3dqmmyCQeC+gL/6mOxNycZmo/pXVprQZaLS/yczscjGkjlDLXrZrTjp6FgU8D1/f
 V6UWreezve8cUT0LZysDwRMxj7SdLcH+h2h9PmM9xKi5tRBh6BP76gU1Pe4rfLSWyqIV
 KaD1gl09hM132RYO1EqT49skmIktcTOWzvlly0iTKXQJK6uxz3xG2+SDXXWfe/5fJicB
 52kZZwTcjEGwZL48ze1T1Xe8+yrNi5nY1ScBP3i/FFdpV5zsBUie3sA3a4+kOjNdAIeS
 7C4A==
X-Gm-Message-State: AOJu0YynqKCAMYdfO0mHxi7iEuqU5vVTRXgqk0eoFVCiqV48PWwNt73d
 MIxVdOj7l9Lp75QhBTMsU0BzMHHJgQlHJkRMkGv7uSXKfG4AQkjg2wpqQoQUIfCCKQA8QHG/lfm
 u
X-Gm-Gg: ASbGncvmm0IhHo2apxNK6mAyJQf23toLuVlRWTpzmtxxusaD5P/Kgk/Ij2kMqAVbEad
 lNrCQZRKtwfwBxZXKxXav/QgfyKKR1YKOSGar/kRg4QE+zp3AwDuRK+4xUBJNvKuhqFUFao5A93
 El+dpCmgGT9AQA2maxVW+ucEOQdtyljdLIwOhPmqQEuOurQiJ2CiTjOraTJKhhmUDtLIj1lHbmQ
 nYVGasDaOr5mnsGWagvH4EqTHoGvDHremSptYauBwJMhiQN2WwUJrLCNkhDKRHO+e8FNZhBcnAg
 U2dO54UmRydfsWAKdNGmjnClEY3zWkg939HbijFTx/ltsmm0fi5K65uEx0efDVlG1nUt3jMGg8i
 aeF6AiftN
X-Google-Smtp-Source: AGHT+IFeDl4UgfOcBY8v8su//qy5sCA3uDSUZolZrOdu+5TH4K77wT9yUQcZt5YOKnRjlsbhrIjOKA==
X-Received: by 2002:aa7:8883:0:b0:736:5753:12f7 with SMTP id
 d2e1a72fcca58-7390593d41amr29303904b3a.3.1742911627013; 
 Tue, 25 Mar 2025 07:07:07 -0700 (PDT)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af8a284888bsm9087835a12.46.2025.03.25.07.07.06
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Mar 2025 07:07:06 -0700 (PDT)
Message-ID: <3776d8fe-f94c-41f2-baba-81c76655703e@linaro.org>
Date: Tue, 25 Mar 2025 07:07:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.1 2/4] target/sparc: Restrict SPARC64 specific
 features
To: qemu-devel@nongnu.org
References: <20250325123927.74939-1-philmd@linaro.org>
 <20250325123927.74939-3-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250325123927.74939-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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

On 3/25/25 05:39, Philippe Mathieu-Daudé wrote:
> @@ -2750,12 +2752,16 @@ static bool trans_SETHI(DisasContext *dc, arg_SETHI *a)
>   static bool do_tcc(DisasContext *dc, int cond, int cc,
>                      int rs1, bool imm, int rs2_or_imm)
>   {
> -    int mask = ((dc->def->features & CPU_FEATURE_HYPV) && supervisor(dc)
> -                ? UA2005_HTRAP_MASK : V8_TRAP_MASK);
> +    int mask = 0;
>       DisasCompare cmp;
>       TCGLabel *lab;
>       TCGv_i32 trap;
>   
> +#ifdef TARGET_SPARC64
> +    mask = ((dc->def->features & CPU_FEATURE_HYPV) && supervisor(dc))
> +           ? UA2005_HTRAP_MASK : V8_TRAP_MASK;
> +#endif

This is wrong.  The conversion could have been

   int mask = V8_TRAP_MASK;
#ifdef
   if (HYPV && super) {
     mask = UA2005_HTRAP_MASK;
   }
#endif

but that's an excellent reason not to have the ifdef at all.

If you want to hide the features from sparc32, so they don't show up on the command-line, 
fine.  But I think you want to introduce

#define CPU_FEATURE_HYPV 0

etc for sparc32 to automatically fail such tests as these without further modification.


r~

