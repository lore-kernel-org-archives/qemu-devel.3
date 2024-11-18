Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91AF6D10F3B
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2024 01:42:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tCqlo-00058n-Cq; Sun, 17 Nov 2024 20:41:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tCqlm-00058W-Er; Sun, 17 Nov 2024 20:41:38 -0500
Received: from mail-ua1-x92f.google.com ([2607:f8b0:4864:20::92f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tCqlk-00032E-RG; Sun, 17 Nov 2024 20:41:38 -0500
Received: by mail-ua1-x92f.google.com with SMTP id
 a1e0cc1a2514c-856e98ad00bso487693241.0; 
 Sun, 17 Nov 2024 17:41:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731894095; x=1732498895; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=75L138SOAFhC3lzJGk14KPoFoytaDNmdnMV6DkTegdc=;
 b=ZtLyClSfz72roI83pzbLsIL6ViuQlK3SWyO93Rykw8hclAlZavT7psDXMZ0Twhbary
 ebRGUCXiuqk0rmZUfpMKRn18hbwk6brKu8ulTLugDQA+7Ck6FBRItaI0J7QRpTaimEqw
 IeE7jTbFfm8nkboj7FCDnGDnaZ2i2R16RKr2yHYCVt1rB9kpNBgOd7r1HF6bEi1pIi17
 cujtBI/3wHHPItdWXW0qy54rJING9Bnpp959cwt+KmK3qfcyHuGpVBPUJ2kVPUqI/Y3+
 mK1E2AdaP5rfdupfuFsjFnAGWYyXN0q/vvZP1orVK/OWucGIpbS4kfA1CbiDKHrwI3r7
 zOWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731894095; x=1732498895;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=75L138SOAFhC3lzJGk14KPoFoytaDNmdnMV6DkTegdc=;
 b=NlgujoOQiueg7/eqbK4BrAFPH1G5kcP+XHWAPN7XixrqaGc6DybB7g75lklxsUp3HP
 JdGDkwmT4TPRp8/KHoBUUbNZBFnd4IUmbpfT1f9EfcsklO0oW88WI8sd9ZguZaOue9Cf
 MMvWN+QX8uE5q2dS37+OPCqiC6HWQKiMGwkFd1NGZyEDj5paPrmV0ZUEHESZMg37ohm7
 P50JchGy46RlwzJpMPrjjBhuM34Doxxjm/OU/zlK5kUR7YfX7j8JCtlCCYh40pVQNhlL
 mSqXGOXaqCSsg5OhCCvLJKjo70hU4EfNMt4O6dpM0f2yhHaDzXZz698IZI81VBY1rXGS
 aRkA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWuW+m9dJnq+d/xnDfIxLZ66RiKM42VrdMg96O8EATSMr4bmqAsN3Q3vVXT2GeNUgJPcJlpziDLvH5a@nongnu.org
X-Gm-Message-State: AOJu0YyRjPVE/Nnub3zVmZaj114FZyMQHYlHX5lrL5varb+snCaIrUOD
 gypwH9AV+ZGx7bQWg7lzUUlvgxXifzHihpRH2YUqXGFXEPEj6TuwqNLAMG/mbpOkjs38hnjaa86
 KLnOrmT85w3At10N7pKqSpgKzzo0=
X-Google-Smtp-Source: AGHT+IGcX4Qo+h28BPf6G2K2m7xqiym16d5cgTnfjAwD10heepSl0qKnIUF1St8WAMlaL/R8vFSt5QTdZtt7Y/bYS6A=
X-Received: by 2002:a05:6102:3907:b0:4a7:4642:8b67 with SMTP id
 ada2fe7eead31-4ad62d1f8b0mr9038014137.17.1731894095346; Sun, 17 Nov 2024
 17:41:35 -0800 (PST)
MIME-Version: 1.0
References: <20241010190337.376987-1-dbarboza@ventanamicro.com>
 <20241010190337.376987-6-dbarboza@ventanamicro.com>
In-Reply-To: <20241010190337.376987-6-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 18 Nov 2024 11:41:09 +1000
Message-ID: <CAKmqyKOfB7M5CJLy6kEyhK_m=oSTBR42iX_N6oLY8w8idQwP0A@mail.gmail.com>
Subject: Re: [PATCH 5/8] hw/riscv/virt.c,
 riscv_aplic.c: add 'emulated_aplic' helpers
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

On Fri, Oct 11, 2024 at 5:05=E2=80=AFAM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> The current logic to determine if we don't need an emulated APLIC
> controller, i.e. KVM will provide for us, is to determine if we're
> running KVM, with in-kernel irqchip support, and running
> aia=3Daplic-imsic. This is modelled by riscv_is_kvm_aia_aplic_imsic() and
> virt_use_kvm_aia_aplic_imsic().
>
> This won't suffice to support irqchip_split() mode: it will match
> exactly the same conditions as the one above, but setting the irqchip to
> 'split' mode will now require us to emulate an APLIC s-mode controller,
> like we're doing with 'aia=3Daplic'.
>
> Create a new riscv_use_emulated_aplic() helper that will encapsulate
> this logic. Replace the uses of "riscv_is_kvm_aia_aplic_imsic()" with
> this helper every time we're taking a decision on emulate an APLIC
> controller or not. Do the same in virt.c with virt_use_emulated_aplic().
>
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/intc/riscv_aplic.c         | 24 +++++++++++++++++++++---
>  hw/riscv/virt.c               | 14 ++++++++++++--
>  include/hw/intc/riscv_aplic.h |  1 +
>  3 files changed, 34 insertions(+), 5 deletions(-)
>
> diff --git a/hw/intc/riscv_aplic.c b/hw/intc/riscv_aplic.c
> index 20de8c63a2..0696e20ddf 100644
> --- a/hw/intc/riscv_aplic.c
> +++ b/hw/intc/riscv_aplic.c
> @@ -32,6 +32,7 @@
>  #include "target/riscv/cpu.h"
>  #include "sysemu/sysemu.h"
>  #include "sysemu/kvm.h"
> +#include "sysemu/tcg.h"
>  #include "kvm/kvm_riscv.h"
>  #include "migration/vmstate.h"
>
> @@ -159,6 +160,23 @@ bool riscv_is_kvm_aia_aplic_imsic(bool msimode)
>      return kvm_irqchip_in_kernel() && msimode;
>  }
>
> +bool riscv_use_emulated_aplic(bool msimode)
> +{
> +#ifdef CONFIG_KVM
> +    if (tcg_enabled()) {
> +        return true;
> +    }
> +
> +    if (!riscv_is_kvm_aia_aplic_imsic(msimode)) {
> +        return true;
> +    }
> +
> +    return kvm_kernel_irqchip_split();
> +#else
> +    return true;
> +#endif
> +}
> +
>  static bool riscv_aplic_irq_rectified_val(RISCVAPLICState *aplic,
>                                            uint32_t irq)
>  {
> @@ -853,7 +871,7 @@ static void riscv_aplic_realize(DeviceState *dev, Err=
or **errp)
>      uint32_t i;
>      RISCVAPLICState *aplic =3D RISCV_APLIC(dev);
>
> -    if (!riscv_is_kvm_aia_aplic_imsic(aplic->msimode)) {
> +    if (riscv_use_emulated_aplic(aplic->msimode)) {
>          aplic->bitfield_words =3D (aplic->num_irqs + 31) >> 5;
>          aplic->sourcecfg =3D g_new0(uint32_t, aplic->num_irqs);
>          aplic->state =3D g_new0(uint32_t, aplic->num_irqs);
> @@ -877,7 +895,7 @@ static void riscv_aplic_realize(DeviceState *dev, Err=
or **errp)
>       * have IRQ lines delegated by their parent APLIC.
>       */
>      if (!aplic->parent) {
> -        if (kvm_enabled() && riscv_is_kvm_aia_aplic_imsic(aplic->msimode=
)) {
> +        if (kvm_enabled() && !riscv_use_emulated_aplic(aplic->msimode)) =
{
>              qdev_init_gpio_in(dev, riscv_kvm_aplic_request, aplic->num_i=
rqs);
>          } else {
>              qdev_init_gpio_in(dev, riscv_aplic_request, aplic->num_irqs)=
;
> @@ -1021,7 +1039,7 @@ DeviceState *riscv_aplic_create(hwaddr addr, hwaddr=
 size,
>
>      sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
>
> -    if (!riscv_is_kvm_aia_aplic_imsic(msimode)) {
> +    if (riscv_use_emulated_aplic(msimode)) {
>          sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, addr);
>      }
>
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index f1bdc1c535..39fd9b7c3e 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -64,6 +64,13 @@ static bool virt_use_kvm_aia_aplic_imsic(RISCVVirtAIAT=
ype aia_type)
>      return riscv_is_kvm_aia_aplic_imsic(msimode);
>  }
>
> +static bool virt_use_emulated_aplic(RISCVVirtAIAType aia_type)
> +{
> +    bool msimode =3D aia_type =3D=3D VIRT_AIA_TYPE_APLIC_IMSIC;
> +
> +    return riscv_use_emulated_aplic(msimode);
> +}
> +
>  static bool virt_aclint_allowed(void)
>  {
>      return tcg_enabled() || qtest_enabled();
> @@ -776,8 +783,11 @@ static void create_fdt_sockets(RISCVVirtState *s, co=
nst MemMapEntry *memmap,
>          *msi_pcie_phandle =3D msi_s_phandle;
>      }
>
> -    /* KVM AIA aplic-imsic only has one APLIC instance */
> -    if (kvm_enabled() && virt_use_kvm_aia_aplic_imsic(s->aia_type)) {
> +    /*
> +     * With KVM AIA aplic-imsic, using an irqchip without split
> +     * mode, we'll use only one APLIC instance.
> +     */
> +    if (!virt_use_emulated_aplic(s->aia_type)) {
>          create_fdt_socket_aplic(s, memmap, 0,
>                                  msi_m_phandle, msi_s_phandle, phandle,
>                                  &intc_phandles[0], xplic_phandles,
> diff --git a/include/hw/intc/riscv_aplic.h b/include/hw/intc/riscv_aplic.=
h
> index fd0e6427d9..74ae5d87b5 100644
> --- a/include/hw/intc/riscv_aplic.h
> +++ b/include/hw/intc/riscv_aplic.h
> @@ -72,6 +72,7 @@ struct RISCVAPLICState {
>
>  void riscv_aplic_add_child(DeviceState *parent, DeviceState *child);
>  bool riscv_is_kvm_aia_aplic_imsic(bool msimode);
> +bool riscv_use_emulated_aplic(bool msimode);
>
>  DeviceState *riscv_aplic_create(hwaddr addr, hwaddr size,
>      uint32_t hartid_base, uint32_t num_harts, uint32_t num_sources,
> --
> 2.45.2
>
>

