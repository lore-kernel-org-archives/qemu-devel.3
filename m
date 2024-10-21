Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB095D3C934
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 01:43:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2hRf-0000kU-M9; Sun, 20 Oct 2024 21:42:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1t2hRe-0000kG-DD; Sun, 20 Oct 2024 21:42:54 -0400
Received: from mail-vs1-xe2a.google.com ([2607:f8b0:4864:20::e2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1t2hRc-0007Vs-NS; Sun, 20 Oct 2024 21:42:54 -0400
Received: by mail-vs1-xe2a.google.com with SMTP id
 ada2fe7eead31-4a47cdaf158so1110425137.0; 
 Sun, 20 Oct 2024 18:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729474971; x=1730079771; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SQIB6wWgEZsU/6BiigKgXreRfCRGYLiYDxBnkGdvsSU=;
 b=UJ2LnrWW55OqW/slOiLzu2V19+91Ht/yjjJt9R8k76qFpO4rIZ7x+rnnioLwv8sEHJ
 UmcX+Pd/OLrH6TrXqnKieltJPOAjhbYzKmwpx6F9Xa+Du14VW1QPmeApP2eFawFKhoh3
 jBQZDNyAaqdbX/Z5vlGon84sQntTiVeeG0m7Fbro02l891BgA4NoZlHrqFQiMkbDC9X4
 RtwZ+AvmmjR7g4l3baCNAVZAEDRlZrFkDasCn/gkMfmDEjyn71xWj6Ozlm6Yc8R6by+O
 6Bb/n3wFgaOKYbJK2kv8DK3yvI4jV/TriyL3YBeOzCzjgS9SQB2kMs7cEIyv81mdc9R3
 7NKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729474971; x=1730079771;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SQIB6wWgEZsU/6BiigKgXreRfCRGYLiYDxBnkGdvsSU=;
 b=X66eKBzGmuuBw3ITXidQcRQctZS9lfTMoUR01FbJWmKnKmjCJZXdfzbj8D2Wf3zytz
 JsyweheYxJAq6AMN0Fl7Ryyx1g/B11NlHJ+JksbMgXjG7pXmadIrs9cAEdCf1vt33wXQ
 z8xCVLlUiyfIIsWaPhuigkNzG6YJ9HZfc6qMCIkLL4KUQvSqMwRcAY5rBNMTp8joHIeH
 0M+7DrHmbKp+4XJdA3ZVKu9LLl/0/ggZf90EzYcMtCyOE8eXiX9e3+EY013+jKaXtxFW
 4E69gzHQhhJjc3LvmSlygC0pktTJpoEqzw/s6Ur4skCKmaK0IFfjSv11566MazLPAMya
 ZwCw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWwElD4hoYd1SRFht4Nipn3SeAnKGf9bV5U8nbJgCloMhsaBgcsBosBOmAkemTPxNXIECJO2QUQQ7YS@nongnu.org
X-Gm-Message-State: AOJu0YzLh9+Nt29bS5qIxqbaYux5SfrVNv8GpI2HcZOHeThAp+UktgOR
 4Gt8gz+1BHKchey3aejoH2xXEBRbBmt7zgEi9GxKzjbgIWG84kJI1CIRLJTBF61PE56Xh1rS7dr
 uVmAeUkgl3JDMqWZKwvKdWNdN36I=
X-Google-Smtp-Source: AGHT+IFEIOCUMyk5kB76Zhp3Ou3DMmiBrcCHfiQF24hIOYMdeSNC/qkW9H4O5JTlrVezaAF7bmhXBOd2pvO6LqyJiR4=
X-Received: by 2002:a05:6102:cc7:b0:4a4:6cf4:3158 with SMTP id
 ada2fe7eead31-4a5d6a5f938mr7430812137.3.1729474971262; Sun, 20 Oct 2024
 18:42:51 -0700 (PDT)
MIME-Version: 1.0
References: <20241016193140.2206352-1-richard.henderson@linaro.org>
In-Reply-To: <20241016193140.2206352-1-richard.henderson@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 21 Oct 2024 11:42:25 +1000
Message-ID: <CAKmqyKOVZ36gHjk=oMQMB77Lmv=iuwSWvQogzNbUOe04ZwY7Rw@mail.gmail.com>
Subject: Re: [PATCH v6 00/14] tcg/riscv: Add support for vector
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 zhiwei_liu@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e2a;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe2a.google.com
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

On Thu, Oct 17, 2024 at 5:33=E2=80=AFAM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Introduce support for the RISC-V vector extension in the TCG backend.
>
> v5: https://lore.kernel.org/qemu-devel/20241007025700.47259-1-zhiwei_liu@=
linux.alibaba.com/
>
> Changes for v6:
>   - Fix problem with TB overflow restart wrt the constant pool.
>   - Fix vsetivli disassembly.
>   - Change set_vtype to precompute all instructions.
>   - Extract one element before comparison in tcg_out_dupi_vec.
>   - Extract one element before comparison in tcg_target_const_match.
>   - Drop 'vm' parameter from most tcg_out_opc_* functions.
>   - Add tcg_out_opc_vv_vi and accept K constants for operations
>     which have .v.i instructions.
>   - Do not expand cmp_vec early.
>   - Fix expansion of rotls_vec.
>
> I've tested this on cfarm95, a banana pi bpi-f3 with 256-bit rvv-1.0,
> with qemu-aarch64 and some vectorized test cases.
>
> Barring further comment, I plan to include this in a PR at the
> end of the week.
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

I have removed the Swung0x48 Signed-off-by line.

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
>  util/cpuinfo-riscv.c              |  24 +-
>  tcg/riscv/tcg-target.c.inc        | 994 +++++++++++++++++++++++++++---
>  11 files changed, 1011 insertions(+), 123 deletions(-)
>  create mode 100644 tcg/riscv/tcg-target.opc.h
>
> --
> 2.43.0
>
>

