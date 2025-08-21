Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D389CA0EFA
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Aug 2025 18:05:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1up9dr-0005qP-Hl; Thu, 21 Aug 2025 14:04:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonid.bloch@gmail.com>)
 id 1up9dm-0005p8-5N
 for qemu-devel@nongnu.org; Thu, 21 Aug 2025 14:03:59 -0400
Received: from mail-lj1-x234.google.com ([2a00:1450:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <leonid.bloch@gmail.com>)
 id 1up9dP-0005Zp-44
 for qemu-devel@nongnu.org; Thu, 21 Aug 2025 14:03:37 -0400
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-333f8d387d6so10516561fa.0
 for <qemu-devel@nongnu.org>; Thu, 21 Aug 2025 11:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755799411; x=1756404211; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6MHdGjyNcinG2AOkCVSTzUQhO+CCMptub2oU8fqB4sE=;
 b=bnEsxetaPAGbQjwyNgjdQJc7Xe5xcyCtSUJ9qn+YAmdUraR4qFoV13Egw5SUcfls62
 wYo2UJ8rXnaC9GeuV3NC2rRr1Oby3fgvOSjxSvk0mzuJi9yXS7gat1RtKkmXRe6hWc36
 MIM6aFHke/HKAhQ7KunKIWPb09CC8+Cw7LYLcx6CPAQ2FmOnuSeeF6h+wOEplGYoM+y3
 KGpN4XBgD1+S1fdESEW9iSuf3szEHUHa+CkQ0rYuYOp56Ya6qACT/6Pf0YU7tFfR8106
 9ZC0ZjSW8/T7Wb07juQ2LBMVn2cNf7BqfLJHYsUbKSEII3kMIxwU9Q0XqzE5dwItZqzd
 HhMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755799411; x=1756404211;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6MHdGjyNcinG2AOkCVSTzUQhO+CCMptub2oU8fqB4sE=;
 b=R2FFQdObo+L2FnthovBTgGE+LrlnmfYHeZuol5BymeA6rXtnMV7FBoAYVuGzonHmtp
 z99xaoASI4CgGUcWBgZY5iW+FlSkDxYEJBdLx1YDxLj030a5YqqF4cEzcoIgjBc3KgqZ
 EAc+aOlOV4YmowiSrKwJAKsWWAFTSIbA37FM8n5GYNJZ93hsHPp+5zelAbyYSlwjK9R3
 GdlBwyjpBh2dBjTOVMgxo6LuxqGx/sV534eXt3xkkWyhLmXK7NK1xUUWGPvmUbjx151C
 Npc46sBS9djEDoAttl1wJmCXC11sVR02TASrOiYJHoZmPqkL5+UponrPcfxcLoYDFDg+
 3Kow==
X-Gm-Message-State: AOJu0Yxp/h7hwsTtAp7IYlc3Z5iC5Scdij/fg0u0gWld1p9VyP2i+F3l
 5qSJ+jJmNYNre6oZURDSIDOb7pTs6oLJB2qBkaee8bU8oF3q6l6hMogjotsl51/y+R/9vUMIvRp
 GerEDFbIBGCWlN8Q9Igyz8XCe97xjb18=
X-Gm-Gg: ASbGncsLsO3Uu+dSBo7BMQDu2/hOsx6Saz2DH5tuIhuOLRYIzE30le+Cl+3TcjV6Mxo
 oC8jZXnzFoFZD3DjYiQmdrKB10x9RdEboloPtZ5DI1Y2BJ0Bgbbf76uouTk6eYAaiOH6HvIfcsj
 NEBeZA5SabyHi2S8tjEDJStHXyf+C1u93f5MDarReQ/rGpTtpW7bZuhflQ+br5QtMtB7y6OD6QU
 H1egaNyHy7BGp5JK+Q=
X-Google-Smtp-Source: AGHT+IGHDWRK3ykX9qJL7SHXZcJ/G8AwLbLtQhEXrjtfS8DfqkDJQAP5cUvmQ4IbaZf5R2LcVi9pcPBVWCpR+5o2+Yw=
X-Received: by 2002:a2e:a9a0:0:b0:335:25e4:25ed with SMTP id
 38308e7fff4ca-33650fefd15mr30481fa.22.1755799410420; Thu, 21 Aug 2025
 11:03:30 -0700 (PDT)
MIME-Version: 1.0
References: <20250821174554.40607-1-lb.workbox@gmail.com>
In-Reply-To: <20250821174554.40607-1-lb.workbox@gmail.com>
From: Leonid Bloch <lb.workbox@gmail.com>
Date: Thu, 21 Aug 2025 21:03:18 +0300
X-Gm-Features: Ac12FXxOvGLEhCE_z9Hl0K3upnrjnrw3or6kFjgSXPzzq-n-0ZyA-s8USlibFsc
Message-ID: <CAOwCge3YPh-0iwrCZ3rFneTGqp9HM9FLRJ8NmPqxjagEbj7Tug@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] Introduce a battery, AC adapter, and lid button
To: "Michael S . Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Eduardo Habkost <ehabkost@redhat.com>, Eric Blake <eblake@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Dmitry Fleytman <dmitry.fleytman@gmail.com>
Cc: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="00000000000027b007063ce3e8c9"
Received-SPF: pass client-ip=2a00:1450:4864:20::234;
 envelope-from=leonid.bloch@gmail.com; helo=mail-lj1-x234.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--00000000000027b007063ce3e8c9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

GitHub PR for ease of review: https://github.com/blochl/qemu/pull/2
Link to v1:
https://lists.gnu.org/archive/html/qemu-devel/2021-01/msg05246.html


On Thu, Aug 21, 2025 at 8:46=E2=80=AFPM Leonid Bloch <lb.workbox@gmail.com>=
 wrote:

> First, I must apologize for the extremely long delay since v1 - it has be=
en
> nearly 4 years, which is unacceptable. Life circumstances intervened.
>
> This series introduces three ACPI devices that are particularly useful
> for laptop/mobile virtualization:
>
> * Battery
> * AC adapter
> * Laptop lid button
>
> Changes in v2:
> --------------
> Based on the feedback from Philippe Mathieu-Daud=C3=A9 and Michael S. Tsi=
rkin:
>
> * Complete redesign with dual-mode operation:
>   - QMP control mode (default): Devices are controlled via QMP commands,
>     providing deterministic behavior essential for migration and CI/testi=
ng
>   - Host mirroring mode (opt-in): Original sysfs/procfs monitoring
> behavior,
>     now disabled by default
>
> * Migrated to modern QEMU ACPI architecture:
>   - Devices now implement ACPI_DEV_AML_IF interface
>   - AML generation moved from centralized acpi-build.c to device files
>
> * Added a QMP interface:
>   - battery-set-state/query-battery
>   - ac-adapter-set-state/query-ac-adapter
>   - lid-button-set-state/query-lid-button
>
> * Documentation improvements:
>   - Converted to .rst format
>   - Added examples for both QMP and "fake" sysfs/procfs testing
>
> The dual-mode design ensures these devices are migration-safe and
> deterministic by default, while still allowing host state mirroring
> when explicitly requested for desktop use cases.
>
> Use cases:
> ----------
> 1. Testing: CI systems can programmatically control power states
> 2. Cloud: Expose virtual battery for usage-based resource limiting
> 3. Desktop virtualization: Mirror host laptop state to guest (opt-in)
> 4. Development: Test power management without physical hardware
>
> Example usage:
> --------------
> # Default QMP-controlled battery
> qemu-system-x86_64 -device battery
>
> # Mirror host battery
> qemu-system-x86_64 -device battery,use-qmp=3Dfalse,enable-sysfs=3Dtrue
>
> # Control via QMP
> {"execute": "battery-set-state",
>  "arguments": {"state": {"present": true, "charging": false,
>                          "discharging": true, "charge-percent": 42,
>                          "rate": 500}}}
>
> The series has been tested with Windows and Linux guests, correctly
> showing battery status, AC adapter state, and lid button events in
> guest UIs and triggering appropriate power management actions.
>
> Thanks again for your patience and feedback.
> Leonid.
>
> Leonid Bloch (4):
>   hw/acpi: Increase the number of possible ACPI interrupts
>   hw/acpi: Introduce the QEMU Battery
>   hw/acpi: Introduce the QEMU AC adapter
>   hw/acpi: Introduce the QEMU lid button
>
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
>
> --
> 2.50.1
>
>

--00000000000027b007063ce3e8c9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">GitHub PR for ease of review:=C2=A0<a href=3D"https://gith=
ub.com/blochl/qemu/pull/2">https://github.com/blochl/qemu/pull/2</a><div>Li=
nk to v1:=C2=A0<a href=3D"https://lists.gnu.org/archive/html/qemu-devel/202=
1-01/msg05246.html">https://lists.gnu.org/archive/html/qemu-devel/2021-01/m=
sg05246.html</a></div></div><br><br><div class=3D"gmail_quote gmail_quote_c=
ontainer"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Aug 21, 2025 at 8:4=
6=E2=80=AFPM Leonid Bloch &lt;<a href=3D"mailto:lb.workbox@gmail.com">lb.wo=
rkbox@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pad=
ding-left:1ex">First, I must apologize for the extremely long delay since v=
1 - it has been<br>
nearly 4 years, which is unacceptable. Life circumstances intervened.<br>
<br>
This series introduces three ACPI devices that are particularly useful<br>
for laptop/mobile virtualization:<br>
<br>
* Battery<br>
* AC adapter<br>
* Laptop lid button<br>
<br>
Changes in v2:<br>
--------------<br>
Based on the feedback from Philippe Mathieu-Daud=C3=A9 and Michael S. Tsirk=
in:<br>
<br>
* Complete redesign with dual-mode operation:<br>
=C2=A0 - QMP control mode (default): Devices are controlled via QMP command=
s,<br>
=C2=A0 =C2=A0 providing deterministic behavior essential for migration and =
CI/testing<br>
=C2=A0 - Host mirroring mode (opt-in): Original sysfs/procfs monitoring beh=
avior,<br>
=C2=A0 =C2=A0 now disabled by default<br>
<br>
* Migrated to modern QEMU ACPI architecture:<br>
=C2=A0 - Devices now implement ACPI_DEV_AML_IF interface<br>
=C2=A0 - AML generation moved from centralized acpi-build.c to device files=
<br>
<br>
* Added a QMP interface:<br>
=C2=A0 - battery-set-state/query-battery<br>
=C2=A0 - ac-adapter-set-state/query-ac-adapter<br>
=C2=A0 - lid-button-set-state/query-lid-button<br>
<br>
* Documentation improvements:<br>
=C2=A0 - Converted to .rst format<br>
=C2=A0 - Added examples for both QMP and &quot;fake&quot; sysfs/procfs test=
ing<br>
<br>
The dual-mode design ensures these devices are migration-safe and<br>
deterministic by default, while still allowing host state mirroring<br>
when explicitly requested for desktop use cases.<br>
<br>
Use cases:<br>
----------<br>
1. Testing: CI systems can programmatically control power states<br>
2. Cloud: Expose virtual battery for usage-based resource limiting<br>
3. Desktop virtualization: Mirror host laptop state to guest (opt-in)<br>
4. Development: Test power management without physical hardware<br>
<br>
Example usage:<br>
--------------<br>
# Default QMP-controlled battery<br>
qemu-system-x86_64 -device battery<br>
<br>
# Mirror host battery<br>
qemu-system-x86_64 -device battery,use-qmp=3Dfalse,enable-sysfs=3Dtrue<br>
<br>
# Control via QMP<br>
{&quot;execute&quot;: &quot;battery-set-state&quot;,<br>
=C2=A0&quot;arguments&quot;: {&quot;state&quot;: {&quot;present&quot;: true=
, &quot;charging&quot;: false,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0&quot;discharging&quot;: true, &quot;charge-percent&quot;:=
 42,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0&quot;rate&quot;: 500}}}<br>
<br>
The series has been tested with Windows and Linux guests, correctly<br>
showing battery status, AC adapter state, and lid button events in<br>
guest UIs and triggering appropriate power management actions.<br>
<br>
Thanks again for your patience and feedback.<br>
Leonid.<br>
<br>
Leonid Bloch (4):<br>
=C2=A0 hw/acpi: Increase the number of possible ACPI interrupts<br>
=C2=A0 hw/acpi: Introduce the QEMU Battery<br>
=C2=A0 hw/acpi: Introduce the QEMU AC adapter<br>
=C2=A0 hw/acpi: Introduce the QEMU lid button<br>
<br>
=C2=A0MAINTAINERS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 18 +<br>
=C2=A0docs/specs/acad.rst=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 | 195 +++++++<br>
=C2=A0docs/specs/battery.rst=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0| 225 ++++++++<br>
=C2=A0docs/specs/button.rst=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 | 189 +++++++<br>
=C2=A0docs/specs/index.rst=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0|=C2=A0 =C2=A03 +<br>
=C2=A0hw/acpi/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 12 +<br>
=C2=A0hw/acpi/acad.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 447 ++++++++++++++++<br>
=C2=A0hw/acpi/battery.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 | 735 +++++++++++++++++++++++++++<br>
=C2=A0hw/acpi/button.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0| 438 ++++++++++++++++<br>
=C2=A0hw/acpi/core.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 17 +-<br>
=C2=A0hw/acpi/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 |=C2=A0 =C2=A03 +<br>
=C2=A0hw/acpi/trace-events=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0|=C2=A0 15 +<br>
=C2=A0hw/i386/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A03 +<br>
=C2=A0hw/i386/acpi-build.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0|=C2=A0 =C2=A01 +<br>
=C2=A0include/hw/acpi/acad.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0|=C2=A0 27 +<br>
=C2=A0include/hw/acpi/acpi_dev_interface.h |=C2=A0 =C2=A03 +<br>
=C2=A0include/hw/acpi/battery.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 33 ++<br>
=C2=A0include/hw/acpi/button.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0|=C2=A0 25 +<br>
=C2=A0qapi/acpi.json=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 171 +++++++<br>
=C2=A019 files changed, 2558 insertions(+), 2 deletions(-)<br>
=C2=A0create mode 100644 docs/specs/acad.rst<br>
=C2=A0create mode 100644 docs/specs/battery.rst<br>
=C2=A0create mode 100644 docs/specs/button.rst<br>
=C2=A0create mode 100644 hw/acpi/acad.c<br>
=C2=A0create mode 100644 hw/acpi/battery.c<br>
=C2=A0create mode 100644 hw/acpi/button.c<br>
=C2=A0create mode 100644 include/hw/acpi/acad.h<br>
=C2=A0create mode 100644 include/hw/acpi/battery.h<br>
=C2=A0create mode 100644 include/hw/acpi/button.h<br>
<br>
-- <br>
2.50.1<br>
<br>
</blockquote></div>

--00000000000027b007063ce3e8c9--

