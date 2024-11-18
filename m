Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3985ED10F3D
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2024 01:59:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tCr2Q-00075c-LA; Sun, 17 Nov 2024 20:58:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tCr2O-00075H-4P; Sun, 17 Nov 2024 20:58:48 -0500
Received: from mail-vk1-xa36.google.com ([2607:f8b0:4864:20::a36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tCr2M-0005SU-9K; Sun, 17 Nov 2024 20:58:47 -0500
Received: by mail-vk1-xa36.google.com with SMTP id
 71dfb90a1353d-512259c860eso993502e0c.2; 
 Sun, 17 Nov 2024 17:58:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731895124; x=1732499924; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kgpuIGc/paxNhhR/m1LzLP5aPVKPDR8A3aYPO/T7Juw=;
 b=AMlgllwUqQ3fwhGHqjsyXfQBLL6ZiPHI0AzAUNrSlVagHbMOcunA2as/jdrhEKvn79
 IWoN5Qc7RF5eNUV9NEJ7xpEyb7X7GBJV4OmnFapVwpjKYUJbwoLJiye7gNQyD4RWseL3
 HlMCrzJuq5+oschxvqFSZfw36+78m8j+Uuayudov+aaNHNyAJAN430ywBQO213dzH5jA
 xdysd8Eh78eInZqD/YPBloAhTKb699sDMMScfwFj/kNr0oECkR3ENACJQB3FJoi7LUOP
 cRpR21IJR6Za3vAPcqlxx673JGSQYuOklAfNvL4JkkRH2jSDDl7+gUEuA74qwVLkyPvO
 YEoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731895124; x=1732499924;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kgpuIGc/paxNhhR/m1LzLP5aPVKPDR8A3aYPO/T7Juw=;
 b=NqtcIbHwaRGRNVSg/0IqDE84dwHUmDcsvfLm+wqtYwMiqsZ5sYxXLmJrtS//gZfeXm
 cnFkqawiGgD/XH7HMTfU3owxZqwv9eScVHEtcpB0CqQEWdqWYXbciCxCdpeIVvtT/zii
 wD4eC5p8wBPgau7ZkIdaS/Jmw9LJxkGRNqAj4aYg9GuQQHhDxqvIi0EG02wUAjPkQ+wq
 tSOyG95o4r18YavvXVdX8Sn0cn67HRYqIDuJnppHW1Y+vsxnNzsSko/1sxDwZ0oaccCg
 3QLI6OxOpETXnQCn3PRZVDfHf1xDfWiy6/PcE8sYdKrwJi42hwcFAOb9UH9ADKa6KAJm
 TNpg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUrqu8gRYVms5N+tVycjgizlPy9mWqam/BAbIxYJkwLrSZIX1hGgOR8Ar7/7JDRQoSnMHJlPS1pD/pH@nongnu.org
X-Gm-Message-State: AOJu0YxvCIxQnlNyFog3ASBiV0tO76vbOqvknwWf+BGLCqoBdZ4sOoEW
 ODGg8XK2uRIM71tuvCvsjwT08ex17mRCEbJ2mdkNH0DOpjb6z6vAdlZ76LpXXB9TNkxyZOyTCql
 qoH1C+xH0BYnbG3XptvivvOOz52E=
X-Google-Smtp-Source: AGHT+IGOsSZEBPhueFwBAF/zPfeXOR/x7OdxCruQnyDvgA+Z0W/fBD0dStz/EyoDTIrK3HlP9tHcz3dhfwFy7Kt+M1o=
X-Received: by 2002:a05:6122:895:b0:50d:b561:33bd with SMTP id
 71dfb90a1353d-514781ddf74mr8469844e0c.12.1731895124051; Sun, 17 Nov 2024
 17:58:44 -0800 (PST)
MIME-Version: 1.0
References: <20241010190337.376987-1-dbarboza@ventanamicro.com>
 <20241010190337.376987-7-dbarboza@ventanamicro.com>
In-Reply-To: <20241010190337.376987-7-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 18 Nov 2024 11:58:18 +1000
Message-ID: <CAKmqyKPiaU5mzOb=HScc5vZHqRp0vD2L84juS-bsx+UZ2SvWig@mail.gmail.com>
Subject: Re: [PATCH 6/8] hw/intc/riscv_aplic: add kvm_msicfgaddr for split
 mode aplic-imsic
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com, ajones@ventanamicro.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a36;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa36.google.com
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

On Fri, Oct 11, 2024 at 5:07=E2=80=AFAM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> The last step to enable KVM AIA aplic-imsic with irqchip in split mode
> is to deal with how MSIs are going to be sent. In our current design we
> don't allow an APLIC controller to send MSIs unless it's on m-mode. And
> we also do not allow Supervisor MSI address configuration via the
> 'smsiaddrcfg' and 'smsiaddrcfgh' registers unless it's also a m-mode
> APLIC controller.
>
> Add a new RISCVACPLICState attribute called 'kvm_msicfgaddr'. This
> attribute represents the base configuration address for MSIs, in our
> case the base addr of the IMSIC controller. This attribute is being set
> only when running irqchip_split() mode with aia=3Daplic-imsic.
>
> During riscv_aplic_msi_send() we'll check if the attribute was set to
> skip the check for a m-mode APLIC controller and to change the resulting
> MSI addr by adding kvm_msicfgaddr right before address_space_stl_le().
>
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/intc/riscv_aplic.c         | 42 +++++++++++++++++++++++++++--------
>  hw/riscv/virt.c               |  6 ++++-
>  include/hw/intc/riscv_aplic.h |  6 +++++
>  3 files changed, 44 insertions(+), 10 deletions(-)
>
> diff --git a/hw/intc/riscv_aplic.c b/hw/intc/riscv_aplic.c
> index 0696e20ddf..4de458e395 100644
> --- a/hw/intc/riscv_aplic.c
> +++ b/hw/intc/riscv_aplic.c
> @@ -177,6 +177,16 @@ bool riscv_use_emulated_aplic(bool msimode)
>  #endif
>  }
>
> +void riscv_aplic_set_kvm_msicfgaddr(RISCVAPLICState *aplic, hwaddr addr)
> +{
> +#ifdef CONFIG_KVM
> +    if (riscv_use_emulated_aplic(aplic->msimode)) {
> +        aplic->kvm_msicfgaddr =3D extract64(addr, 0, 32);
> +        aplic->kvm_msicfgaddrH =3D extract64(addr, 32, 32);
> +    }
> +#endif
> +}
> +
>  static bool riscv_aplic_irq_rectified_val(RISCVAPLICState *aplic,
>                                            uint32_t irq)
>  {
> @@ -377,13 +387,16 @@ static void riscv_aplic_msi_send(RISCVAPLICState *a=
plic,
>      uint32_t lhxs, lhxw, hhxs, hhxw, group_idx, msicfgaddr, msicfgaddrH;
>
>      aplic_m =3D aplic;
> -    while (aplic_m && !aplic_m->mmode) {
> -        aplic_m =3D aplic_m->parent;
> -    }
> -    if (!aplic_m) {
> -        qemu_log_mask(LOG_GUEST_ERROR, "%s: m-level APLIC not found\n",
> -                      __func__);
> -        return;
> +
> +    if (!aplic->kvm_splitmode) {
> +        while (aplic_m && !aplic_m->mmode) {
> +            aplic_m =3D aplic_m->parent;
> +        }
> +        if (!aplic_m) {
> +            qemu_log_mask(LOG_GUEST_ERROR, "%s: m-level APLIC not found\=
n",
> +                          __func__);
> +            return;
> +        }
>      }
>
>      if (aplic->mmode) {
> @@ -415,6 +428,11 @@ static void riscv_aplic_msi_send(RISCVAPLICState *ap=
lic,
>      addr |=3D (uint64_t)(guest_idx & APLIC_xMSICFGADDR_PPN_HART(lhxs));
>      addr <<=3D APLIC_xMSICFGADDR_PPN_SHIFT;
>
> +    if (aplic->kvm_splitmode) {
> +        addr |=3D aplic->kvm_msicfgaddr;
> +        addr |=3D ((uint64_t)aplic->kvm_msicfgaddrH << 32);
> +    }
> +
>      address_space_stl_le(&address_space_memory, addr,
>                           eiid, MEMTXATTRS_UNSPECIFIED, &result);
>      if (result !=3D MEMTX_OK) {
> @@ -888,6 +906,10 @@ static void riscv_aplic_realize(DeviceState *dev, Er=
ror **errp)
>          memory_region_init_io(&aplic->mmio, OBJECT(dev), &riscv_aplic_op=
s,
>                                aplic, TYPE_RISCV_APLIC, aplic->aperture_s=
ize);
>          sysbus_init_mmio(SYS_BUS_DEVICE(dev), &aplic->mmio);
> +
> +        if (kvm_enabled()) {
> +            aplic->kvm_splitmode =3D true;
> +        }
>      }
>
>      /*
> @@ -935,8 +957,8 @@ static Property riscv_aplic_properties[] =3D {
>
>  static const VMStateDescription vmstate_riscv_aplic =3D {
>      .name =3D "riscv_aplic",
> -    .version_id =3D 1,
> -    .minimum_version_id =3D 1,
> +    .version_id =3D 2,
> +    .minimum_version_id =3D 2,
>      .fields =3D (const VMStateField[]) {
>              VMSTATE_UINT32(domaincfg, RISCVAPLICState),
>              VMSTATE_UINT32(mmsicfgaddr, RISCVAPLICState),
> @@ -944,6 +966,8 @@ static const VMStateDescription vmstate_riscv_aplic =
=3D {
>              VMSTATE_UINT32(smsicfgaddr, RISCVAPLICState),
>              VMSTATE_UINT32(smsicfgaddrH, RISCVAPLICState),
>              VMSTATE_UINT32(genmsi, RISCVAPLICState),
> +            VMSTATE_UINT32(kvm_msicfgaddr, RISCVAPLICState),
> +            VMSTATE_UINT32(kvm_msicfgaddrH, RISCVAPLICState),
>              VMSTATE_VARRAY_UINT32(sourcecfg, RISCVAPLICState,
>                                    num_irqs, 0,
>                                    vmstate_info_uint32, uint32_t),
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index 39fd9b7c3e..e5202bad10 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -1221,7 +1221,7 @@ static DeviceState *virt_create_aia(RISCVVirtAIATyp=
e aia_type, int aia_guests,
>                                      int base_hartid, int hart_count)
>  {
>      int i;
> -    hwaddr addr;
> +    hwaddr addr =3D 0;
>      uint32_t guest_bits;
>      DeviceState *aplic_s =3D NULL;
>      DeviceState *aplic_m =3D NULL;
> @@ -1271,6 +1271,10 @@ static DeviceState *virt_create_aia(RISCVVirtAIATy=
pe aia_type, int aia_guests,
>                                   VIRT_IRQCHIP_NUM_PRIO_BITS,
>                                   msimode, false, aplic_m);
>
> +    if (kvm_enabled() && msimode) {
> +        riscv_aplic_set_kvm_msicfgaddr(RISCV_APLIC(aplic_s), addr);
> +    }
> +
>      return kvm_enabled() ? aplic_s : aplic_m;
>  }
>
> diff --git a/include/hw/intc/riscv_aplic.h b/include/hw/intc/riscv_aplic.=
h
> index 74ae5d87b5..489b9133c2 100644
> --- a/include/hw/intc/riscv_aplic.h
> +++ b/include/hw/intc/riscv_aplic.h
> @@ -68,11 +68,17 @@ struct RISCVAPLICState {
>      uint32_t num_irqs;
>      bool msimode;
>      bool mmode;
> +
> +    /* To support KVM aia=3Daplic-imsic with irqchip split mode */
> +    bool kvm_splitmode;
> +    uint32_t kvm_msicfgaddr;
> +    uint32_t kvm_msicfgaddrH;
>  };
>
>  void riscv_aplic_add_child(DeviceState *parent, DeviceState *child);
>  bool riscv_is_kvm_aia_aplic_imsic(bool msimode);
>  bool riscv_use_emulated_aplic(bool msimode);
> +void riscv_aplic_set_kvm_msicfgaddr(RISCVAPLICState *aplic, hwaddr addr)=
;
>
>  DeviceState *riscv_aplic_create(hwaddr addr, hwaddr size,
>      uint32_t hartid_base, uint32_t num_harts, uint32_t num_sources,
> --
> 2.45.2
>
>

