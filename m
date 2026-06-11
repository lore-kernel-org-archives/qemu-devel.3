Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64C75CD98D5
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2026 00:02:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXpLw-0002Ce-87; Thu, 11 Jun 2026 20:02:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3zSQragcKChwBJ9ADC68GG8D6.4GEI6EM-56N6DFGF8FM.GJ8@flex--jrhilke.bounces.google.com>)
 id 1wXmho-0000zh-SK
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 17:12:53 -0400
Received: from mail-pf1-x449.google.com ([2607:f8b0:4864:20::449])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3zSQragcKChwBJ9ADC68GG8D6.4GEI6EM-56N6DFGF8FM.GJ8@flex--jrhilke.bounces.google.com>)
 id 1wXmhl-0003o9-6m
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 17:12:51 -0400
Received: by mail-pf1-x449.google.com with SMTP id
 d2e1a72fcca58-8422382178bso185132b3a.2
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 14:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1781212366; x=1781817166; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=YrpnyWY6NdUpkf/BBaAQQB93oC6zEFtKos4E5qLpdeU=;
 b=uQk9x/St4V0+oRKuah0yET8DaYl2LXXvhaml480LyKUWCkNktSikFwTRFikqNvcD1d
 nKNkam/DGsTRdhfHL/pG3KmBHr3dhWA58jf++TlCnlKSkQ5y1q0k7qxa4YSD1eOYd7SW
 Nkiq+/2vvvifWFdup74h20WEF6mPTVicdGEqkEq3AdW8jctGnk3Q0C8ZKF7yCtI1XJ00
 zbdV34epWaMDlTOfHHhFJzarBFCTAyAo++4oVxaqqSpTDUaK+BIEb3qJHMyJpc/B7oN1
 EvisCFqK3eA3fP+aYJCqloS1CaCKjFLcG3tCg3+Umb1SP6NXVoBEVjMqnS+H3WBbW7xH
 aEtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781212366; x=1781817166;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YrpnyWY6NdUpkf/BBaAQQB93oC6zEFtKos4E5qLpdeU=;
 b=okm65R2359xkXEpwnXZ4QrvpgUa+DXt+7ABjYWUCElQXAp4dSoewRkumYAYSDcwUqi
 jarHf8JqDdXlfrwFT8IIes8mFiXSJ0nOIClJD2xRtrdVAvi6B2t+Hh3IvndQSrZniwHS
 B+BKIIP7deZ7fVYLBCiN9br6tzz6Vqz7POAuOjAvFjK0vYctnQQ7jdsDozA9FwISoA6C
 2ZmuvGaFwMKUO61tVoWAb8f+CbwW6naFV1vnOjYgrSwpXJHi6wHTETb11S4YK2wypHBt
 /4jZYoX0IMcB/KnWYVmh7OLP160tcGoYskdEYta/+NSvCZnV/gpXuJKnI1jeCcQewgwi
 GSVQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+Rl03/Lm96uOFGr0GLBMADoLEgatKhbQ7G+RO2VZhncsZAQneRspR0bEOKiGspusfNY+grkOVogOBW@nongnu.org
X-Gm-Message-State: AOJu0YyMxlcCAweDmVvypk7Lai8Ln2vGRc8dhV3Hp3SsqiEVydaOtRjJ
 sOtnKkKfN9OSzpkQEQJ12+1TcfdMG5Xttq3An2OrAVtu0r5bFdbfYfjieOFnNfhofZzH1dD3CG1
 2LgukEJ0N
X-Received: from pfbll5.prod.google.com ([2002:a05:6a00:7285:b0:842:49cf:8c4b])
 (user=jrhilke job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:1701:b0:842:3be7:4d57
 with SMTP id d2e1a72fcca58-843368068e9mr4995056b3a.18.1781212365878; Thu, 11
 Jun 2026 14:12:45 -0700 (PDT)
Date: Thu, 11 Jun 2026 21:11:29 +0000
In-Reply-To: <20260611-igb-trl-v2-0-bd58de9eb0fa@google.com>
Mime-Version: 1.0
References: <20260611-igb-trl-v2-0-bd58de9eb0fa@google.com>
X-Mailer: b4 0.14.3
Message-ID: <20260611-igb-trl-v2-4-bd58de9eb0fa@google.com>
Subject: [PATCH v2 4/7] igb: Refactor TX path to return processed byte count
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
 envelope-from=3zSQragcKChwBJ9ADC68GG8D6.4GEI6EM-56N6DFGF8FM.GJ8@flex--jrhilke.bounces.google.com;
 helo=mail-pf1-x449.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 11 Jun 2026 20:02:23 -0400
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
index 90d94d4..1c05276 100644
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


