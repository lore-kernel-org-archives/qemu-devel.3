Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B794BC47DD9
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 00:26:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reOoS-0007JU-84; Sun, 25 Feb 2024 19:25:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1reOoR-0007JG-90; Sun, 25 Feb 2024 19:25:43 -0500
Received: from mail-ua1-x92d.google.com ([2607:f8b0:4864:20::92d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1reOoP-0008F7-Lw; Sun, 25 Feb 2024 19:25:42 -0500
Received: by mail-ua1-x92d.google.com with SMTP id
 a1e0cc1a2514c-7d5c890c67fso1109665241.0; 
 Sun, 25 Feb 2024 16:25:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708907140; x=1709511940; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KZaJb3Kb5BwuK5vKs/Nf8G0JioWW2HPTga24JGkluiw=;
 b=fbmT9/O7kdE5vgh9Y0y2e5/Yc7mlKP9Xw9cKpX/phK/a91C+Rd2S6NisyJ3U1npq6h
 1Q0zlATWaptYmCQmB97ryZRSUo0tnySGLIBnD3u7YPqxNJ+4kow1qjaUrWQyVnUP+GAF
 M+6ljxS+SHBf+zNEds2dNjRMdsawyKUyHlNJtGon6wl4Zed47zTIJOwHsfw916P3naZv
 50Is01gVEiApMRgKXVQOdAa3lNuGeUIOA4cMarcmEohcht41kkVzV7J6hjQXvfsJy4ub
 BdXXx6qM1Ufyj8JFHpvIyo6zZCrciMzH4uYgd/ap/Aq205SKamzkLybZq4aJSX68bUrG
 vkiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708907140; x=1709511940;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KZaJb3Kb5BwuK5vKs/Nf8G0JioWW2HPTga24JGkluiw=;
 b=JPe9yxe4aAwHD2BPZ3oA6N2OlJwtg9TS46LHePOwpSz+3MwmqwL1gFCAh5BqswDOZg
 /klSDIPZgwKoPw8S0EBUL7wa413tlo5FxR/FyJbyaBq88JFQBiBhAbymUTcHuAWTBPT4
 aMulRBcWgaNk+8eG2KSL91VqpaVYk4/g8askqvAPZ+cuL6J+vDwLTrqMWBJ+gtJd53sN
 s7jOZhfWhDdbinFw5t2ZTtehk6ASv12GeN60nXo+cfbyVhx+E+TkDj7qVlesg9FpyLjq
 HR8ZsTJKnBbeWBaAKjrb/RflW4h+S1QJ7Bsmsc6Yj408yrmwB7+oQZZf1BfKlzVt3laj
 dzfQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV2zDaKGOKtCAh6lw+lTiSCnN+r8ksxb0K192TPAeMt+52T2Pajy4z35ei9YUzTcBOHcK+oGwqqvgw9BrywT43X+KAUicM=
X-Gm-Message-State: AOJu0YxbW3doHeNvXe/UwMzsCuKyqVSprsaZoCBEkRzxMLLXn9NLKkbR
 rgkzWIZ97P1D4LOhzCIyHrUTTZuU/4U8l2VBCXab8ppv5wH5javGGPBUenEtgKKLWOOHqVWREtq
 S9S81caA9oJeTfhl+IOsSlxeUUmA=
X-Google-Smtp-Source: AGHT+IE5YPPk4V0f9yA4fdcBCHUSvMp1RdHOHol+uRBAJLhM9oXpmFgINRj9PGXLwVwtl0OhGiMkr5QDd9Lhw43C1wg=
X-Received: by 2002:a67:f508:0:b0:471:e032:75e2 with SMTP id
 u8-20020a67f508000000b00471e03275e2mr1402358vsn.5.1708907139981; Sun, 25 Feb
 2024 16:25:39 -0800 (PST)
MIME-Version: 1.0
References: <20240223022119.41255-1-alvinga@andestech.com>
In-Reply-To: <20240223022119.41255-1-alvinga@andestech.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 26 Feb 2024 10:25:14 +1000
Message-ID: <CAKmqyKMkXf8mJvwh2vDEGh2fq-5AP2yz2Y9k-UH1D6MuW6CgTA@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] RISC-V: Modularize common match conditions for
 trigger
To: Alvin Chang <alvinga@andestech.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, alistair.francis@wdc.com, 
 bin.meng@windriver.com, liwei1518@gmail.com, dbarboza@ventanamicro.com, 
 zhiwei_liu@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::92d;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x92d.google.com
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

On Fri, Feb 23, 2024 at 12:22=E2=80=AFPM Alvin Chang via <qemu-devel@nongnu=
.org> wrote:
>
> According to RISC-V Debug specification, the enabled privilege levels of

Can you specify what version of the debug spec?

Ideally if you can link directly to the PDF that would be very useful.
There are multiple versions so it's hard to keep track of.

Alistair

> the trigger is common match conditions for all the types of the trigger.
> This series modularize the code for checking the privilege levels of
> type 2/3/6 triggers by implementing functions trigger_common_match()
> and trigger_priv_match().
>
> Additional match conditions, such as CSR tcontrol and textra, can be
> further implemented into trigger_common_match() in the future.
>
> Changes from v1:
> - Fix typo
> - Add commit description for changing behavior of looping the triggers
>   when we check type 2 triggers.
>
> Alvin Chang (4):
>   target/riscv: Add functions for common matching conditions of trigger
>   target/riscv: Apply modularized matching conditions for breakpoint
>   target/riscv: Apply modularized matching conditions for watchpoint
>   target/riscv: Apply modularized matching conditions for icount trigger
>
>  target/riscv/debug.c | 124 +++++++++++++++++++++++++++++--------------
>  1 file changed, 83 insertions(+), 41 deletions(-)
>
> --
> 2.34.1
>
>

