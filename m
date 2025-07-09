Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F37FC83F03
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Jul 2025 06:37:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZOOj-0004Dd-PD; Wed, 09 Jul 2025 02:35:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uZONh-0003uh-Fd
 for qemu-devel@nongnu.org; Wed, 09 Jul 2025 02:34:30 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uZONb-0000DB-7H
 for qemu-devel@nongnu.org; Wed, 09 Jul 2025 02:34:10 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-60c01b983b6so1203896a12.0
 for <qemu-devel@nongnu.org>; Tue, 08 Jul 2025 23:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752042844; x=1752647644; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3RhvjbPOtBMHAj5bLY/qMrZX4SI68G+AtrqZhXIdYK0=;
 b=uqXQVUii+ipEMexwieN1urzZya/mi1uI59zHYsEu3h5ZLOou4HeIUCjAN6KGP4/kcJ
 Yq6IVBcc0UR9rlMHmSXgU02fe1Ffna2mrLkq/R0iJILskYBrYlUUXAsyVpZFYDjuh3mk
 TuSEO5AYVICX0ol9DZvb2xqwwrzrjE3cTUDEFSGy+4C+7kW3h5NabJEMtL07tSK9N0fC
 xMJpsnerUy22O8hG/EBn//fXajd1GJoLCdqFckyBwFasxAf/IPtCxEBSWMTgTG6ww5ZU
 rVY8pGxuI3HYH2VEkD6i0490KkjJZk7Y5HBNFNDaYv6sg7RzDzbZFvG5bLL9BsaR1bLw
 zE2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752042844; x=1752647644;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3RhvjbPOtBMHAj5bLY/qMrZX4SI68G+AtrqZhXIdYK0=;
 b=ObiNB97Lcfr1NFczG84UpXr5D64RfsDgEi3pXiBfUK18xEiURhcf4fvsOm/yLTcm8C
 teeiO0JTBztWl3ulkeWFXLhsVRjSBde+D3TuQXjAzLM+SRwOanO1yH62elVXhBcIINR7
 fR19gVTWBWXe3cRhkQDbIlE/xPT1pMfLTD87D7hh2RuXrl92zybCdkChkCoA4nDWFEnQ
 KptBxwjnIJxoqeJg+ZDheT6k/Xd/IIVimIBNIaUBw5wu11aMkHlFUSMWqw1DO3aEfQu+
 zGY45FAQHi2DPe1ivzrLPwD5/dfVGTa2ZbjT7aGpxmBps77x1RhP5zcnv4cUi18Mepon
 kbcA==
X-Gm-Message-State: AOJu0Yxz61DWLb5BzDkaMPwCT8/EjxRqpC3l+stTU9bKUz5ILuc+HwDS
 d2B2Zd6EpJls/to/JVt4k2Mv3gBgiEWcLAGOSgDck4xZF/D7cefm93AyQ4Qxozot/prQAcDjFwh
 OUssf59yJgnVOsszNesGYSo3o8cJ9v02ctk76IauAeQ==
X-Gm-Gg: ASbGnctG1RIOB73AodKVfiAEaVcnTR9eLUzLeGovRjZlliosC6SKqAsBPkMPHjnY2V5
 xtUnIofx7KozypAnsVH92DB6yHuw5EdHQNqBSOjWHr8Bcw+5w/jrys3xZJpg2JoYaCbkcQSDa07
 u0crR7tTv4UNOcYfm6vUrqbMnBaoBjlaoMo2eKOnGW+0Asyoe/B3O/Pw==
X-Google-Smtp-Source: AGHT+IGhH/x0bceJ3DCO67kslJ4idZ8X7PsUUczd/8SS7IXk5KzIMhcvNfIjr3Wrdn3PPdN9I2+OWADLO/RfHibSgO8=
X-Received: by 2002:a05:6402:2690:b0:60c:3b8e:7e24 with SMTP id
 4fb4d7f45d1cf-6104bf79420mr5189897a12.10.1752042844039; Tue, 08 Jul 2025
 23:34:04 -0700 (PDT)
MIME-Version: 1.0
References: <20250708215320.70426-1-philmd@linaro.org>
 <20250708215320.70426-7-philmd@linaro.org>
In-Reply-To: <20250708215320.70426-7-philmd@linaro.org>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Wed, 9 Jul 2025 09:33:37 +0300
X-Gm-Features: Ac12FXzji9sHAT512oYNWvejDgccbfmjjApOmxATRbRWngG1hhMhQAyphQYzSv8
Message-ID: <CAAjaMXacZkXmj4paAVCNiK+ZAkUJvXS=HUj_Wdz+M_PFyuq2Dw@mail.gmail.com>
Subject: Re: [PATCH-for-10.1 RESEND v8 6/8] gdbstub/helpers: Replace
 TARGET_BIG_ENDIAN -> target_big_endian()
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, Thomas Huth <thuth@redhat.com>,
 qemu-riscv@nongnu.org, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-block@nongnu.org,
 qemu-arm@nongnu.org, qemu-ppc@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x52f.google.com
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

On Wed, Jul 9, 2025 at 12:53=E2=80=AFAM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> Check endianness at runtime to remove the target-specific
> TARGET_BIG_ENDIAN definition. Use cpu_to_[be,le]XX() from
> "qemu/bswap.h" instead of tswapXX() from "exec/tswap.h".
>
> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  include/gdbstub/helpers.h | 48 +++++++++++++++++++++++----------------
>  1 file changed, 29 insertions(+), 19 deletions(-)
>
> diff --git a/include/gdbstub/helpers.h b/include/gdbstub/helpers.h
> index 6f7cc48adcb..b685afac436 100644
> --- a/include/gdbstub/helpers.h
> +++ b/include/gdbstub/helpers.h
> @@ -16,7 +16,8 @@
>  #error "gdbstub helpers should only be included by target specific code"
>  #endif
>
> -#include "exec/tswap.h"
> +#include "qemu/bswap.h"
> +#include "qemu/target-info.h"
>  #include "cpu-param.h"
>
>  /*
> @@ -33,40 +34,49 @@ static inline int gdb_get_reg8(GByteArray *buf, uint8=
_t val)
>
>  static inline int gdb_get_reg16(GByteArray *buf, uint16_t val)
>  {
> -    uint16_t to_word =3D tswap16(val);
> -    g_byte_array_append(buf, (uint8_t *) &to_word, 2);
> +    if (target_big_endian()) {
> +        cpu_to_be16s(&val);

Unrelated, but that 's' in 'cpu_to_be16s' is non-obvious, I always
think it's about signedness which is unrelated to endianness. I guess
it stands for "specified". It's more intuitive to call by-value
functions 'into' and by-ref 'to' maybe? e.g. `uint16_t
cpu_into_le16(uint16_t v);` and `void cpu_to_le16(uint16_t *v);`.

> +    } else {
> +        cpu_to_le16s(&val);
> +    }
> +    g_byte_array_append(buf, (uint8_t *) &val, 2);
>      return 2;
>  }
>
>  static inline int gdb_get_reg32(GByteArray *buf, uint32_t val)
>  {
> -    uint32_t to_long =3D tswap32(val);
> -    g_byte_array_append(buf, (uint8_t *) &to_long, 4);
> +    if (target_big_endian()) {
> +        cpu_to_be32s(&val);
> +    } else {
> +        cpu_to_le32s(&val);
> +    }
> +    g_byte_array_append(buf, (uint8_t *) &val, 4);
>      return 4;
>  }
>
>  static inline int gdb_get_reg64(GByteArray *buf, uint64_t val)
>  {
> -    uint64_t to_quad =3D tswap64(val);
> -    g_byte_array_append(buf, (uint8_t *) &to_quad, 8);
> +    if (target_big_endian()) {
> +        cpu_to_be64s(&val);
> +    } else {
> +        cpu_to_le64s(&val);
> +    }
> +    g_byte_array_append(buf, (uint8_t *) &val, 8);
>      return 8;
>  }
>
>  static inline int gdb_get_reg128(GByteArray *buf, uint64_t val_hi,
>                                   uint64_t val_lo)
>  {
> -    uint64_t to_quad;
> -#if TARGET_BIG_ENDIAN
> -    to_quad =3D tswap64(val_hi);
> -    g_byte_array_append(buf, (uint8_t *) &to_quad, 8);
> -    to_quad =3D tswap64(val_lo);
> -    g_byte_array_append(buf, (uint8_t *) &to_quad, 8);
> -#else
> -    to_quad =3D tswap64(val_lo);
> -    g_byte_array_append(buf, (uint8_t *) &to_quad, 8);
> -    to_quad =3D tswap64(val_hi);
> -    g_byte_array_append(buf, (uint8_t *) &to_quad, 8);
> -#endif
> +    uint64_t tmp[2];
> +    if (target_big_endian()) {
> +        tmp[0] =3D cpu_to_be64(val_hi);
> +        tmp[1] =3D cpu_to_be64(val_lo);
> +    } else {
> +        tmp[0] =3D cpu_to_le64(val_lo);
> +        tmp[1] =3D cpu_to_le64(val_hi);
> +    }
> +    g_byte_array_append(buf, (uint8_t *)&tmp, 16);
>      return 16;
>  }
>
> --
> 2.49.0
>

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

