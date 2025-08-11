Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADD8DC87FD2
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Aug 2025 11:59:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ulRB7-0008Lh-NI; Mon, 11 Aug 2025 07:59:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1ulRB5-0008L1-KX
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 07:58:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1ulRB1-0002GZ-DP
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 07:58:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754913532;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Nl2peqTydXV+HhCbjamFyp7Fkc8cHNuqp+7mgNCrEss=;
 b=VMWAFABzhNUnth1LZaK0A4e9EhuArKNeG78RAFNVRAu0qWwA6LTaZVf+pNR2Oq2DkQiev6
 lBGfkjRsgMmPWtHRbTOSIOAr34gcm5puYQecnvPGeCbvF5yrINCeglkcrD4W1zchlfLDzp
 Jm1PFbzDnWIk12RFdC9jItPtB8lBLJM=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-133-aFe6QssYOk-jtSueGpN9yw-1; Mon, 11 Aug 2025 07:58:51 -0400
X-MC-Unique: aFe6QssYOk-jtSueGpN9yw-1
X-Mimecast-MFC-AGG-ID: aFe6QssYOk-jtSueGpN9yw_1754913528
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-7e69c14e992so843902885a.3
 for <qemu-devel@nongnu.org>; Mon, 11 Aug 2025 04:58:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754913528; x=1755518328;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Nl2peqTydXV+HhCbjamFyp7Fkc8cHNuqp+7mgNCrEss=;
 b=iQKfgd8ZrI7gSie/0pqOhjL095iMTWzhvf11DaoTwY9qyjcZGJLIRDPjGv07Y3vnIK
 RpQfjG2f4RXnq0B0iUbOCTsmzuWhCKRGKqVxRWjhLyj1V3rH4Csobwm52dNfqqfKSn3d
 KbBglXaNQp8u81lbdiPNIxY4udsCtf8iCxhdC2Y2U9Gvr3En3i1PDSiXBGs5TTQUQ57g
 6/2rWE7BHXEq8mhZNeVq0q7Rq7tHbgGVktcXR7iJnF/Zud4RGBznOyf47W28dUIO++Ad
 XxECPFtc80SG9VQyUpUyAbWeBMpOkgp9wF78J7hCx3FlLnE9vjPU9gioHQsbobO1zYKI
 oD6A==
X-Gm-Message-State: AOJu0YyJohxJRicFCimzsCJXUwjb4o2NOpr3DbSXrmXo1h+JkP6SrGCb
 nY14XInPAouO67k8Aj4LLfsqp+ERiQRtNEBqbVkiYKiiM9ppbF89e2NksZaEI21IKKCw75ou/v0
 6UdcwXnPjdu8z4joC45/2gKsFA96t7gE8lU117qhP056+iRbjlOGIOw0q
X-Gm-Gg: ASbGncudEHe2wtfCVQS48uUkNqBtEDmBWoExzYu7jB6UbGImvvpPbTZDDtHGCQx8J3X
 t4fmquKH9SKP8JB/h0frfCfldEb3PDAVpqpCA7g9a7BKHMBoZV/3y0fSsrYfnYtjsb57k7GEk+k
 OkbyK1acrtt8x2jRzgVm+7En8LYUSN6LrBI0tAs0RMQ60KyHgV5t9Uozy6uf3eqSlCqPOzOEDVr
 CYwjdainZ34aBXPMCI5LBUTE//Bh+fSHF6x+T9O9Ld8wzHCI27nAKbK0+VLuTVd+HRup7XQlCo2
 DmmnUQf43hnG++BXc4HKC1Jc/pnq0A==
X-Received: by 2002:a05:620a:4405:b0:7e3:3405:5cde with SMTP id
 af79cd13be357-7e82c6157c4mr1282230985a.2.1754913528021; 
 Mon, 11 Aug 2025 04:58:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG1gi6vuemisdG7pNNHGKJqApAqCiql3PRjnVV/7kaO3uzujClusgodOcYM5eWvFx5nzIqmEA==
X-Received: by 2002:a05:620a:4405:b0:7e3:3405:5cde with SMTP id
 af79cd13be357-7e82c6157c4mr1282227585a.2.1754913527526; 
 Mon, 11 Aug 2025 04:58:47 -0700 (PDT)
Received: from fedora ([85.93.96.130]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7e83e5d6a1bsm356321285a.13.2025.08.11.04.58.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Aug 2025 04:58:47 -0700 (PDT)
Date: Mon, 11 Aug 2025 13:58:43 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Annie Li <annie.li@oracle.com>
Cc: qemu-devel@nongnu.org, dave@treblig.org, mst@redhat.com,
 anisinha@redhat.com, eduardo@habkost.net, marcel.apfelbaum@gmail.com,
 philmd@linaro.org, wangyanan55@huawei.com, zhao1.liu@intel.com,
 pbonzini@redhat.com, richard.henderson@linaro.org, slp@redhat.com,
 eblake@redhat.com, armbru@redhat.com, miguel.luis@oracle.com
Subject: Re: [PATCH 01/13] acpi: Implement control method sleep button
Message-ID: <20250811135843.4c2c4cf4@fedora>
In-Reply-To: <4d7cfdea-34a4-40b3-a81e-560a3a58b194@oracle.com>
References: <20250528163545.2143-1-annie.li@oracle.com>
 <20250528163835.2151-1-annie.li@oracle.com>
 <20250603143110.2cd22790@imammedo.users.ipa.redhat.com>
 <4d7cfdea-34a4-40b3-a81e-560a3a58b194@oracle.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, 3 Jun 2025 15:08:49 -0400
Annie Li <annie.li@oracle.com> wrote:

> Hello Igor,
>=20
> On 6/3/2025 8:31 AM, Igor Mammedov wrote:
> > On Wed, 28 May 2025 12:38:34 -0400
> > Annie Li<annie.li@oracle.com> wrote:
> > =20
> >> The fixed hardware sleep button isn't appropriate for hardware
> >> reduced platform. This patch implements the control method sleep
> >> button in a separate source file so that the button can be added
> >> for various platforms.
> >>
> >> Co-developed-by: Miguel Luis<miguel.luis@oracle.com>
> >> Signed-off-by: Annie Li<annie.li@oracle.com>
> >> ---
> >>   hw/acpi/control_method_device.c         | 38 +++++++++++++++++++++++=
++
> >>   hw/acpi/meson.build                     |  1 +
> >>   include/hw/acpi/control_method_device.h | 21 ++++++++++++++
> >>   3 files changed, 60 insertions(+)
> >>
> >> diff --git a/hw/acpi/control_method_device.c b/hw/acpi/control_method_=
device.c =20
> > sleep_button would be more to the point =20
> Was thinking of more control method devices may be added in future, so
> choose this general name(control_method_device) just in case.
> I'll rename it to control_method_sleep_button then.
> > =20
> >> new file mode 100644
> >> index 0000000000..f8d691ee04
> >> --- /dev/null
> >> +++ b/hw/acpi/control_method_device.c
> >> @@ -0,0 +1,38 @@
> >> +/*
> >> + * Control Method Device
> >> + *
> >> + * Copyright (c) 2023 Oracle and/or its affiliates.
> >> + *
> >> + *
> >> + * Authors:
> >> + *     Annie Li<annie.li@oracle.com>
> >> + *
> >> + * SPDX-License-Identifier: GPL-2.0-or-later
> >> + */
> >> +
> >> +#include "qemu/osdep.h"
> >> +#include "hw/acpi/control_method_device.h"
> >> +#include "hw/acpi/aml-build.h"
> >> +
> >> +/*
> >> + * The control method sleep button[ACPI v6.5 Section 4.8.2.2.2.2]
> >> + * resides in generic hardware address spaces. The sleep button
> >> + * is defined as _HID("PNP0C0E") that associates with device "SLPB".
> >> + */
> >> +void acpi_dsdt_add_sleep_button(Aml *scope)
> >> +{
> >> +    Aml *dev =3D aml_device(ACPI_SLEEP_BUTTON_DEVICE);
> >> +    aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0C0E")));
> >> +    /*
> >> +     * No _PRW, the sleep button device is always tied to GPE L07
> >> +     * event handler for x86 platform, or a GED event for other
> >> +     * platforms such as virt, ARM, microvm, etc.
> >> +     */
> >> +    aml_append(dev, aml_operation_region("\\SLP", AML_SYSTEM_IO,
> >> +                                         aml_int(0x201), 0x1)); =20
> >                                                      ^^^^^^
> >                                              where does this come from?=
 =20
> Got it from an example in ACPI spec[ACPI v6.5 Section 4.8.2.2.2.2]. "=E2=
=80=A2=20
> Creates an operational region for the control method sleep button=E2=80=
=99s=20
> programming model: System I/O space at 0x201." Any suggestions are welcom=
e.

rather than giving answer, I'd ask
  * what it's supposed to do
  * does QEMU has this register or its alternative

answers to above likely will help with answering my original question
or ideas how to fix patch

> >
> > =20
> >> +    Aml *field =3D aml_field("\\SLP", AML_BYTE_ACC, AML_NOLOCK,
> >> +                           AML_WRITE_AS_ZEROS);
> >> +    aml_append(field, aml_named_field("SBP", 1));
> >> +    aml_append(dev, field);
> >> +    aml_append(scope, dev);
> >> +}
> >> diff --git a/hw/acpi/meson.build b/hw/acpi/meson.build
> >> index 73f02b9691..a62e625cef 100644
> >> --- a/hw/acpi/meson.build
> >> +++ b/hw/acpi/meson.build
> >> @@ -17,6 +17,7 @@ acpi_ss.add(when: 'CONFIG_ACPI_CXL', if_true: files(=
'cxl.c'), if_false: files('c
> >>   acpi_ss.add(when: 'CONFIG_ACPI_VMGENID', if_true: files('vmgenid.c'))
> >>   acpi_ss.add(when: 'CONFIG_ACPI_VMCLOCK', if_true: files('vmclock.c'))
> >>   acpi_ss.add(when: 'CONFIG_ACPI_HW_REDUCED', if_true: files('generic_=
event_device.c'))
> >> +acpi_ss.add(when: 'CONFIG_ACPI_HW_REDUCED', if_true: files('control_m=
ethod_device.c')) =20
> > that would build only for microvm + arm, and pc/q35 wouldn't get it
> > if microvm were disabled. =20
> True.
> How about the following?
> acpi_ss.add(files(
>  =C2=A0 'acpi_interface.c',
>  =C2=A0 'aml-build.c',
>  =C2=A0 'bios-linker-loader.c',
>  =C2=A0 'core.c',
>  =C2=A0 'utils.c',
> +'control_method_device.c',
> ))

perhaps this is better

>=20
> Thanks
>=20
> Annie
>=20
>=20
> > =20
> >>   acpi_ss.add(when: 'CONFIG_ACPI_HMAT', if_true: files('hmat.c'))
> >>   acpi_ss.add(when: 'CONFIG_ACPI_APEI', if_true: files('ghes.c'), if_f=
alse: files('ghes-stub.c'))
> >>   acpi_ss.add(when: 'CONFIG_ACPI_PIIX4', if_true: files('piix4.c'))
> >> diff --git a/include/hw/acpi/control_method_device.h b/include/hw/acpi=
/control_method_device.h
> >> new file mode 100644
> >> index 0000000000..079f1a74dd
> >> --- /dev/null
> >> +++ b/include/hw/acpi/control_method_device.h
> >> @@ -0,0 +1,21 @@
> >> +/*
> >> + * Control Method Device
> >> + *
> >> + * Copyright (c) 2023 Oracle and/or its affiliates.
> >> + *
> >> + *
> >> + * Authors:
> >> + *     Annie Li<annie.li@oracle.com>
> >> + *
> >> + * SPDX-License-Identifier: GPL-2.0-or-later
> >> + */
> >> +
> >> +
> >> +#ifndef HW_ACPI_CONTROL_METHOD_DEVICE_H
> >> +#define HW_ACPI_CONTROL_NETHOD_DEVICE_H
> >> +
> >> +#define ACPI_SLEEP_BUTTON_DEVICE "SLPB"
> >> +
> >> +void acpi_dsdt_add_sleep_button(Aml *scope);
> >> +
> >> +#endif =20


