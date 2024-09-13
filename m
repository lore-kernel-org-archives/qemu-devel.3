Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 729CBFA3755
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2024 15:17:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sp81B-00069C-2r; Fri, 13 Sep 2024 11:15:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sp80D-0002NY-ON
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 11:14:29 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sp80B-0007pE-BT
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 11:14:29 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-42cc8782869so22030935e9.2
 for <qemu-devel@nongnu.org>; Fri, 13 Sep 2024 08:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726240466; x=1726845266; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=+xOK2ZrZb1liyDsXayAy9xBW8YsGkjzSUb/zEYjVuT4=;
 b=eBftLHR3dLFmsAZufPsgCRSPncnhp61qjBgTiSg2HcwpOCBsgGM85xu3iJjl3RmBBb
 wUKdqA2+iPAkKF01tZ16p9HLhX1rKQ66k7eYnN+zp9KBBb9Fl0Z8GWsSWJX0w79VQo6g
 YRpVWGWAEhqEav13W/9csqfYuMV6OQ3ESXytJKM3aYZikcoR+Q81T5VGnwXV4UF1Jmgt
 A1/TKc+ZpYn0IDzT3kiGRdIbBz/dymLkQwsDjJjWlgGTZhnWcF+86js0e8omUI8Ponca
 gSrofWHLyl55k3r56g4x3Ok6wyZiLnTrDdXfyiSTZWF6CJsXS8SSvWwmYZjYeztrWvAz
 1mCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726240466; x=1726845266;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+xOK2ZrZb1liyDsXayAy9xBW8YsGkjzSUb/zEYjVuT4=;
 b=TfDMwaz521rHVi1k987MRJgKkap2ugXubOyqpJVU2Q93zvKGLf2hICDt+2uB2toEac
 kPaU0UZNSzolmrzZZVACIeSd9lf6yOnEnkPcM6wQzvk54RMugaO2bxMjzYfbRi3/cjoF
 E76sgeLL3sXIeil9vXdXrjwhGNtIv29QhykkN8iUEPvFsEXEXNX+YU1mOqvUYxsvlMJT
 GA8VSP27vnVjgxWpYezQb4H9nOxPn/Rhdhw2C2ZLNJISKMlT1YQm/OKFDo74qa+eMe83
 rkETWOVUz307QxzBlZ+YAGcY+LvZ1f3OAJQusAo1yKy01nsYsGxRUPv1r8ZqjA6rHgu9
 OqcQ==
X-Gm-Message-State: AOJu0YzBr/kT2yK9ehzSNMUQAtNA7zLBAnYTXhwlSpbbDIxOUPrRgi+q
 wqiWHzlSyWCy82/4OPCKTExSlBvOJ4QNNTQxEvbggFHe4V2gzW0lKuKfeRx0nrMBmtmsSnyV92j
 V
X-Google-Smtp-Source: AGHT+IHxUDfU2VHMruB5dvPrXB9Ntp1GvXhJu9zIrnmDolYYqqZcCoFZXPFuwJhT0V53uGBdSRb/XQ==
X-Received: by 2002:a05:600c:1c85:b0:42c:b9a5:ebae with SMTP id
 5b1f17b1804b1-42cdb5385c8mr53628995e9.9.1726240465774; 
 Fri, 13 Sep 2024 08:14:25 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42d9b16bfbfsm29152325e9.22.2024.09.13.08.14.25
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Sep 2024 08:14:25 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 23/27] hw/net/can/xlnx-versal-canfd: Fix FIFO issues
Date: Fri, 13 Sep 2024 16:14:07 +0100
Message-Id: <20240913151411.2167922-24-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240913151411.2167922-1-peter.maydell@linaro.org>
References: <20240913151411.2167922-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
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

From: Doug Brown <doug@schmorgal.com>

The read index should not be changed when storing a new message into the
RX or TX FIFO. Changing it at this point will cause the reader to get
out of sync. The wrapping of the read index is already handled by the
pre-write functions for the FIFO status registers anyway.

Additionally, the calculation for wrapping the store index was off by
one, which caused new messages to be written to the wrong location in
the FIFO. This caused incorrect messages to be delivered.

Signed-off-by: Doug Brown <doug@schmorgal.com>
Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
Message-id: 20240827034927.66659-8-doug@schmorgal.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/net/can/xlnx-versal-canfd.c | 36 +++-------------------------------
 1 file changed, 3 insertions(+), 33 deletions(-)

diff --git a/hw/net/can/xlnx-versal-canfd.c b/hw/net/can/xlnx-versal-canfd.c
index ccfed364cc9..e148bd7b465 100644
--- a/hw/net/can/xlnx-versal-canfd.c
+++ b/hw/net/can/xlnx-versal-canfd.c
@@ -1144,18 +1144,8 @@ static void update_rx_sequential(XlnxVersalCANFDState *s,
             read_index = ARRAY_FIELD_EX32(s->regs, RX_FIFO_STATUS_REGISTER, RI);
             store_index = read_index + fill_level;
 
-            if (read_index == s->cfg.rx0_fifo - 1) {
-                /*
-                 * When ri is s->cfg.rx0_fifo - 1 i.e. max, it goes cyclic that
-                 * means we reset the ri to 0x0.
-                 */
-                read_index = 0;
-                ARRAY_FIELD_DP32(s->regs, RX_FIFO_STATUS_REGISTER, RI,
-                                 read_index);
-            }
-
             if (store_index > s->cfg.rx0_fifo - 1) {
-                store_index -= s->cfg.rx0_fifo - 1;
+                store_index -= s->cfg.rx0_fifo;
             }
 
             store_location = R_RB_ID_REGISTER +
@@ -1172,18 +1162,8 @@ static void update_rx_sequential(XlnxVersalCANFDState *s,
                                           RI_1);
             store_index = read_index + fill_level;
 
-            if (read_index == s->cfg.rx1_fifo - 1) {
-                /*
-                 * When ri is s->cfg.rx1_fifo - 1 i.e. max, it goes cyclic that
-                 * means we reset the ri to 0x0.
-                 */
-                read_index = 0;
-                ARRAY_FIELD_DP32(s->regs, RX_FIFO_STATUS_REGISTER, RI_1,
-                                 read_index);
-            }
-
             if (store_index > s->cfg.rx1_fifo - 1) {
-                store_index -= s->cfg.rx1_fifo - 1;
+                store_index -= s->cfg.rx1_fifo;
             }
 
             store_location = R_RB_ID_REGISTER_1 +
@@ -1265,18 +1245,8 @@ static void tx_fifo_stamp(XlnxVersalCANFDState *s, uint32_t tb0_regid)
                           " Discarding the message\n");
             ARRAY_FIELD_DP32(s->regs, INTERRUPT_STATUS_REGISTER, TXEOFLW, 1);
         } else {
-            if (read_index == s->cfg.tx_fifo - 1) {
-                /*
-                 * When ri is s->cfg.tx_fifo - 1 i.e. max, it goes cyclic that
-                 * means we reset the ri to 0x0.
-                 */
-                read_index = 0;
-                ARRAY_FIELD_DP32(s->regs, TX_EVENT_FIFO_STATUS_REGISTER, TXE_RI,
-                                 read_index);
-            }
-
             if (store_index > s->cfg.tx_fifo - 1) {
-                store_index -= s->cfg.tx_fifo - 1;
+                store_index -= s->cfg.tx_fifo;
             }
 
             assert(store_index < s->cfg.tx_fifo);
-- 
2.34.1


