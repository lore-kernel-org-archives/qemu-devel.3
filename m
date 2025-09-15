Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CABE5CAC593
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Sep 2025 11:00:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uy6uA-0000iN-89; Mon, 15 Sep 2025 06:57:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1uy6u7-0000iE-Pp
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 06:57:51 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1uy6tx-0003a6-0A
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 06:57:50 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3ea3d3ae48fso651015f8f.1
 for <qemu-devel@nongnu.org>; Mon, 15 Sep 2025 03:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757933851; x=1758538651; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NM9mggGOccMBkzVpZnhUZYZHGdmEP8DhGl+eaqJCFZ8=;
 b=BrLw6YdlOgRncIGiip4phCMg74Xg3C5Sl21yP3nLKQ+HPjED2L/zukfug1bERTFdK3
 U6MSi3FN5575sWIB8eSUgpOAUmiV22wm/Xvp8dGF15BDzMQUbF+2/rU6hPMs/hVYfVMh
 yPTbPTRCx3B1zIF3F31TnU1MeBLj9v6FYWFADoSPkG5PYP/IOQDH2xl7p8IpdMwRYjJp
 41IpsVh9WchZKVSkf2Me12QfQRXMHAEebFs3BdrRoc40ImqP+k9GTmpXmfgPZJgz6YYa
 BEx3VaBxKV0ADHgyK6kE51sahQTiyuZFxb216cOkCcUepNC56ghY0n887S0EkqTK0JIH
 F52Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757933851; x=1758538651;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NM9mggGOccMBkzVpZnhUZYZHGdmEP8DhGl+eaqJCFZ8=;
 b=XpG/reFltmwjmNc8lR3U8KpdZSjSpKhq6XIVY5Td8sN0543ZPb9brim/xLp+0u5OVW
 smu9f6BJ0EI8bZbZNRGiA/m/J0J/9lkjSdNpVGcRvpTqydaZ6ti0dcg8XcxgaM7p6ihq
 ROULnGYFWILm+WignMl2OMZDl4u5iJQqiYFoWCNaizBPw1+79vgeouks8/UJMlhSSUuM
 IEeztgfw3JrKyM70GsPj9IMrhfXzVA1qecDUTQB8RBKboiB8hA2j4WlaCskee6jEAPuh
 HKJA0oMjpxtHisEeRzvhEPfSKxsf6GWx9vXHZXcoPD4WcIlSI3nQdYx4acm33PDgV4f9
 r1Fg==
X-Gm-Message-State: AOJu0Yz2CAy6vlI8Mos0b3BDhvvW51j1q9WAAVrl92v276SNVTSumMz3
 axRqOTg9yCWX8dbDtdospW6tLcRJQvr2KApqn57k9Wx30qRTeY0SeLrKz8xM8Q==
X-Gm-Gg: ASbGnctoa4DYxWCtmTWII08HXcsqALB43HNNHQx0MDKryzydaPcHPQ/W/lf0MA39KV/
 tH7stlDgGWgDyTbwcITcxIe9tTVlSnvvlLigDuv/Gey7blDlx7o6Nm7uPYiNRdimZXtFN00u7gX
 7srmaurfl185REjvHn7oAm8X70qtPJ3fJ+oATulj9M+0Y3cDaHnT64ZlhB1AudhAQxx3/IUcNOr
 +g2QJR9EP4100Cb4pxv+fVvso8geo5A26u3I2Wsi7D3z8homSSVdI8a+qovrEikKMB41XYSQbu0
 6Tp6MQG9x0r8HPOXENktM4U6W1TIITknhCRzfG/yYtMTpFGRVmcJpJAId5jrfNc0m8kNxiJLYkn
 JQMoGHOoGxA6v5VHW1nvUKdgPwIHWadcomu7+KvGO
X-Google-Smtp-Source: AGHT+IFJUWlrWXa6EFxBK490Mg1n+9DtRpIumiwITb0rBWzjalHR8BeoN5GZLiLTqRioyiJsv8XEhg==
X-Received: by 2002:a05:6000:26cb:b0:3e2:e851:7f93 with SMTP id
 ffacd0b85a97d-3e75e0fc32bmr13514800f8f.7.1757933851134; 
 Mon, 15 Sep 2025 03:57:31 -0700 (PDT)
Received: from ehlo.thunderbird.net ([185.238.219.94])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45e0156abecsm174980075e9.4.2025.09.15.03.57.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Sep 2025 03:57:30 -0700 (PDT)
Date: Mon, 15 Sep 2025 10:41:50 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org, Jiaxun Yang <jiaxun.yang@flygoat.com>
CC: Huacai Chen <chenhuacai@kernel.org>,
 =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH 1/5] hw/pci-host/bonito: Implement ICU
In-Reply-To: <20250508-bonito-v1-1-4f9f27733028@flygoat.com>
References: <20250508-bonito-v1-0-4f9f27733028@flygoat.com>
 <20250508-bonito-v1-1-4f9f27733028@flygoat.com>
Message-ID: <1A535D99-E31D-4F69-B70A-B7C5DA82C0E7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=shentey@gmail.com; helo=mail-wr1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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



Am 8=2E Mai 2025 14:46:06 UTC schrieb Jiaxun Yang <jiaxun=2Eyang@flygoat=
=2Ecom>:
>Implement interrupt controller on Bonito north bridge, as well
>as PCI INTx mapping as per Fuloong 2E's hardware connection=2E
>
>pci_bonito_set_irq is renamed to bonito_set_irq to reflect that
>it also sets other IRQs on chip=2E
>
>Signed-off-by: Jiaxun Yang <jiaxun=2Eyang@flygoat=2Ecom>
>---
> hw/pci-host/bonito=2Ec | 96 ++++++++++++++++++++++++++++++--------------=
--------
> 1 file changed, 56 insertions(+), 40 deletions(-)
>
>diff --git a/hw/pci-host/bonito=2Ec b/hw/pci-host/bonito=2Ec
>index 7d6251a78d7e2e26803dd72968ca2ea7adcfe0e5=2E=2Ea599a1db4c068325b8c1a=
a8fb4a45f6b299b581b 100644
>--- a/hw/pci-host/bonito=2Ec
>+++ b/hw/pci-host/bonito=2Ec
>@@ -157,6 +157,22 @@ FIELD(BONGENCFG, PCIQUEUE,      12, 1)
> #define BONITO_INTEN            (0x38 >> 2)      /* 0x138 */
> #define BONITO_INTISR           (0x3c >> 2)      /* 0x13c */
>=20
>+/* ICU Pins */
>+#define ICU_PIN_MBOXx(x)        (0 + (x))
>+#define ICU_PIN_DMARDY          4
>+#define ICU_PIN_DMAEMPTY        5
>+#define ICU_PIN_COPYRDY         6
>+#define ICU_PIN_COPYEMPTY       7
>+#define ICU_PIN_COPYERR         8
>+#define ICU_PIN_PCIIRQ          9
>+#define ICU_PIN_MASTERERR       10
>+#define ICU_PIN_SYSTEMERR       11
>+#define ICU_PIN_DRAMPERR        12
>+#define ICU_PIN_RETRYERR        13
>+#define ICU_PIN_INTTIMER        14
>+#define ICU_PIN_GPIOx(x)        (16 + (x))
>+#define ICU_PIN_GPINx(x)        (25 + (x))
>+
> /* PCI mail boxes */
> #define BONITO_PCIMAIL0_OFFSET    0x40
> #define BONITO_PCIMAIL1_OFFSET    0x44
>@@ -206,6 +222,7 @@ struct PCIBonitoState {
>=20
>     BonitoState *pcihost;
>     uint32_t regs[BONITO_REGS];
>+    uint32_t icu_pin_state;
>=20
>     struct bonldma {
>         uint32_t ldmactrl;
>@@ -242,6 +259,40 @@ struct BonitoState {
> #define TYPE_PCI_BONITO "Bonito"
> OBJECT_DECLARE_SIMPLE_TYPE(PCIBonitoState, PCI_BONITO)
>=20
>+static void bonito_update_irq(PCIBonitoState *s)
>+{
>+    BonitoState *bs =3D s->pcihost;
>+    uint32_t inten =3D s->regs[BONITO_INTEN];
>+    uint32_t intisr =3D s->regs[BONITO_INTISR];
>+    uint32_t intpol =3D s->regs[BONITO_INTPOL];
>+    uint32_t intedge =3D s->regs[BONITO_INTEDGE];
>+    uint32_t pin_state =3D s->icu_pin_state;
>+    uint32_t level, edge;
>+
>+    pin_state =3D (pin_state & ~intpol) | (~pin_state & intpol);
>+
>+    level =3D pin_state & ~intedge;
>+    edge =3D (pin_state & ~intisr) & intedge;
>+
>+    intisr =3D (intisr & intedge) | level;
>+    intisr |=3D edge;
>+    intisr &=3D inten;
>+
>+    s->regs[BONITO_INTISR] =3D intisr;
>+
>+    qemu_set_irq(*bs->pic, !!intisr);
>+}
>+
>+static void bonito_set_irq(void *opaque, int irq, int level)
>+{
>+    BonitoState *bs =3D opaque;
>+    PCIBonitoState *s =3D bs->pci_dev;
>+
>+    s->icu_pin_state =3D deposit32(s->icu_pin_state, irq, 1, !!level);
>+
>+    bonito_update_irq(s);
>+}
>+
> static void bonito_writel(void *opaque, hwaddr addr,
>                           uint64_t val, unsigned size)
> {
>@@ -289,12 +340,12 @@ static void bonito_writel(void *opaque, hwaddr addr=
,
>         }
>         break;
>     case BONITO_INTENSET:
>-        s->regs[BONITO_INTENSET] =3D val;
>         s->regs[BONITO_INTEN] |=3D val;
>+        bonito_update_irq(s);
>         break;
>     case BONITO_INTENCLR:
>-        s->regs[BONITO_INTENCLR] =3D val;
>         s->regs[BONITO_INTEN] &=3D ~val;
>+        bonito_update_irq(s);
>         break;
>     case BONITO_INTEN:
>     case BONITO_INTISR:
>@@ -549,45 +600,10 @@ static const MemoryRegionOps bonito_spciconf_ops =
=3D {
>     =2Eendianness =3D DEVICE_NATIVE_ENDIAN,
> };
>=20
>-#define BONITO_IRQ_BASE 32
>-
>-static void pci_bonito_set_irq(void *opaque, int irq_num, int level)
>-{
>-    BonitoState *s =3D opaque;
>-    qemu_irq *pic =3D s->pic;
>-    PCIBonitoState *bonito_state =3D s->pci_dev;
>-    int internal_irq =3D irq_num - BONITO_IRQ_BASE;
>-
>-    if (bonito_state->regs[BONITO_INTEDGE] & (1 << internal_irq)) {
>-        qemu_irq_pulse(*pic);
>-    } else {   /* level triggered */
>-        if (bonito_state->regs[BONITO_INTPOL] & (1 << internal_irq)) {
>-            qemu_irq_raise(*pic);
>-        } else {
>-            qemu_irq_lower(*pic);
>-        }
>-    }
>-}
>-
>-/* map the original irq (0~3) to bonito irq (16~47, but 16~31 are unused=
) */
> static int pci_bonito_map_irq(PCIDevice *pci_dev, int irq_num)
> {
>-    int slot;
>-
>-    slot =3D PCI_SLOT(pci_dev->devfn);
>-
>-    switch (slot) {
>-    case 5:   /* FULOONG2E_VIA_SLOT, SouthBridge, IDE, USB, ACPI, AC97, =
MC97 */
>-        return irq_num % 4 + BONITO_IRQ_BASE;
>-    case 6:   /* FULOONG2E_ATI_SLOT, VGA */
>-        return 4 + BONITO_IRQ_BASE;
>-    case 7:   /* FULOONG2E_RTL_SLOT, RTL8139 */
>-        return 5 + BONITO_IRQ_BASE;
>-    case 8 =2E=2E=2E 12: /* PCI slot 1 to 4 */
>-        return (slot - 8 + irq_num) + 6 + BONITO_IRQ_BASE;
>-    default:  /* Unknown device, don't do any translation */
>-        return irq_num;
>-    }
>+    /* Fuloong 2E PCI INTX are connected to Bonito GPIN[3:0] */

Given this comment, doesn't this code belong into fuloong2e=2Ec? See https=
://lore=2Ekernel=2Eorg/qemu-devel/20230105154440=2E259361-1-shentey@gmail=
=2Ecom =2E

>+    return ICU_PIN_GPINx(irq_num);

It would then make sense to export this define=2E I can rebase my series, =
or how about incorporating it here? Either way:

Reviewed-by: Bernhard Beschow <shentey@gmail=2Ecom>

> }
>=20
> static void bonito_reset_hold(Object *obj, ResetType type)
>@@ -633,7 +649,7 @@ static void bonito_host_realize(DeviceState *dev, Err=
or **errp)
>=20
>     memory_region_init(&bs->pci_mem, OBJECT(dev), "pci=2Emem", BONITO_PC=
IHI_SIZE);
>     phb->bus =3D pci_register_root_bus(dev, "pci",
>-                                     pci_bonito_set_irq, pci_bonito_map_=
irq,
>+                                     bonito_set_irq, pci_bonito_map_irq,
>                                      dev, &bs->pci_mem, get_system_io(),
>                                      PCI_DEVFN(5, 0), 32, TYPE_PCI_BUS);
>=20
>

