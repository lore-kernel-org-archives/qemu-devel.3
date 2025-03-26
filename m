Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57848C3600B
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Mar 2025 14:50:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txS4J-0004lL-QO; Wed, 26 Mar 2025 10:49:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1txS4G-0004hV-NG
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 10:49:20 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1txS4E-0000n6-T4
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 10:49:20 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-ac345bd8e13so1219690166b.0
 for <qemu-devel@nongnu.org>; Wed, 26 Mar 2025 07:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=adacore.com; s=google; t=1743000556; x=1743605356; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KvfithdVJG13Ry4+dLoL7noXGGVAeKPWCvwLLvrpz5Y=;
 b=gHtUipp9X+z8/IGR4L5FJzd3GVYjbR5SaXBKS78RKB4Qqv34VhA1sJPhKRb/ZS6jmN
 MJHbwCsUaA22z8a29ciwUG/ezlj5Qi08IkHbhmXck/rz0djaUMUvZvAqGLYZHHccx7SS
 QsUv8x2RWdoq3Rv9r3x3pVfE+a0WB14b2+DsaAapmdXK9w3/zu6fhGQv7/IAVyd7ehXc
 p4hZMf2H08QyP4efEGmnrXHMd4oIHbb4IyXlQ8i+fzYtEu3zWzt4VeQuXZwoYaWc6I7C
 MVPQYmB7tfeayrzandpengIpxyDAOz2px0BfBzFSHe30ZUEUM5D+dNSJmm22vwJyNMVI
 Av2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743000556; x=1743605356;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KvfithdVJG13Ry4+dLoL7noXGGVAeKPWCvwLLvrpz5Y=;
 b=BqU9oea/cUtG8AFqGvpckUmGgFUeVWO6vuLBjaqHKzTLH7zK7ezMSIOIjtyr1Uhmzc
 dCVZHTpCULE77vtDUTaVnWW6/oAiohwhZA+ItNNd6MBg/jMyElmlMSg2R93lk7T1hR+n
 N7GY5REr3upNc4qYlSD48mINZl5T6NWVCNuU2IptWaGTuXerQqCJRGrqOYsWScCXa8sP
 JhrRm6Og0pN+mbKoaPHcsGN8YUNPskVy4/TtLPZQ0QCLL/BADzJxnAiphMEVqcuoKI1C
 NgiFaM0JMNW59+xaxuCdQNZHMwnbWglbL28LDYYyjEt9Hsf4mUFUJueW+M3drBjht7FH
 OB/A==
X-Gm-Message-State: AOJu0YzXx+RT1ScEqwCawVmEcNhZhE1UN5WZTQK6ILqrTGu4G0YfSLse
 x6hPAOlpSaaT5CHIpKUb1Fa7gqV8GJr1SWtFiCnxgRZt6+WC77MMELViHkfd8OhEojwcRB6YP9U
 +LLnz/a6IGZjhMRKccLd7CMTwTzGO0xmooAIx
X-Gm-Gg: ASbGncuAjtq8uw6stkm0sGBBog7QIKrpplaXMJ4uHLeENZWg7uOnLaumNp/QMoSbBBI
 4iBpsEXc9Oyx6hzh2b4UU6PwFBYbBLWiaxvTQCQcuHQKn2A5A0mlMqrnQrE6e/1XFRXRkQQl2D0
 gypYC9aaxLKfL3VXZV3uEjfEuksQ==
X-Google-Smtp-Source: AGHT+IGOA/PW7ta+4MuvB5OMTkTOtqfGXIrZCqwKVr0ug8CGg45W28WL+PgpPN9HkHmjjnvppKbQC/gX0GGnIy9IDTc=
X-Received: by 2002:a17:907:3f24:b0:ac3:3e40:e183 with SMTP id
 a640c23a62f3a-ac3f20d30e8mr2089574166b.3.1743000556088; Wed, 26 Mar 2025
 07:49:16 -0700 (PDT)
MIME-Version: 1.0
References: <20250325123927.74939-1-philmd@linaro.org>
 <20250325123927.74939-4-philmd@linaro.org>
In-Reply-To: <20250325123927.74939-4-philmd@linaro.org>
From: =?UTF-8?Q?Cl=C3=A9ment_Chigot?= <chigot@adacore.com>
Date: Wed, 26 Mar 2025 15:49:05 +0100
X-Gm-Features: AQ5f1Jq7x2TQDMmy73vwq-VuHtgkd6Ojd5gueFjPg_BAsqaWukIZYsHHHwPyUME
Message-ID: <CAJ307EgiVoC4Aqw6x2n5cU6k-2eH2McV-3SybZYHPf3GWg3FAA@mail.gmail.com>
Subject: Re: [PATCH-for-10.1 3/4] target/sparc: Log unimplemented ASI
 load/store accesses
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Frederic Konrad <konrad.frederic@yahoo.fr>, 
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=chigot@adacore.com; helo=mail-ej1-x631.google.com
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

On Tue, Mar 25, 2025 at 1:39=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> When the cache-controller feature is not implemented,
> log potential ASI access as unimplemented.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  target/sparc/ldst_helper.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/target/sparc/ldst_helper.c b/target/sparc/ldst_helper.c
> index b559afc9a94..d4de32d3c48 100644
> --- a/target/sparc/ldst_helper.c
> +++ b/target/sparc/ldst_helper.c
> @@ -600,6 +600,10 @@ uint64_t helper_ld_asi(CPUSPARCState *env, target_ul=
ong addr,
>          case 0x0C:          /* Leon3 Date Cache config */
>              if (env->def.features & CPU_FEATURE_CACHE_CTRL) {
>                  ret =3D leon3_cache_control_ld(env, addr, size);
> +            } else {
> +                qemu_log_mask(LOG_UNIMP,
> +                              "%08x: unimplemented access size: %d\n", a=
ddr,

This should rather mimic the line in "default", as the issue is not
just the size value.
Same below.

Otherwise,
Reviewed-by: Cl=C3=A9ment Chigot <chigot@adacore.com>


> +                              size);
>              }
>              break;
>          case 0x01c00a00: /* MXCC control register */
> @@ -816,6 +820,10 @@ void helper_st_asi(CPUSPARCState *env, target_ulong =
addr, uint64_t val,
>          case 0x0C:          /* Leon3 Date Cache config */
>              if (env->def.features & CPU_FEATURE_CACHE_CTRL) {
>                  leon3_cache_control_st(env, addr, val, size);
> +            } else {
> +                qemu_log_mask(LOG_UNIMP,
> +                              "%08x: unimplemented access size: %d\n", a=
ddr,
> +                              size);
>              }
>              break;
>
> --
> 2.47.1
>

