Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 615B7E77199
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2025 03:37:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tUdv0-0002OH-U1; Sun, 05 Jan 2025 22:36:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tUdux-0002O4-Ad; Sun, 05 Jan 2025 22:36:39 -0500
Received: from mail-ua1-x932.google.com ([2607:f8b0:4864:20::932])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tUduv-0006Vi-Nw; Sun, 05 Jan 2025 22:36:39 -0500
Received: by mail-ua1-x932.google.com with SMTP id
 a1e0cc1a2514c-85ba92b3acfso5810427241.1; 
 Sun, 05 Jan 2025 19:36:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736134596; x=1736739396; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OyhFNG3Olecwae8Zh/b++4z1jqQL+kxO+gyuZuW131g=;
 b=MKOa4QB5JNTUnp0wSookqDzt4rrx+NIOKMnjty+rr9hYU3nNe9wqL3NcVEXROSDqC7
 BiFrRLN0StO6JI2qKJZeC4Yp1DszHtoyR0atAK1KBSS5wCAn1C+9l95Jp/siSji16coH
 EzIYL1E06ofhqY9D6ElArNpGYVx+b3tgJ5AhCPAd3MlQ7Nifyww2EXwjQ55mRYqfDeaQ
 hYQuYQMPTcHFOzM6cRpqsUldmg//8/dEq9Zsvl2WwUKOwMeSekSxD6G2rR8iN3ZJTRph
 /AQ/3O+TCe2v0b5Pulio4tV8KfeFgGXUz05vYvjNIo95q8Nk9RaTpaFTFvplXVOs3jwO
 zVNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736134596; x=1736739396;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OyhFNG3Olecwae8Zh/b++4z1jqQL+kxO+gyuZuW131g=;
 b=l8T0m9xOzd7UYaHRsqygivgmhR8muQXVbKY/qol3iNX8C5YTB7GSD3LTT7NJzj8XJ5
 vZOLO1+etKHzpf8G/aakL7lo4+dMsFWoWZQ2JdLNw/iHAfiJuszncl68bCn3dfb0h+jp
 fz7k3b9jMRsGGLLb1X0Yt+YSFUthE88gNv0YFoAaY38qqSIWPSzybWOPB3HH77PRtOJ2
 ebaB9AQi1yon8GRml5jL3/fgpnyyYTxWsx0nz1dVJZNx56gAacTH8Zwffb3bgo6gRz1N
 IONckbleqC8yDMIi6RAGc44tmhX5mCn7u60+xgBmk27N2GITLOR6va0RQ3bVWtYdR43F
 EGfA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVLSfw5kIKib5GhI3rfXXn4mtpP3bhyMnM4AKb0aXiMdLdhVlkINswAYrAelvbCzaowKCKkQs6iCfdZ@nongnu.org
X-Gm-Message-State: AOJu0Yy0cVuLi+WjX4N+UkqsTnLzKaIpPnDxAzVTiBBxURE+KLzbzj6e
 ujbVbRaq4/UmLf7mUVlUZNoci4QOIlxQbxBHaCgjTAKKyVP/Tq3+DQNWTcbNdEA2/gT3ek5zLjy
 w5pv4jLTq0Z1b6tNyndDSW4K8Viw=
X-Gm-Gg: ASbGncvWXF0KkzKaYN7diR/0Tcu4xHsqJ7WWuCrYzFUNUYO007X83gAH1J59fnBzM5y
 93/ImTnOWtodHSIyy3fhSK0EE474mGpwgfQ20hjWNSBJh6PpQQsMSXrKIlKq5rw4XuHI=
X-Google-Smtp-Source: AGHT+IGbbdCtEgaBGtHcl86K62vtqpabJEvmCU2ZpLNNyRzUwHmh/X0tN2rT5yKpTbXK/A1okuaHOhtoKxg3uD8q7d4=
X-Received: by 2002:a05:6102:6d1:b0:4b1:1b41:ff5f with SMTP id
 ada2fe7eead31-4b2cc320db4mr45424734137.1.1736134596245; Sun, 05 Jan 2025
 19:36:36 -0800 (PST)
MIME-Version: 1.0
References: <20241219174657.1988767-1-dbarboza@ventanamicro.com>
In-Reply-To: <20241219174657.1988767-1-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 6 Jan 2025 13:36:09 +1000
Message-ID: <CAKmqyKNifEXQtfusSACP87eKKTZjMJWM4=Rg2zD_GrLmzWHTTg@mail.gmail.com>
Subject: Re: [PATCH 0/2] target/riscv: add traces for exceptions
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::932;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x932.google.com
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

On Fri, Dec 20, 2024 at 3:47=E2=80=AFAM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> Hi,
>
> Let's add trace capabilities in riscv_raise_exception() to allow users
> of qemu-riscv(32/64) to have a little more information when a SIGILL
> occurs. This is done in patch 2.
>
> Patch 1 is a "look and feel" patch that I figured was worth doing.
>
> Daniel Henrique Barboza (2):
>   target/riscv: use RISCVException enum in exception helpers
>   target/riscv: add trace in riscv_raise_exception()

Do you mind rebasing on
https://github.com/alistair23/qemu/tree/riscv-to-apply.next ?

Alistair

>
>  target/riscv/cpu.h        | 3 ++-
>  target/riscv/op_helper.c  | 9 ++++++++-
>  target/riscv/trace-events | 3 +++
>  target/riscv/translate.c  | 2 +-
>  4 files changed, 14 insertions(+), 3 deletions(-)
>
> --
> 2.47.1
>
>

