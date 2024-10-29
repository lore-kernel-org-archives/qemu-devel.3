Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 150F9D5B874
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2024 04:35:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5dvr-0008QZ-HL; Tue, 29 Oct 2024 00:34:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1t5dvo-0008Q7-TI; Tue, 29 Oct 2024 00:34:12 -0400
Received: from mail-vk1-xa30.google.com ([2607:f8b0:4864:20::a30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1t5dvm-0006A8-Pg; Tue, 29 Oct 2024 00:34:12 -0400
Received: by mail-vk1-xa30.google.com with SMTP id
 71dfb90a1353d-50d3998923dso1732327e0c.2; 
 Mon, 28 Oct 2024 21:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730176449; x=1730781249; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DdNd8yOubO9T6h70jd4OCCmA2tfnx3t3HJcONktET14=;
 b=FFDH7fZRGCw8zFTvuaTWwprsr9eujyTqbG982uUGti5RfHPTc4l/yXbpqdPQGBC29z
 PLjY4wlYH1pXkqMUqeKk6VaPxdkBQQNoioY9ZvV7CNRg38WYW8Mn+qbb2w/xG/WvkqNK
 spXr2mxzk3fEvTjbHezY6IYBkljvdUoT5oXzhbSBfHVCxp9O7gLdRgKPqFTxhm3A8Dr9
 4eH3v/08+QL9tcjDR0Jo6fzzkh/6FfoY2hE0BOyJoGHoJPran8ottFGksNzTByZHQmE9
 frlWcm9RAqfY/UDto8LYUPq1MrtdF+NzHtAgcsED/g8hMuVsW51a7TpMr357ZvsZ7c7z
 9G+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730176449; x=1730781249;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DdNd8yOubO9T6h70jd4OCCmA2tfnx3t3HJcONktET14=;
 b=Fz/HoNEzs1KvQE5Ba/5kvFwlQugRc9SK/HXa00bxvwF+Y3YtoP4MRgvTabXYznuA7v
 naQTk75wotAkFd0+eeO9CLnLaOjTSgMoLQyZo5XflHjE0qTmObyfVW/hfgdtt938oROz
 EA7H0tn7Xlt19xe4j79mUNy0hTz0WE5Ce7qlGgEtAOzqp+rXN41xLSupz8sgyKrcsCx7
 tuKi2Nhdy/YHouQEYdXkC094EJUYubkOTfPDslAfrGz682bWQKjvXZJ4T6ApbTWrdxeC
 3MqrUN3Kpc2S2SGqzC6ac2x1K3OCdIapmtZPC8YkYggWjCQoHsy4GDq6b4JlXJBMKRW9
 NWXg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW33DS5Zr2zspsdrq3X1ti7cAEqA6J8JXxtN5pi7OjWCIqS1tDaTW29Go5A/0O8uRtG4s/y9Fm6KQ9q@nongnu.org
X-Gm-Message-State: AOJu0YyyCIs48GSyDGh4lBEoe1AGZb8t4Tfst29bd2mDnkiF9qAhmSRT
 aCBHy9l2pp24aYT+TMe6xZ+b0JOERfZ/G61CQMH9N4ozU7jUaFJpJ2YRxhHJtkfs+lb1D/RXrjb
 SjL+gYsMIGn34GNygJxNPVS+J9HM=
X-Google-Smtp-Source: AGHT+IHbf7vR74dCv+JK4VTtVgkbvdMs4uaFVifEMIReE5ZNXXgobym/B3hh3TP2UIe+Tp07KiRZ22L6hdURxttcO80=
X-Received: by 2002:a05:6122:3109:b0:501:2556:1cd9 with SMTP id
 71dfb90a1353d-510150e3d35mr7300818e0c.10.1730176449033; Mon, 28 Oct 2024
 21:34:09 -0700 (PDT)
MIME-Version: 1.0
References: <20241008225010.1861630-1-debug@rivosinc.com>
In-Reply-To: <20241008225010.1861630-1-debug@rivosinc.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 29 Oct 2024 14:33:43 +1000
Message-ID: <CAKmqyKN2bha6wmu7O7mZF50Y7ZYTxbxc6w0_sfoRG=ErDf-Y8w@mail.gmail.com>
Subject: Re: [PATCH v16 00/20] riscv support for control flow integrity
 extensions
To: Deepak Gupta <debug@rivosinc.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, palmer@dabbelt.com, 
 Alistair.Francis@wdc.com, bmeng.cn@gmail.com, liwei1518@gmail.com, 
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, jim.shu@sifive.com, 
 kito.cheng@sifive.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a30;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa30.google.com
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

On Wed, Oct 9, 2024 at 8:52=E2=80=AFAM Deepak Gupta <debug@rivosinc.com> wr=
ote:
>
> v16 for riscv zicfilp and zicfiss extensions support in qemu.
>
> Following change in this version:
> cache block operations of clean, flush and inval have store semantics.
> These operations on shadow stack must look like regular stores and must
> always raise store/AMO access fault. However with current logic,
> `probe_access_flags` will succeed because it will be seen as a load.
> In order to prevent that `get_physical_address` must receive `probe`
> parameter. Depending on that parameter, `get_physical_address` can return
> TRANSLATE_PMP_FAIL.
>
> In v15, this was created as a new commit so that we could review and disc=
uss
> it out. In this version, I've squashed it with "mmu changes for zicfiss s=
hadow
> stack protection".
>
> zicfilp and zicfiss spec pdf
> ----------------------------
> https://github.com/riscv/riscv-cfi/releases/download/v1.0/riscv-cfi.pdf
>
> github sources to spec
> https://github.com/riscv/riscv-cfi

Thanks!

Applied to riscv-to-apply.next

Alistair

>
>
> Links for previous versions
> [1] - v1 https://lists.nongnu.org/archive/html/qemu-devel/2024-07/msg0601=
7.html
> [2] - v2 https://lore.kernel.org/all/ed23bcbc-fdc4-4492-803c-daa95880375a=
@linaro.org/T/
> [3] - v3 https://lists.nongnu.org/archive/html/qemu-devel/2024-08/msg0100=
5.html
> [4] - v4 https://lore.kernel.org/all/20240816010711.3055425-6-debug@rivos=
inc.com/T/
> [5] - v5
> +https://lore.kernel.org/all/20240820000129.3522346-1-debug@rivosinc.com/=
T/#m7b9cc847e739ec86f9569a3ca9f3d9377b01e21
> [6] - v6 https://mail.gnu.org/archive/html/qemu-riscv/2024-08/msg00418.ht=
ml
> [7] - v7 https://lore.kernel.org/all/20240822082504.3979610-1-debug@rivos=
inc.com/
> [8] - v8 https://lore.kernel.org/all/20240823190140.4156920-1-debug@rivos=
inc.com/T/
> [9] - v9 https://lore.kernel.org/all/20240826152949.294506-1-debug@rivosi=
nc.com/
> [10]- v10 https://lore.kernel.org/all/20240827231906.553327-1-debug@rivos=
inc.com/
> [11]- v11 https://lore.kernel.org/all/20240828174739.714313-1-debug@rivos=
inc.com/
> [12]- v12 https://lore.kernel.org/all/20240829233425.1005029-1-debug@rivo=
sinc.com/
> [13]- v14 https://lore.kernel.org/all/20240912235320.3768582-1-debug@rivo=
sinc.com/
> [14]- v15 https://lore.kernel.org/all/20241003183342.679249-1-debug@rivos=
inc.com/
>
> ---
> v16:
>    - Squashed changes with respect to "disallow probe access" to shadow s=
tack
>      from cbo.clean/flush/inval flows with "shadow stack mmu" changes
> v15:
>    - Extended `get_physical_address` to take `probe` parameter. This is t=
o ensure
>      that cbo.clean/flush/inval accesses to shadow stack always lead to s=
tore/AMO
>      access fault
>
> v14:
>    - Rebased on https://github.com/alistair23/qemu/blob/riscv-to-apply.ne=
xt
> v13:
>    - Fixed bug(s) reported by richard that
>          - shadow stack doesn't exist in M-mode
>          - shadow stack is not available in M + U only config
>    - updated commit messages with removal of `ufcfien` and `ubcfien` ment=
ions
> v12
>    - Moved ssamoswap to trans_rvzicfiss.
>    - Fixed bcfi_enabled in disascontext to rely only on tb flag
>    - added comment on why PMP_TRANSLATE_FAIL for stores on shadow stack p=
age
>
> v11:
>    - default *envcfg and priv for qemu-user are handled in `riscv_cpu_res=
et_hold`
> v10:
>    - Exposed *envcfg CSR and priv to qemu-user as well and removed specia=
l
>      state management for *envcfg related feature enabling for qemu-user
>    - Exposing zicfilp and zicfiss as different patch
> v9:
>    - fix switch case fallthrough for sw_check excp in patch 4
> v8:
>    - fixed up `gen_cmpxchg` to store extra word2 during compile to raise =
storeAMO always
> v7:
>    - Updated decode_save_opc to take extra argument of excp_uw2 and
>      updated callsites
>    - added a helper for promoting load faults to store faults
>    - Removed stale comments and edited existed comments
> v6:
>    - Added support extra store word 2 for tcg compile and extraction duri=
ng unwind
>    - Using extra word, AMO instructions and shadow stack instructions can=
 raise store fault
>    - some alignment and cosmetic changes
>    - added vmstate migration support for elp and ssp cpu state
> v5:
>    - Simplified elp tracking and lpad implementation as per suggestion by=
 richard
>    - Simplified shadow stack mmu checks as per suggestion by richard
>    - Converged zicfiss compressed and non-comressed instructions to same =
translation
>    - Removed trace hooks. Don't need for upstream.
>
> v4:
>    - elp state in cpu is true/false instead of enum and elp cleared
>      unconditionally on trap entry. elp in *status cleared unconditionall=
y on
>      trap return.
>    - Moved logic for branch tracking in instruction translation from tb_s=
tart.
>    - fixed zicfiss dependency on 'A'
>    - `cpu_get_fcfien/bcfien` helpers checks fixed to check for extension =
first.
>    - removed trace hook enums. Instead added dedicated trace helpers wher=
ever needed.
>    - fixed/simplified instruction format in decoder for lpad, sspush, ssp=
opchk
>    - simplified tlb index logic for shadow stack instructions. Removed SU=
M TB_FLAG
>    - access to ssp CSR is gated on `cpu_get_bcfien` instead of duplicated=
 logic
>    - removed vDSO related changes for now.
> v3:
>    - Removed prctl specific patches because they need to be upstream
>      in kernel first.
>    - As suggested by Richard, added TB flag if fcfi enabled
>    - Re-worked translation for landing pad and shadow stack instructions
>      to not require helper.
>    - tcg helpers only for cfi violation cases so that trace hooks can be
>      placed.
>    - Style changes.
>    - fixes assert condition in accel/tcg
>
> v2:
>    - added missed file (in v1) for shadow stack instructions implementati=
on.
>
> Deepak Gupta (20):
>   target/riscv: expose *envcfg csr and priv to qemu-user as well
>   target/riscv: Add zicfilp extension
>   target/riscv: Introduce elp state and enabling controls for zicfilp
>   target/riscv: save and restore elp state on priv transitions
>   target/riscv: additional code information for sw check
>   target/riscv: tracking indirect branches (fcfi) for zicfilp
>   target/riscv: zicfilp `lpad` impl and branch tracking
>   disas/riscv: enable `lpad` disassembly
>   target/riscv: Expose zicfilp extension as a cpu property
>   target/riscv: Add zicfiss extension
>   target/riscv: introduce ssp and enabling controls for zicfiss
>   target/riscv: tb flag for shadow stack  instructions
>   target/riscv: mmu changes for zicfiss shadow stack protection
>   target/riscv: AMO operations always raise store/AMO fault
>   target/riscv: update `decode_save_opc` to store extra word2
>   target/riscv: implement zicfiss instructions
>   target/riscv: compressed encodings for sspush and sspopchk
>   disas/riscv: enable disassembly for zicfiss instructions
>   disas/riscv: enable disassembly for compressed sspush/sspopchk
>   target/riscv: Expose zicfiss extension as a cpu property
>
>  disas/riscv.c                                 |  77 +++++++-
>  disas/riscv.h                                 |   4 +
>  target/riscv/cpu.c                            |  14 ++
>  target/riscv/cpu.h                            |  31 ++-
>  target/riscv/cpu_bits.h                       |  17 ++
>  target/riscv/cpu_cfg.h                        |   2 +
>  target/riscv/cpu_helper.c                     | 184 ++++++++++++++++--
>  target/riscv/cpu_user.h                       |   1 +
>  target/riscv/csr.c                            |  84 ++++++++
>  target/riscv/insn16.decode                    |   4 +
>  target/riscv/insn32.decode                    |  26 ++-
>  .../riscv/insn_trans/trans_privileged.c.inc   |   8 +-
>  target/riscv/insn_trans/trans_rva.c.inc       |   4 +-
>  target/riscv/insn_trans/trans_rvd.c.inc       |   4 +-
>  target/riscv/insn_trans/trans_rvf.c.inc       |   4 +-
>  target/riscv/insn_trans/trans_rvh.c.inc       |   8 +-
>  target/riscv/insn_trans/trans_rvi.c.inc       |  61 +++++-
>  target/riscv/insn_trans/trans_rvvk.c.inc      |  10 +-
>  target/riscv/insn_trans/trans_rvzacas.c.inc   |   4 +-
>  target/riscv/insn_trans/trans_rvzfh.c.inc     |   4 +-
>  target/riscv/insn_trans/trans_rvzicfiss.c.inc | 114 +++++++++++
>  target/riscv/insn_trans/trans_svinval.c.inc   |   6 +-
>  target/riscv/internals.h                      |   3 +
>  target/riscv/machine.c                        |  38 ++++
>  target/riscv/op_helper.c                      |  17 ++
>  target/riscv/pmp.c                            |   5 +
>  target/riscv/pmp.h                            |   3 +-
>  target/riscv/tcg/tcg-cpu.c                    |  29 +++
>  target/riscv/translate.c                      |  44 ++++-
>  29 files changed, 749 insertions(+), 61 deletions(-)
>  create mode 100644 target/riscv/insn_trans/trans_rvzicfiss.c.inc
>
> --
> 2.45.0
>
>

