Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F77FC982ED
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 17:34:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8htf-0002D0-MY; Mon, 21 Sep 2026 13:33:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1x8htS-0002CV-7k
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 13:33:36 -0400
Received: from mail-wr2-x0f.google.com ([2a00:1450:4864:30::f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1x8htP-00047G-Vo
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 13:33:29 -0400
Received: by mail-wr2-x0f.google.com with SMTP id
 ffacd0b85a97d-4885d4825adso518616f8f.0
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2026 10:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790012002; x=1790616802; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id
 :references:in-reply-to:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Q5BkokiD1WMb+OUgUY9HkDsoC3azTentMvmSLuV66dY=;
 b=bgnmHNRVT3GainDP0GClelVLbpinYtygH6feuyJ32oiIoiws4cOcxCBhqTwg6yBn8n
 drhugx/ANnQEDl03OxFxO1C6LCTBSwuhCnMDNOQNRw5QxJzkhuAMGj9nbVFsrbqAm/FK
 WGR33VCGhsTPPeyLtuX6fTn7Sqp1+rT1+gDaweZfDpmxVlcxwMAFRQz3/1gnPRssyYBE
 FsJW4AYoKJFXeWubPgjMIlVD+wwMgOIatZOfeQ0ssRpLBDDOZPLHXOWbkmdHBDjDQZV1
 RZYuAdRa6M2Cv7LYKSTfQ01DeZUyc6XsVbjcd1/DpKXAAHZYA/ADY700Lli2lsBEQyps
 Ge1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790012002; x=1790616802;
 h=content-transfer-encoding:content-type:mime-version:message-id
 :references:in-reply-to:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Q5BkokiD1WMb+OUgUY9HkDsoC3azTentMvmSLuV66dY=;
 b=PyNrcsn3RfRDvVCofjmnaZOCJ5SszckEhUPyy0VEUwGZZ62D/nqBC2XbKYYtt/X3/7
 SeDefSgdaBcBTAD1YyknnZ5JrDqEFEiIcBYA2rHrJCPmqESrLrnaoWblcIHGsfBv73GC
 OGiLfL0Sj6exwdVAe7v175ZKjOQV8V1psq12pRqBXYS1QVzaDjr067hmug1Kogaq0sP7
 5AG7GGrHfnK4wGa4sgN6BbQ6FkKpHRG5kpsth3mZoxpuDLOs2vn5q3ZB39tcgQQNiKOK
 UakDCZtkbbVrFnBilTs6I9nq9HLq360RliuF+PVc/BJATdK6FrfHAn73/jlWxJLitVkF
 Pavw==
X-Forwarded-Encrypted: i=1;
 AKwUvByb6xloLoUdCiAuXWZuj7mdYpvfh07K0Tmch6XUkKI9g/5i13op+oYM5hsOG2junlBWr/oc3pIojYNl@nongnu.org
X-Gm-Message-State: AFuF++lL9YTWSXF0ER/jFd11me7pelHIOhdbzTdpxs+nsZi0I1Zhq1gV
 gr7Japbj6e5SgvTtKk+gRif03HHQ2LG+4yefAPQVvR8bone6CeAKX5jX1N+kBQ==
X-Gm-Gg: AYBFou3XmZyjUXhDqA+IS+3jM6R+oMQhjf/LRoLdWdtkQUmhEH/dQbWqcjTupcWz8Mi
 pkUQcGIx2sp9R6QwxB12gqrKP3QM0EsISKkfETHHN1jaseoYWNLaCddcDICGIT2Amy/A6imnB/6
 STYW4viKnBEjZm/7TRsm6b486iOpx7J1PVky2fAw6+XQZMtD+rFaNAyCjZK3emN+dIwJJQYnvp9
 32d4SgnibxK0tluY0XmW8vmM7iaPn6mhJZzuTXBZJQr/YlAYlD2ZW6b2EnnPe/2guLOLzHg9N28
 eZkDqIjnD0A1cPFNZ8nu5NVb7AxSrnwyh1EWX/7gMzd5TUzjWWtNhpqTbD+kmWtmqL9dDitt1BT
 oxqCTwZdP+54smzlAo3llNDGopu/uQA6f4T8VNa4rtbMYRTg/MIqNJ+vFA0VzTPVz2hRBD0YVA5
 RwZ33+k8+tl3x0VG2a7BEIO1mVLGG+q83OFRgbuYfi5I35VoVwCVbEHqnc80Nw7lpLv0QqbPwd/
 Rru
X-Received: by 2002:a05:6000:41c9:b0:485:ac96:7273 with SMTP id
 ffacd0b85a97d-4871e213211mr16068424f8f.10.1790012001943; 
 Mon, 21 Sep 2026 10:33:21 -0700 (PDT)
Received: from ehlo.thunderbird.net ([62.214.191.67])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-487244225f2sm25871801f8f.3.2026.09.21.10.33.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Sep 2026 10:33:21 -0700 (PDT)
Date: Mon, 21 Sep 2026 17:32:21 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org, Bin Meng <bin.meng@processmission.com>,
 QEMU <qemu-devel@nongnu.org>
CC: =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>,
 Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2_06/10=5D_hw/sd=3A_sdhci=3A_?=
 =?US-ASCII?Q?Honor_i=2EMX_uSDHC_vendor_clock_gates?=
In-Reply-To: <20260904161438.3838261-7-bin.meng@processmission.com>
References: <20260904161438.3838261-1-bin.meng@processmission.com>
 <20260904161438.3838261-7-bin.meng@processmission.com>
Message-ID: <5F11A2B8-4459-4621-8CDB-CEEE85D83F96@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:30::f;
 envelope-from=shentey@gmail.com; helo=mail-wr2-x0f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



Am 4=2E September 2026 16:14:29 UTC schrieb Bin Meng <bin=2Emeng@processmi=
ssion=2Ecom>:
>U-Boot's i=2EMX uSDHC driver enables IPGEN, HCKEN, PEREN and CKEN in
>VEND_SPEC rather than the standard SDHCI clock-control fields=2E QEMU
>only checks the standard fields before issuing a command=2E It therefore
>silently drops U-Boot's MMC commands even though the controller clocks
>are enabled=2E U-Boot eventually times out waiting for command completion
>and cannot load the kernel and device tree from the SD card=2E
>
>Accept the complete vendor clock-gate set as another valid clock source
>for i=2EMX uSDHC=2E Also report SDSTB when the vendor IP and host clocks
>are enabled, matching the state U-Boot polls while changing the clock=2E
>
>Keep this behavior behind an i=2EMX uSDHC quirk because the shared eSDHC
>paths also serve controllers which use the standard SDHCI fields=2E
>
>Reference: IMX6ULRM (Rev 2), section 56=2E8=2E10, 56=2E8=2E12 and 56=2E8=
=2E26
>https://www=2Enxp=2Ecom/webapp/Download?colCode=3DIMX6ULRM
>
>Signed-off-by: Bin Meng <bin=2Emeng@processmission=2Ecom>
>Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@oss=2Equalcomm=2Ecom>
>
>---
>
>Changes in v2:
>- rebase on top of the microchip polarfire soc series
>
> include/hw/sd/sdhci=2Eh |  7 ++++++-
> hw/sd/sdhci=2Ec         | 27 ++++++++++++++++++++++++---
> 2 files changed, 30 insertions(+), 4 deletions(-)
>
>diff --git a/include/hw/sd/sdhci=2Eh b/include/hw/sd/sdhci=2Eh
>index 2d03e37653=2E=2E83d465774b 100644
>--- a/include/hw/sd/sdhci=2Eh
>+++ b/include/hw/sd/sdhci=2Eh
>@@ -112,7 +112,12 @@ typedef struct SDHCIState SDHCIState;
>  * Controller does not provide transfer-complete interrupt when not
>  * busy=2E
>  */
>-#define SDHCI_QUIRK_NO_BUSY_IRQ    BIT(0)
>+#define SDHCI_QUIRK_NO_BUSY_IRQ          BIT(0)
>+/*
>+ * Controller uses vendor-specific clock gates in place of the standard
>+ * SDHCI clock-control fields
>+ */
>+#define SDHCI_QUIRK_CLOCKS_IN_VENDOR     BIT(1)
>=20
> #define TYPE_PCI_SDHCI "sdhci-pci"
> DECLARE_INSTANCE_CHECKER(SDHCIState, PCI_SDHCI,
>diff --git a/hw/sd/sdhci=2Ec b/hw/sd/sdhci=2Ec
>index 14c312a691=2E=2Eb6e447a805 100644
>--- a/hw/sd/sdhci=2Ec
>+++ b/hw/sd/sdhci=2Ec
>@@ -1107,9 +1107,11 @@ static void sdhci_data_transfer(SDHCIState *s)
>     }
> }
>=20
>+static bool sdhci_clocks_on(SDHCIState *s);
>+
> static bool sdhci_can_issue_command(SDHCIState *s)
> {
>-    if (!SDHC_CLOCK_IS_ON(s->clkcon) ||
>+    if (!sdhci_clocks_on(s) ||
>         (((s->prnsts & SDHC_DATA_INHIBIT) || s->stopped_state) &&
>         ((s->cmdreg & SDHC_CMD_DATA_PRESENT) ||
>         ((s->cmdreg & SDHC_CMD_RESPONSE) =3D=3D SDHC_CMD_RSP_WITH_BUSY &=
&
>@@ -1810,6 +1812,10 @@ static void sdhci_bus_class_init(ObjectClass *klas=
s, const void *data)
>=20
> #define ESDHC_VENDOR_SPEC               0xc0
> #define ESDHC_FRC_SDCLK_ON              (1 << 8)
>+#define ESDHC_VENDOR_IPGEN              (1 << 11)
>+#define ESDHC_VENDOR_HCKEN              (1 << 12)
>+#define ESDHC_VENDOR_PEREN              (1 << 13)
>+#define ESDHC_VENDOR_CKEN               (1 << 14)
>=20
> #define ESDHC_DLL_CTRL                  0x60
>=20
>@@ -1826,6 +1832,16 @@ static void sdhci_bus_class_init(ObjectClass *klas=
s, const void *data)
> #define ESDHC_PRNSTS_SDSTB              (1 << 3)
> #define ESDHC_PRNSTS_CLOCK_GATE_OFF     BIT(7)
>=20
>+static bool sdhci_clocks_on(SDHCIState *s)
>+{
>+    uint32_t vendor_clocks =3D ESDHC_VENDOR_IPGEN | ESDHC_VENDOR_HCKEN |
>+                             ESDHC_VENDOR_PEREN | ESDHC_VENDOR_CKEN;
>+
>+    return SDHC_CLOCK_IS_ON(s->clkcon) ||
>+           ((s->quirks & SDHCI_QUIRK_CLOCKS_IN_VENDOR) &&
>+            (s->vendor_spec & vendor_clocks) =3D=3D vendor_clocks);
>+}
>+

Rather than accumulating vendor-specific quirks in generic code, can we no=
t remap in device-specific "virtual" methods such as usdhc_{read,write}?

Best regards,
Bernhard

> static uint64_t esdhc_read(void *opaque, hwaddr offset, unsigned size)
> {
>     SDHCIState *s =3D SYSBUS_SDHCI(opaque);
>@@ -1861,7 +1877,11 @@ static uint64_t esdhc_read(void *opaque, hwaddr of=
fset, unsigned size)
>     case SDHC_PRNSTS:
>         /* Add SDSTB (SD Clock Stable) bit to PRNSTS */
>         ret =3D sdhci_read(opaque, offset, size) & ~ESDHC_PRNSTS_SDSTB;
>-        if (s->clkcon & SDHC_CLOCK_INT_STABLE) {
>+        if ((s->clkcon & SDHC_CLOCK_INT_STABLE) ||
>+            ((s->quirks & SDHCI_QUIRK_CLOCKS_IN_VENDOR) &&
>+             (s->vendor_spec & (ESDHC_VENDOR_IPGEN |
>+                                ESDHC_VENDOR_HCKEN)) =3D=3D
>+             (ESDHC_VENDOR_IPGEN | ESDHC_VENDOR_HCKEN))) {
>             ret |=3D ESDHC_PRNSTS_SDSTB;
>         }
>         break;
>@@ -2120,7 +2140,8 @@ static void imx_usdhc_init(Object *obj)
>     DeviceState *dev =3D DEVICE(obj);
>=20
>     s->io_ops =3D &usdhc_mmio_ops;
>-    s->quirks =3D SDHCI_QUIRK_NO_BUSY_IRQ;
>+    s->quirks =3D SDHCI_QUIRK_NO_BUSY_IRQ |
>+                SDHCI_QUIRK_CLOCKS_IN_VENDOR;
>     qdev_prop_set_uint8(dev, "sd-spec-version", 3);
> }
>=20

