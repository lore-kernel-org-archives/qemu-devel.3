Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D355C2BBCA
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 07:04:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN5dK-0008VH-Pj; Fri, 28 Jun 2024 03:02:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN5dI-0008Uo-7j
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:02:57 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN5dE-0006fh-HR
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:02:54 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-42563a9fa58so2468575e9.0
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 00:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719558171; x=1720162971; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=8X6AtOCpBUXAQ/1xHubY59Be7qdcbmyzPDPReyo42Nc=;
 b=jRs8BBgaAomubPxiCGqFKrVaB0820B5fps78bESQRRqA4YqszkkcU8l6nBfYcZdX5L
 Yw3pmqSjJ4D9IrDk/gnyh4pKsaqCLcirHqgw6z9dIqY7SRtT8zsVayaYsALud6PcOlD/
 nfL93ljqafB9SymBkdU0cmOCTqAY8qsCFKJh1N6bf0RRjabKUU7eSZI98naoyPBaDs4Y
 te9q0sSO3h0TyPJoxB1615sSFIQaHyzPczFFAm6EP2qztvg6wWORDXaF2AMrEdjJhsb9
 QP1lkLUvGbiPF3aNZBabko3UcjBDA1/Ftnu1Ru9AJoU1lRxYGbUNmV2gLB85fBDAK5k4
 56JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719558171; x=1720162971;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8X6AtOCpBUXAQ/1xHubY59Be7qdcbmyzPDPReyo42Nc=;
 b=SXuLjaZq3UuJtipWmug10xftgwrTBMuQ4uJqrf9Zx1tyuQ65N/97jPoSJSXm37JUOI
 Yvoi2zBwhji7ZaLQSODIitjKww4DQulnvo+AwGxo44NC+e+OjGsW4N6pTXVZ9qVMe0Nf
 gUO0jPcZGIYrdebeYIS3H1EIn9jRUv4dZq8V/VTgNecWU9HQ1gQdx0F76QbX9Qc8qDy5
 SM0XBEqrqQMIUsHDR5jbswTyWSBEgkS+emQl9cRoiKqtIsn+cXigE1EfjWJCcwGwAInb
 4ciyA14vUh/C2CnVrP84H+dq599NSV+pFv7yU7q+eF0iBIKUMdK1lcvZ4SHZ7UJENFR4
 ljsw==
X-Gm-Message-State: AOJu0YyJ2gdoZ1Ty2KIiqR0JhKjipbJKDAk1FLhCXpDdVAkIwxLrb+MS
 whRHxjCblkmbqa95MXMygUYWmYiUQEye4U5P+QdpsU28L+w6I7sQjPTB9q6f2pYsFuUSUrNo4Lk
 Aci8=
X-Google-Smtp-Source: AGHT+IGwVXgB+OxIdHUVsKSeeWSTUl1acpEpC8XD0UYbltjzHMoc1VvHXDt4KJFhSMUe72Mz5JXWRA==
X-Received: by 2002:a05:600c:1c1e:b0:425:692d:c728 with SMTP id
 5b1f17b1804b1-425692dd38dmr15098215e9.28.1719558170871; 
 Fri, 28 Jun 2024 00:02:50 -0700 (PDT)
Received: from m1x-phil.lan (cho94-h02-176-184-4-239.dsl.sta.abo.bbox.fr.
 [176.184.4.239]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256aed2263sm22708705e9.0.2024.06.28.00.02.49
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 28 Jun 2024 00:02:50 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH v42 06/98] hw/sd/sdcard: Do not store vendor data on block
 drive (CMD56)
Date: Fri, 28 Jun 2024 09:00:42 +0200
Message-ID: <20240628070216.92609-7-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240628070216.92609-1-philmd@linaro.org>
References: <20240628070216.92609-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

"General command" (GEN_CMD, CMD56) is described as:

  GEN_CMD is the same as the single block read or write
  commands (CMD24 or CMD17). The difference is that [...]
  the data block is not a memory payload data but has a
  vendor specific format and meaning.

Thus this block must not be stored overwriting data block
on underlying storage drive. Keep it in a dedicated
'vendor_data[]' array.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Cédric Le Goater <clg@redhat.com>
---
RFC: Is it safe to reuse VMSTATE_UNUSED_V() (which happens
to be the same size)?

Cc: Peter Xu <peterx@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>
---
 hw/sd/sd.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 464576751a..1f3eea6e84 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -142,6 +142,8 @@ struct SDState {
     uint64_t data_start;
     uint32_t data_offset;
     uint8_t data[512];
+    uint8_t vendor_data[512];
+
     qemu_irq readonly_cb;
     qemu_irq inserted_cb;
     QEMUTimer *ocr_power_timer;
@@ -656,6 +658,7 @@ static void sd_reset(DeviceState *dev)
     sd->wp_switch = sd->blk ? !blk_is_writable(sd->blk) : false;
     sd->wp_group_bits = sect;
     sd->wp_group_bmap = bitmap_new(sd->wp_group_bits);
+    memset(sd->vendor_data, 0xec, sizeof(sd->vendor_data));
     memset(sd->function_group, 0, sizeof(sd->function_group));
     sd->erase_start = INVALID_ADDRESS;
     sd->erase_end = INVALID_ADDRESS;
@@ -771,7 +774,7 @@ static const VMStateDescription sd_vmstate = {
         VMSTATE_UINT64(data_start, SDState),
         VMSTATE_UINT32(data_offset, SDState),
         VMSTATE_UINT8_ARRAY(data, SDState, 512),
-        VMSTATE_UNUSED_V(1, 512),
+        VMSTATE_UINT8_ARRAY(vendor_data, SDState, 512),
         VMSTATE_BOOL(enable, SDState),
         VMSTATE_END_OF_LIST()
     },
@@ -2029,9 +2032,8 @@ void sd_write_byte(SDState *sd, uint8_t value)
         break;
 
     case 56:  /* CMD56:  GEN_CMD */
-        sd->data[sd->data_offset ++] = value;
-        if (sd->data_offset >= sd->blk_len) {
-            APP_WRITE_BLOCK(sd->data_start, sd->data_offset);
+        sd->vendor_data[sd->data_offset ++] = value;
+        if (sd->data_offset >= sizeof(sd->vendor_data)) {
             sd->state = sd_transfer_state;
         }
         break;
@@ -2165,12 +2167,11 @@ uint8_t sd_read_byte(SDState *sd)
         break;
 
     case 56:  /* CMD56:  GEN_CMD */
-        if (sd->data_offset == 0)
-            APP_READ_BLOCK(sd->data_start, sd->blk_len);
-        ret = sd->data[sd->data_offset ++];
+        ret = sd->vendor_data[sd->data_offset ++];
 
-        if (sd->data_offset >= sd->blk_len)
+        if (sd->data_offset >= sizeof(sd->vendor_data)) {
             sd->state = sd_transfer_state;
+        }
         break;
 
     default:
-- 
2.41.0


