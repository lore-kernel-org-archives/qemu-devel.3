Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90487C3DA41
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 12:28:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRstt-0003s4-6S; Thu, 11 Jul 2024 08:27:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sRsts-0003rb-3i
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 08:27:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sRstq-0003JF-H6
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 08:27:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720700868;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WHI/4wPP8R2+ilKy81OFpjP4p8f9UonN9Xj6JbRjkNk=;
 b=i46n51DmqWvzwiTYCfBs9QLvA9WOw91DbORvPKq53TiOG21kDVZgLgLJRVVrur4ckdea0n
 naheR403RvY8GMzM5NwkK0fJi3RsJn4+jPclgBIFwUIM4lGXKEaG88+en6KGjnN8DIzkSI
 Au2LKueB5YxkW+Ih833raQy/dnMKBrI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-499-WgLoO5zBOdi_SgWMWgtBfQ-1; Thu, 11 Jul 2024 08:27:47 -0400
X-MC-Unique: WgLoO5zBOdi_SgWMWgtBfQ-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-426724679f0so9848005e9.0
 for <qemu-devel@nongnu.org>; Thu, 11 Jul 2024 05:27:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720700866; x=1721305666;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WHI/4wPP8R2+ilKy81OFpjP4p8f9UonN9Xj6JbRjkNk=;
 b=JHp+PciYVN7ahz1O9/S0j3jLOKKtTdw5R00o9/mEGG47t6h4W8kryP22v40e54K1A0
 xoFjTFtKzSxmityBq4M9Flu4QPBoDZhGVx26XfL+gyb/pLVb1lwQbXUnZPUOTlOj0MRx
 n2wM7wonVSd6Fj4F4plqzPSrTz5Wrqn3dB6Ag8Lgt1cDThGa2o0vKrE3Haj/oOxaGIea
 naRt7HAi/LFR6THw+urogemWnuNosnXRXed2e5sFAnSkL63rFpL5NifQglu6ENh27Krg
 0nZgbP8i1Vyx8FNdhfgzlovnDE6Y7GbTHokIL4zcaJbgsalLjgjCipyetFMLmWOTH671
 ST6A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUqHA8AxlWT/OUp12urExTElbdODfWYVokw/1PN+NA6PyTNMwGTKmqKU6ok9fAsranGXroPq/ZlaPisXJ3wXl6X9aohAAk=
X-Gm-Message-State: AOJu0YxB6IVc04ingrRezvtAB28WLehoMdOBOtBB0GtGATnii4Eu6PKd
 nNMfEjhKwZTCXRoHV2yyG/34Bs7280nuPiKxnpXi0z7vTjCyRefLZWpZDvy1HWOaVOtRPwdVh2x
 BnWjdgUyE5I4YgSUfaUqa18vgGjYz3Ol48GbIx2me/iQzIkLWXKjE
X-Received: by 2002:a05:600c:181c:b0:424:a7f1:ba2 with SMTP id
 5b1f17b1804b1-427981f2dd6mr21542385e9.17.1720700866563; 
 Thu, 11 Jul 2024 05:27:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFYXeTwwrqg0QrhxkyzXKVN89bw3IsN5quyO9A3wdmCPi1B8HD3wtsQt5kI60Q2uvLyiovT2Q==
X-Received: by 2002:a05:600c:181c:b0:424:a7f1:ba2 with SMTP id
 5b1f17b1804b1-427981f2dd6mr21542185e9.17.1720700866187; 
 Thu, 11 Jul 2024 05:27:46 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42793dc2bcesm66002165e9.29.2024.07.11.05.27.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jul 2024 05:27:45 -0700 (PDT)
Date: Thu, 11 Jul 2024 14:27:44 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 <qemu-devel@nongnu.org>, <ankita@nvidia.com>, <marcel.apfelbaum@gmail.com>,
 <philmd@linaro.org>, Richard Henderson <richard.henderson@linaro.org>,
 <linuxarm@huawei.com>, Dave Jiang <dave.jiang@intel.com>, Huang Ying
 <ying.huang@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 <eduardo@habkost.net>, <linux-cxl@vger.kernel.org>, Michael Roth
 <michael.roth@amd.com>, Ani Sinha <anisinha@redhat.com>
Subject: Re: [PATCH v4 07/13] hw/pci-bridge: Add acpi_uid property to
 TYPE_PXB_BUS
Message-ID: <20240711142744.1178daec@imammedo.users.ipa.redhat.com>
In-Reply-To: <20240702131428.664859-8-Jonathan.Cameron@huawei.com>
References: <20240702131428.664859-1-Jonathan.Cameron@huawei.com>
 <20240702131428.664859-8-Jonathan.Cameron@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
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

On Tue, 2 Jul 2024 14:14:12 +0100
Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:

> Enable ACPI table creation for PCI Expander Bridges to be independent
> of PCI internals.  Note that the UID is currently the PCI bus number.
> This is motivated by the forthcoming ACPI Generic Port SRAT entries
> which can be made completely independent of PCI internals.
> 
> Suggested-by: Igor Mammedov <imammedo@redhat.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> ---
> v4: Generalize to all TYPE_PXB_BUS.  The handling for primary root
>     bridges is separate and doesn't overlap with this change.
> ---
>  hw/pci-bridge/pci_expander_bridge.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/hw/pci-bridge/pci_expander_bridge.c b/hw/pci-bridge/pci_expander_bridge.c
> index 0411ad31ea..d71eb4b175 100644
> --- a/hw/pci-bridge/pci_expander_bridge.c
> +++ b/hw/pci-bridge/pci_expander_bridge.c
> @@ -85,12 +85,23 @@ static uint16_t pxb_bus_numa_node(PCIBus *bus)
>      return pxb->numa_node;
>  }
>  
> +static void prop_pxb_uid_get(Object *obj, Visitor *v, const char *name,
> +                             void *opaque, Error **errp)
> +{
> +    uint32_t uid = pci_bus_num(PCI_BUS(obj));
> +
> +    visit_type_uint32(v, name, &uid, errp);
> +}
> +
>  static void pxb_bus_class_init(ObjectClass *class, void *data)
>  {
>      PCIBusClass *pbc = PCI_BUS_CLASS(class);
>  
>      pbc->bus_num = pxb_bus_num;
>      pbc->numa_node = pxb_bus_numa_node;
> +
> +    object_class_property_add(class, "acpi_uid", "uint32",
> +                              prop_pxb_uid_get, NULL, NULL, NULL);

missing related object_class_property_set_description()

>  }
>  
>  static const TypeInfo pxb_bus_info = {


