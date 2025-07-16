Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B35AC83F1B
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 10:54:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubzhd-0001CP-Ub; Wed, 16 Jul 2025 06:49:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ubzej-0001F5-Bh
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 06:46:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ubzed-0000r0-NO
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 06:46:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752662786;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5r7DYLmp+E9ag1L7wKjeNhUnOiKaPcopIlcFiJkBtOc=;
 b=MxfL7eBYqidj3j+L8c6SOYneKNK2Zh1UZULsHXXk8K5e1sCilReTDMcbioS84XvLeAOqWT
 9OuufH+alW6sdGtSiWaMSbTGD1GKTdkPBuWJM6It8pgSvW5cCzhImxq721nnPAYW4KDQXi
 Xyqeow3Pi1eiG7hx/6zcAVU22nDT+KE=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-684-fmE3zf07MxuqqfYbSl4YXQ-1; Wed, 16 Jul 2025 06:46:25 -0400
X-MC-Unique: fmE3zf07MxuqqfYbSl4YXQ-1
X-Mimecast-MFC-AGG-ID: fmE3zf07MxuqqfYbSl4YXQ_1752662785
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-23638e1605dso50030595ad.0
 for <qemu-devel@nongnu.org>; Wed, 16 Jul 2025 03:46:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752662785; x=1753267585;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5r7DYLmp+E9ag1L7wKjeNhUnOiKaPcopIlcFiJkBtOc=;
 b=W1kpcjeNiosNIxFZSpDEp94C0pHEsgifU12bojkMF6Dk1Rn3Pv+zwCZcvglYg5StVW
 waDnRQ5GpbCrPLwaPLrsa5H1aO0r65LlaxTOLV3Ahi6YCwlkmJ3K94AwVpdFIOEif91c
 BMV/HPKNvE/WxqtYu8+CE1XM9JMRxs7rolBjULvuib9AH8u+6MT5RxSpQ0T7kOlTUJsu
 rV1hXyj6AMjEllYrpuKiIUtlSPlUMRd4396oVo+iscP/HnwNCfgzJR7YnJ0sDLVwn61p
 vlunH6K5aCnmAl7u5Q58pl5dTppe24mbPCV6pr+71Gbi8XtwbR4xfDxTk/UWgxvjleAO
 vb2g==
X-Gm-Message-State: AOJu0YwqoLGMYkKPjFyobesgpsQSf7cWFUb89lQwPZQxsbDvwvnZbdP2
 qMIqog+ExlcMigA2loaOdbwsV0YJc+5f9mSGq32wTWhR6uGm/eZwF7BaMb5WiS8mPuf2iMW2f5I
 NVM45n4q4izPTsRdivCfYfJjC/x5aUSsCPUl8mtnshX/ia/ijiKamwCFD
X-Gm-Gg: ASbGncss9XOcdzZRcX8jXg8OLSNMyT65LVOpfTpIlZUW6a/eEnNvBj0ly23MNieCkHF
 P9oi3SEPKEKRo1IcWw3cL8ouo6UtqnvSqrUqPd8NNgY25SHh0Vj5ckpSgHNf3x24q5laBZb/wCG
 mAsFVcP5EZvxNuM6/pgOiUx6zHjlZOaOy0Jlc4YsuT5jEXxVz48nZBL7XO2oWQYz+xpZSlaVXtG
 3OumodUPJoTNO4buMKi38gXzLTqkfAdIGgGy9HhlnHlyinQi3uKS9YpoH8rB7aqJNRYFO8+vlE+
 m3hcwXQnKZ7psVwHaaD1MiruOhvA7vFcCRoxsqNsLs9dAYI4zg==
X-Received: by 2002:a17:903:1b66:b0:23d:dcf5:4806 with SMTP id
 d9443c01a7336-23e257660b1mr32966565ad.39.1752662784749; 
 Wed, 16 Jul 2025 03:46:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFhBDIAPUhmgSaKpaVe7juSppj1ep1XKXgbyLGtOu6LuQwU3v0LsLRHp/SYREuKCV3NAM6GrQ==
X-Received: by 2002:a17:903:1b66:b0:23d:dcf5:4806 with SMTP id
 d9443c01a7336-23e257660b1mr32966025ad.39.1752662784356; 
 Wed, 16 Jul 2025 03:46:24 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.97.1])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23de435baccsm123363265ad.227.2025.07.16.03.46.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Jul 2025 03:46:24 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Wed, 16 Jul 2025 16:13:12 +0530
Subject: [PATCH v4 22/23] migration: Add error-parameterized function
 variants in VMSD struct
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250716-propagate_tpm_error-v4-22-7141902077c0@redhat.com>
References: <20250716-propagate_tpm_error-v4-0-7141902077c0@redhat.com>
In-Reply-To: <20250716-propagate_tpm_error-v4-0-7141902077c0@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, 
 Eric Farman <farman@linux.ibm.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>, 
 Thomas Huth <thuth@redhat.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Alex Williamson <alex.williamson@redhat.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Hailiang Zhang <zhanghailiang@xfusion.com>, 
 Steve Sistare <steven.sistare@oracle.com>, qemu-s390x@nongnu.org, 
 qemu-ppc@nongnu.org, Stefan Berger <stefanb@linux.vnet.ibm.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 Matthew Rosato <mjrosato@linux.ibm.com>, Arun Menon <armenon@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5680; i=armenon@redhat.com;
 h=from:subject:message-id; bh=3Jq36iXUSbHTQC9cQ7Zq45KdL78RMO+hdXGkLCz9CVo=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ0Z5k8Nh/QBXpgeJZtF3FQ7slUya+29zTXTR/TuK13jFF
 7tJLxPoKGVhEONikBVTZGn4GiDbFFAYEWn78jrMHFYmkCEMXJwCMJETixkZnkudlJ0+P3j7/PVq
 hQ+mdRg2lOkp956p/FrlXDtj9v6ldYwMJy8bl2W8UrnkWxJ5yDftnXSLDovKu9ITN5YpVTSI2RX
 wAAA=
X-Developer-Key: i=armenon@redhat.com; a=openpgp;
 fpr=80F5501D82507158593DE9D76A7A2538D90F328E
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

- We need to have good error reporting in the callbacks in
  VMStateDescription struct. Specifically pre_save, post_save,
  pre_load and post_load callbacks.
- It is not possible to change these functions everywhere in one
  patch, therefore, we introduce a duplicate set of callbacks
  with Error object passed to them.
- So, in this commit, we implement 'errp' variants of these callbacks,
  introducing an explicit Error object parameter.
- This is a functional step towards transitioning the entire codebase
  to the new error-parameterized functions.
- Deliberately called in mutual exclusion from their counterparts,
  to prevent conflicts during the transition.
- New impls should preferentally use 'errp' variants of
  these methods, and existing impls incrementally converted.
  The variants without 'errp' are intended to be removed
  once all usage is converted.

Signed-off-by: Arun Menon <armenon@redhat.com>
---
 include/migration/vmstate.h | 11 +++++++++++
 migration/vmstate.c         | 36 +++++++++++++++++++++++++++++++-----
 2 files changed, 42 insertions(+), 5 deletions(-)

diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index 056781b1c21e737583f081594d9f88b32adfd674..53fa72c1bbde399be02c88fc8745fdbb79bfd7c8 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -200,15 +200,26 @@ struct VMStateDescription {
      * exclusive. For this reason, also early_setup VMSDs are migrated in a
      * QEMU_VM_SECTION_FULL section, while save_setup() data is migrated in
      * a QEMU_VM_SECTION_START section.
+     *
+     * There are duplicate impls of the post/pre save/load hooks.
+     * New impls should preferentally use 'errp' variants of these
+     * methods and existing impls incrementally converted.
+     * The variants without 'errp' are intended to be removed
+     * once all usage is converted.
      */
+
     bool early_setup;
     int version_id;
     int minimum_version_id;
     MigrationPriority priority;
     int (*pre_load)(void *opaque);
+    int (*pre_load_errp)(void *opaque, Error **errp);
     int (*post_load)(void *opaque, int version_id);
+    int (*post_load_errp)(void *opaque, int version_id, Error **errp);
     int (*pre_save)(void *opaque);
+    int (*pre_save_errp)(void *opaque, Error **errp);
     int (*post_save)(void *opaque);
+    int (*post_save_errp)(void *opaque, Error **errp);
     bool (*needed)(void *opaque);
     bool (*dev_unplug_pending)(void *opaque);
 
diff --git a/migration/vmstate.c b/migration/vmstate.c
index 078a00003023cc248fb16f05017d4c4251fd86df..bff4539cbe526c5a0718678d4e1f32ba9ac57889 100644
--- a/migration/vmstate.c
+++ b/migration/vmstate.c
@@ -152,7 +152,13 @@ int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
         trace_vmstate_load_state_end(vmsd->name, "too old", -EINVAL);
         return -EINVAL;
     }
-    if (vmsd->pre_load) {
+    if (vmsd->pre_load_errp) {
+        ret = vmsd->pre_load_errp(opaque, errp);
+        if (ret) {
+            error_prepend(errp, "VM pre load failed : %d ", ret);
+            return ret;
+        }
+    } else if (vmsd->pre_load) {
         ret = vmsd->pre_load(opaque);
         if (ret) {
             error_setg(errp, "VM pre load failed : %d", ret);
@@ -238,7 +244,12 @@ int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
         qemu_file_set_error(f, ret);
         return ret;
     }
-    if (vmsd->post_load) {
+    if (vmsd->post_load_errp) {
+        ret = vmsd->post_load_errp(opaque, version_id, errp);
+        if (ret < 0) {
+            error_prepend(errp, "VM Post load failed : %d ", ret);
+        }
+    } else if (vmsd->post_load) {
         ret = vmsd->post_load(opaque, version_id);
         if (ret < 0) {
             error_setg(errp, "VM Post load failed : %d", ret);
@@ -414,7 +425,14 @@ int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
 
     trace_vmstate_save_state_top(vmsd->name);
 
-    if (vmsd->pre_save) {
+    if (vmsd->pre_save_errp) {
+        ret = vmsd->pre_save_errp(opaque, errp);
+        trace_vmstate_save_state_pre_save_res(vmsd->name, ret);
+        if (ret) {
+            error_prepend(errp, "pre-save failed: %s ", vmsd->name);
+            return ret;
+        }
+    } else if (vmsd->pre_save) {
         ret = vmsd->pre_save(opaque);
         trace_vmstate_save_state_pre_save_res(vmsd->name, ret);
         if (ret) {
@@ -524,7 +542,9 @@ int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
                 if (ret) {
                     error_setg(errp, "Save of field %s/%s failed",
                                 vmsd->name, field->name);
-                    if (vmsd->post_save) {
+                    if (vmsd->post_save_errp) {
+                        vmsd->post_save_errp(opaque, errp);
+                    } else if (vmsd->post_save) {
                         vmsd->post_save(opaque);
                     }
                     return ret;
@@ -552,7 +572,13 @@ int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
 
     ret = vmstate_subsection_save(f, vmsd, opaque, vmdesc, errp);
 
-    if (vmsd->post_save) {
+    if (vmsd->post_save_errp) {
+        int ps_ret = vmsd->post_save_errp(opaque, errp);
+        if (!ret && ps_ret) {
+            ret = ps_ret;
+            error_prepend(errp, "post-save failed: %s ", vmsd->name);
+        }
+    } else if (vmsd->post_save) {
         int ps_ret = vmsd->post_save(opaque);
         if (!ret && ps_ret) {
             ret = ps_ret;

-- 
2.50.0


