Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1219BC369AB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 08:57:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7sO5-0004Ma-Ei; Thu, 24 Apr 2025 04:56:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1u7sO3-0004M8-Vy
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 04:56:52 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1u7sO1-0005Vc-JY
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 04:56:51 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-ac6ed4ab410so124422066b.1
 for <qemu-devel@nongnu.org>; Thu, 24 Apr 2025 01:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745485007; x=1746089807; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Wyii2gVUlHMETKICBvd5cXPe4KRSBYBg1zEb5ptBvVI=;
 b=W0HWkfPMYll7bKDbm9811+UcaoEORu0pTXDIfenWFIdCKPqLga1Gw1aFvNGzfL3OOi
 mNtNp/Xn6sOSakIOOimJejH9exLHrTR5taTyryfm/uMGgeDQrVnVtDtyhZLIUbiE6Nmp
 z5WdgnXS/0QDDS5oWKro901dylY15vCNqxwr8HSF8y5+DSsJBUIwLx9jsze6w0JIpzyb
 HJ7wyvElo+vDgqFisR9D8Or2x+BYtfJwj/pkDbk2ZLsJ0ofSy5tU25BVnFlj++mU3RNQ
 t2QhFZl3adQc1JtgbF6C6kzeyKzXxAjsv1uSvuqqxEQ5LFXmfOn+CbvRjP1tPprHaMQM
 0BxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745485007; x=1746089807;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Wyii2gVUlHMETKICBvd5cXPe4KRSBYBg1zEb5ptBvVI=;
 b=LR81tVR37a40zJPD1oBVd5YZDzbQJOA/2nBsUmBLRn6xYip7DjTuUWSjR6QjAarEfi
 BFVsp1kPnFuHHIUeft2hOd+4owkFgKlY8kX2AsIVfHfUFe1od5tOf1Xa+KZs1k3awBnK
 yzYoJscP3MfH3uNA4HiH0h9h5BblSfjHEQLeGD7U2Ib1jddr8hJsSFj3z81imAS9sazm
 oX+NUHylVP+duy0e+bbN2lMnqNbipDgOMYE9crtsvIhVyJQ0DpgSiYFOe9NOop71UnDN
 tpy7zH8HElT/7/yzk7Z0O7i4wpf2SsNho9mQZbFGRfKUal+ntdUDF0sptxY80ZF/5IMh
 Tb9w==
X-Gm-Message-State: AOJu0YxR8uFtslNPq2eVArNuHokGPSWvK2BZakKQv0uXa2SXjTbbi4/i
 z26fC2/Ect276B9wCrEibxTpNM3Eyx8X9jT9Y0SBm7F5fXmTh77mmnLrF4rKxNpeqEeM7FkMluc
 Fx0WKksIfKt4Tp6Boln1FcEclKWk=
X-Gm-Gg: ASbGnctlbz5ZKwrGx7fNloZIRdE0GDSdAxAF1a/773fg0rlhVlWWVtLx121xaqOz1Rk
 ucdNFhH7KFRhmvvkjsD+/NhRzG2EuFG3xVEzgNKjac4UU5GmgRS1yIUbJ1LuVeYy1o0zNtbGWqa
 dGI71vhCwpWTR98E30HBnT6C4=
X-Google-Smtp-Source: AGHT+IE0185jEeLAXPNuUjeJkHTj7XXhp4cWyzfuTW+oaQypQw1CTQrL4R4+JSVINPv4xToAvAvyw2A0o+8Pl1Ak2aY=
X-Received: by 2002:a17:907:d27:b0:ac2:7f28:684e with SMTP id
 a640c23a62f3a-ace570e0d79mr166690466b.6.1745485006971; Thu, 24 Apr 2025
 01:56:46 -0700 (PDT)
MIME-Version: 1.0
References: <20250402135402.14526-1-zhangckid@gmail.com>
 <d39ed054-d99b-46a8-afc8-1a2981d919e1@linaro.org>
 <CAK3tnvLqGLzQffAi=dk_VzXgH_k_r_z2xNTN3tVE-G+xjpPWcw@mail.gmail.com>
In-Reply-To: <CAK3tnvLqGLzQffAi=dk_VzXgH_k_r_z2xNTN3tVE-G+xjpPWcw@mail.gmail.com>
From: Zhang Chen <zhangckid@gmail.com>
Date: Thu, 24 Apr 2025 16:56:10 +0800
X-Gm-Features: ATxdqUHsoJv3aeS5Aa80gGGEeuiNq_SXkSgqpa8yrz5m77dT5JeiZTvv6xelEXA
Message-ID: <CAK3tnvJMOe+rtjnwbfQ8nuZyQAtGMPKjgXBVo2RpkmKNtzAXpQ@mail.gmail.com>
Subject: Re: [PATCH] hw/arm/virt.c: Fix wrong default cpu type in AARCH64
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=zhangckid@gmail.com; helo=mail-ej1-x633.google.com
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

On Thu, Apr 3, 2025 at 10:23=E2=80=AFAM Zhang Chen <zhangckid@gmail.com> wr=
ote:
>
> On Thu, Apr 3, 2025 at 2:43=E2=80=AFAM Richard Henderson
> <richard.henderson@linaro.org> wrote:
> >
> > On 4/2/25 06:54, Zhang Chen wrote:
> > > Because of the CONFIG_TCG auto enabled, the cpu type "cortex-a15"
> > > is mistakenly set to the default AARCH64 target.
> >
> > This is the correct backward compatible setting.
> > In essence, it means that you *must* supply a -cpu argument.
> >
> >
>
> If the "-cpu" is required, the VM should not be started without this argu=
ment.
> If yes, I will skip this patch and submit another one to make QEMU
> refuse to start without this parameter.
>

Ping... and let me explain this status, it is not just for the default valu=
e.
1. The cpu type "cortex-a15" is not the correct backward compatible
setting for AARCH64 target.
The ARM cortex-a15 is a 32 bit CPU based on ARMv7-A architecture. It
can not boot for AARCH64 target.
For example, the Apple M silicon can not boot with the default -cpu value.

2. Most of QEMU docs does not said user *must* supply a -cpu argument.
https://www.qemu.org/docs/master/system/qemu-manpage.html

Thanks
Chen

> Thanks
> Chen
>
> > r~
> >
> > >
> > > Signed-off-by: Zhang Chen <zhangckid@gmail.com>
> > > ---
> > >   hw/arm/virt.c | 5 +++--
> > >   1 file changed, 3 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> > > index a96452f17a..63649e9543 100644
> > > --- a/hw/arm/virt.c
> > > +++ b/hw/arm/virt.c
> > > @@ -3178,9 +3178,10 @@ static void virt_machine_class_init(ObjectClas=
s *oc, void *data)
> > >       mc->cpu_index_to_instance_props =3D virt_cpu_index_to_props;
> > >   #ifdef CONFIG_TCG
> > >       mc->default_cpu_type =3D ARM_CPU_TYPE_NAME("cortex-a15");
> > > -#else
> > > +#ifdef TARGET_AARCH64
> > >       mc->default_cpu_type =3D ARM_CPU_TYPE_NAME("max");
> > > -#endif
> > > +#endif /* TARGET_AARCH64 */
> > > +#endif /* CONFIG_TCG */
> > >       mc->valid_cpu_types =3D valid_cpu_types;
> > >       mc->get_default_cpu_node_id =3D virt_get_default_cpu_node_id;
> > >       mc->kvm_type =3D virt_kvm_type;
> >
> >

