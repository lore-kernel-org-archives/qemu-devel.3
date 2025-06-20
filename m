Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F468C71155
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 12:46:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSb8A-0004Y0-EO; Fri, 20 Jun 2025 08:46:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uSb7z-0004Xb-Ac
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 08:45:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uSb7w-0002Ao-VG
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 08:45:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750423551;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ixw2GuPREzzHodVzbvCDgX1hhsFwnJGhUX8+FgDdGdg=;
 b=WNkVtiypKVuLQenafztXoBwHDRAUn/cFErnStDeunH1PsQOWnS5L1CF7iyf7MD9N8W1Vpg
 BjO3/nVoRvt3IGYChGju3kyLjWeLDB39RNPvuXXw1JivMIS8pbSAWATYITDZVKX+L5rb6J
 gU1VA/ba3TORDOfjXLQDa51g73iDbWM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-RAXZYNr9Mcm7WYwSJ8AHGw-1; Fri, 20 Jun 2025 08:45:50 -0400
X-MC-Unique: RAXZYNr9Mcm7WYwSJ8AHGw-1
X-Mimecast-MFC-AGG-ID: RAXZYNr9Mcm7WYwSJ8AHGw_1750423549
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-45311704d22so11174885e9.2
 for <qemu-devel@nongnu.org>; Fri, 20 Jun 2025 05:45:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750423549; x=1751028349;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ixw2GuPREzzHodVzbvCDgX1hhsFwnJGhUX8+FgDdGdg=;
 b=gWpCVtx4usE2ypKBwUDyrqFSwhzhw7sE+i/DDhudrAEupyuElUkBTSkXKcOKut2Be3
 MXk83NKyz5y9+8pp1+j1DVBfO3M7IAHvFy7LfS61yCaSozmJh4DSK/5w+FDY836+LkCa
 X5mSms6ZyztNmvJHkq3AkIVOVjEpKqVMNenm6BYuPk3GqigUThj9hSxl2p5TqgZhRB9P
 lvk77LwFfvTUV/VZXqxGlMvk0Yp49cMXJdBzm+3aVVVp7pMz59c3ttwLhVrVV5L3scyo
 OzrxnU2WBRLhoz9Gu5WNk86Kk+oafRc9rXw4u6azLg60reXERIISeBXg1tWl2uqO+6y2
 C0Dg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWrttKOmKanZ2y17ycadCRRDUaRGGetJRR0CpC+Qvy87OuwwuQ3POfI64rtYrlT34eDTEupCY2A0x91@nongnu.org
X-Gm-Message-State: AOJu0YxGqP02/qyxV2Nh/bdKlbgHS+b4bEnr9dZuwvaccwywzsfD73jU
 KCVqcijRQFhRHmyX75XdQkid13m07g99ouWB7eoh8Q+cWuNM3Z97+Z8xCCt+pmDw1ahYRxP4uUY
 cyflhnYM8iVT7cIaKS1hMvcYDAeI2mFQGHkkGKHLt254nu/zsDgxLk5hl
X-Gm-Gg: ASbGncve43Jd2HsqlgHCAiw1Z8IRGe/FC2wK/GFOhZIAtL0fl32SewtOkrMi6g9En0G
 PQT3CfbIcah+FlikNJcKxVNnwuwSBkJzHVvMG5xXsUupuRBHdhRTqeJX7PsPlhbn1hwDQeD2TrD
 atf/beDdj2v7cvVECSBkeOYJwpb4XhSjBe8Ju+5nIQ0rcIgJSSPbg0e/yktfnhmHEZoLCEedRjg
 8Fj4ryXRCBJ43L/FR9K9mvQBFNrcgEqFPHrMO7KGhiQU8OfU+V9TuSwoHAO/OVz+h1tgjdr7bm2
 CWdGSR9dGiXE
X-Received: by 2002:a05:6000:4283:b0:3a4:f6c4:355a with SMTP id
 ffacd0b85a97d-3a6d131ac8emr2269665f8f.57.1750423548814; 
 Fri, 20 Jun 2025 05:45:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGrLT3wNR9H3+UM6jaYxsQGEx+qkhxAI0jiqUIfqR20b+tZYGc1HfpaZ42XLtYF9wy0dlXn8g==
X-Received: by 2002:a05:6000:4283:b0:3a4:f6c4:355a with SMTP id
 ffacd0b85a97d-3a6d131ac8emr2269639f8f.57.1750423548417; 
 Fri, 20 Jun 2025 05:45:48 -0700 (PDT)
Received: from fedora ([85.93.96.130]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4535e98b48asm59359715e9.16.2025.06.20.05.45.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Jun 2025 05:45:48 -0700 (PDT)
Date: Fri, 20 Jun 2025 14:45:47 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 peter.maydell@linaro.org, gustavo.romero@linaro.org, anisinha@redhat.com,
 mst@redhat.com, shannon.zhaosl@gmail.com, pbonzini@redhat.com,
 Jonathan.Cameron@huawei.com, philmd@linaro.org, alex.bennee@linaro.org
Subject: Re: [PATCH v3 18/29] hw/acpi/ged: Add a bus link property
Message-ID: <20250620144547.2140006a@fedora>
In-Reply-To: <20250616094903.885753-19-eric.auger@redhat.com>
References: <20250616094903.885753-1-eric.auger@redhat.com>
 <20250616094903.885753-19-eric.auger@redhat.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.897,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Mon, 16 Jun 2025 11:46:47 +0200
Eric Auger <eric.auger@redhat.com> wrote:

> This property will be set by the machine code on the object
> creation. It will be used by acpi pcihp hotplug code.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>


also with that it's possible to end up with NULL root
if someone forgets to wire it up.

I'd add assert somewhere in pcihp.c
so that we wouldn't end up with wounds from too much head scratching
if it fails somewhere during runtime.

> ---
>  hw/acpi/generic_event_device.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/hw/acpi/generic_event_device.c b/hw/acpi/generic_event_device.c
> index 7831db412b..ef1c1ec51f 100644
> --- a/hw/acpi/generic_event_device.c
> +++ b/hw/acpi/generic_event_device.c
> @@ -13,6 +13,7 @@
>  #include "qapi/error.h"
>  #include "hw/acpi/acpi.h"
>  #include "hw/acpi/generic_event_device.h"
> +#include "hw/pci/pci.h"
>  #include "hw/irq.h"
>  #include "hw/mem/pc-dimm.h"
>  #include "hw/mem/nvdimm.h"
> @@ -320,6 +321,8 @@ static const Property acpi_ged_properties[] = {
>      DEFINE_PROP_UINT32("ged-event", AcpiGedState, ged_event_bitmap, 0),
>      DEFINE_PROP_BOOL(ACPI_PM_PROP_ACPI_PCIHP_BRIDGE, AcpiGedState,
>                       pcihp_state.use_acpi_hotplug_bridge, 0),
> +    DEFINE_PROP_LINK("bus", AcpiGedState, pcihp_state.root,
> +                     TYPE_PCI_BUS, PCIBus *),
>  };
>  
>  static const VMStateDescription vmstate_memhp_state = {


