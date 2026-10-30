Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62E0E606A332
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 10:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=summations.net header.i=@summations.net header.a=rsa-sha256 header.s=google header.b=bPord5Ek
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMk7g-00021j-5s; Fri, 30 Oct 2026 06:46:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rahul@summations.net>)
 id 1xMk7T-0001yZ-U7
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 06:46:04 -0400
Received: from mail-yx1-xb134.google.com ([2607:f8b0:4864:20::b134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rahul@summations.net>)
 id 1xMk7R-0007ZM-A9
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 06:45:59 -0400
Received: by mail-yx1-xb134.google.com with SMTP id
 956f58d0204a3-67b9bd530b7so394505d50.0
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 03:45:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793357153; cv=none;
 d=google.com; s=arc-20260327;
 b=qjB5NrNFQJivOJRo1BiCs2JOVRxTIevhDbU698/D5LaGew4DP6qwQDH7oNDvmkeQeO
 2PLBCidwIDa++jiRePpsYV6haqj7jiTVu4Ydh9ErRsV0yMgx0n9LWi44Y1meBP08GZjR
 rrneVoClf5h7W+1G/oOaZsMS9wJd9HzNNX4iVoJJ2/fq6e0DrVPP/+dJN0FDX1dO6eNq
 D95C/VSkQjYT7JptbaClW7FLVE5BSBwqgTJrFBbPzT/E1qmkvRGHvWQKGhm33qu/5ga0
 PqBKR+j6CEVawEJjUoR8kbXDkAZEwC49piyLdUCQSfdA/M8mMN8Gav+o62B5aSsJB7IB
 fKeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=dIs7lC+ZTuo8fyy3O3yGHwNg2RDTT67WltyHYKq634E=;
 fh=7FvbfQGd5mk6jUFOl8TVKrZG+MkHtL63dmEz2F7Gt6g=;
 b=qKiTMQgY8wwAciZgV445y07fBogbyOU7LWCho6P1aaO765WtJ+csL5id5fjjSGySDh
 qpMhvWl1YQV+Mf7ti9ha7gDN2a2d3DWBDO52uHeVvaz3fqqfiRm9nCu3OdAVYfwkemrl
 GMrsJKAR9KNJbQE5xm/gWdsYhLT0klLyQtvusF7GPQBtYx6dxAer3wwAeGJ7/9o1v0jU
 p41sD3uIm/7I93jwQS9z5yjzxnxFHi3iZfJEsUtMExbVtH+oNtK22ybPV5/UWctCKhzX
 +dvD9lKQyqA/qJHekT9jLtybSWVqURxtgrIIia/BbTPqs2PkzZSY2t/T5lpcrifci8lp
 mIkA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=summations.net; s=google; t=1793357153; x=1793961953; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=dIs7lC+ZTuo8fyy3O3yGHwNg2RDTT67WltyHYKq634E=;
 b=bPord5EkjOe0bD+BWEH9RmInRmuERXILI9ud15hoHiiFei4rO7GBR6YaHogrmnlKF3
 SiySqmkc7zE/wQyu8dcYlwrfn3rEIFmdQJGilr9xlLRJJ03qn5382KoxkN7eeq3EVaWg
 vTE30+J7Pme+n2pKJFvK7uwEINXNB7RgDC2U+QgQ90C/eljACDJx8E3nxvXZdRTMHowh
 KUXcL79mmc59/c2uFqoy/Xjl2bEXcSkEgjnjWAYiCDaC0Zr6dTj0kU1mFy1v4gTbSkX9
 8sGER90LqTIHqSyYSf8kYcsJRbR8bOV/LUwuRtxQUUx+EFXf5JmVFfpypD4+XRQk5+8V
 znIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793357153; x=1793961953;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=dIs7lC+ZTuo8fyy3O3yGHwNg2RDTT67WltyHYKq634E=;
 b=fxFyg8FbVV7M8sx9YYq3zWeH/NPIYwetAboPEunym3Of7j2XiWB+fOg0T3oQLO85kq
 rS9/sFasRB2eMBPBJXJkTV/GT4WiQuZ7ILGNf0pZNbi7+mmHb0i4WmCi3VUxrJ6gFc9O
 gM8frAi3VwJMublgf6Gyzqz2lQ+2Ublo/I+dAzV7zOTDb/GPUTM4i/IdSVxAADWfULAw
 gQ68EpxwiZRRey8PklNZY3Wg0vJcl9o9ekxw1z7A2F73XS5mK34MNRUr88OQ19fIshEl
 J82Hjcxxn1jqiB6Npdw88AavGL7ScQA5huwaW2LlIyU0wJq4N7jSjd2jCFGaRC1C2n1n
 JSaw==
X-Forwarded-Encrypted: i=1;
 AKwUvByre8P8eJHUC/MmBd7GoSgd1NftOLBeU0Mz2U19/2lAaQGHKupn/bl2imqMG1kLtryXLXPWWbbxEqPj@nongnu.org
X-Gm-Message-State: AFq9FYJNwkPGFFOB8G6TeYbzMnGpE4/KBWRdCMhkOUnLuod7Qx3N+GfE
 O3OmICGkkKUb5l3nRzSn4PsXIyQ62LqhImG/qYwvXAh1aNaYIGqnohZNACzPrM973YpBN2wULJv
 l3PD9DnrkNiYPrzAyefzd/Q83a85RYJu8S6BGxMSleIo=
X-Gm-Gg: AYBFou2wn6rQz4GKjUeZMw2wQ7exl5oi5/wjiIzAWYiOAHEc/W3nhfkgqHhEc9V/Ujt
 snj8Ps1Vgmk/83sIKCTjTskZZT2K6PXgP4A0b2wkDlzrfEPDtKkE/PWzMNJDRPdQ1/lchU/vH8y
 LT5TeMp2hNT66cQpYgvVoXdfQvxuuQDtm6uvorhAE+W8opPlg6xiua4OjOZSWlJqMQXKi78arW1
 0MGnDGQruI86wuuihtEHZxHqHqFjzaLmFocdKliN3Wa5F0nmOvfUHRkJ2LvSeG9Y0DTuh2C36KF
 SXU69OUTfVZb0MXeKcSSALcMRuZmEZyrdC4dZ4+0oO223Z8mmGW8Dtk+D0YKZzWJe+heeAdzyy7
 K6zKvIvTJJ93KcHyd+SwPW97wH0YRY/4Cvqc7EFEw6RPUaeZ2vJ+YqG8b39ODCJwwgG0BMJrMNd
 nzLkU8kGng5HTUlRGNGX4TsnLyUw==
X-Received: by 2002:a05:690e:484f:b0:679:941a:5b7e with SMTP id
 956f58d0204a3-67ba50b7a03mr1049439d50.84.1793357152707; Fri, 30 Oct 2026
 03:45:52 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20260723200325.24969-1-zhiwei_liu@linux.alibaba.com>
 <73bc69a4-a3e6-47c8-9c7f-92443706b250@oss.qualcomm.com>
 <397f4ece-067b-4714-93f3-082e07fad06d@linux.alibaba.com>
In-Reply-To: <397f4ece-067b-4714-93f3-082e07fad06d@linux.alibaba.com>
From: Rahul Pathak <rahul@summations.net>
Date: Fri, 30 Oct 2026 16:15:41 +0530
X-Gm-Features: AclHuK9kEtitJkXM97BtGOyYaRQhX8-ax_cQ2ODmDFY8ss3XYFjPcKlwMTWGRiM
Message-ID: <CABdD5xku3v1hGGHQA=WNiB-zTYkHdg=Pou5nci7ShUyERLp-CA@mail.gmail.com>
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::b134;
 envelope-from=rahul@summations.net; helo=mail-yx1-xb134.google.com
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_SBL=1.623 autolearn=no autolearn_force=no
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

Hi Zhiwei,

The SMMPT spec has been updated following the ARC comments
 and the big change is the merging of both SMSDID and SMMPT
 sub extensions into one with new name "SMSD" which is much better now.

https://github.com/riscv/riscv-smmtt/commit/ff5069fa99fc1fdd97c9fb8d96329e1=
3afa82712

Can you please update this series.

Thanks
Rahul

On Sat, Oct 10, 2026 at 12:13=E2=80=AFPM LIU Zhiwei
<zhiwei_liu@linux.alibaba.com> wrote:
>
>
> On 10/8/26 10:42 AM, Daniel Henrique Barboza wrote:
> > Hi Zhiwei,
> >
> >
> > Sorry from taking this long to take a look at this work.  I am afraid
> > I'll
> > need to ask you to send a v9 due to the following upstream changes, asi=
de
> > from some review comments I made:
> >
> > - upstream changed how tcg tests are invoked (we use meson now), i.e. y=
ou
> > need to add changes in tests/tcg/riscv64/system/meson.build instead of
> > Makefile.softmmu-target;
> >
> > - upstream also changed how we declare things in disas/riscv.c.
> >
> >
> > If you send a v9 I'll prioritize it for review.  We can get this done f=
or
> > 11.2.
> >
> Hi Daniel,
>
> Thank you for taking the time to review this! No worries about the delay.
>
> I appreciate the heads-up on the upstream changes. I will update the
> patch accordingly:
>
> Switch from Makefile.softmmu-target to
> tests/tcg/riscv64/system/meson.build for the TCG test invocation;
> Update the declarations in disas/riscv.c to align with the latest
> upstream changes.
> I will send out v9 as soon as possible. Really glad to hear we can
> target 11.2 for this =E2=80=94 I'll make sure to prioritize it on my end =
as well.
>
> Thanks again for the review and for keeping this moving!
>
> Best regards,
> Zhiwei
> >
> > Cheers,
> > Daniel
> >
> > On 7/23/2026 5:03 PM, LIU Zhiwei wrote:
> >> This patch set introduces support for the RISC-V Smsdid and Smmpt
> >> (Supervisor Domain Identifier and Memory Protection Table) extensions
> >> v0.4.9(https://github.com/riscv/riscv-smmtt/releases/tag/v0.4.9).
> >> Smmpt provides a hardware mechanism for fine-grained memory protection=
,
> >> checked after address translation, which is particularly useful for
> >> supervisor-level sandboxing and security monitoring.
> >>
> >> The rfc patch set:
> >> https://mail.gnu.org/archive/html/qemu-riscv/2025-09/msg00216.html
> >>
> >> Rahul Pathak is working on SMMPT OpenSBI support -
> >> https://lists.infradead.org/pipermail/opensbi/2026-July/010235.html
> >>
> >> based on his QEMU SMMPT branch -
> >> https://github.com/pathakraul/qemu/tree/rpathak_smmpt_v1
> >>
> >> As we all agree -
> >> https://patchew.org/QEMU/20260715145016.17369-1-zhiwei._5Fliu@linux.al=
ibaba.com/
> >>
> >> , we will collaborate on this work and not duplicate efforts. Rahul wi=
ll
> >> focus on OpenSBI upstream and I will update the QEMU patch set to v8.
> >>
> >> Xiangyi will review the OpenSBI SMMPT patch set and may collaborate to
> >> upstream the other parts, such as SMSDIA and IOMPT.
> >>
> >> v7->v8:
> >>      1. Update the mfence.pa and minval.pa instruction encodings to
> >> match the
> >>         upstream riscv-opcodes definition
> >>         (https://github.com/riscv/riscv-opcodes/pull/389/): mfence.pa
> >> now uses
> >>         funct7=3D0b0011001 and minval.pa uses funct7=3D0b0011011. The
> >> decoder,
> >>         disassembler and the system test are updated accordingly.
> >>
> >> v6->v7:
> >>      The implementation is updated from the v0.3.4 specification to
> >>      v0.4.9. The main changes are:
> >>      1. Update the mmpt CSR number to 0x382 and msdcfg to 0x74E.
> >>      2. Update the mmpt register layout: the SDID and PPN field
> >> positions
> >>         changed and the RV64 PPN is now 44 bits.
> >>      3. Rework the MPTE format: the N (NAPOT) bit now lives at bit 2,
> >> the
> >>         non-leaf NAPOT form is removed, NAPOT leaf entries encode a
> >> single
> >>         XWR tuple plus a G granularity field, and non-NAPOT leaf entri=
es
> >>         hold per-page XWR tuples.
> >>      4. Treat XWR=3D000 as "no access" and a non-leaf entry with N=3D1=
 as a
> >>         fault.
> >>      5. Enforce the Smmpt64 root-table PPN alignment (low 3 bits zero)=
.
> >>      6. Rename the fence instructions mfence.spa/minval.spa to
> >>         mfence.pa/minval.pa.
> >>      7. Drop stale Reviewed-by tags on the substantially reworked
> >> patches.
> >>      8. Introduce the configurable "smmpt-sdidlen" CPU property.
> >>      9. Add disassembly support for the Smmpt.
> >>      10. Add bare-metal M-mode system tests.
> >>      11. Rebase to master.
> >>
> >> v5->v6:
> >>      1. Use explicitly bit fields extract instead of mpte_union_t.
> >>      2. Use the same exception behavior for MPT valiation as PMP
> >>         valiation.
> >>      3. Use PAGE_* instead of MPT_ACCESS_* as they have same value.
> >>      4. Use address_space_*_le instead of address_space_* for SMMPT.
> >>      5. Only print SMMPT address check log when SMMPT is enabled.
> >>      6. Add implied rule for SMMPT as it depends on SMSDID.
> >>      7. Rebase to master.
> >>
> >> v4->v5:
> >>      1. Rebase to master.
> >> v3->v4:
> >>      1. Add missing review tags.
> >> v2->v3:
> >>      1. Fix build error in patch 2.
> >>      2. Rebase to master.
> >>
> >> rfc->v2:
> >>      1. When ext_smmpt is false or BARE mode, make other fields in mmp=
t
> >>         CSR zero.
> >>      2. Add patch 5 to fix smrnmi ISA string order.
> >>      3. Fix patch 6 smmpt and smsdid ISA string order.
> >>      4. Make smmpt and smsdid experiment extensions.
> >>      5. Add review tags.
> >>
> >> LIU Zhiwei (11):
> >>    target/riscv: Add basic definitions and CSRs for SMMPT
> >>    target/riscv: Add smmpt-sdidlen property for the mmpt SDID field
> >>    target/riscv: Implement core SMMPT lookup logic
> >>    target/riscv: Integrate SMMPT checks into MMU and TLB fill
> >>    target/riscv: Implement SMMPT fence instructions
> >>    target/riscv: Fix smrnmi isa alphabetical order
> >>    target/riscv: Add disassembly for Smmpt instructions and CSRs
> >>    target/riscv: Enable SMMPT extension
> >>    target/riscv: Add system test for SMMPT extension
> >>    target/riscv: Add system tests for Smmpt52 and Smmpt64
> >>    target/riscv: Add system test for Smmpt34
> >>
> >>   disas/riscv.c                                 |   9 +-
> >>   target/riscv/cpu.c                            |  60 +++-
> >>   target/riscv/cpu.h                            |   8 +
> >>   target/riscv/cpu_bits.h                       |  27 ++
> >>   target/riscv/cpu_cfg_fields.h.inc             |   3 +
> >>   target/riscv/insn32.decode                    |   2 +
> >>   target/riscv/meson.build                      |   1 +
> >>   target/riscv/riscv_smmpt.c                    | 339 ++++++++++++++++=
++
> >>   target/riscv/riscv_smmpt.h                    |  26 ++
> >>   target/riscv/tcg/cpu_helper.c                 | 119 +++++-
> >>   target/riscv/tcg/csr.c                        | 106 ++++++
> >>   .../tcg/insn_trans/trans_privileged.c.inc     |  30 ++
> >>   target/riscv/tcg/pmp.h                        |   3 +
> >>   tests/tcg/riscv64/Makefile.softmmu-target     |  12 +
> >>   tests/tcg/riscv64/smmpt-common.S              | 257 +++++++++++++
> >>   tests/tcg/riscv64/test-smmpt.S                |  85 +++++
> >>   tests/tcg/riscv64/test-smmpt34.S              |  97 +++++
> >>   tests/tcg/riscv64/test-smmpt52.S              |  91 +++++
> >>   tests/tcg/riscv64/test-smmpt64.S              |  98 +++++
> >>   19 files changed, 1354 insertions(+), 19 deletions(-)
> >>   create mode 100644 target/riscv/riscv_smmpt.c
> >>   create mode 100644 target/riscv/riscv_smmpt.h
> >>   create mode 100644 tests/tcg/riscv64/smmpt-common.S
> >>   create mode 100644 tests/tcg/riscv64/test-smmpt.S
> >>   create mode 100644 tests/tcg/riscv64/test-smmpt34.S
> >>   create mode 100644 tests/tcg/riscv64/test-smmpt52.S
> >>   create mode 100644 tests/tcg/riscv64/test-smmpt64.S
> >>
> >>
> >> base-commit: 499039798cdad7d86b787fec0eaf1da4151c0f05
> >

