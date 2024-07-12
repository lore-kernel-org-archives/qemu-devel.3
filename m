Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 621D1C3DA45
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2024 01:36:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sS5BP-0002C2-3G; Thu, 11 Jul 2024 21:34:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sS5BN-0002B0-Py; Thu, 11 Jul 2024 21:34:45 -0400
Received: from mail-vk1-xa32.google.com ([2607:f8b0:4864:20::a32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sS5BM-00082N-3U; Thu, 11 Jul 2024 21:34:45 -0400
Received: by mail-vk1-xa32.google.com with SMTP id
 71dfb90a1353d-4f30d197e5cso820980e0c.0; 
 Thu, 11 Jul 2024 18:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720748082; x=1721352882; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XPwA6Gz6CR5g2s2o0AVSkI8pMIHcCfAoOUvo2+T6Yfc=;
 b=jM7mE6jGLEOt2L1ca8PpFmvzqMpuAWYxlVpsPR+tuK6TxlmEdDtR2XByhMATb/rCJq
 Ec+pOFUWkzX1h9c5BvdxVzeZ8IoOgl8XKCUg3dYphe4WVFFYoP1FaFzOrx0LbwiurQAa
 oeoDey2ncXC3yULwWv3V/XiEQ7Bl/1L/9oOo0JYO0bfX3hRga21vR1XzxfQgohGsTh/b
 9gD018Veluy4i3xoNUchXJX432voQqfaC3IJe/MRboyyBu2BnbyUngFtiejd0kWS/OjB
 trzLqot3i9IvB4BWlLzX40Pc9QPoWPqquwq2EffOWGTbFpXUHdo3ITuL+brSBOBASgL4
 Tihw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720748082; x=1721352882;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XPwA6Gz6CR5g2s2o0AVSkI8pMIHcCfAoOUvo2+T6Yfc=;
 b=QPTrIXQtPGJf92TfStmr8zmvkRg/LQAqh2zXxI67NI9vwf8Bv5rqz8a/AVEEzpFmgc
 5+kcYCTUFRPx/7rBx1afdA4BCU5CCPKn/vMriT9/OYr58szHnnjtVTwu1md2n0/ZwP6E
 gFaCIrS65Jf6MgvdR8R2rakcNGcvvDDnjljNkdxXI8r7/4L1hRhMY49PBF+8P/MFvjnq
 iAerA1x3Mr68oIeN0CgcYUu99WG0t1NgVkjifeBWmFMJtwRWrX5TGGy0i02mmLNoWdvo
 i6h7hIhw72tR7Q2C1j2V3wD390CtaHAvrloRKVVMUfMlT0UPK7IFy+0OUZpd2VyHcm5B
 jkOQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWiwTDae8mFLghZR8o34fd6/mgJk/ARh5DP0SX2tRgSNumQXBdjeZrJ8TFES/9gGb0bvB/Gq6qlw0xcUKYpK+k+F0Ryay0=
X-Gm-Message-State: AOJu0YzVNR9URmpsiPxWKA5LUsgeI7tvYBNnbuqg7FScej6FOIa03Iws
 WiBlee7DJKFAWQCH99IHOJ9Ovaa0N7S/gmemvDfe5axnNV0S+d1nMfJCVOS0YDjzlngz8I5j9gN
 qDTS256bNf3wzdPzQhaSVO2Kribc=
X-Google-Smtp-Source: AGHT+IFoPK3VurG0P+oxY94e9sKFjSw3evdFOswdP7qUzRo/4y7DSCDKLBLYI3wirWn8SWK7vUmg4nRH1sASWhqca0g=
X-Received: by 2002:a05:6122:411a:b0:4f2:ffa6:dbd5 with SMTP id
 71dfb90a1353d-4f492518e1cmr1204053e0c.6.1720748081895; Thu, 11 Jul 2024
 18:34:41 -0700 (PDT)
MIME-Version: 1.0
References: <20240710022430.1306-1-zhiwei_liu@linux.alibaba.com>
In-Reply-To: <20240710022430.1306-1-zhiwei_liu@linux.alibaba.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 12 Jul 2024 11:34:15 +1000
Message-ID: <CAKmqyKN_+Hir5W1MPqpRhW_1b3M0kiRufX1M2__KcPrZY5guUg@mail.gmail.com>
Subject: Re: [PATCH v5 0/7] target/riscv: Expose RV32 cpu to RV64 QEMU
To: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, palmer@dabbelt.com, 
 alistair.francis@wdc.com, dbarboza@ventanamicro.com, liwei1518@gmail.com, 
 bmeng.cn@gmail.com, =?UTF-8?B?55Sy5LiA?= <lzw194868@alibaba-inc.com>
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

On Wed, Jul 10, 2024 at 12:27=E2=80=AFPM LIU Zhiwei
<zhiwei_liu@linux.alibaba.com> wrote:
>
> From: =E7=94=B2=E4=B8=80 <lzw194868@alibaba-inc.com>
>
> This patch set aims to expose 32-bit RISC-V cpu to RV64 QEMU. Thus
> qemu-system-riscv64 can directly boot a RV32 Linux.
>
> This patch set has been tested with 6.9.0 Linux Image.
> And add an avocado test in tests/avocado.
>
> # make check-avocado AVOCADO_TESTS=3D/home/jenkins/git/qemu/tests/avocado=
/boot_linux_console.py:BootLinuxConsole.test_riscv64_virt_rv32i
>   VENVPIP install -e /home/jenkins/git/qemu/python/
> /home/jenkins/git/qemu/build/pyvenv/bin/python3 -B /home/jenkins/git/qemu=
/python/scripts/mkvenv.py ensuregroup  --online /home/jenkins/git/qemu/pyth=
ondeps.toml avocado
> mkvenv: checking for avocado-framework(>=3D88.1, <93.0)
> mkvenv: checking for pycdlib>=3D1.11.0
> mkvenv: installing avocado-framework=3D=3D88.1, pycdlib>=3D1.11.0
>   AVOCADO tests/avocado
> Fetching asset from /home/jenkins/git/qemu/tests/avocado/boot_linux_conso=
le.py:BootLinuxConsole.test_riscv64_virt_rv32i
> Fetching asset from /home/jenkins/git/qemu/tests/avocado/boot_linux_conso=
le.py:BootLinuxConsole.test_riscv64_virt_rv32i
> JOB ID     : 8c2e1ff918d3111d078a52eba9956893afaf9e1d
> JOB LOG    : /home/jenkins/git/qemu/build/tests/results/job-2024-07-10T09=
.55-8c2e1ff/job.log
>  (1/1) /home/jenkins/git/qemu/tests/avocado/boot_linux_console.py:BootLin=
uxConsole.test_riscv64_virt_rv32i: PASS (17.50 s)
> RESULTS    : PASS 1 | ERROR 0 | FAIL 0 | SKIP 0 | WARN 0 | INTERRUPT 0 | =
CANCEL 0
> JOB TIME   : 29.50 s
>
> v5:
>   Rebase to master and add tags
>
> v4:
>   Drop UL completely in PATCH v3 2/7, 4/7, 5/7.
>   Avocado: Add "if=3Dnone" to "-drive" option in QEMU command line
>
> v3:
>   Rebase to the master branch
>
> v2:
>   Remove the line that was inadvertently left in PATCH v1 4/6.
>   Add an avocado test.
>
> v1:
>   https://mail.gnu.org/archive/html/qemu-riscv/2024-06/msg00501.html
>
> TANG Tiancheng (7):
>   target/riscv: Add fw_dynamic_info32 for booting RV32 OpenSBI
>   target/riscv: Adjust PMP size for no-MMU RV64 QEMU running RV32
>   target/riscv: Correct SXL return value for RV32 in RV64 QEMU
>   target/riscv: Detect sxl to set bit width for RV32 in RV64
>   target/riscv: Correct mcause/scause bit width for RV32 in RV64 QEMU
>   target/riscv: Enable RV32 CPU support in RV64 QEMU
>   tests/avocado: Add an avocado test for riscv64

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

>
>  configs/targets/riscv64-softmmu.mak |  2 +-
>  hw/riscv/boot.c                     | 35 +++++++++++++++++---------
>  hw/riscv/sifive_u.c                 |  3 ++-
>  include/hw/riscv/boot.h             |  4 ++-
>  include/hw/riscv/boot_opensbi.h     | 29 ++++++++++++++++++++++
>  target/riscv/cpu.c                  | 17 ++++++++++---
>  target/riscv/cpu.h                  |  5 +++-
>  target/riscv/cpu_helper.c           | 25 +++++++++++++------
>  target/riscv/pmp.c                  |  2 +-
>  tests/avocado/boot_linux_console.py | 38 +++++++++++++++++++++++++++++
>  10 files changed, 132 insertions(+), 28 deletions(-)
>
> --
> 2.25.1
>
>

