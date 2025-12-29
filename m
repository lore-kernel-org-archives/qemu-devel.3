Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5D69D3B7E5
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Dec 2025 11:01:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaB00-0005Uf-Dz; Mon, 29 Dec 2025 06:01:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vaAzp-0005Pg-Jk
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 06:01:05 -0500
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vaAzn-0002uF-Jf
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 06:01:05 -0500
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-b7277324204so1333211566b.0
 for <qemu-devel@nongnu.org>; Mon, 29 Dec 2025 03:01:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767006062; x=1767610862; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lBh/xXqzE2ZpDR+LmY6vNjUFo3FaCc2tm8ZztdYj2C4=;
 b=dZ+/8DX7Mu14TzkjUv8eJB/3+u6tg76fbix/QGSepckk+O68tz3XNFPfgOg/tlaRTf
 eKdhHFgYXyHask6eehw2WFQTgI9IP7UlMgwfgJLaLGtYYoGiHenCSnkqVD7Hvt0YZ/Hy
 rHjd9IZO2wwM0ibzKjFVve62cf7HIRy84GORUuIrvjAWz64hjRk6VuHIMQqVuInqvi5V
 wf+4G8gCNpxWvEXMsM5Xk+2Pdk6zisoOeo9uZ4EGp0RJA0h6aIJtxfKmTdnswrr3THFc
 U9v4roQiUJ4m8KADkeOJ4/JO/x8XK0/fD6Unk8PnVVh1/mErdbCv/RAOGCFD/2yjJD96
 srjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767006062; x=1767610862;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lBh/xXqzE2ZpDR+LmY6vNjUFo3FaCc2tm8ZztdYj2C4=;
 b=P7IDtdA36MSvjGe6dd60DW9vVBPuykKQHB1A12+TxRN8eBbZSb2jEgrD9amqQppeMn
 IvdKKN1RxOtY19v/9rF7eCrY6oIeZ4qVNmDigs+Nk10Pi8O4xlA/hkwPRmhkmwacq118
 ThF15MPnyKuWC5TcENn0hO33lnOhySldYL7i9NRZx/a28QtRtcbic88XNkVg+M6vrrMK
 Qlsaf3tA0RdYju2X0CXFZvANFWf2NM9Vh8ca2NdPxrbBuWBhSHsDy54HizTUhKbR8L8w
 UKrXwT3YfEptSGDq/hQtWxtOZGu1Yx+VcSnw1+d/akRDEu3Dy7OFXk2Cgp1AacM9H793
 4sCA==
X-Gm-Message-State: AOJu0YwViwE/jl2v+eLpCXm270XyoKLkor1SPfHAJQ6wUIgvxORQ7vPn
 l1N4nIehCypOfHSvTw9Y1A6UEVPSof7jlb1pFk/kwXUO38ELOvsNkFhmVEzPpoIpPHgkkre8zIo
 h2MiRVtbpzleBIyPTMlgjGcazdVADy+LQ9ID33GqeZg==
X-Gm-Gg: AY/fxX7PrV6cb64gF83RlWp17ofPXv7N5Gil3PIVxyk4HrLR9bKxrB6rXHvo9FI8WsX
 yFpwuSNpnqEivXU5ZCcB8tIhm435BgH0ArbTe0nrkgsRyPhq9wtvH7V4zyJieBet4JUB1IzqXZg
 W+aw4QCvAeXSY4hq17J7gwhCsqPmyrPJzhuJEHAUiPRD7hsq8XPhZvOPRjRbrb4PrAsgMuqUde6
 gBHNo5w+1ZKmFjDUUihHowdSD+AtJFJO6hWQYaSST6XizX2yLIblXCIITWLMjpgJeERHQt7yCcI
 vMiA/fqEzK2wZGjCDyLXRDJP2N5TRlklFOslB6B5BScUgTa+hw==
X-Google-Smtp-Source: AGHT+IHnEfi1mBUmIfzIGho0WLP9FLI0nDO9h+k25tTY/TCGKPeuq1ReweJeUAw2atWuEcOQInmLmsg7aJhb3gXjLXQ=
X-Received: by 2002:a17:907:7f21:b0:b79:a827:4d47 with SMTP id
 a640c23a62f3a-b8036a8d6e4mr2988897266b.0.1767006061846; Mon, 29 Dec 2025
 03:01:01 -0800 (PST)
MIME-Version: 1.0
References: <20251224161804.90064-1-philmd@linaro.org>
 <20251224161804.90064-4-philmd@linaro.org>
In-Reply-To: <20251224161804.90064-4-philmd@linaro.org>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Mon, 29 Dec 2025 13:00:35 +0200
X-Gm-Features: AQt7F2rl2zCSdcFJPfMpyzeScBU2riLtPVY_bvWgpsYEABagJIe19W9BBwMS13g
Message-ID: <CAAjaMXbwhGbd3AQ1XoN0iCfOX8f1hy09-h99Dgdsr6LNq=MKwQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] target/openrisc: Inline translator_ldl()
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Jia Liu <proljc@gmail.com>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, Anton Johansson <anjo@rev.ng>, 
 Laurent Vivier <laurent@vivier.eu>, Stafford Horne <shorne@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x62a.google.com
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

On Wed, Dec 24, 2025 at 6:18=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
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
> since we only build the OpenRISC targets as big-endian.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

>  target/openrisc/translate.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/target/openrisc/translate.c b/target/openrisc/translate.c
> index 6fa4d6cfa70..a6d550bbc2e 100644
> --- a/target/openrisc/translate.c
> +++ b/target/openrisc/translate.c
> @@ -1558,7 +1558,8 @@ static void openrisc_tr_insn_start(DisasContextBase=
 *dcbase, CPUState *cs)
>  static void openrisc_tr_translate_insn(DisasContextBase *dcbase, CPUStat=
e *cs)
>  {
>      DisasContext *dc =3D container_of(dcbase, DisasContext, base);
> -    uint32_t insn =3D translator_ldl(cpu_env(cs), &dc->base, dc->base.pc=
_next);
> +    uint32_t insn =3D translator_ldl_end(cpu_env(cs), &dc->base,
> +                                       dc->base.pc_next, MO_BE);
>
>      if (!decode(dc, insn)) {
>          gen_illegal_exception(dc);
> --
> 2.52.0
>

