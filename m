Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29132C3DA49
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2024 02:44:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWRze-0006aL-7b; Tue, 23 Jul 2024 22:44:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sWRzV-0006Yk-7t; Tue, 23 Jul 2024 22:44:34 -0400
Received: from mail-vs1-xe2b.google.com ([2607:f8b0:4864:20::e2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sWRzS-0006Rl-5n; Tue, 23 Jul 2024 22:44:32 -0400
Received: by mail-vs1-xe2b.google.com with SMTP id
 ada2fe7eead31-4928d2f45e2so1363741137.0; 
 Tue, 23 Jul 2024 19:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721789067; x=1722393867; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OjE9bHM+7VMQ1ZrAw/PpnOKSkmeUm2Q6befBxSOhlSs=;
 b=JEn2l081JGRNQCn5lfm2mLUPqdLPFd+zKNb801mJv9uU9r26mxD+OETDK4XchFnq9F
 S4l2z8RHCFxi3Dlaeap5I71x1is0DciXYSmh6dpeMGZlsI8jFHQaOo6v5EwCiSSt/ka3
 E8OaRtsMLa2vEr5RFLd/8FJgPi+6CLEv7H8DdZl9VLaffSdVqgV67Ohmw7bg26Z4uNpc
 ibVqOeQcRhqQ+XqjvcK7vvNinY3ypujj3WK1+5QagTBIwOTuADGo3ZEmGZ0t0/ebwC94
 N9aNH7K9ACiYFIB6o5KPzZL+OQBvRT+KQTAesu6Gzp6nklywSwwXJv3m8l6BI5rFRwFA
 RLIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721789067; x=1722393867;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OjE9bHM+7VMQ1ZrAw/PpnOKSkmeUm2Q6befBxSOhlSs=;
 b=UuiZQuTMmNB+X1v64AF0YK7yKiSlAjCZverK3PVd9mOwsCAdoc0UZB/Adc1byx0Xeh
 GrvUaCupG/UlStFMxLLGlcNqeHxAoDbbc5WWKvMSHOG4HKaPyO+QuR3IS873Ja+lTo6v
 2GQGU/VSPPQhCaBTPuiSeFMvOHaFAqapwj4+BHaIooH1lfY0T3xzKfL5n9rytljWbToZ
 49aiwog800xNWXe944mFQ+i2dDGvumWYKet1Buu9k/M7UQuJq1ji/TjG+vSsq9m7TeES
 uY16UvwtSGSEuSN1YDUKZeHNfHS4ZIZGfChJBhyl7mX75ifCb5caxc/XTTnRRl2E7srY
 COmw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXlN6evAV4i5C5L7QpJY0hPOtV6EjpOm5sJlcdSLJ0Ub5nfhpUwrIYnIBnaq67iJ5F8Q0mCdLNQD9UnC0SXJKfSbbUO4Is=
X-Gm-Message-State: AOJu0YwL4avelq1gVMa27Eo19fChJJkJ2XgwgaSdqYebP9lHxLd6gocN
 dHNjlelunZuTKak5p4iFws4Xn3+4OXuCJyetkHLsfYVCMU3I8tjapcXwJHHyqJ9xPSlEF3Bm3Yv
 DPvdE8yvhDr6Obc+kRA7Kr7zaeP0=
X-Google-Smtp-Source: AGHT+IE7Y28RIaR5uPCQ1b69+Rm8t+h4LkW7MCnC9JOhEq9g/CZPBFicAYAvGCAIVU/MTLqEyv7Qw1NqHdZ62PcYZM0=
X-Received: by 2002:a05:6102:1523:b0:492:94a5:fa1e with SMTP id
 ada2fe7eead31-493c19eb05dmr2033143137.22.1721789067158; Tue, 23 Jul 2024
 19:44:27 -0700 (PDT)
MIME-Version: 1.0
References: <20240719231149.1364-1-zhiwei_liu@linux.alibaba.com>
In-Reply-To: <20240719231149.1364-1-zhiwei_liu@linux.alibaba.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 24 Jul 2024 12:44:01 +1000
Message-ID: <CAKmqyKN=S9o32K0G8k5NqyMs=Xm+gSNBgnbRi3AjbvOubXoDwA@mail.gmail.com>
Subject: Re: [PATCH v6 0/8] target/riscv: Expose RV32 cpu to RV64 QEMU
To: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, palmer@dabbelt.com, 
 alistair.francis@wdc.com, dbarboza@ventanamicro.com, liwei1518@gmail.com, 
 bmeng.cn@gmail.com, philmd@linaro.org, alex.bennee@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e2b;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe2b.google.com
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

On Sat, Jul 20, 2024 at 9:15=E2=80=AFAM LIU Zhiwei <zhiwei_liu@linux.alibab=
a.com> wrote:
>
> This patch set aims to expose 32-bit RISC-V cpu to RV64 QEMU. Thus
> qemu-system-riscv64 can directly boot a RV32 Linux.
>
> This patch set has been tested with 6.9.0 Linux Image.
> And add an avocado tuxrun test in tests/avocado.
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
>
> LIU Zhiwei (2):
>   target/riscv: Add any32 and max32 CPU for RV64 QEMU
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
>  target/riscv/cpu-qom.h              |  2 ++
>  target/riscv/cpu.c                  | 30 +++++++++++++++++--------
>  target/riscv/cpu.h                  |  5 ++++-
>  target/riscv/cpu_helper.c           | 25 +++++++++++++++------
>  target/riscv/pmp.c                  |  2 +-
>  tests/avocado/tuxrun_baselines.py   | 16 +++++++++++++
>  11 files changed, 120 insertions(+), 33 deletions(-)
>
> --
> 2.25.1
>
>

