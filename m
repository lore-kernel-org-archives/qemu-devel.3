Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13CC0C48260
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 10:39:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZqCG-0005AH-TV; Tue, 13 Feb 2024 05:39:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rZqCE-0005A2-S4
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 05:39:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rZqCD-0002IR-53
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 05:39:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707820763;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mauRMf5MsEGYigBgnvZFNNtsUxvK3dQyEkLMA3BR3V0=;
 b=atSo3cewPzFe3q0mPCY/COwQCeqdDbUxTyso97C10x6qXR0usiMr565RG7aUcMPpedcIzg
 n3pLUpeicCU7hrNU+/JMuXiTGqGSJUN/sM9cJffymBn4EGrm/FylPa3zOHCDDeFqDEI6le
 m5oiO2Ep9pGfPVQWbU7zyvjzSOYqYFU=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-612-Riu93T2kPRGITONQM4CfUQ-1; Tue, 13 Feb 2024 05:39:21 -0500
X-MC-Unique: Riu93T2kPRGITONQM4CfUQ-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-51156c3208cso3881214e87.1
 for <qemu-devel@nongnu.org>; Tue, 13 Feb 2024 02:39:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707820759; x=1708425559;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mauRMf5MsEGYigBgnvZFNNtsUxvK3dQyEkLMA3BR3V0=;
 b=k2AsBTbHyaNeBPOKR0Ozxi6VTg1Orti2WPdiNPLCTdyIwmz+Dnnk8LAU4gWwx2pgNw
 h7A9pJWGg1WGRpFZWjq/i5x94g9HJrXFKIW+iwutU2cc/rFcznoiB10CfgTYpZmjDsyB
 cRdzGC/1+CNOUj6GGK1v9/MTTHKVvq+RjlY7UjRzr1CuU2bM/Y6P9bRpTGedUJQAAwnK
 gUegBzlU4bpyNeiFSMW+wie+eYlk5Z3SNsKS8ZP/8j2+RdbDrkTKB4BmK6b7nxUdvNge
 8lLjWcC+4hn/pGRIqgYtoaBWdr4LkgbkthSevEmJmRKpOQcYyfXgE8DtKUEgZFGEPcpI
 mZSQ==
X-Gm-Message-State: AOJu0Yyixr6RvjB1xSgAGTGdkCqCQJMpmDRwzLUfI4z6FOiRQLVWwaM5
 do9tZ3JXCY61yomRxnTrBAdODekWo0BtbtWrhzxLbnA0NSlRnzZRzbQ5qqYe4OIKvVLlf1HNT7M
 QmvxM7/KfitFy6q9AGx3mLi5cZKbj2YERjRETAH+Q6Q5JF7ow55wcn71D2IUk
X-Received: by 2002:a05:6512:3d20:b0:511:66fb:9f95 with SMTP id
 d32-20020a0565123d2000b0051166fb9f95mr7633309lfv.3.1707820759221; 
 Tue, 13 Feb 2024 02:39:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHF5KI+d1EvTs7DqDrb5cGgg86rKva/C7lgAjFzAkwpO9oa5n2Qx6JkeIQYbrddlOlDehw4tQ==
X-Received: by 2002:a05:6512:3d20:b0:511:66fb:9f95 with SMTP id
 d32-20020a0565123d2000b0051166fb9f95mr7633289lfv.3.1707820758890; 
 Tue, 13 Feb 2024 02:39:18 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCVF5QF3vx6xS3nxuGwvRdMf1OG9pdYwo23WxTANAgaUxlE48+N2XAyXh4McYpzfDsjlFjegLgftGg0fSmMPKPCR09L397yVdGpCBp+OpNrWnie1GBbQjIVRDZJSmAmK1PV79nXlpfbFqx3VD1mZGE98NwdDyVNCbipOmzRY+2y6kUidj1404yQNeNufJgjrYiTiyt4s+Skt0nlPTxtlciww
Received: from redhat.com ([2.52.146.238]) by smtp.gmail.com with ESMTPSA id
 w15-20020a17090633cf00b00a3868b8e78dsm1164832eja.52.2024.02.13.02.39.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Feb 2024 02:39:18 -0800 (PST)
Date: Tue, 13 Feb 2024 05:39:13 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas@t-8ch.de>
Cc: Cornelia Huck <cohuck@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 qemu-devel@nongnu.org, Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Subject: Re: [PATCH v6 1/6] linux-headers: drop pvpanic.h
Message-ID: <20240213053745-mutt-send-email-mst@kernel.org>
References: <20240208-pvpanic-shutdown-v6-0-965580ac057b@t-8ch.de>
 <20240208-pvpanic-shutdown-v6-1-965580ac057b@t-8ch.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240208-pvpanic-shutdown-v6-1-965580ac057b@t-8ch.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.774,
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

On Thu, Feb 08, 2024 at 09:02:20PM +0100, Thomas Weiﬂschuh wrote:
> misc/pvpanic.h from the Linux UAPI does not define a Linux UAPI but a
> qemu device API.
> 
> This leads to a weird process when updates to the interface are needed:
> 1) Change to the specification in the qemu tree
> 2) Change to the header in the Linux tree
> 3) Re-import of the header into Qemu.
> 
> The kernel prefers to drop the header anyways.
> 
> Prepare for the removal from the Linux UAPI headers by moving the
> contents to the existing pvpanic.h header.
> 
> Link: https://lore.kernel.org/lkml/2023110431-pacemaker-pruning-0e4c@gregkh/
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> Signed-off-by: Thomas Weiﬂschuh <thomas@t-8ch.de>


I don't think I agree with greg. The interaction is with hypervisor
not with userspace but linux does not have a separate
directory for that and the implications are mostly the same.


> ---
>  hw/misc/pvpanic-isa.c                    | 1 -
>  hw/misc/pvpanic-pci.c                    | 1 -
>  hw/misc/pvpanic.c                        | 1 -
>  include/hw/misc/pvpanic.h                | 3 +++
>  include/standard-headers/linux/pvpanic.h | 9 ---------
>  scripts/update-linux-headers.sh          | 3 +--
>  6 files changed, 4 insertions(+), 14 deletions(-)
> 
> diff --git a/hw/misc/pvpanic-isa.c b/hw/misc/pvpanic-isa.c
> index ccec50f61bbd..ef438a31fbe9 100644
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
> diff --git a/hw/misc/pvpanic-pci.c b/hw/misc/pvpanic-pci.c
> index c01e4ce8646a..01e269b55284 100644
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
> diff --git a/hw/misc/pvpanic.c b/hw/misc/pvpanic.c
> index 1540e9091a45..4915ef256e74 100644
> --- a/hw/misc/pvpanic.c
> +++ b/hw/misc/pvpanic.c
> @@ -21,7 +21,6 @@
>  #include "hw/qdev-properties.h"
>  #include "hw/misc/pvpanic.h"
>  #include "qom/object.h"
> -#include "standard-headers/linux/pvpanic.h"
>  
>  static void handle_event(int event)
>  {
> diff --git a/include/hw/misc/pvpanic.h b/include/hw/misc/pvpanic.h
> index fab94165d03d..dffca827f77a 100644
> --- a/include/hw/misc/pvpanic.h
> +++ b/include/hw/misc/pvpanic.h
> @@ -18,6 +18,9 @@
>  #include "exec/memory.h"
>  #include "qom/object.h"
>  
> +#define PVPANIC_PANICKED	(1 << 0)
> +#define PVPANIC_CRASH_LOADED	(1 << 1)
> +
>  #define TYPE_PVPANIC_ISA_DEVICE "pvpanic"
>  #define TYPE_PVPANIC_PCI_DEVICE "pvpanic-pci"
>  
> diff --git a/include/standard-headers/linux/pvpanic.h b/include/standard-headers/linux/pvpanic.h
> deleted file mode 100644
> index 54b7485390d3..000000000000
> --- a/include/standard-headers/linux/pvpanic.h
> +++ /dev/null
> @@ -1,9 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> -
> -#ifndef __PVPANIC_H__
> -#define __PVPANIC_H__
> -
> -#define PVPANIC_PANICKED	(1 << 0)
> -#define PVPANIC_CRASH_LOADED	(1 << 1)
> -
> -#endif /* __PVPANIC_H__ */
> diff --git a/scripts/update-linux-headers.sh b/scripts/update-linux-headers.sh
> index a0006eec6fd1..c4fea51c93fd 100755
> --- a/scripts/update-linux-headers.sh
> +++ b/scripts/update-linux-headers.sh
> @@ -218,8 +218,7 @@ for i in "$tmpdir"/include/linux/*virtio*.h \
>           "$tmpdir/include/linux/const.h" \
>           "$tmpdir/include/linux/kernel.h" \
>           "$tmpdir/include/linux/vhost_types.h" \
> -         "$tmpdir/include/linux/sysinfo.h" \
> -         "$tmpdir/include/misc/pvpanic.h"; do
> +         "$tmpdir/include/linux/sysinfo.h"; do
>      cp_portable "$i" "$output/include/standard-headers/linux"
>  done
>  mkdir -p "$output/include/standard-headers/drm"
> 
> -- 
> 2.43.0


