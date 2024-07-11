Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB522C3DA49
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 12:35:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRt0Z-0005KM-N0; Thu, 11 Jul 2024 08:34:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sRt0Y-0005Hh-13
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 08:34:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sRt0W-0004KG-4U
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 08:34:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720701282;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Bxb/8w4DES5aJg9E5ei3A2woovHRbaf3PI/9QzkhEVE=;
 b=XBilCpysy8d6C+I3IccxcLYF25u6K2vHlwel/ER4DWC41f8fL7VTTUF3LfwOCuuQLRufkw
 CxRl0jECU07GKVH/Wdcx3Q776Cv7iXYDZ7L5oyr3OMQb2C9yWzFzXsG74zA7qSKhHGfa2f
 3N00UEIohz2zb2+vr5iGbPf7fMfz4fI=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-260-d0NEcCUTNPWrFIpF7s42Dw-1; Thu, 11 Jul 2024 08:34:39 -0400
X-MC-Unique: d0NEcCUTNPWrFIpF7s42Dw-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-52e98693f43so840930e87.3
 for <qemu-devel@nongnu.org>; Thu, 11 Jul 2024 05:34:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720701278; x=1721306078;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Bxb/8w4DES5aJg9E5ei3A2woovHRbaf3PI/9QzkhEVE=;
 b=EWw2ADb2n+uWxqmBdOOhxrAvWVhAcY7T9sXZL9P5TPEIbtbl4bohZjn0h04+aPSr7W
 ztCLory9E/m8Qh9qOSt4H8WQC7I+9Rv3lO1AxN6vWRKVZGWkzr4FlYEe6Xf9A6Mv7rFo
 4sogwt5peFBlVHEUiLJxO/DHbc278yQHBFP6dEx2Ec/n31LD104F5qX3BmFqHBQE28Hf
 XLPYnzCOlPidGEVpX5+vq8fJN7YiKZaFZibrsUF7UtfKVIxXAAiEYrPcaCrVOEnssn+v
 dMZmH8U4wuS0pBghtr60u5FjPbrRZwUDxQVPtWv5dlaR78hWCCJMOr90Fxcp9xuHeTTV
 4cgQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVjoUvjwbnTdokdlzCm03W5bav/gPDq3aHM+5St7cExOUq2F6xUDCZb/6rSPUX/X3/Vy+3397gpXcshY4bDUZd7UQM7/HY=
X-Gm-Message-State: AOJu0YwZyKz3lwNdPPiy2A9DPWDppzsWf+2L/Gic6tuv2KWPK5GjHurb
 CfB9n7QN9j8sPKIPUxIOI/71HdPlR5EgivRgI8kI6saIk1lx7hxZPnG+Y73ODUr8VJst9wVxe7R
 5puorpdHSLnkWE+9GflZEYZCqEgMjX860+5vlNR8PPMeYi0cD4ckA
X-Received: by 2002:a05:6512:3e19:b0:52e:93d1:57a6 with SMTP id
 2adb3069b0e04-52eb998e483mr6103954e87.6.1720701278333; 
 Thu, 11 Jul 2024 05:34:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGt5dnrspIs4beSaN9giDzz5Dhq9xTuLYc24NNSTl+lKF/RRpQXbzbbcNFjHF8swmRuzya+Ww==
X-Received: by 2002:a05:6512:3e19:b0:52e:93d1:57a6 with SMTP id
 2adb3069b0e04-52eb998e483mr6103936e87.6.1720701277823; 
 Thu, 11 Jul 2024 05:34:37 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4266f741624sm113560185e9.41.2024.07.11.05.34.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jul 2024 05:34:37 -0700 (PDT)
Date: Thu, 11 Jul 2024 14:34:35 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 <qemu-devel@nongnu.org>, <ankita@nvidia.com>, <marcel.apfelbaum@gmail.com>,
 <philmd@linaro.org>, Richard Henderson <richard.henderson@linaro.org>,
 <linuxarm@huawei.com>, Dave Jiang <dave.jiang@intel.com>, Huang Ying
 <ying.huang@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 <eduardo@habkost.net>, <linux-cxl@vger.kernel.org>, Michael Roth
 <michael.roth@amd.com>, Ani Sinha <anisinha@redhat.com>
Subject: Re: [PATCH v4 08/13] hw/i386/acpi: Use TYPE_PXB_BUS property
 acpi_uid for DSDT
Message-ID: <20240711143435.1e5f33b0@imammedo.users.ipa.redhat.com>
In-Reply-To: <20240702131428.664859-9-Jonathan.Cameron@huawei.com>
References: <20240702131428.664859-1-Jonathan.Cameron@huawei.com>
 <20240702131428.664859-9-Jonathan.Cameron@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
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

On Tue, 2 Jul 2024 14:14:13 +0100
Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:

> Rather than relying on PCI internals, use the new acpi_property
> to obtain the ACPI _UID values.  These are still the same
> as the PCI Bus numbers so no functional change.
> 
> Suggested-by: Igor Mammedov <imammedo@redhat.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
> v4: New patch.
> ---
>  hw/i386/acpi-build.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index ee92783836..cc32f1e6d4 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -1550,6 +1550,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
>          QLIST_FOREACH(bus, &bus->child, sibling) {
>              uint8_t bus_num = pci_bus_num(bus);
>              uint8_t numa_node = pci_bus_numa_node(bus);
> +            uint8_t uid;
>  
>              /* look only for expander root buses */
>              if (!pci_bus_is_root(bus)) {
> @@ -1560,14 +1561,16 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
>                  root_bus_limit = bus_num - 1;
>              }
>  
> +            uid = object_property_get_uint(OBJECT(bus), "acpi_uid",
> +                                           &error_fatal);

theoretically acpi_uid is 32bit, so if we are expecting 
only 256 buses here, then having and assert to catch truncation
would be good.
alternatively if this UID can't ever be more than 8bit, I'd use
 visit_type_uint8() in previous patch to make sure too large value
won't be silently ignored.

>              scope = aml_scope("\\_SB");
>  
>              if (pci_bus_is_cxl(bus)) {
> -                dev = aml_device("CL%.02X", bus_num);
> +                dev = aml_device("CL%.02X", uid);
>              } else {
> -                dev = aml_device("PC%.02X", bus_num);
> +                dev = aml_device("PC%.02X", uid);
>              }
> -            aml_append(dev, aml_name_decl("_UID", aml_int(bus_num)));
> +            aml_append(dev, aml_name_decl("_UID", aml_int(uid)));
>              aml_append(dev, aml_name_decl("_BBN", aml_int(bus_num)));
>              if (pci_bus_is_cxl(bus)) {
>                  struct Aml *aml_pkg = aml_package(2);


