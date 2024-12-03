Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19BE8E6C5FD
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 04:40:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIKhZ-00019W-PJ; Mon, 02 Dec 2024 23:39:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tIKhX-00019H-O5; Mon, 02 Dec 2024 23:39:55 -0500
Received: from mail-vs1-xe32.google.com ([2607:f8b0:4864:20::e32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tIKhW-0003ik-8O; Mon, 02 Dec 2024 23:39:55 -0500
Received: by mail-vs1-xe32.google.com with SMTP id
 ada2fe7eead31-4ae82bad101so1127360137.0; 
 Mon, 02 Dec 2024 20:39:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733200792; x=1733805592; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BWp3BuvttCU+bKBvYX9KyJXE8RQPFrQDKligAi5CXwo=;
 b=SIQ4sHbAXvwxNz0YUWMCwxVj77j5ijNPIIjt3PZXUAFtK6ftOAff6JYZJnlkBiGDEn
 xHZ+Wt/Iv7nC3IXrjc32VyipITgxUG77OpR7Ajgr+hJgMSN4goucU6RXhaUl0XAjDhlk
 oEgBIXOQwh+p1+GTcUIcMW+s5XUqzXPHoqt16qpx02grbZgv6VxQsu25pfsu51A5eNqx
 5zPv7DQzhVLydbVXd430tdcGWt5dx9J4fkDrF9m3SB8ZvnaIgkFy93EyK56NhNQnzW5h
 oGC2hW8sUDJnnUfn1Qerd8weqGYfebBlBIH0hJk//WsW+tJ9cqw23O3osyGvlazqEXXg
 fAYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733200792; x=1733805592;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BWp3BuvttCU+bKBvYX9KyJXE8RQPFrQDKligAi5CXwo=;
 b=bIyM+0+eq8x+Im1cHDrR4uTyH5xwfmEzt9lC6IhZ2JJtYQo23h1E/Niym3IVF1Y9Wd
 RLA0Gs5RN7r/vmuwaeGGSv+frifSrKy0rLjWUno9Zdhz4F25uSbkJ4w5CSFCAgxCW3J1
 HyGzry1i3lDemeuwgBBO4PGkcXOKiU7V3o7C4nhOqJ2BmrT/JpGdcSTWHQ7g/0n62PUm
 c+aiLyiETl5vQ4eqR7LnjbSszuy+/gWNkP2r4NKBVv1s0sg5RVM4VBtJxRUXl+tfNX5a
 ey719ziRzx3rk0TPfMlj7qAWzQ+6P62T+pLYAEduJpMGwg4ruX8Fy6E8LXx/YV17tI7M
 BPcg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXxKwKOfBVRXSzCzJRaFvbXuzGMuv+j0l1I0VjWT8xY28F3gALG5kXHObHjUs5JRUhyhifACA04eagK@nongnu.org
X-Gm-Message-State: AOJu0Yy2P/fnG0fIBIMiG36HcP5Ns+gfBxVTzSCgSpkUxhmvSlE105Gc
 VjCd6LR5Xinhu5joFl9i93baDd3GilD2EHMpOf+zrXcj2ytm0gEx5pTmyXXJPm5QKrf4taRGDtT
 LwA5R8/F0F8GrCECmIkRIiJzHydU=
X-Gm-Gg: ASbGncs1wmMWxJLt0XwzWQ0CiQRva5GvLXCzVB97k3X/Y7dUJNqjA245Q6eCoN+nfGP
 sCAZl/wW78oT/gUlv8B8PeBSEPpzISME4
X-Google-Smtp-Source: AGHT+IEysaj0rFAH+eXuCAxMksl5l1DbbPBrOC4Mb/m8fs+JTmazmkAypS1gvRmDqRIahbzycMpIo5pg88IM7s3QtGM=
X-Received: by 2002:a05:6102:54a5:b0:4af:5f8d:65d with SMTP id
 ada2fe7eead31-4af9727089dmr1833449137.15.1733200792405; Mon, 02 Dec 2024
 20:39:52 -0800 (PST)
MIME-Version: 1.0
References: <cover.1733063076.git.neither@nut.email>
 <1f9b7a8c8bca228529957a5ca62ad778870215ff.1733063076.git.neither@nut.email>
In-Reply-To: <1f9b7a8c8bca228529957a5ca62ad778870215ff.1733063076.git.neither@nut.email>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 3 Dec 2024 13:39:26 +0900
Message-ID: <CAKmqyKMhdZxZ-yQkcmt8RESQbAF1GEooN_1e4O-7LseTXsJw1w@mail.gmail.com>
Subject: Re: [RFC PATCH v3 09/11] target/riscv: call plugin trap callbacks
To: Julian Ganz <neither@nut.email>
Cc: qemu-devel@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>, 
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 "open list:RISC-V TCG CPUs" <qemu-riscv@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e32;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe32.google.com
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

On Tue, Dec 3, 2024 at 4:30=E2=80=AFAM Julian Ganz <neither@nut.email> wrot=
e:
>
> We recently introduced API for registering callbacks for trap related
> events as well as the corresponding hook functions. Due to differences
> between architectures, the latter need to be called from target specific
> code.
>
> This change places hooks for RISC-V targets.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu_helper.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index 0a3ead69ea..6da9bd4629 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -34,6 +34,7 @@
>  #include "debug.h"
>  #include "tcg/oversized-guest.h"
>  #include "pmp.h"
> +#include "qemu/plugin.h"
>
>  int riscv_env_mmu_index(CPURISCVState *env, bool ifetch)
>  {
> @@ -1806,6 +1807,7 @@ void riscv_cpu_do_interrupt(CPUState *cs)
>          !(env->mip & (1 << cause));
>      bool vs_injected =3D env->hvip & (1 << cause) & env->hvien &&
>          !(env->mip & (1 << cause));
> +    uint64_t last_pc =3D env-> pc;
>      target_ulong tval =3D 0;
>      target_ulong tinst =3D 0;
>      target_ulong htval =3D 0;
> @@ -1820,6 +1822,7 @@ void riscv_cpu_do_interrupt(CPUState *cs)
>          case RISCV_EXCP_SEMIHOST:
>              do_common_semihosting(cs);
>              env->pc +=3D 4;
> +            qemu_plugin_vcpu_hostcall_cb(cs, last_pc, env->pc);
>              return;
>  #endif
>          case RISCV_EXCP_LOAD_GUEST_ACCESS_FAULT:
> @@ -1999,6 +2002,12 @@ void riscv_cpu_do_interrupt(CPUState *cs)
>          riscv_cpu_set_mode(env, PRV_M, virt);
>      }
>
> +    if (async) {
> +        qemu_plugin_vcpu_interrupt_cb(cs, last_pc, env->pc);
> +    } else {
> +        qemu_plugin_vcpu_exception_cb(cs, last_pc, env->pc);
> +    }
> +
>      /*
>       * Interrupt/exception/trap delivery is asynchronous event and as pe=
r
>       * zicfilp spec CPU should clear up the ELP state. No harm in cleari=
ng
> --
> 2.45.2
>
>

