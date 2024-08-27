Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 970F0C5472D
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2024 02:45:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1simCu-0001UJ-Lu; Mon, 26 Aug 2024 22:45:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1simCs-0001Ls-Q2; Mon, 26 Aug 2024 22:45:18 -0400
Received: from mail-ua1-x92b.google.com ([2607:f8b0:4864:20::92b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1simCp-0006V4-OO; Mon, 26 Aug 2024 22:45:17 -0400
Received: by mail-ua1-x92b.google.com with SMTP id
 a1e0cc1a2514c-842fe71877cso1265125241.3; 
 Mon, 26 Aug 2024 19:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724726712; x=1725331512; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LStGmla/704quX8uCAcuU+jM0z/5AmT7uG7MzwyRlRk=;
 b=iGXIfOH8PjINNLrHyFI2MPh2jKLZqIE74heHsecDo0JExKVeWi5GXtjsjxoSuy0S90
 cH/8Z8+ix+UAU1kiOrVQ4HHaFVyyO/lOLMalTUcnXpoU3dUTH7cLRmVsMqMnlaDg7mjm
 pMTG21HC8+TX4rHZp/rOxnrBQDh41gpbcM5iylE4hCvr85gT40KZ5MnCdW9qyt9Ap/Sx
 7zohyrXiVbmhVecVds9w7qSK4Bx+E8DwqJq2+e7T9HqQadMDseO5Tp3qkd5q7R3aFJqW
 j+ZcMM9VI72Gkv3fhstjfN8lP3g8nVb9sGhGyqbL3/ZlKVvXJrbY/rGhwY/YKGNgm6YG
 AP6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724726712; x=1725331512;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LStGmla/704quX8uCAcuU+jM0z/5AmT7uG7MzwyRlRk=;
 b=hbCkQ9A9AjR58A6cFAch7OaKuBNoutSahtdthXIXp7JckcPkQREs4yJqlMyXIB36eK
 2fkMixHilNJHbsFiHIbhyT/WotS/r/MTUrlcXkajb6OzwcW8L1hGW6fvgt1E5RzOYfYe
 dIM6jexaVUgtlK0vJKNhUSSISXVUgk5FdmaX/t9h26D+pQK6twaGF/kY9VCTiGHyhBP8
 FBpfsJ3uyFvERXlhBe3apI2n8nL2FzzDc5EPlp2UTwsm+0jRkqUQJQ71Ulj1Odz3vL0f
 SYI0UOSwUr6cXlP0eV9V4wRd9noF9rFcRndvGpsjs0k1sYmE2dCL+UHZzvmNNbLuh4ah
 V5tA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV8JC8gIp3ZAMhWGAYKchehCyAqBV7uEgpVzhugDmqnJZP/GkMPKGhPa63BWTpgnaihxJjWnYZNC+Dh@nongnu.org
X-Gm-Message-State: AOJu0Yx+yngZ9/ASGv05GOlJ35DTsxQkEE9LmtmXkNs8vVI5TsJq2ZvS
 XgQgrNKYXrRnNeGtD35+6BWsycDSRDflmGighZTHH1m121txbSvHPljD/qS4rDz/c4cAmLJoLWI
 fsmyGv1GC8fEx0C37LJ6AuDrsfP0=
X-Google-Smtp-Source: AGHT+IF8ljfmfbyQ3i2hk7fLHCU/1KAoJuGp+gWXhl26br43V1JqrQwwZaG14pPRPnQLF16fzfblykAydFvxu70Iah8=
X-Received: by 2002:a67:f34d:0:b0:497:50c0:a6cb with SMTP id
 ada2fe7eead31-498f4c1c571mr10267753137.19.1724726712253; Mon, 26 Aug 2024
 19:45:12 -0700 (PDT)
MIME-Version: 1.0
References: <20240826152949.294506-1-debug@rivosinc.com>
In-Reply-To: <20240826152949.294506-1-debug@rivosinc.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 27 Aug 2024 12:44:45 +1000
Message-ID: <CAKmqyKP7EPXq_S4avRnJ7zQQan=WKmXx9Wqv-tsUPpSWYDueaQ@mail.gmail.com>
Subject: Re: [PATCH v9 00/17] riscv support for control flow integrity
 extensions
To: Deepak Gupta <debug@rivosinc.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, palmer@dabbelt.com, 
 Alistair.Francis@wdc.com, bmeng.cn@gmail.com, liwei1518@gmail.com, 
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, jim.shu@sifive.com, 
 andy.chiu@sifive.com, richard.henderson@linaro.org, kito.cheng@sifive.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::92b;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x92b.google.com
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

On Tue, Aug 27, 2024 at 1:31=E2=80=AFAM Deepak Gupta <debug@rivosinc.com> w=
rote:
>
> v9 for riscv zicfilp and zicfiss extensions support in qemu.

Can you please link to the exact specification and version you used?

We have had issues where there are multiple RVI spec versions ratified
and it's difficult to figure out which exact one is supported

Alistair

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
> ---
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
> Deepak Gupta (17):
>   target/riscv: Add zicfilp extension
>   target/riscv: Introduce elp state and enabling controls for zicfilp
>   target/riscv: save and restore elp state on priv transitions
>   target/riscv: additional code information for sw check
>   target/riscv: tracking indirect branches (fcfi) for zicfilp
>   target/riscv: zicfilp `lpad` impl and branch tracking
>   disas/riscv: enable `lpad` disassembly
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
>
>  disas/riscv.c                                 |  77 ++++++++-
>  disas/riscv.h                                 |   4 +
>  target/riscv/cpu.c                            |  17 ++
>  target/riscv/cpu.h                            |  24 ++-
>  target/riscv/cpu_bits.h                       |  17 ++
>  target/riscv/cpu_cfg.h                        |   2 +
>  target/riscv/cpu_helper.c                     | 154 +++++++++++++++++-
>  target/riscv/cpu_user.h                       |   1 +
>  target/riscv/csr.c                            |  84 ++++++++++
>  target/riscv/insn16.decode                    |   4 +
>  target/riscv/insn32.decode                    |  26 ++-
>  .../riscv/insn_trans/trans_privileged.c.inc   |   8 +-
>  target/riscv/insn_trans/trans_rva.c.inc       |  43 ++++-
>  target/riscv/insn_trans/trans_rvd.c.inc       |   4 +-
>  target/riscv/insn_trans/trans_rvf.c.inc       |   4 +-
>  target/riscv/insn_trans/trans_rvh.c.inc       |   8 +-
>  target/riscv/insn_trans/trans_rvi.c.inc       |  61 ++++++-
>  target/riscv/insn_trans/trans_rvvk.c.inc      |  10 +-
>  target/riscv/insn_trans/trans_rvzacas.c.inc   |   4 +-
>  target/riscv/insn_trans/trans_rvzfh.c.inc     |   4 +-
>  target/riscv/insn_trans/trans_rvzicfiss.c.inc |  75 +++++++++
>  target/riscv/insn_trans/trans_svinval.c.inc   |   6 +-
>  target/riscv/internals.h                      |   3 +
>  target/riscv/machine.c                        |  38 +++++
>  target/riscv/op_helper.c                      |  18 ++
>  target/riscv/pmp.c                            |   5 +
>  target/riscv/pmp.h                            |   3 +-
>  target/riscv/tcg/tcg-cpu.c                    |  25 +++
>  target/riscv/translate.c                      |  45 ++++-
>  29 files changed, 725 insertions(+), 49 deletions(-)
>  create mode 100644 target/riscv/insn_trans/trans_rvzicfiss.c.inc
>
> --
> 2.44.0
>
>

