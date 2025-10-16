Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 996CACCD185
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 03:31:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9EhH-0005RS-GS; Wed, 15 Oct 2025 23:30:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v9EhF-0005RG-NW
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 23:30:33 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v9EhD-0006Oa-C6
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 23:30:33 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-63c1006fdcfso63063a12.2
 for <qemu-devel@nongnu.org>; Wed, 15 Oct 2025 20:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760585428; x=1761190228; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YJpyq+XEzOePN/A/RAKSPFoo07S7LQUxptorHZ+zlQM=;
 b=SCUqKhpQO3kRsRPvtmSeFRAtJjPTJz5avK0yOwPN8Eo43+ltNESJ7Jqhrh07o+IdDH
 Iq+Z6A4MHSaC4jVjX3iOe/fyg43HtSRhqxJwxIVfSbSpaIro+aw+nWLROMT5JtUvBQ9x
 hagKgI7yWmRqbS8zV0zniKJMmLAN+xYM7SYsGNtk4oXiaG56CoCZdLOgcre48cVSZZnm
 TwV/+2O6gL31KZjwQqJgNg5fRs9cudRNY+HQlQcTD62RLvk+lgOBNirPs7q/1+95fpcP
 /pKv18psuFmlRa1mlQ1scGNl+cIPy1tj2L9yYersi8CgbOkN6C9/5iuCnHnSzwfGUMO7
 m2OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760585428; x=1761190228;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YJpyq+XEzOePN/A/RAKSPFoo07S7LQUxptorHZ+zlQM=;
 b=Luer2rdtAK0QzdaW2UWRho//tgHQcpbnApOOnmoqQPM09uMgf0xoJRH62XlUGHGH0w
 jnbAotbfBnQ54Qoe2cui4K30ku6cmjyyrV/yJ2OYmforqXCP0Zu5Sg+K0MR0nUvnIhfX
 Bv+fBTiUDsGWpxFA7NH5IasRlj2LHY3aJwZ8Zc+HvSSOQxQplAJ99AOzp0TEbIOQqteS
 ak33rvN+h7RaDn8ty1O7hrxRopYUP/jZH6V2qJEsuvl1EuhpdSZzK8OvbjxMMOQtwxxo
 CF65+8g6r62aiNKnCgnTaI1PFapL/jZ5TZFQKih1ZLTL+9CKI5ibAqA/NztEVuiuaiRP
 xVnw==
X-Gm-Message-State: AOJu0YwB2Zd2kGDyVP86Qv7BPmKbv4qpRZES+Q0zEwaMUQRv0HjQ7hGx
 MGMLSdj/2w/JLDQim2Hvug3U+lhU6YwamXOIIJQg1bMBuqgvp0CTrzpMq+x3+4lLGNaPjjAfs/W
 tL/1Xyt7sHAEiFahASBxi48jcFpz3Ob8=
X-Gm-Gg: ASbGncvJxT8BAd96yj64PX/nLtPuquZbH8gLZUqPJQW07+2eOV8YHpoyieF+JD4nH8M
 qxRywCkpT9GpQqa1U3X3dDsCWUyJfl0y5UourWpXxr8iEvl66jauMfT6vOuiaPfCMfhH/hv8Vms
 5GGc+B80NVR+GRy/Mwiww5YKLDY+Dv2z/5i3DOqNL5BijQdvPVXPFITUVpUzvok0W6Ppe1MDDCr
 VcYjLU0VZVaxaejwNSh+gnA+D7W1i/msXbUuv3a4dvj4bkylG6MA5HYYhuSUni/bodQseYf/zGR
 mqhvM7y/hIpX7w8=
X-Google-Smtp-Source: AGHT+IHlFivv+EDybMJNIeMxmun2t0GQMkcZw7BN0xDAumOxIebS95ebYZdQg7XBNqzo9L0yex01hAj73r2e8DLmbI4=
X-Received: by 2002:a05:6402:84f:b0:631:cc4f:2ff5 with SMTP id
 4fb4d7f45d1cf-639d5c5a788mr28383200a12.25.1760585427922; Wed, 15 Oct 2025
 20:30:27 -0700 (PDT)
MIME-Version: 1.0
References: <20251014203512.26282-1-anjo@rev.ng>
In-Reply-To: <20251014203512.26282-1-anjo@rev.ng>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 16 Oct 2025 13:30:01 +1000
X-Gm-Features: AS18NWB_7phHHPH8zF5ej6bsW1YpP4be8g_tFnh8YQylqyl9h1k71f82SxMBWHo
Message-ID: <CAKmqyKOviCFNk_ShuOsk6nvgYudPmrKSGK3cAoeGoFC4mR1adA@mail.gmail.com>
Subject: Re: [PATCH v3 00/34] single-binary: Make riscv cpu.h target
 independent
To: Anton Johansson <anjo@rev.ng>
Cc: qemu-devel@nongnu.org, pierrick.bouvier@linaro.org, philmd@linaro.org, 
 alistair.francis@wdc.com, palmer@dabbelt.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x529.google.com
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

On Wed, Oct 15, 2025 at 6:34=E2=80=AFAM Anton Johansson via
<qemu-devel@nongnu.org> wrote:
>
> Hi,
>
> this is a first patchset moving towards single-binary support for riscv.
> Additional patchsets for hw/ and target/ are based on this one so it's
> best to make sure the approach taken is ok.  Most patches in this set
> concern fields in CPUArchState which are either widened (usually to
> uint64_t) or fixed to a smaller size which handles all use cases.
>
> General purpose registers and fields mapped to TCG are dealt with by
> widening the type and applying an offset to tcg_global_mem_new() to
> correctly handle 32-bit targets on big endian hosts.
>
> Quick question to correct my understanding. AFAICT riscv64-softmmu is a
> superset of riscv32-softmmu which handles 32-, 64, and 128-bit ISAs, so
> concerning single-binary do we for the time being only need to support
> riscv64-softmmu?

That's correct, the idea is that someone can use riscv64-softmmu for
32, 64 and 128 bit CPUs.

So in theory we could remove riscv32-softmmu today and not break
anything (obviously it would break a lot due to the name and argument
changes required, but you get the point).

I don't think many people are using riscv64-softmmu with 32-bit CPUs,
so it's possible there are bugs where we accidently expose the wrong
thing, but the idea is there and we should work on fixing those.

Alistair

>
> Let me know what you think of the direction taken here and if you would
> prefer something else.
>
> Patches 4, 5, and 10 still in need of review.
>
> Changes in v2:
>   - Use BIT() to define misa extension bits in "Use 32 bits for misa
>     extensions";
>
>   - Squash "Fix size of mcause" into "Fix size of trivial CPUArchState
>     fields";
>
>   - Bump VMSTATE version_id and minimum_version_id for "cpu/pmp/entry",
>     "cpu/pmp", "cpu/hyper", "cpu/vector", "cpu/rv128", "cpu/debug",
>     "cpu/envcfg", "cpu/pmu", "cpu/jvt", "cpu/ssp", and "cpu".  Migration
>     from older versions is broken.
>
> Changes in v3:
>   - Fix formatting issues during printing;
>
>   - Move assert before extract64() in pmu_read_ctr();
>
>   - Added patch 5/34 fixing a bug in rmw_cd_ctr_cfg() where bit 30 is
>     zeroed instead of bit 62 (MHPMEVENTH_* vs MHPMEVENT_*);
>
>   - Added privilege_mode_t typedef for storing PRV_* fields;
>
>   - Added reviewed-bys.
>
> Anton Johansson (34):
>   target/riscv: Use 32 bits for misa extensions
>   target/riscv: Fix size of trivial CPUArchState fields
>   target/riscv: Fix size of mhartid
>   target/riscv: Bugfix riscv_pmu_ctr_get_fixed_counters_val()
>   target/riscv: Bugfix make bit 62 read-only 0 for sireg* cfg CSR read
>   target/riscv: Combine mhpmevent and mhpmeventh
>   target/riscv: Combine mcyclecfg and mcyclecfgh
>   target/riscv: Combine minstretcfg and minstretcfgh
>   target/riscv: Combine mhpmcounter and mhpmcounterh
>   target/riscv: Fix size of gpr and gprh
>   target/riscv: Fix size of vector CSRs
>   target/riscv: Fix size of pc, load_[val|res]
>   target/riscv: Fix size of frm and fflags
>   target/riscv: Fix size of badaddr and bins
>   target/riscv: Fix size of guest_phys_fault_addr
>   target/riscv: Fix size of priv_ver and vext_ver
>   target/riscv: Fix size of retxh
>   target/riscv: Fix size of ssp
>   target/riscv: Fix size of excp_uw2
>   target/riscv: Fix size of sw_check_code
>   target/riscv: Fix size of priv
>   target/riscv: Fix size of gei fields
>   target/riscv: Fix size of [m|s|vs]iselect fields
>   target/riscv: Fix arguments to board IMSIC emulation callbacks
>   target/riscv: Fix size of irq_overflow_left
>   target/riscv: Indent PMUFixedCtrState correctly
>   target/riscv: Replace target_ulong in riscv_cpu_get_trap_name()
>   target/riscv: Replace target_ulong in riscv_ctr_add_entry()
>   target/riscv: Fix size of trigger data
>   target/riscv: Fix size of mseccfg
>   target/riscv: Move debug.h include away from cpu.h
>   target/riscv: Move CSR declarations to separate csr.h header
>   target/riscv: Introduce externally facing CSR access functions
>   target/riscv: Make pmp.h target_ulong agnostic
>
>  target/riscv/cpu.h                            | 349 +++++++-----------
>  target/riscv/csr.h                            |  93 +++++
>  target/riscv/debug.h                          |   2 -
>  target/riscv/pmp.h                            |  20 +-
>  hw/intc/riscv_imsic.c                         |  34 +-
>  hw/riscv/riscv_hart.c                         |   7 +-
>  linux-user/riscv/signal.c                     |   5 +-
>  target/riscv/cpu.c                            |  10 +-
>  target/riscv/cpu_helper.c                     |  42 +--
>  target/riscv/csr.c                            | 290 ++++++++-------
>  target/riscv/debug.c                          |   1 +
>  target/riscv/fpu_helper.c                     |   6 +-
>  target/riscv/gdbstub.c                        |   1 +
>  target/riscv/kvm/kvm-cpu.c                    |   1 +
>  target/riscv/machine.c                        | 177 +++++----
>  target/riscv/op_helper.c                      |   1 +
>  target/riscv/pmp.c                            |  14 +-
>  target/riscv/pmu.c                            | 150 ++------
>  target/riscv/riscv-qmp-cmds.c                 |   3 +-
>  target/riscv/tcg/tcg-cpu.c                    |   3 +-
>  target/riscv/th_csr.c                         |   1 +
>  target/riscv/translate.c                      |  53 ++-
>  target/riscv/vector_helper.c                  |  22 +-
>  .../riscv/insn_trans/trans_privileged.c.inc   |   2 +-
>  target/riscv/insn_trans/trans_rvi.c.inc       |  16 +-
>  target/riscv/insn_trans/trans_rvm.c.inc       |  16 +-
>  target/riscv/insn_trans/trans_rvv.c.inc       |  24 +-
>  target/riscv/insn_trans/trans_rvzicfiss.c.inc |  22 +-
>  28 files changed, 685 insertions(+), 680 deletions(-)
>  create mode 100644 target/riscv/csr.h
>
> --
> 2.51.0
>
>

