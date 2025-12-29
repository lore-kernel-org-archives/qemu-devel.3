Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BF60E8FDB1
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Dec 2025 10:57:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaAvl-0002Ss-1t; Mon, 29 Dec 2025 05:56:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vaAvd-0002R5-FO
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 05:56:48 -0500
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vaAva-0002HC-FW
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 05:56:45 -0500
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-b7a02592efaso1353746466b.1
 for <qemu-devel@nongnu.org>; Mon, 29 Dec 2025 02:56:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767005800; x=1767610600; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i/4kOM0gQ4D8rKxOqAn1LlUsp9O2OKl2y5Evmi2iOiI=;
 b=rD/D36QMNuCNK8U10v2yewzTdoilUIXzWNvr/hijOW8+hJYJX8GFK9+q2fwW8x718M
 3kDP+WPxwew3jWeifR8crQHrxMDGyw5kArd9M1HuU/Lel94xM+FSPD/PbCLei+gK8Vua
 C6UOGrhnbxV0ZrDTqb84yEjcQtpG4iH2bcpiuslKKAsaZEagXuuWgScraxRIA5b6kDQE
 HOHJKf9o0ofUGRR6f+3SIxrmA3q8UVSUbMjx/uBbLncLCswiAH9+IJWTd/JXW1B4G4mC
 ddT7O9pnQ++AUz+IIafBjuhgXkxyF62BBMzt3MAgATaoM7cek+YSF+SRMUuz0JtO39t3
 Ojdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767005800; x=1767610600;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=i/4kOM0gQ4D8rKxOqAn1LlUsp9O2OKl2y5Evmi2iOiI=;
 b=WBag+InkzLpAQjotO4mgjUCh1Lj2QgvA0JMZMfGrCJF3KuclUI0+f1cUpKhlhD0xoo
 EiIeTMeq+tjsQGGVr+66rwKfBckDq4uJcf3fAswl0RuqGuHpK40jC4H7weS6kh+b17mK
 BSaI9gFyNiqI0SxnBDADpDy+S4BaXpf2uZPRrGw1hupRUlu1NK7Mu2ItykHtlNKgP2vt
 a4DPqRtpTi5JoRkSyJk0f4+srZBUlytvA3F1iE1xSn49eR7TzCjdPAoaq80RmAaImm7B
 YLBlhPpKeCgDDosYivm4wEb46AxGB7x08iL8e+UN/SXDOe4FVpKpB4ES7t69z8uYQExa
 Rldg==
X-Gm-Message-State: AOJu0YxNY2uwwee9FMxirAkhBL2coxF9Ia+16AOXYxA0+wcMlrkrl3ga
 uwSqATJWk8FgnGoRk8BGtql0rilJhdn7s1PjHz1VJMg9qXZsc4YqR7I2Qt9QdpZEk9iuTRRQbYC
 5Y9CpJvrd2vlA/EqpP/Xakvyiw1qTu/1f3N8kMcKv6A==
X-Gm-Gg: AY/fxX5VGqxvAG8heo82V2Vkr9xKFToHJD9wvmsV3XoCbHDtjK5Ia3uO4B+k4VcEVuJ
 agL/ptd5kVGOXFSfkLV2R9iG9VNoJCBAiRxakp9oZ0OE0u3oywRXcCgQOFPXyuBjXATMQuR3P6S
 9ox4XAt5SW31lpwh2VlN3FZ7LkyF96i98as7KEmdLC7E6utvSeR/5VJs3m7sqRU4LFENSVuJzl8
 si7cC6EBVzfFr0B+3rVqy7Hs1HsyJglll7JIzYszBGeb2Q7wPH+GdiwhSPbHgrRT6JsPklJr1wR
 XWf1V7h/9B+OVFrSdQWoUXBtsf2w7ask74+ULbk=
X-Google-Smtp-Source: AGHT+IG0OB7xJFMzaUgnNzFnJDsCT1azEGBnUfGR0mfVsO/HKbCz3EXgRFG2qBfNIGoGzOPpFBmRqFYnjfk2t5YTFr8=
X-Received: by 2002:a17:907:829a:b0:b83:246c:d125 with SMTP id
 a640c23a62f3a-b83246cd206mr838846066b.41.1767005800289; Mon, 29 Dec 2025
 02:56:40 -0800 (PST)
MIME-Version: 1.0
References: <20251224160335.88861-1-philmd@linaro.org>
 <20251224160335.88861-3-philmd@linaro.org>
In-Reply-To: <20251224160335.88861-3-philmd@linaro.org>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Mon, 29 Dec 2025 12:56:13 +0200
X-Gm-Features: AQt7F2pjVvV7dH4eUmmxn1FuP-zn2O6LUoyblaaS2nhFrWp-Ok8_xv5nFb6PiVA
Message-ID: <CAAjaMXYdJAxzyGZvfKuPZS6w2HSfZZhc7tu3U41iX27zKDHa5w@mail.gmail.com>
Subject: Re: [PATCH 2/3] target/avr: Inline translator_lduw()
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Anton Johansson <anjo@rev.ng>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Michael Rolnik <mrolnik@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x629.google.com
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

On Wed, Dec 24, 2025 at 6:03=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> translator_lduw() is defined in "exec/translator.h" as:
>
>  192 static inline uint16_t
>  193 translator_lduw(CPUArchState *env, DisasContextBase *db, vaddr pc)
>  194 {
>  195     return translator_lduw_end(env, db, pc, MO_TE);
>  196 }
>
> Directly use the inlined form, expanding MO_TE -> MO_LE
> since AVR only exists in little-endian.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

>  target/avr/translate.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/target/avr/translate.c b/target/avr/translate.c
> index ef6f655a458..78ae83df219 100644
> --- a/target/avr/translate.c
> +++ b/target/avr/translate.c
> @@ -173,7 +173,7 @@ static int to_regs_00_30_by_two(DisasContext *ctx, in=
t indx)
>
>  static uint16_t next_word(DisasContext *ctx)
>  {
> -    return translator_lduw(ctx->env, &ctx->base, ctx->npc++ * 2);
> +    return translator_lduw_end(ctx->env, &ctx->base, ctx->npc++ * 2, MO_=
LE);
>  }
>
>  static int append_16(DisasContext *ctx, int x)
> --
> 2.52.0
>

