Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E465FC4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2024 08:52:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwI4d-00007J-BL; Mon, 15 Apr 2024 04:52:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1rwI4b-00006R-Ib; Mon, 15 Apr 2024 04:52:21 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1rwI4Z-00032a-MK; Mon, 15 Apr 2024 04:52:21 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a523524e5baso334236066b.3; 
 Mon, 15 Apr 2024 01:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713171137; x=1713775937; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WlwEbuBnPTwkbYIObk+FEeTP3OlrkRLzF7+OAThsGAs=;
 b=XO78S2rhSMSe4W66xssTl6/+8IcUw328xRvdbRg5EhTQPYrrFosbMdjdD2azOCGRzz
 x7N5T7mL5TkS/d/l3OWtQILaKd5AvIqKZycVOMuriEFfPUd4gZ+eC2FFobzZQIJfmjWw
 9OFCdy1JaZOg+Mo9POMwWuZlKMoUtMrv3SGcCVILx8s2cCbdbWIK45uzaj5uKIs0nsec
 dy9rl35dAT9TXjqbOXfaUho3lpj78sbrjaeabsj+FKL+Cv0tFaOYsiPoag6WTv21hfsI
 a70B7FZN1fighKVim/scYe6W+LE/pPZh2KUjh2ZjsrvlUiZ5gKlICafGDC0TBIzR4rF7
 RL6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713171137; x=1713775937;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WlwEbuBnPTwkbYIObk+FEeTP3OlrkRLzF7+OAThsGAs=;
 b=I4b0ytpLhEijp99V2LgJ8MoZIdMd9gdPCI0r0wnwD2tJBVD9kbU+xNslc/AHwfygYb
 XvyaQy+l5l4MBYesGjauGNqUn0Ba1G2GGNZB3YCJdhCqFrfKuIeYLGo6xSaPJJVVyYiJ
 Gj38gYDyoums5Y+niGmK5kw3b4noqRV5S1HmVxjT2VFtjiqaYNyvKFsUTK+ztuZqYsBM
 ZwnsslMvAELI1ijsnS2PlII+K0p6N3N+L9LBGILSFxSziAXxBj6/CauktSb/qE7OVZYY
 isrLOx15NIXtAiKIAai1xq2Hv/6i1Kut+5k8B93pS9nLWR3JC1IZxb2MphX9vDWn12hP
 SniQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWbQ5mPX84qM5aYXBD3TLq1pri4IaWN2j3DjXi0SgKR2N8MRIKQawe0v2WuHGEvLhEyB+PpMG0IYvX29mqgEfAtsTjf7v/XZQh2Ln3S1zbkc8yvg1Ht6A5a50FwDw==
X-Gm-Message-State: AOJu0YyP5wutmAF46vtCVdkaFlIKagU+rkC5JZhLjpbNrBxUThArJfHn
 pG3sAxjyf90xgk/77Z081YyDX1ukxSDSrOkFmLIJ2Kdn3ylqLD+X
X-Google-Smtp-Source: AGHT+IHgxc8dQIxPxHQDNlTubhbaKJumZmGB+DUoJD71gyY+Oogs9D76Pqp45QmfV2p+I8+jBUWS1Q==
X-Received: by 2002:a17:906:f0ce:b0:a52:4363:b028 with SMTP id
 dk14-20020a170906f0ce00b00a524363b028mr4917168ejb.29.1713171137090; 
 Mon, 15 Apr 2024 01:52:17 -0700 (PDT)
Received: from [127.0.0.1] (business-90-187-110-129.pool2.vodafone-ip.de.
 [90.187.110.129]) by smtp.gmail.com with ESMTPSA id
 j15-20020a170906254f00b00a54c12de34dsm270467ejb.188.2024.04.15.01.52.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Apr 2024 01:52:16 -0700 (PDT)
Date: Mon, 15 Apr 2024 08:05:42 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
CC: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, Ani Sinha <anisinha@redhat.com>,
 qemu-block@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, John Snow <jsnow@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: Re: [PATCH v2 11/15] hw/southbridge/ich9: Add a AHCI function
In-Reply-To: <20240226111416.39217-12-philmd@linaro.org>
References: <20240226111416.39217-1-philmd@linaro.org>
 <20240226111416.39217-12-philmd@linaro.org>
Message-ID: <E3144A4C-E0F8-4E39-A791-576E0D017FBF@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x635.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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



Am 26=2E Februar 2024 11:14:10 UTC schrieb "Philippe Mathieu-Daud=C3=A9" <=
philmd@linaro=2Eorg>:
>Instantiate TYPE_ICH9_AHCI in TYPE_ICH9_SOUTHBRIDGE=2E
>
>Since the PC machines can disable SATA (see the
>PC_MACHINE_SATA dynamic property), add the 'sata-enabled'
>property to disable it=2E
>
>Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro=2Eorg>
>---
> MAINTAINERS                   |  2 ++
> include/hw/southbridge/ich9=2Eh |  4 ----
> hw/i386/pc_q35=2Ec              | 21 +++------------------
> hw/southbridge/ich9=2Ec         | 35 +++++++++++++++++++++++++++++++++++
> hw/i386/Kconfig               |  1 -
> hw/southbridge/Kconfig        |  1 +
> 6 files changed, 41 insertions(+), 23 deletions(-)
>
>diff --git a/MAINTAINERS b/MAINTAINERS
>index 4576339053=2E=2E7d1b3e0d99 100644
>--- a/MAINTAINERS
>+++ b/MAINTAINERS
>@@ -2615,10 +2615,12 @@ M: Marcel Apfelbaum <marcel=2Eapfelbaum@gmail=2Ec=
om>
> S: Supported
> F: hw/acpi/ich9*=2Ec
> F: hw/i2c/smbus_ich9=2Ec
>+F: hw/ide/ich9_ahci=2Ec
> F: hw/isa/lpc_ich9=2Ec
> F: hw/southbridge/ich9=2Ec
> F: include/hw/acpi/ich9*=2Eh
> F: include/hw/i2c/ich9_smbus=2Eh
>+F: include/hw/ide/ahci-pci=2Eh
> F: include/hw/pci-bridge/ich9_dmi=2Eh
> F: include/hw/southbridge/ich9=2Eh
>=20
>diff --git a/include/hw/southbridge/ich9=2Eh b/include/hw/southbridge/ich=
9=2Eh
>index b9122d299d=2E=2Eac7f9f4ff5 100644
>--- a/include/hw/southbridge/ich9=2Eh
>+++ b/include/hw/southbridge/ich9=2Eh
>@@ -166,10 +166,6 @@ struct ICH9LPCState {
>=20
> #define ICH9_GPIO_GSI "gsi"
>=20
>-/* D31:F2 SATA Controller #1 */
>-#define ICH9_SATA1_DEV                          31
>-#define ICH9_SATA1_FUNC                         2
>-
> /* D31:F0 power management I/O registers
>    offset from the address ICH9_LPC_PMBASE */
>=20
>diff --git a/hw/i386/pc_q35=2Ec b/hw/i386/pc_q35=2Ec
>index f951cf1e3a=2E=2E6903719b97 100644
>--- a/hw/i386/pc_q35=2Ec
>+++ b/hw/i386/pc_q35=2Ec
>@@ -60,9 +60,6 @@
> #include "hw/i386/acpi-build=2Eh"
> #include "target/i386/cpu=2Eh"
>=20
>-/* ICH9 AHCI has 6 ports */
>-#define MAX_SATA_PORTS     6
>-
> struct ehci_companions {
>     const char *name;
>     int func;
>@@ -134,7 +131,6 @@ static void pc_q35_init(MachineState *machine)
>     ISABus *isa_bus;
>     int i;
>     ram_addr_t lowmem;
>-    DriveInfo *hd[MAX_SATA_PORTS];
>     MachineClass *mc =3D MACHINE_GET_CLASS(machine);
>     bool acpi_pcihp;
>     bool keep_pci_slot_hpc;
>@@ -227,6 +223,7 @@ static void pc_q35_init(MachineState *machine)
>     object_property_set_link(OBJECT(ich9), "mch-pcie-bus",
>                              OBJECT(pcms->pcibus), &error_abort);
>     qdev_prop_set_bit(ich9, "d2p-enabled", false);
>+    qdev_prop_set_bit(ich9, "sata-enabled", pcms->sata_enabled);
>     qdev_realize_and_unref(ich9, NULL, &error_fatal);
>=20
>     /* create ISA bus */
>@@ -287,20 +284,8 @@ static void pc_q35_init(MachineState *machine)
>                          0xff0104);
>=20
>     if (pcms->sata_enabled) {
>-        PCIDevice *pdev;
>-        AHCIPCIState *ich9;

The ahci include and perhaps all ide includes can be removed here=2E

Any plans for a v3?

Best regards,
Bernhard

>-
>-        /* ahci and SATA device, for q35 1 ahci controller is built-in *=
/
>-        pdev =3D pci_create_simple_multifunction(pcms->pcibus,
>-                                               PCI_DEVFN(ICH9_SATA1_DEV,
>-                                                         ICH9_SATA1_FUNC=
),
>-                                               "ich9-ahci");
>-        ich9 =3D ICH9_AHCI(pdev);
>-        pcms->idebus[0] =3D qdev_get_child_bus(DEVICE(pdev), "ide=2E0");
>-        pcms->idebus[1] =3D qdev_get_child_bus(DEVICE(pdev), "ide=2E1");
>-        g_assert(MAX_SATA_PORTS =3D=3D ich9->ahci=2Eports);
>-        ide_drive_get(hd, ich9->ahci=2Eports);
>-        ahci_ide_create_devs(&ich9->ahci, hd);
>+        pcms->idebus[0] =3D qdev_get_child_bus(ich9, "ide=2E0");
>+        pcms->idebus[1] =3D qdev_get_child_bus(ich9, "ide=2E1");
>     }
>=20
>     if (machine_usb(machine)) {
>diff --git a/hw/southbridge/ich9=2Ec b/hw/southbridge/ich9=2Ec
>index 8c4356ff74=2E=2E37255bb941 100644
>--- a/hw/southbridge/ich9=2Ec
>+++ b/hw/southbridge/ich9=2Ec
>@@ -13,22 +13,30 @@
> #include "hw/southbridge/ich9=2Eh"
> #include "hw/pci/pci=2Eh"
> #include "hw/pci-bridge/ich9_dmi=2Eh"
>+#include "hw/ide/ahci-pci=2Eh"
>+#include "hw/ide/ide-dev=2Eh"
>=20
> #define ICH9_D2P_DEVFN          PCI_DEVFN(30, 0)
>+#define ICH9_SATA1_DEVFN        PCI_DEVFN(31, 2)
>+
>+#define SATA_PORTS              6
>=20
> struct ICH9State {
>     DeviceState parent_obj;
>=20
>     I82801b11Bridge d2p;
>+    AHCIPCIState sata0;
>=20
>     PCIBus *pci_bus;
>     bool d2p_enabled;
>+    bool sata_enabled;
> };
>=20
> static Property ich9_props[] =3D {
>     DEFINE_PROP_LINK("mch-pcie-bus", ICH9State, pci_bus,
>                      TYPE_PCIE_BUS, PCIBus *),
>     DEFINE_PROP_BOOL("d2p-enabled", ICH9State, d2p_enabled, true),
>+    DEFINE_PROP_BOOL("sata-enabled", ICH9State, sata_enabled, true),
>     DEFINE_PROP_END_OF_LIST(),
> };
>=20
>@@ -52,6 +60,29 @@ static bool ich9_realize_d2p(ICH9State *s, Error **err=
p)
>     return true;
> }
>=20
>+static bool ich9_realize_sata(ICH9State *s, Error **errp)
>+{
>+    DriveInfo *hd[SATA_PORTS];
>+
>+    object_initialize_child(OBJECT(s), "sata[0]", &s->sata0, TYPE_ICH9_A=
HCI);
>+    qdev_prop_set_int32(DEVICE(&s->sata0), "addr", ICH9_SATA1_DEVFN);
>+    if (!qdev_realize(DEVICE(&s->sata0), BUS(s->pci_bus), errp)) {
>+        return false;
>+    }
>+    for (unsigned i =3D 0; i < SATA_PORTS; i++) {
>+        g_autofree char *portname =3D g_strdup_printf("ide=2E%u", i);
>+
>+        object_property_add_alias(OBJECT(s), portname,
>+                                  OBJECT(&s->sata0), portname);
>+    }
>+
>+    g_assert(SATA_PORTS =3D=3D s->sata0=2Eahci=2Eports);
>+    ide_drive_get(hd, s->sata0=2Eahci=2Eports);
>+    ahci_ide_create_devs(&s->sata0=2Eahci, hd);
>+
>+    return true;
>+}
>+
> static void ich9_realize(DeviceState *dev, Error **errp)
> {
>     ICH9State *s =3D ICH9_SOUTHBRIDGE(dev);
>@@ -64,6 +95,10 @@ static void ich9_realize(DeviceState *dev, Error **err=
p)
>     if (s->d2p_enabled && !ich9_realize_d2p(s, errp)) {
>         return;
>     }
>+
>+    if (s->sata_enabled && !ich9_realize_sata(s, errp)) {
>+        return;
>+    }
> }
>=20
> static void ich9_class_init(ObjectClass *klass, void *data)
>diff --git a/hw/i386/Kconfig b/hw/i386/Kconfig
>index d21638f4f9=2E=2E226d7f6916 100644
>--- a/hw/i386/Kconfig
>+++ b/hw/i386/Kconfig
>@@ -101,7 +101,6 @@ config Q35
>     select PCI_EXPRESS_Q35
>     select ICH9
>     select LPC_ICH9
>-    select AHCI_ICH9
>     select DIMM
>     select SMBIOS
>     select FW_CFG_DMA
>diff --git a/hw/southbridge/Kconfig b/hw/southbridge/Kconfig
>index db7259bf6f=2E=2Ef806033d48 100644
>--- a/hw/southbridge/Kconfig
>+++ b/hw/southbridge/Kconfig
>@@ -4,3 +4,4 @@ config ICH9
>     bool
>     depends on PCI_EXPRESS
>     imply I82801B11
>+    select AHCI_ICH9

