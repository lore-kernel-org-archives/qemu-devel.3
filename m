Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29216CD98CF
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2026 21:51:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wY9m6-00023t-JU; Fri, 12 Jun 2026 17:50:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3NH8sagcKCj0iqghkjdfnnfkd.bnlpdlt-cdudkmnmfmt.nqf@flex--jrhilke.bounces.google.com>)
 id 1wY9m5-00023K-C2
 for qemu-devel@nongnu.org; Fri, 12 Jun 2026 17:50:49 -0400
Received: from mail-pf1-x449.google.com ([2607:f8b0:4864:20::449])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3NH8sagcKCj0iqghkjdfnnfkd.bnlpdlt-cdudkmnmfmt.nqf@flex--jrhilke.bounces.google.com>)
 id 1wY9m3-0005JH-Me
 for qemu-devel@nongnu.org; Fri, 12 Jun 2026 17:50:49 -0400
Received: by mail-pf1-x449.google.com with SMTP id
 d2e1a72fcca58-8421ffff8a3so1799998b3a.2
 for <qemu-devel@nongnu.org>; Fri, 12 Jun 2026 14:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1781301045; x=1781905845; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=DscT2u9TJqheLznAg/uVIVkF6I2gMms9Ny27onDAukk=;
 b=IOs+rm9WV1ysIe/jVDbCVv50WsrUQ2yAjRJoJn+/1Hixya6XXgGFPGAFXC9UwDcYck
 GldV+RPZUOXghSXA/zWcQuKazRwJNZRny+GP9aDctoJMtsKaE38hkNHqGXPXPq/ZbDdR
 GU502Zm73kDnTjJLULZGQsoOoyDx4aCQkNRgFGBK6+iUZmmpy+7jZMdaMizyZx/hsG/+
 HJEJy0s1uySbpsnNvVC3ZamMd8e4u+BQ0IdNjtooTWdpHSrdjhphXF3QqawKt/eJ/ft7
 3Vp5Gye99J8ulN693JLGky22Ty9gyWdvZWsGuVKW7uhh16e/y6DhH0Iy9qWL/FokUw1y
 FDiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781301045; x=1781905845;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DscT2u9TJqheLznAg/uVIVkF6I2gMms9Ny27onDAukk=;
 b=tWhmE60SHMqcoR6E/XoAKZfJDyjgKUKMupKK0L9eFT8EWgc06eMiUNTHl1i2D2HZla
 7YB2oNKB5SeIgcysz8dhJ03sGXiof7Y3aPyEcm4/gmBr5raGfqjey3hnDzqFM76AE+It
 ljnp3Z99onrO9KoZ48GZARSd1yi6h0sDk/Qn8Jsl83e0VYokwTzof6QzMKQkOa2z+yDj
 SjQJ8bRhFG1ERoKROy/bnUnF4RZ0sNR4vdEQLCBThtgHKCn6m3N/fmKcBWJD/AFUygTv
 9gmaatWve1ENTQQf9HHug56T+GIvtKa29TCu9kns1HyU4tpAOFgl+WuEWP4Wev/cMJFA
 Tf8A==
X-Forwarded-Encrypted: i=1;
 AFNElJ9q408fD5nNixxUyALOKcXUzptNMKZwkqQW82Puq1TIIwvt+eaqcEjnCy0g6RSb0I/N20e3c5igU+pP@nongnu.org
X-Gm-Message-State: AOJu0YwBziyItW7DW+wGODrAM+xkU59OrZCdZGt+Wzahy/ZAVlnDBkrO
 8Xdd73Ccs5Oxs8vGhHJz9mHh9EbCPwAyyd+5s60coxZy2NdTPBZzotubNeMhNqkxw9jUMzY+Ek5
 QXQlfaYDz
X-Received: from pfbhw7.prod.google.com ([2002:a05:6a00:8907:b0:842:26f2:e602])
 (user=jrhilke job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:8d6:b0:82f:623f:e5b3
 with SMTP id d2e1a72fcca58-8434ce8ada9mr5084456b3a.34.1781301044702; Fri, 12
 Jun 2026 14:50:44 -0700 (PDT)
Date: Fri, 12 Jun 2026 21:50:15 +0000
In-Reply-To: <20260612-igb-trl-v3-0-19607f9a3dde@google.com>
Mime-Version: 1.0
References: <20260612-igb-trl-v3-0-19607f9a3dde@google.com>
X-Mailer: b4 0.14.3
Message-ID: <20260612-igb-trl-v3-4-19607f9a3dde@google.com>
Subject: [PATCH v3 4/7] igb: Refactor TX path to return processed byte count
From: Josh Hilke <jrhilke@google.com>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-devel@nongnu.org
Cc: Josh Hilke <jrhilke@google.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>, 
 Jason Wang <jasowang@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 David Matlack <dmatlack@google.com>,
 Alex Williamson <alex.williamson@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::449;
 envelope-from=3NH8sagcKCj0iqghkjdfnnfkd.bnlpdlt-cdudkmnmfmt.nqf@flex--jrhilke.bounces.google.com;
 helo=mail-pf1-x449.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

Modify igb_process_tx_desc to return the total size of the transmitted
packet (in bytes) when processing the End of Packet (EOP) descriptor,
and 0 otherwise. This allows the transmission loop to track how many
bytes are being sent for rate-limiting calculations.

Signed-off-by: Josh Hilke <jrhilke@google.com>
---
 hw/net/igb_core.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/hw/net/igb_core.c b/hw/net/igb_core.c
index 3eddfbe..4670c1e 100644
--- a/hw/net/igb_core.c
+++ b/hw/net/igb_core.c
@@ -599,7 +599,7 @@ igb_on_tx_done_update_stats(IGBCore *core, struct NetTxPkt *tx_pkt, int qn)
     }
 }
 
-static void
+static size_t
 igb_process_tx_desc(IGBCore *core,
                     PCIDevice *dev,
                     struct igb_tx *tx,
@@ -632,10 +632,10 @@ igb_process_tx_desc(IGBCore *core,
             tx->ctx[idx].seqnum_seed = le32_to_cpu(tx_ctx_desc->seqnum_seed);
             tx->ctx[idx].type_tucmd_mlhl = le32_to_cpu(tx_ctx_desc->type_tucmd_mlhl);
             tx->ctx[idx].mss_l4len_idx = le32_to_cpu(tx_ctx_desc->mss_l4len_idx);
-            return;
+            return 0;
         } else {
             /* unknown descriptor type */
-            return;
+            return 0;
         }
     } else {
         /* legacy descriptor */
@@ -654,7 +654,9 @@ igb_process_tx_desc(IGBCore *core,
     }
 
     if (cmd_type_len & E1000_TXD_CMD_EOP) {
+        size_t total_len = 0;
         if (!tx->skip_cp && net_tx_pkt_parse(tx->tx_pkt)) {
+            total_len = net_tx_pkt_get_total_len(tx->tx_pkt);
             idx = (tx->first_olinfo_status >> 4) & 1;
             igb_tx_insert_vlan(core, queue_index, tx,
                 tx->ctx[idx].vlan_macip_lens >> IGB_TX_FLAGS_VLAN_SHIFT,
@@ -675,7 +677,9 @@ igb_process_tx_desc(IGBCore *core,
         tx->first = true;
         tx->skip_cp = false;
         net_tx_pkt_reset(tx->tx_pkt, net_tx_pkt_unmap_frag_pci, dev);
+        return total_len;
     }
+    return 0;
 }
 
 static uint32_t igb_tx_wb_eic(IGBCore *core, int queue_idx)

-- 
2.54.0.1136.gdb2ca164c4-goog


