Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38810C48297
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Feb 2024 15:58:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYTGM-00083N-2b; Fri, 09 Feb 2024 10:58:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1rYTG8-00082W-MI; Fri, 09 Feb 2024 10:57:48 -0500
Received: from mail-lj1-x232.google.com ([2a00:1450:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1rYTG6-0005TY-Dq; Fri, 09 Feb 2024 10:57:48 -0500
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2d09faadba5so14796261fa.1; 
 Fri, 09 Feb 2024 07:57:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707494264; x=1708099064; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+uB20R0AyDDqns9d5Ga8ls5CPJE4Ka4SwwQZgTP9t7o=;
 b=ba8eNsXFe6M6RaawctwL7zd5ZVLQWNltUOOpIrhKJ5kT3PKGiarBHcpeFPOYR9MJMa
 gQBEN1KYcY1OglNVwKlpE2BYlTaN8e6VtkSeh73krsu0hEa1n6WFkSYeqyqznqZhHp3s
 r6Eg1YjdQqqlYp4UEESNULHe44vqxM7+OQsHkFzI1qdqwePjO1cotKci7AVU6Ih10c/U
 gBu2KYUKZdp+q+73LBcNb6dTbiUe7+H2TEvpXGdD46+iVqsrKrXKawmF74yICJSp73UI
 nZMpsCRuy9FhoD+lXrUYYfIEGrlR34BBw5FRk1pzLbnoilFVR0KPF+MLMlSvAu7GWOfz
 oA4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707494264; x=1708099064;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+uB20R0AyDDqns9d5Ga8ls5CPJE4Ka4SwwQZgTP9t7o=;
 b=qkMvlLq1fx1En5fPxrdZdhxs3J6Cd4xhcJpXjQaOK5h+PaDF6kK+Rc9rIIJ15xPL6w
 R+mmQb9lGoGvNQRRnq4tN++V+1Cl5IMs/J1pVA2eFcEWRYGOSo3pbj4y91aezuUcpgR7
 PFo0dhNXtssvjdZTyMjk0SCoU9F7zx4fGAGBZjUKEelxYe54UCTvlIFcD4xx7Qj5B1IM
 EuEX0nYHUZ1zStaq7SPq+sr5qOBbU0oWJ12lvih3GPKjQlnPdmQqmY/tNb8elT13XWoZ
 sI1hSgXSk1okmlox0nLYpzjaA/Vw93XIKukpmSGOECetfVOW2DtqGBgVl1kQ+Z/FydZZ
 T4iA==
X-Gm-Message-State: AOJu0YybiDiptevSK17mTjhVIqjOltb1aBf+jJpKwFrYiXsHtNdG51rR
 p4T8hTYs6pIVuxEVhhhsnblRiUqv/gQK+ZWf9tAxymKU4W0B7HoJ
X-Google-Smtp-Source: AGHT+IGXAVO/nyk3xwGLKPF3yug7JmW0vBZctQ8RXfJcxZH8ljEG+Qt24goK44/C/WHbXVoxSOISfw==
X-Received: by 2002:a05:6512:32bc:b0:511:6d75:f114 with SMTP id
 q28-20020a05651232bc00b005116d75f114mr1631693lfe.65.1707494263469; 
 Fri, 09 Feb 2024 07:57:43 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCVAXjMRAdowO528Mea0b3Jts2oj8SGU2pJrFVNP/wZRCL6xWriLHU+4g/K+oyKLKakJM5zK9tIjWP07JzVMwjjGQ8FAoHemlIoub3F/rUk1TV/zxi24YGVlNXnmCnLRplcYHR1Z/IVv4P4QYc73kAJ8Q9+Tbghs/yoxF6ACze5IxY9YcW2msGBFe6iFCWripCDRR9O7hKn61ErUoFkW0BTGKkicyMwXnRKXkwEpi7VLeGGYM7Qb13v8aKNp8NV09hyMvomv/OuFNKY6aNfwPYvBMXygLyiCuoJk5xeRJj6Ow4pivJ+/NipERKyNulwZVNmG8YEQYhGMti/wVLAJ3WCVk4PTMNAfUoUFxoZCCC3Q5GxsQZrTYucN6hrDGV6/hvf6FbqG+ApmntBROpExHpGVbiSdgwqKu4kHSHiEMrEAQ6u6FbhA6oOVilDiiv7Uzjxil31YztbS/jhQfJ5H0jq7spOfzuKuU054OPmJ/OIHFhNllHVYl2iCh4zi40hYeXm6roefZcWSrKAexsbEIxu3oR8bmOIo8Q++nq9VkOjyxU2vFj1Nv3G6E4SbqI69bZFjvCvJMWDr/xctwwg6SKguQoeE/YPfRz5rtXb1N/r48zF5l/H1biB4FmxGaXGJH6DosF5jRrKEZXpQd9jm5A3PLOT7Z29hi0L9Qz+shBWkYH02PjVWFImREROl1j43iS0Y
Received: from ?IPv6:::1?
 (p200300faaf1724007ccdd0ba9e70da1e.dip0.t-ipconnect.de.
 [2003:fa:af17:2400:7ccd:d0ba:9e70:da1e])
 by smtp.gmail.com with ESMTPSA id
 fm8-20020a05600c0c0800b0040ef718cf81sm1134586wmb.28.2024.02.09.07.57.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Feb 2024 07:57:43 -0800 (PST)
Date: Fri, 09 Feb 2024 15:57:42 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
CC: =?ISO-8859-1?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 Laurent Vivier <laurent@vivier.eu>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 qemu-block@nongnu.org, John Snow <jsnow@redhat.com>, qemu-ppc@nongnu.org,
 Eduardo Habkost <eduardo@habkost.net>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Thomas Huth <thuth@redhat.com>, Alexander Graf <agraf@csgraf.de>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?ISO-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>,
 Luc Michel <luc.michel@amd.com>, Zhao Liu <zhao1.liu@linux.intel.com>,
 Gustavo Romero <gustavo.romero@linaro.org>
Subject: Re: [RFC PATCH 0/7] hw/qdev: Split 'wiring' phase from 'realize'
In-Reply-To: <20240209123226.32576-1-philmd@linaro.org>
References: <20240209123226.32576-1-philmd@linaro.org>
Message-ID: <035D5DEC-A762-4AE9-BBBE-410B66EC0BE6@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::232;
 envelope-from=shentey@gmail.com; helo=mail-lj1-x232.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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



Am 9=2E Februar 2024 12:32:18 UTC schrieb "Philippe Mathieu-Daud=C3=A9" <p=
hilmd@linaro=2Eorg>:
>Hi,
>
>Various issues related to implementing dynamic machines have
>been documented in [1]=2E
>
>We are trying to understand what means "a qdev is realized"=2E
>One explanation was "the device is guest visible"; however
>many devices are realized before being mapped, thus are not
>"guest visible"=2E Some devices map / wire their IRQs before
>being realized (such ISA devices)=2E There is a need for devices
>to be "automatically" mapped/wired (see [2]) such CLI-created
>devices, but this apply generically to dynamic machines=2E
>
>Currently the device creation steps are expected to roughly be:
>
>  (external use)                (QDev core)                   (Device Imp=
l)
>   ~~~~~~~~~~~~                  ~~~~~~~~~                     ~~~~~~~~~~=
~
>
>                               INIT enter
>                   ----->
>                         +----------------------+
>                         |    Allocate state    |
>                         +----------------------+
>                                                 ----->
>                                                        +----------------=
-----+
>                                                        | INIT children  =
     |
>                                                        |                =
     |
>                                                        | Alias children =
properties
>                                                        |                =
     |
>                                                        | Expose properti=
es   |
>                                INIT exit               +----------------=
-----+
>                   <-----------------------------------
> +----------------+
> | set properties |
> |                |
> | set ClkIn      |
> +----------------+          REALIZE enter
>                   ---------------------------------->
>                                                       +-----------------=
-----+
>                                                       | Use config prope=
rties|
>                                                       |                 =
     |
>                                                       | Realize children=
     |
>                                                       |                 =
     |
>                                                       | Init GPIOs/IRQs =
     |
>                                                       |                 =
     |
>                                                       | Init MemoryRegio=
ns   |
>                                                       +-----------------=
-----+
>                               REALIZE exit
>                   <-----------------------------------                  =
      ----  "realized" / "guest visible"
>+-----------------+
>| Explicit wiring:|
>|   IRQs          |
>|   I/O / Mem     |
>|   ClkOut        |
>+-----------------+             RESET enter
>                    --------------------------------->
>                                                       +-----------------=
-----+
>                                                       | Reset default va=
lues |
>                                                       +-----------------=
-----+
>
>But as mentioned, various devices "wire" parts before they exit
>the "realize" step=2E
>In order to clarify, I'm trying to enforce what can be done
>*before* and *after* realization=2E
>
>*after* a device is expected to be stable (no more configurable)
>and fully usable=2E
>
>To be able to use internal/auto wiring (such ISA devices) and
>keep the current external/explicit wiring, I propose to add an
>extra "internal wiring" step, happening after the REALIZE step
>as:
>
>  (external use)                (QDev core)                   (Device Imp=
l)
>   ~~~~~~~~~~~~                  ~~~~~~~~~                     ~~~~~~~~~~=
~
>
>                               INIT enter
>                   ----->
>                         +----------------------+
>                         |    Allocate state    |
>                         +----------------------+
>                                                 ----->
>                                                        +----------------=
-----+
>                                                        | INIT children  =
     |
>                                                        |                =
     |
>                                                        | Alias children =
properties
>                                                        |                =
     |
>                                                        | Expose properti=
es   |
>                                INIT exit               +----------------=
-----+
>                   <-----------------------------------
> +----------------+
> | set properties |
> |                |
> | set ClkIn      |
> +----------------+          REALIZE enter
>                   ---------------------------------->
>                                                       +-----------------=
-----+
>                                                       | Use config prope=
rties|
>                                                       |                 =
     |
>                                                       | Realize children=
     |
>                                                       |                 =
     |
>                                                       | Init GPIOs/IRQs =
     |
>                                                       |                 =
     |
>                                                       | Init MemoryRegio=
ns   |
>                                                       +-----------------=
-----+
>                               REALIZE exit       <---
>                         +----------------------+
>                         | Internal auto wiring |
>                         |   IRQs               |  (i=2Ee=2E ISA bus)
>                         |   I/O / Mem          |
>                         |   ClkOut             |
>                         +----------------------+
>                    <---                                                 =
      ----  "realized"
>+-----------------+
>| External wiring:|
>|   IRQs          |
>|   I/O / Mem     |
>|   ClkOut        |
>+-----------------+             RESET enter                              =
      ----  "guest visible"
>                    --------------------------------->
>                                                       +-----------------=
-----+
>                                                       | Reset default va=
lues |
>                                                       +-----------------=
-----+
>
>The "realized" point is not changed=2E "guest visible" concept only
>occurs *after* wiring, just before the reset phase=2E
>
>This series introduces the DeviceClass::wire handler within qdev
>core realization code, and convert devices using the implicit
>wiring to using that explicit handler=2E
>
>QDev API assertions patches will be posted later as another series=2E
>
>Thoughts?

Hi Phil,

What exactly are you trying to achieve? I assume that the goal is to make =
devices user-creatable which currently can't due to current limitations=2E =
For this I'm presenting an idea:

I'd probably not force the new discipline onto devices which aren't user-c=
reatable -- that seems like too much gymnastics to me for no gain=2E Instea=
d, I'd act on the suggestion of having an interface TYPE_USER_CREATABLE and=
 put the wire method there=2E

This wire method would be responsible for performing *all* duties between =
the states "realized" and "guest-visible"=2E Based on the parameters it is =
given by the user, it would find all resources it needs to wire up the devi=
ce=2E It finds these resources by e=2Eg=2E scanning the QOM tree=2E A good =
practice would be to pass the root node for the scanning as parameter, e=2E=
g=2E the current machine=2E

It could happen that a user-crrated device depends on another user-created=
 device=2E To make this work, the part of QEMU that deals with user-created=
 devices would perform a fixed point iteration over all not yet finished us=
er-created devices=2E When there is no progress within one iteration, QEMU =
aborts with an error message=2E This error message could come from the `wir=
e` invocation of any -- or even better -- all not yet finished devices=2E

To demonstrate the approach, one could probably pick just one device, add =
the interface and hack up something in the core handling of user-created de=
vices=2E

Does this idea sound reasonable? Is this what you're ultimately after?

Best regards,
Bernhatd

>
>Regards,
>
>Phil=2E
>
>[1] https://lore=2Ekernel=2Eorg/all/87o7d1i7ky=2Efsf@pond=2Esub=2Eorg/
>[2] https://lore=2Ekernel=2Eorg/qemu-devel/20231127052024=2E435743-1-gust=
avo=2Eromero@linaro=2Eorg/
>
>Cc: Eduardo Habkost <eduardo@habkost=2Enet>
>Cc: Markus Armbruster <armbru@redhat=2Ecom>' --cc '
>Cc: Edgar E=2E Iglesias <edgar=2Eiglesias@gmail=2Ecom>'
>Cc: Richard Henderson <richard=2Ehenderson@linaro=2Eorg>
>Cc: Mark Cave-Ayland <mark=2Ecave-ayland@ilande=2Eco=2Euk>
>Cc: Thomas Huth <thuth@redhat=2Ecom>
>Cc: Paolo Bonzini <pbonzini@redhat=2Ecom>
>Cc: Alexander Graf <agraf@csgraf=2Ede>
>Cc: Bernhard Beschow <shentey@gmail=2Ecom>
>Cc: Stefan Hajnoczi <stefanha@redhat=2Ecom>
>Cc: Peter Maydell <peter=2Emaydell@linaro=2Eorg>
>Cc: C=C3=A9dric Le Goater <clg@kaod=2Eorg>
>Cc: Luc Michel <luc=2Emichel@amd=2Ecom>
>Cc: Zhao Liu <zhao1=2Eliu@linux=2Eintel=2Ecom>
>Cc: Gustavo Romero <gustavo=2Eromero@linaro=2Eorg>
>
>Philippe Mathieu-Daud=C3=A9 (7):
>  hw/qdev: Introduce DeviceClass::[un]wire() handlers
>  hw/input/pckbd: Connect i8042 GPIOs once mouse/keyboard are realized
>  hw/ide/cmd646: Configure IDE bus IRQs after realization
>  hw/ide/sii3112: Configure IDE bus IRQs after realization
>  hw/ide/via: Configure IDE bus IRQs after realization
>  hw/intc/mips_gic: Initialize IRQ array once device is realized
>  hw/misc/mac_via: Have VIA1 child access parent IRQ once realized
>
> include/hw/qdev-core=2Eh |  8 +++++++-
> hw/core/qdev=2Ec         | 21 ++++++++++++++++++++-
> hw/ide/cmd646=2Ec        | 12 +++++++++++-
> hw/ide/sii3112=2Ec       | 10 ++++++++++
> hw/ide/via=2Ec           | 10 ++++++++++
> hw/input/pckbd=2Ec       | 38 +++++++++++++++++++++++++++-----------
> hw/intc/mips_gic=2Ec     | 11 +++++++++--
> hw/misc/mac_via=2Ec      |  9 ++++++++-
> 8 files changed, 102 insertions(+), 17 deletions(-)
>

