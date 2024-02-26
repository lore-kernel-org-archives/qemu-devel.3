Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB0EAC48BF6
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 22:52:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rejpd-00052w-BL; Mon, 26 Feb 2024 17:52:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1rejpc-00052k-7O; Mon, 26 Feb 2024 17:52:20 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1rejpa-0008RC-F3; Mon, 26 Feb 2024 17:52:19 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3392b045e0aso3077762f8f.2; 
 Mon, 26 Feb 2024 14:52:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708987936; x=1709592736; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f64sCN1crQnikz14pqK3CJQ0dA85B3Apeta5LNXnrjI=;
 b=Z1XLDvgrjtFpChcnzNvTYnanOb3Lx+KvYvhYYxvRny/OqI6JzRvJq9THnNFBWKLXIB
 6dtSqzd7dEZ1os6VnRynlTW3Kk+DqmvYYdR5O/yq68Fl9MtTRMAYtja9XdI+Cri1iipJ
 uoLfpp4vb864s1zqzoVHi3bcn7JRXIShR7jtWwgpkxmGRyeCf+LW5LXI3u9JS+OVSgil
 8FcSraeWJ/0U6DqDALMvvMG0Hv8v/vdJdNP9HzgIHBLD+4baS+TfSQE2XdX1klTOoW48
 lxVP4+L2uqK1uyqsiYFji2H5Y1GITM7sx6VQlEhhXXMt+sC3Nm5n6gju0+Avf5MV98hI
 y0KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708987936; x=1709592736;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=f64sCN1crQnikz14pqK3CJQ0dA85B3Apeta5LNXnrjI=;
 b=ahdadBRX/6n2GttFqak03as4oq0eAE5pi78aUEo1FnKhGslivDUuBzl0Ts1P6iBZFf
 TKEzJ7RwPPp8OBAS2ihdhQMZY+s/Cwwdbs+qidzZbQpGUp9UQyzS/m2S3DuK+ZZE9aF8
 0eBbRnhX+PLRecO5ImlFmIXDohbVFQqb6YwB0V3z4OT2oXOifDlCpGRENFwRkrlGjbM5
 T+5cjLj2DQItqhlEwW8P57IXeAMqCnP4OecIQqm5MdCC1CElTav5P/qtVTjpEcp42s3+
 Jsjxk6OEZnGO9nHatxvZkXt+PFedZqxqH5vYZTOQPiB/IdBRTr523VeP8nR8lW9Mwkpq
 3adA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUsoqLRj36auQbJt2zEAipQS0fU3OJmLeuoQzPPUXtXg0fBsa9AZ3hEMVMH+z0xTBt/RB+PVnNd1eh5Ug0B/NG4AlLHTPttLYNFYmCYazXTVTKCmDfa2WifYc/Wrg==
X-Gm-Message-State: AOJu0YxibuJimNXmQ5TTRdZ/KIK6eVqdcFp/eZQDTytDXYrHD/NNfxA1
 N+EjaFMl95cn4TWfkf5CAkFOKseTpjd/tLbNJBX1F3xRupDD6ZEr
X-Google-Smtp-Source: AGHT+IExO1UhmhHf0Gfbp9rJyD+gQUGeMmHT1UBy5gaMi0wqu39qYNcOraUi/FG0+ptzur7GzSyROA==
X-Received: by 2002:a5d:64ec:0:b0:33d:c707:d18c with SMTP id
 g12-20020a5d64ec000000b0033dc707d18cmr5093463wri.42.1708987936211; 
 Mon, 26 Feb 2024 14:52:16 -0800 (PST)
Received: from [127.0.0.1] (dynamic-077-188-008-186.77.188.pool.telefonica.de.
 [77.188.8.186]) by smtp.gmail.com with ESMTPSA id
 w10-20020adff9ca000000b0033d1b760125sm9566960wrr.92.2024.02.26.14.52.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Feb 2024 14:52:15 -0800 (PST)
Date: Mon, 26 Feb 2024 22:52:13 +0000
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
Subject: Re: [PATCH v2 10/15] hw/southbridge/ich9: Add the DMI-to-PCI bridge
In-Reply-To: <20240226111416.39217-11-philmd@linaro.org>
References: <20240226111416.39217-1-philmd@linaro.org>
 <20240226111416.39217-11-philmd@linaro.org>
Message-ID: <3A0F9325-16B9-4E9A-B086-E2831E70F880@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=shentey@gmail.com; helo=mail-wr1-x433.google.com
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



Am 26=2E Februar 2024 11:14:09 UTC schrieb "Philippe Mathieu-Daud=C3=A9" <=
philmd@linaro=2Eorg>:
>Instantiate TYPE_ICH_DMI_PCI_BRIDGE in TYPE_ICH9_SOUTHBRIDGE=2E
>
>Since the Q35 machine doesn't use it, add the 'd2p-enabled'
>property to disable it=2E
>
>Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro=2Eorg>
>---
> include/hw/southbridge/ich9=2Eh |  9 ---------
> hw/i386/pc_q35=2Ec              |  1 +
> hw/southbridge/ich9=2Ec         | 27 +++++++++++++++++++++++++++
> hw/southbridge/Kconfig        |  1 +
> 4 files changed, 29 insertions(+), 9 deletions(-)
>
>diff --git a/include/hw/southbridge/ich9=2Eh b/include/hw/southbridge/ich=
9=2Eh
>index 162ae3baa1=2E=2Eb9122d299d 100644
>--- a/include/hw/southbridge/ich9=2Eh
>+++ b/include/hw/southbridge/ich9=2Eh
>@@ -108,15 +108,6 @@ struct ICH9LPCState {
> #define ICH9_USB_UHCI1_DEV                      29
> #define ICH9_USB_UHCI1_FUNC                     0
>=20
>-/* D30:F0 DMI-to-PCI bridge */
>-#define ICH9_D2P_BRIDGE                         "ICH9 D2P BRIDGE"
>-#define ICH9_D2P_BRIDGE_SAVEVM_VERSION          0
>-
>-#define ICH9_D2P_BRIDGE_DEV                     30
>-#define ICH9_D2P_BRIDGE_FUNC                    0
>-
>-#define ICH9_D2P_SECONDARY_DEFAULT              (256 - 8)
>-
> /* D31:F0 LPC Processor Interface */
> #define ICH9_RST_CNT_IOPORT                     0xCF9
>=20
>diff --git a/hw/i386/pc_q35=2Ec b/hw/i386/pc_q35=2Ec
>index 8c8a2f65b8=2E=2Ef951cf1e3a 100644
>--- a/hw/i386/pc_q35=2Ec
>+++ b/hw/i386/pc_q35=2Ec
>@@ -226,6 +226,7 @@ static void pc_q35_init(MachineState *machine)
>     object_property_add_child(OBJECT(machine), "ich9", OBJECT(ich9));
>     object_property_set_link(OBJECT(ich9), "mch-pcie-bus",
>                              OBJECT(pcms->pcibus), &error_abort);
>+    qdev_prop_set_bit(ich9, "d2p-enabled", false);
>     qdev_realize_and_unref(ich9, NULL, &error_fatal);
>=20
>     /* create ISA bus */
>diff --git a/hw/southbridge/ich9=2Ec b/hw/southbridge/ich9=2Ec
>index f3a9b932ab=2E=2E8c4356ff74 100644
>--- a/hw/southbridge/ich9=2Ec
>+++ b/hw/southbridge/ich9=2Ec
>@@ -12,16 +12,23 @@
> #include "hw/qdev-properties=2Eh"
> #include "hw/southbridge/ich9=2Eh"
> #include "hw/pci/pci=2Eh"
>+#include "hw/pci-bridge/ich9_dmi=2Eh"
>+
>+#define ICH9_D2P_DEVFN          PCI_DEVFN(30, 0)

Something along the lines of ICH9_DMI_PCI_DEVFN seems more clear to me=2E

>=20
> struct ICH9State {
>     DeviceState parent_obj;
>=20
>+    I82801b11Bridge d2p;

Same here and essentially all identifiers and properties with "d2p" in the=
ir name=2E

Best regards,
Bernhard

>+
>     PCIBus *pci_bus;
>+    bool d2p_enabled;
> };
>=20
> static Property ich9_props[] =3D {
>     DEFINE_PROP_LINK("mch-pcie-bus", ICH9State, pci_bus,
>                      TYPE_PCIE_BUS, PCIBus *),
>+    DEFINE_PROP_BOOL("d2p-enabled", ICH9State, d2p_enabled, true),
>     DEFINE_PROP_END_OF_LIST(),
> };
>=20
>@@ -29,6 +36,22 @@ static void ich9_init(Object *obj)
> {
> }
>=20
>+static bool ich9_realize_d2p(ICH9State *s, Error **errp)
>+{
>+    if (!module_object_class_by_name(TYPE_ICH_DMI_PCI_BRIDGE)) {
>+        error_setg(errp, "DMI-to-PCI function not available in this buil=
d");
>+        return false;
>+    }
>+    object_initialize_child(OBJECT(s), "d2p", &s->d2p, TYPE_ICH_DMI_PCI_=
BRIDGE);
>+    qdev_prop_set_int32(DEVICE(&s->d2p), "addr", ICH9_D2P_DEVFN);
>+    if (!qdev_realize(DEVICE(&s->d2p), BUS(s->pci_bus), errp)) {
>+        return false;
>+    }
>+    object_property_add_alias(OBJECT(s), "pci=2E0", OBJECT(&s->d2p), "pc=
i=2E0");
>+
>+    return true;
>+}
>+
> static void ich9_realize(DeviceState *dev, Error **errp)
> {
>     ICH9State *s =3D ICH9_SOUTHBRIDGE(dev);
>@@ -37,6 +60,10 @@ static void ich9_realize(DeviceState *dev, Error **err=
p)
>         error_setg(errp, "'pcie-bus' property must be set");
>         return;
>     }
>+
>+    if (s->d2p_enabled && !ich9_realize_d2p(s, errp)) {
>+        return;
>+    }
> }
>=20
> static void ich9_class_init(ObjectClass *klass, void *data)
>diff --git a/hw/southbridge/Kconfig b/hw/southbridge/Kconfig
>index 852b7f346f=2E=2Edb7259bf6f 100644
>--- a/hw/southbridge/Kconfig
>+++ b/hw/southbridge/Kconfig
>@@ -3,3 +3,4 @@
> config ICH9
>     bool
>     depends on PCI_EXPRESS
>+    imply I82801B11

