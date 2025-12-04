Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BB79D2A520
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Dec 2025 19:34:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vRF51-0001PM-Qi; Thu, 04 Dec 2025 14:33:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1vRF50-0001Od-IJ
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 14:33:30 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1vRF4y-0000Za-NH
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 14:33:30 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4779a637712so9871475e9.1
 for <qemu-devel@nongnu.org>; Thu, 04 Dec 2025 11:33:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764876806; x=1765481606; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=d866HaOUOnbzdL1/N7SyCjyOZdyW35ebyFaE6QmQOGg=;
 b=kLaIp2LEmActGNIVI1qOizHC9hxbdlgRDhT4bCVECSqa1GN7fEjsezDGVujWkKUWIz
 USQdQbBc9DbfqudIEwAJ+psnOWeCeTyJYiCWP9hK5PBqrK7xJv27KMfRjt1W+AO5+pSd
 Olf9B+3VywOcXUiaz/4regNhk8q+aHcn0QUmWkL2n93AXwH5New8yCUnvyG2bQIgliSv
 YmdI7ZWy7YvzXE1/j+vK5nj87+9IWopGt3j01fFmkfz9DY2VZEHQrs/AK/8MUn2t/XXN
 Wg8QbjgxyISEClBLFw5+h8koHRKq3tF95uMSqAISGKG/jlOEKZyeAm8erqxXh9KB/xce
 vDbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764876806; x=1765481606;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d866HaOUOnbzdL1/N7SyCjyOZdyW35ebyFaE6QmQOGg=;
 b=TdA0SaoNTG2quOZNMM/Lsh4j0K+zCslTOMRqeLADZOO1cV/BpWoyxr1Em5GEVSpm/1
 L/SNOR2J/BMirpmRTMuxjvIXvJQwhLsOYwejM6EIrjOWTuKzwYQIStDsswIXJVj3S50a
 dgNScrEt0y6I4Pmv8ObCda3v9VWGE4n2r3uSATRqY5JEqYbrimsynwIA30Ni2snpQHpj
 pTqmoXlIpRXVCkmJ8CbjAJKjO9n40CUe7s2k0p4lc9dFN7M7cor4+0pXbBkEoQfCNkX5
 YVsGWpgZ4dokhYYTRMgscdxED44CbWFtNZvnzgr43CwJvxBkv6oIdMx6uK0pHwaw3ljS
 7zqg==
X-Gm-Message-State: AOJu0Yw1nOAxogZ482IuNt9DWUC1WTp/Hh58jZ3bsNQGa//OmufDRdqy
 n5kJu9K8CRlMA5UVrMp6h5udSV4JsnOLtEoHlDORkKtoDwhPVFMyoG2dA0sQCnsz3qou9JxqZw9
 B4abR
X-Gm-Gg: ASbGnct8Aw/JkX3kNHagEUAt0njaDKbtuC9r2ST4nBD/TV3j/nuoHRZB3wm8hwp6RQb
 v54Vv95lVO+A2X2O0EY1Fgp4sUhP9xdUPJ2RYIPWU2+wqDH/X0dQ/94h19zt6RqIUpa5dvYhtU2
 CA87VYWwTsn24VAuJGUGYOQ87Nc6r8wQVzLttSY+JNe4JyITzYF4zwSAipprNjh/Q2pnQS7TOZA
 c5uGhhpkIO9zwo3DDTyvOEgohGDOZmsQgkfecMj5hYo/TEQlZheoodNYu4a4P9wLJtFWU1HVKUE
 Q7jo06G5HVNzeO8kY42DlfjXEk2uYy/WLk0YKHvNhgQttw814e1lteAZiOQsytm4/DAlTH2iWiE
 2JLRIv1pdF5hXSuREq40ceqSLJr9h0MsMSVZ8jKT1A+NWXN/roJpsmXaODRUnIOOJq/W3ra5I+d
 2wMY4htWS0T5c=
X-Google-Smtp-Source: AGHT+IGzMTHlAPBlFuhy6IzM1z8S9IJ0Tur7SPrDNAfNh6jCRC5KplGWzNdQiXfR38P72CInwWa6+A==
X-Received: by 2002:a05:6000:2085:b0:42b:3b55:8927 with SMTP id
 ffacd0b85a97d-42f731967damr8160631f8f.21.1764876805963; 
 Thu, 04 Dec 2025 11:33:25 -0800 (PST)
Received: from jimm-x1.. ([2a10:d582:31e:0:d817:b2ba:2766:5b2a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42f7d222491sm4912865f8f.22.2025.12.04.11.33.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Dec 2025 11:33:25 -0800 (PST)
From: Jim MacArthur <jim.macarthur@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jim MacArthur <jim.macarthur@linaro.org>
Subject: [PATCH] hw/dma/omap_dma.c: Use 64 bit maths for
 omap_dma_transfer_setup
Date: Thu,  4 Dec 2025 19:33:11 +0000
Message-ID: <20251204193311.1281133-1-jim.macarthur@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=jim.macarthur@linaro.org; helo=mail-wm1-x32f.google.com
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

If both frame and element count are 65535, which appears valid from my
reading of the OMAP5912 documentation, then some of the calculations
will overflow the 32-bit signed integer range and produce a negative
min_elems value.

Raised by #3204 (https://gitlab.com/qemu-project/qemu/-/issues/3204).

Signed-off-by: Jim MacArthur <jim.macarthur@linaro.org>
---
 hw/dma/omap_dma.c | 32 +++++++++++++++++++++-----------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/hw/dma/omap_dma.c b/hw/dma/omap_dma.c
index 101f91f4a3..93e6503ff9 100644
--- a/hw/dma/omap_dma.c
+++ b/hw/dma/omap_dma.c
@@ -504,9 +504,19 @@ static void omap_dma_transfer_setup(struct soc_dma_ch_s *dma)
     struct omap_dma_channel_s *ch = dma->opaque;
     struct omap_dma_s *s = dma->dma->opaque;
     int frames, min_elems, elements[__omap_dma_intr_last];
+    uint64_t frames64, frame64, elements64, element64;
 
     a = &ch->active_set;
 
+    /*
+     * We do maths with the frame and element fields which exceeds
+     * a signed 32-bit integer, so convert all these to 64 bit for future use.
+     */
+    frames64 = a->frames;
+    frame64 = a->frame;
+    elements64 = a->elements;
+    element64 = a->element;
+
     src_p = &s->mpu->port[ch->port[0]];
     dest_p = &s->mpu->port[ch->port[1]];
     if ((!ch->constant_fill && !src_p->addr_valid(s->mpu, a->src)) ||
@@ -527,7 +537,7 @@ static void omap_dma_transfer_setup(struct soc_dma_ch_s *dma)
     /* Check all the conditions that terminate the transfer starting
      * with those that can occur the soonest.  */
 #define INTR_CHECK(cond, id, nelements) \
-    if (cond) {         \
+    if (cond && nelements <= INT_MAX) {         \
         elements[id] = nelements;   \
         if (elements[id] < min_elems)   \
             min_elems = elements[id];   \
@@ -547,24 +557,24 @@ static void omap_dma_transfer_setup(struct soc_dma_ch_s *dma)
      * See also the TODO in omap_dma_channel_load.  */
     INTR_CHECK(
                     (ch->interrupts & LAST_FRAME_INTR) &&
-                    ((a->frame < a->frames - 1) || !a->element),
+                    ((frame64 < frames64 - 1) || !element64),
                     omap_dma_intr_last_frame,
-                    (a->frames - a->frame - 2) * a->elements +
-                    (a->elements - a->element + 1))
+                    (frames64 - frame64 - 2) * elements64 +
+                    (elements64 - element64 + 1))
     INTR_CHECK(
                     ch->interrupts & HALF_FRAME_INTR,
                     omap_dma_intr_half_frame,
-                    (a->elements >> 1) +
-                    (a->element >= (a->elements >> 1) ? a->elements : 0) -
-                    a->element)
+                    (elements64 >> 1) +
+                    (element64 >= (elements64 >> 1) ? elements64 : 0) -
+                    element64)
     INTR_CHECK(
                     ch->sync && ch->fs && (ch->interrupts & END_FRAME_INTR),
                     omap_dma_intr_frame,
-                    a->elements - a->element)
+                    elements64 - element64)
     INTR_CHECK(
                     ch->sync && ch->fs && !ch->bs,
                     omap_dma_intr_frame_sync,
-                    a->elements - a->element)
+                    elements64 - element64)
 
     /* Packets */
     INTR_CHECK(
@@ -581,8 +591,8 @@ static void omap_dma_transfer_setup(struct soc_dma_ch_s *dma)
     INTR_CHECK(
                     1,
                     omap_dma_intr_block,
-                    (a->frames - a->frame - 1) * a->elements +
-                    (a->elements - a->element))
+                    (frames64 - frame64 - 1) * elements64 +
+                    (elements64 - element64))
 
     dma->bytes = min_elems * ch->data_type;
 
-- 
2.43.0


