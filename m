Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04C2CC87FCC
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Jul 2025 14:25:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhUBq-0006Bi-0f; Thu, 31 Jul 2025 10:23:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1uhTH7-00070p-0e
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 09:24:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1uhTH2-0008U0-9g
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 09:24:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753968283;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SxT7t8v3VO+Rr1RL3SBMVQbsB5LGB39zeRYYNnq7mSo=;
 b=cA12R42zAQu9mLWKavgreKrS9OlK7mEiSLOAuMnpMwhiEqntsSeA67A6WB73WmqjWP08cZ
 lVZeXM8Tfrv60kvxqLqAlsQOEPT6C+RN0zH9z2gjR3mhKLZpFSz3GXzcyx0LCJEa5YGjh1
 CexLyJFp0qSva74vG+Ddzp2W5q+1g8w=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-gD5jlRgaM3alThOSS3CjCg-1; Thu, 31 Jul 2025 09:24:42 -0400
X-MC-Unique: gD5jlRgaM3alThOSS3CjCg-1
X-Mimecast-MFC-AGG-ID: gD5jlRgaM3alThOSS3CjCg_1753968281
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-31effad1358so936331a91.1
 for <qemu-devel@nongnu.org>; Thu, 31 Jul 2025 06:24:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753968278; x=1754573078;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SxT7t8v3VO+Rr1RL3SBMVQbsB5LGB39zeRYYNnq7mSo=;
 b=ixMph+v1oJFk9F3Otrj5xDLYG4fANjnXZQfgSPWk/8Q/T3p42LW1imSoR/rnixE9e5
 cLMiRso7Hq8NgQY9GvqwUCGLURVCqBKUnMYWaAz6u6Soe+gBW8kd8JOoDQd6ysFUaMLe
 UR3sR6Rbz+9j6jumD1+P6VctQp7ogHYv1azMd0mvIKMwTwQxnvLavUSn4EDArL5tGYnA
 m+9YonBhsHovXTJikOMVk5CrLTSyABrVXYH0/Wu/eZODjjJIDNZe4NCQOqrStofqLUCP
 lojmSy/Rum0NK+i7eZws+/BS1a+qCYpakSZjrDdla6ZK3+pF14/qNPV41q74F7CJwHWk
 /aDQ==
X-Gm-Message-State: AOJu0YwfCwzeFtyh9MIEwwAm13xaOU2nlSallGzcknEPE4ehRcYftxm6
 Issx8DTi58JQR/+LOSK/zLSnAGx+Nq1j2ymDRwBkEkeKC+e6eM/dUW1Aw6fb+8lIRq8zKM5r/1U
 Upd2tkadVbv4B7yJMdpQSrbXZfMC/SL/4RPAOmaEgm/IprrqjG/P7e0V+EYdRj9E3UbWpU1aGUv
 ijOn8f4X4cfYyZjX2rjH3xxq/Ct0DLlAxT6Tie9lBzng==
X-Gm-Gg: ASbGncsfsjxSRuJlSGDAsygddU2T2LOEd0f1gQ4EfCriORy4n7RQYhCX9l+egvZLv8P
 CIouS+r9lNWQ5Krat5psWVcYuLDoAfUUudil7T1W95oUmqmXhck61U9uWiJxrpJqURo2VjONn/6
 g1oZuxY1owqW75LX4/VV2x3mCoQtKt9EFmPIwzacioXHkL6zsX07mYip7XmVibgMU1jPFVl5oDQ
 SkzlXABD83JQ/C6sgEordOCdAfEjyyNG48xLzEAVsTN4BYQzlsGlhcrOtljPzPU1mRsXqIxhH7/
 HMaoaYjurqDw+i1NSfDkVvPSJ/dxfgkKB3l6Y8Gc5dHtEI5o1vQx
X-Received: by 2002:a17:90b:1b47:b0:31f:d0:95c4 with SMTP id
 98e67ed59e1d1-320da5b4016mr2791179a91.5.1753968277842; 
 Thu, 31 Jul 2025 06:24:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFQ6v8Df5t5D3siWuwGvdQky2ausTTtNgryjQzdFUXbZsSavq67Ooh7GbECHJGF4YyG2PxjJA==
X-Received: by 2002:a17:90b:1b47:b0:31f:d0:95c4 with SMTP id
 98e67ed59e1d1-320da5b4016mr2791087a91.5.1753968277207; 
 Thu, 31 Jul 2025 06:24:37 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.99.139])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3209a84d115sm2007034a91.36.2025.07.31.06.24.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Jul 2025 06:24:36 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Thu, 31 Jul 2025 18:50:57 +0530
Subject: [PATCH v8 17/27] migration: push Error **errp into
 loadvm_process_enable_colo()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250731-propagate_tpm_error-v8-17-28fd82fdfdb2@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5926; i=armenon@redhat.com;
 h=from:subject:message-id; bh=P5w2VFa5ILBTWE0/p7n8qWxh210KDW/+EmHaCXDgktA=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ0Z37rOTv+fNzWT3qzDjco/cecAxpspWUWRlVVBd0o4mV
 YszUXUdpSwMYlwMsmKKLA1fA2SbAgojIm1fXoeZw8oEMoSBi1MAJmJfxMhwj0V+U8eBpKdzBBTm
 nOZrMnD+teiDY63A4nsXb05Tf2vgw8hwVu9i+skAV3mP6/4lF++uVZ3f2xB2q1HK6N/6HJOZgvY
 cAA==
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
index 6a0dcc04f436524a37672c41c38f201f06773374..995431c9e320f443c385c29d664d62e18c1afd90 100644
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
index d095ea370464b7098ef37d0ad37c2fc595edf6ea..eeae34454117fa785a7514ed70b11bb712e37d6b 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2518,15 +2518,21 @@ static int loadvm_handle_recv_bitmap(MigrationIncomingState *mis,
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
@@ -2645,11 +2651,7 @@ static int loadvm_process_command(QEMUFile *f, Error **errp)
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
2.50.0


