Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6214EC5DF81
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 00:12:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwTtu-0001Yf-9f; Tue, 18 Aug 2026 20:11:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1wwTts-0001YH-O4
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 20:11:24 -0400
Received: from mail-lf1-x130.google.com ([2a00:1450:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1wwTtq-00074Q-RL
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 20:11:24 -0400
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-5b45f1cd80eso483431e87.2
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 17:11:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787098269; cv=none;
 d=google.com; s=arc-20260327;
 b=ZQP8aFqpWGU0QnPPj9gkjJ5uxdWzPNJ7GqWJjqJLnnWMgnrxOf+YmTwrBJss6YbcSs
 wqnBTDunkceKYoMJCT9q0aKgCwt3I0aVJUxvccYsYHJtOOtFx8iG1ltbhkPQnuhhgO8x
 744wupyXq8htH8HI/3bHQ9C0m4zSH7/MsimUkIe+Ibl6tTNPcs7x/hxdw+YvrkdKJnyi
 NefsACpUEaBr1ef0PoGn3cb3pKWt/VsQskQ7wxU7XL9TzgqtQ8EZHkv6xKrSAapq9Mvd
 3hAhGnK0R35v9XIFfuYlQhI4xz79ys612PpE7HPJ1i1dFlIeAyplOaJJYQ/XTgoFhhm0
 w4/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Ytrxr6B4JnhFaOKLKqOgiBfz6miQWhjD87khaglm1As=;
 fh=sPnp61a2YNNsKkD0W3RUEF+042aNl9Quj94CbgGh8Xs=;
 b=c9qbfuMxd9FdRCaUMCzo36g9AMp2gf68uv58C0/cOp4rM7LjSUYVKtA6sefSKB/CES
 HZBnK+V/JuJvLmC8hqlJprAGdDMtyX1Tr+uySdHaiQ45Of1djUEERABwhxtHEZyBio0d
 BFCFrnxzNA+XGgR9kDtHjyASyhsFSKtmPzNaw7jY8nFVBArvHkN99lr61i07kSM5Q6gy
 N/2M/zZ91Bzjj88q5QIcDEPlB+Hv5GQqBkar2ACvEGxMljCQiP3NpUnALouB8BzMF1kD
 Gpl7K5h3qFJcV9Sf1oa9vTbP6e5lfpwZysLg0jBsrGFoFcSTecUmmYkXMkAvBjdfwzaK
 0Grw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787098269; x=1787703069; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Ytrxr6B4JnhFaOKLKqOgiBfz6miQWhjD87khaglm1As=;
 b=Eo1aueG34hvMphCv36rGYSDhMSw/2xBbR3JOufuMkOZOlo+s+gSEiYsZkzKChwrJWU
 xEG2Sha6Z4ZD1khT72kzS76ptiNThMA8DG6xY0xFR877Y+Z3hhR1d9tdIaJRZcJNr32+
 kriivT2Vb8qSBJcMuZQl/zCi5cplWINgxDgSeyiOBTdsgwae+8B0JOwo0314JgZJi3FG
 B2BVi0eGG6zkD0OgWBi5rWCFkWxz8tRKyQDk5+MmEJUkIR9jfg6/n0Bc4IbMAKyrXHZx
 UF7YRxJzrDA95/eq2PFBn+WJ/J3erVkZo+XRzWMnRMawkP34i/Bu/5NtxCOf65jUiThB
 /5Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787098269; x=1787703069;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Ytrxr6B4JnhFaOKLKqOgiBfz6miQWhjD87khaglm1As=;
 b=cYWbpKv71Olr6zGx6r6x7sm1+6+vAxzDPD/B6xi1GhYITFHDgf9vnSY+dt8Yi4D/AR
 U3aAgf2mXg8rvv1NRrrPQVg1A6gaGlePxlfgPmvY1Naa1XSt0SxvzA7SCp+2UKfS4tv2
 xvhhG9ExHJWo57aX9bX4eY4Vz0JmVlgtz7vdGKVwUqioXbA/NYEAx1VCAKaF28TIxQT1
 4D99OvQW0KmftMEs9IODu3LquPcf33sAHK1429+dpdwzdRh05juiOD3SWOD8pljynC20
 qN7pFzcmPJeEGdDw8q88aQQGjZAVWGECGOqpdIhq8JU64pCHWD8Oq3cqfAKtdauPvGnO
 mSZg==
X-Gm-Message-State: AOJu0YyC5WV+WzgAm7jJRpNar/hRL1E0vjZe0FntAuitGJX7Ikc2zn70
 02/2ONIgVIXqmE+v2wLmZnya0gd5VV1jZ8lChzE+Mbkq+EWb5ptOy3WPhmteLrzhz3aMRiu2t9O
 /LJYQq6DJA7snvRhp57RxZcHM4UkIwwo=
X-Gm-Gg: AR+sD11L0ra5CzKRpxOSpc461O5epAN5gt2/5Gse4isSc95UWQjxuicaVID6UDAUX1g
 hY6E5i6CtNj3pA6PLu2Z9b3x3DK+55jlxgw/FuOpni8A82kneHHt+g5RlaAGqiylktpfPEBYkWy
 HfWwV34kfrZtsMUfUZpRSfwWM8Lvtx0dLOl2AKk2PPW8U+Sef0OB+RD2IcgGU+PlCkZYEykGZOQ
 cezxanHCih3g+7N9RDoOXb3iJj4Fcj67OpFYYsuJxWwSczblN46x8J4/971JQ+Xnjtp8jNzpTvi
 kKFuxnq69TyhuRqJ5bxW7xkSVyIz95YkHs69qMHHlhWbY70Nsc3316ZvCTxA93dn1ntmqEOutKc
 jDPU=
X-Received: by 2002:a05:6512:2308:b0:5b0:eda:de1f with SMTP id
 2adb3069b0e04-5b478b5158cmr143016e87.6.1787098269093; Tue, 18 Aug 2026
 17:11:09 -0700 (PDT)
MIME-Version: 1.0
References: <20260818174247.649526-1-mattst88@gmail.com>
 <20260818174247.649526-5-mattst88@gmail.com>
 <23eaea1b-e3bf-4845-8942-0e6ffcf056ca@oss.qualcomm.com>
In-Reply-To: <23eaea1b-e3bf-4845-8942-0e6ffcf056ca@oss.qualcomm.com>
From: Matt Turner <mattst88@gmail.com>
Date: Tue, 18 Aug 2026 20:10:56 -0400
X-Gm-Features: AcwNN1W5ijnt9tnRKKAoNXvyFcvXkqW8020AGWguZ5pBBCLOWoOlnJUmGRUHz6c
Message-ID: <CAEdQ38EwBQJp4hsWfvmCiZNOkghEESzZ7yU3LaQeQ1AzMSnj5w@mail.gmail.com>
Subject: Re: [PATCH 4/8] RFC: tcg: probe the TB jump cache inline instead of
 calling a helper
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org, pbonzini@redhat.com, 
 philmd@mailo.com, zhao1.liu@intel.com, laurent@vivier.eu, deller@gmx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::130;
 envelope-from=mattst88@gmail.com; helo=mail-lf1-x130.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Aug 18, 2026 at 5:51=E2=80=AFPM Pierrick Bouvier
<pierrick.bouvier@oss.qualcomm.com> wrote:
>
> On 8/18/2026 10:42 AM, Matt Turner wrote:
> > Every indirect branch that cannot use goto_tb ends in
> > tcg_gen_lookup_and_goto_ptr(), which calls helper_lookup_tb_ptr(). For =
an
> > emulated compiler that is 8.4 billion helper calls in a single translat=
ion
> > unit: 24.6% of all TB exits take this path, because jsr/ret/jmp have a
> > register destination and because goto_tb is restricted to same-page
> > targets.
> >
> > The helper itself is already tight, but each call pays for a call frame=
,
> > the can_do_io store, the get_tb_cpu_state() indirect call through
> > TCGCPUOps, curr_cflags(), and a breakpoint check, before it gets to the
> > jump cache probe that almost always hits (95.8% for this workload).
> >
> > Emit the probe inline instead. The destination PC is already in a TCG
> > temp, and the flags and cflags the destination must match are constants=
 at
> > translation time, so the fast path is a hash, three guarded loads and a
> > goto_ptr. Only a miss calls the helper, which still owns filling the ca=
che.
> >
> > Two details matter for the generated code. The flags and cflags guards =
are
> > folded into a single aligned 64-bit load and compare, since the fields =
are
> > adjacent. And each path emits its own goto_ptr rather than branching to=
 a
> > shared one: a temp live across the label is spilled and reloaded on eve=
ry
> > dispatch, which cost 6.3% on its own.
> >
> > Measured with qemu-alpha running an emulated alpha gcc 16.2.0 compiling
> > the SQLite 3.45.1 amalgamation (255k lines, -O2) on an x86-64 host, LTO
> > build, on top of the preceding three patches:
> >
> >     before: 1,402,816,253,499 instructions
> >     after:    890,713,633,237 instructions   -36.51%
> >
> >     before: 115.75s wall clock
> >     after:   84.44s wall clock               -27.05%
> >
> > The gap between the two is the point at which this stops being a
> > straight-line win: the helper call was highly predictable work that the
> > host pipelined well, so removing it retires far fewer instructions than=
 it
> > saves time. IPC falls from 2.48 to 2.15 across this patch for that reas=
on.
> >
> > Despite emitting more code, this also reduces instruction cache pressur=
e,
> > because a dispatch no longer jumps into qemu's .text and evicts transla=
ted
> > code:
> >
> >     before: 11,476,318,964 L1-icache-load-misses
> >     after:   6,990,186,701 L1-icache-load-misses   -39.1%
> >
> > The mechanism is visible directly in a profile: helper_lookup_tb_ptr()
> > falls from 30.97% of samples to 0.42%, and qemu's own .text falls from
> > 38.9% to 5.4%, with the balance moving into generated code.
> >
> > Combined with the three preceding patches, against an unmodified LTO
> > build, 1,647,901,588,726 instructions fall to 890,713,633,237, or -45.9=
5%.
> > The emulated compiler produces byte-identical output throughout.
> >
> > Open issues, hence RFC:
> >
> > - The flags/cflags guards use the *current* TB's values as constants. T=
hat
> >   assumes the CPU flags feeding get_tb_cpu_state() cannot change within=
 a
> >   TB, and that curr_cflags() cannot change under a running TB (gdb
> >   attaching to enable single-step would). Both need to be established o=
r
> >   the values need to be loaded at runtime.
> > - tcg/tcg-op.c has no business including accel/tcg/tb-jmp-cache.h or
> >   knowing the CPUJumpCache layout. The probe likely belongs in accel/tc=
g
> >   with a small emit helper exported from tcg/.
> > - The jump cache entry is read without qatomic_read(); entries are
> >   invalidated concurrently by setting tb to NULL.
> > - Only wired up for alpha so far, and only for 64-bit guest PCs.
> >
> > Signed-off-by: Matt Turner <mattst88@gmail.com>
> > ---
> >  include/tcg/tcg-op-common.h |  2 +
> >  target/alpha/translate.c    |  4 +-
> >  tcg/tcg-op.c                | 79 +++++++++++++++++++++++++++++++++++++
> >  3 files changed, 83 insertions(+), 2 deletions(-)
> >
>
> This change breaks following tcg test:
> alpha-linux-user/gdbstub-follow-fork-mode-child
>
> Reproduce with:
> ninja -C build &&
> make -C build/tests/tcg/alpha-linux-user/ &&
> make -C build/tests/tcg/alpha-linux-user/ run-gdbstub-follow-fork-mode-ch=
ild
>
> Need gdb-multiarch and gcc-alpha-linux-gnu installed on your machine.

Thanks! I had gdb available, I apparently just needed to configure
with `--cross-prefix-alpha=3Dalpha-unknown-linux-gnu-` to get this test
to run.

Fixed locally.

