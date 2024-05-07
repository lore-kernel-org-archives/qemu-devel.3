Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBF7FC25B4F
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 09:07:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4GmT-0007ZO-Ns; Tue, 07 May 2024 05:06:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1s4GmS-0007YU-5H
 for qemu-devel@nongnu.org; Tue, 07 May 2024 05:06:36 -0400
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1s4GmP-0006Zu-7B
 for qemu-devel@nongnu.org; Tue, 07 May 2024 05:06:35 -0400
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-51f174e316eso3151370e87.0
 for <qemu-devel@nongnu.org>; Tue, 07 May 2024 02:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1715072790; x=1715677590; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AeTLInywx/8jWc09cXAEdBRVupgy2H4EYNKJEbF3QfY=;
 b=mcZVc5Ir0ROJnAz5x3JnWLuY10YeI4nfNFOx29LEmf1Sk2xQVUkd7f2Xu5qHxsCKkI
 olInMwoKhziZD0kP8y4O4Pk+xxuGhwg/xSgtUpzN4FNG+zss0RisJ81hfsNbr+MY3y5x
 glJiuCnv4Y0bOCjQPwmKWe8LAviIIUh3U8HDf3Y723usjUkhl1akU4CHIKxMOs1POB0V
 yJHyg4/E2+QCvf5+61rIK3gJ2hSKktx4My8SXCHbwZ2+5vF3GlE8c9QE9njwwJFEYxWV
 /+ZVIrofCh6TMbpnRes3G3IaT+lHaZqww7iBYBZpEy7g2yIs4FGGw7oWewPy0gI/Qxll
 YbVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715072790; x=1715677590;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AeTLInywx/8jWc09cXAEdBRVupgy2H4EYNKJEbF3QfY=;
 b=AfS099jccdIa6L3aEnHkJe458NxADWroS1Ic70+LyPu9Kw9rkNF91zyEm+NEOoitNR
 y+HqzdD+DGJ/H/z+vOHKMqy1Q3yHRWve2avPnrry9nh+perFbk1ZSahMCXBtRqaJffzt
 8poKuea3Z5FWmK2DCOCoFe6NmHMouCs5g28ZSrMQEavOimx6DRagARG+caA6rESltYo1
 yA//J56CD4yJ0ovMA7WKFA4pzMLmCgE//0LwpX0Ig0HcIaIZSWyDxtghY5u2bfydxoQ2
 yzQB2BboVV1nW8bs7fyjmJ7Y3kQmTlKCGLvcEN+CHAvfPaAMUcoE177gTfAETCgfH2c2
 jsuA==
X-Gm-Message-State: AOJu0YxaI5i2ttIuYwMHBT0RwL/PpHLHHICYxrsp/eeuDcZm0UBJy1hT
 zUlEFKnIjukvGHd0sO+qpgMmFPEozcGXi6f9tikRMw7PdQydYWvNwWJ4qWmr+lNWnMVDQULXbN2
 INaXqTCQbwafpCQp+4hxReaUcG9IEUdeHDlJIlYkw90jnhJYD8Yma4T0/JnTpjPMjCvk+djpaVa
 KYsds7kIX4IPuCcY/zz+HOuNqFYXsY8B7UiOvU52Cj5A==
X-Google-Smtp-Source: AGHT+IEdZRNGVO75Th60Xo9Q2qXmSgTQFg7hyActGbsBNH6E0gfeYUePQEab7Z2RVRFUIa71iFLO9g==
X-Received: by 2002:a05:6512:793:b0:51d:a87d:b6f3 with SMTP id
 x19-20020a056512079300b0051da87db6f3mr6386864lfr.39.1715072790206; 
 Tue, 07 May 2024 02:06:30 -0700 (PDT)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com.
 [209.85.208.173]) by smtp.gmail.com with ESMTPSA id
 t29-20020a192d5d000000b0051f0da61e60sm2041842lft.55.2024.05.07.02.06.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 May 2024 02:06:29 -0700 (PDT)
Received: by mail-lj1-f173.google.com with SMTP id
 38308e7fff4ca-2e30c625178so25589721fa.1; 
 Tue, 07 May 2024 02:06:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCXK73Aqy+k3vxTOkMSGkMKRpHtO2VJVaj+K+JxiMBI6ZUuS9h4Rgfti0Kn4Da67CoJyZxaGPbpUp0mcOzaktBLVAHyl1+g=
X-Received: by 2002:a2e:7d07:0:b0:2de:809c:c67b with SMTP id
 y7-20020a2e7d07000000b002de809cc67bmr7064516ljc.24.1715072789595; Tue, 07 May
 2024 02:06:29 -0700 (PDT)
MIME-Version: 1.0
References: <20240307160319.675044-1-dbarboza@ventanamicro.com>
 <20240307160319.675044-15-dbarboza@ventanamicro.com>
In-Reply-To: <20240307160319.675044-15-dbarboza@ventanamicro.com>
From: Frank Chang <frank.chang@sifive.com>
Date: Tue, 7 May 2024 17:06:18 +0800
X-Gmail-Original-Message-ID: <CANzO1D3JJqf_CAAXkHxEuiY9rvy5W4HOOnDYMG9-S7Yd7ArWPQ@mail.gmail.com>
Message-ID: <CANzO1D3JJqf_CAAXkHxEuiY9rvy5W4HOOnDYMG9-S7Yd7ArWPQ@mail.gmail.com>
Subject: Re: [PATCH v2 14/15] hw/misc: EDU: added PASID support
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com, ajones@ventanamicro.com, tjeznach@rivosinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=frank.chang@sifive.com; helo=mail-lf1-x134.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Hi Daniel,

Daniel Henrique Barboza <dbarboza@ventanamicro.com> =E6=96=BC 2024=E5=B9=B4=
3=E6=9C=888=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8A=E5=8D=8812:05=E5=AF=AB=E9=
=81=93=EF=BC=9A

>
> From: Tomasz Jeznach <tjeznach@rivosinc.com>
>
> Extension to support DMA with PASID identifier and reporting PASID
> extended PCIe capabilities.
>
> Signed-off-by: Tomasz Jeznach <tjeznach@rivosinc.com>
> ---
>  hw/misc/edu.c | 57 +++++++++++++++++++++++++++++++++++++++------------
>  1 file changed, 44 insertions(+), 13 deletions(-)
>
> diff --git a/hw/misc/edu.c b/hw/misc/edu.c
> index 2a976ca2b1..522cec85b3 100644
> --- a/hw/misc/edu.c
> +++ b/hw/misc/edu.c
> @@ -26,6 +26,7 @@
>  #include "qemu/units.h"
>  #include "hw/pci/pci.h"
>  #include "hw/hw.h"
> +#include "hw/qdev-properties.h"
>  #include "hw/pci/msi.h"
>  #include "qemu/timer.h"
>  #include "qom/object.h"
> @@ -53,6 +54,8 @@ struct EduState {
>      QemuCond thr_cond;
>      bool stopping;
>
> +    bool enable_pasid;
> +
>      uint32_t addr4;
>      uint32_t fact;
>  #define EDU_STATUS_COMPUTING    0x01
> @@ -66,6 +69,9 @@ struct EduState {
>  # define EDU_DMA_FROM_PCI       0
>  # define EDU_DMA_TO_PCI         1
>  #define EDU_DMA_IRQ             0x4
> +#define EDU_DMA_PV              0x8
> +#define EDU_DMA_PASID(cmd)      (((cmd) >> 8) & ((1U << 20) - 1))
> +
>      struct dma_state {
>          dma_addr_t src;
>          dma_addr_t dst;
> @@ -126,12 +132,7 @@ static void edu_check_range(uint64_t addr, uint64_t =
size1, uint64_t start,
>
>  static dma_addr_t edu_clamp_addr(const EduState *edu, dma_addr_t addr)
>  {
> -    dma_addr_t res =3D addr & edu->dma_mask;
> -
> -    if (addr !=3D res) {
> -        printf("EDU: clamping DMA %#.16"PRIx64" to %#.16"PRIx64"!\n", ad=
dr, res);
> -    }
> -
> +    dma_addr_t res =3D addr;
>      return res;
>  }
>
> @@ -139,23 +140,33 @@ static void edu_dma_timer(void *opaque)
>  {
>      EduState *edu =3D opaque;
>      bool raise_irq =3D false;
> +    MemTxAttrs attrs =3D MEMTXATTRS_UNSPECIFIED;
>
>      if (!(edu->dma.cmd & EDU_DMA_RUN)) {
>          return;
>      }
>
> +    if (edu->enable_pasid && (edu->dma.cmd & EDU_DMA_PV)) {
> +        attrs.unspecified =3D 0;
> +        attrs.pasid =3D EDU_DMA_PASID(edu->dma.cmd);
> +        attrs.requester_id =3D pci_requester_id(&edu->pdev);
> +        attrs.secure =3D 0;
> +    }
> +
>      if (EDU_DMA_DIR(edu->dma.cmd) =3D=3D EDU_DMA_FROM_PCI) {
>          uint64_t dst =3D edu->dma.dst;
>          edu_check_range(dst, edu->dma.cnt, DMA_START, DMA_SIZE);
>          dst -=3D DMA_START;
> -        pci_dma_read(&edu->pdev, edu_clamp_addr(edu, edu->dma.src),
> -                edu->dma_buf + dst, edu->dma.cnt);
> +        pci_dma_rw(&edu->pdev, edu_clamp_addr(edu, edu->dma.src),
> +                edu->dma_buf + dst, edu->dma.cnt,
> +                DMA_DIRECTION_TO_DEVICE, attrs);
>      } else {
>          uint64_t src =3D edu->dma.src;
>          edu_check_range(src, edu->dma.cnt, DMA_START, DMA_SIZE);
>          src -=3D DMA_START;
> -        pci_dma_write(&edu->pdev, edu_clamp_addr(edu, edu->dma.dst),
> -                edu->dma_buf + src, edu->dma.cnt);
> +        pci_dma_rw(&edu->pdev, edu_clamp_addr(edu, edu->dma.dst),
> +                edu->dma_buf + src, edu->dma.cnt,
> +                DMA_DIRECTION_FROM_DEVICE, attrs);
>      }
>
>      edu->dma.cmd &=3D ~EDU_DMA_RUN;
> @@ -255,7 +266,8 @@ static void edu_mmio_write(void *opaque, hwaddr addr,=
 uint64_t val,
>          if (qatomic_read(&edu->status) & EDU_STATUS_COMPUTING) {
>              break;
>          }
> -        /* EDU_STATUS_COMPUTING cannot go 0->1 concurrently, because it =
is only
> +        /*
> +         * EDU_STATUS_COMPUTING cannot go 0->1 concurrently, because it =
is only
>           * set in this function and it is under the iothread mutex.
>           */
>          qemu_mutex_lock(&edu->thr_mutex);
> @@ -368,9 +380,21 @@ static void pci_edu_realize(PCIDevice *pdev, Error *=
*errp)
>  {
>      EduState *edu =3D EDU(pdev);
>      uint8_t *pci_conf =3D pdev->config;
> +    int pos;
>
>      pci_config_set_interrupt_pin(pci_conf, 1);
>
> +    pcie_endpoint_cap_init(pdev, 0);
> +
> +    /* PCIe extended capability for PASID */
> +    pos =3D PCI_CONFIG_SPACE_SIZE;
> +    if (edu->enable_pasid) {
> +        /* PCIe Spec 7.8.9 PASID Extended Capability Structure */
> +        pcie_add_capability(pdev, 0x1b, 1, pos, 8);
> +        pci_set_long(pdev->config + pos + 4, 0x00001400);
> +        pci_set_long(pdev->wmask + pos + 4,  0xfff0ffff);

We should use the defines declared in
include/standard-headers/linux/pci_regs.h for readability.

> +    }
> +
>      if (msi_init(pdev, 0, 1, true, false, errp)) {
>          return;
>      }
> @@ -404,20 +428,27 @@ static void pci_edu_uninit(PCIDevice *pdev)
>      msi_uninit(pdev);
>  }
>
> +

This new line is unnecessary.

>  static void edu_instance_init(Object *obj)
>  {
>      EduState *edu =3D EDU(obj);
>
> -    edu->dma_mask =3D (1UL << 28) - 1;
> +    edu->dma_mask =3D ~0ULL;

docs/specs/edu.txt says:
"For educational purposes, the device supports only 28 bits (256 MiB)
by default. Students shall set dma_mask for the device in the OS driver
properly."

We should either update the EDU spec or revert the change here.

>      object_property_add_uint64_ptr(obj, "dma_mask",
>                                     &edu->dma_mask, OBJ_PROP_FLAG_READWRI=
TE);
>  }
>
> +static Property edu_properties[] =3D {
> +    DEFINE_PROP_BOOL("pasid", EduState, enable_pasid, TRUE),
> +    DEFINE_PROP_END_OF_LIST(),
> +};
> +
>  static void edu_class_init(ObjectClass *class, void *data)
>  {
>      DeviceClass *dc =3D DEVICE_CLASS(class);
>      PCIDeviceClass *k =3D PCI_DEVICE_CLASS(class);
>
> +    device_class_set_props(dc, edu_properties);
>      k->realize =3D pci_edu_realize;
>      k->exit =3D pci_edu_uninit;
>      k->vendor_id =3D PCI_VENDOR_ID_QEMU;
> @@ -430,7 +461,7 @@ static void edu_class_init(ObjectClass *class, void *=
data)
>  static void pci_edu_register_types(void)
>  {
>      static InterfaceInfo interfaces[] =3D {
> -        { INTERFACE_CONVENTIONAL_PCI_DEVICE },
> +        { INTERFACE_PCIE_DEVICE },
>          { },
>      };
>      static const TypeInfo edu_info =3D {
> --
> 2.43.2
>
>

This commit introduces a new command for PASID (PV, bitwise OR of:
0x08; PASID, cmds[27:8]).
We should also update the EDU spec: docs/specs/edu.rst to address the chang=
es.


Regards,
Frank Chang

