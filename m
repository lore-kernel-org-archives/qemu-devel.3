Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B826CED24E
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2024 01:18:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxyrJ-0005nO-C5; Mon, 07 Oct 2024 21:17:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sxyr7-0005Xr-JM; Mon, 07 Oct 2024 21:17:42 -0400
Received: from mail-ua1-x930.google.com ([2607:f8b0:4864:20::930])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sxyr5-0008TH-7W; Mon, 07 Oct 2024 21:17:40 -0400
Received: by mail-ua1-x930.google.com with SMTP id
 a1e0cc1a2514c-84f29f2547fso1299169241.0; 
 Mon, 07 Oct 2024 18:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728350256; x=1728955056; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H7XcROQHzaMp4c2pQ5mw9PeqZzqv/Ez36cA9tpdGmts=;
 b=K4fveUZD3Ownoz2Hp8W4uafTCuSyz773qghmSwniEHnRu5K+INIpg9E//PaDf9Hq3c
 UXxBc/RMOqXB3kI8ZZ5MMN+tQdplu5gJOEjVc/6pOgvjn5zypI5iyFXvTpDT8ZhmWdgO
 miVxutxnBKuf2uJRAeQNSMZCCcrWcC0gahorNgTEzw4d8GcVOGzzEJGUMgUwL2ZCDr8v
 +LvKgqQp5R0fF4Fxq2+hz92PHM7++ZO3zDmvq/tP2M2gJPYy7GkJKGl50jm0LRtc0BGQ
 Fv6yrk2MBaLMbdL1RZjdYH/RXFs1FAzf80rMJgqZzwdhbj1jhD5Y0jekp7MVMt/UyhJY
 cNow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728350256; x=1728955056;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=H7XcROQHzaMp4c2pQ5mw9PeqZzqv/Ez36cA9tpdGmts=;
 b=jd4iBBAa7Gwl8qzUw+qoZsTPwmxKMGLMC+BCK/LeM0cvyQSZHiMxRoYROXKD4Sk/B0
 eg9Wk9Jl8UP6B3hlG2DpG3qOWI3YSavApJkNxJPssuB73E2RpIWjWBcxDsM3x4AD+AGT
 8KTQMMJVE8wi5qb9Ibvb/O5FKH5AZDGNiDd1QVwgzmqFG7F0NXep91w66ludTqtCe17G
 RJ7+KlZqq3GO6MgV8AlPHJHjVEzjdrV7BCxKQxibVcVywxLkXscW7ehXqmG67Zj+bph5
 h9XZKiXGgYmACAijjRrPq2Q+97Mufizkbni/ucfeazH3n9E9QWPpd3cFPFZIHeC6bh/3
 nCeQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVOco5m+TvsCdQMQfBDzpJrFnp9dCGlYta9BHdhgMb0K/Q11vS3i2ZLxTX5nBQArdVjdsQs6DbV/vrr@nongnu.org
X-Gm-Message-State: AOJu0YxTBXopQDyKD2y2WVpkWrWiQzxPk0fWVothqQuWH/YnwhJP2+n1
 6vKiynLEOXFtZm80cDprbT4jXwCpf37R4kdY56V5SA9Aho/A/cKt+JvwkefBD1yEIvpGW5rnxNO
 TgwwxvvV7wR1fYlYM5DB1+R0nx3k=
X-Google-Smtp-Source: AGHT+IEOLPrkggHEBAx19gWSsT9KlLjPJMUVyFnd0spGUs/FgRm9s0B7W9n/afgGJ600gGpCv62LkRGItKTF5NVrMas=
X-Received: by 2002:a05:6102:b07:b0:4a3:a0b1:b94 with SMTP id
 ada2fe7eead31-4a4057620eemr8833563137.9.1728350256662; Mon, 07 Oct 2024
 18:17:36 -0700 (PDT)
MIME-Version: 1.0
References: <20240919055048.562-1-zhiwei_liu@linux.alibaba.com>
In-Reply-To: <20240919055048.562-1-zhiwei_liu@linux.alibaba.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 8 Oct 2024 11:17:10 +1000
Message-ID: <CAKmqyKOAnhskgqw1RU-3cSkUUCVRj7B614QT3RWn5t-pD=CziQ@mail.gmail.com>
Subject: Re: [PATCH v7 0/8] target/riscv: Expose RV32 cpu to RV64 QEMU
To: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, palmer@dabbelt.com, 
 alistair.francis@wdc.com, dbarboza@ventanamicro.com, liwei1518@gmail.com, 
 bmeng.cn@gmail.com, TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::930;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x930.google.com
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

On Thu, Sep 19, 2024 at 3:53=E2=80=AFPM LIU Zhiwei <zhiwei_liu@linux.alibab=
a.com> wrote:
>
> From: TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
>
> This patch set aims to expose 32-bit RISC-V cpu to RV64 QEMU. Thus
> qemu-system-riscv64 can directly boot a RV32 Linux.
>
> This patch set has been tested with 6.9.0 Linux Image.
> And add an avocado tuxrun test in tests/avocado.
>
> v7:
>   Remove cpu of "any".
>
> v6:
>   Use TUXRUN test case instead of boot_linux_console
>   Add any32 and max32 cpu for RV64 QEMU
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
> LIU Zhiwei (2):
>   target/riscv: Add max32 CPU for RV64 QEMU
>   tests/avocado: Boot Linux for RV32 cpu on RV64 QEMU
>
> TANG Tiancheng (6):
>   target/riscv: Add fw_dynamic_info32 for booting RV32 OpenSBI
>   target/riscv: Adjust PMP size for no-MMU RV64 QEMU running RV32
>   target/riscv: Correct SXL return value for RV32 in RV64 QEMU
>   target/riscv: Detect sxl to set bit width for RV32 in RV64
>   target/riscv: Correct mcause/scause bit width for RV32 in RV64 QEMU
>   target/riscv: Enable RV32 CPU support in RV64 QEMU

Thanks!

Applied to riscv-to-apply.next

Alistair

>
>  configs/targets/riscv64-softmmu.mak |  2 +-
>  hw/riscv/boot.c                     | 35 +++++++++++++++++++----------
>  hw/riscv/sifive_u.c                 |  3 ++-
>  include/hw/riscv/boot.h             |  4 +++-
>  include/hw/riscv/boot_opensbi.h     | 29 ++++++++++++++++++++++++
>  target/riscv/cpu-qom.h              |  1 +
>  target/riscv/cpu.c                  | 28 ++++++++++++++++-------
>  target/riscv/cpu.h                  |  5 ++++-
>  target/riscv/cpu_helper.c           | 25 +++++++++++++++------
>  target/riscv/pmp.c                  |  2 +-
>  tests/avocado/tuxrun_baselines.py   | 16 +++++++++++++
>  11 files changed, 118 insertions(+), 32 deletions(-)
>
> --
> 2.43.0
>
>

