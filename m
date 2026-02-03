Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2495AE83049
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 03:13:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vn6qI-00038s-4d; Mon, 02 Feb 2026 22:12:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vn6qC-00037f-FI
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 22:12:36 -0500
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vn6q8-0006qg-QG
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 22:12:35 -0500
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-82318b640beso2883174b3a.0
 for <qemu-devel@nongnu.org>; Mon, 02 Feb 2026 19:12:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770088351; x=1770693151; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=07V7MfFl/bioGoEebLtntbQdeaz9O9lILUnoX5oUsCg=;
 b=xnB5slQwB2mAM0zGXh1BUCpUc6wqyiYHQhxHbPZQIsWn+QkuNwVGYLhQlUv97Hn6SL
 AvbQ/YTLbCtdKJK/FGhh98O3cta2fy0sXghYtlXjcuS8Xn3zHBKunMPj1eDXEKrKHZTH
 /pB2gAEDcBq8CwWWC91c3mLYG4i6wti40HyClH0oIQgQYbTUE/zP1I7iJRFvJmkZ0f+D
 OXC0PLiOz4ocAJzh6Tkmj6Kkx8rK0aN+x94WmDuU080hXqG91J5eakEbu8Sh6dywRXQO
 hMJRaFf9/lAUXg7h863KRtCOSAZ18EyZ+e57VLRU5FP40Np83FWcpWA7H7jgLGu0xR7U
 6grA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770088351; x=1770693151;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=07V7MfFl/bioGoEebLtntbQdeaz9O9lILUnoX5oUsCg=;
 b=mwSgZ9oNkn5fcztWUDlrrSOl3M8ccv26qLQQsdXA4Xng0U7l6teFtYecu0fpRsO+oe
 vTd3/3UY8C1y0DPBl7iwwqdtVwyOxYXa3kJcY89oIoGd42Zp+toBEq8IJx1BZPuLWtPK
 Ykeg648LaLN7T7+O50+j+UgU6cSUV69dzluqeRcLLWaZE4ZhKwBIz0LnxWVfnXE3dTZe
 6N4OIPyhhDyGxYHELFov51JHWrCar+CV82YIYS+ih9eGxXl07vDqOVehpFrRuu+aBvBN
 uIsBMAkecz54yKjp3dyEFVUMCvAPSmXLJk/HaPjRgSkerMXQjCh4S4Bzqs8iwl0a01Ec
 chWA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVFPasTjCB6oT7LRP73ah7/4mw7BtdrJ+iqmG3FzkMdJnqtLeci59BPtUX9hMDlTIchEhC57aZ5ZNb0@nongnu.org
X-Gm-Message-State: AOJu0YzUXiFD1k5nlv1Frq9Fl5gGbpe7ve2vxkimCUfP/NzSZTsnay59
 25zwqtOWv8C5uYrAdQhA7LkaPveNbCuuBZx0WaVSbGe1x+AAnR/cOawJrsi4Eslvb8B18kDcnsB
 TrZI8uyipIA==
X-Gm-Gg: AZuq6aJpQDTcpf4XWyRxXwKqWDZbbbcneuAuwjhc2r6wbLrziaCaOW/A2w4Vz8RIvtN
 PMlB7d5DDFtl5yk8lXd0OscP9CKKCk5rmO7ArNlW4lrtog5Dz6jnEIG5D+P+pQgB6eYFZ4vibI3
 iqeTpJ3W2QdA8waHBkYqUxIjvyR10WkNWmSbfqW6yyvBv+1vtx4lKVNFzaKMcyb/tN9IfFP/X6H
 VMx9sV6rnAdZ36D4A33aD/ux2wwIFqc+dUlogGvHk6xJ07xyevsvmLWghvX9gyTYSqUOInlklcc
 YTEGDE4/tOjNBcnT8tKL5KrecvH2C4g1hUrrionTxa/rBIQVF82uHaPwXRPLfrY2Ip0z0ZXMLwf
 xrh4GGa8R5QPDgnJA7wwGp03DJaK4eMdmFkU2BtgPiGfqZLwE6J9dNalq9VZOqDxMXxQcmDr3U4
 faxD/xpkE187gJJWQCKjzwI09Cd71o9hyFaqPp8h43rTPKAcL0W4CZ5GRPIEgLUi61ezQCwSWxM
 m21tldefJQ=
X-Received: by 2002:a05:6a00:2d01:b0:81c:92ec:ccf3 with SMTP id
 d2e1a72fcca58-823aa43a5afmr15378833b3a.19.1770088350945; 
 Mon, 02 Feb 2026 19:12:30 -0800 (PST)
Received: from ?IPV6:2401:d002:dc0f:2100:1047:c02f:591b:6a5c?
 ([2401:d002:dc0f:2100:1047:c02f:591b:6a5c])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82379bfb924sm17821845b3a.34.2026.02.02.19.12.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Feb 2026 19:12:30 -0800 (PST)
Message-ID: <4bcf78f9-e2c3-4673-b7de-88ba7776e1a8@linaro.org>
Date: Tue, 3 Feb 2026 13:12:25 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/15] target/arm/tcg: Allow SVE RAX1 in SME2p1
 streaming mode
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20260202133353.2231685-1-peter.maydell@linaro.org>
 <20260202133353.2231685-5-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260202133353.2231685-5-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
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

On 2/2/26 23:33, Peter Maydell wrote:
> The SVE RAX1 instruction is permitted in SME streaming mode starting
> from SME2p1.  We forgot to allow this relaxation when we implemented
> SME2p1.
> 
> Cc: qemu-stable@nongnu.org
> Fixes: 7b1613a1020d2 ("target/arm: Enable FEAT_SME2p1 on -cpu max")
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/arm/tcg/translate-sve.c | 13 +++++++++++--
>   1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
> index 81f487152c..e853b4dd0a 100644
> --- a/target/arm/tcg/translate-sve.c
> +++ b/target/arm/tcg/translate-sve.c
> @@ -7803,8 +7803,17 @@ TRANS_FEAT_NONSTREAMING(SM4E, aa64_sve2_sm4, gen_gvec_ool_arg_zzz,
>   TRANS_FEAT_NONSTREAMING(SM4EKEY, aa64_sve2_sm4, gen_gvec_ool_arg_zzz,
>                           gen_helper_crypto_sm4ekey, a, 0)
>   
> -TRANS_FEAT_NONSTREAMING(RAX1, aa64_sve2_sha3, gen_gvec_fn_arg_zzz,
> -                        gen_gvec_rax1, a)
> +static bool trans_RAX1(DisasContext *s, arg_RAX1 *a)
> +{
> +    if (!dc_isar_feature(aa64_sve2_sha3, s)) {
> +        return false;
> +    }
> +    if (!dc_isar_feature(aa64_sme2p1, s)) {
> +        /* SME2p1 adds this as valid in streaming SVE mode */
> +        s->is_nonstreaming = true;
> +    }
> +    return gen_gvec_fn_arg_zzz(s, gen_gvec_rax1, a);
> +}
>   
>   TRANS_FEAT(FCVTNT_sh, aa64_sve2, gen_gvec_fpst_arg_zpz,
>              gen_helper_sve2_fcvtnt_sh, a, 0, FPST_A64)

I wonder if we should update sme-fa64.decode instead of handling this per-insn?

Anyway,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

