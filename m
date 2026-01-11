Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5F81D25031
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Jan 2026 22:51:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vf4GY-0006io-4O; Sun, 11 Jan 2026 17:50:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vf4GV-0006i8-KI
 for qemu-devel@nongnu.org; Sun, 11 Jan 2026 17:50:32 -0500
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vf4GS-0006eU-Di
 for qemu-devel@nongnu.org; Sun, 11 Jan 2026 17:50:29 -0500
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-64d30dc4ed7so11324998a12.0
 for <qemu-devel@nongnu.org>; Sun, 11 Jan 2026 14:50:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768171826; x=1768776626; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Iwc5CEZAIs6a6mkAV8FZ/NCuxcwSUhoTQWC4ljnbAkQ=;
 b=QXYrsYRZI5OChLxLe/EWMiTPujmALfFsnvoqZu/Ht8hWp/VdWbA4NbdkrTYucaUxtL
 sr+vQjMRYAmhpOY7aP/c0AP3RvEZzoYFc9zwruv5AYsmrhEanSflkFHG6HJufPCEHXYY
 6ixGivMEtYcG1TrQF3unBTXsM108giXbUIHnx886MvXj0yJTKGAjRFIjpRuRav9eqShc
 uyY86QCHqXwyLH5OE6OoQQgWxkOEYjNSdcI1HkzZFd0hAXAZahl1ebbDId6Ts0TA3dQg
 lAj/3t+wtDomts6Zjb6taWB7uOzz0rGhyiBLX/+9xb8lbDonn6RsAmpfZqc7Me78CgR2
 3sDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768171826; x=1768776626;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Iwc5CEZAIs6a6mkAV8FZ/NCuxcwSUhoTQWC4ljnbAkQ=;
 b=DnZwDxNSl/mGhZzfc2ZCyn9VtU5dDbEq2/WaPDPAJjeAZCbC0yiJSfN14ORvtPjj1v
 Gk7AC0LQICIiNccuVhH4ve97KMW6Lzuj8pAQATgYmaE+LCCSmcJT4918MG4wytkY84kr
 C/BuqjUbKQOKK3+RxsayFMFHGizfZhaUlCFJwkN7ZCukWS+YypOPTK5RyuOXDRlshVq4
 5bJPtSCZhSx7xTCKHIGhGsr+/pBUjL4W+NP9UwE9LxoRnGQCp48AAskpNHnJj/TKg9/e
 SXJtX9ZLN9uHXFwPvPwBJE/kXhfBqSvMUSO1qUZXDuYVpm5sy2hHSBoaG2w360MWdq2a
 liFg==
X-Gm-Message-State: AOJu0YxFHQKpTp7++3OaF+jbeIg+W2Z+9qgIO2M5y6h5jgvapN41+D/K
 zIf2UnWPWa3Zi+ed4MVH56ItHlo6nwdGKpZcRB4g3Y7kVW/DT8mlHVslfJ/BR2S4R99E3nsp2nc
 65HcEZpyEqzdqW6ro2GgRp7Q7YkEU/Pg=
X-Gm-Gg: AY/fxX5017nZIbhtWPJClY96jI91nGhTvOWWE4i0BM+xFQBMMXbGF5GIib7o0o4vCwY
 qsa0OJ0OZYw97zH8W2Rs/IuaZZK6wq7pMzEo6pockGCg1KyV8oTJheUJcod+SCGT5CMkggj5FSi
 OXPrVWRYnsGNgtXhV2KvptjBLYvqW6Fpmtm4riRqIb/VIclrtPzw4U9VPZMR6qpFkQxpS5IQPXj
 t+529x1senWX6RuAV8YxYUcTdXdzGIAaH6hrvr6JQ1zBK5Ibg/FrzKmemwcCdLMv36dA72+gzP7
 NWHY5N/FpCUeD14mdHtvTik4pQ==
X-Google-Smtp-Source: AGHT+IG+FFB7AC6xMxVrnleJZRuLExdM5iOS5iYafSXz36fPuBhu7+g/Cmhv4QhGvdU4Aqe11HbsYpEjPPyMTKkSJO8=
X-Received: by 2002:a17:907:3f21:b0:b87:191f:4f99 with SMTP id
 a640c23a62f3a-b87191f521bmr186874466b.48.1768171825702; Sun, 11 Jan 2026
 14:50:25 -0800 (PST)
MIME-Version: 1.0
References: <20260108134128.2218102-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20260108134128.2218102-1-djordje.todorovic@htecgroup.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 12 Jan 2026 08:49:59 +1000
X-Gm-Features: AZwV_Qg93t3WyuXbI6dLAzv1vmwSYhE2sQjA6z8746yEMaqnGj5msmtAoeeaEZk
Message-ID: <CAKmqyKMHdzmFVj7dW9ku0pe3+niysL7KHe4Zbk_G8D1sUMN2Kw@mail.gmail.com>
Subject: Re: [PATCH v16 00/12] riscv: Add support for MIPS P8700 CPU
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
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x534.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Jan 8, 2026 at 11:41=E2=80=AFPM Djordje Todorovic
<Djordje.Todorovic@htecgroup.com> wrote:
>
> Rebased again on top of very latest master branch by resolving
> build issues occured due to the changes in the code organization.
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

Thanks!

Applied to riscv-to-apply.next

Alistair

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
>
> --
> 2.34.1

