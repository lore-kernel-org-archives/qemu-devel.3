Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AFD6CD98C6
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 04:29:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXX1m-0001ZD-9r; Thu, 11 Jun 2026 00:28:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <33R0qagcKCho9H78BA46EE6B4.2ECG4CK-34L4BDED6DK.EH6@flex--jrhilke.bounces.google.com>)
 id 1wXVC5-0002pp-9z
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 22:30:57 -0400
Received: from mail-pg1-x54a.google.com ([2607:f8b0:4864:20::54a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <33R0qagcKCho9H78BA46EE6B4.2ECG4CK-34L4BDED6DK.EH6@flex--jrhilke.bounces.google.com>)
 id 1wXVC3-0005Jj-Sz
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 22:30:57 -0400
Received: by mail-pg1-x54a.google.com with SMTP id
 41be03b00d2f7-c8584e80bfcso3268513a12.3
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 19:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1781145053; x=1781749853; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=ma924iyC011nf7ybJLZ1S9bbLOL/NtLR70XgfBI0bQY=;
 b=h/Q8frplXmPFzEQc/a9OS8vel5HcxBg9pAJqxIHL+mUXsSj2Qvg4yZ9MvR+122oGJr
 y8epVM5WhKoipV4cyqdotNJ0MwFbRH4dHH64W7VNr/31ZZyzxpC5PweiUKeuhX8AtEqu
 DQupy7RxYhvpJKuujR8n32hah6HdLI3i2H/h0Rlwx/MbY78ksTY7lyMalxYJK6SDJeF0
 jqgGQ0z4tSP96+3w+JyuFyWjV5JjDH9xnAFhpSspZ2Tf9riE51SkpcZK/INbCvwtpLte
 dlFLRBRi7xGY3GGSfwEGPk6LXtSxGrhfLBwdjpkb+oTqZQOm11c1i1Jh6eTuP3hgQFXc
 imkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781145053; x=1781749853;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ma924iyC011nf7ybJLZ1S9bbLOL/NtLR70XgfBI0bQY=;
 b=fqEkElSk6YnaEHWMcGiUtrH6GXC8+guxYi77aGkLwU+js2DEzD2G/8uDUqxbTT1b7D
 IxisKqkbZVzVZcDZ6d5Ube1h+hWWc6leXMvdqjBaCHBm40Cfd1YBX2AB1Nh5ZmnFjbmJ
 urf7VgnaaXpzma8VGhL4tprtGC+mDbo2v9wOWhy4QjFbgRk+8YvHfhOd8w6Po0GhTlC+
 v8hr7nd2kb8Z+TfEeeWm0Wp+PDhsJJeFn8g4bjSelYLs2LSdhGKXB43aFr7VP8ffGFc1
 ObTB4dVSw1QtPlI4XM5g629rzqMDvpTEyT/JxIn/ezkmWtQYL37vr0XXGRJktt0O1bQI
 vw5A==
X-Gm-Message-State: AOJu0YxkFlOuIZG4wfNaHV69acteGC3B4eLMMjVW5uKCmA+bFwnByr0k
 hynMjmUHAVc5dBM9GIIsM8A9jS2TzvO0i2o/u9xuEC7tCxdaMuM1tkdH8Li1eQYZTDFX932dMND
 sgaw5sgwVUdgAfvDbFkgWMQcTDSSbMbxQnJ1ATUEE/O6bmMNQCWXFV7Hg6m3OsdMCepXYh8VXIt
 BQt+5grNk+dOC6/vRvDVQvL0voqd2DVmsD01IloNc=
X-Received: from pgac18.prod.google.com ([2002:a05:6a02:2952:b0:c79:8315:4734])
 (user=jrhilke job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:c887:b0:3b4:9124:ae14
 with SMTP id adf61e73a8af0-3b5e31e23c8mr693363637.11.1781145053107; Wed, 10
 Jun 2026 19:30:53 -0700 (PDT)
Date: Thu, 11 Jun 2026 02:30:26 +0000
In-Reply-To: <20260611023028.102071-1-jrhilke@google.com>
Mime-Version: 1.0
References: <20260611023028.102071-1-jrhilke@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260611023028.102071-4-jrhilke@google.com>
Subject: [PATCH 3/5] igb: Refactor TX path to return processed byte count
From: Josh Hilke <jrhilke@google.com>
To: qemu-devel@nongnu.org, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: Josh Hilke <jrhilke@google.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>, 
 Jason Wang <jasowang@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 David Matlack <dmatlack@google.com>,
 Alex Williamson <alex.williamson@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::54a;
 envelope-from=33R0qagcKCho9H78BA46EE6B4.2ECG4CK-34L4BDED6DK.EH6@flex--jrhilke.bounces.google.com;
 helo=mail-pg1-x54a.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 11 Jun 2026 00:28:24 -0400
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
index 3bb4649..9ed0e78 100644
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


