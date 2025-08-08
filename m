Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84DE5C87FD3
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Aug 2025 07:19:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukHNU-0005kn-5c; Fri, 08 Aug 2025 03:19:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ukHN0-0005Q0-SR
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 03:18:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ukHMx-0007ec-9j
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 03:18:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754637506;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f8etomzJDv74aPooKldxhhsipey+f0WbhDyhekbvx0g=;
 b=JoFzikBrv+BMFpBWFC/BEhysGWiwSKvwWqH0EJf8qrkxeaf1RVkRQgZPeHGRnQSBBvZzRb
 +qGEDpflrLqfJRD2dl+sJamd9/gSt8yQ3Lx+HwlfzjIfnwIPrbgO7iVLXHWXwwPhO6FPBr
 jTB8ADZub/AxTUpZw6xvnEKNsAA4Lx4=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-ioPqAN6rPVOnKwQHG1QGig-1; Fri, 08 Aug 2025 03:18:24 -0400
X-MC-Unique: ioPqAN6rPVOnKwQHG1QGig-1
X-Mimecast-MFC-AGG-ID: ioPqAN6rPVOnKwQHG1QGig_1754637504
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2425e41424cso23569665ad.1
 for <qemu-devel@nongnu.org>; Fri, 08 Aug 2025 00:18:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754637504; x=1755242304;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=f8etomzJDv74aPooKldxhhsipey+f0WbhDyhekbvx0g=;
 b=o1uf2BAvuCP0Y66ome5mP2v6pitseTElSlueAkTn+etc5NifTe/JQy9o0ptBtwfW65
 VS45JmajduB5yJQ7hn9CC2ZQIrpJgFHS1Tktuz60wMeQvSv9KLkg4i+RBeeYPNy4wsNH
 u9xrOySOL2chkmISsjt88rz1HlyuNfNBJn1FKXVKWkb12tQy8noPO4GvCHFtkrNKPPv5
 WtpKsUqoBwN/0lv/CRD6luBdnMDFetiBiCOfAgAS10LwvJu31v6BhWEqY7g1zx+Q/uRt
 /W/pKgGJ+f6D4Up/sq4fhKYi53Um9wbhQc+aweLQp0o+wzuGPwNqRhs0Bo/iK2WQm2lq
 NHBQ==
X-Gm-Message-State: AOJu0Yw+Umqi6OXi6GWZu2kg8XPXSceIPSnz2Bg1pE74290xw6nzA4y6
 rRnOs91tWF+y17ZkkOUEIdqJ0R8HLeVPUuU1lM6E9rtB2zp+y8ypLb9ZBUQKPg8iYDy6FWgFaq/
 EaDAvlhVkBvMYEGNlFK0O6td/MGUwkpkft0GNo9m14PQwMLavxAPf/aub
X-Gm-Gg: ASbGncsNBsnMdVMASCiZ6h/CkLu02r5uDMlKgUfWJ61cLVDU2u35wsG+HGaDZF1n77g
 0SmueqzkewXOsqPeqm+bTJKkJc/PieRpj+Di6FbOLUEOxYsbU3jUfEoMuquApqVaVE/COFQnOdk
 TJP3d70gLYh3tOC9hsBebpWLtWIPVB7msTKG41T/Pdc3PfLjolNnOtNEVXevYXiHz1pfLrCaWs2
 41GoYOLF/bPwVaudTFGhOsF3hENyuG2Am5c9gG2WB5Gqy8h0WIczHtmnr+sr2skf/m7zZBeWkzm
 XqDDVrg49zQjNq/EqByyNv12LSiI/yAx36bXpG1uX9HHgAyVRoVuWQ==
X-Received: by 2002:a17:902:f212:b0:23f:f707:f97e with SMTP id
 d9443c01a7336-242c2007364mr21604575ad.17.1754637503653; 
 Fri, 08 Aug 2025 00:18:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEyzpcc0M2rIiQ1ydsux6Curq+mzHrOFUV0FU9oP12FFgBUnKpal5oEYwy0OElv8Bh741iLwA==
X-Received: by 2002:a17:902:f212:b0:23f:f707:f97e with SMTP id
 d9443c01a7336-242c2007364mr21604095ad.17.1754637503190; 
 Fri, 08 Aug 2025 00:18:23 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.101.237])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-241e899d347sm199659385ad.140.2025.08.08.00.18.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Aug 2025 00:18:22 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Fri, 08 Aug 2025 12:43:51 +0530
Subject: [PATCH v10 25/27] migration: Rename post_save() to cleanup_save()
 and make it void
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250808-propagate_tpm_error-v10-25-3e81a1d419b2@redhat.com>
References: <20250808-propagate_tpm_error-v10-0-3e81a1d419b2@redhat.com>
In-Reply-To: <20250808-propagate_tpm_error-v10-0-3e81a1d419b2@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, 
 Eric Farman <farman@linux.ibm.com>, Thomas Huth <thuth@redhat.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Matthew Rosato <mjrosato@linux.ibm.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>, 
 Alex Williamson <alex.williamson@redhat.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Steve Sistare <steven.sistare@oracle.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, 
 Hailiang Zhang <zhanghailiang@xfusion.com>, 
 Stefan Berger <stefanb@linux.vnet.ibm.com>, 
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, 
 Arun Menon <armenon@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6394; i=armenon@redhat.com;
 h=from:subject:message-id; bh=4QJ5KiGWeQW+4m56rX5HJhHjSkDszitwwdaUAPTZaW0=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ8bUxdfcmg89PvZjPqtu5Z5l/088Cnou/ZBvgZyrv6V98
 u1vfCasHaUsDGJcDLJiiiwNXwNkmwIKIyJtX16HmcPKBDKEgYtTACZSs4CR4WKb1QT+Wy+eHq2f
 6P3AjWtdKVPsErGzAUf0OnUco+duNmX4Z2Zg/OvZAYmo7iVyvbN1/9x6/KNSKyT63qczLnfktJl
 jWQA=
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

The post_save() function call is responsible for cleaning up resources
after the device state has been saved.
Currently it is infallible, and does not return an error.

It is called regardless of whether there is a preceding error from
save or subsection save. That is, save and post_save() together are
considered to be an atomic logical operation.

It should not be confused as a counterpart of the post_load() function
because post_load() does some sanity checks and returns an error if it
fails. This commit, therefore, renames post_save() to cleanup_save()
and makes it a void function.

Signed-off-by: Arun Menon <armenon@redhat.com>
---
 docs/devel/migration/main.rst |  2 +-
 hw/ppc/spapr_pci.c            |  5 ++---
 include/migration/vmstate.h   |  2 +-
 migration/savevm.c            |  5 ++---
 migration/vmstate.c           | 12 ++++--------
 target/arm/machine.c          |  6 ++----
 6 files changed, 12 insertions(+), 20 deletions(-)

diff --git a/docs/devel/migration/main.rst b/docs/devel/migration/main.rst
index 6493c1d2bca48a2fa34d92f6c0979c215c56b8d5..a39fec2e21c26c4315c0cf13b105176d70679d4d 100644
--- a/docs/devel/migration/main.rst
+++ b/docs/devel/migration/main.rst
@@ -439,7 +439,7 @@ The functions to do that are inside a vmstate definition, and are called:
 
   This function is called before we save the state of one device.
 
-- ``int (*post_save)(void *opaque);``
+- ``void (*cleanup_save)(void *opaque);``
 
   This function is called after we save the state of one device
   (even upon failure, unless the call to pre_save returned an error).
diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index 1ac1185825e84ca908fd878f6cbe7e8cacac1d89..135265f075dff502af59fbc91babca1f9a26c54d 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -2118,14 +2118,13 @@ static int spapr_pci_pre_save(void *opaque)
     return 0;
 }
 
-static int spapr_pci_post_save(void *opaque)
+static void spapr_pci_cleanup_save(void *opaque)
 {
     SpaprPhbState *sphb = opaque;
 
     g_free(sphb->msi_devs);
     sphb->msi_devs = NULL;
     sphb->msi_devs_num = 0;
-    return 0;
 }
 
 static int spapr_pci_post_load(void *opaque, int version_id)
@@ -2152,7 +2151,7 @@ static const VMStateDescription vmstate_spapr_pci = {
     .version_id = 2,
     .minimum_version_id = 2,
     .pre_save = spapr_pci_pre_save,
-    .post_save = spapr_pci_post_save,
+    .cleanup_save = spapr_pci_cleanup_save,
     .post_load = spapr_pci_post_load,
     .fields = (const VMStateField[]) {
         VMSTATE_UINT64_EQUAL(buid, SpaprPhbState, NULL),
diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index 5fe9bbf39058d0cf97c1adab54cc516dbe8dc32a..c1d8e5b7a7d9d544fc8ce181372660f5538ef66b 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -208,7 +208,7 @@ struct VMStateDescription {
     int (*pre_load)(void *opaque);
     int (*post_load)(void *opaque, int version_id);
     int (*pre_save)(void *opaque);
-    int (*post_save)(void *opaque);
+    void (*cleanup_save)(void *opaque);
     bool (*needed)(void *opaque);
     bool (*dev_unplug_pending)(void *opaque);
 
diff --git a/migration/savevm.c b/migration/savevm.c
index 06cb9c465a24fd7f96bd36735feaeeddf268cc87..fabf948e74e471eb9f29ee10055c0041f399956e 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -322,14 +322,13 @@ static int configuration_pre_save(void *opaque)
     return 0;
 }
 
-static int configuration_post_save(void *opaque)
+static void configuration_cleanup_save(void *opaque)
 {
     SaveState *state = opaque;
 
     g_free(state->capabilities);
     state->capabilities = NULL;
     state->caps_count = 0;
-    return 0;
 }
 
 static int configuration_pre_load(void *opaque)
@@ -544,7 +543,7 @@ static const VMStateDescription vmstate_configuration = {
     .pre_load = configuration_pre_load,
     .post_load = configuration_post_load,
     .pre_save = configuration_pre_save,
-    .post_save = configuration_post_save,
+    .cleanup_save = configuration_cleanup_save,
     .fields = (const VMStateField[]) {
         VMSTATE_UINT32(len, SaveState),
         VMSTATE_VBUFFER_ALLOC_UINT32(name, SaveState, 0, NULL, len),
diff --git a/migration/vmstate.c b/migration/vmstate.c
index 4a6a33d5258cf271a0c58661b8a367eed2210601..fdb8c118721a11dd88d55eadb471a61788c3eee6 100644
--- a/migration/vmstate.c
+++ b/migration/vmstate.c
@@ -530,8 +530,8 @@ int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
                 if (ret) {
                     error_setg(errp, "Save of field %s/%s failed",
                                 vmsd->name, field->name);
-                    if (vmsd->post_save) {
-                        vmsd->post_save(opaque);
+                    if (vmsd->cleanup_save) {
+                        vmsd->cleanup_save(opaque);
                     }
                     return ret;
                 }
@@ -558,12 +558,8 @@ int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
 
     ret = vmstate_subsection_save(f, vmsd, opaque, vmdesc, errp);
 
-    if (vmsd->post_save) {
-        int ps_ret = vmsd->post_save(opaque);
-        if (!ret && ps_ret) {
-            ret = ps_ret;
-            error_setg(errp, "post-save failed: %s", vmsd->name);
-        }
+    if (vmsd->cleanup_save) {
+        vmsd->cleanup_save(opaque);
     }
     return ret;
 }
diff --git a/target/arm/machine.c b/target/arm/machine.c
index 6986915bee876402c1bd2efb92f41ca1298c66a3..d070114da15de85fd50af71e1d8caa84f25846d8 100644
--- a/target/arm/machine.c
+++ b/target/arm/machine.c
@@ -903,15 +903,13 @@ static int cpu_pre_save(void *opaque)
     return 0;
 }
 
-static int cpu_post_save(void *opaque)
+static void cpu_cleanup_save(void *opaque)
 {
     ARMCPU *cpu = opaque;
 
     if (!kvm_enabled()) {
         pmu_op_finish(&cpu->env);
     }
-
-    return 0;
 }
 
 static int cpu_pre_load(void *opaque)
@@ -1048,7 +1046,7 @@ const VMStateDescription vmstate_arm_cpu = {
     .version_id = 22,
     .minimum_version_id = 22,
     .pre_save = cpu_pre_save,
-    .post_save = cpu_post_save,
+    .cleanup_save = cpu_cleanup_save,
     .pre_load = cpu_pre_load,
     .post_load = cpu_post_load,
     .fields = (const VMStateField[]) {

-- 
2.50.1


