Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A9DFC3601A
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Apr 2025 03:12:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0XTf-0001x6-5p; Thu, 03 Apr 2025 23:12:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1u0XTd-0001wR-AV; Thu, 03 Apr 2025 23:12:17 -0400
Received: from mail-ua1-x936.google.com ([2607:f8b0:4864:20::936])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1u0XTb-00013t-PR; Thu, 03 Apr 2025 23:12:16 -0400
Received: by mail-ua1-x936.google.com with SMTP id
 a1e0cc1a2514c-86c29c0acdfso779943241.3; 
 Thu, 03 Apr 2025 20:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743736334; x=1744341134; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F3YmNRA/bmmZ7jXysI2R5gi1Whw7OolM6Mcre3dbFTI=;
 b=NnDrNeF+eh59JudNvdWKS81191RzQ1Im5nodYCzHPsyTCg7vu7N0GE+H9I9UMFvVsg
 /AdzR31ORLJswpLfszemmX+e3cvu48sWk4fwDctCBTDU//GmTvbm2Ipvw28AxpjNy2lD
 LLlkAMR3R0Cbba51z6Pt5MDIEJnwcn9jf2+ePh9pZhVR0NxnAOPZdRO+vAz3kZj9JXF5
 0N9y+FN9Opz6HWr5cqohyewJjfH1VM0raqQKs9UvzWMr17VtRiTTeFZLdbMkidOYs0tR
 Y0cFolOL4cgvywOrVd7m0mP2BwF9E5sexH3D4Tm/fIx7LU9lDo09FrEzzWGhMHhdfaS3
 VGyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743736334; x=1744341134;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=F3YmNRA/bmmZ7jXysI2R5gi1Whw7OolM6Mcre3dbFTI=;
 b=jpemqkIYo0C/CgN8CA4MW1lezKM1Bz25OVDaVS9Lqt8mB1oYYVQ9nuk/BzQHdw7wZm
 fQdzk3LmQaLK3Mlx2Mm3EJHvCXjjv3W0FJDXbEEkVabPrf3J5q/Uu3kPweSEtlji/wpM
 x/GO1gusVZX4Z4534sB3dWed4SZs4eJW2qyYpcys5GiyfdYGyeWsfCcqkVsJvDwhOKlE
 Y/g/3Rg9tKDENeMLQT9nm8Vq4gIX6RhJawtHuWYRV2qHiLJpQnIEsThqyzXS7fd1D3rM
 zslseFs8W+sr+FOI6Rs0kgE9OHHrPlNhAgxHwshWo/IlksEfgRA+YHitIAvG3sstNHpj
 mrUQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWO/v4A3yTHtiJm0s05j3UCtrgZoyUYi9g5GIw7V9FyxfTyBTJbdXr7fgyeTODNgQth4ukFSC7xwI9x@nongnu.org
X-Gm-Message-State: AOJu0Yx+lDd4GCixfJijVYKH5hSboDnLHwEHcSH+WfPrDMXi74JKgFT3
 mr4gDgjzXsbIewoJShoKe/DC2Dy7gFdDAT/BI/B3V99swf3DR8vzva1ns0kbAzb0xuw9bin9fL3
 qVSqJdQxf8+8iF/x9QeCv/p1YX+I=
X-Gm-Gg: ASbGncstVg4biKzifYLGxBhaB2N+ZPOSk3Low4FfcAJR1iL5JFAYjHxgptE5DXrG/+h
 T3Cs6Ih44YWbH+zSUrS49aOxmvqZlkgzAre1OUI2V4McheHkzT7X6PBLgKt4afY1J73+M2McqZC
 0B0uoX/YDXZzYClWWs5AGR3YkX3TcXd0S4EmbQ3JC9+ewtPiMG0I0Y3rG9
X-Google-Smtp-Source: AGHT+IHzcHKgVUKQAxMWe4yg9KXn3VsOpbhjN2kuISGPNHlLIs5MPISusnJ1Byxv0hak1HZvllJG5mdx3BYcIREakMs=
X-Received: by 2002:a05:6102:418b:b0:4c1:b0ad:a0bd with SMTP id
 ada2fe7eead31-4c8554acac7mr1375133137.23.1743736333977; Thu, 03 Apr 2025
 20:12:13 -0700 (PDT)
MIME-Version: 1.0
References: <20250319192153.28549-1-jim.shu@sifive.com>
 <20250319192153.28549-3-jim.shu@sifive.com>
In-Reply-To: <20250319192153.28549-3-jim.shu@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 4 Apr 2025 13:11:47 +1000
X-Gm-Features: ATxdqUFhNgpE60cw-yYHpxA4le3uHxjiIs2lRJ36rmdTtcN4EE7PfzgODjp6GEk
Message-ID: <CAKmqyKPo4G3t32=uKbgYoY+nDJOEg+fLJ3yFC1hx2PJEqT=59A@mail.gmail.com>
Subject: Re: [PATCH 2/4] hw/intc: riscv_aclint: Fix mtime write for sstc
 extension
To: Jim Shu <jim.shu@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::936;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x936.google.com
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

On Thu, Mar 20, 2025 at 5:24=E2=80=AFAM Jim Shu <jim.shu@sifive.com> wrote:
>
> When changing the mtime value, the period of [s|vs]timecmp timers
> should also be updated like the period of mtimecmp timer.

Why should they be updated?

Alistair

>
> Signed-off-by: Jim Shu <jim.shu@sifive.com>
> ---
>  hw/intc/riscv_aclint.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/hw/intc/riscv_aclint.c b/hw/intc/riscv_aclint.c
> index db374a7c2d..5f4a17e177 100644
> --- a/hw/intc/riscv_aclint.c
> +++ b/hw/intc/riscv_aclint.c
> @@ -28,6 +28,7 @@
>  #include "qemu/module.h"
>  #include "hw/sysbus.h"
>  #include "target/riscv/cpu.h"
> +#include "target/riscv/time_helper.h"
>  #include "hw/qdev-properties.h"
>  #include "hw/intc/riscv_aclint.h"
>  #include "qemu/timer.h"
> @@ -240,6 +241,10 @@ static void riscv_aclint_mtimer_write(void *opaque, =
hwaddr addr,
>              riscv_aclint_mtimer_write_timecmp(mtimer, RISCV_CPU(cpu),
>                                                mtimer->hartid_base + i,
>                                                mtimer->timecmp[i]);
> +            riscv_timer_write_timecmp(env, env->stimer, env->stimecmp, 0=
, MIP_STIP);
> +            riscv_timer_write_timecmp(env, env->vstimer, env->vstimecmp,
> +                                      env->htimedelta, MIP_VSTIP);
> +
>          }
>          return;
>      }
> --
> 2.17.1
>
>

