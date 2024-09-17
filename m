Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89BEFCAC58D
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2024 16:39:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqbE6-0003zI-LP; Tue, 17 Sep 2024 12:38:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sqbE0-0003id-Fg
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 12:38:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sqbDy-0008To-Nx
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 12:38:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726591126;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZyaI/UCHK61GYnEHGZaEepibYRivTV0MRwcjjCl1LVM=;
 b=P1n1HzBGK1Hx8ALV/XJIFuwKlc5FYJ/FnqWbT3osyv2JuTNl485ixwjjH7hmlM687q6yve
 dqWFrMNVzg7xYFYq3eB5S8pQDAhzP/3rCNevm3vO/SFFTw8J/Y/AIL7oKAVUcj1dx2jtun
 sQoFP4u14sHBQe68PFmNrTZzh2XQyqU=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-581-31jIsb4VPWWYpH2s2EKYgA-1; Tue, 17 Sep 2024 12:38:45 -0400
X-MC-Unique: 31jIsb4VPWWYpH2s2EKYgA-1
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-4586e0c6597so90115181cf.2
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2024 09:38:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726591123; x=1727195923;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZyaI/UCHK61GYnEHGZaEepibYRivTV0MRwcjjCl1LVM=;
 b=oQdS4ine8zhUFK5gGyV/WY687AXAfCiv3lEUw2ALBVEzwXkptR7laaCdVM1VykAfIx
 Bz4JJhhwpnJLZsEugr9L+6PKBkJ1HhKxMoyWUlon+vUf9U4ipN1icrSBGT56qEKAtgMA
 HjsCdPWQAiqB5bT1dXSpX5wGr1SmMP9soWwSKZ8xG3V5Hpg+KrRYWSIAq9giNOLvarKU
 o6Uus8amdCRd1SnWFoZ+6pbm6hk7UUIdP/lEr0WXqjs5ojTGqev7z+hLWiP/x1kPqMfA
 xDHxmincYVMXegcqT8+y44cr1v2gKIBQ/W4L14PAtQc8HcRIrmyigKHSis2Lad+PU0gH
 KGug==
X-Gm-Message-State: AOJu0YyDQKueepjJhsgjXuWM6yq0fP8kKm7CWgHxtRH2cNuDcToNK8FK
 LZq7PKQXgNtdp3dmCFDVfTHydwIQ6cINb1ufzej9lUJoegtq2VV2d81nZ+L9vpIo/N3wWsFOMxH
 fojfwLbr8j9RXt8xF/LPA+gkBdMXgYSYu7nvDIij65BsVggRxEN4x7iQHxDQOP8yM0hU8b2nSTX
 OuK2RzOu+qvkEfbhbOe2+a0XiJhddr5SgW6fKi
X-Received: by 2002:a05:622a:5d3:b0:451:a12d:b9d1 with SMTP id
 d75a77b69052e-458602a7663mr333879171cf.10.1726591123218; 
 Tue, 17 Sep 2024 09:38:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEOLri8g3HajwEL1z5d5V9xdqzSxTVr2uPDNOLqez36tIKXmhMQudxcO4H7ZM5SJg7TBopG/g==
X-Received: by 2002:a05:622a:5d3:b0:451:a12d:b9d1 with SMTP id
 d75a77b69052e-458602a7663mr333878701cf.10.1726591122732; 
 Tue, 17 Sep 2024 09:38:42 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-459aad2497asm39942911cf.95.2024.09.17.09.38.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Sep 2024 09:38:42 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 peterx@redhat.com, Prasad Pandit <ppandit@redhat.com>,
 Julia Suvorova <jusual@redhat.com>, Juraj Marcin <jmarcin@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>
Subject: [PATCH v4 3/4] KVM: Rename KVMMemoryListener.nr_used_slots to
 nr_slots_used
Date: Tue, 17 Sep 2024 12:38:34 -0400
Message-ID: <20240917163835.194664-4-peterx@redhat.com>
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

This will make all nr_slots counters to be named in the same manner.

Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/sysemu/kvm_int.h | 2 +-
 accel/kvm/kvm-all.c      | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/sysemu/kvm_int.h b/include/sysemu/kvm_int.h
index 2304537b93..914c5c9ec5 100644
--- a/include/sysemu/kvm_int.h
+++ b/include/sysemu/kvm_int.h
@@ -45,7 +45,7 @@ typedef struct KVMMemoryUpdate {
 typedef struct KVMMemoryListener {
     MemoryListener listener;
     KVMSlot *slots;
-    unsigned int nr_used_slots;
+    unsigned int nr_slots_used;
     unsigned int nr_slots_allocated;
     int as_id;
     QSIMPLEQ_HEAD(, KVMMemoryUpdate) transaction_add;
diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 0b66c8b27f..bceb154943 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -239,7 +239,7 @@ unsigned int kvm_get_free_memslots(void)
         if (!s->as[i].ml) {
             continue;
         }
-        used_slots = MAX(used_slots, s->as[i].ml->nr_used_slots);
+        used_slots = MAX(used_slots, s->as[i].ml->nr_slots_used);
     }
     kvm_slots_unlock();
 
@@ -1516,7 +1516,7 @@ static void kvm_set_phys_mem(KVMMemoryListener *kml,
             }
             start_addr += slot_size;
             size -= slot_size;
-            kml->nr_used_slots--;
+            kml->nr_slots_used--;
         } while (size);
         return;
     }
@@ -1555,7 +1555,7 @@ static void kvm_set_phys_mem(KVMMemoryListener *kml,
         ram_start_offset += slot_size;
         ram += slot_size;
         size -= slot_size;
-        kml->nr_used_slots++;
+        kml->nr_slots_used++;
     } while (size);
 }
 
-- 
2.45.0


