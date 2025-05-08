Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 907DBC3ABBE
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 13:52:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uD1eg-00040O-Ky; Thu, 08 May 2025 09:51:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uD1ee-0003zd-1S
 for qemu-devel@nongnu.org; Thu, 08 May 2025 09:51:16 -0400
Received: from mail-yw1-x1129.google.com ([2607:f8b0:4864:20::1129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uD1eb-0005zR-Ew
 for qemu-devel@nongnu.org; Thu, 08 May 2025 09:51:15 -0400
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-708b31650ffso10385697b3.0
 for <qemu-devel@nongnu.org>; Thu, 08 May 2025 06:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746712270; x=1747317070; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Lr2FKoznQd1dzrXOA3k8dGjH+BUO8/I3at7g4/YAiok=;
 b=xkh1uKvRTNd5sAcovVRzVhlUVqYDfHllnJdxE3e5uJ3sTnWx/TG2TvDuiBCPuOMHfe
 mROtzj9ixAUeS2WXv5FNRBkXqsjBbIyygL4ss2AOAReFJdsoHWldnvMbZf25gDA/eeux
 2RymYRLIb12J2I9iGA+UDLcT3Je3etQ2zg153dUrx4J8kLNgzovl+GwaklCNWenkuHwG
 GCHjp+VdeaThUucKMrmBcTC45mFAcy1O4SczRfZCUKlxNKP00wKD3e7ukvUk/npfZEnc
 dcgNla0ODZvJojTsx4Qz6a8aaOnYcSUmngcU7i7Jt97yPVK0RrdQlKnAPbGnbuwo1DGp
 r5gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746712270; x=1747317070;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Lr2FKoznQd1dzrXOA3k8dGjH+BUO8/I3at7g4/YAiok=;
 b=dn2S0HFbVfaK2+Vz6GAYodZHGoB1cqm24kjk9UnoAm9KYjKlm1efL8BWKWTM6g4F50
 uMPxEye/6PObFS3fpLwCVM/XrDT9TERWCNRlxWhx/ISeSdeyHA1MViyNF1PR+2NrjGe9
 roGt0GMnoIBSSQv2v2ApFSqa48d5I5x1iNQKkI+zuPkg8qc88q9MdSgnGN+j/bIVcIBR
 0V5WlriBB0wVZkN7C9rNwO2RYmyHYtPwtMY5J2y01q/CDyURGtc/zha032vsvvY9Kb0R
 65yB1OpdJoXkAhxNkFEYckBObxqylJAYiJYAbvaUVpk4Mfaovb95ZfLfQNzC63O/gfxF
 YPLQ==
X-Gm-Message-State: AOJu0YxMG7v3B35c+f9dI8eTiMNngfYWtWwD5HSpMoRiyepYpZ2y1vXl
 sOWXVIOAEgnsxKvJDQp4cyiHV6uaMgUq7iCrDfq675I0HAke6oJs7ExaT+5EmswHDwaZeuRUo8E
 A9AuLcZIaDRXmMtNS22xk+XyoJ+b8KDMsmUVYIA==
X-Gm-Gg: ASbGncvJrcbIR3jhbkMMdRUkq9KB6rZboZT7ow+9T9j1wU6z0jYWLjaqDJ1UNUUVd+L
 NYKEcRouZr6TZYJw/u++Jr+4YhyBQRsg2MOJfeUmhIBvfBqcnhRh1lyEAnBLKbxV9Roq1Yn52Ev
 P2rfZTas1WysjDmgtnxQG5MQ4=
X-Google-Smtp-Source: AGHT+IEdlnDkIEQSZSpMBMXc5pv6kz/G3AH6tgDXwpDFS2x21qayM3rmbg6uuxVD5pILbmvilJQSlhIXrUlIKzrkplE=
X-Received: by 2002:a05:690c:3749:b0:708:bfc6:c7cd with SMTP id
 00721157ae682-70a2ce85c22mr53693097b3.6.1746712269882; Thu, 08 May 2025
 06:51:09 -0700 (PDT)
MIME-Version: 1.0
References: <20250507165840.401623-1-alex.bennee@linaro.org>
 <CAFEAcA_0cf=XEbH9VQdTHqu1wekSmFDLdqnnzpcwnshCT-UUCg@mail.gmail.com>
 <87zffnmidy.fsf@draig.linaro.org>
 <CAFEAcA80-CWEQYwTQPziUxm5V1K93VZstLh2r9mTGkD5QueKoA@mail.gmail.com>
 <87o6w3mdex.fsf@draig.linaro.org>
In-Reply-To: <87o6w3mdex.fsf@draig.linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 8 May 2025 14:50:58 +0100
X-Gm-Features: ATxdqUFyTo5XkBldfiqYzeGRzhmXruF_k_USSFHUxSU1OMWV1ed0ohn-cyX4ss0
Message-ID: <CAFEAcA-hgkPM_PXsD_q_SjNDyLCX3hVA=rVpTg9AWCdihK8fSg@mail.gmail.com>
Subject: Re: [RFC PATCH] target/arm: allow gdb to read ARM_CP_NORAW regs
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Julian Armistead <julian.armistead@linaro.org>, 
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1129;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1129.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Thu, 8 May 2025 at 14:37, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:
>
> Peter Maydell <peter.maydell@linaro.org> writes:
>
> > On Thu, 8 May 2025 at 12:50, Alex Benn=C3=A9e <alex.bennee@linaro.org> =
wrote:
> >>
> >> Peter Maydell <peter.maydell@linaro.org> writes:
> >>
> >> > On Wed, 7 May 2025 at 17:58, Alex Benn=C3=A9e <alex.bennee@linaro.or=
g> wrote:
> >> >>
> >> >> Before this we suppress all ARM_CP_NORAW registers being listed und=
er
> >> >> GDB. This includes useful registers like CurrentEL which gets tagge=
d
> >> >> as ARM_CP_NO_RAW because it is one of the ARM_CP_SPECIAL_MASK
> >> >> registers. These are registers TCG can directly compute because we
> >> >> have the information at compile time but until now with no readfn.
> >> >>
> >> >> Add a .readfn to return the CurrentEL and then loosen the restricti=
ons
> >> >> in arm_register_sysreg_for_feature to allow ARM_CP_NORAW registers =
to
> >> >> be read if there is a readfn available.
> >> >
> >> > The primary use case for NO_RAW is "system instructions" like
> >> > the TLB maintenance insns. These don't make sense to expose
> >> > to a debugger.
> >>
> >> I think we could re-think the logic:
> >>
> >>     /*
> >>      * By convention, for wildcarded registers only the first
> >>      * entry is used for migration; the others are marked as
> >>      * ALIAS so we don't try to transfer the register
> >>      * multiple times. Special registers (ie NOP/WFI) are
> >>      * never migratable and not even raw-accessible.
> >>      */
> >>     if (r2->type & ARM_CP_SPECIAL_MASK) {
> >>         r2->type |=3D ARM_CP_NO_RAW;
> >>     }
> >
> > Well, we definitely don't want WFI or the DC ZVA etc
> > "registers" to be exposed to GDB or for us to try to handle
> > them in KVM state sync or migration... ARM_CP_NOP is less
> > clear because we use it pretty widely for more than one
> > purpose. The main one is "system instruction that we don't
> > need to implement". (CP_NOP + a readable register is a
> > questionable combination since the guest will expect it to
> > update the general-purpose destreg, not leave it untouched,
> > but we do have some.)
> >
> >> > If we want the gdbstub access to system registers to be
> >> > more than our current "we provide the ones that are easy",
> >> > then I think I'd like to see a bit more up-front analysis of
> >> > what the gdbstub needs and whether we've got into a bit of
> >> > a mess with our ARM_CP_* flags that we could straighten out.
> >>
> >> Yeah - hence the RFC. CurrentEL is a super useful one to expose though
> >> when you are debugging complex hypervisor setups.
> >
> > One problem with this patch is the one that the reporter of
> > https://gitlab.com/qemu-project/qemu/-/issues/2760 noted
> > in the conversation there: it will allow the debugger to
> > read registers which have a side-effect on read, like
> > ICC_IAR1_EL1: we almost certainly do not want to allow
> > the debugger to acknowledge an interrupt by doing a sysreg
> > read.
>
> Doesn't raw_readfn offer these semantics?
>
>     /*
>      * Function for doing a "raw" read; used when we need to copy
>      * coprocessor state to the kernel for KVM or out for
>      * migration. This only needs to be provided if there is also a
>      * readfn and it has side effects (for instance clear-on-read bits).
>      */
>     CPReadFn *raw_readfn;
>
> So maybe:
>
>         /* We can only read ARM_CP_NO_RAW regs without side effects */
>         if ((ri->type & ARM_CP_NO_RAW) && !ri->raw_readfn) {
>             return;
>         }
>
> And I guess we can strengthen the gdb helper to NOP any writes to such
> registers.

This seems to be continuing down the path of "oh, if we just
tweak this condition here it seems to whack this particular
mole on the head". What I'm asking for is a more holistic
view of what we're trying to achieve and what the "right"
design for that ought to be, not for small patches that
add more ad-hoc adjustments to where we are currently.

thanks
-- PMM

