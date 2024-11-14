Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B7C0D637D6
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 01:19:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBOTS-00044B-Al; Wed, 13 Nov 2024 20:16:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tBOT0-0002VS-IQ
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 20:16:16 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tBOSx-00031y-Sq
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 20:16:14 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-431616c23b5so205305e9.0
 for <qemu-devel@nongnu.org>; Wed, 13 Nov 2024 17:16:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731546969; x=1732151769; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dJnPLBXDUWt9APABFP9RtiuQUlaLpT6eHtJy+a+Whyg=;
 b=qSC2iR3FZXQ9xvcsI53Cva0/uYAFxHj+GyOAmpyHInvli7a3m+TRmBsokfSUeheQD6
 5pBBDLn+iRIGWrq4mHs24modnt7mMF8QtnlDY1ALgRaHcgt3z2EFGBYDOvpD+NEXgqZ8
 v9fxuS1RSgwfz6k4y6wzk5Aq/iiFZ5OuopnyrGOxuItaqa/Gd7agNItE9Xgdv3sKOi9s
 GGuZZUCNG40cuOSKjVsw4GOKU4zpQ+KcOhL47kr7MQaE/JR0rA4GuXIPfRxhoQgptGm4
 4R3pA07Pw8BoPwOQc5cejTOwPkvZpeqxqP+R/N59rNViHh+Z+JNlbAMrJiqmv9kjh+oy
 5hkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731546969; x=1732151769;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dJnPLBXDUWt9APABFP9RtiuQUlaLpT6eHtJy+a+Whyg=;
 b=qzRadUCaYawoPH7HmJPN2dl0lxKD8sMJmVVRWEOMOZ0Du8FrH5bo/Qhcessv14AWJ8
 VT7M/GeTkK2XwZua5BsLSgdBeBYx++o+Xs18NViUpY7kksegtRThfsQ5DYbtmj3jqQOS
 gj0diBgVKwRUQ9e2q1HRvqi2fJ3zyzhADvakT7rTmRqMKlc3juqk4nuW2msE3G+irXWZ
 Ta7k3PZ3FhxmfeLXPDeZ6V7DI/Kj+hfsdI13E2cdrPoUgEjPRibzvPQR2XIionvm2WuX
 0h3ObfCii7Abl4ej8EOemabrAZH81w3p+yv/XzbpUTOy21yRyfB7SFW1v+GGWqWWtue5
 41Qg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUStxbJ5Q53DcXNf3lxQ5YPMb29vfJS6H8ypYnu0Wqvbz8Y+Zu9i/bTklyvVePSY//30OEcXuu7Zqke@nongnu.org
X-Gm-Message-State: AOJu0YwSKlxS391guXvV1spxOCNm4LtpX99xNzFDEeFt9YxtfxMXD/E0
 RHzsNQ4VU0kPttJvc2kyblFjF63QqUHwINo1MmPuH2/edLiIl+PDs6u5x7nzQ9Gpan1O1NACxdZ
 y
X-Google-Smtp-Source: AGHT+IFNRYI+6+k6hzZD/Oqm3sK6NGybQN7v5rJRv2V4XIRC72YBhh+g6R+IRQke+T79tc6rz4+9zg==
X-Received: by 2002:a05:600c:4fc5:b0:431:55f3:d34e with SMTP id
 5b1f17b1804b1-432d9761bdcmr12005115e9.15.1731546969598; 
 Wed, 13 Nov 2024 17:16:09 -0800 (PST)
Received: from localhost.localdomain ([176.187.209.238])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432da280018sm4774385e9.26.2024.11.13.17.16.07
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 13 Nov 2024 17:16:09 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org,
 Peter Xu <peterx@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-riscv@nongnu.org,
 David Hildenbrand <david@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-s390x@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 22/24] exec/cpu-common: Move ram_addr_t related methods to
 'exec/ram_addr.h'
Date: Thu, 14 Nov 2024 02:13:07 +0100
Message-ID: <20241114011310.3615-23-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241114011310.3615-1-philmd@linaro.org>
References: <20241114011310.3615-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Move methods related to the ram_addr_t type to
the specific "exec/ram_addr.h" header.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/exec/cpu-common.h        | 56 +-------------------------------
 include/exec/ram_addr.h          | 56 ++++++++++++++++++++++++++++++++
 include/exec/translation-block.h |  2 +-
 3 files changed, 58 insertions(+), 56 deletions(-)

diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index 638dc806a5..b790202c56 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -54,61 +54,7 @@ enum device_endian {
 #define DEVICE_HOST_ENDIAN DEVICE_LITTLE_ENDIAN
 #endif
 
-/* address in the RAM (different from a physical address) */
-#if defined(CONFIG_XEN_BACKEND)
-typedef uint64_t ram_addr_t;
-#  define RAM_ADDR_MAX UINT64_MAX
-#  define RAM_ADDR_FMT "%" PRIx64
-#else
-typedef uintptr_t ram_addr_t;
-#  define RAM_ADDR_MAX UINTPTR_MAX
-#  define RAM_ADDR_FMT "%" PRIxPTR
-#endif
-
-/* memory API */
-
-void qemu_ram_remap(ram_addr_t addr, ram_addr_t length);
-/* This should not be used by devices.  */
-ram_addr_t qemu_ram_addr_from_host(void *ptr);
-ram_addr_t qemu_ram_addr_from_host_nofail(void *ptr);
-RAMBlock *qemu_ram_block_by_name(const char *name);
-
-/*
- * Translates a host ptr back to a RAMBlock and an offset in that RAMBlock.
- *
- * @ptr: The host pointer to translate.
- * @round_offset: Whether to round the result offset down to a target page
- * @offset: Will be set to the offset within the returned RAMBlock.
- *
- * Returns: RAMBlock (or NULL if not found)
- *
- * By the time this function returns, the returned pointer is not protected
- * by RCU anymore.  If the caller is not within an RCU critical section and
- * does not hold the BQL, it must have other means of protecting the
- * pointer, such as a reference to the memory region that owns the RAMBlock.
- */
-RAMBlock *qemu_ram_block_from_host(void *ptr, bool round_offset,
-                                   ram_addr_t *offset);
-ram_addr_t qemu_ram_block_host_offset(RAMBlock *rb, void *host);
-void qemu_ram_set_idstr(RAMBlock *block, const char *name, DeviceState *dev);
-void qemu_ram_unset_idstr(RAMBlock *block);
-const char *qemu_ram_get_idstr(RAMBlock *rb);
-void *qemu_ram_get_host_addr(RAMBlock *rb);
-ram_addr_t qemu_ram_get_offset(RAMBlock *rb);
-ram_addr_t qemu_ram_get_used_length(RAMBlock *rb);
-ram_addr_t qemu_ram_get_max_length(RAMBlock *rb);
-bool qemu_ram_is_shared(RAMBlock *rb);
-bool qemu_ram_is_noreserve(RAMBlock *rb);
-bool qemu_ram_is_uf_zeroable(RAMBlock *rb);
-void qemu_ram_set_uf_zeroable(RAMBlock *rb);
-bool qemu_ram_is_migratable(RAMBlock *rb);
-void qemu_ram_set_migratable(RAMBlock *rb);
-void qemu_ram_unset_migratable(RAMBlock *rb);
-bool qemu_ram_is_named_file(RAMBlock *rb);
-int qemu_ram_get_fd(RAMBlock *rb);
-
-size_t qemu_ram_pagesize(RAMBlock *block);
-size_t qemu_ram_pagesize_largest(void);
+#include "exec/ram_addr.h"
 
 /**
  * cpu_address_space_init:
diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
index 80f6dc7564..e0620ddb03 100644
--- a/include/exec/ram_addr.h
+++ b/include/exec/ram_addr.h
@@ -21,6 +21,62 @@
 
 #ifndef CONFIG_USER_ONLY
 
+/* address in the RAM (different from a physical address) */
+#if defined(CONFIG_XEN_BACKEND)
+typedef uint64_t ram_addr_t;
+#  define RAM_ADDR_MAX UINT64_MAX
+#  define RAM_ADDR_FMT "%" PRIx64
+#else
+typedef uintptr_t ram_addr_t;
+#  define RAM_ADDR_MAX UINTPTR_MAX
+#  define RAM_ADDR_FMT "%" PRIxPTR
+#endif
+
+/* memory API */
+
+void qemu_ram_remap(ram_addr_t addr, ram_addr_t length);
+/* This should not be used by devices.  */
+ram_addr_t qemu_ram_addr_from_host(void *ptr);
+ram_addr_t qemu_ram_addr_from_host_nofail(void *ptr);
+RAMBlock *qemu_ram_block_by_name(const char *name);
+
+/*
+ * Translates a host ptr back to a RAMBlock and an offset in that RAMBlock.
+ *
+ * @ptr: The host pointer to translate.
+ * @round_offset: Whether to round the result offset down to a target page
+ * @offset: Will be set to the offset within the returned RAMBlock.
+ *
+ * Returns: RAMBlock (or NULL if not found)
+ *
+ * By the time this function returns, the returned pointer is not protected
+ * by RCU anymore.  If the caller is not within an RCU critical section and
+ * does not hold the BQL, it must have other means of protecting the
+ * pointer, such as a reference to the memory region that owns the RAMBlock.
+ */
+RAMBlock *qemu_ram_block_from_host(void *ptr, bool round_offset,
+                                   ram_addr_t *offset);
+ram_addr_t qemu_ram_block_host_offset(RAMBlock *rb, void *host);
+void qemu_ram_set_idstr(RAMBlock *block, const char *name, DeviceState *dev);
+void qemu_ram_unset_idstr(RAMBlock *block);
+const char *qemu_ram_get_idstr(RAMBlock *rb);
+void *qemu_ram_get_host_addr(RAMBlock *rb);
+ram_addr_t qemu_ram_get_offset(RAMBlock *rb);
+ram_addr_t qemu_ram_get_used_length(RAMBlock *rb);
+ram_addr_t qemu_ram_get_max_length(RAMBlock *rb);
+bool qemu_ram_is_shared(RAMBlock *rb);
+bool qemu_ram_is_noreserve(RAMBlock *rb);
+bool qemu_ram_is_uf_zeroable(RAMBlock *rb);
+void qemu_ram_set_uf_zeroable(RAMBlock *rb);
+bool qemu_ram_is_migratable(RAMBlock *rb);
+void qemu_ram_set_migratable(RAMBlock *rb);
+void qemu_ram_unset_migratable(RAMBlock *rb);
+bool qemu_ram_is_named_file(RAMBlock *rb);
+int qemu_ram_get_fd(RAMBlock *rb);
+
+size_t qemu_ram_pagesize(RAMBlock *block);
+size_t qemu_ram_pagesize_largest(void);
+
 bool ramblock_is_pmem(RAMBlock *rb);
 
 long qemu_minrampagesize(void);
diff --git a/include/exec/translation-block.h b/include/exec/translation-block.h
index b99afb0077..9c4757882c 100644
--- a/include/exec/translation-block.h
+++ b/include/exec/translation-block.h
@@ -8,7 +8,7 @@
 #define EXEC_TRANSLATION_BLOCK_H
 
 #include "qemu/thread.h"
-#include "exec/cpu-common.h"
+#include "exec/ram_addr.h"
 #include "exec/vaddr.h"
 #ifdef CONFIG_USER_ONLY
 #include "qemu/interval-tree.h"
-- 
2.45.2


