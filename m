Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8012E9D827
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2026 00:02:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w9XPT-0003gL-Nc; Sun, 05 Apr 2026 20:01:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w9XPQ-0003g8-FY
 for qemu-devel@nongnu.org; Sun, 05 Apr 2026 20:01:40 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w9XPO-0006wo-Fe
 for qemu-devel@nongnu.org; Sun, 05 Apr 2026 20:01:40 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-82ce0a9b3f7so1413069b3a.0
 for <qemu-devel@nongnu.org>; Sun, 05 Apr 2026 17:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775433697; x=1776038497; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XH8MIXV91UwNLYwejCAuimdOLK0orVqOEx/jxCs4thg=;
 b=GiJ3zSvXwUvX6F2cJEkRVuMVVnm0Jxcb/8GYlJmaL6u/hKSQgC+nMSZXEGGuK9p3gy
 XJ5uMCwsBekSHUAQ+OReYR/ZI23TH54il63qtBQbxQVPfLJFzhQLCobeI7ZltsC0kDqf
 +88iEjcIFg4BM/TEBZFgE2ih0hcSRHpkzXuq5QRnXfpATGTrXlplyAuPpzcpdijdijeF
 RpxKiWDfNA8fZ8iyaJ3qAHvnT4efDfknOC5fBtCiXj4PfHtj1Y3KnY9Qrpgnq5Up0Kwu
 bcHSeapy/gs5pNrVDtOAm+MRK6bUaB+EWhmI3AUP3Nja6C2G4kPglsH8zEpUnYPw7JAN
 Q5/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775433697; x=1776038497;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XH8MIXV91UwNLYwejCAuimdOLK0orVqOEx/jxCs4thg=;
 b=h8Ld1q5N3cef6C5uHs0EsxXfquLVNUlsWbJ0aTXDPHkmBa0fmKbb13V0TkxRbJlksW
 ML5duDwU8GaPV8kzOgiDdY+HUnZnwDCW4bKDhKgGwhKTkd7BIdZS+kIt+b3JESsLE+2/
 jELQscONtv4KrHdWldj777pgvMgkJOJwtxuH+How379w02POEXcidLXAZtVXqw2iB3Hd
 Qbu+U6e9++9CeKWugk7KaNpZb2OVFCg6cAUK55T5HZHaXS+Bc1cSU+afAlauxoK2MxOn
 s3nxR97ln/i9Vwc3OPnvzrcJohD5pMZkbfYTlChp5yGtB9EMRHwUc21vY/pz+Wp9iG3e
 6mvQ==
X-Gm-Message-State: AOJu0Yyvs13rCdb/KwmZqVmsAl8jDt5dZ/Mnl4mpUx1CaHq++kp9/A3d
 pfPinc+rJmx28nXIb68a3VYtElqcF9q3wJfDaKX43XEOKTlBmfZBRpIChIwLZo+5o87QcpChCFk
 qFTzZ
X-Gm-Gg: AeBDiesiiQelDeSqMdv1YA0YjSQFvWAwbrqQQg/78vuERE/IMug1LZYu1cCVKnKv1x8
 YeqCvrCHHZW/OuV5NgiLMNa9A1W3vydsKZ2TUsOW8nWtHUGOstfzqQZuJK79HJpj+sBVgUxARfm
 zAYn11tg/voTCBbM2rdbuLsKpUl++wuMtv7cpsPk+ok+meZzdHQaXKEGzxSxvqGyggwsVKtHPPX
 aS7e75dBqR0/3hcdwHkZ5r2BRTlUCy+n+kWnD5sH644l4QsHkTu5zCYQkJfOg7VJF7ia0k/QDBy
 PpHiH5PBP5XWofGt5l9IYHMRklE3/T4xFQo8WFL7lbGLaudl4CO72COmpJSb8TcH3uBOFmrT2Bd
 hhGkzkyRshcoqQqEkw0ycj6cXAtBm9xtjR9wr9PKEi2Pu9fqlxW/42CaNBdG1svsVvwg4JD7i1q
 4cpffw00GxnhiGir702KNSKUyH3aY0Yh47ZRSe/3I8DXFIrOaKs7HvpGKvNAfMGPdLIq4=
X-Received: by 2002:aa7:88c2:0:b0:82c:2205:507d with SMTP id
 d2e1a72fcca58-82d0db7338fmr11042716b3a.36.1775433696173; 
 Sun, 05 Apr 2026 17:01:36 -0700 (PDT)
Received: from [192.168.1.105] (124-150-69-109.tpgi.com.au. [124.150.69.109])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82cf9c9ba21sm16176729b3a.51.2026.04.05.17.01.34
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 05 Apr 2026 17:01:35 -0700 (PDT)
Message-ID: <c1f15949-91dd-4c16-a39b-d46c66c91c91@linaro.org>
Date: Mon, 6 Apr 2026 10:01:30 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 15/35] target/arm: migrate check_hcr_el2_trap to use
 syndrome helper
To: qemu-devel@nongnu.org
References: <20260320130607.2071996-1-alex.bennee@linaro.org>
 <20260320130607.2071996-16-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260320130607.2071996-16-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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
> It shares the same COPROC_ISS encoding as the other CP traps although
> not all the fields are used.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   target/arm/syndrome.h       | 16 ++++++++++++++++
>   target/arm/tcg/vfp_helper.c |  5 +----
>   2 files changed, 17 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

> 
> diff --git a/target/arm/syndrome.h b/target/arm/syndrome.h
> index 2e3121aec9c..4fbc35ce7b0 100644
> --- a/target/arm/syndrome.h
> +++ b/target/arm/syndrome.h
> @@ -251,6 +251,22 @@ FIELD(COPROC_ISS, OP2, 17, 3)
>   FIELD(COPROC_ISS, COND, 20, 4)
>   FIELD(COPROC_ISS, CV, 24, 1)
>   
> +static inline uint32_t syn_cp10_rt_trap(int cv, int cond, int opc1,
> +                                        int crn, int rt, int isread)
> +{
> +    uint32_t res = syn_set_ec(0, EC_FPIDTRAP);
> +    res = FIELD_DP32(res, SYNDROME, IL, 1);
> +
> +    res = FIELD_DP32(res, COPROC_ISS, CV, cv);
> +    res = FIELD_DP32(res, COPROC_ISS, COND, cond);
> +    res = FIELD_DP32(res, COPROC_ISS, OP1, opc1);
> +    res = FIELD_DP32(res, COPROC_ISS, CRN, crn);
> +    res = FIELD_DP32(res, COPROC_ISS, RT, rt);
> +    res = FIELD_DP32(res, COPROC_ISS, ISREAD, isread);
> +
> +    return res;
> +}
> +
>   static inline uint32_t syn_cp14_rt_trap(int cv, int cond, int opc1, int opc2,
>                                           int crn, int crm, int rt, int isread,
>                                           bool is_16bit)
> diff --git a/target/arm/tcg/vfp_helper.c b/target/arm/tcg/vfp_helper.c
> index 45f2eb0930f..e692bc568bd 100644
> --- a/target/arm/tcg/vfp_helper.c
> +++ b/target/arm/tcg/vfp_helper.c
> @@ -1359,10 +1359,7 @@ void HELPER(check_hcr_el2_trap)(CPUARMState *env, uint32_t rt, uint32_t reg)
>           g_assert_not_reached();
>       }
>   
> -    syndrome = ((EC_FPIDTRAP << ARM_EL_EC_SHIFT)
> -                | ARM_EL_IL
> -                | (1 << 24) | (0xe << 20) | (7 << 14)
> -                | (reg << 10) | (rt << 5) | 1);
> +    syndrome = syn_cp10_rt_trap(1, 0xe, 7, reg, rt, 1);
>   
>       raise_exception(env, EXCP_HYP_TRAP, syndrome, 2);
>   }


