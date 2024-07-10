Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A18DEC3DA41
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2024 01:41:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRMJe-0002jU-Km; Tue, 09 Jul 2024 21:40:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sRMJV-0002hl-Gh; Tue, 09 Jul 2024 21:40:12 -0400
Received: from mail-vs1-xe2b.google.com ([2607:f8b0:4864:20::e2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sRMJS-0002o0-DJ; Tue, 09 Jul 2024 21:40:07 -0400
Received: by mail-vs1-xe2b.google.com with SMTP id
 ada2fe7eead31-48ffd139a9cso1550250137.0; 
 Tue, 09 Jul 2024 18:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720575604; x=1721180404; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ln9ryFhpSTFy7Z4FZZEnNtTFEPHa12Z0au9dXUIJ4yg=;
 b=ibvDucxcd3xvjAm2QJxtr7z4fdVJdjqqyPJ1kU/+0BRRiUy+5uBs24jFE3rpDZgqHN
 JqoV+C25lexIzTMT3EdPh83rLXHIOKw7k3r/oMpnMF1pBNtpYmjy/ynX1tTGnKF+GkF1
 KtS3uLjDPK09jftt3A11s0CrKaXkkZkI4Z1P6P6ukzYwkRK4laNmdwgUkUZPclkCyfva
 2cIDaTqVwdQb/moOvogC9hePaWxm0vywCmgrKvSxmGtzqFRu81OVcLI/EOccywEOdvLQ
 uT38HXPYgChLi8IIE5EbL/PinPmZydfnMqgpRTpFyhE6GOWjT6x9mTf3ezNsv/szfpZa
 Lj2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720575604; x=1721180404;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ln9ryFhpSTFy7Z4FZZEnNtTFEPHa12Z0au9dXUIJ4yg=;
 b=wHUPli3mJQoQVrEpI7Uc0s8MBMb9okAR9gRpZWXGe5ns3UdjNt5+SEH6jpBz8paKrn
 u5iwffVMTAEQNL5PxUwl93ks4fm6dxDjQQIgjrFT5AAg7n3EWjc8UBpYuxzClVFO6q2j
 p8Dsd+S+o9upfzyF5HbnmnVCyIlqBMoKDYGA6X5DKd8xWpohXf37P6pVVlNMeq20TiKv
 KbYVMSu2+E8PQc8NIwqya2Jc0L8GINswva1iOJKw4avl5qksm5p+TgnlPSLVfuO2lgPF
 f5hrH7jWmNuKzIy9e4Rqi4p3vhJ6i7sPBPJiyQ78Zffq3q51u8oYi1XD1iiesdAj7wPl
 1Y4A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUghubQlFKosuzrRQFZ6WdF7bkG5XxZGTwHdpDRTdBgt6i7W8a0267mJE25U+yTh6OLtasfY+4n7fl6lnolzOH8A7oBEfU=
X-Gm-Message-State: AOJu0Yye8fB1+AMkKS1eIwr2xDoQL8RgUj0FZeZxO1Kdj9gXvZBY+uM6
 MKFsqRJFaMTuopbDI6zStrLymBAMloAOWPcwIKDFovNLxLxeE0vcuHiWc5/YZVkjckSb3vKWYpG
 KkeyyxgsgzHqZUdJQnxbPr7wQXOg=
X-Google-Smtp-Source: AGHT+IHP3vh62Gbe/YkEOfvJBRTunL+lXNtX/3w7nyVjwBQTq2cf9gccHS0fwnAoZFcUznYlZkOn6xxtOTV1enUM1Ho=
X-Received: by 2002:a05:6102:26c9:b0:48f:e4cd:a877 with SMTP id
 ada2fe7eead31-490321130cbmr4913446137.4.1720575604148; Tue, 09 Jul 2024
 18:40:04 -0700 (PDT)
MIME-Version: 1.0
References: <20240709113652.1239-1-zhiwei_liu@linux.alibaba.com>
In-Reply-To: <20240709113652.1239-1-zhiwei_liu@linux.alibaba.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 10 Jul 2024 11:39:37 +1000
Message-ID: <CAKmqyKNTgYtAQJZtJ6MYDcWoSWouRY0809-xb_qkPjxbUdTWaw@mail.gmail.com>
Subject: Re: [PATCH v4 00/11] target/riscv: Support zimop/zcmop/zama16b/zabha
To: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, palmer@dabbelt.com, 
 alistair.francis@wdc.com, dbarboza@ventanamicro.com, liwei1518@gmail.com, 
 bmeng.cn@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e2b;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe2b.google.com
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

On Tue, Jul 9, 2024 at 9:41=E2=80=AFPM LIU Zhiwei <zhiwei_liu@linux.alibaba=
.com> wrote:
>
> I once used a wrong major opcode for zimop. It should use 0x73 as major o=
pcode.
> This was detected after I got a toolchain with zimop support. Before that=
, I tested
> this implementation with hardwire code instruction instead of assemble co=
de.
>
> This patch set has been queued to alistair/riscv-to-apply.next, but it is=
 still not
> merged by the master branch. I think we had better fix it before merging =
into the
> master.
>
> v3->v4:
>     1. Fix zimop opcode and disassemble
>
> v2->v3:
>     1. Add review tags.
>     2. Reword the patch 10 in commit log
>
> v1->v2:
>     1. Fix the isa orders.
>     2. Make zimop/zcmop/zama16b/zabha depend on priviledged 1.13
>     3. Add review tags.
>
> The v2 patch set is here
> https://mail.gnu.org/archive/html/qemu-riscv/2024-06/msg00489.html
>
> The v1 patch set is here
>     1. zimop/zcmop
>         https://mail.gnu.org/archive/html/qemu-riscv/2024-05/msg00207.htm=
l
>     2. zama16b
>         https://mail.gnu.org/archive/html/qemu-riscv/2024-05/msg00212.htm=
l
>     3. zabha
>         https://mail.gnu.org/archive/html/qemu-riscv/2024-05/msg00214.htm=
l
>
> LIU Zhiwei (11):
>   target/riscv: Add zimop extension
>   disas/riscv: Support zimop disassemble
>   target/riscv: Add zcmop extension
>   disas/riscv: Support zcmop disassemble
>   target/riscv: Support Zama16b extension
>   target/riscv: Move gen_amo before implement Zabha
>   target/riscv: Add AMO instructions for Zabha
>   target/riscv: Move gen_cmpxchg before adding amocas.[b|h]
>   target/riscv: Add amocas.[b|h] for Zabha
>   target/riscv: Expose zabha extension as a cpu property
>   disas/riscv: Support zabha disassemble

Thanks!

Applied to riscv-to-apply.next

Alistair

>
>  disas/riscv.c                               | 181 ++++++++++++++++++++
>  target/riscv/cpu.c                          |   8 +
>  target/riscv/cpu_cfg.h                      |   4 +
>  target/riscv/insn16.decode                  |   1 +
>  target/riscv/insn32.decode                  |  33 ++++
>  target/riscv/insn_trans/trans_rva.c.inc     |  51 ++----
>  target/riscv/insn_trans/trans_rvd.c.inc     |  14 +-
>  target/riscv/insn_trans/trans_rvf.c.inc     |  14 +-
>  target/riscv/insn_trans/trans_rvi.c.inc     |   6 +
>  target/riscv/insn_trans/trans_rvzabha.c.inc | 145 ++++++++++++++++
>  target/riscv/insn_trans/trans_rvzacas.c.inc |  13 --
>  target/riscv/insn_trans/trans_rvzcmop.c.inc |  29 ++++
>  target/riscv/insn_trans/trans_rvzimop.c.inc |  37 ++++
>  target/riscv/tcg/tcg-cpu.c                  |   5 +
>  target/riscv/translate.c                    |  38 ++++
>  15 files changed, 529 insertions(+), 50 deletions(-)
>  create mode 100644 target/riscv/insn_trans/trans_rvzabha.c.inc
>  create mode 100644 target/riscv/insn_trans/trans_rvzcmop.c.inc
>  create mode 100644 target/riscv/insn_trans/trans_rvzimop.c.inc
>
> --
> 2.25.1
>
>

