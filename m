Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81A42C2BD09
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 12:43:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMoSk-0006CI-V9; Thu, 27 Jun 2024 08:42:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sMoSj-0006C5-5E
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 08:42:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sMoSh-0000AD-8J
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 08:42:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719492170;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9ud/uQiAuYG/yErmjqEEC4JbOOjXx62yX+ti0vETMa4=;
 b=I/BuzwJnGrYfZ780P3/q73nHxEgcSmTkzNZHlJVRuEIOal+FFXhBv/+G+RYplkpHxfJbeP
 GEPQgxGdg0wDm8TWSqpUoVz+1Cm4L6uwby2wfI+ZoH0S2ICeb66mmUkOpEuz5Rfg+AP51W
 qnNwByrMFH9QINi2Q9tHR0cJS0xBPC8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-486-koS5MJw7NXaug5cDzqF_7g-1; Thu, 27 Jun 2024 08:42:48 -0400
X-MC-Unique: koS5MJw7NXaug5cDzqF_7g-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3625b8355b5so5126845f8f.3
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 05:42:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719492166; x=1720096966;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9ud/uQiAuYG/yErmjqEEC4JbOOjXx62yX+ti0vETMa4=;
 b=aw4Y3nhp5ZhG/6A7jf5DxRmjR+aToBn+k+4h421VzprTvf3m+N6Hm8BRLN6JgcE9Hu
 W9TPdcKJjCEY2P3O259DjKENY4XGi+tNYDdEzJ0l5+6M5PP8ZjnbISy/p+G2JEW6P41d
 CmstX58S/sswesSYPnD+kJypBM5WNdKgfS8GWlGRQ3pfbOk3yzkc21MApCN5w/Oass/V
 7K726Qt6e7Nc/Bf1W4JLc5QtgcmcJEEZHhjXZQ89xZeBHmwXc37US89MKSOkPcEjsELJ
 nIuv4hGoTXZDf8HKBAilHnv4BVFsyRMkmLeIVlJMjFOopCJh3MXNlQo6vWbwa4fyKnx4
 UBVw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVXS2p8x7VoACNbmmmSiN5lfp27DgvnA30776FnhT3WPHciOtX0IQ5ZE6AAWjtffdUu5Icj8+70lBYXrFt915Uk08A8HkQ=
X-Gm-Message-State: AOJu0YzDY7895MtaU13MLl9LooLnSGs+VgxNJaMUw1yY6chVxPB9F9vK
 cE8Vy5xB0L852xo4vPgQPb8/kZzqq5FpocTSvsylVgVpzDCQq00IQUQi6xt6BctPTo4gv2gvd45
 ZgB78T7E0rbZloIW5qLSb4y9Km0BJGjRqhdv3mgpdO/jfVTPtFiit
X-Received: by 2002:a05:6000:178f:b0:366:ee01:30d6 with SMTP id
 ffacd0b85a97d-366ee0134b8mr13801258f8f.49.1719492166078; 
 Thu, 27 Jun 2024 05:42:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGi4M28RQ7G+nNIOa63jszPtkUbL0i85I1grdzJ47TU94N/Yvxp+ZjoFF6ELbprBr588NWf0w==
X-Received: by 2002:a05:6000:178f:b0:366:ee01:30d6 with SMTP id
 ffacd0b85a97d-366ee0134b8mr13801222f8f.49.1719492165589; 
 Thu, 27 Jun 2024 05:42:45 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3674357c12esm1752427f8f.15.2024.06.27.05.42.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Jun 2024 05:42:45 -0700 (PDT)
Date: Thu, 27 Jun 2024 14:42:44 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 <qemu-devel@nongnu.org>, <ankita@nvidia.com>, <marcel.apfelbaum@gmail.com>,
 <philmd@linaro.org>, Richard Henderson <richard.henderson@linaro.org>,
 <linuxarm@huawei.com>, Dave Jiang <dave.jiang@intel.com>, Huang Ying
 <ying.huang@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 <eduardo@habkost.net>, <linux-cxl@vger.kernel.org>, Michael Roth
 <michael.roth@amd.com>, Ani Sinha <anisinha@redhat.com>
Subject: Re: [PATCH v3 03/11] hw/acpi: Move AML building code for Generic
 Initiators to aml_build.c
Message-ID: <20240627144244.27473a32@imammedo.users.ipa.redhat.com>
In-Reply-To: <20240620160324.109058-4-Jonathan.Cameron@huawei.com>
References: <20240620160324.109058-1-Jonathan.Cameron@huawei.com>
 <20240620160324.109058-4-Jonathan.Cameron@huawei.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.212,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, 20 Jun 2024 17:03:11 +0100
Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:

> Rather than attempting to create a generic function with mess of the two
> different device handle types, use a PCI handle specific variant.  If the
> ACPI handle form is needed then that can be introduced alongside this
> with little duplicated code.
>=20
> Drop the PCIDeviceHandle in favor of just passing the bus, devfn
> and segment directly.  devfn kept as a single byte because ARI means
> that in cases this is just an 8 bit function number.
>=20
> Suggested-by: Igor Mammedov <imammedo@redhat.com>
> Link: https://lore.kernel.org/qemu-devel/20240618142333.102be976@imammedo=
.users.ipa.redhat.com/
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

with typo fixed

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

>=20
> ---
> v3: New patch based on Igor's comments on the endian fix.
> ---
>  include/hw/acpi/acpi_generic_initiator.h | 23 -------------
>  include/hw/acpi/aml-build.h              |  4 +++
>  hw/acpi/acpi_generic_initiator.c         | 39 ++-------------------
>  hw/acpi/aml-build.c                      | 44 ++++++++++++++++++++++++
>  4 files changed, 51 insertions(+), 59 deletions(-)
>=20
> diff --git a/include/hw/acpi/acpi_generic_initiator.h b/include/hw/acpi/a=
cpi_generic_initiator.h
> index a304bad73e..7b98676713 100644
> --- a/include/hw/acpi/acpi_generic_initiator.h
> +++ b/include/hw/acpi/acpi_generic_initiator.h
> @@ -19,29 +19,6 @@ typedef struct AcpiGenericInitiator {
>      uint16_t node;
>  } AcpiGenericInitiator;
> =20
> -/*
> - * ACPI 6.3:
> - * Table 5-81 Flags =E2=80=93 Generic Initiator Affinity Structure
> - */
> -typedef enum {
> -    /*
> -     * If clear, the OSPM ignores the contents of the Generic
> -     * Initiator/Port Affinity Structure. This allows system firmware
> -     * to populate the SRAT with a static number of structures, but only
> -     * enable them as necessary.
> -     */
> -    GEN_AFFINITY_ENABLED =3D (1 << 0),
> -} GenericAffinityFlags;
> -
> -/*
> - * ACPI 6.3:
> - * Table 5-80 Device Handle - PCI
> - */
> -typedef struct PCIDeviceHandle {
> -    uint16_t segment;
> -    uint16_t bdf;
> -} PCIDeviceHandle;
> -
>  void build_srat_generic_pci_initiator(GArray *table_data);
> =20
>  #endif
> diff --git a/include/hw/acpi/aml-build.h b/include/hw/acpi/aml-build.h
> index a3784155cb..9ba3a21c13 100644
> --- a/include/hw/acpi/aml-build.h
> +++ b/include/hw/acpi/aml-build.h
> @@ -486,6 +486,10 @@ Aml *build_crs(PCIHostState *host, CrsRangeSet *rang=
e_set, uint32_t io_offset,
>  void build_srat_memory(GArray *table_data, uint64_t base,
>                         uint64_t len, int node, MemoryAffinityFlags flags=
);
> =20
> +void build_srat_pci_generic_initiator(GArray * table_date, int node,

s/table_date/table_data/

> +                                      uint16_t segment, uint8_t bus,
> +                                      uint8_t devfn);
> +
>  void build_slit(GArray *table_data, BIOSLinker *linker, MachineState *ms,
>                  const char *oem_id, const char *oem_table_id);
> =20
> diff --git a/hw/acpi/acpi_generic_initiator.c b/hw/acpi/acpi_generic_init=
iator.c
> index 4a02c19468..7665b16107 100644
> --- a/hw/acpi/acpi_generic_initiator.c
> +++ b/hw/acpi/acpi_generic_initiator.c
> @@ -74,40 +74,11 @@ static void acpi_generic_initiator_class_init(ObjectC=
lass *oc, void *data)
>          acpi_generic_initiator_set_node, NULL, NULL);
>  }
> =20
> -/*
> - * ACPI 6.3:
> - * Table 5-78 Generic Initiator Affinity Structure
> - */
> -static void
> -build_srat_generic_pci_initiator_affinity(GArray *table_data, int node,
> -                                          PCIDeviceHandle *handle)
> -{
> -    uint8_t index;
> -
> -    build_append_int_noprefix(table_data, 5, 1);  /* Type */
> -    build_append_int_noprefix(table_data, 32, 1); /* Length */
> -    build_append_int_noprefix(table_data, 0, 1);  /* Reserved */
> -    build_append_int_noprefix(table_data, 1, 1);  /* Device Handle Type:=
 PCI */
> -    build_append_int_noprefix(table_data, node, 4);  /* Proximity Domain=
 */
> -
> -    /* Device Handle - PCI */
> -    build_append_int_noprefix(table_data, handle->segment, 2);
> -    build_append_int_noprefix(table_data, PCI_BUS_NUM(handle->bdf), 1);
> -    build_append_int_noprefix(table_data, PCI_BDF_TO_DEVFN(handle->bdf),=
 1);
> -    for (index =3D 0; index < 12; index++) {
> -        build_append_int_noprefix(table_data, 0, 1);
> -    }
> -
> -    build_append_int_noprefix(table_data, GEN_AFFINITY_ENABLED, 4); /* F=
lags */
> -    build_append_int_noprefix(table_data, 0, 4);     /* Reserved */
> -}
> -
>  static int build_all_acpi_generic_initiators(Object *obj, void *opaque)
>  {
>      MachineState *ms =3D MACHINE(qdev_get_machine());
>      AcpiGenericInitiator *gi;
>      GArray *table_data =3D opaque;
> -    PCIDeviceHandle dev_handle;
>      PCIDevice *pci_dev;
>      Object *o;
> =20
> @@ -130,13 +101,9 @@ static int build_all_acpi_generic_initiators(Object =
*obj, void *opaque)
>      }
> =20
>      pci_dev =3D PCI_DEVICE(o);
> -
> -    dev_handle.segment =3D 0;
> -    dev_handle.bdf =3D PCI_BUILD_BDF(pci_bus_num(pci_get_bus(pci_dev)),
> -                                   pci_dev->devfn);
> -
> -    build_srat_generic_pci_initiator_affinity(table_data,
> -                                              gi->node, &dev_handle);
> +    build_srat_pci_generic_initiator(table_data, gi->node, 0,
> +                                     pci_bus_num(pci_get_bus(pci_dev)),
> +                                     pci_dev->devfn);
> =20
>      return 0;
>  }
> diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
> index 6d4517cfbe..968b654e58 100644
> --- a/hw/acpi/aml-build.c
> +++ b/hw/acpi/aml-build.c
> @@ -1938,6 +1938,50 @@ void build_srat_memory(GArray *table_data, uint64_=
t base,
>      build_append_int_noprefix(table_data, 0, 8); /* Reserved */
>  }
> =20
> +/*
> + * ACPI Spec Revision 6.3
> + * Table 5-80 Device Handle - PCI
> + */
> +static void build_append_srat_pci_device_handle(GArray *table_data,
> +                                                uint16_t segment,
> +                                                uint8_t bus, uint8_t dev=
fn)
> +{
> +    /* PCI segment number */
> +    build_append_int_noprefix(table_data, segment, 2);
> +    /* PCI Bus Device Function */
> +    build_append_int_noprefix(table_data, bus, 1);
> +    build_append_int_noprefix(table_data, devfn, 1);
> +    /* Reserved */
> +    build_append_int_noprefix(table_data, 0, 12);
> +}
> +
> +/*
> + * ACPI spec, Revision 6.3
> + * 5.2.16.6 Generic Initiator Affinity Structure
> + *    With PCI Device Handle.
> + */
> +void build_srat_pci_generic_initiator(GArray *table_data, int node,
> +                                      uint16_t segment, uint8_t bus,
> +                                      uint8_t devfn)
> +{
> +    /* Type */
> +    build_append_int_noprefix(table_data, 5, 1);
> +    /* Length */
> +    build_append_int_noprefix(table_data, 32, 1);
> +    /* Reserved */
> +    build_append_int_noprefix(table_data, 0, 1);
> +    /* Device Handle Type: PCI */
> +    build_append_int_noprefix(table_data, 1, 1);
> +    /* Proximity Domain */
> +    build_append_int_noprefix(table_data, node, 4);
> +    /* Device Handle */
> +    build_append_srat_pci_device_handle(table_data, segment, bus, devfn);
> +    /* Flags - GI Enabled */
> +    build_append_int_noprefix(table_data, 1, 4);
> +    /* Reserved */
> +    build_append_int_noprefix(table_data, 0, 4);
> +}
> +
>  /*
>   * ACPI spec 5.2.17 System Locality Distance Information Table
>   * (Revision 2.0 or later)


