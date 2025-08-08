Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 747B1C87FD3
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Aug 2025 13:53:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukM6a-0005DI-Kb; Fri, 08 Aug 2025 08:21:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ukM6Q-00057z-Aq
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 08:21:45 -0400
Received: from mail-yw1-x112e.google.com ([2607:f8b0:4864:20::112e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ukM6O-00025h-Fq
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 08:21:42 -0400
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-71a38e35674so12366447b3.3
 for <qemu-devel@nongnu.org>; Fri, 08 Aug 2025 05:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754655695; x=1755260495; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8F9FDswivwS1Mi8z9vaCJzGrmOPEYpSX6hOtic20iHM=;
 b=lssIg92eRMZczMS8QRdq8UnD1/rkrteo0OiISn0DSXgHxg0ngGNO1MwndXWjjs/Oyc
 vf+JcRbeMm97S8BSsoEPydYhrTH/Fy8o5aSGSQA/ym7+dbPMpH27jVJLjxL4bAn7Oc1R
 wUQ0LPu/ewpwWgfwgSAEOrrSRrtg7OvWfv/SQDmc5z0vBtMHUKSVK7dJqAZj7af5pIcV
 Bm2jvoa4+t6kmZsC88qeQkCCuCDwQDkwihct8oSyp8wtkflIZOeXVYVMchfWVV89d8LO
 JO3rvL/4ZdBBneerCTgZ4ygom5soUUs064KBPPTDDEu8UdmDKqa5VggzK5fWROIFayBY
 EgbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754655695; x=1755260495;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8F9FDswivwS1Mi8z9vaCJzGrmOPEYpSX6hOtic20iHM=;
 b=U8x+r4Mmyafr4KDtDiDR0eojkTFzkdXcpFBbC/0BNXrm8N740MiAPOMvcxQ1/0tV49
 d11zzjF2DRh542bOkJvxE9zZWWJTdAccMJ5xnSV9fwZGpUUkYTCH8CAoIOwy4cSehKhf
 trPaSu0noSjhaY+LHKdKomVgjySULP3hvBYt33VDD5t7L4Hoa5JkhyE6XDRgdwt57foC
 Nb+A5QsGm+CSEgR/k7aLa8pyld2ttX5t9C+wmJzrFN6knIiXF6eMb+Bq2LPpb9tt/On0
 9pFnzeKw9V7qK5HUAuoG9mQb73Fo8MGXcbJpd6r+YIXJ8dX6RiIqzPj9h0UB7CWdxZt1
 SQZQ==
X-Gm-Message-State: AOJu0Yx06IygnwxhIIm8riQog846VECWdQgmGb5JxJIXA/dr48fRVI1X
 qwfiSSG6wV2PeF34tkViX0NTeCuyb1nPEc38wKb/soikbMedA8hW59I2VF/m9rb2znGnhxeBZcO
 8PW7mvDrToUeQXAToHeHThIHfvNlfZ+9CxWa3TurUww==
X-Gm-Gg: ASbGncuWAV23EV0WRg4dYX6upiJuiIjg9TPyW5huVN1Un8/wdQUSeegNxPENOaJP5It
 hxF9+sDR5zPLW6eh/pUiESREKdlo7SnOumHv95hkcLpQqX9EZ+Eb1fw2gEVUMNzX2X4wX7C2HwL
 fsUI37PhX3rggoI+eOet4b7J+RDnF4lTkeB4TaUB9Uaiz38T7rr3EXgezU2iB/ejmmEXAvHPI/8
 j/fFSfk
X-Google-Smtp-Source: AGHT+IFX9bd8QrjP0rnKXtwQbA1zirN/jJhEf5xEt8ztbTJ6iiY7kG6DC3II3kv/lVbxQvwseS7lwLcYQcGXbZ4OrV0=
X-Received: by 2002:a05:690c:4803:b0:71a:1f26:5d1a with SMTP id
 00721157ae682-71bf0d43708mr31205257b3.11.1754655694726; Fri, 08 Aug 2025
 05:21:34 -0700 (PDT)
MIME-Version: 1.0
References: <20250808-gdbstub-aarch64-pstate-regs-v1-0-14ba70be1b3d@linaro.org>
 <20250808-gdbstub-aarch64-pstate-regs-v1-1-14ba70be1b3d@linaro.org>
In-Reply-To: <20250808-gdbstub-aarch64-pstate-regs-v1-1-14ba70be1b3d@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 8 Aug 2025 13:21:22 +0100
X-Gm-Features: Ac12FXzJETIc1VKPT2wtH5yDYjrceRr5w5RBhZbijP3oMufqLUQhi9JnkEODfjc
Message-ID: <CAFEAcA-2Zt7HTDX_bdBHjJyQS7o=csE1x6eDymyEPkV3K+pXrg@mail.gmail.com>
Subject: Re: [PATCH 1/4] gdbstub/aarch64: add CurrentEL register
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112e.google.com
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

On Fri, 8 Aug 2025 at 12:30, Manos Pitsidianakis
<manos.pitsidianakis@linaro.org> wrote:
>
> Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> ---
>  gdb-xml/aarch64-core.xml | 5 +++++
>  target/arm/cpu.h         | 1 +
>  target/arm/gdbstub64.c   | 6 ++++++
>  3 files changed, 12 insertions(+)
>
> diff --git a/gdb-xml/aarch64-core.xml b/gdb-xml/aarch64-core.xml
> index b8046510b9a085d30463d37b3ecc8d435f5fb7a4..19ad743dc5607b4021fb795bfb9b8e9cf0adef68 100644
> --- a/gdb-xml/aarch64-core.xml
> +++ b/gdb-xml/aarch64-core.xml
> @@ -91,4 +91,9 @@
>    </flags>
>    <reg name="cpsr" bitsize="32" type="cpsr_flags"/>
>
> +  <flags id="current_el_flags" size="8">
> +    <!-- Exception Level.  -->
> +    <field name="EL" start="2" end="3"/>
> +  </flags>
> +  <reg name="CurrentEL" bitsize="64" type="current_el"/>
>  </feature>
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index dc9b6dce4c92297b2636d0d7c0dce580f1806d5b..c3070cd9863381fac40f5640e0a7a84dfa1c6e06 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -1473,6 +1473,7 @@ void pmu_init(ARMCPU *cpu);
>   * AArch32 mode SPSRs are basically CPSR-format.
>   */
>  #define PSTATE_SP (1U)
> +#define PSTATE_EL (3U << 2)
>  #define PSTATE_M (0xFU)
>  #define PSTATE_nRW (1U << 4)
>  #define PSTATE_F (1U << 6)
> diff --git a/target/arm/gdbstub64.c b/target/arm/gdbstub64.c
> index 08e28585396816ab90d6d8e460ff8171892fe8da..16b564e1a970cb5e854a705619f71ffc61545a73 100644
> --- a/target/arm/gdbstub64.c
> +++ b/target/arm/gdbstub64.c
> @@ -48,6 +48,9 @@ int aarch64_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
>          return gdb_get_reg64(mem_buf, env->pc);
>      case 33:
>          return gdb_get_reg32(mem_buf, pstate_read(env));
> +    case 34:
> +        /* CurrentEL */
> +        return gdb_get_reg64(mem_buf, env->pstate & PSTATE_EL);
>      }

The debugger already has this information in the 'cpsr'
register, so it could implement convenience views of
the subfields itself if it liked.

If we're going to do this I would prefer it to be because
we've gained some consensus with e.g. the gdb maintainers
that this is the "preferred" way to expose the CPU state.
The XML config stuff lets us do it in our own way if we
want to, but I think there is value in consistency across
stubs here.

thanks
-- PMM

