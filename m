Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EF36D60D0B
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2024 02:17:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDDnq-0006nG-Ln; Mon, 18 Nov 2024 21:17:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tDDno-0006mo-RE; Mon, 18 Nov 2024 21:17:17 -0500
Received: from mail-vk1-xa2c.google.com ([2607:f8b0:4864:20::a2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tDDnm-0001rO-Vz; Mon, 18 Nov 2024 21:17:16 -0500
Received: by mail-vk1-xa2c.google.com with SMTP id
 71dfb90a1353d-514589ac56dso1283436e0c.0; 
 Mon, 18 Nov 2024 18:17:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731982633; x=1732587433; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aEBhBJfHlNKcP8lByG25KgB4lVyRtjB4I28rAwSLLU8=;
 b=iC+87z/5zHE6Jcno5SGqxxt8LQhr1bUeVtcGFLbWHmqLChDCGRhv+gF+nVEeW39VtN
 h9dk4ZXlV31J11VOVrDWa3Na3RMwfTvSXkfbXnx3fcqyg/YFpj+ePkNr/8KP4UyD2708
 mshQBECzknhJ8X28ZX30xNsqVHfHnz/pIsbhBXSpclAZnoV0OShITKu/oX55Fyl79Nnw
 iORt7c7KGTKOq7RdH5WdPKNoj4qIfbZk5BAd2M+b7IvpXIZzQR1fwGdpcQyVNNuh/3LK
 +A0tH8JkShpWA+J/fE5uEKYvDt2wUzaDm4Q6Z4nav8RvtsmhDdq+P5/DWd+E+QN+Pbj9
 r7OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731982633; x=1732587433;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aEBhBJfHlNKcP8lByG25KgB4lVyRtjB4I28rAwSLLU8=;
 b=ZTa50ldl2vz6iptUtQPp1trPSsaVR0OkchqxqQGYTpUlzgXXZh8RXeIk8prLxH89ch
 yDECfPBYREIc7q5/mZXGSKjglxJA1wiEyoIh8PkKsPyiPwPj66XxN/QeKylGYgzn4aY4
 CSv96PiemMLkM865vq4BeUSh0UD4AVSuRV2nuYeIhBG01awLHkNkDfkb/cAivzFM4877
 r13qGPDj9TpfhtoSkxF7o3uvxnNdfySEtac+5QdBdFnas7oAcEQs7xGOqrccB6VKPdqP
 mHby54EMEVmiZehUQJKQ0QQANGOfGhtxSyWb9/Qogk7yUW/b/UuscweAvdUqUyNs2GHk
 Wy+w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVM9DKo1MqRP460aGz+etUo0AMioRq8Q5th1L5LQ2X7XeHXmSHWgWi+OFFD6SjSzBcpeYs3q+3Rg5Wf@nongnu.org
X-Gm-Message-State: AOJu0Yw5lxjtJ6dlUpWVAGYhSPYL1ZqWGfVaUFsQViSOHgkITbN+SJ1p
 gIZTvkPlWg7zXpxlQbt4KNcfqjbOwXtcmILCWHKX3IstLdyQ7C10NRV2T++LvhZu0YLhrGGq4BJ
 dWjTXwJvU9xlcVq5YOteXTYJScN4=
X-Google-Smtp-Source: AGHT+IGbw7woWi4+gVNSVTbS9dyH7G1EjQZHhmMf0XeND7EaD5MAehs8SosofE72CIbaAsW/55n6o9/YUi1p7nbmTh4=
X-Received: by 2002:a05:6122:3d0d:b0:50d:918d:4da1 with SMTP id
 71dfb90a1353d-51477ee3893mr14343849e0c.3.1731982633594; Mon, 18 Nov 2024
 18:17:13 -0800 (PST)
MIME-Version: 1.0
References: <20241106133407.604587-1-dbarboza@ventanamicro.com>
 <20241106133407.604587-7-dbarboza@ventanamicro.com>
In-Reply-To: <20241106133407.604587-7-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 19 Nov 2024 12:16:47 +1000
Message-ID: <CAKmqyKOuNuu0CKjxNUMViKFGnsCkNqLQQEtS1=6Jewq6Cqmd9w@mail.gmail.com>
Subject: Re: [PATCH for-10.0 6/7] hw/riscv/riscv-iommu: implement reset
 protocol
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2c;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa2c.google.com
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

On Wed, Nov 6, 2024 at 11:35=E2=80=AFPM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> Add a riscv_iommu_reset() helper in the base emulation code that
> implements the expected reset behavior as defined by the riscv-iommu
> spec.
>
> Devices can then use this helper in their own reset callbacks.
>
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/riscv/riscv-iommu-pci.c | 20 ++++++++++++++++++++
>  hw/riscv/riscv-iommu-sys.c | 20 ++++++++++++++++++++
>  hw/riscv/riscv-iommu.c     | 35 +++++++++++++++++++++++++++++++++++
>  hw/riscv/riscv-iommu.h     |  1 +
>  hw/riscv/trace-events      |  2 ++
>  include/hw/riscv/iommu.h   |  6 ++++--
>  6 files changed, 82 insertions(+), 2 deletions(-)
>
> diff --git a/hw/riscv/riscv-iommu-pci.c b/hw/riscv/riscv-iommu-pci.c
> index 4ce9bf6b78..51226c4877 100644
> --- a/hw/riscv/riscv-iommu-pci.c
> +++ b/hw/riscv/riscv-iommu-pci.c
> @@ -31,6 +31,7 @@
>  #include "cpu_bits.h"
>  #include "riscv-iommu.h"
>  #include "riscv-iommu-bits.h"
> +#include "trace.h"
>
>  /* RISC-V IOMMU PCI Device Emulation */
>  #define RISCV_PCI_CLASS_SYSTEM_IOMMU     0x0806
> @@ -66,6 +67,12 @@ typedef struct RISCVIOMMUStatePci {
>      RISCVIOMMUState  iommu;   /* common IOMMU state */
>  } RISCVIOMMUStatePci;
>
> +struct RISCVIOMMUPciClass {
> +    /*< public >*/
> +    DeviceRealize parent_realize;
> +    ResettablePhases parent_phases;
> +};
> +
>  /* interrupt delivery callback */
>  static void riscv_iommu_pci_notify(RISCVIOMMUState *iommu, unsigned vect=
or)
>  {
> @@ -167,10 +174,23 @@ static Property riscv_iommu_pci_properties[] =3D {
>      DEFINE_PROP_END_OF_LIST(),
>  };
>
> +static void riscv_iommu_pci_reset_hold(Object *obj, ResetType type)
> +{
> +    RISCVIOMMUStatePci *pci =3D RISCV_IOMMU_PCI(obj);
> +    RISCVIOMMUState *iommu =3D &pci->iommu;
> +
> +    riscv_iommu_reset(iommu);
> +
> +    trace_riscv_iommu_pci_reset_hold(type);
> +}
> +
>  static void riscv_iommu_pci_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc =3D DEVICE_CLASS(klass);
>      PCIDeviceClass *k =3D PCI_DEVICE_CLASS(klass);
> +    ResettableClass *rc =3D RESETTABLE_CLASS(klass);
> +
> +    rc->phases.hold =3D riscv_iommu_pci_reset_hold;
>
>      k->realize =3D riscv_iommu_pci_realize;
>      k->exit =3D riscv_iommu_pci_exit;
> diff --git a/hw/riscv/riscv-iommu-sys.c b/hw/riscv/riscv-iommu-sys.c
> index a0ef67a20b..605979a0ac 100644
> --- a/hw/riscv/riscv-iommu-sys.c
> +++ b/hw/riscv/riscv-iommu-sys.c
> @@ -54,6 +54,12 @@ struct RISCVIOMMUStateSys {
>      uint8_t *msix_pba;
>  };
>
> +struct RISCVIOMMUSysClass {
> +    /*< public >*/
> +    DeviceRealize parent_realize;
> +    ResettablePhases parent_phases;
> +};
> +
>  static uint64_t msix_table_mmio_read(void *opaque, hwaddr addr,
>                                       unsigned size)
>  {
> @@ -212,9 +218,23 @@ static Property riscv_iommu_sys_properties[] =3D {
>      DEFINE_PROP_END_OF_LIST(),
>  };
>
> +static void riscv_iommu_sys_reset_hold(Object *obj, ResetType type)
> +{
> +    RISCVIOMMUStateSys *sys =3D RISCV_IOMMU_SYS(obj);
> +    RISCVIOMMUState *iommu =3D &sys->iommu;
> +
> +    riscv_iommu_reset(iommu);
> +
> +    trace_riscv_iommu_sys_reset_hold(type);
> +}
> +
>  static void riscv_iommu_sys_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc =3D DEVICE_CLASS(klass);
> +    ResettableClass *rc =3D RESETTABLE_CLASS(klass);
> +
> +    rc->phases.hold =3D riscv_iommu_sys_reset_hold;
> +
>      dc->realize =3D riscv_iommu_sys_realize;
>      set_bit(DEVICE_CATEGORY_MISC, dc->categories);
>      device_class_set_props(dc, riscv_iommu_sys_properties);
> diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
> index 239f83f5bd..cf2019d6aa 100644
> --- a/hw/riscv/riscv-iommu.c
> +++ b/hw/riscv/riscv-iommu.c
> @@ -2228,6 +2228,41 @@ static void riscv_iommu_unrealize(DeviceState *dev=
)
>      g_hash_table_unref(s->ctx_cache);
>  }
>
> +void riscv_iommu_reset(RISCVIOMMUState *s)
> +{
> +    uint32_t reg_clr;
> +    int ddtp_mode;
> +
> +    /*
> +     * Clear DDTP while setting DDTP_mode back to user
> +     * initial setting.
> +     */
> +    ddtp_mode =3D s->enable_off ?
> +                RISCV_IOMMU_DDTP_MODE_OFF : RISCV_IOMMU_DDTP_MODE_BARE;
> +    s->ddtp =3D set_field(0, RISCV_IOMMU_DDTP_MODE, ddtp_mode);
> +    riscv_iommu_reg_set64(s, RISCV_IOMMU_REG_DDTP, s->ddtp);
> +
> +    reg_clr =3D RISCV_IOMMU_CQCSR_CQEN | RISCV_IOMMU_CQCSR_CIE |
> +              RISCV_IOMMU_CQCSR_CQON | RISCV_IOMMU_CQCSR_BUSY;
> +    riscv_iommu_reg_mod32(s, RISCV_IOMMU_REG_CQCSR, 0, reg_clr);
> +
> +    reg_clr =3D RISCV_IOMMU_FQCSR_FQEN | RISCV_IOMMU_FQCSR_FIE |
> +              RISCV_IOMMU_FQCSR_FQON | RISCV_IOMMU_FQCSR_BUSY;
> +    riscv_iommu_reg_mod32(s, RISCV_IOMMU_REG_FQCSR, 0, reg_clr);
> +
> +    reg_clr =3D RISCV_IOMMU_PQCSR_PQEN | RISCV_IOMMU_PQCSR_PIE |
> +              RISCV_IOMMU_PQCSR_PQON | RISCV_IOMMU_PQCSR_BUSY;
> +    riscv_iommu_reg_mod32(s, RISCV_IOMMU_REG_PQCSR, 0, reg_clr);
> +
> +    riscv_iommu_reg_mod64(s, RISCV_IOMMU_REG_TR_REQ_CTL, 0,
> +                          RISCV_IOMMU_TR_REQ_CTL_GO_BUSY);
> +
> +    riscv_iommu_reg_set32(s, RISCV_IOMMU_REG_IPSR, 0);
> +
> +    g_hash_table_remove_all(s->ctx_cache);
> +    g_hash_table_remove_all(s->iot_cache);
> +}
> +
>  static Property riscv_iommu_properties[] =3D {
>      DEFINE_PROP_UINT32("version", RISCVIOMMUState, version,
>          RISCV_IOMMU_SPEC_DOT_VER),
> diff --git a/hw/riscv/riscv-iommu.h b/hw/riscv/riscv-iommu.h
> index f9f2827808..9424989df4 100644
> --- a/hw/riscv/riscv-iommu.h
> +++ b/hw/riscv/riscv-iommu.h
> @@ -89,6 +89,7 @@ struct RISCVIOMMUState {
>  void riscv_iommu_pci_setup_iommu(RISCVIOMMUState *iommu, PCIBus *bus,
>           Error **errp);
>  void riscv_iommu_set_cap_igs(RISCVIOMMUState *s, riscv_iommu_igs_mode mo=
de);
> +void riscv_iommu_reset(RISCVIOMMUState *s);
>
>  /* private helpers */
>
> diff --git a/hw/riscv/trace-events b/hw/riscv/trace-events
> index 94facbb8b1..aaa2c0eb94 100644
> --- a/hw/riscv/trace-events
> +++ b/hw/riscv/trace-events
> @@ -17,3 +17,5 @@ riscv_iommu_ats_inval(const char *id) "%s: dev-iotlb in=
validate"
>  riscv_iommu_ats_prgr(const char *id) "%s: dev-iotlb page request group r=
esponse"
>  riscv_iommu_sys_irq_sent(uint32_t vector) "IRQ sent to vector %u"
>  riscv_iommu_sys_msi_sent(uint32_t vector, uint64_t msi_addr, uint32_t ms=
i_data, uint32_t result) "MSI sent to vector %u msi_addr 0x%lx msi_data 0x%=
x result %u"
> +riscv_iommu_sys_reset_hold(int reset_type) "reset type %d"
> +riscv_iommu_pci_reset_hold(int reset_type) "reset type %d"
> diff --git a/include/hw/riscv/iommu.h b/include/hw/riscv/iommu.h
> index 8a8acfc3f0..b03339d75c 100644
> --- a/include/hw/riscv/iommu.h
> +++ b/include/hw/riscv/iommu.h
> @@ -30,12 +30,14 @@ typedef struct RISCVIOMMUState RISCVIOMMUState;
>  typedef struct RISCVIOMMUSpace RISCVIOMMUSpace;
>
>  #define TYPE_RISCV_IOMMU_PCI "riscv-iommu-pci"
> -OBJECT_DECLARE_SIMPLE_TYPE(RISCVIOMMUStatePci, RISCV_IOMMU_PCI)
> +OBJECT_DECLARE_TYPE(RISCVIOMMUStatePci, RISCVIOMMUPciClass, RISCV_IOMMU_=
PCI)
>  typedef struct RISCVIOMMUStatePci RISCVIOMMUStatePci;
> +typedef struct RISCVIOMMUPciClass RISCVIOMMUPciClass;
>
>  #define TYPE_RISCV_IOMMU_SYS "riscv-iommu-device"
> -OBJECT_DECLARE_SIMPLE_TYPE(RISCVIOMMUStateSys, RISCV_IOMMU_SYS)
> +OBJECT_DECLARE_TYPE(RISCVIOMMUStateSys, RISCVIOMMUSysClass, RISCV_IOMMU_=
SYS)
>  typedef struct RISCVIOMMUStateSys RISCVIOMMUStateSys;
> +typedef struct RISCVIOMMUSysClass RISCVIOMMUSysClass;
>
>  #define FDT_IRQ_TYPE_EDGE_LOW 1
>
> --
> 2.45.2
>
>

