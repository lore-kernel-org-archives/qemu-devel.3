Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09318CD98F0
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 20:17:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZwgH-0002bc-AT; Wed, 17 Jun 2026 16:16:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3iAAzagcKCq0WeUVYXRTbbTYR.PbZdRZh-QRiRYabaTah.beT@flex--jrhilke.bounces.google.com>)
 id 1wZwgG-0002bF-AC
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 16:16:12 -0400
Received: from mail-pg1-x54a.google.com ([2607:f8b0:4864:20::54a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3iAAzagcKCq0WeUVYXRTbbTYR.PbZdRZh-QRiRYabaTah.beT@flex--jrhilke.bounces.google.com>)
 id 1wZwgE-0002u2-SW
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 16:16:12 -0400
Received: by mail-pg1-x54a.google.com with SMTP id
 41be03b00d2f7-c8582b167f7so111220a12.0
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 13:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1781727369; x=1782332169; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=GYlI/RPJAOu9sVPxOCzznuMsF7sHk3l3K3UNAlhhfls=;
 b=bNzbaMLuaDorgfTshGlwZYXmv5Te8MiOU1k6LT8qVn/iMJ9mTl87LlywickI9hgQl5
 +2JmJz19yWjS9irqqiv9OCCLVWNg7eeDyIlxh2hFGyMjrjPL7pLGYuP4Sqk1NRlViunF
 0GY7DQFg2w1SNLAqlZEtY/cFyGD8+F2zGfisViOjcpam3iaNalc6m+yH7pXM03k9c5dR
 Mfx7IdU7AwJdMAiuavo4e9S8OAxafYtOqNYsbEOcN+UZW5YszzuZjHKM2X+di/Ph9/1U
 WF0uOFIjldGMPuywSX01GuMv1JcJgsCQBa5+Wkd1Z2YeY1eptK7iqacedGdLk+hStn3G
 LgRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781727369; x=1782332169;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GYlI/RPJAOu9sVPxOCzznuMsF7sHk3l3K3UNAlhhfls=;
 b=lPt3UDNmSE++fSWsy6tI93D18cg0xZNiZM8iFBMUK+SIaVR6DBANm9mvmwLRCWXqKL
 hkN+QqfLNU5/B5PuItcp9ormtilTx4zITmq/qwuyy+lbUfZXH/6/FrAX0NgQ9P1iWU4r
 p8n0wU0mpZB1f6eGuA9Fw5wp83h2j0vqv1GT3fxY79Q+2lF5ts7L3JammkJPLQr7VvIm
 LwpeKgvDwrdfJU8e3WDv6nIc/Y4JYiMallMFy+7fLCEGwfDGeVdhki0egHXJlSwibiVT
 kbLi2qUa8G+AAH1Sg6e7vjEZ14OlCRj7geWSMqWre5hwjACBAIP5zhfXboUCAIPmr0b+
 r+yg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9e59B5S06aET3lhBsX9N6ha35Jjp/Qa8SenlF7c2hfqpdVY6pq8cUXPzxkpmbuZAEoBE6yKjGXCuwL@nongnu.org
X-Gm-Message-State: AOJu0YxohQR7yJM/lgl3rfSwn0CQ2Tvi9idnEp0iBO7TRIPnHnv1prKI
 qyht8NqgVaU5VdKk3yTGMZh1xIl49GBPMaFqKmGNTOR2tqd2WCmV5/viKApIcIBi5uzri1ZP1J/
 aJwetgPQD
X-Received: from pgac18.prod.google.com ([2002:a05:6a02:2952:b0:c85:fff:9472])
 (user=jrhilke job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:3d02:b0:3b3:1951:489b
 with SMTP id adf61e73a8af0-3b8b85fc238mr6459441637.45.1781727368708; Wed, 17
 Jun 2026 13:16:08 -0700 (PDT)
Date: Wed, 17 Jun 2026 20:15:49 +0000
In-Reply-To: <20260617-igb-trl-v6-0-bbdfcadb81e2@google.com>
Mime-Version: 1.0
References: <20260617-igb-trl-v6-0-bbdfcadb81e2@google.com>
X-Mailer: b4 0.14.3
Message-ID: <20260617-igb-trl-v6-4-bbdfcadb81e2@google.com>
Subject: [PATCH v6 4/7] igb: Refactor TX path to return processed byte count
From: Josh Hilke <jrhilke@google.com>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-devel@nongnu.org
Cc: Josh Hilke <jrhilke@google.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>, 
 Jason Wang <jasowang@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 David Matlack <dmatlack@google.com>,
 Alex Williamson <alex.williamson@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::54a;
 envelope-from=3iAAzagcKCq0WeUVYXRTbbTYR.PbZdRZh-QRiRYabaTah.beT@flex--jrhilke.bounces.google.com;
 helo=mail-pg1-x54a.google.com
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
index 65403f9..693353e 100644
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
@@ -654,11 +654,13 @@ igb_process_tx_desc(IGBCore *core,
     }
 
     if (cmd_type_len & E1000_TXD_CMD_EOP) {
+        size_t total_len = 0;
         if (!tx->skip_cp && net_tx_pkt_parse(tx->tx_pkt)) {
             idx = (tx->first_olinfo_status >> 4) & 1;
             igb_tx_insert_vlan(core, queue_index, tx,
                 tx->ctx[idx].vlan_macip_lens >> IGB_TX_FLAGS_VLAN_SHIFT,
                 !!(tx->first_cmd_type_len & E1000_TXD_CMD_VLE));
+            total_len = net_tx_pkt_get_total_len(tx->tx_pkt);
 
             if ((tx->first_cmd_type_len & E1000_ADVTXD_MAC_TSTAMP) &&
                 (core->mac[TSYNCTXCTL] & E1000_TSYNCTXCTL_ENABLED) &&
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
2.55.0.rc0.738.g0c8ab3ebcc-goog


