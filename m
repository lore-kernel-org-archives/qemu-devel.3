Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18A7DCE7AA6
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2024 23:47:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smMBX-0000ch-OD; Thu, 05 Sep 2024 19:46:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1smMBW-0000bn-1c; Thu, 05 Sep 2024 19:46:42 -0400
Received: from mail-ua1-x92a.google.com ([2607:f8b0:4864:20::92a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1smMBU-0003fT-89; Thu, 05 Sep 2024 19:46:41 -0400
Received: by mail-ua1-x92a.google.com with SMTP id
 a1e0cc1a2514c-846d536254fso404059241.1; 
 Thu, 05 Sep 2024 16:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725579999; x=1726184799; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j1FT70JgR5k0fMIt3cRyRiAuGMZMVFzdSs5qW3TiPRM=;
 b=BC2EyyVRNfH8wopUvyYJpnQneZVuNYWKmM3SWQ25JyOcHHR8IdDZlQ+cQz863OKQs0
 o1mMuCgz6Wvxo2Z6v0vlCR9TczVtidCeNlmvO421W3cYuM0rX2Q8r26eK7oAkh0pYitA
 PwLaFyLqu8E1bran/DNyhiAdAzoi2/sbpWYR13Yv5HLvF/sc/1b5ufxBEQm84GH/TNUP
 D5JSQZVR3394Uh0mwEFz/vQNLPRPc25VyA73bFk8zsutZa47xfoqV/3jGY5+SE4PTCXr
 HdVqpyNK3gj99jy7mdYF+uj9jItBwBE+qkM6tDNZTKO6A53dALU8U4Hoe/GDxxAIWRK6
 t83w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725579999; x=1726184799;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=j1FT70JgR5k0fMIt3cRyRiAuGMZMVFzdSs5qW3TiPRM=;
 b=RJPYBNV6JTzEAt/+pxSnrpOsM4OfcVL0lNLHp5ecDP/XJOn8iZ7pJp5TPGxFDT9u2+
 J+vzRRhtQVc+ltGxLOA9BqWsRb47UlFqwQx8KK/u0o7F06CQ3g3IzY3tOHDmqlp6mv7g
 1kKUvTGcJmUQSfQJSoxcih/9dTOjSu4YlKNTHMmWvRm9CLf3vjSdqqzkdCnsA6hhMkim
 1EmbowiU+PLhiBD0FYAX0PHe6zRIyKOBb4RzQjXbUdRcHqqBgSxk5Zoba6Kx8bZIrE+B
 KcC+3XEsU2SbgQC4rLq6TWo3/+8RbbXi+ybKSg3bDtvWl+GcvZdTbckLAuqE1KJPL6mN
 Qyqw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW/hE1KT+z2cheuO0MG0+vYSPcZQeoYo9BEF9UIz/xmezyStxIvYZAjcABWTVEvPNCX0s4QZW+NJwqN@nongnu.org
X-Gm-Message-State: AOJu0YyBHEY758iOQ85Gj8wdxjv86P0KI1czlSQOfLftOl7+ftoWEjf4
 RXEdI0fs33H0Gk0t5sAcb/P3i4UWE+P1gIbz0pfc28KtTr/bojTypIMZVuzqJa49gWIHon2KGO5
 R4h0Kv2glXvFJR3RE2r/3l7IwuBugP70R
X-Google-Smtp-Source: AGHT+IHeEVUp2sJ1pes3HwxUhE05xuvxEkMG8/jhy26XDvS2me9IIo6wYfFQ8vk+XFS+rYZebiH9VkRSSokxcWSk694=
X-Received: by 2002:a05:6102:32cd:b0:493:f097:e5b7 with SMTP id
 ada2fe7eead31-49bde130e3dmr1226872137.1.1725579998569; Thu, 05 Sep 2024
 16:46:38 -0700 (PDT)
MIME-Version: 1.0
References: <20240904142739.854-1-zhiwei_liu@linux.alibaba.com>
In-Reply-To: <20240904142739.854-1-zhiwei_liu@linux.alibaba.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 6 Sep 2024 09:46:12 +1000
Message-ID: <CAKmqyKNerLvtkWFCP=VR=86Ewcg+iPUMTVfgtzYDYGopyEFHfQ@mail.gmail.com>
Subject: Re: [PATCH v3 00/14] Add support for vector
To: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, palmer@dabbelt.com, 
 alistair.francis@wdc.com, dbarboza@ventanamicro.com, liwei1518@gmail.com, 
 bmeng.cn@gmail.com, richard.henderson@linaro.org, 
 TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::92a;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x92a.google.com
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

On Thu, Sep 5, 2024 at 12:29=E2=80=AFAM LIU Zhiwei <zhiwei_liu@linux.alibab=
a.com> wrote:
>
> From: TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>

Can you please mention RISC-V in the cover letter title. Otherwise
it's not obvious that this is RISC-V specific

Alistair

>
> This patch set introduces support for the RISC-V vector extension
> in TCG backend for RISC-V targets.
>
> v3:
>   1. Use the .insn form in cpuinfo probing.
>
>   2. Use reserved_regs to constrain the register group index instead of u=
sing constrain.
>
>   3. Avoid using macros to implement functions whenever possible.
>
>   4. Rename vtypei to vtype.
>
>   5. Move the __thread prev_vtype variable to TCGContext.
>
>   6. Support fractional LMUL setting, but since MF2 has a minimum ELEN of=
 32,
>     restrict fractional LMUL to cases where SEW < 64.
>
>   7. Handle vector load/store imm12 split in a different function.
>
>   8. Remove compare vx and implement INDEX_op_cmpsel_vec for INDEX_op_cmp=
_vec in a more concise way.
>
>   9. Move the implementation of shi_vec from tcg_expand_vec_op to tcg_out=
_vec_op.
>
>   10. Address some formatting issues.
>
> v2:
>   https://lists.gnu.org/archive/html/qemu-riscv/2024-08/msg00679.html
>
> v1:
>   https://lists.gnu.org/archive/html/qemu-riscv/2024-08/msg00205.html
>
> Swung0x48 (1):
>   tcg/riscv: Add basic support for vector
>
> TANG Tiancheng (13):
>   tcg/op-gvec: Fix iteration step in 32-bit operation
>   util: Add RISC-V vector extension probe in cpuinfo
>   tcg/riscv: Add riscv vset{i}vli support
>   tcg/riscv: Implement vector load/store
>   tcg/riscv: Implement vector mov/dup{m/i}
>   tcg/riscv: Add support for basic vector opcodes
>   tcg/riscv: Implement vector cmp ops
>   tcg/riscv: Implement vector neg ops
>   tcg/riscv: Implement vector sat/mul ops
>   tcg/riscv: Implement vector min/max ops
>   tcg/riscv: Implement vector shs/v ops
>   tcg/riscv: Implement vector roti/v/x shi ops
>   tcg/riscv: Enable native vector support for TCG host
>
>  host/include/riscv/host/cpuinfo.h |    3 +
>  include/tcg/tcg.h                 |    3 +
>  tcg/riscv/tcg-target-con-set.h    |    7 +
>  tcg/riscv/tcg-target-con-str.h    |    3 +
>  tcg/riscv/tcg-target.c.inc        | 1047 ++++++++++++++++++++++++++---
>  tcg/riscv/tcg-target.h            |   80 ++-
>  tcg/riscv/tcg-target.opc.h        |   12 +
>  tcg/tcg-internal.h                |    2 +
>  tcg/tcg-op-gvec.c                 |    2 +-
>  tcg/tcg-op-vec.c                  |    2 +-
>  util/cpuinfo-riscv.c              |   26 +-
>  11 files changed, 1062 insertions(+), 125 deletions(-)
>  create mode 100644 tcg/riscv/tcg-target.opc.h
>
> --
> 2.43.0
>
>

