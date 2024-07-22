Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80E7CC3DA59
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 12:07:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVro0-0000VA-9l; Mon, 22 Jul 2024 08:06:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sVrnr-0008HA-Jy
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 08:06:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sVrno-0007w3-9w
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 08:06:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721649963;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tClUS2s/M0YyRZbl85m11Cv3d2+aU9p8IaBUrdhpDqA=;
 b=d00ZvyTHrbRAsl1PRiWDFtlTiP8EBSV+Ko+9L7UsldeWOtbiPA3TGbXmKKm56VILRquItP
 g7Em09edJgWTTOroqIbtOfrFP2UB9IvnvPxNnHBFx4A0sMYkAtyNVcydHt66nMbfDPMfMk
 1ZTZr5XB261B1P/CSt6mcdBN/tyoOJ8=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-15-SSc8k4EJMQO6zM22Gl4XwQ-1; Mon, 22 Jul 2024 08:06:01 -0400
X-MC-Unique: SSc8k4EJMQO6zM22Gl4XwQ-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a77df0dc240so347886766b.3
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 05:06:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721649960; x=1722254760;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tClUS2s/M0YyRZbl85m11Cv3d2+aU9p8IaBUrdhpDqA=;
 b=wWd65Z4bNSK/oNyxjCKSSwb0m3vih1bGCXEaw/+PSmVVswEbDsNWM9uiLy+ohgDVZ7
 blk4YW3E1of1KXm8L5dXAN/vY4BWjlX/CojzBR/bFl+tpFcyMur/2uzimYiLQ+Z+Xf/f
 FTDKFG3OR80ctzljdVHw94VMb/pls7VGl2FSSZPHK4g8PemiZ7jf7fRwTPoSeQyHKpD3
 BXXCbzOYz5QmAgCVpeay/YhJrufCXWcA47Gc8nBQufeND9LJRsrjvjiQhbhUrN2nZ7Vo
 s8EX+BQSpwXENa11W+PB186cfOUHnA8OXWpkKwN5Tqt2wl9XNIDfB/CYdpPSzZj7L5h7
 6okg==
X-Gm-Message-State: AOJu0Yxxkq+GBiCatsxxGvxfsWkxpvRV+lg0ioFtVmSKj0T6ZS/Ry7bb
 iQqaySRD3NvqxLkYQvXUgC/DZN4GZGCSxSCFxGEvEGuUREUbADRlnpxuIlH1mtwofpZLrVIL8VH
 BLFHOd5lYBkKAXip/7NXAhhexr7s2t5C6Y+ZEHFGMg3c7gvB6oo8Nbhxc7BC1016lJbp03ORVGB
 zYbwiXoqVsvNVRjVtPEG7w4z58Zl5vwfEj5+QK
X-Received: by 2002:a17:907:944b:b0:a77:d0a0:ea74 with SMTP id
 a640c23a62f3a-a7a4bfa4f77mr438361466b.3.1721649960154; 
 Mon, 22 Jul 2024 05:06:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHoi/zm0pSQtqSuvPv3mMzgrC2a/0wb5qN0c+vcSDZdCPIPcvGvxGg0SVbFUVc0slbqB3WUxQ==
X-Received: by 2002:a17:907:944b:b0:a77:d0a0:ea74 with SMTP id
 a640c23a62f3a-a7a4bfa4f77mr438359566b.3.1721649959811; 
 Mon, 22 Jul 2024 05:05:59 -0700 (PDT)
Received: from avogadro.local ([151.95.101.29])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7a3c92308dsm419969166b.170.2024.07.22.05.05.58
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jul 2024 05:05:59 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 7/7] hpet: avoid timer storms on periodic timers
Date: Mon, 22 Jul 2024 14:05:41 +0200
Message-ID: <20240722120541.70790-8-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240722120541.70790-1-pbonzini@redhat.com>
References: <20240722120541.70790-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

If the period is set to a value that is too low, there could be no
time left to run the rest of QEMU.  Do not trigger interrupts faster
than 1 MHz.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/timer/hpet.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/hw/timer/hpet.c b/hw/timer/hpet.c
index 1654b7cb8b8..471950adef1 100644
--- a/hw/timer/hpet.c
+++ b/hw/timer/hpet.c
@@ -59,6 +59,7 @@ typedef struct HPETTimer {  /* timers */
     uint8_t wrap_flag;      /* timer pop will indicate wrap for one-shot 32-bit
                              * mode. Next pop will be actual timer expiration.
                              */
+    uint64_t last;          /* last value armed, to avoid timer storms */
 } HPETTimer;
 
 struct HPETState {
@@ -266,6 +267,7 @@ static int hpet_post_load(void *opaque, int version_id)
     for (i = 0; i < s->num_timers; i++) {
         HPETTimer *t = &s->timer[i];
         t->cmp64 = hpet_calculate_cmp64(t, s->hpet_counter, t->cmp);
+        t->last = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) - NANOSECONDS_PER_SECOND;
     }
     /* Recalculate the offset between the main counter and guest time */
     if (!s->hpet_offset_saved) {
@@ -364,8 +366,15 @@ static const VMStateDescription vmstate_hpet = {
 
 static void hpet_arm(HPETTimer *t, uint64_t tick)
 {
-    /* FIXME: Clamp period to reasonable min value? */
-    timer_mod(t->qemu_timer, hpet_get_ns(t->state, tick));
+    uint64_t ns = hpet_get_ns(t->state, tick);
+
+    /* Clamp period to reasonable min value (1 us) */
+    if (timer_is_periodic(t) && ns - t->last < 1000) {
+        ns = t->last + 1000;
+    }
+
+    t->last = ns;
+    timer_mod(t->qemu_timer, ns);
 }
 
 /*
-- 
2.45.2


