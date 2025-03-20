Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82DD3C28B30
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Mar 2025 08:24:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvBBi-0002wn-5Y; Thu, 20 Mar 2025 04:23:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tvBBf-0002wY-5L
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 04:23:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tvBBc-00045m-B7
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 04:23:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742459011;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=ki7ZbIvoEXhmEChrTvaSgIXOaNAvKjs4AxSnPEq/yow=;
 b=TAbJ/9ecUvqaJR+dKbEmXNlRPMmjsM2lzkQtUQ7li930ukXTzNRGuubKMr+6Hw0ZrVub5z
 m51m8FAHmQ5IQk+KnImjQV9l+Qjz6IhgY7qKiXh61C0lZrDNN5Sa1cKNFUV+rpj8L4Lml9
 UHTQg4+8vu9IKYJKSHsowXA5Skz/MFs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-167-vDwDpVcyMMO_MR-tEB4wXQ-1; Thu, 20 Mar 2025 04:23:28 -0400
X-MC-Unique: vDwDpVcyMMO_MR-tEB4wXQ-1
X-Mimecast-MFC-AGG-ID: vDwDpVcyMMO_MR-tEB4wXQ_1742459008
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43ab5baf62cso3621855e9.0
 for <qemu-devel@nongnu.org>; Thu, 20 Mar 2025 01:23:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742459007; x=1743063807;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ki7ZbIvoEXhmEChrTvaSgIXOaNAvKjs4AxSnPEq/yow=;
 b=l+jrj/MDjQW5cEITlCgPOgFswGnwgmW/BkDoVk0wgCEmrE+/MY1P+e6IVYW9IFZljf
 ktLNIBxce9FHA9K124Nb8byd6+G3cQR96IYckEtmtknU4hmvmiAF2NSDBffmVSO9P+QF
 KSsusQ6F7x9swIDzSZTOqWLoLmPuTHV23RLb2ul4q3SKA2d8kXjkfZlR+Hv9jlHSe3YZ
 qCFCwwC7wavOLoEM4u8Q5P1HrBy0yq0MyCcwuBHu5Ma65WnSk4vzq8Jn3E8ezCB5qmAU
 rZwhiZnAWWy6juUDkYfZzMFoRFxC3s+ejgeScv7X7qmMkBdFC3NIWzonWcl0fsbkDGpq
 Jq1g==
X-Gm-Message-State: AOJu0Yxzhz2z8bCjsjoGGaX2lMKWBBTy04QHBmbYOaSgaY2z99lqcnRw
 D8h4kbgCHRdczZrRx8WtntiPQ281DoNzzSaAHmuR4QsYcfNgQWegaVyfvCoprgH3oVuhogDFMkv
 GgwU6YnigRKKNXUwN7cwkQf9ko6hN6jh7QqmMb8BRyakCddYNCq49sZukzjrNBzm8DRln5nOC5C
 f+AvVYmP738eUnNvnhmkTZSZkT3KzdD8DSI9n5
X-Gm-Gg: ASbGncvaNxlWHJozu2kcJ9E55zxsWeo//5gMf+XS2o5C++fLyJVK4eUKEzkBUJxFrtN
 xps+JbYx0EhP+7p+y40axEbVumY5pCy4vxDqwDeIut+87V2Y3rkLT6gv4lZ7yD6klVnNIowWubO
 R+BSyLZLNKECsK1Jr7Akul6+8D7FDjnQOdW3XSxPJ1W6Tt/V3Bts+/xPddD4zqFPvJxEHxT1x+7
 6KZcQoBxWacNh2YCDjEVBDUwNwgGI5GiijNOtM66IsDcSRtNTQW5M6ya9eGxKKPp7/bj46ZHR7+
 eX9DiPMDoag3fZ4AyUwe
X-Received: by 2002:a05:600c:1d15:b0:43c:e8a5:87a with SMTP id
 5b1f17b1804b1-43d4954f47dmr14846595e9.16.1742459007269; 
 Thu, 20 Mar 2025 01:23:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH8+p/lfb/PfU6DuzRgGSCGJjNgb+ZurvpnFgEBVKSTKVUPJuXWDFAZH9lYVxEPu8RQQtCDKQ==
X-Received: by 2002:a05:600c:1d15:b0:43c:e8a5:87a with SMTP id
 5b1f17b1804b1-43d4954f47dmr14846325e9.16.1742459006639; 
 Thu, 20 Mar 2025 01:23:26 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.194.153])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d43f47c8csm41046215e9.12.2025.03.20.01.23.25
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Mar 2025 01:23:26 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] qdev, rust/hpet: fix type of HPET "timers" property
Date: Thu, 20 Mar 2025 09:23:25 +0100
Message-ID: <20250320082325.788273-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.337,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/hw/qdev-properties.h   |  1 +
 hw/core/qdev-properties.c      | 35 ++++++++++++++++++++++++++++++++++
 rust/hw/timer/hpet/src/hpet.rs |  6 +++---
 3 files changed, 39 insertions(+), 3 deletions(-)

diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-properties.h
index 15fcec5260c..2c99856caac 100644
--- a/include/hw/qdev-properties.h
+++ b/include/hw/qdev-properties.h
@@ -52,6 +52,7 @@ extern const PropertyInfo qdev_prop_bool;
 extern const PropertyInfo qdev_prop_uint8;
 extern const PropertyInfo qdev_prop_uint16;
 extern const PropertyInfo qdev_prop_uint32;
+extern const PropertyInfo qdev_prop_usize;
 extern const PropertyInfo qdev_prop_int32;
 extern const PropertyInfo qdev_prop_uint64;
 extern const PropertyInfo qdev_prop_uint64_checkmask;
diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index c04df3b337a..dce323a0c90 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -442,6 +442,41 @@ const PropertyInfo qdev_prop_uint64_checkmask = {
     .set   = set_uint64_checkmask,
 };
 
+/* --- pointer-size integer --- */
+
+static void get_usize(Object *obj, Visitor *v, const char *name, void *opaque,
+                      Error **errp)
+{
+    const Property *prop = opaque;
+    size_t *ptr = object_field_prop_ptr(obj, prop);
+
+#if HOST_LONG_BITS == 32
+    visit_type_uint32(v, name, ptr, errp);
+#else
+    visit_type_uint64(v, name, ptr, errp);
+#endif
+}
+
+static void set_usize(Object *obj, Visitor *v, const char *name, void *opaque,
+                      Error **errp)
+{
+    const Property *prop = opaque;
+    size_t *ptr = object_field_prop_ptr(obj, prop);
+
+#if HOST_LONG_BITS == 32
+    visit_type_uint32(v, name, ptr, errp);
+#else
+    visit_type_uint64(v, name, ptr, errp);
+#endif
+}
+
+const PropertyInfo qdev_prop_usize = {
+    .type  = "usize",
+    .get   = get_usize,
+    .set   = set_usize,
+    .set_default_value = qdev_propinfo_set_default_value_uint,
+};
+
 /* --- string --- */
 
 static void release_string(Object *obj, const char *name, void *opaque)
diff --git a/rust/hw/timer/hpet/src/hpet.rs b/rust/hw/timer/hpet/src/hpet.rs
index 20e0afdfca8..63c1971f0b5 100644
--- a/rust/hw/timer/hpet/src/hpet.rs
+++ b/rust/hw/timer/hpet/src/hpet.rs
@@ -12,7 +12,7 @@
 use qemu_api::{
     bindings::{
         address_space_memory, address_space_stl_le, qdev_prop_bit, qdev_prop_bool,
-        qdev_prop_uint32, qdev_prop_uint8,
+        qdev_prop_uint32, qdev_prop_usize,
     },
     c_str,
     cell::{BqlCell, BqlRefCell},
@@ -859,8 +859,8 @@ impl ObjectImpl for HPETState {
         c_str!("timers"),
         HPETState,
         num_timers,
-        unsafe { &qdev_prop_uint8 },
-        u8,
+        unsafe { &qdev_prop_usize },
+        usize,
         default = HPET_MIN_TIMERS
     ),
     qemu_api::define_property!(
-- 
2.48.1


