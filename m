Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17D99CF45AF
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 17:16:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfLWM-0007FG-Hz; Mon, 12 Jan 2026 12:16:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vfLWF-0006v2-6E
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 12:15:55 -0500
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vfLWD-000893-L7
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 12:15:54 -0500
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-34ca40c1213so3337720a91.0
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 09:15:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768238152; x=1768842952; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bP8nw+4xRIgU1pe42o0KsYU/1+seivXe73OoPZKPxAo=;
 b=nUWXsswV6vlJsH5Yc7+IKZqQ+TZ6MqRC3tl6F/fwhLlgijJKkMDXGPTpm8b7qjdmnY
 K1rubcUmbQ3XuItmjc8g+1FYgycSdYJ9lM8GRKCTjef+QnUBiqeWpgQuD1xuTwNTy0sp
 YSIhVwuqrNZB2Nu9t2FFvpBM8s+9cgpL8EJN7lNwgvA4QjosMxr+ERQ3cRbnBbmhscI2
 adioKGGEHIYEioxJtffnJIOyCFWoRTJkauhpdSdFJixFdiWajgStudEATLvHJ/n8jpao
 UncUZlYdcWJ8gyE1rDsiW2K6/0weAKFQhYbZ6LFsDmteHoyQlV/btq86EPEPzbLZMcUl
 MI+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768238152; x=1768842952;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bP8nw+4xRIgU1pe42o0KsYU/1+seivXe73OoPZKPxAo=;
 b=aj71eoF4ENTTTYDquAlzJ4p4sznd+sWYeECgX6OGOjw9Pq/uPvBiSnMWFE3/GKXPgZ
 0AML0TjWP3cIhHugpzB7wldvzBvGbNCPYz/9hWpyw7qiv8GxBAJMc68ndOTsNS6H8IBh
 EsYrnOjBGo2ge4cPMatK8/3ef0LzWKyOnrIUam2JkXmxyEuK69BdFaEmcTvSwyGz2N1x
 xwEE9ejUKWkTlCVPj1s36xbQWe19ALanjb6WNK5gxgyDklobcwGeEMY0jS7K/c7qZhqn
 nMtixuC2jpPUK5AIlWwN2Iwa/p7Eplc6UQQ9Y/er9n5j93oChjRD8GGJh3eLcqoPbRg1
 NxPg==
X-Gm-Message-State: AOJu0Yy2DCH6Ec37ERjO63x9teWIoDb6lEilsRl2J/qMlXH5UJ3mkII1
 JdQMEWmXNpZB2HwCalmrJbJVwRkgnD3kIBOfgrsY8BgAtqdOFg92Vppll0YtKeMyf3k=
X-Gm-Gg: AY/fxX7U+FVjh3EheOgESwXigyVRzLYPxghC+8Y30phkXRWd9UqsGeBBfw2HjzxRpwy
 khkR5aul7Ftb+w8sPWGgVSaEcn9S2pNtirC8EB+V7JpWP9aUqh0dtr6Ng0+Nv7TvybkpF6baWOd
 l7GPCQu2ozr0/yqLlYd1mo5xinJrc2bldy5beZGHeO/Xv4FPXZsgU1weO2gffzfUoRoOFz9GbsU
 io/smAEMuewVEL4g1x3UlB1kVVpEy/e7MpFXfX1h/WY1pZ2Hdq0GI1kreu/d6m2cVlDClaOwpw6
 dihZWFv3vQm9Qx0QFW52CdRPvIyXY4jgwp3zzt0GkcuyPm3xC5bLJupoZQZkj+whxQ3GOYzqVya
 ltFBEmNaWLKNHVhnkx5WoNcHc5DW1mEjrnNLNHmJo0fBCowm79HZzID68+beUGE256O4SKxRq1K
 iPwEnsI8VmgfodGKE+uYeom3CKo3OhETUt1v4HrRXjYphmMmSxnQvlOaHw
X-Google-Smtp-Source: AGHT+IHpu1smMO8bgQC0dtYejvdgS7E08chd1p6soqZp6mljs3PiwqcypFka06FM9I+Vum9qN92vWA==
X-Received: by 2002:a17:90b:1a81:b0:32e:3c57:8a9e with SMTP id
 98e67ed59e1d1-34f68cc2973mr18150268a91.35.1768238151768; 
 Mon, 12 Jan 2026 09:15:51 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-34f5fb7419csm18215894a91.13.2026.01.12.09.15.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Jan 2026 09:15:50 -0800 (PST)
Message-ID: <7f09a713-c889-4afc-a4b7-34e3df402ec8@linaro.org>
Date: Mon, 12 Jan 2026 09:15:49 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] target/arm: make granule_protection_check usable
 from SMMU
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Tao Tang <tangtao1634@phytium.com.cn>,
 qemu-arm@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Richard Henderson <richard.henderson@linaro.org>,
 Eric Auger <eric.auger@redhat.com>
References: <20251216000122.763264-1-pierrick.bouvier@linaro.org>
 <c8e80923-d837-4874-a072-d5ae579576a4@linaro.org>
 <CAFEAcA_iXHEFTJ0mS+kRC=rNxxhyCHyw5R=nQNMXYE03qkBTZA@mail.gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Language: en-US
In-Reply-To: <CAFEAcA_iXHEFTJ0mS+kRC=rNxxhyCHyw5R=nQNMXYE03qkBTZA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1035.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 1/12/26 9:01 AM, Peter Maydell wrote:
> On Mon, 12 Jan 2026 at 16:29, Pierrick Bouvier
> <pierrick.bouvier@linaro.org> wrote:
>>
>> On 12/15/25 4:01 PM, Pierrick Bouvier wrote:
>>> This series prepare granule_protection_check to be usable from SMMU, for
>>> implementing RME feature.
>>> It's based on Tao's commit [1] extracting ARMSecuritySpace from cpu.h header for
>>> convenience.
> 
> 
>> Another gentle ping.
>> This series has been reviewed and should be ready to be pulled.
> 
> Applied to target-arm.next, thanks. I folded in this minor change
> which avoids the "local variables not declared at beginning of block"
> style issue:
> 
> --- a/target/arm/ptw.c
> +++ b/target/arm/ptw.c
> @@ -3785,9 +3785,7 @@ static bool get_phys_addr_gpc(CPUARMState *env,
> S1Translate *ptw,
>           return true;
>       }
> 
> -    const uint64_t gpccr = env->cp15.gpccr_el3;
> -    const bool gpc_enabled = FIELD_EX64(gpccr, GPCCR, GPC);
> -    if (gpc_enabled) {
> +    if (FIELD_EX64(env->cp15.gpccr_el3, GPCCR, GPC)) {
>           ARMCPU *cpu = env_archcpu(env);
>           MemTxAttrs attrs = {
>               .secure = true,
> 
> -- PMM

Ok, thanks.

