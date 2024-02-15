Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7852C48BEB
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 06:25:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raV78-0002Oa-7p; Thu, 15 Feb 2024 01:20:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1raV75-0002NK-W5
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 01:20:52 -0500
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1raV74-0005WV-0o
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 01:20:51 -0500
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-517ab9a4a13so472684a12.1
 for <qemu-devel@nongnu.org>; Wed, 14 Feb 2024 22:20:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707978049; x=1708582849; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t1OILcn76v2zPwlGFZzc7UG2ju3QgEVusg1rS5CPk58=;
 b=YLx2hBbNTAcc2lkKvVj7S/7psvZupK5l5Idvj8nUz1B6eK6uS3jg33zMykD9YxPIlS
 O7RWo69eldz6OBG0A+/8/U1Me9lOxVe7ehFNnK/I8tATvIkAVfjJKJVW0zBE4IvqWoE8
 fFrz8objzloX6GHOQF13dK9UCh/kPiBGPCCKHdS360X9+9pAdaoRAl6H42NDCZsapk5y
 6qjTIqD76VyjEnCkVdrn+RIk7YYUNV0VW60+grOgL3uVgUp08icXnIi/I9wFF5g4dGak
 aeheE6zLB0vWefsLY3EQHgIxOmFTlOD5/aS7mmMrkv/uz1R+GehIKVhQFsV+NUR59kSO
 dW7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707978049; x=1708582849;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=t1OILcn76v2zPwlGFZzc7UG2ju3QgEVusg1rS5CPk58=;
 b=ZZaEFlPgDcscVFOpJ/46zdSxJHdmFj1+mR/S0YKkYGKVFhjAKlZz+uDYUPAqCDx4F6
 9UfXQnoI6A3fIpf7a5V0NrAbyyaRms/WU2tOggsz9FJMvztiu+SEwIm/501oYctNBuJ4
 TjIKaWTNwAAwoZNl0azxhQNAQDTZo1C2LvRm4473l9w7aFJfL87MHaHvBHD7YYxn/EvM
 DHcRFR7GGMC9/fLFODKTSd/Cv8ZAjWfBz0sZAAZYwuXBafS4qCoF5oIoFthpiF2lUHt4
 Mr8JRo3CM+zdx3p8KGN8FTIE+oznlDu59K4IZeuSnjxhzwq2yoQtokkF2vS8x5dfsOaw
 H3DA==
X-Gm-Message-State: AOJu0YyifhHRhWgmNRT1UYwjbx2c3of8WQOJFb17n7HVYqQMqZ68+nI9
 G0+AK0eWT0m66eBHDazhlv4WCvqeI0VXoiFDRSoeaa0UOwyQgrgeh8Ij1ltLgvlLb4uGmVKvZ9n
 c
X-Google-Smtp-Source: AGHT+IGhxIMzeR1o5Qi3VF56p8ZnWYRSxcy6xFjU+t23KSi2u1iWJdkwHoZ0iIiOzGCGEJlHGgRkgQ==
X-Received: by 2002:a17:90a:d301:b0:296:2afe:25e with SMTP id
 p1-20020a17090ad30100b002962afe025emr892906pju.32.1707978048754; 
 Wed, 14 Feb 2024 22:20:48 -0800 (PST)
Received: from stoup.. (173-197-098-125.biz.spectrum.com. [173.197.98.125])
 by smtp.gmail.com with ESMTPSA id
 d5-20020a170902b70500b001d6f29c12f7sm464418pls.135.2024.02.14.22.20.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Feb 2024 22:20:48 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Helge Deller <deller@gmx.de>
Subject: [PATCH v4 19/36] linux-user: Split out mmap_end
Date: Wed, 14 Feb 2024 20:20:01 -1000
Message-Id: <20240215062018.795056-20-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240215062018.795056-1-richard.henderson@linaro.org>
References: <20240215062018.795056-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x536.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Use a subroutine instead of a goto within target_mmap__locked.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
Acked-by: Helge Deller <deller@gmx.de>
Message-Id: <20240102015808.132373-20-richard.henderson@linaro.org>
---
 linux-user/mmap.c | 71 +++++++++++++++++++++++++++--------------------
 1 file changed, 41 insertions(+), 30 deletions(-)

diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index 48fcdd4a32..cc983bedbd 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -490,6 +490,43 @@ abi_ulong mmap_find_vma(abi_ulong start, abi_ulong size, abi_ulong align)
     }
 }
 
+/*
+ * Record a successful mmap within the user-exec interval tree.
+ */
+static abi_long mmap_end(abi_ulong start, abi_ulong last,
+                         abi_ulong passthrough_start,
+                         abi_ulong passthrough_last,
+                         int flags, int page_flags)
+{
+    if (flags & MAP_ANONYMOUS) {
+        page_flags |= PAGE_ANON;
+    }
+    page_flags |= PAGE_RESET;
+    if (passthrough_start > passthrough_last) {
+        page_set_flags(start, last, page_flags);
+    } else {
+        if (start < passthrough_start) {
+            page_set_flags(start, passthrough_start - 1, page_flags);
+        }
+        page_set_flags(passthrough_start, passthrough_last,
+                       page_flags | PAGE_PASSTHROUGH);
+        if (passthrough_last < last) {
+            page_set_flags(passthrough_last + 1, last, page_flags);
+        }
+    }
+    shm_region_rm_complete(start, last);
+    trace_target_mmap_complete(start);
+    if (qemu_loglevel_mask(CPU_LOG_PAGE)) {
+        FILE *f = qemu_log_trylock();
+        if (f) {
+            fprintf(f, "page layout changed following mmap\n");
+            page_dump(f);
+            qemu_log_unlock(f);
+        }
+    }
+    return start;
+}
+
 static abi_long target_mmap__locked(abi_ulong start, abi_ulong len,
                                     int target_prot, int flags, int page_flags,
                                     int fd, off_t offset)
@@ -632,7 +669,7 @@ static abi_long target_mmap__locked(abi_ulong start, abi_ulong len,
                 ret = target_mprotect(start, len, target_prot);
                 assert(ret == 0);
             }
-            goto the_end;
+            return mmap_end(start, last, -1, 0, flags, page_flags);
         }
 
         /* handle the start of the mapping */
@@ -643,7 +680,7 @@ static abi_long target_mmap__locked(abi_ulong start, abi_ulong len,
                                target_prot, flags, fd, offset)) {
                     return -1;
                 }
-                goto the_end;
+                return mmap_end(start, last, -1, 0, flags, page_flags);
             }
             if (!mmap_frag(real_start, start,
                            real_start + host_page_size - 1,
@@ -690,34 +727,8 @@ static abi_long target_mmap__locked(abi_ulong start, abi_ulong len,
             passthrough_last = real_last;
         }
     }
- the_end:
-    if (flags & MAP_ANONYMOUS) {
-        page_flags |= PAGE_ANON;
-    }
-    page_flags |= PAGE_RESET;
-    if (passthrough_start > passthrough_last) {
-        page_set_flags(start, last, page_flags);
-    } else {
-        if (start < passthrough_start) {
-            page_set_flags(start, passthrough_start - 1, page_flags);
-        }
-        page_set_flags(passthrough_start, passthrough_last,
-                       page_flags | PAGE_PASSTHROUGH);
-        if (passthrough_last < last) {
-            page_set_flags(passthrough_last + 1, last, page_flags);
-        }
-    }
-    shm_region_rm_complete(start, last);
-    trace_target_mmap_complete(start);
-    if (qemu_loglevel_mask(CPU_LOG_PAGE)) {
-        FILE *f = qemu_log_trylock();
-        if (f) {
-            fprintf(f, "page layout changed following mmap\n");
-            page_dump(f);
-            qemu_log_unlock(f);
-        }
-    }
-    return start;
+    return mmap_end(start, last, passthrough_start, passthrough_last,
+                    flags, page_flags);
 }
 
 /* NOTE: all the constants are the HOST ones */
-- 
2.34.1


