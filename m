Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 910E3C77B7F
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Jun 2025 12:23:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTgCO-0004ti-Ok; Mon, 23 Jun 2025 08:22:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uTgB6-0004BG-2A
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 08:21:40 -0400
Received: from mail-yb1-xb31.google.com ([2607:f8b0:4864:20::b31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uTgB4-0001Fr-02
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 08:21:35 -0400
Received: by mail-yb1-xb31.google.com with SMTP id
 3f1490d57ef6-e733cd55f9eso3393828276.1
 for <qemu-devel@nongnu.org>; Mon, 23 Jun 2025 05:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750681292; x=1751286092; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Rb0Nma2Ov+KRCaB1a/tt2nPEQS4hhjWwzL/eYwV/cWM=;
 b=XyvbtL6sOGGRtuQc30PUGfX6DFAOE8+9B/l34feMOerYrmH2Y4k9z7srHsOzbuahY2
 HReiNiP2WaXmZfranBQNfye5dOrT+m8cuVIV+M0MDLMy9N1fsy01vJi5wmIZ/0KkflAn
 MOMdnWDSrr+xBiL1SP4IYgrFg6yFHQoHRQbX4wbPiosVVTw0pcscVISoZ9tt0w+EQx9y
 E618teqrs600ANrzMYUBYWYCSkzAZz6b+UrH5rARK8Em42Gpkxw8HGwN1HrvvbEkeDjW
 wLYmMymqPBWkLB11VjMo1QYAH4PtFE35c0T2NaKlSXeHjpQwNrESA4/ypGVFiSOVDh4t
 WCqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750681292; x=1751286092;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Rb0Nma2Ov+KRCaB1a/tt2nPEQS4hhjWwzL/eYwV/cWM=;
 b=IVYCdLIGXx+Uan/eU9ej3+j4zEVrF0yBrcXjqDefdtsZgwK2lCrGtG0RDVbGpt5VWC
 FNO0IKlm2RyLoWYPAB0R5BPoU+DB1G3EiXbeAc7St8RiYNpXcgRRXSM/EWz4nSHj/Kgf
 Ufwr4SF7BSglqClndrqg2jj8iAggA5vqLWaXnBIgx6AWtJwn/RfytnsWlTEdwxYa8uGT
 n0k86bcHCYP6fZmszmY0zu9fneUQZoFVHDnzUZ/RTDz6VumdhwJwhy51u7XHD8a+6NPZ
 bXCODHbrIQ8b3arylnnkoblbpe/kClrFt/8rqmS7+6gUaq8m0hJOPAo2XXUvNrv4f/sg
 wgFg==
X-Gm-Message-State: AOJu0YxV9oA7wmDyquKtmkxWev3ZXThonYh2Rm1Vt15FDICSayVQZSx+
 Cbq3LlXQTXtNt1iIweysNhyKYzSbtnq7vYrPDDJisPyfGPEoEup4UNTD1A9pG2exxIbxwAsdb94
 t0ISOQtzTbEOylvpjdzwdY7ubysBrkIfHGJ9N4c+kyA==
X-Gm-Gg: ASbGnctc2r1lokeojVeA2IynkVrID+zE6HNuZIzmNS6aaR/w5FKtFrAUn0x7c3aq9Ic
 etd2iIAv1DAXWJl1fIj5VdNt6NEokB2dm+sZmQSPJAnklqCl9Wj0x4GRgYupOv2jSM51AceI3J8
 srqOqChKigXDHUmyRJugK8ulv6pLMmS0HGKDqNVJ2E/JW6kLdiBbjkcKA=
X-Google-Smtp-Source: AGHT+IEWkEOs1FUN9pDS+WmPfJkRUoV4mUwdi+3ZOeedhjKVQ/rBpaVhv3/yppF2m2JWfb118GKbaNDnn+FapzSA5i0=
X-Received: by 2002:a05:690c:48c8:b0:710:f470:154f with SMTP id
 00721157ae682-712c68cc6f4mr166474107b3.34.1750681292144; Mon, 23 Jun 2025
 05:21:32 -0700 (PDT)
MIME-Version: 1.0
References: <20250621235037.74091-1-richard.henderson@linaro.org>
 <20250621235037.74091-20-richard.henderson@linaro.org>
In-Reply-To: <20250621235037.74091-20-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 23 Jun 2025 13:21:20 +0100
X-Gm-Features: AX0GCFtUox1z6NVCNoCfZ5etV7T-qLXfCYfxh8rYKhT4qotk1lO8Ll5HWWXSRd8
Message-ID: <CAFEAcA98aZhdE6=564tB0bn8DvStzHrM6ihn=duvdTJhoodwOA@mail.gmail.com>
Subject: Re: [PATCH v2 019/101] target/arm: Implement SME2 LDR/STR ZT0
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b31;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb31.google.com
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

On Sun, 22 Jun 2025 at 00:52, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/translate-sme.c | 12 ++++++++++++
>  target/arm/tcg/sme.decode      |  6 ++++++
>  2 files changed, 18 insertions(+)
>
> diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
> index 37f4d341f0..8b0a33e2ae 100644
> --- a/target/arm/tcg/translate-sme.c
> +++ b/target/arm/tcg/translate-sme.c
> @@ -291,6 +291,18 @@ static bool do_ldst_r(DisasContext *s, arg_ldstr *a, GenLdStR *fn)
>  TRANS_FEAT(LDR, aa64_sme, do_ldst_r, a, gen_sve_ldr)
>  TRANS_FEAT(STR, aa64_sme, do_ldst_r, a, gen_sve_str)
>
> +static bool do_ldst_zt0(DisasContext *s, arg_ldstzt0 *a, GenLdStR *fn)
> +{
> +    if (sme2_zt0_enabled_check(s)) {
> +        fn(s, tcg_env, offsetof(CPUARMState, za_state.zt0),
> +           sizeof_field(CPUARMState, za_state.zt0), a->rn, 0);
> +    }
> +    return true;
> +}
> +
> +TRANS_FEAT(LDR_zt0, aa64_sme2, do_ldst_zt0, a, gen_sve_ldr)
> +TRANS_FEAT(STR_zt0, aa64_sme2, do_ldst_zt0, a, gen_sve_str)

The alignment check the pseudocode requires happens inside
gen_sve_ldr/str, right? I don't entirely understand why, though,
because those functions don't seem to use MO_ALIGN.

Anyway, given that these insns have the same alignment
check requirement as the SVE LDR (vector) and SME LDR (array vector)
this patch is fine:

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

