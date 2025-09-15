Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8778FCAC597
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Sep 2025 16:05:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyBgc-00070O-AM; Mon, 15 Sep 2025 12:04:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uyBgS-0006sd-OA
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 12:04:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uyBgJ-0001ao-Ad
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 12:04:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757952231;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SyeQdteY+MvcNhZF7062a/F7ERVibCEkKa7mB6cP9A8=;
 b=dtJoU0VztjHm6xv/0/SaWQgk/ZPhN3ElO0BfQi17eRQMQ8XDyjoO5g1+jS7TaQ/UkV9jzM
 aUPC6vzMeGSsBIsk0RE7I8tNIBmbPzwnzGdOmlyvi5bczLMTXfecW41AcbnfF4SVd8XUsK
 2gmAQn5b/2A+Czzyli516I7f3PW7s0I=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-212-3B2AeyHgPKOkjWYlBZgsFQ-1; Mon, 15 Sep 2025 12:03:46 -0400
X-MC-Unique: 3B2AeyHgPKOkjWYlBZgsFQ-1
X-Mimecast-MFC-AGG-ID: 3B2AeyHgPKOkjWYlBZgsFQ_1757952225
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-804512c4373so1106450385a.3
 for <qemu-devel@nongnu.org>; Mon, 15 Sep 2025 09:03:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757952225; x=1758557025;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SyeQdteY+MvcNhZF7062a/F7ERVibCEkKa7mB6cP9A8=;
 b=MzTCGR1uNrLpz1GtnO2+Urj7tuLv7g+yTRQVLWu2AHM1HLs24upU4/rmCAaSxN/JXk
 I4u/hPfXus79vV2FpFNaSNXBfFORiLCy1trW1zcqdGplpj4FsOeh/p1GJGySPglXhDVb
 Fm+zcvV+wtqNFwPIULF6swy8fSLomii1XIuOKr6J6Z7NQlz1Tx6FOGS4mijiCKJIs8WV
 GmEKu8/Wo7Y+dh31hHh9s6ZI2C3DVm1m0Hw/kTuVf8UmAcsNWKU/5CxFZH7K7tY1/sR/
 2AwSOfQtHDIckDUcZ2gxBkXOvJUuBi3CmixNlXMDM2o4kRFeVh4C6e2lPx12OOWWzG6t
 eH4A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWon+idNrPFwGzV7cyE/z/CmMYuvz4O4GrV2PbbLIuuUxX+/7cVWfRyhctxHFJthmMDF+UReqoJQrUL@nongnu.org
X-Gm-Message-State: AOJu0YxSpNv+lHjtnxrVOV977TMvNr02GQNm3xSZm3aCtJw3eX15yfQV
 0Jn4LxzZFQTJsfMD6UCHUpX1J0CbssD9NizE/aFCEs0gYfvPE3dB4DQ2Oc0yn5FOQKW5vcfcZAF
 Cw37HDZCtz+a71ASvd2Oo+sNl4LdrS7oDjAvKjBi0wCwa8VYaayk7Ine/
X-Gm-Gg: ASbGncvlp3hxLOiC0AYZD0s3escsRDTB9XjlToYZTMCx0ppdqz87eP3FwBdEBWmWEq4
 Lc+jeduNDkafOofob+J9OAAAYGuVPEMIM8ju0lkDLPC2WwIWYDnxCPke6c/GklFh6EU7ve+HiXg
 0IWOFCX5V0KCM60n6nk4YaOI0buqSM+FXwgHN5H2XFP+qFaBO2628/+idgu6h0qlrL8ntfc3b+C
 bZxfaKU966AKMNLJatqWCNZ0HqhF9Cyj9bl055dI70WPZ0n/jx8YQ7dVBJDs5e2dCunGuDurxek
 nwCZ0KJXc35ZyXqG0OJkR6XCGVSn9A==
X-Received: by 2002:a05:620a:198a:b0:82a:12b3:8bea with SMTP id
 af79cd13be357-82a12b391e9mr350055185a.37.1757952223575; 
 Mon, 15 Sep 2025 09:03:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGBE54T0zetbTL98JrDG1mSNASUHt8z30/5kHArV0xtniBpCpSANV/rNs0GKi1RckZ+x6yFlg==
X-Received: by 2002:a05:620a:198a:b0:82a:12b3:8bea with SMTP id
 af79cd13be357-82a12b391e9mr350047885a.37.1757952222792; 
 Mon, 15 Sep 2025 09:03:42 -0700 (PDT)
Received: from x1.com ([174.89.135.121]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-820ce19e020sm796565385a.52.2025.09.15.09.03.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Sep 2025 09:03:42 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Cc: peterx@redhat.com, David Hildenbrand <david@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?UTF-8?q?Cl=C3=A9ment=20Mathieu--Drif?= <clement.mathieu--drif@eviden.com>
Subject: [PULL 2/2] memory: Fix leaks due to owner-shared MRs circular
 references
Date: Mon, 15 Sep 2025 12:03:28 -0400
Message-ID: <20250915160328.2080723-3-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250915160328.2080723-1-peterx@redhat.com>
References: <20250915160328.2080723-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.035,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Clément Mathieu--Drif <clement.mathieu--drif@eviden.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Tested-by: Peter Maydell <peter.maydell@linaro.org>
Link: https://lore.kernel.org/r/20250826221750.285242-1-peterx@redhat.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 docs/devel/memory.rst |  7 +++++--
 system/memory.c       | 46 ++++++++++++++++++++++++++++++++++---------
 2 files changed, 42 insertions(+), 11 deletions(-)

diff --git a/docs/devel/memory.rst b/docs/devel/memory.rst
index 57fb2aec76..42d3ca29c4 100644
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
+and finalized one by one.  The order in which memory regions will be
+finalized is not guaranteed.
 
 If however the memory region is part of a dynamically allocated data
 structure, you should call object_unparent() to destroy the memory region
diff --git a/system/memory.c b/system/memory.c
index 44701c465c..cf8cad6961 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -1796,16 +1796,37 @@ static void memory_region_finalize(Object *obj)
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
+     * Each memory region (that can be freed) must have an owner, and it
+     * always has the same lifecycle of its owner.  It means when reaching
+     * here, the memory region's owner's refcount is zero.
+     *
+     * Here it is possible that the MR has:
+     *
+     * (1) mr->container set, which means this MR is a subregion of a
+     *     container MR. In this case they must share the same owner as the
+     *     container (otherwise the container should have kept a refcount
+     *     of this MR's owner).
+     *
+     * (2) mr->subregions non-empty, which means this MR is a container of
+     *     one or more other MRs (which might have the the owner as this
+     *     MR, or a different owner).
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
@@ -2640,7 +2661,10 @@ static void memory_region_update_container_subregions(MemoryRegion *subregion)
 
     memory_region_transaction_begin();
 
-    memory_region_ref(subregion);
+    if (mr->owner != subregion->owner) {
+        memory_region_ref(subregion);
+    }
+
     QTAILQ_FOREACH(other, &mr->subregions, subregions_link) {
         if (subregion->priority >= other->priority) {
             QTAILQ_INSERT_BEFORE(other, subregion, subregions_link);
@@ -2698,7 +2722,11 @@ void memory_region_del_subregion(MemoryRegion *mr,
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


