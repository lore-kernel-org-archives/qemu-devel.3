Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68A72CA5FFC
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 17:38:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEVaL-0002KC-Uh; Wed, 07 Oct 2026 13:37:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xEVZv-00026e-WA
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 13:37:24 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xEVZs-0004IZ-Hj
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 13:37:19 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-6aa9164072cso1163855a12.2
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 10:37:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791394635; cv=none;
 d=google.com; s=arc-20260327;
 b=C8JaC2llwxOeTTKtDqqWSqZtQPzjxrYD+AZzG3+GZca+QTvF5UKJVysj8qY8EUk7by
 5l1YGLtEnqasW792Orxnp6yJVIDI13JclOO9RL/6BEIjXUve8o0MqlGCzzwQCidFqEAk
 ZL6VD0mc044gm295GgvkOLQKwSFw2VVcx0DUD3GjjLHRMJ+YBRfIHk8YvURZYZfA0Hww
 X90+bDDf77uDja9D+CIgm6P/EdIrN4332I+1/3sPMRjlIWP0GJzZ0Q1KY7TzxNiIcfYD
 8EXs5q4iu4/xbrrfqcWFoEhEgwoKNtgAodoghza0tx4gBUm6H2cLlg2ylsJoAIc0hXas
 JiRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=jQ5G539b5PlM768dOz9ghPIEBp2K7zTCBOFKY+EPPRA=;
 fh=ICI+EqXWS+NqqCeNMH6s/9zkKUicsXF1K3mTJcDiCcU=;
 b=pnM5I6s0zyQM1RoBJABYGjQJh4aJCSIuNsy6uqflPflAUfUn4oC/YpEWqplizY4WBJ
 GH5PpnSn/zBgdPidTOh9JzdoxzRFGWLJGJZS7mQmoJdOrdmHBwcvNktDUmcXT+88v80g
 RcIgiTamCs/ZDiUoKhq4kx69zLAyLv8lbqFp9oyC2LkaPchJaLHWcNHqsqYv2xaoSyxh
 fym6ZalQt6MevuIC7eRgX1MfnitxBCVgZcuAtQx3w3SYoRDjp+nYP1h7htN1Y8jqXVOX
 7e/kVqlif/1aDlucbMkSJI55zjsy64a+NrghzUH/F61Zu5915mMdI0adoeYxNTMOa2Qt
 /5Sw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791394635; x=1791999435; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=jQ5G539b5PlM768dOz9ghPIEBp2K7zTCBOFKY+EPPRA=;
 b=lb5GSi0OL39ksV7RQYzU2bTrHf7ux1FbVYM6udvkNSY8esNGmvPhiG2je8UFTchIis
 hbOSlU02I2EIAMgUQ0MGUpWbqMGI+vnMw2EUgllN8aLroRNlzHtnJqBESJ9uBbNV1etS
 A9UpBxKN2u9EhfLpbRyoOPRchuDb/3bpXhHX0GIJGkHSlrs+swYaICzZ9I7Ny54Uv74V
 84XA6nh31IfCXPQoI8fRCKv6zK8DsDS7UltZaagciK/juZxmvBQ3YIayeB1AUHH/5WsY
 BR29B2sZaf8VkBij6in3K05miwe7/q6T19nONZv3AIJRAbNErm7cGmCFfnA0+FNT1MvT
 8GVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791394635; x=1791999435;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=jQ5G539b5PlM768dOz9ghPIEBp2K7zTCBOFKY+EPPRA=;
 b=vK8thiSm7O7uOXOkgkEQ7BHMIWyfWb6Gtg60zyfz01qQOaMPUfgAo8i4X5cLwIUqhu
 ZIkaQnRQgXxgndg54d5DhrQw7q6ZiRIJNzqMOqHYDDlVGNv8O90M6wuEgPcz6XQ1V0Us
 HpDBs82gNgfBtJKRIpReVGjAr8CLJpw9HbRqWUMDE8W+7MfIgYDNCJEamLgaztKalGTz
 WDUKGO7TBONzCijxpdawtPSVb/P39YFRI3huxFFkf1dvK3dRSeiVz57HQcURRW1P7vB8
 LW9aT0Wk7rEyACK6ZR/CINqeUrxU4/S4zC2UNxckxuuzXwVej7zmW0U3iQYYhkBpOHnm
 FvqQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBx/TONck+W10NV1P+5faNuaBuSabe44xUWgTDOBriVyK+AY1Dq15hg11RAAupbQ4xYfUTbuh5Y44qCj@nongnu.org
X-Gm-Message-State: AFq9FYJYfRaIfmX1INx3ceqCAv8A2ZIH7poeJsMfdsp3kWN9dk7+hRvy
 P6v8BuhOX7OymsWJC47wbsALz9cDe9szYLBIxs44lCuq7QHXq/o26kJBriEBB5Gy53JFdIuG+6w
 MTwgqjIV4ZnLBveVxYWKAtJMPo8YRVIE=
X-Gm-Gg: AYBFou1FPwLsyBTuzywqaX4WT3Q73QQV6F8pLgYnTDJYTRgSAxhjc7tfWXb3M8W8GXa
 0Se49+siYes6oNP7F0ecdLLCCyHAdWb5oMXAwAialXvN0AeB6GYxvUWAcxrHyf31wMfRmv1NESE
 GCCz5Hs9n6lshOWp7Y9cce+TZ+AfdPFExAFtfSlHu94dLjzs2Xs2NFQQ2O7PAkjW+md7XYO5Gs2
 LOt33tsbGh4MmHmT6mN3+2EWKEn4bpsPh24nJHBwEhHqbHqa+APhtcPGV2pOzmVtATS1wYWN9jW
 McYYBmhhAYZus1Ts/tMAVuPt37qZe8FspeNPAaFnnRKt39hrnKnr+9g=
X-Received: by 2002:a05:6402:a0d2:b0:6ac:6fe6:b391 with SMTP id
 4fb4d7f45d1cf-6aff47a068amr2477770a12.18.1791394634718; Wed, 07 Oct 2026
 10:37:14 -0700 (PDT)
MIME-Version: 1.0
References: <20261007-rv-dedup-v2-0-8a2f0f296a7f@rev.ng>
 <20261007-rv-dedup-v2-15-8a2f0f296a7f@rev.ng>
 <b41b3cd4-2f20-4c34-8b8d-da80c23a6990@oss.qualcomm.com>
 <5df7768b-013f-4686-9ac4-cb8e39773919@oss.qualcomm.com>
In-Reply-To: <5df7768b-013f-4686-9ac4-cb8e39773919@oss.qualcomm.com>
From: Yonggang Luo <luoyonggang@gmail.com>
Date: Thu, 8 Oct 2026 01:36:59 +0800
X-Gm-Features: AclHuK-ESmEuj595eJsNupHFjXajEayl-laQYEYFujgm_Qe7FbU404ub7dhX7dQ
Message-ID: <CAE2XoE8FmkmkMgNqQzzGx9+X1WfFti_MXH+tT3bky1qiEidr-g@mail.gmail.com>
Subject: Re: [PATCH v2 15/18] target/riscv: Compile arch_dump.c once
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org,
 Ani Sinha <anisinha@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 qemu-riscv@nongnu.org, daniel.barboza@oss.qualcomm.com, 
 pierrick.bouvier@oss.qualcomm.com, palmer@dabbelt.com, 
 alistair.francis@wdc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=luoyonggang@gmail.com; helo=mail-ed1-x529.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: luoyonggang@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Oct 8, 2026 at 1:30=E2=80=AFAM Philippe Mathieu-Daud=C3=A9
<philmd@oss.qualcomm.com> wrote:
>
> On 2026-10-07 12:34, Philippe Mathieu-Daud=C3=83=C2=A9 wrote:
> > On 7/10/26 10:43, Anton Johansson wrote:
> >> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> >> Signed-off-by: Anton Johansson <anjo@rev.ng>
> >> ---
> >>   target/riscv/arch_dump.c | 13 +++++++------
> >>   target/riscv/meson.build |  2 +-
> >>   2 files changed, 8 insertions(+), 7 deletions(-)
> >>
> >> diff --git a/target/riscv/arch_dump.c b/target/riscv/arch_dump.c
> >
> >
> >> @@ -175,11 +176,11 @@ int cpu_get_dump_info(ArchDumpInfo *info,
> >>       info->d_machine =3D EM_RISCV;
> >> -#if defined(TARGET_RISCV64)
> >> -    info->d_class =3D ELFCLASS64;
> >> -#else
> >> -    info->d_class =3D ELFCLASS32;
> >> -#endif
> >> +    if (target_riscv64()) {
> >> +        info->d_class =3D ELFCLASS64;
> >> +    } else {
> >> +        info->d_class =3D ELFCLASS32;
> >> +    }
> > If this is good enough to link:
> > Acked-by: Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com>
> >
> > But FYI the whole "system/dump-arch.h" API is not ready for
> > heterogenous emulation. We discussed it once with Marc-Andr=C3=A9
> > and there is no good way to adapt it, since it was not designed
> > with that in mind, and is restricted to a single architecture
> > which doesn't change (word size, endianness) at runtime.
> > IIRC we ended agreeing dump can not be supported in Het.Emu.,
> > and the plan was to refactor get_dump_info() as a CPUClass
> > handler, if not heterogenous then dispatch if available
> > otherwise fallback to "not supported" stub.
>
> FTR for whoever will work on this, this symbol will clash:
>
> $ git grep -w cpu_get_dump_info
> dump/dump.c:1856:     * If the target architecture is not supported,
> cpu_get_dump_info() will
> dump/dump.c:1859:    ret =3D cpu_get_dump_info(&s->dump_info,
> &s->guest_phys_blocks);
> include/system/dump-arch.h:31:int cpu_get_dump_info(ArchDumpInfo *info,
> stubs/dump.c:17:int cpu_get_dump_info(ArchDumpInfo *info,
> target/arm/arch_dump.c:388:int cpu_get_dump_info(ArchDumpInfo *info,
> target/i386/arch_dump.c:397:int cpu_get_dump_info(ArchDumpInfo *info,
> target/loongarch/arch_dump.c:145:int cpu_get_dump_info(ArchDumpInfo *info=
,
> target/ppc/arch_dump.c:232:int cpu_get_dump_info(ArchDumpInfo *info,
> target/riscv/arch_dump.c:164:int cpu_get_dump_info(ArchDumpInfo *info,
> target/s390x/arch_dump.c:452:int cpu_get_dump_info(ArchDumpInfo *info,


This is how I deal with these conflict and others alike

https://gitlab.com/lygstate-qemu/qemu/-/commit/facad1f56e06b7f53d7441c5d859=
28b1ceaf8894

But it's depends on
https://lore.kernel.org/qemu-devel/20261006182558.151956-1-pierrick.bouvier=
@oss.qualcomm.com/T/#t
That ensure those target_arch() return the valid value.

>


--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

