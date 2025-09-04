Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFEE3CA1002
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Sep 2025 12:43:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uu9I9-0004nX-9g; Thu, 04 Sep 2025 08:42:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uu9I5-0004mi-Jr
 for qemu-devel@nongnu.org; Thu, 04 Sep 2025 08:42:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uu9Hw-0007tX-Um
 for qemu-devel@nongnu.org; Thu, 04 Sep 2025 08:42:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756989717;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ot3UKrQ3BJvizdhD8pIBX/oZt6RTHodcDuffr0qAOSU=;
 b=I5vyd6FVyR0OKHYrbmHKlpnYnlOSuykieHxJg52a8QfDuRiGTE4IefhUBFFKMxDbCGWRg/
 QXskOxTosjb0zreN5KcrRnIQZGAl7ItOyGsAzKpoLdll0AULjIUVOiFxaY7PkQzlNvz5m4
 MugIoSBNIEOhFVK04urm/DEh8mbGxWI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-_XTRp157O1-IfdPA9tFjTQ-1; Thu, 04 Sep 2025 08:41:54 -0400
X-MC-Unique: _XTRp157O1-IfdPA9tFjTQ-1
X-Mimecast-MFC-AGG-ID: _XTRp157O1-IfdPA9tFjTQ_1756989713
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-45b7c01a6d3so5518515e9.2
 for <qemu-devel@nongnu.org>; Thu, 04 Sep 2025 05:41:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756989713; x=1757594513;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ot3UKrQ3BJvizdhD8pIBX/oZt6RTHodcDuffr0qAOSU=;
 b=iFQE6q3Vs29LCg0mdehNIKrfjZ4WgK9Emgfaahqd4etahk4iVOd6PQnB2B15zEjEw4
 XXKZ9xGURCD7LOWFLKmMKtU4ZQeSgBulvCDILngYiJgh6ABazbMtxJ5yjL0OfSP1KvdE
 bCO+FS26IplTw0HLyhaiYtvLx95LxITgyamR+oW7Ekppu9T5M7CaYzUGFzFMKia8FtHs
 8hng1xGeIFZ/PpKPxw/cvYEAXl5nPiOHGbPAiQwLmdUIrRQADHSt4WRGA468baznwHMc
 zfhjpVLwmDISwxaII5kC7hv8gPNKyySlFDInytnVmkjgI7YE7kkPHx3faA4T0CeHdOhz
 uRoQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVb5a9q7rNCjmzHmG/P9RPuUQ0MeJaCjnv/vLwJnK8H7SZaxlHC85Nxz0KRS6Ojt2w6gMPmG5UNK9u/@nongnu.org
X-Gm-Message-State: AOJu0YyzPPl+kqnYsMasYqsQMJUxV9bGsERHKIIg0c7iAMFWgpmRHkL3
 fTHf3QE62dEnSAJ9/CREwCR9ws4s7Qiqw3cKojH5ucz5B9J2R4RqnjY8VePqKb9TCyYYGudWKeb
 5vboEjxLFG+elGr4U5iDGO16wGtnKycUCtheTxZhbu6mdw0x/mhAGuy9r
X-Gm-Gg: ASbGncsfSp8hgSF0fsDg5M25Qi3FSaqb6FGXPTvl+vGiEM3TK6joHvHUOJJbQsYVo/J
 IXAOCJ9341M8QW/P07c42WTC2UawBwcktKdqM8rfp89Zez3i5fiwgK8H0dxDZW/CgZzU+0PWXfv
 DG1iajQuW/qyuYydd/omUSJsXsENud1k4bpijLBuvAXcElYGlzSwWkHGaqBf+jW1eW3Zt77IJ5K
 EPdm7bS7yr/JTEwWNM0qBVSblITJcy54BKXc7FPNeawJq6zxlE4BSVrx3N/y7hf2259t5ZtgUYF
 0ShnQFprPkbuD7NjKQdyMB70rNyw5Q==
X-Received: by 2002:a05:600c:1914:b0:45b:8ac2:9759 with SMTP id
 5b1f17b1804b1-45b8ac29906mr134809235e9.23.1756989713020; 
 Thu, 04 Sep 2025 05:41:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGkQk9BgEPm0PYieByOpRbF7d8G166d9nE4ViqSsvrag571LRfL3yE9mq1oPJ6DtWljSvfbvQ==
X-Received: by 2002:a05:600c:1914:b0:45b:8ac2:9759 with SMTP id
 5b1f17b1804b1-45b8ac29906mr134808975e9.23.1756989712549; 
 Thu, 04 Sep 2025 05:41:52 -0700 (PDT)
Received: from fedora ([85.93.96.130]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b93fae643sm130350575e9.3.2025.09.04.05.41.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Sep 2025 05:41:52 -0700 (PDT)
Date: Thu, 4 Sep 2025 14:41:51 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Leonid Bloch <lb.workbox@gmail.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, Eric
 Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Marcel
 Apfelbaum <marcel.apfelbaum@gmail.com>, Dmitry Fleytman
 <dmitry.fleytman@gmail.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v3 0/4] Introduce a battery, AC adapter, and lid button
Message-ID: <20250904144151.799bf77f@fedora>
In-Reply-To: <20250827220054.37268-1-lb.workbox@gmail.com>
References: <20250827220054.37268-1-lb.workbox@gmail.com>
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
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Thu, 28 Aug 2025 01:00:46 +0300
Leonid Bloch <lb.workbox@gmail.com> wrote:

> This series introduces three ACPI devices that are particularly useful
> for laptop/mobile virtualization:
>=20
> * Battery
> * AC adapter
> * Laptop lid button
generic comments that apply to whole series.

1. I'd suggest to split out documentation from the code into a separate pat=
ches.
   1st goes a doc patch, then device code, rinse& repeat for the next devic=
e.
   That should make patches more readable. (as it's now patches are too big)

2. Fishing out battery/lid/... date from host, is very host specific
   and not exactly QEMU business.
   I think QMP interface is sufficient to make new devices functional.
   And user/mgmt apps can use QMP to set/trigger/update device state when n=
ecessary.

   So I suggest to drop everything related to sysfs & co.
   It should be fine to provide in tree a python script as a reference impl.
   that would access sysfs and translate it to QMP for dev purposes.

   That will help reviewabilty of patches, from security pov reduce codebase
   only to bare necessity to emulate/manage devices, and won't require
   giving away access to sysfs files to QEMU.

   If there is a desire to make it available to end-users, then adding that
   to libvirt (which is likely next mgmt layer on for laptop users) looks
   like a best bet to make it accessible to ordinary users.

3. is it possible to use PCI instead of ISA as a base for the devices?
   (with PCI, device will be basically self provisioning with out need to
   manually pick up addresses, which is difficult thing to do and also
   on ACPI level PCI bars can be accessed without need to nail down
   IO region addresses, and possibility to use it machines without ISA bus)

I'll skim through individual patches as the 1st pass (and will do detailed =
review
on next revision once comments are addressed).
=20
> Link to v2: https://lists.gnu.org/archive/html/qemu-devel/2025-08/msg0316=
6.html
> Link to GitHub PR, for ease of review: https://github.com/blochl/qemu/pul=
l/3
>=20
> Changes in v3:
> --------------
> * Rebased on latest master
> * Addressed the v2 review by Igor Mammedov
>=20
> Changes in v2:
> --------------
> Based on the feedback from Philippe Mathieu-Daud=C3=A9 and Michael S. Tsi=
rkin:
>=20
> * Complete redesign with dual-mode operation:
>   - QMP control mode (default): Devices are controlled via QMP commands,
>     providing deterministic behavior essential for migration and CI/testi=
ng
>   - Host mirroring mode (opt-in): Original sysfs/procfs monitoring behavi=
or,
>     now disabled by default
>=20
> * Migrated to modern QEMU ACPI architecture:
>   - Devices now implement ACPI_DEV_AML_IF interface
>   - AML generation moved from centralized acpi-build.c to device files
>=20
> * Added a QMP interface:
>   - battery-set-state/query-battery
>   - ac-adapter-set-state/query-ac-adapter
>   - lid-button-set-state/query-lid-button
>=20
> * Documentation improvements:
>   - Converted to .rst format
>   - Added examples for both QMP and "fake" sysfs/procfs testing
>=20
> The dual-mode design ensures these devices are migration-safe and
> deterministic by default, while still allowing host state mirroring
> when explicitly requested for desktop use cases.
>=20
> Use cases:
> ----------
> 1. Testing: CI systems can programmatically control power states
> 2. Cloud: Expose virtual battery for usage-based resource limiting
> 3. Desktop virtualization: Mirror host laptop state to guest (opt-in)
> 4. Development: Test power management without physical hardware
>=20
> Example usage:
> --------------
> # Default QMP-controlled battery
> qemu-system-x86_64 -device battery
>=20
> # Mirror host battery
> qemu-system-x86_64 -device battery,use-qmp=3Dfalse,enable-sysfs=3Dtrue
>=20
> # Control via QMP
> {"execute": "battery-set-state",
>  "arguments": {"state": {"present": true, "charging": false,
>                          "discharging": true, "charge-percent": 42,
>                          "rate": 500}}}
>=20
> The series has been tested with Windows and Linux guests, correctly
> showing battery status, AC adapter state, and lid button events in
> guest UIs and triggering appropriate power management actions.
>=20
> Thanks again for your patience and feedback.
> Leonid.
>=20
> Leonid Bloch (4):
>   hw/acpi: Support extended GPE handling for additional ACPI devices
>   hw/acpi: Introduce the QEMU Battery
>   hw/acpi: Introduce the QEMU AC adapter
>   hw/acpi: Introduce the QEMU lid button
>=20
>  MAINTAINERS                          |  18 +
>  docs/specs/acad.rst                  | 195 +++++++
>  docs/specs/battery.rst               | 225 ++++++++
>  docs/specs/button.rst                | 189 +++++++
>  docs/specs/index.rst                 |   3 +
>  hw/acpi/Kconfig                      |  12 +
>  hw/acpi/acad.c                       | 447 ++++++++++++++++
>  hw/acpi/battery.c                    | 735 +++++++++++++++++++++++++++
>  hw/acpi/button.c                     | 438 ++++++++++++++++
>  hw/acpi/core.c                       |  17 +-
>  hw/acpi/meson.build                  |   3 +
>  hw/acpi/trace-events                 |  15 +
>  hw/i386/Kconfig                      |   3 +
>  hw/i386/acpi-build.c                 |   1 +
>  include/hw/acpi/acad.h               |  27 +
>  include/hw/acpi/acpi_dev_interface.h |   3 +
>  include/hw/acpi/battery.h            |  33 ++
>  include/hw/acpi/button.h             |  25 +
>  qapi/acpi.json                       | 171 +++++++
>  19 files changed, 2558 insertions(+), 2 deletions(-)
>  create mode 100644 docs/specs/acad.rst
>  create mode 100644 docs/specs/battery.rst
>  create mode 100644 docs/specs/button.rst
>  create mode 100644 hw/acpi/acad.c
>  create mode 100644 hw/acpi/battery.c
>  create mode 100644 hw/acpi/button.c
>  create mode 100644 include/hw/acpi/acad.h
>  create mode 100644 include/hw/acpi/battery.h
>  create mode 100644 include/hw/acpi/button.h
>=20


