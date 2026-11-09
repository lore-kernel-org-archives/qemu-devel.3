Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE0A606EEBB
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 09:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=summations.net header.i=@summations.net header.a=rsa-sha256 header.s=google header.b=KNZhi+V/
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQLTP-0008L3-8y; Mon, 09 Nov 2026 04:15:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rahul@summations.net>)
 id 1xQLSq-0008Ci-DA
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 04:15:08 -0500
Received: from mail-yw1-x1132.google.com ([2607:f8b0:4864:20::1132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rahul@summations.net>)
 id 1xQLSm-0003kW-Kt
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 04:14:55 -0500
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-8b10d24345dso5002427b3.3
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 01:14:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794215690; cv=none;
 d=google.com; s=arc-20260327;
 b=KqKjO/8CfG73ttzm7PbYJZczRJihQEG7znOfSlLD90s+t/MqT4hm7egcNM9TM+YS3t
 iybqsizaSFNUdX1KEIGDvl1nHlIn1WzRLngiz27CDQ7HUWYVgFRGbWadaJikRU17KFGE
 DPEIoSoIlyywvNp3bro4dEZTKNuKUTZ6UU7hLIOhkyf/QDZChFNMDZHaX2j+ks2NK2pF
 XtxwSNb5Q9/785JGl07Jhr3/MHCM2IuhqOSFkgEuX4wvGi5Ac8h+9/DO55oSR/H82pNm
 ZD5Rjrfi8HEA4MbYQjQnG9/Ir65LsB3/gycZJ7hMsjcMSm+9AX3McobwlBGLaNJdfwRV
 60Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Pr5mkg+z9Zmb0BcJ7NiDS8DqyWBc9okrtwtlDgfvwtU=;
 fh=jMfEyO2DXUenr5MxIg3VlR4MlyWhOApo7KzM+YffhJY=;
 b=rYAO3/CVjAWkxjORj7XAcSMSunAoMaGL16FIKt5AFCeeDk67v9GuuZvd8fSEjY38jq
 qcL+reUSzGIsJjCqLMUQ6V7il5fQyW0UrhO7H0GD9xsk/O4kYRNO4fTTODMcvK+jkewa
 dfj88+E8XCYD7aQdcWRXKeE3B2BOY1mQsQdbUtNCf8DABuVzFcDWhFitxNOIGcTLEUgM
 +RdsVd4EpplyK2PzEqCtfyI8Cnkt9lDAxKXChVppZZ8PDYS5fMFR1s2ue/VhFUPkamTO
 z3dDIhS06Es4hvQlOzNgX2GkwsGEX0y/voFbaimOZ8rX59HAzpLGmCJzpqSpffGV3wdH
 L73A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=summations.net; s=google; t=1794215690; x=1794820490; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Pr5mkg+z9Zmb0BcJ7NiDS8DqyWBc9okrtwtlDgfvwtU=;
 b=KNZhi+V/9nWdRiaoNpTZMt5VHFroGqnK5B+6i2D49Qmf9aKCPR2+5ZeM6kQWJ6egnJ
 NBlWoVC4bQkfevixYf4NYnZuQmLvXSxKabcb9suHplu434DtyXkkXPMkRxdLDbQV1fjC
 HtYwomkr/q/OMy0bs0M3FvhQTIedmCkBkLt4jIZLM8T5Sq6YiGOfIuhejlcj+WX3kZHw
 LLOdFi2LWc4onlsxsbwnhgKSRpl++tPdRbPul5dRjGkL7v6lnrRmKttQLQLcJ56wCql0
 hx/LOWDC5fUGlz3EOLSxU1cE3KfncEPWjHiskZX5uk2qW59isrhJq72UZ9r2pfUT+ylQ
 yjJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794215690; x=1794820490;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Pr5mkg+z9Zmb0BcJ7NiDS8DqyWBc9okrtwtlDgfvwtU=;
 b=SXYUxfUki6nRXFKB11kLblcqoe+c+ixdXQebD7xpn0HXm5GmxqOCg+faEK4q2M8bES
 ob4VKNDHrol63xvq53wj1Aw9YkvP7sSik2m68fsnKrKmJNruXE0J5F+4sp4PM9x5iprY
 eM6Beur09yLZoFs5m/aHnG6XriWdJIkrUekQTIFTWFO+9Kbe8QgeDa+8d6x4sb++iv75
 00cumkhhuWyzvSoa/L6zpCGePVLwIIu50913htIja8rCIJCiwVRDOcBmeQ4oFJiWpNoi
 kga/xZzL5j8/9zfgOWpmmrLHXXYS9iXp+luLBH3Yt3a2QiUbLjdlgFZip4OrvSu2oTms
 Aj3A==
X-Forwarded-Encrypted: i=1;
 AL+hErEvV97yWIX4JCclDPb9eULc+DD/JJ1IKPe2wFttSrvZICNztISk7VjoMJ3uFupb/7re584ecLCNJjcH@nongnu.org
X-Gm-Message-State: APuU4Z/P1sicHQH69ZIEhqR/+N6pcJs91r2R4fI5suIs9VC9Ko/hPvos
 tYMu6ayDyyK9wJIToLvYRLMCLVKU0IJQ5OL/rsTjpN5ZdOgP4+ReXfUrxi8ZXDkcSzaBhVzH8X+
 g/7pptsAOVu9wbQ4BitNsbidHSFs0iPLyWESZxQXozO8=
X-Gm-Gg: AYBFou1FWgcmbE95LvMCmOYydvPAFkg6uKdkVk59VVCd9BNz28c6ugwjTsNdPpi7WJK
 ZvDhi7JMNHSfvxOWUB6U/Y0nELcOQh6M/6K/961PtfoRcs4PdZnrKH4qMEA2v0zcYMLGEx52/CD
 zJAbjTSb4cfUL7MtLgmECitud+8MoR1+aGJgTfrRhB6U/1GBGT4F7jjOneylOPPNK3+H9C22yR3
 K6jC+TglEkZovgGrB+HbVyd6yHUjy+WGIf2aAm7qKxmim1cq/ulr633cBgfDFjDzqznVUJjmLjD
 skj4bQpfeoPNDEYn4jWx8aP+OH4zPIzYEGZ1KWW/7/xglU1xk9BV/fEvplv/lMfDHAw+EShvOv7
 oAbE1F+omgJ+Bzc6Pi3vFaHw1UrS1vZl8yIF/3sFQTYxR1EZcQ6FflHy44HULPRCuoRuv72RZwS
 IGAuHo8R/vhAixoltX8rf+xZ8df45A39qOiDcBpBTBvNahEw==
X-Received: by 2002:a05:690c:c50f:b0:8ab:48c5:cbce with SMTP id
 00721157ae682-8b36cb913fcmr22906247b3.32.1794215690539; Mon, 09 Nov 2026
 01:14:50 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20260723200325.24969-1-zhiwei_liu@linux.alibaba.com>
 <73bc69a4-a3e6-47c8-9c7f-92443706b250@oss.qualcomm.com>
 <397f4ece-067b-4714-93f3-082e07fad06d@linux.alibaba.com>
 <CABdD5xku3v1hGGHQA=WNiB-zTYkHdg=Pou5nci7ShUyERLp-CA@mail.gmail.com>
 <f742d921-b9e7-40e3-b70f-9d70804a9bcd@linux.alibaba.com>
In-Reply-To: <f742d921-b9e7-40e3-b70f-9d70804a9bcd@linux.alibaba.com>
From: Rahul Pathak <rahul@summations.net>
Date: Mon, 9 Nov 2026 14:44:39 +0530
X-Gm-Features: AclHuK8IMG3txV4EIVbeGdwA3sotK3LWfCa2v-kbgiecyzB8XpX4E7Xo-U2wwA4
Message-ID: <CABdD5xmPcBg21buQU6L9VdGTu1AwyOD7iFNWa_kDv_rt71hZPg@mail.gmail.com>
Subject: Re: [PATCH v8 00/11] target/riscv: Implement Smsdid and Smmpt
 extension
To: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Cc: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-devel@nongnu.org, 
 palmer@dabbelt.com, alistair.francis@wdc.com, chao.liu.zevorn@gmail.com, 
 liwei1518@gmail.com, qemu-riscv@nongnu.org, xiangyi.zeng@linux.alibaba.com, 
 cxx194832@alibaba-inc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1132;
 envelope-from=rahul@summations.net; helo=mail-yw1-x1132.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Last week I have sent V7 of OpenSBI series which is based on V0.9
version of SMMTT(SPDA) spec.

https://patchwork.ozlabs.org/project/opensbi/list/?series=3D531089

On Mon, Nov 9, 2026 at 1:05=E2=80=AFPM LIU Zhiwei <zhiwei_liu@linux.alibaba=
.com> wrote:
>
>
> On 10/30/26 6:45 PM, Rahul Pathak wrote:
> > Hi Zhiwei,
> >
> > The SMMPT spec has been updated following the ARC comments
> >   and the big change is the merging of both SMSDID and SMMPT
> >   sub extensions into one with new name "SMSD" which is much better now=
.
> >
> > https://github.com/riscv/riscv-smmtt/commit/ff5069fa99fc1fdd97c9fb8d963=
29e13afa82712
> >
> > Can you please update this series.
> Hi Rahul and Daniel,
>
> I see the latest specification is v0.9.0 now. Supporting v0.4.9 is not
> necessary. I will update this patch set to v0.9.0 together with updated
> test cases.
>
> Thanks,
> Zhiwei
>
> >
> > Thanks
> > Rahul
> >
> > On Sat, Oct 10, 2026 at 12:13=E2=80=AFPM LIU Zhiwei
> > <zhiwei_liu@linux.alibaba.com> wrote:
> >>
> >> On 10/8/26 10:42 AM, Daniel Henrique Barboza wrote:
> >>> Hi Zhiwei,
> >>>
> >>>
> >>> Sorry from taking this long to take a look at this work.  I am afraid
> >>> I'll
> >>> need to ask you to send a v9 due to the following upstream changes, a=
side
> >>> from some review comments I made:
> >>>
> >>> - upstream changed how tcg tests are invoked (we use meson now), i.e.=
 you
> >>> need to add changes in tests/tcg/riscv64/system/meson.build instead o=
f
> >>> Makefile.softmmu-target;
> >>>
> >>> - upstream also changed how we declare things in disas/riscv.c.
> >>>
> >>>
> >>> If you send a v9 I'll prioritize it for review.  We can get this done=
 for
> >>> 11.2.
> >>>
> >> Hi Daniel,
> >>
> >> Thank you for taking the time to review this! No worries about the del=
ay.
> >>
> >> I appreciate the heads-up on the upstream changes. I will update the
> >> patch accordingly:
> >>
> >> Switch from Makefile.softmmu-target to
> >> tests/tcg/riscv64/system/meson.build for the TCG test invocation;
> >> Update the declarations in disas/riscv.c to align with the latest
> >> upstream changes.
> >> I will send out v9 as soon as possible. Really glad to hear we can
> >> target 11.2 for this =E2=80=94 I'll make sure to prioritize it on my e=
nd as well.
> >>
> >> Thanks again for the review and for keeping this moving!
> >>
> >> Best regards,
> >> Zhiwei
> >>> Cheers,
> >>> Daniel
> >>>
> >>> On 7/23/2026 5:03 PM, LIU Zhiwei wrote:
> >>>> This patch set introduces support for the RISC-V Smsdid and Smmpt
> >>>> (Supervisor Domain Identifier and Memory Protection Table) extension=
s
> >>>> v0.4.9(https://github.com/riscv/riscv-smmtt/releases/tag/v0.4.9).
> >>>> Smmpt provides a hardware mechanism for fine-grained memory protecti=
on,
> >>>> checked after address translation, which is particularly useful for
> >>>> supervisor-level sandboxing and security monitoring.
> >>>>
> >>>> The rfc patch set:
> >>>> https://mail.gnu.org/archive/html/qemu-riscv/2025-09/msg00216.html
> >>>>
> >>>> Rahul Pathak is working on SMMPT OpenSBI support -
> >>>> https://lists.infradead.org/pipermail/opensbi/2026-July/010235.html
> >>>>
> >>>> based on his QEMU SMMPT branch -
> >>>> https://github.com/pathakraul/qemu/tree/rpathak_smmpt_v1
> >>>>
> >>>> As we all agree -
> >>>> https://patchew.org/QEMU/20260715145016.17369-1-zhiwei._5Fliu@linux.=
alibaba.com/
> >>>>
> >>>> , we will collaborate on this work and not duplicate efforts. Rahul =
will
> >>>> focus on OpenSBI upstream and I will update the QEMU patch set to v8=
.
> >>>>
> >>>> Xiangyi will review the OpenSBI SMMPT patch set and may collaborate =
to
> >>>> upstream the other parts, such as SMSDIA and IOMPT.
> >>>>
> >>>> v7->v8:
> >>>>       1. Update the mfence.pa and minval.pa instruction encodings to
> >>>> match the
> >>>>          upstream riscv-opcodes definition
> >>>>          (https://github.com/riscv/riscv-opcodes/pull/389/): mfence.=
pa
> >>>> now uses
> >>>>          funct7=3D0b0011001 and minval.pa uses funct7=3D0b0011011. T=
he
> >>>> decoder,
> >>>>          disassembler and the system test are updated accordingly.
> >>>>
> >>>> v6->v7:
> >>>>       The implementation is updated from the v0.3.4 specification to
> >>>>       v0.4.9. The main changes are:
> >>>>       1. Update the mmpt CSR number to 0x382 and msdcfg to 0x74E.
> >>>>       2. Update the mmpt register layout: the SDID and PPN field
> >>>> positions
> >>>>          changed and the RV64 PPN is now 44 bits.
> >>>>       3. Rework the MPTE format: the N (NAPOT) bit now lives at bit =
2,
> >>>> the
> >>>>          non-leaf NAPOT form is removed, NAPOT leaf entries encode a
> >>>> single
> >>>>          XWR tuple plus a G granularity field, and non-NAPOT leaf en=
tries
> >>>>          hold per-page XWR tuples.
> >>>>       4. Treat XWR=3D000 as "no access" and a non-leaf entry with N=
=3D1 as a
> >>>>          fault.
> >>>>       5. Enforce the Smmpt64 root-table PPN alignment (low 3 bits ze=
ro).
> >>>>       6. Rename the fence instructions mfence.spa/minval.spa to
> >>>>          mfence.pa/minval.pa.
> >>>>       7. Drop stale Reviewed-by tags on the substantially reworked
> >>>> patches.
> >>>>       8. Introduce the configurable "smmpt-sdidlen" CPU property.
> >>>>       9. Add disassembly support for the Smmpt.
> >>>>       10. Add bare-metal M-mode system tests.
> >>>>       11. Rebase to master.
> >>>>
> >>>> v5->v6:
> >>>>       1. Use explicitly bit fields extract instead of mpte_union_t.
> >>>>       2. Use the same exception behavior for MPT valiation as PMP
> >>>>          valiation.
> >>>>       3. Use PAGE_* instead of MPT_ACCESS_* as they have same value.
> >>>>       4. Use address_space_*_le instead of address_space_* for SMMPT=
.
> >>>>       5. Only print SMMPT address check log when SMMPT is enabled.
> >>>>       6. Add implied rule for SMMPT as it depends on SMSDID.
> >>>>       7. Rebase to master.
> >>>>
> >>>> v4->v5:
> >>>>       1. Rebase to master.
> >>>> v3->v4:
> >>>>       1. Add missing review tags.
> >>>> v2->v3:
> >>>>       1. Fix build error in patch 2.
> >>>>       2. Rebase to master.
> >>>>
> >>>> rfc->v2:
> >>>>       1. When ext_smmpt is false or BARE mode, make other fields in =
mmpt
> >>>>          CSR zero.
> >>>>       2. Add patch 5 to fix smrnmi ISA string order.
> >>>>       3. Fix patch 6 smmpt and smsdid ISA string order.
> >>>>       4. Make smmpt and smsdid experiment extensions.
> >>>>       5. Add review tags.
> >>>>
> >>>> LIU Zhiwei (11):
> >>>>     target/riscv: Add basic definitions and CSRs for SMMPT
> >>>>     target/riscv: Add smmpt-sdidlen property for the mmpt SDID field
> >>>>     target/riscv: Implement core SMMPT lookup logic
> >>>>     target/riscv: Integrate SMMPT checks into MMU and TLB fill
> >>>>     target/riscv: Implement SMMPT fence instructions
> >>>>     target/riscv: Fix smrnmi isa alphabetical order
> >>>>     target/riscv: Add disassembly for Smmpt instructions and CSRs
> >>>>     target/riscv: Enable SMMPT extension
> >>>>     target/riscv: Add system test for SMMPT extension
> >>>>     target/riscv: Add system tests for Smmpt52 and Smmpt64
> >>>>     target/riscv: Add system test for Smmpt34
> >>>>
> >>>>    disas/riscv.c                                 |   9 +-
> >>>>    target/riscv/cpu.c                            |  60 +++-
> >>>>    target/riscv/cpu.h                            |   8 +
> >>>>    target/riscv/cpu_bits.h                       |  27 ++
> >>>>    target/riscv/cpu_cfg_fields.h.inc             |   3 +
> >>>>    target/riscv/insn32.decode                    |   2 +
> >>>>    target/riscv/meson.build                      |   1 +
> >>>>    target/riscv/riscv_smmpt.c                    | 339 +++++++++++++=
+++++
> >>>>    target/riscv/riscv_smmpt.h                    |  26 ++
> >>>>    target/riscv/tcg/cpu_helper.c                 | 119 +++++-
> >>>>    target/riscv/tcg/csr.c                        | 106 ++++++
> >>>>    .../tcg/insn_trans/trans_privileged.c.inc     |  30 ++
> >>>>    target/riscv/tcg/pmp.h                        |   3 +
> >>>>    tests/tcg/riscv64/Makefile.softmmu-target     |  12 +
> >>>>    tests/tcg/riscv64/smmpt-common.S              | 257 +++++++++++++
> >>>>    tests/tcg/riscv64/test-smmpt.S                |  85 +++++
> >>>>    tests/tcg/riscv64/test-smmpt34.S              |  97 +++++
> >>>>    tests/tcg/riscv64/test-smmpt52.S              |  91 +++++
> >>>>    tests/tcg/riscv64/test-smmpt64.S              |  98 +++++
> >>>>    19 files changed, 1354 insertions(+), 19 deletions(-)
> >>>>    create mode 100644 target/riscv/riscv_smmpt.c
> >>>>    create mode 100644 target/riscv/riscv_smmpt.h
> >>>>    create mode 100644 tests/tcg/riscv64/smmpt-common.S
> >>>>    create mode 100644 tests/tcg/riscv64/test-smmpt.S
> >>>>    create mode 100644 tests/tcg/riscv64/test-smmpt34.S
> >>>>    create mode 100644 tests/tcg/riscv64/test-smmpt52.S
> >>>>    create mode 100644 tests/tcg/riscv64/test-smmpt64.S
> >>>>
> >>>>
> >>>> base-commit: 499039798cdad7d86b787fec0eaf1da4151c0f05

