Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A7F61061B1B
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2026 19:05:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7Hvi-0003pt-B2; Mon, 30 Mar 2026 15:05:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hayatake396@gmail.com>)
 id 1w7HvV-0003ok-Gl
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 15:05:29 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hayatake396@gmail.com>)
 id 1w7HvS-0005DJ-9W
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 15:05:27 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-82ae378fff8so3067187b3a.2
 for <qemu-devel@nongnu.org>; Mon, 30 Mar 2026 12:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774897524; x=1775502324; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=GWXg+mj1MOof8W2D421QpIVtIcM/Q39yej/+pKha1zc=;
 b=NxbyE7GDpfa0A3980XL0Faqc17PU6RzqiqYAagwzVXOhLjY2Eo4DxSPnBd4gYkW/xB
 Oq3dG/wcLOkuEckkkCTrV0CEWcH5e/xVUGKckmqHBPoR6UkVwttiFNITixRpHtidpcCU
 0nNOeCbRPXRfGuEEi5YOVf2LaTU8T6kmN3G/WfAKh6WgKpP8uPQD1b8u2o/I8qd91Q9l
 +6tG9f5wPYp7pPccKZy1oj8MwnoFD1yU/Kh872J3yyd0m9gSnJEVrw9BSeMEG6cGBTsf
 RKDyBGYIbxvCi43ERjyXCrsQ92Dq/jGhIS7hf5RfQ5gXEmL/eTOv0UwfJj7pgVEBWiue
 nCGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774897524; x=1775502324;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=GWXg+mj1MOof8W2D421QpIVtIcM/Q39yej/+pKha1zc=;
 b=dVLJZmb+02LJvDlo2rx4hIvVo5vzdEAzbHfq9VItHYRnyIO8L6bZEPILqoYo7+tFTW
 NJpLQUHO+Th3ZRfwVJmbjlkTkR4BfJCEORdeiPFkHlS+2YVXBExlQU5YCualL2HcpBw6
 5yv7ILs4O3Grp7LNOZ6Y5y/nCtceLixu5NjxTB5UyV4FhPnsmP829qxOsI8hlKuRreo5
 XaDaNa5xGFWi4fY47Mw6+p+8gCQWXng20TOQosv1W0PomZnZwLibJu1DiPahwFiAWdR/
 S/jLrIlhoVDqX84Zn1B3BE+N5bWAzr6ceDoxTXP2YHD7M1wnUlqsXb7CRpodsHcAGr0A
 zwOA==
X-Gm-Message-State: AOJu0YwspvY3ANDzojqcRr/zkD9L0a1EHgdKBOIYJns4P3J2ssB85Ene
 E74Ssj6qs8B5ysLShHEr8suwkBHvMBeA1Ezdd1gSpsgmbEdFuXPrvyMCqDmpiQ==
X-Gm-Gg: ATEYQzx1/GQadZJgRtZYldTNYg4+E75Do8LyBFSLSrwp4+WPyIs5peIMDomQd7Sa4+l
 jWUteeT8Ixo9d/GkvoQAvi3iLlbuSFwMwfLNdW0uKB6R0QO0lDWWizxepCU34ZNkG32YZY388tC
 hVR7fgyHQo89cXmURGnPVd06vS5NAn/dpd00zTQ6ps3msHaMsV16bxPd5FOQMV3ocYH3Vp6zkrL
 DzU1hmnKb08Q/3igFDw83U0mBo+e61rbuQItwVFWUCQNP6tGUfTg4qvv/IcFm0K141TXDF+OiO/
 pdAUHBFUofqpUbcQijJNFc3K86XSLVTcSlU67/Z2jIInlRlX7Vqcjj1EaXIhvOpOp05VVX2fSvE
 AIWN0ulGlhvtN+seYzswKgW3w29vFx6vZPrNvvJlFv8iFCFcbgAFR/i7VdK61GiqCrYBHcKzkC7
 vsNDnaIRytskGETrhT76FhbDz/j1uTLGh2YBPTLzeH455bHOSV/LJEbgLOrWYCjgMIgtR1XkT/N
 zLy9bYWcwQxJCemo5sX8DnYA7n9
X-Received: by 2002:a05:6a00:1ca8:b0:82a:778:cd73 with SMTP id
 d2e1a72fcca58-82c96039a20mr11884762b3a.51.1774897524430; 
 Mon, 30 Mar 2026 12:05:24 -0700 (PDT)
Received: from [127.0.1.1] (191.68.231.218.rev.ocx2915.net. [218.231.68.191])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82ca84644d9sm8496989b3a.13.2026.03.30.12.05.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Mar 2026 12:05:23 -0700 (PDT)
From: Takeru Hayasaka <hayatake396@gmail.com>
Date: Mon, 30 Mar 2026 19:04:41 +0000
Subject: [PATCH 1/3] migration/postcopy: Extract page fault handler
 callback
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260330-fast-snapshot-refactor-v1-1-22143e70c467@gmail.com>
References: <20260330-fast-snapshot-refactor-v1-0-22143e70c467@gmail.com>
In-Reply-To: <20260330-fast-snapshot-refactor-v1-0-22143e70c467@gmail.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Takeru Hayasaka <hayatake396@gmail.com>
X-Mailer: b4 0.15.1
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=hayatake396@gmail.com; helo=mail-pf1-x42b.google.com
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

Introduce a PostcopyPageHandler callback type and use it to decouple
the userfaultfd fault thread from the postcopy-specific page request
logic. This prepares for fast snapshot load, which will supply pages
from a local file instead of requesting them over the network.

The fault thread now calls mis->page_fault_handler() instead of
postcopy_request_page() directly. For postcopy, the handler is set to
postcopy_page_fault_handler() which delegates to the existing
postcopy_request_page().

No functional change for postcopy migration.

Signed-off-by: Takeru Hayasaka <hayatake396@gmail.com>
---
 migration/migration.h    | 16 ++++++++++++++++
 migration/postcopy-ram.c | 22 +++++++++++++++++++---
 2 files changed, 35 insertions(+), 3 deletions(-)

diff --git a/migration/migration.h b/migration/migration.h
index b6888daceddf..33525402922d 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -89,6 +89,17 @@ typedef enum {
     PREEMPT_THREAD_QUIT,
 } PreemptThreadStatus;
 
+/*
+ * Callback to handle a page fault from the userfaultfd fault thread.
+ * Implementations resolve the fault by supplying the requested page,
+ * e.g., by requesting it from the migration source (postcopy) or by
+ * reading it from a snapshot file (fast snapshot load).
+ */
+typedef int (*PostcopyPageHandler)(MigrationIncomingState *mis,
+                                   RAMBlock *rb,
+                                   ram_addr_t offset,
+                                   void *fault_address);
+
 /* State for the incoming migration */
 struct MigrationIncomingState {
     QEMUFile *from_src_file;
@@ -116,6 +127,11 @@ struct MigrationIncomingState {
     QemuThread     fault_thread;
     /* Set this when we want the fault thread to quit */
     bool           fault_thread_quit;
+    /* Callback to resolve page faults; set before fault thread starts */
+    PostcopyPageHandler page_fault_handler;
+    void *page_fault_opaque;
+    /* ptid from current uffd fault msg, for postcopy blocktime tracking */
+    uint32_t fault_thread_ptid;
 
     bool           have_listen_thread;
     QemuThread     listen_thread;
diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index f5ef93f1933c..8dcd8ff35e85 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -976,6 +976,20 @@ static int postcopy_request_page(MigrationIncomingState *mis, RAMBlock *rb,
     return migrate_send_rp_req_pages(mis, rb, start, haddr, tid);
 }
 
+/*
+ * Default page fault handler for postcopy live migration.
+ * Requests the faulted page from the source via the return path.
+ */
+static int postcopy_page_fault_handler(MigrationIncomingState *mis,
+                                       RAMBlock *rb,
+                                       ram_addr_t offset,
+                                       void *fault_address)
+{
+    return postcopy_request_page(mis, rb, offset,
+                                 (uint64_t)(uintptr_t)fault_address,
+                                 mis->fault_thread_ptid);
+}
+
 /*
  * Callback from shared fault handlers to ask for a page,
  * the page must be specified by a RAMBlock and an offset in that rb
@@ -1392,9 +1406,9 @@ retry:
              * Send the request to the source - we want to request one
              * of our host page sizes (which is >= TPS)
              */
-            ret = postcopy_request_page(mis, rb, rb_offset,
-                                        msg.arg.pagefault.address,
-                                        msg.arg.pagefault.feat.ptid);
+            mis->fault_thread_ptid = msg.arg.pagefault.feat.ptid;
+            ret = mis->page_fault_handler(mis, rb, rb_offset,
+                    (void *)(uintptr_t)msg.arg.pagefault.address);
             if (ret) {
                 /* May be network failure, try to wait for recovery */
                 postcopy_pause_fault_thread(mis);
@@ -1552,6 +1566,8 @@ int postcopy_ram_incoming_setup(MigrationIncomingState *mis)
         return -1;
     }
 
+    mis->page_fault_handler = postcopy_page_fault_handler;
+
     postcopy_thread_create(mis, &mis->fault_thread,
                            MIGRATION_THREAD_DST_FAULT,
                            postcopy_ram_fault_thread, QEMU_THREAD_JOINABLE);

-- 
2.43.0


