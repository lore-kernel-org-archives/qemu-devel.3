Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61472C48BC4
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 20:06:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcWNE-0003P6-1J; Tue, 20 Feb 2024 15:05:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1rcWNC-0003MK-2o
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 15:05:50 -0500
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1rcWNA-0005U5-AH
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 15:05:49 -0500
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a3e4765c86eso395219866b.0
 for <qemu-devel@nongnu.org>; Tue, 20 Feb 2024 12:05:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708459547; x=1709064347; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r98N5zsHeg7bpGOE7jvPIcOtsan2X5N4hBuZ3wvt2Cw=;
 b=f4M6uCJzhPKPk+8P6vKuT7irs+EGQ2RQodcOEBD3zzyLc0mAvV/o2fJvLDiXqYiTTN
 nRtoKs1hqnTvQZJn14tjn5jeE/oFRM8goBh+Mxm9osCnODPadHBbSQurU9TUzxWr1AuM
 T4cKeygh4vjYkmH1rk2juXuBuiFXxpWAJueDpzA7ZNXiP0h42UdeMJGodHnkDgs24nZW
 S3fTwLK/UY7bJ/tTvRBa8JnAXKzS+mBtfTf+bSrSq3PtJlQvAOeixhiTxoSuN/ocAkAf
 +MKuh7fYElWOexerZpGfIufvMl68VzS8uEkeIeJWHswjcfv2xmcN477ajicHkSuwf31L
 JpYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708459547; x=1709064347;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r98N5zsHeg7bpGOE7jvPIcOtsan2X5N4hBuZ3wvt2Cw=;
 b=j3okV9MpFdavqGc4B+xCG59sLh/LhVl6sBJTIWvZ7c2iguiI0DSHAh7y2yEUaWep+w
 mdv5PydVm6Q0p0uPsB5BNjJknYAQBtB2H9z1VUJDRqdk+5iO9A9bHtW1rgxFXouu2YGC
 rISaSrhXAPkAeOu9zZLd8YplgFuqGb/wAR0Sb9ziyReVxVf1+KpInszmyVDrF9Ln7+uW
 s5AyiCgdSMfkgCkxmzuQ87Crb9hKShXjvF9/kq+jJCIoFaIZzFN/YwyV4ErOVGGZIQk2
 /X+xKhYZ3JYSaHmlsXj6NDvbY9RlZp/Lscog89u8MEpsGwPuG398pch2ZZLDlUSp3rJG
 p4RA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUTAxJNsZ+SrktPOkd4KlOdl6s9YppMNhyzAmzK9hcQy3aa6SByOCquqsenso3oAjAVyxZJgHtvmMzCa++vTyMpABUGcEA=
X-Gm-Message-State: AOJu0Yyo8ghjNMWaTbQMoJY6si9polJTEWFv7cxmhvYkmPgL6IOM2Mh0
 /V+CTJ95Q2C0ELkUQni1p3d8FsQwzPXmtx3imMJ+MdgFuA1Jld1j
X-Google-Smtp-Source: AGHT+IHvSIlqRGSKV+/GjfZCrCrj7GNtmuo0nADpjG/8Fj1w5iNMvvtBt36XXr8W/otv6331NFbjKQ==
X-Received: by 2002:a17:906:6686:b0:a3e:9709:4b67 with SMTP id
 z6-20020a170906668600b00a3e97094b67mr4848079ejo.22.1708459546685; 
 Tue, 20 Feb 2024 12:05:46 -0800 (PST)
Received: from [127.0.0.1] (dynamic-089-014-092-079.89.14.pool.telefonica.de.
 [89.14.92.79]) by smtp.gmail.com with ESMTPSA id
 k9-20020a1709063fc900b00a3cfd838f32sm4328214ejj.178.2024.02.20.12.05.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Feb 2024 12:05:46 -0800 (PST)
Date: Tue, 20 Feb 2024 19:25:27 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
CC: "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>,
 BALATON Zoltan <balaton@eik.bme.hu>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_06/14=5D_hw/pci-bridge=3A_Extrac?=
 =?US-ASCII?Q?t_QOM_ICH_definitions_to_=27ich=5Fdmi=5Fpci=2Eh=27?=
In-Reply-To: <20240219163855.87326-7-philmd@linaro.org>
References: <20240219163855.87326-1-philmd@linaro.org>
 <20240219163855.87326-7-philmd@linaro.org>
Message-ID: <C977DC8F-8731-4ED4-8FFC-85241ABED160@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x62f.google.com
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



Am 19=2E Februar 2024 16:38:46 UTC schrieb "Philippe Mathieu-Daud=C3=A9" <=
philmd@linaro=2Eorg>:
>Expose TYPE_ICH_DMI_PCI_BRIDGE to the new
>"hw/pci-bridge/ich_dmi_pci=2Eh" header=2E
>
>Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro=2Eorg>
>---
> MAINTAINERS                         |  1 +
> include/hw/pci-bridge/ich_dmi_pci=2Eh | 20 ++++++++++++++++++++
> include/hw/southbridge/ich9=2Eh       |  2 --
> hw/pci-bridge/i82801b11=2Ec           | 11 ++++-------
> 4 files changed, 25 insertions(+), 9 deletions(-)
> create mode 100644 include/hw/pci-bridge/ich_dmi_pci=2Eh
>
>diff --git a/MAINTAINERS b/MAINTAINERS
>index 1b210c5cc1=2E=2E50507c3dd6 100644
>--- a/MAINTAINERS
>+++ b/MAINTAINERS
>@@ -2609,6 +2609,7 @@ F: hw/acpi/ich9*=2Ec
> F: hw/i2c/smbus_ich9=2Ec
> F: hw/isa/lpc_ich9=2Ec
> F: include/hw/acpi/ich9*=2Eh
>+F: include/hw/pci-bridge/ich_dmi_pci=2Eh
> F: include/hw/southbridge/ich9=2Eh
>=20
> PIIX4 South Bridge (i82371AB)
>diff --git a/include/hw/pci-bridge/ich_dmi_pci=2Eh b/include/hw/pci-bridg=
e/ich_dmi_pci=2Eh
>new file mode 100644
>index 0000000000=2E=2E7623b32b8e
>--- /dev/null
>+++ b/include/hw/pci-bridge/ich_dmi_pci=2Eh

Shouldn't we name the new header like its source file, i=2Ee=2E i82801b11=
=2Eh?

>@@ -0,0 +1,20 @@
>+/*
>+ * QEMU ICH4 i82801b11 dmi-to-pci Bridge Emulation
>+ *
>+ * SPDX-License-Identifier: GPL-2=2E0-or-later
>+ */
>+
>+#ifndef HW_PCI_BRIDGE_ICH_D2P_H
>+#define HW_PCI_BRIDGE_ICH_D2P_H
>+
>+#include "qom/object=2Eh"
>+#include "hw/pci/pci_bridge=2Eh"
>+
>+#define TYPE_ICH_DMI_PCI_BRIDGE "i82801b11-bridge"
>+OBJECT_DECLARE_SIMPLE_TYPE(I82801b11Bridge, ICH_DMI_PCI_BRIDGE)
>+
>+struct I82801b11Bridge {
>+    PCIBridge parent_obj;
>+};
>+
>+#endif
>diff --git a/include/hw/southbridge/ich9=2Eh b/include/hw/southbridge/ich=
9=2Eh
>index bee522a4cf=2E=2Eb2abf483e0 100644
>--- a/include/hw/southbridge/ich9=2Eh
>+++ b/include/hw/southbridge/ich9=2Eh
>@@ -114,8 +114,6 @@ struct ICH9LPCState {
>=20
> #define ICH9_D2P_SECONDARY_DEFAULT              (256 - 8)
>=20
>-#define ICH9_D2P_A2_REVISION                    0x92
>-
> /* D31:F0 LPC Processor Interface */
> #define ICH9_RST_CNT_IOPORT                     0xCF9
>=20
>diff --git a/hw/pci-bridge/i82801b11=2Ec b/hw/pci-bridge/i82801b11=2Ec
>index c140919cbc=2E=2Edd17e35b0a 100644
>--- a/hw/pci-bridge/i82801b11=2Ec
>+++ b/hw/pci-bridge/i82801b11=2Ec
>@@ -45,7 +45,7 @@
> #include "hw/pci/pci_bridge=2Eh"
> #include "migration/vmstate=2Eh"
> #include "qemu/module=2Eh"
>-#include "hw/southbridge/ich9=2Eh"
>+#include "hw/pci-bridge/ich_dmi_pci=2Eh"
>=20
> /***********************************************************************=
******/
> /* ICH9 DMI-to-PCI bridge */
>@@ -53,11 +53,8 @@
> #define I82801ba_SSVID_SVID     0
> #define I82801ba_SSVID_SSID     0
>=20
>-typedef struct I82801b11Bridge {
>-    /*< private >*/
>-    PCIBridge parent_obj;
>-    /*< public >*/
>-} I82801b11Bridge;
>+
>+#define ICH9_D2P_A2_REVISION                    0x92
>=20
> static void i82801b11_bridge_realize(PCIDevice *d, Error **errp)
> {
>@@ -103,7 +100,7 @@ static void i82801b11_bridge_class_init(ObjectClass *=
klass, void *data)
> }
>=20
> static const TypeInfo i82801b11_bridge_info =3D {
>-    =2Ename          =3D "i82801b11-bridge",
>+    =2Ename          =3D TYPE_ICH_DMI_PCI_BRIDGE,
>     =2Eparent        =3D TYPE_PCI_BRIDGE,
>     =2Einstance_size =3D sizeof(I82801b11Bridge),
>     =2Eclass_init    =3D i82801b11_bridge_class_init,

