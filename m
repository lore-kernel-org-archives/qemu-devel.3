Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CE29CAC58D
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2024 16:40:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqbE7-00047C-Hg; Tue, 17 Sep 2024 12:38:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sqbE1-0003lV-OZ
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 12:38:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sqbE0-0008UB-45
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 12:38:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726591127;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SxzMnh3LR9kbrVwkJ0PAxEWUkiep6PxwmVi9MFzuWOA=;
 b=XLekxeaGoeXNnb1Bb7+w3EVlgdkqbylCzYbpe3K4gYtqUDK8Eo+IhI3LU+p1dd4zQvDSgx
 f12bpMM+Cc6kt5Gyrhfs6N2X795xf9JncRq/tDiIcZSHPwdjniedR7+PYR7uramaDDqiJ+
 pQjoQFr6js4KkFolLV87g7YWhu69b1k=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-671-DTBg2HQHO2WmhZ25XzctQg-1; Tue, 17 Sep 2024 12:38:46 -0400
X-MC-Unique: DTBg2HQHO2WmhZ25XzctQg-1
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-45828d941f1so94162121cf.3
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2024 09:38:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726591125; x=1727195925;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SxzMnh3LR9kbrVwkJ0PAxEWUkiep6PxwmVi9MFzuWOA=;
 b=S4aSQOJ03VAUDEOPYMJ+4cXWyfzklLu9mtbDVdiiNc3/TMWrN287KdwPNRLUPsCJoz
 hohMbyWFo77HRfhyQ4KrzBbUt8QMgkRM+kh1eRqZ3j7zgDomRjuaAxMZOCSdORE4wC/b
 H28qAmHu1RbmdLgej8giW+2GQ1IghrrS4uYFfUa6ZpeBdV3/aQqe8UjsZH59LMZPec8n
 /oWsZ6X64Qg8jC4MKmuR6oxzombxBgq7JR8Jgk/f1gjU4wUYpKnPvyZ1kwCop//DrIIO
 NgMWxtOr1SuPvd2mpfxsrduiqX+YUFlerRH9dn0mJBZlxMsFv1/ThcVNXFwcP6I+cfTe
 Yo2g==
X-Gm-Message-State: AOJu0Yxdvi5jEqTFfzW7+NJNUbh9YwHrbfVl+RDIBHYRCdkD9HpN/BZ2
 hn5oR+djdkqvc64IOhqCtIpnOvCjVWAeOum7ccJgUOM8IbAe1elmjJnPLtqCsoJBOaemM7LFkim
 ZOOKE1UTjRMmNvhij76wSDRhT/1+y/NbnxuwbeAfprwReCqU2JBtwd8de7XWEXCy2zdDUuaaYGY
 x4UXcJPqnfASJEcM7ptk87n6/0qxVnbigJhqlP
X-Received: by 2002:ac8:7e92:0:b0:458:53da:a4e9 with SMTP id
 d75a77b69052e-45b081eee24mr9435571cf.4.1726591125180; 
 Tue, 17 Sep 2024 09:38:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFDjAhygfHh81isAqOnGCSAncBV8wM9/StrqPBLPnSzDPMKQ8lr8HcuiEJLSJBzcyegFYrs6Q==
X-Received: by 2002:ac8:7e92:0:b0:458:53da:a4e9 with SMTP id
 d75a77b69052e-45b081eee24mr9435191cf.4.1726591124707; 
 Tue, 17 Sep 2024 09:38:44 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-459aad2497asm39942911cf.95.2024.09.17.09.38.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Sep 2024 09:38:43 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 peterx@redhat.com, Prasad Pandit <ppandit@redhat.com>,
 Julia Suvorova <jusual@redhat.com>, Juraj Marcin <jmarcin@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>
Subject: [PATCH v4 4/4] KVM: Rename KVMState->nr_slots to nr_slots_max
Date: Tue, 17 Sep 2024 12:38:35 -0400
Message-ID: <20240917163835.194664-5-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240917163835.194664-1-peterx@redhat.com>
References: <20240917163835.194664-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

This value used to reflect the maximum supported memslots from KVM kernel.
Rename it to be clearer.

Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/sysemu/kvm_int.h |  4 ++--
 accel/kvm/kvm-all.c      | 12 ++++++------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/sysemu/kvm_int.h b/include/sysemu/kvm_int.h
index 914c5c9ec5..a1e72763da 100644
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
index bceb154943..7fa4019544 100644
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
@@ -2513,10 +2513,10 @@ static int kvm_init(MachineState *ms)
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
2.45.0


