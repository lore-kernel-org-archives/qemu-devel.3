Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA1F0606BFB5
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 19:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=v5s7hmFz
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM8vf-00075i-5d; Wed, 28 Oct 2026 15:03:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xM8vB-0006xm-MZ
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 15:02:55 -0400
Received: from mail-yx1-xb130.google.com ([2607:f8b0:4864:20::b130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xM8v8-0003zQ-KN
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 15:02:48 -0400
Received: by mail-yx1-xb130.google.com with SMTP id
 956f58d0204a3-679e86015e2so2717408d50.1
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 12:02:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793214165; cv=none;
 d=google.com; s=arc-20260327;
 b=DPaF5m2K/rykzG4sb0JPkDln1EeSdgcLHYpM2I99CyAEPOxbPslJE9zTKVXzRoCmxL
 bYkVyb/nRNOhmGHGhXI0nAKKZk8fv7Nqh9jseyHsCP1UvZ/MWt1EABTOLQd8QyM60Lcz
 JcGPsOhAf3UolkHD2yJWlkHrIKDkfNlRmpiCiAg8HiC4LUnvYcm65yqp2tGMqzzRx+kG
 Ib8XKuAeq67nRiSPooAmEFYoyQsoT1rj6MPYwfeJb2cpD/Xo9Gsb4DMcP/tO9zQCoesP
 Dku5Tewl1vfZc39XiPWwx4QvFqAPJ3eSuV895n+oybt8AdX841WG2zyMaVh27B+ssHC0
 5YMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=SQLvMiCpiVOTd49aL7ZS4Hwkv6j4PcOfxzajO064Rk0=;
 fh=MsLaIlcIPA50HmX74wi2HNsjjsYbTt2Ekvbc68GyrkY=;
 b=W44vf29t9wOo+xLxONNwPGy7sSxkjkuo9RRkNqm9a+dp9IbAeooCS/4K1//RBdcH2A
 imFUo2qZrJAfJmKA627SgLFv00RIO+qJCkMpTGt/s3ArgXJnFZWh4aRr2ppVBfyD1eHV
 ykxmo0Wj2g/ZREkW4zbeoFRoZr/eHZeIN9LnYOBLbJp7WmsHSq6//tg6tylvXt+CjwAe
 GOzcbmJxhd/WxlUzhqga5maxX4Lzcc9zoXjfSLvm6E7lOtvTZlK51VIQXrFJkmaG1S/P
 nRznRqy5vKsBw1IGIGn8rnfH0BWLiIt/L7mVt+7IGLjG01NWZDN8paLemIVjbJtDwGEC
 BHUg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793214165; x=1793818965; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=SQLvMiCpiVOTd49aL7ZS4Hwkv6j4PcOfxzajO064Rk0=;
 b=v5s7hmFzdi6HeaoQlf1YSX9Jc5YJRjYYdGArxmz7dM580OQS16iSehNeJqKaZtFRz3
 LAHO7/NmQZB0sYlF2qxz2HIMkx1Awt0DwREf92OjJ5Ul8N7VpdHhgopxgRF3tLAJboLt
 mbZWLZtdvD9X9Rz8uerzsZvKcHyxhdk11zhoAPdTKXPFfDPhJMS73sffS3pJKq6X2lny
 THhGjjZcBRYpQI6PfIZnz06CtsVD6UJyJYlT+26mkSI56sxmlFrqlZvI24KDaYDanGPM
 pkX6sHaznCysutrhUb90z72JAzligRHEU/j5l2MpSQST3PfqhqcjM20f/rAFNgO3gywZ
 xx+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793214165; x=1793818965;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=SQLvMiCpiVOTd49aL7ZS4Hwkv6j4PcOfxzajO064Rk0=;
 b=p81JqQoy1+JnDGdNzEAKQ8aop0F11FqIQa9aVpgLIJC/5wBktwEcpxHlsmtXgloZ8E
 NkPHEOW51mkYiFPFSMhel6R8XAUKUpWDi4EaS20V0f+AUShQw5WtnGzdMw/FzMni/eAm
 9kMYX31kue3zjW7DX3eE6WsAwUwpgS9Z19rO9hkeuumxoXHk725qKd85MMRe8Cy/CMOz
 H2Evmr3bJ+yb+eeIBtOENEuDWmd74hrXJDxAlkEAfhwjbbiers0oKkBlsCzzFcxdMkAr
 3pgJ7RSIoBE+gKQNz031Zpn1LPLLnsl4dkgfBVmyqq3/WfAE+RT92qiL9wM9dB7Im+Ay
 sxzg==
X-Gm-Message-State: AFq9FYKM0VUL9XbJyHqPpT3U9GcV4iOl67gtMIYg5Spuqw8H4Sew0FDH
 BG4jeBpAiQolQYXOgt+7IwkjBBmssxBsIT4/FLDijjMPfBPr6vJaNvQn7BkWG1RoO2Tfm/BwEm0
 k1q4WZZEep5AMAov16f+QrBTALjsnbVM=
X-Gm-Gg: AYBFou0Ed8HGC+xkDmcH/IzZtPHNqXa8gdKl4fAC7UhQUlAGoTNo6i2pl6EIWbPw//b
 PFQasbN7BNQCPmPQuhPPkMT6qyjGE8/jncgfcm3ePXTI5LIxCXRXzz+8MocgoD7Hf8fNfpJ3IBS
 hwHIcL1ZEptFL/B3yd/BUKQheHHBNpfViSZqdB39YEPY1FKLWlr0oX+hxomrTH7Tv8OwYKl4yk5
 fHJhW6vevcnkQjjrTkhS8H1R+W9ZEf6+cp28eu5sZi9AArJp1zaIrkO2lVAMQ/HoDnf71AHqre3
 QaYTfOlc0M3ipH/XXFPepio8ovb05D3QAUGAy0CbmS19a/rDCCHmF4NzrkjYym7OkSMHs0rsE8+
 /xf9uEkfjOgH0k11kaKsc/ghY7L0+Tm0aFc+zut4biTNaBosABz8iIbyt/A==
X-Received: by 2002:a05:690e:80c:20b0:679:9b4c:5baa with SMTP id
 956f58d0204a3-67a8d304c91mr233756d50.50.1793214165041; Wed, 28 Oct 2026
 12:02:45 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261028063049.2530-1-luoyonggang@gmail.com>
 <20261028063049.2530-2-luoyonggang@gmail.com>
 <bc5bad6e-fbc2-44e1-a4b4-41bdfd41d33a@oss.qualcomm.com>
In-Reply-To: <bc5bad6e-fbc2-44e1-a4b4-41bdfd41d33a@oss.qualcomm.com>
From: Yonggang Luo <luoyonggang@gmail.com>
Date: Thu, 29 Oct 2026 03:02:31 +0800
X-Gm-Features: AclHuK-xtUx2DvtS0iezu4tyq4WmXhbo6cUKb6Cq1RIENkwqvf9N0UJisT-_IPg
Message-ID: <CAE2XoE_r3gZXzS+TFUd+GRs-8ZtCTajsJK0wJpTHNoXx_Cf3dA@mail.gmail.com>
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::b130;
 envelope-from=luoyonggang@gmail.com; helo=mail-yx1-xb130.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Oct 29, 2026 at 2:25=E2=80=AFAM Pierrick Bouvier
<pierrick.bouvier@oss.qualcomm.com> wrote:
>
> On 10/27/2026 10:30 PM, Yonggang Luo wrote:
> > A multi-target binary registers one accel-$cpu_type parent per linked
> > target. accel-target.c is compiled once per target and calls
> > accel_register_cpu_type() with that target's target_arch and
> > CPU_RESOLVING_TYPE. A bool array keyed by SysEmuTarget records which
> > arch already registered. Targets that share one CPU_RESOLVING_TYPE
> > reuse the parent from the earlier arch.
> >
> > test-multi-target checks that each target's accel parent exists after
> > QOM init.
> >
> > Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> > ---
> >  accel/accel-common.c           | 31 ++++++++++++++++++++++++++++---
> >  accel/accel-internal.h         |  2 ++
> >  accel/accel-target.c           | 21 +++++++++++++++++++++
> >  accel/meson.build              |  1 +
> >  tests/unit/test-multi-target.c | 22 ++++++++++++++++++++++
> >  5 files changed, 74 insertions(+), 3 deletions(-)
> >  create mode 100644 accel/accel-target.c
> >
> > diff --git a/accel/accel-common.c b/accel/accel-common.c
> > index 00a400243f0..0d04b8c5749 100644
> > --- a/accel/accel-common.c
> > +++ b/accel/accel-common.c
> > @@ -130,9 +130,9 @@ static const TypeInfo accel_types[] =3D {
> >
> >  DEFINE_TYPES(accel_types)
> >
> > -static void register_accel_target_type(void)
> > +static void register_accel_target_type(const char *cpu_type)
> >  {
> > -    g_autofree char *name =3D g_strconcat("accel-", target_cpu_type(),=
 NULL);
> > +    g_autofree char *name =3D g_strconcat("accel-", cpu_type, NULL);
> >      const TypeInfo accel_cpu_type =3D {
> >          .name =3D name,
> >          .parent =3D TYPE_OBJECT,
> > @@ -143,4 +143,29 @@ static void register_accel_target_type(void)
> >      type_register_static(&accel_cpu_type);
> >  }
> >
> > -type_init(register_accel_target_type);
> > +void accel_register_cpu_type(SysEmuTarget arch, const char *cpu_type)
> > +{
> > +    static bool accel_cpu_registered[SYS_EMU_TARGET__MAX];
> > +    static const char *accel_cpu_types[SYS_EMU_TARGET__MAX];
> > +
> > +    if (accel_cpu_registered[arch]) {
> > +        return;
> > +    }
> > +
> > +    /*
> > +     * Keyed by target_arch. Targets that share CPU_RESOLVING_TYPE alr=
eady
> > +     * have a parent from an earlier target_arch.
> > +     */
> > +    for (int i =3D 0; i < SYS_EMU_TARGET__MAX; i++) {
> > +        if (accel_cpu_registered[i] &&
> > +            g_str_equal(accel_cpu_types[i], cpu_type)) {
> > +            accel_cpu_registered[arch] =3D true;
> > +            accel_cpu_types[arch] =3D cpu_type;
> > +            return;
> > +        }
> > +    }
> > +
> > +    accel_cpu_registered[arch] =3D true;
> > +    accel_cpu_types[arch] =3D cpu_type;
> > +    register_accel_target_type(cpu_type);
> > +}
>
> No need to do this, just move the whole type registration in
> accel-target.c and type will be present at runtime for all present target=
s.

The issue is that CPU_RESOLVING_TYPE is not unique for each
target_arch, you may not realize it.
for example:
arm/aarch64 sharing same
```
#define TYPE_ARM_CPU "arm-cpu"
#define CPU_RESOLVING_TYPE TYPE_ARM_CPU
```

And the same name can not be registered twice, that's why this
accel_register_cpu_type should be
in a global shared place. We need accel_cpu_registered/accel_cpu_types
for deduplication.

>
> Regards,
> Pierrick



--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

