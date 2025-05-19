Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 219D8C54756
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 03:26:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uGr86-0007CR-8j; Sun, 18 May 2025 23:25:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uGr84-0007CF-Pb; Sun, 18 May 2025 23:25:28 -0400
Received: from mail-vs1-xe2d.google.com ([2607:f8b0:4864:20::e2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uGr83-0007XS-9x; Sun, 18 May 2025 23:25:28 -0400
Received: by mail-vs1-xe2d.google.com with SMTP id
 ada2fe7eead31-4e2881202f0so313094137.0; 
 Sun, 18 May 2025 20:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747625126; x=1748229926; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L9wg+Kox9TIDdtB4fL1r/gilyrEEOLXQjnByBP5Jono=;
 b=FydXW84DJRjcvX1s+Yg6Pls5b19Al2NyPcClbkf3IOh2wIjWUNjyOFhvYtS0hoNLNY
 XiC5L5v/9ak1YuzWqd9LSVNcQq0+oHtPPqSUs//fx6in/f36HDa+Gf44LSpArupYWipo
 zr+Q01Vc0gVF0G8t7ZvPxQpyalEUlU3W/oGlDc0q8V4pJC85zcC5jJ0pWrpcbvdLJHjX
 Iv9zxR5yqgHkN1j/EEzWl8toBHkeF28EJsJXRaoIGpN07y5RctLom8BCwp4GuGLZ6EgO
 dnwn+gzsVlfYXLuLQNsIw+q1qEgHjEWY57YBvyB1VeAHlxogm+y/R1Penr+JfvG1OXzT
 /tJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747625126; x=1748229926;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=L9wg+Kox9TIDdtB4fL1r/gilyrEEOLXQjnByBP5Jono=;
 b=LPZUO6/ncOwoohcrWF+ywlj3dSXN3hE1OBEL1kH+95geVwca6kR3yywQPJ7ubRolpp
 grU5eYWv7RIJTkPw4EZ12xm5l04bDYwYolXv+o+jN0DGGuy0ScG7Ij2x/TDOqF74uiog
 MJOCf3KwPnDNYvpfp/7hy8che14ntE+Qd0YmOOnqEphDb88Lnl9WapHp7xrVKNG5BT20
 ywTuMbj/qcG/82vgt4CeWyNmNzacdOdkUsu3n6nocls2suHzDzx3RbE8gKlGFpNWWnRg
 AuTrpOAeZQ4Ak0bk1/69MhuYklgE9gWXEpW+x7YBpjAuH3/+tnYbiZfWQDfkpDJ0ridp
 wwkg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXuV1ar7MP42JMuDmNyPw535rE7+lWsaMFJ3UQ3tKaV0Ol6oW88rsggTujTRabaRYBVyvruuVe/Vqvp@nongnu.org
X-Gm-Message-State: AOJu0Yx+6AvrIabPV4d0R0Rkc8HaXBf0TuSOZHh1Rbk27Zi+JCKk1UNo
 vinPEU/54O9+TuFdPSPsWBXhCGfzGiPG9h2RQAqLmnmKwOCaQkbQJiYS0rDtmQbbopgTAFiH7JD
 i+whTEt363IrZpYWR2kQvYhR6b/nhNPk=
X-Gm-Gg: ASbGncsUNtxBnU/K3R9/XXhBxh+KYk2nRFLPzicFocbO23naHR4HdefNXo4Ca5KyBXh
 utts/hq2NmFNsMREPf4OJ6PlhLlNz0nXbG0T6L+HYshfhkhnzSl4QPOCOSc8Inz1HlmsegO5duU
 ZtYsvlSZV+vz34MdP40fEKETewReZK9L3YyqdqUQ7FbdCXoyZz1LR78zJTMpgW9jE=
X-Google-Smtp-Source: AGHT+IGBd8Q8aOevw7/x5Zd+TFrVOwtthu0Pe+Nhew3YiVUJSa4yJWpkIRihEkChW5JMZXjQgdKaR0fKLQ3ndlaFxkA=
X-Received: by 2002:a05:6102:3ca1:b0:4de:81a:7d42 with SMTP id
 ada2fe7eead31-4dfa6af4f05mr12728927137.1.1747625125970; Sun, 18 May 2025
 20:25:25 -0700 (PDT)
MIME-Version: 1.0
References: <20250409025131.3670-1-jim.shu@sifive.com>
In-Reply-To: <20250409025131.3670-1-jim.shu@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 19 May 2025 13:24:59 +1000
X-Gm-Features: AX0GCFv3F7DMDWfwzaRIrcik1wRm1SeIliFbjuKCxzRzcU4RLIFEkLzOw6hYpoo
Message-ID: <CAKmqyKOPOJku+102LtcgYQrt-AhawnWm2QgDQk0tx=iDGnG9_g@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] Several sstc extension fixes
To: Jim Shu <jim.shu@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e2d;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe2d.google.com
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

On Wed, Apr 9, 2025 at 12:53=E2=80=AFPM Jim Shu <jim.shu@sifive.com> wrote:
>
> This patch series contains several sstc fixes:
>
> (1) Writing to ACLINT mtime should also update the period of S/VS-mode
>     timer, just like M-mode timer.
> (2) VSTIP bit of $mip CSR should check both M-mode and H-mode STCE.
> (3) Writing to STCE bit may enable/disable sstc extension in S/VS-mode,
>     which should update the timer and IRQ pending bits.
>
>
> Jim Shu (4):
>   target/riscv: Add the checking into stimecmp write function.
>   hw/intc: riscv_aclint: Fix mtime write for sstc extension
>   target/riscv: Fix VSTIP bit in sstc extension.
>   target/riscv: Enable/Disable S/VS-mode Timer when STCE bit is changed

Can you please rebase this on
https://github.com/alistair23/qemu/tree/riscv-to-apply.next

Alistair

>
>  hw/intc/riscv_aclint.c     |  5 +++
>  target/riscv/csr.c         | 53 ++++++++++++++++++++++++++++++-
>  target/riscv/time_helper.c | 65 ++++++++++++++++++++++++++++++++++++--
>  target/riscv/time_helper.h |  1 +
>  4 files changed, 121 insertions(+), 3 deletions(-)
>
> --
> 2.17.1
>
>

