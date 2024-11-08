Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C56CDD5C0EF
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2024 15:45:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9R8Z-0002K2-6G; Fri, 08 Nov 2024 10:43:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1t9R8X-0002Jp-Og
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 10:43:01 -0500
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1t9R8W-0005Ia-4W
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 10:43:01 -0500
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-7205b6f51f3so1883179b3a.1
 for <qemu-devel@nongnu.org>; Fri, 08 Nov 2024 07:42:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731080578; x=1731685378; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8YXGNtau+JOHmNo5R4BLXeKKLnW7DMVKJ7snPHk/S1E=;
 b=ZMcvx19WArgR95ydIGmIvPHGP+qaU9mBgUPhb7VU6Lrs8YpZpLnoMgLINlFx0uKLdn
 XVrtuampQXtTApNI5mQmRE+7arcKypCEGgEzVr7BhMFm5tgxR7UDnnkbo+95bOtk9cus
 SfSyTUXPeTw0Pm+KgbYHYG773Zac2ImZVjnEu4jwMxERFlMFYBW0D8SZvvgTOSLiL15D
 3hyp39UwdpAkFN4u9FU/ab1kb+9VqN/41m9UlOIGnvAkx26EGUdjV/QKSUOxa+xFAjp5
 fbUj8nLJCuovZZeAyRdeiYsh0vDmCMrzLn6NkcjnfcpNFX6GuHdQKbm2WbtLkaSljE9r
 xF3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731080578; x=1731685378;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8YXGNtau+JOHmNo5R4BLXeKKLnW7DMVKJ7snPHk/S1E=;
 b=oBwA/RGemPPYANtSXf2RgZjzSrrUx+b0NllT56EmSBwKwqRUeBboc4qUJwlBHSJAn2
 k2yUC6exQvGZJXizNGTl4rUQ6OUkWzERnUgacSRqo67qwFUNRCnhveU7LM6pXIVgA84s
 FQs3Rl5KXYaS5nuekRrhAWxH3lJFk/BTXtXR1bLWr/ymtKLP1S1k1v+n3OCEcZvB5YkA
 nNkdJz5+lgqnt+nVHyCt5rNCPN/QydxfQ8Pbfdg4Kj+Fdi2NMZEq3qpht35hDwZYVQDT
 QSMTC3spVG5Dj1OCE/foOV1bc1H44FbK6iIbWNapxLf3gR8Sp8nab1xw1JURwQE1oPSP
 gPoA==
X-Gm-Message-State: AOJu0YwxYJw0asnx6s+MRgRw7TtXX0VVgdGQVYyAaxQG/iE6DeWgCCEJ
 yFPbxiEDbK/jh0kwS09zfZT7rLK8syUEr+vOGLiJ7WS1dJZTGaGSq+7KRQ==
X-Google-Smtp-Source: AGHT+IEu64Vj33987GfRKRL3Kkgfx4OVYyvViKQytS1L06GskA/2TPkWC8T7Ez0mCHOiwj32wO4cHQ==
X-Received: by 2002:a05:6a21:7881:b0:1db:e425:c8a2 with SMTP id
 adf61e73a8af0-1dc229a40e4mr4002760637.19.1731080578014; 
 Fri, 08 Nov 2024 07:42:58 -0800 (PST)
Received: from wheely.local0.net (124-171-217-17.tpgi.com.au. [124.171.217.17])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7f41f48d32bsm3110444a12.17.2024.11.08.07.42.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Nov 2024 07:42:57 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Subject: [RFC PATCH 5/5] hw/usb: Support XHCI TR NOOP commands
Date: Sat,  9 Nov 2024 01:42:28 +1000
Message-ID: <20241108154229.263097-6-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241108154229.263097-1-npiggin@gmail.com>
References: <20241108154229.263097-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Implement TR NOOP commands by setting up then immediately completing
the packet. Add a TR NOOP test to the xhci qtest.

The IBM AIX XHCI driver uses NOOP commands to check driver and
hardware health.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/usb/hcd-xhci.c               | 28 ++++++++++++++++++++++++++-
 tests/qtest/usb-hcd-xhci-test.c | 34 +++++++++++++++++++++++++++++++++
 2 files changed, 61 insertions(+), 1 deletion(-)

diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
index d85adaca0d..9e223acd83 100644
--- a/hw/usb/hcd-xhci.c
+++ b/hw/usb/hcd-xhci.c
@@ -1832,6 +1832,20 @@ static int xhci_fire_transfer(XHCIState *xhci, XHCITransfer *xfer, XHCIEPContext
     return xhci_submit(xhci, xfer, epctx);
 }
 
+static int xhci_noop_transfer(XHCIState *xhci, XHCITransfer *xfer)
+{
+    /*
+     * TR NOOP conceptually probably better not call into USB subsystem
+     * (usb_packet_setup() via xhci_setup_packet()). In practice it
+     * works and avoids code duplication.
+     */
+    if (xhci_setup_packet(xfer) < 0) {
+        return -1;
+    }
+    xhci_try_complete_packet(xfer);
+    return 0;
+}
+
 static void xhci_kick_ep(XHCIState *xhci, unsigned int slotid,
                          unsigned int epid, unsigned int streamid)
 {
@@ -1954,6 +1968,8 @@ static void xhci_kick_epctx(XHCIEPContext *epctx, unsigned int streamid)
 
     epctx->kick_active++;
     while (1) {
+        bool noop = false;
+
         length = xhci_ring_chain_length(xhci, ring);
         if (length <= 0) {
             if (epctx->type == ET_ISO_OUT || epctx->type == ET_ISO_IN) {
@@ -1982,10 +1998,20 @@ static void xhci_kick_epctx(XHCIEPContext *epctx, unsigned int streamid)
                 epctx->kick_active--;
                 return;
             }
+            if (type == TR_NOOP) {
+                noop = true;
+            }
         }
         xfer->streamid = streamid;
 
-        if (epctx->epid == 1) {
+        if (noop) {
+            if (length != 1) {
+                qemu_log_mask(LOG_GUEST_ERROR,
+                              "%s: NOOP TR TRB within TRB chain!\n", __func__);
+                /* Undefined behavior, we no-op the entire chain */
+            }
+            xhci_noop_transfer(xhci, xfer);
+        } else if (epctx->epid == 1) {
             xhci_fire_ctl_transfer(xhci, xfer);
         } else {
             xhci_fire_transfer(xhci, xfer, epctx);
diff --git a/tests/qtest/usb-hcd-xhci-test.c b/tests/qtest/usb-hcd-xhci-test.c
index d66e76f070..8a36f42522 100644
--- a/tests/qtest/usb-hcd-xhci-test.c
+++ b/tests/qtest/usb-hcd-xhci-test.c
@@ -357,6 +357,30 @@ static void submit_cr_trb(XHCIQState *s, XHCITRB *trb)
     xhci_db_writel(s, 0, 0); /* doorbell 0 */
 }
 
+static void submit_tr_trb(XHCIQState *s, int slot, XHCITRB *trb)
+{
+    XHCITRB t;
+    uint64_t tr_addr = s->slots[slot].transfer_ring + s->slots[slot].tr_trb_idx * sizeof(*trb);
+
+    trb->control |= s->slots[slot].tr_trb_c; /* C */
+
+    t.parameter = cpu_to_le64(trb->parameter);
+    t.status = cpu_to_le32(trb->status);
+    t.control = cpu_to_le32(trb->control);
+
+    qtest_memwrite(s->parent->qts, tr_addr, &t, sizeof(t));
+    s->slots[slot].tr_trb_idx++;
+    /* Last entry contains the link, so wrap back */
+    if (s->slots[slot].tr_trb_idx == s->slots[slot].tr_trb_entries - 1) {
+        set_link_trb(s, s->slots[slot].transfer_ring,
+                        s->slots[slot].tr_trb_c,
+                        s->slots[slot].tr_trb_entries);
+        s->slots[slot].tr_trb_idx = 0;
+        s->slots[slot].tr_trb_c ^= 1;
+    }
+    xhci_db_writel(s, slot, 1); /* doorbell slot, EP0 target */
+}
+
 static void pci_xhci_stress_rings(void)
 {
     XHCIQState *s;
@@ -509,6 +533,16 @@ static void pci_xhci_stress_rings(void)
 
     /* XXX: Check EP state is running? */
 
+    /* Wrap the transfer ring a few times */
+    for (i = 0; i < 100; i++) {
+        /* Issue a transfer ring slot 0 noop */
+        memset(&trb, 0, sizeof(trb));
+        trb.control |= TR_NOOP << TRB_TYPE_SHIFT;
+        trb.control |= TRB_TR_IOC;
+        submit_tr_trb(s, slotid, &trb);
+        wait_event_trb(s, &trb);
+    }
+
     /* Shut it down */
     qpci_msix_disable(s->dev);
 
-- 
2.45.2


