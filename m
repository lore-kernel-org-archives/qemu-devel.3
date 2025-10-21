Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 740D5CCD1A2
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 00:29:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vB0FA-00043l-DP; Mon, 20 Oct 2025 20:28:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vB0F9-00043J-6G
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 20:28:51 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vB0F7-0007j6-BJ
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 20:28:50 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-b403bb7843eso921385866b.3
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 17:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761006527; x=1761611327; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ENQorWcochUpYuLhbwtKxwgqM/w8upG4c3Z/t8s5idg=;
 b=cX+aFCMbvaW2kC21nGAOWuXUvBJFi2MfAK4FBfj0LTm0tEjdaf3qRQguPUCix2xN0/
 v4/qSkb8pC0zXFHFd6mnRihC8IhkPYlR4HQh7SG860iFusjozWovNp3APUPd6zuZlsZr
 EslnUk4PDKb63jW0jazzxh/VKifmWF0ApJFn5SLH5G2xoanQBRz9Ri5Xg18AwF9yhMqF
 EF1MUhMAx2NRTFGjRjpQvX96+k+PlCrhi5vwQ5+TpOjWrQGB+3IS5prGwwyhQomNRR8f
 Zdehto0DmeOYigpR3/albv9Xr4R65RIklZ/FDaZKEnJYXrC/44pW2VssSM8y1cm5H8M9
 VEpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761006527; x=1761611327;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ENQorWcochUpYuLhbwtKxwgqM/w8upG4c3Z/t8s5idg=;
 b=Q1Guws3HaDZ8KyX9gGMoWibEPKGtNiU+qK84Bb5PhmMZ+4ebEQcepW4Be8EnsQWrJm
 vYwrrkxzhNhNOmU1YON72OvQiOINlXnNH5aDv9CIoOUQuIc2Ww4GEWYHWMtqmU7YSr4I
 avEStTskObOcH37fVPOXzF04GOt1bI6d8G1t+1P72rXtDzIiRVSwkC79CXuqBZy7ruWB
 fIsXYAr49ysVo7tiq0kiNj1wjp/ycxv8LI4ZWkZLsVy3f9UGim9rQPqw9rUPvcQVk1oR
 0+1ItqsXHV72LtLf+xRtdnsic9HSYPYwmCS3KKlyocGHOWMbptDK2X4MU8P9fYIU2ik0
 FArA==
X-Gm-Message-State: AOJu0YwivVnvHwiMRIOJPA1It2oP4IGDPNjoj6r0Yr9tE8ZUknl2Fi3k
 LQRTmWuZ6Kv0z2d/1UXPUh8KOp3HmwbVP3ljKUjWyqJRtT0D1TaVblKr5fsOd11dU+fAdItifON
 pINb06Wc1JNeMRErksxmC6n9PV16TVqw=
X-Gm-Gg: ASbGncsnkon4PjNl++LoDhkndfNIIs8bgGNY8VXgyHRYjrO3Kc73rNaEqhSARgur0Z0
 /W9grGnGaFfnqcJBLx1eCOqFqIF6U110PTlFcWmAQln59ZEgyoDE3CpFkIIIkQPXPgNFXZISkJi
 yMYCPeeYgYiPW+ovtnxg1uvjNtT2aF4cZwjwYWs3cWgvRaM/7WtT4FQKNhgis/gHswIx+EeOlvS
 904PFZ+GJ+nVr8tFEV6403elJzvFMGrCyeOp0ZsXbYN869hKxXy36ZbcMf+vcPZ0Xu7yqJ0F57b
 k5VSWJBgzh3n9BM=
X-Google-Smtp-Source: AGHT+IFRhjFwRONb4Meo5PNnoeOUB7nsZrxZz6QU0Itny6sLzh+L/4mCAon7HuxoV9tWR8ULfJGh0SjK447q+QPfY/s=
X-Received: by 2002:a17:907:9492:b0:b3c:4ebc:85e5 with SMTP id
 a640c23a62f3a-b647482d7a7mr1725246566b.59.1761006526889; Mon, 20 Oct 2025
 17:28:46 -0700 (PDT)
MIME-Version: 1.0
References: <20251018154522.745788-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20251018154522.745788-1-djordje.todorovic@htecgroup.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 21 Oct 2025 10:28:20 +1000
X-Gm-Features: AS18NWCyaRkywjv0G5p7cJ9gXsjbMRLqdPI2KMPhj4mXD1xC_35Xtl-V0jZPgiA
Message-ID: <CAKmqyKP4F_M4YZ9qyiTU1SDyhAf8ctsB+oMHh_ZDxPCr2ExW7g@mail.gmail.com>
Subject: Re: [PATCH v13 00/13] riscv: Add support for MIPS P8700 CPU
To: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, 
 "cfu@mips.com" <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>, 
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>, 
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>,
 "philmd@linaro.org" <philmd@linaro.org>, 
 "thuth@redhat.com" <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x62f.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Sun, Oct 19, 2025 at 1:45=E2=80=AFAM Djordje Todorovic
<Djordje.Todorovic@htecgroup.com> wrote:
>
> Update meson.build with the new test name.
>
> Djordje Todorovic (13):
>   hw/intc: Allow gaps in hartids for aclint and aplic
>   target/riscv: Add cpu_set_exception_base
>   target/riscv: Add MIPS P8700 CPU
>   target/riscv: Add MIPS P8700 CSRs
>   target/riscv: Add mips.ccmov instruction
>   target/riscv: Add mips.pref instruction
>   target/riscv: Add Xmipslsp instructions
>   hw/misc: Add RISC-V CMGCR device implementation
>   hw/misc: Add RISC-V CPC device implementation
>   hw/riscv: Add support for RISCV CPS
>   hw/riscv: Add support for MIPS Boston-aia board mode
>   riscv/boston-aia: Add an e1000e NIC in slot 0 func 1
>   test/functional: Add test for boston-aia board

Thanks!

Applied to riscv-to-apply.next

Alistair

>
>  configs/devices/riscv64-softmmu/default.mak |   1 +
>  docs/system/riscv/mips.rst                  |  20 +
>  docs/system/target-riscv.rst                |   1 +
>  hw/intc/riscv_aclint.c                      |  18 +-
>  hw/intc/riscv_aplic.c                       |  13 +-
>  hw/misc/Kconfig                             |  17 +
>  hw/misc/meson.build                         |   3 +
>  hw/misc/riscv_cmgcr.c                       | 248 ++++++++++
>  hw/misc/riscv_cpc.c                         | 265 +++++++++++
>  hw/riscv/Kconfig                            |   6 +
>  hw/riscv/boston-aia.c                       | 476 ++++++++++++++++++++
>  hw/riscv/cps.c                              | 196 ++++++++
>  hw/riscv/meson.build                        |   3 +
>  include/hw/misc/riscv_cmgcr.h               |  50 ++
>  include/hw/misc/riscv_cpc.h                 |  64 +++
>  include/hw/riscv/cps.h                      |  66 +++
>  target/riscv/cpu-qom.h                      |   1 +
>  target/riscv/cpu.c                          |  44 ++
>  target/riscv/cpu.h                          |   7 +
>  target/riscv/cpu_cfg.h                      |   5 +
>  target/riscv/cpu_cfg_fields.h.inc           |   3 +
>  target/riscv/cpu_vendorid.h                 |   1 +
>  target/riscv/insn_trans/trans_xmips.c.inc   | 136 ++++++
>  target/riscv/meson.build                    |   2 +
>  target/riscv/mips_csr.c                     | 217 +++++++++
>  target/riscv/translate.c                    |   3 +
>  target/riscv/xmips.decode                   |  35 ++
>  tests/functional/riscv64/meson.build        |   2 +
>  tests/functional/riscv64/test_boston.py     | 123 +++++
>  29 files changed, 2021 insertions(+), 5 deletions(-)
>  create mode 100644 docs/system/riscv/mips.rst
>  create mode 100644 hw/misc/riscv_cmgcr.c
>  create mode 100644 hw/misc/riscv_cpc.c
>  create mode 100644 hw/riscv/boston-aia.c
>  create mode 100644 hw/riscv/cps.c
>  create mode 100644 include/hw/misc/riscv_cmgcr.h
>  create mode 100644 include/hw/misc/riscv_cpc.h
>  create mode 100644 include/hw/riscv/cps.h
>  create mode 100644 target/riscv/insn_trans/trans_xmips.c.inc
>  create mode 100644 target/riscv/mips_csr.c
>  create mode 100644 target/riscv/xmips.decode
>  create mode 100755 tests/functional/riscv64/test_boston.py
>
> --
> 2.34.1

