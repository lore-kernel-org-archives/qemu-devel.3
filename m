Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D459BD10F3B
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2024 01:38:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tCqi0-0003w9-4S; Sun, 17 Nov 2024 20:37:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tCqhv-0003vH-W0; Sun, 17 Nov 2024 20:37:40 -0500
Received: from mail-vk1-xa2b.google.com ([2607:f8b0:4864:20::a2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tCqhu-0002F2-8o; Sun, 17 Nov 2024 20:37:39 -0500
Received: by mail-vk1-xa2b.google.com with SMTP id
 71dfb90a1353d-513de4267d8so565632e0c.3; 
 Sun, 17 Nov 2024 17:37:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731893856; x=1732498656; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ovCu4KUsEIGk7i5O5wk3uurBMvwCGjymsUkKSgE1D5g=;
 b=DxPF9SIdBUShN0+rsFjCKznrlJvB7vI4uCobo79N+0yQhkat2PeAMSu5E3tCV/mllJ
 UT9YW+2KA9sinhv3EQCth3bxLj+N0PxZHvacF4kUQW4ruZwBR/f93CjBL9Ru5MokZnUx
 cpVLtWXYzvaO7aLKAqDvzTYmLaiA3k1nHjBPEArFZD0drStlpslbFqJ2AZym2YRP/cd9
 +IG6K9dXuEP2CQXWaTCM3jeYhP3PYYNyDCghfg3kMFr90uPsi9LQUv65iRi228OOIJjV
 3VWszoQXm70Z0+/apNo/ErGqQodd/VtS9BxRFgdbqQz3ObV43gpF+hf5BQ09i3is95KV
 RlDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731893856; x=1732498656;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ovCu4KUsEIGk7i5O5wk3uurBMvwCGjymsUkKSgE1D5g=;
 b=X8wdzrObOhaZ3FkcEIz8LWwxwItmHI8upHsI60M3hoUYUY/8rYi5whL2k/swNX3C/0
 dYTH4hlZQOr3rIdB+dJ8WBxFNH2DpKReIEt40srDifH0VMra5C1fXdQhVEB5dPMi8PwZ
 mi/W+ePOhpuZyFE5vUP3O0FIrB/IYoVlfeSYiWhcOcZPOtcFpu1YYBX4V35jOH2ZbZTd
 aajLUxqhvvXnk/fmC1iiDSmSbJQDrRB/a2iTOYyjo8W0QDRI7q+eDEu2O9I9l6HrkVIR
 7vgxB6pBGTOdChQaSonL1tuRXlQf7ZNxzlbMTr7VVKI1TSOtKocgBUJfWKKHHeqguvD9
 vLlw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW5CjvKXbFhjo2uLV6l3EzhY7HTqmM8DW22FoPdqIkrWS2jTi5PTNzFd1XN0ht8QLdtD6z7YW8XTdlJ@nongnu.org
X-Gm-Message-State: AOJu0YyaX1hGejZAIoTPVbShMfmK03Ytn8gUjha1ZMc2cNDTkC5CIuKD
 fwceRQ9I7i8+/EIow/3fmiVMhFOrNoWPOVU6sR4ckpb0x6UQG5w4zoCXmTo72QpwjZMwd/gI64R
 Rct1qh46uOdTaq36ni64sTooKg+0=
X-Google-Smtp-Source: AGHT+IH5vTfKlJVvpf2OsvEOZNvykGHlBe0g/ryDCw75vTDFTeG6TPr1ncgcr2YWjrRownqQqXtLAIqUSLlBpnp7x4s=
X-Received: by 2002:a05:6122:1689:b0:50c:4eb7:90fa with SMTP id
 71dfb90a1353d-51477eedcf0mr9348782e0c.5.1731893856364; Sun, 17 Nov 2024
 17:37:36 -0800 (PST)
MIME-Version: 1.0
References: <20241010190337.376987-1-dbarboza@ventanamicro.com>
 <20241010190337.376987-5-dbarboza@ventanamicro.com>
In-Reply-To: <20241010190337.376987-5-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 18 Nov 2024 11:37:10 +1000
Message-ID: <CAKmqyKNf4_MnHeVvc2Zj9U2xNW4CxW--0bT5rDnoc3oc818_-w@mail.gmail.com>
Subject: Re: [PATCH 4/8] target/riscv/kvm: consider irqchip_split() in
 aia_create()
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com, ajones@ventanamicro.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2b;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa2b.google.com
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

On Fri, Oct 11, 2024 at 5:05=E2=80=AFAM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> Before adding support to kernel-irqchip=3Dsplit when using KVM AIA we nee=
d
> to change how we create the in-kernel AIA device.
>
> In the use case we have so far, i.e. in-kernel irqchip without split
> mode, both the s-mode APLIC and IMSIC controllers are provided by the
> irqchip. In irqchip_split() mode we'll emulate the s-mode APLIC
> controller, which will send MSIs to the in-kernel IMSIC controller. To
> do that we need to change kvm_riscv_aia_create() to not create the
> in-kernel s-mode APLIC controller.
>
> In the kernel source arch/riscv/kvm/aia_aplic.c, function
> kvm_riscv_aia_aplic_init(), we verify that the APLIC controller won't be
> instantiated by KVM if we do not set 'nr_sources', which is set via
> KVM_DEV_RISCV_AIA_CONFIG_SRCS. For QEMU this means that we should not
> set 'aia_irq_num' during kvm_riscv_aia_create() in irqchip_split() mode.
>
> In this same condition, skip KVM_DEV_RISCV_AIA_ADDR_APLIC as well since
> it is used to set the base address for the in-kernel APLIC controller.
>
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/kvm/kvm-cpu.c | 36 ++++++++++++++++++++++--------------
>  1 file changed, 22 insertions(+), 14 deletions(-)
>
> diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
> index 8233a32102..a92a46694a 100644
> --- a/target/riscv/kvm/kvm-cpu.c
> +++ b/target/riscv/kvm/kvm-cpu.c
> @@ -1725,12 +1725,28 @@ void kvm_riscv_aia_create(MachineState *machine, =
uint64_t group_shift,
>                       kvm_aia_mode_str(aia_mode));
>      }
>
> -    ret =3D kvm_device_access(aia_fd, KVM_DEV_RISCV_AIA_GRP_CONFIG,
> -                            KVM_DEV_RISCV_AIA_CONFIG_SRCS,
> -                            &aia_irq_num, true, NULL);
> -    if (ret < 0) {
> -        error_report("KVM AIA: failed to set number of input irq lines")=
;
> -        exit(1);
> +    /*
> +     * Skip APLIC creation in KVM if we're running split mode.
> +     * This is done by leaving KVM_DEV_RISCV_AIA_CONFIG_SRCS
> +     * unset. We can also skip KVM_DEV_RISCV_AIA_ADDR_APLIC
> +     * since KVM won't be using it.
> +     */
> +    if (!kvm_kernel_irqchip_split()) {
> +        ret =3D kvm_device_access(aia_fd, KVM_DEV_RISCV_AIA_GRP_CONFIG,
> +                                KVM_DEV_RISCV_AIA_CONFIG_SRCS,
> +                                &aia_irq_num, true, NULL);
> +        if (ret < 0) {
> +            error_report("KVM AIA: failed to set number of input irq lin=
es");
> +            exit(1);
> +        }
> +
> +        ret =3D kvm_device_access(aia_fd, KVM_DEV_RISCV_AIA_GRP_ADDR,
> +                                KVM_DEV_RISCV_AIA_ADDR_APLIC,
> +                                &aplic_base, true, NULL);
> +        if (ret < 0) {
> +            error_report("KVM AIA: failed to set the base address of APL=
IC");
> +            exit(1);
> +        }
>      }
>
>      ret =3D kvm_device_access(aia_fd, KVM_DEV_RISCV_AIA_GRP_CONFIG,
> @@ -1772,14 +1788,6 @@ void kvm_riscv_aia_create(MachineState *machine, u=
int64_t group_shift,
>          exit(1);
>      }
>
> -    ret =3D kvm_device_access(aia_fd, KVM_DEV_RISCV_AIA_GRP_ADDR,
> -                            KVM_DEV_RISCV_AIA_ADDR_APLIC,
> -                            &aplic_base, true, NULL);
> -    if (ret < 0) {
> -        error_report("KVM AIA: failed to set the base address of APLIC")=
;
> -        exit(1);
> -    }
> -
>      for (socket =3D 0; socket < socket_count; socket++) {
>          socket_imsic_base =3D imsic_base + socket * (1U << group_shift);
>          hart_count =3D riscv_socket_hart_count(machine, socket);
> --
> 2.45.2
>
>

