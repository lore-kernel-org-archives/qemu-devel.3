Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4F63C3DA7F
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2024 11:58:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdTgf-0000ci-Iq; Mon, 12 Aug 2024 07:58:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sdTgb-0000bN-EL
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 07:58:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sdTgN-0000tH-9l
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 07:58:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723463869;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SpJndEgom61tK7M4GAuqbEtbuGe7It7d4qf5OxcAq8U=;
 b=f9v3pRrqvxIaeu0d9wK3dW90zcev6TChQjH1VW/LA+8qy4nrJALg9DBOHFZwyYHpBYzRoL
 bH9xytv1BxEfal/Zav4VYrBT7SaGVy45ViEC5KfB3x6UWrtKONJjQ4BUI0RIyKP0nAb4sm
 R7xW3NJFl5GNk2PBhdNp6zhANms/OQs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-186-YcOwKA5HObOd6MB4r7c31Q-1; Mon, 12 Aug 2024 07:57:48 -0400
X-MC-Unique: YcOwKA5HObOd6MB4r7c31Q-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-428207daff2so29317095e9.0
 for <qemu-devel@nongnu.org>; Mon, 12 Aug 2024 04:57:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723463867; x=1724068667;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SpJndEgom61tK7M4GAuqbEtbuGe7It7d4qf5OxcAq8U=;
 b=FVqm5uRRF6QByAqEcXbRfzH+HcZ3Pj3qmW0m0PNORCrGv3RciQp2Xz5ULWTjhVfsCG
 BLKsJtAjsqEk4LW8+T6wc+rAyRCEa5stGWNRRlVUwz3Yx/6Uq2KCZLfqRSvt8TYj/xRi
 P2vhRQAkzpOjizUn9gddMOzqx4u8Xbu2fws9gee/qxtefY7Xv5N+5z1D1/cUc0ohDYWI
 MSQeti8ypH1SveoE2HV7fFhgVgZ0rEgAAi6tfwLh0DRPPDVckwttvP2tGl9MnGB5+yZh
 FeQ4Jak/cHmbwP7NXPK7taVrrfPV7O7KsyBygzAQOwwreSjdIijTd1Bg3u/2Wduu8PaZ
 d+8A==
X-Forwarded-Encrypted: i=1;
 AJvYcCW7uRcuJWFri6TR4cm9bgeRMsKyx0Ov/HdvXHP9lFwILczml1TnPy0uzv7KbAihprcSB1xsPFERGy0OYFn8rmRP6bmscFI=
X-Gm-Message-State: AOJu0YwVaG1dGJMzB0pE5JR3vnlgvTA4IYjUzcC777KkAeX6HIdcE2k/
 XhOM2pU2Y4sHH1zsCytL1jpTva/BErg7VqNIkfav1KXNNUkAGHyKxUlktok/K1QSkyzOQ9g84cO
 l7s/l9YdrP6cXZg1jWAKfOF7wYcLzO44kTkMRFOUAWH0H2NQZ9Ey4
X-Received: by 2002:a05:600c:1e2a:b0:426:593c:9351 with SMTP id
 5b1f17b1804b1-429d47f7044mr1143225e9.6.1723463866811; 
 Mon, 12 Aug 2024 04:57:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEbOH34v3VEOn6QS/EhIQpUgtEPbst67Vw1IN6JOWDjpCL0mrQ5nSf1+YlWJIeTbBCPIOUglw==
X-Received: by 2002:a05:600c:1e2a:b0:426:593c:9351 with SMTP id
 5b1f17b1804b1-429d47f7044mr1142955e9.6.1723463866312; 
 Mon, 12 Aug 2024 04:57:46 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-429c751a554sm102720295e9.22.2024.08.12.04.57.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Aug 2024 04:57:45 -0700 (PDT)
Date: Mon, 12 Aug 2024 13:57:44 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Shiju Jose
 <shiju.jose@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha
 <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>, Eric Blake
 <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Michael Roth
 <michael.roth@amd.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, linux-kernel@vger.kernel.org,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v6 04/10] qapi/ghes-cper: add an interface to do generic
 CPER error injection
Message-ID: <20240812135744.644deaa9@imammedo.users.ipa.redhat.com>
In-Reply-To: <87799362699e4349ce4a44f3d25698d5764735c6.1723119423.git.mchehab+huawei@kernel.org>
References: <cover.1723119423.git.mchehab+huawei@kernel.org>
 <87799362699e4349ce4a44f3d25698d5764735c6.1723119423.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.126,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Thu,  8 Aug 2024 14:26:30 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Creates a QMP command to be used for generic ACPI APEI hardware error
> injection (HEST) via GHESv2.
>=20
> The actual GHES code will be added at the followup patch.
>=20
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  MAINTAINERS              |  7 +++++
>  hw/acpi/Kconfig          |  5 ++++
>  hw/acpi/ghes_cper.c      | 45 ++++++++++++++++++++++++++++++++
>  hw/acpi/ghes_cper_stub.c | 19 ++++++++++++++
>  hw/acpi/meson.build      |  2 ++
>  hw/arm/Kconfig           |  5 ++++
>  include/hw/acpi/ghes.h   |  7 +++++
>  qapi/ghes-cper.json      | 55 ++++++++++++++++++++++++++++++++++++++++
>  qapi/meson.build         |  1 +
>  qapi/qapi-schema.json    |  1 +
>  10 files changed, 147 insertions(+)
>  create mode 100644 hw/acpi/ghes_cper.c
>  create mode 100644 hw/acpi/ghes_cper_stub.c
>  create mode 100644 qapi/ghes-cper.json
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 10af21263293..a0c36f9b5d0c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2077,6 +2077,13 @@ F: hw/acpi/ghes.c
>  F: include/hw/acpi/ghes.h
>  F: docs/specs/acpi_hest_ghes.rst
> =20
> +ACPI/HEST/GHES/ARM processor CPER
> +R: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> +S: Maintained
> +F: hw/arm/ghes_cper.c
> +F: hw/acpi/ghes_cper_stub.c
> +F: qapi/ghes-cper.json
> +
>  ppc4xx
>  L: qemu-ppc@nongnu.org
>  S: Orphan
> diff --git a/hw/acpi/Kconfig b/hw/acpi/Kconfig
> index e07d3204eb36..73ffbb82c150 100644
> --- a/hw/acpi/Kconfig
> +++ b/hw/acpi/Kconfig
> @@ -51,6 +51,11 @@ config ACPI_APEI
>      bool
>      depends on ACPI
> =20
> +config GHES_CPER
> +    bool
> +    depends on ACPI_APEI
> +    default y
> +
>  config ACPI_PCI
>      bool
>      depends on ACPI && PCI
> diff --git a/hw/acpi/ghes_cper.c b/hw/acpi/ghes_cper.c
> new file mode 100644
> index 000000000000..7aa7e71e90dc
> --- /dev/null
> +++ b/hw/acpi/ghes_cper.c
> @@ -0,0 +1,45 @@
> +/*
> + * ARM Processor error injection
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
> +#include "qapi/qapi-commands-ghes-cper.h"
> +#include "hw/acpi/ghes.h"
> +
> +void qmp_ghes_cper(CommonPlatformErrorRecord *qmp_cper,
> +                   Error **errp)
> +{
> +    int rc;
> +    AcpiGhesCper cper;
> +    QemuUUID be_uuid, le_uuid;
> +
> +    rc =3D qemu_uuid_parse(qmp_cper->notification_type, &be_uuid);
> +    if (rc) {
> +        error_setg(errp, "GHES: Invalid UUID: %s",
> +                   qmp_cper->notification_type);
> +        return;
> +    }
> +
> +    le_uuid =3D qemu_uuid_bswap(be_uuid);
> +    cper.guid =3D le_uuid.data;
> +
> +    cper.data =3D qbase64_decode(qmp_cper->raw_data, -1,
> +                               &cper.data_len, errp);
> +    if (!cper.data) {
> +        return;
> +    }
> +
> +    /* TODO: call a function at ghes */
> +
> +    g_free(cper.data);
> +}
> diff --git a/hw/acpi/ghes_cper_stub.c b/hw/acpi/ghes_cper_stub.c
> new file mode 100644
> index 000000000000..2358e039b181
> --- /dev/null
> +++ b/hw/acpi/ghes_cper_stub.c
> @@ -0,0 +1,19 @@
> +/*
> + * ARM Processor error injection
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
> +#include "qapi/qapi-commands-ghes-cper.h"
> +#include "hw/acpi/ghes.h"
> +
> +void qmp_ghes_cper(CommonPlatformErrorRecord *cper, Error **errp)
> +{
> +    error_setg(errp, "GHES QMP error inject is not compiled in");
> +}
> diff --git a/hw/acpi/meson.build b/hw/acpi/meson.build
> index fa5c07db9068..6cbf430eb66d 100644
> --- a/hw/acpi/meson.build
> +++ b/hw/acpi/meson.build
> @@ -34,4 +34,6 @@ endif
>  system_ss.add(when: 'CONFIG_ACPI', if_false: files('acpi-stub.c', 'aml-b=
uild-stub.c', 'ghes-stub.c', 'acpi_interface.c'))
>  system_ss.add(when: 'CONFIG_ACPI_PCI_BRIDGE', if_false: files('pci-bridg=
e-stub.c'))
>  system_ss.add_all(when: 'CONFIG_ACPI', if_true: acpi_ss)
> +system_ss.add(when: 'CONFIG_GHES_CPER', if_true: files('ghes_cper.c'))
> +system_ss.add(when: 'CONFIG_GHES_CPER', if_false: files('ghes_cper_stub.=
c'))
>  system_ss.add(files('acpi-qmp-cmds.c'))
> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
> index 1ad60da7aa2d..bed6ba27d715 100644
> --- a/hw/arm/Kconfig
> +++ b/hw/arm/Kconfig
> @@ -712,3 +712,8 @@ config ARMSSE
>      select UNIMP
>      select SSE_COUNTER
>      select SSE_TIMER
> +
> +config GHES_CPER
> +    bool
> +    depends on ARM
> +    default y if AARCH64
> diff --git a/include/hw/acpi/ghes.h b/include/hw/acpi/ghes.h
> index ce6f82a1155a..a7a18c7b50cf 100644
> --- a/include/hw/acpi/ghes.h
> +++ b/include/hw/acpi/ghes.h
> @@ -23,6 +23,7 @@
>  #define ACPI_GHES_H
> =20
>  #include "hw/acpi/bios-linker-loader.h"
> +#include "qapi/error.h"
>  #include "qemu/notify.h"
> =20
>  extern NotifierList acpi_generic_error_notifiers;
> @@ -78,6 +79,12 @@ void acpi_ghes_add_fw_cfg(AcpiGhesState *vms, FWCfgSta=
te *s,
>                            GArray *hardware_errors);
>  int acpi_ghes_record_errors(uint8_t notify, uint64_t error_physical_addr=
);
> =20
> +typedef struct AcpiGhesCper {
> +    uint8_t *guid;
> +    uint8_t *data;
> +    size_t data_len;
> +} AcpiGhesCper;
> +
>  /**
>   * acpi_ghes_present: Report whether ACPI GHES table is present
>   *
> diff --git a/qapi/ghes-cper.json b/qapi/ghes-cper.json
> new file mode 100644
> index 000000000000..3cc4f9f2aaa9
> --- /dev/null
> +++ b/qapi/ghes-cper.json
> @@ -0,0 +1,55 @@
> +# -*- Mode: Python -*-
> +# vim: filetype=3Dpython
> +
> +##
> +# =3D GHESv2 CPER Error Injection
> +#
> +# These are defined at
> +# ACPI 6.2: 18.3.2.8 Generic Hardware Error Source version 2
> +# (GHESv2 - Type 10)
> +##
> +
> +##
> +# @CommonPlatformErrorRecord:
> +#
> +# Common Platform Error Record - CPER - as defined at the UEFI
> +# specification.  See
> +# https://uefi.org/specs/UEFI/2.10/Apx_N_Common_Platform_Error_Record.ht=
ml#record-header
> +# for more details.
> +#
> +# @notification-type: pre-assigned GUID string indicating the record
> +#   association with an error event notification type, as defined
> +#   at https://uefi.org/specs/UEFI/2.10/Apx_N_Common_Platform_Error_Reco=
rd.html#record-header
> +#
> +# @raw-data: Contains a base64 encoded string with the payload of
> +#   the CPER.
> +#
> +# Since: 9.2
> +##
> +{ 'struct': 'CommonPlatformErrorRecord',
> +  'data': {
> +      'notification-type': 'str',

like was mentioned at v5 review,
you only need this for setting cper notification type if you are (re)using

  acpi_ghes_generic_error_status() && acpi_ghes_generic_error_data()

however while doing this in (6/10), you are also limiting what
could be encoded in headers to some hardcoded values.

Given QEMU doesn't need to know anything about notification type,
modulo putting it data block header, it would be beneficial
to drop 'notification type' from QAPI interface, and include
error status block and error data headers in raw-data.

This way it should be possible to change headers within python script
without affecting QEMU and QAPI interface. On top of that
ghes_record_cper_errors() could be simplified by dropping (in 6/10)
   acpi_ghes_generic_error_status() && acpi_ghes_generic_error_data()
and just copying raw-data as is directly into error buffer (assuming
script put needed headers cper data).

=46rom fusing pov it's also beneficial to try generate junk error status
block headers, for which python script looks like ideal place to put
it in.

> +      'raw-data': 'str'
> +  }
> +}
> +
> +##
> +# @ghes-cper:
> +#
> +# Inject ARM Processor error with data to be filled according with
> +# ACPI 6.2 GHESv2 spec.
> +#
> +# @cper: a single CPER record to be sent to the guest OS.
> +#
> +# Features:
> +#
> +# @unstable: This command is experimental.
> +#
> +# Since: 9.2
> +##
> +{ 'command': 'ghes-cper',
> +  'data': {
> +    'cper': 'CommonPlatformErrorRecord'
> +  },
> +  'features': [ 'unstable' ]
> +}
> diff --git a/qapi/meson.build b/qapi/meson.build
> index e7bc54e5d047..bd13cd7d40c9 100644
> --- a/qapi/meson.build
> +++ b/qapi/meson.build
> @@ -35,6 +35,7 @@ qapi_all_modules =3D [
>    'dump',
>    'ebpf',
>    'error',
> +  'ghes-cper',
>    'introspect',
>    'job',
>    'machine-common',
> diff --git a/qapi/qapi-schema.json b/qapi/qapi-schema.json
> index b1581988e4eb..c1a267399fe5 100644
> --- a/qapi/qapi-schema.json
> +++ b/qapi/qapi-schema.json
> @@ -75,6 +75,7 @@
>  { 'include': 'misc-target.json' }
>  { 'include': 'audio.json' }
>  { 'include': 'acpi.json' }
> +{ 'include': 'ghes-cper.json' }
>  { 'include': 'pci.json' }
>  { 'include': 'stats.json' }
>  { 'include': 'virtio.json' }


