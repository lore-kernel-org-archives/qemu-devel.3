Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C252DC54ED1
	for <qemu-devel@archiver.kernel.org>; Tue, 27 May 2025 14:23:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJvBr-0002Z3-Dp; Tue, 27 May 2025 10:22:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uJvBq-0002Yr-6v
 for qemu-devel@nongnu.org; Tue, 27 May 2025 10:22:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uJvBZ-0000p9-5w
 for qemu-devel@nongnu.org; Tue, 27 May 2025 10:22:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748355693;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hHmlju6tLlaVUgmSPzTxf9ZO3W6KmL5QKzZOE4IKFd4=;
 b=QwNvn9DsP2t5xoy6vZU3deXFjDrwPDQbzueZ0DsBO1Ad2cgY68DTclwgOz80IIgHqLzwU2
 TIdsSD14UblTtRb/Z9apr1rEJjgiX2yBsnS4D0F7z5r+BxJ7ESETzdNPJwkX1HO5QoIlJC
 6fwkekx8xl3+IWb7M8G+PsbYFQpC7nQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-z4NicTEwO-yR1-CpxhpeHg-1; Tue, 27 May 2025 10:21:28 -0400
X-MC-Unique: z4NicTEwO-yR1-CpxhpeHg-1
X-Mimecast-MFC-AGG-ID: z4NicTEwO-yR1-CpxhpeHg_1748355687
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-442f90418b0so18103925e9.2
 for <qemu-devel@nongnu.org>; Tue, 27 May 2025 07:21:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748355687; x=1748960487;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hHmlju6tLlaVUgmSPzTxf9ZO3W6KmL5QKzZOE4IKFd4=;
 b=BZYBBgWkHSdqqTIuNr+gwlLYiPUi3mXZT5kmh0AH5PdIbkxinUeWshNa50ntW09xPl
 l2UP6WftNa+u5y7eypCdyod8ChIYlDHkMn5RW2GtdvueQF2MtxvEDnE162NKols+2lfW
 BVO8TA29M2mk1ZkNvYmHBBDBqNSH1VyyVWz85QaxK7+W42DPenEemj3470I9tPkctgF2
 KA1LSN8gEDcTVveDtgYv2opqbdJDJ7MUBPz0FA1aQE9XsmfPKmtLqhnUH0tpXsibcQkO
 nCeQ0DMUoMSA9AnrIm45ctfhWhPQ8z/jcjosEbT9+ysupOYSk3F5ZOZq6dFhX8Ibxl4Q
 IUqg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWMFwyThsKeLgHo9mxMr63KGCA9knVsEMaHb7DICp5KStJkxpaSuYSZMOb0fJ9JqANGcdBn6qtcyPhF@nongnu.org
X-Gm-Message-State: AOJu0Yz5SxmQg8RxYS6F9nbeI/14+uVzadp/u/C+QNlGG1bh7DM/SDZn
 9crM8lUFsnwmVoPunXu1uD8onpHUEsjVOOuC7rTg/i7NyBE37PXJ+1evEHoZUs5NON23mwOvWiv
 Gyd/ElsAaeLa9Xw8fUSveNW3dLniiNZDTNNL/SfiMK8pIxUJFF81nnlcm
X-Gm-Gg: ASbGnctQVgICmleU2ARsWWZx4Nvf1xD8e3UTF+HgPA39myx9nqGKY/HUZ6ME96QQHCy
 PKRIigwZsefzo7pFL6BdI4tYKYl6lVpL6PxDS0SBEy+SdTlBnwuuTq+MLj6nPNP9wy0AhLKvhl5
 dRTvvYrjogA6jhkKdOAIvCoPvONfvrhzEZ5TOHSnaN5O4U1pc0ZjdZnbrjJDtJYAqjbiYQbWE+2
 au6TUKeIjoE6pmmhYA4WKU/GZySpZNudQCFXs9Kp+n38spHOi5GQpZZxI1fnfSVO3pgiClVKaXV
 e5hPe5HezSxteY0VBGtBOJeKarMW8u3g
X-Received: by 2002:a05:600c:1f91:b0:43e:afca:808f with SMTP id
 5b1f17b1804b1-44c93018fbamr125639025e9.31.1748355687446; 
 Tue, 27 May 2025 07:21:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGg84nLTKEpGB1cE8n+t3vK18AqgpQULku9T2a78Do4qXlxYmSiH024y1cbpqVda67j7TWX6w==
X-Received: by 2002:a05:600c:1f91:b0:43e:afca:808f with SMTP id
 5b1f17b1804b1-44c93018fbamr125638705e9.31.1748355687017; 
 Tue, 27 May 2025 07:21:27 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com ([85.93.96.130])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-447f73d3d6csm278046025e9.19.2025.05.27.07.21.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 May 2025 07:21:26 -0700 (PDT)
Date: Tue, 27 May 2025 16:21:25 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 peter.maydell@linaro.org, gustavo.romero@linaro.org, anisinha@redhat.com,
 mst@redhat.com, shannon.zhaosl@gmail.com, pbonzini@redhat.com,
 Jonathan.Cameron@huawei.com, philmd@linaro.org, alex.bennee@linaro.org
Subject: Re: [PATCH v2 19/25] hw/acpi/ged: Call pcihp plug callbacks in
 hotplug handler implementation
Message-ID: <20250527162125.19bcb7f0@imammedo.users.ipa.redhat.com>
In-Reply-To: <20250527074224.1197793-20-eric.auger@redhat.com>
References: <20250527074224.1197793-1-eric.auger@redhat.com>
 <20250527074224.1197793-20-eric.auger@redhat.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.907,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Tue, 27 May 2025 09:40:21 +0200
Eric Auger <eric.auger@redhat.com> wrote:

> Add PCI device related code in the TYPE_HOTPLUG_HANDLER
> implementation.
> 
> For a PCI device hotplug/hotunplug event, the code routes to
> acpi_pcihp_device callbacks (pre_plug_cb, plug_cb, unplug_request_cb,
> unplug_cb).
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> ---
>  hw/acpi/generic_event_device.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/hw/acpi/generic_event_device.c b/hw/acpi/generic_event_device.c
> index f84216a85f..c0dbf9b358 100644
> --- a/hw/acpi/generic_event_device.c
> +++ b/hw/acpi/generic_event_device.c
> @@ -17,6 +17,7 @@
>  #include "hw/irq.h"
>  #include "hw/mem/pc-dimm.h"
>  #include "hw/mem/nvdimm.h"
> +#include "hw/pci/pci_device.h"
>  #include "hw/qdev-properties.h"
>  #include "migration/vmstate.h"
>  #include "qemu/error-report.h"
> @@ -235,6 +236,17 @@ static const MemoryRegionOps ged_regs_ops = {
>      },
>  };
>  
> +static void acpi_ged_device_pre_plug_cb(HotplugHandler *hotplug_dev,
> +                                        DeviceState *dev, Error **errp)
> +{
> +    if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_DEVICE)) {
> +        acpi_pcihp_device_pre_plug_cb(hotplug_dev, dev, errp);
> +    } else {
> +        error_setg(errp, "virt: device pre plug request for unsupported device"
> +                   " type: %s", object_get_typename(OBJECT(dev)));

does memory hotplug still work after that?
why?

> +    }
> +}
> +
>  static void acpi_ged_device_plug_cb(HotplugHandler *hotplug_dev,
>                                      DeviceState *dev, Error **errp)
>  {
> @@ -248,6 +260,8 @@ static void acpi_ged_device_plug_cb(HotplugHandler *hotplug_dev,
>          }
>      } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
>          acpi_cpu_plug_cb(hotplug_dev, &s->cpuhp_state, dev, errp);
> +    } else if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_DEVICE)) {
> +        acpi_pcihp_device_plug_cb(hotplug_dev, &s->pcihp_state, dev, errp);
>      } else {
>          error_setg(errp, "virt: device plug request for unsupported device"
>                     " type: %s", object_get_typename(OBJECT(dev)));
> @@ -264,6 +278,9 @@ static void acpi_ged_unplug_request_cb(HotplugHandler *hotplug_dev,
>          acpi_memory_unplug_request_cb(hotplug_dev, &s->memhp_state, dev, errp);
>      } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
>          acpi_cpu_unplug_request_cb(hotplug_dev, &s->cpuhp_state, dev, errp);
> +    } else if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_DEVICE)) {
> +        acpi_pcihp_device_unplug_request_cb(hotplug_dev, &s->pcihp_state,
> +                                            dev, errp);
>      } else {
>          error_setg(errp, "acpi: device unplug request for unsupported device"
>                     " type: %s", object_get_typename(OBJECT(dev)));
> @@ -279,6 +296,8 @@ static void acpi_ged_unplug_cb(HotplugHandler *hotplug_dev,
>          acpi_memory_unplug_cb(&s->memhp_state, dev, errp);
>      } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
>          acpi_cpu_unplug_cb(&s->cpuhp_state, dev, errp);
> +    } else if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_DEVICE)) {
> +        acpi_pcihp_device_unplug_cb(hotplug_dev, &s->pcihp_state, dev, errp);
>      } else {
>          error_setg(errp, "acpi: device unplug for unsupported device"
>                     " type: %s", object_get_typename(OBJECT(dev)));
> @@ -494,6 +513,7 @@ static void acpi_ged_class_init(ObjectClass *class, const void *data)
>      dc->vmsd = &vmstate_acpi_ged;
>      dc->realize = acpi_ged_realize;
>  
> +    hc->pre_plug = acpi_ged_device_pre_plug_cb;
>      hc->plug = acpi_ged_device_plug_cb;
>      hc->unplug_request = acpi_ged_unplug_request_cb;
>      hc->unplug = acpi_ged_unplug_cb;


