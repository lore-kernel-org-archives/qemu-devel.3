Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02C4DC3DA59
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2024 14:30:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTMi9-0007rW-5p; Mon, 15 Jul 2024 10:29:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sTMi5-0007OV-1F
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 10:29:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sTMi3-0005HA-GT
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 10:29:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721053785;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fMcgl+1UkPeUjDXshVSWNgTJeZuds3OPWpHtLfyyLGs=;
 b=NL/FzBRXKh6t0kyZNA82nGtwikbi3RvlH2v+aeHcMGtHIT5Fwx0ifb6k0SfHAL4BclkCJq
 DppZyDRwSFvN9aIwUF8xjVigIzWhn12+FdKcLR3l2Pdk8pQa7l5vBICQI7vjHCWRiXi056
 2QIaSeiiF+bX/eBQTI/hPCBwuI+2DSc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-472-NO_Fa4SZP1mvdZ3vHkjjJg-1; Mon, 15 Jul 2024 10:29:44 -0400
X-MC-Unique: NO_Fa4SZP1mvdZ3vHkjjJg-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-36794ef4815so2691506f8f.1
 for <qemu-devel@nongnu.org>; Mon, 15 Jul 2024 07:29:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721053783; x=1721658583;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fMcgl+1UkPeUjDXshVSWNgTJeZuds3OPWpHtLfyyLGs=;
 b=S4gCEEwa7lrfPJ6FIQhkaWVeMwBNL+sxgB9V2OjLsghSp05sj5UA1acTVXX5ZmBeRD
 kx+1IFtTWAwQN/H3RgbUWbQUhByz29VWXLQyJhuAwG+OI+hxz0cBCYUS+GcXGGWd8bSU
 fANsgL++6d/+2fumKss/5ZEdxj59NNLg69j39aTsm4IgC5wHvUqAT9otFOI61BGIUvhA
 7L+NUFuPwlR465HE7ERPaAdnCEfppkRIaSshHIG/u2l9FVOfScQHpfB/MnFq8V/ejiJ2
 d/0D3Ee2QaEq0t3CvKJMljY5o4zJ1RuQdCNVESMVqqFiKvt9mkji+V6zCMrXyPNiSDEg
 p7Dw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW2zOwCIsW1HxigouWTI1WIDSxVhXeQeAVbwyFFMGT5Ftsx2soKJI0ZaNANvDNG2neUAgayglUt/6sV97sMY4a6RrUhkyg=
X-Gm-Message-State: AOJu0YzYMaPeI1Xh/2YlDCY3GNB5nyr7QbjivAiH/fsnEBfBd4Xff/iU
 WZxlW71iDrze5k86D7cLrkv5m8xJ4Z+Xhjnqpe2xz5z4MNopCZxy2KctLG5yUuyjurluisiqF5L
 NCRe4M4dA8H4KeaSvhrZs5oN7wGQ/5DsDtkN3WyZrrpNAt4aLg2vz
X-Received: by 2002:adf:fb52:0:b0:367:94a7:12cb with SMTP id
 ffacd0b85a97d-367ceacaaaamr12775733f8f.43.1721053782870; 
 Mon, 15 Jul 2024 07:29:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHmY4ZGp74sKtTX+24Hg7vTd6Jh9kf4WQIur3c2F6swt232bqQLeRb+/7XzA65+QJYhcqFBRw==
X-Received: by 2002:adf:fb52:0:b0:367:94a7:12cb with SMTP id
 ffacd0b85a97d-367ceacaaaamr12775716f8f.43.1721053782648; 
 Mon, 15 Jul 2024 07:29:42 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3680daccbddsm6530110f8f.64.2024.07.15.07.29.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jul 2024 07:29:42 -0700 (PDT)
Date: Mon, 15 Jul 2024 16:29:41 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 <qemu-devel@nongnu.org>, <ankita@nvidia.com>, <linuxarm@huawei.com>,
 <linux-cxl@vger.kernel.org>, <marcel.apfelbaum@gmail.com>,
 <philmd@linaro.org>, Richard Henderson <richard.henderson@linaro.org>, Dave
 Jiang <dave.jiang@intel.com>, Huang Ying <ying.huang@intel.com>, Paolo
 Bonzini <pbonzini@redhat.com>, <eduardo@habkost.net>, Michael Roth
 <michael.roth@amd.com>, Ani Sinha <anisinha@redhat.com>
Subject: Re: [PATCH v5 09/13] hw/pci-host/gpex-acpi: Use acpi_uid property.
Message-ID: <20240715162941.060b64f7@imammedo.users.ipa.redhat.com>
In-Reply-To: <20240712110837.1439736-10-Jonathan.Cameron@huawei.com>
References: <20240712110837.1439736-1-Jonathan.Cameron@huawei.com>
 <20240712110837.1439736-10-Jonathan.Cameron@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Fri, 12 Jul 2024 12:08:13 +0100
Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:

> Reduce the direct use of PCI internals inside ACPI table creation.
> 
> Suggested-by: Igor Mammedov <imammedo@redhat.com>
> Tested-by: "Huang, Ying" <ying.huang@intel.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
> v5: Similar to previous, use bus number, not uid in ACPI device naming so
>     that uid can be 32 bits and we don't need checks to ensure it is only
>     8 bits.  Not change to the actual numbers as the UID == bus_num
> ---
>  hw/pci-host/gpex-acpi.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/pci-host/gpex-acpi.c b/hw/pci-host/gpex-acpi.c
> index f69413ea2c..f271817ef5 100644
> --- a/hw/pci-host/gpex-acpi.c
> +++ b/hw/pci-host/gpex-acpi.c
> @@ -140,6 +140,7 @@ void acpi_dsdt_add_gpex(Aml *scope, struct GPEXConfig *cfg)
>          QLIST_FOREACH(bus, &bus->child, sibling) {
>              uint8_t bus_num = pci_bus_num(bus);
>              uint8_t numa_node = pci_bus_numa_node(bus);
> +            uint32_t uid;
>              bool is_cxl = pci_bus_is_cxl(bus);
>  
>              if (!pci_bus_is_root(bus)) {
> @@ -155,6 +156,8 @@ void acpi_dsdt_add_gpex(Aml *scope, struct GPEXConfig *cfg)
>                  nr_pcie_buses = bus_num;
>              }
>  
> +            uid = object_property_get_uint(OBJECT(bus), "acpi_uid",
> +                                           &error_fatal);
>              dev = aml_device("PC%.02X", bus_num);
>              if (is_cxl) {
>                  struct Aml *pkg = aml_package(2);
> @@ -167,7 +170,7 @@ void acpi_dsdt_add_gpex(Aml *scope, struct GPEXConfig *cfg)
>                  aml_append(dev, aml_name_decl("_CID", aml_string("PNP0A03")));
>              }
>              aml_append(dev, aml_name_decl("_BBN", aml_int(bus_num)));
> -            aml_append(dev, aml_name_decl("_UID", aml_int(bus_num)));
> +            aml_append(dev, aml_name_decl("_UID", aml_int(uid)));
>              aml_append(dev, aml_name_decl("_STR", aml_unicode("pxb Device")));
>              aml_append(dev, aml_name_decl("_CCA", aml_int(1)));
>              if (numa_node != NUMA_NODE_UNASSIGNED) {


