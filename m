Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AADFCCD98CE
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 22:19:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZFeO-0004zj-W3; Mon, 15 Jun 2026 18:19:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3X3owagcKCm4VdTUXWQSaaSXQ.OaYcQYg-PQhQXZaZSZg.adS@flex--jrhilke.bounces.google.com>)
 id 1wZFeK-0004vu-KD
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 18:19:22 -0400
Received: from mail-pj1-x1049.google.com ([2607:f8b0:4864:20::1049])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3X3owagcKCm4VdTUXWQSaaSXQ.OaYcQYg-PQhQXZaZSZg.adS@flex--jrhilke.bounces.google.com>)
 id 1wZFeI-0008ND-9b
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 18:19:20 -0400
Received: by mail-pj1-x1049.google.com with SMTP id
 98e67ed59e1d1-36d98b74447so3092867a91.2
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 15:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1781561951; x=1782166751; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=eOKAi0jvceWVaBXIW4WG1tFWvFk5cjTpiZMy09F5ILY=;
 b=uSV9Io2+SaAT+We5gU+AwldX4KyM/+yCMjBPTpLnvEFuJHs/P49dUqigyr++mxOxVv
 lr6qLVl9fyYPUwxmRQtKFMZ0mw37dUk5cGBIlXSls43ilz0uw5PSdnQSxoPiqjPNW5us
 5F/x4djTSfNWj02qVs/qvZ0ER1TYDq3iq4MnbiZdbzDm83foBojPKA5t+iwC68+xnGdO
 kID4/OvpDKuYhGEEOP0gzMtGT4LhQSGKEo6bvdu9Af9DGU+NSVPP9Ysz4PQtqJAhjx1w
 8iv8R+X5ru9Q31yMbrSO2LJJ7NKyryVF6ZAGbQHyCgzpNfMjo9nThOnChZgvhTe6A/Y/
 l3xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781561951; x=1782166751;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eOKAi0jvceWVaBXIW4WG1tFWvFk5cjTpiZMy09F5ILY=;
 b=C8sK5ZcjGzHsC1Mf/foxuR++1boXEmi5j0tMdSE9d/RrrYGgYIVqiRckf9MBOghtwW
 9QlnFQRgKPQvS1kpzNDZOg0siG2T+s6CjlelYLMYsqYlu+OKgB+8S5H1/MCW/DPdrUfo
 7xwBUi4PfHPdwQffkShKKTZpuOGXc9+/I5DWXcLDG20xsFHkuAwqYvddS1o7ZP97txTa
 ql7MY2Oge7mbce2BDdFqEhSqCYW/62YB96WosOlK/OVLeJVdn1Fv0klvhClXyMQpR1Kn
 WxjzWglAGlbPfW98GIeEUxSa+vNVptS6PYxbD+AmkHZgF3dWRSOcWSxL7e3vGkA/HNOh
 70Jw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/RiA8LZ+tVJElSH3+IaXBybvgji1FdkJGnCoiA1AV4RHNa15XMOZDZMOAafzae0bhHVOiR48I+FBX+@nongnu.org
X-Gm-Message-State: AOJu0Yyfclw//oMC1S3P7zxr3CrGHaDFk6GJ9ZJ+jImXva5rUo0othPa
 ocGvgfyxbcDHR3Pee9mJ4+Ahq5XPOdZnl9pDXcWVDsf3P9dKjO8VfYdYmPr8JTyjYcjEgpvEKDA
 wiFKZA2KH
X-Received: from pjl5.prod.google.com ([2002:a17:90b:2f85:b0:368:bb57:bcb7])
 (user=jrhilke job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:38d2:b0:36e:2106:dedc
 with SMTP id 98e67ed59e1d1-37c52923dbdmr930176a91.22.1781561951194; Mon, 15
 Jun 2026 15:19:11 -0700 (PDT)
Date: Mon, 15 Jun 2026 22:18:06 +0000
In-Reply-To: <20260615-igb-trl-v4-0-cf5739bf529f@google.com>
Mime-Version: 1.0
References: <20260615-igb-trl-v4-0-cf5739bf529f@google.com>
X-Mailer: b4 0.14.3
Message-ID: <20260615-igb-trl-v4-4-cf5739bf529f@google.com>
Subject: [PATCH v4 4/7] igb: Refactor TX path to return processed byte count
From: Josh Hilke <jrhilke@google.com>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-devel@nongnu.org
Cc: Josh Hilke <jrhilke@google.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>, 
 Jason Wang <jasowang@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 David Matlack <dmatlack@google.com>,
 Alex Williamson <alex.williamson@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1049;
 envelope-from=3X3owagcKCm4VdTUXWQSaaSXQ.OaYcQYg-PQhQXZaZSZg.adS@flex--jrhilke.bounces.google.com;
 helo=mail-pj1-x1049.google.com
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
index dea8136..fac4c44 100644
--- a/hw/net/igb_core.c
+++ b/hw/net/igb_core.c
@@ -600,7 +600,7 @@ igb_on_tx_done_update_stats(IGBCore *core, struct NetTxPkt *tx_pkt, int qn)
     }
 }
 
-static void
+static size_t
 igb_process_tx_desc(IGBCore *core,
                     PCIDevice *dev,
                     struct igb_tx *tx,
@@ -633,10 +633,10 @@ igb_process_tx_desc(IGBCore *core,
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
@@ -655,11 +655,13 @@ igb_process_tx_desc(IGBCore *core,
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
@@ -676,7 +678,9 @@ igb_process_tx_desc(IGBCore *core,
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


