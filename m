Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC326076726
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 15:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=korins.ky header.i=@korins.ky header.a=rsa-sha256 header.s=20240125rsa header.b=K7DWUUqx;
	dkim=fail reason="signature verification failed" header.d=korins.ky header.i=@korins.ky header.a=ed25519-sha256 header.s=20240125ed25519 header.b=f+kJcD2Y
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNtgK-0001i8-VY; Mon, 02 Nov 2026 10:10:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1xNtgK-0001hq-9c
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 10:10:44 -0500
Received: from mx1.catap.net ([162.55.82.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1xNtgD-0003MQ-Sg
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 10:10:42 -0500
ARC-Seal: i=1; a=rsa-sha256; s=20240125rsa; cv=none; d=mx.catap.net; b=g7WI6fe
 g4+hEz6mCh8SJmBYPVvUm7fyah60qjiRnDW1t0iVlM3CoWG8Vp4fPNmFONCi/DxuPiYKiz
 x0iqeO8tHC29SmGqjYQaEOjdXp6TITQn42qP4ELY3L4eHw9TSvm39VChoXqOb9rVkc//2X
 1d4gKE9MX8I+Ns+0aOhnKT+u4htaC/gVaji8jSy5qAh0Bumpn7oYs+mSHjBu5zucBMyQZN
 t/iGc+h69JGXX/N2lhuMX2XJsygtu27NAEWTD9f+RNvP5p/FKrPPtVXk5aBR4YhcVuxEst
 lhLGCMkAJm+KykAq5QqOMeRqvUP8s9WQYgmmvSADCNADE6x7ZQCJ4FA==
ARC-Message-Signature: i=1; a=rsa-sha256; s=20240125rsa; c=simple/simple; bh=W
 +GGhktDevltQPQTh3cJi3vwPyJwsM0T8Zjp0Wk18Ns=;
 h=references:in-reply-to:
 date:subject:cc:to:from:dkim-signature:dkim-signature; d=mx.catap.net;
 b=Nin4XYJYrzOqYz+LZyjwf9kEQK39uynbF9AavL1CDxdUyYEkEh6iTWrVa/jzmLxnwWQ2
 NWzUv3NiN6dTW+U8gxyC0M0fUUTLEAkd3Vak+BXArlni6Od1tUxXDXtHzc3iu79pfDwTBM
 aRxv6lSgurRdJLlvBtpCakXaN1JmP91nNDMOv8s4Rq6wQHIUskhHYI1XMvEbVFBV8av0mS
 mqMD4ghW/wEvlCvZwSReSpgV8LMlzxEWrCjZx2/lBaz9V0Wq4rPpx1ZEajtYYdz/fNang/
 tMnUgHDpiyz4K7Ldws6zZj0TSi6q3NcjIwt66G9tgP4tle40UwPuk/5HyuDeI//w==
ARC-Authentication-Results: i=1; mx.catap.net; dkim=pass
 header.s=20240125rsa header.d=korins.ky header.a=rsa-sha256 
 header.b=K7DWUUqx; dkim=pass header.s=20240125ed25519 
 header.d=korins.ky header.a=ed25519-sha256 header.b=f+kJcD2Y;
 arc=none; iprev=pass; spf=none
 smtp.helo=postmaster@matebook.home.arpa; spf=softfail
 smtp.mailfrom=kirill@korins.ky
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=20240125rsa; bh=W+GGhktD
 evltQPQTh3cJi3vwPyJwsM0T8Zjp0Wk18Ns=;
 h=references:in-reply-to:date:
 subject:cc:to:from; d=korins.ky; b=K7DWUUqxq2bzJWRlcGJxeAstXtRo65utkUS
 nYTKhdzHEqQ/m9joJZGzjr5CfI9dwh183+v4WPXtZ/a0xblRjSLio/Er+p8d7EGizSVC+W
 F4Ba11waL3aFc0AuSyOTFSlU8/LqvFOk+Ja1baiOdPdkUbIf+PlqEvetWJ5AJF0oh/kxlK
 8XP3ra3/ZsNjkb6wl686V1nU0JJMRD2SZFv3nOuh0a3DC0Lk5ASANxG6PbncFMmv9P+KWA
 BrLiHtQQ7CG/REBG/A6TXvcxHw9ScrI8TjQTlB/TDWDMNlxY8QaFJlhbnUXveg4d01Q4iQ
 H70T/qk7QlULDO6FBLnQ1KV0LJw==
DKIM-Signature: v=1; a=ed25519-sha256; c=simple/simple; s=20240125ed25519;
 bh=W+GGhktDevltQPQTh3cJi3vwPyJwsM0T8Zjp0Wk18Ns=; h=references:
 in-reply-to:date:subject:cc:to:from; d=korins.ky; b=f+kJcD2Ys3If0EFm9R
 FVmnq0/iT16Z/zmW/m/dZ3qfQSnCmfy3EYkXinRwO35lcK7gyLG1IRJ+iax80d9LeTBQ==
Received: by mx1.catap.net (OpenSMTPD) id 0dfdd055;
 Mon, 2 Nov 2026 16:10:32 +0100 (CET)
Received: from localhost (matebook.home.arpa [local])
 by matebook.home.arpa (OpenSMTPD) with ESMTPA id a1945482;
 Mon, 2 Nov 2026 16:10:29 +0100 (CET)
From: Kirill A. Korinsky <kirill@korins.ky>
To: Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: "Kirill A . Korinsky" <kirill@korins.ky>
Subject: [PATCH v2 1/1] usb/xhci: implement Event Ring Full handling
Date: Mon,  2 Nov 2026 16:09:37 +0100
Message-ID: <20261102151022.64359-2-kirill@korins.ky>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261102151022.64359-1-kirill@korins.ky>
References: <20261102151022.64359-1-kirill@korins.ky>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=162.55.82.72; envelope-from=kirill@korins.ky;
 helo=mx1.catap.net
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: "Kirill A. Korinsky" <kirill@korins.ky>

QEMU reports Event Ring Full when two entries remain, drops the event
which encounters that condition, and continues consuming Command and
Transfer Rings. An ERDP write consequently has no full state to
recover, so a lost completion can leave a guest request blocked
indefinitely.

The xHCI Requirements Specification, revision 1.2c, section 4.9.4
and Figure 4-12, defines a different state machine. The xHC checks for
full before posting an event and considers the ring full while one
entry remains. It writes a Host Controller Event TRB with Event Ring
Full Error into that reserved entry, then stops Command and Transfer
Ring processing. The full state persists until an ERDP write frees
space. Section 6.4.2.6 and section 6.4.5, Table 6-90, define the error
TRB and completion code 21.

Keep full state and unposted events per interrupter. Gate command and
endpoint producers while any Event Ring is full; for the QEMU
non-virtualized xHC this is the required Primary Event Ring behavior
and the conservative behavior which section 4.9.4 permits for
Secondary Event Rings. Retain endpoint and stream doorbells while
stopped and resume them asynchronously after the full condition
clears.

Section 4.14.2 requires MFINDEX Wrap events to be dropped while the
target Event Ring is full. Coalesce repeated Port Status Change and
Command Ring Stopped notifications so sources still active during the
stop cannot grow the pending queue without bound.

On an ERDP write, take a fixed snapshot of the newly freed entries and
reserve one entry for another Full Error. Replay no more events than
that snapshot permits. If events remain, write another Full Error into
the reserve and remain stopped; otherwise clear the full state and
resume producers. This also implements the section 4.9.4 warning that
partial ERDP updates may fill the ring again with Full Error events.

Section 5.5.2.3.3 explicitly permits consecutive equal ERDP values for
a FULL-to-EMPTY advancement. Recovery therefore follows an ERDP
pointer write, including this equal-value case, and does not depend on
EHB. Section 4.17.2 and section 5.5.2.3.3 define EHB as RW1C interrupt
moderation state, set with IP and cleared by software; it is not an
Event Ring Full acknowledgement.

The replay loop has a fixed credit count which decreases on every
iteration and cannot be replenished by newly queued events. QEMU
supports one Event Ring segment, and section 6.5, Table 6-95, limits a
segment to 4096 TRBs, so one ERDP write can replay at most 4095 events.

Preserve the full state, pending events, and deferred endpoint work
across migration. HCRST discards them, while ordinary Event Ring
reprogramming retains pending completions. Add qtests for the reserved
Full Error layout, equal and partial ERDP recovery, producer stop and
resume, HCRST, and Event Ring reprogramming.

Signed-off-by: Kirill A. Korinsky <kirill@korins.ky>
---
 MAINTAINERS                        |   1 +
 hw/usb/hcd-xhci.c                  | 585 ++++++++++++++++++++++++++++-
 hw/usb/hcd-xhci.h                  |  31 +-
 tests/qtest/meson.build            |   1 +
 tests/qtest/xhci-event-ring-test.c | 560 +++++++++++++++++++++++++++
 5 files changed, 1164 insertions(+), 14 deletions(-)
 create mode 100644 tests/qtest/xhci-event-ring-test.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 3b12ba90f2..bb96a5468f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2469,6 +2469,7 @@ USB
 S: Orphan
 F: hw/usb/*
 F: tests/qtest/usb-*-test.c
+F: tests/qtest/xhci-*-test.c
 F: docs/system/devices/usb.rst
 F: include/hw/usb/usb.h
 F: include/hw/usb/
diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
index 5d7a77b8bc..1ed7f7d74c 100644
--- a/hw/usb/hcd-xhci.c
+++ b/hw/usb/hcd-xhci.c
@@ -300,13 +300,19 @@ typedef struct XHCIEvRingSeg {
     uint32_t rsvd;
 } XHCIEvRingSeg;
 
+struct XHCIDeferredKick {
+    unsigned int index;
+    QTAILQ_ENTRY(XHCIDeferredKick) next;
+};
+
 static void xhci_kick_ep(XHCIState *xhci, unsigned int slotid,
                          unsigned int epid, unsigned int streamid);
 static void xhci_kick_epctx(XHCIEPContext *epctx, unsigned int streamid);
+static void xhci_process_commands(XHCIState *xhci);
 static TRBCCode xhci_disable_ep(XHCIState *xhci, unsigned int slotid,
                                 unsigned int epid);
 static void xhci_xfer_report(XHCITransfer *xfer);
-static void xhci_event(XHCIState *xhci, XHCIEvent *event, int v);
+static bool xhci_event(XHCIState *xhci, XHCIEvent *event, int v);
 static void xhci_write_event(XHCIState *xhci, XHCIEvent *event, int v);
 static USBEndpoint *xhci_epid_to_usbep(XHCIEPContext *epctx);
 
@@ -608,6 +614,304 @@ static inline int xhci_running(XHCIState *xhci)
     return !(xhci->usbsts & USBSTS_HCH);
 }
 
+static uint32_t xhci_pending_port_mask(const XHCIEvent *event)
+{
+    unsigned int portnr;
+
+    if (event->type != ER_PORT_STATUS_CHANGE) {
+        return 0;
+    }
+
+    portnr = event->ptr >> 24;
+    if (portnr < 1 || portnr > XHCI_MAXPORTS) {
+        return 0;
+    }
+    return 1U << (portnr - 1);
+}
+
+static bool xhci_pending_command_ring_stopped(const XHCIEvent *event)
+{
+    return event->type == ER_COMMAND_COMPLETE &&
+           event->ccode == CC_COMMAND_RING_STOPPED;
+}
+
+static void xhci_queue_pending_event(XHCIInterrupter *intr,
+                                     const XHCIEvent *event)
+{
+    XHCIPendingEvent *pending;
+    uint32_t port_mask;
+
+    if (event->type == ER_MFINDEX_WRAP) {
+        return;
+    }
+
+    port_mask = xhci_pending_port_mask(event);
+    if (port_mask && (intr->pending_port_events & port_mask)) {
+        return;
+    }
+    if (xhci_pending_command_ring_stopped(event)) {
+        if (intr->pending_command_ring_stopped) {
+            return;
+        }
+        intr->pending_command_ring_stopped = true;
+    }
+
+    pending = g_new(XHCIPendingEvent, 1);
+    pending->event = *event;
+    QTAILQ_INSERT_TAIL(&intr->pending_events, pending, next);
+    intr->pending_port_events |= port_mask;
+}
+
+static XHCIPendingEvent *xhci_pop_pending_event(XHCIInterrupter *intr)
+{
+    XHCIPendingEvent *pending = QTAILQ_FIRST(&intr->pending_events);
+
+    if (pending) {
+        intr->pending_port_events &=
+            ~xhci_pending_port_mask(&pending->event);
+        if (xhci_pending_command_ring_stopped(&pending->event)) {
+            intr->pending_command_ring_stopped = false;
+        }
+        QTAILQ_REMOVE(&intr->pending_events, pending, next);
+    }
+    return pending;
+}
+
+static void xhci_clear_pending_events(XHCIInterrupter *intr)
+{
+    XHCIPendingEvent *pending, *next_pending;
+
+    QTAILQ_FOREACH_SAFE(pending, &intr->pending_events, next, next_pending) {
+        QTAILQ_REMOVE(&intr->pending_events, pending, next);
+        g_free(pending);
+    }
+    intr->pending_port_events = 0;
+    intr->pending_command_ring_stopped = false;
+}
+
+static void xhci_set_event_ring_full(XHCIState *xhci,
+                                     XHCIInterrupter *intr, bool full)
+{
+    if (intr->er_full == full) {
+        return;
+    }
+
+    intr->er_full = full;
+    if (full) {
+        xhci->er_full_count++;
+    } else {
+        assert(xhci->er_full_count > 0);
+        xhci->er_full_count--;
+    }
+}
+
+static unsigned int xhci_endpoint_index(unsigned int slotid,
+                                        unsigned int epid)
+{
+    assert(slotid >= 1 && slotid <= XHCI_MAXSLOTS);
+    assert(epid >= 1 && epid <= 31);
+    return (slotid - 1) * 31 + epid - 1;
+}
+
+static bool xhci_deferred_ep_has_kicks(XHCIState *xhci,
+                                       unsigned int index)
+{
+    unsigned int word;
+
+    for (word = 0; word < XHCI_DEFERRED_KICK_WORDS; word++) {
+        if (xhci->deferred_kicks[index][word]) {
+            return true;
+        }
+    }
+    return false;
+}
+
+static void xhci_queue_deferred_ep(XHCIState *xhci, unsigned int index)
+{
+    XHCIDeferredKick *kick;
+
+    if (xhci->deferred_kick_eps[index]) {
+        return;
+    }
+
+    kick = g_new(XHCIDeferredKick, 1);
+    kick->index = index;
+    QTAILQ_INSERT_TAIL(&xhci->deferred_kick_queue, kick, next);
+    xhci->deferred_kick_eps[index] = kick;
+}
+
+static void xhci_defer_ep_kick(XHCIEPContext *epctx, unsigned int streamid)
+{
+    XHCIState *xhci = epctx->xhci;
+    unsigned int index;
+    unsigned int word;
+    uint64_t mask;
+
+    if (epctx->nr_pstreams) {
+        if (streamid == 0 || streamid >= epctx->nr_pstreams) {
+            return;
+        }
+    } else {
+        streamid = 0;
+    }
+
+    index = xhci_endpoint_index(epctx->slotid, epctx->epid);
+    word = streamid / 64;
+    mask = 1ULL << (streamid % 64);
+    if (!(xhci->deferred_kicks[index][word] & mask)) {
+        xhci->deferred_kicks[index][word] |= mask;
+        xhci->deferred_kick_count++;
+        xhci_queue_deferred_ep(xhci, index);
+    }
+}
+
+static void xhci_clear_ep_kicks(XHCIState *xhci, unsigned int slotid,
+                                unsigned int epid)
+{
+    unsigned int index = xhci_endpoint_index(slotid, epid);
+    XHCIDeferredKick *kick = xhci->deferred_kick_eps[index];
+    unsigned int word;
+
+    if (kick) {
+        QTAILQ_REMOVE(&xhci->deferred_kick_queue, kick, next);
+        xhci->deferred_kick_eps[index] = NULL;
+        g_free(kick);
+    }
+    for (word = 0; word < XHCI_DEFERRED_KICK_WORDS; word++) {
+        xhci->deferred_kick_count -=
+            ctpop64(xhci->deferred_kicks[index][word]);
+        xhci->deferred_kicks[index][word] = 0;
+    }
+}
+
+static void xhci_clear_deferred_kick_queue(XHCIState *xhci)
+{
+    XHCIDeferredKick *kick, *next_kick;
+
+    if (xhci->deferred_kick_bh) {
+        qemu_bh_cancel(xhci->deferred_kick_bh);
+    }
+    QTAILQ_FOREACH_SAFE(kick, &xhci->deferred_kick_queue,
+                        next, next_kick) {
+        QTAILQ_REMOVE(&xhci->deferred_kick_queue, kick, next);
+        g_free(kick);
+    }
+    memset(xhci->deferred_kick_eps, 0, sizeof(xhci->deferred_kick_eps));
+}
+
+static void xhci_clear_deferred_kicks(XHCIState *xhci)
+{
+    xhci_clear_deferred_kick_queue(xhci);
+    xhci->deferred_kick_count = 0;
+    memset(xhci->deferred_kicks, 0, sizeof(xhci->deferred_kicks));
+}
+
+static void xhci_rebuild_deferred_kick_queue(XHCIState *xhci)
+{
+    unsigned int index;
+
+    xhci_clear_deferred_kick_queue(xhci);
+    xhci->deferred_kick_count = 0;
+    for (index = 0; index < XHCI_MAX_ENDPOINT_CONTEXTS; index++) {
+        unsigned int word;
+
+        for (word = 0; word < XHCI_DEFERRED_KICK_WORDS; word++) {
+            xhci->deferred_kick_count +=
+                ctpop64(xhci->deferred_kicks[index][word]);
+        }
+        if (xhci_deferred_ep_has_kicks(xhci, index)) {
+            xhci_queue_deferred_ep(xhci, index);
+        }
+    }
+}
+
+static unsigned int xhci_first_deferred_stream(XHCIState *xhci,
+                                                unsigned int index)
+{
+    unsigned int word;
+
+    for (word = 0; word < XHCI_DEFERRED_KICK_WORDS; word++) {
+        uint64_t bits = xhci->deferred_kicks[index][word];
+
+        if (bits) {
+            return word * 64 + ctz64(bits);
+        }
+    }
+    return XHCI_MAX_STREAMS;
+}
+
+static void xhci_schedule_deferred_kicks(XHCIState *xhci)
+{
+    if (xhci->deferred_kick_bh && xhci_running(xhci) &&
+        xhci->er_full_count == 0 && xhci->deferred_kick_count) {
+        qemu_bh_schedule(xhci->deferred_kick_bh);
+    }
+}
+
+static void xhci_deferred_kick_bh(void *opaque)
+{
+    XHCIState *xhci = opaque;
+    XHCIDeferredKick *kick;
+    XHCIEPContext *epctx;
+    unsigned int index;
+    unsigned int slotid;
+    unsigned int epid;
+    unsigned int streamid;
+    unsigned int word;
+    uint64_t mask;
+
+    if (!xhci_running(xhci) || xhci->er_full_count ||
+        xhci->deferred_kick_count == 0) {
+        return;
+    }
+
+    kick = QTAILQ_FIRST(&xhci->deferred_kick_queue);
+    assert(kick != NULL);
+    index = kick->index;
+    QTAILQ_REMOVE(&xhci->deferred_kick_queue, kick, next);
+    xhci->deferred_kick_eps[index] = NULL;
+
+    streamid = xhci_first_deferred_stream(xhci, index);
+    assert(streamid < XHCI_MAX_STREAMS);
+    word = streamid / 64;
+    mask = 1ULL << (streamid % 64);
+    xhci->deferred_kicks[index][word] &= ~mask;
+    xhci->deferred_kick_count--;
+
+    if (xhci_deferred_ep_has_kicks(xhci, index)) {
+        QTAILQ_INSERT_TAIL(&xhci->deferred_kick_queue, kick, next);
+        xhci->deferred_kick_eps[index] = kick;
+    } else {
+        g_free(kick);
+    }
+
+    slotid = index / 31 + 1;
+    epid = index % 31 + 1;
+    epctx = xhci->slots[slotid - 1].eps[epid - 1];
+    if (epctx) {
+        xhci_kick_epctx(epctx, streamid);
+    }
+
+    /* The idle rearm yields instead of draining the queue in this poll. */
+    if (xhci_running(xhci) && xhci->er_full_count == 0 &&
+        xhci->deferred_kick_count) {
+        qemu_bh_schedule_idle(xhci->deferred_kick_bh);
+    }
+}
+
+static void xhci_resume_work(XHCIState *xhci)
+{
+    if (xhci->er_full_count) {
+        return;
+    }
+    if (xhci->crcr_low & CRCR_CRR) {
+        xhci_process_commands(xhci);
+    }
+    if (xhci->er_full_count == 0) {
+        xhci_schedule_deferred_kicks(xhci);
+    }
+}
+
 static void xhci_write_event(XHCIState *xhci, XHCIEvent *event, int v)
 {
     XHCIInterrupter *intr = &xhci->intr[v];
@@ -643,7 +947,7 @@ static void xhci_write_event(XHCIState *xhci, XHCIEvent *event, int v)
     }
 }
 
-static void xhci_event(XHCIState *xhci, XHCIEvent *event, int v)
+static bool xhci_event(XHCIState *xhci, XHCIEvent *event, int v)
 {
     XHCIInterrupter *intr;
     dma_addr_t erdp;
@@ -656,10 +960,15 @@ static void xhci_event(XHCIState *xhci, XHCIEvent *event, int v)
 
     if (v >= xhci->numintrs) {
         DPRINTF("intr nr out of range (%d >= %d)\n", v, xhci->numintrs);
-        return;
+        return false;
     }
     intr = &xhci->intr[v];
 
+    if (intr->er_full) {
+        xhci_queue_pending_event(intr, event);
+        return true;
+    }
+
     erdp = xhci_addr64(intr->erdp_low, intr->erdp_high);
     if (erdp < intr->er_start ||
         erdp >= (intr->er_start + TRB_SIZE*intr->er_size)) {
@@ -667,23 +976,84 @@ static void xhci_event(XHCIState *xhci, XHCIEvent *event, int v)
         DPRINTF("xhci: ER[%d] at "DMA_ADDR_FMT" len %d\n",
                 v, intr->er_start, intr->er_size);
         xhci_die(xhci);
-        return;
+        return false;
     }
 
     dp_idx = (erdp - intr->er_start) / TRB_SIZE;
     assert(dp_idx < intr->er_size);
 
-    if ((intr->er_ep_idx + 2) % intr->er_size == dp_idx) {
+    if ((intr->er_ep_idx + 1) % intr->er_size == dp_idx) {
         DPRINTF("xhci: ER %d full, send ring full error\n", v);
         XHCIEvent full = {ER_HOST_CONTROLLER, CC_EVENT_RING_FULL_ERROR};
+
+        xhci_queue_pending_event(intr, event);
+        intr->erdp_pending = false;
+        xhci_set_event_ring_full(xhci, intr, true);
         xhci_write_event(xhci, &full, v);
-    } else if ((intr->er_ep_idx + 1) % intr->er_size == dp_idx) {
-        DPRINTF("xhci: ER %d full, drop event\n", v);
-    } else {
-        xhci_write_event(xhci, event, v);
+        xhci_intr_raise(xhci, v);
+        return true;
     }
 
+    xhci_write_event(xhci, event, v);
     xhci_intr_raise(xhci, v);
+    return false;
+}
+
+static void xhci_event_ring_resume(XHCIState *xhci, int v)
+{
+    XHCIInterrupter *intr = &xhci->intr[v];
+    XHCIPendingEvent *pending;
+    dma_addr_t erdp;
+    unsigned int credits;
+    unsigned int dp_idx;
+    unsigned int free_entries;
+    bool posted = false;
+
+    if (!intr->er_full || !intr->erdp_pending || !xhci_running(xhci)) {
+        return;
+    }
+
+    erdp = xhci_addr64(intr->erdp_low, intr->erdp_high);
+    if (erdp < intr->er_start ||
+        erdp >= intr->er_start + TRB_SIZE * intr->er_size) {
+        return;
+    }
+
+    intr->erdp_pending = false;
+    dp_idx = (erdp - intr->er_start) / TRB_SIZE;
+    free_entries = (dp_idx + intr->er_size - intr->er_ep_idx) %
+                   intr->er_size;
+    if (free_entries == 0) {
+        free_entries = intr->er_size;
+    }
+    credits = free_entries - 1;
+
+    /*
+     * ERDP cannot change during this MMIO operation, and one entry stays
+     * reserved for another Full Error.  Thus this snapshot can decrease
+     * at most er_size - 1 times and queued events cannot extend the loop.
+     */
+    while (credits &&
+           (pending = xhci_pop_pending_event(intr)) != NULL) {
+        credits--;
+        xhci_write_event(xhci, &pending->event, v);
+        g_free(pending);
+        posted = true;
+    }
+
+    if (!QTAILQ_EMPTY(&intr->pending_events)) {
+        XHCIEvent full = {ER_HOST_CONTROLLER, CC_EVENT_RING_FULL_ERROR};
+
+        xhci_write_event(xhci, &full, v);
+        xhci_intr_raise(xhci, v);
+        return;
+    }
+
+    xhci_set_event_ring_full(xhci, intr, false);
+    if (posted) {
+        xhci_intr_raise(xhci, v);
+    }
+    xhci_resume_work(xhci);
 }
 
 static void xhci_ring_init(XHCIState *xhci, XHCIRing *ring,
@@ -809,6 +1179,7 @@ static void xhci_er_reset(XHCIState *xhci, int v)
     XHCIInterrupter *intr = &xhci->intr[v];
     XHCIEvRingSeg seg;
     dma_addr_t erstba = xhci_addr64(intr->erstba_low, intr->erstba_high);
+    bool was_full = intr->er_full;
 
     if (intr->erstsz == 0 || erstba == 0) {
         /* disabled */
@@ -846,13 +1217,25 @@ static void xhci_er_reset(XHCIState *xhci, int v)
 
     DPRINTF("xhci: event ring[%d]:" DMA_ADDR_FMT " [%d]\n",
             v, intr->er_start, intr->er_size);
+
+    if (was_full) {
+        intr->erdp_pending = true;
+        xhci_event_ring_resume(xhci, v);
+    }
 }
 
 static void xhci_run(XHCIState *xhci)
 {
+    unsigned int i;
+
     trace_usb_xhci_run();
     xhci->usbsts &= ~USBSTS_HCH;
     xhci->mfindex_start = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+
+    for (i = 0; i < xhci->numintrs; i++) {
+        xhci_event_ring_resume(xhci, i);
+    }
+    xhci_schedule_deferred_kicks(xhci);
 }
 
 static void xhci_stop(XHCIState *xhci)
@@ -860,6 +1243,7 @@ static void xhci_stop(XHCIState *xhci)
     trace_usb_xhci_stop();
     xhci->usbsts |= USBSTS_HCH;
     xhci->crcr_low &= ~CRCR_CRR;
+    qemu_bh_cancel(xhci->deferred_kick_bh);
 }
 
 static XHCIStreamContext *xhci_alloc_stream_contexts(unsigned count,
@@ -1301,6 +1685,7 @@ static TRBCCode xhci_disable_ep(XHCIState *xhci, unsigned int slotid,
         return CC_SUCCESS;
     }
 
+    xhci_clear_ep_kicks(xhci, slotid, epid);
     xhci_ep_nuke_xfers(xhci, slotid, epid, 0);
 
     epctx = slot->eps[epid-1];
@@ -1342,6 +1727,7 @@ static TRBCCode xhci_stop_ep(XHCIState *xhci, unsigned int slotid,
         return CC_EP_NOT_ENABLED_ERROR;
     }
 
+    xhci_clear_ep_kicks(xhci, slotid, epid);
     if (xhci_ep_nuke_xfers(xhci, slotid, epid, CC_STOPPED) > 0) {
         DPRINTF("xhci: FIXME: endpoint stopped w/ xfers running, "
                 "data might be lost\n");
@@ -1387,6 +1773,7 @@ static TRBCCode xhci_reset_ep(XHCIState *xhci, unsigned int slotid,
         return CC_CONTEXT_STATE_ERROR;
     }
 
+    xhci_clear_ep_kicks(xhci, slotid, epid);
     if (xhci_ep_nuke_xfers(xhci, slotid, epid, 0) > 0) {
         DPRINTF("xhci: FIXME: endpoint reset w/ xfers running, "
                 "data might be lost\n");
@@ -1905,6 +2292,11 @@ static void xhci_kick_epctx(XHCIEPContext *epctx, unsigned int streamid)
     trace_usb_xhci_ep_kick(epctx->slotid, epctx->epid, streamid);
     assert(!epctx->kick_active);
 
+    if (xhci->er_full_count) {
+        xhci_defer_ep_kick(epctx, streamid);
+        return;
+    }
+
     /* If the device has been detached, but the guest has not noticed this
        yet the 2 above checks will succeed, but we must NOT continue */
     if (!xhci_slot_ok(xhci, epctx->slotid)) {
@@ -1944,6 +2336,11 @@ static void xhci_kick_epctx(XHCIEPContext *epctx, unsigned int streamid)
         epctx->retry = NULL;
     }
 
+    if (xhci->er_full_count) {
+        xhci_defer_ep_kick(epctx, streamid);
+        return;
+    }
+
     if (epctx->state == EP_HALTED) {
         DPRINTF("xhci: ep halted, not running schedule\n");
         return;
@@ -2016,6 +2413,11 @@ static void xhci_kick_epctx(XHCIEPContext *epctx, unsigned int streamid)
             xfer = NULL;
         }
 
+        if (xhci->er_full_count) {
+            xhci_defer_ep_kick(epctx, streamid);
+            break;
+        }
+
         if (epctx->state == EP_HALTED) {
             break;
         }
@@ -2492,6 +2894,9 @@ static void xhci_process_commands(XHCIState *xhci)
     }
 
     xhci->crcr_low |= CRCR_CRR;
+    if (xhci->er_full_count) {
+        return;
+    }
 
     while ((type = xhci_ring_fetch(xhci, &xhci->cmd_ring, &trb, &addr))) {
         event.ptr = addr;
@@ -2602,7 +3007,9 @@ static void xhci_process_commands(XHCIState *xhci)
             break;
         }
         event.slotid = slotid;
-        xhci_event(xhci, &event, 0);
+        if (xhci_event(xhci, &event, 0)) {
+            return;
+        }
 
         if (count++ > COMMAND_LIMIT) {
             trace_usb_xhci_enforced_limit("commands");
@@ -2718,6 +3125,8 @@ static void xhci_reset(DeviceState *dev)
     xhci->dcbaap_low = 0;
     xhci->dcbaap_high = 0;
     xhci->config = 0;
+    xhci->er_full_count = 0;
+    xhci_clear_deferred_kicks(xhci);
 
     for (i = 0; i < xhci->numslots; i++) {
         xhci_disable_slot(xhci, i+1);
@@ -2738,6 +3147,11 @@ static void xhci_reset(DeviceState *dev)
 
         xhci->intr[i].er_ep_idx = 0;
         xhci->intr[i].er_pcs = 1;
+        xhci->intr[i].er_full = false;
+        xhci->intr[i].erdp_pending = false;
+        xhci_clear_pending_events(&xhci->intr[i]);
+        xhci->intr[i].pending_port_events = 0;
+        xhci->intr[i].er_full_unused = false;
         xhci->intr[i].ev_buffer_put = 0;
         xhci->intr[i].ev_buffer_get = 0;
     }
@@ -3141,6 +3555,11 @@ static void xhci_runtime_write(void *ptr, hwaddr reg,
             intr->erdp_low &= ~ERDP_EHB;
         }
         intr->erdp_low = (val & ~ERDP_EHB) | (intr->erdp_low & ERDP_EHB);
+        if (size == 8) {
+            intr->erdp_high = val >> 32;
+        }
+        intr->erdp_pending = true;
+        xhci_event_ring_resume(xhci, v);
         if (val & ERDP_EHB) {
             dma_addr_t erdp = xhci_addr64(intr->erdp_low, intr->erdp_high);
             unsigned int dp_idx = (erdp - intr->er_start) / TRB_SIZE;
@@ -3153,6 +3572,7 @@ static void xhci_runtime_write(void *ptr, hwaddr reg,
         break;
     case 0x1c: /* ERDP high */
         intr->erdp_high = val;
+        xhci_event_ring_resume(xhci, v);
         break;
     default:
         trace_usb_xhci_unimplemented("oper write", reg);
@@ -3454,6 +3874,15 @@ static void usb_xhci_realize(DeviceState *dev, Error **errp)
     if (xhci->numslots < 1) {
         xhci->numslots = 1;
     }
+
+    QTAILQ_INIT(&xhci->deferred_kick_queue);
+    xhci->deferred_kick_bh = qemu_bh_new_guarded(
+        xhci_deferred_kick_bh, xhci, &dev->mem_reentrancy_guard);
+
+    for (i = 0; i < xhci->numintrs; i++) {
+        QTAILQ_INIT(&xhci->intr[i].pending_events);
+    }
+
     if (xhci_get_flag(xhci, XHCI_FLAG_ENABLE_STREAMS)) {
         xhci->max_pstreams_mask = 7; /* == 256 primary streams */
     } else {
@@ -3499,6 +3928,14 @@ static void usb_xhci_unrealize(DeviceState *dev)
         xhci_disable_slot(xhci, i + 1);
     }
 
+    for (i = 0; i < xhci->numintrs; i++) {
+        xhci_clear_pending_events(&xhci->intr[i]);
+    }
+
+    xhci_clear_deferred_kicks(xhci);
+    qemu_bh_delete(xhci->deferred_kick_bh);
+    xhci->deferred_kick_bh = NULL;
+
     if (xhci->mfwrap_timer) {
         timer_free(xhci->mfwrap_timer);
         xhci->mfwrap_timer = NULL;
@@ -3517,17 +3954,70 @@ static void usb_xhci_unrealize(DeviceState *dev)
     usb_bus_release(&xhci->bus);
 }
 
+static int usb_xhci_pre_save(void *opaque)
+{
+    XHCIState *xhci = opaque;
+    unsigned int slotid;
+
+    if (xhci->er_full_count == 0) {
+        return 0;
+    }
+
+    for (slotid = 1; slotid <= xhci->numslots; slotid++) {
+        unsigned int epid;
+
+        for (epid = 1; epid <= 31; epid++) {
+            XHCIEPContext *epctx = xhci->slots[slotid - 1].eps[epid - 1];
+            XHCITransfer *xfer;
+
+            if (!epctx) {
+                continue;
+            }
+            QTAILQ_FOREACH(xfer, &epctx->transfers, next) {
+                xhci_defer_ep_kick(epctx, xfer->streamid);
+            }
+        }
+    }
+    return 0;
+}
+
 static int usb_xhci_post_load(void *opaque, int version_id)
 {
     XHCIState *xhci = opaque;
+    XHCIPendingEvent *pending;
     XHCISlot *slot;
     XHCIEPContext *epctx;
     dma_addr_t dcbaap, pctx;
     uint32_t slot_ctx[4];
     uint32_t ep_ctx[5];
-    int slotid, epid, state;
+    int slotid, epid, state, i;
     uint64_t addr;
 
+    xhci->er_full_count = 0;
+    for (i = 0; i < xhci->numintrs; i++) {
+        XHCIInterrupter *intr = &xhci->intr[i];
+
+        intr->pending_port_events = 0;
+        intr->pending_command_ring_stopped = false;
+        if (!intr->er_full && !QTAILQ_EMPTY(&intr->pending_events)) {
+            return -EINVAL;
+        }
+        if (intr->erdp_pending && !intr->er_full) {
+            return -EINVAL;
+        }
+        if (intr->er_full) {
+            xhci->er_full_count++;
+        }
+        QTAILQ_FOREACH(pending, &intr->pending_events, next) {
+            intr->pending_port_events |=
+                xhci_pending_port_mask(&pending->event);
+            intr->pending_command_ring_stopped |=
+                xhci_pending_command_ring_stopped(&pending->event);
+        }
+    }
+
+    xhci_rebuild_deferred_kick_queue(xhci);
+
     dcbaap = xhci_addr64(xhci->dcbaap_low, xhci->dcbaap_high);
 
     for (slotid = 1; slotid <= xhci->numslots; slotid++) {
@@ -3560,11 +4050,19 @@ static int usb_xhci_post_load(void *opaque, int version_id)
             xhci_init_epctx(epctx, pctx, ep_ctx);
             epctx->state = state;
             if (state == EP_RUNNING) {
-                /* kick endpoint after vmload is finished */
-                timer_mod(epctx->kick_timer, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL));
+                if (xhci->er_full_count && !epctx->nr_pstreams) {
+                    xhci_defer_ep_kick(epctx, 0);
+                } else if (xhci->er_full_count == 0 &&
+                           !xhci_deferred_ep_has_kicks(
+                               xhci, xhci_endpoint_index(slotid, epid))) {
+                    /* kick endpoint after vmload is finished */
+                    timer_mod(epctx->kick_timer,
+                              qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL));
+                }
             }
         }
     }
+    xhci_schedule_deferred_kicks(xhci);
     return 0;
 }
 
@@ -3612,6 +4110,38 @@ static const VMStateDescription vmstate_xhci_event = {
     }
 };
 
+static const VMStateDescription vmstate_xhci_pending_event = {
+    .name = "xhci-pending-event",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_STRUCT(event, XHCIPendingEvent, 0,
+                       vmstate_xhci_event, XHCIEvent),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static bool xhci_event_ring_full_needed(void *opaque)
+{
+    XHCIInterrupter *intr = opaque;
+
+    return intr->er_full || !QTAILQ_EMPTY(&intr->pending_events);
+}
+
+static const VMStateDescription vmstate_xhci_event_ring_full = {
+    .name = "xhci-intr/event-ring-full",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = xhci_event_ring_full_needed,
+    .fields = (const VMStateField[]) {
+        VMSTATE_BOOL(er_full, XHCIInterrupter),
+        VMSTATE_BOOL(erdp_pending, XHCIInterrupter),
+        VMSTATE_QTAILQ_V(pending_events, XHCIInterrupter, 1,
+                         vmstate_xhci_pending_event, XHCIPendingEvent, next),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 static bool xhci_er_full(void *opaque, int version_id)
 {
     return false;
@@ -3646,12 +4176,37 @@ static const VMStateDescription vmstate_xhci_intr = {
                                   vmstate_xhci_event, XHCIEvent),
 
         VMSTATE_END_OF_LIST()
+    },
+    .subsections = (const VMStateDescription * const []) {
+        &vmstate_xhci_event_ring_full,
+        NULL
+    }
+};
+
+static bool xhci_deferred_kicks_needed(void *opaque)
+{
+    XHCIState *xhci = opaque;
+
+    return xhci->deferred_kick_count != 0;
+}
+
+static const VMStateDescription vmstate_xhci_deferred_kicks = {
+    .name = "xhci-core/deferred-kicks",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = xhci_deferred_kicks_needed,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT64_2DARRAY(deferred_kicks, XHCIState,
+                               XHCI_MAX_ENDPOINT_CONTEXTS,
+                               XHCI_DEFERRED_KICK_WORDS),
+        VMSTATE_END_OF_LIST()
     }
 };
 
 const VMStateDescription vmstate_xhci = {
     .name = "xhci-core",
     .version_id = 1,
+    .pre_save = usb_xhci_pre_save,
     .post_load = usb_xhci_post_load,
     .fields = (const VMStateField[]) {
         VMSTATE_STRUCT_VARRAY_UINT32(ports, XHCIState, numports, 1,
@@ -3677,6 +4232,10 @@ const VMStateDescription vmstate_xhci = {
         VMSTATE_STRUCT(cmd_ring, XHCIState, 1, vmstate_xhci_ring, XHCIRing),
 
         VMSTATE_END_OF_LIST()
+    },
+    .subsections = (const VMStateDescription * const []) {
+        &vmstate_xhci_deferred_kicks,
+        NULL
     }
 };
 
diff --git a/hw/usb/hcd-xhci.h b/hw/usb/hcd-xhci.h
index 5cb9e06d1d..09f4a81197 100644
--- a/hw/usb/hcd-xhci.h
+++ b/hw/usb/hcd-xhci.h
@@ -25,15 +25,23 @@
 
 #include "hw/usb/usb.h"
 #include "hw/usb/xhci.h"
+#include "qemu/queue.h"
 #include "system/dma.h"
 
 OBJECT_DECLARE_SIMPLE_TYPE(XHCIState, XHCI)
 
-/* Very pessimistic, let's hope it's enough for all cases */
+/* Kept for live migration compatibility only. */
 #define EV_QUEUE (((3 * 24) + 16) * XHCI_MAXSLOTS)
 
+#define XHCI_MAX_ENDPOINT_CONTEXTS (XHCI_MAXSLOTS * 31)
+#define XHCI_MAX_STREAMS 256
+#define XHCI_DEFERRED_KICK_WORDS (XHCI_MAX_STREAMS / 64)
+
 typedef struct XHCIStreamContext XHCIStreamContext;
 typedef struct XHCIEPContext XHCIEPContext;
+typedef struct XHCIDeferredKick XHCIDeferredKick;
+
+QTAILQ_HEAD(XHCIDeferredKickList, XHCIDeferredKick);
 
 enum xhci_flags {
     XHCI_FLAG_ENABLE_STREAMS = 1,
@@ -149,6 +157,13 @@ typedef struct XHCIEvent {
     uint8_t epid;
 } XHCIEvent;
 
+typedef struct XHCIPendingEvent {
+    XHCIEvent event;
+    QTAILQ_ENTRY(XHCIPendingEvent) next;
+} XHCIPendingEvent;
+
+QTAILQ_HEAD(XHCIPendingEventList, XHCIPendingEvent);
+
 typedef struct XHCIInterrupter {
     uint32_t iman;
     uint32_t imod;
@@ -164,6 +179,12 @@ typedef struct XHCIInterrupter {
     uint32_t er_size;
     unsigned int er_ep_idx;
 
+    bool er_full;
+    bool erdp_pending;
+    uint32_t pending_port_events;
+    bool pending_command_ring_stopped;
+    union XHCIPendingEventList pending_events;
+
     /* kept for live migration compat only */
     bool er_full_unused;
     XHCIEvent ev_buffer[EV_QUEUE];
@@ -220,6 +241,14 @@ typedef struct XHCIState {
     QEMUTimer *mfwrap_timer;
     XHCIInterrupter intr[XHCI_MAXINTRS];
 
+    unsigned int er_full_count;
+    unsigned int deferred_kick_count;
+    uint64_t deferred_kicks[XHCI_MAX_ENDPOINT_CONTEXTS]
+                           [XHCI_DEFERRED_KICK_WORDS];
+    QEMUBH *deferred_kick_bh;
+    union XHCIDeferredKickList deferred_kick_queue;
+    XHCIDeferredKick *deferred_kick_eps[XHCI_MAX_ENDPOINT_CONTEXTS];
+
     XHCIRing cmd_ring;
 
     bool nec_quirks;
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 6f74b519c7..4bcd0a0187 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -356,6 +356,7 @@ qos_test_ss.add(
   'tmp105-test.c',
   'emc141x-test.c',
   'usb-hcd-ohci-test.c',
+  'xhci-event-ring-test.c',
   'virtio-test.c',
   'virtio-blk-test.c',
   'virtio-net-test.c',
diff --git a/tests/qtest/xhci-event-ring-test.c b/tests/qtest/xhci-event-ring-test.c
new file mode 100644
index 0000000000..3e28be8c5a
--- /dev/null
+++ b/tests/qtest/xhci-event-ring-test.c
@@ -0,0 +1,560 @@
+/*
+ * QTest testcase for the xHCI event ring
+ *
+ * Copyright (c) 2026 Kirill A. Korinsky
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/bswap.h"
+#include "qemu/module.h"
+#include "hw/pci/pci.h"
+#include "libqtest.h"
+#include "libqos/qgraph.h"
+#include "libqos/pci.h"
+
+#define XHCI_CAPLENGTH                0x00
+#define XHCI_DBOFF                    0x14
+#define XHCI_RTSOFF                   0x18
+
+#define XHCI_USBCMD                   0x00
+#define XHCI_USBSTS                   0x04
+#define XHCI_CRCR_LOW                 0x18
+#define XHCI_CRCR_HIGH                0x1c
+
+#define XHCI_INTR0_OFFSET             0x20
+#define XHCI_ERSTSZ                   (XHCI_INTR0_OFFSET + 0x08)
+#define XHCI_ERSTBA_LOW               (XHCI_INTR0_OFFSET + 0x10)
+#define XHCI_ERSTBA_HIGH              (XHCI_INTR0_OFFSET + 0x14)
+#define XHCI_ERDP_LOW                 (XHCI_INTR0_OFFSET + 0x18)
+#define XHCI_ERDP_HIGH                (XHCI_INTR0_OFFSET + 0x1c)
+
+#define XHCI_USBCMD_RUN               (1U << 0)
+#define XHCI_USBCMD_RESET             (1U << 1)
+#define XHCI_USBSTS_HALTED             (1U << 0)
+#define XHCI_CRCR_RCS                 (1U << 0)
+#define XHCI_CRCR_CS                  (1U << 1)
+
+#define XHCI_TRB_CYCLE                (1U << 0)
+#define XHCI_TRB_TYPE_SHIFT           10
+#define XHCI_TRB_TYPE_MASK            0x3f
+#define XHCI_TRB_DEV_SPEED_SHIFT      16
+#define XHCI_CR_GET_PORT_BANDWIDTH    21
+#define XHCI_CR_NOOP                  23
+#define XHCI_CR_RESERVED              63
+#define XHCI_ER_COMMAND_COMPLETE      33
+#define XHCI_ER_HOST_CONTROLLER       37
+#define XHCI_CC_SUCCESS               1
+#define XHCI_CC_EVENT_RING_FULL       21
+#define XHCI_CC_COMMAND_RING_STOPPED  24
+#define XHCI_SPEED_SUPER              4
+
+#define XHCI_EVENT_RING_SIZE          16
+#define XHCI_DMA_PAGE_SIZE            0x1000
+#define XHCI_DMA_SIZE                 (4 * XHCI_DMA_PAGE_SIZE)
+
+typedef struct QXHCITRB {
+    uint64_t parameter;
+    uint32_t status;
+    uint32_t control;
+} QXHCITRB;
+
+typedef struct QXHCIEventRingSegment {
+    uint32_t addr_low;
+    uint32_t addr_high;
+    uint32_t size;
+    uint32_t reserved;
+} QXHCIEventRingSegment;
+
+typedef struct QXHCI QXHCI;
+
+struct QXHCI {
+    QTestState *qts;
+    uint32_t (*readl)(QXHCI *xhci, uint64_t offset);
+    void (*writel)(QXHCI *xhci, uint64_t offset, uint32_t value);
+};
+
+typedef struct QXHCIPCI {
+    QOSGraphObject obj;
+    QXHCI xhci;
+    QPCIDevice dev;
+    QPCIBar bar;
+} QXHCIPCI;
+
+typedef struct QXHCITest {
+    QXHCI *xhci;
+    QGuestAllocator *alloc;
+    uint64_t dma_base;
+    uint64_t event_ring_addr;
+    uint64_t erst_addr;
+    uint64_t command_ring_addr;
+    uint64_t bandwidth_addr;
+    uint32_t oper;
+    uint32_t runtime;
+    uint32_t doorbell;
+} QXHCITest;
+
+static uint32_t qxhci_pci_readl(QXHCI *xhci, uint64_t offset)
+{
+    QXHCIPCI *pci = container_of(xhci, QXHCIPCI, xhci);
+
+    return qpci_io_readl(&pci->dev, pci->bar, offset);
+}
+
+static void qxhci_pci_writel(QXHCI *xhci, uint64_t offset, uint32_t value)
+{
+    QXHCIPCI *pci = container_of(xhci, QXHCIPCI, xhci);
+
+    qpci_io_writel(&pci->dev, pci->bar, offset, value);
+}
+
+static void *qxhci_pci_get_driver(void *obj, const char *interface)
+{
+    QXHCIPCI *pci = obj;
+
+    if (!g_strcmp0(interface, "xhci")) {
+        return &pci->xhci;
+    }
+
+    g_assert_not_reached();
+}
+
+static void qxhci_pci_start_hw(QOSGraphObject *obj)
+{
+    QXHCIPCI *pci = (QXHCIPCI *)obj;
+
+    qpci_device_enable(&pci->dev);
+}
+
+static void qxhci_pci_destructor(QOSGraphObject *obj)
+{
+    QXHCIPCI *pci = (QXHCIPCI *)obj;
+
+    qpci_iounmap(&pci->dev, pci->bar);
+}
+
+static void *qxhci_pci_create(void *pci_bus, QGuestAllocator *alloc,
+                              void *addr)
+{
+    QXHCIPCI *pci = g_new0(QXHCIPCI, 1);
+    QPCIBus *bus = pci_bus;
+
+    qpci_device_init(&pci->dev, bus, addr);
+    pci->bar = qpci_iomap(&pci->dev, 0, NULL);
+    pci->xhci.qts = bus->qts;
+    pci->xhci.readl = qxhci_pci_readl;
+    pci->xhci.writel = qxhci_pci_writel;
+    pci->obj.get_driver = qxhci_pci_get_driver;
+    pci->obj.start_hw = qxhci_pci_start_hw;
+    pci->obj.destructor = qxhci_pci_destructor;
+
+    return &pci->obj;
+}
+
+static uint32_t qxhci_readl(QXHCITest *test, uint64_t offset)
+{
+    return test->xhci->readl(test->xhci, offset);
+}
+
+static void qxhci_writel(QXHCITest *test, uint64_t offset, uint32_t value)
+{
+    test->xhci->writel(test->xhci, offset, value);
+}
+
+static void qxhci_init(QXHCITest *test, QXHCI *xhci,
+                       QGuestAllocator *alloc)
+{
+    test->xhci = xhci;
+    test->alloc = alloc;
+    test->dma_base = guest_alloc(alloc, XHCI_DMA_SIZE);
+    test->event_ring_addr = test->dma_base;
+    test->erst_addr = test->dma_base + XHCI_DMA_PAGE_SIZE;
+    test->command_ring_addr = test->dma_base + 2 * XHCI_DMA_PAGE_SIZE;
+    test->bandwidth_addr = test->dma_base + 3 * XHCI_DMA_PAGE_SIZE;
+
+    test->oper = qxhci_readl(test, XHCI_CAPLENGTH) & 0xff;
+    test->runtime = qxhci_readl(test, XHCI_RTSOFF) & ~0x1fU;
+    test->doorbell = qxhci_readl(test, XHCI_DBOFF) & ~0x3U;
+
+    qxhci_writel(test, test->oper + XHCI_USBCMD, XHCI_USBCMD_RESET);
+    g_assert_cmphex(qxhci_readl(test, test->oper + XHCI_USBSTS) &
+                    XHCI_USBSTS_HALTED, ==, XHCI_USBSTS_HALTED);
+}
+
+static void qxhci_deinit(QXHCITest *test)
+{
+    qxhci_writel(test, test->oper + XHCI_USBCMD, 0);
+    g_assert_cmphex(qxhci_readl(test, test->oper + XHCI_USBSTS) &
+                    XHCI_USBSTS_HALTED, ==, XHCI_USBSTS_HALTED);
+    qxhci_writel(test, test->oper + XHCI_USBCMD, XHCI_USBCMD_RESET);
+    guest_free(test->alloc, test->dma_base);
+}
+
+static void qxhci_write_command(QXHCITRB *trb, uint32_t type,
+                                uint64_t parameter)
+{
+    trb->parameter = cpu_to_le64(parameter);
+    trb->status = 0;
+    trb->control = cpu_to_le32((type << XHCI_TRB_TYPE_SHIFT) |
+                               XHCI_TRB_CYCLE);
+}
+
+static void qxhci_write_bandwidth_command(QXHCITRB *trb, uint64_t parameter)
+{
+    qxhci_write_command(trb, XHCI_CR_GET_PORT_BANDWIDTH, parameter);
+    trb->control |= cpu_to_le32(XHCI_SPEED_SUPER <<
+                                XHCI_TRB_DEV_SPEED_SHIFT);
+}
+
+static void qxhci_start(QXHCITest *test, const QXHCITRB *commands,
+                        size_t commands_size)
+{
+    QXHCIEventRingSegment segment = {
+        .addr_low = cpu_to_le32(test->event_ring_addr),
+        .addr_high = cpu_to_le32(test->event_ring_addr >> 32),
+        .size = cpu_to_le32(XHCI_EVENT_RING_SIZE),
+    };
+
+    qtest_memset(test->xhci->qts, test->event_ring_addr, 0,
+                 XHCI_EVENT_RING_SIZE * sizeof(QXHCITRB));
+    qtest_memwrite(test->xhci->qts, test->erst_addr, &segment,
+                   sizeof(segment));
+    qtest_memwrite(test->xhci->qts, test->command_ring_addr, commands,
+                   commands_size);
+
+    qxhci_writel(test, test->runtime + XHCI_ERSTSZ, 1);
+    qxhci_writel(test, test->runtime + XHCI_ERDP_LOW,
+                 test->event_ring_addr);
+    qxhci_writel(test, test->runtime + XHCI_ERDP_HIGH,
+                 test->event_ring_addr >> 32);
+    qxhci_writel(test, test->runtime + XHCI_ERSTBA_LOW,
+                 test->erst_addr);
+    qxhci_writel(test, test->runtime + XHCI_ERSTBA_HIGH,
+                 test->erst_addr >> 32);
+    qxhci_writel(test, test->oper + XHCI_CRCR_LOW,
+                 test->command_ring_addr | XHCI_CRCR_RCS);
+    qxhci_writel(test, test->oper + XHCI_CRCR_HIGH,
+                 test->command_ring_addr >> 32);
+    qxhci_writel(test, test->oper + XHCI_USBCMD, XHCI_USBCMD_RUN);
+    g_assert_cmphex(qxhci_readl(test, test->oper + XHCI_USBSTS) &
+                    XHCI_USBSTS_HALTED, ==, 0);
+}
+
+static QXHCITRB qxhci_read_event(QXHCITest *test, unsigned int index)
+{
+    QXHCITRB event;
+
+    qtest_memread(test->xhci->qts,
+                  test->event_ring_addr + index * sizeof(event),
+                  &event, sizeof(event));
+    event.parameter = le64_to_cpu(event.parameter);
+    event.status = le32_to_cpu(event.status);
+    event.control = le32_to_cpu(event.control);
+    return event;
+}
+
+static void qxhci_stop_command_ring(QXHCITest *test)
+{
+    qxhci_writel(test, test->oper + XHCI_CRCR_LOW,
+                 test->command_ring_addr | XHCI_CRCR_RCS | XHCI_CRCR_CS);
+    qxhci_writel(test, test->oper + XHCI_CRCR_HIGH,
+                 test->command_ring_addr >> 32);
+}
+
+static void qxhci_assert_event(QXHCITest *test, unsigned int index,
+                               uint32_t type, uint32_t completion_code,
+                               uint64_t parameter, bool cycle)
+{
+    QXHCITRB event = qxhci_read_event(test, index);
+
+    g_assert_cmpuint((event.control >> XHCI_TRB_TYPE_SHIFT) &
+                     XHCI_TRB_TYPE_MASK, ==, type);
+    g_assert_cmpuint(event.status >> 24, ==, completion_code);
+    g_assert_cmphex(event.parameter, ==, parameter);
+    g_assert_cmphex(event.control & XHCI_TRB_CYCLE, ==,
+                    cycle ? XHCI_TRB_CYCLE : 0);
+}
+
+static void qxhci_assert_full_error_present(QXHCITest *test)
+{
+    unsigned int i;
+
+    for (i = 0; i < XHCI_EVENT_RING_SIZE; i++) {
+        QXHCITRB event = qxhci_read_event(test, i);
+
+        if (((event.control >> XHCI_TRB_TYPE_SHIFT) &
+             XHCI_TRB_TYPE_MASK) == XHCI_ER_HOST_CONTROLLER &&
+            event.status >> 24 == XHCI_CC_EVENT_RING_FULL) {
+            return;
+        }
+    }
+
+    g_assert_not_reached();
+}
+
+static void test_xhci_event_ring_full_layout(void *obj, void *data,
+                                             QGuestAllocator *alloc)
+{
+    QXHCITest test = { 0 };
+    QXHCITRB commands[XHCI_EVENT_RING_SIZE + 1] = { 0 };
+    unsigned int i;
+
+    for (i = 0; i < XHCI_EVENT_RING_SIZE; i++) {
+        qxhci_write_command(&commands[i], XHCI_CR_NOOP, 0);
+    }
+
+    qxhci_init(&test, obj, alloc);
+    qxhci_start(&test, commands, sizeof(commands));
+    qxhci_writel(&test, test.doorbell, 0);
+
+    /* xHCI 1.2c 4.9.4 Figure 4-12 reserves one entry for Full Error. */
+    for (i = 0; i < XHCI_EVENT_RING_SIZE - 1; i++) {
+        qxhci_assert_event(&test, i, XHCI_ER_COMMAND_COMPLETE,
+                           XHCI_CC_SUCCESS,
+                           test.command_ring_addr + i * sizeof(QXHCITRB),
+                           true);
+    }
+    qxhci_assert_event(&test, XHCI_EVENT_RING_SIZE - 1,
+                       XHCI_ER_HOST_CONTROLLER,
+                       XHCI_CC_EVENT_RING_FULL, 0, true);
+    qxhci_deinit(&test);
+}
+
+static void test_xhci_event_ring_full_replay(void *obj, void *data,
+                                             QGuestAllocator *alloc)
+{
+    QXHCITest test = { 0 };
+    QXHCITRB commands[XHCI_EVENT_RING_SIZE + 1] = { 0 };
+    unsigned int i;
+
+    for (i = 0; i < XHCI_EVENT_RING_SIZE; i++) {
+        qxhci_write_command(&commands[i], XHCI_CR_NOOP, 0);
+    }
+
+    qxhci_init(&test, obj, alloc);
+    qxhci_start(&test, commands, sizeof(commands));
+    qxhci_writel(&test, test.doorbell, 0);
+
+    qxhci_assert_full_error_present(&test);
+    qxhci_stop_command_ring(&test);
+
+    /*
+     * xHCI 1.2c 5.5.2.3.3 permits the repeated ERDP for Full-to-Empty;
+     * 4.9.4 Figure 4-12 resumes the Event Ring on that write.
+     */
+    qxhci_writel(&test, test.runtime + XHCI_ERDP_LOW,
+                 test.event_ring_addr);
+    qxhci_writel(&test, test.runtime + XHCI_ERDP_HIGH,
+                 test.event_ring_addr >> 32);
+
+    qxhci_assert_event(&test, 0, XHCI_ER_COMMAND_COMPLETE,
+                       XHCI_CC_SUCCESS,
+                       test.command_ring_addr +
+                       (XHCI_EVENT_RING_SIZE - 1) * sizeof(QXHCITRB),
+                       false);
+    qxhci_assert_event(&test, 1, XHCI_ER_COMMAND_COMPLETE,
+                       XHCI_CC_COMMAND_RING_STOPPED, 0, false);
+    qxhci_deinit(&test);
+}
+
+static void test_xhci_event_ring_full_refill(void *obj, void *data,
+                                             QGuestAllocator *alloc)
+{
+    QXHCITest test = { 0 };
+    QXHCITRB commands[XHCI_EVENT_RING_SIZE + 1] = { 0 };
+    uint64_t erdp;
+    unsigned int i;
+
+    for (i = 0; i < XHCI_EVENT_RING_SIZE; i++) {
+        qxhci_write_command(&commands[i], XHCI_CR_NOOP, 0);
+    }
+
+    qxhci_init(&test, obj, alloc);
+    qxhci_start(&test, commands, sizeof(commands));
+    qxhci_writel(&test, test.doorbell, 0);
+    qxhci_assert_full_error_present(&test);
+    qxhci_stop_command_ring(&test);
+
+    /* Leave one replay credit, forcing a new Full Error in the reserve. */
+    erdp = test.event_ring_addr + 2 * sizeof(QXHCITRB);
+    qxhci_writel(&test, test.runtime + XHCI_ERDP_LOW, erdp);
+    qxhci_writel(&test, test.runtime + XHCI_ERDP_HIGH, erdp >> 32);
+
+    qxhci_assert_event(&test, 0, XHCI_ER_COMMAND_COMPLETE,
+                       XHCI_CC_SUCCESS,
+                       test.command_ring_addr +
+                       (XHCI_EVENT_RING_SIZE - 1) * sizeof(QXHCITRB),
+                       false);
+    qxhci_assert_event(&test, 1, XHCI_ER_HOST_CONTROLLER,
+                       XHCI_CC_EVENT_RING_FULL, 0, false);
+
+    qxhci_writel(&test, test.runtime + XHCI_ERDP_LOW, erdp);
+    qxhci_writel(&test, test.runtime + XHCI_ERDP_HIGH, erdp >> 32);
+    qxhci_assert_event(&test, 2, XHCI_ER_COMMAND_COMPLETE,
+                       XHCI_CC_COMMAND_RING_STOPPED, 0, false);
+    qxhci_deinit(&test);
+}
+
+static void test_xhci_event_ring_full_stop(void *obj, void *data,
+                                           QGuestAllocator *alloc)
+{
+    QXHCITest test = { 0 };
+    QXHCITRB commands[XHCI_EVENT_RING_SIZE + 2] = { 0 };
+    uint64_t stopped_bandwidth_addr;
+    uint8_t bandwidth;
+    unsigned int i;
+
+    for (i = 0; i < XHCI_EVENT_RING_SIZE - 1; i++) {
+        qxhci_write_command(&commands[i], XHCI_CR_NOOP, 0);
+    }
+
+    qxhci_init(&test, obj, alloc);
+    stopped_bandwidth_addr = test.bandwidth_addr + 0x100;
+    qxhci_write_bandwidth_command(&commands[XHCI_EVENT_RING_SIZE - 1],
+                                  test.bandwidth_addr);
+    qxhci_write_bandwidth_command(&commands[XHCI_EVENT_RING_SIZE],
+                                  stopped_bandwidth_addr);
+    qtest_memset(test.xhci->qts, test.bandwidth_addr, 0xa5, 1);
+    qtest_memset(test.xhci->qts, stopped_bandwidth_addr, 0xa5, 1);
+    qxhci_start(&test, commands, sizeof(commands));
+    qxhci_writel(&test, test.doorbell, 0);
+
+    qxhci_assert_full_error_present(&test);
+
+    /* The triggering command completes before its Event Ring Full check. */
+    qtest_memread(test.xhci->qts, test.bandwidth_addr,
+                  &bandwidth, sizeof(bandwidth));
+    g_assert_cmphex(bandwidth, !=, 0xa5);
+
+    /* xHCI 1.2c 4.9.4 Figure 4-12 stops before the following command. */
+    qtest_memread(test.xhci->qts, stopped_bandwidth_addr,
+                  &bandwidth, sizeof(bandwidth));
+    g_assert_cmphex(bandwidth, ==, 0xa5);
+
+    qxhci_writel(&test, test.runtime + XHCI_ERDP_LOW,
+                 test.event_ring_addr);
+    qxhci_writel(&test, test.runtime + XHCI_ERDP_HIGH,
+                 test.event_ring_addr >> 32);
+    qtest_memread(test.xhci->qts, stopped_bandwidth_addr,
+                  &bandwidth, sizeof(bandwidth));
+    g_assert_cmphex(bandwidth, !=, 0xa5);
+    qxhci_deinit(&test);
+}
+
+static void test_xhci_event_ring_full_reset(void *obj, void *data,
+                                            QGuestAllocator *alloc)
+{
+    QXHCITest blocked = { 0 };
+    QXHCITest control = { 0 };
+    QXHCITRB blocked_commands[XHCI_EVENT_RING_SIZE + 1] = { 0 };
+    QXHCITRB control_commands[XHCI_EVENT_RING_SIZE + 1] = { 0 };
+    unsigned int i;
+
+    for (i = 0; i < XHCI_EVENT_RING_SIZE - 1; i++) {
+        qxhci_write_command(&blocked_commands[i], XHCI_CR_NOOP, 0);
+    }
+    /* A leaked pre-reset completion has TRB Error, not Success. */
+    qxhci_write_command(&blocked_commands[XHCI_EVENT_RING_SIZE - 1],
+                        XHCI_CR_RESERVED, 0);
+
+    qxhci_init(&blocked, obj, alloc);
+    qxhci_start(&blocked, blocked_commands, sizeof(blocked_commands));
+    qxhci_writel(&blocked, blocked.doorbell, 0);
+    qxhci_assert_full_error_present(&blocked);
+    qxhci_deinit(&blocked);
+
+    /* HCRST must discard the blocked ring and its pending work. */
+    for (i = 0; i < XHCI_EVENT_RING_SIZE; i++) {
+        qxhci_write_command(&control_commands[i], XHCI_CR_NOOP, 0);
+    }
+    qxhci_init(&control, obj, alloc);
+    qxhci_start(&control, control_commands, sizeof(control_commands));
+    qxhci_writel(&control, control.doorbell, 0);
+    qxhci_assert_full_error_present(&control);
+    qxhci_writel(&control, control.runtime + XHCI_ERDP_LOW,
+                 control.event_ring_addr);
+    qxhci_writel(&control, control.runtime + XHCI_ERDP_HIGH,
+                 control.event_ring_addr >> 32);
+    qxhci_assert_event(&control, 0, XHCI_ER_COMMAND_COMPLETE,
+                       XHCI_CC_SUCCESS,
+                       control.command_ring_addr +
+                       (XHCI_EVENT_RING_SIZE - 1) * sizeof(QXHCITRB),
+                       false);
+    qxhci_deinit(&control);
+}
+
+static void test_xhci_event_ring_full_reprogram(void *obj, void *data,
+                                                QGuestAllocator *alloc)
+{
+    QXHCITest test = { 0 };
+    QXHCITRB commands[XHCI_EVENT_RING_SIZE + 1] = { 0 };
+    unsigned int i;
+
+    for (i = 0; i < XHCI_EVENT_RING_SIZE; i++) {
+        qxhci_write_command(&commands[i], XHCI_CR_NOOP, 0);
+    }
+
+    qxhci_init(&test, obj, alloc);
+    qxhci_start(&test, commands, sizeof(commands));
+    qxhci_writel(&test, test.doorbell, 0);
+    qxhci_assert_full_error_present(&test);
+
+    qxhci_writel(&test, test.oper + XHCI_USBCMD, 0);
+    qxhci_writel(&test, test.runtime + XHCI_ERSTSZ, 0);
+    qxhci_writel(&test, test.runtime + XHCI_ERSTBA_HIGH,
+                 test.erst_addr >> 32);
+
+    qtest_memset(test.xhci->qts, test.event_ring_addr, 0,
+                 XHCI_EVENT_RING_SIZE * sizeof(QXHCITRB));
+    qxhci_writel(&test, test.runtime + XHCI_ERSTSZ, 1);
+    qxhci_writel(&test, test.runtime + XHCI_ERDP_LOW,
+                 test.event_ring_addr);
+    qxhci_writel(&test, test.runtime + XHCI_ERDP_HIGH,
+                 test.event_ring_addr >> 32);
+    qxhci_writel(&test, test.runtime + XHCI_ERSTBA_LOW,
+                 test.erst_addr);
+    qxhci_writel(&test, test.runtime + XHCI_ERSTBA_HIGH,
+                 test.erst_addr >> 32);
+    qxhci_writel(&test, test.oper + XHCI_USBCMD, XHCI_USBCMD_RUN);
+
+    qxhci_assert_event(&test, 0, XHCI_ER_COMMAND_COMPLETE,
+                       XHCI_CC_SUCCESS,
+                       test.command_ring_addr +
+                       (XHCI_EVENT_RING_SIZE - 1) * sizeof(QXHCITRB),
+                       true);
+    qxhci_deinit(&test);
+}
+
+static void qxhci_register_nodes(void)
+{
+    QOSGraphEdgeOptions opts = {
+        .before_cmd_line = "-global pci-host-bridge.bypass-iommu=on",
+        .extra_device_opts = "addr=04.0",
+    };
+    QPCIAddress addr = {
+        .devfn = QPCI_DEVFN(4, 0),
+        .vendor_id = PCI_VENDOR_ID_REDHAT,
+        .device_id = PCI_DEVICE_ID_REDHAT_XHCI,
+    };
+
+    add_qpci_address(&opts, &addr);
+    qos_node_create_driver("qemu-xhci", qxhci_pci_create);
+    qos_node_consumes("qemu-xhci", "pci-bus", &opts);
+    qos_node_produces("qemu-xhci", "xhci");
+
+    qos_add_test("event-ring-full/layout", "xhci",
+                 test_xhci_event_ring_full_layout, NULL);
+    qos_add_test("event-ring-full/replay", "xhci",
+                 test_xhci_event_ring_full_replay, NULL);
+    qos_add_test("event-ring-full/refill", "xhci",
+                 test_xhci_event_ring_full_refill, NULL);
+    qos_add_test("event-ring-full/stop", "xhci",
+                 test_xhci_event_ring_full_stop, NULL);
+    qos_add_test("event-ring-full/reset", "xhci",
+                 test_xhci_event_ring_full_reset, NULL);
+    qos_add_test("event-ring-full/reprogram", "xhci",
+                 test_xhci_event_ring_full_reprogram, NULL);
+}
+
+libqos_init(qxhci_register_nodes);
-- 
2.56.0


