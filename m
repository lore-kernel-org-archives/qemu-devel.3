Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7C52E9D826
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Apr 2026 23:21:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w9WmH-0002BP-Jt; Sun, 05 Apr 2026 19:21:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w9WmF-00029W-LB
 for qemu-devel@nongnu.org; Sun, 05 Apr 2026 19:21:11 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w9WmE-0002kv-3X
 for qemu-devel@nongnu.org; Sun, 05 Apr 2026 19:21:11 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-82cef263bedso1517139b3a.0
 for <qemu-devel@nongnu.org>; Sun, 05 Apr 2026 16:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775431268; x=1776036068; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JfeZM4akJPrmB6dECv4zNkmvHYj+AyV5q6bsVdV63zs=;
 b=RviU5yySJu3PO0ptymzD8FW7v4z2fSjQT63S/kcwWcB26iRE82Hkgn0sblnEAxrNhh
 rdY75Wh30egjsZr68mHTkGkM7zyvVTzSUyTfGXYVWb+7nWZPMCG0mkAFt5IerIzB7boB
 lDtslsh3i802kSyA1Rp6HxH3a3gw3CvVTJ3Ht0dAcG21BMfXlEzVT+WaEO+1haf3BU0O
 ovbfZEEKv0lS7/zIkMVFeH73cVLiZ3En1k+MRgWuLRjQvnp7nJidl1y96LAeY/Y+ocni
 pUU6Gok2z5AfGCK9gd8SpnfOrmJAIjWdueHiYe7B6XltbDDi8vZ7tSWyANUiM+HdDGqT
 dOng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775431268; x=1776036068;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JfeZM4akJPrmB6dECv4zNkmvHYj+AyV5q6bsVdV63zs=;
 b=lrH/rJXZ71hnFVzSuz9nqn406EQHAY7sW2c8DdfDcmczoRpz9JgA24vqfAv9jAoU31
 T9gCEW+Lx4QlO+pPiTccIxt+m8XcOjfbrqf2xfgmGAjCYaY5if5EpGexV6Sj4eNAGHJe
 J4BlmDp9YTcOeTQKvLlVa4+K+y6eSPm448a6tOHkmc6v5zlfXShDtKckwWflkv9KN2eJ
 x78jnQCsyNYQIr7oNzLemJDait7lBCHatS6pBWAQfd9HqQHtFEcr5UjB/pSzymiIyBMn
 qqCDqBsDIOQGBniTAFyw3ByyqzPax8SgY6OKx0Qi3sUbt5TYScmfuRTuO5qb2fs1uO50
 zk7A==
X-Gm-Message-State: AOJu0YzCqgvLMnMs2SSWy3ZrEWq1SVdfHAouXJ04JTrHmJYvrNdj7zCf
 wsCQ17mb05p7545KtVM/OXI2IOYGoKii3rdYl9l4+Tt341S/qSBkdXHpx+SSPx055b/SHstpXBh
 gytgN
X-Gm-Gg: AeBDievzg2IWtKnveKg6GDytWazH3NUsUtlsJbf0cfe050e9lQ4s2IXOoENnqutIfwd
 GrhKgdVYs2cFdAI1bTMLkLMqLjH6YH8T+tmsKBZ/PULqQ1Ie2Gejli2R1cLjCevxabOr0gpyWQE
 cn8MioU1tCVdArhO8yxniFVBnTJbfJIESqttDocGkXUbD54RY5KIjD4t5wMHPHKLlsUJQ4Y+klI
 Dd1qycXP72wLzqK0vzGIAZ5O99vFInBOJN9XIv7RIa8kFR2Zlud5o8DOAqYkpsjlJprtM8/xvh8
 VY0L2RqeMZByQK4lb4Q+0P1Nn3Nz3qJ0jCGVyoKZ1x9StGbFSLQcAw4C0CnZGF8ZtaE4NhGWMWp
 WPtfEZUp9SuEyh6ItXZtlElYqcE/+IaB5ExURvrjI0JUkvLWjRn39EecNQMQBm3dTU7bZmODnS0
 VCVcMSrsBKOW8oRy0F5kmmaVqciiPt/+VWZ0+FiBTk6uK2Kasyn/otbYqBZS+oUQvpOKM=
X-Received: by 2002:a05:6a00:4b53:b0:82c:e1a3:986f with SMTP id
 d2e1a72fcca58-82d0db93629mr9123557b3a.43.1775431268304; 
 Sun, 05 Apr 2026 16:21:08 -0700 (PDT)
Received: from [192.168.1.105] (124-150-69-109.tpgi.com.au. [124.150.69.109])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82cf9b3c930sm12346155b3a.17.2026.04.05.16.21.06
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 05 Apr 2026 16:21:07 -0700 (PDT)
Message-ID: <2c03c01b-1bec-40cf-90e6-d7a8444e7199@linaro.org>
Date: Mon, 6 Apr 2026 09:21:04 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 04/35] target/arm: migrate eret trap syndromes to
 registerfields
To: qemu-devel@nongnu.org
References: <20260320130607.2071996-1-alex.bennee@linaro.org>
 <20260320130607.2071996-5-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260320130607.2071996-5-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
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

On 3/21/26 00:05, Alex Bennée wrote:
> For simplicity keep the OP as a two bit field rather than the two
> interlinked fields in the docs (ERET/ERETA).
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   target/arm/syndrome.h | 11 ++++++++++-
>   1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/target/arm/syndrome.h b/target/arm/syndrome.h
> index 5b5a5cb182e..b145a52769f 100644
> --- a/target/arm/syndrome.h
> +++ b/target/arm/syndrome.h
> @@ -367,12 +367,21 @@ static inline uint32_t syn_sve_access_trap(void)
>   }
>   
>   /*
> + * ISS encoding for an exception from an ERET, ERETAA or ERETAB
> + * instructions.
> + *
>    * eret_op is bits [1:0] of the ERET instruction, so:
>    * 0 for ERET, 2 for ERETAA, 3 for ERETAB.
>    */
> +FIELD(ERET_ISS, OP, 0, 2)
> +
>   static inline uint32_t syn_erettrap(int eret_op)
>   {
> -    return (EC_ERETTRAP << ARM_EL_EC_SHIFT) | ARM_EL_IL | eret_op;
> +    uint32_t res = syn_set_ec(0, EC_ERETTRAP);
> +    res = FIELD_DP32(res, SYNDROME, IL, 1);
> +    res = FIELD_DP32(res, ERET_ISS, OP, eret_op);
> +
> +    return res;
>   }
>   
>   static inline uint32_t syn_smetrap(SMEExceptionType etype, bool is_16bit)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

