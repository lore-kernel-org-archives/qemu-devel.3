Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00648C5AE59
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 12:32:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMQne-0007KZ-RJ; Tue, 03 Jun 2025 08:31:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uMQna-0007IS-45
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 08:31:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uMQnV-0007YD-Ee
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 08:31:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748953875;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s5kVA7XHT0jpOLHqJil0HY4Ad5i6kLNREu9me6/mG0k=;
 b=IHaB8vq0eODK8q8PY3vac7IaGZCAPuG/i0Q4ZFb8yuSvDF8G7bSaFZzmcRjRtS5SaRMUvF
 dKvRuC+Bd5AKXB+H2kNrZLyo2zmq/jwPdfEGL72ueuctl+qyWn8YlbEKpdFOeS5dJDKU/h
 3z471SwsNtA0v1KjFMKl4DTAtHiN/2Q=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-575-Rs3M2yIKPO-MwEGLo9wcPg-1; Tue, 03 Jun 2025 08:31:14 -0400
X-MC-Unique: Rs3M2yIKPO-MwEGLo9wcPg-1
X-Mimecast-MFC-AGG-ID: Rs3M2yIKPO-MwEGLo9wcPg_1748953873
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-ad56c5412f2so425507166b.1
 for <qemu-devel@nongnu.org>; Tue, 03 Jun 2025 05:31:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748953873; x=1749558673;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=s5kVA7XHT0jpOLHqJil0HY4Ad5i6kLNREu9me6/mG0k=;
 b=jD/V6TmYgr6iy4OxrRQgu6GGayGyTR4JFnii0HpJu26ovM78DJu71fyd+FoKbi0nEK
 HGZNIOtp7J5gpzKCH+IfCVgD2s7S4hkuiHQJ7wTwQUVBlxaDuP7Q3kKQY6sI0SZHwClc
 BccnGIAVpYbxZRCtCaLo0p3v+RWx2KFKgASJ3A46J2Ka1lBQKiUolULK1/2VjwYn/VIo
 78Q/QnQMDAgTHfH8GWLy9EZ+N4mnNSotrteM7z6M29zOhuwRSO872h3JXiTIvbeBKNAu
 WTyVc4pzNvLF7UTxJBBXorSs9NIf0lCogp0+1gZpWyHKoKNgnuPWv0ngSeWY7ivfw/ub
 9Rpg==
X-Gm-Message-State: AOJu0YyVK9wXGwJUF9byqFP6MSjnSGtRGcS8TYiAJMfuJa/Z1SHO8qrN
 4KihhkqL8jn839ghX5oKMMJTVBB3WAN4SVALy6GQDUgEld4YNgsRmH4r0T/cSQA4k1xUiRrUErn
 K5eDcrxuizrcJYVkVwHgruyJjOX1VwF93rKQGopbQBKWm//uiuhyTrJ2D
X-Gm-Gg: ASbGncvcFTjVjhJBRFog4Dp1kBgI5EFdzdI/v5WoiG+pDUi3bkorJkMXi0gN1kgkoGO
 dlMDitMXYOSxk0mBeiFBQY1+oChHflJhZ9hoIasAmK3NTuBTJeyolF+JFWo4yd/t3MsOQxUK8tr
 VdP2zYZJuAEtcMLnO7IQ3WsCyRxynYOF01LfW7Ez0+0BnpSdMUS5g8rAb0RDjd4ZZrVu8wFn3+x
 SsQ5GLIKfCs+eHQvRS0hWb9LUhHT37EcjeHXsvlcPdCp0HFuXSAQMs6EQurJrKAzocLyVy8yib2
 /Xu+3LRUqwVUvyHRriQj892wZB4oHGzTbTbawZkEVDY=
X-Received: by 2002:a17:907:3f29:b0:ad2:2fa8:c0a7 with SMTP id
 a640c23a62f3a-adb36b4cfa8mr1474413666b.21.1748953873154; 
 Tue, 03 Jun 2025 05:31:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHZoooMPCVOZJ4A2zaBUVxMGU0BGVkmFRSQjLGB0mX2Yt/M0B63kxxQErY++jg6tKofSI6mbg==
X-Received: by 2002:a17:907:3f29:b0:ad2:2fa8:c0a7 with SMTP id
 a640c23a62f3a-adb36b4cfa8mr1474408866b.21.1748953872581; 
 Tue, 03 Jun 2025 05:31:12 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com ([85.93.96.130])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ada6ad6ac28sm939262066b.164.2025.06.03.05.31.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Jun 2025 05:31:12 -0700 (PDT)
Date: Tue, 3 Jun 2025 14:31:10 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Annie Li <annie.li@oracle.com>
Cc: qemu-devel@nongnu.org, dave@treblig.org, mst@redhat.com,
 anisinha@redhat.com, eduardo@habkost.net, marcel.apfelbaum@gmail.com,
 philmd@linaro.org, wangyanan55@huawei.com, zhao1.liu@intel.com,
 pbonzini@redhat.com, richard.henderson@linaro.org, slp@redhat.com,
 eblake@redhat.com, armbru@redhat.com, miguel.luis@oracle.com
Subject: Re: [PATCH 01/13] acpi: Implement control method sleep button
Message-ID: <20250603143110.2cd22790@imammedo.users.ipa.redhat.com>
In-Reply-To: <20250528163835.2151-1-annie.li@oracle.com>
References: <20250528163545.2143-1-annie.li@oracle.com>
 <20250528163835.2151-1-annie.li@oracle.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.128,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Wed, 28 May 2025 12:38:34 -0400
Annie Li <annie.li@oracle.com> wrote:

> The fixed hardware sleep button isn't appropriate for hardware
> reduced platform. This patch implements the control method sleep
> button in a separate source file so that the button can be added
> for various platforms.
> 
> Co-developed-by: Miguel Luis <miguel.luis@oracle.com>
> Signed-off-by: Annie Li <annie.li@oracle.com>
> ---
>  hw/acpi/control_method_device.c         | 38 +++++++++++++++++++++++++
>  hw/acpi/meson.build                     |  1 +
>  include/hw/acpi/control_method_device.h | 21 ++++++++++++++
>  3 files changed, 60 insertions(+)
> 
> diff --git a/hw/acpi/control_method_device.c b/hw/acpi/control_method_device.c

sleep_button would be more to the point

> new file mode 100644
> index 0000000000..f8d691ee04
> --- /dev/null
> +++ b/hw/acpi/control_method_device.c
> @@ -0,0 +1,38 @@
> +/*
> + * Control Method Device
> + *
> + * Copyright (c) 2023 Oracle and/or its affiliates.
> + *
> + *
> + * Authors:
> + *     Annie Li <annie.li@oracle.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "hw/acpi/control_method_device.h"
> +#include "hw/acpi/aml-build.h"
> +
> +/*
> + * The control method sleep button[ACPI v6.5 Section 4.8.2.2.2.2]
> + * resides in generic hardware address spaces. The sleep button
> + * is defined as _HID("PNP0C0E") that associates with device "SLPB".
> + */
> +void acpi_dsdt_add_sleep_button(Aml *scope)
> +{
> +    Aml *dev = aml_device(ACPI_SLEEP_BUTTON_DEVICE);
> +    aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0C0E")));
> +    /*
> +     * No _PRW, the sleep button device is always tied to GPE L07
> +     * event handler for x86 platform, or a GED event for other
> +     * platforms such as virt, ARM, microvm, etc.
> +     */
> +    aml_append(dev, aml_operation_region("\\SLP", AML_SYSTEM_IO,
> +                                         aml_int(0x201), 0x1));
                                                    ^^^^^^
                                            where does this come from?


> +    Aml *field = aml_field("\\SLP", AML_BYTE_ACC, AML_NOLOCK,
> +                           AML_WRITE_AS_ZEROS);
> +    aml_append(field, aml_named_field("SBP", 1));
> +    aml_append(dev, field);
> +    aml_append(scope, dev);
> +}
> diff --git a/hw/acpi/meson.build b/hw/acpi/meson.build
> index 73f02b9691..a62e625cef 100644
> --- a/hw/acpi/meson.build
> +++ b/hw/acpi/meson.build
> @@ -17,6 +17,7 @@ acpi_ss.add(when: 'CONFIG_ACPI_CXL', if_true: files('cxl.c'), if_false: files('c
>  acpi_ss.add(when: 'CONFIG_ACPI_VMGENID', if_true: files('vmgenid.c'))
>  acpi_ss.add(when: 'CONFIG_ACPI_VMCLOCK', if_true: files('vmclock.c'))
>  acpi_ss.add(when: 'CONFIG_ACPI_HW_REDUCED', if_true: files('generic_event_device.c'))
> +acpi_ss.add(when: 'CONFIG_ACPI_HW_REDUCED', if_true: files('control_method_device.c'))

that would build only for microvm + arm, and pc/q35 wouldn't get it
if microvm were disabled. 

>  acpi_ss.add(when: 'CONFIG_ACPI_HMAT', if_true: files('hmat.c'))
>  acpi_ss.add(when: 'CONFIG_ACPI_APEI', if_true: files('ghes.c'), if_false: files('ghes-stub.c'))
>  acpi_ss.add(when: 'CONFIG_ACPI_PIIX4', if_true: files('piix4.c'))
> diff --git a/include/hw/acpi/control_method_device.h b/include/hw/acpi/control_method_device.h
> new file mode 100644
> index 0000000000..079f1a74dd
> --- /dev/null
> +++ b/include/hw/acpi/control_method_device.h
> @@ -0,0 +1,21 @@
> +/*
> + * Control Method Device
> + *
> + * Copyright (c) 2023 Oracle and/or its affiliates.
> + *
> + *
> + * Authors:
> + *     Annie Li <annie.li@oracle.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +
> +#ifndef HW_ACPI_CONTROL_METHOD_DEVICE_H
> +#define HW_ACPI_CONTROL_NETHOD_DEVICE_H
> +
> +#define ACPI_SLEEP_BUTTON_DEVICE "SLPB"
> +
> +void acpi_dsdt_add_sleep_button(Aml *scope);
> +
> +#endif


