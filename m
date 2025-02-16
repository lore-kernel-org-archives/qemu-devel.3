Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82EF8C02198
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2025 09:30:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjaxX-0006Y6-PC; Sun, 16 Feb 2025 04:29:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tjaxW-0006Xv-6n
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 04:29:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tjaxU-0000mj-Er
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 04:29:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739698140;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=nqCS8aVqo48MHLwS9VGBeK8SxpnR9X2XLdWh3HfIHf8=;
 b=DBNECjAfmq5kS55fj0OC73FItXW1Kq8AXmim9AIvahWK2RBMF/9TYol1bmcB7kQBuEtxlq
 vzDya8IatxLTDC6aQZ+zIrImS0wIfPwzIsaywb2BOQ0yAn+sw0Yh5/TVmLXrVwAViVumCN
 ZBdDxzqtTWSa+bF4Fq6RYk96L5567UQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-R_qR3rXXO6qJnFyp_IMhig-1; Sun, 16 Feb 2025 04:28:57 -0500
X-MC-Unique: R_qR3rXXO6qJnFyp_IMhig-1
X-Mimecast-MFC-AGG-ID: R_qR3rXXO6qJnFyp_IMhig_1739698136
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43935bcec74so18728095e9.3
 for <qemu-devel@nongnu.org>; Sun, 16 Feb 2025 01:28:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739698135; x=1740302935;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nqCS8aVqo48MHLwS9VGBeK8SxpnR9X2XLdWh3HfIHf8=;
 b=rQDi4YZl9x9vbD9DymY60V4mwx8/5LXefIHu8q6G2dD//a4AAuA7N8Cc0PmPOxncVV
 yLU3D/ARcWQFm8Jt46ut7K1X9IcPA/e70Lbh1xHS03TrMgTdw5BuG4l0hd0MOuKSeiYZ
 Zh44V0/+Ia/ZpJFBlEkaHnNvNbGkm+eD9ElD0s/fiwQut5dmakOeotwtIfHZ5Vjr1SBN
 7xWR/2M2NJ7yVrqleA/HZQ4dbFeneqsC6pWwaiXK4PbppA2ytEIUCI17NzVRTXEHJXuU
 adFev7IZTErta2pQf5CExyTM1E+KEFqDC8REyXqxpB0tPiDwNdCUdxoOTGL24TngpwuU
 /ZEw==
X-Gm-Message-State: AOJu0YwAvknf32JJj87VGEm2zb4JQaKsIhlkRtMoVbgGRuGj8lRUyEl1
 rnUNd1pagVrq65SymFffwTfgim3XOWQ/3ulDJqC3MZ1A9+x5ijeSBTE/QCM1q5jUkRYKaTXKsTG
 wwiqQXdMTU4kr0UVd/nLyOAsmOm4wwgE0TH0tzkRFXSLHf5yqfa+YFze3baCZHFJPgGGuYiCJtx
 Q0nFR7aJAx07UOVIRJqUlTerLowJe888EW7v84vQQ=
X-Gm-Gg: ASbGncuHPx4cnExGvKCuT0Geu+Z59Fe5DIjQGxjZRU+QbZX+zHf9NjL4xRMYSPZldlr
 XYwxHHiWbXgrVCnm+Z7OCyxBDIxNQ2b3HIDhK0/mAe6dNbJDXl7u2qSD8OV82YuRORm5ILr3UHQ
 vaCpBDfnO/JtDD/HUEpK28mamwmrOYrD7S3K9pETLuA6g4E69GIDgFyKhryYbS6YhEPC0nAAjv2
 W7rg3qZ0SPakMVCPelDyORU0ygE3JXDImois5Yjk4Eu8aH3ETkDouxqZHmjUUD4ZqUVcxf2cuVC
 u2I0240TOZU=
X-Received: by 2002:a05:600c:4711:b0:439:4700:9eb1 with SMTP id
 5b1f17b1804b1-4396e69992fmr46801225e9.2.1739698135548; 
 Sun, 16 Feb 2025 01:28:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGC2Y/7Li0lTpEYpTm4ugAjug/zDU8BVpUme382e1mNsFV6jAwjOCx5POX/u7el/rLirzTAqg==
X-Received: by 2002:a05:600c:4711:b0:439:4700:9eb1 with SMTP id
 5b1f17b1804b1-4396e69992fmr46801085e9.2.1739698135051; 
 Sun, 16 Feb 2025 01:28:55 -0800 (PST)
Received: from [192.168.10.48] ([176.206.122.109])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4395a1aa7f3sm123259345e9.29.2025.02.16.01.28.54
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2025 01:28:54 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2] hpet: do not overwrite properties on post_load
Date: Sun, 16 Feb 2025 10:28:53 +0100
Message-ID: <20250216092853.4169458-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.195,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Migration relies on having the same device configuration on the source
and destination.  Therefore, there is no need to modify flags,
timer capabilities and the fw_cfg HPET block id on migration;
it was set to exactly the same values by realize.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
        v1->v2: also do not overwrite num_timers

 hw/timer/hpet.c | 38 ++++++++++----------------------------
 1 file changed, 10 insertions(+), 28 deletions(-)

diff --git a/hw/timer/hpet.c b/hw/timer/hpet.c
index dcff18a9871..ccb97b68066 100644
--- a/hw/timer/hpet.c
+++ b/hw/timer/hpet.c
@@ -77,6 +77,7 @@ struct HPETState {
     uint8_t rtc_irq_level;
     qemu_irq pit_enabled;
     uint8_t num_timers;
+    uint8_t num_timers_save;
     uint32_t intcap;
     HPETTimer timer[HPET_MAX_TIMERS];
 
@@ -237,15 +238,12 @@ static int hpet_pre_save(void *opaque)
         s->hpet_counter = hpet_get_ticks(s);
     }
 
-    return 0;
-}
-
-static int hpet_pre_load(void *opaque)
-{
-    HPETState *s = opaque;
-
-    /* version 1 only supports 3, later versions will load the actual value */
-    s->num_timers = HPET_MIN_TIMERS;
+    /*
+     * The number of timers must match on source and destination, but it was
+     * also added to the migration stream.  Check that it matches the value
+     * that was configured.
+     */
+    s->num_timers_save = s->num_timers;
     return 0;
 }
 
@@ -253,12 +251,7 @@ static bool hpet_validate_num_timers(void *opaque, int version_id)
 {
     HPETState *s = opaque;
 
-    if (s->num_timers < HPET_MIN_TIMERS) {
-        return false;
-    } else if (s->num_timers > HPET_MAX_TIMERS) {
-        return false;
-    }
-    return true;
+    return s->num_timers == s->num_timers_save;
 }
 
 static int hpet_post_load(void *opaque, int version_id)
@@ -277,16 +270,6 @@ static int hpet_post_load(void *opaque, int version_id)
                         - qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
     }
 
-    /* Push number of timers into capability returned via HPET_ID */
-    s->capability &= ~HPET_ID_NUM_TIM_MASK;
-    s->capability |= (s->num_timers - 1) << HPET_ID_NUM_TIM_SHIFT;
-    hpet_fw_cfg.hpet[s->hpet_id].event_timer_block_id = (uint32_t)s->capability;
-
-    /* Derive HPET_MSI_SUPPORT from the capability of the first timer. */
-    s->flags &= ~(1 << HPET_MSI_SUPPORT);
-    if (s->timer[0].config & HPET_TN_FSB_CAP) {
-        s->flags |= 1 << HPET_MSI_SUPPORT;
-    }
     return 0;
 }
 
@@ -347,14 +330,13 @@ static const VMStateDescription vmstate_hpet = {
     .version_id = 2,
     .minimum_version_id = 1,
     .pre_save = hpet_pre_save,
-    .pre_load = hpet_pre_load,
     .post_load = hpet_post_load,
     .fields = (const VMStateField[]) {
         VMSTATE_UINT64(config, HPETState),
         VMSTATE_UINT64(isr, HPETState),
         VMSTATE_UINT64(hpet_counter, HPETState),
-        VMSTATE_UINT8_V(num_timers, HPETState, 2),
-        VMSTATE_VALIDATE("num_timers in range", hpet_validate_num_timers),
+        VMSTATE_UINT8_V(num_timers_save, HPETState, 2),
+        VMSTATE_VALIDATE("num_timers must match", hpet_validate_num_timers),
         VMSTATE_STRUCT_VARRAY_UINT8(timer, HPETState, num_timers, 0,
                                     vmstate_hpet_timer, HPETTimer),
         VMSTATE_END_OF_LIST()
-- 
2.48.1


