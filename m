Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7BF0CD98E1
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 22:37:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZcOD-0007OD-C9; Tue, 16 Jun 2026 18:36:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <31c8xagcKCpQ7F569824CC492.0CAE2AI-12J29BCB4BI.CF4@flex--jrhilke.bounces.google.com>)
 id 1wZcOA-0007NE-CB
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 18:36:10 -0400
Received: from mail-pg1-x549.google.com ([2607:f8b0:4864:20::549])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <31c8xagcKCpQ7F569824CC492.0CAE2AI-12J29BCB4BI.CF4@flex--jrhilke.bounces.google.com>)
 id 1wZcO7-0001cn-Q1
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 18:36:09 -0400
Received: by mail-pg1-x549.google.com with SMTP id
 41be03b00d2f7-c8611b27631so168391a12.0
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 15:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1781649366; x=1782254166; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=i8sboYZs+AgO+kK/lrxvBnKXQH9QR1x6gV2ECBQVB50=;
 b=IyRhGQUKUAEkBGeId5fj9yloMGe6twIN9JKLXOGpFYainZNuJZ9U6V9xc45cwOK3ax
 i1QH3NmNt4+YK2kpV0cPyhZn3oYh0wWJ6YkP5PuPujpXjxzw5/z8NUKOliLZcwpBRhyx
 HwumyhIXaNtRCHfjAX+Cma6RZPbiH/F4TFJXleq6hmsjAR9Nd+J0CaVWY1fiG+lqoNCT
 UPq9wsiN9U5+m3TEOJaEoSVazOE4mmu6btLWZ+REK0NpYgvFG7/GZCBB7JPquzvhgk9r
 1RF+DKE5fre9vXx9U6GkMwxtBEgg9JCCA9mBkqxMTU8gf8ISufeJ9XydgeO5vtHVxnG9
 OHRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781649366; x=1782254166;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=i8sboYZs+AgO+kK/lrxvBnKXQH9QR1x6gV2ECBQVB50=;
 b=kaOebNc9HPnkPiNPl3M4N4wquopBnSq3Fu4hJY3c3omBgo3IS01Ckjz3UxmyLqFq6S
 7oNZbA/eiMMDcP9N4Z7/3cntgxVCxNoncrBVKUsqoUu3hKgqBeIGL9ITKMrH95eXnwrV
 F+ipSt9+XkupwvfjrkHNucZvhzZ0X5P/onBlFujQtNaaqNmTossTqcxMlg34yQYvO8vY
 w3l7odHBlAPCoI6hTZTR/KZzRSStEEbF8pF2kBLU/KoVWIRYnIDm6FsfD1LXgqdhr2sV
 7aCi+6hE3W+rwquGsJ0UCS+RQEt3Z8pQHryDUPZc6TfzbtDJrkDMDhWzf47gQY3dumie
 jxNQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8sTrFo+MyoVdCXa6BQhAu4yEHXj5u0AMFpldqTdly5jlF4CW1KmWYCyAFYwifni9zeNkMO77FztQ9o@nongnu.org
X-Gm-Message-State: AOJu0YzScfNumLkjPIXHsfa4WJ8hCJcd2rn/QNU1R+9TCTnoN+BSrj/D
 4hx58sQ+pU7W9KBYJhz1vRN+s0+rc81kpE8LCNNlFLHYdCmTZ7073ubJmk0r8ztfTMG/ucqGoOy
 mH7bLlW08
X-Received: from pld5.prod.google.com ([2002:a17:903:3545:b0:2c2:dcfe:8f73])
 (user=jrhilke job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:f549:b0:2c6:b3dc:b838
 with SMTP id d9443c01a7336-2c6bd11dc47mr4061275ad.18.1781649365657; Tue, 16
 Jun 2026 15:36:05 -0700 (PDT)
Date: Tue, 16 Jun 2026 22:35:31 +0000
In-Reply-To: <20260616-igb-trl-v5-0-1183e3635e06@google.com>
Mime-Version: 1.0
References: <20260616-igb-trl-v5-0-1183e3635e06@google.com>
X-Mailer: b4 0.14.3
Message-ID: <20260616-igb-trl-v5-4-1183e3635e06@google.com>
Subject: [PATCH v5 4/7] igb: Refactor TX path to return processed byte count
From: Josh Hilke <jrhilke@google.com>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-devel@nongnu.org
Cc: Josh Hilke <jrhilke@google.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>, 
 Jason Wang <jasowang@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 David Matlack <dmatlack@google.com>,
 Alex Williamson <alex.williamson@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::549;
 envelope-from=31c8xagcKCpQ7F569824CC492.0CAE2AI-12J29BCB4BI.CF4@flex--jrhilke.bounces.google.com;
 helo=mail-pg1-x549.google.com
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
index fb31e37..b7f880e 100644
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
2.54.0.1136.gdb2ca164c4-goog


