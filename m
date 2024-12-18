Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23116E77187
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 10:56:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNriK-0001wN-VD; Wed, 18 Dec 2024 05:55:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dhildenb@redhat.com>)
 id 1tNrhs-0000nd-JF
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 05:55:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dhildenb@redhat.com>)
 id 1tNrhm-0006qd-TN
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 05:55:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734519302;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l0gBfmC/71g11Jbf0onG2UBI9DIVGHNXDaOgDh8tn80=;
 b=SRDCKNRxnpxpNtOty7+2TVtfN6CHw9r6Nd90jBjz8UGxixgqFBiTi5yb587P7oSRQRDW9o
 E2tJe8TLNYow5NUJfEv4H45tULRUmj24+I15kY974JnVkf0xqN6PWp62S1MH10hKBJPp7i
 fxMjVy2dOMvTGPnuExJPBX7D+JWIxoA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-372-r6R2KEj3NseZ9Nq1gVkwhw-1; Wed, 18 Dec 2024 05:53:30 -0500
X-MC-Unique: r6R2KEj3NseZ9Nq1gVkwhw-1
X-Mimecast-MFC-AGG-ID: r6R2KEj3NseZ9Nq1gVkwhw
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43635895374so3142675e9.0
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 02:53:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734519209; x=1735124009;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=l0gBfmC/71g11Jbf0onG2UBI9DIVGHNXDaOgDh8tn80=;
 b=lOfO+TRYM94JIUt6lmbEz86ULsMqsTD7Vm7J4eXwEv2L5XRP02wbjXnzsiB1vym/4D
 BmoT02tOMIKjPASBAE65hMGwApXxxte4KrOe8rlOoTiBh32PlzvknP9WH8vZLM56KIbY
 qcaSYKphUqKtliAl+UGv+ORTKX73S0ykQLWc7Lynxk5JrLBIt6KoisSa6eosafGYeClU
 ZOBVb84WBYgIJfiwVhD0jooywiUev16uYnr/jMkkyE64Os8vA/AUdJu667uKlNjYcS8m
 b7ByqWVoUbDirZ64+Dn5J8LzsbOnpGV61aLfWUpYLX+8P7KbzO0BxfsBQlC4iTlhwoc+
 OMKA==
X-Gm-Message-State: AOJu0Yw0Eqh1EwbZ57uuRVljpHkMzdoxWN/C4o+yCKXrhFsomNVeMFLn
 ylOGOjJlaxxjecUaCgXPHO+vs51dOptcNEkExtqTySQBI+m/FZWMouBlFwAYEmws23aXDYGmmsq
 jieIKkRC2O2ktvP/ATAOKePuClNpu1MbLZiweYWcFSG6lE4h+AfujaMNeyJHgKc5EZ5ZNMYpgex
 dd9m/FM3xOoFAp7TIpkyIls751bq1BDODaPyo=
X-Gm-Gg: ASbGncsGgULKwcEJ442B2B5Q833BT9/5kMU0ZrWdhDdH9annxVH2aVQ93rmmgK+F15Z
 +8/6sohafZrK8CJiPQ42564epuWfHYa24zeyM+wmSUZOrWHiMrPAt2HiMTD8semqXbBpunzO4+H
 8tHamLxDgq2mVy4Z78NlLF5EDLoUlUkgYqCUYHCdX6T5KhxChfhncoVYGRQ7UaF8nDfXLkRDU/C
 OCX7pdJB544KPenCIrbOfq5mNioujkwhX5VxSdfqaGU+/sLPj4TltDwbaD3Rv1wX/IeH6m1o2xj
 EjgR8Cm3Bhv7Fvbl/plAq5MxdteIzBZjtF+8Wghg7w==
X-Received: by 2002:a05:600c:1d19:b0:434:fb8b:deee with SMTP id
 5b1f17b1804b1-436553f2d16mr18279715e9.16.1734519209030; 
 Wed, 18 Dec 2024 02:53:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEY1h8hO0hLiRa2NcpJKgUPQl3PlEPEYdtJ50FtCnI6VQUOcNTr4E99dVOKspMmAk02wEBBnQ==
X-Received: by 2002:a05:600c:1d19:b0:434:fb8b:deee with SMTP id
 5b1f17b1804b1-436553f2d16mr18279505e9.16.1734519208578; 
 Wed, 18 Dec 2024 02:53:28 -0800 (PST)
Received: from localhost
 (p200300cbc73f8300a5d5c21badd3cf50.dip0.t-ipconnect.de.
 [2003:cb:c73f:8300:a5d5:c21b:add3:cf50])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-4364b053e91sm50545215e9.1.2024.12.18.02.53.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Dec 2024 02:53:27 -0800 (PST)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Cc: Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 David Hildenbrand <david@redhat.com>
Subject: [PULL 09/15] s390x/s390-stattrib-kvm: prepare for memory devices and
 sparse memory layouts
Date: Wed, 18 Dec 2024 11:52:57 +0100
Message-ID: <20241218105303.1966303-10-david@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241218105303.1966303-1-david@redhat.com>
References: <20241218105303.1966303-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=dhildenb@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.116,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

With memory devices, we will have storage attributes for memory that
exceeds the initial ram size. Further, we can easily have memory holes,
for which there (currently) are no storage attributes.

In particular, with memory holes, KVM_S390_SET_CMMA_BITS will fail to set
some storage attributes.

So let's do it like we handle storage keys migration, relying on
guest_phys_blocks_append(). However, in contrast to storage key
migration, we will handle it on the migration destination.

This is a preparation for virtio-mem support. Note that ever since the
"early migration" feature was added (x-early-migration), the state
of device blocks (plugged/unplugged) is migrated early such that
guest_phys_blocks_append() will properly consider all currently plugged
memory blocks and skip any unplugged ones.

In the future, we should try getting rid of the large temporary buffer
and also not send any attributes for any memory holes, just so they
get ignored on the destination.

Message-ID: <20241008105455.2302628-9-david@redhat.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/s390x/s390-stattrib-kvm.c | 67 +++++++++++++++++++++++-------------
 1 file changed, 43 insertions(+), 24 deletions(-)

diff --git a/hw/s390x/s390-stattrib-kvm.c b/hw/s390x/s390-stattrib-kvm.c
index eeaa811098..33ec91422a 100644
--- a/hw/s390x/s390-stattrib-kvm.c
+++ b/hw/s390x/s390-stattrib-kvm.c
@@ -10,11 +10,12 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/boards.h"
+#include "hw/s390x/s390-virtio-ccw.h"
 #include "migration/qemu-file.h"
 #include "hw/s390x/storage-attributes.h"
 #include "qemu/error-report.h"
 #include "sysemu/kvm.h"
+#include "sysemu/memory_mapping.h"
 #include "exec/ram_addr.h"
 #include "kvm/kvm_s390x.h"
 #include "qapi/error.h"
@@ -84,8 +85,8 @@ static int kvm_s390_stattrib_set_stattr(S390StAttribState *sa,
                                         uint8_t *values)
 {
     KVMS390StAttribState *sas = KVM_S390_STATTRIB(sa);
-    MachineState *machine = MACHINE(qdev_get_machine());
-    unsigned long max = machine->ram_size / TARGET_PAGE_SIZE;
+    S390CcwMachineState *s390ms = S390_CCW_MACHINE(qdev_get_machine());
+    unsigned long max = s390_get_memory_limit(s390ms) / TARGET_PAGE_SIZE;
 
     if (start_gfn + count > max) {
         error_report("Out of memory bounds when setting storage attributes");
@@ -103,39 +104,57 @@ static int kvm_s390_stattrib_set_stattr(S390StAttribState *sa,
 static void kvm_s390_stattrib_synchronize(S390StAttribState *sa)
 {
     KVMS390StAttribState *sas = KVM_S390_STATTRIB(sa);
-    MachineState *machine = MACHINE(qdev_get_machine());
-    unsigned long max = machine->ram_size / TARGET_PAGE_SIZE;
-    /* We do not need to reach the maximum buffer size allowed */
-    unsigned long cx, len = KVM_S390_SKEYS_MAX / 2;
+    S390CcwMachineState *s390ms = S390_CCW_MACHINE(qdev_get_machine());
+    unsigned long max = s390_get_memory_limit(s390ms) / TARGET_PAGE_SIZE;
+    unsigned long start_gfn, end_gfn, pages;
+    GuestPhysBlockList guest_phys_blocks;
+    GuestPhysBlock *block;
     int r;
     struct kvm_s390_cmma_log clog = {
         .flags = 0,
         .mask = ~0ULL,
     };
 
-    if (sas->incoming_buffer) {
-        for (cx = 0; cx + len <= max; cx += len) {
-            clog.start_gfn = cx;
-            clog.count = len;
-            clog.values = (uint64_t)(sas->incoming_buffer + cx);
-            r = kvm_vm_ioctl(kvm_state, KVM_S390_SET_CMMA_BITS, &clog);
-            if (r) {
-                error_report("KVM_S390_SET_CMMA_BITS failed: %s", strerror(-r));
-                return;
-            }
-        }
-        if (cx < max) {
-            clog.start_gfn = cx;
-            clog.count = max - cx;
-            clog.values = (uint64_t)(sas->incoming_buffer + cx);
+    if (!sas->incoming_buffer) {
+        return;
+    }
+    guest_phys_blocks_init(&guest_phys_blocks);
+    guest_phys_blocks_append(&guest_phys_blocks);
+
+    QTAILQ_FOREACH(block, &guest_phys_blocks.head, next) {
+        assert(QEMU_IS_ALIGNED(block->target_start, TARGET_PAGE_SIZE));
+        assert(QEMU_IS_ALIGNED(block->target_end, TARGET_PAGE_SIZE));
+
+        start_gfn = block->target_start / TARGET_PAGE_SIZE;
+        end_gfn = block->target_end / TARGET_PAGE_SIZE;
+
+        while (start_gfn < end_gfn) {
+            /* Don't exceed the maximum buffer size. */
+            pages = MIN(end_gfn - start_gfn, KVM_S390_SKEYS_MAX / 2);
+
+            /*
+             * If we ever get guest physical memory beyond the configured
+             * memory limit, something went very wrong.
+             */
+            assert(start_gfn + pages <= max);
+
+            clog.start_gfn = start_gfn;
+            clog.count = pages;
+            clog.values = (uint64_t)(sas->incoming_buffer + start_gfn);
             r = kvm_vm_ioctl(kvm_state, KVM_S390_SET_CMMA_BITS, &clog);
             if (r) {
                 error_report("KVM_S390_SET_CMMA_BITS failed: %s", strerror(-r));
+                goto out;
             }
+
+            start_gfn += pages;
         }
-        g_free(sas->incoming_buffer);
-        sas->incoming_buffer = NULL;
     }
+
+out:
+    guest_phys_blocks_free(&guest_phys_blocks);
+    g_free(sas->incoming_buffer);
+    sas->incoming_buffer = NULL;
 }
 
 static int kvm_s390_stattrib_set_migrationmode(S390StAttribState *sa, bool val,
-- 
2.47.1


