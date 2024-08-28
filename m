Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49BD7C54746
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2024 00:12:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sj6Hk-0008G4-FO; Tue, 27 Aug 2024 20:11:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sj6Hi-0008A2-Ih; Tue, 27 Aug 2024 20:11:38 -0400
Received: from mail-vk1-xa32.google.com ([2607:f8b0:4864:20::a32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sj6Hg-0006dz-Jh; Tue, 27 Aug 2024 20:11:38 -0400
Received: by mail-vk1-xa32.google.com with SMTP id
 71dfb90a1353d-4fcefbd6bc4so2296008e0c.1; 
 Tue, 27 Aug 2024 17:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724803895; x=1725408695; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jm4bF/zPz7B/RdINFXriXOM8xgfQId1DhTPSE3weJ2k=;
 b=UAEAPqPt4CWODWw6FMumLHz0JP2yLZyKJ9vE7n4TJ++hi/NBN7sK9K+ollaK/A8nMx
 y5G04kdJV1RpD+E5HAHl/QL38giIE4cwxPBuIxQHH2gB+JqIRNq1H6Rzu1iemGrwAtQ5
 v2dOj2c2BPOgi4eAPgnqd56bgnwcAq8atDXuRySx4CYLQF9TwamdTW9wf2bQtT+FYqul
 RaPxZdshJoFx7xvWAIbjRqjcNgONH94Ep8D5mFz5JlqQDObAmi2lWrfNfB34gAV5rVAj
 vuPhm9U/HDOkbRW/fbBaZlXSGf4eovW3OHMHp8IMiEHIPLizbUAoy2nTOyWCXVOi4EFv
 3LvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724803895; x=1725408695;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jm4bF/zPz7B/RdINFXriXOM8xgfQId1DhTPSE3weJ2k=;
 b=JM1StXZulMofG+qWbPj7/vAox1rYJN+YeINVnEgobW6OF3tamOQ3PepNjCsUHpkT2S
 D8iRE17UV6NmaziVeKhei4lmd3MFJWnaYNKGkUWHyHipACHkTj7lX5a5wePxDabenebd
 8p+8jMxxsP0HwVUPdqzjEjkldSl0xzD+LYdS4QAaf7yXMPpzsfyX6apaPS9zBS6dAR5Z
 EQkIQwmrMH32LlTVaw2hQPoZ/4w9oqRQ6ixOf0upqKR0jDmiU0UyYsjFYoGXeQo0d3a8
 KIQY0pyA1kZJtP2qYoSohSvg95iZItMY0gFQF4a2YIlXi4XkMb8jNndj7hRqzdHrvuLT
 K2Dw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXlhA0AJXicqdAUpqohhT7bHSW7cgEytBZ4MZJEqpnsilamAa0YQSYvtXIQaNXBsp2IHXoKr2Z4aUjG@nongnu.org
X-Gm-Message-State: AOJu0YyW6lg9+hjHIh1nzqeCzEUSL0p5f9FzdUOecLY1Nwc/KIB+5nX0
 d8qyV/DaEHVOxcwZmMeVQmAZsJsUUAWddxrhg+yD7kZucDortWqG9beNkSmGNU45PRIt7HxzrDH
 pTReT6ReIBxDEGmzSc6jUHcRseag=
X-Google-Smtp-Source: AGHT+IEkHe4ZxIFg1c83tcNruHq9ZmEMd7vhnrBASG7gtSk3aLBp3FzJrK+Fijf415/aSxf+1EVRqgKxwpjQluVj44s=
X-Received: by 2002:a05:6122:1d9f:b0:4f5:2276:136d with SMTP id
 71dfb90a1353d-4fef0e96297mr299762e0c.1.1724803895001; Tue, 27 Aug 2024
 17:11:35 -0700 (PDT)
MIME-Version: 1.0
References: <20240827231906.553327-1-debug@rivosinc.com>
 <CAKmqyKPukMM7Q2o01c2Vmmqqhc2+f49FS=wM1oxRQ5mQaq2jAw@mail.gmail.com>
 <Zs5pnnEiEcXpp2YT@debug.ba.rivosinc.com>
In-Reply-To: <Zs5pnnEiEcXpp2YT@debug.ba.rivosinc.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 28 Aug 2024 10:11:08 +1000
Message-ID: <CAKmqyKPNiBWYQuMB2ThxVE8zv29QeTFDMyeb8o5JkO-7g0kizQ@mail.gmail.com>
Subject: Re: [PATCH v10 00/21] riscv support for control flow integrity
 extensions
To: Deepak Gupta <debug@rivosinc.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, palmer@dabbelt.com, 
 Alistair.Francis@wdc.com, laurent@vivier.eu, bmeng.cn@gmail.com, 
 liwei1518@gmail.com, dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, 
 jim.shu@sifive.com, andy.chiu@sifive.com, kito.cheng@sifive.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a32;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa32.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Wed, Aug 28, 2024 at 10:04=E2=80=AFAM Deepak Gupta <debug@rivosinc.com> =
wrote:
>
> On Wed, Aug 28, 2024 at 10:02:42AM +1000, Alistair Francis wrote:
> >On Wed, Aug 28, 2024 at 9:21=E2=80=AFAM Deepak Gupta <debug@rivosinc.com=
> wrote:
> >>
> >> v10 for riscv zicfilp and zicfiss extensions support in qemu.
> >
> >Please specify the exact version of the spec you used
>
> https://github.com/riscv/riscv-cfi/releases/download/v1.0/riscv-cfi.pdf

Great! Include that in the cover letter please

Alistair

>
> >
> >Alistair
> >
> >>
> >> Links for previous versions
> >> [1] - v1 https://lists.nongnu.org/archive/html/qemu-devel/2024-07/msg0=
6017.html
> >> [2] - v2 https://lore.kernel.org/all/ed23bcbc-fdc4-4492-803c-daa958803=
75a@linaro.org/T/
> >> [3] - v3 https://lists.nongnu.org/archive/html/qemu-devel/2024-08/msg0=
1005.html
> >> [4] - v4 https://lore.kernel.org/all/20240816010711.3055425-6-debug@ri=
vosinc.com/T/
> >> [5] - v5
> >> +https://lore.kernel.org/all/20240820000129.3522346-1-debug@rivosinc.c=
om/T/#m7b9cc847e739ec86f9569a3ca9f3d9377b01e21
> >> [6] - v6 https://mail.gnu.org/archive/html/qemu-riscv/2024-08/msg00418=
.html
> >> [7] - v7 https://lore.kernel.org/all/20240822082504.3979610-1-debug@ri=
vosinc.com/
> >> [8] - v8 https://lore.kernel.org/all/20240823190140.4156920-1-debug@ri=
vosinc.com/T/
> >> [9] - v9 https://lore.kernel.org/all/20240826152949.294506-1-debug@riv=
osinc.com/
> >>
> >> ---
> >> v10:
> >>    - Exposed *envcfg CSR and priv to qemu-user as well and removed spe=
cial
> >>      state management for *envcfg related feature enabling for qemu-us=
er
> >>    - Exposing zicfilp and zicfiss as different patch
> >> v9:
> >>    - fix switch case fallthrough for sw_check excp in patch 4
> >> v8:
> >>    - fixed up `gen_cmpxchg` to store extra word2 during compile to rai=
se storeAMO always
> >> v7:
> >>    - Updated decode_save_opc to take extra argument of excp_uw2 and
> >>      updated callsites
> >>    - added a helper for promoting load faults to store faults
> >>    - Removed stale comments and edited existed comments
> >> v6:
> >>    - Added support extra store word 2 for tcg compile and extraction d=
uring unwind
> >>    - Using extra word, AMO instructions and shadow stack instructions =
can raise store fault
> >>    - some alignment and cosmetic changes
> >>    - added vmstate migration support for elp and ssp cpu state
> >> v5:
> >>    - Simplified elp tracking and lpad implementation as per suggestion=
 by richard
> >>    - Simplified shadow stack mmu checks as per suggestion by richard
> >>    - Converged zicfiss compressed and non-comressed instructions to sa=
me translation
> >>    - Removed trace hooks. Don't need for upstream.
> >>
> >> v4:
> >>    - elp state in cpu is true/false instead of enum and elp cleared
> >>      unconditionally on trap entry. elp in *status cleared uncondition=
ally on
> >>      trap return.
> >>    - Moved logic for branch tracking in instruction translation from t=
b_start.
> >>    - fixed zicfiss dependency on 'A'
> >>    - `cpu_get_fcfien/bcfien` helpers checks fixed to check for extensi=
on first.
> >>    - removed trace hook enums. Instead added dedicated trace helpers w=
herever needed.
> >>    - fixed/simplified instruction format in decoder for lpad, sspush, =
sspopchk
> >>    - simplified tlb index logic for shadow stack instructions. Removed=
 SUM TB_FLAG
> >>    - access to ssp CSR is gated on `cpu_get_bcfien` instead of duplica=
ted logic
> >>    - removed vDSO related changes for now.
> >> v3:
> >>    - Removed prctl specific patches because they need to be upstream
> >>      in kernel first.
> >>    - As suggested by Richard, added TB flag if fcfi enabled
> >>    - Re-worked translation for landing pad and shadow stack instructio=
ns
> >>      to not require helper.
> >>    - tcg helpers only for cfi violation cases so that trace hooks can =
be
> >>      placed.
> >>    - Style changes.
> >>    - fixes assert condition in accel/tcg
> >>
> >> v2:
> >>    - added missed file (in v1) for shadow stack instructions implement=
ation.
> >>
> >> Deepak Gupta (21):
> >>   target/riscv: expose *envcfg csr and priv to qemu-user as well
> >>   linux-user/riscv: set priv for qemu-user and defaults for *envcfg
> >>   target/riscv: Add zicfilp extension
> >>   target/riscv: Introduce elp state and enabling controls for zicfilp
> >>   target/riscv: save and restore elp state on priv transitions
> >>   target/riscv: additional code information for sw check
> >>   target/riscv: tracking indirect branches (fcfi) for zicfilp
> >>   target/riscv: zicfilp `lpad` impl and branch tracking
> >>   disas/riscv: enable `lpad` disassembly
> >>   target/riscv: Expose zicfilp extension as a cpu property
> >>   target/riscv: Add zicfiss extension
> >>   target/riscv: introduce ssp and enabling controls for zicfiss
> >>   target/riscv: tb flag for shadow stack  instructions
> >>   target/riscv: mmu changes for zicfiss shadow stack protection
> >>   target/riscv: AMO operations always raise store/AMO fault
> >>   target/riscv: update `decode_save_opc` to store extra word2
> >>   target/riscv: implement zicfiss instructions
> >>   target/riscv: compressed encodings for sspush and sspopchk
> >>   disas/riscv: enable disassembly for zicfiss instructions
> >>   disas/riscv: enable disassembly for compressed sspush/sspopchk
> >>   target/riscv: Expose zicfiss extension as a cpu property
> >>
> >>  disas/riscv.c                                 |  77 ++++++++-
> >>  disas/riscv.h                                 |   4 +
> >>  linux-user/riscv/cpu_loop.c                   |   4 +
> >>  target/riscv/cpu.c                            |  10 ++
> >>  target/riscv/cpu.h                            |  31 +++-
> >>  target/riscv/cpu_bits.h                       |  17 ++
> >>  target/riscv/cpu_cfg.h                        |   2 +
> >>  target/riscv/cpu_helper.c                     | 155 +++++++++++++++++=
-
> >>  target/riscv/cpu_user.h                       |   1 +
> >>  target/riscv/csr.c                            |  84 ++++++++++
> >>  target/riscv/insn16.decode                    |   4 +
> >>  target/riscv/insn32.decode                    |  26 ++-
> >>  .../riscv/insn_trans/trans_privileged.c.inc   |   8 +-
> >>  target/riscv/insn_trans/trans_rva.c.inc       |  43 ++++-
> >>  target/riscv/insn_trans/trans_rvd.c.inc       |   4 +-
> >>  target/riscv/insn_trans/trans_rvf.c.inc       |   4 +-
> >>  target/riscv/insn_trans/trans_rvh.c.inc       |   8 +-
> >>  target/riscv/insn_trans/trans_rvi.c.inc       |  61 ++++++-
> >>  target/riscv/insn_trans/trans_rvvk.c.inc      |  10 +-
> >>  target/riscv/insn_trans/trans_rvzacas.c.inc   |   4 +-
> >>  target/riscv/insn_trans/trans_rvzfh.c.inc     |   4 +-
> >>  target/riscv/insn_trans/trans_rvzicfiss.c.inc |  75 +++++++++
> >>  target/riscv/insn_trans/trans_svinval.c.inc   |   6 +-
> >>  target/riscv/internals.h                      |   3 +
> >>  target/riscv/machine.c                        |  38 +++++
> >>  target/riscv/op_helper.c                      |  18 ++
> >>  target/riscv/pmp.c                            |   5 +
> >>  target/riscv/pmp.h                            |   3 +-
> >>  target/riscv/tcg/tcg-cpu.c                    |  25 +++
> >>  target/riscv/translate.c                      |  45 ++++-
> >>  30 files changed, 726 insertions(+), 53 deletions(-)
> >>  create mode 100644 target/riscv/insn_trans/trans_rvzicfiss.c.inc
> >>
> >> --
> >> 2.44.0
> >>
> >>

