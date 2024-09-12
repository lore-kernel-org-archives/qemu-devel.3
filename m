Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC663EE644D
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2024 06:19:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sodAR-0003hA-Oy; Thu, 12 Sep 2024 02:18:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1sodAQ-0003bg-Ci
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 02:18:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1sodAO-0007lw-N5
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 02:18:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726121935;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=qdljBIE1wnO1o1WeSrRcjuRU9723daTDWmWRls2lHV8=;
 b=OcY9LYFrvHI+igAE65afB9L+YpdAM1Pz4qmdSHNYRlzkYlttAOjcRQvW9FxHAkX61fTfdO
 fVFTWdW5LLTjEQ2dXdY9A9P83DY0gYmXtx8vG2ZpdiNBuqS9wygbjeiaO6m/RRQ/A5tMAf
 p7zhGmq/gvZm5r12oMeoyAjrIMPARfc=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-67-2FuRfqLfPi6ogTkoOqDXlw-1; Thu, 12 Sep 2024 02:18:53 -0400
X-MC-Unique: 2FuRfqLfPi6ogTkoOqDXlw-1
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-205516d992eso8377475ad.3
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 23:18:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726121933; x=1726726733;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qdljBIE1wnO1o1WeSrRcjuRU9723daTDWmWRls2lHV8=;
 b=Ia/daGOiIUOSO+H2vQ7IJIuzIOQVpBUGogSMxqn4FuTPF4rlna9J9/tjOYGs6a7gCE
 CD3nHnI9fbsrozSiulQQEYb3WWJSLGkwCqTxip8KZSxgc25KvyKOL9oca+x6rsuf8XJm
 oZn5TqgnaajepKVY9ys6fnjFoTef55cnYCRsZx8KQb0ZUzohi6s6FZodP0ioax5zhUuj
 veckMGPSrNRtNPNWUxtPFpY1krawRQuR1kAdHrds/SaNAePfvccpyY44QrVGpUhKNtBS
 Vn1Y4XoosMU9EeebFizy9Lss67GoGMNHetff6Yt+yGccjRxqaJkI7+tEcvnIhWM2FPNL
 b6Ew==
X-Forwarded-Encrypted: i=1;
 AJvYcCUcPW//yyuQWPIge+4rEfRnRvFuJhA+ewnNa+wgUs0fSsOSynlBc9y9dRdnW7S9Pytf7idorYdU/JRr@nongnu.org
X-Gm-Message-State: AOJu0YyufmHi0F0wiyYQ1dzJEzaVyB0xf3YtPBpHWmmCQdOgp3r9xxGb
 xX/liwQ+LtUm16wTGfeIVrEn6fUTtewm4XKafKXIO08tQ0NrBaBynddApQH6aLrzaDTC9IGr/DC
 EW3ijDSHfQhyL0VJb1rkpofC2NAVJeM0I+6l/jvZKz3OHep3zAKrM
X-Received: by 2002:a17:902:e852:b0:202:49e:6a35 with SMTP id
 d9443c01a7336-2076e33e935mr28065025ad.19.1726121932617; 
 Wed, 11 Sep 2024 23:18:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHKzhzW+CekLd+GsI4x5ghgEvoYSLHVyPmx+X/rUn7ap1rlRZgslul0eln4r/hrDoSF6i6SjA==
X-Received: by 2002:a17:902:e852:b0:202:49e:6a35 with SMTP id
 d9443c01a7336-2076e33e935mr28064685ad.19.1726121932116; 
 Wed, 11 Sep 2024 23:18:52 -0700 (PDT)
Received: from localhost.localdomain ([115.96.132.12])
 by smtp.googlemail.com with ESMTPSA id
 d9443c01a7336-2076af49af0sm8420995ad.107.2024.09.11.23.18.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Sep 2024 23:18:51 -0700 (PDT)
From: Ani Sinha <anisinha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Ani Sinha <anisinha@redhat.com>, kvm@vger.kernel.org, qemu-devel@nongnu.org
Subject: [PATCH] accel/kvm: refactor dirty ring setup
Date: Thu, 12 Sep 2024 11:48:38 +0530
Message-ID: <20240912061838.4501-1-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Refactor setting up of dirty ring code in kvm_init() so that is can be
reused in the future patchsets.

Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 accel/kvm/kvm-all.c | 88 +++++++++++++++++++++++++--------------------
 1 file changed, 50 insertions(+), 38 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 75d11a07b2..92f954ecfb 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -2385,6 +2385,55 @@ uint32_t kvm_dirty_ring_size(void)
     return kvm_state->kvm_dirty_ring_size;
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
@@ -2404,7 +2453,6 @@ static int kvm_init(MachineState *ms)
     const KVMCapabilityInfo *missing_cap;
     int ret;
     int type;
-    uint64_t dirty_log_manual_caps;
 
     qemu_mutex_init(&kml_slots_lock);
 
@@ -2551,47 +2599,11 @@ static int kvm_init(MachineState *ms)
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
2.42.0


