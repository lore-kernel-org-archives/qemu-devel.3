Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34034C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2024 22:42:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzOnI-0002OG-UV; Tue, 23 Apr 2024 18:39:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rzOmo-0001fE-Fy
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 18:38:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rzOmm-0006Fm-OE
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 18:38:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713911928;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M+gOpvRG0UHv/ctwGx6rMTNZQF29KVYeLViX3Vc4ac8=;
 b=MfjdG4eLW9+dHlpgwaQHH6lZxoXBJHG516A1E6bvTcihb2ZfGeY+baVGiaE37+3ekVLMZn
 bG4JbHF/N6EMjMPwNCEkKvmC/gRhz+pezpajN00HvHdpfaIQub+f9bJgz3yB19GB4JfY4A
 qhDny1MXpKQWUfLzV2RpC4dT0O/PLzc=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-166-ZFhKdTx5OhCjCnsKIrYRAg-1; Tue, 23 Apr 2024 18:38:47 -0400
X-MC-Unique: ZFhKdTx5OhCjCnsKIrYRAg-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-6a05461964cso18606076d6.2
 for <qemu-devel@nongnu.org>; Tue, 23 Apr 2024 15:38:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713911926; x=1714516726;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=M+gOpvRG0UHv/ctwGx6rMTNZQF29KVYeLViX3Vc4ac8=;
 b=fnosozo1tZO4yIkvESY8oQPATmSTOj9DPneGkD4Ysr75q8JnXrgzuvKP2VZB+VRFTM
 2tMyoJvQAZnZqP4J2/dcdEhtfIrF8b/5UE7YQuWhf8+9InHRrFxvRaZMV68fIl+ttzRF
 MmbnOdRH6GQtdJdbJxDzJS36Z90emjTgWJIOpZCHDs+hnzS4wt9hHlHH3Y6ozzUQcWn+
 RN8gWDGZ4ZxWynEUnuRSPOzTEqxU4AJp/1v7AC3GjfUOnszgUgmIgHuQ3FBYQA8qyRtW
 z/Nn8/h2cInyiLchVuddbzYUkIQIXWlEglG9xKJtK6QzB6+2d8qUOG0czNxg/FAr+UOM
 hfKQ==
X-Gm-Message-State: AOJu0Yz44pVj7b9mERKl2SNwzxv2aX3WfBG4Lr5UEIy9t2Hp3AeI5mw7
 sl+izFzp+N0rDxh4jJG28W1YGVapisqCAReKJ4q2G6WBzNWcFt1SA5xbwTRnv0rmIp1wCHYhLdu
 Cs7lxsYU7SBbx0i8Jk7BShw2btreqaaDs4twwaor28vMwGwFTOobJ4I/ZZB+VbVJFR2zrB/x+6t
 iIZXI2F3r2jNGj6QYt2c/s+wm9EHR5sz+Ttg==
X-Received: by 2002:a05:620a:4081:b0:790:7d78:1ca0 with SMTP id
 f1-20020a05620a408100b007907d781ca0mr1090055qko.2.1713911926268; 
 Tue, 23 Apr 2024 15:38:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHYFoisrMMorSfG9dfRl80g5YdOaPbQhh1cA7AcGRbsSf6YFi2DSJVsAeW8faOzcIpRaJC2Wg==
X-Received: by 2002:a05:620a:4081:b0:790:7d78:1ca0 with SMTP id
 f1-20020a05620a408100b007907d781ca0mr1090027qko.2.1713911925501; 
 Tue, 23 Apr 2024 15:38:45 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 c21-20020a05620a11b500b0078d67886632sm5647726qkk.37.2024.04.23.15.38.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Apr 2024 15:38:45 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, Prasad Pandit <ppandit@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Fabiano Rosas <farosas@suse.de>,
 Li Zhijian <lizhijian@fujitsu.com>, qemu-stable@nongnu.org,
 Zhang Chen <chen.zhang@intel.com>
Subject: [PULL 26/26] migration/colo: Fix bdrv_graph_rdlock_main_loop:
 Assertion `!qemu_in_coroutine()' failed.
Date: Tue, 23 Apr 2024 18:38:13 -0400
Message-ID: <20240423223813.3237060-27-peterx@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240423223813.3237060-1-peterx@redhat.com>
References: <20240423223813.3237060-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.67,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Li Zhijian <lizhijian@fujitsu.com>

bdrv_activate_all() should not be called from the coroutine context, move
it to the QEMU thread colo_process_incoming_thread() with the bql_lock
protected.

The backtrace is as follows:
 #4  0x0000561af7948362 in bdrv_graph_rdlock_main_loop () at ../block/graph-lock.c:260
 #5  0x0000561af7907a68 in graph_lockable_auto_lock_mainloop (x=0x7fd29810be7b) at /patch/to/qemu/include/block/graph-lock.h:259
 #6  0x0000561af79167d1 in bdrv_activate_all (errp=0x7fd29810bed0) at ../block.c:6906
 #7  0x0000561af762b4af in colo_incoming_co () at ../migration/colo.c:935
 #8  0x0000561af7607e57 in process_incoming_migration_co (opaque=0x0) at ../migration/migration.c:793
 #9  0x0000561af7adbeeb in coroutine_trampoline (i0=-106876144, i1=22042) at ../util/coroutine-ucontext.c:175
 #10 0x00007fd2a5cf21c0 in  () at /lib64/libc.so.6

Cc: qemu-stable@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>
Closes: https://gitlab.com/qemu-project/qemu/-/issues/2277
Fixes: 2b3912f135 ("block: Mark bdrv_first_blk() and bdrv_is_root_node() GRAPH_RDLOCK")
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
Reviewed-by: Zhang Chen <chen.zhang@intel.com>
Tested-by: Zhang Chen <chen.zhang@intel.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/r/20240417025634.1014582-1-lizhijian@fujitsu.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/colo.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/migration/colo.c b/migration/colo.c
index 84632a603e..5600a43d78 100644
--- a/migration/colo.c
+++ b/migration/colo.c
@@ -835,6 +835,16 @@ static void *colo_process_incoming_thread(void *opaque)
         return NULL;
     }
 
+    /* Make sure all file formats throw away their mutable metadata */
+    bql_lock();
+    bdrv_activate_all(&local_err);
+    if (local_err) {
+        bql_unlock();
+        error_report_err(local_err);
+        return NULL;
+    }
+    bql_unlock();
+
     failover_init_state();
 
     mis->to_src_file = qemu_file_get_return_path(mis->from_src_file);
@@ -922,7 +932,6 @@ out:
 int coroutine_fn colo_incoming_co(void)
 {
     MigrationIncomingState *mis = migration_incoming_get_current();
-    Error *local_err = NULL;
     QemuThread th;
 
     assert(bql_locked());
@@ -931,13 +940,6 @@ int coroutine_fn colo_incoming_co(void)
         return 0;
     }
 
-    /* Make sure all file formats throw away their mutable metadata */
-    bdrv_activate_all(&local_err);
-    if (local_err) {
-        error_report_err(local_err);
-        return -EINVAL;
-    }
-
     qemu_thread_create(&th, "COLO incoming", colo_process_incoming_thread,
                        mis, QEMU_THREAD_JOINABLE);
 
-- 
2.44.0


