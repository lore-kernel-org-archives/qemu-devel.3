Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22274C47258
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jan 2024 23:29:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSQCs-0002cK-QN; Tue, 23 Jan 2024 18:29:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rSQCr-0002c6-3J
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 18:29:25 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rSQCp-00023D-Jq
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 18:29:24 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1d5f252411aso27877385ad.2
 for <qemu-devel@nongnu.org>; Tue, 23 Jan 2024 15:29:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706052558; x=1706657358; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qf2U+J352BZMJ4duf5NgSdY273q3LP1n6EiYu41+lzU=;
 b=dTeL09VVeb4WKkpASy4P4aWdsQxrUjZBOMr01ctTNA0F40J2FDF5+QfX2b6ISCiJUN
 S78DxA7r9B8Oyserv4a7ON4vcVFimBhOJOS43QO8y/G41ApggNwGt7Q3Px+3S7qNVBiA
 6F01WC5b3GsRnvtkUTduE3Ry3eiKQf8FbwMoCTH1vsKlEKnTLRfDdjObcXffaxXvO998
 MchZsl7coRpCctC4odLN2snNGZrio46rgu0/YFHexatsvI9XJs5+h1U18SP0Wa3pgfoY
 nJDj+Hm3uVBln8q4qkaAGzpBkhhtq0UqJdebJWELWivGPp18PNLIqwPB168S02tVuzeB
 mf+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706052558; x=1706657358;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qf2U+J352BZMJ4duf5NgSdY273q3LP1n6EiYu41+lzU=;
 b=HehJCG9rQx/3mIIIiF0WY2ryWeSqWsnEHWrIGHISB/zdvATk4sB+tLrb78GRbNKJVu
 k/YGwgK9t3vwxM9gkjqWRoQ3tac2+qRfwavVOkqcgd1zTt9K4NtX7MH1eq2yZYvAPKCd
 rxsWsRUm6zxJsydpPEfi+ZesGK/XnmWuSb6sZ8v7noYbgjbzFQ7NttY/tNw95sq7/yXH
 utCv2rwDyrztThv7JL/lkt3Zguy0bE85Be/W+OL3GXsa49FjOCduWkA2nKvQTxpWsyeQ
 xS4DCQ51a7042PqF+VPpXTrObQw8q2VzWWJgqhXOdLgFQYkMFEVBB7yz2x07pzTUz7qY
 tPcQ==
X-Gm-Message-State: AOJu0Ywmdmi2MN8fMW8KsNcQYiChILN6yKApy5NMJalj0ABgtn811vpY
 Kz0B7j5acm8jrFz6u8HRCsZnZO3W98WzAxM/YdBUplOdLA8r1OLWSVfPxa5sHi2DCV0wkhwAVDz
 m
X-Google-Smtp-Source: AGHT+IGELFoodVCa1KHezr/rCK7bWVH1/wQIruS70QbIAsGq5gjXV8lgyqIkgpP3CpXnc7qKicdqlA==
X-Received: by 2002:a17:902:f685:b0:1d5:7316:c899 with SMTP id
 l5-20020a170902f68500b001d57316c899mr4338880plg.14.1706052558215; 
 Tue, 23 Jan 2024 15:29:18 -0800 (PST)
Received: from ?IPV6:2001:44b8:2176:c800:dd1:291f:3c3c:2485?
 (2001-44b8-2176-c800-0dd1-291f-3c3c-2485.static.ipv6.internode.on.net.
 [2001:44b8:2176:c800:dd1:291f:3c3c:2485])
 by smtp.gmail.com with ESMTPSA id
 jb13-20020a170903258d00b001d7271916dfsm6738997plb.25.2024.01.23.15.29.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jan 2024 15:29:17 -0800 (PST)
Message-ID: <7b0f7699-14b3-4923-868e-d59b53947971@linaro.org>
Date: Wed, 24 Jan 2024 09:29:13 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 10/34] exec: [VADDR] typedef abi_ptr to vaddr
Content-Language: en-US
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: ale@rev.ng, philmd@linaro.org
References: <20240119144024.14289-1-anjo@rev.ng>
 <20240119144024.14289-11-anjo@rev.ng>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240119144024.14289-11-anjo@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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

On 1/20/24 00:40, Anton Johansson wrote:
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> ---
>   include/exec/cpu_ldst.h | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/exec/cpu_ldst.h b/include/exec/cpu_ldst.h
> index 6061e33ac9..eb8f3f0595 100644
> --- a/include/exec/cpu_ldst.h
> +++ b/include/exec/cpu_ldst.h
> @@ -121,8 +121,8 @@ static inline bool guest_range_valid_untagged(abi_ulong start, abi_ulong len)
>       h2g_nocheck(x); \
>   })
>   #else
> -typedef target_ulong abi_ptr;
> -#define TARGET_ABI_FMT_ptr TARGET_FMT_lx
> +typedef vaddr abi_ptr;
> +#define TARGET_ABI_FMT_ptr VADDR_PRIx
>   #endif
>   
>   uint32_t cpu_ldub_data(CPUArchState *env, abi_ptr ptr);

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

