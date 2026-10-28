Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6BF5606A31E
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 19:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nizUNiVo
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM9Ay-0006Qf-8v; Wed, 28 Oct 2026 15:19:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xM9Aw-0006QO-Uv
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 15:19:07 -0400
Received: from mail-yx1-xb135.google.com ([2607:f8b0:4864:20::b135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xM9Au-0005KW-7z
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 15:19:06 -0400
Received: by mail-yx1-xb135.google.com with SMTP id
 956f58d0204a3-679e6ab6471so17280d50.0
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 12:19:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793215143; cv=none;
 d=google.com; s=arc-20260327;
 b=nXWmjTvS5P9cRsiV3AKJI+2NeEFm5/J0NHLIz6wEKflGPqwldjbjGaMzaKaBUp/sX2
 +9irTlz+U+v55Opfne4qzANn/yg5xXOQCT5JLWnKgVDIfr//3wFXc2iDgjmAzaW4V2jk
 HYcmtwWlxTVGKrs4k/R/8jJx30exFsAVAA5+ud+Pka3qEzsZpdn31bBHTGJb0r7mhFJX
 tusjTet6lywSS7mujVkU6bkfxRnqy+gs8zei8HnWpaCsiOjzvCM7LRRcHltN7z4Op5Wd
 FKC2RSSFYTNQPVuNSbWN0WRzRxVb3LhWAX1Twk7GfP87N//j+ElRZfdbhNnh6m9+853+
 KdIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=aTS+A681mIrnnETlSdM14Ivbll15fjA3/zVwCINUMmk=;
 fh=MsLaIlcIPA50HmX74wi2HNsjjsYbTt2Ekvbc68GyrkY=;
 b=IYEaYHP8OKgC6rSIWqCpaNOsHpSMuiOjS8Jg7uuYDEzimtv/Kn8NlB6YFcAURaBxkV
 5/SyCjsG1EzZfeEW24F4U0Opd3wxzdSz3FQahpF8xgt0UG6mFpaPqGXNz337I6WS+/N8
 +c5erzuVuzQI58XovaXZwa5tX4wdO38WURxBMxjgTqoGt0TWTlcc6VCA1gJCrAfDPb1F
 7MYMEPBP/qeuxmZFf/uIaJxbE3UC04YZa+wcd5Sv5/3sjdFlCjfsaIin6lz4ffwB2sD0
 y5N+PaPxCBiiJbASjgtFmVNbkybAa44KJNV794w/7jtc+q2+ja6yEeyPUeh65d614wnq
 3z2w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793215143; x=1793819943; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=aTS+A681mIrnnETlSdM14Ivbll15fjA3/zVwCINUMmk=;
 b=nizUNiVo/yPrRUurVl5MNBnMHT260i5nXXHKepx5FJJyG2H2sMn/E38cTOdvR44nQ5
 6fCDFJwIbWU3ECBP25E10vYZST/39E4PHMiDzy4LRveQRvSxHm09ELHHF3WlavgM+OZW
 a1jmDrXEgbJ3UPNZURp1kjwaIh7wIw4enJhBbZfK1kuJQGn5StwdHsra3/nSjYA1Q9yi
 uk/B0HVBj4d13hxCJZsqTDmFC1qHIJue8iptmMpDIyxi67Evudg0ymo4+qKwRdvD+X5I
 WesRCX8/eku0qAe8FO5O6+yFNts+N+RTZHUfldcM+S7/VkBGAFQwpbTkfI5PPVgF4Spd
 ghhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793215143; x=1793819943;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=aTS+A681mIrnnETlSdM14Ivbll15fjA3/zVwCINUMmk=;
 b=DLKv6F2rHGfbOzUEhIF1iKHqo4wzNRyY9ezxYd3/yd2eYOds8wHu5eT6CTaei6l3ov
 HMAZK1+q767A+fKEivdgu71B+Bnr5wHzIgFErskIc5J6639hmi8vdTu7x7+g+RFAbObt
 FXbFs/GbVezJoiqtjuu49pYui0LofiuWdVzcpl8NaW9+kRjlp0EDQS8NeJ8EQ5OCwekl
 92VNJoYMN/8eq2J9cCt0R1Dltkk22dHkzjFrlMTdsihquTpB4aSBGz3P8RBtFbnygspS
 kpqL5fRBMqDMzrwLdwmWyLri3FoMSWCp3e/UspxKOawzE4AJ64KulKL4lTX7WQXGIb5B
 nMVw==
X-Gm-Message-State: AFq9FYKn+67T90dqz7EgZ5POkvzqtGKvOZ8AlSD5rymMPezIBDibg2xw
 KAY8emslOePZ+DNXzJWEUjBO8U8CUPK525CYu752O3XvQk0oVyH+8KmZqs6j4+pF4PkzFE213vw
 lJL2i4QwJcvwbKdfmKYjF8yWenuvIm1w=
X-Gm-Gg: AYBFou3eSzU1hAEolu7y/c/XUXN55prHc7fTaft19CHKoXxr5QaxYIzDrNn4rgFhlu7
 vXv8xCiwaG6GrHOlj6El57FOAef3BGvZuh/qryfcLMc+chBQ9vDOE87NTE3UjwArgLsTkXMA1qj
 +xJ+s9eBvpVK5o9W0Gqcf16HO6EuU4nKEO4u3BUC3vkZDLemMrx7bl0Ii+c76SFPoFy7mqMi9Cp
 pYfa4hXj/+ttM3ZSNiFJQ+o7OwvV8HT6XWvpjlADc97wLILcGvGkH+6IIUqVi1o9rpelzrkiRox
 mfXXqzazbK/8avWBUYw7KxzJzXLeZS1+y/thG2r5/w1/AmmDm2Aiifq9iqmziJhzQIBbTpPlz+Q
 fBKZQSW2avRthfamx9bjPog/8wM+pjdSyqoQD
X-Received: by 2002:a05:690e:128e:b0:677:d4de:21a9 with SMTP id
 956f58d0204a3-67a8d05856bmr397162d50.7.1793215142955; Wed, 28 Oct 2026
 12:19:02 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261028063049.2530-1-luoyonggang@gmail.com>
 <20261028063049.2530-2-luoyonggang@gmail.com>
 <bc5bad6e-fbc2-44e1-a4b4-41bdfd41d33a@oss.qualcomm.com>
 <CAE2XoE_r3gZXzS+TFUd+GRs-8ZtCTajsJK0wJpTHNoXx_Cf3dA@mail.gmail.com>
 <7bd5d577-63db-4356-a19e-4b7e030d58d9@oss.qualcomm.com>
In-Reply-To: <7bd5d577-63db-4356-a19e-4b7e030d58d9@oss.qualcomm.com>
From: Yonggang Luo <luoyonggang@gmail.com>
Date: Thu, 29 Oct 2026 03:18:48 +0800
X-Gm-Features: AclHuK-1VSED8TUJADZfn2zB4SG6R2RQ3vj2vsCONOKdXgBTJf-jtO5fpm--rR4
Message-ID: <CAE2XoE-0zECt6yYURkTbUDBWfG63r_6Dr1oxc5XUcUXr9Wk61g@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] accel: register CPU parent for each target
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, Chao Liu <chao.liu@processmission.com>, 
 Richard Henderson <richard.henderson@linaro.org>, qemu-riscv@nongnu.org, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 Alistair Francis <alistair.francis@wdc.com>,
 Philippe Mathieu-Daude <philmd@mailo.com>, Weiwei Li <liwei1518@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b135;
 envelope-from=luoyonggang@gmail.com; helo=mail-yx1-xb135.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: luoyonggang@gmail.com
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Oct 29, 2026 at 3:06=E2=80=AFAM Pierrick Bouvier
<pierrick.bouvier@oss.qualcomm.com> wrote:
>
> On 10/28/2026 11:02 AM, Yonggang Luo wrote:
> > On Thu, Oct 29, 2026 at 2:25=E2=80=AFAM Pierrick Bouvier
> > <pierrick.bouvier@oss.qualcomm.com> wrote:
> >>
> >> On 10/27/2026 10:30 PM, Yonggang Luo wrote:
> >>> A multi-target binary registers one accel-$cpu_type parent per linked
> >>> target. accel-target.c is compiled once per target and calls
> >>> accel_register_cpu_type() with that target's target_arch and
> >>> CPU_RESOLVING_TYPE. A bool array keyed by SysEmuTarget records which
> >>> arch already registered. Targets that share one CPU_RESOLVING_TYPE
> >>> reuse the parent from the earlier arch.
> >>>
> >>> test-multi-target checks that each target's accel parent exists after
> >>> QOM init.
> >>>
> >>> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> >>> ---
> >>>  accel/accel-common.c           | 31 ++++++++++++++++++++++++++++---
> >>>  accel/accel-internal.h         |  2 ++
> >>>  accel/accel-target.c           | 21 +++++++++++++++++++++
> >>>  accel/meson.build              |  1 +
> >>>  tests/unit/test-multi-target.c | 22 ++++++++++++++++++++++
> >>>  5 files changed, 74 insertions(+), 3 deletions(-)
> >>>  create mode 100644 accel/accel-target.c
> >>>
> >>> diff --git a/accel/accel-common.c b/accel/accel-common.c
> >>> index 00a400243f0..0d04b8c5749 100644
> >>> --- a/accel/accel-common.c
> >>> +++ b/accel/accel-common.c
> >>> @@ -130,9 +130,9 @@ static const TypeInfo accel_types[] =3D {
> >>>
> >>>  DEFINE_TYPES(accel_types)
> >>>
> >>> -static void register_accel_target_type(void)
> >>> +static void register_accel_target_type(const char *cpu_type)
> >>>  {
> >>> -    g_autofree char *name =3D g_strconcat("accel-", target_cpu_type(=
), NULL);
> >>> +    g_autofree char *name =3D g_strconcat("accel-", cpu_type, NULL);
> >>>      const TypeInfo accel_cpu_type =3D {
> >>>          .name =3D name,
> >>>          .parent =3D TYPE_OBJECT,
> >>> @@ -143,4 +143,29 @@ static void register_accel_target_type(void)
> >>>      type_register_static(&accel_cpu_type);
> >>>  }
> >>>
> >>> -type_init(register_accel_target_type);
> >>> +void accel_register_cpu_type(SysEmuTarget arch, const char *cpu_type=
)
> >>> +{
> >>> +    static bool accel_cpu_registered[SYS_EMU_TARGET__MAX];
> >>> +    static const char *accel_cpu_types[SYS_EMU_TARGET__MAX];
> >>> +
> >>> +    if (accel_cpu_registered[arch]) {
> >>> +        return;
> >>> +    }
> >>> +
> >>> +    /*
> >>> +     * Keyed by target_arch. Targets that share CPU_RESOLVING_TYPE a=
lready
> >>> +     * have a parent from an earlier target_arch.
> >>> +     */
> >>> +    for (int i =3D 0; i < SYS_EMU_TARGET__MAX; i++) {
> >>> +        if (accel_cpu_registered[i] &&
> >>> +            g_str_equal(accel_cpu_types[i], cpu_type)) {
> >>> +            accel_cpu_registered[arch] =3D true;
> >>> +            accel_cpu_types[arch] =3D cpu_type;
> >>> +            return;
> >>> +        }
> >>> +    }
> >>> +
> >>> +    accel_cpu_registered[arch] =3D true;
> >>> +    accel_cpu_types[arch] =3D cpu_type;
> >>> +    register_accel_target_type(cpu_type);
> >>> +}
> >>
> >> No need to do this, just move the whole type registration in
> >> accel-target.c and type will be present at runtime for all present tar=
gets.
> >
> > The issue is that CPU_RESOLVING_TYPE is not unique for each
> > target_arch, you may not realize it.
> > for example:
> > arm/aarch64 sharing same
> > ```
> > #define TYPE_ARM_CPU "arm-cpu"
> > #define CPU_RESOLVING_TYPE TYPE_ARM_CPU
> > ```
> >
>
> Oh right. In this case, the accel-target has to be added once per base
> architecture (in each target/*/).

So you mean call register_accel_target_type at each target/$base/cpu.c?
too much duplicated code scattered.

>
> > And the same name can not be registered twice, that's why this
> > accel_register_cpu_type should be
> > in a global shared place. We need accel_cpu_registered/accel_cpu_types
> > for deduplication.
> >
> >>
> >> Regards,
> >> Pierrick
> >
> >
> >
>


--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

