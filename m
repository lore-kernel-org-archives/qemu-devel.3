Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4447BE77197
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2025 02:59:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tUdKC-0005Jm-IJ; Sun, 05 Jan 2025 21:58:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tUdKA-0005Ja-1i; Sun, 05 Jan 2025 21:58:38 -0500
Received: from mail-vk1-xa32.google.com ([2607:f8b0:4864:20::a32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tUdK8-0006gK-7d; Sun, 05 Jan 2025 21:58:37 -0500
Received: by mail-vk1-xa32.google.com with SMTP id
 71dfb90a1353d-5187f0b893dso4559552e0c.3; 
 Sun, 05 Jan 2025 18:58:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736132314; x=1736737114; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dNaUGDC4SrY5Lt2oalMcDCCw+O1rqRkuNVaphVtFSMU=;
 b=jF7hVJ5Np1BDzOQ9WeVNeXw+5luCpxbyu7/ua5za95XyD9hPHOlURKjn7QAuWWIUwe
 a+shNQB4bKios38eLMn3zlsNqE5BLxq6scWc2lCdPvqcdjhLBJUWa1YM/8VwUll9AS/X
 +n5k6YstjNWX1wMLBBuqMR+oKBwqw429XpIBOVlQjkDiJJfDE/n4Pv7GxoLW9neKS076
 LgM3w34Pxc8nQ7ZGNi/+nVjcduyfiqJ8fvnadFlkyVlkUk6yjvsIx9/prp828oKHi071
 7+F4P3YL/Fl+/uMaf0CeczruUARBwy4wVEXI8HoSEv9Lgj3xigtWsY1kqXXfBJOFz0Og
 q4tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736132314; x=1736737114;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dNaUGDC4SrY5Lt2oalMcDCCw+O1rqRkuNVaphVtFSMU=;
 b=hoyh0SfbkcWtaLR/fhbhd/4yozZRNJHXfklLvFVmgndQ462FtghWCu6ZTn70cuayec
 vah48uy0kwB+fA1ZSbdvvGyJWc7PuWwtvVEjDYzWT5Q/Jq15ppjyFPx6+QebPLEM+X01
 bC7MRcPxTvHDunW7ObVMkyU5iCinVHFrjE5oh5YDs3StC9Rk7EdkHbiJyWN24ZT8yNmU
 tF3/kSUBV8bRzfxnfe/a67min5Ov+9NCe7W+QEpg+/QMcoqVbY/9Xe0VvM6nuT3K1f4B
 shHfpClOwUM4uUjwz9KcbRClArN6ewWWoUwBryV8bx4BBZ3PC5sRc6VqRy0m61ntqPna
 M5Mw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVgM0X/jxqV6u10f6X4fIoaygP1Obr6VZU+uJovT2ew2a2VePXnlkNdrAtXx84XiTF4q9OSsQxJ0ysl@nongnu.org
X-Gm-Message-State: AOJu0YwMjsZb4/aB+qUWbsAx64EHAN5yAEK3UjKQGgbFZMxHId5VJGC6
 WfaMxGQOl60e7CnWxHYaJ6sa/8fFKuBdfmbOxkjFwUg6Aq4QSWgIZskoA8/EX9Pe816UuUX4kKO
 E6NW2wNURyT0QYLvggBLD992GvBE=
X-Gm-Gg: ASbGncsJ66hGMPlMREX4oEypV28bvfJpvhJwcRjLIjekMHWpHSsDe7dFRaeZCieIsQJ
 +z5fbL/m1Fl51+MGChzkF/uAQLLL5XTj3AV9LqzX45/jNNh5n5nFBhh5ocCl0M0PLUuk=
X-Google-Smtp-Source: AGHT+IELCPui90qHLJqUMPOPMaR9OXlEcnpFQyggOzPWce6OvE/jiZAjpbIYxVwGDn0Dal3WkszdTMiGpuTxwIidA+4=
X-Received: by 2002:a05:6102:3308:b0:4b2:48ef:3cf2 with SMTP id
 ada2fe7eead31-4b3b5561e30mr540166137.25.1736132314361; Sun, 05 Jan 2025
 18:58:34 -0800 (PST)
MIME-Version: 1.0
References: <20241218114026.1652352-1-dbarboza@ventanamicro.com>
In-Reply-To: <20241218114026.1652352-1-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 6 Jan 2025 12:58:08 +1000
Message-ID: <CAKmqyKN7-SYhm3iueUDOYD_JdKASpjLdHM8_vpTwipgMF2JJng@mail.gmail.com>
Subject: Re: [PATCH v2 0/9] target/riscv: add 'sha' support
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a32;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa32.google.com
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

On Wed, Dec 18, 2024 at 9:42=E2=80=AFPM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> Hi,
>
> In this version the errors with 'bios-tables-test' qtest are fixed in
> each patch that ended up breaking it. The test will break every time
> we're changing the default riscv,isa DT from the 'rv64' CPU.
>
> This doesn't happen that often so for now I think we'll bite the bullet,
> but if this becomes annoying we'll have to consider another solution,
> e.g. use a more stable CPU for bios-tables-test.
>
> Alistair, I'm resending all patches, including patches 1 and 2 that are
> already applied in riscv-to-apply.next. Feel free to keep the tree as is
> and apply just 3-9.
>
> All patches acked/reviewed.
>
> Changes from v1:
> - patches 3,4,5,6,7,8: change bios-tables-test to match the changes in
>   riscv,isa
> - v1 link: https://lore.kernel.org/qemu-riscv/20241113171755.978109-1-dba=
rboza@ventanamicro.com/
>
> Daniel Henrique Barboza (9):
>   target/riscv/tcg: hide warn for named feats when disabling via
>     priv_ver
>   target/riscv: add ssstateen
>   target/riscv: add shcounterenw
>   target/riscv: add shvstvala
>   target/riscv: add shtvala
>   target/riscv: add shvstvecd
>   target/riscv: add shvsatpa
>   target/riscv: add shgatpa
>   target/riscv/tcg: add sha

Thanks!

Applied to riscv-to-apply.next

Alistair

>
>  target/riscv/cpu.c                |  10 ++++++++++
>  target/riscv/cpu_cfg.h            |   2 ++
>  target/riscv/tcg/tcg-cpu.c        |  30 ++++++++++++++++++++++++++----
>  tests/data/acpi/riscv64/virt/RHCT | Bin 332 -> 390 bytes
>  4 files changed, 38 insertions(+), 4 deletions(-)
>
> --
> 2.47.1
>
>

