Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B18DC25B10
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 11:30:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6Ts4-0001Qh-3B; Mon, 13 May 2024 07:29:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1s6Ts2-0001QR-26; Mon, 13 May 2024 07:29:30 -0400
Received: from mail-vs1-xe36.google.com ([2607:f8b0:4864:20::e36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1s6Ts0-0000Op-3B; Mon, 13 May 2024 07:29:29 -0400
Received: by mail-vs1-xe36.google.com with SMTP id
 ada2fe7eead31-47f298cedcfso1322649137.1; 
 Mon, 13 May 2024 04:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715599767; x=1716204567; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f4Dgtj+sRzu9i/CBiOXyf3zOO/a+FxLVTQv+xvnAbLc=;
 b=YHT6NceNhE0pYkMv9KsP1OECqcv8fPnuaQE3MiNsUf6HAFmCMJAGc9T4OT65UwVFDd
 ML/EbhYUnApY9ESb9zWAlFxhyngA13UzJuW7i8dahkhqgzt18oLiwPg3oEJ33m5n3yGR
 m/o0dz+2XwXY46s+8CfES6w57edBgAsm2cqooR432elpc1tz0hTc15Gf3KgWnaMIH63f
 F05rlbHa3mpuvYXHBSwnxqNenpW2INSKz6ynrwZQ/Z+e1YODmYa3P8WkgoZaYmHZNiC8
 GkeQI5qMS2uYd1DrN7h8DKIulawP/LPaPIVZoMsW0S5ZdpmaJeY12f3osnsQvKjLjbjN
 d0eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715599767; x=1716204567;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=f4Dgtj+sRzu9i/CBiOXyf3zOO/a+FxLVTQv+xvnAbLc=;
 b=B84dmEcCkJcWe5lssxyPEei9xhbazpS0ZaIyzN2hwNeYvWxFMfB83lCFt8BZ7fJQHH
 eBIxNObHkwiVBd5Fol+Gc6yNACv9QSv1mYH3Svyd5N6+PpRiMGAEmhpwpjdqHPrRxHlN
 pG28REXuv9QA3C7HzQEFD8QZ++q6c2eqSQovWAJZDLmMnGOmpdRkK8whPWJnM314OEom
 16UquTlBUVjLvsJukQpuqk7XK36WSMB4aoEHPBV+QTq+iUHMknVFXHsBu2MmssIOKChg
 SQYe7TlHCh/32xWK2MLDBkcILLVnEXvJsPihnFiWLyWjntvzMBtqNZ8g94B6YefhAm36
 Dc8A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVtPKM1y1+7I1EFcmOYfCiNB/cDLwps/qwbzZ8UIsgrPaA6XE0nYcSb8R931Rldaam9V+aSH52rhpqS+9JvN2UZhjnH2Lo20cq5JuWBvTyOgkGCi8qzgrwZI1wtFw==
X-Gm-Message-State: AOJu0YyBKQfqCMB7A84Xd5lswMSNvpM5d3DyjebfhlmpwJaa+7zOBxzB
 GKyFlI28pbyHqbF+mG5NEyqe5H59vFInZWdLavMwV7VFVUwjXM3yIYEt8ABXJOhtuSjYib8vRtI
 JpAe8hD0CPJJeY7IatTc4k0YM48U=
X-Google-Smtp-Source: AGHT+IES0bev5VIb3PvzjriWL3Rb8644Jj2C+6/i2rPVWHNtXpVCdyu3Xz5z6IWnY/sap8WvZZtIFOO5Xk3EAIHuwcE=
X-Received: by 2002:a05:6102:5088:b0:47c:549c:d6a3 with SMTP id
 ada2fe7eead31-48077dcd792mr7359303137.2.1715599766728; Mon, 13 May 2024
 04:29:26 -0700 (PDT)
MIME-Version: 1.0
References: <20240511101053.1875596-1-me@deliversmonkey.space>
 <20240511101053.1875596-3-me@deliversmonkey.space>
In-Reply-To: <20240511101053.1875596-3-me@deliversmonkey.space>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 13 May 2024 21:29:00 +1000
Message-ID: <CAKmqyKOHdei-1r46=te7W01qwrOH3ShT4FGcWkMioRMAhLhU9w@mail.gmail.com>
Subject: Re: [PATCH v9 2/6] target/riscv: Add new CSR fields for S{sn, mn,
 m}pm extensions as part of Zjpm v0.8
To: Alexey Baturo <baturo.alexey@gmail.com>
Cc: richard.henderson@linaro.org, space.monkey.delivers@gmail.com, 
 palmer@dabbelt.com, Alistair.Francis@wdc.com, sagark@eecs.berkeley.edu, 
 kbastian@mail.uni-paderborn.de, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e36;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe36.google.com
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

On Sat, May 11, 2024 at 8:12=E2=80=AFPM Alexey Baturo <baturo.alexey@gmail.=
com> wrote:
>
> From: Alexey Baturo <baturo.alexey@gmail.com>
>
> Signed-off-by: Alexey Baturo <baturo.alexey@gmail.com>
>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  target/riscv/cpu.h      |  8 ++++++++
>  target/riscv/cpu_bits.h |  3 +++
>  target/riscv/cpu_cfg.h  |  3 +++
>  target/riscv/csr.c      | 11 +++++++++++
>  target/riscv/machine.c  | 10 +++++++---
>  target/riscv/pmp.c      | 13 ++++++++++---
>  target/riscv/pmp.h      | 11 ++++++-----
>  7 files changed, 48 insertions(+), 11 deletions(-)

This patch generates warnings/errors

include/qemu/compiler.h:70:35: error: invalid operands to binary -
(have =E2=80=98uint32_t *=E2=80=99 {aka =E2=80=98unsigned int *=E2=80=99} a=
nd =E2=80=98uint64_t *=E2=80=99 {aka =E2=80=98long
unsigned int *=E2=80=99})
   70 | #define type_check(t1,t2) ((t1*)0 - (t2*)0)
      |                                   ^
...
../target/riscv/machine.c:167:9: note: in expansion of macro =E2=80=98VMSTA=
TE_UINTTL=E2=80=99
  167 |         VMSTATE_UINTTL(env.menvcfg, RISCVCPU),
      |         ^~~~~~~~~~~~~~

Alistair

