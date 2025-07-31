Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FA7EC87FCA
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Jul 2025 14:27:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhUDf-00057l-VM; Thu, 31 Jul 2025 10:25:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1uhTI6-00031t-Ps
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 09:25:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1uhTI3-0000Rc-Hf
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 09:25:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753968345;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2OrRpnTKSAzXf76/A6MXcginXwGhQ0toXTEhBlZCIns=;
 b=I9znyoVqXIrx33WyzFizVxGoN21d7QNEmp6B/UmXGgaJxhekmhAX0GvlodpNohngtN2adI
 3DeG/V5Vi6voTjYlftdj3Kryh3zGD6qyn2KKQc2zDXclmW1mPwNOXyfv/cvxoT/m3EdM55
 /YEWVBHAorjKR3nY+NFkekauX0/I7Hw=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-599-HIBBmfgRMIW1QGmaMtZpkg-1; Thu, 31 Jul 2025 09:25:44 -0400
X-MC-Unique: HIBBmfgRMIW1QGmaMtZpkg-1
X-Mimecast-MFC-AGG-ID: HIBBmfgRMIW1QGmaMtZpkg_1753968344
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-31f65d519d3so726033a91.2
 for <qemu-devel@nongnu.org>; Thu, 31 Jul 2025 06:25:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753968343; x=1754573143;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2OrRpnTKSAzXf76/A6MXcginXwGhQ0toXTEhBlZCIns=;
 b=aa0skoeR5eplOKtyyJ4SnP6M8unP/Si3Vpsqzesaw3lElMCiTlIvUbE0QkZkaI8KFA
 9uEXsxu/qCoKmLGNyEuUFjOkoguSpUMceQZt96E6o3ZHQskg3gj1LSNF0zgyjtZFFVWD
 oPZs3UefvhxdOIUcH5G5KCYlBb8dltZgVXHrUJn0kiaoaoU6w8sm6iml09yQODpWzpWG
 3e1H6UTUrrnzLj8V+uGVYKz16O4X1Z4RZSfQ/KBhDZ4/Ugdy2O6+452QI+UEeBgpNZH2
 6PPqOM3ujS3QLIO3YpcMEPqIP3jurf1wGwSf0WHtXbqUb7BCiuwnT+VsseZ0Th0fA51j
 bccQ==
X-Gm-Message-State: AOJu0YyzxLWbvoygTp0Jr+nLV9LEeo1lhxHynuXp1P3zsVHlH5SMGREJ
 HbFSKKoIkC9v7jSMJ1qokukE0Sq4DRUH9xxJgYAVTDJjZFuWAMZFTu4eMJ94eYqYmbpvbuHKEgh
 WjvnC77XA8idv4DZCgyld+FXb4OIy/oYHWo90wddQc1GkRMj6mUA+62muZMmrApjA/ilewcVGdY
 Uc8C+NJz8JJJ3NY7XHrkeGY5R2Vt6Ff1GY3f+UnEq+Lw==
X-Gm-Gg: ASbGncvtKftzFHP3AWypMyVjZwlBw6iZ9itKxLVrRNW5KHngDXAz6GlMi+jJk1TrUdY
 8jf8oofb7IrSQkR88/UNADfpN+dUaiasUit6kKFuD9l3kGqTv9knzvcBBWNRw8dJTCr7lftS2p6
 MIOSmwwHq2bzViphaiQ9ZZrERnFnLax4m+IEwDG/eM04w7Vk89VMmFV18dogQuRiP2K6G76nkxt
 DqsL8mDoV/NeYmrpKcH9jCOpZwDnirZD7+VnAf5yizWtZVCHXzS/fOVtLrhxZppER66ikMP6qLE
 Ig/dM7+jrCLW02uLZMciU49tBFckqqvVk30Qharbtvcks1yn7Vme
X-Received: by 2002:a17:90b:2b4c:b0:312:e9d:3ffa with SMTP id
 98e67ed59e1d1-31f5de95105mr9782283a91.31.1753968343159; 
 Thu, 31 Jul 2025 06:25:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEyjxGDiHFSfuB+nPBAd3w21H/IaYZYPlJ/7woa/uq8nbwIo3cP+cY/SCIwIVcr33aD6nd+pA==
X-Received: by 2002:a17:90b:2b4c:b0:312:e9d:3ffa with SMTP id
 98e67ed59e1d1-31f5de95105mr9782213a91.31.1753968342644; 
 Thu, 31 Jul 2025 06:25:42 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.99.139])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3209a84d115sm2007034a91.36.2025.07.31.06.25.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Jul 2025 06:25:42 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Thu, 31 Jul 2025 18:51:04 +0530
Subject: [PATCH v8 24/27] migration: Refactor vmstate_save_state_v() function
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250731-propagate_tpm_error-v8-24-28fd82fdfdb2@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5112; i=armenon@redhat.com;
 h=from:subject:message-id; bh=jVkG3CMlD4VGW1wmUquk34ldSco5mD63TT/CrbF8g5g=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ0Z37vM1Oebvzt33dprEq7qx300scwvHFbOT3zXFVNawy
 4owpR3qKGVhEONikBVTZGn4GiDbFFAYEWn78jrMHFYmkCEMXJwCMBGefkaGhX+PeR5k3yFTZ1/E
 wbE9IKFRbcbUsyXigYK77CyEXzi/ZGRYl5O3Zl3KepWJMrIyh21s7LJO2Nv+W7pxrugmzfDsrCo
 2AA==
X-Developer-Key: i=armenon@redhat.com; a=openpgp;
 fpr=80F5501D82507158593DE9D76A7A2538D90F328E
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

The original vmstate_save_state_v() function combined multiple
responsibilities like calling pre-save hooks, saving the state of
the device, handling subsection saves and invoking post-save hooks.
This led to a lengthy and less readable function.

To address this, introduce wrapper functions for pre-save,
post-save and the device-state save functionalities.

Signed-off-by: Arun Menon <armenon@redhat.com>
---
 migration/vmstate.c | 89 ++++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 64 insertions(+), 25 deletions(-)

diff --git a/migration/vmstate.c b/migration/vmstate.c
index 25a819da069b982d4043f287b4562ea402d9eb0e..cec1ee2f30d6f0270ee1fd30d29f6f0f5d20bdb0 100644
--- a/migration/vmstate.c
+++ b/migration/vmstate.c
@@ -414,23 +414,43 @@ int vmstate_save_state_with_err(QEMUFile *f, const VMStateDescription *vmsd,
     return vmstate_save_state_v(f, vmsd, opaque, vmdesc_id, vmsd->version_id, errp);
 }
 
-int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
-                         void *opaque, JSONWriter *vmdesc, int version_id, Error **errp)
+static int pre_save_dispatch(const VMStateDescription *vmsd, void *opaque,
+                             Error **errp)
 {
     int ret = 0;
-    int ps_ret = 0;
-    const VMStateField *field = vmsd->fields;
-
-    trace_vmstate_save_state_top(vmsd->name);
-
     if (vmsd->pre_save) {
         ret = vmsd->pre_save(opaque);
         trace_vmstate_save_state_pre_save_res(vmsd->name, ret);
         if (ret) {
-            error_setg(errp, "pre-save failed: %s", vmsd->name);
-            return ret;
+            error_setg(errp, "pre-save for %s failed, ret: '%d'",
+                       vmsd->name, ret);
         }
     }
+    return ret;
+}
+
+static int post_save_dispatch(const VMStateDescription *vmsd, void *opaque,
+                              Error **errp)
+{
+    int ret = 0;
+    if (vmsd->post_save) {
+        ret = vmsd->post_save(opaque);
+        error_setg(errp, "post-save for %s failed, ret: '%d'",
+                   vmsd->name, ret);
+    }
+    return ret;
+}
+
+static int vmstate_save_dispatch(QEMUFile *f,
+                                 const VMStateDescription *vmsd,
+                                 void *opaque, JSONWriter *vmdesc,
+                                 int version_id, Error **errp)
+{
+    ERRP_GUARD();
+    int ret = 0;
+    int ps_ret = 0;
+    Error *local_err = NULL;
+    const VMStateField *field = vmsd->fields;
 
     if (vmdesc) {
         json_writer_str(vmdesc, "vmsd_name", vmsd->name);
@@ -533,15 +553,11 @@ int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
                 if (ret) {
                     error_setg(errp, "Save of field %s/%s failed",
                                 vmsd->name, field->name);
-                    if (vmsd->post_save) {
-                        ps_ret = vmsd->post_save(opaque);
-                        if (ps_ret) {
-                            ret = ps_ret;
-                            error_free_or_abort(errp);
-                            error_setg(errp,
-                                       "post-save for %s failed, ret: '%d'",
-                                       vmsd->name, ret);
-                        }
+                    ps_ret = post_save_dispatch(vmsd, opaque, &local_err);
+                    if (ps_ret) {
+                        ret = ps_ret;
+                        error_free_or_abort(errp);
+                        error_propagate(errp, local_err);
                     }
                     return ret;
                 }
@@ -565,17 +581,40 @@ int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
     if (vmdesc) {
         json_writer_end_array(vmdesc);
     }
+    return ret;
+}
 
-    ret = vmstate_subsection_save(f, vmsd, opaque, vmdesc, errp);
 
-    if (vmsd->post_save) {
-        ps_ret = vmsd->post_save(opaque);
-        if (ps_ret) {
-            ret = ps_ret;
+int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
+                         void *opaque, JSONWriter *vmdesc, int version_id,
+                         Error **errp)
+{
+    ERRP_GUARD();
+    int ret = 0;
+    Error *local_err = NULL;
+    int ps_ret = 0;
+
+    trace_vmstate_save_state_top(vmsd->name);
+
+    ret = pre_save_dispatch(vmsd, opaque, errp);
+    if (ret) {
+        return ret;
+    }
+
+    ret = vmstate_save_dispatch(f, vmsd, opaque, vmdesc,
+                                version_id, errp);
+    if (ret) {
+        return ret;
+    }
+
+    ret = vmstate_subsection_save(f, vmsd, opaque, vmdesc, errp);
+    ps_ret = post_save_dispatch(vmsd, opaque, &local_err);
+    if (ps_ret) {
+        if (ret) {
             error_free_or_abort(errp);
-            error_setg(errp, "post-save for %s failed, ret: '%d'",
-                       vmsd->name, ret);
         }
+        ret = ps_ret;
+        error_propagate(errp, local_err);
     }
     return ret;
 }

-- 
2.50.0


