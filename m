Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 261B7E8FDB1
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Dec 2025 11:17:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaBFM-0005Ds-PF; Mon, 29 Dec 2025 06:17:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vaBFI-0005Bi-BN
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 06:17:04 -0500
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vaBFG-0005XJ-Hl
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 06:17:03 -0500
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-b7636c96b9aso1629309366b.2
 for <qemu-devel@nongnu.org>; Mon, 29 Dec 2025 03:17:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767007021; x=1767611821; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xP+tbjvHVTsUzguFnTB5gUCmTlKN1CVU3M/0VPMlOp4=;
 b=ZT4F5CgZNC8eYgmr9za4pJmZMVZWhpUvSWz8k77ODLiajIh5WLj8fnp65mWE0Iy2mc
 klqD5HMi4IWClIFo5IgCE8cGxlvStlsxn3UlrZ4MDgugP3rdI2kJRhgUIrLx+AxlscV6
 OsBMwoMwDYFDzFv8jZGcIuP2MisgXheVrTplMpnfuKyxlBQO+DaC2h46sn1o9N5rofTX
 rEe1kzaa0kUxPkSQ2tIp84P0e9zUvIN3JLdPWWqxNth5KOcqQEoALSYk67YsxGehu9/U
 St50q2g8D5fbAvtLha2xEDRrtLWlD2X+f6AocQenMcOco+PxwRKe3N6T/LjwLhFPLo8t
 x+gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767007021; x=1767611821;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xP+tbjvHVTsUzguFnTB5gUCmTlKN1CVU3M/0VPMlOp4=;
 b=BH/tOL7R8Foyad0ZW1XUS1LvrQ6k6kthmKeh+u40+S2gVftCTyKQ3IBE7o3l8pM2Sw
 HmQB9oOHfTBljiE7AToGSV9AI/2lRyaLsXephA6+z5f+TJgE+fMFflb84Y3wuvLyzHJY
 VI6S+STmKWDwNLT6C5KAYNCF10A7fttkwCBwZkEshCw7S7K8/pMhjS9EnkCOJntnZX2i
 ubc+y6bWGW4AkkLLg91+HLHFUp2b3gvY7xlNPsCF+nbYuJJIuipwrliYKr6zEwN5Al3w
 dIy1SYTAKgt+6g1ZKnn8jX7ErR/O0qW8+6BysW98JruW9h2BLPTtk49EzN3ck4pu08mF
 gl4Q==
X-Gm-Message-State: AOJu0YxLOOrVbhu8iqp/kt169Q16oIUlYHy9Sef20nYPDs9jeBesmTJP
 4tpvIV+Z4FHJi81TtPMmD11U/iDDsZ2zSQBCYaHEdgvAAZXbRJjaJZsqo1wED8mJWmY7+9VFxCh
 p+fEbebrqFP1vOUy/qdu36YI4fCut+tgZtkmgFESWoLL5Qr4GjYdLzzMWTA==
X-Gm-Gg: AY/fxX7EMqeaHC5WDFXVQMglL/2JMhkTrdfthHJ78xa/9Tgg89YoMubT1Tc79uo2HV6
 ghLw3m2ufBMOFdrHF4BV+qhf3ifjQTdCmBeagmNj61wMyzoSGX/nV09wUtdSR9EtSVWiu0/pQFu
 7I55ZEzdrLIeYaMLLwsjRVuL7Xd05XjkZAJ18uAVi3pj0505WzXroJ4cuiOBmJ2yj6sRGPgKAsI
 CeSlJ8Y2t8gafCC9WvEIIKRwzipwpwF4V8qvmhRUTAu/CK28wMf6JZUak1logHtV2iI/2L1qN6S
 hD2F+WOAjZKGLXEbuo2eTIt9I0B7iB+AhvEaeBcabesMj1p5Tw==
X-Google-Smtp-Source: AGHT+IHu3iU+0l3VO+36ngbui6GXuMeMQ6yVmNkbddt3Qus6kha93Zg3GPSrgVWkvWqBv3nnssNY0nbQgW2VtkLeUMo=
X-Received: by 2002:a17:907:1c0f:b0:b83:3715:530e with SMTP id
 a640c23a62f3a-b83371556d9mr973064166b.11.1767007020908; Mon, 29 Dec 2025
 03:17:00 -0800 (PST)
MIME-Version: 1.0
References: <20251224162642.90857-1-philmd@linaro.org>
 <20251224162642.90857-7-philmd@linaro.org>
In-Reply-To: <20251224162642.90857-7-philmd@linaro.org>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Mon, 29 Dec 2025 13:16:35 +0200
X-Gm-Features: AQt7F2pJnbzAA4BKSig0n3bPaJ2L-HLtMKAbinc4G0n4-tdtiAmedKY_U2Jir3Y
Message-ID: <CAAjaMXbDG+Ys+VurORP4Tceq9ncdFYKY0D7vr-w1D-HDHd6-Kw@mail.gmail.com>
Subject: Re: [PATCH v3 6/9] target/sparc: Inline translator_ldl()
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Cl=C3=A9ment_Chigot?= <chigot@adacore.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Anton Johansson <anjo@rev.ng>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>, 
 Laurent Vivier <laurent@vivier.eu>, Frederic Konrad <konrad.frederic@yahoo.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x62d.google.com
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

On Wed, Dec 24, 2025 at 6:27=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> translator_ldl() is defined in "exec/translator.h" as:
>
>   198 static inline uint32_t
>   199 translator_ldl(CPUArchState *env, DisasContextBase *db, vaddr pc)
>   200 {
>   201     return translator_ldl_end(env, db, pc, MO_TE);
>   202 }
>
> Directly use the inlined form, expanding MO_TE -> MO_BE
> since we only build the SPARC targets as big-endian.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

>  target/sparc/translate.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/target/sparc/translate.c b/target/sparc/translate.c
> index 23079697f52..57b50ff8b9a 100644
> --- a/target/sparc/translate.c
> +++ b/target/sparc/translate.c
> @@ -5743,7 +5743,7 @@ static void sparc_tr_translate_insn(DisasContextBas=
e *dcbase, CPUState *cs)
>      DisasContext *dc =3D container_of(dcbase, DisasContext, base);
>      unsigned int insn;
>
> -    insn =3D translator_ldl(cpu_env(cs), &dc->base, dc->pc);
> +    insn =3D translator_ldl_end(cpu_env(cs), &dc->base, dc->pc, MO_BE);
>      dc->base.pc_next +=3D 4;
>
>      if (!decode(dc, insn)) {
> --
> 2.52.0
>

