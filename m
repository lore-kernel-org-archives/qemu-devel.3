Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BAFD606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 17:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gHstaVWI;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=JeAzx6QS
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM7GQ-0000sj-CE; Wed, 28 Oct 2026 13:16:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xM7Fb-00076V-0H
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 13:15:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xM7FZ-0003o8-Cw
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 13:15:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793207744;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pbKioKf7eRKWzM2JXaJWvZSryHLaVe5ykt2zdqy8CVk=;
 b=gHstaVWIVDOIevJPVltxVtuEOz+u0x8Zg3rwQ06kcosBjmS5lrpTN8gm2xZkjr5XfRwO6B
 2XxGEcMEg3BYFzO84c1Mcg0HN4H3kExjVBkWdwRBWPp/xuAq6m0ZiyYn8Crvef3/K4O3Pw
 X5cfFo5cUEPtl28N2hY3ETuK99sVWKo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-227-9lf4IKjUMTebWPDOFcRTwA-1; Wed, 28 Oct 2026 13:15:43 -0400
X-MC-Unique: 9lf4IKjUMTebWPDOFcRTwA-1
X-Mimecast-MFC-AGG-ID: 9lf4IKjUMTebWPDOFcRTwA_1793207742
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4a2063be141so10638005e9.1
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 10:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793207742; x=1793812542; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=pbKioKf7eRKWzM2JXaJWvZSryHLaVe5ykt2zdqy8CVk=;
 b=JeAzx6QSrw0m3EIHYyJQu/NJ2vZKMI0wXE4vDN9yFo0GI8dkbelbZm0nOHmkriPOvS
 QnqrYi8BVTeunU/+wfBoUq2PxTADPvKK+4crwWIYeL3ZTmxGk3DnJLavKEfnkIpBnAkt
 Hyn1CQB/fZDuTmj1pwqpM2Co7aOHq6z37Mx8qNlUJ5Crxn5gjO3gLPr5PByataTgTyDr
 5IdfYwDRzS82GsyXZG29cpsJleeJVL0608kSc5ykrzbxhuiZXZrVpkGJFMTQmA2nQ9LR
 33kR/7SIfWQbX+ldeVhUZJr1kZLliOUn4i1ASi3LCo+tsSE1xIPgKskUlw+5/8suE72y
 u94w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793207742; x=1793812542;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=pbKioKf7eRKWzM2JXaJWvZSryHLaVe5ykt2zdqy8CVk=;
 b=oXcDLAT+RcSs8S+X4zdNSmTzTr3MysEMoItHbogOT3e9aaftakcuxiJAQxACz92PL6
 OTWFW0ssjXJ14aFc/QBjlr5ep9zLqCROSBu8mq14GRrQf8WK6FaPa42wXOaXOogbKLWC
 YHuLX5VJA3J9ebprFyuOslUuyLBgxjKOs/f31V0c0TMcnuLElaFkJqWyevUvqfcGXQyA
 kAyai8Lbg2WPfxrt7avFKdn1lOMBftJv9oeDGZLtLjBsj8rQ8Dnj6ad63bgE1ofXuuEq
 C/dfD/xNDxv2ZAf+iZiS8dxZRqW91TrSjmNgrtJWni/1xZhdQRkQU5tRgk/McFRuWiJK
 2PRw==
X-Gm-Message-State: AFq9FYJ5tInsnyH0tNdoWrRtc0EZdk/+V/4vrMTTzlY8o1GlDw5Nuchg
 csuSFxfTksT9R7iHG+x4AA6iyHIg/WZKowlUbl/GIeHxTCm8S2lR2IR57nfxhQGT7G3Oo949Cf0
 Sug3PadB9ahcGJTzD4og1zum8SYWkYk84CX+G7a5x87T0wsKtRf1D1HQEbvw3JQJAW7rujsWodV
 Ee33+eVQ44QkiFouuwvKhCtV571aCqLJ0xQA==
X-Gm-Gg: AYBFou0oNwgubfsN+eUBQF8L8Tt42xuX7jTzREvAiXw44zgI7dQ9jp0YwrA1QyIv6Dc
 3+5HywXfZjHWpvexY1/3geisybjV4JP8LtedQZ5BFO9usoDO9gpLPIMO53xg1E9vxvCd471cFcm
 egp7FKdEga0nOEX4ZJ2+GfxJTiYQFwtc60i+KWiAUq09ez+FMQlWFieySJWO4Wk5N73Hp5jS81m
 AxxQrIsbLmROFwVcW+l0yeG/33JRRZbOWAyOs+SWClG8AUYBasIQJ2ML7j5Q99rVV1/ZAWSA186
 oObsBb56lMVEvGkv4YNH9VQsA2CNtoHf9VJkyAlIXbnolqsdK+wG9wEjVLgVd4Ir4OpuSnB5CwY
 Slx+rNSROxX0tqvzb1buOmlDxgtCBhrbDDBZbjOEd
X-Received: by 2002:a05:600c:4ece:b0:4a1:6c0c:ab93 with SMTP id
 5b1f17b1804b1-4a9674e69dcmr67242195e9.28.1793207742015; 
 Wed, 28 Oct 2026 10:15:42 -0700 (PDT)
X-Received: by 2002:a05:600c:4ece:b0:4a1:6c0c:ab93 with SMTP id
 5b1f17b1804b1-4a9674e69dcmr67241355e9.28.1793207741312; 
 Wed, 28 Oct 2026 10:15:41 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1536:fc00:b838:383:1c7:6e81])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4aa7ee57589sm7095275e9.2.2026.10.28.10.15.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 10:15:40 -0700 (PDT)
Date: Wed, 28 Oct 2026 13:15:38 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Junjie Cao <junjie.cao@intel.com>, Jonathan Cameron <jic23@kernel.org>,
 Junjie Cao <junjie.cao@linux.dev>, Anisa Su <anisa.su@samsung.com>,
 linux-cxl@vger.kernel.org
Subject: [PULL 38/78] hw/cxl: clear event logs, scan media and interrupt
 policy on reset
Message-ID: <a82f0c08fd564fb1e6195849e560b335996b5b97.1793207602.git.mst@redhat.com>
References: <cover.1793207602.git.mst@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1793207602.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Junjie Cao <junjie.cao@intel.com>

Event records, scan media results and event interrupt settings are
device-internal dynamic state that should not survive a device reset.

Per CXL r4.0 Section 8.2.10.9.4.6 (Get Scan Media Results), "If the
Scan Media command has not been called since the last Conventional
Reset, the device shall return the Unsupported return code."  This
explicitly invalidates scan media results across reset, so clear the
scan_media_hasrun flag.

Per CXL r4.0 Section 8.2.10.2.5 (Set Event Interrupt Policy), "All
event log interrupt settings shall be reset to 00b (No Interrupts) by
the device on Conventional Reset."  Clear irq_enabled for every event
log accordingly.

For the event records there is no direct spec mandate to drop the
stored records on reset; the Event Status register (Table 8-203) is
non-sticky and resets to zero per Section 9.7, and no reset flavor
requires the already-reported records to persist.  Draining the queues
is therefore a reasonable modelling choice that keeps the records
consistent with the freshly-reset status register, rather than a spec
requirement.  Call the existing cxl_discard_all_event_records() helper
to drain all event queues.  The event log infrastructure itself
(mutexes, IRQ vectors) remains intact as it is initialized once during
device realize.

This is also where reset-type gating begins: a wakeup from suspend-to-RAM
(RESET_TYPE_WAKEUP) is not a Conventional or CXL Reset and must retain
device-internal state, so the hold phase returns early for that type
before discarding any records.  This mirrors the RESET_TYPE_WAKEUP
shortcut in virtio-mem and virtio-balloon.  Only the unconditional
mailbox interface re-initialization and the in-flight sanitize free
(whose backing timer was already destroyed) run on a wakeup.

Signed-off-by: Junjie Cao <junjie.cao@intel.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260729144645.1552511-7-junjie.cao@intel.com>
---
 hw/mem/cxl_type3.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 04558a114f..26c3773dc0 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -1360,6 +1360,23 @@ static void ct3d_reset_hold(Object *obj, ResetType type)
     }
     cxl_initialize_t3_ld_cci(&ct3d->ld0_cci, DEVICE(ct3d), DEVICE(ct3d),
                              512); /* Max payload made up */
+
+    /*
+     * A wakeup from suspend-to-RAM is not a Conventional or CXL Reset.  The
+     * device-internal dynamic state cleared below (event logs, scan media
+     * results, and the poison/feature-transfer state cleared in subsequent
+     * patches) must be preserved across resume, so stop here for a wakeup.
+     * virtio-mem and virtio-balloon take the same RESET_TYPE_WAKEUP shortcut.
+     */
+    if (type == RESET_TYPE_WAKEUP) {
+        return;
+    }
+
+    cxl_discard_all_event_records(&ct3d->cxl_dstate);
+    for (int i = 0; i < CXL_EVENT_TYPE_MAX; i++) {
+        ct3d->cxl_dstate.event_logs[i].irq_enabled = false;
+    }
+    ct3d->scan_media_hasrun = false;
 }
 
 static const Property ct3_props[] = {
-- 
MST


