Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6574110F3DE7
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Mar 2026 13:01:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w6TIG-0003QV-R3; Sat, 28 Mar 2026 09:01:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vikingtc4@gmail.com>)
 id 1w6TI2-0003PS-Ay
 for qemu-devel@nongnu.org; Sat, 28 Mar 2026 09:01:26 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <vikingtc4@gmail.com>)
 id 1w6TI0-0002UX-9r
 for qemu-devel@nongnu.org; Sat, 28 Mar 2026 09:01:22 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-35d99bae2ebso201394a91.3
 for <qemu-devel@nongnu.org>; Sat, 28 Mar 2026 06:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774702877; x=1775307677; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=vziqdk81suTBSw8GCoOakWLJDxRdW1194aCRU8sKqEc=;
 b=cMgClWvhK2YXTEdBgGUv3RnDyoP8qPGVEH9/+qys9ys1nn4TPgoKkrrKSBYQRH2GPk
 iT5CQv/4e2hUL5HkWm4vSV1MSamUGq9UkdcYgD4HpE2wGysRatQMOirEbisU50ntT4bb
 k62MhOP16setvWknnuJYSn4iSkJ+yFgKBpePBHKoPQsBcEVt64CJ4lbKSwzxtR0jr0LB
 bk+m13pHYWeQQN/QXLvyHX+vhxiotMGKk/Jjnm80rYyE56gFq5liEXhCThrAM/INVS3O
 nNEf7l+WPTCUXaoX+NHBmXuJgBhZdqcN2SkcqdI3DSe//lUPdM3SAB4hJr8jakXH8L9o
 DLGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774702877; x=1775307677;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vziqdk81suTBSw8GCoOakWLJDxRdW1194aCRU8sKqEc=;
 b=AMOmuBXluO+KNhuE4SYT+bXoNAwQkLXUt+dWzort9AQftrh6IN2KhkigyiaGhyGOvc
 DG0mZqVSZiMwCisot3M/2fNUJBrKeTa3gwtmJAPJMzPKLIdeFsoNOKIYBwepBnCznMLA
 t/oic2VI8PAdQTpDyb8DftgAc7XRUowareRZ3reohaMeZJsYFyVisjPQwvsauTgs4gkI
 +AzEuRyuM7Ya98J3JVxFIUAj/+kzYwRCXban45DBC88HT4x6kAmUtLIuZVOxVOR+9XEK
 hnOcAa2CJjeqa9qyODSB/sU9LrpcOpvtzvy/XynbV+NiBCrYaEPdZpBpE05QSuurnxeQ
 TtvA==
X-Gm-Message-State: AOJu0YxPVIkClVDiVWH56zXw2onsXh1289wodDMyAlKiyqvhDsYwxp0T
 n7fuxbpHmavn5QlvRFhE/dPSiSfXBmxxTtTLlg0iWpeWFvz8UietFuHNDhLv8XLX
X-Gm-Gg: ATEYQzwhebgIBSGF5ArjHV2StPO0o2MQjO8AVt8J2Gn2NCDoRdGS94CUwQHuMe+TOFQ
 Wqonhu9gC/X6NaAmlOqptwq7hakBsMM/W+DPDryauj31JEMVwTdX6VQdT0juXE633uMics1vw8l
 rOrKZTvi4tnlMo9Cd3CRSbnApo7iYbZENoDJDHy0GjsFgF3IXE9XVvewM0bsmoNP+MfgLw/XdS5
 yOOXyBhfNaxCQhtUpfxBthngwL1RspXXGL5XFkbTTF0/dNYIhJQlD7wZtsm1AzK+5Tveir/hcBZ
 fNqZi1ktxgyO0UrXfziI2a9rmUC0dA8g0Cn2A6y3wJTrlA8S2finYkJ+PffTAvOat0fM0mgN+DP
 PiNDR30+GFY3XGAy12ItvdLyU8fxHSXKKKCyJZrpF8Rht560ZWSZKQ1qHMX+6bZProaJiFXVsD3
 c//YXz53mtY+sNTGu3WaPkiC7jVg+XigV3bXZp3lKQUFz1SB1E17uTpQIayvY0RJFo1SsBKVZ9K
 NyInmX1Wg==
X-Received: by 2002:a17:90b:48d2:b0:35b:e529:7089 with SMTP id
 98e67ed59e1d1-35c2fffebadmr6381549a91.10.1774702876567; 
 Sat, 28 Mar 2026 06:01:16 -0700 (PDT)
Received: from trieu2-huynh-trieuhpn-ubuntu24.bee-live.svc.cluster.local
 ([27.122.242.65]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35c2d8f96e9sm2463978a91.1.2026.03.28.06.01.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Mar 2026 06:01:16 -0700 (PDT)
From: Trieu Huynh <vikingtc4@gmail.com>
To: qemu-devel@nongnu.org
Cc: Trieu Huynh <vikingtc4@gmail.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH] migration/ram: avoid page population in ram_handle_zero via
 madvise
Date: Sat, 28 Mar 2026 22:01:10 +0900
Message-ID: <20260328130110.166469-1-vikingtc4@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=vikingtc4@gmail.com; helo=mail-pj1-x1034.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

When the destination receives a zero page during precopy migration,
ram_handle_zero() calls buffer_is_zero() which reads the page. For
anonymous mmap this is benign (reads map to the shared zero page), but
for memory-backend-memfd (mmap(MAP_SHARED) of a memfd) even a read
commits a physical page in the tmpfs page cache.

As a result, after migration all zero pages of the guest are committed
on the destination, turning a sparse RSS into a fully-populated one
(see GitLab issue #2839: a 256 GB VM went from ~4 GB RSS before
migration to ~256 GB after).

Add a bool can_discard parameter and call madvise(MADV_DONTNEED) when
it is true. This releases tmpfs/anonymous pages back to the kernel's
zero-page pool without reading the mapping at all. The madvise is
issued before any read or write, preventing the initial page fault
entirely.

Callers pass can_discard = !(block->flags & RAM_PREALLOC) so that
backends with prealloc=on are unaffected: deliberately pre-faulted pages
must not be discarded. On the destination side vCPUs are paused
(RUN_STATE_INMIGRATE) while precopy pages are loaded, so madvise is
race-free.

After migration for VM with 4GB RAM, the RSS on destination was reduced
to 247 MB (vs 4148 MB before change), measured via VmRSS in
/proc/$PID/status.

Relates-to: https://wiki.qemu.org/ToDo/LiveMigration#Avoid_page_population_when_page_is_not_populated
See-also: https://gitlab.com/qemu-project/qemu/-/issues/2839

Signed-off-by: Trieu Huynh <vikingtc4@gmail.com>
---
 migration/ram.c  | 16 +++++++++++++---
 migration/ram.h  |  2 +-
 migration/rdma.c |  9 ++++++++-
 3 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 2a7e958e87..e57613e29d 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -3638,9 +3638,13 @@ static inline void *colo_cache_from_block_offset(RAMBlock *block,
  *
  * @host: host address for the zero page
  * @size: size of the zero page
+ * @can_discard: check whether RAMBlock was created with prealloc=on
  */
-void ram_handle_zero(void *host, uint64_t size)
+void ram_handle_zero(void *host, uint64_t size, bool can_discard)
 {
+    if (can_discard && qemu_madvise(host, size, QEMU_MADV_DONTNEED) == 0) {
+        return;
+    }
     if (!buffer_is_zero(host, size)) {
         memset(host, 0, size);
     }
@@ -4086,7 +4090,7 @@ static bool handle_zero_mapped_ram(RAMBlock *block, unsigned long from_bit_idx,
                    block->idstr);
         return false;
     }
-    ram_handle_zero(host, size);
+    ram_handle_zero(host, size, !(block->flags & RAM_PREALLOC));
 
     return true;
 }
@@ -4421,7 +4425,13 @@ static int ram_load_precopy(QEMUFile *f)
                 ret = -EINVAL;
                 break;
             }
-            ram_handle_zero(host, TARGET_PAGE_SIZE);
+            {
+                ram_addr_t ram_offset;
+                RAMBlock *rb = qemu_ram_block_from_host(host, false,
+                                                        &ram_offset);
+                bool can_discard = rb && !(rb->flags & RAM_PREALLOC);
+                ram_handle_zero(host, TARGET_PAGE_SIZE, can_discard);
+            }
             break;
 
         case RAM_SAVE_FLAG_PAGE:
diff --git a/migration/ram.h b/migration/ram.h
index 41697a7599..faa80f27d1 100644
--- a/migration/ram.h
+++ b/migration/ram.h
@@ -90,7 +90,7 @@ int ram_discard_range(const char *block_name, uint64_t start, size_t length);
 int ram_postcopy_incoming_init(MigrationIncomingState *mis, Error **errp);
 int ram_load_postcopy(QEMUFile *f, int channel);
 
-void ram_handle_zero(void *host, uint64_t size);
+void ram_handle_zero(void *host, uint64_t size, bool can_discard);
 
 void ram_transferred_add(uint64_t bytes);
 void ram_release_page(const char *rbname, uint64_t offset);
diff --git a/migration/rdma.c b/migration/rdma.c
index 55ab85650a..d4c36af5b9 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -28,6 +28,7 @@
 #include "qemu/error-report.h"
 #include "qemu/main-loop.h"
 #include "qemu/module.h"
+#include "system/ramblock.h"
 #include "qemu/rcu.h"
 #include "qemu/sockets.h"
 #include "qemu/bitmap.h"
@@ -3413,7 +3414,13 @@ int rdma_registration_handle(QEMUFile *f)
                              comp->value);
                 goto err;
             }
-            ram_handle_zero(host_addr, comp->length);
+            {
+                ram_addr_t ram_offset;
+                RAMBlock *rb = qemu_ram_block_from_host(host_addr, false,
+                                                        &ram_offset);
+                bool can_discard = rb && !(rb->flags & RAM_PREALLOC);
+                ram_handle_zero(host_addr, comp->length, can_discard);
+            }
             break;
 
         case RDMA_CONTROL_REGISTER_FINISHED:
-- 
2.43.0


