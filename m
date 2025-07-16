Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C1A5C83F1B
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 10:54:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubzeH-0000u9-TY; Wed, 16 Jul 2025 06:46:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ubzdr-0000ZO-Mk
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 06:45:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ubzdp-0000ir-SD
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 06:45:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752662737;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UJUnk8SbHicXLpcNeizMsdmVmWoSkURxjXg/ZmoasiM=;
 b=KDdQa5Bj2aeI7fgFPiu9xm6NHkBMMTCKVD20wFl54mIeux0PxhHTmMYvqbxyXU0r2U++Xa
 xOtvixArovKc1wyv9S2Os49ao5rnF1bBs7GuCv03pnzPrXtbw8ZIIK2tA8IXg/W850BDDQ
 6a7IZtXJtV41qb4aF8McFiAisCkU/CY=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-375-L5XisO8KP8GVDdvXREQ26w-1; Wed, 16 Jul 2025 06:45:35 -0400
X-MC-Unique: L5XisO8KP8GVDdvXREQ26w-1
X-Mimecast-MFC-AGG-ID: L5XisO8KP8GVDdvXREQ26w_1752662735
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-235f77f86f6so62323455ad.2
 for <qemu-devel@nongnu.org>; Wed, 16 Jul 2025 03:45:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752662734; x=1753267534;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UJUnk8SbHicXLpcNeizMsdmVmWoSkURxjXg/ZmoasiM=;
 b=Nfyzlpb8xDNSvFlD+vXpXaIje09gCQA/P1sOFSsp82aFcyJ1e0pGEtwS69GGzEsQkz
 UlZKousGblzAVKeGZnNpiDAPmD8hmkhdSWzY8qJ+r7ptGUHE7G6nNbumu6kdhSkTsj6x
 1qGPTAkaa5HuywIJ/BtQp3Xnw4dfn4M6y7VMD7KP8tJ9hVdnhvELpH+t3IaDzerAqsAF
 s+80MAF44SbOshzrQtzZq6ZWxq00jwSFX/A2ITiw5UbtkG4GXDI/4PDF8BFu30hEclHO
 Lj1Y+wSub2NpkpU9L63gO3vhSXopcT3WR4/5m3GGCvubLTts/Z4YB0G3gauc5w3FWHSC
 jysw==
X-Gm-Message-State: AOJu0YxOLWJYxF366jSvfXoaJSSFBEX99jjIVBNGiWqY2GackhxPgXSz
 M/ZtVn9DSM3wLZuXB1XjarPnfdRmYXmVykkw1sREVbunCkfO6aOA7qSj/vu67FzQ/gkjPXMScBR
 dP3bOz/WrLGm3+qQqfK6tsTy1+L/zRPoJuL/xtmYcV01aLPDBZvUpCHkV
X-Gm-Gg: ASbGncs4JJXObCWyJkcp5ifyhdLYLMhGY9kKzQScVPTkQ7fxqnbcjUXwENFrClZmgv1
 n3MAMYFtWQHzJ5C7C6TdZ0baxYcvLXQj2bn5ek+8ays7QXjkM6nfTgN49jvtTuL22W2NQzVC7Bs
 LXmEoNONy516Upl2pdL/pFUJ2wkGCf91E8r0zEtyCpA/Ebaw8qwe/XfvHSuop1u6cT58lGVb+Ps
 ZchCEXrD0GZYKvErBvHo7ZCOMRJPwX0irY3dLpNegKZThR9Z403rk/A5j0bvqsko3+ruOMx/E+y
 UHAbePRwY9gVbUGAfyHIYdt06epfwD+1E7JCpIC53Eo8USxdkw==
X-Received: by 2002:a17:902:e885:b0:223:f9a4:3f99 with SMTP id
 d9443c01a7336-23e2572fbcemr35602555ad.29.1752662734502; 
 Wed, 16 Jul 2025 03:45:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHzqxEKzTLJ5nOW3U86NICBS4cmT5Jw0X68sv51D9sumBVQNFJUwKZUYrXaMlGgKfzosq8gGw==
X-Received: by 2002:a17:902:e885:b0:223:f9a4:3f99 with SMTP id
 d9443c01a7336-23e2572fbcemr35601975ad.29.1752662734054; 
 Wed, 16 Jul 2025 03:45:34 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.97.1])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23de435baccsm123363265ad.227.2025.07.16.03.45.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Jul 2025 03:45:33 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Wed, 16 Jul 2025 16:13:06 +0530
Subject: [PATCH v4 16/23] migration: push Error **errp into
 loadvm_process_enable_colo()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250716-propagate_tpm_error-v4-16-7141902077c0@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5924; i=armenon@redhat.com;
 h=from:subject:message-id; bh=BZ6FKJqahQF1gd7Pro769BmCrdc2KF3bTnabdXOwHRE=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ0Z5k4PvlfigI9vPySwKKJ+jaPtx4jkFtas+H4wzqtedT
 d0jm7S7o5SFQYyLQVZMkaXha4BsU0BhRKTty+swc1iZQIYwcHEKwESSixl+MsqdcPG/vuyxjnjb
 Fm2hr0XcLMs1d2/R+JfFyHhqXcaRI4wMj10mhtZILfz0n1/H8XeF9tRp8/dsnatr21Mfz7RBqSi
 PAwA=
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
 migration/savevm.c       | 25 ++++++++++++-------------
 5 files changed, 24 insertions(+), 25 deletions(-)

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
index 10c216d25dec01f206eacad2edd24d21f00e614c..326487882c8d41e2f89f99f69df0d9d4d42705e4 100644
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
index 6f42ae111fd9c98c9b85e9b292caad737db0706d..a4add82ca0f654bfe7252ae33fe80276f8ee5ffd 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2510,15 +2510,19 @@ static int loadvm_handle_recv_bitmap(MigrationIncomingState *mis,
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
+    if (migration_incoming_enable_colo(errp) < 0) {
+        return -1;
+    }
+
+    ret = colo_init_ram_cache(errp);
+    if (ret) {
+        error_prepend(errp, "failed to init colo RAM cache: %d", ret);
+        migration_incoming_disable_colo();
     }
     return ret;
 }
@@ -2643,12 +2647,7 @@ static int loadvm_process_command(QEMUFile *f, Error **errp)
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


