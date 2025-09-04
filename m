Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 742D4CA1012
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Sep 2025 22:34:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uuIVI-00054O-UT; Thu, 04 Sep 2025 18:32:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uuIVG-00053Z-PU
 for qemu-devel@nongnu.org; Thu, 04 Sep 2025 18:32:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uuIV6-0006t2-6s
 for qemu-devel@nongnu.org; Thu, 04 Sep 2025 18:32:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757025123;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=GMauJ16MY/NX9oxW4O4AYryWbtbAiPiqAFghBrOlrDE=;
 b=H158CA1CqEZfN8MdLlv4Fci1YsW1VEFAQAbxEKkci5SSBYq6wL/+JxxnHrdAlat0kXkxs1
 kkdIKJgnUJ7cYWejIwW5Lnoc0LI0X1nZZbGVy1nir7WTG9TLdFdOjN+2ruvsTtf6Y8akSq
 IWw9LFmMLACMLHsfMCe9XRH776f4e0I=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-400-5OuNpohdN0alErEC8ikheg-1; Thu, 04 Sep 2025 18:32:02 -0400
X-MC-Unique: 5OuNpohdN0alErEC8ikheg-1
X-Mimecast-MFC-AGG-ID: 5OuNpohdN0alErEC8ikheg_1757025122
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-4b34c87dad0so31118891cf.3
 for <qemu-devel@nongnu.org>; Thu, 04 Sep 2025 15:32:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757025122; x=1757629922;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GMauJ16MY/NX9oxW4O4AYryWbtbAiPiqAFghBrOlrDE=;
 b=FfW8c71pMkfaqys0TTfBCMtGq6ziN6isTnix1wErnZc04gVWf60mquvppmWAPUibjF
 UTqvK/bo7N6XQjhps274EwRURipUpFibHfty993xh0B7lZh32QaGAVxznQcLHU2Vgnoo
 IEQJnDSTQgZfIr/fOuyKVU17FwUmOp5/nX3YLI9hYg3g/+RZklBp0oNHtCV6bATlHkco
 q1JT5XZks/lsaxZfAHPir/bsOjsSZ1j9mM437cwMl31jxaGODKtA4DIlESC2UeJcabyf
 bNAEDP6dTmL+HOZcODFxvnJg9oOvYpuE5WQ4MZTTTfLXAUUoivqhioXOss/N0pryEY75
 1E2Q==
X-Gm-Message-State: AOJu0YwEWJP0L7HYWOnfeTUCrsdlQ7T/vyO/KpDTfhGZTciwJTxs7XCk
 JabJyJBLFQ6fnXI7YFSlvZvBockYIFjEeUaob9PuJuR6cmDoO6kkDNZ9qJQFYekVZv+lpz/1gnN
 TqUms5kkZlB2pZ0KgnyLnCFTc/y62NP9rYXIdWdmOZ0Rc1gcJtS2n5/xHft8NNf1R8n0iA+xlKP
 ylnFtgAuW3FTstsbNPuE4AAhT0EKiBrx7MgM40Dw==
X-Gm-Gg: ASbGnct0IQAoDd+Lh7Tv5Gh8XQcktEX5vwiGMpmV4AotF4hNpvig9LajAGu1/UrZhxG
 //Vbf6rTHCHA+4nLz8ctsQ8Ej2ts+kN0y32r51pms78lLuYnrqBdOaSChUiR/wEcywciUTupq+9
 AusZODr+GDzzGubpUd80/eSBvU2aQcJxHNOhmNOauMitU8ZtXYWUL65tdfxgGpI+4UmJEGvorS/
 Ot3SYKWZY4Yh3un4svljsjUkp4hWbFhN5dhy/jYxTqlV0gHIRjUlSq0xfC3BH9IbRLxJg0ThbBw
 GAvvEaMLtQvu3DJoRFcqk5KHMUn/JNqgXv6OW6ohGJbSgiFKY9kTWDMk4Ln1vuCERI+3YlsHbAp
 pMi5KdhhBn0EZz6z+ud4=
X-Received: by 2002:a05:622a:a13:b0:4b5:de12:4c34 with SMTP id
 d75a77b69052e-4b5de1250c6mr34945641cf.75.1757025121631; 
 Thu, 04 Sep 2025 15:32:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH/DsK1lCNe/eKdcfe7iAu+t5FDa6/H8Z3POgqOnaZGVl8PzECAkNQNaN8/BEk94tEEeuDFRg==
X-Received: by 2002:a05:622a:a13:b0:4b5:de12:4c34 with SMTP id
 d75a77b69052e-4b5de1250c6mr34945221cf.75.1757025121001; 
 Thu, 04 Sep 2025 15:32:01 -0700 (PDT)
Received: from x1.com
 (bras-base-aurron9134w-grc-11-174-89-135-121.dsl.bell.ca. [174.89.135.121])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-7252d6ad05asm34200366d6.62.2025.09.04.15.31.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Sep 2025 15:32:00 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Juraj Marcin <jmarcin@redhat.com>, peterx@redhat.com,
 Peter Maydell <peter.maydell@linaro.org>, Fabiano Rosas <farosas@suse.de>
Subject: [PATCH] bql: Fix bql_locked status with condvar APIs
Date: Thu,  4 Sep 2025 18:31:58 -0400
Message-ID: <20250904223158.1276992-1-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
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

QEMU has a per-thread "bql_locked" variable stored in TLS section, showing
whether the current thread is holding the BQL lock.

It's a pretty handy variable.  Function-wise, QEMU have codes trying to
conditionally take bql, relying on the var reflecting the locking status
(e.g. BQL_LOCK_GUARD), or in a GDB debugging session, we could also look at
the variable (in reality, co_tls_bql_locked), to see which thread is
currently holding the bql.

When using that as a debugging facility, sometimes we can observe multiple
threads holding bql at the same time. It's because QEMU's condvar APIs
bypassed the bql_*() API, hence they do not update bql_locked even if they
have released the mutex while waiting.

It can cause confusion if one does "thread apply all p co_tls_bql_locked"
and see multiple threads reporting true.

Fix this by moving the bql status updates into the mutex debug hooks.  Now
the variable should always reflect the reality.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
rfc->v1
- Fix comment [Stefan]
---
 include/qemu/main-loop.h  | 18 ++++++++++++++++++
 util/qemu-thread-common.h |  7 +++++++
 stubs/iothread-lock.c     |  9 +++++++++
 system/cpus.c             | 14 ++++++++++++--
 4 files changed, 46 insertions(+), 2 deletions(-)

diff --git a/include/qemu/main-loop.h b/include/qemu/main-loop.h
index 4e2436b196..0d55c636b2 100644
--- a/include/qemu/main-loop.h
+++ b/include/qemu/main-loop.h
@@ -270,6 +270,24 @@ void rust_bql_mock_lock(void);
  */
 bool bql_locked(void);
 
+/**
+ * mutex_is_bql:
+ *
+ * @mutex: the mutex pointer
+ *
+ * Returns whether the mutex is the BQL.
+ */
+bool mutex_is_bql(QemuMutex *mutex);
+
+/**
+ * bql_update_status:
+ *
+ * @locked: update status on whether the BQL is locked
+ *
+ * NOTE: this should normally only be invoked when the status changed.
+ */
+void bql_update_status(bool locked);
+
 /**
  * bql_block: Allow/deny releasing the BQL
  *
diff --git a/util/qemu-thread-common.h b/util/qemu-thread-common.h
index 2af6b12085..09331843ba 100644
--- a/util/qemu-thread-common.h
+++ b/util/qemu-thread-common.h
@@ -14,6 +14,7 @@
 #define QEMU_THREAD_COMMON_H
 
 #include "qemu/thread.h"
+#include "qemu/main-loop.h"
 #include "trace.h"
 
 static inline void qemu_mutex_post_init(QemuMutex *mutex)
@@ -39,6 +40,9 @@ static inline void qemu_mutex_post_lock(QemuMutex *mutex,
     mutex->line = line;
 #endif
     trace_qemu_mutex_locked(mutex, file, line);
+    if (mutex_is_bql(mutex)) {
+        bql_update_status(true);
+    }
 }
 
 static inline void qemu_mutex_pre_unlock(QemuMutex *mutex,
@@ -49,6 +53,9 @@ static inline void qemu_mutex_pre_unlock(QemuMutex *mutex,
     mutex->line = 0;
 #endif
     trace_qemu_mutex_unlock(mutex, file, line);
+    if (mutex_is_bql(mutex)) {
+        bql_update_status(false);
+    }
 }
 
 #endif
diff --git a/stubs/iothread-lock.c b/stubs/iothread-lock.c
index 6050c081f5..c89c9c7228 100644
--- a/stubs/iothread-lock.c
+++ b/stubs/iothread-lock.c
@@ -34,3 +34,12 @@ void bql_block_unlock(bool increase)
     assert((new_value > bql_unlock_blocked) == increase);
     bql_unlock_blocked = new_value;
 }
+
+bool mutex_is_bql(QemuMutex *mutex)
+{
+    return false;
+}
+
+void bql_update_status(bool locked)
+{
+}
diff --git a/system/cpus.c b/system/cpus.c
index 437848b5eb..9c066e1c08 100644
--- a/system/cpus.c
+++ b/system/cpus.c
@@ -524,6 +524,18 @@ bool qemu_in_vcpu_thread(void)
 
 QEMU_DEFINE_STATIC_CO_TLS(bool, bql_locked)
 
+bool mutex_is_bql(QemuMutex *mutex)
+{
+    return mutex == &bql;
+}
+
+void bql_update_status(bool locked)
+{
+    /* This function should only be used when an update happened.. */
+    assert(bql_locked() != locked);
+    set_bql_locked(locked);
+}
+
 static uint32_t bql_unlock_blocked;
 
 void bql_block_unlock(bool increase)
@@ -564,14 +576,12 @@ void bql_lock_impl(const char *file, int line)
 
     g_assert(!bql_locked());
     bql_lock_fn(&bql, file, line);
-    set_bql_locked(true);
 }
 
 void bql_unlock(void)
 {
     g_assert(bql_locked());
     g_assert(!bql_unlock_blocked);
-    set_bql_locked(false);
     qemu_mutex_unlock(&bql);
 }
 
-- 
2.50.1


