Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3E4DC6FD1F
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 17:18:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmzZh-0002GT-88; Wed, 20 Mar 2024 13:18:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rmzZg-0002Fw-4R
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 13:18:00 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rmzZd-0006Wg-4V
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 13:17:59 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-56bb22ff7baso1130871a12.3
 for <qemu-devel@nongnu.org>; Wed, 20 Mar 2024 10:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710955075; x=1711559875; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=33F1//D2fVsuIjqVnoLzC6cYCRfMhnqisnhO1dhobsc=;
 b=wTjIEk5wqDvhqN5pP56g0QGFTNkHtDmBDsrgHwcnmZtfWNV5qWtoZJAk6YpM7+4UoJ
 /g4YXsB6Y24TW/HpziSl1BFQauJfzR5EceQAdWrrnZO69LMoKgseQ2ryMzZoj0bqq7Xr
 ciZTfpi2p1IYJs4bxBZNrFpEe0usWAEDUAzPsThHm2Am3tQTGdL1wtE2ThVfjMTqtc21
 2ouv+NMC8kPljNHuriboxNiPQK+lZVfxTmz6V9z0881ulIJ4LhR4rarF3pnhoORr3t3j
 5EAK+2VP0vpdQuHanFR+yxJj8Cb0KpepPzzqTgzhF3h15JKWiLFLqYC2r6RFkQzjGsX8
 s9JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710955075; x=1711559875;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=33F1//D2fVsuIjqVnoLzC6cYCRfMhnqisnhO1dhobsc=;
 b=I+3czMXRSdxqHOizX/ROiAFSdB9W5h1utFIo3SyKF1mB81cFRVGCzuPf1AW2NPeMyV
 o0VLS0GrEIMXZMRBSBHD7knNKQ5l+VO51Le7RIF/ULH4lXNGXFnK3ce15O1ddAbsY9U3
 fRbJjdhaWH748lpVramDSmjrma90k0LLh+JGI2SqL09SvB4mpRNJxRcnhq94Nih0MFnu
 GoRPnnrAeKWxdhrzMZh2kJzBE2fWQU1pvxLwRny8MT/evkWIveWUoJZE+fmMOjpz1iEp
 cvsxesfiVjE5yiCBvlyFGULgPoKUW9nOaVscpY/UdzyUGHol/h6cVCbQFjA9j0bvuThQ
 uvvQ==
X-Gm-Message-State: AOJu0Yxuc50/Yx/ZnXinGXXGruTJlwJWjVR5sGVzDvPO0eFOo05MzBdA
 O8N3otGBaP/zBzX3AUY15rxfo1cqShes4XyxzC9XLKTPZUMS+8DtgJA/ylDuO0UBn4VkPHHlF/7
 +lwZIDZrxjSB/LayhDn+gvnr+3mGBl559ae3oqCKZA9dOnXo/
X-Google-Smtp-Source: AGHT+IGypr6vcyDFxgdjfErmrgzvn4GBXX5EaJq2Nl7edaxdaUO/tMFMWVp58UUqCiH3ayzi3eDB4SKSW5VnMt7yPYw=
X-Received: by 2002:a05:6402:4346:b0:56a:ae8a:acb3 with SMTP id
 n6-20020a056402434600b0056aae8aacb3mr5817083edc.42.1710955075311; Wed, 20 Mar
 2024 10:17:55 -0700 (PDT)
MIME-Version: 1.0
References: <20240320164055.60319-1-philmd@linaro.org>
 <CAFEAcA81u9J9iijs-CNDbsANb6c0Cdb4qQKmBd=DiQAoFA4U=w@mail.gmail.com>
 <5deec986-7a22-402d-abe1-4e40f5bb427a@linaro.org>
In-Reply-To: <5deec986-7a22-402d-abe1-4e40f5bb427a@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 20 Mar 2024 17:17:43 +0000
Message-ID: <CAFEAcA_4J32gpUgxXxND8ZVhrEEhFK=gPG2SF8xsVJ+jpkV0WA@mail.gmail.com>
Subject: Re: [PATCH-for-9.0 0/2] target/monitor: Deprecate 'info tlb/mem' in
 favor of 'info mmu'
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Richard Henderson <richard.henderson@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-ppc@nongnu.org, 
 Thomas Huth <thuth@redhat.com>, devel@lists.libvirt.org, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x536.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Wed, 20 Mar 2024 at 17:06, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> +Alex/Daniel
>
> On 20/3/24 17:53, Peter Maydell wrote:
> > On Wed, 20 Mar 2024 at 16:40, Philippe Mathieu-Daud=C3=A9 <philmd@linar=
o.org> wrote:
> >>
> >> 'info tlb' and 'info mem' commands don't scale in heterogeneous
> >> emulation. They will be reworked after the next release, hidden
> >> behind the 'info mmu' command. It is not too late to deprecate
> >> commands, so add the 'info mmu' command as wrapper to the other
> >> ones, but already deprecate them.
> >>
> >> Philippe Mathieu-Daud=C3=A9 (2):
> >>    target/monitor: Introduce 'info mmu' command
> >>    target/monitor: Deprecate 'info tlb' and 'info mem' commands
> >
> > This seems to replace "info tlb" and "info mem" with "info mmu -t"
> > and "info mmu -m", but it doesn't really say anything about:
> >   * what the difference is between these two things
>
> I really don't know; I'm only trying to keep the monitor interface
> identical.

You don't, though: you change it from "info tlb" to "info mmu -t" etc.

> >   * which targets implement which and why
>
> This one is easy to answer:
>
> #if defined(TARGET_I386) || defined(TARGET_SH4) || defined(TARGET_SPARC)
> || \
>      defined(TARGET_PPC) || defined(TARGET_XTENSA) || defined(TARGET_M68K=
)
>      {
>          .name       =3D "tlb",
>
> #if defined(TARGET_I386) || defined(TARGET_RISCV)
>      {
>          .name       =3D "mem",
>
> >   * what the plan is for the future
>
> My problem is with linking a single QEMU binary, as these two symbols
> (hmp_info_mem and hmp_info_tlb) clash.

Yes, but they both (implicitly) operate on the current HMP CPU,
so the problem with linking into a single binary is that they're
not indirected through a method on the CPU object, not the syntax
used in the monitor to invoke them, presumably.

> I'm indeed only postponing the problem, without looking at what
> this code does. I did it adding hmp_info_mmu_tlb/mem hooks in
> TCGCPUOps ("hw/core/tcg-cpu-ops.h"), so the command can be
> dispatched per target vcpu as target-agnostic code in
> monitor/hmp-cmds.c:
>
> +#include "hw/core/tcg-cpu-ops.h"
> +
> +static void hmp_info_mmu_tlb(Monitor *mon, CPUState *cpu)
> +{
> +    const TCGCPUOps *tcg_ops =3D cpu->cc->tcg_ops;
> +
> +    if (tcg_ops->hmp_info_mmu_tlb) {
> +        tcg_ops->hmp_info_mmu_tlb(mon, cpu_env(cpu));
> +    } else {
> +        monitor_puts(mon, "No per-CPU information available on this
> target\n");
> +    }
> +}

These aren't TCG specific though, so why TCGCPUOps ?

> > I am definitely not a fan of either of these commands, because
> > (as we currently implement them) they effectively require each
> > target architecture to implement a second copy of the page table
> > walking code. But before we can deprecate them we need to be
> > pretty sure that "info mmu" is what we want to replace them with.
>
> An alternative is to just deprecate them, without adding "info mmu" :)
>
> It is OK to un-deprecate stuff if we realize its usefulness.

The commands are there because some users find them useful.
I just dislike them because I think they're a bit niche and
annoying to implement and not consistent across target
architectures and not very well documented...

By the way, we have no obligation to follow the deprecate-and-drop
process for HMP commands; unlike QMP, we give ourselves the
license to vary it when we feel like it, because the users are
humans, not programs or scripts.

-- PMM

