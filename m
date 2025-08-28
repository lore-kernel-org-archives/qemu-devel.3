Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A509CCA0EED
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 17:25:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urgII-0006q7-Jj; Thu, 28 Aug 2025 13:20:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1urbvL-0003bV-Fg
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 08:40:18 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1urbvI-00062B-MV
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 08:40:14 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-afe775db944so294843766b.1
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 05:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756384810; x=1756989610; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AlIvv6RMizbq/9wRX53R6SQBitlqtBGFxJsGtLvgQaI=;
 b=ZmWXeyen+m28ek+b8lhb9jEtyl0A4VopzSuaOawQXrZEYa599fEf/pDLarc35XUS4t
 vbV2P2H7PuuDqmdJWpDaaoIPaJec/Qcrea6QUHjW5FU17g19cILq/k2WWOBj+MgRxKGg
 hR8266KKxjq8UNluk2FgBery7rCpPG9bAjDJBODR1N8SQTzNRUNPYy/tB+vesHT+ueTX
 74XiOgdN3YomYOLSzDasSflnx9jV71y0sCTs6mOCcH92jU3/9nK21wkqNqhoFCTZ/Fik
 QUXf4K5tFwmOuU9/PONZkjos7wtcItPIE3uEzn8X4o6fTGRpfdesfOYLAgK+E4mrs9XW
 jJbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756384810; x=1756989610;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AlIvv6RMizbq/9wRX53R6SQBitlqtBGFxJsGtLvgQaI=;
 b=pMc/xWznxIHPppLa/pwkC5pPMRhHSL/cQlccCBWEuSUoOWLC0cPVpXPpH//FfALngy
 a3gHL0VvNSHhS67U9Kzf8DnMxfqRYi0+J3Fqbj07ndQ4gSolvPlk8vtsPpR7xxgO5wVV
 Qzrnr/qjzyztPwX/t5gUmg9ty1SaSKT0B9i8CH9JcG47mPJshqCvMfTUWq0f3zwO3R43
 qH0GkX3ptZ6H/NWfMPDyAArpRMcOoOyP+8IM0DdE+D6Z9ParoFGPOlyQFent+zNnrg+0
 OXKpC96l+ZzzlIeRghJaanMu+LKxr77z4fyyF5IjLTdyJmvuM22juCsabexyOkBxqdUr
 NyrA==
X-Gm-Message-State: AOJu0Ywg4egmAUiHaW9mnMwBHYnVNmwS/PVWxCIDMHt45G8XWS80XbiB
 EBnTw6QLWRwudLwhCQpTyta6vCk2aHoi+86/oCLjSJUm70zpwLAKvs4zEOlRz2u02lQBp+nXc40
 5hz9R9TjtBMihQTXYjwC9KKAx1tq0VKSYrcNCThXKmQ==
X-Gm-Gg: ASbGncsCiaDCEc7VFHWDWaxix6OEtQjwj+iYY6vrYDZCrOHJd/Hel1gY31BFrUtsg8v
 HK1YVlpvIENI3ImXtDL+XR7SFjw9FTdleEX0rrf6CtXXknThCMVByz4ohx4OCU1L0QDSd8mNg2S
 1j2W9uDvubx3GLpiOlWXsXuRaBcbd7G57/pwWqtQnSL9aUK4E4kxftiZHX8Z/XmaGN76VMSCbjP
 +sFbZPXPU9gl1qZNQFhmfCfAS+blw==
X-Google-Smtp-Source: AGHT+IHGrQlnN89D5g1kHrKr2djF/XTjDycItYNHa7sxSPqMpoyHP32Fmlm3WV+XCLR3lPudwbNzd4E7E/LrYusiRqM=
X-Received: by 2002:a17:906:1c02:b0:afe:d5bb:f444 with SMTP id
 a640c23a62f3a-afed5bc15a2mr254275666b.32.1756384810210; Thu, 28 Aug 2025
 05:40:10 -0700 (PDT)
MIME-Version: 1.0
References: <20250827010453.4059782-1-richard.henderson@linaro.org>
 <20250827010453.4059782-38-richard.henderson@linaro.org>
In-Reply-To: <20250827010453.4059782-38-richard.henderson@linaro.org>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Thu, 28 Aug 2025 15:39:43 +0300
X-Gm-Features: Ac12FXy6xrXQr6fme5Wny4aNUq8j3m5PZIPtB69qIzWe-3BEw8_Z3FkYInlqsLo
Message-ID: <CAAjaMXb1KMo9h=nz8+P3ddzHnFiLTgcXju4hW5ZoQqsym+xZdw@mail.gmail.com>
Subject: Re: [PATCH 33/61] target/arm: Redirect VHE FOO_EL1 -> FOO_EL2 during
 translation
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x632.google.com
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

On Wed, Aug 27, 2025 at 4:11=E2=80=AFAM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/cpregs.h            |  6 ++++
>  target/arm/gdbstub.c           |  5 ++++
>  target/arm/helper.c            | 53 +---------------------------------
>  target/arm/tcg/translate-a64.c |  9 ++++++
>  4 files changed, 21 insertions(+), 52 deletions(-)
>
> diff --git a/target/arm/cpregs.h b/target/arm/cpregs.h
> index 7bdf6cf847..d34ed0d40b 100644
> --- a/target/arm/cpregs.h
> +++ b/target/arm/cpregs.h
> @@ -911,6 +911,12 @@ struct ARMCPRegInfo {
>       */
>      uint32_t nv2_redirect_offset;
>
> +    /*
> +     * With VHE, with E2H, at EL2, access to this EL0/EL1 reg redirects
> +     * to the EL2 reg with the specified key.
> +     */
> +    uint32_t vhe_redir_to_el2;
> +
>      /* This is used only by VHE. */
>      void *opaque;
>      /*
> diff --git a/target/arm/gdbstub.c b/target/arm/gdbstub.c
> index e2fc389170..3727dc01af 100644
> --- a/target/arm/gdbstub.c
> +++ b/target/arm/gdbstub.c
> @@ -249,6 +249,11 @@ static int arm_gdb_get_sysreg(CPUState *cs, GByteArr=
ay *buf, int reg)
>      if (ri) {
>          switch (cpreg_field_type(ri)) {
>          case MO_64:
> +            if (ri->vhe_redir_to_el2 &&
> +                (arm_hcr_el2_eff(env) & HCR_E2H) &&
> +                arm_current_el(env) =3D=3D 2) {
> +                ri =3D get_arm_cp_reginfo(cpu->cp_regs, ri->vhe_redir_to=
_el2);
> +            }
>              return gdb_get_reg64(buf, (uint64_t)read_raw_cp_reg(env, ri)=
);
>          case MO_32:
>              return gdb_get_reg32(buf, (uint32_t)read_raw_cp_reg(env, ri)=
);
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index d0ccc23811..3f69ce6cb5 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -4441,47 +4441,6 @@ static CPAccessResult access_el1nvvct(CPUARMState =
*env, const ARMCPRegInfo *ri,
>      return e2h_access(env, ri, isread);
>  }
>
> -/* Test if system register redirection is to occur in the current state.=
  */
> -static bool redirect_for_e2h(CPUARMState *env)
> -{
> -    return arm_current_el(env) =3D=3D 2 && (arm_hcr_el2_eff(env) & HCR_E=
2H);
> -}
> -
> -static uint64_t el2_e2h_read(CPUARMState *env, const ARMCPRegInfo *ri)
> -{
> -    CPReadFn *readfn;
> -
> -    if (redirect_for_e2h(env)) {
> -        /* Switch to the saved EL2 version of the register.  */
> -        ri =3D ri->opaque;
> -        readfn =3D ri->readfn;
> -    } else {
> -        readfn =3D ri->orig_readfn;
> -    }
> -    if (readfn =3D=3D NULL) {
> -        readfn =3D raw_read;
> -    }
> -    return readfn(env, ri);
> -}
> -
> -static void el2_e2h_write(CPUARMState *env, const ARMCPRegInfo *ri,
> -                          uint64_t value)
> -{
> -    CPWriteFn *writefn;
> -
> -    if (redirect_for_e2h(env)) {
> -        /* Switch to the saved EL2 version of the register.  */
> -        ri =3D ri->opaque;
> -        writefn =3D ri->writefn;
> -    } else {
> -        writefn =3D ri->orig_writefn;
> -    }
> -    if (writefn =3D=3D NULL) {
> -        writefn =3D raw_write;
> -    }
> -    writefn(env, ri, value);
> -}
> -
>  static uint64_t el2_e2h_e12_read(CPUARMState *env, const ARMCPRegInfo *r=
i)
>  {
>      /* Pass the EL1 register accessor its ri, not the EL12 alias ri */
> @@ -4657,17 +4616,7 @@ static void define_arm_vh_e2h_redirects_aliases(AR=
MCPU *cpu)
>                                   (gpointer)(uintptr_t)a->new_key, new_re=
g);
>          g_assert(ok);
>
> -        src_reg->opaque =3D dst_reg;
> -        src_reg->orig_readfn =3D src_reg->readfn ?: raw_read;
> -        src_reg->orig_writefn =3D src_reg->writefn ?: raw_write;
> -        if (!src_reg->raw_readfn) {
> -            src_reg->raw_readfn =3D raw_read;
> -        }
> -        if (!src_reg->raw_writefn) {
> -            src_reg->raw_writefn =3D raw_write;
> -        }
> -        src_reg->readfn =3D el2_e2h_read;
> -        src_reg->writefn =3D el2_e2h_write;
> +        src_reg->vhe_redir_to_el2 =3D a->dst_key;
>      }
>  }
>  #endif
> diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a6=
4.c
> index 8303f0dac2..8fcc74d151 100644
> --- a/target/arm/tcg/translate-a64.c
> +++ b/target/arm/tcg/translate-a64.c
> @@ -2573,6 +2573,15 @@ static void handle_sys(DisasContext *s, bool isrea=
d,
>          }
>      }
>
> +    if (ri->vhe_redir_to_el2 && s->current_el =3D=3D 2 && s->e2h) {
> +        /*
> +         * This one of the FOO_EL1 registers which redirect to FOO_EL2
> +         * from EL2 when HCR_EL2.E2H is set.
> +         */
> +        key =3D ri->vhe_redir_to_el2;
> +        ri =3D redirect_cpreg(s, key, isread);
> +    }
> +
>      if (ri->accessfn || (ri->fgt && s->fgt_active)) {
>          /* Emit code to perform further access permissions checks at
>           * runtime; this may result in an exception.
> --
> 2.43.0
>
>

This looks much better

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

