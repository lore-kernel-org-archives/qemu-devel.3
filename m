Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F02F5C02181
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 12:39:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbIxe-0006Ty-4p; Fri, 24 Jan 2025 07:38:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tbIxY-0006TR-Tr
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 07:38:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tbIxW-0003gi-GS
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 07:38:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737722328;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/u9uz5233xcg3BDclrAoelnIrDNjGp/yo1G75N/4Gkc=;
 b=hB2w0fKtlM3VYOx7kAohGBCNb+TnT909otjT+G7Mh+vcJXDHtarc00hQ+FJFQXybv/wtJr
 ntTmmLh3ZPXRPLnXjdnHRjr9z1GncN19cBk9QMy9jaq7J398EHDLE5XC8jeOwon01SFN3U
 pAyySFPb1h0U3pjUThDFCUgtlRdz3vE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-6hE5bjlJMQqCHhxpbwbicw-1; Fri, 24 Jan 2025 07:38:47 -0500
X-MC-Unique: 6hE5bjlJMQqCHhxpbwbicw-1
X-Mimecast-MFC-AGG-ID: 6hE5bjlJMQqCHhxpbwbicw
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-38c24ac3415so1656073f8f.2
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2025 04:38:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737722326; x=1738327126;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/u9uz5233xcg3BDclrAoelnIrDNjGp/yo1G75N/4Gkc=;
 b=mcuB8YUoeBvDRO/TG6lsbWnNFzK8JowQHxqNcaKseS2b7r1KKp7o6m8j/Fjnrleq4P
 mwvTw2HsQJJXoaM7pGIAOi+jdB16rxJ/w1VcY+XML3dLmkR+IIYpRzaA499mbyo+jpAB
 8UOkbGJqPQHXVdPl7cvbWBJN53Yy2IzPOdwDiO/TOx7s+1ww+neS0ZZnc3NqLYu+Q2Uc
 A0l6Uaohd4Bl0pMx3jzyGiQgkZQc1gDHOy6mnI3OV1i26UHn6c1dtjYPTasQR4NmBv0+
 +guk8U2s5qBDtWB6wvb70bjcrCbUTVbc6/vmg7JYxCHfE4r3rpfUMrR+0cUjwLa6pZuw
 K6Rw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVxvbvpKR3uqUrTY83XAUnceKX/XqAqd/gIPPpkNEwV5xPV0dMWzs/BmGsE9RSclb4mPiZtvzJwKCM3@nongnu.org
X-Gm-Message-State: AOJu0Yw5Kc7C2qdPg3HIzy1LMVQvPsGGScCcaCnF1ZBPajQiEKYbL98R
 yzXaikAItXUfBTO9KDhxmHbnrCHoBueByE9IZVI2dOgKtjOcB80pFgXc7VAqWiWByRDd82nxBVz
 nLNaP0LCikI5aLCc8jQQ9HHYMoMWU3EljblfQOW2oE04PMhyurbQY
X-Gm-Gg: ASbGnct49hJxpTJv53ra5p4Byc76xSWeZHyHhndESzYicxLQRyVbrQyHEPm07ajRYT4
 0mNNUhogrFVDFOZCrnJ1Fn6Vfwx0DarJDr5Mfkpo1XyIav1sRkmIJV+hvhfq8M5X5q5k5uLVJ02
 TQxibEbKKcnD3I1RKRquWpFIMjEXr7GEeRzfHY+lsAcAVAM1SBVPGdbwSxL/w7/AkE117xPrb9D
 4Rv0xgKQENybreOAq899G6uYQJThq3aU4zAQhQkaJGfzhKE5NaGTAepnHPZVb2+ZsvvLiujXM/r
 5tOX5dZa/0WtHwK5LPNKX95UKoQ/GIytlaivCYvE+A==
X-Received: by 2002:adf:cd82:0:b0:385:ee3f:5cbf with SMTP id
 ffacd0b85a97d-38bf565a596mr22190027f8f.20.1737722325897; 
 Fri, 24 Jan 2025 04:38:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEDlHwMbxYGdgZJtFCLdHYsXK7HZSNtsHLvp8Y0TTLstRqyuj0qt2KJZQCdl7JWZigvHeR85g==
X-Received: by 2002:adf:cd82:0:b0:385:ee3f:5cbf with SMTP id
 ffacd0b85a97d-38bf565a596mr22190010f8f.20.1737722325491; 
 Fri, 24 Jan 2025 04:38:45 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c2a1bb0c9sm2591242f8f.78.2025.01.24.04.38.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jan 2025 04:38:44 -0800 (PST)
Date: Fri, 24 Jan 2025 13:38:44 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Shiju Jose <shiju.jose@huawei.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org, Ani Sinha
 <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>, Eric Blake
 <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Michael Roth
 <michael.roth@amd.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, Shannon Zhao <shannon.zhaosl@gmail.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/11] qapi/acpi-hest: add an interface to do generic
 CPER error injection
Message-ID: <20250124133844.463a99c9@imammedo.users.ipa.redhat.com>
In-Reply-To: <769b68a3192cc921fec4c0e5e925552920fdbe71.1737560101.git.mchehab+huawei@kernel.org>
References: <cover.1737560101.git.mchehab+huawei@kernel.org>
 <769b68a3192cc921fec4c0e5e925552920fdbe71.1737560101.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Wed, 22 Jan 2025 16:46:27 +0100
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Creates a QMP command to be used for generic ACPI APEI hardware error
> injection (HEST) via GHESv2, and add support for it for ARM guests.
> 
> Error injection uses ACPI_HEST_SRC_ID_QMP source ID to be platform
> independent. This is mapped at arch virt bindings, depending on the
> types supported by QEMU and by the BIOS. So, on ARM, this is supported
> via ACPI_GHES_NOTIFY_GPIO notification type.
> 
> This patch is co-authored:
>     - original ghes logic to inject a simple ARM record by Shiju Jose;
>     - generic logic to handle block addresses by Jonathan Cameron;
>     - generic GHESv2 error inject by Mauro Carvalho Chehab;
> 
> Co-authored-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Co-authored-by: Shiju Jose <shiju.jose@huawei.com>
> Co-authored-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

QMP is not my area, so just a cursory review

with nits below fixed up
  Acked-by: Igor Mammedov <imammedo@redhat.com>

> 
> ---
> 
> Changes since v9:
> - ARM source IDs renamed to reflect SYNC/ASYNC;
> - command name changed to better reflect what it does;
> - some improvements at JSON documentation;
> - add a check for QMP source at the notification logic.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  MAINTAINERS              |  7 +++++++
>  hw/acpi/Kconfig          |  5 +++++
>  hw/acpi/ghes.c           |  2 +-
>  hw/acpi/ghes_cper.c      | 32 ++++++++++++++++++++++++++++++++
>  hw/acpi/ghes_cper_stub.c | 19 +++++++++++++++++++
>  hw/acpi/meson.build      |  2 ++
>  hw/arm/virt-acpi-build.c |  1 +
>  hw/arm/virt.c            |  7 +++++++
>  include/hw/acpi/ghes.h   |  1 +
>  include/hw/arm/virt.h    |  1 +
>  qapi/acpi-hest.json      | 35 +++++++++++++++++++++++++++++++++++
>  qapi/meson.build         |  1 +
>  qapi/qapi-schema.json    |  1 +
>  13 files changed, 113 insertions(+), 1 deletion(-)
>  create mode 100644 hw/acpi/ghes_cper.c
>  create mode 100644 hw/acpi/ghes_cper_stub.c
>  create mode 100644 qapi/acpi-hest.json
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 846b81e3ec03..8e1f662fa0e0 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2075,6 +2075,13 @@ F: hw/acpi/ghes.c
>  F: include/hw/acpi/ghes.h
>  F: docs/specs/acpi_hest_ghes.rst
>  
> +ACPI/HEST/GHES/ARM processor CPER
> +R: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> +S: Maintained
> +F: hw/arm/ghes_cper.c
> +F: hw/acpi/ghes_cper_stub.c
> +F: qapi/acpi-hest.json
> +
>  ppc4xx
>  L: qemu-ppc@nongnu.org
>  S: Orphan
> diff --git a/hw/acpi/Kconfig b/hw/acpi/Kconfig
> index 1d4e9f0845c0..daabbe6cd11e 100644
> --- a/hw/acpi/Kconfig
> +++ b/hw/acpi/Kconfig
> @@ -51,6 +51,11 @@ config ACPI_APEI
>      bool
>      depends on ACPI
>  
> +config GHES_CPER
> +    bool
> +    depends on ACPI_APEI
> +    default y
> +
>  config ACPI_PCI
>      bool
>      depends on ACPI && PCI
> diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
> index 5d29db3918dd..cf83c959b5ef 100644
> --- a/hw/acpi/ghes.c
> +++ b/hw/acpi/ghes.c
> @@ -547,7 +547,7 @@ void ghes_record_cper_errors(const void *cper, size_t len,
>      /* Write the generic error data entry into guest memory */
>      cpu_physical_memory_write(cper_addr, cper, len);
>  
> -    notifier_list_notify(&acpi_generic_error_notifiers, NULL);
> +    notifier_list_notify(&acpi_generic_error_notifiers, &source_id);
>  }
>  
>  int acpi_ghes_memory_errors(uint16_t source_id, uint64_t physical_address)
> diff --git a/hw/acpi/ghes_cper.c b/hw/acpi/ghes_cper.c
> new file mode 100644
> index 000000000000..02c47b41b990
> --- /dev/null
> +++ b/hw/acpi/ghes_cper.c
> @@ -0,0 +1,32 @@
> +/*
> + * CPER payload parser for error injection
> + *
> + * Copyright(C) 2024 Huawei LTD.
> + *
> + * This code is licensed under the GPL version 2 or later. See the
> + * COPYING file in the top-level directory.
> + *
> + */
> +
> +#include "qemu/osdep.h"
> +
> +#include "qemu/base64.h"
> +#include "qemu/error-report.h"
> +#include "qemu/uuid.h"
> +#include "qapi/qapi-commands-acpi-hest.h"
> +#include "hw/acpi/ghes.h"
> +
> +void qmp_inject_ghes_error(const char *qmp_cper, Error **errp)
> +{
> +
> +    uint8_t *cper;
> +    size_t  len;
> +
> +    cper = qbase64_decode(qmp_cper, -1, &len, errp);
> +    if (!cper) {
> +        error_setg(errp, "missing GHES CPER payload");
> +        return;
> +    }
> +
> +    ghes_record_cper_errors(cper, len, ACPI_HEST_SRC_ID_QMP, errp);
> +}
> diff --git a/hw/acpi/ghes_cper_stub.c b/hw/acpi/ghes_cper_stub.c
> new file mode 100644
> index 000000000000..8782e2c02fa8
> --- /dev/null
> +++ b/hw/acpi/ghes_cper_stub.c
> @@ -0,0 +1,19 @@
> +/*
> + * Stub interface for CPER payload parser for error injection
> + *
> + * Copyright(C) 2024 Huawei LTD.
> + *
> + * This code is licensed under the GPL version 2 or later. See the
> + * COPYING file in the top-level directory.
> + *
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qapi/error.h"
> +#include "qapi/qapi-commands-acpi-hest.h"
> +#include "hw/acpi/ghes.h"
> +
> +void qmp_inject_ghes_error(const char *cper, Error **errp)
> +{
> +    error_setg(errp, "GHES QMP error inject is not compiled in");
> +}
> diff --git a/hw/acpi/meson.build b/hw/acpi/meson.build
> index 73f02b96912b..56b5d1ec9691 100644
> --- a/hw/acpi/meson.build
> +++ b/hw/acpi/meson.build
> @@ -34,4 +34,6 @@ endif
>  system_ss.add(when: 'CONFIG_ACPI', if_false: files('acpi-stub.c', 'aml-build-stub.c', 'ghes-stub.c', 'acpi_interface.c'))
>  system_ss.add(when: 'CONFIG_ACPI_PCI_BRIDGE', if_false: files('pci-bridge-stub.c'))
>  system_ss.add_all(when: 'CONFIG_ACPI', if_true: acpi_ss)
> +system_ss.add(when: 'CONFIG_GHES_CPER', if_true: files('ghes_cper.c'))
> +system_ss.add(when: 'CONFIG_GHES_CPER', if_false: files('ghes_cper_stub.c'))
>  system_ss.add(files('acpi-qmp-cmds.c'))
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index ae60268bdcc2..d094212ce584 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -896,6 +896,7 @@ static void acpi_align_size(GArray *blob, unsigned align)
>  
>  static const AcpiNotificationSourceId hest_ghes_notify[] = {
>      { ACPI_HEST_SRC_ID_SYNC, ACPI_GHES_NOTIFY_SEA },
> +    { ACPI_HEST_SRC_ID_QMP, ACPI_GHES_NOTIFY_GPIO },
>  };
>  
>  static const AcpiNotificationSourceId hest_ghes_notify_9_2[] = {
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index e272b35ea114..9074a540197d 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -1012,6 +1012,13 @@ static void virt_powerdown_req(Notifier *n, void *opaque)
>  
>  static void virt_generic_error_req(Notifier *n, void *opaque)
>  {
> +    uint16_t *source_id = opaque;
> +
> +    /* Currently, only QMP source ID is async */
> +    if (*source_id != ACPI_HEST_SRC_ID_QMP) {
> +        return;
> +    }
> +
>      VirtMachineState *s = container_of(n, VirtMachineState, generic_error_notifier);
>  
>      acpi_send_event(s->acpi_dev, ACPI_GENERIC_ERROR);
> diff --git a/include/hw/acpi/ghes.h b/include/hw/acpi/ghes.h
> index 64fe2b5bea65..078d78666f91 100644
> --- a/include/hw/acpi/ghes.h
> +++ b/include/hw/acpi/ghes.h
> @@ -72,6 +72,7 @@ typedef struct AcpiGhesState {
>   */
>  enum AcpiGhesSourceID {
>      ACPI_HEST_SRC_ID_SYNC,
> +    ACPI_HEST_SRC_ID_QMP,       /* Use it only for QMP injected errors */
>  };
>  
>  typedef struct AcpiNotificationSourceId {
> diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
> index f3cf28436770..56f270f61cf5 100644
> --- a/include/hw/arm/virt.h
> +++ b/include/hw/arm/virt.h
> @@ -33,6 +33,7 @@
>  #include "exec/hwaddr.h"
>  #include "qemu/notify.h"
>  #include "hw/boards.h"
> +#include "hw/acpi/ghes.h"
>  #include "hw/arm/boot.h"
>  #include "hw/arm/bsa.h"
>  #include "hw/block/flash.h"
> diff --git a/qapi/acpi-hest.json b/qapi/acpi-hest.json
> new file mode 100644
> index 000000000000..d58fba485180
> --- /dev/null
> +++ b/qapi/acpi-hest.json
> @@ -0,0 +1,35 @@
> +# -*- Mode: Python -*-
> +# vim: filetype=python
> +
> +##
> +# == GHESv2 CPER Error Injection
> +#
> +# Defined since ACPI Specification 6.1,
> +# section 18.3.2.8 Generic Hardware Error Source version 2. See:
> +#
> +# https://uefi.org/sites/default/files/resources/ACPI_6_1.pdf
> +##
> +
> +
> +##
> +# @inject-ghes-error:
> +#
> +# Inject an error with additional ACPI 6.1 GHESv2 error information
> +#
> +# @cper: contains a base64 encoded string with raw data for a single
> +#     CPER record with Generic Error Status Block, Generic Error Data
> +#     Entry and generic error data payload, as described at
> +#     https://uefi.org/specs/UEFI/2.10/Apx_N_Common_Platform_Error_Record.html#format
> +#
> +# Features:
> +#
> +# @unstable: This command is experimental.
> +#
> +# Since: 9.2

10.0

> +##
> +{ 'command': 'inject-ghes-error',

s/ghes/ghes-v2/


> +  'data': {
> +    'cper': 'str'
> +  },
> +  'features': [ 'unstable' ]
> +}
> diff --git a/qapi/meson.build b/qapi/meson.build
> index e7bc54e5d047..35cea6147262 100644
> --- a/qapi/meson.build
> +++ b/qapi/meson.build
> @@ -59,6 +59,7 @@ qapi_all_modules = [
>  if have_system
>    qapi_all_modules += [
>      'acpi',
> +    'acpi-hest',
>      'audio',
>      'cryptodev',
>      'qdev',
> diff --git a/qapi/qapi-schema.json b/qapi/qapi-schema.json
> index b1581988e4eb..baf19ab73afe 100644
> --- a/qapi/qapi-schema.json
> +++ b/qapi/qapi-schema.json
> @@ -75,6 +75,7 @@
>  { 'include': 'misc-target.json' }
>  { 'include': 'audio.json' }
>  { 'include': 'acpi.json' }
> +{ 'include': 'acpi-hest.json' }
>  { 'include': 'pci.json' }
>  { 'include': 'stats.json' }
>  { 'include': 'virtio.json' }


