Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F40CBCDB479
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 15:07:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wc2iS-0006of-I7; Tue, 23 Jun 2026 11:07:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3_qA6agcKCoMqyopsrlnvvnsl.jvtxlt1-kl2lsuvunu1.vyn@flex--jrhilke.bounces.google.com>)
 id 1wc2i2-0006jZ-F3
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 11:06:47 -0400
Received: from mail-pj1-x104a.google.com ([2607:f8b0:4864:20::104a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3_qA6agcKCoMqyopsrlnvvnsl.jvtxlt1-kl2lsuvunu1.vyn@flex--jrhilke.bounces.google.com>)
 id 1wc2i0-0006oy-DO
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 11:06:41 -0400
Received: by mail-pj1-x104a.google.com with SMTP id
 98e67ed59e1d1-36bba9b849dso29867a91.1
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 08:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1782227199; x=1782831999; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
 :reply-to; bh=UBRgHg7zBT9dDU9XG5F8KOgfMU/+ygbpAlA+5C2uefE=;
 b=LeHvhMqVSfkJcyM806TAieISoGwOO/BCJhjOCqdPaXo6f47gKPnwJAQN7sjY8isi3h
 PvLs2mz7pNQAs3q5GgOCxmSEA9nbL4P9RGYAGaKzEZy6oRT0VTG+VWQP9AxbG6+z8pZf
 uTTurUEVSS287hMIelUGWy6wnxF1MjpxtSQZ7isJKJDFnlLfev3nUMTUL4yGfy4WOn8A
 iDPCL147ahKg/lV9UnZAf9SFXdGifOyWSr6iRBUVNv0ajsF2aKQVkA9Kx0FZHcAyZBbE
 YxNxfiYP+WAc4K3yBk9oi3ZNlaVDoMwrr/a7766UP7XTAPIePnvjAUMhR6hbGUYzN0eA
 L1dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782227199; x=1782831999;
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=UBRgHg7zBT9dDU9XG5F8KOgfMU/+ygbpAlA+5C2uefE=;
 b=R3fCk90UoFXFvIOsAL7+jpvMs0jMc791WfY4GAPMKz7+e2mAu0B1cFq8ET+9mC6x4A
 Oe1ixxyHsLByOOVALtVN+tiSVQIjrsTfxockFcTXuyEO0Fz4M6XLEvg4adsQW+od9YPy
 bZiC8ZeaC9Q5MVlW3pDEI4Q7IotuF5bINw+chu2V6rqxTYv7AF0A7cNrYcKiwCSeIZc2
 +4oR1uu2ZP0qbVvL9gXJC8+VzIghwmILj8Wz34DS8n6nQY2Vv8l3c0Ci/Sehb5iPh9j3
 eMy6pfTdhU7+w7d6aHML3NRvGtHvgmXb4d6Sj8Z0CbgCkHMbViA1k4WH4J1mxm7hcUEx
 nCaw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqCyyHS8mOeI9EbN9PiH7SIAAi5I886qEW239zq5mcrC+7RK+gYWx1TAzsAtERBTFEyc7vtAKioiKOu@nongnu.org
X-Gm-Message-State: AOJu0Yx2AOVfkE6OG29uuO+1169c+63WTjMggdjNryWE/iuHTpAleltE
 tAHD3AgXVEroPw3ZQt6Mf9gQbBcYXhWZnXVtx3661YoRhhKPhvRoPDH2Bc/hVAqHUnaWcaNOmXN
 EfiVPCYMe
X-Received: from pjbos11.prod.google.com ([2002:a17:90b:1ccb:b0:36b:c6a2:b8bc])
 (user=jrhilke job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:264b:b0:369:7421:b36f
 with SMTP id 98e67ed59e1d1-37d160e9587mr20691204a91.21.1782227198428; Tue, 23
 Jun 2026 08:06:38 -0700 (PDT)
Date: Tue, 23 Jun 2026 15:06:02 +0000
In-Reply-To: <20260623-igb-trl-v8-0-c9b1fc6c3304@google.com>
Mime-Version: 1.0
References: <20260623-igb-trl-v8-0-c9b1fc6c3304@google.com>
X-Mailer: b4 0.14.3
Message-ID: <20260623-igb-trl-v8-4-c9b1fc6c3304@google.com>
Subject: [PATCH v8 4/7] igb: Refactor TX path to return processed byte count
From: Josh Hilke <jrhilke@google.com>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-devel@nongnu.org
Cc: Josh Hilke <jrhilke@google.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>, 
 Jason Wang <jasowang@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 David Matlack <dmatlack@google.com>,
 Alex Williamson <alex.williamson@nvidia.com>, 
 "=?utf-8?q?Philippe_Mathieu-Daud=C3=A9?=" <philmd@oss.qualcomm.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::104a;
 envelope-from=3_qA6agcKCoMqyopsrlnvvnsl.jvtxlt1-kl2lsuvunu1.vyn@flex--jrhilke.bounces.google.com;
 helo=mail-pj1-x104a.google.com
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
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com>
---
 hw/net/igb_core.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/hw/net/igb_core.c b/hw/net/igb_core.c
index ca427d7..9a8ef15 100644
--- a/hw/net/igb_core.c
+++ b/hw/net/igb_core.c
@@ -599,7 +599,7 @@ igb_on_tx_done_update_stats(IGBCore *core, struct NetTx=
Pkt *tx_pkt, int qn)
     }
 }
=20
-static void
+static size_t
 igb_process_tx_desc(IGBCore *core,
                     PCIDevice *dev,
                     struct igb_tx *tx,
@@ -632,10 +632,10 @@ igb_process_tx_desc(IGBCore *core,
             tx->ctx[idx].seqnum_seed =3D le32_to_cpu(tx_ctx_desc->seqnum_s=
eed);
             tx->ctx[idx].type_tucmd_mlhl =3D le32_to_cpu(tx_ctx_desc->type=
_tucmd_mlhl);
             tx->ctx[idx].mss_l4len_idx =3D le32_to_cpu(tx_ctx_desc->mss_l4=
len_idx);
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
=20
     if (cmd_type_len & E1000_TXD_CMD_EOP) {
+        size_t total_len =3D 0;
         if (!tx->skip_cp && net_tx_pkt_parse(tx->tx_pkt)) {
             idx =3D (tx->first_olinfo_status >> 4) & 1;
             igb_tx_insert_vlan(core, queue_index, tx,
                 tx->ctx[idx].vlan_macip_lens >> IGB_TX_FLAGS_VLAN_SHIFT,
                 !!(tx->first_cmd_type_len & E1000_TXD_CMD_VLE));
+            total_len =3D net_tx_pkt_get_total_len(tx->tx_pkt);
=20
             if ((tx->first_cmd_type_len & E1000_ADVTXD_MAC_TSTAMP) &&
                 (core->mac[TSYNCTXCTL] & E1000_TSYNCTXCTL_ENABLED) &&
@@ -675,7 +677,9 @@ igb_process_tx_desc(IGBCore *core,
         tx->first =3D true;
         tx->skip_cp =3D false;
         net_tx_pkt_reset(tx->tx_pkt, net_tx_pkt_unmap_frag_pci, dev);
+        return total_len;
     }
+    return 0;
 }
=20
 static uint32_t igb_tx_wb_eic(IGBCore *core, int queue_idx)

--=20
2.55.0.rc0.786.g65d90a0328-goog


