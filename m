Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 087D2606A326
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 13:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xI6dwnZr
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOxTd-0003lh-1n; Thu, 05 Nov 2026 08:26:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xOxTa-0003f2-KW
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 08:25:58 -0500
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xOxTW-0002vY-EP
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 08:25:58 -0500
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-6acb9c018ffso1089348a12.1
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 05:25:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793885152; cv=none;
 d=google.com; s=arc-20260327;
 b=LUCG1DT4sIV23M9gB2qcraxlCt+yfc1Be0ky60KgzyhJpwI0+aHGdsvgs2Uync7XUg
 orb+85VQ8B/zGG0TcIO52ZWRZM4xPHFbQc9L7Xt0Md7sLww6gI1oOaBX1UvPtcOMIMQs
 L2Zm1Scgwei7HoHDSXhMQcU4QROCXFvlOr40bWkNwQ5dHyzVaWn7dIIaaYHXpdL5CwHa
 F6dJSQFpjgdLNhgp9vSVmpBit4Ka4ouv0Fdb4Rg9LFpUpniaUfNA33Wi/GZTCQ2yR8At
 S4xpV3cqMbpQ+pOJlJXS4qIFZxnZ/vjeJzh32teH5mEmnm3WfZnzVV6/8cMizWVK/+G0
 sAPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=6UZ5gR1xV5mL+paG9/KMhE8nTbKcPZDCYjb0LfUzpDg=;
 fh=5wnEN+1PBErBuqm697CiM0ygFndTj3bRhEw9XWifuiM=;
 b=D/LX32QEPvcVL1dj/rtE4Zxqd5zZ8g/4ZCdZ4o1MwVCO4/wZAhtqHo5nsmP649uPrW
 XFq4cJ8/OduEJVv94QV886onlMF6bD+HecgfCTcmiaa38UheiCnUwI0ROcWWn72z3lqH
 JcRVSwVuYUsAgeYnwYAp7nUucL+KPY92RiVL95lEARjo642qtzZwE0zOmyORMZLT5yLW
 M7+i6OBJNmHZNaPD2Ix0h9g+vOrvm4fFMJ4cXoRGx+7EnYk+h2sQtpnWWmnFAMvcwNqo
 W8764mhOcxoGbkS5tJrtsW1LgheQdIuKQjiXbleTmSGiPbIkRm5TthGevGHjm2bXkjIy
 PtjA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793885152; x=1794489952; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=6UZ5gR1xV5mL+paG9/KMhE8nTbKcPZDCYjb0LfUzpDg=;
 b=xI6dwnZrjh+JRNiFRplBHQxCHHBSOYb2cbAnvpOcZqiWUMvkLMeKXS3VQa7dT2FkiO
 tVr1a4M3SBj/pn1eOmeKGH1xmW4/pn77r4yayypM4ptOIgDrFNB3w/fN/7RgC8T8n8id
 IhKud6qDb2ythkhupEsGoXyHCbf2NWat4YVNwJMTUCk/2k7bwn7wC0bwXrCEeS6msSWP
 ZRnX0LsK4rvSI2uuMdjcs20WchYxFLFS6GxHmF+q3pUnT+pQbBLQ206w9VC5wW/qEcfk
 3nz2fD662LJAmbnQStJGb2yMbTMMRhk2O2dOQXuuIYOWElh5M1RcMyPHzUL3NI758Rhd
 eL9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793885152; x=1794489952;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6UZ5gR1xV5mL+paG9/KMhE8nTbKcPZDCYjb0LfUzpDg=;
 b=O0FuDQT9aHlGbzCf/9XCQCYFfTVjKTayNfwY+VzHP7/Ib5c5AwKVB5CCHMPN3BxmeQ
 2YEKRLI0QseHkgq9KBaMjbsAHB3a4Z8Zoz10MtZLa3WlgK2Uy9m6wEz0GRcOz5HoMNLq
 wGV30np4K0nzo6f11br4Hn5HyKlJCozLmqCG0voWr06+T5pwjLglENubjeYzzhMKqwxI
 tPB/E7gjDRf3uxDCofpTed3q8va4ezNtFr21aXCUimf1u6Tyi4qlbh0UphwgNwzghMwZ
 2XRv5bYaS+NQrmoxDjKnGZ5l9I29JuFVjK6wSRjui6IeB7NF2R4SkduKna/qn0jQWOK3
 5AGg==
X-Gm-Message-State: APuU4Z/1bsDOSuCgeIFmYDwHHOn4jqtHh1A/7iyFYqazcw8ZYsCnsn8z
 rW0uHLf4BTskBEuWHi0mNJlrWy9FilKrbXo9cM52ffZBFGRP5ik2Ogolsirg6/wkPQ5Ohoy7x5v
 +il1eviYuIkzYa+lXmszEqcdZDEpldfI=
X-Gm-Gg: AYBFou2Es0h0xuFVjs0AlZ5q/ftoUOViqxvY5I4Mshes4DKZ/Wl8dfVykRni7o2iYX0
 sC+N3yiZoh9wgwamsRietoyy8PUgt09EdJlJ0ZS/cQdo1TRz075WA0QkC8nxRa6ikZTQ+N1AXCW
 FLv3yyGvE6CZMKMro9EKaC1zYuNhC0s8fBkwTLqw4798WmbeKUy61Op26MkjXjjX1N5u7DC5pxP
 WNfjvDdfYWI2N7VCoVc9tA0J3z+u9jHI9QQpgxv87ilRAhVamzm50r/vq66H7JZx+vVEul+lP4+
 Am7eDy0mMsO1AMiEQ0PmaDAdIegKTmwqysdGLnzQfRnlSx3A3R5B7x63H7OLRHtA7Hm9r+hU2MV
 7QArSqYubq9V/yjpRx2JxaUoJu0cS7yXjlrcaS0bJsWDYUYl2cA7ZifybVA==
X-Received: by 2002:a05:6402:540d:b0:6b4:dcab:bf9f with SMTP id
 4fb4d7f45d1cf-6b5771fc038mr2078001a12.16.1793885152327; Thu, 05 Nov 2026
 05:25:52 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261031164009.2048-1-luoyonggang@gmail.com>
 <20261031164009.2048-7-luoyonggang@gmail.com>
 <auxgsFyzv-5UiyNk@redhat.com>
 <CAE2XoE9J++-BHL5BDx4_jxuto+xwVmvFS3F-hE9gLbgfUmaFdA@mail.gmail.com>
 <aux5vwTnbV3cXcFX@redhat.com>
In-Reply-To: <aux5vwTnbV3cXcFX@redhat.com>
From: Yonggang Luo <luoyonggang@gmail.com>
Date: Thu, 5 Nov 2026 21:25:39 +0800
X-Gm-Features: AclHuK_9QSm8YCgsb7dwql8aPYKqsrUIPCNRhBLCQRzD3bPkMMPJRu01tqhmlSQ
Message-ID: <CAE2XoE-fTKqUB0TZh0-HW6RuMyWJhMGDijarhGSmwsYVTWAcPQ@mail.gmail.com>
Subject: Re: [PATCH v2 06/12] target/arm: register separate max-v8 CPU types
 for arm and aarch64
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, 
 Song Gao <17746591750@163.com>, Matthew Rosato <mjrosato@linux.ibm.com>, 
 Philippe Mathieu-Daude <philmd@mailo.com>, David Hildenbrand <david@kernel.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Fam Zheng <fam@euphon.net>, Max Filippov <jcmvbkbc@gmail.com>, 
 "qemu-s390x@nongnu.org" <qemu-s390x@nongnu.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Eric Farman <farman@linux.ibm.com>, 
 Peter Maydell <peter.maydell@linaro.org>, Cornelia Huck <cohuck@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=luoyonggang@gmail.com; helo=mail-ed1-x52f.google.com
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
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thursday, November 5, 2026, Daniel P. Berrang=C3=A9 <berrange@redhat.com=
> wrote:
>
> On Thu, Nov 05, 2026 at 07:14:35PM +0800, Yonggang Luo wrote:
> > On Thu, Nov 5, 2026 at 6:55=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrang=
e@redhat.com> wrote:
> > >
> > > On Sun, Nov 01, 2026 at 12:40:01AM +0800, Yonggang Luo wrote:
> > > > max-v8 was one TypeInfo whose instance initializer was chosen from =
the
> > > > selected target at registration. Register both initializers, and le=
t
> > > > target_arm() and target_aarch64() select which type is available.
> > > >
> > > > Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> > > > Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> > > > ---
> > > >  target/arm/cpu.c            |  1 +
> > > >  target/arm/cpu.h            |  1 +
> > > >  target/arm/tcg/cpu-max-v8.c | 16 ++++++++++++----
> > > >  3 files changed, 14 insertions(+), 4 deletions(-)
> > > >
> > > > diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> > > > index 510fc9eeb3b..6eb55242980 100644
> > > > --- a/target/arm/cpu.c
> > > > +++ b/target/arm/cpu.c
> > > > @@ -2695,6 +2695,7 @@ void arm_cpu_register(const ARMCPUInfo *info)
> > > >          .instance_init =3D arm_cpu_instance_init,
> > > >          .class_init =3D info->class_init ?: cpu_register_class_ini=
t,
> > > >          .class_data =3D info,
> > > > +        .is_available =3D info->is_available,
> > > >      };
> > > >
> > > >      type_info.name =3D g_strdup_printf("%s-" TYPE_ARM_CPU, info->n=
ame);
> > > > diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> > > > index add993ef101..3240a8633ee 100644
> > > > --- a/target/arm/cpu.h
> > > > +++ b/target/arm/cpu.h
> > > > @@ -1203,6 +1203,7 @@ typedef struct ARMCPUInfo {
> > > >      const char *deprecation_note;
> > > >      void (*initfn)(Object *obj);
> > > >      void (*class_init)(ObjectClass *oc, const void *data);
> > > > +    bool (*is_available)(void);
> > > >  } ARMCPUInfo;
> > > >
> > > >  /**
> > > > diff --git a/target/arm/tcg/cpu-max-v8.c b/target/arm/tcg/cpu-max-v=
8.c
> > > > index 65f851f2006..e819d07e6ce 100644
> > > > --- a/target/arm/tcg/cpu-max-v8.c
> > > > +++ b/target/arm/tcg/cpu-max-v8.c
> > > > @@ -121,10 +121,18 @@ void aarch32_max_v8_tcg_initfn(Object *obj)
> > > >
> > > >  static void cpu_max_v8_register_type(void)
> > > >  {
> > > > -    static const ARMCPUInfo max_v8[2] =3D {
> > > > -        { .name =3D "max-v8", .initfn =3D aarch32_max_v8_tcg_initf=
n },
> > > > -        { .name =3D "max-v8", .initfn =3D aarch64_max_v8_tcg_initf=
n },
> > > > +    static const ARMCPUInfo max_v8_aarch32 =3D {
> > > > +        .name =3D "max-v8",
> > > > +        .initfn =3D aarch32_max_v8_tcg_initfn,
> > > > +        .is_available =3D target_arm,
> > > >      };
> > > > -    arm_cpu_register(&max_v8[target_aarch64()]);
> > > > +    static const ARMCPUInfo max_v8_aarch64 =3D {
> > > > +        .name =3D "max-v8",
> > > > +        .initfn =3D aarch64_max_v8_tcg_initfn,
> > > > +        .is_available =3D target_aarch64,
> > > > +    };
> > > > +
> > > > +    arm_cpu_register(&max_v8_aarch32);
> > > > +    arm_cpu_register(&max_v8_aarch64);
> > > >  }
> > > >  type_init(cpu_max_v8_register_type)
> > >
> > > Conceptually these are two separate CPUs one 32-bit featureset
> > > and one 64-bit featureset, but both given the same name. The
> > > current code registers them only in the respective arm and aarch64
> > > target binaries, but this CPU is an oddity overall.
> >
> > This is the one I did before
> > https://lore.kernel.org/qemu-devel/20261013195606.152-1-luoyonggang@gma=
il.com/
> >
> > target/arm: defer max-v8 initializer selection until CPU creation
> > but rejected, and I think it's fine.
>
> So that essentially matches the historical semantics where one
> CPU class magically changes its behaviour based on what target
> is running.  So in that sense, it works, and is no worse than
> the semantics we've had for 'max' models forever.
>
> Splitting into 2 distinct types is worthwhile if we want to
> make it possible for the aarch64 emulator to support a runtime
> choice of both 32-bit and 64-bit "max" models.
>
> This patch doesn't allow that though, as it is creating two
> classes with the same name and filtering which is registered.
> If we don't intend to allow 64-bit target to ever use a 32-bit
> 'max' CPU, then your original patch is better IMHO.


Hi Daniel, this is a prepare to allow creating two classes with the same na=
me,
the is_available will be removed later.

Maybe I should directly replace is_available with TypeBucket to get
things be clear to review,
but that is explicitly rejected by Pierrick

>
>
> > > More generally the aarch64 emulator includes all the 32-bit CPUs
> > > that the arm emulator includes, and just adds extra 64-bit CPUs.
> > > IOW, excluding the 32-bit max-v8 CPU is a special case - if it
> > > were not for the clashing name, it would be included like all the
> > > other 32-bit CPUs.
> > >
> > > Thus rather than using is_available to continue to exclude it,
> > > we must instead resolve the naming problem, such that both
> > > models can be included concurrently.
> >
> > I have already implemented the TypeBucket over targets/arch_mask that w=
orks
> > properly. That same QOM name will have multiple TypeImpl.
>
> I'm not sure what you mean by TypeBucket, but my general thought is that
> at the QOM class/type naming level everything must always be unique,
> such that we have a single object modelk across QEMU.
>
> Any ambiguitity & its resolution (if needed) should live outside core
> QOM typework, such as with aliases in machines/CPUs.

Yeap, it's a design choice, both renaming the QOM type with
MachineClass::targets;
or using TypeBucket in object.c(so all QOM types do not need rename
including "virt" machines)
is implemented by me, it's just finally what we want to do.

>
> If we have a common pattern for aliases, perhaps we could create a
> standard QOM Interface for resolving aliases.
>
>
> With regards,
> Daniel
> --
> |: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
> |: https://libvirt.org          ~~          https://entangle-photo.org :|
> |: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|
>

