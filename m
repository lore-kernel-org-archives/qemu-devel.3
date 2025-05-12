Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85DEAC3ABCB
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 22:51:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEbz4-0000Z6-Ja; Mon, 12 May 2025 18:50:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uEbz3-0000Yp-Bd; Mon, 12 May 2025 18:50:53 -0400
Received: from mail-vk1-xa2a.google.com ([2607:f8b0:4864:20::a2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uEbz1-0001x2-3f; Mon, 12 May 2025 18:50:52 -0400
Received: by mail-vk1-xa2a.google.com with SMTP id
 71dfb90a1353d-52c55db3743so1273702e0c.1; 
 Mon, 12 May 2025 15:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747090249; x=1747695049; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UVZmC3NLKELZ8+sF0ymWu0+rEBEHAecwjsCl4g4zr8w=;
 b=brCD5jxEN9LZgJiK2m9AhJrZE971AtXTJTDeLOTgnLd+hu8Enb8U3rkZrqp15mXvwb
 V1+tEn5zJrap+/9NhXCIqq6qSIKV3UceIRAZUwSV23YvWFkkFwZRL7qUHkNpg0vIRUZw
 JQyU/RhmF0Qg26aqSRi0cpSmOY5Wbuq/9hl1YR2srwFkzfwyn8Z9GU2TwpzXgkHgzJqk
 pDgpo1SLISa2tmPPMY4yHMF0Rl/qVG+lR9Mn9iIMaqkKzTCzyWXq3RhtjgQQs0KkbAhj
 jZSCJbi91yQ1CaCk/0Hb4PzRLWYOvxzP/OcTGcSgrOOqvshoqrCFJG/6vh0N0bRULknZ
 T+IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747090249; x=1747695049;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UVZmC3NLKELZ8+sF0ymWu0+rEBEHAecwjsCl4g4zr8w=;
 b=X28kA39LvXbAGzgDetwRY1iM7wPN6KS8b+xBDcmaJl8VecB4eytznjC1yAt70VsAVp
 7rAtpMjwmxvFf8m6xVSq8Zbye+Bz8snHym9z6H7UY49pSCDLDI35CRqlanLMCGpGqImG
 d6hc5MACyV5NkHOikkmlUOmaGfBFAr14P5OwccIrFURz8n+kgIsMczcadr56WtcSNA6r
 AcyN2MoIf3IOVi8ApI9Lwean10+XJNvYzgqEZF3iaXc50dr5pIZYvtUb6MDyNHZ6G1++
 hQ5Tf1Pqtx4p9taNExvcBdssxdPQAzhYEBblWJ7t+zBDkS3i4ns029Nnuh9LCLA3DLY/
 4uSA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX5oy+RSmwbdIYuW8EjDPQDBMguWnaRINktcqRPEgH9flNzhMedyzUj4HYE+eC3Y+imtBPeWVQRtB60@nongnu.org
X-Gm-Message-State: AOJu0YzdFVM4nCFIvIXnxpynTSmY7siT3cFoMZANwgABBEdKkMhW6YfG
 WsAdPc43avIL04xUYKGwrPK+SzEDLaNcJhbs8QgedlHyeZs6dUcXUFkGUlJQhc0wiZoCvzAjBzO
 GH4wb95loNj3dyqBwxaIomRjPD9Y=
X-Gm-Gg: ASbGnctsNPy46JBh48v9eVG5OQGXr3gndeYg69q8svFV5W7vPP2G4l5cYe/tfoooz6g
 hmSBbbCMUEl7m2CkGvbWcYdGS3xjNL3wFtwwUH68P8thm4S6/PAhTRuWi1nYQiuo2XVaiT3jIEi
 G0fzHB41UNBoAqS/k3tz+GlXJU0T6iQdSA2od+1EsykZcrZdPc9/PNeaZGMj1MyQk=
X-Google-Smtp-Source: AGHT+IFS6+sKDgdtJRjCFUUbvab3mLR67n+l8BZV1MAX0PCtNk1xRq83zGAB1tz0D/6RbIJFF8UXQCd9b7iwqvLuhlg=
X-Received: by 2002:a05:6122:828d:b0:52c:5062:c84d with SMTP id
 71dfb90a1353d-52c538121aemr9412682e0c.0.1747090249224; Mon, 12 May 2025
 15:50:49 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1746968215.git.neither@nut.email>
 <40c7216b842b7d06a0b947a7eee7cc11b9305b15.1746968215.git.neither@nut.email>
In-Reply-To: <40c7216b842b7d06a0b947a7eee7cc11b9305b15.1746968215.git.neither@nut.email>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 13 May 2025 08:50:23 +1000
X-Gm-Features: AX0GCFtC_8yO4px2eHIpPXvURVdxBA33BKDXu2crm9lxd5YpaR3NfWKvRK9gFtA
Message-ID: <CAKmqyKNmHYuyvG8w5ELL2nheS332YLLuQsVrnKiE-A0-Kt_Bww@mail.gmail.com>
Subject: Re: [PATCH v4 16/23] target/riscv: call plugin trap callbacks
To: Julian Ganz <neither@nut.email>
Cc: qemu-devel@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 "open list:RISC-V TCG CPUs" <qemu-riscv@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2a;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa2a.google.com
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

On Sun, May 11, 2025 at 11:18=E2=80=AFPM Julian Ganz <neither@nut.email> wr=
ote:
>
> We recently introduced API for registering callbacks for trap related
> events as well as the corresponding hook functions. Due to differences
> between architectures, the latter need to be called from target specific
> code.
>
> This change places hooks for RISC-V targets.
>
> Signed-off-by: Julian Ganz <neither@nut.email>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu_helper.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index d5039f69a9..dce7e34cba 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -36,6 +36,7 @@
>  #include "cpu_bits.h"
>  #include "debug.h"
>  #include "pmp.h"
> +#include "qemu/plugin.h"
>
>  int riscv_env_mmu_index(CPURISCVState *env, bool ifetch)
>  {
> @@ -2173,6 +2174,7 @@ void riscv_cpu_do_interrupt(CPUState *cs)
>      uint64_t hdeleg =3D async ? env->hideleg : env->hedeleg;
>      const bool prev_virt =3D env->virt_enabled;
>      const target_ulong prev_priv =3D env->priv;
> +    uint64_t last_pc =3D env->pc;
>      target_ulong tval =3D 0;
>      target_ulong tinst =3D 0;
>      target_ulong htval =3D 0;
> @@ -2195,6 +2197,7 @@ void riscv_cpu_do_interrupt(CPUState *cs)
>          case RISCV_EXCP_SEMIHOST:
>              do_common_semihosting(cs);
>              env->pc +=3D 4;
> +            qemu_plugin_vcpu_hostcall_cb(cs, last_pc);
>              return;
>  #endif
>          case RISCV_EXCP_LOAD_GUEST_ACCESS_FAULT:
> @@ -2464,6 +2467,12 @@ void riscv_cpu_do_interrupt(CPUState *cs)
>                          prev_priv, prev_virt);
>      }
>
> +    if (async) {
> +        qemu_plugin_vcpu_interrupt_cb(cs, last_pc);
> +    } else {
> +        qemu_plugin_vcpu_exception_cb(cs, last_pc);
> +    }
> +
>      /*
>       * Interrupt/exception/trap delivery is asynchronous event and as pe=
r
>       * zicfilp spec CPU should clear up the ELP state. No harm in cleari=
ng
> --
> 2.49.0
>
>

