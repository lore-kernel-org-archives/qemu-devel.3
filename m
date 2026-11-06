Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB8A9606A326
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2026 16:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YS3lw+4K
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPMnu-0004QM-7q; Fri, 06 Nov 2026 11:28:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xPMns-0004Q6-20
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 11:28:36 -0500
Received: from mail-yx1-xb134.google.com ([2607:f8b0:4864:20::b134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xPMnp-0005Ul-PE
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 11:28:35 -0500
Received: by mail-yx1-xb134.google.com with SMTP id
 956f58d0204a3-67bec5dc8d4so721133d50.0
 for <qemu-devel@nongnu.org>; Fri, 06 Nov 2026 08:28:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793982512; cv=none;
 d=google.com; s=arc-20260327;
 b=I0LDl7CpPClh4IXf1Bnp3aBj5SVVKeSdp+EVRVFh0ebZzR09PfbgiqVL1TCG7AGR1H
 hWq0zEKVboTBxJtAf4I9KjKBAIN1RQGt6gGhfwspE3nhj1Lre6glNuWLbK++LjrPYiHd
 rFlm0FEfyO0zCTxRIVkvptuLJeLGKizxLF+a4k0qfvjn1jrnXyoCyJKVpiI4CkyBf/jP
 BGwpoM07DzQh8Clqds3EI0RL6BO/K8cQ6MyB114J2odKXPV1Xnzj5kZcU+EyQXiYG714
 3ef451BkIdZx8uQ8AINbHO3rggcLMCbFiyvzHkH+07D0kB3RNv8bnRAfOn1ErD2cMgAW
 09bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=JqxvoINGeuYD973W9LxvnQmq5wSiiQ+StclRs82Y7LA=;
 fh=VauZ7bJuFOUFjqssKUzUzq+jxH4WBozopictS452t7Q=;
 b=NX4mXpZHOnv1abaC/Wz7hxDxiIKJuW0hdPckBbiwm1UnCGGe/xYyYzK4rWX16j/Y70
 PEAt8p+28yn7/uluOjBL03wpOpYRZ4dS5VF/400RsTVls0Bbw/2RFCCr0QfpToQqcrmO
 rqawOwq6UGJDWZixHyey3Vu+C1+g82FuLibhXkVonlj2SxNhctCL1KGD3wuTrebdw+iY
 n99rat3H31nabzyDB8iZMVuPNRGfrUgG2VRTqaugaB3kOl24zEFO80vEVrTanGP2RZ8x
 igzg+kG2jFgIXPPxOobmBhO/PHClzEOrv80caIb/1Z+rPy4g9W2sapm2HAC4aiZUtImc
 RWdA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793982512; x=1794587312; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=JqxvoINGeuYD973W9LxvnQmq5wSiiQ+StclRs82Y7LA=;
 b=YS3lw+4KgXj4LH68M9Kop3fp9UnulLmP5sY2pFcouwhs8UUic58QIG79Hhjm2vMo01
 TbpRZXZKyqB5FDUYzTqRhJn3ak3XP/e7b9FrAlwVLvwRoyetXbZc7bRtlBObDhFEwuFa
 x68zZJSt5pRwTrHo4GkKhkP+j3aXochzTL5kDggBL6IKV6LGgjw0XUBv/SmCWDdno9H0
 m0ARQ3R/3G2+E5YPvkM3griGugIkqPvO6NO9Sz2BJ6BM0VQ3i/rL1dD17raBT3MQqvnd
 62zS9551UYzYGbbbscc0i9diaEWEvYQFhlGGYdUMvjWDDgDomkTSR0jqi3yWAu8R79gY
 R/cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793982512; x=1794587312;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=JqxvoINGeuYD973W9LxvnQmq5wSiiQ+StclRs82Y7LA=;
 b=DmnwTOVsEP3EYfnVvynUaf2V/likL0s4fiWSKdAi3L+lVi9SPNvPpgYTaPOirq48XE
 cqUaoTXsvLUOm9mB6FkhOrxLDBPO041NvDofhiAxZSezVK9NaSNjiv9EdiRN0YSbjtO5
 vmHok9pldxcnkDeyRnRgPFDPSw568yMKQvYEPRjrbRUHwC2GItS9GpBkcZqHqL5cS5vg
 lKAaFKLfl9ltOvJ32oito0K5QirRcXbAIzTc0lYsF9kvR5U55nmjryj5PajZIpRUr43A
 iO5l6HAjloB01Fo6T2raxsaT4zMWCLPlVhDUy33mh9plYcDfQIa5y/jOxXAG/NT899X+
 dChA==
X-Forwarded-Encrypted: i=1;
 AL+hErELiQsRDmcA28FrY3yTFlYTk2eCUbeWc4Rs98gubarb2JBz9JT+LaLa1Tyrxjt9//exWYAzCqw67di2@nongnu.org
X-Gm-Message-State: APuU4Z+2H7WTqYf1/rEM3YPXvbK8g3XT3vAsu+O6SMs29q+V00v70AdT
 xW5O1d/cyqAz6FKZSqEZ9H1Wn6VC0qxr2dc1do3gglGTl8DeRh6E7vu3EE18UZGFkb/E3mMTqPQ
 mbgvMeWtqbJpZFSHnLKgDjwfaap3VmfA=
X-Gm-Gg: AYBFou0WzbV9mezlShuP7gYqvliKuM2bisszNyO2a0pktL42N/mDPjSG0+tFFBlSpeM
 QWOWNmshkJL/sGs8gZ4Hs5B84WZWXFWheUWQUyJmrzrmLlh59pwFZ2fW6AtymJFjydio6K6i/+b
 zMqokZqb8v5hyDigNpWfMDNeQWkixnxUr1Ry+LR5SRhyxIiTsoZ3aaXFo1/mQivr+205pLzmo++
 DXW8DG57SByZFEJUp6BCF8DGRPTVFkFr50rbM4NW7qoLulr6F0uy2zV01dpRL4vuVdcRLyb8dRt
 3zfiNOQXSg8nZEUNiylHPUa4iSaE+ZGKIIRMW30smVz1pA63PjG2nT9WUVnBfjWXmIOzWQSsSq+
 lyNioCQsFeSEtoXJaE0nGZHUuXXF/SdtYHy0g
X-Received: by 2002:a05:690e:bc6:b0:67c:257a:cba4 with SMTP id
 956f58d0204a3-67c257ad0e2mr308154d50.20.1793982512329; Fri, 06 Nov 2026
 08:28:32 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261105102432.1131493-1-berrange@redhat.com>
 <e0afc971-a070-4853-b690-b6c523c5b65a@oss.qualcomm.com>
 <au3zw-IBajJYhiWN@redhat.com>
In-Reply-To: <au3zw-IBajJYhiWN@redhat.com>
From: Yonggang Luo <luoyonggang@gmail.com>
Date: Sat, 7 Nov 2026 00:28:17 +0800
X-Gm-Features: AclHuK--UOkpk4mZd5BNqY7wACzSuauMBHDCumWiy2CBFci8mdGFcG4YSAQL7KA
Message-ID: <CAE2XoE_R_n3k944sWbQ1EG+zsth2C=O89_SCLqijvLtQ4L2EyA@mail.gmail.com>
Subject: Re: [PATCH 0/4] hw: support machine filtering without is_available
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b134;
 envelope-from=luoyonggang@gmail.com; helo=mail-yx1-xb134.google.com
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
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Nov 6, 2026 at 11:35=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com> wrote:
>
> On Thu, Nov 05, 2026 at 09:25:28AM -0800, Pierrick Bouvier wrote:
> > On 11/5/2026 2:24 AM, Daniel P. Berrang=C3=A9 wrote:
> > > The 'is_available' callback on TypeInfo is based on a mistaken
> > > notion that we should filter out classes at registration time
> > > based on architecture.
> > >
> > > This creates new problems however, some already present and
> > > some which will impact a future multi-target binary
> > >
> > >  * For introspection of the binaries' features, we have
> > >    a dependancy on selecting a target before we can
> > >    introspect features. It would require re-launching
> > >    QEMU for each target, leading to lots of redundant
> > >    introspection and a big time sink. It would also not
> > >    be possible to introspect targets
> > >
> > >  * It creates a circular dependancy on QOM initialization
> > >    inside the QOM initialization code, since 'target_info()'
> > >    itself uses QOM. This then requires further work to break
> > >    by initializing QOM target info before the rest of QOM.
> > >
> > >  * We have no means to introspect what targets a machine
> > >    type can be used with, as this information is expressed
> > >    as code (in target_XXXX() methods), instead of as data.
> > >
> > >  * New fields in TypeInfo requires more changes to macros
> > >    used for initializing machines.
> > >
> > > There is no inherant conceptual reason why we must filter out
> > > classes at type registration time. This is just a shortcut to
> > > workaround historical technical debt where certain classes
> > > have clashing names. This is an undesirable approach, as it
> > > is trading one set of problems for a new set of problems.
> > >
> > > This series proposes removal of the 'is_available' concept
> > > from QOM, and illustrates handling machines with full introspection
> > > support available from the MachineClass.
> > >
> > > This implies fixing the root cause, of clashing class names,
> > > but does not include patches since various series have already
> > > been posted for machine class name fixes.
> > >
> > > The machine changes are fairly simple
> > >
> > >  * MachineClass gains a 'targets' field which is a bit mask
> > >    of SysEmuTarget
> > >  * machine_class_is_available() matches 'targets' against
> > >    'target_info()'
> > >  * -machine CLI enforces machine_class_is_available()
> > >  * query-machines filters on machine_class_is_available
> > >    by default
> > >  * query-machines gains 'all-targets': 'bool' to opt-in
> > >    to returning the unfiltered list, with a 'targets'
> > >    list present
> > >
> > > NB, this removes filtering from riscv CPUs with no
> > > alternative proposed. I'm unclear what this was trying
> > > to address to begin with, but utlimately it should be
> > > possible to address it with runtime filtering/matching
> > > of classes, instead of hiding TypeInfo registration.
> > > If someone gives me info on the CPUs problem I can a
> > > make a design suggestion.
> > >
> > > Daniel P. Berrang=C3=A9 (4):
> > >   hw/core: record permitted targets against MachineClass
> > >   hw: replace 'is_available' with 'targets' in machines
> > >   target/riscv: remove 'is_available' from riscv CPUs
> > >   qom: drop the 'is_available' callback from TypeInfo
> > >
> > >  hw/arm/aspeed_ast27x0-fc.c  |  3 ++-
> > >  hw/arm/aspeed_ast27x0_evb.c |  5 +++--
> > >  hw/arm/raspi.c              | 21 +++++++++++++--------
> > >  hw/arm/raspi4b.c            |  3 ++-
> > >  hw/arm/virt.c               |  5 +++--
> > >  hw/core/machine-qmp-cmds.c  | 18 ++++++++++++++++++
> > >  hw/core/machine.c           | 13 +++++++++++++
> > >  hw/hexagon/virt.c           |  3 ++-
> > >  hw/m68k/virt.c              |  4 ++--
> > >  hw/or1k/virt.c              |  3 ++-
> > >  hw/riscv/virt.c             |  4 +++-
> > >  include/hw/core/boards.h    |  3 +++
> > >  include/qom/object.h        |  3 ---
> > >  qapi/machine.json           | 12 +++++++++++-
> > >  qom/object.c                |  4 ----
> > >  rust/qom/src/qom.rs         |  1 -
> > >  system/vl.c                 |  9 +++++++++
> > >  target/riscv/kvm/kvm-cpu.c  |  1 -
> > >  target/riscv/tcg/tcg-cpu.c  |  1 -
> > >  19 files changed, 86 insertions(+), 30 deletions(-)
> > >
> >
> > Thanks for posting the series.
> >
> > Would that be possible to complete it so that beyond compilation, test
> > ./build/tests/unit/test-multi-target passes also? At the moment it fail=
s
> > with duplicated types being registered.
>
> Oh I see, it didn't failure because I only enabled
> the two arm/aarch64 targets, once i add in more
> targets we get a clash on the virt-machine class.
>
> FYI, it also fails without my patch series present
> in some scenarios:
>
> # child process (/multi-targets/qom-types-are-unique/aarch64 [1950288]) s=
tderr: "Registering `vm-launch-update' which already exists\n"
> **
> ERROR:../tests/unit/test-multi-target.c:41:test_qom_types_are_unique: chi=
ld process (/multi-targets/qom-types-are-unique/aarch64 [1950288]) failed u=
nexpectedly
> not ok /multi-targets/qom-types-are-unique/aarch64 - ERROR:../tests/unit/=
test-multi-target.c:41:test_qom_types_are_unique: child process (/multi-tar=
gets/qom-types-are-unique/aarch64 [1950288]) failed unexpectedly
> Bail out!
> Aborted                    (core dumped) tests/unit/test-multi-target
>
> This is caused by presence of 'igvm-devel' at build time on
> one of my machines (Fedora), which enables this device type,
> if you have both arm and aarch64 targets enabled.
>
> We need to add igvm to our Fedora dockerfile to catch this
> in CI.
>
> Moving it from specific_ss to system_ss make the test pass,
> but I'm unclear if it is sufficient to rely on lack of
> compiler and test complaints ? Or it needs manual code
> inspection to make sure the device is safe in this
> scenario ?
>
> > That's why this is_available was introduced in the first place. It was
> > just a way to move forward and provide the multi-target test to prevent
> > regression while work on single-binary is continued by Yonggang.
>
> Right, so with my series, we would first need the class
> renames to fix the multi-target test.
>
> I should have labelled this posting "POC" as it was not
> tested thoroughly.

It's good to have these, make the progress more clear, and we have
more agreements.

I think a possible direction is comes with
qom: filter type lookup with TypeBucket
https://lore.kernel.org/qemu-devel/20261105190346.1539-1-luoyonggang@gmail.=
com/T/#mc0a763e16d33b7b7c79d87fb07936ae4f04d68a0

So we can get conflict machine names such as "virt-machine" to be
registered with this TypeBucket.

Then we can limit the subclasses of TYPE_MACHINE to use this means(TypeBuck=
et).
That is we can add unit-test in tests/unit/test-multi-target.c
to ensure after object_class_get_list(NULL, true); only TYPE_MACHINE's
subclass's "targets" can differ from QEMU_ARCH_ALL.

Or one more abstract class TYPE_CPU(only when absolutely necessary).
For example deal with:
target/arm: register separate max-v8 CPU types for arm and aarch64
https://lore.kernel.org/qemu-devel/auyP09mbwuefulBL@redhat.com/

>
> With regards,
> Daniel
> --
> |: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
> |: https://libvirt.org          ~~          https://entangle-photo.org :|
> |: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|
>

--
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

