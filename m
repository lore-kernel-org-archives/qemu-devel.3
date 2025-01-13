Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E62F7E7719E
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2025 00:15:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tX86i-000798-1d; Sun, 12 Jan 2025 19:15:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tX86Z-00077g-VU; Sun, 12 Jan 2025 19:14:56 -0500
Received: from mail-vk1-xa30.google.com ([2607:f8b0:4864:20::a30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tX86W-0003yg-V5; Sun, 12 Jan 2025 19:14:54 -0500
Received: by mail-vk1-xa30.google.com with SMTP id
 71dfb90a1353d-51bb020339fso1444793e0c.0; 
 Sun, 12 Jan 2025 16:14:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736727291; x=1737332091; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TD7MU9vPdejNwguB14lxVRUJfEDkji0WNdvY4VPa6mc=;
 b=GgUJaISq4CyBfbiWnXveNzDMnK42kmiK4srohS8+4BIvb/dWI2HQDkmHhEe/MyDCle
 Pf8//4ImsWGGtyp+M//H3tmIoswVRWExsE/l21ubtYpOsXWfDr1l6+nkyNhgqHKT79zi
 UIqqcCrZUDch8OlX36lFx3bM2zmyNo4IowwaxUA4yo+auD1f5V7weaHhag8/DdntTw2h
 cgayvIbf8bDOLqUTUw/GqOqmyX76eJbNKbVlu+LWixItWL7Dp+AEvFj3hWTcNqPJhcAZ
 K/B+EUeMij6pzXsMXsz4hndZUB3WJWg4lVDUeMDXRSNCVAhKRc1hDxO+k7YsqzffJror
 AFCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736727291; x=1737332091;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TD7MU9vPdejNwguB14lxVRUJfEDkji0WNdvY4VPa6mc=;
 b=ehEKwM7C03bzWFVQNULRCdeDYhgNvp051Lg12KK4mj5tz4Y7xqIR53TPUo/kXn+AkA
 55sjj+7MzzWEm34wnO/bIj7xLqPGsc9GpYiOgTMYmiBf1Yp47tyGk4dyDDKAcf59Yg3O
 QySUgmWHcwcudBkMAOcttznZveBaLpCM5V06L7Ny6fUD88BOiJoH/PXLmd7i/TiZMmZf
 w1WGBbChKDJHoVKxHp5UbASrXITih8G2wnMQde1aNOHzzfjmoGHhc+o1F5lr6ynu+tsj
 +kczJeS/++MYY0ijbOwsmrDzY4cma3tPeqf+CqScSXyqwK2ghCg3egNON9hU5JOsaKo9
 1ijQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWJ1522IwmqGNrMBxt88O0KwgnZ9A8NvXfyAtSdyCmTLAw9eQ+BYW01fjYJ4r5exQTzQ3cjzXuPOKmc@nongnu.org
X-Gm-Message-State: AOJu0Yyr2kMpXVbolSblrnDNl5V8CSIUMKgLYriq4NUptA0g+Z906S59
 UR7ErZ5Km6XkTi2pcSXnEXUIh4OxFnxlNTCd5XkAmkLmuvI5bfchhUycVW+/7prhxCizrxTlH5L
 pOGNTpMlcPK0+lfEX0RxPcmhj6OE=
X-Gm-Gg: ASbGncvK2pk9L7k+NTfc4jLOkksBW0JAFC3eicuJL1PdA0frcnbBW5khfwfECIMsncK
 m6oCxQb8GR/BI+lA9azU2Yk4364UOW3eruhUvqKQXBPTKeufxWSu1TkwAlWQyw6l1Fb0=
X-Google-Smtp-Source: AGHT+IFfSGuBNQiBS4O6D+UTtA10bNFllhl1aqhxsLzi+w4zwPsnS5TDKjHc20OOz03FUhspmA+1trV26+UDAFoOEQM=
X-Received: by 2002:a05:6122:130b:b0:518:9582:db90 with SMTP id
 71dfb90a1353d-51c6c535f0dmr16752521e0c.11.1736727291099; Sun, 12 Jan 2025
 16:14:51 -0800 (PST)
MIME-Version: 1.0
References: <20250112231344.34632-1-philmd@linaro.org>
 <20250112231344.34632-2-philmd@linaro.org>
In-Reply-To: <20250112231344.34632-2-philmd@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 13 Jan 2025 10:14:25 +1000
X-Gm-Features: AbW1kvYMg4I4ISWxrIS52yrofKyvhh5U5kdD1WP5kXYfDPAsm6dLwvkqusJlnSk
Message-ID: <CAKmqyKOXXj4Zq-yNqSPSRqQWW+x-=G78nRim_Nvc_LfGTyt13g@mail.gmail.com>
Subject: Re: [PATCH 1/2] target/riscv: Have kvm_riscv_get_timebase_frequency()
 take RISCVCPU cpu
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Bin Meng <bmeng.cn@gmail.com>, 
 Weiwei Li <liwei1518@gmail.com>, Alistair Francis <alistair.francis@wdc.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a30;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa30.google.com
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

On Mon, Jan 13, 2025 at 9:14=E2=80=AFAM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> Keep kvm_riscv_get_timebase_frequency() prototype aligned with
> the other ones declared in "kvm_riscv.h", have it take a RISCVCPU
> cpu as argument. Include "target/riscv/cpu-qom.h" which declares
> the RISCVCPU typedef.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/kvm/kvm_riscv.h | 4 +++-
>  hw/riscv/virt.c              | 2 +-
>  target/riscv/kvm/kvm-cpu.c   | 4 ++--
>  3 files changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/target/riscv/kvm/kvm_riscv.h b/target/riscv/kvm/kvm_riscv.h
> index 58518988681..b2bcd1041f6 100644
> --- a/target/riscv/kvm/kvm_riscv.h
> +++ b/target/riscv/kvm/kvm_riscv.h
> @@ -19,6 +19,8 @@
>  #ifndef QEMU_KVM_RISCV_H
>  #define QEMU_KVM_RISCV_H
>
> +#include "target/riscv/cpu-qom.h"
> +
>  void kvm_riscv_reset_vcpu(RISCVCPU *cpu);
>  void kvm_riscv_set_irq(RISCVCPU *cpu, int irq, int level);
>  void kvm_riscv_aia_create(MachineState *machine, uint64_t group_shift,
> @@ -28,6 +30,6 @@ void kvm_riscv_aia_create(MachineState *machine, uint64=
_t group_shift,
>  void riscv_kvm_aplic_request(void *opaque, int irq, int level);
>  int kvm_riscv_sync_mpstate_to_kvm(RISCVCPU *cpu, int state);
>  void riscv_kvm_cpu_finalize_features(RISCVCPU *cpu, Error **errp);
> -uint64_t kvm_riscv_get_timebase_frequency(CPUState *cs);
> +uint64_t kvm_riscv_get_timebase_frequency(RISCVCPU *cpu);
>
>  #endif
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index 2bc5a9dd981..9e8876be29b 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -750,7 +750,7 @@ static void create_fdt_sockets(RISCVVirtState *s, con=
st MemMapEntry *memmap,
>      qemu_fdt_add_subnode(ms->fdt, "/cpus");
>      qemu_fdt_setprop_cell(ms->fdt, "/cpus", "timebase-frequency",
>                            kvm_enabled() ?
> -                          kvm_riscv_get_timebase_frequency(first_cpu) :
> +                          kvm_riscv_get_timebase_frequency(RISCV_CPU(fir=
st_cpu)) :
>                            RISCV_ACLINT_DEFAULT_TIMEBASE_FREQ);
>      qemu_fdt_setprop_cell(ms->fdt, "/cpus", "#size-cells", 0x0);
>      qemu_fdt_setprop_cell(ms->fdt, "/cpus", "#address-cells", 0x1);
> diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
> index 11278ea778d..23ce7793594 100644
> --- a/target/riscv/kvm/kvm-cpu.c
> +++ b/target/riscv/kvm/kvm-cpu.c
> @@ -758,11 +758,11 @@ static void kvm_riscv_put_regs_timer(CPUState *cs)
>      env->kvm_timer_dirty =3D false;
>  }
>
> -uint64_t kvm_riscv_get_timebase_frequency(CPUState *cs)
> +uint64_t kvm_riscv_get_timebase_frequency(RISCVCPU *cpu)
>  {
>      uint64_t reg;
>
> -    KVM_RISCV_GET_TIMER(cs, frequency, reg);
> +    KVM_RISCV_GET_TIMER(CPU(cpu), frequency, reg);
>
>      return reg;
>  }
> --
> 2.47.1
>
>

