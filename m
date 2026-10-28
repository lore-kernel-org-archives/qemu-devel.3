Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB6AE606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 20:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=theorem-dev.20260707.gappssmtp.com header.i=@theorem-dev.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=Y2aB8mNJ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM9uX-00030j-EP; Wed, 28 Oct 2026 16:06:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tewaro@theorem.dev>)
 id 1xM9uH-000300-3V
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 16:05:58 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tewaro@theorem.dev>)
 id 1xM9uD-0001Cg-PV
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 16:05:55 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-6b3dd83e779so2741953a12.1
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 13:05:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793217952; cv=none;
 d=google.com; s=arc-20260327;
 b=gFqzQgq1d72GF8bckzIivXLedwvzR6dDWshd6zGWyH4rLd/V4z3jHLx1T1kiPx/G3k
 42H4Yaj+/0f7cFFToFxBaIb29ZagZ4uZblP3+n1QkbsHCr/HLPdFWl5pqE2oAhH1JCzT
 +Jip2xXsEvHuRQU2Zgn+c7EbT0coxr6sZgCf/+glZ88Y26LPsCguVUiA6/zhQTWRhoAB
 99GEFYGNrTbwhMIco87a003E1OLqJPqNNuF1tUixmDgCmoVHlTBWe6kAMmyyBzKS9fF8
 g1QBHnGwzWc2C+2ZiN7T7jZPxSgBxtzVufLGqW7YLuEycPjxLuZpdwHZeEa/gupGqby4
 J6BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=XY4ZWQhg/N0GvvBFsbOzrHsQFWaTfAkGUplEPCBIcKw=;
 fh=0r7M59Q6BKUeNDZeyXl77G9/VwAIfE101JSqXLfikfw=;
 b=QF9PYfztqTUoUfaw3sWqwX4hO/t2TzJm1vZMAgRPLLqIrjZs+6/tLM4vaX5Rwb/YMs
 4Sb2IOP7RfSd/WhMhmmZfJ/lcLNykAMc+5TPlJAHO2pJ/O2R39gCXW52MuOwA2iQ8ej4
 2I3T0yJBf6hcqJdaS4X27vOak/BQ2iiqr94w+iAXWfKPgVxd3KtN+gpX/VYdqy2rTydo
 YAVlCpucAUB2rKe5qbDXCBUTcHNhU4HEsaCheX8AYDGwP29OcSzL7Rq8foJ03Gx3FjmH
 ximn98QawmWTbnFTdaLB64C1wQ0A1Vfappgmvt5WG6qww5mpvr42gpYAbtEqEPff7rVa
 sERA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=theorem-dev.20260707.gappssmtp.com; s=20260707; t=1793217952; x=1793822752;
 darn=nongnu.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=XY4ZWQhg/N0GvvBFsbOzrHsQFWaTfAkGUplEPCBIcKw=;
 b=Y2aB8mNJyjFLbLATplormIOswHF+9Eyq/lslbaew1TJ+p0nCTIZDoqQcwg434dUhvN
 3O5iwTtgrKVVZ7ey+A48BWYeXJKRlRwmmjoiUnLQ076ss0ro+cwOM1g2ykxoqwbXiu9m
 g5KHuu58DjDslLknjc1OKEn7825T+x2URpOx7OXUS2WZH8gLFwtIvADJmyn778VOJWgm
 TCpnrSOwwXXe32DAzmdWmXbMBCslmXd1nc7/lCkUrw3J3sEw78aG5G1ioZ6tqg93CoNa
 ylbsBEVmpjCSE6x/4G/Y9/1O/Z16b9Q/evqGW9C4bbmLhIbCLpbi8JR7UAftfsnP3lau
 /Ckw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793217952; x=1793822752;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=XY4ZWQhg/N0GvvBFsbOzrHsQFWaTfAkGUplEPCBIcKw=;
 b=CP5u7lCeCpsOADnKxDMftunZ7horKP8AKJRzPkAQpFGaVJSYAjyixFUEbGd8wl0LjT
 Hk3Ifb9vkmgfEpbVa6LzrJ/KX/cg7UzThlmqncEy3jj5LMBpBGelEQIeaW4QODFU0gB8
 9HnYCnHPmRr8FH7wKs7zPDZPaASMQMM/VeAMtv/8tEAJ/gL5x3C9h8hb5b+Zy7zrTZMq
 XpvOtK32IKtbQO54Za7MZHO0z2UAda2F6wqYT1FiGyQHvWqJHv59dTDh3x+lea0rd2Ek
 uVSCVHho8ZMMfXPZYc6XajiPYDHanCfvQPUVbtzPb6wFF0LXYhdQWGJCVFK4QXsvtrDs
 v/vA==
X-Gm-Message-State: AFq9FYIhnhi77TcdcfdW6JgjwxEG/lFk9g60DdIQTIHDodMgZclui3zd
 4DNXxVYeNylHubVHilSX4mgjCzI+P/DIWHpbtWkyzu9O+LaMxopX2m+jJww8KgxPfKI5AcNoEO2
 G9zww3IxKZ5mzXtIAooAatO51ngdkXeu2c/Py9tEt0w==
X-Gm-Gg: AYBFou18fz5T3fJAIFAA4ZQSyUllRnXsFnEmbdscuo3ACgrJzgO6Ly7qfTvnxDgI82r
 XsgFdygTZeNvwYdj6H1MXmauCYLthKvLynPUHuAi4tqiybj0YCS8uwe95roCL2YMem3a8aKM+wk
 JX5NO5EtgBKYRrzUW89dLjq0CJl25IFx34YRSBn1CR1tPC713Es9ETUX8meBVfAqYFacXmVeYlY
 +/xWyV3kKkmgj8cuNWx83ee9RPjAy4zTDmh+L+amIik/Y2UHz1PzYEK6d1g8i884NAd/i02EwJi
 rla/jz8ja5X7gAyaXicGFMw15heeiKXPnSnKXcdvBObaWAERxV5+TO31FglcCoKyXbK1i8ngChr
 ESkuBbxkjogWiUpypa368CdpI0lzSW7CF9t+IPQ9X
X-Received: by 2002:a17:906:d54d:b0:c41:5a0e:3356 with SMTP id
 a640c23a62f3a-c49bdfa7acbmr284216866b.41.1793217951993; Wed, 28 Oct 2026
 13:05:51 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261022045737.67060-1-tewaro@theorem.dev>
 <CAEq2Q90Lvd4PMtxhj=2B-v5BiOdgBsgo2q5sFV-B4UcRFdEHkA@mail.gmail.com>
 <3cf09147-a718-45cc-a585-125c58952587@oss.qualcomm.com>
In-Reply-To: <3cf09147-a718-45cc-a585-125c58952587@oss.qualcomm.com>
From: Aditya Tewari <tewaro@theorem.dev>
Date: Wed, 28 Oct 2026 13:05:40 -0700
X-Gm-Features: AclHuK93hXxFn1nhTVdAWMQ7tCOwXtU4_9a2ztvfs0hwopLjHYxRs3teDMQhRZM
Message-ID: <CAEq2Q93qnqqThmZ6CiHo=5jLy=Y1tQ6iv_bU8uK+EGBvHLrYxw@mail.gmail.com>
Subject: Re: [PATCH 1/2] target/riscv: do not raise the no-PMP-rule access
 fault from mret
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, disclosures@theorem.dev, 
 tewaro <tewaro@tewaro.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li <liwei1518@gmail.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>
Content-Type: multipart/alternative; boundary="00000000000008a75b065eec17d8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=tewaro@theorem.dev; helo=mail-ed1-x52a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--00000000000008a75b065eec17d8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Daniel,

Sorry about that; I had some issues on my end using email APIs.

I've resent them here:
https://lore.kernel.org/qemu-devel/fbeadd5b2fe5ccfd20b52dbccd4e5856f215ede0=
.1793217528.git.tewaro@theorem.dev/T/#t

Thanks,

tewaro

On Wed, Oct 28, 2026 at 6:31=E2=80=AFAM Daniel Henrique Barboza <
daniel.barboza@oss.qualcomm.com> wrote:

> Hi,
>
> I couldn't apply this patch.  git claims that the file is corrupted:
>
> $ git am --reject \[PATCH\ *
> Applying: target/riscv: do not raise the no-PMP-rule access fault from mr=
et
> error: corrupt patch at line 18
> Patch failed at 0001 target/riscv: do not raise the no-PMP-rule access
> fault from mret
>
>
> If I try to apply patch 2 standalone I get a different error:
>
>
> $ git am \[PATCH\ 2_2\]\ tests_tcg_riscv64_\ add\ test\ for\ mret\ to\
> S-mode\ with\ no\ PMP\ entry\ -\ tewaro\ \(tewaro@theorem.dev\)\ -\
> 2026-10-22\ 0157.eml
> Applying: tests/tcg/riscv64: add test for mret to S-mode with no PMP entr=
y
> error: git diff header lacks filename information when removing 1 leading
> pathname component (line 8)
> Patch failed at 0001 tests/tcg/riscv64: add test for mret to S-mode with
> no PMP entry
> hint: Use 'git am --show-current-patch=3Ddiff' to see the failed patch
>
>
> Can you please re-send both?  Thanks,
>
> Daniel
>
>
> On 10/22/2026 1:57 AM, tewaro wrote:
> > Consider a CPU that implements PMP but has no PMP entry configured.
> > If M-mode executes mret with MPP set to S or U, QEMU raises an
> > instruction access fault on the mret. The trap is taken in M-mode,
> > with mepc pointing at the mret, mtval zero and MPP equal to M.
> >
> > The spec says the mret succeeds and the first S/U-mode fetch fails
> > [1][2]. The trap should therefore be taken from S/U-mode, with mepc
> > and mtval equal to the mret target [3][4] and MPP equal to S/U [5].
> >
> > The early check in check_ret_from_m_mode() is what moves the fault
> > onto the mret. Without it, the fetch at the target misses the TB and
> > TLB caches, which are keyed by privilege level, and reaches
> > pmp_hart_has_privs_default() through riscv_cpu_tlb_fill(). That
> > function already denies S/U-mode when no rule matches. Nothing
> > executes between the privilege switch and that fetch, so no other
> > behaviour changes.
> >
> > As it stands, S/U-mode can never be entered on such a configuration,
> > and a handler that steps mepc past the apparent fault resumes in
> > M-mode at the S-mode entry point (GitLab issue #2074).
> >
> > The check was added by commit d102f19a208 alongside the pmp.c change
> > that makes the no-rule path M-mode-only, and I believe it was already
> > redundant then. Building v6.0.0 and v7.2.0 with only the check removed
> > confirms the fetch faults as expected. Later commits (0fbb5d2d3c9,
> > 4c48aad1, 3157a553, 16aa7771) changed its gating, cause and location
> > but not the normal path. Remove it and the now unused prev_priv
> > parameter.
> >
> > The bug was found and debugged with the help of Claude (Anthropic),
> > used as a research and debugging aid; the patch was written by hand.
> >
> > [1] Privileged ISA v1.12, 3.7.1 "Physical Memory Protection CSRs",
> >      Priority and Matching Logic
> > [2] Privileged ISA v1.12, 3.3.2 "Trap-Return Instructions"
> > [3] Privileged ISA v1.12, 3.1.14 "Machine Exception Program Counter"
> > [4] Privileged ISA v1.12, 3.1.16 "Machine Trap Value Register"
> > [5] Privileged ISA v1.12, 3.1.6.1 "Privilege and Global
> >      Interrupt-Enable Stack in mstatus register"
> >
> > Privileged ISA v1.12 (ratified, 2021-12-03):
> > https://github.com/riscv/riscv-isa-manual/releases/tag/Priv-v1.12
> > Current source, same wording:
> >
> https://github.com/riscv/riscv-isa-manual/blob/4877e41a/src/priv/machine.=
adoc
> >
> > Fixes: d102f19a2085 ("target/riscv/pmp: Raise exception if no PMP
> > entry is configured")
> > Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2074
> > Signed-off-by: tewaro <tewaro@theorem.dev>
> > ---
> >   target/riscv/tcg/op_helper.c | 10 ++--------
> >   1 file changed, 2 insertions(+), 8 deletions(-)
> >
> > diff --git a/target/riscv/tcg/op_helper.c b/target/riscv/tcg/op_helper.=
c
> > index b67c7718db..a355d28f4b 100644
> > --- a/target/riscv/tcg/op_helper.c
> > +++ b/target/riscv/tcg/op_helper.c
> > @@ -423,7 +423,6 @@ target_ulong helper_sret(CPURISCVState *env)
> >   }
> >
> >   static void check_ret_from_m_mode(CPURISCVState *env, target_ulong
> retpc,
> > -                                  privilege_mode_t prev_priv,
> >                                     uintptr_t ra)
> >   {
> >       if (!(env->priv >=3D PRV_M)) {
> > @@ -435,11 +434,6 @@ static void check_ret_from_m_mode(CPURISCVState
> > *env, target_ulong retpc,
> >                                       env->misa_ext) && (retpc & 0x3)) =
{
> >           riscv_raise_exception(env, RISCV_EXCP_INST_ADDR_MIS, ra);
> >       }
> > -
> > -    if (riscv_cpu_cfg(env)->pmp &&
> > -        !pmp_get_num_rules(env) && (prev_priv !=3D PRV_M)) {
> > -        riscv_raise_exception(env, RISCV_EXCP_INST_ACCESS_FAULT, ra);
> > -    }
> >   }
> >   static target_ulong ssdbltrp_mxret(CPURISCVState *env, target_ulong
> mstatus,
> >                                      privilege_mode_t prev_priv,
> > @@ -465,7 +459,7 @@ target_ulong helper_mret(CPURISCVState *env)
> >       privilege_mode_t prev_priv =3D get_field(mstatus, MSTATUS_MPP);
> >       uintptr_t ra =3D GETPC();
> >
> > -    check_ret_from_m_mode(env, retpc, prev_priv, ra);
> > +    check_ret_from_m_mode(env, retpc, ra);
> >
> >       bool prev_virt =3D !!(get_field(env->mstatus, MSTATUS_MPV) &&
> >                        (prev_priv !=3D PRV_M));
> > @@ -515,7 +509,7 @@ target_ulong helper_mnret(CPURISCVState *env)
> >       bool prev_virt;
> >       uintptr_t ra =3D GETPC();
> >
> > -    check_ret_from_m_mode(env, retpc, prev_priv, ra);
> > +    check_ret_from_m_mode(env, retpc, ra);
> >
> >       prev_virt =3D !!(get_field(env->mnstatus, MNSTATUS_MNPV) &&
> >                   (prev_priv !=3D PRV_M));
>
>

--00000000000008a75b065eec17d8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Daniel,<div><br></div><div>Sorry about that; I had some is=
sues on my end using email APIs.</div><div><br></div><div>I&#39;ve resent t=
hem here:=C2=A0<a href=3D"https://lore.kernel.org/qemu-devel/fbeadd5b2fe5cc=
fd20b52dbccd4e5856f215ede0.1793217528.git.tewaro@theorem.dev/T/#t">https://=
lore.kernel.org/qemu-devel/fbeadd5b2fe5ccfd20b52dbccd4e5856f215ede0.1793217=
528.git.tewaro@theorem.dev/T/#t</a></div><div><br></div><div>Thanks,</div><=
div><br></div><div>tewaro</div></div><br><div class=3D"gmail_quote gmail_qu=
ote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Oct 28, 2026 a=
t 6:31=E2=80=AFAM Daniel Henrique Barboza &lt;<a href=3D"mailto:daniel.barb=
oza@oss.qualcomm.com">daniel.barboza@oss.qualcomm.com</a>&gt; wrote:<br></d=
iv><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bord=
er-left:1px solid rgb(204,204,204);padding-left:1ex">Hi,<br>
<br>
I couldn&#39;t apply this patch.=C2=A0 git claims that the file is corrupte=
d:<br>
<br>
$ git am --reject \[PATCH\ *<br>
Applying: target/riscv: do not raise the no-PMP-rule access fault from mret=
<br>
error: corrupt patch at line 18<br>
Patch failed at 0001 target/riscv: do not raise the no-PMP-rule access faul=
t from mret<br>
<br>
<br>
If I try to apply patch 2 standalone I get a different error:<br>
<br>
<br>
$ git am \[PATCH\ 2_2\]\ tests_tcg_riscv64_\ add\ test\ for\ mret\ to\ S-mo=
de\ with\ no\ PMP\ entry\ -\ tewaro\ \(<a href=3D"mailto:tewaro@theorem.dev=
" target=3D"_blank">tewaro@theorem.dev</a>\)\ -\ 2026-10-22\ 0157.eml<br>
Applying: tests/tcg/riscv64: add test for mret to S-mode with no PMP entry<=
br>
error: git diff header lacks filename information when removing 1 leading p=
athname component (line 8)<br>
Patch failed at 0001 tests/tcg/riscv64: add test for mret to S-mode with no=
 PMP entry<br>
hint: Use &#39;git am --show-current-patch=3Ddiff&#39; to see the failed pa=
tch<br>
<br>
<br>
Can you please re-send both?=C2=A0 Thanks,<br>
<br>
Daniel<br>
<br>
<br>
On 10/22/2026 1:57 AM, tewaro wrote:<br>
&gt; Consider a CPU that implements PMP but has no PMP entry configured.<br=
>
&gt; If M-mode executes mret with MPP set to S or U, QEMU raises an<br>
&gt; instruction access fault on the mret. The trap is taken in M-mode,<br>
&gt; with mepc pointing at the mret, mtval zero and MPP equal to M.<br>
&gt; <br>
&gt; The spec says the mret succeeds and the first S/U-mode fetch fails<br>
&gt; [1][2]. The trap should therefore be taken from S/U-mode, with mepc<br=
>
&gt; and mtval equal to the mret target [3][4] and MPP equal to S/U [5].<br=
>
&gt; <br>
&gt; The early check in check_ret_from_m_mode() is what moves the fault<br>
&gt; onto the mret. Without it, the fetch at the target misses the TB and<b=
r>
&gt; TLB caches, which are keyed by privilege level, and reaches<br>
&gt; pmp_hart_has_privs_default() through riscv_cpu_tlb_fill(). That<br>
&gt; function already denies S/U-mode when no rule matches. Nothing<br>
&gt; executes between the privilege switch and that fetch, so no other<br>
&gt; behaviour changes.<br>
&gt; <br>
&gt; As it stands, S/U-mode can never be entered on such a configuration,<b=
r>
&gt; and a handler that steps mepc past the apparent fault resumes in<br>
&gt; M-mode at the S-mode entry point (GitLab issue #2074).<br>
&gt; <br>
&gt; The check was added by commit d102f19a208 alongside the pmp.c change<b=
r>
&gt; that makes the no-rule path M-mode-only, and I believe it was already<=
br>
&gt; redundant then. Building v6.0.0 and v7.2.0 with only the check removed=
<br>
&gt; confirms the fetch faults as expected. Later commits (0fbb5d2d3c9,<br>
&gt; 4c48aad1, 3157a553, 16aa7771) changed its gating, cause and location<b=
r>
&gt; but not the normal path. Remove it and the now unused prev_priv<br>
&gt; parameter.<br>
&gt; <br>
&gt; The bug was found and debugged with the help of Claude (Anthropic),<br=
>
&gt; used as a research and debugging aid; the patch was written by hand.<b=
r>
&gt; <br>
&gt; [1] Privileged ISA v1.12, 3.7.1 &quot;Physical Memory Protection CSRs&=
quot;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 Priority and Matching Logic<br>
&gt; [2] Privileged ISA v1.12, 3.3.2 &quot;Trap-Return Instructions&quot;<b=
r>
&gt; [3] Privileged ISA v1.12, 3.1.14 &quot;Machine Exception Program Count=
er&quot;<br>
&gt; [4] Privileged ISA v1.12, 3.1.16 &quot;Machine Trap Value Register&quo=
t;<br>
&gt; [5] Privileged ISA v1.12, 3.1.6.1 &quot;Privilege and Global<br>
&gt;=C2=A0 =C2=A0 =C2=A0 Interrupt-Enable Stack in mstatus register&quot;<b=
r>
&gt; <br>
&gt; Privileged ISA v1.12 (ratified, 2021-12-03):<br>
&gt; <a href=3D"https://github.com/riscv/riscv-isa-manual/releases/tag/Priv=
-v1.12" rel=3D"noreferrer" target=3D"_blank">https://github.com/riscv/riscv=
-isa-manual/releases/tag/Priv-v1.12</a><br>
&gt; Current source, same wording:<br>
&gt; <a href=3D"https://github.com/riscv/riscv-isa-manual/blob/4877e41a/src=
/priv/machine.adoc" rel=3D"noreferrer" target=3D"_blank">https://github.com=
/riscv/riscv-isa-manual/blob/4877e41a/src/priv/machine.adoc</a><br>
&gt; <br>
&gt; Fixes: d102f19a2085 (&quot;target/riscv/pmp: Raise exception if no PMP=
<br>
&gt; entry is configured&quot;)<br>
&gt; Resolves: <a href=3D"https://gitlab.com/qemu-project/qemu/-/issues/207=
4" rel=3D"noreferrer" target=3D"_blank">https://gitlab.com/qemu-project/qem=
u/-/issues/2074</a><br>
&gt; Signed-off-by: tewaro &lt;<a href=3D"mailto:tewaro@theorem.dev" target=
=3D"_blank">tewaro@theorem.dev</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0target/riscv/tcg/op_helper.c | 10 ++--------<br>
&gt;=C2=A0 =C2=A01 file changed, 2 insertions(+), 8 deletions(-)<br>
&gt; <br>
&gt; diff --git a/target/riscv/tcg/op_helper.c b/target/riscv/tcg/op_helper=
.c<br>
&gt; index b67c7718db..a355d28f4b 100644<br>
&gt; --- a/target/riscv/tcg/op_helper.c<br>
&gt; +++ b/target/riscv/tcg/op_helper.c<br>
&gt; @@ -423,7 +423,6 @@ target_ulong helper_sret(CPURISCVState *env)<br>
&gt;=C2=A0 =C2=A0}<br>
&gt; <br>
&gt;=C2=A0 =C2=A0static void check_ret_from_m_mode(CPURISCVState *env, targ=
et_ulong retpc,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 privilege_mode_t prev_pri=
v,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uintptr_t ra)=
<br>
&gt;=C2=A0 =C2=A0{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!(env-&gt;priv &gt;=3D PRV_M)) {<br>
&gt; @@ -435,11 +434,6 @@ static void check_ret_from_m_mode(CPURISCVState<b=
r>
&gt; *env, target_ulong retpc,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0env-&g=
t;misa_ext) &amp;&amp; (retpc &amp; 0x3)) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0riscv_raise_exception(env, RIS=
CV_EXCP_INST_ADDR_MIS, ra);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 if (riscv_cpu_cfg(env)-&gt;pmp &amp;&amp;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 !pmp_get_num_rules(env) &amp;&amp; (prev_=
priv !=3D PRV_M)) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 riscv_raise_exception(env, RISCV_EXCP_INS=
T_ACCESS_FAULT, ra);<br>
&gt; -=C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0static target_ulong ssdbltrp_mxret(CPURISCVState *env, tar=
get_ulong mstatus,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 privilege_mo=
de_t prev_priv,<br>
&gt; @@ -465,7 +459,7 @@ target_ulong helper_mret(CPURISCVState *env)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0privilege_mode_t prev_priv =3D get_field(mst=
atus, MSTATUS_MPP);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0uintptr_t ra =3D GETPC();<br>
&gt; <br>
&gt; -=C2=A0 =C2=A0 check_ret_from_m_mode(env, retpc, prev_priv, ra);<br>
&gt; +=C2=A0 =C2=A0 check_ret_from_m_mode(env, retpc, ra);<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0bool prev_virt =3D !!(get_field(env-&gt;msta=
tus, MSTATUS_MPV) &amp;&amp;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 (prev_priv !=3D PRV_M));<br>
&gt; @@ -515,7 +509,7 @@ target_ulong helper_mnret(CPURISCVState *env)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0bool prev_virt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0uintptr_t ra =3D GETPC();<br>
&gt; <br>
&gt; -=C2=A0 =C2=A0 check_ret_from_m_mode(env, retpc, prev_priv, ra);<br>
&gt; +=C2=A0 =C2=A0 check_ret_from_m_mode(env, retpc, ra);<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0prev_virt =3D !!(get_field(env-&gt;mnstatus,=
 MNSTATUS_MNPV) &amp;&amp;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(p=
rev_priv !=3D PRV_M));<br>
<br>
</blockquote></div>

--00000000000008a75b065eec17d8--

