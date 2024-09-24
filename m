Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DA1ECF9C73
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2024 01:44:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ssuaE-0002cP-Tk; Mon, 23 Sep 2024 21:43:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1ssua4-0002aq-G8; Mon, 23 Sep 2024 21:43:09 -0400
Received: from mail-vk1-xa2f.google.com ([2607:f8b0:4864:20::a2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1ssua2-0003l6-0A; Mon, 23 Sep 2024 21:43:08 -0400
Received: by mail-vk1-xa2f.google.com with SMTP id
 71dfb90a1353d-503f943f115so729705e0c.0; 
 Mon, 23 Sep 2024 18:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727142183; x=1727746983; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=faDkYXV1K6yqYIsnvz9xZ5HD/5PpfXc6TjNjAsstgWI=;
 b=cn1D4AWveaRThqvp1H/euTxZrf+vFlRroDbRoizAqy6pDankR3rIVk4Sm7StAk7bFi
 WYCVu8YXAFulhIi/1txiHxhdq7+LRYu62Pj3vcqsQtttmlWDhv3o+UFpW/9BVuCdUXxa
 PUuMvLrmQm2p9b5EZK15YyQzgv3tIs0ct/DW8QwSseUVvgfiicjKy+rDHrtTDVkowYmw
 RidOh3x909u8i7ItTKDbLE38/LUuBIS2FRGwWgHEgA02OKn7cZB8kiQz7vbnx8Mf9B6h
 RyMOKX0FylKyFUMB6q6E/MEr1zyxD16R1na4G5JkEeo6jsqrFMRNP5H6QpTXj85q0DD3
 QZ7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727142183; x=1727746983;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=faDkYXV1K6yqYIsnvz9xZ5HD/5PpfXc6TjNjAsstgWI=;
 b=KDKU1R0qa6TvPK0+WmEF/x6VjTkZelT5Q7VOQ05J62SnbMOlwMTVlON5hzYo8ronxK
 foFOVMfTrA3g0bLxF++ANJGdJoRnldeILgHiDsOw4kMr/fyQa2pTP6n66HVKT8W1sIeH
 GaGYJ5hgN1lL+WLrBMPgREuOgI1VuxnoXdmF6SSeeHItNeZX0P4Di74T5En2HBhv8RaW
 iEWlb7pwDH4MCZn7cehgIlVP2sG2X6n7wcFo33z4Mehg7+Hj6wwMgMbKiB2+bz+85U5U
 jpPFf3Rripvbd/2cTyQZRDy1CjRAFgokDdmlcjFTfdcjEgbMqBex8oEdAq9hG6uHD9TC
 LQJQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXLLkQnm4iTl2EJVVl68AMefID1jYdLFf50Q8jiuDA8NZWLAGC28gTY2r96quA/qea6rDNu85+P11Fp@nongnu.org
X-Gm-Message-State: AOJu0YwwIBHNRGqgwsbV7IKex2Ro2Niq4kTFzCXqpDmwMwSHD0CClWny
 +I+FOyHfKzdEWWUeq5waW+6NlmW8jbBuVuiXEMzOs8WK634904+Gq52JuxzJEmVsKmvP/4PHcuk
 XSHvVFIrMT7K1D6YhyiwCknEwkbw=
X-Google-Smtp-Source: AGHT+IFe0v+wFMqQEJOpbUMQCoPTQICUsVTxQgHMx4Kx6pBe+1nawWcXGubjN8MIaisAKo8LNYNuaMr7Yq/xDmKaGrg=
X-Received: by 2002:a05:6122:3c4a:b0:501:2851:b3bb with SMTP id
 71dfb90a1353d-503e03d8808mr8634152e0c.1.1727142182656; Mon, 23 Sep 2024
 18:43:02 -0700 (PDT)
MIME-Version: 1.0
References: <20240916155119.14610-1-itachis@FreeBSD.org>
In-Reply-To: <20240916155119.14610-1-itachis@FreeBSD.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 24 Sep 2024 11:42:36 +1000
Message-ID: <CAKmqyKOA1uWHm12s8dJ=ZPSW4VOzn=XgisX7sRuJyxC3DaPCrQ@mail.gmail.com>
Subject: Re: [PATCH v7 00/17] bsd-user: Comprehensive RISCV Support
To: Ajeet Singh <itachis6234@gmail.com>
Cc: qemu-devel@nongnu.org, Alistair Francis <alistair.francis@wdc.com>, 
 Mark Corbin <mark@dibsco.co.uk>, qemu-riscv@nongnu.org,
 Warner Losh <imp@bsdimp.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Ajeet Singh <itachis@freebsd.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2f;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa2f.google.com
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

On Tue, Sep 17, 2024 at 1:54=E2=80=AFAM Ajeet Singh <itachis6234@gmail.com>=
 wrote:
>
> Key Changes Compared to Version 6:
> Included "signal-common.h" in target_arch_cpu.h
>
> Mark Corbin (15):
>   bsd-user: Implement RISC-V CPU initialization and main loop
>   bsd-user: Add RISC-V CPU execution loop and syscall handling
>   bsd-user: Implement RISC-V CPU register cloning and reset functions
>   bsd-user: Implement RISC-V TLS register setup
>   bsd-user: Add RISC-V ELF definitions and hardware capability detection
>   bsd-user: Define RISC-V register structures and register copying
>   bsd-user: Add RISC-V signal trampoline setup function
>   bsd-user: Implement RISC-V sysarch system call emulation
>   bsd-user: Add RISC-V thread setup and initialization support
>   bsd-user: Define RISC-V VM parameters and helper functions
>   bsd-user: Define RISC-V system call structures and constants
>   bsd-user: Define RISC-V signal handling structures and constants
>   bsd-user: Implement RISC-V signal trampoline setup functions
>   bsd-user: Implement 'get_mcontext' for RISC-V
>   bsd-user: Implement set_mcontext and get_ucontext_sigreturn for RISCV
>
> Warner Losh (2):
>   bsd-user: Add generic RISC-V64 target definitions
>   bsd-user: Add RISC-V 64-bit Target Configuration and Debug XML Files

Thanks!

Applied to riscv-to-apply.next

Alistair

>
>  bsd-user/riscv/signal.c               | 170 ++++++++++++++++++++++++++
>  bsd-user/riscv/target.h               |  20 +++
>  bsd-user/riscv/target_arch.h          |  27 ++++
>  bsd-user/riscv/target_arch_cpu.c      |  29 +++++
>  bsd-user/riscv/target_arch_cpu.h      | 148 ++++++++++++++++++++++
>  bsd-user/riscv/target_arch_elf.h      |  42 +++++++
>  bsd-user/riscv/target_arch_reg.h      |  88 +++++++++++++
>  bsd-user/riscv/target_arch_signal.h   |  75 ++++++++++++
>  bsd-user/riscv/target_arch_sigtramp.h |  41 +++++++
>  bsd-user/riscv/target_arch_sysarch.h  |  41 +++++++
>  bsd-user/riscv/target_arch_thread.h   |  47 +++++++
>  bsd-user/riscv/target_arch_vmparam.h  |  53 ++++++++
>  bsd-user/riscv/target_syscall.h       |  38 ++++++
>  configs/targets/riscv64-bsd-user.mak  |   4 +
>  14 files changed, 823 insertions(+)
>  create mode 100644 bsd-user/riscv/signal.c
>  create mode 100644 bsd-user/riscv/target.h
>  create mode 100644 bsd-user/riscv/target_arch.h
>  create mode 100644 bsd-user/riscv/target_arch_cpu.c
>  create mode 100644 bsd-user/riscv/target_arch_cpu.h
>  create mode 100644 bsd-user/riscv/target_arch_elf.h
>  create mode 100644 bsd-user/riscv/target_arch_reg.h
>  create mode 100644 bsd-user/riscv/target_arch_signal.h
>  create mode 100644 bsd-user/riscv/target_arch_sigtramp.h
>  create mode 100644 bsd-user/riscv/target_arch_sysarch.h
>  create mode 100644 bsd-user/riscv/target_arch_thread.h
>  create mode 100644 bsd-user/riscv/target_arch_vmparam.h
>  create mode 100644 bsd-user/riscv/target_syscall.h
>  create mode 100644 configs/targets/riscv64-bsd-user.mak
>
> --
> 2.34.1
>
>

