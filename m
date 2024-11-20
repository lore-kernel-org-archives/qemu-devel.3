Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06CE3D6E2BB
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2024 05:52:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDdd6-0005ou-7C; Wed, 20 Nov 2024 00:51:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tDdd4-0005o6-Ka; Wed, 20 Nov 2024 00:51:54 -0500
Received: from mail-ua1-x92e.google.com ([2607:f8b0:4864:20::92e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tDdd2-00021T-PS; Wed, 20 Nov 2024 00:51:54 -0500
Received: by mail-ua1-x92e.google.com with SMTP id
 a1e0cc1a2514c-84ff612ca93so795658241.0; 
 Tue, 19 Nov 2024 21:51:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732081911; x=1732686711; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NslKfnQLV85oeH9OHTfxQWvmrIBII0MLtp06+wKZlhU=;
 b=BoG7Rs+e1rIzETW1h91xPFn/JIE9OCaINksmCV7ZwlwT689H2sWHxOqBeGDrI/sXEa
 6DCAXwXzNzDxkQpJijmExg2+ejDqD2bFsEHhQ55OrHXFoNDAiLzrFRJ0ptSF+Sqga/4h
 vDomqQrUppRTVA3mYLTNO9obkEX/WaUvqA28b/r0D7tp4ishjJP4c0YCPejx81QamHvM
 gfPqANdyl2hpWgRa3zsxScaDiUe8EdDqScxKM4y5LjRUhDVwpiZVWnwWyG1nWXPkN40b
 P1CV+DCICAobZ5whIyOErSq84ADSdmYMjQnMljwDClB3KCPfW6lXiS7UupcoR5iU/cuR
 Ekag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732081911; x=1732686711;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NslKfnQLV85oeH9OHTfxQWvmrIBII0MLtp06+wKZlhU=;
 b=oVBDdR/bD8qNrq3bLaC2LiqUHmUgNOkqbsvhAoC+wpVC0gtko5AJ8bZ5QA1fxd20ei
 oTjFS9Dq6BcfgEha4L1Oq8jt8k+oRwEi4VE8YtrDswiRq6OMmKQcFGuaqlLq03gzqms1
 8ddWTtlQskvTaHT1cLHu03NWgWN3fJFlTrUHhv00Fqm5z60MZ6MhLILL0zOtMiK5eUzC
 KxWbCZPmgJtc9QLLZa0speg2DEAPfhDiPAV+p/OdbROFJRVnxliyQUA6thZv7HDI070X
 dUIie6HFCsJ9dIXzWA7DaBqsSiLGhJWQA5uI1gKMZyDMnfQi0AS+kdQ22E5HL2Ex2fo1
 hJlQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXklD4hbWJRw8XOYA1lQL8w2BLLgggpv9GrHQ4AVpWl6lz+f+ynSvvCeA/I1p/WJE1PFgLyKXKCDS+n@nongnu.org
X-Gm-Message-State: AOJu0YyIY2k+6yJY2TO+iv9coZUBJQ2NRayORVC+8n8QwY8DwX31ms16
 OoYu5vG7feIPfgtMlREYLwF0KKfBGeSm3y2y7uW8PHsMWcfpzBuE6x1IPIJIUeD9GYYcpMF94SP
 V59ivJXmh/3qmDENiQc/WAgSRJLU=
X-Gm-Gg: ASbGncvwlsAJoNUIL1g7hzS8MQKyvxVFgnjo52m0l2gStxafDmbp3WYyJv1QfrnJM9Y
 VL91uaTtyCXxdMnePgURFcsh3fg7tp5kY2mGOrMRVZMh7RNz4+dTq2CwJfFnyxg==
X-Google-Smtp-Source: AGHT+IFJF8ejYbvPxs95GB1Q6chFexrUM4Ne496gvOEgQDIiY0B3U3VnKfHQmF2czL43dBq9RhbM6xsM00mGiuuBq+Q=
X-Received: by 2002:a05:6102:e0f:b0:4ad:592e:7f4c with SMTP id
 ada2fe7eead31-4adaf592a3cmr1580541137.17.1732081911147; Tue, 19 Nov 2024
 21:51:51 -0800 (PST)
MIME-Version: 1.0
References: <20241119191706.718860-1-dbarboza@ventanamicro.com>
In-Reply-To: <20241119191706.718860-1-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 20 Nov 2024 15:51:00 +1000
Message-ID: <CAKmqyKO+-sYRbyP5t2=yr5nAEYnshb7MT0Dnh4rKM=T0gsfE7w@mail.gmail.com>
Subject: Re: [PATCH for-10.0 v2 0/8] riscv: AIA userspace irqchip_split support
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::92e;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x92e.google.com
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

On Wed, Nov 20, 2024 at 5:20=E2=80=AFAM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> Hi,
>
> This second version was rebased with 'master'. Alistair's acks were
> included.
>
> No other changes were made. All patches acked/reviewed.
>
> Changes from v1:
> - rebased with master @ af4c4fd128
> - v1 link: https://lore.kernel.org/qemu-riscv/20241010190337.376987-1-dba=
rboza@ventanamicro.com/
>
>
> Daniel Henrique Barboza (8):
>   hw/intc/riscv_aplic: rename is_kvm_aia()
>   hw/riscv/virt.c: reduce virt_use_kvm_aia() usage
>   hw/riscv/virt.c: rename helper to virt_use_kvm_aia_aplic_imsic()
>   target/riscv/kvm: consider irqchip_split() in aia_create()
>   hw/riscv/virt.c, riscv_aplic.c: add 'emulated_aplic' helpers
>   hw/intc/riscv_aplic: add kvm_msicfgaddr for split mode aplic-imsic
>   target/riscv/kvm: remove irqchip_split() restriction
>   docs: update riscv/virt.rst with kernel-irqchip=3Dsplit support

Thanks!

Applied to riscv-to-apply.next

Alistair

>
>  docs/specs/index.rst          |  1 +
>  docs/specs/riscv-aia.rst      | 83 +++++++++++++++++++++++++++++++++++
>  docs/system/riscv/virt.rst    |  7 +++
>  hw/intc/riscv_aplic.c         | 68 ++++++++++++++++++++++------
>  hw/riscv/virt.c               | 38 +++++++++++-----
>  include/hw/intc/riscv_aplic.h |  8 ++++
>  target/riscv/kvm/kvm-cpu.c    | 43 +++++++++---------
>  7 files changed, 203 insertions(+), 45 deletions(-)
>  create mode 100644 docs/specs/riscv-aia.rst
>
> --
> 2.47.0
>
>

