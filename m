Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00BD1C27C4F
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2024 10:26:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKbTT-0003zM-4a; Fri, 21 Jun 2024 06:26:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sKbTR-0003vq-6B
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 06:26:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sKbTP-0008CV-MQ
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 06:26:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718965586;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b3vcZEnvcRN8efBD/EQKkDtTL1JriYb06mY/KS73HHY=;
 b=fkQ4F2xZaGgb+zRwdmPLx/Zb5VkGxkefi0uNp2FZCpTkqZzu7Gku5ShHs3wIfmPM1Ub/k/
 uxiTFf+qHbcUTkv5bo+EHRxNzTEgSJKlCktRAEuqE1URFbQYop4DjJJFejPEWcy9sTCnNa
 LaOio8g2NDrm1wbMbWNfpp9SudfixJQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-149-nUemPp4yMveBjA2SiYB_9A-1; Fri, 21 Jun 2024 06:26:25 -0400
X-MC-Unique: nUemPp4yMveBjA2SiYB_9A-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4247047e74aso17666015e9.3
 for <qemu-devel@nongnu.org>; Fri, 21 Jun 2024 03:26:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718965584; x=1719570384;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=b3vcZEnvcRN8efBD/EQKkDtTL1JriYb06mY/KS73HHY=;
 b=IifRKME7nMinGVxkqCle0QNuLGoyN53xDAdcMi49soh4hRt8Bzy7FOaQIffYd17sjN
 4jpgLJqUlPOvDGqc+cdZoH8T58/svqNmuGiplQMwhg3WlJWVBs1/CBeoaTy18PgB2AQW
 T7x80K12NOX0Tpfi5Dr5wCd67ACajqcNsh+jUio9RazBOq8HMS8q4h04sOoxCswBiQgV
 yizTF4R9zgZtlC+QaYbFpsZ0VQBc3EhihjRjRLiFVZ4ljOuE9DDFkl+klCvu+ppUiuWL
 +0tPCwNSbWfG+xWAPtLyYUB+WqJIIA7MTPTzd8eaygimX07kL/tmHd604FL2tSc0YY81
 lPLg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXobX1c1ACUrMKf2eJe9mWDkCXiwqNg46N2F9iDUqWvPAM5MVa3VqomeBpIRP8BCQyZZROyyz1+7XVbizHKycAPqotw4qQ=
X-Gm-Message-State: AOJu0YyN/WFWTADkWxLdkrKiIIeTbmk7Z+UwTiR9stSuVLKNp/cdBlS3
 KQC2ThcxffbfqKkDpKEnM+6QupBTmB5PG9dRtLfMxOHnq5bXhbABp46RHwmQoDeRKaiOdYEdYcB
 eWCVmePT1V5dAlc5V7IGik1fWHr7HLek7JKE5Ch7hGz08O0/x6+gX
X-Received: by 2002:a5d:464a:0:b0:35f:28eb:5a46 with SMTP id
 ffacd0b85a97d-363170ed434mr7821830f8f.10.1718965583994; 
 Fri, 21 Jun 2024 03:26:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF4JRNBJ051021SVYemFNpv29rT9dMwYZfyHe9BVlp3NdsyQCDHiUGJVdq7oPj3mgYJgtn+TQ==
X-Received: by 2002:a5d:464a:0:b0:35f:28eb:5a46 with SMTP id
 ffacd0b85a97d-363170ed434mr7821798f8f.10.1718965583190; 
 Fri, 21 Jun 2024 03:26:23 -0700 (PDT)
Received: from redhat.com ([2.52.146.100]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3663a8c8b32sm1308063f8f.92.2024.06.21.03.26.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Jun 2024 03:26:22 -0700 (PDT)
Date: Fri, 21 Jun 2024 06:26:19 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas@t-8ch.de>
Cc: Cornelia Huck <cohuck@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 Alejandro Jimenez <alejandro.j.jimenez@oracle.com>, kvm@vger.kernel.org
Subject: Re: [PATCH v8 3/8] hw/misc/pvpanic: centralize definition of
 supported events
Message-ID: <20240621062512-mutt-send-email-mst@kernel.org>
References: <20240527-pvpanic-shutdown-v8-0-5a28ec02558b@t-8ch.de>
 <20240527-pvpanic-shutdown-v8-3-5a28ec02558b@t-8ch.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240527-pvpanic-shutdown-v8-3-5a28ec02558b@t-8ch.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.152,
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

On Mon, May 27, 2024 at 08:27:49AM +0200, Thomas Weiﬂschuh wrote:
> The different components of pvpanic duplicate the list of supported
> events. Move it to the shared header file to minimize changes when new
> events are added.
> 
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> Signed-off-by: Thomas Weiﬂschuh <thomas@t-8ch.de>
> ---
>  hw/misc/pvpanic-isa.c     | 3 +--
>  hw/misc/pvpanic-pci.c     | 3 +--
>  hw/misc/pvpanic.c         | 3 +--
>  include/hw/misc/pvpanic.h | 4 ++++
>  4 files changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/misc/pvpanic-isa.c b/hw/misc/pvpanic-isa.c
> index ccec50f61bbd..9a923b786907 100644
> --- a/hw/misc/pvpanic-isa.c
> +++ b/hw/misc/pvpanic-isa.c
> @@ -21,7 +21,6 @@
>  #include "hw/misc/pvpanic.h"
>  #include "qom/object.h"
>  #include "hw/isa/isa.h"
> -#include "standard-headers/linux/pvpanic.h"
>  #include "hw/acpi/acpi_aml_interface.h"
>  
>  OBJECT_DECLARE_SIMPLE_TYPE(PVPanicISAState, PVPANIC_ISA_DEVICE)
> @@ -102,7 +101,7 @@ static void build_pvpanic_isa_aml(AcpiDevAmlIf *adev, Aml *scope)
>  static Property pvpanic_isa_properties[] = {
>      DEFINE_PROP_UINT16(PVPANIC_IOPORT_PROP, PVPanicISAState, ioport, 0x505),
>      DEFINE_PROP_UINT8("events", PVPanicISAState, pvpanic.events,
> -                      PVPANIC_PANICKED | PVPANIC_CRASH_LOADED),
> +                      PVPANIC_EVENTS),
>      DEFINE_PROP_END_OF_LIST(),
>  };
>  
> diff --git a/hw/misc/pvpanic-pci.c b/hw/misc/pvpanic-pci.c
> index 83be95d0d249..603c5c7600da 100644
> --- a/hw/misc/pvpanic-pci.c
> +++ b/hw/misc/pvpanic-pci.c
> @@ -21,7 +21,6 @@
>  #include "hw/misc/pvpanic.h"
>  #include "qom/object.h"
>  #include "hw/pci/pci_device.h"
> -#include "standard-headers/linux/pvpanic.h"
>  
>  OBJECT_DECLARE_SIMPLE_TYPE(PVPanicPCIState, PVPANIC_PCI_DEVICE)
>  
> @@ -55,7 +54,7 @@ static void pvpanic_pci_realizefn(PCIDevice *dev, Error **errp)
>  
>  static Property pvpanic_pci_properties[] = {
>      DEFINE_PROP_UINT8("events", PVPanicPCIState, pvpanic.events,
> -                      PVPANIC_PANICKED | PVPANIC_CRASH_LOADED),
> +                      PVPANIC_EVENTS),
>      DEFINE_PROP_END_OF_LIST(),
>  };
>  
> diff --git a/hw/misc/pvpanic.c b/hw/misc/pvpanic.c
> index 1540e9091a45..a4982cc5928e 100644
> --- a/hw/misc/pvpanic.c
> +++ b/hw/misc/pvpanic.c
> @@ -21,13 +21,12 @@
>  #include "hw/qdev-properties.h"
>  #include "hw/misc/pvpanic.h"
>  #include "qom/object.h"
> -#include "standard-headers/linux/pvpanic.h"


This part is wrong. PVPANIC_PANICKED and PVPANIC_CRASH_LOADED
are still used in pvpanic.c directly, so we should
include standard-headers/linux/pvpanic.h to avoid depending
on which header includes which.

I fixed up the patch.


>  static void handle_event(int event)
>  {
>      static bool logged;
>  
> -    if (event & ~(PVPANIC_PANICKED | PVPANIC_CRASH_LOADED) && !logged) {
> +    if (event & ~PVPANIC_EVENTS && !logged) {
>          qemu_log_mask(LOG_GUEST_ERROR, "pvpanic: unknown event %#x.\n", event);
>          logged = true;
>      }
> diff --git a/include/hw/misc/pvpanic.h b/include/hw/misc/pvpanic.h
> index fab94165d03d..947468b81b1a 100644
> --- a/include/hw/misc/pvpanic.h
> +++ b/include/hw/misc/pvpanic.h
> @@ -18,6 +18,10 @@
>  #include "exec/memory.h"
>  #include "qom/object.h"
>  
> +#include "standard-headers/linux/pvpanic.h"
> +
> +#define PVPANIC_EVENTS (PVPANIC_PANICKED | PVPANIC_CRASH_LOADED)
> +
>  #define TYPE_PVPANIC_ISA_DEVICE "pvpanic"
>  #define TYPE_PVPANIC_PCI_DEVICE "pvpanic-pci"
>  
> 
> -- 
> 2.45.1


