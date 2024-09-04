Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5CCDCD4F3C
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2024 22:36:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slyb0-00045h-47; Wed, 04 Sep 2024 18:35:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1slyax-0003va-Ob
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 18:35:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1slyaw-0001A8-7t
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 18:35:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725489321;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EkbxL0DLwlIg9hHpDaAUsSOs36b2eDu6NFzXSaDhuLM=;
 b=go2YM2DYC6uDF90o41SbVZdvjv4OSbE07UHquDkVm1N2WOhNFBLyu6RcMUXHq5f1zxj3ad
 tjJ1MI3FCiY5JkQxKO1AXqc31+MUJWETSARvKmQLqA1hD3bcNfefP1BiI7389GUdXmiPvk
 qHNgt6x6fO+8MqbUCfJC1SR+bhrmZZI=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-PpirzaWNORa7rlFsz63AAg-1; Wed, 04 Sep 2024 18:35:20 -0400
X-MC-Unique: PpirzaWNORa7rlFsz63AAg-1
Received: by mail-oi1-f200.google.com with SMTP id
 5614622812f47-3df033c1e08so75842b6e.2
 for <qemu-devel@nongnu.org>; Wed, 04 Sep 2024 15:35:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725489319; x=1726094119;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EkbxL0DLwlIg9hHpDaAUsSOs36b2eDu6NFzXSaDhuLM=;
 b=MvgschJMkTsn+gSsjsSkRnOzFurVD2RrU33/X0fVkezJdUXfHPZ4Ow1mgYotq0rD/a
 dlSjwiAlZL3FBCwPI2U/aDsyWkRh66sCQDsDFY1F+h+cGhX/G+uupidFzmFvxFytx6lR
 3LRsP3867/7FZYeZG3DvNbFNJDHA7EeCww+p5UEJwOI75Yv58RMt8AeIwU3rJn8UWnhA
 yRTQQcjPcoOrDWIaa+bOjy7jFzKlQct8mh4gHeFloRGr7SELM0GNUx4bh/wOtfasx9bF
 LBavyNaX0atRhAksUir+z7RqLOIJTi01H7lRA8w0pytwbpuBrVbPzELhs0al37iurxd5
 5ooA==
X-Gm-Message-State: AOJu0Yz572WFMj3Eo/7dZJbN94z+CoHN54wn1tIN9djg78SBfCYdBXdc
 3j8nEDeqJXnauCUDfD8r28zRCpeMB8UW9/TqL3Ldo9qjlbUuGJ2Ba+u0xxFs8Itxi9h9BrTnL85
 ztn7IezjTuzOmGbD2uVQQ+2DhQkKsx3EBP1RVIxXDe/9r43A+WrUdHMcdKOOsfJ+suLjsyF1+wK
 B4uyGJLb0VBInGxvw3A3VthS3l7p7vn4O1Lz5U
X-Received: by 2002:a05:6808:1a0e:b0:3df:1625:d993 with SMTP id
 5614622812f47-3df1ca27bf5mr18219464b6e.34.1725489319433; 
 Wed, 04 Sep 2024 15:35:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGsIqhbfHNOPbcqocHfuPo8FFcU7ygheSRmWWbrNer0Jfo/Fy4cUuihzIBzE/fIYQlY7MK25g==
X-Received: by 2002:a05:6808:1a0e:b0:3df:1625:d993 with SMTP id
 5614622812f47-3df1ca27bf5mr18219442b6e.34.1725489319087; 
 Wed, 04 Sep 2024 15:35:19 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-45801b35df7sm2428881cf.33.2024.09.04.15.35.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Sep 2024 15:35:18 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>, Prasad Pandit <ppandit@redhat.com>,
 Julia Suvorova <jusual@redhat.com>, peterx@redhat.com,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Juraj Marcin <jmarcin@redhat.com>, David Hildenbrand <david@redhat.com>
Subject: [PATCH v2 4/4] KVM: Rename KVMState->nr_slots to nr_slots_max
Date: Wed,  4 Sep 2024 18:35:10 -0400
Message-ID: <20240904223510.3519358-5-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240904223510.3519358-1-peterx@redhat.com>
References: <20240904223510.3519358-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

This value used to reflect the maximum supported memslots from KVM kernel.
Rename it to be clearer.

Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/sysemu/kvm_int.h |  4 ++--
 accel/kvm/kvm-all.c      | 16 ++++++++--------
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/include/sysemu/kvm_int.h b/include/sysemu/kvm_int.h
index b705dfc9b4..2c57194b6b 100644
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
index b7fb73ae18..020fd16ab8 100644
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
@@ -2507,10 +2507,10 @@ static int kvm_init(MachineState *ms)
         (kvm_supported_memory_attributes & KVM_MEMORY_ATTRIBUTE_PRIVATE);
 
     kvm_immediate_exit = kvm_check_extension(s, KVM_CAP_IMMEDIATE_EXIT);
-    s->nr_slots = kvm_check_extension(s, KVM_CAP_NR_MEMSLOTS);
+    s->nr_slots_max = kvm_check_extension(s, KVM_CAP_NR_MEMSLOTS);
 
     /* If unspecified, use the default value */
-    if (!s->nr_slots) {
+    if (!s->nr_slots_max) {
         s->nr_slots_max = KVM_MEMSLOTS_NR_MAX_DEFAULT;
     }
 
@@ -2519,10 +2519,10 @@ static int kvm_init(MachineState *ms)
      * fail to boot.  Make sure the supported value is always at least
      * larger than what we will initially allocate.
      */
-    if (s->nr_slots < KVM_MEMSLOTS_NR_ALLOC_DEFAULT) {
+    if (s->nr_slots_max < KVM_MEMSLOTS_NR_ALLOC_DEFAULT) {
         ret = -EINVAL;
         fprintf(stderr, "KVM max supported number of slots (%d) too small\n",
-                s->nr_slots);
+                s->nr_slots_max);
         goto err;
     }
 
-- 
2.45.0


