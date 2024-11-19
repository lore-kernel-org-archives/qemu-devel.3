Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C678D60D06
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2024 01:24:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDCyL-0006yN-LN; Mon, 18 Nov 2024 20:24:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tDCyJ-0006y2-B4; Mon, 18 Nov 2024 20:24:03 -0500
Received: from mail-ua1-x931.google.com ([2607:f8b0:4864:20::931])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tDCyH-00046v-Q6; Mon, 18 Nov 2024 20:24:03 -0500
Received: by mail-ua1-x931.google.com with SMTP id
 a1e0cc1a2514c-85700f9cdd6so871953241.1; 
 Mon, 18 Nov 2024 17:24:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731979439; x=1732584239; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2IG6fw4P3agJH7Dqw1tukwMfCrX3ZhdsPN/fn7Hsylo=;
 b=BOe/FryJw38Y2Kwy9T8EaLxPnW22FMm+SDqkrNarBtrnnkUBVEAIqs4ucW3nBvSapB
 2+Eri6Y1TVO5kvI0jAE2IX4OTLB60IWPAkimx8TEyw8AVoQXo21IB/umCUzKzl8AVt4q
 h13gmrb4XNHeedQsg+eQeOaiUTE3q3/gzf0SAN6x2iDrJ9jzAEVV2ClwFNTEFg49F6Cz
 ZiSWBumECqivQ8H+d1FJfIqU9/dxVMb3779oMxCag0q0ipDz+31xRMBrgHtuMZ6xdhzL
 oC9AyrhjYiZP+fpMBT32u90hLc86vIOXKlWRJZn/ADq6mrd3+2SS+QCwZIAVkVQRIgCu
 Y08A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731979439; x=1732584239;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2IG6fw4P3agJH7Dqw1tukwMfCrX3ZhdsPN/fn7Hsylo=;
 b=SgNxxyiKPihdqmKwKWfAxYok8G6+0uHQbi5ix+phFV12BmmFuKpCtTbt0UawQ0EYZw
 86u4PLQYheV9xai74V7gtYqetXSvIJT3+Il6FNzFfrj/FfBbzeq5plTxqlB/vuxOtXp4
 wJxL9Ksg7XVJHUT4D0UV2TNGLyyxIsuRgRSm3VJKQol1oomlZESQZ/0BcAhGTKqtbIBn
 qCS7Sxa06Zr/jkl1aTZH37IkqJANkc5GPSSsowHMqSRs1ib/WiySlEKGl2P1vjzgWWad
 iHRmhpMLAkKdbrKEvA2k7HVsi147+O7j2Ei1gFTu9d5QhI4oKl49xexE7SSXp+ffAkre
 orJA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXBd/9Pq37/IsJNWcCutEdN6ybxhYh2PZSfOBoKrNOg7xvSpoTAEC6vV+FX8IXUcomi0U9tmVKkub9o@nongnu.org
X-Gm-Message-State: AOJu0YwcTlxLbJMhSZPD/Ce64uNQ0qZFpuneON7rVd9n31oIrtlaqAGG
 etpLolc8GuMUZB1tVH53Gox15i2OrbdklRxcmgFQoOr+mchgeYckFJus/vJ7KaaRuKbvFySJQb7
 6KmHx7X+dHga2er+nGWYmM9mxYP0=
X-Google-Smtp-Source: AGHT+IGdoEYwWWwrtUCPuuMZRSVO0ahkuD7mFvVXL9MBHaCqKxD+Yj3LOndalDoMtLUZYMFWUmDxDSKsPAbEkzmLcsc=
X-Received: by 2002:a05:6102:3e93:b0:498:c4e5:bc4f with SMTP id
 ada2fe7eead31-4ad62d18edemr13079219137.17.1731979439627; Mon, 18 Nov 2024
 17:23:59 -0800 (PST)
MIME-Version: 1.0
References: <20241106133407.604587-1-dbarboza@ventanamicro.com>
 <20241106133407.604587-3-dbarboza@ventanamicro.com>
In-Reply-To: <20241106133407.604587-3-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 19 Nov 2024 11:23:33 +1000
Message-ID: <CAKmqyKN2oizNFrqqyz-_zDqfS3=P1fWVhK8cX-619ej0am9=TA@mail.gmail.com>
Subject: Re: [PATCH for-10.0 2/7] hw/riscv/riscv-iommu: parametrize CAP.IGS
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::931;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x931.google.com
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

On Wed, Nov 6, 2024 at 11:36=E2=80=AFPM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> Interrupt Generation Support (IGS) is a capability that is tied to the
> interrupt deliver mechanism, not with the core IOMMU emulation. We
> should allow device implementations to set IGS as they wish.
>
> A new helper is added to make it easier for device impls to set IGS. Use
> it in our existing IOMMU device (riscv-iommu-pci) to set
> RISCV_IOMMU_CAPS_IGS_MSI.
>
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/riscv/riscv-iommu-bits.h | 6 ++++++
>  hw/riscv/riscv-iommu-pci.c  | 1 +
>  hw/riscv/riscv-iommu.c      | 5 +++++
>  hw/riscv/riscv-iommu.h      | 4 ++++
>  4 files changed, 16 insertions(+)
>
> diff --git a/hw/riscv/riscv-iommu-bits.h b/hw/riscv/riscv-iommu-bits.h
> index 6359ae0353..485f36b9c9 100644
> --- a/hw/riscv/riscv-iommu-bits.h
> +++ b/hw/riscv/riscv-iommu-bits.h
> @@ -88,6 +88,12 @@ struct riscv_iommu_pq_record {
>  #define RISCV_IOMMU_CAP_PD17            BIT_ULL(39)
>  #define RISCV_IOMMU_CAP_PD20            BIT_ULL(40)
>
> +enum riscv_iommu_igs_modes {
> +    RISCV_IOMMU_CAP_IGS_MSI =3D 0,
> +    RISCV_IOMMU_CAP_IGS_WSI,
> +    RISCV_IOMMU_CAP_IGS_BOTH
> +};
> +
>  /* 5.4 Features control register (32bits) */
>  #define RISCV_IOMMU_REG_FCTL            0x0008
>  #define RISCV_IOMMU_FCTL_BE             BIT(0)
> diff --git a/hw/riscv/riscv-iommu-pci.c b/hw/riscv/riscv-iommu-pci.c
> index a42242532d..4ce9bf6b78 100644
> --- a/hw/riscv/riscv-iommu-pci.c
> +++ b/hw/riscv/riscv-iommu-pci.c
> @@ -155,6 +155,7 @@ static void riscv_iommu_pci_init(Object *obj)
>      qdev_alias_all_properties(DEVICE(iommu), obj);
>
>      iommu->icvec_avail_vectors =3D RISCV_IOMMU_PCI_ICVEC_VECTORS;
> +    riscv_iommu_set_cap_igs(iommu, RISCV_IOMMU_CAP_IGS_MSI);
>  }
>
>  static Property riscv_iommu_pci_properties[] =3D {
> diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
> index 1893584028..d95b4b95d8 100644
> --- a/hw/riscv/riscv-iommu.c
> +++ b/hw/riscv/riscv-iommu.c
> @@ -2096,6 +2096,11 @@ static const MemoryRegionOps riscv_iommu_trap_ops =
=3D {
>      }
>  };
>
> +void riscv_iommu_set_cap_igs(RISCVIOMMUState *s, riscv_iommu_igs_mode mo=
de)
> +{
> +    s->cap =3D set_field(s->cap, RISCV_IOMMU_CAP_IGS, mode);
> +}
> +
>  static void riscv_iommu_instance_init(Object *obj)
>  {
>      RISCVIOMMUState *s =3D RISCV_IOMMU(obj);
> diff --git a/hw/riscv/riscv-iommu.h b/hw/riscv/riscv-iommu.h
> index da3f03440c..f9f2827808 100644
> --- a/hw/riscv/riscv-iommu.h
> +++ b/hw/riscv/riscv-iommu.h
> @@ -21,6 +21,9 @@
>
>  #include "qom/object.h"
>  #include "hw/riscv/iommu.h"
> +#include "hw/riscv/riscv-iommu-bits.h"
> +
> +typedef enum riscv_iommu_igs_modes riscv_iommu_igs_mode;
>
>  struct RISCVIOMMUState {
>      /*< private >*/
> @@ -85,6 +88,7 @@ struct RISCVIOMMUState {
>
>  void riscv_iommu_pci_setup_iommu(RISCVIOMMUState *iommu, PCIBus *bus,
>           Error **errp);
> +void riscv_iommu_set_cap_igs(RISCVIOMMUState *s, riscv_iommu_igs_mode mo=
de);
>
>  /* private helpers */
>
> --
> 2.45.2
>
>

