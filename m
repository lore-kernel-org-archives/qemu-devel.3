Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80CADCA0EED
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 17:30:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urgFU-0000rk-3n; Thu, 28 Aug 2025 13:17:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1urdTD-0000hJ-20; Thu, 28 Aug 2025 10:19:19 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1urdT5-0005q4-Tk; Thu, 28 Aug 2025 10:19:18 -0400
Received: from [192.168.10.111] (p865013-ipoe.ipoe.ocn.ne.jp [153.242.222.12])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 57SEICLL097958
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 28 Aug 2025 23:18:25 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=jzogqJfWs1YAWF0gs/a83AXvrISG0uG/DVCnqKIQt4E=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Date:Subject:Message-Id:To;
 s=rs20250326; t=1756390705; v=1;
 b=X+o+lfgUy+NckM5J9mBAk4+4xCuPwCAAkeh+zTDIc44Qua1iJ4UdOlhK6WYA4um2
 bFavsb+yK2jnpvyiwoTWCPozwWN47gC92pTClSqgzVj8L2AbEi0RUDn6zGAp5AEf
 uMrgklOKb1Nlg7g1jMlF3j2awi0KiS//9/AOmvEVW/lzoZQ/uuoKXs8EEWNutfvT
 X2AH+M6Pc4b5cYcKIk4ny+Potp+RrcvYA+SEMNtcaGsc5GTcFnaRNBIXMJmoO8uS
 TfvSqI+LGRhszXZRvEa5smY0opNhVozEyazSMF++rHneemjrv3+Nwd+GLGAQF0FI
 car65A3Lu1We7YOZKga4Og==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Thu, 28 Aug 2025 23:18:11 +0900
Subject: [PATCH v9 1/2] memory: Update inline documentation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250828-san-v9-1-c0dff4b8a487@rsg.ci.i.u-tokyo.ac.jp>
References: <20250828-san-v9-0-c0dff4b8a487@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20250828-san-v9-0-c0dff4b8a487@rsg.ci.i.u-tokyo.ac.jp>
To: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, John Snow <jsnow@redhat.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>,
 David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, qemu-ppc@nongnu.org,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
X-Mailer: b4 0.14.2
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Do not refer to "memory region's reference count"
-------------------------------------------------

Now MemoryRegions do have their own reference counts, but they will not
be used when their owners are not themselves. However, the documentation
of memory_region_ref() says it adds "1 to a memory region's reference
count", which is confusing. Avoid referring to "memory region's
reference count" and just say: "Add a reference to a memory region".
Make a similar change to memory_region_unref() too.

Refer to docs/devel/memory.rst for "owner"
------------------------------------------

memory_region_ref() and memory_region_unref() used to have their own
descriptions of "owner", but they are somewhat out-of-date and
misleading.

In particular, they say "whenever memory regions are accessed outside
the BQL, they need to be preserved against hot-unplug", but protecting
against hot-unplug is not mandatory if it is known that they will never
be hot-unplugged. They also say "MemoryRegions actually do not have
their own reference count", but they actually do. They just will not be
used unless their owners are not themselves.

Refer to docs/devel/memory.rst as the single source of truth instead of
maintaining duplicate descriptions of "owner".

Clarify that owner may be missing

---------------------------------
A memory region may not have an owner, and memory_region_ref() and
memory_region_unref() do nothing for such.

memory: Clarify owner must not call memory_region_ref()
--------------------------------------------------------

The owner must not call this function as it results in a circular
reference.

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Reviewed-by: Peter Xu <peterx@redhat.com>
---
 include/system/memory.h | 59 +++++++++++++++++++++++--------------------------
 1 file changed, 28 insertions(+), 31 deletions(-)

diff --git a/include/system/memory.h b/include/system/memory.h
index e2cd6ed126144abaed6f3035e3ef091d747b4c34..06d6abaa7a9d85e650ff7a9df3f76f4535e8c4aa 100644
--- a/include/system/memory.h
+++ b/include/system/memory.h
@@ -1307,7 +1307,7 @@ static inline bool memory_region_section_intersect_range(MemoryRegionSection *s,
  * memory_region_add_subregion() to add subregions.
  *
  * @mr: the #MemoryRegion to be initialized
- * @owner: the object that tracks the region's reference count
+ * @owner: the object that keeps the region alive
  * @name: used for debugging; not visible to the user or ABI
  * @size: size of the region; any subregions beyond this size will be clipped
  */
@@ -1317,29 +1317,26 @@ void memory_region_init(MemoryRegion *mr,
                         uint64_t size);
 
 /**
- * memory_region_ref: Add 1 to a memory region's reference count
+ * memory_region_ref: Add a reference to the owner of a memory region
  *
- * Whenever memory regions are accessed outside the BQL, they need to be
- * preserved against hot-unplug.  MemoryRegions actually do not have their
- * own reference count; they piggyback on a QOM object, their "owner".
- * This function adds a reference to the owner.
- *
- * All MemoryRegions must have an owner if they can disappear, even if the
- * device they belong to operates exclusively under the BQL.  This is because
- * the region could be returned at any time by memory_region_find, and this
- * is usually under guest control.
+ * This function adds a reference to the owner of a memory region to keep the
+ * memory region alive. It does nothing if the owner is not present as a memory
+ * region without owner will never die.
+ * For references internal to the owner, pass the memory region to object_ref()
+ * instead of using this function to avoid a circular reference.
+ * See docs/devel/memory.rst to know about owner.
  *
  * @mr: the #MemoryRegion
  */
 void memory_region_ref(MemoryRegion *mr);
 
 /**
- * memory_region_unref: Remove 1 to a memory region's reference count
+ * memory_region_unref: Remove a reference to the memory region of the owner
  *
- * Whenever memory regions are accessed outside the BQL, they need to be
- * preserved against hot-unplug.  MemoryRegions actually do not have their
- * own reference count; they piggyback on a QOM object, their "owner".
- * This function removes a reference to the owner and possibly destroys it.
+ * This function removes a reference to the owner of a memory region and
+ * possibly destroys the owner along with the memory region. It does nothing if
+ * the owner is not present.
+ * See docs/devel/memory.rst to know about owner.
  *
  * @mr: the #MemoryRegion
  */
@@ -1352,7 +1349,7 @@ void memory_region_unref(MemoryRegion *mr);
  * if @size is nonzero, subregions will be clipped to @size.
  *
  * @mr: the #MemoryRegion to be initialized.
- * @owner: the object that tracks the region's reference count
+ * @owner: the object that keeps the region alive
  * @ops: a structure containing read and write callbacks to be used when
  *       I/O is performed on the region.
  * @opaque: passed to the read and write callbacks of the @ops structure.
@@ -1372,7 +1369,7 @@ void memory_region_init_io(MemoryRegion *mr,
  *                                    directly.
  *
  * @mr: the #MemoryRegion to be initialized.
- * @owner: the object that tracks the region's reference count
+ * @owner: the object that keeps the region alive
  * @name: Region name, becomes part of RAMBlock name used in migration stream
  *        must be unique within any device
  * @size: size of the region.
@@ -1395,7 +1392,7 @@ bool memory_region_init_ram_nomigrate(MemoryRegion *mr,
  *                                          modify memory directly.
  *
  * @mr: the #MemoryRegion to be initialized.
- * @owner: the object that tracks the region's reference count
+ * @owner: the object that keeps the region alive
  * @name: Region name, becomes part of RAMBlock name used in migration stream
  *        must be unique within any device
  * @size: size of the region.
@@ -1425,7 +1422,7 @@ bool memory_region_init_ram_flags_nomigrate(MemoryRegion *mr,
  *                                     canceled.
  *
  * @mr: the #MemoryRegion to be initialized.
- * @owner: the object that tracks the region's reference count
+ * @owner: the object that keeps the region alive
  * @name: Region name, becomes part of RAMBlock name used in migration stream
  *        must be unique within any device
  * @size: used size of the region.
@@ -1454,7 +1451,7 @@ bool memory_region_init_resizeable_ram(MemoryRegion *mr,
  *                                    mmap-ed backend.
  *
  * @mr: the #MemoryRegion to be initialized.
- * @owner: the object that tracks the region's reference count
+ * @owner: the object that keeps the region alive
  * @name: Region name, becomes part of RAMBlock name used in migration stream
  *        must be unique within any device
  * @size: size of the region.
@@ -1487,7 +1484,7 @@ bool memory_region_init_ram_from_file(MemoryRegion *mr,
  *                                  mmap-ed backend.
  *
  * @mr: the #MemoryRegion to be initialized.
- * @owner: the object that tracks the region's reference count
+ * @owner: the object that keeps the region alive
  * @name: the name of the region.
  * @size: size of the region.
  * @ram_flags: RamBlock flags. Supported flags: RAM_SHARED, RAM_PMEM,
@@ -1518,7 +1515,7 @@ bool memory_region_init_ram_from_fd(MemoryRegion *mr,
  *                              region will modify memory directly.
  *
  * @mr: the #MemoryRegion to be initialized.
- * @owner: the object that tracks the region's reference count
+ * @owner: the object that keeps the region alive
  * @name: Region name, becomes part of RAMBlock name used in migration stream
  *        must be unique within any device
  * @size: size of the region.
@@ -1546,7 +1543,7 @@ void memory_region_init_ram_ptr(MemoryRegion *mr,
  * skip_dump flag.
  *
  * @mr: the #MemoryRegion to be initialized.
- * @owner: the object that tracks the region's reference count
+ * @owner: the object that keeps the region alive
  * @name: the name of the region.
  * @size: size of the region.
  * @ptr: memory to be mapped; must contain at least @size bytes.
@@ -1566,7 +1563,7 @@ void memory_region_init_ram_device_ptr(MemoryRegion *mr,
  *                           part of another memory region.
  *
  * @mr: the #MemoryRegion to be initialized.
- * @owner: the object that tracks the region's reference count
+ * @owner: the object that keeps the region alive
  * @name: used for debugging; not visible to the user or ABI
  * @orig: the region to be referenced; @mr will be equivalent to
  *        @orig between @offset and @offset + @size - 1.
@@ -1592,7 +1589,7 @@ void memory_region_init_alias(MemoryRegion *mr,
  * of the caller.
  *
  * @mr: the #MemoryRegion to be initialized.
- * @owner: the object that tracks the region's reference count
+ * @owner: the object that keeps the region alive
  * @name: Region name, becomes part of RAMBlock name used in migration stream
  *        must be unique within any device
  * @size: size of the region.
@@ -1615,7 +1612,7 @@ bool memory_region_init_rom_nomigrate(MemoryRegion *mr,
  * of the caller.
  *
  * @mr: the #MemoryRegion to be initialized.
- * @owner: the object that tracks the region's reference count
+ * @owner: the object that keeps the region alive
  * @ops: callbacks for write access handling (must not be NULL).
  * @opaque: passed to the read and write callbacks of the @ops structure.
  * @name: Region name, becomes part of RAMBlock name used in migration stream
@@ -1651,7 +1648,7 @@ bool memory_region_init_rom_device_nomigrate(MemoryRegion *mr,
  * @_iommu_mr: the #IOMMUMemoryRegion to be initialized
  * @instance_size: the IOMMUMemoryRegion subclass instance size
  * @mrtypename: the type name of the #IOMMUMemoryRegion
- * @owner: the object that tracks the region's reference count
+ * @owner: the object that keeps the region alive
  * @name: used for debugging; not visible to the user or ABI
  * @size: size of the region.
  */
@@ -1667,7 +1664,7 @@ void memory_region_init_iommu(void *_iommu_mr,
  *                          region will modify memory directly.
  *
  * @mr: the #MemoryRegion to be initialized
- * @owner: the object that tracks the region's reference count (must be
+ * @owner: the object that keeps the region alive (must be
  *         TYPE_DEVICE or a subclass of TYPE_DEVICE, or NULL)
  * @name: name of the memory region
  * @size: size of the region in bytes
@@ -1713,7 +1710,7 @@ bool memory_region_init_ram_guest_memfd(MemoryRegion *mr,
  * If you pass a non-NULL non-device @owner then we will assert.
  *
  * @mr: the #MemoryRegion to be initialized.
- * @owner: the object that tracks the region's reference count
+ * @owner: the object that keeps the region alive
  * @name: Region name, becomes part of RAMBlock name used in migration stream
  *        must be unique within any device
  * @size: size of the region.
@@ -1744,7 +1741,7 @@ bool memory_region_init_rom(MemoryRegion *mr,
  * If you pass a non-NULL non-device @owner then we will assert.
  *
  * @mr: the #MemoryRegion to be initialized.
- * @owner: the object that tracks the region's reference count
+ * @owner: the object that keeps the region alive
  * @ops: callbacks for write access handling (must not be NULL).
  * @opaque: passed to the read and write callbacks of the @ops structure.
  * @name: Region name, becomes part of RAMBlock name used in migration stream

-- 
2.51.0


