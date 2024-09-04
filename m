Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C3ABCD4F45
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2024 22:36:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slyay-0003x2-37; Wed, 04 Sep 2024 18:35:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1slyaw-0003qY-Ij
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 18:35:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1slyau-00019k-Tm
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 18:35:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725489320;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bDftqUi+TODvxn/v8AdpNLGIJkWpOz4ULtJCbY+H3Mc=;
 b=iJGNVHV1PJY9pK/MZS/xZOqcmi4rM+bSqU7ALItDu1pX0EX3kKyWdjPkdjn1/IBwlzImQc
 Yc+AhorbYtPwFP2annGqemZuvhDpc1RnzyrxbzcMlqeAAbebnEIoIVkiGQi4DJhnhF1kzS
 MotHRG+KCbzmUG7o1o0rTXCB7AWbzf4=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-311-kpNfUwJYOr2EpIrgic_Dng-1; Wed, 04 Sep 2024 18:35:19 -0400
X-MC-Unique: kpNfUwJYOr2EpIrgic_Dng-1
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-457c70a2da0so1271001cf.2
 for <qemu-devel@nongnu.org>; Wed, 04 Sep 2024 15:35:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725489318; x=1726094118;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bDftqUi+TODvxn/v8AdpNLGIJkWpOz4ULtJCbY+H3Mc=;
 b=wjd1T/U1siRq67B8BgwfzHnc4rM4ZdB5TQIcVINKdns44nfzDXOtHSeP9jPpJ2IEeB
 Ow9A61wXVpMDZHh9ohhrdG8YUSF3lADyc+NhOZ+cenJ8Lim8vo+RKK/knvnTJmTxKuvy
 FQVT4TKqdg6w5PontxBvXEqUCW3e9ca98BNVm1DNCInqyM5IJ0zLR1NQbEGZY2IpoScc
 J4+mfMB5uEm7jVbeXmdU3jLvDSfJaljflDcmvcHf2/fyxS9GILvuptzN1OfCJOArvpUq
 wZ/klyqQ5dMx1YOhA2h2C272P5lBIwU5BPrlEZNg+BhB39UQxogigmBx/vNdGecBoCvt
 nJnQ==
X-Gm-Message-State: AOJu0YyGbIaseH6IFPT6OTe6o43l2HKcTCcUGo5sFcoZumjybTn8aMlW
 LCgLxrmc1rZTMZ5LTabAB0meWs+TpXk2WziPscwyIU66C3y2koLz9H55WXTR5C+CRgbWMrM5LIq
 sdkZOJ/8LD7axMnRue2Qy8o6quUwWRVzYfXUteCLAkT/gGpQuj4xabaxMk7E1WpE3clf0Dd57m3
 4wFtYmhx7kMF+5OtqDwq4cgorJPc7lCBcjXiBm
X-Received: by 2002:a05:622a:993:b0:456:8ee8:f5f3 with SMTP id
 d75a77b69052e-456fd7d8632mr186080831cf.33.1725489317808; 
 Wed, 04 Sep 2024 15:35:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFnanzZ3lnpXZrxYOqOHeANrVZMrQvjX/09uT0b3vzCXL42rtL5rdMjlBhd2PyGuZIOcyBJlA==
X-Received: by 2002:a05:622a:993:b0:456:8ee8:f5f3 with SMTP id
 d75a77b69052e-456fd7d8632mr186080391cf.33.1725489317230; 
 Wed, 04 Sep 2024 15:35:17 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-45801b35df7sm2428881cf.33.2024.09.04.15.35.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Sep 2024 15:35:16 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>, Prasad Pandit <ppandit@redhat.com>,
 Julia Suvorova <jusual@redhat.com>, peterx@redhat.com,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Juraj Marcin <jmarcin@redhat.com>, David Hildenbrand <david@redhat.com>
Subject: [PATCH v2 3/4] KVM: Rename KVMMemoryListener.nr_used_slots to
 nr_slots_used
Date: Wed,  4 Sep 2024 18:35:09 -0400
Message-ID: <20240904223510.3519358-4-peterx@redhat.com>
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

This will make all nr_slots counters to be named in the same manner.

Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/sysemu/kvm_int.h | 2 +-
 accel/kvm/kvm-all.c      | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/sysemu/kvm_int.h b/include/sysemu/kvm_int.h
index 48e496b3d4..b705dfc9b4 100644
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
index bc1b039190..b7fb73ae18 100644
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
 
@@ -1510,7 +1510,7 @@ static void kvm_set_phys_mem(KVMMemoryListener *kml,
             }
             start_addr += slot_size;
             size -= slot_size;
-            kml->nr_used_slots--;
+            kml->nr_slots_used--;
         } while (size);
         return;
     }
@@ -1549,7 +1549,7 @@ static void kvm_set_phys_mem(KVMMemoryListener *kml,
         ram_start_offset += slot_size;
         ram += slot_size;
         size -= slot_size;
-        kml->nr_used_slots++;
+        kml->nr_slots_used++;
     } while (size);
 }
 
-- 
2.45.0


