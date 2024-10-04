Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 091B4CF884D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2024 16:43:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swlI0-0001VE-9R; Fri, 04 Oct 2024 12:36:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1swlGy-00086k-1u
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 12:35:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1swlGw-0006Rc-AF
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 12:35:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728059717;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MHCtYjHZqWBXvAFkbnga8RDrSxeZpUx1dCLsimTB34c=;
 b=WutKUpyHZnlK/GL9QgwYmX9gJLSp5+0Fsho0jUOiWAZx9fuM4DMpAM9qOVuL1IuVVftqme
 iWaxqsbE4hwOq9RpKkdjDBYX/HvGcG5NcqWhPEdDdA4CsI+LKgFqHoutZgygOAUDuzhoUT
 2NUOjf3uU27FuVxvRuo2X8/U5shxUs8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-104-7bv196j8NrCXbkK40Ji2yw-1; Fri, 04 Oct 2024 12:35:16 -0400
X-MC-Unique: 7bv196j8NrCXbkK40Ji2yw-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-42f89a68c29so1416195e9.1
 for <qemu-devel@nongnu.org>; Fri, 04 Oct 2024 09:35:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728059714; x=1728664514;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MHCtYjHZqWBXvAFkbnga8RDrSxeZpUx1dCLsimTB34c=;
 b=AfWDdyQfE2w/pu/zmtovBsn+yKOsa4KZZfCelEyU4Buwcy6KM5l413Nti3ZP+bAvHG
 H0ChBt+QMUXmPGq2MQWyHaIi0DwgkZOXV1iWS+NkBPBo7udG7FGQoFEcQlRVOyBAWjVb
 CcpmXAeNYI6qLX7jSgUHXPV6D6hzrv0rp3NA1WNZSB1MsUvUBjmtMIaogxGNPEDlVUFC
 /E0RhmzobEVK21WoZng9pYMK5E9wYMTgLF4ORu2i803150zvdfpxEBE2xffCLT104wBs
 809/lHHGul69/oTeWYz6OKaB5YYXTy0wC2vffXle9b7McVPiYud9kf+5ZfCMQDj/mvyk
 qNsQ==
X-Gm-Message-State: AOJu0YxOW420yy9Tj6YKZQbSkMoEeHWd/TuM04IySSqv4f3DG2GZlEU+
 U7R292sPH8vEozymgoWEMRGxoTi/jg0LT9CvvlnvRMNJXlmPoFKwjouBt6ictybGqIBYiOoqk+o
 eHw0ksRT0JZujZr+WK0Ycx3Nt9S4S/qOPVFFGas42U+7bbSaQOAK46pGZLXg7CC/g0l/oaObS3u
 YUHMk9B8jlAr37w+/yGPICQnfVNXUw+18hiMxMbgc=
X-Received: by 2002:a5d:5306:0:b0:37c:c842:a16e with SMTP id
 ffacd0b85a97d-37d0e6f28a5mr2251527f8f.5.1728059714059; 
 Fri, 04 Oct 2024 09:35:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH/Hy6Sdyxc915rkTtKJcvJ5h+axZmR6OEQFFkAHW1qxMFwNhFqm3SYIrvsQ7K7MRn6WoRlOQ==
X-Received: by 2002:a5d:5306:0:b0:37c:c842:a16e with SMTP id
 ffacd0b85a97d-37d0e6f28a5mr2251505f8f.5.1728059713547; 
 Fri, 04 Oct 2024 09:35:13 -0700 (PDT)
Received: from avogadro.local ([151.95.43.71])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d1691fff0sm35017f8f.51.2024.10.04.09.35.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Oct 2024 09:35:13 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>
Subject: [PULL 18/23] accel/kvm: refactor dirty ring setup
Date: Fri,  4 Oct 2024 18:34:10 +0200
Message-ID: <20241004163415.951106-19-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20241004163415.951106-1-pbonzini@redhat.com>
References: <20241004163415.951106-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.146,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Ani Sinha <anisinha@redhat.com>

Refactor setting up of dirty ring code in kvm_init() so that is can be
reused in the future patchsets.

Signed-off-by: Ani Sinha <anisinha@redhat.com>
Link: https://lore.kernel.org/r/20240912061838.4501-1-anisinha@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 accel/kvm/kvm-all.c | 88 +++++++++++++++++++++++++--------------------
 1 file changed, 50 insertions(+), 38 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index e06cf3a4157..e57492fda5c 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -2435,6 +2435,55 @@ static int find_kvm_machine_type(MachineState *ms)
     return type;
 }
 
+static int kvm_setup_dirty_ring(KVMState *s)
+{
+    uint64_t dirty_log_manual_caps;
+    int ret;
+
+    /*
+     * Enable KVM dirty ring if supported, otherwise fall back to
+     * dirty logging mode
+     */
+    ret = kvm_dirty_ring_init(s);
+    if (ret < 0) {
+        return ret;
+    }
+
+    /*
+     * KVM_CAP_MANUAL_DIRTY_LOG_PROTECT2 is not needed when dirty ring is
+     * enabled.  More importantly, KVM_DIRTY_LOG_INITIALLY_SET will assume no
+     * page is wr-protected initially, which is against how kvm dirty ring is
+     * usage - kvm dirty ring requires all pages are wr-protected at the very
+     * beginning.  Enabling this feature for dirty ring causes data corruption.
+     *
+     * TODO: Without KVM_CAP_MANUAL_DIRTY_LOG_PROTECT2 and kvm clear dirty log,
+     * we may expect a higher stall time when starting the migration.  In the
+     * future we can enable KVM_CLEAR_DIRTY_LOG to work with dirty ring too:
+     * instead of clearing dirty bit, it can be a way to explicitly wr-protect
+     * guest pages.
+     */
+    if (!s->kvm_dirty_ring_size) {
+        dirty_log_manual_caps =
+            kvm_check_extension(s, KVM_CAP_MANUAL_DIRTY_LOG_PROTECT2);
+        dirty_log_manual_caps &= (KVM_DIRTY_LOG_MANUAL_PROTECT_ENABLE |
+                                  KVM_DIRTY_LOG_INITIALLY_SET);
+        s->manual_dirty_log_protect = dirty_log_manual_caps;
+        if (dirty_log_manual_caps) {
+            ret = kvm_vm_enable_cap(s, KVM_CAP_MANUAL_DIRTY_LOG_PROTECT2, 0,
+                                    dirty_log_manual_caps);
+            if (ret) {
+                warn_report("Trying to enable capability %"PRIu64" of "
+                            "KVM_CAP_MANUAL_DIRTY_LOG_PROTECT2 but failed. "
+                            "Falling back to the legacy mode. ",
+                            dirty_log_manual_caps);
+                s->manual_dirty_log_protect = 0;
+            }
+        }
+    }
+
+    return 0;
+}
+
 static int kvm_init(MachineState *ms)
 {
     MachineClass *mc = MACHINE_GET_CLASS(ms);
@@ -2454,7 +2503,6 @@ static int kvm_init(MachineState *ms)
     const KVMCapabilityInfo *missing_cap;
     int ret;
     int type;
-    uint64_t dirty_log_manual_caps;
 
     qemu_mutex_init(&kml_slots_lock);
 
@@ -2566,47 +2614,11 @@ static int kvm_init(MachineState *ms)
     s->coalesced_pio = s->coalesced_mmio &&
                        kvm_check_extension(s, KVM_CAP_COALESCED_PIO);
 
-    /*
-     * Enable KVM dirty ring if supported, otherwise fall back to
-     * dirty logging mode
-     */
-    ret = kvm_dirty_ring_init(s);
+    ret = kvm_setup_dirty_ring(s);
     if (ret < 0) {
         goto err;
     }
 
-    /*
-     * KVM_CAP_MANUAL_DIRTY_LOG_PROTECT2 is not needed when dirty ring is
-     * enabled.  More importantly, KVM_DIRTY_LOG_INITIALLY_SET will assume no
-     * page is wr-protected initially, which is against how kvm dirty ring is
-     * usage - kvm dirty ring requires all pages are wr-protected at the very
-     * beginning.  Enabling this feature for dirty ring causes data corruption.
-     *
-     * TODO: Without KVM_CAP_MANUAL_DIRTY_LOG_PROTECT2 and kvm clear dirty log,
-     * we may expect a higher stall time when starting the migration.  In the
-     * future we can enable KVM_CLEAR_DIRTY_LOG to work with dirty ring too:
-     * instead of clearing dirty bit, it can be a way to explicitly wr-protect
-     * guest pages.
-     */
-    if (!s->kvm_dirty_ring_size) {
-        dirty_log_manual_caps =
-            kvm_check_extension(s, KVM_CAP_MANUAL_DIRTY_LOG_PROTECT2);
-        dirty_log_manual_caps &= (KVM_DIRTY_LOG_MANUAL_PROTECT_ENABLE |
-                                  KVM_DIRTY_LOG_INITIALLY_SET);
-        s->manual_dirty_log_protect = dirty_log_manual_caps;
-        if (dirty_log_manual_caps) {
-            ret = kvm_vm_enable_cap(s, KVM_CAP_MANUAL_DIRTY_LOG_PROTECT2, 0,
-                                    dirty_log_manual_caps);
-            if (ret) {
-                warn_report("Trying to enable capability %"PRIu64" of "
-                            "KVM_CAP_MANUAL_DIRTY_LOG_PROTECT2 but failed. "
-                            "Falling back to the legacy mode. ",
-                            dirty_log_manual_caps);
-                s->manual_dirty_log_protect = 0;
-            }
-        }
-    }
-
 #ifdef KVM_CAP_VCPU_EVENTS
     s->vcpu_events = kvm_check_extension(s, KVM_CAP_VCPU_EVENTS);
 #endif
-- 
2.46.1


