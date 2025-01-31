Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D24A0C0218A
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2025 00:26:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tderH-0005Kd-47; Thu, 30 Jan 2025 19:26:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tderD-0005KP-Vu; Thu, 30 Jan 2025 19:26:04 -0500
Received: from mail-ua1-x92f.google.com ([2607:f8b0:4864:20::92f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tderA-0002Mc-Bm; Thu, 30 Jan 2025 19:26:02 -0500
Received: by mail-ua1-x92f.google.com with SMTP id
 a1e0cc1a2514c-85b9f2de38eso310200241.2; 
 Thu, 30 Jan 2025 16:25:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738283158; x=1738887958; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=awS6yZQ3rHQBeJx3bIb/2HovVnbrfwV4w2WJsSlHDjw=;
 b=Y1S+Ss692IGCScRrw83K9+eXcDFLiL/i0x2dxqPnMEOqYMYggygS60KlSyk7M7RnYa
 uDhPKVCzNrSTNqcn/EksrxkshTmov+KVw9JPquV6Lfyf3cJ9sacYae+7oGReoV+Tbu7r
 +ZPfrWY+iAcj6vwkycHjOgBLrgTL8zrUESCLtRRwjQOA0cBnbq/ggVjyRa+AtIDdtrPv
 O7cC/U9G4XH6mmJQuUDVyrZJDcwgvsK2fijA5wqAq/ndKPD2sNHPKWYV0GPtgppugk5F
 o6QHlO1KqhTFK5AGii6gIabVnVVpycr2ewWLvF0NTrZKG4F9/aqnVStCBtQM00WH43Y2
 l0xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738283158; x=1738887958;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=awS6yZQ3rHQBeJx3bIb/2HovVnbrfwV4w2WJsSlHDjw=;
 b=vqG+LrNBO181s+XjdqCJNFdXGsmONFnWkgNjOYcvIrVNgt9tPj0lCGiW4FcvlDjpJZ
 lZumNSniRYzsQLHZvoB3s2AEsfuRanS87CrOg9KPH6dTsWUtGDwvoYtOi/rCH8g9AaH6
 Vucz5uuxixPbm3RxBdIUvO13T9uLFn/5bgiz3MWyW0K1M8nABTmFB7RdHVgESIAzQAiX
 0CnlxA0slyafaG0HdnwFPIOuxprCsOzdpXn1tHCYVE7E+ID1NO4WWqq9v9xF6zSzKpr5
 3iZTBNL9+hDWXbTH/sk/CsNWJ4RBxl2DHEGbakDOctdz1dxFkAo/0no9t511PEOKgArn
 bWeA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUmJcVp73wLqSWKlHcpZY5p5zQEE8BUeM1Yl6otXE4WONZ0cAQGGJbN5h0OKrMr0EnSlSokgs8RisPc@nongnu.org
X-Gm-Message-State: AOJu0Yyt1l9eVqc71rUUrSqRlDkjcH15lo2JtL5FWcs/RbPoLVslI7Nu
 vt8RFUBehNb95Jxt29zjcp3miXgvewGIlLz3VVzx1N2QEcrnVJM62fBFKL5PMDvXp4qOiOS4/PL
 GEEJLZGdmGRC/PqmbgBT5Sk4qUt0=
X-Gm-Gg: ASbGncuVnmTRV3WpxqrkOqGtArCJVaaG/Z3RaqU/vfnmuCuNKY3KWXL3+Pi/AekzRqV
 DsE+vn0gEM2dhR5rAGbJIhZLZMGtYWqZEbdm4Og+MIkca/PSSkQKxqzNS0ZkDZp+TS+7S877UJH
 7eHiV4mI+2UYHIaxdZz2EXyDeoVGY=
X-Google-Smtp-Source: AGHT+IHcdErY6Z8JjWXkEUrMcDDUmg2I5zOgRcIs9au5zKH/GTihJbT9fHhMQe0m16kbs3HdFVrhc7fl2nZdMcQ4u4s=
X-Received: by 2002:a05:6102:508a:b0:4b2:adca:c13a with SMTP id
 ada2fe7eead31-4b9a4f5c277mr8605310137.12.1738283158066; Thu, 30 Jan 2025
 16:25:58 -0800 (PST)
MIME-Version: 1.0
References: <20250115184316.2344583-1-dbarboza@ventanamicro.com>
In-Reply-To: <20250115184316.2344583-1-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 31 Jan 2025 10:25:32 +1000
X-Gm-Features: AWEUYZnvEemTC_xtXUG08-Qql3Ylh0ToFw3SaX7REUzqpHWb-O7Zb9WN7NMKqOs
Message-ID: <CAKmqyKND+dt80wpaePWJRtRcBxUuxtkqPuxRcCRvNwGBZd2_1Q@mail.gmail.com>
Subject: Re: [PATCH v4 0/6] target/riscv: RVA23 profile support
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com, ajones@ventanamicro.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::92f;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x92f.google.com
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

On Thu, Jan 16, 2025 at 4:44=E2=80=AFAM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> Hi,
>
> This new version has tweaks suggested by Drew in v3. No major changes
> were made.
>
> Patches based on alistair/riscv-to-apply.next.
>
> All patches acked.
>
> Changes from v3:
> - patch 3:
>   - fix commit msg
>   - drop the 'profile->enabled &&' check from riscv_cpu_check_parent_prof=
ile()
> - patch 6:
>   - fix RVA23U64 -> RVA23S64 comment in the profile description
> - v3 link: https://lore.kernel.org/qemu-riscv/20250115134957.2179085-1-db=
arboza@ventanamicro.com/
>
> Daniel Henrique Barboza (6):
>   target/riscv: add ssu64xl
>   target/riscv: use RVB in RVA22U64
>   target/riscv: add profile u_parent and s_parent
>   target/riscv: change priv_ver check in validate_profile()
>   target/riscv: add RVA23U64 profile
>   target/riscv: add RVA23S64 profile

Thanks!

Applied to riscv-to-apply.next

Alistair

>
>  target/riscv/cpu-qom.h            |   2 +
>  target/riscv/cpu.c                |  81 ++++++++++++++++++++++++++++--
>  target/riscv/cpu.h                |   3 +-
>  target/riscv/tcg/tcg-cpu.c        |  37 ++++++++++----
>  tests/data/acpi/riscv64/virt/RHCT | Bin 390 -> 400 bytes
>  5 files changed, 109 insertions(+), 14 deletions(-)
>
> --
> 2.47.1
>
>

