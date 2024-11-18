Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0605CD10F3A
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2024 01:34:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tCqey-000336-Qf; Sun, 17 Nov 2024 20:34:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tCqex-00032t-Ag; Sun, 17 Nov 2024 20:34:35 -0500
Received: from mail-vk1-xa33.google.com ([2607:f8b0:4864:20::a33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tCqev-0001fE-Q9; Sun, 17 Nov 2024 20:34:35 -0500
Received: by mail-vk1-xa33.google.com with SMTP id
 71dfb90a1353d-5146e6531c8so1133251e0c.0; 
 Sun, 17 Nov 2024 17:34:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731893672; x=1732498472; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oMUpE4aJ1OXI00/wqKIypJGHSEs0Ji+n92UWtdWldPk=;
 b=IGXdaPAFdPsg2tCuAeSX4NUPS+ACkK4oP8dlhmdp8773u3cTF3TTHSXBNJo3ifJX0M
 esKql/9ObX+aSO8zmrhFNVVxlUxFlzObkaEMQRgzrJhxw0orQGh9zOc51KYAoBrKjMYy
 vgHRJ1/GPlev05q9WTJw5J+/JiAJPy5G/kao7K5xXsNWINgI3FA6xSEpVhScrc7BRZMI
 nDTIFjmMu1QZz+fHG4gxVsnbsTpB2idnJ9w3FXpXX01VUdxQh6j0E2iBLVW45NLth62y
 wWXUXA4h8gNSoJbrD+XbyEMaaly1TqLeXZnt6fhXJ30tDjO55IhYnXiyocsMXSSV8yiC
 oVFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731893672; x=1732498472;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oMUpE4aJ1OXI00/wqKIypJGHSEs0Ji+n92UWtdWldPk=;
 b=IT9eGgC7Yc9nRv6jPW2xE/Ez3tOpHGZ4XPm4lkDIiBeC/09q+npAOQSdxmVXeb4Bi+
 GyIXIr0A24BsmzwTFB4GCJ21Mjdgb8AvMSUtXXbsn7mZvyELuhPr0bQHHOQb6LaY389Z
 HRp/yEvhNiDcvlA8t9bZQ8ZVDwaB4XqCOxT93n9M8Knqvyrm1JHlNCFr3G+JEfO21C6o
 YbTFRj3jbY9ndAmbzGX5P+7uCvaSNirIpyRwwZxKGvd4eeuRKVdT0Y8ANnbGXv6Lj8Oz
 x1oPcOo0zPH0iMOFnQ8yZ1p7K9iI5wIAObUQEO8voDB0fMGxb4YgLYIVf416QYeA8MDq
 cQuQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXcjB5hcHq/KPxv6mzgEuraL1Xmgx0dY4Vd32pP95X41A1u1X6lwlWliIdhxB/2W7/ixbf+jbwG1qw8@nongnu.org
X-Gm-Message-State: AOJu0YzV9HdZHx68+ox19S8NuhnI7mKUis0vLjnn/XbGma9g/e/jvIlo
 s7H1tYZbzTy4VyQJZFUXlMRzk6GeRF32FdKFCYzlA9Gtpv0nUPS/etlG0cLll8g4sAIa/l8qBOy
 uLRtlun/MrwM5Dul0jA9dwLEGPaOq3Q==
X-Google-Smtp-Source: AGHT+IGkPvLggRDRfzNWRr7vE/8s6RlhBvs2FdNl1LUehub/FDqYLGr2WQlQ1jDicc+geoN/Aj3FuNhydoCxHqw0phc=
X-Received: by 2002:a05:6122:1794:b0:50d:3ec1:1546 with SMTP id
 71dfb90a1353d-51477f148b9mr9385791e0c.4.1731893672218; Sun, 17 Nov 2024
 17:34:32 -0800 (PST)
MIME-Version: 1.0
References: <20241010190337.376987-1-dbarboza@ventanamicro.com>
 <20241010190337.376987-4-dbarboza@ventanamicro.com>
In-Reply-To: <20241010190337.376987-4-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 18 Nov 2024 11:34:06 +1000
Message-ID: <CAKmqyKND=aAwDJDSaG=T02By0MnQviYMwiWXF1=i6JkKsdj_cQ@mail.gmail.com>
Subject: Re: [PATCH 3/8] hw/riscv/virt.c: rename helper to
 virt_use_kvm_aia_aplic_imsic()
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com, ajones@ventanamicro.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a33;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa33.google.com
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

On Fri, Oct 11, 2024 at 5:04=E2=80=AFAM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> Similar to the riscv_is_kvm_aia_aplic_imsic() helper from riscv_aplic.c,
> the existing virt_use_kvm_aia() is testing for KVM aia=3Daplic-imsic with
> in-kernel irqchip enabled. It is not checking for a generic AIA support.
>
> Rename the helper to virt_use_kvm_aia_aplic_imsic() to reflect what the
> helper is doing, and use the existing riscv_is_kvm_aia_aplic_imsic() to
> obscure details such as the presence of the in-kernel irqchip.
>
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/riscv/virt.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index b5bdbb34e0..f1bdc1c535 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -57,9 +57,11 @@
>  #include "hw/virtio/virtio-iommu.h"
>
>  /* KVM AIA only supports APLIC MSI. APLIC Wired is always emulated by QE=
MU. */
> -static bool virt_use_kvm_aia(RISCVVirtState *s)
> +static bool virt_use_kvm_aia_aplic_imsic(RISCVVirtAIAType aia_type)
>  {
> -    return kvm_irqchip_in_kernel() && s->aia_type =3D=3D VIRT_AIA_TYPE_A=
PLIC_IMSIC;
> +    bool msimode =3D aia_type =3D=3D VIRT_AIA_TYPE_APLIC_IMSIC;
> +
> +    return riscv_is_kvm_aia_aplic_imsic(msimode);
>  }
>
>  static bool virt_aclint_allowed(void)
> @@ -774,8 +776,8 @@ static void create_fdt_sockets(RISCVVirtState *s, con=
st MemMapEntry *memmap,
>          *msi_pcie_phandle =3D msi_s_phandle;
>      }
>
> -    /* KVM AIA only has one APLIC instance */
> -    if (kvm_enabled() && virt_use_kvm_aia(s)) {
> +    /* KVM AIA aplic-imsic only has one APLIC instance */
> +    if (kvm_enabled() && virt_use_kvm_aia_aplic_imsic(s->aia_type)) {
>          create_fdt_socket_aplic(s, memmap, 0,
>                                  msi_m_phandle, msi_s_phandle, phandle,
>                                  &intc_phandles[0], xplic_phandles,
> @@ -1540,7 +1542,7 @@ static void virt_machine_init(MachineState *machine=
)
>          }
>      }
>
> -    if (kvm_enabled() && virt_use_kvm_aia(s)) {
> +    if (kvm_enabled() && virt_use_kvm_aia_aplic_imsic(s->aia_type)) {
>          kvm_riscv_aia_create(machine, IMSIC_MMIO_GROUP_MIN_SHIFT,
>                               VIRT_IRQCHIP_NUM_SOURCES, VIRT_IRQCHIP_NUM_=
MSIS,
>                               memmap[VIRT_APLIC_S].base,
> --
> 2.45.2
>
>

