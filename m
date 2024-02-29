Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49DF1C54798
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 09:20:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfcaf-0005wo-SH; Thu, 29 Feb 2024 04:20:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1rfcac-0005tW-LG
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 04:20:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1rfcaU-0000bF-Sp
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 04:20:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709198419;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=epd5r8Aht0KH2PY0VvBXXlACH0mc8Tf1TL/ueYBMHWI=;
 b=gp2Cj1rAVqPWGzJrYhuuvRKIRKgmWYungFdOFNorPZbNrCjzM+lqAxXYAwMuep9ZCOHBBI
 MueQNrEoE+hk0It08uXk/sufQiZqJ610CcalK9pDxgljMwrl+QY0VTbo3fr8ow0OVIv4HY
 0D9erHWUZUQ9fcc2A+JwIDM+kwq/EqE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-340-FdWH-aKTOi66O6bS0lSBhQ-1; Thu, 29 Feb 2024 04:20:17 -0500
X-MC-Unique: FdWH-aKTOi66O6bS0lSBhQ-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-33d8b4175dbso337773f8f.0
 for <qemu-devel@nongnu.org>; Thu, 29 Feb 2024 01:20:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709198416; x=1709803216;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=epd5r8Aht0KH2PY0VvBXXlACH0mc8Tf1TL/ueYBMHWI=;
 b=vPPy5DiATWqyAFUs8CSiSnzWo1y+v7Rzeerjg64pIbWZ+/3Iez6Sm5kuuFFUzL2t3B
 Hr4yiU6rBlADQ9DKbq0eFyL9jqmYUjI5z6Ef5We4ZQzZ+hFw9sCpeNJhL3vPXDqnfi9K
 fZFSrE4+DtLalCMIGjJi6M7Y4BnrRESWtanQlBhs6VFk4Da6LGoInqrPnFxdx5+ZSLL+
 slxoJXfCHf9DMgMRWVsdKUQlKmZEMS1l1ZY4E77PvFSuRuHyF77+tIbE8Gw1+omjXJRc
 vFsa9p0+wsQnParI+z9DAFr22q7dhZ/64PWsi2O/6DF7lHHeNqBo8IBZhVSoXL7Ung/n
 q61w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVAceQiXJ7+dKsj9Il6Y8lCwgubvpt2EihYPHw+LyQp1Djua4DbOjpyjHqbAeGKs6Bq7w4tPUVRUbViEK0ySxjqe1t4b7Y=
X-Gm-Message-State: AOJu0YzgjXa1jebTIEH2Tb3baWyQKM0d5wVNJc/yBaqjK4cgFOMJW7rW
 RiMvkt0T9UrrDGlurrSl6j+unOLmtHhwLdnFsGz4549k5bSSOyZG39YkpErkoZBnapNNYyEfmMt
 D4AXJXlgvvCDdmXgBIwvaEm60IcureNrUXQB8ntlDD94Hp3beauUV
X-Received: by 2002:adf:e507:0:b0:33d:a43d:75e8 with SMTP id
 j7-20020adfe507000000b0033da43d75e8mr1123373wrm.2.1709198416707; 
 Thu, 29 Feb 2024 01:20:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGNH+H5zlUPCp88FoODYyA6qVmDe3SYy/HPJsdI8Y6FVNRztUFZWGeXXpABBDZV474GPP4LaQ==
X-Received: by 2002:adf:e507:0:b0:33d:a43d:75e8 with SMTP id
 j7-20020adfe507000000b0033da43d75e8mr1123353wrm.2.1709198416300; 
 Thu, 29 Feb 2024 01:20:16 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 q16-20020a5d6590000000b0033d56aa4f45sm1197575wru.112.2024.02.29.01.20.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Feb 2024 01:20:15 -0800 (PST)
Date: Thu, 29 Feb 2024 10:20:14 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 jean-philippe@linaro.org, mst@redhat.com, peter.maydell@linaro.org,
 clg@redhat.com, zhenzhong.duan@intel.com, yanghliu@redhat.com,
 alex.williamson@redhat.com, jasowang@redhat.com
Subject: Re: [PATCH v5 3/4] hw: Set virtio-iommu aw-bits default value on
 pc_q35 and arm virt
Message-ID: <20240229102014.6c5e9f74@imammedo.users.ipa.redhat.com>
In-Reply-To: <20240215084315.863897-4-eric.auger@redhat.com>
References: <20240215084315.863897-1-eric.auger@redhat.com>
 <20240215084315.863897-4-eric.auger@redhat.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.102,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Thu, 15 Feb 2024 09:42:13 +0100
Eric Auger <eric.auger@redhat.com> wrote:

> Currently the default input range can extend to 64 bits. On x86,
> when the virtio-iommu protects vfio devices, the physical iommu
> may support only 39 bits. Let's set the default to 39, as done
> for the intel-iommu. On ARM we set 48b as a default (matching
> SMMUv3 SMMU_IDR5.VAX =3D=3D 0).
>=20
> We use hw_compat_8_2 to handle the compatibility for machines
> before 9.0 which used to have a virtio-iommu default input range
> of 64 bits.

so we have different defaults per target/machine
while open codding fixup in _pre_plug_ works it's
a bit unexpected place to manage defaults and
avoid adding 0 magic.

How about using compat machinery instead to set
machine dependent defaults:
For example:

pc_i440fx_machine_options(MachineClass *m)
{
...
+    compat_props_add(m->compat_props, pc_compat_defaults,pc_compat_default=
s_len);
 }

> Of course if aw-bits is set from the command line, the default
> is overriden.
>=20
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> Tested-by: Yanghang Liu<yanghliu@redhat.com>
>=20
> ---
>=20
> v3 -> v4:
> - update the qos test to relax the check on the max input IOVA
>=20
> v2 -> v3:
> - collected Zhenzhong's R-b
> - use &error_abort instead of NULL error handle
>   on object_property_get_uint() call (C=C3=A9dric)
> - use VTD_HOST_AW_39BIT (C=C3=A9dric)
>=20
> v1 -> v2:
> - set aw-bits to 48b on ARM
> - use hw_compat_8_2 to handle the compat for older machines
>   which used 64b as a default
> ---
>  hw/arm/virt.c                   | 6 ++++++
>  hw/core/machine.c               | 5 ++++-
>  hw/i386/pc.c                    | 6 ++++++
>  hw/virtio/virtio-iommu.c        | 2 +-
>  tests/qtest/virtio-iommu-test.c | 2 +-
>  5 files changed, 18 insertions(+), 3 deletions(-)
>=20
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 368c2a415a..0994f2a560 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -2716,10 +2716,16 @@ static void virt_machine_device_pre_plug_cb(Hotpl=
ugHandler *hotplug_dev,
>      } else if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MD_PCI)) {
>          virtio_md_pci_pre_plug(VIRTIO_MD_PCI(dev), MACHINE(hotplug_dev),=
 errp);
>      } else if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_IOMMU_PCI)) {
> +        uint8_t aw_bits =3D object_property_get_uint(OBJECT(dev),
> +                                                   "aw-bits", &error_abo=
rt);
>          hwaddr db_start =3D 0, db_end =3D 0;
>          QList *reserved_regions;
>          char *resv_prop_str;
> =20
> +        if (!aw_bits) {
> +            qdev_prop_set_uint8(dev, "aw-bits", 48);

s/48/macro name/?

> +        }
>
>
>          if (vms->iommu !=3D VIRT_IOMMU_NONE) {
>              error_setg(errp, "virt machine does not support multiple IOM=
MUs");
>              return;
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index fb5afdcae4..70ac96954c 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -30,9 +30,12 @@
>  #include "exec/confidential-guest-support.h"
>  #include "hw/virtio/virtio-pci.h"
>  #include "hw/virtio/virtio-net.h"
> +#include "hw/virtio/virtio-iommu.h"
>  #include "audio/audio.h"
> =20
> -GlobalProperty hw_compat_8_2[] =3D {};
> +GlobalProperty hw_compat_8_2[] =3D {
> +    { TYPE_VIRTIO_IOMMU_PCI, "aw-bits", "64" },
> +};
>  const size_t hw_compat_8_2_len =3D G_N_ELEMENTS(hw_compat_8_2);
> =20
>  GlobalProperty hw_compat_8_1[] =3D {
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 196827531a..ee2d379c90 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -1456,6 +1456,8 @@ static void pc_machine_device_pre_plug_cb(HotplugHa=
ndler *hotplug_dev,
>      } else if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MD_PCI)) {
>          virtio_md_pci_pre_plug(VIRTIO_MD_PCI(dev), MACHINE(hotplug_dev),=
 errp);
>      } else if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_IOMMU_PCI)) {
> +        uint8_t aw_bits =3D object_property_get_uint(OBJECT(dev),
> +                                                   "aw-bits", &error_abo=
rt);
>          /* Declare the APIC range as the reserved MSI region */
>          char *resv_prop_str =3D g_strdup_printf("0xfee00000:0xfeefffff:%=
d",
>                                                VIRTIO_IOMMU_RESV_MEM_T_MS=
I);
> @@ -1464,6 +1466,10 @@ static void pc_machine_device_pre_plug_cb(HotplugH=
andler *hotplug_dev,
>          qlist_append_str(reserved_regions, resv_prop_str);
>          qdev_prop_set_array(dev, "reserved-regions", reserved_regions);
> =20
> +        if (!aw_bits) {
> +            qdev_prop_set_uint8(dev, "aw-bits", VTD_HOST_AW_39BIT);
> +        }
> +
>          g_free(resv_prop_str);
>      }
> =20
> diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
> index 8b541de850..2ec5ef3cd1 100644
> --- a/hw/virtio/virtio-iommu.c
> +++ b/hw/virtio/virtio-iommu.c
> @@ -1526,7 +1526,7 @@ static Property virtio_iommu_properties[] =3D {
>      DEFINE_PROP_LINK("primary-bus", VirtIOIOMMU, primary_bus,
>                       TYPE_PCI_BUS, PCIBus *),
>      DEFINE_PROP_BOOL("boot-bypass", VirtIOIOMMU, boot_bypass, true),
> -    DEFINE_PROP_UINT8("aw-bits", VirtIOIOMMU, aw_bits, 64),
> +    DEFINE_PROP_UINT8("aw-bits", VirtIOIOMMU, aw_bits, 0),
I'd set some valid value here (obviously not universal) and skip
default property setting for that machine/target
For example pick x86 one.

>      DEFINE_PROP_END_OF_LIST(),
>  };
> =20
> diff --git a/tests/qtest/virtio-iommu-test.c b/tests/qtest/virtio-iommu-t=
est.c
> index 068e7a9e6c..0f36381acb 100644
> --- a/tests/qtest/virtio-iommu-test.c
> +++ b/tests/qtest/virtio-iommu-test.c
> @@ -34,7 +34,7 @@ static void pci_config(void *obj, void *data, QGuestAll=
ocator *t_alloc)
>      uint8_t bypass =3D qvirtio_config_readb(dev, 36);
> =20
>      g_assert_cmpint(input_range_start, =3D=3D, 0);
> -    g_assert_cmphex(input_range_end, =3D=3D, UINT64_MAX);
> +    g_assert_cmphex(input_range_end, >=3D, 32);
>      g_assert_cmpint(domain_range_start, =3D=3D, 0);
>      g_assert_cmpint(domain_range_end, =3D=3D, UINT32_MAX);
>      g_assert_cmpint(bypass, =3D=3D, 1);


