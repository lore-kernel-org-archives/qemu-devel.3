Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00644C2BD09
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 13:28:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMpAY-0003bx-I9; Thu, 27 Jun 2024 09:28:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sMpAW-0003b2-No
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 09:28:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sMpAV-0002ny-7m
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 09:28:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719494886;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cYUx4KqikT7Aj5OJG6BCx/5Xs46RwC0eG9WjjQEbO+c=;
 b=ZbPCAPT55PWGj6sVP3zj8vfy7Onon2Is5uEaAvHkFdLnmVWHbM5c1tgHnMahWsRlZPCzIK
 ThVX7n64VdU4RBX4fMfgTBoT799sJ7FwZ3s2bK6LTi52jbZtme9fQxmWTYH6Vbvw4qAjpr
 jjWH016gqyZS5rW1wfBbEL0xnFnKHD4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-457-6t9ZkZaYP7aivx6ItmYEMg-1; Thu, 27 Jun 2024 09:28:04 -0400
X-MC-Unique: 6t9ZkZaYP7aivx6ItmYEMg-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-42566e8a9efso4482575e9.2
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 06:28:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719494883; x=1720099683;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cYUx4KqikT7Aj5OJG6BCx/5Xs46RwC0eG9WjjQEbO+c=;
 b=P/3vVw2qYztE3k6Hq+FO8m2IrC6gKvqXSPSLUBknXJOCnXt7WXSFBSwMKSNFatQLCw
 gt2SLXXgcjn0zVME88VeKx1Og+KTQGCWr7ANGmqQBfeOghXbz1zaQbojshqallon+mnj
 P3EkUy69pe+vKTKXYfftWIIXmPaxKbR0Q1qwlBTFq4MQHY4ibrNXfbFWrmw6M4Ug2I3s
 RxXvSNbsyqsXEHg29UKDy02jLggSsKtycUSQUgkQGYSX0kHjgi5O2CWPeUUWXS+plbzJ
 8oqqzAL+NT5DNeqiH99GKP1a2f3ZsQO/tjAmWFO1tdF2NFQKiIfWTc+VGeQlKq9dvced
 2NJg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVM9n4YFyA7SzsJVwsERGQz8lzt+2iJoAby82DNMejK36HSsHakzzxNrf8GRVmuAqhcUs5ln+uuprAUZrU7535p/f7gPm8=
X-Gm-Message-State: AOJu0Yyyk0QIhXo66HS6ntLfpSWHDZvLCJxpvQmzYyFRD1+Hq011dldo
 viTxVzxFBtyuPhUjS0OmC0UpVxelcqKh9IMBBdEPvIg7NKPgOcfrvVluYP+6tP587t7hQVbHBia
 M6N1hcCWRYG02rXOw6+TzMadpQ1wp7MzjTlsuNP+zU2CwnEkQ96a+
X-Received: by 2002:adf:a384:0:b0:35f:1eba:cf66 with SMTP id
 ffacd0b85a97d-366e9656803mr9408267f8f.61.1719494883727; 
 Thu, 27 Jun 2024 06:28:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGA0748DfHU6nJAiOFrTFZSa0Sf8UG6c7brVlaiAadLN09St07sfilGx20k3+Kx+JJlWOx8Kg==
X-Received: by 2002:adf:a384:0:b0:35f:1eba:cf66 with SMTP id
 ffacd0b85a97d-366e9656803mr9408251f8f.61.1719494883357; 
 Thu, 27 Jun 2024 06:28:03 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3674d992187sm1557396f8f.38.2024.06.27.06.28.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Jun 2024 06:28:02 -0700 (PDT)
Date: Thu, 27 Jun 2024 15:27:58 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 <qemu-devel@nongnu.org>, <ankita@nvidia.com>, <marcel.apfelbaum@gmail.com>,
 <philmd@linaro.org>, Richard Henderson <richard.henderson@linaro.org>,
 <linuxarm@huawei.com>, Dave Jiang <dave.jiang@intel.com>, Huang Ying
 <ying.huang@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 <eduardo@habkost.net>, <linux-cxl@vger.kernel.org>, Michael Roth
 <michael.roth@amd.com>, Ani Sinha <anisinha@redhat.com>
Subject: Re: [PATCH v3 07/11] hw/pci-bridge: Add acpi_uid property to CXL PXB
Message-ID: <20240627152758.5eafb402@imammedo.users.ipa.redhat.com>
In-Reply-To: <20240620160324.109058-8-Jonathan.Cameron@huawei.com>
References: <20240620160324.109058-1-Jonathan.Cameron@huawei.com>
 <20240620160324.109058-8-Jonathan.Cameron@huawei.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
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

On Thu, 20 Jun 2024 17:03:15 +0100
Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:

> This allows the ACPI SRAT Generic Port Affinity Structure
> creation to be independent of PCI internals. Note that
> the UID is currently the PCI bus number.
> 
> Suggested-by: Igor Mammedov <imammedo@redhat.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> ---
> v3: New patch
> ---
>  hw/pci-bridge/pci_expander_bridge.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/pci-bridge/pci_expander_bridge.c b/hw/pci-bridge/pci_expander_bridge.c
> index 0411ad31ea..92d39b917a 100644
> --- a/hw/pci-bridge/pci_expander_bridge.c
> +++ b/hw/pci-bridge/pci_expander_bridge.c
> @@ -93,6 +93,21 @@ static void pxb_bus_class_init(ObjectClass *class, void *data)
>      pbc->numa_node = pxb_bus_numa_node;
>  }
>  
> +static void prop_pxb_cxl_uid_get(Object *obj, Visitor *v, const char *name,
> +                             void *opaque, Error **errp)
> +{
> +    uint32_t uid = pci_bus_num(PCI_BUS(obj));
> +
> +    visit_type_uint32(v, name, &uid, errp);
> +}
> +
> +static void pxb_cxl_bus_class_init(ObjectClass *class, void *data)
> +{
> +    pxb_bus_class_init(class, data);
> +    object_class_property_add(class, "acpi_uid", "uint32",
> +                              prop_pxb_cxl_uid_get, NULL, NULL, NULL);
> +}
> +
>  static const TypeInfo pxb_bus_info = {
>      .name          = TYPE_PXB_BUS,
>      .parent        = TYPE_PCI_BUS,
> @@ -111,7 +126,7 @@ static const TypeInfo pxb_cxl_bus_info = {
>      .name          = TYPE_PXB_CXL_BUS,
>      .parent        = TYPE_CXL_BUS,
>      .instance_size = sizeof(PXBBus),
> -    .class_init    = pxb_bus_class_init,
> +    .class_init    = pxb_cxl_bus_class_init,

why it's CXL only, doesn't the same UID rules apply to other PCI buses?
>  };
>  
>  static const char *pxb_host_root_bus_path(PCIHostState *host_bridge,


