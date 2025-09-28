Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F925CAC5BB
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Sep 2025 23:38:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v30wS-0003AL-DL; Sun, 28 Sep 2025 19:36:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v30wO-000349-0g
 for qemu-devel@nongnu.org; Sun, 28 Sep 2025 19:36:28 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v30w6-0006iC-89
 for qemu-devel@nongnu.org; Sun, 28 Sep 2025 19:36:26 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-63163a6556bso9017167a12.1
 for <qemu-devel@nongnu.org>; Sun, 28 Sep 2025 16:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1759102565; x=1759707365; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HD2+rEol+zuesGa48FK5nOsi28dpTeYz0uRTWXah58A=;
 b=J8jgtEMdwJbFpyOsL/4tClnR3/G+oYKk7sGtuabTJMa/y5FzfJD6pPjvgaD2mVPx4p
 jpiQwwhD4CMTUJ2umuEQsdEXnKGnMRt9fm04Q0rnfmPrmdVEv6WcuKDiDvbDKFoDN6dZ
 99M9Z1ZwMPwKanoBphaXrhjdKt4Hu42COmXRPVuzdtmsYNPnoRxcry4BNTYJDutR+XFA
 DfZw+OQB7DjKxKafYiUNQrlph52LV/hvmazK8j0vGmSMXDoxf8Xep9rrP0Pmu3SDiG6O
 EkvCstaaNsuOu0ZKRqwTN+J1L/8q0LiGKzXD2Uch6T2cP0WhndwoC2lR0vO3dCLJptOi
 dQTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759102565; x=1759707365;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HD2+rEol+zuesGa48FK5nOsi28dpTeYz0uRTWXah58A=;
 b=kOLOF4mLqJCqfJiamy2oSIwMS9n4WXHaegi3+enUiyep2Kkcu3gXIGfJf48Es2D314
 M2ltvEJ5rNmsafKaWcRHUaejPuFAsrfn+n3Mn0uyr7J/YouVLMkroXAkmlB59XxBChIX
 o1mc4da6H8TeW+zA/kifj3CECkS55lnmK7NcsykSIxcaS1L5Lk7w0gZsd4usyeFh4DmC
 EUz4emHR7Y2gDXMllsl886ttt0sb16iIs+TOOhVQdk+uYAlW/G9CAVRMyixWGBogbYIK
 KL1tpH9EVR9Uejf02R1IncurLO2bjkwWGPG77zsUOAwixCgxTVUZUSqXwfckA7Oq3+dI
 4dDw==
X-Gm-Message-State: AOJu0YyCcuR58VkwAD/HYmQcIhTQDSYtmrpkDxPg4GwYFrb6Pa3TS+Is
 nlhWy6EmMBZ0jvqbyyszWCdLVOFagO8l1VhxjKuOzH37NcOlnUjKxnH0dPDOsq8rK4ELc6TR1e0
 qIbVZsqLlUH/OoVoMTEnPPFhXhO0wh7M=
X-Gm-Gg: ASbGncuw8LoUaJvBpIYdfG4WT9W8aq9TN22pLIxvb1uyGyCk4Mazq6t/Uen+9l7uTay
 OBqcIhAcN50CsVYoI4+ReuinOatTjDkGZY4gv9HU0yguzwzCS6NrqLJW0wog/ev9NzZgoLddr24
 sVZrfrMFZyUfKqVuDVk5qwl8hvWV0r7bIqdY9BXdobRV+CvtyGT4J/uobAQiQFYRXrfdDXX7tba
 R57HKyNi402d1kN53ktojj0abPeW7MjJBzAPg==
X-Google-Smtp-Source: AGHT+IG8UmC1JtVGPuq3Q8HeKWf6Y11YOD0ghCL4E9Q2pPwtej86heMuMRvNkad3LwexQgQ79wF50vyjYW+7LQAZcmc=
X-Received: by 2002:a17:906:f586:b0:b3d:d6be:4cbe with SMTP id
 a640c23a62f3a-b3dd6be501fmr327735266b.18.1759102565288; Sun, 28 Sep 2025
 16:36:05 -0700 (PDT)
MIME-Version: 1.0
References: <20250917114450.175892-1-luc.michel@amd.com>
 <20250917114450.175892-5-luc.michel@amd.com>
In-Reply-To: <20250917114450.175892-5-luc.michel@amd.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 29 Sep 2025 09:35:38 +1000
X-Gm-Features: AS18NWCd7M3pY-ULQbN3tNzSPRcE3-9A3kwkHeA_qnAcH8LlwzizUQDKmAdm8SQ
Message-ID: <CAKmqyKMY3p=5RzeYRjF_twtE6p2yeahJPBoqcFW4ZHsVaRYZYg@mail.gmail.com>
Subject: Re: [PATCH 4/7] hw/core/register: remove the `register_finalize_block'
 function
To: Luc Michel <luc.michel@amd.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 Peter Maydell <peter.maydell@linaro.org>,
 Francisco Iglesias <francisco.iglesias@amd.com>, 
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Alistair Francis <alistair@alistair23.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x530.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Wed, Sep 17, 2025 at 9:50=E2=80=AFPM Luc Michel <luc.michel@amd.com> wro=
te:
>
> This function is now unused. Drop it.
>
> Signed-off-by: Luc Michel <luc.michel@amd.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  include/hw/register.h | 14 --------------
>  hw/core/register.c    |  4 ----
>  2 files changed, 18 deletions(-)
>
> diff --git a/include/hw/register.h b/include/hw/register.h
> index 65c82600e06..7b0f4c8b7a6 100644
> --- a/include/hw/register.h
> +++ b/include/hw/register.h
> @@ -207,20 +207,6 @@ RegisterInfoArray *register_init_block64(DeviceState=
 *owner,
>                                           uint64_t *data,
>                                           const MemoryRegionOps *ops,
>                                           bool debug_enabled,
>                                           uint64_t memory_size);
>
> -/**
> - * This function should be called to cleanup the registers that were ini=
tialized
> - * when calling register_init_block32(). This function should only be ca=
lled
> - * from the device's instance_finalize function.
> - *
> - * Any memory operations that the device performed that require cleanup =
(such
> - * as creating subregions) need to be called before calling this functio=
n.
> - *
> - * @r_array: A structure containing all of the registers, as returned by
> - *           register_init_block32()
> - */
> -
> -void register_finalize_block(RegisterInfoArray *r_array);
> -
>  #endif
> diff --git a/hw/core/register.c b/hw/core/register.c
> index 4d1cce02a55..6cfcfcd2b14 100644
> --- a/hw/core/register.c
> +++ b/hw/core/register.c
> @@ -321,14 +321,10 @@ static void register_array_finalize(Object *obj)
>
>      object_unparent(OBJECT(&r_array->mem));
>      g_free(r_array->r);
>  }
>
> -void register_finalize_block(RegisterInfoArray *r_array)
> -{
> -}
> -
>  static const TypeInfo register_array_info =3D {
>      .name  =3D TYPE_REGISTER_ARRAY,
>      .parent =3D TYPE_OBJECT,
>      .instance_size =3D sizeof(RegisterInfoArray),
>      .instance_finalize =3D register_array_finalize,
> --
> 2.50.1
>
>

