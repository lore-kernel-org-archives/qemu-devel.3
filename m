Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9330D11712
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Dec 2025 16:41:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQTQh-0000xU-A0; Tue, 02 Dec 2025 11:40:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vQTQX-0000wq-RK
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 11:40:34 -0500
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vQTQW-0001lq-0b
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 11:40:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1764693631; x=1796229631;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Ri+hE0aEh63QaQ4qr99LpLC5VPDanP5Ow2vhQA4wQY4=;
 b=ZQEles1fx1bj9wKn7G3WH/FjpM3qGxjfCWDi1KeCrpp8u+wnp5WtSpwd
 mFB7W054a8R4qpp5OXlOx9Qc51HdCoXA4xdEyFq8fAUyccP7j3EHWT83Z
 oTaty8MrefP572eVMRYCNkoArZfnlMBL4fiJbiXug0fUOYZcSinF0CJIi
 8IRwaS8tQ4VxZuilS6ZGnUkbFhSSY6HvW3fFKeGhHr8n1PP/Q1ODtoVzy
 YaVtOFqJhb85HfK5/iuhnuilM1yqkjHMUQ+4dZ+GjBf/VYZD81D0I9+/T
 Nhf5boBPAmhLpXEWiVxI/ug4v0WqG7/WaGVQbfAmRlYToTlQTjNd660F1 g==;
X-CSE-ConnectionGUID: g5yqNmrXSgSgTocTNlBW5g==
X-CSE-MsgGUID: DAANyP1DQs+FDJq/cVOGgg==
X-IronPort-AV: E=McAfee;i="6800,10657,11630"; a="66555296"
X-IronPort-AV: E=Sophos;i="6.20,243,1758610800"; d="scan'208";a="66555296"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Dec 2025 08:40:29 -0800
X-CSE-ConnectionGUID: PWHPbr76TMmUfIXFdpdFPg==
X-CSE-MsgGUID: 1maLxthjSC6dnbTfwtI+ZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,243,1758610800"; d="scan'208";a="231751216"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa001.jf.intel.com with ESMTP; 02 Dec 2025 08:40:26 -0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>, devel@lists.libvirt.org,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [RFC 01/10] qom: Rename ObjectPropertyFlags to
 ObjectPropertyAccessorFlags
Date: Wed,  3 Dec 2025 01:04:53 +0800
Message-Id: <20251202170502.3228625-2-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251202170502.3228625-1-zhao1.liu@intel.com>
References: <20251202170502.3228625-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.17; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

At present, ObjectPropertyFlags is used to select accessors and such
flags won't be stored in ObjectProperty itself.

So it's not proper to extend this ObjectPropertyFlags for "deprecated"
or "internal" flags.

Therefore, rename ObjectPropertyFlags to ObjectPropertyAccessorFlags,
and then the original name ObjectPropertyFlags can be used for other
cases.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 include/qom/object.h | 28 ++++++++++++++--------------
 qom/object.c         | 16 ++++++++--------
 2 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/include/qom/object.h b/include/qom/object.h
index 26df6137b911..3f807a03f5aa 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -1846,14 +1846,14 @@ typedef enum {
     OBJ_PROP_FLAG_WRITE = 1 << 1,
     /* Automatically add a getter and a setter to the property */
     OBJ_PROP_FLAG_READWRITE = (OBJ_PROP_FLAG_READ | OBJ_PROP_FLAG_WRITE),
-} ObjectPropertyFlags;
+} ObjectPropertyAccessorFlags;
 
 /**
  * object_property_add_uint8_ptr:
  * @obj: the object to add a property to
  * @name: the name of the property
  * @v: pointer to value
- * @flags: bitwise-or'd ObjectPropertyFlags
+ * @flags: bitwise-or'd ObjectPropertyAccessorFlags
  *
  * Add an integer property in memory.  This function will add a
  * property of type 'uint8'.
@@ -1861,20 +1861,20 @@ typedef enum {
  * Returns: The newly added property on success, or %NULL on failure.
  */
 ObjectProperty *object_property_add_uint8_ptr(Object *obj, const char *name,
-                                              const uint8_t *v,
-                                              ObjectPropertyFlags flags);
+                                        const uint8_t *v,
+                                        ObjectPropertyAccessorFlags flags);
 
 ObjectProperty *object_class_property_add_uint8_ptr(ObjectClass *klass,
                                          const char *name,
                                          const uint8_t *v,
-                                         ObjectPropertyFlags flags);
+                                         ObjectPropertyAccessorFlags flags);
 
 /**
  * object_property_add_uint16_ptr:
  * @obj: the object to add a property to
  * @name: the name of the property
  * @v: pointer to value
- * @flags: bitwise-or'd ObjectPropertyFlags
+ * @flags: bitwise-or'd ObjectPropertyAccessorFlags
  *
  * Add an integer property in memory.  This function will add a
  * property of type 'uint16'.
@@ -1883,19 +1883,19 @@ ObjectProperty *object_class_property_add_uint8_ptr(ObjectClass *klass,
  */
 ObjectProperty *object_property_add_uint16_ptr(Object *obj, const char *name,
                                     const uint16_t *v,
-                                    ObjectPropertyFlags flags);
+                                    ObjectPropertyAccessorFlags flags);
 
 ObjectProperty *object_class_property_add_uint16_ptr(ObjectClass *klass,
                                           const char *name,
                                           const uint16_t *v,
-                                          ObjectPropertyFlags flags);
+                                          ObjectPropertyAccessorFlags flags);
 
 /**
  * object_property_add_uint32_ptr:
  * @obj: the object to add a property to
  * @name: the name of the property
  * @v: pointer to value
- * @flags: bitwise-or'd ObjectPropertyFlags
+ * @flags: bitwise-or'd ObjectPropertyAccessorFlags
  *
  * Add an integer property in memory.  This function will add a
  * property of type 'uint32'.
@@ -1904,19 +1904,19 @@ ObjectProperty *object_class_property_add_uint16_ptr(ObjectClass *klass,
  */
 ObjectProperty *object_property_add_uint32_ptr(Object *obj, const char *name,
                                     const uint32_t *v,
-                                    ObjectPropertyFlags flags);
+                                    ObjectPropertyAccessorFlags flags);
 
 ObjectProperty *object_class_property_add_uint32_ptr(ObjectClass *klass,
                                           const char *name,
                                           const uint32_t *v,
-                                          ObjectPropertyFlags flags);
+                                          ObjectPropertyAccessorFlags flags);
 
 /**
  * object_property_add_uint64_ptr:
  * @obj: the object to add a property to
  * @name: the name of the property
  * @v: pointer to value
- * @flags: bitwise-or'd ObjectPropertyFlags
+ * @flags: bitwise-or'd ObjectPropertyAccessorFlags
  *
  * Add an integer property in memory.  This function will add a
  * property of type 'uint64'.
@@ -1925,12 +1925,12 @@ ObjectProperty *object_class_property_add_uint32_ptr(ObjectClass *klass,
  */
 ObjectProperty *object_property_add_uint64_ptr(Object *obj, const char *name,
                                     const uint64_t *v,
-                                    ObjectPropertyFlags flags);
+                                    ObjectPropertyAccessorFlags flags);
 
 ObjectProperty *object_class_property_add_uint64_ptr(ObjectClass *klass,
                                           const char *name,
                                           const uint64_t *v,
-                                          ObjectPropertyFlags flags);
+                                          ObjectPropertyAccessorFlags flags);
 
 /**
  * object_property_add_alias:
diff --git a/qom/object.c b/qom/object.c
index 4f32c1aba7d7..85d31bb64b36 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -2636,7 +2636,7 @@ static void property_set_uint64_ptr(Object *obj, Visitor *v, const char *name,
 ObjectProperty *
 object_property_add_uint8_ptr(Object *obj, const char *name,
                               const uint8_t *v,
-                              ObjectPropertyFlags flags)
+                              ObjectPropertyAccessorFlags flags)
 {
     ObjectPropertyAccessor *getter = NULL;
     ObjectPropertyAccessor *setter = NULL;
@@ -2656,7 +2656,7 @@ object_property_add_uint8_ptr(Object *obj, const char *name,
 ObjectProperty *
 object_class_property_add_uint8_ptr(ObjectClass *klass, const char *name,
                                     const uint8_t *v,
-                                    ObjectPropertyFlags flags)
+                                    ObjectPropertyAccessorFlags flags)
 {
     ObjectPropertyAccessor *getter = NULL;
     ObjectPropertyAccessor *setter = NULL;
@@ -2676,7 +2676,7 @@ object_class_property_add_uint8_ptr(ObjectClass *klass, const char *name,
 ObjectProperty *
 object_property_add_uint16_ptr(Object *obj, const char *name,
                                const uint16_t *v,
-                               ObjectPropertyFlags flags)
+                               ObjectPropertyAccessorFlags flags)
 {
     ObjectPropertyAccessor *getter = NULL;
     ObjectPropertyAccessor *setter = NULL;
@@ -2696,7 +2696,7 @@ object_property_add_uint16_ptr(Object *obj, const char *name,
 ObjectProperty *
 object_class_property_add_uint16_ptr(ObjectClass *klass, const char *name,
                                      const uint16_t *v,
-                                     ObjectPropertyFlags flags)
+                                     ObjectPropertyAccessorFlags flags)
 {
     ObjectPropertyAccessor *getter = NULL;
     ObjectPropertyAccessor *setter = NULL;
@@ -2716,7 +2716,7 @@ object_class_property_add_uint16_ptr(ObjectClass *klass, const char *name,
 ObjectProperty *
 object_property_add_uint32_ptr(Object *obj, const char *name,
                                const uint32_t *v,
-                               ObjectPropertyFlags flags)
+                               ObjectPropertyAccessorFlags flags)
 {
     ObjectPropertyAccessor *getter = NULL;
     ObjectPropertyAccessor *setter = NULL;
@@ -2736,7 +2736,7 @@ object_property_add_uint32_ptr(Object *obj, const char *name,
 ObjectProperty *
 object_class_property_add_uint32_ptr(ObjectClass *klass, const char *name,
                                      const uint32_t *v,
-                                     ObjectPropertyFlags flags)
+                                     ObjectPropertyAccessorFlags flags)
 {
     ObjectPropertyAccessor *getter = NULL;
     ObjectPropertyAccessor *setter = NULL;
@@ -2756,7 +2756,7 @@ object_class_property_add_uint32_ptr(ObjectClass *klass, const char *name,
 ObjectProperty *
 object_property_add_uint64_ptr(Object *obj, const char *name,
                                const uint64_t *v,
-                               ObjectPropertyFlags flags)
+                               ObjectPropertyAccessorFlags flags)
 {
     ObjectPropertyAccessor *getter = NULL;
     ObjectPropertyAccessor *setter = NULL;
@@ -2776,7 +2776,7 @@ object_property_add_uint64_ptr(Object *obj, const char *name,
 ObjectProperty *
 object_class_property_add_uint64_ptr(ObjectClass *klass, const char *name,
                                      const uint64_t *v,
-                                     ObjectPropertyFlags flags)
+                                     ObjectPropertyAccessorFlags flags)
 {
     ObjectPropertyAccessor *getter = NULL;
     ObjectPropertyAccessor *setter = NULL;
-- 
2.34.1


