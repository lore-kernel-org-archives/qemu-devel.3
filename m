Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9A54D6A221
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 19:19:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBfN8-00040R-7z; Thu, 14 Nov 2024 14:19:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tBfN7-000400-AN
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 14:19:17 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tBfN3-0000CI-MK
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 14:19:16 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-20c805a0753so10615415ad.0
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 11:19:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731611949; x=1732216749; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=s0Dvqfj9DowpfpWzoYao0iUmgeNJmjRhVc0tjP0hvOw=;
 b=xoKu2rwUTUFs7bRCURCFJ6NHGlYXqxno5wgU70xRODOl1LC1Nf6cNsClEQv/J+fAaK
 qDuK9Lug+STAiDZQK9C2bJi5LY3ShvpY4cqPttotTwCtjFPQsWjNxIyAOFI5Blucz7IX
 SvbqXVDSwiScMwH4seH4VI/DRCvnEzlMsYG2wCIKzLyzodZmHxXq1XWs/jsU/A2Ilz6s
 MNtNfXrFs0t3ZItz6c0QI0b4rt9OrhNRTmVLiWH9cQaUWwEZDndQNlRLLWbVB1vvdgNE
 LPghUSm8uPORRuFvTR6Crvoll50agGDjzPkzRypWZ7OnKDzShoi/GKNxgMDrAx7H0ci7
 lc0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731611949; x=1732216749;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=s0Dvqfj9DowpfpWzoYao0iUmgeNJmjRhVc0tjP0hvOw=;
 b=gg1/c7HL9JrHF24w6Lp+lliMvtC/7QowBAkYYHqGfnXHzPooKvijHkUriY7rohWf0z
 OWSeHc8WWEBB714KQEBKBHu2zFoNA1hvmfJIm2Fbs7/RPFIG1d0v1Hdrr+tFXNtUgjap
 DdxJo0+TVTtcXV+RIovpl4lhIKmMSCmyA02CXYwNwTEAl/osBgj6TTMrdLI/tNJHXG3f
 HpA7i65cKqL1BbeNYi9cO55V351b9ohRX4ZbXYA2tqlDv0qH10cLwPxb5Fe24xlxUTny
 9K5yQU15cRDfjRrdpGXXOKDHi2RD70Rk0DJBioOGxtGL7YZM6/t3oCLpn9un5RR6B+m9
 zfxg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWxlE4IQeHZ+l7XvMCMsZmMOHCpQiHObyaxrMtLVQi7/fmhsU/DzwG4L1Xybh95rTkMDec5SCI36RGS@nongnu.org
X-Gm-Message-State: AOJu0Yzjzcyj+2onKcDG0gVcPTbePUS+FQntErwoDYJ8+FyrSG4UC/G4
 5Q8rbx0I4fKOpU4m/BzwgGv2YRp2MKqBx7QlpIq/pPskwPQsW/gXYrsKb25aSuY=
X-Google-Smtp-Source: AGHT+IF2wx13kgvBJCCM+Ukz7KTLiYUFJbyeR2wdiIlBTuhv8rXCbtj6XB1BBAIDmyu0IdZiCpWB7w==
X-Received: by 2002:a17:902:f541:b0:20d:1866:ed6f with SMTP id
 d9443c01a7336-21183ccf11bmr339200565ad.4.1731611949378; 
 Thu, 14 Nov 2024 11:19:09 -0800 (PST)
Received: from [192.168.0.4] ([71.212.136.242])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-211c7c2d3basm14229255ad.12.2024.11.14.11.19.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Nov 2024 11:19:08 -0800 (PST)
Message-ID: <1c700309-abc5-4b5d-9a40-d00b7a7a13a2@linaro.org>
Date: Thu, 14 Nov 2024 11:19:07 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/24] exec: Declare tlb_reset_dirty*() in 'exec/cputlb.h'
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Anton Johansson <anjo@rev.ng>,
 qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org, 
 Peter Xu <peterx@redhat.com>, Pierrick Bouvier
 <pierrick.bouvier@linaro.org>, qemu-riscv@nongnu.org,
 David Hildenbrand <david@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-s390x@nongnu.org
References: <20241114011310.3615-1-philmd@linaro.org>
 <20241114011310.3615-14-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241114011310.3615-14-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

On 11/13/24 17:12, Philippe Mathieu-Daudé wrote:
> Move CPU TLB related methods to "exec/cputlb.h".
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/exec/cputlb.h   | 7 +++++++
>   include/exec/exec-all.h | 3 ---
>   include/exec/ram_addr.h | 1 +
>   system/physmem.c        | 1 +
>   4 files changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/include/exec/cputlb.h b/include/exec/cputlb.h
> index ef18642a32..6cac7d530f 100644
> --- a/include/exec/cputlb.h
> +++ b/include/exec/cputlb.h
> @@ -32,4 +32,11 @@ void tlb_unprotect_code(ram_addr_t ram_addr);
>   
>   #endif /* CONFIG_TCG */
>   
> +#ifndef CONFIG_USER_ONLY
> +
> +void tlb_reset_dirty(CPUState *cpu, ram_addr_t start1, ram_addr_t length);
> +void tlb_reset_dirty_range_all(ram_addr_t start, ram_addr_t length);
> +
> +#endif
> +
>   #endif

This can join the existing CONFIG_TCG, !CONFIG_USER_ONLY block above.


r~

