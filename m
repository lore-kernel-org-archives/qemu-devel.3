Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99CA1C982D7
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Sep 2026 14:33:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7w7t-0002is-T7; Sat, 19 Sep 2026 10:33:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1x7w7V-0002gy-0w
 for qemu-devel@nongnu.org; Sat, 19 Sep 2026 10:32:50 -0400
Received: from mail-wr2-x0d.google.com ([2a00:1450:4864:30::d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1x7w7S-0001Sk-6k
 for qemu-devel@nongnu.org; Sat, 19 Sep 2026 10:32:48 -0400
Received: by mail-wr2-x0d.google.com with SMTP id
 ffacd0b85a97d-482f6351831so814826f8f.1
 for <qemu-devel@nongnu.org>; Sat, 19 Sep 2026 07:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789828364; x=1790433164; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id
 :references:in-reply-to:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=jJH94cVmIGehmjThCA6dph6rAPj/vYzBq/NTqRNmw/s=;
 b=sMSMDttFVGX7PziuS5/KXuaXOCZXuKVKL1MpUUh/L+XLDO+cWD8iJ9XTEaA4vx8GO0
 HMRbQcu+2HbgKj6haGAKwm74kwdOVX79brv/cmsv4vyZPcZyMnzw9OUr41q+ETRXtrKV
 3y+Ugprh7hPUsVUbWNtqOwcbfY1gx9ZvxVsuDr8w3BqIYduUoAxYbQcbQqzUIvn6WW45
 oUgFRtlj1hHUVw5VVl5Cmn4881RQLxPpTsHooZiP6+rhjcbArZFo2GclvoDuYDYYkBOb
 cthsmb5j68F+FymxIuDzbUW2HnE/fm8HKxXFEmfk98t6ww0+fkDaIdN1B/8Yw6n/8GTl
 xD0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789828364; x=1790433164;
 h=content-transfer-encoding:content-type:mime-version:message-id
 :references:in-reply-to:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=jJH94cVmIGehmjThCA6dph6rAPj/vYzBq/NTqRNmw/s=;
 b=iVS0xqyvJrzrVuUzVMJ/OLI3RFn9fMkZKS7iIBEyDs3V46rSDZJjItHM816ecfIi+Q
 VXm0NsyzpatXEWHWWltNQtihg9IiYePaxjUolBgQchz3sBMl8pxZ5V+i3m6bverCw2IM
 5QtogJfvgduoLc1hJhM5m4ANhTEL0WRRYpY1SM+pY5AGhOfb9qbrrTFQRHGAa9+qCN9c
 f8/jfSt1sV7Cc0nh3StIS54XJkH+8IT/ZUQMlXIejQ02qdt50DYnHHvkfJfJIrzOWjkZ
 4cQTmLCEeNiJu3hSA3r/v+abajlgWftgbCT832n/TgR0itEtQk/zdoAgK0+cg8X1GMIa
 zPKA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzkQz02l/q0jtP+NSWZprJVGHYvbFw9LrxuukfyMAPP0WrTa9IUMXUbnT0lmJQveP9ulqZF/15Qxo5g@nongnu.org
X-Gm-Message-State: AFuF++nqKjV1HsiAF4DAltL5mpe6TzaL0PE4SRTInnNFFr82RxJ7Oarj
 iREE+70EmRAefY+54A2wWNiQUl5g8V7fE9lgqwSQ03Wp9/CZA8JwwqyyimwRHg==
X-Gm-Gg: AYBFou0KFI70e7NqVOvyL/D0ktmrqRA0dqiHuKjRE1mz99PKgJBO50PO1/CYHFPcBL8
 mGgC2USFu0hLySD8C4AcrEicZ4m0n/rjewWM2tn2o+GOHakAJyQKfAe2C6ePp5G3dEtGG2t/HYz
 5PL0q8J9cQT7LnmBos8HhljncHeMyXozgubUuKDe1eowx2XuYaa2jTZMSYFh5s2f1M/jXayOkFL
 NLwV3cSSNVYMhSxq8FeG2u8x3CIJQgj3Zr9IbYOxwW5gr72nyKpE5DrhQF6OnCMrxFtttyyCyPK
 /YbFk/WbQewoQNR3nDWCvcxt+gZmlDcZnUfWbPTMgTK/rZYz/RilBiqq+TWyHc7G7FK7ZeU5sap
 butsT/7eUOH/v47BtpDyytITkS2LPE9OUnnAcmqvHcOoLBRkzBZeBezABKjeLPBQUo75rBhhAUL
 TZJdEQ0MhLBPJPt28eAX1RstxeRSQq7DcZWHne3kzloYvW9i6fxmHl9bdzX11LXPGTsW2zvqGh6
 0birEAxIqowk6LLE6nwOPFskpWMwL27iK9KeML8KwUDNMhVAjSW+Rc8Vg==
X-Received: by 2002:a05:600c:474c:b0:49e:817a:ca7 with SMTP id
 5b1f17b1804b1-49fc56c3c34mr81901015e9.8.1789828363633; 
 Sat, 19 Sep 2026 07:32:43 -0700 (PDT)
Received: from ehlo.thunderbird.net
 (dynamic-077-011-070-039.77.11.pool.telefonica.de. [77.11.70.39])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fc57547easm119416195e9.3.2026.09.19.07.32.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 19 Sep 2026 07:32:42 -0700 (PDT)
Date: Sat, 19 Sep 2026 14:32:34 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org, Bin Meng <bin.meng@processmission.com>,
 QEMU <qemu-devel@nongnu.org>
CC: Bin Meng <bmeng.cn@gmail.com>,
 =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>,
 qemu-block@nongnu.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2_08/10=5D_hw/sd=3A_sdhci=3A_Sk?=
 =?US-ASCII?Q?ip_SDMA_boundary_stops_for_i=2EMX_uSDHC?=
In-Reply-To: <20260904161438.3838261-9-bin.meng@processmission.com>
References: <20260904161438.3838261-1-bin.meng@processmission.com>
 <20260904161438.3838261-9-bin.meng@processmission.com>
Message-ID: <6F7614BD-BB6D-4F68-B9EA-F762F54B1FB5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:30::d;
 envelope-from=shentey@gmail.com; helo=mail-wr2-x0d.google.com
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



Am 4=2E September 2026 16:14:31 UTC schrieb Bin Meng <bin=2Emeng@processmi=
ssion=2Ecom>:
>The standard SDHCI Block Size register encodes an SDMA buffer boundary
>in bits 14:12=2E The generic model stops at each selected boundary, sets
>the DMA status, and waits for software to rewrite the SDMA system
>address before continuing=2E
>
>Freescale eSDHC and i=2EMX uSDHC instead expose BLKATTR without a
>programmable standard boundary field=2E On both controller families,
>bits 14:13 are reserved and bit 12 is the high bit of the 13-bit
>block-size field=2E Linux masks the standard boundary encoding before
>writing BLKATTR=2E
>
>Despite its name, esdhc_write() is the shared register translation
>helper=2E usdhc_write() delegates common register accesses to it=2E The
>existing translation inserts 0x7 into the generic boundary field so
>the common core sees a 512 KiB boundary=2E
>
>For i=2EMX6UL uSDHC, BLK_ATT bits 15:13 are reserved and bit 12 is
>part of its 13-bit block size=2E DINT reports successful completion of
>the whole internal DMA transfer, not an intermediate boundary pause=2E
>
>U-Boot programs one contiguous DMA address and a block count, then
>waits for both DINT and transfer-complete=2E It never rewrites the addres=
s
>at an intermediate boundary=2E Reads larger than 512 KiB therefore reach
>the synthetic boundary and stall with blocks remaining=2E
>
>The missing field alone does not establish whether every older eSDHC
>has a fixed internal boundary handshake=2E Limit the new quirk to only
>TYPE_IMX_USDHC, where the reference manual, U-Boot behavior, and the
>observed failure agree=2E Existing FSL eSDHC and standard SDHCI behavior
>remain unchanged=2E
>
>Reference: IMX6ULRM (Rev=2E 2), section 56=2E8=2E2 and 56=2E8=2E13
>https://www=2Enxp=2Ecom/webapp/Download?colCode=3DIMX6ULRM
>
>Signed-off-by: Bin Meng <bin=2Emeng@processmission=2Ecom>
>---
>
>(no changes since v1)
>
> include/hw/sd/sdhci=2Eh |  5 +++++
> hw/sd/sdhci=2Ec         | 37 ++++++++++++++++++++++++-------------
> 2 files changed, 29 insertions(+), 13 deletions(-)
>
>diff --git a/include/hw/sd/sdhci=2Eh b/include/hw/sd/sdhci=2Eh
>index 83d465774b=2E=2E6664822398 100644
>--- a/include/hw/sd/sdhci=2Eh
>+++ b/include/hw/sd/sdhci=2Eh
>@@ -118,6 +118,11 @@ typedef struct SDHCIState SDHCIState;
>  * SDHCI clock-control fields
>  */
> #define SDHCI_QUIRK_CLOCKS_IN_VENDOR     BIT(1)
>+/*
>+ * Controller completes contiguous SDMA transfers without the standard
>+ * intermediate buffer-boundary stop and address-update handshake
>+ */
>+#define SDHCI_QUIRK_NO_SDMA_BOUNDARY     BIT(2)
>=20
> #define TYPE_PCI_SDHCI "sdhci-pci"
> DECLARE_INSTANCE_CHECKER(SDHCIState, PCI_SDHCI,
>diff --git a/hw/sd/sdhci=2Ec b/hw/sd/sdhci=2Ec
>index 4d7bbdbe7a=2E=2Ede0883497b 100644
>--- a/hw/sd/sdhci=2Ec
>+++ b/hw/sd/sdhci=2Ec
>@@ -687,12 +687,14 @@ static void sdhci_advance_sdma_address(SDHCIState *=
s, uint32_t bytes)
> /* Multi block SDMA transfer */
> static void sdhci_sdma_transfer_multi_blocks(SDHCIState *s)
> {
>+    bool boundary_enabled =3D
>+        !(s->quirks & SDHCI_QUIRK_NO_SDMA_BOUNDARY);
>     bool page_aligned =3D false;
>     unsigned int begin;
>     const uint16_t block_size =3D s->blksize & BLOCK_SIZE_MASK;
>-    uint32_t boundary_chk =3D 1 << (((s->blksize & ~BLOCK_SIZE_MASK) >> =
12) + 12);
>+    uint32_t boundary_chk =3D 0;
>     uint64_t sdma_address =3D sdhci_sdma_address(s);
>-    uint32_t boundary_count =3D boundary_chk - (sdma_address % boundary_=
chk);
>+    uint32_t boundary_count =3D 0;
>=20
>     if (!(s->trnmod & SDHC_TRNS_BLK_CNT_EN) || !s->blkcnt) {
>         qemu_log_mask(LOG_UNIMP, "infinite transfer is not supported\n")=
;
>@@ -704,8 +706,11 @@ static void sdhci_sdma_transfer_multi_blocks(SDHCISt=
ate *s)
>      * possible stop at page boundary if initial address is not page ali=
gned,
>      * allow them to work properly
>      */
>-    if ((sdma_address % boundary_chk) =3D=3D 0) {
>-        page_aligned =3D true;
>+    if (boundary_enabled) {
>+        boundary_chk =3D
>+            1 << (((s->blksize & ~BLOCK_SIZE_MASK) >> 12) + 12);
>+        boundary_count =3D boundary_chk - (sdma_address % boundary_chk);
>+        page_aligned =3D (sdma_address % boundary_chk) =3D=3D 0;
>     }
>=20
>     s->prnsts |=3D SDHC_DATA_INHIBIT | SDHC_DAT_LINE_ACTIVE;
>@@ -721,7 +726,9 @@ static void sdhci_sdma_transfer_multi_blocks(SDHCISta=
te *s)
>                 boundary_count =3D 0;
>              } else {
>                 s->data_count =3D block_size;
>-                boundary_count -=3D block_size - begin;
>+                if (boundary_enabled) {
>+                    boundary_count -=3D block_size - begin;
>+                }
>                 if (s->trnmod & SDHC_TRNS_BLK_CNT_EN) {
>                     s->blkcnt--;
>                 }
>@@ -746,7 +753,9 @@ static void sdhci_sdma_transfer_multi_blocks(SDHCISta=
te *s)
>                 boundary_count =3D 0;
>              } else {
>                 s->data_count =3D block_size;
>-                boundary_count -=3D block_size - begin;
>+                if (boundary_enabled) {
>+                    boundary_count -=3D block_size - begin;
>+                }
>             }
>             dma_memory_read(s->dma_as, sdhci_sdma_address(s),
>                             &s->fifo_buffer[begin],
>@@ -2015,13 +2024,14 @@ esdhc_write(void *opaque, hwaddr offset, uint64_t=
 val, unsigned size)
>=20
>     case SDHC_BLKSIZE:
>         /*
>-         * ESDHCI does not implement "Host SDMA Buffer Boundary", and
>-         * Linux driver will try to zero this field out which will
>-         * break the rest of SDHCI emulation=2E
>+         * Freescale eSDHC and i=2EMX uSDHC use BLKATTR without the stan=
dard
>+         * Host SDMA Buffer Boundary field=2E uSDHC accesses reach this =
shared
>+         * register translation through usdhc_write()=2E
>          *
>-         * Linux defaults to maximum possible setting (512K boundary)
>-         * and it seems to be the only option that i=2EMX IP implements,
>-         * so we artificially set it to that value=2E
>+         * Keep the largest boundary in the generic representation to
>+         * preserve existing eSDHC behavior=2E TYPE_IMX_USDHC separately
>+         * disables the associated stop semantics because its DINT repor=
ts
>+         * completion of the entire transfer rather than a boundary even=
t=2E
>          */
>         val |=3D 0x7 << 12;
>         /* FALLTHROUGH */
>@@ -2168,7 +2178,8 @@ static void imx_usdhc_init(Object *obj)
>=20
>     s->io_ops =3D &usdhc_mmio_ops;
>     s->quirks =3D SDHCI_QUIRK_NO_BUSY_IRQ |
>-                SDHCI_QUIRK_CLOCKS_IN_VENDOR;
>+                SDHCI_QUIRK_CLOCKS_IN_VENDOR |
>+                SDHCI_QUIRK_NO_SDMA_BOUNDARY;

Given the above comments please also add the quirk to both ESDHC variants=
=2E Thanks!

With the above fixed:

Reviewed-by: Bernhard Beschow <shentey@gmail=2Ecom>

>     qdev_prop_set_uint8(dev, "sd-spec-version", 3);
> }
>=20

