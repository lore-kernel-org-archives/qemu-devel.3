Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D53ED216AF
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 14:20:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0iNq-00084Q-N7; Tue, 15 Oct 2024 10:18:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t0iNY-0007b4-O0
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 10:18:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t0iNX-0003Nc-5x
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 10:18:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729001906;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lfx6O6NRBuHysHI4JEXDMEebwOB1Dn5JwQNzit6+NTU=;
 b=DdFX1AdQZ2uIf5Zbrc0/VO/5MKMsmli2gTd/raTqdemeIiThvyt2I5eCVBVXKImsfvXZcp
 ZCB1Pvtr51kSNWpdB6YmTJEzRMOMa36ea/FZDOU8TGHg5xp89r7pKCrIaeJOPKq0/mNefW
 dCtz8JzrXopaoMt2gnyGFOSbX13Zr5E=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-694-JIAnY0TTOPKcNYjPdyue-A-1; Tue, 15 Oct 2024 10:18:24 -0400
X-MC-Unique: JIAnY0TTOPKcNYjPdyue-A-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4312b53256cso17610295e9.2
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2024 07:18:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729001902; x=1729606702;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lfx6O6NRBuHysHI4JEXDMEebwOB1Dn5JwQNzit6+NTU=;
 b=GzPq+8oRHAw+LeKkSPuH2Bog5opo/RNEsWFK2bDWRQ2d0jriMJDCb8z2Sk3Z7ZQH3H
 0WKcRI2Enr8J02HPcp/QlMDw/Qy+h1SpgdYHT3ZGU3W4wVaXo6rwrr1xPBTo1F/eil7n
 DxqutUkwkF4aJHdeOmwd7im6/lFx1lMD94AVXrkQRoDmVMEcx6DS5JMVtNPXLh1KSJno
 crQ2v08Rs2kA4xu4MfiWuvQnnrC0IIeZ7jbK5W9rxYM+Jk5zDtwLFWdDo4Anp7Dspn7+
 gxo/4UqSOOB3p4PdVT/a+A5/1PQF2sfV/xloy5gd7VM8I02JxDOS9IpX/koKmdTYosC4
 8/Rg==
X-Gm-Message-State: AOJu0YyNOpVa1yRmh74ukzTRne1BhljTxka0OUm1/7KQvNr8bQ5Xsq8Y
 qWXUjzGx7EJC0Y+QCVcOrwuIGDmAgwtYNkiDDzkwzV42mFvVh3UOIOoCMO4xUzaOGDhbZ824Ts2
 94dtYovqkZE7zK+Je0vnhgXYPETIKYt0R/oW4DWPDoJ3pcK/JgVkE7m3oQEl9bZk7jlIWn3vlOS
 KT9uS1vH9Uddtm1exra2LNQuA3pfp+BGi2dexZ8aE=
X-Received: by 2002:a05:600c:5354:b0:42c:ba1f:5475 with SMTP id
 5b1f17b1804b1-4311df4299bmr132917345e9.26.1729001902367; 
 Tue, 15 Oct 2024 07:18:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHiXZItO3MC9wsO2M6jlr+BeSr3VCWj9Xn0/bmnKXBt06JCf/8MddefYkL1gAcyodY6EVVNbw==
X-Received: by 2002:a05:600c:5354:b0:42c:ba1f:5475 with SMTP id
 5b1f17b1804b1-4311df4299bmr132917095e9.26.1729001901893; 
 Tue, 15 Oct 2024 07:18:21 -0700 (PDT)
Received: from avogadro.local ([151.95.144.54])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4313f55e054sm19688885e9.4.2024.10.15.07.18.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Oct 2024 07:18:21 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
	David Hildenbrand <david@redhat.com>
Subject: [PULL 20/25] KVM: Rename KVMState->nr_slots to nr_slots_max
Date: Tue, 15 Oct 2024 16:17:06 +0200
Message-ID: <20241015141711.528342-21-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241015141711.528342-1-pbonzini@redhat.com>
References: <20241015141711.528342-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.063,
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

From: Peter Xu <peterx@redhat.com>

This value used to reflect the maximum supported memslots from KVM kernel.
Rename it to be clearer.

Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
Link: https://lore.kernel.org/r/20240917163835.194664-5-peterx@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/sysemu/kvm_int.h |  4 ++--
 accel/kvm/kvm-all.c      | 12 ++++++------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/sysemu/kvm_int.h b/include/sysemu/kvm_int.h
index 914c5c9ec50..a1e72763da1 100644
--- a/include/sysemu/kvm_int.h
+++ b/include/sysemu/kvm_int.h
@@ -103,8 +103,8 @@ struct KVMDirtyRingReaper {
 struct KVMState
 {
     AccelState parent_obj;
-
-    int nr_slots;
+    /* Max number of KVM slots supported */
+    int nr_slots_max;
     int fd;
     int vmfd;
     int coalesced_mmio;
diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 24d76a18906..8be731cfeed 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -183,8 +183,8 @@ static bool kvm_slots_grow(KVMMemoryListener *kml, unsigned int nr_slots_new)
     unsigned int i, cur = kml->nr_slots_allocated;
     KVMSlot *slots;
 
-    if (nr_slots_new > kvm_state->nr_slots) {
-        nr_slots_new = kvm_state->nr_slots;
+    if (nr_slots_new > kvm_state->nr_slots_max) {
+        nr_slots_new = kvm_state->nr_slots_max;
     }
 
     if (cur >= nr_slots_new) {
@@ -225,7 +225,7 @@ unsigned int kvm_get_max_memslots(void)
 {
     KVMState *s = KVM_STATE(current_accel());
 
-    return s->nr_slots;
+    return s->nr_slots_max;
 }
 
 unsigned int kvm_get_free_memslots(void)
@@ -243,7 +243,7 @@ unsigned int kvm_get_free_memslots(void)
     }
     kvm_slots_unlock();
 
-    return s->nr_slots - used_slots;
+    return s->nr_slots_max - used_slots;
 }
 
 /* Called with KVMMemoryListener.slots_lock held */
@@ -2611,10 +2611,10 @@ static int kvm_init(MachineState *ms)
         (kvm_supported_memory_attributes & KVM_MEMORY_ATTRIBUTE_PRIVATE);
 
     kvm_immediate_exit = kvm_check_extension(s, KVM_CAP_IMMEDIATE_EXIT);
-    s->nr_slots = kvm_check_extension(s, KVM_CAP_NR_MEMSLOTS);
+    s->nr_slots_max = kvm_check_extension(s, KVM_CAP_NR_MEMSLOTS);
 
     /* If unspecified, use the default value */
-    if (!s->nr_slots) {
+    if (!s->nr_slots_max) {
         s->nr_slots_max = KVM_MEMSLOTS_NR_MAX_DEFAULT;
     }
 
-- 
2.46.2


