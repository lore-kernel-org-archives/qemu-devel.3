Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05285E8FDB1
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Dec 2025 10:59:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaAxz-0004O4-GZ; Mon, 29 Dec 2025 05:59:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vaAxv-0004F7-Cb
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 05:59:08 -0500
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vaAxt-0002Uy-Rw
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 05:59:07 -0500
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-b8052725de4so823233066b.0
 for <qemu-devel@nongnu.org>; Mon, 29 Dec 2025 02:59:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767005944; x=1767610744; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XrmRQ8r9/KKC7hVmPGQrq/E0/lpdh9eRI/ls/yQ5Zx8=;
 b=Heg4XTcrGEM2SeIBWraIU6cfRV/pF8z5WesQr+DUQR0auVAwD4hXEe6f9NfTgHGrqj
 wwtKvvVcYo8rOtrmb7x0dLfQrvdR3KMWUMLDtB9CoRkPtT2bW7yKuxzh2QTIllHTnCkv
 pP2/w70jxufFORpwxH8MJzNkIphaItGlUkFrrx3x50GH8TDqATW120taS6Ln+K+FZ2bT
 SO/PqxRwJ/Rvdu4a6GCF9UgF43knhCoULabevF2izk3Rseb8dM1IjRbr/JPGvE7wxY9v
 zBoawQHj8RPEpMJjplzP2QIYgPhY76nG+Qc11ZH5Hk5F2iP1vCmmvUY5g0v5MDU8gDZK
 hU5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767005944; x=1767610744;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XrmRQ8r9/KKC7hVmPGQrq/E0/lpdh9eRI/ls/yQ5Zx8=;
 b=F4naK7heLKK+uRynnWOTpCgOOewFzOc+qKx0YDbd7Qit+eftB2sro7Jy3xrr8lF+Wa
 /V95+Gtp5SDdFxXZb944u7ffggSDh4nduN1gv0iECZBElSsdP09B1kfWKb/Eu+dGP/Yb
 SMSu8Z9i4EhVCBjVr0IL0JqqBd8UWaNid38oFpCp70wkSUDYoCkt2u+AAtPwpKc8yS/2
 J+dZf/k9jFNJ5m8lhH0L/jRDjmKaJEx3iCw8m9LdbidShOABaBTLrgvs15yKO54P42Kx
 P+RgEhKE3puRxhgd9fOU24tkGHgTGcQp4qyiWPQpqgOC8pcmdt9ZLY9Usb5eKvUGHOAe
 LB2g==
X-Gm-Message-State: AOJu0Yze2CknGf+IFMvlVWkUnKgKt9rqbrrufr1IEZI1kRpcqRvU40cp
 PmcfkrvF60+jGTXXTLffWTOm4mwo4qU8gBFHOP0ctvyyimEtR+QoQtNmvxOxY5TPND5Um02S6AQ
 +FWhfGUIpTJVlv7MKOv6A1Z5pQan5kfpqELMyIs/R4A==
X-Gm-Gg: AY/fxX647MAdsPkZV1hYfNuwpzztU+uJ1cWQj1Pz3IlS5sgTcYl+6WYuPgXd0efjxsY
 Qp+c4nlnDEWJCaBU4A3itqML0t6XhzuF80hLL9V5+jCosJNLvemwXmhl2gytjW4gmPnFN4d/acc
 bO9RtbO1X5O/k83XalRcPLTd9HxSoEWYlljlDgL6V96Q3EIRBcIIGL3616EaVM7i4VxA8TPMvsw
 UwBFN/UeMIJU0Xvl3RVEpH/5X5PyLLgnxhUsj9KSJMpQmWKyX63rGHo1aOXV/sRzWpvvNmXqBFY
 PjRnhEkweOK8SKbupTxqU7W7xOseDfKU1ew/TfY=
X-Google-Smtp-Source: AGHT+IFOjjxJ2tlNUnobZ8h6xuVzadnPCkF1FUFrCyOMKy9VvsEMYHZGI//nPCe8fAjVbG9kSlXTkXd82vZ+80byMXE=
X-Received: by 2002:a17:907:3e21:b0:b83:3716:ca69 with SMTP id
 a640c23a62f3a-b833716ce57mr1033684766b.21.1767005944324; Mon, 29 Dec 2025
 02:59:04 -0800 (PST)
MIME-Version: 1.0
References: <20251224160942.89386-1-philmd@linaro.org>
 <20251224160942.89386-4-philmd@linaro.org>
In-Reply-To: <20251224160942.89386-4-philmd@linaro.org>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Mon, 29 Dec 2025 12:58:38 +0200
X-Gm-Features: AQt7F2qpW25xNE3wUSgheJrwARdDbUMIk_uqhAVQuPVWGm-qoXU5WR90vmWZ0es
Message-ID: <CAAjaMXYcES-6itMm20zwX1ThnwiD30drMBz5J2wm55AB05D8QA@mail.gmail.com>
Subject: Re: [PATCH 3/4] target/hppa: Inline translator_ldl()
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Anton Johansson <anjo@rev.ng>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, Helge Deller <deller@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x630.google.com
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

On Wed, Dec 24, 2025 at 6:10=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
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
> since PA-RISC use big-endian order.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

>  target/hppa/translate.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/target/hppa/translate.c b/target/hppa/translate.c
> index 853cba2ba4f..73c2cbdf5fc 100644
> --- a/target/hppa/translate.c
> +++ b/target/hppa/translate.c
> @@ -4737,7 +4737,8 @@ static void hppa_tr_translate_insn(DisasContextBase=
 *dcbase, CPUState *cs)
>      {
>          /* Always fetch the insn, even if nullified, so that we check
>             the page permissions for execute.  */
> -        uint32_t insn =3D translator_ldl(env, &ctx->base, ctx->base.pc_n=
ext);
> +        uint32_t insn =3D translator_ldl_end(env, &ctx->base, ctx->base.=
pc_next,
> +                                           MO_BE);
>
>          /*
>           * Set up the IA queue for the next insn.
> --
> 2.52.0
>

