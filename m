Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8B09C2A073
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Jan 2026 00:34:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vcYYU-0005w1-Hp; Sun, 04 Jan 2026 19:34:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vcYYT-0005vg-EH
 for qemu-devel@nongnu.org; Sun, 04 Jan 2026 19:34:41 -0500
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vcYYQ-0000Xp-4Q
 for qemu-devel@nongnu.org; Sun, 04 Jan 2026 19:34:40 -0500
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-34c718c5481so12906553a91.3
 for <qemu-devel@nongnu.org>; Sun, 04 Jan 2026 16:34:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767573276; x=1768178076; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=aUpnPZAK6E/G+V8PhqC9hIDxOKmqNiNs7dPUrGay0Ug=;
 b=npbYysBrTkwpcnpiX7aD9FpujyLp1lUet1mFrBu72m4qoS0gTPWeMS+qIUQl0m1Zu9
 3RaLhSwEp24Wk++9anGtzwQs/cIVoSnEZ+kiKTJicte7Pdupzl2pKRbtFEUSsb2dcBIo
 WmoMH1BR7jQqdKh41rR/pmDGg8hDDpdmcycGakGCpgucdK6ZI8oQsMsVf+xHeyPxWb71
 cDDz1JbgzaHoTdA3UXHB3YXvURvuwYiloX4FwYXMcq6Qn7ONnXwUO+NLtmnwTaylYm61
 y/7BFfk3YFMy6v4XvD1odS1apiHdtFtIuCin2CJme7JiHTEFNA59OjFS1QR0WPEtlkU3
 ZqOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767573276; x=1768178076;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aUpnPZAK6E/G+V8PhqC9hIDxOKmqNiNs7dPUrGay0Ug=;
 b=sMYsLHbQW2XSdoni3FBab9zgGrSXgFrfd9XNLQc1h7yNz4bOH/sK/b0K246CnnNs4W
 2AMqL8IXW+7Zekv5BdxpePXswL7Nkiwb6YaaM9gxvP4dRz3GT+N5lFF65/xNXWo9APRE
 z9+MzKsWv2+lilj5BJjZzQ8cbJOnBwr9MtENkR//8vEdlNZUXEJlo2gSUSH8krq68wdh
 YYCa4+CIAz3i/wvzKf2zhy0lfW/G7EvDeupdVsNhfKTD0bmy+K2kCMTdfMTtQkf6DD86
 hUj+TvfMP9Zunhv5vSS7L7tBgsKLNmHkE/C4kBcoPgf/lPs3ddFbaCDnQrqu2gd9i6oX
 6dGw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUh1EPzaCMojlWVRK9AGr3hMtFdzSFQbE/h3C4xxWCLMwNZCjGp/z6iNzQwM3ksLvhLPLWiSf1OEy1P@nongnu.org
X-Gm-Message-State: AOJu0Yyz6UR28Gm01TuXKFSgOchkuGw4jsJmvhjw/so2xIRff2VamGpv
 Bj84gfmz8Vgq0q41ynWPABRFDsk4FuliwoOypEsSPcyQh9CS612yX+IeWVCsct+djwo=
X-Gm-Gg: AY/fxX749XAaxi6XFck00OEPGbuair6bmHlsEm2bP7fKoyAOKS1fCcn9cVxV/Yl7cQS
 uRmtKHPUTXv374D8mlK1loRtlOVC2PdJFs+n+xt0bmGyLPEN4pgWjWrt4evcs/Xo3Wz5qS4fR3N
 uG64CvdP+gP7nysAqdj6lSo5CGvz4Z1HpWu8bZb+UCY1tvAMjj1yYfDrGthYnEr9BqM5f0T0KAL
 vlTIjGvjLIYyqqnKKv1Slf7RbbeD07jlLcbXpYcINI3VcW3hwFAQWqxAZ512SjOHvUtbiP3Il1g
 loM8ym9iNoTPUptUIeHM8e4bfqCcRh2kFsTGAKuFxCfcd/hzyIJpWVQYF+L3eimfXfQk+kPIFX4
 fLjpN8Rt9jFikTkccLP5NioADsHFeSMeh/xtxaPz6EWjAE4hb8OIHpL2F5dgyIG8Wthc1rrndQe
 eJfZF29stPXzzCV9hbm7BVKElZtFLkRA==
X-Google-Smtp-Source: AGHT+IFqTzzolP1wkcaq03E6htyif0zqROiq6fnPJYGk4Y67lVLb0Ysv2awJpWjwaVP2gbU/VGeOLg==
X-Received: by 2002:a17:90b:5843:b0:32e:528c:60ee with SMTP id
 98e67ed59e1d1-34e921c3dc8mr40669904a91.24.1767573276400; 
 Sun, 04 Jan 2026 16:34:36 -0800 (PST)
Received: from [192.168.10.140] ([180.233.125.201])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-34f475f1726sm4383938a91.4.2026.01.04.16.34.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 04 Jan 2026 16:34:35 -0800 (PST)
Message-ID: <aedd62db-7305-45d9-9f00-735c948691a1@linaro.org>
Date: Mon, 5 Jan 2026 11:34:27 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/9] target/sparc: Use big-endian variant of
 cpu_ld/st_data*()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?Q?Cl=C3=A9ment_Chigot?=
 <chigot@adacore.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Anton Johansson <anjo@rev.ng>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Laurent Vivier <laurent@vivier.eu>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Frederic Konrad <konrad.frederic@yahoo.fr>
References: <20251224162642.90857-1-philmd@linaro.org>
 <20251224162642.90857-6-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251224162642.90857-6-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1036.google.com
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

On 12/25/25 03:26, Philippe Mathieu-Daudé wrote:
> We only build the SPARC targets using big endianness order,
> therefore the cpu_ld/st_data*() definitions expand to the big
> endian declarations. Use the explicit big-endian variants.
> 
> Mechanical change running:
> 
>    $ tgt=sparc; \
>      end=be; \
>      for op in data mmuidx_ra; do \
>        for ac in uw sw l q; do \
>          sed -i -e "s/cpu_ld${ac}_${op}/cpu_ld${ac}_${end}_${op}/" \
>                    $(git grep -l cpu_ target/${tgt}/); \
>        done;
>        for ac in w l q; do \
>          sed -i -e "s/cpu_st${ac}_${op}/cpu_st${ac}_${end}_${op}/" \
>                    $(git grep -l cpu_ target/${tgt}/); \
>        done;
>      done
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/sparc/ldst_helper.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)

FWIW, this function could be re-organized to use cpu_ld*_mmu, to avoid the explicit BE 
load followed by an explicit bswap, for the little-endian ASIs.


r~


> 
> diff --git a/target/sparc/ldst_helper.c b/target/sparc/ldst_helper.c
> index 9892c8f61c6..d39f7d72a7e 100644
> --- a/target/sparc/ldst_helper.c
> +++ b/target/sparc/ldst_helper.c
> @@ -1228,13 +1228,13 @@ uint64_t helper_ld_asi(CPUSPARCState *env, target_ulong addr,
>               ret = cpu_ldub_data(env, addr);
>               break;
>           case 2:
> -            ret = cpu_lduw_data(env, addr);
> +            ret = cpu_lduw_be_data(env, addr);
>               break;
>           case 4:
> -            ret = cpu_ldl_data(env, addr);
> +            ret = cpu_ldl_be_data(env, addr);
>               break;
>           case 8:
> -            ret = cpu_ldq_data(env, addr);
> +            ret = cpu_ldq_be_data(env, addr);
>               break;
>           default:
>               g_assert_not_reached();


