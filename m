Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B098DE8FDB1
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Dec 2025 10:58:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaAxE-0003mI-O6; Mon, 29 Dec 2025 05:58:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vaAxA-0003hd-17
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 05:58:20 -0500
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vaAx8-0002Te-Ez
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 05:58:19 -0500
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-b79d6a70fc8so1567235066b.0
 for <qemu-devel@nongnu.org>; Mon, 29 Dec 2025 02:58:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767005897; x=1767610697; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eoq0U5h+9eIKqNFj1+0dw+4ZONR1lKVhGA4oyCsyy8I=;
 b=DU31LTR6UgyPWlaaptZQT7Feho9DPCBEaSwRs6pV2LIZ4vuw1s2oCuScO5raKESIQ/
 ZnArHfEtondQJL6163GBF/PDtDFNCdPe8vT7Wvhqwuf02AjmU2WkUIFC/UUEjXR0nk1D
 yzWIt1dxwuBr1H3FAJTqsFDRPWB+ksHw7KXrUlNTytinFlnB+3+MQlSyvmmhb7mJld1y
 BxOSVMamIlxjudbjwQZYa/haLIv20rRXZmfrCHR9e/wBcU/n7gr1zvQnlI50a4DVg6UY
 6exawYNPo4gwNzisoYs8ToC60iiQetEjGCfXAw5SbsJluCYYh7sNONCoCEiPXiRT3swc
 XLWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767005897; x=1767610697;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=eoq0U5h+9eIKqNFj1+0dw+4ZONR1lKVhGA4oyCsyy8I=;
 b=k3Bmrx/MfZl00I2jOMbQ/baKotWCV1uk/m5teAQGrUT4zVQgqp/xkh/tyR3z3H90mK
 Izgd4FY16eZFJ5Cl1KCiPGxH9PQBdPs+WYSZIK6dxh0bYu4RozfRU1IbZql8b2HRdRLT
 0d8gyBrSytIffoXLUmGItTt74z4eggntVDgDkJI5pGQj3FfnUbdvcLroMmXZmUt2hV97
 l8PJIaaNYR3fVxqK0ICD4/TLMDMzMldtX0IIPa5P6VQdQl1Kd0e1kwq+G429/QxCdoBM
 1Knt1BTGMnQdwGJ+bvQ0pLWsqzJjSnzvnvxBFr83DZrWqnwpgQJVIQ9bqV9OOtZ89/tq
 IrUg==
X-Gm-Message-State: AOJu0YwCTla0VoFP6VM5kkWA0cX9kA7vGHW2ezCNAPSjlrc03C72GKQr
 xg6rVRtrHVOBrXf6IP14kt5Vzyp4SarW3eBuO17OPeRtkuwUvRDRn0nzdmz9auqHYXSPtorxe+n
 YolMaoBOrw6+sRO/0Q6L6+aHa1zUGLibpZKUBkgTklw==
X-Gm-Gg: AY/fxX7GF5nliECcsoKyBf+Ess0NTtssbIT6ZkLnMdUtxgtmU/+QqsaRIECLFO3Heda
 AD49iGNkngk3GXL4BXNfsg+Tp6NR8eeTknb279yC2kDSYq75scchUXvi6xzsRcCV0yj1ifUacJ+
 WqF+YnzMbqJ1yqrKNLFGnhFkOxTyn+xDhN6LocwJme8HJht1f/auMn5ijNvSgUVkwU3s9Lko0xV
 kr0vQtRSMnH1qO34woaCMYvxNrhr2fGfGoUzpRe23pXD0E4nXHy8EQEoXlJt/HtvuFmo28ryaPP
 Dg56s1Cv7HZVRe5TZqk3qyvdm8ToPrVZV3YDWCo=
X-Google-Smtp-Source: AGHT+IF1iWhAlJbcaVSg1ZcOi2taochNf1n3X3b+9dW8n+fuFp/yVfMZ1Czqb+G8+CS7PFbyvcNcUhuF+0NblSpuI3Y=
X-Received: by 2002:a17:907:3dac:b0:b73:75ea:febf with SMTP id
 a640c23a62f3a-b80371daabemr3249954166b.55.1767005896851; Mon, 29 Dec 2025
 02:58:16 -0800 (PST)
MIME-Version: 1.0
References: <20251224160708.89085-1-philmd@linaro.org>
 <20251224160708.89085-2-philmd@linaro.org>
In-Reply-To: <20251224160708.89085-2-philmd@linaro.org>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Mon, 29 Dec 2025 12:57:50 +0200
X-Gm-Features: AQt7F2peC8yFY9NeTDtM2HCXQe7nAupKUbj78fWktnwiRcKdEFZHr3lA6zXHOrE
Message-ID: <CAAjaMXYtkstoYpVvby6ynM-K1HssXLcctSvQD6hSxH44cr+L8g@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] target/hexagon: Inline translator_ldl()
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Brian Cain <brian.cain@oss.qualcomm.com>, Anton Johansson <anjo@rev.ng>, 
 Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x636.google.com
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

On Wed, Dec 24, 2025 at 6:07=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
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
> Directly use the inlined form, expanding MO_TE -> MO_LE
> since Hexagon use little-endian order.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

>  target/hexagon/translate.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/target/hexagon/translate.c b/target/hexagon/translate.c
> index 8fce219c0de..c37035c4774 100644
> --- a/target/hexagon/translate.c
> +++ b/target/hexagon/translate.c
> @@ -203,8 +203,9 @@ static int read_packet_words(CPUHexagonState *env, Di=
sasContext *ctx,
>      memset(words, 0, PACKET_WORDS_MAX * sizeof(uint32_t));
>      for (nwords =3D 0; !found_end && nwords < PACKET_WORDS_MAX; nwords++=
) {
>          words[nwords] =3D
> -            translator_ldl(env, &ctx->base,
> -                           ctx->base.pc_next + nwords * sizeof(uint32_t)=
);
> +            translator_ldl_end(env, &ctx->base,
> +                               ctx->base.pc_next + nwords * sizeof(uint3=
2_t),
> +                               MO_LE);
>          found_end =3D is_packet_end(words[nwords]);
>      }
>      if (!found_end) {
> @@ -966,8 +967,10 @@ static bool pkt_crosses_page(CPUHexagonState *env, D=
isasContext *ctx)
>      int nwords;
>
>      for (nwords =3D 0; !found_end && nwords < PACKET_WORDS_MAX; nwords++=
) {
> -        uint32_t word =3D translator_ldl(env, &ctx->base,
> -                            ctx->base.pc_next + nwords * sizeof(uint32_t=
));
> +        uint32_t word =3D translator_ldl_end(env, &ctx->base,
> +                                           ctx->base.pc_next
> +                                           + nwords * sizeof(uint32_t),
> +                                           MO_LE);
>          found_end =3D is_packet_end(word);
>      }
>      uint32_t next_ptr =3D  ctx->base.pc_next + nwords * sizeof(uint32_t)=
;
> --
> 2.52.0
>

