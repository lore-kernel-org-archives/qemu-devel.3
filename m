Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CEC5C5321E
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2024 00:16:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1siNOb-000644-OH; Sun, 25 Aug 2024 20:15:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1siNOZ-00062T-4V; Sun, 25 Aug 2024 20:15:43 -0400
Received: from mail-lj1-x234.google.com ([2a00:1450:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1siNOX-0002BW-2T; Sun, 25 Aug 2024 20:15:42 -0400
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2f025b94e07so34962021fa.0; 
 Sun, 25 Aug 2024 17:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724631331; x=1725236131; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oZQGHKo4CTY8t0xrs1/quuaQTUi3pqHn3/HcKMXoB6c=;
 b=RNrI+G3nNcSOHUBgE68nwBt9qHCpQjuP7WTM6eBIVzsXg9TmDbYHFHihlDI9RA7zSP
 Dqv93J5PeSB9fQzNfo4HEFj1ojgolaL8OisJK95SpQR4XQScfh1arkpUhCdOHWnIe8HP
 3doF+LYilspzWx8uAI/xtr2rpDKPeP1b1CU9U1So176rvcgBie+VyYhJHLbJFL1rXGq1
 1r4a0x7zA+pGNiGDfDxyqu2aOS1tP0tMXV+blRJYAwCRjCftcAovsqb3Nfr0r/6ZdlKa
 NSyrmQLy2PJs49qiax0i2KQ4hy9E08kZsRNPeaeUk2udEtq7tykMAPKi8dvyZ8nBSF0L
 ZdZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724631331; x=1725236131;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oZQGHKo4CTY8t0xrs1/quuaQTUi3pqHn3/HcKMXoB6c=;
 b=OeGlRboxBhug/+E6swjlgMnaskJpiH4us+19Rbkf0pPZ8QlFRS4q3RZbYiIseLOwUA
 58cuJgLfSWPVjmc/UwqOBk07g3AXF3EHmQ4Suw6MGaOEiPWQarny0KE8hO71Bf1ItE2q
 a1iUaQWLoNY5lGXhkD9i8E0N315cFPuiO6MgmC78kYuGHnX59sGFFrmTyGEwGOLRy+OY
 /Xy7TMc/e7MbGVyrdCaEpa69TWrrqxpxZhlidvAJrvnQFrGSrSbXVpxHva3aA+rwnZUQ
 Pg1Kc8mCAtJwdu3QA9+yh6rGFjgyk4xJ+jInHdQpX83iGaVRnWjXTTFLGEXfORS55yh6
 x1Sw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXlS3GoJ3SDGKP+N7qf9Di4kO/8p9GZD/LsdV5vPd7WGsgBOTJQV/7lPZMXAuJong79EdaZu42915IN@nongnu.org
X-Gm-Message-State: AOJu0Yy1ZRszPO4alrlXdzFLqNv/DEbyYyLByWVQJC2XbQR/97JAI52e
 g/RB0wL7nsW6CiGJZR98WxIm5j2lu/bm2Ew0QKbfcACVedEB6627g6guCk1sUsu0ZopAiGs9Qhk
 8osZKXemYWzUolg9OOf75ZzNPEps=
X-Google-Smtp-Source: AGHT+IH1egHUcOPQYyzQyayrzLIywRBd0KwpwIfobtAne4LRyYSZLWgzIkPoLTZ7yFnvQHQnDXfy+LU5dbc2VqEa5g4=
X-Received: by 2002:a2e:9a8e:0:b0:2ef:18ae:5cc2 with SMTP id
 38308e7fff4ca-2f4f490dd89mr46385611fa.21.1724631330571; Sun, 25 Aug 2024
 17:15:30 -0700 (PDT)
MIME-Version: 1.0
References: <20240824173338.316666-1-dbarboza@ventanamicro.com>
In-Reply-To: <20240824173338.316666-1-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 26 Aug 2024 10:15:03 +1000
Message-ID: <CAKmqyKN6THm3yEYPB5g-65oz6Dv3R9upJwjfMSDgBARgerd1qQ@mail.gmail.com>
Subject: Re: [PATCH] target/riscv/tcg/tcg-cpu.c: consider MISA bit choice in
 implied rule
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com, Frank Chang <frank.chang@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::234;
 envelope-from=alistair23@gmail.com; helo=mail-lj1-x234.google.com
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

On Sun, Aug 25, 2024 at 3:34=E2=80=AFAM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> Gitlab issue [1] reports a misleading error when trying to run a 'rv64'
> cpu with 'zfinx' and without 'f':
>
> $ ./build/qemu-system-riscv64 -nographic -M virt -cpu rv64,zfinx=3Dtrue,f=
=3Dfalse
> qemu-system-riscv64: Zfinx cannot be supported together with F extension
>
> The user explicitly disabled F and the error message mentions a conflict
> with Zfinx and F.
>
> The problem isn't the error reporting, but the logic used when applying
> the implied ZFA rule that enables RVF unconditionally, without honoring
> user choice (i.e. keep F disabled).
>
> Change cpu_enable_implied_rule() to check if the user deliberately
> disabled a MISA bit. In this case we shouldn't either re-enable the bit
> nor apply any implied rules related to it.
>
> After this change the error message now shows:
>
> $ ./build/qemu-system-riscv64 -nographic -M virt -cpu rv64,zfinx=3Dtrue,f=
=3Dfalse
> qemu-system-riscv64: Zfa extension requires F extension
>
> Disabling 'zfa':
>
> $ ./build/qemu-system-riscv64 -nographic -M virt -cpu rv64,zfinx=3Dtrue,f=
=3Dfalse,zfa=3Dfalse
> qemu-system-riscv64: D extension requires F extension
>
> And finally after disabling 'd':
>
> $ ./build/qemu-system-riscv64 -nographic -M virt -cpu rv64,zfinx=3Dtrue,f=
=3Dfalse,zfa=3Dfalse,d=3Dfalse
> (OpenSBI boots ...)
>
> [1] https://gitlab.com/qemu-project/qemu/-/issues/2486
>
> Cc: Frank Chang <frank.chang@sifive.com>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2486
> Fixes: 047da861f9 ("target/riscv: Introduce extension implied rule helper=
s")
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Thanks!

Applied to riscv-to-apply.next

Alistair

