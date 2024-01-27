Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9EBEC46CD2
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Jan 2024 09:43:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTfCp-0002PU-Hu; Sat, 27 Jan 2024 04:42:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rTfCn-0002PK-JG
 for qemu-devel@nongnu.org; Sat, 27 Jan 2024 04:42:29 -0500
Received: from mail-ot1-x32a.google.com ([2607:f8b0:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rTfCm-0005vk-2F
 for qemu-devel@nongnu.org; Sat, 27 Jan 2024 04:42:29 -0500
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-6dddfdc3244so852703a34.1
 for <qemu-devel@nongnu.org>; Sat, 27 Jan 2024 01:42:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706348546; x=1706953346; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GWnjSFdMCCcnrzHftSSiLITZya2qnJRpj1a7FIGXI68=;
 b=hwd7PyO4r/bCrLpbfzUZugq5EvOJlcfAhHZPRJHFaB34iJvQhGRSd6qosS8CDaZNDo
 +mLCbD4Cw2TnrUGKJ79/aZoDVuUouH5hWIXrJ8fAUkdbcWGN02Mse4RoaK8b979uQj3o
 1h421KUTuQbs/rF+tCt6PH56kFL7ysY9O6GaQJ6cWUSThzHRcPuqLea8uzoNaPoR7Ie3
 x4XTD5wWx5uPIqop/cR3m8/5LQV8kv3LpSWp2bCokpzzYcjCfV5P0xafRwDYr1nVRiHS
 y5IJSqbkE1zypSjcPa+AZJN11SxLhaX/t2+JuPkwdGSPXOBDKr67NPOPRIXOaL5g1gmn
 sCzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706348546; x=1706953346;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GWnjSFdMCCcnrzHftSSiLITZya2qnJRpj1a7FIGXI68=;
 b=Lm95dJbOKFZNKwCNTvrhi+apcsl4V/P8rzFih2AuFwJedXSVYfDfjzA0Srt2WxcyEo
 YVijNiSzdS1A6Z0+Mmpk0Zr5mRaKUkG5Tgv2dsEJR2wUtuFiVmqKefT/3EKjCKwwATO8
 v0dUyD0LZcaTHf0vb/VCpW7JPoAHMVF0TmIAh1Ov6/yYnVa32n/09Me/VmXK7qs5Zh4G
 AGt5bbSuERPNhDUrIa/O1yLOzl1sMzX6Z+PFOT/xjtHN28/1Icb9pMObD1Jwb0nR5XUj
 kcTE1MDNqLWDUyu1dcOV/cLf3BPv1CglM6vYSgJsg1swKxkEAChVpore0ME6G6GfrW16
 VjSg==
X-Gm-Message-State: AOJu0YzX3Po3nr+6XRPNjXF+ttDX6JDDaVI+fKug6et5YEfF4ZsXun7M
 IPgA7bSerUVaLKuJvezOq19MxUiW1umYxWhZ+xst3Q3FRoHWxpsTFwqjYNyxH2s=
X-Google-Smtp-Source: AGHT+IFSKeGVQ6Qt5oOkbZ0gyEj7Q+c0GOuTZvViQFE6cvkzfYk82yAn6dNOSaZVcPMbsne8gefEog==
X-Received: by 2002:a9d:69d3:0:b0:6e0:f839:8581 with SMTP id
 v19-20020a9d69d3000000b006e0f8398581mr1554569oto.55.1706348546711; 
 Sat, 27 Jan 2024 01:42:26 -0800 (PST)
Received: from ?IPV6:2001:8003:c96c:3c00:af6d:99b9:66ea:c79a?
 ([2001:8003:c96c:3c00:af6d:99b9:66ea:c79a])
 by smtp.gmail.com with ESMTPSA id
 j19-20020a63cf13000000b0058ee60f8e4dsm2461974pgg.34.2024.01.27.01.42.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 27 Jan 2024 01:42:26 -0800 (PST)
Message-ID: <822252d0-cd5f-4b7a-8499-27d557093db6@linaro.org>
Date: Sat, 27 Jan 2024 19:42:20 +1000
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::32a;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32a.google.com
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

Queued, thanks.

r~

