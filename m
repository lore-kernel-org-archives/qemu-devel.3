Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADFF3C2BD09
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 12:56:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMofr-0006bm-SB; Thu, 27 Jun 2024 08:56:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sMofm-0006bH-Dx
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 08:56:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sMofk-0002rk-Sj
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 08:56:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719492980;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JR5ErMuEbVd1Zz4SFGXEnrGmn4JGl3Pfz9x/6WzCVEw=;
 b=gwL1ajjdS684mNaYt3Jw6q0xn7ntIWBRi3yyeVsT4OmXhHRYspHZVE91KVf9FYvHjegtoN
 rRwApDVwuHaJ8ChG9v90WjOF/OVoSUEzXUiX6iun8ezfctPKZXcwcb1/t4vcQ2Z8Uv0AMA
 3MCFWf3Tt01Cmouzn8hwtVeBjwQnGco=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-KuwVHrt2PXekZ7RjHExXKQ-1; Thu, 27 Jun 2024 08:56:18 -0400
X-MC-Unique: KuwVHrt2PXekZ7RjHExXKQ-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-422322e4abaso9836005e9.1
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 05:56:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719492977; x=1720097777;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JR5ErMuEbVd1Zz4SFGXEnrGmn4JGl3Pfz9x/6WzCVEw=;
 b=IITIYjfPe846Fh2Y34LkyvhY2FZELXhE2eSJvzgs4+E0/iBHrQqDf/3nvcmtrm9MIT
 T6lx6si4wHwnkTFUduCChkQ8Wz4cWrMSsv6O5QzcjB0OPMw64oFmwMV6/7FMqnraEEsb
 jBMJXrpgXgsQO/l0yo1CxI7VVnQLuijpq0tpzLLXRBEgbqvtloAnF+Z7vJvr5vmZ0qme
 DE9LSAnWnZWude9jej530CTEggX4Hxp9IfPCn6fPRyFWCIkRv2v+09p+c5Itl/rpZsm1
 1W4zIFm6T6yd7HR6rmDXrkncaaPtJpu4vR/WYBZgt0i8pjSqFmLsvEs0q0rLfFYYUwkb
 7mgQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVY/pPUEBQ1KmINqBpW/ORDZaEJ/9qz5NbBZmR4ryIrpQzUS2cc/lpIZqC9P7iymsJOdEBh7MJK48m1Ffxii8Eem/LoDWA=
X-Gm-Message-State: AOJu0YwR8D4OzzFvnJcFNUI/eiIkCTvGuRdx4Shh8GzqSCnYsZsXswQN
 /aWoBJh4JRFSXqV3F6qAuSCRYcLu6/RC0oLGr5HIkOxWQhOkuO/jyaVCgdvmKrDMVY+drzCWMYJ
 7C+497GqiG0CNt4yXtdOoApO9VrRN5EtOggi5v6HTdeuIt1MPW9EL
X-Received: by 2002:a05:600c:4a06:b0:421:8234:9bb4 with SMTP id
 5b1f17b1804b1-42563126c2dmr25773015e9.19.1719492977687; 
 Thu, 27 Jun 2024 05:56:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHwpnlf/eRAa07oL95W2YCkf8HrDfbnms0npxB8y9IFXrOozdKcDu3WZq/h9GihKU2aoJJGOQ==
X-Received: by 2002:a05:600c:4a06:b0:421:8234:9bb4 with SMTP id
 5b1f17b1804b1-42563126c2dmr25772745e9.19.1719492977344; 
 Thu, 27 Jun 2024 05:56:17 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-424c848353dsm65954585e9.48.2024.06.27.05.56.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Jun 2024 05:56:16 -0700 (PDT)
Date: Thu, 27 Jun 2024 14:56:14 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 <qemu-devel@nongnu.org>, <ankita@nvidia.com>, <marcel.apfelbaum@gmail.com>,
 <philmd@linaro.org>, Richard Henderson <richard.henderson@linaro.org>,
 <linuxarm@huawei.com>, Dave Jiang <dave.jiang@intel.com>, Huang Ying
 <ying.huang@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 <eduardo@habkost.net>, <linux-cxl@vger.kernel.org>, Michael Roth
 <michael.roth@amd.com>, Ani Sinha <anisinha@redhat.com>
Subject: Re: [PATCH v3 04/11] hw/acpi: Rename
 build_all_acpi_generic_initiators() to build_acpi_generic_initiator()
Message-ID: <20240627145614.6c46c1b4@imammedo.users.ipa.redhat.com>
In-Reply-To: <20240620160324.109058-5-Jonathan.Cameron@huawei.com>
References: <20240620160324.109058-1-Jonathan.Cameron@huawei.com>
 <20240620160324.109058-5-Jonathan.Cameron@huawei.com>
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

On Thu, 20 Jun 2024 17:03:12 +0100
Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:

> Igor noted that this function only builds one instance, so was rather
> misleadingly named. Fix that.
> 
> Suggested-by: Igor Mammedov <imammedo@redhat.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> 
> ---
> v3: New patch
> ---
>  hw/acpi/acpi_generic_initiator.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/acpi/acpi_generic_initiator.c b/hw/acpi/acpi_generic_initiator.c
> index 7665b16107..73bafaaaea 100644
> --- a/hw/acpi/acpi_generic_initiator.c
> +++ b/hw/acpi/acpi_generic_initiator.c
> @@ -74,7 +74,7 @@ static void acpi_generic_initiator_class_init(ObjectClass *oc, void *data)
>          acpi_generic_initiator_set_node, NULL, NULL);
>  }
>  
> -static int build_all_acpi_generic_initiators(Object *obj, void *opaque)
> +static int build_acpi_generic_initiator(Object *obj, void *opaque)
>  {
>      MachineState *ms = MACHINE(qdev_get_machine());
>      AcpiGenericInitiator *gi;
> @@ -111,6 +111,6 @@ static int build_all_acpi_generic_initiators(Object *obj, void *opaque)
>  void build_srat_generic_pci_initiator(GArray *table_data)
>  {
>      object_child_foreach_recursive(object_get_root(),
> -                                   build_all_acpi_generic_initiators,
> +                                   build_acpi_generic_initiator,
>                                     table_data);
>  }


