Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91B92D3B7E5
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Dec 2025 11:16:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaBF2-0004ub-Bz; Mon, 29 Dec 2025 06:16:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vaBEz-0004pr-1o
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 06:16:45 -0500
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vaBEx-0005W8-6o
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 06:16:44 -0500
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-b725ead5800so1255842866b.1
 for <qemu-devel@nongnu.org>; Mon, 29 Dec 2025 03:16:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767007002; x=1767611802; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BKlbFAwsQ7LB5x+UqR1L5llLhJY0/GrJXzxo4R3mztk=;
 b=H+uPHM9sj8NGi3BfZ3a+SuP/NKr7wuBAA9EQ4jgbtfL04LxT3EM5mkcdSXooNS4waZ
 PXJkynXJzrM6uuMFNmGu78CJyNP/aptJRKJWfjYGua+fEMRLnsF/DV0E6OL0fw1Y4+Od
 vcq7Au8Bto+8pR/kZhsBSQ+KblHrlK9sQb1YnzZCCn6LD2cztZJC1qDzR9/xzrEhTP+p
 LEIrbtxxHYkoSlzdNDoHZHCdb6YzCPqReQdGCdnn6P0/Z35cpAJHiRv9zMCsmNCYawSY
 hlkMfhz/DhDR6BFFbw0ysEQBci+1NL/94YloFALNCSyol+FbUMXocZUYRaWVTnvdtrF0
 xq7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767007002; x=1767611802;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BKlbFAwsQ7LB5x+UqR1L5llLhJY0/GrJXzxo4R3mztk=;
 b=TDRcOZqCNOr6FTWeYxUjiKWDJw6fhPiU8/CbI0JrSnSWYnOEIWgUO1l0FSKfqg2IGe
 nHl/odAWHLaWuGjB3d5pft1Ilvphka3r67l2mXmLIZyIlOJyioYeQpxNOON0ycas5pmb
 99afJT25/v8HEvJpDRfVFx1ovyLkaWEsEmzQoSDKDEk/Ia1l8JzoBnMdUgdO7sSp00LK
 SKuw2oIKJGyc5uacg/3gQ8gV+CDu9+5XPPo1u8k9HOPA5965TfDscIS74zlCrgZennW6
 IGJUJzETImlK/kyNfl1+R1nQfWi5iK1QrkMEokwaEzbGm1CvnDK4S3a/LoMPbXKVLlsv
 d/Sw==
X-Gm-Message-State: AOJu0YxkZL/xiJmjJcy+fXaAGRJunOIf1KsrFXduNUIMGFn7wK2Xk6FY
 34FqdAu7BouC/XILGm9OuuPMr2XFG7hqfjjXt52YPiq4GRZ7OxyUFMX3vuhoLlRrSZ2maF0LhKM
 0dlYdd0fv+qSn1WyRfIgF6L2EDvkSn0HEmRX0SsAfog==
X-Gm-Gg: AY/fxX5wm8FrnT9SeGL7VfDW3xDRgoxUq7MLbPkz+H/P8deJ7/s42wiYBb8E0nxNXGg
 hhZs6Tg4yBDuO/ak846BUT1uLe4sagMMcchUIX6EouSRPFdcKTvtmkZdTj0o07L9eMWKmqSThMO
 NH9OAkyKQQ1SSRho1yUG/enPwwz/nneONjOxrZSS0oTu+7Aiho4I9seRfK6491R1X8qU5M+478I
 ZcY98uWl313x44C4ZCohi31ZbdkVD1ptJdvqBukZeP2UM7TpXvzuN12SR1KzbX6aPTpmqdbG087
 P8CDdu8r0Ysg9Pcnpb662hM3dg1z7Uhac/iyhl4=
X-Google-Smtp-Source: AGHT+IH4HHAWOi4idF+QLsZMmTXGm0xIYArC4AdGAzitnSlkBzC2YDDeKPdAIKGn7ANThkTlHyiENESRWCbkqC+wpCU=
X-Received: by 2002:a17:906:ef08:b0:b72:6728:5bb1 with SMTP id
 a640c23a62f3a-b803726dd35mr3587879966b.56.1767007001645; Mon, 29 Dec 2025
 03:16:41 -0800 (PST)
MIME-Version: 1.0
References: <20251224162642.90857-1-philmd@linaro.org>
 <20251224162642.90857-6-philmd@linaro.org>
In-Reply-To: <20251224162642.90857-6-philmd@linaro.org>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Mon, 29 Dec 2025 13:16:15 +0200
X-Gm-Features: AQt7F2p6ELv4a7L71th4jzr3P4k6kAJMRNUkwedCLnrcMVn8upet6B5ikMjhxcg
Message-ID: <CAAjaMXYZt4NvnE=yb+UB8oU-iH_iEOEuh98cxGoWTbKUTpWThQ@mail.gmail.com>
Subject: Re: [PATCH v3 5/9] target/sparc: Use big-endian variant of
 cpu_ld/st_data*()
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Cl=C3=A9ment_Chigot?= <chigot@adacore.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Anton Johansson <anjo@rev.ng>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>, 
 Laurent Vivier <laurent@vivier.eu>, Frederic Konrad <konrad.frederic@yahoo.fr>,
 Richard Henderson <richard.henderson@linaro.org>
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

On Wed, Dec 24, 2025 at 6:27=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> We only build the SPARC targets using big endianness order,
> therefore the cpu_ld/st_data*() definitions expand to the big
> endian declarations. Use the explicit big-endian variants.
>
> Mechanical change running:
>
>   $ tgt=3Dsparc; \
>     end=3Dbe; \
>     for op in data mmuidx_ra; do \
>       for ac in uw sw l q; do \
>         sed -i -e "s/cpu_ld${ac}_${op}/cpu_ld${ac}_${end}_${op}/" \
>                   $(git grep -l cpu_ target/${tgt}/); \
>       done;
>       for ac in w l q; do \
>         sed -i -e "s/cpu_st${ac}_${op}/cpu_st${ac}_${end}_${op}/" \
>                   $(git grep -l cpu_ target/${tgt}/); \
>       done;
>     done
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

>  target/sparc/ldst_helper.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/target/sparc/ldst_helper.c b/target/sparc/ldst_helper.c
> index 9892c8f61c6..d39f7d72a7e 100644
> --- a/target/sparc/ldst_helper.c
> +++ b/target/sparc/ldst_helper.c
> @@ -1228,13 +1228,13 @@ uint64_t helper_ld_asi(CPUSPARCState *env, target=
_ulong addr,
>              ret =3D cpu_ldub_data(env, addr);
>              break;
>          case 2:
> -            ret =3D cpu_lduw_data(env, addr);
> +            ret =3D cpu_lduw_be_data(env, addr);
>              break;
>          case 4:
> -            ret =3D cpu_ldl_data(env, addr);
> +            ret =3D cpu_ldl_be_data(env, addr);
>              break;
>          case 8:
> -            ret =3D cpu_ldq_data(env, addr);
> +            ret =3D cpu_ldq_be_data(env, addr);
>              break;
>          default:
>              g_assert_not_reached();
> --
> 2.52.0
>

