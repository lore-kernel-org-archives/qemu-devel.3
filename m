Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEADCD2E00A
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2024 02:42:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3RK6-0006yz-R9; Tue, 22 Oct 2024 22:42:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1t3RK5-0006yn-IE; Tue, 22 Oct 2024 22:42:09 -0400
Received: from mail-ua1-x92b.google.com ([2607:f8b0:4864:20::92b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1t3RK3-0002gt-RH; Tue, 22 Oct 2024 22:42:09 -0400
Received: by mail-ua1-x92b.google.com with SMTP id
 a1e0cc1a2514c-851f5d3001fso1167069241.1; 
 Tue, 22 Oct 2024 19:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729651326; x=1730256126; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xasrTJdnJ1pVArHdqKo6aHNQGXlFXq3LgiX/sh6/SWA=;
 b=deeUaJjcmGtWzJjsB92TGnvi4cgrUua0shCUgmwFhFZ24CDJAi/1xYqMQ7xOpgzF44
 P/Vih89uHIzJTqIpDgoPA7CqSlUxs4UQa+jE0X7dU2sZp+RMze4ryPosPuSF1n+y8xnN
 ComjBNMCk7uPpfTM6ygKudaW3yyqXOUP87m35qvlrCKC/xUj/79CRuoWGMV2xtmMjhVI
 YJTTKr/8Yy0lC/j5HvpjKhAaP46X//6BP7KkzAoEir0DD4t4Dta/EWB+xn380o2H1hHr
 1TbRLA7uom7do1M5oLjYzozJ1j8H84BB50dcCy1hYi79qGwqloD8wIRiboj+39/bOu3r
 fEwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729651326; x=1730256126;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xasrTJdnJ1pVArHdqKo6aHNQGXlFXq3LgiX/sh6/SWA=;
 b=cb2R1XTiPkDbKiQrk2Ry2Kf02+rLF/XPhHC6wjC17NnOfJ4eCiBwv+v196obEUBMpu
 j1C9UpbUxL4VhldVuB3w2S2VnW67JTu+CAki5+EpWu+R1MVk3JIT4cb+FWNVW2liO/OE
 4oYaAgoo4rj3BKN6S61HUjobpiwMRP0l1hJYXC3c+La6P4uwq8paUmvrDy7K/39Pe/I5
 QThhnDMEJLp1wnS9Sms3z6E192U2w1A6Dxj9OPuTfYB8s67fBb8Plxqy24v8DKRh1mBz
 33D7Ogc00kD4XwVFyfe7ikDRcGvXcM4XYgptxqtmIRKIDuPtK4ewLrEX+FD0G/nrYGKA
 NTJQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXLKV/er8g8sI0UPIXQoyCHv0VDD7phJQqx52Un+bhjxmQkmwckTiW785f7aj6LFcXqix7BWiLQ8yBM@nongnu.org
X-Gm-Message-State: AOJu0Yzovq25XP8O0SlAt7WffA2tucqV3Wes0OH6r3JdCr/X+bcOI/51
 z5Q33Le9XmtI3/TxkL18Rswa4yFM+zhudp8sgzqD3pjATYZq6gwS1NEWN1u/2iUindxp/Mt3LLE
 /rO9HiTTUIZq3FSbwAG+Tw5iwM1/w6Wts
X-Google-Smtp-Source: AGHT+IGv7Mvu/BFov21NGL6qsxQkO1r2CgFclJsUeyHE3y00c+V9HUFB/Ha+KK91ridtoCV6CtEi80whdf5Yq3hQMVo=
X-Received: by 2002:a67:ea84:0:b0:4a5:be31:b349 with SMTP id
 ada2fe7eead31-4a751cb4edamr1031289137.28.1729651326347; Tue, 22 Oct 2024
 19:42:06 -0700 (PDT)
MIME-Version: 1.0
References: <20241022001134.828724-1-richard.henderson@linaro.org>
In-Reply-To: <20241022001134.828724-1-richard.henderson@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 23 Oct 2024 12:41:40 +1000
Message-ID: <CAKmqyKP-foRhdJMhmo7+zSqW9K+f7gpHS2W2xGjmG17YVJLNOQ@mail.gmail.com>
Subject: Re: [PATCH v7 00/14] tcg/riscv: Add support for vector
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, dbarboza@ventanamicro.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::92b;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x92b.google.com
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

On Tue, Oct 22, 2024 at 10:11=E2=80=AFAM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Introduce support for the RISC-V vector extension in the TCG backend.
>
> Changes for v7:
>   - Adjust cpuinfo-riscv.c probing for vector support.
>
> In addition to adjusting @left, assert expected value in vlenb.
> I wondered what would happen if a binary built for -march=3Drv64gv
> was run on a host without vector support.  In my case it got SIGILL
> in another constructor before reaching cpuinfo_init().  But that's
> certainly not guaranteed.
>
>
> r~
>
>
> Huang Shiyuan (1):
>   tcg/riscv: Add basic support for vector
>
> Richard Henderson (3):
>   tcg: Reset data_gen_ptr correctly
>   disas/riscv: Fix vsetivli disassembly
>   tcg/riscv: Accept constant first argument to sub_vec
>
> TANG Tiancheng (10):
>   util: Add RISC-V vector extension probe in cpuinfo
>   tcg/riscv: Implement vector mov/dup{m/i}
>   tcg/riscv: Add support for basic vector opcodes
>   tcg/riscv: Implement vector cmp/cmpsel ops
>   tcg/riscv: Implement vector neg ops
>   tcg/riscv: Implement vector sat/mul ops
>   tcg/riscv: Implement vector min/max ops
>   tcg/riscv: Implement vector shi/s/v ops
>   tcg/riscv: Implement vector roti/v/x ops
>   tcg/riscv: Enable native vector support for TCG host

Thanks!

Applied to riscv-to-apply.next

Alistair

>
>  disas/riscv.h                     |   2 +-
>  host/include/riscv/host/cpuinfo.h |   2 +
>  include/tcg/tcg.h                 |   6 +
>  tcg/riscv/tcg-target-con-set.h    |   9 +
>  tcg/riscv/tcg-target-con-str.h    |   3 +
>  tcg/riscv/tcg-target.h            |  78 ++-
>  tcg/riscv/tcg-target.opc.h        |  12 +
>  disas/riscv.c                     |   2 +-
>  tcg/tcg.c                         |   2 +-
>  util/cpuinfo-riscv.c              |  34 +-
>  tcg/riscv/tcg-target.c.inc        | 994 +++++++++++++++++++++++++++---
>  11 files changed, 1022 insertions(+), 122 deletions(-)
>  create mode 100644 tcg/riscv/tcg-target.opc.h
>
> --
> 2.43.0
>

