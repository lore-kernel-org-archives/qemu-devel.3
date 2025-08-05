Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25E11C87FCB
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Aug 2025 18:37:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujMWQ-0007eZ-5E; Tue, 05 Aug 2025 14:36:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ujMVI-0002SN-3p
 for qemu-devel@nongnu.org; Tue, 05 Aug 2025 14:35:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ujMR9-0004bM-Lx
 for qemu-devel@nongnu.org; Tue, 05 Aug 2025 14:31:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754418658;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sLDCA+3nlUvyWOgTSOhD9LnMqaRWdX9vmvBFGNCzBWs=;
 b=QLEIghNxv7/sd5nN7pHsVfSLN4FneojQiLjjzXn17gNTN2bcGRrbI0Dheq4RivOLH2An96
 j4HXKpcwDha7cbhC0dssh4VwIMGpg9apUgkfydlHoVZGC5s5t9v5xsND0cfVDU1FtV43iU
 6FgZigUgwObp1h8ieITBcwwU79J5Ao4=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-440-AUJiIvgQMx21BxQUdOPYKw-1; Tue, 05 Aug 2025 14:30:55 -0400
X-MC-Unique: AUJiIvgQMx21BxQUdOPYKw-1
X-Mimecast-MFC-AGG-ID: AUJiIvgQMx21BxQUdOPYKw_1754418654
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-240908dd108so1237015ad.0
 for <qemu-devel@nongnu.org>; Tue, 05 Aug 2025 11:30:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754418654; x=1755023454;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sLDCA+3nlUvyWOgTSOhD9LnMqaRWdX9vmvBFGNCzBWs=;
 b=n7ERX1oqNYfPYPdWsqaVo3gH51sj2QAXuVt363n8HgWBFfv2DTCT8GT0r6k2bMF18+
 utgLEnar3c1PHDSl0r4opejoHnlpnHh4AKSmueLIxKVJQx5nVeYQ43MnThKrOx3Kdy8m
 x0jUxKG8dyhg7qzvBC3rzFC7bufnnV1/HAYznYn5DLue5NkKCDRYTUKiOO72RAiEmMos
 a9tt6LeC5zcvEXVynxzmDIylqt+nB+UDd/fUm3qahLof8Azgd01kJXLXJp1T6YHkLeYJ
 BQAQcbxn7qXUhES8rfK6zkKfDPZv6LyDixeSikPziGCsx79ZsB9U+HeVJZggS9u0lVDK
 QX6Q==
X-Gm-Message-State: AOJu0YyJ3sixklYuIt+9t8y4I5zEStCEtS/Dah8R+mw32HZVKe3qbPFd
 rPtXjKW2FUrBNBj7EdSqFeudic3sKwTxYL9DR4gJWdR89hr3ZgEeE7p+y7S74cjwwb8EjEVCQk0
 SJTJtTHGgI+1Gn8ATiW8TWk967YlsYLuvSVswySeyjG4aqrxxX4tQSSgE
X-Gm-Gg: ASbGncvWV4ekTD+o2xwKQFS31KeDKbj65dbHmV65p2AUNK+e3DvI6LYv3xRkymr59yJ
 dM8z1tznlnksEkgLLyi7vGTxBboC1DJ4L6Ii7La1ND7aOdk+FbTOqHKfNnINThVpwVoI0yopNW6
 YCp2Vzj+5QsDpXNfafSN7UQIKmAUdUz9EPPWA+YwveHoEOL4Rkpe7aPwfcX3nIfZc2d9aYtqZ/v
 bhFCKNb6gqyA842n0tl/bSLUWgcCR+K1PqOVXA6jX2+AwKkVmUwvA+vFFIlen0NM9mu7Gef2t6x
 Nej5+Oe51/YTjJMuSYX0tYrMFAynq1RdO0xin5BSdLLjZUA41Q==
X-Received: by 2002:a17:902:ea06:b0:234:595d:a58e with SMTP id
 d9443c01a7336-24288e2243amr66242035ad.25.1754418654413; 
 Tue, 05 Aug 2025 11:30:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE7UNTyJJSLL7jsxNj/hU2M562kUako7itNcqiUXyYs9piY4yDADUbZa1DhIg+yxrZsLgtdzA==
X-Received: by 2002:a17:902:ea06:b0:234:595d:a58e with SMTP id
 d9443c01a7336-24288e2243amr66241675ad.25.1754418653959; 
 Tue, 05 Aug 2025 11:30:53 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.99.3])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-241d1f0e585sm139200115ad.40.2025.08.05.11.30.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Aug 2025 11:30:53 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Tue, 05 Aug 2025 23:55:27 +0530
Subject: [PATCH v9 20/27] migration: push Error **errp into
 loadvm_process_enable_colo()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250805-propagate_tpm_error-v9-20-123450810db7@redhat.com>
References: <20250805-propagate_tpm_error-v9-0-123450810db7@redhat.com>
In-Reply-To: <20250805-propagate_tpm_error-v9-0-123450810db7@redhat.com>
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
 Stefan Berger <stefanb@linux.vnet.ibm.com>, Arun Menon <armenon@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5926; i=armenon@redhat.com;
 h=from:subject:message-id; bh=fgvd4uHPOVZmJFPX7ZVKrd3MupA0peKN3ZUBuFC022s=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ8YkXxmn7f/7fKwmnZ2+jeXCV5lb8nt+HXDQyt/Tt9jsl
 lLHxiniHaUsDGJcDLJiiiwNXwNkmwIKIyJtX16HmcPKBDKEgYtTACYSwMjIsHDLo3+/M3yqcqeH
 mPatuio/dVLE77LISY9z5IyV5C5NncvwP0JaurGd4deC7b8lJv+9cObfoer5/rZXr/a/ceO9lzA
 xkhsA
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
index 6962dc7d7f3e0121d28994c98f12f9f2258343d7..4a76d7ed730589bae87115368b0bf4819f8b161e 100644
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
index 938adb20270adbf9546b0884d0877c25c3f0f816..a6b71a958aeda31e89043f8103bfe2fc89542fb5 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2519,15 +2519,21 @@ static int loadvm_handle_recv_bitmap(MigrationIncomingState *mis,
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


