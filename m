Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EFA2C4345F
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Apr 2024 08:42:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rySkx-0006v4-7c; Sun, 21 Apr 2024 04:41:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1rySku-0006ui-1g
 for qemu-devel@nongnu.org; Sun, 21 Apr 2024 04:41:00 -0400
Received: from mail-lj1-x22d.google.com ([2a00:1450:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1rySks-0005ZM-50
 for qemu-devel@nongnu.org; Sun, 21 Apr 2024 04:40:59 -0400
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2dd6a7ae2dcso2864781fa.1
 for <qemu-devel@nongnu.org>; Sun, 21 Apr 2024 01:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713688855; x=1714293655; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EYw+oymiOaoOYHHgiSaU0Ta6laFDOAwqfTQrddQlKT4=;
 b=Lz9DIYXjAw0+spwv42t6l6Z4v6gn9gx5olWDlK/Zn0JkrIwnayhRj7aCKX33zWwBzY
 TQmrX6A8MpgJiTyl65DE4XGt2J2qFvZgDiSkYDKkDnhdcdOclo7p/NaaPoZllFKuThKv
 ZoMuvxTgZGjtIqqciUauT+TPLDYPbgAIe6qrjcbVBuwYYMJ44UsgdPwA6SNT+tRImh2H
 Dc/gkGbanHYh5Z2KOpWlMgMPn23XG2bqEq/1h1kcMYEOcsrnSvXBJU35UWjx5L6Jf7SC
 Uj1oSNIPkrXFGMcMVpNLHDfL5O6mehCyRBiqkbDvPb7rsxhcCYWMdqPzc7MYYFUK9xdg
 9Y5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713688855; x=1714293655;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EYw+oymiOaoOYHHgiSaU0Ta6laFDOAwqfTQrddQlKT4=;
 b=PfMRqFHSbGcjJSrFgzxjiA8kjphYPiFt8+qostIDL3mitCDxKBlhEP/IlC2V7eQ5gD
 Kk6KZ/ItTnuz9yQ3H7cWpebVDxB/I71lj+xXC1y46GAp205UR88/ZlAED0w6BAMrCi/b
 I+bn0mp2Uj1b/n8BEJHzmNMZtRcUTXFc664ToX0SKq/+d/BFXcvaGKZZGFOY4Llw+MDz
 szQE+z6NhOHrKZ+VbaP7vWey69/5fTS5s9AtH8IKmiIWCqj2hzOMJGFllWubhcS0U9Fr
 8Z+Q0SuYCXRu0oMn4mMPAO9eU6zBHQU5xlMYPuNEJbKqbcxW5Sx70tlRuMurL8AtxPfi
 5Dhg==
X-Gm-Message-State: AOJu0Ywpr1xIQOcHCO0q+JQyCj9KP725+KI94OT1io6PqvhoQg2iGSBa
 gbusE1dEYfq4Nd1+O4RDFBj1YaKQYURFEN6joaV51n0UtUspNt5vcC12Xy78pzUmW4tAjB2YwTz
 Hyi5tic+vDX+IIxoYyOvno1HueJc=
X-Google-Smtp-Source: AGHT+IGR9ZQq3eVBnsdzgC8K+QUTGH9xoW0jCR82J4l+z7eeo1ZF7swFwrND7r1ZN4As/BgCOpW7LQ//EFeAQuxLzpA=
X-Received: by 2002:a05:651c:1414:b0:2da:16fd:5c9b with SMTP id
 u20-20020a05651c141400b002da16fd5c9bmr4978757lje.9.1713688854943; Sun, 21 Apr
 2024 01:40:54 -0700 (PDT)
MIME-Version: 1.0
References: <20240419183135.12276-1-dorjoychy111@gmail.com>
 <f397f267-06d9-46c1-8acc-1c9ebf9c3773@linaro.org>
In-Reply-To: <f397f267-06d9-46c1-8acc-1c9ebf9c3773@linaro.org>
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Date: Sun, 21 Apr 2024 14:40:43 +0600
Message-ID: <CAFfO_h7vUEhqV15epf+_zVrbDhc3JrejkkOVsHzHgCXNk+nDdg@mail.gmail.com>
Subject: Re: [PATCH] target/arm: fix MPIDR value for ARM CPUs with SMT
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::22d;
 envelope-from=dorjoychy111@gmail.com; helo=mail-lj1-x22d.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Sun, Apr 21, 2024 at 11:40=E2=80=AFAM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 4/19/24 11:31, Dorjoy Chowdhury wrote:
> > +
> > +    /*
> > +     * Instantiate a temporary CPU object to build mp_affinity
> > +     * of the possible CPUs.
> > +     */
> > +    cpuobj =3D object_new(ms->cpu_type);
> > +    armcpu =3D ARM_CPU(cpuobj);
> > +
> >       for (n =3D 0; n < ms->possible_cpus->len; n++) {
> >           ms->possible_cpus->cpus[n].type =3D ms->cpu_type;
> >           ms->possible_cpus->cpus[n].arch_id =3D
> > -            sbsa_ref_cpu_mp_affinity(sms, n);
> > +            sbsa_ref_cpu_mp_affinity(armcpu, n);
> >           ms->possible_cpus->cpus[n].props.has_thread_id =3D true;
> >           ms->possible_cpus->cpus[n].props.thread_id =3D n;
> >       }
> > +
> > +    object_unref(cpuobj);
>
> Why is this instantiation necessary?
>

The instantiation is necessary (like the one in hw/arm/virt.c in
virt_possible_cpu_arch_ids) because the
"sbsa_ref_possible_cpu_arch_ids" function is called (via
possible_cpu_arch_ids) before the CPUs are created in the
"sbsa_ref_init" function. There was some related discussion here
(qemu-devel archive URL):
https://mail.gnu.org/archive/html/qemu-devel/2024-04/msg02074.html . I
picked this up from the same thing done in hw/arm/virt.c in the
"machvirt_init" function in the "if (!vms->memap) {" block.

> > --- a/target/arm/cpu.c
> > +++ b/target/arm/cpu.c
> > @@ -1314,8 +1314,18 @@ static void arm_cpu_dump_state(CPUState *cs, FIL=
E *f, int flags)
> >       }
> >   }
> >
> > -uint64_t arm_build_mp_affinity(int idx, uint8_t clustersz)
> > +uint64_t arm_build_mp_affinity(ARMCPU *cpu, int idx, uint8_t clustersz=
)
> >   {
> > +    if (cpu->has_smt) {
> > +        /*
> > +         * Right now, the ARM CPUs with SMT supported by QEMU only hav=
e
> > +         * one thread per core. So Aff0 is always 0.
> > +         */
>
> Well, this isn't true.
>
>      -smp [[cpus=3D]n][,maxcpus=3Dmaxcpus][,drawers=3Ddrawers][,books=3Db=
ooks][,sockets=3Dsockets]
>                     [,dies=3Ddies][,clusters=3Dclusters][,cores=3Dcores][=
,threads=3Dthreads]
>
> I would expect all of Aff[0-3] to be settable with the proper topology pa=
rameters.
>

Sorry, maybe I misunderstood. From the gitlab bug ticket (URL:
https://gitlab.com/qemu-project/qemu/-/issues/1608) and the discussion
in qemu-devel (URL:
https://mail.gnu.org/archive/html/qemu-devel/2024-04/msg01964.html) I
looked at the technical reference manuals of the MPIDR register of the
a-55, a-76, a-710, neoverse-v1, neoverse-n1, neoverse-n2 CPUs and all
of them had MT=3D1 and one thread per core so Aff0 is always 0.

I don't know what Aff3 should be set to. I see this comment in the
target/arm/cpu.c "arm_cpu_realizefn" function
   /* This cpu-id-to-MPIDR affinity is used only for TCG; KVM will
override it.=E2=94=82
     * We don't support setting cluster ID ([16..23]) (known as Aff2
         =E2=94=82
     * in later ARM ARM versions), or any of the higher affinity level
fields,  =E2=94=82
     * so these bits always RAZ.
         =E2=94=82
     */
Right now we don't seem to set Aff3[39:32] at all in the mp_affinity
property. Let me know what should be the expected behavior here as I
don't have enough knowledge here. I will try to fix it. Thanks!

Regards,
Dorjoy

