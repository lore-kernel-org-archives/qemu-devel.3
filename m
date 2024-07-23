Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11139C3DA63
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 14:17:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWGJU-00066C-Ca; Tue, 23 Jul 2024 10:16:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sWGJE-0005TP-S0
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 10:16:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sWGJB-0007F2-SN
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 10:16:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721744165;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tClUS2s/M0YyRZbl85m11Cv3d2+aU9p8IaBUrdhpDqA=;
 b=fF9wgae5T7M/fHenUJ2fflY5L8dztgyl3Gi2ksf20Qlq+hsQ9/5T4Nb9T46WIc9tMypZBT
 DNClkNtd2z42hK7rVwyfh5ZDLD4qhlHBvCnjYwEawc5Yx5THqjmxHNaYwUQOMFqkEPlNbh
 w1vVhKU81jRGV/rHnyyvLGs5Xi6XPs0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-401-dzYBZFupN0ubaxgyGL_c3g-1; Tue, 23 Jul 2024 10:16:02 -0400
X-MC-Unique: dzYBZFupN0ubaxgyGL_c3g-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-36832c7023bso3243374f8f.2
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 07:16:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721744161; x=1722348961;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tClUS2s/M0YyRZbl85m11Cv3d2+aU9p8IaBUrdhpDqA=;
 b=kE6iwGXGg8GJbsCrzo5+uaRpOohfBq/y92onNAvKelHFoPqaWBwo/W45wEsAdCugrm
 pJLKvAASAxCXRd8xvcmYg79qWlfmiAtUkci7U0CMQLOrwjHKNnqv/ZcIQlRgz7+6t8p6
 heafR6Wh7kAEmgPn1rYZvwLoHfYw2kgYzWYODZ3sFiAvvh6BxUdiG3c0SwN/tLdl45VA
 q5EeSErROqgCN4MkaabkztqwbJz5hr30hwXPyOf1/ivXNA8OXFoAICTAeUlYQ0TX8qC6
 CWgQ6FnC0cQqKusv/LV+Owcna7/+gcBJUle2AeEdoM3Emv3jcWjxf56mGUh7UGSKTGQk
 ukwA==
X-Gm-Message-State: AOJu0YzZzVQKmmsrmFEKdI+cdkxJYEn+xHjaAJEMe/XCg2IIkC9eZnjF
 RxDk0zeLRa4RlsbFfwn3mdYizFQMavz4LllZb2hL2jSVdC+qMAMcfYsFpm6IqMI8MsK3RpxAHwy
 CjHu3nGZfCPwnXLRt8b5qjFFcmCxas9F0e93k71I6LxWsSjmvnV0pcXZbdCRFGsBbQH+uNkWrgG
 kcMwrQT1VC8Tds1v3r9ieDf5XjlG0YLhY3DvDr
X-Received: by 2002:a05:6000:1564:b0:368:4910:8f49 with SMTP id
 ffacd0b85a97d-369bae23910mr7158192f8f.12.1721744161335; 
 Tue, 23 Jul 2024 07:16:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGvLD8dFCXeg1E8al4FQUbHm7UUf+7qa7GAS1iRuhIUznmjft04usdMkSBFN1xVaIb9Xk58Fw==
X-Received: by 2002:a05:6000:1564:b0:368:4910:8f49 with SMTP id
 ffacd0b85a97d-369bae23910mr7158173f8f.12.1721744160955; 
 Tue, 23 Jul 2024 07:16:00 -0700 (PDT)
Received: from avogadro.local ([151.95.101.29])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36878694a4dsm11718986f8f.59.2024.07.23.07.16.00
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jul 2024 07:16:00 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 11/11] hpet: avoid timer storms on periodic timers
Date: Tue, 23 Jul 2024 16:15:29 +0200
Message-ID: <20240723141529.551737-12-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240723141529.551737-1-pbonzini@redhat.com>
References: <20240723141529.551737-1-pbonzini@redhat.com>
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


