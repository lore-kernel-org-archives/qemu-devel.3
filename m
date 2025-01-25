Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A27F5C0218D
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jan 2025 15:08:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbhks-0006NZ-1D; Sat, 25 Jan 2025 10:07:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tbhkh-0006N9-N1
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 10:07:16 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tbhkf-0001YR-Ji
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 10:07:15 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-21a7ed0155cso51607865ad.3
 for <qemu-devel@nongnu.org>; Sat, 25 Jan 2025 07:07:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737817632; x=1738422432; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=m1XQh8170hyGOxRLW1IngBQRIPG1Wrk38VXtpTKl63s=;
 b=J+d4yUOpujM1kJoHlUKpq2nN1A5ByjzlASGAQEnqT7uw9sJBOiBEJspzj1SlqyxKVH
 TCmW6R5+c15tpcCpEcT/FUBVpdDGkjjcJRR24ABui9hNShzO29sZ76pwjM1tMzzje9g3
 43AUbZd4sl67kpwrFqRE6v1mR21zEyS4hipG0wAf8W8j+jniJlBGXYd6BmI48Ljo1qsC
 fOZ3qdscVGwHyhx50PwIpk98VueehYwBRx0AzfAC44H+NPSDE9MBUsjS35vaxL3tDSsA
 iAD/k1N5gQZ5DQR0jO2vCBRBVjF5aw/G++0pgtc40LJfrCl4JU67H08hZDm8pL/zjMqM
 /JrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737817632; x=1738422432;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=m1XQh8170hyGOxRLW1IngBQRIPG1Wrk38VXtpTKl63s=;
 b=jqilddfHTWJHobKhnBImCbsEgUZMqXPNPTgPay1ob5ix03icuZSlDfsOiXCbgEpxyP
 lcDM4pCeBK043u/pOoVkWyUlNyKWFq1X0rIvVX09RaIUsPATPAFRa6OUsC+fRtjBzSOL
 tsyWWlWGH+9JtWSNRmjKYJSFqElJqto8jMdLr0vMzqpl87L9eW6vKzT50qP4NfJMEyRp
 IbiLv+X+NKjlMF4WwQTFxjb4EE0GfuGqPsT7RTTku32zCAqeSJ7VnjeU5s+YOhJW+Qhy
 4S/blcy0TivEc4rvZyGH00wPl90mUU7qMEgvMTK+GXKwstKoXWHl9CCHxWr6KI29rGhs
 iBfg==
X-Gm-Message-State: AOJu0YzaEqnH4HQnc5ADT+//hswJM2FbwJHcXUFGmi1WmhjYTozTXgDL
 U7QeEhKD5FEMaW6cDYxC0uOJ6bdw+LsU74qc/9bmYbVEHLSf2cYZ4e1ywTSlMxuF9IC9J95n1B3
 w
X-Gm-Gg: ASbGncskzBRhnxzXaskBhCB82H8tHy6tVyueHnkG3cwyaRQgg1B0p9U+LWJYBRtC+By
 7UPoAQkX+EhBHEsK+3INVregxx+IsLS6C/HBDilSY+tTRL0Tw/xgWjugzVa0zR9IiGCE+g223fi
 CQTSTDKwIh97uZ8WS1qm7QwaoZBXszt0MqfJwYTBoHXQ1+gupYR764ffh9drD0VQX15iqbLn+ZV
 3yWmAHv0OiMt7qEouuM0hX5mXaXwxlweplEieSyWE4b1HRPvML/XOcSEJjYHRQCfZ11RSug9t8e
 WEaRO8yT4Gl9iu4HCaESOg==
X-Google-Smtp-Source: AGHT+IERdSJ+QWyZVc3MoT087+CUAVfqWZUOpKfVguzx4tKY/MunKQ3wxd7r7xIcTawkBiGbIL3Q5Q==
X-Received: by 2002:a05:6a00:ad8d:b0:72a:ae66:3050 with SMTP id
 d2e1a72fcca58-72daf931cd0mr45220550b3a.1.1737817631848; 
 Sat, 25 Jan 2025 07:07:11 -0800 (PST)
Received: from [192.168.74.94] ([50.200.230.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72f8a6b3073sm3946847b3a.52.2025.01.25.07.07.11
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 25 Jan 2025 07:07:11 -0800 (PST)
Message-ID: <e4194fd5-1af8-4f79-8b88-58d30b094937@linaro.org>
Date: Sat, 25 Jan 2025 07:07:09 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/76] target/arm: arm_reset_sve_state() should set FPSR, 
 not FPCR
To: qemu-devel@nongnu.org
References: <20250124162836.2332150-1-peter.maydell@linaro.org>
 <20250124162836.2332150-4-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250124162836.2332150-4-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

On 1/24/25 08:27, Peter Maydell wrote:
> The pseudocode ResetSVEState() does:
>      FPSR = ZeroExtend(0x0800009f<31:0>, 64);
> but QEMU's arm_reset_sve_state() called vfp_set_fpcr() by accident.
> 
> Before the advent of FEAT_AFP, this was only setting a collection of
> RES0 bits, which vfp_set_fpsr() would then ignore, so the only effect
> was that we didn't actually set the FPSR the way we are supposed to
> do.  Once FEAT_AFP is implemented, setting the bottom bits of FPSR
> will change the floating point behaviour.
> 
> Call vfp_set_fpsr(), as we ought to.
> 
> (Note for stable backports: commit 7f2a01e7368f9 moved this function
> from sme_helper.c to helper.c, but it had the same bug before the
> move too.)
> 
> Cc: qemu-stable@nongnu.org
> Fixes: f84734b87461 ("target/arm: Implement SMSTART, SMSTOP")
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/arm/helper.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 63997678513..40bdfc851a5 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -6413,7 +6413,7 @@ static void arm_reset_sve_state(CPUARMState *env)
>       memset(env->vfp.zregs, 0, sizeof(env->vfp.zregs));
>       /* Recall that FFR is stored as pregs[16]. */
>       memset(env->vfp.pregs, 0, sizeof(env->vfp.pregs));
> -    vfp_set_fpcr(env, 0x0800009f);
> +    vfp_set_fpsr(env, 0x0800009f);
>   }
>   
>   void aarch64_set_svcr(CPUARMState *env, uint64_t new, uint64_t mask)

Oops.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

