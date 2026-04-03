Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6770E88D61
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2026 21:09:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8lkp-0001nT-4f; Fri, 03 Apr 2026 17:08:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w8lkm-0001mS-TD
 for qemu-devel@nongnu.org; Fri, 03 Apr 2026 17:08:32 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w8lki-0002fE-SD
 for qemu-devel@nongnu.org; Fri, 03 Apr 2026 17:08:30 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-35d9c7bf9a1so1908701a91.3
 for <qemu-devel@nongnu.org>; Fri, 03 Apr 2026 14:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775250506; x=1775855306; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jttZ3IIBfWqIL7L8dJ+GaVUkqKW41vKE1ZXRoz/4S9w=;
 b=CGxtjsQZrJhn/Cf2/lp61D5gao1RmnvzeSVZ5ni8Zp5ArfxwQWgkcVu7q/CsfYY13G
 eJYRkRAXvsVDJFp9KN2UrIYjz3eKJuTNst/xA3iiuwH8keYxskAOebrkOQJrCCpZIT1j
 0tl89lCwYt909O6wWKV1RlMyMahEYUmlCzhg7uqkg+o7YeGXI1abMEAUYi4CLmSn+qGb
 XxXkssvJ0ves/Un0e/9c2X5NQU0GwnITbOXQQ2AUwaI2EG3mFdCQWzPRpFwGBjhZUMmL
 WnExqRIfK2Lai7G71u+Bai7VBtKluuf5g8OQD3zF4lawlRMwM17wDcFodzZ8E5GlI+wD
 L2pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775250506; x=1775855306;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jttZ3IIBfWqIL7L8dJ+GaVUkqKW41vKE1ZXRoz/4S9w=;
 b=O+bqGInFrq6j4V4DfdSQOfBXtOWmoqihx1sTwDpg2Mz4CPlv+UmNsbgSpdXO8RsVNn
 AQOcSfmxX3WMx8gF6tiZfDhPea+WvCo9DdNQntt+ymRana5/CT2K0JbtcslSA9Na4pNX
 5BNDn5ajSDb/y71Uca+Luai5Y5WyWd9veg8fjJxVR7RSXi7QhJ1DtnM6ZoRT0XIcsiYB
 nFPH7yNGg6PJFHhgFTUo3h917oiio1kNYSYIogcrKiOH5oxeuA27XB+sb8Ss9LXB2VKT
 7o4Fl4uQmdLjfZrp8x3xHtRtVsF0HHZqsdmWhXVAySJjPcIWGGTlLDNNXMF9wCYEUz7t
 D/Aw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVdJyl/DKlS8VMY3JdhO/Vf1xIPNzh2mW54vrE0iOZdXNmYZgqYEKdOIrVxU+vCzHMYKYAm5TRKMbGd@nongnu.org
X-Gm-Message-State: AOJu0YygL9fK/6W9oSX1uCkJbgKkxp6P5qG3tnhZU6qkOz2Pi7fqWF0B
 vu/7LgD2GslshQF7ByP5mqwOIWtRC2+fG6gkuoPFGkcWOxfGl2TzNqRJJ4+5+ptHKa4=
X-Gm-Gg: AeBDieuYQIfia9ebl1gL9mCfvDSIJD/7XCPYKYzfGaKmhjw+jRxVJy4H11z3QNIdtri
 SNG5J5ponXEeS3XdTIH5Qqs43PJIu7dMoMKnAxoRfF0cBM0IL/pg6nrVKV93iWvEg1/aJZ0DK5a
 eVOdzyOMpBKQC8C5a2cqgDgfFaFA0vdfti768gIx+GURvI/5/ylK8uRXpFmghv69w0IAGPimegS
 5Fu7Yy2GMjpeQw7Hv+E/nCaM7R5RRihuXpV6XRpQMYjneskUGXcggqqAMfRWCChiNsRl7E5vv/R
 jntofPXYkgkPeCSEE+FXw9Cbbhds2j0qrdEDYyt3c7kVxobWet2T0z1r90EXh+aW4H28hwAjEcn
 79I/K0AE73m5zxU6DceBl+xdsoqjEW6Rvqp1E3QcvMCqEzXF7a3B3NuSJG3NKLPWJeoQ+Oy/azO
 6eQmDDlfWcDLlx7J8XyD0h70IZR+CEuF9r8mWfKT/foTDGeydDi2XG7ODMtXxeQ56F82w=
X-Received: by 2002:a17:90b:314d:b0:359:f43d:4a6e with SMTP id
 98e67ed59e1d1-35de662f67fmr4064794a91.0.1775250506065; 
 Fri, 03 Apr 2026 14:08:26 -0700 (PDT)
Received: from [192.168.1.105] (124-150-69-109.tpgi.com.au. [124.150.69.109])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35dd367bfbcsm6285829a91.12.2026.04.03.14.08.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Apr 2026 14:08:25 -0700 (PDT)
Message-ID: <27c6d754-9139-4758-b92c-af3302a2d425@linaro.org>
Date: Sat, 4 Apr 2026 07:08:18 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 06/12] target/arm/tcg/translate-neon.c: make
 compilation unit common
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 jim.macarthur@linaro.org, philmd@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20260401192057.1182724-1-pierrick.bouvier@linaro.org>
 <20260401192057.1182724-7-pierrick.bouvier@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260401192057.1182724-7-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102e.google.com
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

On 4/2/26 05:20, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   target/arm/tcg/meson.build | 10 ++++++++--
>   1 file changed, 8 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

> 
> diff --git a/target/arm/tcg/meson.build b/target/arm/tcg/meson.build
> index 5f33ecd76e0..8d9112f6da2 100644
> --- a/target/arm/tcg/meson.build
> +++ b/target/arm/tcg/meson.build
> @@ -10,10 +10,13 @@ vfp_d = [
>     decodetree.process('vfp-uncond.decode', extra_args: '--decode=disas_vfp_uncond'),
>   ]
>   
> -gen_a32 = [
> +neon_d = [
>     decodetree.process('neon-shared.decode', extra_args: '--decode=disas_neon_shared'),
>     decodetree.process('neon-dp.decode', extra_args: '--decode=disas_neon_dp'),
>     decodetree.process('neon-ls.decode', extra_args: '--decode=disas_neon_ls'),
> +]
> +
> +gen_a32 = [
>     decodetree.process('m-nocp.decode', extra_args: '--decode=disas_m_nocp'),
>     decodetree.process('mve.decode', extra_args: '--decode=disas_mve'),
>     decodetree.process('a32.decode', extra_args: '--static-decode=disas_a32'),
> @@ -32,7 +35,6 @@ arm_ss.add(files(
>     'translate.c',
>     'translate-m-nocp.c',
>     'translate-mve.c',
> -  'translate-neon.c',
>     'm_helper.c',
>     'mve_helper.c',
>     'op_helper.c',
> @@ -63,6 +65,7 @@ arm_common_ss.add(files(
>   ))
>   
>   arm_common_system_ss.add(
> +  neon_d,
>     vfp_d,
>     files(
>     'cpregs-at.c',
> @@ -72,17 +75,20 @@ arm_common_system_ss.add(
>     'psci.c',
>     'tlb_helper.c',
>     'tlb-insns.c',
> +  'translate-neon.c',
>     'translate-vfp.c',
>     'vec_helper.c',
>     'vfp_helper.c',
>   ))
>   arm_user_ss.add(
> +  neon_d,
>     vfp_d,
>     files(
>     'debug.c',
>     'hflags.c',
>     'neon_helper.c',
>     'tlb_helper.c',
> +  'translate-neon.c',
>     'translate-vfp.c',
>     'vec_helper.c',
>     'vfp_helper.c',


