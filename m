Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1923CA0FF0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Aug 2025 22:20:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ur1zp-0000ZB-7J; Tue, 26 Aug 2025 18:18:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1ur1zn-0000Ys-MN
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 18:18:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1ur1zb-0008F9-Ii
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 18:18:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756246691;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=F+bjwlqEUtpkU0LwRRYAcrtQ+7O+EZnUr1dEn35sXLc=;
 b=IQ3TFSOqtIu9qZbbKqk0n2ZhQTNOchZ++ZZPJZSQ/cCpQkZdKi9ZQR1QAZ3E0e1OGrPYMa
 qXCBYDJNvd/RaqoeFKSeqc2L+QG5eNGOMKjo2gQpCtG6JlcK/dVAy0E+1B1/HRgADdwBgm
 VduADOaf8aY0HDxVSVf082gI4HlzpVg=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-568-KZG_zQdmPniEMfHgGj_6_w-1; Tue, 26 Aug 2025 18:18:05 -0400
X-MC-Unique: KZG_zQdmPniEMfHgGj_6_w-1
X-Mimecast-MFC-AGG-ID: KZG_zQdmPniEMfHgGj_6_w_1756246684
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-7e87031ae4dso764749285a.0
 for <qemu-devel@nongnu.org>; Tue, 26 Aug 2025 15:18:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756246683; x=1756851483;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=F+bjwlqEUtpkU0LwRRYAcrtQ+7O+EZnUr1dEn35sXLc=;
 b=IHUOD1LHR1h01P7REbvjI9Tvc9iNrxT50RZv9RZfr055FfjKCcOiFPdr5Jf6m/10Je
 XeeW/Y2vL1wli7uPqdvB/6YKJ7M/ARkhz84qcnv+9mkYagzWiKYE+0KIMFx4mhntX6EQ
 eSF3ELlEb1B1i5Neb1JJSTyDOtZdEpGCvvA18wOdRNURuXqyXUme6jQlb8a6lIU4B1+k
 MNQbcOk1U1JrIJgRDIRLqySA+o2lU1jids7NgwidkvOGmt7fiHC+WJkLkNR6YQVO1Shm
 SLTdk1zFxVwy7q18r70hU6xkE1C8PiN+XIXPT8M40QqV8uRp3UevmuGTbMEA8MJJlcsR
 ipHw==
X-Gm-Message-State: AOJu0Yy+8dOOq8caVtHB0vIjlfKQ4TMEJw0OTTLJ6M2u+ePdLrJL7g0Q
 2460NwiSUy2PKUVs5ST6Xt+oHIElIaHhbtURpZ2Bx0ChRQozMzHf+qShGxSjAktLvzBawdb4b43
 mIzXC+L0T2iRXwhncuHKoiMeqEE1ZGgWlNWpmapuZJgC8rFaSWSpUoOgZigj3Z5m5KOBzrUc69d
 z/tA+n9XUX8NIP5tolNcud6E3lkU02NlynOM7zJg==
X-Gm-Gg: ASbGncs8m+yEnwrBGVRmgkzgpWVkfF+wH4UndW7a303amlDsb47p3UYz3qxaHDF+qCL
 +++4bLo+BZyJZWT8tj7vNPhOtexTNjJCQoXXZEs+CeU5im3Vp2Nlp3bdjIigq3unHquNtk2n0Bs
 IP5ohzUwXETewZILyZuusTaYGTSQ9T2/o/0dPAM8Uok0GtVUYX1dibYapBA8aJ6pAdavmy/gptp
 /p7ajdetBZwPXwhwiD3WeqtukFR/4IHFDkT3FcTKHMtezghNSi0txPRpFI519KC8LuH2PHsGmtd
 +kwloBqrlXlR9sipnzjJwhM/lxcB4Q==
X-Received: by 2002:a05:620a:410b:b0:7e6:8bd4:8c70 with SMTP id
 af79cd13be357-7ea1104715cmr2101189085a.44.1756246683512; 
 Tue, 26 Aug 2025 15:18:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEbpIVQxhHBw0DEgWq95wBX5BKcL21M4ktInhJvHZWBqKcjuRbtQQEcjpjgF8eYYV4A5Ztghg==
X-Received: by 2002:a05:620a:410b:b0:7e6:8bd4:8c70 with SMTP id
 af79cd13be357-7ea1104715cmr2101184985a.44.1756246682883; 
 Tue, 26 Aug 2025 15:18:02 -0700 (PDT)
Received: from x1.com ([174.89.135.121]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7eeb4bc9c65sm602730685a.9.2025.08.26.15.18.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Aug 2025 15:18:02 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, peterx@redhat.com,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH] memory: Fix leaks due to owner-shared MRs circular references
Date: Tue, 26 Aug 2025 18:17:50 -0400
Message-ID: <20250826221750.285242-1-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Currently, QEMU refcounts the MR by always taking it from the owner.

It's common that one object will have multiple MR objects embeded in the
object itself.  All the MRs in this case share the same lifespan of the
owner object.

It's also common that in the instance_init() of an object, MR A can be a
container of MR B, C, D, by using memory_region_add_subregion*() set of
memory region APIs.

Now we have a circular reference issue, as when adding subregions for MR A,
we essentially incremented the owner's refcount within the instance_init(),
meaning the object will be self-boosted and its refcount can never go down
to zero if the MRs won't get detached properly before object's finalize().

Delete subregions within object's finalize() won't work either, because
finalize() will be invoked only if the refcount goes to zero first.  What
is worse, object_finalize() will do object_property_del_all() first before
object_deinit().  Since embeded MRs will be properties of the owner object,
it means they'll be freed _before_ the owner's finalize().

To fix that, teach memory API to stop refcount on MRs that share the same
owner.  Because if they share the lifecycle of the owner, then they share
the same lifecycle between themselves, hence the refcount doesn't help but
only introduce troubles.

Meanwhile, allow auto-detachments of MRs during finalize() of MRs even
against its container, as long as they belong to the same owner.

The latter is needed because now it's possible to have MRs' finalize()
happen in any order when they share the same lifespan with a same owner.
In this case, we should allow finalize() to happen in any order of either
the parent or child MR.  Loose the mr->container check in MR's finalize()
to allow auto-detach.  Double check it shares the same owner.

Proper document this behavior in code.

This patch is heavily based on the work done by Akihiko Odaki:

https://lore.kernel.org/r/CAFEAcA8DV40fGsci76r4yeP1P-SP_QjNRDD2OzPxjx5wRs0GEg@mail.gmail.com

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 docs/devel/memory.rst |  7 +++++--
 system/memory.c       | 45 ++++++++++++++++++++++++++++++++++---------
 2 files changed, 41 insertions(+), 11 deletions(-)

diff --git a/docs/devel/memory.rst b/docs/devel/memory.rst
index 57fb2aec76..a325e97d7b 100644
--- a/docs/devel/memory.rst
+++ b/docs/devel/memory.rst
@@ -158,8 +158,11 @@ ioeventfd) can be changed during the region lifecycle.  They take effect
 as soon as the region is made visible.  This can be immediately, later,
 or never.
 
-Destruction of a memory region happens automatically when the owner
-object dies.
+Destruction of a memory region happens automatically when the owner object
+dies.  When there are multiple memory regions under the same owner object,
+the memory API will guarantee all memory regions will be properly detached
+and finalized one by one.  The order which memory region will be finalized
+first is not guaranteed.
 
 If however the memory region is part of a dynamically allocated data
 structure, you should call object_unparent() to destroy the memory region
diff --git a/system/memory.c b/system/memory.c
index 5646547940..d7f6ad9be2 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -1796,16 +1796,36 @@ static void memory_region_finalize(Object *obj)
 {
     MemoryRegion *mr = MEMORY_REGION(obj);
 
-    assert(!mr->container);
-
-    /* We know the region is not visible in any address space (it
-     * does not have a container and cannot be a root either because
-     * it has no references, so we can blindly clear mr->enabled.
-     * memory_region_set_enabled instead could trigger a transaction
-     * and cause an infinite loop.
+    /*
+     * Each memory region (that can be dynamically freed..) must has an
+     * owner, and it always has the same lifecycle of its owner.  It means
+     * when reaching here, the memory region's owner refcount is zero.
+     *
+     * Here it is possible that the MR has:
+     *
+     * (1) mr->container set, which means this MR can be a subregion of a
+     *     container MR, in this case it must share the same owner
+     *     (otherwise the container should have kept a refcount of this
+     *     MR's owner), or,
+     *
+     * (2) mr->subregions non-empty, which means this MR can be a container
+     *     of other MRs (share the owner or not).
+     *
+     * We know the MR, or any MR that is attached to this one as either
+     * container or children, is not visible in any address space, because
+     * otherwise the address space should have taken at least one refcount
+     * of this MR's owner.  So we can blindly clear mr->enabled.
+     *
+     * memory_region_set_enabled instead could trigger a transaction and
+     * cause an infinite loop.
      */
     mr->enabled = false;
     memory_region_transaction_begin();
+    if (mr->container) {
+        /* Must share the owner; see above comments */
+        assert(mr->container->owner == mr->owner);
+        memory_region_del_subregion(mr->container, mr);
+    }
     while (!QTAILQ_EMPTY(&mr->subregions)) {
         MemoryRegion *subregion = QTAILQ_FIRST(&mr->subregions);
         memory_region_del_subregion(mr, subregion);
@@ -2625,7 +2645,10 @@ static void memory_region_update_container_subregions(MemoryRegion *subregion)
 
     memory_region_transaction_begin();
 
-    memory_region_ref(subregion);
+    if (mr->owner != subregion->owner) {
+        memory_region_ref(subregion);
+    }
+
     QTAILQ_FOREACH(other, &mr->subregions, subregions_link) {
         if (subregion->priority >= other->priority) {
             QTAILQ_INSERT_BEFORE(other, subregion, subregions_link);
@@ -2683,7 +2706,11 @@ void memory_region_del_subregion(MemoryRegion *mr,
         assert(alias->mapped_via_alias >= 0);
     }
     QTAILQ_REMOVE(&mr->subregions, subregion, subregions_link);
-    memory_region_unref(subregion);
+
+    if (mr->owner != subregion->owner) {
+        memory_region_unref(subregion);
+    }
+
     memory_region_update_pending |= mr->enabled && subregion->enabled;
     memory_region_transaction_commit();
 }
-- 
2.50.1


