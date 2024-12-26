Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83E87E77188
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Dec 2024 21:31:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQvSG-00040n-PN; Thu, 26 Dec 2024 16:31:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tQvSC-00040V-QP
 for qemu-devel@nongnu.org; Thu, 26 Dec 2024 16:31:36 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tQvSA-0004Nj-Gf
 for qemu-devel@nongnu.org; Thu, 26 Dec 2024 16:31:36 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2166022c5caso70670535ad.2
 for <qemu-devel@nongnu.org>; Thu, 26 Dec 2024 13:31:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735248693; x=1735853493; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mXs+PRdlHS2A9kM3OQ2WjUzZ8dU799pArfdWqWJur+k=;
 b=xSCbF/F2dIEaGhCwmdeOxHvCaiATy8/r9DK45LFmd9QyrxB42O2sdp4zf8ah629WX3
 X/kho89vQaNeT1tZKr8rX1KCVULywnxAchiQp+XetusRiQ2V5EqoRysywiyOw1u98GmI
 oOVY69TAXeia3cfveN+d8wpGhSXaS2QXCjxdm3AfzLkoTuOm7ZzULHKDh9pj600ZhXSA
 DjId5rYer1+F64izr8x66lEOv1ivHtV7sWVb0Ay/VNFX7icBKyv0HZbHET0FLIkFRUrC
 AlRHfAMu8ozM7dtnEsydpVw40baOMhpX6oqBBncUtCYt8lB5NDVS529F74ZRE35M0xqA
 JjKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735248693; x=1735853493;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mXs+PRdlHS2A9kM3OQ2WjUzZ8dU799pArfdWqWJur+k=;
 b=lNORQ4RXb4gqnx/3HeSyc6rhXC5nNsnou1Ua5XHizYs3gc36IwP6DCrnajScAmyiVp
 7raBEg52DQ8Up7vJAJVP6qlhDXBc3oE0P3bE22OjFS8x691crY+bm76u7AuZNlZaAULb
 TRKzSEAmF+B90S2/hP4Vr5IYzA/nrMiSOfLq9gs4x9XV8+C22C/H2szYbXCSftodIYMp
 lXVWhPs61Opm+P6sAjlz8vdMpltp4ieFpIe+5dStW3/7xBzH4gSCcMm7ADD7RXNAumgm
 bvlcMSS5gBYgqHLNkqVSAZz7jD/LEzhgUsil9BfcPRnG0zBbj1BgtTghzMysA+J787Tl
 n84w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXDYbs3RCK+RKh2skPolXkjdo0q9OvNsFG7zK6PkKfcc0aOWSJWh5Hepj5h2p8czFbhj9ITJCPJ96Xo@nongnu.org
X-Gm-Message-State: AOJu0YzWBrkIdcwa54Co+WltFjID6ENQXBi1PCXHCTSobs1HVeSXdha+
 bSw7e93AMreAOkgZEN2opg2Ib85oFinpR78wJjmnPWg8r/FfDIg8TUHCR34Zu6ged17CcH3M1No
 wyCY=
X-Gm-Gg: ASbGncuoELR6V+ZzlTW0Y3OjWE/Up+acvs9fzHoVtBys7aPbtnLYg8nWmKHNuhQ6a5Y
 YHVh+H0JREC45zKBhFmnm1XZc1K6tN/JVRGQUjeOVWlzUdL/shO61JHTcP2aceKOvR7WiFZi40y
 ifG23Llo4/1tJGY6GRsMTm4vl27eJ+Gvi5u9CgyvOQXTQP4GaJLzq25K4ZYICOtUxugquf5FS+f
 c7mMfnWNjmvfM9zewtBdS7JJkHxxhEneZ2gj0Na1wa/cUWwt5vJg1rJgytcnM4FqJathneiarw0
 Shl93/d86pTPdA9uQJD+6LkrOJMG2+oYYxMiESc=
X-Google-Smtp-Source: AGHT+IFiMS7nWEDz8hDlwIB7SmNcLH7H6umyIzYrbv6Ev9memdTc3TFTw9vbI7yiRkQtSYouodV7Cw==
X-Received: by 2002:a05:6a21:6da4:b0:1e1:c03c:b420 with SMTP id
 adf61e73a8af0-1e5e07f9731mr45340686637.31.1735248693140; 
 Thu, 26 Dec 2024 13:31:33 -0800 (PST)
Received: from [192.168.125.227] (syn-156-019-246-023.biz.spectrum.com.
 [156.19.246.23]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad816459sm13774100b3a.23.2024.12.26.13.31.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Dec 2024 13:31:32 -0800 (PST)
Message-ID: <bf043ccb-21e6-4ff6-a8c2-ab2e38b6fc9a@linaro.org>
Date: Thu, 26 Dec 2024 13:31:30 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/23] target/loongarch: Use target_ulong for CSR
 helpers
To: Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org
Cc: Song Gao <gaosong@loongson.cn>, Bibo Mao <maobibo@loongson.cn>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20241226-la32-fixes1-v2-0-0414594f8cb5@flygoat.com>
 <20241226-la32-fixes1-v2-9-0414594f8cb5@flygoat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241226-la32-fixes1-v2-9-0414594f8cb5@flygoat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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

On 12/26/24 13:19, Jiaxun Yang wrote:
> All CSRs are meant to be target_ulong wide in our setting.
> 
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
>   target/loongarch/helper.h        | 14 +++++++-------
>   target/loongarch/tcg/op_helper.c |  4 ++--
>   2 files changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/target/loongarch/helper.h b/target/loongarch/helper.h
> index 409d93a5b0808f0e32b8c0e2e17cebac9feaf8ed..a608754b7f52689da9e9f4da1cef68d5af72f2ed 100644
> --- a/target/loongarch/helper.h
> +++ b/target/loongarch/helper.h
> @@ -97,13 +97,13 @@ DEF_HELPER_1(rdtime_d, i64, env)
>   
>   #ifndef CONFIG_USER_ONLY
>   /* CSRs helper */
> -DEF_HELPER_1(csrrd_pgd, i64, env)
> -DEF_HELPER_1(csrrd_cpuid, i64, env)
> -DEF_HELPER_1(csrrd_tval, i64, env)
> -DEF_HELPER_2(csrwr_estat, i64, env, tl)
> -DEF_HELPER_2(csrwr_asid, i64, env, tl)
> -DEF_HELPER_2(csrwr_tcfg, i64, env, tl)
> -DEF_HELPER_2(csrwr_ticlr, i64, env, tl)
> +DEF_HELPER_1(csrrd_pgd, tl, env)
> +DEF_HELPER_1(csrrd_cpuid, tl, env)
> +DEF_HELPER_1(csrrd_tval, tl, env)
> +DEF_HELPER_2(csrwr_estat, tl, env, tl)
> +DEF_HELPER_2(csrwr_asid, tl, env, tl)
> +DEF_HELPER_2(csrwr_tcfg, tl, env, tl)
> +DEF_HELPER_2(csrwr_ticlr, tl, env, tl)


Changes to helper declarations here, but not to definitions.


>   DEF_HELPER_2(iocsrrd_b, tl, env, tl)
>   DEF_HELPER_2(iocsrrd_h, tl, env, tl)
>   DEF_HELPER_2(iocsrrd_w, tl, env, tl)
> diff --git a/target/loongarch/tcg/op_helper.c b/target/loongarch/tcg/op_helper.c
> index b17208e5b962f2191b2afa60181bff311d618bba..c9d7e84e7ec9000bab655366bdf6ed8aaa4fd080 100644
> --- a/target/loongarch/tcg/op_helper.c
> +++ b/target/loongarch/tcg/op_helper.c
> @@ -61,7 +61,7 @@ void helper_asrtgt_d(CPULoongArchState *env, target_ulong rj, target_ulong rk)
>       }
>   }
>   
> -target_ulong helper_crc32(target_ulong val, target_ulong m, uint64_t sz)
> +target_ulong helper_crc32(target_ulong val, target_ulong m, target_ulong sz)
>   {
>       uint8_t buf[8];
>       target_ulong mask = ((sz * 8) == 64) ? -1ULL : ((1ULL << (sz * 8)) - 1);
> @@ -71,7 +71,7 @@ target_ulong helper_crc32(target_ulong val, target_ulong m, uint64_t sz)
>       return (int32_t) (crc32(val ^ 0xffffffff, buf, sz) ^ 0xffffffff);
>   }
>   
> -target_ulong helper_crc32c(target_ulong val, target_ulong m, uint64_t sz)
> +target_ulong helper_crc32c(target_ulong val, target_ulong m, target_ulong sz)
>   {
>       uint8_t buf[8];
>       target_ulong mask = ((sz * 8) == 64) ? -1ULL : ((1ULL << (sz * 8)) - 1);
> 

Changes to helper definitions, but not to the declarations.

Is this patch a victim of incorrect splitting, or incorrect rebasing?


r~

