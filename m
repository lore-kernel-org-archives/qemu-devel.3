Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F160606A335
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 11:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gpPlDCxZ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOvR2-0000rf-0F; Thu, 05 Nov 2026 06:15:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xOvQl-0000gC-I4
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 06:14:57 -0500
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xOvQj-0002T4-BX
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 06:14:55 -0500
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-6acb9c018ffso910118a12.1
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 03:14:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793877289; cv=none;
 d=google.com; s=arc-20260327;
 b=CbIRbSk2FwFgI9MLcO6UnD973Bcq3c8lp5rrZfoQ+IBgRqJav2YEKXJCT7/JWkwIcH
 aikrNVJalqXK8opAjHBsSsoPO/TgNcjQCY4LhpRHIlVY/ZrkT83Fv8vY23/x85GPzZUk
 oFdlEdCjyBU0hB/t3akoS//c6s+xNpdKwI8Sa2w0Gk5tIZTmlriTWqUo9RzmLNGf/7t5
 t6HIu/msC2R7vGq7EWQErnsZBRS8Zp3itJvRECjEfncZGf6wsKcKnA3qaw/HDefuycw1
 iyuS7lRZl4/1uquXQUlcilg2wLJ6nlz/ywyRpJSB4CynQ8QtoANIgLVcdcy8DSB39QrZ
 tGNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=cVbkdDuKyZ8y+K1SLT1x92HxA91Y6BCx8q4u5K2TpeU=;
 fh=Opyu6zz72KvkUOOBDEfhVcLqIpwIfdca/LhqIasCHqI=;
 b=AwDVnXw5KPyg6turzKqgF0TqGDXaV25UytYAcG8PmMs49Z/ZSphMzp8R+VGj62Vw/I
 Rziv5iPXPigFHTsnP5ZC42hzqpX84A2aHY7D82G5sjuDH+qDf7VX4QWJ5DRlMOpvl4G8
 vraApwuAh70/1m8su6I+NFK9aOdUc9HlXbUf6LHOl8qQMTym6iNol6gP08ss9Z48FiIY
 9AL28uB502PkI+Dzpjbcs4RupB/kI9N8fBW/hu5em/JcJ0TqwsgrezV/IpCDm6fCi3mN
 tUhBj7tqLnAEixL+dnrH3iCl6iSU8iwC2r1q8xV7K/64+Mo1p8Qs+hlUytaflZ8XeGJG
 7IZg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793877289; x=1794482089; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=cVbkdDuKyZ8y+K1SLT1x92HxA91Y6BCx8q4u5K2TpeU=;
 b=gpPlDCxZy4Tf7EUfU6QwGxza/mE8egnOShY/DOuzepyO4qgsZaW2Dk5Vbt3oIXWtIs
 3RnmCMd19bNvWn7bhG7mT1W5C3yGc0ItpM+hm35k/DQ5a7K5xW5IwhMNjdL6/Sb9Pdj9
 JF17LVsioGL6vLD2IRiuOe5DPWO/RF9gl/tnRvR8ZFm5JxFqe1cBVA8/5Zeq3GN72qt5
 9lqGUmaK1kmV/6LmtIxmUkmzjjf+iNbOfts8FjMtr/qSzHfkBLnYnZQbrY/eMVgsNBxp
 DECV3XLk2amVcH4rq0g2Pg7bZvpqlFldRoz3SyE6ceRQQfNJCOriq2cI32iu0GItIJMY
 1Fcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793877289; x=1794482089;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=cVbkdDuKyZ8y+K1SLT1x92HxA91Y6BCx8q4u5K2TpeU=;
 b=mEKMty77+cs2YGOuFogr2DSuUZQOxkgGj1uJvG/qEO64lmgc/ZsUw7Yyes6QvZUVjY
 SxEYXKTtTDnWp6W4nAB8KebR9d+vtN0K9+ut/kxe4wPwPaflpbWftt66YDiA8jRampCd
 lUlQ0ogKIhV8EFWb/GhFbt0wkWzWTPxUzU0JSPqkLVWblrTBy2X4BA9WLLzuyGVvxUTi
 F6f4ZFEfmgrowVKBFizvr2HKymejgQsus2JKKs31HVLkNgZw2r1IU2EM8K0VDgZbM+13
 i448o/3hxEkS9qcZ9G3xJWwPZE94WJRZ9sMuaJA/6ZTOFd3PgVjyCnxOTdGCWEdEWYbm
 I79A==
X-Gm-Message-State: APuU4Z/8REEMLUP4GEUb6asoBm/z5y3Qul+aYuMhTF4mogHU3ntauwbM
 lcFurCNnjm07ZeQJipr9cnnXGSXhwQb/x0dfPXAS5C2rpRPu8odJ6V/sarmy5uW8su3ljgTpXwI
 WdeLJVoVAXq2bLIvRy8ahhsHcrt8FgBc=
X-Gm-Gg: AYBFou1OZjEB7x56X6YvLDHCgX8HPpuesCqEjxkwlBnHb0Ga+hU+0eOoGGfKp4G/Di3
 QA48cc6dReiQAwl3fIh92HvYQA8jC7DdLVHtnzcU2cFVIsjN1rtTiC+3e7R+Z/eYXdjIlb8SQTL
 KTOb7bIAsXahoj188rks+JcpZTS5DclyqZwrLPcsNIw3ADCloZQK8s+mrwaejhUhffQFfGJ6T+i
 QylBCWRy1f93lbf0SV/6EEJoEoWPgo0HJi3H0HZ8ncJy8QKWgDQZgrg8UcUOk/b++ypnA0PVD2M
 c52ftRzxDE9ofwL0r+fMzno/ZQplM/eodIPOH0W2iK3vf+q4q6x5PNL5zLe6+3uGx0p9Nls+tYP
 r3xanBPrWoUimdjbqFqGRY6Ed8+RjP/I/uGwR
X-Received: by 2002:a05:6402:b21:b0:6b1:c285:f8d8 with SMTP id
 4fb4d7f45d1cf-6b5777252eemr1132165a12.11.1793877288489; Thu, 05 Nov 2026
 03:14:48 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261031164009.2048-1-luoyonggang@gmail.com>
 <20261031164009.2048-7-luoyonggang@gmail.com>
 <auxgsFyzv-5UiyNk@redhat.com>
In-Reply-To: <auxgsFyzv-5UiyNk@redhat.com>
From: Yonggang Luo <luoyonggang@gmail.com>
Date: Thu, 5 Nov 2026 19:14:35 +0800
X-Gm-Features: AclHuK8tJYW8q4QG64JvjzWiMabcPoIg_CKQ5B4EQj0WH1J30aCIg40XxtKDWWE
Message-ID: <CAE2XoE9J++-BHL5BDx4_jxuto+xwVmvFS3F-hE9gLbgfUmaFdA@mail.gmail.com>
Subject: Re: [PATCH v2 06/12] target/arm: register separate max-v8 CPU types
 for arm and aarch64
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Song Gao <17746591750@163.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 Philippe Mathieu-Daude <philmd@mailo.com>, 
 David Hildenbrand <david@kernel.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Fam Zheng <fam@euphon.net>, Max Filippov <jcmvbkbc@gmail.com>,
 qemu-s390x@nongnu.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 Eric Farman <farman@linux.ibm.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Cornelia Huck <cohuck@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=luoyonggang@gmail.com; helo=mail-ed1-x52c.google.com
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

On Thu, Nov 5, 2026 at 6:55=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@re=
dhat.com> wrote:
>
> On Sun, Nov 01, 2026 at 12:40:01AM +0800, Yonggang Luo wrote:
> > max-v8 was one TypeInfo whose instance initializer was chosen from the
> > selected target at registration. Register both initializers, and let
> > target_arm() and target_aarch64() select which type is available.
> >
> > Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> > Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> > ---
> >  target/arm/cpu.c            |  1 +
> >  target/arm/cpu.h            |  1 +
> >  target/arm/tcg/cpu-max-v8.c | 16 ++++++++++++----
> >  3 files changed, 14 insertions(+), 4 deletions(-)
> >
> > diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> > index 510fc9eeb3b..6eb55242980 100644
> > --- a/target/arm/cpu.c
> > +++ b/target/arm/cpu.c
> > @@ -2695,6 +2695,7 @@ void arm_cpu_register(const ARMCPUInfo *info)
> >          .instance_init =3D arm_cpu_instance_init,
> >          .class_init =3D info->class_init ?: cpu_register_class_init,
> >          .class_data =3D info,
> > +        .is_available =3D info->is_available,
> >      };
> >
> >      type_info.name =3D g_strdup_printf("%s-" TYPE_ARM_CPU, info->name)=
;
> > diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> > index add993ef101..3240a8633ee 100644
> > --- a/target/arm/cpu.h
> > +++ b/target/arm/cpu.h
> > @@ -1203,6 +1203,7 @@ typedef struct ARMCPUInfo {
> >      const char *deprecation_note;
> >      void (*initfn)(Object *obj);
> >      void (*class_init)(ObjectClass *oc, const void *data);
> > +    bool (*is_available)(void);
> >  } ARMCPUInfo;
> >
> >  /**
> > diff --git a/target/arm/tcg/cpu-max-v8.c b/target/arm/tcg/cpu-max-v8.c
> > index 65f851f2006..e819d07e6ce 100644
> > --- a/target/arm/tcg/cpu-max-v8.c
> > +++ b/target/arm/tcg/cpu-max-v8.c
> > @@ -121,10 +121,18 @@ void aarch32_max_v8_tcg_initfn(Object *obj)
> >
> >  static void cpu_max_v8_register_type(void)
> >  {
> > -    static const ARMCPUInfo max_v8[2] =3D {
> > -        { .name =3D "max-v8", .initfn =3D aarch32_max_v8_tcg_initfn },
> > -        { .name =3D "max-v8", .initfn =3D aarch64_max_v8_tcg_initfn },
> > +    static const ARMCPUInfo max_v8_aarch32 =3D {
> > +        .name =3D "max-v8",
> > +        .initfn =3D aarch32_max_v8_tcg_initfn,
> > +        .is_available =3D target_arm,
> >      };
> > -    arm_cpu_register(&max_v8[target_aarch64()]);
> > +    static const ARMCPUInfo max_v8_aarch64 =3D {
> > +        .name =3D "max-v8",
> > +        .initfn =3D aarch64_max_v8_tcg_initfn,
> > +        .is_available =3D target_aarch64,
> > +    };
> > +
> > +    arm_cpu_register(&max_v8_aarch32);
> > +    arm_cpu_register(&max_v8_aarch64);
> >  }
> >  type_init(cpu_max_v8_register_type)
>
> Conceptually these are two separate CPUs one 32-bit featureset
> and one 64-bit featureset, but both given the same name. The
> current code registers them only in the respective arm and aarch64
> target binaries, but this CPU is an oddity overall.

This is the one I did before
https://lore.kernel.org/qemu-devel/20261013195606.152-1-luoyonggang@gmail.c=
om/

target/arm: defer max-v8 initializer selection until CPU creation
but rejected, and I think it's fine.

>
> More generally the aarch64 emulator includes all the 32-bit CPUs
> that the arm emulator includes, and just adds extra 64-bit CPUs.
> IOW, excluding the 32-bit max-v8 CPU is a special case - if it
> were not for the clashing name, it would be included like all the
> other 32-bit CPUs.
>
> Thus rather than using is_available to continue to exclude it,
> we must instead resolve the naming problem, such that both
> models can be included concurrently.

I have already implemented the TypeBucket over targets/arch_mask that works
properly. That same QOM name will have multiple TypeImpl.

If you allow me, I'd like to post them all with TypeBucket implemented
so we have
a clean discussion basepoint.

>
> One approach to this is to consider  the generic 'max-v8' name
> to be an alias, that is resolved to the underlying real CPU
> name 'max-v8-64' vs 'max-v8-32'. Allow the aliases to be
> ambiguous, and either the selected target_info() disambiguates
> aliases, or apps can use the canonical name instead of the alias.
>
> With regards,
> Daniel
> --
> |: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
> |: https://libvirt.org          ~~          https://entangle-photo.org :|
> |: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|
>


--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

