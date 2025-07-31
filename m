Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA8CBC87FCA
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Jul 2025 14:26:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhUCx-0000cd-J6; Thu, 31 Jul 2025 10:24:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1uhTIQ-0004qS-6z
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 09:26:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1uhTIN-0000Vx-NU
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 09:26:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753968366;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SBfQJK2JW5W8/viknmh/y+5CyIVaxDMmsG4Tihgbhek=;
 b=V8jU/Q8lIK4U6RMEBDxCtMiDdebvVQSOTzHNVWfKN2k/4ZOALrFr0W2BtXe+qtO5n1bVuW
 I+3cbFMfWFTb95Uw/FDGDQXzUE4Jy2TDChg8WpSUp2hIMarSe52Z/sFc7sfpYHEwSsbH2O
 lTW6WIJDbT7SPoTuh5Q257VEOvl1lGU=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-58-zoRf8r0oOdyyDBWfAuJrAg-1; Thu, 31 Jul 2025 09:26:05 -0400
X-MC-Unique: zoRf8r0oOdyyDBWfAuJrAg-1
X-Mimecast-MFC-AGG-ID: zoRf8r0oOdyyDBWfAuJrAg_1753968364
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2400cbd4241so12627685ad.3
 for <qemu-devel@nongnu.org>; Thu, 31 Jul 2025 06:26:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753968364; x=1754573164;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SBfQJK2JW5W8/viknmh/y+5CyIVaxDMmsG4Tihgbhek=;
 b=g5b702g7ctiYxo5Tvx4u2niHfZx86rOP8xcuElykacVE1prEDfzOLweyB4FnLoDm/c
 QDt3SybcsmzWmt+WJg3lzzZua4/wXQDpTuyESDIi6CAN43wt/26vsjIyq85WmjQB33jv
 z2Y+VHGHevfVOfQtshON+jyQbX73FnvU9NkIJ8cIvDUickPGiWn/rQpHjJWhB+b9PtjR
 znOk5AnMBYOGFtwN2npfb9oxpG4EAhPdJESEYpybKeVGledL6N32vq8+Z3pyH2M7m3bx
 1VtfB0vVjS50bv+wg/vreaXNPfFBTbvB/9ShVpUhvqEYfe+o0i6pA96MlmE7sEdGgEed
 fBHg==
X-Gm-Message-State: AOJu0YxmK3/q/1yi9SXtE/A4HTAmvFrWrBoxcGJqx+TkXAxx/X5kOVb9
 Ch3bymea35IcoTf2WBloMkgWagFYHCuwUKaIySLlAsqSSm50i8/HLCq+KkLuct1BSoIe2No4Kdq
 HgdyymneDll+/B/ddHXOFxCvT9Z2iEmMgUy0LQPLWgnwz8yW11LrWGq0sFTW1sPE0xxBhazXAJA
 T4nbnXuoJQtVwxDVYwNrK6ARib1E0zoidIb+QPSrKkbA==
X-Gm-Gg: ASbGncsnesA2fOaN4LueumFmKrGOF2s4uWSQOw9R1bDpIQk+HOq4G1nLhfgfSbeKt57
 3NKKAs6UcixUa31qzCLNvavQp3kVqThyHkJ/qnJ8IFJUOuAHGANwppZSDhdH/w9f9zjNypqSJ+N
 UZgQsBFO/j62ivzqEYVYU7esNdsnKT5WiYnkoZIMD8HJhDeHeBc3iEmiolua+Sf3euY3vlwmSOz
 cPWAfff3E/7gQt/r2vplXw06hAmGtEjarM+K/ht21AIO/pLeoduroDEFL8oRH0GEXp3EGQkEGr3
 NCpydlcEOohmwfv0SE2QpzbUYpl4X1Wkg/kNNmmASPQqR23woxcd
X-Received: by 2002:a17:902:cec8:b0:23c:863d:2989 with SMTP id
 d9443c01a7336-24096a4f7d8mr105790375ad.3.1753968363761; 
 Thu, 31 Jul 2025 06:26:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHBZBgxWbcJRWUd5yjJBg0dpCTCzKtCqttCXHPU+6p/L2gDR3xDp2xFUvr5O/PK6PAXx/uW0Q==
X-Received: by 2002:a17:902:cec8:b0:23c:863d:2989 with SMTP id
 d9443c01a7336-24096a4f7d8mr105789285ad.3.1753968362878; 
 Thu, 31 Jul 2025 06:26:02 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.99.139])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3209a84d115sm2007034a91.36.2025.07.31.06.25.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Jul 2025 06:26:02 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Thu, 31 Jul 2025 18:51:06 +0530
Subject: [PATCH v8 26/27] migration: Add error-parameterized function
 variants in VMSD struct
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250731-propagate_tpm_error-v8-26-28fd82fdfdb2@redhat.com>
References: <20250731-propagate_tpm_error-v8-0-28fd82fdfdb2@redhat.com>
In-Reply-To: <20250731-propagate_tpm_error-v8-0-28fd82fdfdb2@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7163; i=armenon@redhat.com;
 h=from:subject:message-id; bh=UoofvziF9RyLHTE6L38QBQQxwIyZ0DMu/eAi69s1Tco=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ0Z37vPQVx9nHSyV7Vn58PCL635LN0/8s1gvSEo/43i7O
 eev3j6PjlIWBjEuBlkxRZaGrwGyTQGFEZG2L6/DzGFlAhnCwMUpABeZxMhwmN+8SnO2e7eB8ex3
 frssfuzwun36Qsv75X1i87KXtiw0YWTok1pYfvGo3v7JrhsmnCiYMW3f7T6xhwc5zXRua8k9KC9
 nBwA=
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
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
 docs/devel/migration/main.rst | 24 ++++++++++++++++++++++++
 include/migration/vmstate.h   | 15 +++++++++++++++
 migration/vmstate.c           | 34 ++++++++++++++++++++++++++++++----
 3 files changed, 69 insertions(+), 4 deletions(-)

diff --git a/docs/devel/migration/main.rst b/docs/devel/migration/main.rst
index 6493c1d2bca48a2fa34d92f6c0979c215c56b8d5..35bf5ae26c87f3c82964eb15618be373ab5a41fc 100644
--- a/docs/devel/migration/main.rst
+++ b/docs/devel/migration/main.rst
@@ -444,6 +444,30 @@ The functions to do that are inside a vmstate definition, and are called:
   This function is called after we save the state of one device
   (even upon failure, unless the call to pre_save returned an error).
 
+Following are the errp variants of these functions.
+
+- ``int (*pre_load_errp)(void *opaque, Error **errp);``
+
+  This function is called before we load the state of one device.
+
+- ``int (*post_load_errp)(void *opaque, int version_id, Error **errp);``
+
+  This function is called after we load the state of one device.
+
+- ``int (*pre_save_errp)(void *opaque, Error **errp);``
+
+  This function is called before we save the state of one device.
+
+- ``int (*post_save_errp)(void *opaque, Error **errp);``
+
+  This function is called after we save the state of one device
+  (even upon failure, unless the call to pre_save returned an error).
+
+New impls should preferentally use 'errp' variants of these
+methods and existing impls incrementally converted.
+The variants without 'errp' are intended to be removed
+once all usage is converted.
+
 Example: You can look at hpet.c, that uses the first three functions
 to massage the state that is transferred.
 
diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index 5fe9bbf39058d0cf97c1adab54cc516dbe8dc32a..51baf6c7f9d061ee33949d7e798f2184e50b4cbf 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -200,15 +200,30 @@ struct VMStateDescription {
      * exclusive. For this reason, also early_setup VMSDs are migrated in a
      * QEMU_VM_SECTION_FULL section, while save_setup() data is migrated in
      * a QEMU_VM_SECTION_START section.
+     *
+     * There are duplicate impls of the post/pre save/load hooks.
+     * New impls should preferentally use 'errp' variants of these
+     * methods and existing impls incrementally converted.
+     * The variants without 'errp' are intended to be removed
+     * once all usage is converted.
+     *
+     * For the errp variants,
+     * Returns: 0 on success,
+     *          <0 on error where -value is an error number from errno.h
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
index 07b192fa090e95ea80b642cff3982cefa65287a4..f6b7d0ff840ea219a77b305e9cd622a4c1f61b96 100644
--- a/migration/vmstate.c
+++ b/migration/vmstate.c
@@ -152,7 +152,16 @@ int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
         trace_vmstate_load_state_end(vmsd->name, "too old", -EINVAL);
         return -EINVAL;
     }
-    if (vmsd->pre_load) {
+    if (vmsd->pre_load_errp) {
+        ret = vmsd->pre_load_errp(opaque, errp);
+        if (ret) {
+            error_prepend(errp, "VM pre load failed for: '%s', "
+                          "version_id: '%d', minimum version_id: '%d', "
+                          "ret: %d: ", vmsd->name, vmsd->version_id,
+                          vmsd->minimum_version_id, ret);
+            return ret;
+        }
+    } else if (vmsd->pre_load) {
         ret = vmsd->pre_load(opaque);
         if (ret) {
             error_setg(errp, "VM pre load failed for: '%s', "
@@ -242,7 +251,14 @@ int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
         qemu_file_set_error(f, ret);
         return ret;
     }
-    if (vmsd->post_load) {
+    if (vmsd->post_load_errp) {
+        ret = vmsd->post_load_errp(opaque, version_id, errp);
+        if (ret < 0) {
+            error_prepend(errp, "VM Post load failed for: %s, version_id: %d, "
+                          "minimum_version: %d, ret: %d: ", vmsd->name,
+                          vmsd->version_id, vmsd->minimum_version_id, ret);
+        }
+    } else if (vmsd->post_load) {
         ret = vmsd->post_load(opaque, version_id);
         if (ret < 0) {
             error_setg(errp,
@@ -411,8 +427,16 @@ int vmstate_save_state(QEMUFile *f, const VMStateDescription *vmsd,
 static int pre_save_dispatch(const VMStateDescription *vmsd, void *opaque,
                              Error **errp)
 {
+    ERRP_GUARD();
     int ret = 0;
-    if (vmsd->pre_save) {
+    if (vmsd->pre_save_errp) {
+        ret = vmsd->pre_save_errp(opaque, errp);
+        trace_vmstate_save_state_pre_save_res(vmsd->name, ret);
+        if (ret) {
+            error_prepend(errp, "pre-save for %s failed, ret: '%d': ",
+                          vmsd->name, ret);
+        }
+    } else if (vmsd->pre_save) {
         ret = vmsd->pre_save(opaque);
         trace_vmstate_save_state_pre_save_res(vmsd->name, ret);
         if (ret) {
@@ -427,7 +451,9 @@ static int post_save_dispatch(const VMStateDescription *vmsd, void *opaque,
                               Error **errp)
 {
     int ret = 0;
-    if (vmsd->post_save) {
+    if (vmsd->post_save_errp) {
+        ret = vmsd->post_save_errp(opaque, errp);
+    } else if (vmsd->post_save) {
         ret = vmsd->post_save(opaque);
         error_setg(errp, "post-save for %s failed, ret: '%d'",
                    vmsd->name, ret);

-- 
2.50.0


