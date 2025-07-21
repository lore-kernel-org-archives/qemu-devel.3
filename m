Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8635C83F25
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 11:38:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udond-0002KA-Tq; Mon, 21 Jul 2025 07:35:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1udokb-0002Li-B4
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 07:32:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1udokU-00017d-GB
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 07:32:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753097521;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WWnnOOZssAqy+ZivYvKk/9N+LTPqGJXTfjoJczUreUg=;
 b=h51mWyLCxFXBSS/5rsBYv69onpMYZ5SdgOtPuCvVD27sdYcf3mWjHtVHzgx9xCu+aM/PYg
 GO0p4WLG+gf478AveYiwmgMjuYhitbwjGGYki2nDHCItjS1QcuFAZ059zfZUK4xWuv8JS6
 /CS4eRMXhArOMPVUmw8TOmCYA1TTHg0=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-426-utNHxxTFNl2a_BRKq3OtLA-1; Mon, 21 Jul 2025 07:32:00 -0400
X-MC-Unique: utNHxxTFNl2a_BRKq3OtLA-1
X-Mimecast-MFC-AGG-ID: utNHxxTFNl2a_BRKq3OtLA_1753097519
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-235f77f86f6so40697175ad.2
 for <qemu-devel@nongnu.org>; Mon, 21 Jul 2025 04:31:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753097517; x=1753702317;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WWnnOOZssAqy+ZivYvKk/9N+LTPqGJXTfjoJczUreUg=;
 b=J1mI22HjPwd0zzqtAmtu4AVovnCu3qhqSdiW/11+qYFAP04/v+RIkKmrvYlHaSZNAM
 7UvwB751YVxbS43bTDgVqBDizGIOBkQfEneg7tGY0Vun3ftHb3Dmvve/jw5iIiPDnQwb
 /X/uvv6hJDSf1UarMI0IfXhKgLtg8Q79hd77pzezpbJZ92gcpUVQlm5dJgSt4+vl/iSG
 ywmqjKtM3xcRXOLb5PXXaBLioOXzFzeuru9UP0d65YKExSTA3uD61F/VoBvwLzxsejux
 eZ/xYEujScF/fy4ZqRd3gxSb7AYQxz3yadxHShpVS13ubSuyyheFhrO+u1AK5MwMgV16
 EH9g==
X-Gm-Message-State: AOJu0YztnACh66WmlHW+f9wGla03XZM1Y7wZM88jT3dGkgDrhEebqZpc
 QrzxPcOHQRzoeC1nbDA+99a3lpTgpX3rAt3chBQO2y+L2WW/qfVOgaxS8MtKOepUq3qzmjKqxc7
 +DC2it4zCF/QNgfAxbzmHxU9PkFeHJE9NyBQ06I4vlS7f8+eM7notpeOi
X-Gm-Gg: ASbGncsKv9Xqw/QC1gKmB8jJN++i6PUeAHjWqFzJuCiA6fqVcLG2b/gHpdUbmkqk7vX
 Y0fXs932FF6VNnhb4NVs+7DA2V0FNCg9OYMsgZsZSdAqSq+03bTbMYzLAvhPmQwuhC+SsTTMogU
 UQN4xplbTVMXSd/3q6R5iI12FhXW8YRXoCBXOCQDGH2IinE09v9Io0KfGljhxz37vCFRvJoOpO3
 0EMLYfTfqBUl+9U5qIo5j3dboyOaK3eVS8pA0lf3R4PPs83d6pmD+5Z4KcFf3pxjmEPP8E7hzBQ
 rwqeDpzl8i0t7kCVKS0oNyYSGeA+jPn/9XG87uxIX97X70byYCtF
X-Received: by 2002:a17:902:e547:b0:235:eb71:a37b with SMTP id
 d9443c01a7336-23e25776833mr358039255ad.46.1753097516750; 
 Mon, 21 Jul 2025 04:31:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGqgn34/n2Ilewer2uwVwTMw2zmRzex15pb1m/5YHCQxBHtm9Do0gvIOGCyR+OazLF0VjavoA==
X-Received: by 2002:a17:902:e547:b0:235:eb71:a37b with SMTP id
 d9443c01a7336-23e25776833mr358038605ad.46.1753097516287; 
 Mon, 21 Jul 2025 04:31:56 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.101.21])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23e3b5e3c89sm56150465ad.18.2025.07.21.04.31.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Jul 2025 04:31:55 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Mon, 21 Jul 2025 16:59:22 +0530
Subject: [PATCH v6 17/24] migration: push Error **errp into
 loadvm_process_enable_colo()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250721-propagate_tpm_error-v6-17-fef740e15e17@redhat.com>
References: <20250721-propagate_tpm_error-v6-0-fef740e15e17@redhat.com>
In-Reply-To: <20250721-propagate_tpm_error-v6-0-fef740e15e17@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5943; i=armenon@redhat.com;
 h=from:subject:message-id; bh=Ms0bgiemTO9y3dtp+EfTX+VE/wxDPLWcxN1XKLTV/Vk=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ0adyqRfFsenbVzjlSGx8OYHk4WzHA6v9T26/ePEMD+3r
 beL5+b5dJSyMIhxMciKKbI0fA2QbQoojIi0fXkdZg4rE8gQBi5OAZhIczfD/1R+r3q2u9u2LVT4
 wLLvHJNv2crgOVoR6hOYX2w62bG0ip/hv+8JW+2OT3rZdnq86XovN6SIPz1pxSiQaXTjD2/nOSc
 nVgA=
X-Developer-Key: i=armenon@redhat.com; a=openpgp;
 fpr=80F5501D82507158593DE9D76A7A2538D90F328E
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.926,
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

This is an incremental step in converting vmstate loading
code to report error via Error objects instead of directly
printing it to console/monitor.
It is ensured that loadvm_process_enable_colo() must report an error
in errp, in case of failure.

Signed-off-by: Arun Menon <armenon@redhat.com>
---
 include/migration/colo.h |  2 +-
 migration/migration.c    | 12 ++++++------
 migration/ram.c          |  8 ++++----
 migration/ram.h          |  2 +-
 migration/savevm.c       | 26 +++++++++++++-------------
 5 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/include/migration/colo.h b/include/migration/colo.h
index 43222ef5ae6adc3f7d8aa6a48bef79af33d09208..d4fe422e4d335d3bef4f860f56400fcd73287a0e 100644
--- a/include/migration/colo.h
+++ b/include/migration/colo.h
@@ -25,7 +25,7 @@ void migrate_start_colo_process(MigrationState *s);
 bool migration_in_colo_state(void);
 
 /* loadvm */
-int migration_incoming_enable_colo(void);
+int migration_incoming_enable_colo(Error **errp);
 void migration_incoming_disable_colo(void);
 bool migration_incoming_colo_enabled(void);
 bool migration_incoming_in_colo_state(void);
diff --git a/migration/migration.c b/migration/migration.c
index b3bccaeaee806abd01595863f6475057049b0688..d748a02712dc4ebc2de6b0488fb199c92c4d4079 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -623,22 +623,22 @@ void migration_incoming_disable_colo(void)
     migration_colo_enabled = false;
 }
 
-int migration_incoming_enable_colo(void)
+int migration_incoming_enable_colo(Error **errp)
 {
 #ifndef CONFIG_REPLICATION
-    error_report("ENABLE_COLO command come in migration stream, but the "
-                 "replication module is not built in");
+    error_setg(errp, "ENABLE_COLO command come in migration stream, but the "
+               "replication module is not built in");
     return -ENOTSUP;
 #endif
 
     if (!migrate_colo()) {
-        error_report("ENABLE_COLO command come in migration stream, but x-colo "
-                     "capability is not set");
+        error_setg(errp, "ENABLE_COLO command come in migration stream"
+                   ", but x-colo capability is not set");
         return -EINVAL;
     }
 
     if (ram_block_discard_disable(true)) {
-        error_report("COLO: cannot disable RAM discard");
+        error_setg(errp, "COLO: cannot disable RAM discard");
         return -EBUSY;
     }
     migration_colo_enabled = true;
diff --git a/migration/ram.c b/migration/ram.c
index 8223183132dc0f558f45fbae3f4f832845730bd3..607c979cc15a3d321e5e3e380ac7613d80d86fc9 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -3576,7 +3576,7 @@ static void colo_init_ram_state(void)
  * memory of the secondary VM, it is need to hold the global lock
  * to call this helper.
  */
-int colo_init_ram_cache(void)
+int colo_init_ram_cache(Error **errp)
 {
     RAMBlock *block;
 
@@ -3585,9 +3585,9 @@ int colo_init_ram_cache(void)
             block->colo_cache = qemu_anon_ram_alloc(block->used_length,
                                                     NULL, false, false);
             if (!block->colo_cache) {
-                error_report("%s: Can't alloc memory for COLO cache of block %s,"
-                             "size 0x" RAM_ADDR_FMT, __func__, block->idstr,
-                             block->used_length);
+                error_setg(errp, "%s: Can't alloc memory for COLO cache of "
+                           "block %s, size 0x" RAM_ADDR_FMT, __func__,
+                           block->idstr, block->used_length);
                 RAMBLOCK_FOREACH_NOT_IGNORED(block) {
                     if (block->colo_cache) {
                         qemu_anon_ram_free(block->colo_cache, block->used_length);
diff --git a/migration/ram.h b/migration/ram.h
index 275709a99187f9429ccb4111e05281ec268ba0db..24cd0bf585762cfa1e86834dc03c6baeea2f0627 100644
--- a/migration/ram.h
+++ b/migration/ram.h
@@ -109,7 +109,7 @@ void ramblock_set_file_bmap_atomic(RAMBlock *block, ram_addr_t offset,
                                    bool set);
 
 /* ram cache */
-int colo_init_ram_cache(void);
+int colo_init_ram_cache(Error **errp);
 void colo_flush_ram_cache(void);
 void colo_release_ram_cache(void);
 void colo_incoming_start_dirty_log(void);
diff --git a/migration/savevm.c b/migration/savevm.c
index 011f4032d582e64b112313e783e0cbf98822292d..49eb629a8dcd909274e78ecb2f31eb10f57c5425 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2516,15 +2516,20 @@ static int loadvm_handle_recv_bitmap(MigrationIncomingState *mis,
     return 0;
 }
 
-static int loadvm_process_enable_colo(MigrationIncomingState *mis)
+static int loadvm_process_enable_colo(MigrationIncomingState *mis,
+                                      Error **errp)
 {
-    int ret = migration_incoming_enable_colo();
+    int ret;
 
-    if (!ret) {
-        ret = colo_init_ram_cache();
-        if (ret) {
-            migration_incoming_disable_colo();
-        }
+    ret = migration_incoming_enable_colo(errp);
+    if (ret < 0) {
+        return ret;
+    }
+
+    ret = colo_init_ram_cache(errp);
+    if (ret) {
+        error_prepend(errp, "failed to init colo RAM cache: %d", ret);
+        migration_incoming_disable_colo();
     }
     return ret;
 }
@@ -2643,12 +2648,7 @@ static int loadvm_process_command(QEMUFile *f, Error **errp)
         return loadvm_handle_recv_bitmap(mis, len, errp);
 
     case MIG_CMD_ENABLE_COLO:
-        ret = loadvm_process_enable_colo(mis);
-        if (ret < 0) {
-            error_setg(errp, "Failed to load device state command: %d", ret);
-            return -1;
-        }
-        return ret;
+        return loadvm_process_enable_colo(mis, errp);
 
     case MIG_CMD_SWITCHOVER_START:
         ret = loadvm_postcopy_handle_switchover_start();

-- 
2.50.0


