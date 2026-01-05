Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A575C2A073
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Jan 2026 02:36:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vcaRt-0000eB-KB; Sun, 04 Jan 2026 21:36:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vcaRs-0000Zn-29
 for qemu-devel@nongnu.org; Sun, 04 Jan 2026 21:36:00 -0500
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vcaRq-0006F8-EP
 for qemu-devel@nongnu.org; Sun, 04 Jan 2026 21:35:59 -0500
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-64d1ef53cf3so14652353a12.0
 for <qemu-devel@nongnu.org>; Sun, 04 Jan 2026 18:35:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767580556; x=1768185356; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1l5U3tuMctwZOEz6gnTqYSg0Y7tsjjD/ok3JAMsXqYE=;
 b=fqApm3Ci5rY2yG/myt9XnBpyv9KbpBS7ob341O1WxiLs//uN80MwWrdn0ZPpabpnK0
 BjQRad+zzHVN8RnAF2Zt22FVbjm34pkAVC2AV5emd22Y6jo7nOCMN25MrSUXrDBq4IZd
 9DJUv/cizHxu5NHgDblJY721/hD1+Y2VXayp7OBlYWkwKqIqToOfhFIn0GhuK1D9FwWQ
 8qLgbmj7Rto1iam2jvJdvFjG1kDl9lRLJoldQj4mw64WGFYPnBIHgDJzo+D5BoldDeXb
 JgwYaXl/ccjao6NcFAD2zIYb8yC2fPhfIyOcyzlFsymMBYPehm3rwT+VvieSDM2u4sFu
 TSIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767580556; x=1768185356;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1l5U3tuMctwZOEz6gnTqYSg0Y7tsjjD/ok3JAMsXqYE=;
 b=KvHFt6K6+urpzO1JW26I/X/Y6kDUNZM8axmxnVp1oz25q79OvrAsmbz2KW2PtIgY2E
 5VqIRTBJa84Gpj/YN1YQkK2CYJGV1Uozk18VSkizTuB4h5mC8P6hbdrL9agquWMEoEIK
 YpmfxjYb1EjPdamvEpAbvKcrTFkbC+FiPphWyGTRYZQ6LY/iDuybxnMHSChgcMfH0RX7
 cPxiMz77G00VX086OtyE5/DV8TYnV1v1lN7YH7gmQ7rM8vwVMO0CjxechfLemXJFluX/
 QVUkspb8tXq2PVX1PeuCPAA9Gg/rV0DEWAtqXY8/W56btGA5ngJ3X4AKIIEZYXg9qNaY
 UDfw==
X-Gm-Message-State: AOJu0YwmybyyBbrFBtoWrTX36Pd/VrvXejnsrGVIsMHE3ItQoeMpVNWR
 SPjtFgP+i4ecKLAm0L0/ILm9dih8I94FTNdJdG/0rE1u9r6L1cyv43NxD7cCbErcb8lLh9o8izg
 CyOsHZvdXcEzBJHL0ns2diC7U95g1AsQ=
X-Gm-Gg: AY/fxX6YApb8aB3Ss8aLgK+BEwIyNHCpSd2W3sUo3tU5RQlmSMkTSlByQx/lIw2vDyK
 91XoEgMftXzFbg07hQT9zPdMM2xYW370rlRbofvyBp0V/nLh4x4gv4I9URQH+eQlgjSOPMRbGq/
 OMFmzgSZMJkCUaQlxSN0ZF0LZLE2kpIUhHXgsdE6ifKDY6hsTuC8NPikHpXq4Q2fPeB6SbBb1NA
 /IREkMGcO9AG9UlcRnzv2ILQnSwVLtsWGXtO4kq07ZgcmKjzsozO6rFtT564+ArjBJq+yP/YdXO
 hO6bGbok07kgCcyMEIBiSTccQg==
X-Google-Smtp-Source: AGHT+IHrR7AFwMbwOrr/SB4qARVeqKOhvjnFj0TAzamUsbRa6IovhJJMEx9dR3HMUkemqngGfscBh2n2mAITnM9Kuh8=
X-Received: by 2002:a17:907:9722:b0:b83:13ac:a3c4 with SMTP id
 a640c23a62f3a-b8313aca9dcmr3660501866b.52.1767580555986; Sun, 04 Jan 2026
 18:35:55 -0800 (PST)
MIME-Version: 1.0
References: <20251223094739.1983381-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20251223094739.1983381-1-djordje.todorovic@htecgroup.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 5 Jan 2026 12:35:29 +1000
X-Gm-Features: AQt7F2qY91TxEVy-e3dxfgGYc5d5EBidzT2yrsvwNI22LphiDcGKg8CGEZvIjkU
Message-ID: <CAKmqyKMR_3z1jNTBDhAJRPWqVohaaFP3LYPbxxApXOH8ZwsLWw@mail.gmail.com>
Subject: Re: [PATCH v15 00/12] riscv: Add support for MIPS P8700 CPU
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
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x530.google.com
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

On Tue, Dec 23, 2025 at 7:47=E2=80=AFPM Djordje Todorovic
<Djordje.Todorovic@htecgroup.com> wrote:
>
> Rebased on top of master branch and removed patches that are merged.
>
> Djordje Todorovic (12):
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
>
>  configs/devices/riscv64-softmmu/default.mak |   1 +
>  docs/system/riscv/mips.rst                  |  20 +
>  docs/system/target-riscv.rst                |   1 +
>  hw/misc/Kconfig                             |  17 +
>  hw/misc/meson.build                         |   3 +
>  hw/misc/riscv_cmgcr.c                       | 243 ++++++++++
>  hw/misc/riscv_cpc.c                         | 265 +++++++++++
>  hw/riscv/Kconfig                            |   6 +
>  hw/riscv/boston-aia.c                       | 476 ++++++++++++++++++++
>  hw/riscv/cps.c                              | 196 ++++++++
>  hw/riscv/meson.build                        |   3 +
>  include/hw/misc/riscv_cmgcr.h               |  48 ++
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
>  27 files changed, 1988 insertions(+)
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

This has a few build errors, things like

../hw/misc/riscv_cmgcr.c:18:10: fatal error: hw/sysbus.h: No such file
or directory
  18 | #include "hw/sysbus.h"
     |          ^~~~~~~~~~~~~
compilation terminated.
[528/1079] Compiling C object li

I tried fixing those for you, but there are other build errors that
need to be fixed.

Alistair

>
> --
> 2.34.1

