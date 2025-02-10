Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8432AC02198
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 04:12:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thL9C-00034v-Ob; Sun, 09 Feb 2025 23:11:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1thL99-000346-75; Sun, 09 Feb 2025 23:11:47 -0500
Received: from mail-vs1-xe31.google.com ([2607:f8b0:4864:20::e31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1thL96-0003ga-Pa; Sun, 09 Feb 2025 23:11:46 -0500
Received: by mail-vs1-xe31.google.com with SMTP id
 ada2fe7eead31-4bbbab48111so294497137.0; 
 Sun, 09 Feb 2025 20:11:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1739160703; x=1739765503; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=27DDN3UmqvhVrPbVFH9KHkVOpBm9fwG7BaJ5+WYBh2M=;
 b=MBVXZmBDrBcgvYVz5XD1u9FZtVs/xHrtRkR4wrmyvdo0YiXtXMRv7ld/FzeaXFp3O8
 UjugCzllh4gxBhu4aC5kYQ61r3rP3KZ6PtnIG1TjNVsV21RLg+A6TGIhgUQ7/cnL//ug
 /6oUUbXvmrfhxhMc12uyrC1ZEj3NpJT+c7sHlFIUuGvwsfLZfRwtN8ypGsmfFGKfVQXu
 LPiKaREyOQPVxXjzGxdE7xhvlkFSKmFmAPln3aV7q2/AD7e4xpkXctBI9Qes5klFN/GB
 1a4xIwy/B/WmzG/NhXPZaWm2OFtx2wbmvrhHSTmGJ0uwgLVQnTt21Hwb7TLtO0v4mGrB
 B9dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739160703; x=1739765503;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=27DDN3UmqvhVrPbVFH9KHkVOpBm9fwG7BaJ5+WYBh2M=;
 b=tLtH8ZCzjIsIip0h6yk9sJu2xmRfAp7TZLqQo/gMwFiMdtsal53DLfsOMiLGbG5i9z
 xD6kcgkjdO+iGwznUTxaAP6T2QbEkH9XKZLE8AKL8+Ag32SCCJFnkkYMrummFNmY731M
 2DedZAb+KKud9CI55SMMS1t+5PdcsYDgM99k3u0ncay3Hn+SaUFUamFOhF5PfZ+UEyx7
 Sov8HdWFVawCnE9tnzVZf9OSgv2s+LrVD4uDOddfTQ9IVBHq/oDm9u3qUBdlpUpgkGe/
 oTkj80ASdgWOjZzsenIl15TwK83f32ii2YJ/pOtk5uuU+L5JXiyXzmLPdJcOTSuenyQY
 rffA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW5Ak8Qfk6I4lOWVybJsZf5kxw0mmmjyYYjiRrEVvujPztnNFM/3zw4uN8vbEYs/Y65w7jlSxaRvpHj@nongnu.org
X-Gm-Message-State: AOJu0Yw5s0jn9eobCwC9IhtnARGJmKaE6E0ZRJIi2Bn9OboyifKJNgrH
 RxN/uzxHjm61sv3UV/4xC9Nt/6RQnA35UX0A+Ux7Ji/6MNKTJHzc+3FA9FkhBHqPYcp18QJMCaz
 RDzwimGhSx3JuwJGfqKNiDEQkqgE=
X-Gm-Gg: ASbGncu6vagM7DK8rrbq0+RnYdic5iAUhWJ6bg4p11/tsaupzgg9F3tC8RFlskmzCLA
 TT4HscrjkusH7z5tjN6c6H+M/OYOluqNVSG7BVhLUAi2XHXsn+Xy1Ndped9+okd+XfcbC33iWpb
 WnBtDafrvhhD0TlUqjXznaZJCeEw==
X-Google-Smtp-Source: AGHT+IHsRMWPy6I3D8YFnYl1eq/EeVv4KDSd9loltaGn36mF9WPJRi0+aFkm6UUm+zdDeOTu9H2SyPgKWmWh95u1MhU=
X-Received: by 2002:a05:6102:809e:b0:4bb:b589:9da5 with SMTP id
 ada2fe7eead31-4bbb5899f31mr3063189137.25.1739160702762; Sun, 09 Feb 2025
 20:11:42 -0800 (PST)
MIME-Version: 1.0
References: <20250205-b4-ctr_upstream_v6-v6-0-439d8e06c8ef@rivosinc.com>
 <CAKmqyKMhV8Nj2oUmD_vWCnZBjJgYcw=8CQ86P2jihy0S09TXTQ@mail.gmail.com>
 <CAECbVCubhhy4y8oJPGiW5r322Uv02oOyKY4e+qWSMFNfbgx8yQ@mail.gmail.com>
In-Reply-To: <CAECbVCubhhy4y8oJPGiW5r322Uv02oOyKY4e+qWSMFNfbgx8yQ@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 10 Feb 2025 14:11:16 +1000
X-Gm-Features: AWEUYZlvs4VoVvSp5zag60rxea99oKXG-u3W5SOUy0jG4zhOAUv8Cwa80zywR-A
Message-ID: <CAKmqyKNaxUn_99=+3EsCiE48Qx+64Lu=ybR1asGscP_UiPxnxw@mail.gmail.com>
Subject: Re: [PATCH v6 0/7] target/riscv: Add support for Control Transfer
 Records Ext.
To: Rajnesh Kanwal <rkanwal@rivosinc.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, alistair.francis@wdc.com, 
 bin.meng@windriver.com, liweiwei@iscas.ac.cn, dbarboza@ventanamicro.com, 
 zhiwei_liu@linux.alibaba.com, atishp@rivosinc.com, apatel@ventanamicro.com, 
 beeman@rivosinc.com, jason.chien@sifive.com, frank.chang@sifive.com, 
 richard.henderson@linaro.org, bmeng.cn@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e31;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe31.google.com
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

On Thu, Feb 6, 2025 at 9:45=E2=80=AFPM Rajnesh Kanwal <rkanwal@rivosinc.com=
> wrote:
>
> On Thu, Feb 6, 2025 at 5:39=E2=80=AFAM Alistair Francis <alistair23@gmail=
.com> wrote:
> >
> > On Wed, Feb 5, 2025 at 9:21=E2=80=AFPM Rajnesh Kanwal <rkanwal@rivosinc=
.com> wrote:
> > >
> > > This series enables Control Transfer Records extension support on ris=
cv
> > > platform. This extension is similar to Arch LBR in x86 and BRBE in AR=
M.
> > > The Extension has been ratified and this series is based on v1.0 [0]
> > >
> > > CTR extension depends on both the implementation of S-mode and Sscsri=
nd
> > > extension v1.0.0 [1]. CTR access ctrsource, ctrtartget and ctrdata CS=
Rs using
> > > sscsrind extension.
> > >
> > > The series is based on Smcdeleg/Ssccfg counter delegation extension [=
2]
> > > patches [3]. CTR itself doesn't depend on counter delegation support.=
 This
> > > rebase is basically to include the Smcsrind patches.
> > >
> > > Here is the link to a quick start guide [4] to setup and run a basic =
perf demo
> > > on Linux to use CTR Ext.
> > >
> > > Qemu patches can be found here:
> > > https://github.com/rajnesh-kanwal/qemu/tree/b4/ctr_upstream_v6
> > >
> > > Opensbi patch can be found here:
> > > https://github.com/rajnesh-kanwal/opensbi/tree/ctr_upstream_v2
> > >
> > > Linux kernel patches can be found here:
> > > https://github.com/rajnesh-kanwal/linux/tree/b4/ctr_upstream_v2
> > >
> > > [0]: https://github.com/riscv/riscv-control-transfer-records/releases=
/tag/v1.0
> > > [1]: https://github.com/riscvarchive/riscv-indirect-csr-access/releas=
es/tag/v1.0.0
> > > [2]: https://github.com/riscvarchive/riscv-smcdeleg-ssccfg/releases/t=
ag/v1.0.0
> > > [3]: https://lore.kernel.org/qemu-riscv/20241203-counter_delegation-v=
4-0-c12a89baed86@rivosinc.com/
> > > [4]: https://github.com/rajnesh-kanwal/linux/wiki/Running-CTR-basic-d=
emo-on-QEMU-RISC%E2%80%90V-Virt-machine
> > >
> > > Signed-off-by: Rajnesh Kanwal <rkanwal@rivosinc.com>
> > > ---
> > > Changelog:
> > > v6: Rebased on latest riscv-to-apply.for-upstream.
> >
> > It should be rebased on
> > https://github.com/alistair23/qemu/tree/riscv-to-apply.next
> >
> > I applied the first 6 patches as they apply cleanly
> >
> > Alistair
> >
>
> Sorry for the inconvenience. Strangely cherry-pick, patch and git am -3
> all seem to work fine but git am seems to be failing.
>
> I looked into the conflict and it looks like am expects
> ISA_EXT_DATA_ENTRY(sstvecd, PRIV_VERSION_1_12_0, has_priv_1_12),
> but gets this in cpu.c.
> ISA_EXT_DATA_ENTRY(ssu64xl, PRIV_VERSION_1_12_0, has_priv_1_12),
>
> I have tried following cmds on top of riscv-to-apply.next and these
> fetch the last patch
> only and apply the last patch perfectly fine.
>
> b4 am -i  -P=3D"-1" 20250205-b4-ctr_upstream_v6-v6-0-439d8e06c8ef@rivosin=
c.com
> git am -3 ./v6_20250205_rkanwal_target_riscv_add_support_for_control_tran=
sfer_records_ext.mbx

The threeway merge is failing for me

>
> If you want I can send v7 as well rebased on top of riscv-to-apply.next.

Yes please :)

Alistair

>
> Thanks
> Rajnesh
>
> > >
> > > v5: Improvements based on Richard Henderson's feedback.
> > >   - Fixed code gen logic to use gen_update_pc() instead of
> > >     tcg_constant_tl().
> > >   - Some function renaming.
> > >   - Rebased onto v4 of counter delegation series.
> > >   - https://lore.kernel.org/qemu-riscv/20241205-b4-ctr_upstream_v3-v5=
-0-60b993aa567d@rivosinc.com/
> > >
> > > v4: Improvements based on Richard Henderson's feedback.
> > >   - Refactored CTR related code generation to move more code into
> > >     translation side and avoid unnecessary code execution in generate=
d
> > >     code.
> > >   - Added missing code in machine.c to migrate the new state.
> > >   - https://lore.kernel.org/r/20241204-b4-ctr_upstream_v3-v4-0-d3ce6b=
ef9432@rivosinc.com
> > >
> > > v3: Improvements based on Jason Chien and Frank Chang's feedback.
> > >   - Created single set of MACROs for CTR CSRs in cpu_bit.h
> > >   - Some fixes in riscv_ctr_add_entry.
> > >   - Return zero for vs/sireg4-6 for CTR 0x200 to 0x2ff range.
> > >   - Improved extension dependency check.
> > >   - Fixed invalid ctrctl csr selection bug in riscv_ctr_freeze.
> > >   - Added implied rules for Smctr and Ssctr.
> > >   - Added missing SMSTATEEN0_CTR bit in mstateen0 and hstateen0 write=
 ops.
> > >   - Some more cosmetic changes.
> > >   - https://lore.kernel.org/qemu-riscv/20241104-b4-ctr_upstream_v3-v3=
-0-32fd3c48205f@rivosinc.com/
> > >
> > > v2: Lots of improvements based on Jason Chien's feedback including:
> > >   - Added CTR recording for cm.jalt, cm.jt, cm.popret, cm.popretz.
> > >   - Fixed and added more CTR extension enable checks.
> > >   - Fixed CTR CSR predicate functions.
> > >   - Fixed external trap xTE bit checks.
> > >   - One fix in freeze function for VS-mode.
> > >   - Lots of minor code improvements.
> > >   - Added checks in sctrclr instruction helper.
> > >   - https://lore.kernel.org/qemu-riscv/20240619152708.135991-1-rkanwa=
l@rivosinc.com/
> > >
> > > v1:
> > >   - https://lore.kernel.org/qemu-riscv/20240529160950.132754-1-rkanwa=
l@rivosinc.com/
> > >
> > > ---
> > > Rajnesh Kanwal (7):
> > >       target/riscv: Remove obsolete sfence.vm instruction
> > >       target/riscv: Add Control Transfer Records CSR definitions.
> > >       target/riscv: Add support for Control Transfer Records extensio=
n CSRs.
> > >       target/riscv: Add support to record CTR entries.
> > >       target/riscv: Add CTR sctrclr instruction.
> > >       target/riscv: machine: Add Control Transfer Record state descri=
ption
> > >       target/riscv: Add support to access ctrsource, ctrtarget, ctrda=
ta regs.
> > >
> > >  target/riscv/cpu.c                             |  26 ++-
> > >  target/riscv/cpu.h                             |  13 ++
> > >  target/riscv/cpu_bits.h                        | 145 ++++++++++++
> > >  target/riscv/cpu_cfg.h                         |   2 +
> > >  target/riscv/cpu_helper.c                      | 266 +++++++++++++++=
+++++++
> > >  target/riscv/csr.c                             | 294 +++++++++++++++=
+++++++++-
> > >  target/riscv/helper.h                          |   2 +
> > >  target/riscv/insn32.decode                     |   2 +-
> > >  target/riscv/insn_trans/trans_privileged.c.inc |  18 +-
> > >  target/riscv/insn_trans/trans_rvi.c.inc        |  75 +++++++
> > >  target/riscv/insn_trans/trans_rvzce.c.inc      |  21 ++
> > >  target/riscv/machine.c                         |  25 +++
> > >  target/riscv/op_helper.c                       |  48 ++++
> > >  target/riscv/tcg/tcg-cpu.c                     |  11 +
> > >  target/riscv/translate.c                       |  46 ++++
> > >  15 files changed, 986 insertions(+), 8 deletions(-)
> > > ---
> > > base-commit: 699291ba7774f1580584cd96f84ceda8cc4edb7e
> > > change-id: 20250205-b4-ctr_upstream_v6-71418cd245ee
> > > --
> > > Best Regards,
> > > Rajnesh Kanwal
> > >
> > >

