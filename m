Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59AD7C2A073
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Jan 2026 00:50:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vcYnM-00025l-G7; Sun, 04 Jan 2026 19:50:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vcYnK-00021p-DD
 for qemu-devel@nongnu.org; Sun, 04 Jan 2026 19:50:02 -0500
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vcYnI-0001lD-MA
 for qemu-devel@nongnu.org; Sun, 04 Jan 2026 19:50:02 -0500
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-34c718c5481so12912752a91.3
 for <qemu-devel@nongnu.org>; Sun, 04 Jan 2026 16:50:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767574199; x=1768178999; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=W+rnA2UjP5RGsGmtugtwXDtHoTR3QpzD7s4CXiG8aJ0=;
 b=pmSIPQQW/lHxkyy8aVzPXoXWC5qbNsgvdDPFUm9PO0LzXogEySIpUPsNqbniq3z++y
 YkmbiNJMjr1bM9hleggtSsHa66RP/lp2538e0IgzBDOpBdDQCTtUR6GFxiCgiH1/vIqi
 LjH8CYtItopZ9nO43AGwms3Da5sKe6C+D714x31dW4bgpfU9MY1hxIPNdMJ7+tSnCcPY
 olXF38cAxi8KM/3jb1V1wIiNxyQzxOw34hPkT/gDUeXM9QLy7m+1m8L8Hi5D+1PXSo7D
 lMQzezgMgSGpMC4RItKvSuZRh6ghs2LkpUd0LgjhRfzzexHYAWKzOg5MfszMyKUyca3x
 Enxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767574199; x=1768178999;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=W+rnA2UjP5RGsGmtugtwXDtHoTR3QpzD7s4CXiG8aJ0=;
 b=Tpg3iBF90aO5Xd1pJ0CCzeFXVELXiFA05WhLbj/JU3IQ3F46CZsjfqtzc+FvwScKWl
 BS7rR1Rgx+/TYDovSFB99SdWr5/XELECMaUazELme5LTNfXgWPrS6CcLpx6jE3WcVcJx
 DYgGSY+LDIY4kWhkWi6k9mipgAXJgq22FCdPtiMy6OIntKA+w+hx+BxChCeapipA9mIo
 roLVM/XwKdfnAeD9IrH3wffl9ONZb/E9N/2H+Hm2fKFvN+6JlQX7r7FhqMxGAHcK8DK6
 Uek6yKFfPSerEmkQrW8SZAwQ9FtIAmtFTZ65HdAI3ucDIPgXpv4/DJ6hqN1rN8uBKl3t
 8Psg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWSRAm9MTkNYtw2dNG7EmMx81kdvp1AySA2WRz9cIeZb0LVGUeYrYMVnmyqfIzRFYbgq0lHR+1zBbTo@nongnu.org
X-Gm-Message-State: AOJu0YzdM+d83x2MgbuRsZT8FzoCQkDGJprmfCdCt0jZaR8SwI0A+SuU
 simFRHWlCysOsehAhVCZx8UQdqaz9hkv37Am9vMoDgAIlE+kIcuwteMbwXoLo31cVoM=
X-Gm-Gg: AY/fxX6LHPD1HiOA3sT2CvlQkyeCH8+q2qDDTfGlXKsRZzdBFO805eNcl4KAmyTH9QX
 a3WUTdimaAN0VQkkaPg5OrabGprwOwnKsRRFNdTKcrri7l0hi0+i4Pz/rQuh7gL895vYzqkRWmj
 LRB4RYRvvL4ziyP+UiXNujo1De/Yyvy7U3BTGA+8+Bn0TOMeLvGCwCq8/56Fc3zblHL8RhXaADE
 NV2Wv2LsynRnoe3sYmgKgjSaCMxuwJEzSH79RCkWre81V+hN+O/J82msYFyH1Wg95PSug153+/L
 vxJ3xcIiV5bGJk1vRtPw9h8T+9ez5/Ix+cQt+DtPZqpUoCRWgtbP2bp4CHkKvSyfqTrXyxMGf+T
 Rp9IRBdSFrfChZuhdqTjMsa1VW12z/5o3c3ulLjSr/GLznfNMHoHxIttIjMAO2RrhqA59BIYmaH
 vB0bAjURSzNKTmVijKt3aJfAf5lRVg1A==
X-Google-Smtp-Source: AGHT+IEfi2+zqfskk89cSBQchQxdjyJGPTjmhU8frRT1H8NVtc2ncp3Amlq3YOep1ykt5oQmU1cQfA==
X-Received: by 2002:a17:90b:2fc5:b0:33b:a906:e40 with SMTP id
 98e67ed59e1d1-34e92137cd4mr34411767a91.2.1767574198766; 
 Sun, 04 Jan 2026 16:49:58 -0800 (PST)
Received: from [192.168.10.140] ([180.233.125.201])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-34f476fb86dsm4497910a91.8.2026.01.04.16.49.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 04 Jan 2026 16:49:58 -0800 (PST)
Message-ID: <03447f71-16d3-4ec4-b4a7-67df34bb8257@linaro.org>
Date: Mon, 5 Jan 2026 11:49:54 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-11.0] tcg/optimize: do use affected bits
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20251223163720.985578-1-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251223163720.985578-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1033.google.com
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

On 12/24/25 03:37, Paolo Bonzini wrote:
> Commit 932522a9ddc ("tcg/optimize: Fold and to extract during optimize",
> 2025-06-30) inadvertently disabled affected bits optimizations on
> operations that use fold_masks_zosa.  These happen relatively often
> in x86 code for extract/sextract; for example given the following:
> 
>     mov %esi, %ebp
>     xor $0x1, %ebp
> 
> the optimizer is able to simplify the "extract_i64 rbp,tmp0,$0x0,$0x20"
> produced by the second instruction to a move.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   tcg/optimize.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tcg/optimize.c b/tcg/optimize.c
> index f69702b26e8..c546e8910ba 100644
> --- a/tcg/optimize.c
> +++ b/tcg/optimize.c
> @@ -1102,7 +1102,7 @@ static bool fold_masks_zosa_int(OptContext *ctx, TCGOp *op,
>   static bool fold_masks_zosa(OptContext *ctx, TCGOp *op, uint64_t z_mask,
>                               uint64_t o_mask, int64_t s_mask, uint64_t a_mask)
>   {
> -    fold_masks_zosa_int(ctx, op, z_mask, o_mask, s_mask, -1);
> +    fold_masks_zosa_int(ctx, op, z_mask, o_mask, s_mask, a_mask);
>       return true;
>   }
>   

Queued, thanks.

r~

