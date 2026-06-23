Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB129CDB479
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 15:07:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wc2iT-0006pP-Bj; Tue, 23 Jun 2026 11:07:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3AKE6agcKCoUs0qrutnpxxpun.lxvznv3-mn4nuwxwpw3.x0p@flex--jrhilke.bounces.google.com>)
 id 1wc2i6-0006l6-D9
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 11:06:48 -0400
Received: from mail-pf1-x449.google.com ([2607:f8b0:4864:20::449])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3AKE6agcKCoUs0qrutnpxxpun.lxvznv3-mn4nuwxwpw3.x0p@flex--jrhilke.bounces.google.com>)
 id 1wc2i3-0006pG-Cc
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 11:06:45 -0400
Received: by mail-pf1-x449.google.com with SMTP id
 d2e1a72fcca58-8426ed9f24dso776259b3a.1
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 08:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1782227201; x=1782832001; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
 :reply-to; bh=oT0toD01z3dMY9p/cSubZkI67L2zw3OEmlJDwnKQ2Z8=;
 b=mpCigSBvdLLUzxeZcYEdPx+W1HNxb61vBC7TbXLrt6nXmcfLTdgs2BP+XPA4J8GXl9
 1CpqgFsBXO/ek5B7is7xdWcJOUu+WAnul/GmrIWpFEeXAqvsJUVNhbDAQVxg3xJhEw/b
 iqiBg8u1SJ5DBSCWShtQZYP6ZnGnFBKgE5nPqpgBRojSsOrOSJtMqFTeCtKTPtQKtidP
 8IDAb3yJpdp1D24wTc91zLlwDDMYqyfHdN/MHLn8tvF66sE1HaCMKEGkMoEkacLavY29
 kRhBVQu98RLvo7EebupgJl/doHyiV+EG6QRx6boLffd+7XUC2fxfA7kkiYT9ftjKuau0
 thkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782227201; x=1782832001;
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=oT0toD01z3dMY9p/cSubZkI67L2zw3OEmlJDwnKQ2Z8=;
 b=rfl+9OGLzru0inRrSfSkb9ujp8gPiCOAWFcGGZIwAAYpgUSkpikHUNk0vYivi4/QDe
 +1YTV05p36xGBlgWjTbbAvPNOlp2OZvC3M4b0LGr7dFIdYFLsOh4K2SJwAf4XHVsLi7j
 OyEtN7kX1Juy/OtnLZtzTzGE2p5oxdS1N0dYeVcghNWhQCWgdLWOKlI37pLlz1EC4DK7
 SqPLvf58bLXjYs5PWziF1OIAYsxHbCJht59BgSSxscAXYFWqlwNvdxKy3Rs1fHXyZory
 nZ7jRbHerNqUbe0tboet6KzXtNV0B+PCYT5Kjv8REMIFsg/PzZK4+St7tJ1S/5hYEH9I
 bkOg==
X-Forwarded-Encrypted: i=1;
 AFNElJ85J49cZzvRmPGVkuyU1GH9sLfZWFO7Qb8poFhAENO1JZuVFnJ0vHaPIF4YhYlMHePa9778M2Xto1lV@nongnu.org
X-Gm-Message-State: AOJu0YxAuuV/lztHUzWaC+TnmSmh14aFLQ3dq2GUcz88qMW7gxtr6GXR
 SW9owG4dwCRrHP4Sizfzza4GinS3KYKw/85Jn9t/LZDJWaBHg1DtPb2N2pnk4gwL9Al/eDlbK8C
 X8pOVt08y
X-Received: from pfld2.prod.google.com ([2002:a05:6a00:1982:b0:842:32f6:5738])
 (user=jrhilke job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:1494:b0:842:3838:cb03
 with SMTP id d2e1a72fcca58-84591c076a9mr3968527b3a.11.1782227200360; Tue, 23
 Jun 2026 08:06:40 -0700 (PDT)
Date: Tue, 23 Jun 2026 15:06:03 +0000
In-Reply-To: <20260623-igb-trl-v8-0-c9b1fc6c3304@google.com>
Mime-Version: 1.0
References: <20260623-igb-trl-v8-0-c9b1fc6c3304@google.com>
X-Mailer: b4 0.14.3
Message-ID: <20260623-igb-trl-v8-5-c9b1fc6c3304@google.com>
Subject: [PATCH v8 5/7] igb: Implement TRL throttling and timer resumption
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::449;
 envelope-from=3AKE6agcKCoUs0qrutnpxxpun.lxvznv3-mn4nuwxwpw3.x0p@flex--jrhilke.bounces.google.com;
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

Integrate throttling logic into the transmission path. In
`igb_start_xmit`, check if the queue is currently throttled.  Accumulate
bytes sent, calculate the transmission delay based on the configured
target rate, and if a throttle is triggered, set the virtual timer, mark
the queue as throttled, and defer remaining packets.  Implement the
timer callback to clear the throttled state and resume transmission when
the timer expires.

Signed-off-by: Josh Hilke <jrhilke@google.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com>
---
 hw/net/igb_core.c | 64 +++++++++++++++++++++++++++++++++++++++++++++++++++=
++--
 1 file changed, 62 insertions(+), 2 deletions(-)

diff --git a/hw/net/igb_core.c b/hw/net/igb_core.c
index 9a8ef15..4fe2fad 100644
--- a/hw/net/igb_core.c
+++ b/hw/net/igb_core.c
@@ -875,6 +875,48 @@ igb_tx_enabled(IGBCore *core, const E1000ERingInfo *tx=
i)
         (core->mac[TXDCTL0 + (qn * 16)] & E1000_TXDCTL_QUEUE_ENABLE);
 }
=20
+static uint64_t igb_trl_calculate_delay(const IGBTrlQueue *q, size_t bytes=
_sent)
+{
+    uint32_t divisor;
+    uint32_t rf;
+
+    if (!igb_trl_enabled(q)) {
+        return 0;
+    }
+
+    /*
+     * 7.8 Transmit Rate Limiting (TRL)
+     *
+     * > RF =3D 1Gb/s / Target-Rate (Rate Factor) is the ratio between the
+     * > nominal link rate and the target maximum rate to achieve for
+     * > that rate controlled queue. It is a decimal number ranging from
+     * > 1 to 1,000 (1 Mb/s minimum target rate) at least 10-bits before
+     * > the hexadecimal point and 14-bits after, as required for the
+     * > maximum PL by which it is multiplied.
+     *
+     * The TRLRC register stores the RF in 10.14 fixed-point format:
+     * - Bits 13:0: Fractional part
+     * - Bits 23:14: Integer part
+     *
+     * Combined, the lower 24 bits of the register (23:0) represent the
+     * RF directly.
+     */
+    rf =3D MAX(extract32(q->trlrc, 0, 24), 1 << 14);
+
+    /*
+     * Delay =3D PL (Packet Length) / Target-Rate
+     *       =3D PL / (1Gb/s / RF)
+     *       =3D PL * RF / 1Gb/s
+     *       =3D PL * RF / (1G / b/B / ns/s) B/ns
+     *       =3D (bytes_sent * (RF / 2^14) / (1G / b/B / ns/s)) ns
+     *       =3D (bytes_sent * RF / (1G / b/B * 2^14 / ns/s)) ns
+     */
+    divisor =3D ((1000000000ULL / BITS_PER_BYTE) << 14) /
+              NANOSECONDS_PER_SECOND;
+
+    return muldiv64(bytes_sent, rf, divisor);
+}
+
 static void
 igb_start_xmit(IGBCore *core, const IGB_TxRing *txr)
 {
@@ -883,12 +925,19 @@ igb_start_xmit(IGBCore *core, const IGB_TxRing *txr)
     union e1000_adv_tx_desc desc;
     const E1000ERingInfo *txi =3D txr->i;
     uint32_t eic =3D 0;
+    size_t bytes_sent =3D 0;
+    uint64_t delay_ns;
=20
     if (!igb_tx_enabled(core, txi)) {
         trace_e1000e_tx_disabled();
         return;
     }
=20
+    if (igb_trl_enabled(&core->trl[txi->idx]) &&
+        timer_pending(core->trl[txi->idx].timer)) {
+        return;
+    }
+
     d =3D pcie_sriov_get_vf_at_index(core->owner, txi->idx % 8);
     if (!d) {
         d =3D core->owner;
@@ -902,9 +951,16 @@ igb_start_xmit(IGBCore *core, const IGB_TxRing *txr)
         trace_e1000e_tx_descr((void *)(intptr_t)desc.read.buffer_addr,
                               desc.read.cmd_type_len, desc.wb.status);
=20
-        igb_process_tx_desc(core, d, txr->tx, &desc, txi->idx);
+        bytes_sent +=3D igb_process_tx_desc(core, d, txr->tx, &desc, txi->=
idx);
         igb_ring_advance(core, txi, 1);
         eic |=3D igb_txdesc_writeback(core, base, &desc, txi);
+
+        delay_ns =3D igb_trl_calculate_delay(&core->trl[txi->idx], bytes_s=
ent);
+        if (delay_ns > 0) {
+            timer_mod(core->trl[txi->idx].timer,
+                      qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + delay_ns);
+            break;
+        }
     }
=20
     if (eic) {
@@ -4329,7 +4385,11 @@ bool igb_trl_enabled(const IGBTrlQueue *q)
=20
 static void igb_trl_timer_cb(void *opaque)
 {
-    /* Stub */
+    IGBTrlQueue *trl =3D opaque;
+    IGB_TxRing txr;
+
+    igb_tx_ring_init(trl->core, &txr, trl->qidx);
+    igb_start_xmit(trl->core, &txr);
 }
=20
 static void igb_trl_init(IGBCore *core)

--=20
2.55.0.rc0.786.g65d90a0328-goog


