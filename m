Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E681CA0EEB
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Aug 2025 08:54:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1up0zV-0002eU-No; Thu, 21 Aug 2025 04:49:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1up0yB-0007vs-Se
 for qemu-devel@nongnu.org; Thu, 21 Aug 2025 04:48:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1up0y8-0001fb-3f
 for qemu-devel@nongnu.org; Thu, 21 Aug 2025 04:48:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755766102;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/0oIGaP1ASs1AgG/cQMl9sVBAN+AzsXQ1x5zKIdL8Tc=;
 b=ZnmZSWR5tvMx1z1GTYUr4NFSktRMNykrpFonTKGYOoNIM8qzWBuZdseqqDXC9bkAA94eoU
 JIknB4+O2PGC7Id0abitdN4LisKfy/8ozuf8BaKDNRyK45KTpuIjvZXcxlIDSmnYrSTzrl
 cQm3+PSHDZQsq+yu+ZaPZ5eAR4AmaJo=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-375-lm2l31MiPS2XbSqxIDte5Q-1; Thu, 21 Aug 2025 04:48:20 -0400
X-MC-Unique: lm2l31MiPS2XbSqxIDte5Q-1
X-Mimecast-MFC-AGG-ID: lm2l31MiPS2XbSqxIDte5Q_1755766099
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-b47538030bfso684217a12.1
 for <qemu-devel@nongnu.org>; Thu, 21 Aug 2025 01:48:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755766099; x=1756370899;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/0oIGaP1ASs1AgG/cQMl9sVBAN+AzsXQ1x5zKIdL8Tc=;
 b=KAMQfp9BtOxWForouBaj8HJiyRZQLZKjXCGyb+0ctZLrDl8yA5SKN+jpvmrQWBvo31
 pxVWloMMlR3E4785fePb4FqIUAIZNHzZjOAk+xUMXhR0uhKnnEmhM2hVQRpH3D641sHF
 M3UOsk29LLnph6xvo07Iwjrj5+DRbcSx5bIRHptV2RU2QRv8WRLRjVCP9yIedkVgXJfD
 4t4buuoVsgiLhf/UKyrHgoGH21Ew12h27pzUihtm+EF1VG4HpHIXWouaSKx0aH5cAWr/
 BoRmSSigGn/qXv/axb1BY4e6x0cG1dCsesP2fczgDGwa7YhbCnG5s8sNf56a/jdotUks
 J30Q==
X-Gm-Message-State: AOJu0YyA1voAjou9CixHt9AMS7Uhz9h61RBRDMLT+a5AVr5oZLIMJl7X
 Hhc4LR6eLsC7/NrJ1oHR2Hp2oKrwodXmyTQ2riAdwubzkEloe1uBcSMOlPmvrEUDSUdBcltZ654
 EHUh5j+U0KtXcb9ZWf9LPvQg0Z8DGezAZnHp/c2CacIUcSpGBnFgcTRH0
X-Gm-Gg: ASbGncuy2MY+bYw4cKsGhRJaM9xfLNeEXgZYJ8CyA1Neid93TZyuitpVZ0hBkxk8an7
 WkVEgVBqOMezOhS15Q9H8BKx3o1majrsWR1NO4pOXYPfts5uoWv6DxJmKfuqhfwfFe8vjrjF1kW
 cCPmjEVH1OEKIEPGUcGpX+WDffV1y+iiynCeVCKYav/IsnnKp2MsbLpTMZgMjGq+MY6RDw/cm11
 55HZlmuuBjtfHfmr9wOLSYGLeM93+OCAnDk4wN51GlOsQPxtbl/0fti/mpsFJ6/zxTITE90xAxX
 ZLd5i2a4GTYSOC5Gwfuyk4/fd5InX1cn5/vkn6AxGeEyGF4PAH/4
X-Received: by 2002:a17:903:2311:b0:240:2774:8372 with SMTP id
 d9443c01a7336-245fed8920dmr28109525ad.36.1755766099276; 
 Thu, 21 Aug 2025 01:48:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG6xmT8PUGROrrouRVSwEp1ItuadPvhzG8eiTlcsnWFXn+eakES9v6o1wDmRIybzbGWt1h4Bw==
X-Received: by 2002:a17:903:2311:b0:240:2774:8372 with SMTP id
 d9443c01a7336-245fed8920dmr28108935ad.36.1755766098860; 
 Thu, 21 Aug 2025 01:48:18 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.47.192.65])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-245ed33e05dsm48789985ad.3.2025.08.21.01.48.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Aug 2025 01:48:18 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Thu, 21 Aug 2025 14:14:15 +0530
Subject: [PATCH v12 21/27] migration: push Error **errp into
 loadvm_process_enable_colo()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250821-propagate_tpm_error-v12-21-72b803e707dc@redhat.com>
References: <20250821-propagate_tpm_error-v12-0-72b803e707dc@redhat.com>
In-Reply-To: <20250821-propagate_tpm_error-v12-0-72b803e707dc@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6000; i=armenon@redhat.com;
 h=from:subject:message-id; bh=q/Yf6rJSvtWhEDbKnbUT85eZp80+CMp8o8AGNsv0UBE=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ8ayOylPpokkS9/JeCxkXWR78cccsfjmdBO5zvCZxrXvv
 gq/ev6zo5SFQYyLQVZMkaXha4BsU0BhRKTty+swc1iZQIYwcHEKwETepDH8M5zN51p2cFbdFsOa
 pp1hx3kWin+eP6XQ4uW11c0PQjdEmjL8lZGNK7DqclH8bCp/s2Ly0rdbcj9EnO7r/97YuWtzecd
 HfgA=
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

This is an incremental step in converting vmstate loading
code to report error via Error objects instead of directly
printing it to console/monitor.
It is ensured that loadvm_process_enable_colo() must report an error
in errp, in case of failure.

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Arun Menon <armenon@redhat.com>
---
 include/migration/colo.h |  2 +-
 migration/migration.c    | 12 ++++++------
 migration/ram.c          |  8 ++++----
 migration/ram.h          |  2 +-
 migration/savevm.c       | 26 ++++++++++++++------------
 5 files changed, 26 insertions(+), 24 deletions(-)

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
index 35f769bc55c235134abb5554ed01b94787d4bf78..39d6142abccf90c3a35e6c2df3df245052eb0bcf 100644
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
index 163265a57f26fb1dc88d9797629d58c278e9afb7..a8e8d2cc6790336625de626fee070ecc51327200 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -3578,7 +3578,7 @@ static void colo_init_ram_state(void)
  *
  * Returns zero to indicate success or -1 on error.
  */
-int colo_init_ram_cache(void)
+int colo_init_ram_cache(Error **errp)
 {
     RAMBlock *block;
 
@@ -3587,9 +3587,9 @@ int colo_init_ram_cache(void)
             block->colo_cache = qemu_anon_ram_alloc(block->used_length,
                                                     NULL, false, false);
             if (!block->colo_cache) {
-                error_report("%s: Can't alloc memory for COLO cache of block %s,"
-                             "size 0x" RAM_ADDR_FMT, __func__, block->idstr,
-                             block->used_length);
+                error_setg(errp, "Can't alloc memory for COLO cache of "
+                           "block %s, size 0x" RAM_ADDR_FMT,
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
index 359264cb639605a3f63a2b022c57afd511c47a05..3a1aa25dd86226fc9770d0dbaba51ee673f8f663 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2515,15 +2515,21 @@ static int loadvm_handle_recv_bitmap(MigrationIncomingState *mis,
     return 0;
 }
 
-static int loadvm_process_enable_colo(MigrationIncomingState *mis)
+static int loadvm_process_enable_colo(MigrationIncomingState *mis,
+                                      Error **errp)
 {
-    int ret = migration_incoming_enable_colo();
+    ERRP_GUARD();
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
+        error_prepend(errp, "failed to init colo RAM cache: %d: ", ret);
+        migration_incoming_disable_colo();
     }
     return ret;
 }
@@ -2646,11 +2652,7 @@ static int loadvm_process_command(QEMUFile *f, Error **errp)
         return loadvm_handle_recv_bitmap(mis, len, errp);
 
     case MIG_CMD_ENABLE_COLO:
-        ret = loadvm_process_enable_colo(mis);
-        if (ret < 0) {
-            error_setg(errp, "Failed to load device state command: %d", ret);
-        }
-        return ret;
+        return loadvm_process_enable_colo(mis, errp);
 
     case MIG_CMD_SWITCHOVER_START:
         ret = loadvm_postcopy_handle_switchover_start();

-- 
2.50.1


