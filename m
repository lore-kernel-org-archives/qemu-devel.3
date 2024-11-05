Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3592D1CA19
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 03:38:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8AOj-0001BR-89; Mon, 04 Nov 2024 22:38:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1t8AOh-0001Ay-VL; Mon, 04 Nov 2024 22:38:28 -0500
Received: from mail-vk1-xa31.google.com ([2607:f8b0:4864:20::a31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1t8AOg-0000Ut-DF; Mon, 04 Nov 2024 22:38:27 -0500
Received: by mail-vk1-xa31.google.com with SMTP id
 71dfb90a1353d-50d32d82bd8so1543891e0c.1; 
 Mon, 04 Nov 2024 19:38:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730777905; x=1731382705; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PZSgRnzBOZa/Qscj4ZeSqmsdXbQm+WfJ6DPvRjrBho4=;
 b=TSbzQOG80rxBrmqmS+OkaJUvNZGVsgNNNtOTQylp9ij6IfSbGW+oq+cG/bB3FxsDnl
 wvuWzY+cvKWS5Qq3GV2NaySI28Elhup6LNCVvfk44NS+Q5asRyN4G+QffZ4R8TojDkjL
 Nswe70NUC8QC+Yj+spJ3u+upxEi3bI9nxkssRZ+LGS9XsJc3aSA2KCOugREs6TqH2fgo
 fUpF0stZFTqlsfjx2FZnHFLbVjFYd46Cn5snTTgMJPKAkhwXnuQjKgn7cRmh/ZhTfcFt
 W0TRkT0sAooGNJ69VN73KUir23Nze0d53LI7dsjQ+Z0rK7DaEMXLfvTlAlSVxVtmLXfO
 idOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730777905; x=1731382705;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PZSgRnzBOZa/Qscj4ZeSqmsdXbQm+WfJ6DPvRjrBho4=;
 b=u4JfkVAZExwaBbuHNYrXsJ3f2G1mWjqdxMJRj58U7ve6WluzVXSxubCpA8OXSatSeT
 sbzc72+MXVR9+HpfAxJl7zvQ5nQDN9WM+6OXByNitkvsJbqQriQ9Nxvi9gk3vSvG91hG
 7XzOjqJDR46NF5sklmLoHx+MwDQiKId3zdDZjEyw+kmSFaKOFy/OixkfO2Dgs5IO5otJ
 dRi7bJFZtONI4+bQPkff7louInzJNtfeN3jGvwPXBKc9iRTD4u0dIhWBX7/gzbXFZ91x
 dKDnYj+Rov9Wn8lL1TFcKEhiI88VFmTLKODJ8iSqHz9M3op10Jwk5ppxzDBPb1U/yMfa
 solw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUoVzP0dJTRNGY4fdsDl1rrzyOViyBut1JRjTXTw1Sx5KpOK2zTKeqbHnqULCWWFpNAxvp6e/QWxcWP@nongnu.org
X-Gm-Message-State: AOJu0YzSu3JA9lgj33ZETcR95jeB/MliaZVyXJDqDc/xk92Xv3iyV2R4
 5zz07HAWo1VQ/9j+XtIPmBo6eXrCT5Vv4xgGJfbxMqe5PeXF3M+KdUW6q4/DYLrI6CISnZNYhGm
 /zsuOdovGxtqorykIqvK108YW/Z8=
X-Google-Smtp-Source: AGHT+IGgIcMLF/qjTuCKISpFFleDGiCMEy/TyP1D4SE0rUWfeBRx07/SLEgkvspsz60dY6eTNa1UmvqAU/fmyqBLJ0Y=
X-Received: by 2002:a05:6122:1d4c:b0:50d:a31c:678c with SMTP id
 71dfb90a1353d-5106ae6d944mr17639708e0c.2.1730777904530; Mon, 04 Nov 2024
 19:38:24 -0800 (PST)
MIME-Version: 1.0
References: <20240918171412.150107-1-max.chou@sifive.com>
In-Reply-To: <20240918171412.150107-1-max.chou@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 5 Nov 2024 13:37:58 +1000
Message-ID: <CAKmqyKML3BnmcNXNRmxAbwFzbTeC+4x+kwqtOhQCzVRcnDqytw@mail.gmail.com>
Subject: Re: [PATCH v6 0/7] Improve the performance of RISC-V vector
 unit-stride/whole register ld/st instructions
To: Max Chou <max.chou@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 richard.henderson@linaro.org, negge@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a31;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa31.google.com
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

On Thu, Sep 19, 2024 at 3:15=E2=80=AFAM Max Chou <max.chou@sifive.com> wrot=
e:
>
> Hi,
>
> This version fixes several issues in v5
> - The cross page bound checking issue
> - The mismatch vl comparison in the early exit checking of vext_ldst_us
> - The endian issue when host is big endian
>
> Thank for Richard Henderson's suggestions that this version unrolled the
> loop in helper functions of unmasked vector unit-stride load/store
> instructions, etc.
>
> And this version also extends the optimizations to the unmasked vector
> fault-only-first load instruction.
>
> Some performance result of this version
> 1. Test case provided in
>     https://gitlab.com/qemu-project/qemu/-/issues/2137#note_1757501369
>     - QEMU user mode (vlen=3D128):
>         - Original:   ~11.8 sec
>         - v5:          ~1.3 sec
>         - v6:          ~1.2 sec
>     - QEMU system mode (vlen=3D128):
>         - Original:   ~29.4 sec
>         - v5:          ~1.6 sec
>         - v6:          ~1.6 sec
> 2. SPEC CPU2006 INT (test input)
>     - QEMU user mode (vlen=3D128)
>         - Original:  ~459.1 sec
>         - v5:        ~300.0 sec
>         - v6:        ~280.6 sec
> 3. SPEC CPU2017 intspeed (test input)
>     - QEMU user mode (vlen=3D128)
>         - Original: ~2475.9 sec
>         - v5:       ~1702.6 sec
>         - v6:       ~1663.4 sec
>
>
> This version is based on the riscv-to-apply.next branch(commit 90d5d3c).
>
> Changes from v5:
> - patch 2
>     - Replace the VSTART_CHECK_EARLY_EXIT function by checking the
>       correct evl in vext_ldst_us.
> - patch 3
>     - Unroll the memory load/store loop
>     - Fix the bound checking issue in cross page elements
>     - Fix the endian issue in GEN_VEXT_LD_ELEM/GEN_VEXT_ST_ELEM
>     - Pass in mmu_index for vext_page_ldst_us
>     - Reduce the flag & host checking
> - patch 4
>     - Unroll the memory load/store loop
>     - Fix the bound checking issue in cross page elements
> - patch 5
>     - Extend optimizations to unmasked vector fault-only-first load
>       instruction
> - patch 6
>     - Switch to memcpy only when doing byte load/store
> - patch 7
>     - Inline the vext_page_ldst_us function
>
> Previous versions:
> - v1: https://lore.kernel.org/all/20240215192823.729209-1-max.chou@sifive=
.com/
> - v2: https://lore.kernel.org/all/20240531174504.281461-1-max.chou@sifive=
.com/
> - v3: https://lore.kernel.org/all/20240613141906.1276105-1-max.chou@sifiv=
e.com/
> - v4: https://lore.kernel.org/all/20240613175122.1299212-1-max.chou@sifiv=
e.com/
> - v5: https://lore.kernel.org/all/20240717133936.713642-1-max.chou@sifive=
.com/
>
> Max Chou (7):
>   target/riscv: Set vdata.vm field for vector load/store whole register
>     instructions
>   target/riscv: rvv: Replace VSTART_CHECK_EARLY_EXIT in vext_ldst_us
>   target/riscv: rvv: Provide a fast path using direct access to host ram
>     for unmasked unit-stride load/store
>   target/riscv: rvv: Provide a fast path using direct access to host ram
>     for unit-stride whole register load/store
>   target/riscv: rvv: Provide a fast path using direct access to host ram
>     for unit-stride load-only-first load instructions
>   target/riscv: rvv: Provide group continuous ld/st flow for unit-stride
>     ld/st instructions
>   target/riscv: Inline unit-stride ld/st and corresponding functions for
>     performance

Thanks!

Applied to riscv-to-apply.next

Alistair

>
>  target/riscv/insn_trans/trans_rvv.c.inc |   3 +
>  target/riscv/vector_helper.c            | 598 ++++++++++++++++--------
>  2 files changed, 400 insertions(+), 201 deletions(-)
>
> --
> 2.34.1
>
>

