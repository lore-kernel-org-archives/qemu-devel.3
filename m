Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3F99C19F32
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 17:41:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnhsZ-0004Ez-VK; Thu, 27 Feb 2025 12:40:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tnhsY-0004Eb-N6
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 12:40:58 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tnhsS-0001MB-Em
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 12:40:58 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-220f4dd756eso27862535ad.3
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2025 09:40:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740678050; x=1741282850; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TyZf1ul3PUNaNOTxhmqbnJL4CY5oAqr14HJOsJ2jKBc=;
 b=Jao1EvDvmXLkmWUC2shFClR+G8wGKP7uDI6JwTBIPCB5iMk4WjybWSjmZ93zH44zwW
 9g2Fe6MPvh1g2pQ0lIF+8Ha8WkosgeqefdYP/ytOPE//zsW6JIHvt2miSAKv0EvHzO8D
 blmIKWni/oRekbxaTmeECvCyUSp0ohQD37z60UcEUV1a/RDSdTykamCjLpamSKSzRFqU
 Exdxt22tfMb8jAA4uJydTB5CgFyoTzE+b0f6gUu37Nbflx/MvHgEe93eyerQXkjqHZW/
 hn4gJW06ZZUCwXABZ/zb6esNcxb0Hp9heWlOvUZSEpMgqj7NJhvJzgnVCQf/GJbUWYGu
 +Xjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740678050; x=1741282850;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TyZf1ul3PUNaNOTxhmqbnJL4CY5oAqr14HJOsJ2jKBc=;
 b=mE9Dzgyo6U1kG5/AxuXMuHzxQUwf67Yk2bWnCayxWEpcXt9nN21Y+/su1BDXaXZ/sp
 7SZJkBpU3vH3yJ97OOGFIs3NnqK6FNxZHagRGTZI8jboHztzr3jLd0ZXKy4GkxzI69WY
 qiAIU3OgVvknUkkcoSQ7c9oDakMNJgnodri7LUCUxszxCLEzcsuTZRrAyVuPidmQG40t
 zBd3ycdTeF5zbAl4y6jydwEvbomOmbCfbE8P+0nxl1d81s7SQV1cvE86EDSdXn3QBo5x
 mltoOxTaGnAukiDjFQnLpyoqPHir0P5qdlOPgwKK7/MtPlw1kbFRNE5eqA5v4RcRc5DT
 Lxpw==
X-Gm-Message-State: AOJu0Yw0jAG5MenpRRTISCeZcVhWl8VAF1WiAagIHHtOTP7ipS7I8hjx
 QiZELSQYgWgrxx94qZOuAQF2gHY34RGSPo74rSyuu2QH9OdvUAw/I0+xkE02wiArBFhpsBbeqpb
 3
X-Gm-Gg: ASbGnct/ksH5VgtUZ2/yObLuJXX3vHNCRoKTKFAJRYoNEHXbKW6ZEIr9WDIn9i1VjZh
 sCQUCrVJEXPrxXYZWD0ogIDguNuRsyNJghTGikacVEn3ZVfHGSFs9a3yXmVyQjv5YuMBR3pMpsN
 wkILVyqyxOk3DsQFNcP88HxaPG300xce4u1XWyBWG/7Aai8AS+Ar1ilbJYLPhqpvY+zChqYYmyn
 1+L+2YvzjtUu2Ds9X+RnTG4x5zxs3JgAR+qKV2xmpXupeAwt3J1b0UqB2WJSfICEjKSIVFhtmtW
 o62Hx5OoRQmfyOPH5J03q0VJ1T8pL15ZxlZ/wsMJvA2l8/p4zSxnJAfYlbBDSP7qSJr48ZkxNbY
 O7+lYnxc=
X-Google-Smtp-Source: AGHT+IHegkl/RUJfDSILjXWX5KhB3vPErE5853B6pildYUf9tdm/4x1XspJ9pJ5BXDwr+nMpGx1b0g==
X-Received: by 2002:a05:6a00:1248:b0:730:888a:252a with SMTP id
 d2e1a72fcca58-734ac42b53amr365880b3a.15.1740678049878; 
 Thu, 27 Feb 2025 09:40:49 -0800 (PST)
Received: from [10.254.143.227] (syn-156-019-246-023.biz.spectrum.com.
 [156.19.246.23]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7349fe2b821sm1941835b3a.25.2025.02.27.09.40.49
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Feb 2025 09:40:49 -0800 (PST)
Message-ID: <69ae459d-90ff-441d-a039-ae3ee15c919e@linaro.org>
Date: Thu, 27 Feb 2025 09:40:47 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] target/arm: Correct LDRD atomicity and fault behaviour
To: qemu-devel@nongnu.org
References: <20250227142746.1698904-1-peter.maydell@linaro.org>
 <20250227142746.1698904-2-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250227142746.1698904-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 2/27/25 06:27, Peter Maydell wrote:
> Our LDRD implementation is wrong in two respects:
> 
>   * if the address is 4-aligned and the load crosses a page boundary
>     and the second load faults and the first load was to the
>     base register (as in cases like "ldrd r2, r3, [r2]", then we
>     must not update the base register before taking the fault
>   * if the address is 8-aligned the access must be a 64-bit
>     single-copy atomic access, not two 32-bit accesses
> 
> Rewrite the handling of the loads in LDRD to use a single
> tcg_gen_qemu_ld_i64() and split the result into the destination
> registers. This allows us to get the atomicity requirements
> right, and also implicitly means that we won't update the
> base register too early for the page-crossing case.
> 
> Note that because we no longer increment 'addr' by 4 in the course of
> performing the LDRD we must change the adjustment value we pass to
> op_addr_ri_post() and op_addr_rr_post(): it no longer needs to
> subtract 4 to get the correct value to use if doing base register
> writeback.
> 
> STRD has the same problem with not getting the atomicity right;
> we will deal with that in the following commit.
> 
> Cc: qemu-stable@nongnu.org
> Reported-by: Stu Grossman <stu.grossman@gmail.com>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/arm/tcg/translate.c | 64 ++++++++++++++++++++++++--------------
>   1 file changed, 40 insertions(+), 24 deletions(-)
> 
> diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
> index d8225b77c8c..e10a1240c17 100644
> --- a/target/arm/tcg/translate.c
> +++ b/target/arm/tcg/translate.c
> @@ -5003,10 +5003,43 @@ static bool op_store_rr(DisasContext *s, arg_ldst_rr *a,
>       return true;
>   }
>   
> +static void do_ldrd_load(DisasContext *s, TCGv_i32 addr, int rt, int rt2)
> +{
> +    /*
> +     * LDRD is required to be an atomic 64-bit access if the
> +     * address is 8-aligned, two atomic 32-bit accesses if
> +     * it's only 4-aligned, and to give an alignemnt fault
> +     * if it's not 4-aligned.
> +     * Rt is always the word from the lower address, and Rt2 the
> +     * data from the higher address, regardless of endianness.
> +     * So (like gen_load_exclusive) we avoid gen_aa32_ld_i64()
> +     * so we don't get its SCTLR_B check, and instead do a 64-bit access
> +     * using MO_BE if appropriate and then split the two halves.
> +     *
> +     * This also gives us the correct behaviour of not updating
> +     * rt if the load of rt2 faults; this is required for cases
> +     * like "ldrd r2, r3, [r2]" where rt is also the base register.
> +     */
> +    int mem_idx = get_mem_index(s);
> +    MemOp opc = MO_64 | MO_ALIGN_4 | MO_ATOM_SUBALIGN | s->be_data;

The 64-bit atomicity begins with armv7 + LPAE, and not present for any m-profile.
Worth checking ARM_FEATURE_LPAE, or at least adding to the comment?

Getting 2 x 4-byte atomicity, but not require 8-byte atomicity, would use 
MO_ATOM_IFALIGN_PAIR.

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

