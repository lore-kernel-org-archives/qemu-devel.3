Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EE6BCA5FCE
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 10:46:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDgD9-00066Y-Uj; Mon, 05 Oct 2026 06:46:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xDgD8-00065u-Dc
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 06:46:22 -0400
Received: from mail-wm2-x10.google.com ([2a00:1450:4864:31::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xDgD6-0003s5-Ba
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 06:46:22 -0400
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-4a01ff8c098so10558715e9.3
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2026 03:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791197178; x=1791801978; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id
 :references:in-reply-to:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=+mdqw9SlbtKi9bcsBK3wMMZQpcpJ3zW371eQsSPicnw=;
 b=QMmpWOUN9hCKQfvvQM8IDoEKJMo7P5kTltsWOm0IXiVJknCEH8Cd2QXHWeOLoIegX2
 nW0xC0SU82XXI0NHsm/ykvV6zErw/Pb6fj5G+y9cpFqifcpKA6ktV26/xPen7AiGT5XH
 hZajh1M4jzD0YIEZdwEoOVSYQQnP5/ERI6wXjKqwrb2nX8TbJ4G5iFZFptVzAocxs+jz
 f/hU/GU1Ssy7D6Qh/KhMPT9nIdkTvVbTV1omU/8waIRhcBkLbc3AncS1hvjfsVD2zqDL
 AsxHlD59iy1jlCFM2Hy+z8hGV7XqyDa9gZJYgf7zG5s2aAhiwaF5FHtS47s+nYi5zyGK
 xcaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791197178; x=1791801978;
 h=content-transfer-encoding:content-type:mime-version:message-id
 :references:in-reply-to:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+mdqw9SlbtKi9bcsBK3wMMZQpcpJ3zW371eQsSPicnw=;
 b=po5I2zvVb2LLNxbC+Yutd4a35xCkwYzUYQ5bXUWrVT2iiMWvJ3fJ3UZp31TMeM/xzA
 X1sfcUSUA6FeCjteIbrS41z6j7kdJN9hbzfh2ZtU/Kgr7Qdhpd9JBM4oYzBA7lLkIz5P
 TQAcqxsilHX2kYsC3CbL/eHpKV7/AwDKZiXdf900efT0AYGe4qwKuF+77nuzXRaRZD5v
 wb55sQkQ4PGSwxuR/qMxMfoxhMfi/dXecXh33AtFVRPKluNK/XBAz5sHyP1enqhd+XFS
 nV0PmDbN1yU51QrGsjXzEe9lj5Sm/9rxncCjYFpFxJynoVC6/x93kUZq2J3XmB/gVwvA
 tlSQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxVGwwD2PmfGiJfXnVRMilVhBXQRnolIqNwSTG9MutmJgF9XYRrpHxt4MvBDXwvmu6LtWBr9VzbDygB@nongnu.org
X-Gm-Message-State: AFuF++nIbe/2heAgzhR2kpgQFhFMXn/JoZ1hNWdlXBVPLF31j3e2ytIH
 yXVoWJUOlQjxGnpVYsFzfpe2wEZNwOlLJC2Mr6ZRCIZT2gwDiRbZUMO9eEwASA==
X-Gm-Gg: AYBFou07SYgJkCsFLTdLTASjEcWXFKkiK6O9V945xoB4QVISF3BuetPHK3gu+VG9nBe
 p4B+8cZbqE32RQRARD04ScLRxbwRTgulffkcRwHIBFsnL+6UjiKORtih449xSJRziVfGQQ0Hkmo
 FGqyeg9XpJ/bXW44zeame3WVtxPYzp2vawRRoX1Btih2REwJSPhiZyoo3tgahXVLvnrU43e+Q7I
 grBOzYGjCFyOb0sb3LwU8ZD88QF2ocqoRI6vywu8rR4BsNAT8kI3yECWc6wvY/AtZCeJLCki6bu
 pH82aaBM9n24+FFVAs8no+IcEn3J5aqC13S2UQLqGRPQsrA5G0c92sx3WddRqdFMRT0ISghuKtt
 ED3ZUJ2P4heAtv+IhorcXAuqJy45c13yKzq6MJTUQ1ZQ02NboE/QLyCHoK2LzEmgd4MK9VgHSYm
 T8Cu8HCpS00QLsrX893Bhq/MCMcLdHIoZWZNjZ5bwplX9yLZHj4LWGdawDAovZdGCGNvqzgxfav
 ZlLAOpIdYYlc0R1e7DoSBI74OwM2eQmmbzw7rLDVowBdIh+SIU9yEwrlj03OQdW5z+ktko=
X-Received: by 2002:a05:600c:8b22:b0:4a1:6811:8d with SMTP id
 5b1f17b1804b1-4a1681100f1mr105347655e9.11.1791197178105; 
 Mon, 05 Oct 2026 03:46:18 -0700 (PDT)
Received: from ehlo.thunderbird.net
 (p200300faaf09ae005c0c4b1d534a3dac.dip0.t-ipconnect.de.
 [2003:fa:af09:ae00:5c0c:4b1d:534a:3dac])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a170f7cff4sm147040345e9.7.2026.10.05.03.46.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Oct 2026 03:46:17 -0700 (PDT)
Date: Mon, 05 Oct 2026 10:46:08 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org, Bin Meng <bin.meng@processmission.com>,
 QEMU <qemu-devel@nongnu.org>
CC: Bin Meng <bmeng.cn@gmail.com>,
 =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>,
 qemu-block@nongnu.org
Subject: Re: [PATCH v3 09/27] hw/sd: sdhci: Run ADMA independently of MMIO
In-Reply-To: <20261003170232.2450916-10-bin.meng@processmission.com>
References: <20261003170232.2450916-1-bin.meng@processmission.com>
 <20261003170232.2450916-10-bin.meng@processmission.com>
Message-ID: <280C2CA1-0D1E-4F56-8F64-0139F2B038F0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:31::10;
 envelope-from=shentey@gmail.com; helo=mail-wm2-x10.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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



Am 3=2E Oktober 2026 17:01:59 UTC schrieb Bin Meng <bin=2Emeng@processmiss=
ion=2Ecom>:
>The SDHCI model processes the first ADMA descriptor batch inside the
>command MMIO write, then resumes pending batches before every later
>SDHCI MMIO read or write=2E This makes register access perform bulk DMA
>work and can delay a status read even when completion bits are set=2E
>
>On the Icicle Kit, U-Boot uses ADMA2-64 and CMD18 to load a roughly
>19 MiB FIT image from SD=2E It can report:
>
>  Timeout for status update: 00000001 00000001
>  Timeout for status update: 00000003 00000001
>
>The status already contains the requested Command Complete bit, and may
>also contain Transfer Complete=2E However, reading the interrupt status
>first executes a pending ADMA batch=2E The MMIO read can therefore return
>after U-Boot has reached its one-second polling deadline=2E
>
>Turn the existing transfer timer into an ADMA-only engine=2E Starting an
>ADMA command arms the engine directly, and each timer callback runs one
>bounded batch before yielding=2E MMIO reads and writes no longer perform
>or schedule ADMA work=2E Keep PIO and SDMA synchronous=2E
>
>Cancel the engine and clear ADMA activity and error state on DATA or ALL
>reset=2E
>
>Signed-off-by: Bin Meng <bin=2Emeng@processmission=2Ecom>
>---
>
>(no changes since v1)

Hi Bin,

I've accidentally left some comments on v2 after you sent v3: https://lore=
=2Ekernel=2Eorg/qemu-devel/8D7F1DAF-0133-41A6-A665-8EC8D4078273@gmail=2Ecom=
/ =2E Generally patch LGTM=2E

Best regards,
Bernhard

>
> hw/sd/sdhci=2Ec | 143 ++++++++++++++++++++++++++++++--------------------
> 1 file changed, 87 insertions(+), 56 deletions(-)
>
>diff --git a/hw/sd/sdhci=2Ec b/hw/sd/sdhci=2Ec
>index bd74c60f72=2E=2E14c312a691 100644
>--- a/hw/sd/sdhci=2Ec
>+++ b/hw/sd/sdhci=2Ec
>@@ -277,6 +277,7 @@ static void sdhci_set_inserted(DeviceState *dev, bool=
 level)
>             }
>         } else {
>             s->prnsts =3D 0x1fa0000;
>+            timer_del(s->transfer_timer);
>             s->pwrcon &=3D ~SDHC_POWER_ON;
>             s->clkcon &=3D ~SDHC_CLOCK_SDCLK_EN;
>             if (s->norintstsen & SDHC_NISEN_REMOVE) {
>@@ -348,7 +349,34 @@ static void sdhci_poweron_reset(DeviceState *dev)
>     }
> }
>=20
>-static void sdhci_data_transfer(void *opaque);
>+static void sdhci_data_transfer(SDHCIState *s);
>+static void sdhci_adma_engine(void *opaque);
>+
>+static void sdhci_set_transfer_active(SDHCIState *s)
>+{
>+    s->prnsts |=3D SDHC_DATA_INHIBIT | SDHC_DAT_LINE_ACTIVE;
>+    if (s->trnmod & SDHC_TRNS_READ) {
>+        s->prnsts |=3D SDHC_DOING_READ;
>+    } else {
>+        s->prnsts |=3D SDHC_DOING_WRITE;
>+    }
>+}
>+
>+static void sdhci_schedule_adma(SDHCIState *s)
>+{
>+    timer_mod(s->transfer_timer,
>+              qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + SDHC_TRANSFER_DELA=
Y);
>+}
>+
>+static bool sdhci_adma_transfer_active(SDHCIState *s)
>+{
>+    return TRANSFERRING_DATA(s->prnsts) &&
>+           (s->trnmod & SDHC_TRNS_DMA) &&
>+           (s->cmdreg & SDHC_CMD_DATA_PRESENT) &&
>+           sdhci_get_dma_type(s) !=3D SDHC_CTRL_SDMA &&
>+           !(s->admaerr & SDHC_ADMAERR_STATE_MASK) &&
>+           !(s->errintsts & SDHC_EIS_ADMAERR);
>+}
>=20
> #define BLOCK_SIZE_MASK (4 * KiB - 1)
>=20
>@@ -405,7 +433,13 @@ static void sdhci_send_command(SDHCIState *s)
>     if (!timeout && (s->blksize & BLOCK_SIZE_MASK) &&
>         (s->cmdreg & SDHC_CMD_DATA_PRESENT)) {
>         s->data_count =3D 0;
>-        sdhci_data_transfer(s);
>+        if ((s->trnmod & SDHC_TRNS_DMA) &&
>+            sdhci_get_dma_type(s) !=3D SDHC_CTRL_SDMA) {
>+            sdhci_set_transfer_active(s);
>+            sdhci_schedule_adma(s);
>+        } else {
>+            sdhci_data_transfer(s);
>+        }
>     }
> }
>=20
>@@ -850,7 +884,7 @@ static void get_adma_description(SDHCIState *s, ADMAD=
escr *dscr)
>=20
> /* Advanced DMA data transfer */
>=20
>-static void sdhci_do_adma(SDHCIState *s)
>+static void sdhci_adma_run_batch(SDHCIState *s)
> {
>     unsigned int begin, length;
>     const uint16_t block_size =3D s->blksize & BLOCK_SIZE_MASK;
>@@ -956,15 +990,17 @@ static void sdhci_do_adma(SDHCIState *s)
>             }
>             if (res !=3D MEMTX_OK) {
>                 s->data_count =3D 0;
>+                s->admaerr &=3D ~SDHC_ADMAERR_STATE_MASK;
>+                s->admaerr |=3D SDHC_ADMAERR_STATE_ST_TFR;
>                 if (s->errintstsen & SDHC_EISEN_ADMAERR) {
>                     trace_sdhci_error("Set ADMA error flag");
>                     s->errintsts |=3D SDHC_EIS_ADMAERR;
>                     s->norintsts |=3D SDHC_NIS_ERR;
>                 }
>                 sdhci_update_irq(s);
>-            } else {
>-                s->admasysaddr +=3D dscr=2Eincr;
>+                return;
>             }
>+            s->admasysaddr +=3D dscr=2Eincr;
>             break;
>         case SDHC_ADMA_ATTR_ACT_LINK:   /* link to next descriptor table=
 */
>             s->admasysaddr =3D dscr=2Eaddr;
>@@ -1012,50 +1048,52 @@ static void sdhci_do_adma(SDHCIState *s)
>     }
>=20
>     /* we have unfinished business - reschedule to continue ADMA */
>-    timer_mod(s->transfer_timer,
>-                   qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + SDHC_TRANSFER=
_DELAY);
>+    sdhci_schedule_adma(s);
> }
>=20
>-/* Perform data transfer according to controller configuration */
>-
>-static void sdhci_data_transfer(void *opaque)
>+/* Run one independently scheduled, quota-bounded ADMA batch */
>+static void sdhci_adma_engine(void *opaque)
> {
>     SDHCIState *s =3D (SDHCIState *)opaque;
>=20
>-    if (s->trnmod & SDHC_TRNS_DMA) {
>-        switch (sdhci_get_dma_type(s)) {
>-        case SDHC_CTRL_SDMA:
>-            sdhci_sdma_transfer(s);
>-            break;
>-        case SDHC_CTRL_ADMA1_32:
>-            if (!(s->capareg & R_SDHC_CAPAB_ADMA1_MASK)) {
>-                trace_sdhci_error("ADMA1 not supported");
>-                break;
>-            }
>+    if (!sdhci_adma_transfer_active(s)) {
>+        return;
>+    }
>=20
>-            sdhci_do_adma(s);
>-            break;
>-        case SDHC_CTRL_ADMA2_32:
>-            if (!(s->capareg & R_SDHC_CAPAB_ADMA2_MASK)) {
>-                trace_sdhci_error("ADMA2 not supported");
>-                break;
>-            }
>+    switch (sdhci_get_dma_type(s)) {
>+    case SDHC_CTRL_ADMA1_32:
>+        if (!(s->capareg & R_SDHC_CAPAB_ADMA1_MASK)) {
>+            trace_sdhci_error("ADMA1 not supported");
>+            return;
>+        }
>+        break;
>+    case SDHC_CTRL_ADMA2_32:
>+        if (!(s->capareg & R_SDHC_CAPAB_ADMA2_MASK)) {
>+            trace_sdhci_error("ADMA2 not supported");
>+            return;
>+        }
>+        break;
>+    case SDHC_CTRL_ADMA2_64:
>+        if (!(s->capareg & R_SDHC_CAPAB_ADMA2_MASK) ||
>+            !(s->capareg & R_SDHC_CAPAB_BUS64BIT_MASK)) {
>+            trace_sdhci_error("64 bit ADMA not supported");
>+            return;
>+        }
>+        break;
>+    default:
>+        trace_sdhci_error("Unsupported ADMA type");
>+        return;
>+    }
>=20
>-            sdhci_do_adma(s);
>-            break;
>-        case SDHC_CTRL_ADMA2_64:
>-            if (!(s->capareg & R_SDHC_CAPAB_ADMA2_MASK) ||
>-                    !(s->capareg & R_SDHC_CAPAB_BUS64BIT_MASK)) {
>-                trace_sdhci_error("64 bit ADMA not supported");
>-                break;
>-            }
>+    sdhci_adma_run_batch(s);
>+}
>=20
>-            sdhci_do_adma(s);
>-            break;
>-        default:
>-            trace_sdhci_error("Unsupported DMA type");
>-            break;
>-        }
>+/* Perform synchronous PIO or SDMA data transfer */
>+static void sdhci_data_transfer(SDHCIState *s)
>+{
>+    if (s->trnmod & SDHC_TRNS_DMA) {
>+        assert(sdhci_get_dma_type(s) =3D=3D SDHC_CTRL_SDMA);
>+        sdhci_sdma_transfer(s);
>     } else {
>         if ((s->trnmod & SDHC_TRNS_READ) && sdbus_data_ready(&s->sdbus))=
 {
>             s->prnsts |=3D SDHC_DOING_READ | SDHC_DATA_INHIBIT |
>@@ -1098,21 +1136,11 @@ sdhci_buff_access_is_sequential(SDHCIState *s, un=
signed byte_num)
>     return true;
> }
>=20
>-static void sdhci_resume_pending_transfer(SDHCIState *s)
>-{
>-    timer_del(s->transfer_timer);
>-    sdhci_data_transfer(s);
>-}
>-
> static uint64_t sdhci_read(void *opaque, hwaddr offset, unsigned size)
> {
>     SDHCIState *s =3D (SDHCIState *)opaque;
>     uint32_t ret =3D 0;
>=20
>-    if (timer_pending(s->transfer_timer)) {
>-        sdhci_resume_pending_transfer(s);
>-    }
>-
>     switch (offset & ~0x3) {
>     case SDHC_SYSAD:
>         ret =3D s->sdmasysad;
>@@ -1235,7 +1263,10 @@ static inline void sdhci_reset_write(SDHCIState *s=
, uint8_t value)
>         s->norintsts &=3D ~SDHC_NIS_CMDCMP;
>         break;
>     case SDHC_RESET_DATA:
>+        timer_del(s->transfer_timer);
>         s->data_count =3D 0;
>+        s->admaerr =3D 0;
>+        s->errintsts &=3D ~SDHC_EIS_ADMAERR;
>         s->prnsts &=3D ~(SDHC_SPACE_AVAILABLE | SDHC_DATA_AVAILABLE |
>                 SDHC_DOING_READ | SDHC_DOING_WRITE |
>                 SDHC_DATA_INHIBIT | SDHC_DAT_LINE_ACTIVE);
>@@ -1244,6 +1275,10 @@ static inline void sdhci_reset_write(SDHCIState *s=
, uint8_t value)
>         s->sdma_boundary_paused =3D false;
>         s->norintsts &=3D ~(SDHC_NIS_WBUFRDY | SDHC_NIS_RBUFRDY |
>                 SDHC_NIS_DMA | SDHC_NIS_TRSCMP | SDHC_NIS_BLKGAP);
>+        if (!s->errintsts) {
>+            s->norintsts &=3D ~SDHC_NIS_ERR;
>+        }
>+        sdhci_update_irq(s);
>         break;
>     }
> }
>@@ -1257,10 +1292,6 @@ sdhci_write(void *opaque, hwaddr offset, uint64_t =
val, unsigned size)
>     uint32_t value =3D val;
>     value <<=3D shift;
>=20
>-    if (timer_pending(s->transfer_timer)) {
>-        sdhci_resume_pending_transfer(s);
>-    }
>-
>     switch (offset & ~0x3) {
>     case SDHC_SYSAD:
>         if (!TRANSFERRING_DATA(s->prnsts) ||
>@@ -1521,7 +1552,7 @@ void sdhci_initfn(SDHCIState *s)
>     s->insert_timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL,
>                                    sdhci_raise_insertion_irq, s);
>     s->transfer_timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL,
>-                                     sdhci_data_transfer, s);
>+                                     sdhci_adma_engine, s);
>=20
>     s->io_ops =3D &sdhci_mmio_ops;
> }

