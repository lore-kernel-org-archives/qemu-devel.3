Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8C66C4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 03:37:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1Hp6-0008Hh-FC; Sun, 28 Apr 2024 23:37:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1s1Hov-0008Bq-Eo; Sun, 28 Apr 2024 23:36:52 -0400
Received: from mail-vk1-xa2c.google.com ([2607:f8b0:4864:20::a2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1s1Hom-0005sU-KZ; Sun, 28 Apr 2024 23:36:47 -0400
Received: by mail-vk1-xa2c.google.com with SMTP id
 71dfb90a1353d-4daab3cf090so1964602e0c.0; 
 Sun, 28 Apr 2024 20:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714361798; x=1714966598; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EVzcD7HdvVOrulE2dSGxUt2LBzyjlzWuAJgtgmmGrd0=;
 b=BqrsKCpYC0KfEU5oCqzNx9q2DWYbaiZtnRJ/f/Kt2ma3G9OY7cROowaed/v0AGjLmM
 IbzGXanbITUYkq7LcR4qh6b7ICNgI5ogZcI2L1UB2DWuslwk3tC1lYQj3SCha89AzxsR
 CvYnB3zt6JrB3gidKXn7MReERv8vnx+Lzx4QsGa59W7gwmTUckbo69Ll0uDaU65mD06h
 /iWuLUOLrEryLZc7GbJD7d5ynIrMWNXjcUZ4eroJK18j/ODot0NdnQNXJFJOu6u8cm4o
 N+EJjXnRJZFz6o2ib5aAxsYd42iH0tuXUtSvU7WuPSOtVJL31LGlbFfOqIEaIRCWod9p
 GsHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714361798; x=1714966598;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EVzcD7HdvVOrulE2dSGxUt2LBzyjlzWuAJgtgmmGrd0=;
 b=BhtZon2Mi+zM+Jtm3RDX1SB6eJkpT3bn6g1Bye8QcOYK8OQXY5mXSkXDxTktL7eNpb
 7d405EbvM7PvlmXPAer8+xr9qnIZlmu79KPzotRPwrHUIkZ0ibnxPHGtQL86yH7kHZCx
 TRfpGPdQkZue+T3E5CzYrr513XtLoGKSWPXK091DPoSqi94QT2MK7HztN6Y8X+Vj3g+N
 Om/GOs6GV5WYD9UiHSVVxPZGnRUBr+NLM+ELf4+tQS+b54u+qkibtYPHGkxCcF3OV8Ro
 s7kPDXpTll6FKPjKKI5slFMA8iwCou7G9l8wDLy7u7ntnplplf+olLPjBG7ZO4xvz7Pe
 grXA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVj1w2QlpM2qml+ixflYcEFKo8ccHmUNPBpziYcmNNcfE7H6VyVNtmYQkjw5v7DFFBiRtCNi2V2Cu3VtcuUaG6pL+cBf3s=
X-Gm-Message-State: AOJu0YxjRRlx6j2a0DjCjVk6qollO5FdNXdu1/Yrj6Vcp52pJCRfphex
 6fo/TeC5OpWAJoA5GNbjQRqCnpY9p2PKsKQlXS8WXLHZvNJkX+S8ofMJSrQWlaBEw+P3AG47avc
 x+Jg44SDF2Ea7B3drZpUj/a9wNrc6WqHB
X-Google-Smtp-Source: AGHT+IHP6NYHgDHadPmMcGxyCWs4ftJJ1FPKthJJWT9gcJTNbyMpsuWmM3h0DtkUrmJP7HQBUd2IAXCThck76naCGNE=
X-Received: by 2002:ac5:c985:0:b0:4d5:f28b:2c2c with SMTP id
 e5-20020ac5c985000000b004d5f28b2c2cmr5703423vkm.3.1714361798307; Sun, 28 Apr
 2024 20:36:38 -0700 (PDT)
MIME-Version: 1.0
References: <20240328022343.6871-1-jason.chien@sifive.com>
In-Reply-To: <20240328022343.6871-1-jason.chien@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 29 Apr 2024 13:36:12 +1000
Message-ID: <CAKmqyKMFE-RrVj1dvsByq-Dbizuz5ZbMrL7+UZjnXBx-DJ83Nw@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] target/riscv: Support Zve32x and Zve64x extensions
To: Jason Chien <jason.chien@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2c;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa2c.google.com
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

On Thu, Mar 28, 2024 at 12:25=E2=80=AFPM Jason Chien <jason.chien@sifive.co=
m> wrote:
>
> This patch series adds the support for Zve32x and Zvx64x and makes vector
> registers visible in GDB if any of the V/Zve*/Zvk* extensions is enabled.
>
> v2:
>     Rebase onto riscv-to-apply.next (commit 385e575).
> v3:
>     Spuash patch 2 into patch 1.
>     Spuash patch 4 into patch 3.
>
> Jason Chien (3):
>   target/riscv: Add support for Zve32x extension
>   target/riscv: Add support for Zve64x extension
>   target/riscv: Relax vector register check in RISCV gdbstub

Thanks!

Applied to riscv-to-apply.next

Alistair

>
>  target/riscv/cpu.c                      |  4 +++
>  target/riscv/cpu_cfg.h                  |  2 ++
>  target/riscv/cpu_helper.c               |  2 +-
>  target/riscv/csr.c                      |  2 +-
>  target/riscv/gdbstub.c                  |  2 +-
>  target/riscv/insn_trans/trans_rvv.c.inc |  4 +--
>  target/riscv/tcg/tcg-cpu.c              | 33 ++++++++++++++-----------
>  7 files changed, 30 insertions(+), 19 deletions(-)
>
> --
> 2.43.2
>
>

