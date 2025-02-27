Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A612EC19F2E
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 14:20:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnekJ-0006xA-DW; Thu, 27 Feb 2025 09:20:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tnekE-0006py-1B
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 09:20:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tnek9-0003Tp-8T
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 09:20:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740666001;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Yd96deOozQ4yFlkLSTWHMyluR4p3ujPsRgX3RMFDVT8=;
 b=PU1kJAiO+ZMdlT94zPxZbtkNQ/y5FPdp7VRUOUxHI2r6Lx7CaeLTYH0dF6VY+w7juWWx1D
 jpx2+0v2bRYUITJihcTWg3w6oFKV8zM194e5laF+zNd6oGmz/1NJLE0SpUvFljcV/wENRk
 YjO2EeMvThFY0Enxz5V/UHDXwCNpggI=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-171-ythVPMXcMr-U-Zs9c4Armw-1; Thu, 27 Feb 2025 09:20:00 -0500
X-MC-Unique: ythVPMXcMr-U-Zs9c4Armw-1
X-Mimecast-MFC-AGG-ID: ythVPMXcMr-U-Zs9c4Armw_1740665999
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-abb76bd0feeso127363366b.0
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2025 06:19:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740665997; x=1741270797;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Yd96deOozQ4yFlkLSTWHMyluR4p3ujPsRgX3RMFDVT8=;
 b=hjJ/lyhjbUMDsLt+yF978CwnRohk2qoKcJlVzhU/w+tRGRdgTWGS61a5Qn7f/8ILqZ
 xjj/zdqa5kSQedW5UTtYEC357EjiMs4bvp8X5UeoUOhFBmAEetFOKPeRl2OxEZyBa505
 +zWdp2/acWLxdYsO67q6+Sy3rGAqRZrOw37IZdsKGCF+grzQS0mg7qUhFWQLZGMSqbwa
 LmKIRnRFbBZpqVtSpMkCNqOpQCxNj63korcU3cIZ422uxYPMO9JaVagnB6hElCoNrobx
 Z+CcoTzgV+qsAvUdi8lkPBi2cfoJu1ac/ObIZvHK+cu3geL7tq4rjZff9XKJX/vhAKtd
 olCg==
X-Gm-Message-State: AOJu0Yx7Ecr+/6h0pc6rhkOLAXDTVc2TJkYjAqDQpTOHxUP12/tSrjQL
 iyGtEU9UkC1qIDb+f1l9O5dtRssz5UiYzbRMvakr7E3mdcHjxmR3fOzppPUWHmtWftVABgFPTfF
 Jes2bXG16aRhU3gsaLHwPKy+qZ2A3Ea2pebbamuNQHoN+z2xNR2gSYv/19b4IeK5aWpJtsIFKt1
 QDiF5OHZh8OFaulky4KN3VbxtzwEsFcksaKUEqcNg=
X-Gm-Gg: ASbGnctfpClMmVQVnar6USw2AVaKvZ4d5I9lionbN1Ri4W90YceKMbpY17MktiUkYBd
 CkZ4RghxIt4H7g2T36u/kFjBsVi07va/8j9OfVAvNyc1SrxSMHgXNdXmvejjaE86H7YH8hQD21U
 26Rlox3UoNUwcQuDPIJmVwEJnBQvsXeefhZHfLj3Wn4u7TTTTaaHD1ZAVLFC1Q/uAEdQOqMgQq/
 NgYn7SRuwqfvLVcveR8jSJhDdDW0Kxstt0iTZvriFModMHPcSw5AXG/HnesFNC5lR5dyK/5e00v
 Jx1muz/98d5X/k2boIrw
X-Received: by 2002:a17:907:96ac:b0:ab7:d34a:8f83 with SMTP id
 a640c23a62f3a-abf0609c4d0mr495143066b.17.1740665996809; 
 Thu, 27 Feb 2025 06:19:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEue+gpbYy29G1dTgzJx7eaylJDIreWqwC32T3hk9MPX7vIKqxCgOl3nM57B6lknnK94DTc7g==
X-Received: by 2002:a17:907:96ac:b0:ab7:d34a:8f83 with SMTP id
 a640c23a62f3a-abf0609c4d0mr495137066b.17.1740665996400; 
 Thu, 27 Feb 2025 06:19:56 -0800 (PST)
Received: from [192.168.10.48] ([176.206.102.52])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-abf0c0dc5d5sm131905966b.63.2025.02.27.06.19.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Feb 2025 06:19:55 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 02/34] hpet: do not overwrite properties on post_load
Date: Thu, 27 Feb 2025 15:19:20 +0100
Message-ID: <20250227141952.811410-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250227141952.811410-1-pbonzini@redhat.com>
References: <20250227141952.811410-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Reviewed-by: Zhao Liu <zhao1.liu@intel.com> (hpet_post_load only)
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
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


