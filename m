Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0F85CD4F25
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2024 19:17:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slvUt-0005TH-5b; Wed, 04 Sep 2024 15:16:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1slvUo-0005Jb-7W
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 15:16:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1slvUj-0006Fn-49
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 15:16:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725477403;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AZo3zun2gYF/lIZMcDte2iwtChauWw2bWOpZKcGZkjI=;
 b=Tfps2dLf4D+f5ZuUtVqMKHXgG3A0mtXiQQHt0DI+xEpqf4jB6EkunP4uwp/3Dr9f6htgEW
 zKHTiI76dZUomFE4kdKCfp3qaPtMEvkJ/gPyKuFkptc+RGVs7aPCJWkv/9l02JqKCU25Ac
 oBimVJviXTOzUPn9un/gIoJhyYi2BQY=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-116-XXZkA7o1NiWS_BiZO-MU9g-1; Wed, 04 Sep 2024 15:16:40 -0400
X-MC-Unique: XXZkA7o1NiWS_BiZO-MU9g-1
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-7a977382875so385886185a.1
 for <qemu-devel@nongnu.org>; Wed, 04 Sep 2024 12:16:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725477399; x=1726082199;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AZo3zun2gYF/lIZMcDte2iwtChauWw2bWOpZKcGZkjI=;
 b=s+W4p0dbyMikznQ/gk5FGmc8Fsg2NgVZzlSTTIrnrT/4nkBPfSQab9c2e8C4q9flCr
 nYhs6bOvfd4JMrOF9fMVvXdsa0tvWr7tZAN1V9V+seo6SX2pTfqiQhBg9DWqbWZI4zbV
 XH8WbF2SbVawcq5bJgvFpndHZNHotBuQmB9Hcgc60+2hR14Lu06ERxEVoiNMaKjDhBqX
 p5Ao4fNCF7NCqemwN3GwMA920C7uI8dUzmpXQdLnD9dsqfGuqoN0LaER3IkTp98wVHwS
 QI6I606IOI1OU9FTNEfvR3wUtuMn+sHWeeCArxQzkNdStWjsGsks4py00+m9sSm1RkFp
 ZdFQ==
X-Gm-Message-State: AOJu0YwLb2n5zCIIHEXvdd2uKQY4wkehXpknJ4GbE8Ci5fxz0ioBkhpT
 QSkFs3MCZzkXBBqlb/mfUiOrCISjHkAyvm1hW7q+fTIzOhy9LBKlpxTMBkNoCRT1CiBu/F7SMHo
 9j0ef/LUu1Y+q/eXtz/6MB45ACvaaYmbw2GBNvDHZcbAPOsCXiil1CItKwkwyrqAaaX4EUgMu9k
 3rkkpeGHF+/zftapBDK+yGAc/eq6ksexBqNgQQ
X-Received: by 2002:a05:620a:244f:b0:7a7:df7b:26e6 with SMTP id
 af79cd13be357-7a8ac3ba7afmr2035577085a.54.1725477399632; 
 Wed, 04 Sep 2024 12:16:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEIk1uTW+aj7Ds8CwIHnxiklepBqG/asYs4sm4iHGZbHfPCucUq5Fi2GMfjRW6SNyHnCRBrEg==
X-Received: by 2002:a05:620a:244f:b0:7a7:df7b:26e6 with SMTP id
 af79cd13be357-7a8ac3ba7afmr2035572285a.54.1725477399115; 
 Wed, 04 Sep 2024 12:16:39 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7a98ef250d2sm10260285a.15.2024.09.04.12.16.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Sep 2024 12:16:38 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Juraj Marcin <jmarcin@redhat.com>, peterx@redhat.com,
 Prasad Pandit <ppandit@redhat.com>, Julia Suvorova <jusual@redhat.com>,
 David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: [PATCH 1/4] KVM: Rename KVMState->nr_slots to nr_slots_max
Date: Wed,  4 Sep 2024 15:16:32 -0400
Message-ID: <20240904191635.3045606-2-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240904191635.3045606-1-peterx@redhat.com>
References: <20240904191635.3045606-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Rename it to be clearer, preparing for dynamic sized memslot allocations.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/sysemu/kvm_int.h |  4 ++--
 accel/kvm/kvm-all.c      | 26 +++++++++++++-------------
 2 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/include/sysemu/kvm_int.h b/include/sysemu/kvm_int.h
index 1d8fb1473b..e5de43619e 100644
--- a/include/sysemu/kvm_int.h
+++ b/include/sysemu/kvm_int.h
@@ -102,8 +102,8 @@ struct KVMDirtyRingReaper {
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
index 75d11a07b2..991c389adc 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -169,7 +169,7 @@ unsigned int kvm_get_max_memslots(void)
 {
     KVMState *s = KVM_STATE(current_accel());
 
-    return s->nr_slots;
+    return s->nr_slots_max;
 }
 
 unsigned int kvm_get_free_memslots(void)
@@ -187,7 +187,7 @@ unsigned int kvm_get_free_memslots(void)
     }
     kvm_slots_unlock();
 
-    return s->nr_slots - used_slots;
+    return s->nr_slots_max - used_slots;
 }
 
 /* Called with KVMMemoryListener.slots_lock held */
@@ -196,7 +196,7 @@ static KVMSlot *kvm_get_free_slot(KVMMemoryListener *kml)
     KVMState *s = kvm_state;
     int i;
 
-    for (i = 0; i < s->nr_slots; i++) {
+    for (i = 0; i < s->nr_slots_max; i++) {
         if (kml->slots[i].memory_size == 0) {
             return &kml->slots[i];
         }
@@ -225,7 +225,7 @@ static KVMSlot *kvm_lookup_matching_slot(KVMMemoryListener *kml,
     KVMState *s = kvm_state;
     int i;
 
-    for (i = 0; i < s->nr_slots; i++) {
+    for (i = 0; i < s->nr_slots_max; i++) {
         KVMSlot *mem = &kml->slots[i];
 
         if (start_addr == mem->start_addr && size == mem->memory_size) {
@@ -267,7 +267,7 @@ int kvm_physical_memory_addr_from_host(KVMState *s, void *ram,
     int i, ret = 0;
 
     kvm_slots_lock();
-    for (i = 0; i < s->nr_slots; i++) {
+    for (i = 0; i < s->nr_slots_max; i++) {
         KVMSlot *mem = &kml->slots[i];
 
         if (ram >= mem->ram && ram < mem->ram + mem->memory_size) {
@@ -1071,7 +1071,7 @@ static int kvm_physical_log_clear(KVMMemoryListener *kml,
 
     kvm_slots_lock();
 
-    for (i = 0; i < s->nr_slots; i++) {
+    for (i = 0; i < s->nr_slots_max; i++) {
         mem = &kml->slots[i];
         /* Discard slots that are empty or do not overlap the section */
         if (!mem->memory_size ||
@@ -1720,11 +1720,11 @@ static void kvm_log_sync_global(MemoryListener *l, bool last_stage)
     kvm_dirty_ring_flush();
 
     /*
-     * TODO: make this faster when nr_slots is big while there are
+     * TODO: make this faster when nr_slots_max is big while there are
      * only a few used slots (small VMs).
      */
     kvm_slots_lock();
-    for (i = 0; i < s->nr_slots; i++) {
+    for (i = 0; i < s->nr_slots_max; i++) {
         mem = &kml->slots[i];
         if (mem->memory_size && mem->flags & KVM_MEM_LOG_DIRTY_PAGES) {
             kvm_slot_sync_dirty_pages(mem);
@@ -1839,10 +1839,10 @@ void kvm_memory_listener_register(KVMState *s, KVMMemoryListener *kml,
 {
     int i;
 
-    kml->slots = g_new0(KVMSlot, s->nr_slots);
+    kml->slots = g_new0(KVMSlot, s->nr_slots_max);
     kml->as_id = as_id;
 
-    for (i = 0; i < s->nr_slots; i++) {
+    for (i = 0; i < s->nr_slots_max; i++) {
         kml->slots[i].slot = i;
     }
 
@@ -2454,11 +2454,11 @@ static int kvm_init(MachineState *ms)
         (kvm_supported_memory_attributes & KVM_MEMORY_ATTRIBUTE_PRIVATE);
 
     kvm_immediate_exit = kvm_check_extension(s, KVM_CAP_IMMEDIATE_EXIT);
-    s->nr_slots = kvm_check_extension(s, KVM_CAP_NR_MEMSLOTS);
+    s->nr_slots_max = kvm_check_extension(s, KVM_CAP_NR_MEMSLOTS);
 
     /* If unspecified, use the default value */
-    if (!s->nr_slots) {
-        s->nr_slots = 32;
+    if (!s->nr_slots_max) {
+        s->nr_slots_max = 32;
     }
 
     s->nr_as = kvm_check_extension(s, KVM_CAP_MULTI_ADDRESS_SPACE);
-- 
2.45.0


