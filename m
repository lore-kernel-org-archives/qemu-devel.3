Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04DBCC3ABD8
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 12:43:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFBRD-0005oB-7J; Wed, 14 May 2025 08:42:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1uFBRB-0005nU-Gj
 for qemu-devel@nongnu.org; Wed, 14 May 2025 08:42:17 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1uFBR7-000672-1o
 for qemu-devel@nongnu.org; Wed, 14 May 2025 08:42:17 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5fbf0324faaso13751638a12.1
 for <qemu-devel@nongnu.org>; Wed, 14 May 2025 05:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=adacore.com; s=google; t=1747226524; x=1747831324; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6eX7PdtbY7MsbAYfz5XbSkZ+MJFpe8kpenUP/WPVwho=;
 b=BVKDnztvzgv1ZKKzxFeB0fgxZ59OVGkgk3U9YBQpyLJv6gvUWXJCMBcKigHbjTYhNF
 a6CwiWdVOhaWfvopsujC4HIzKeh0lS36IPXtmx6TtfykHY1+kwP97Uh+AzdDA1f21DiQ
 8EJSCaItsPpOP2z9UJtXZ7Vu0EzmWDIhWqDSZYfr5qUpn/KH4uY/dIgAqeYtev931bO2
 p6g8krSLWiDhJ1//yqpBYnHH1gPNaouZDTTAS2D+vfNrvrnc3cZi0g0wlMQoMEg+COtM
 ylDNb5W56chsFthBohN9IAHjVCvMciFZUc0Q9EYLtre2qGNxCfWR34LOmiqo/kOLnObh
 jhng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747226524; x=1747831324;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6eX7PdtbY7MsbAYfz5XbSkZ+MJFpe8kpenUP/WPVwho=;
 b=r1wbFiY79ePnBDechVc8segx+z0no5SB+wYatTkHPagmKdisLyu6hpmPtewXHsUwLf
 YX4NZ6j/rc9Upy2Ryv1InWNK7a1nMyNik1DVC9apY5QxRWz4nIZ1RsK7PnyDLbEyygfh
 HqnNDkTZ4trcTKAcphT7MqGBTbBmr01acwh6G7i3i8Z3j5H5xAwZSFM248HkTkluJ9Qi
 M8TiWWJJ7fkXGqKevqgVb3zELL284UzBhZ5piJ6sjgrXJyOjWBEduvsVMAo6+IENYkrY
 oXAFJPmQR27/8uLyDUWxUZaZAobxcg6IeuZQAxrXzfBd0wOUudXI/fmdmAhcHRAasEiB
 sktA==
X-Gm-Message-State: AOJu0YypxW4X3iI5v4pieRZeV66Cte9ZbPdZZWjwgjmw2HxsrOhv9mR+
 70PDI/X0luwLbnRAfQsq+N29FEX0rDbUN52TBHPC/ndvqpyyvjD90a2t85SO3nOUdY9fgFbViZ7
 gBwXQ1b5DMqgKY/LfmmyXtm2+OaVvLVpqM1Zl
X-Gm-Gg: ASbGncuNNWerMAXHiBF2+GtywidaqqKK8oU2BnMPutVFTItLv58Th/G0XipcmkggvAE
 sItzXAiud6+dbjJUATnJBtD8bGeB2jVWs0D91eexpQPQLh05KXepm2e9QL882tYuSYG9acwFPer
 +N8q6PM52VQZ+cbmbcgGScveYhf9qS7b6q43GI0X15E0Y=
X-Google-Smtp-Source: AGHT+IE0oB6ypYeyYZ+6kt3gB/hwYw8UZwUhH7GyEJwmJTtpdLjRZokOZPsGrvwKa+uhIIO4WQeReijyNDhOykTK1eE=
X-Received: by 2002:a05:6402:5206:b0:5fe:a303:a6a3 with SMTP id
 4fb4d7f45d1cf-5ff988d4395mr2521901a12.23.1747226524236; Wed, 14 May 2025
 05:42:04 -0700 (PDT)
MIME-Version: 1.0
References: <20250513141448.297946-1-chigot@adacore.com>
 <20250513141448.297946-3-chigot@adacore.com>
 <3314f721-9c5e-479b-9fcc-3b8a021efde9@linaro.org>
In-Reply-To: <3314f721-9c5e-479b-9fcc-3b8a021efde9@linaro.org>
From: =?UTF-8?Q?Cl=C3=A9ment_Chigot?= <chigot@adacore.com>
Date: Wed, 14 May 2025 14:41:53 +0200
X-Gm-Features: AX0GCFs9sB9dU3DXj9r2AtuDGU5ek73ux-p6vpxb-9vRFUwtSKqMzOURCT28ijU
Message-ID: <CAJ307EjyFBDLMe6EaeNUTWSwNTkSxSYJq5VxAD5u0BwZVu4Fqw@mail.gmail.com>
Subject: Re: [PATCH 2/4] hw/intc/arm_gic: introduce a first-cpu-index property
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 qemu-arm@nongnu.org, 
 peter.maydell@linaro.org, edgar.iglesias@gmail.com, alistair@alistair23.me, 
 Frederic Konrad <konrad.frederic@yahoo.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=chigot@adacore.com; helo=mail-ed1-x52b.google.com
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

On Tue, May 13, 2025 at 5:39=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> On 13/5/25 16:14, Cl=C3=A9ment Chigot wrote:
> > From: Frederic Konrad <konrad.frederic@yahoo.fr>
> >
> > This introduces a first-cpu-index property to the arm-gic, as some SOCs
> > could have two separate GIC (ie: the zynqmp).
> >
> > Signed-off-by: Cl=C3=A9ment Chigot <chigot@adacore.com>
> > ---
> >   hw/intc/arm_gic.c                | 2 +-
> >   hw/intc/arm_gic_common.c         | 1 +
> >   include/hw/intc/arm_gic_common.h | 2 ++
> >   3 files changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/hw/intc/arm_gic.c b/hw/intc/arm_gic.c
> > index d18bef40fc..899f133363 100644
> > --- a/hw/intc/arm_gic.c
> > +++ b/hw/intc/arm_gic.c
> > @@ -59,7 +59,7 @@ static const uint8_t gic_id_gicv2[] =3D {
> >   static inline int gic_get_current_cpu(GICState *s)
> >   {
> >       if (!qtest_enabled() && s->num_cpu > 1) {
> > -        return current_cpu->cpu_index;
> > +        return current_cpu->cpu_index - s->first_cpu_index;
>
> Note, CPUState::cpu_index is meant for accelerators code and shouldn't
> be used in hw/ (in particular because it vary when using hotplug).

Is there another way to perform that then ? As you can see `cpu_index`
is already present prior to my patch. I don't mind improving it as a
prerequisite for that series though.

> >       }
> >       return 0;
> >   }
> > diff --git a/hw/intc/arm_gic_common.c b/hw/intc/arm_gic_common.c
> > index 0f0c48d89a..ed5be05645 100644
> > --- a/hw/intc/arm_gic_common.c
> > +++ b/hw/intc/arm_gic_common.c
> > @@ -350,6 +350,7 @@ static void arm_gic_common_linux_init(ARMLinuxBootI=
f *obj,
> >
> >   static const Property arm_gic_common_properties[] =3D {
> >       DEFINE_PROP_UINT32("num-cpu", GICState, num_cpu, 1),
> > +    DEFINE_PROP_UINT32("first-cpu-index", GICState, first_cpu_index, 0=
),
> >       DEFINE_PROP_UINT32("num-irq", GICState, num_irq, 32),
> >       /* Revision can be 1 or 2 for GIC architecture specification
> >        * versions 1 or 2, or 0 to indicate the legacy 11MPCore GIC.
> > diff --git a/include/hw/intc/arm_gic_common.h b/include/hw/intc/arm_gic=
_common.h
> > index 97fea4102d..93a3cc2bf8 100644
> > --- a/include/hw/intc/arm_gic_common.h
> > +++ b/include/hw/intc/arm_gic_common.h
> > @@ -129,6 +129,8 @@ struct GICState {
> >       uint32_t num_lrs;
> >
> >       uint32_t num_cpu;
> > +    /* cpu_index of the first CPU, attached to this GIC.  */
> > +    uint32_t first_cpu_index;
> >
> >       MemoryRegion iomem; /* Distributor */
> >       /* This is just so we can have an opaque pointer which identifies
>
> Alternative series motivated to remove &first_cpu / qemu_get_cpu():
> https://lore.kernel.org/qemu-devel/20231212162935.42910-1-philmd@linaro.o=
rg/

