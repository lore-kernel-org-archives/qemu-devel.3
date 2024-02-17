Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD64FC48BF6
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Feb 2024 00:41:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rb8jv-00068D-2n; Fri, 16 Feb 2024 19:39:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rb8js-00066B-RI
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 19:39:32 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rb8jr-0008Gf-5d
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 19:39:32 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1d780a392fdso13142115ad.3
 for <qemu-devel@nongnu.org>; Fri, 16 Feb 2024 16:39:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708130369; x=1708735169; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kPtJ2gcWQWVvl3eYL4tk0YOKmkXHenThqZDsJAXs+wo=;
 b=w9v4enFkGQirt/QzMAfau+pLcveXFzQyKo0fgxliLLY8+uiEAfDWgtaKZZJz9DGtyN
 CUyqks8yqI7JYZHLVafKx7zZEvN1zRfZiZ1h3DNtwH58xo4oOl6y+a7B74em2SaZdULs
 XpYvsLDhyMfr9rF1F+EGX7jAeUrFRZ5U8lniS72CYdA1gYZgrgO9TBR7YbMKM0W45Gwd
 OiePKYghCstYwPSQX7ZNGMv4QG6PgaaijaKBHFL5dw6O+nqNxDxSMNY+fKcDWdHK6EHF
 Jukl1ahAZTEa+Mw9aW/HEVeRose0O6C/QhUuWp0Spb5qyzwlsTgkOCtwXSozHNznDqxm
 yAuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708130369; x=1708735169;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kPtJ2gcWQWVvl3eYL4tk0YOKmkXHenThqZDsJAXs+wo=;
 b=L4/IUPgj0kmHhv0SWXQeBReX0TdCq3uju10HPIZFABDGzfQtYBpYVe9wlaBCdh1O2m
 8iLCvCWllWx5Md+R1VdtX21AA/siRDHJHOzEh5oyNq0RU7UjcAVKkbvNQzKxGUKiCvrP
 vQdp498s0WxxxjzOjRJGFRgvfLfB/N7TeIadtWq81u5uOs8PqDUhfAdP7a4erG1zwJz4
 tNcKdDEIHgURsaCLI1dDgJOvDTDn5Pm/I7qGZseXsjc7ArG7dfMczp9KFclyedXhYq1Z
 AZJ++8irXfYCRmnNAxJ8DCwY4aA+ItFsKAyn1sz09K0FV1nlxe9e4lrGdjh6TlzP/Wly
 AjAQ==
X-Gm-Message-State: AOJu0YxVayY8aR9G1xe1DHtE8vdcE3/KO2YseCmJf0llMnjPQS2X1Kk3
 2luTQlF5Obc/O4JOu5acbYWhJ58oE21zfqeEGhbqgTuLPxmOAna0iPgPhHJ3Rkb2rtrkkOgpGlZ
 F
X-Google-Smtp-Source: AGHT+IGkHYZgS696sSl38aVvJR6UGC1iQh6bdpyTs7DS/bc1uhc3VAOguwaOZW0igpHQdexRfB0BDw==
X-Received: by 2002:a17:903:2352:b0:1d9:bf90:2f1b with SMTP id
 c18-20020a170903235200b001d9bf902f1bmr7600846plh.53.1708130369517; 
 Fri, 16 Feb 2024 16:39:29 -0800 (PST)
Received: from stoup.. (173-197-098-125.biz.spectrum.com. [173.197.98.125])
 by smtp.gmail.com with ESMTPSA id
 z6-20020a170902ee0600b001d90306bdcfsm419325plb.65.2024.02.16.16.39.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Feb 2024 16:39:29 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: amonakov@ispras.ru,
	mmromanov@ispras.ru
Subject: [PATCH v5 06/10] util/bufferiszero: Improve scalar variant
Date: Fri, 16 Feb 2024 14:39:14 -1000
Message-Id: <20240217003918.52229-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240217003918.52229-1-richard.henderson@linaro.org>
References: <20240217003918.52229-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

Split less-than and greater-than 256 cases.
Use unaligned accesses for head and tail.
Avoid using out-of-bounds pointers in loop boundary conditions.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 util/bufferiszero.c | 86 +++++++++++++++++++++++++++------------------
 1 file changed, 52 insertions(+), 34 deletions(-)

diff --git a/util/bufferiszero.c b/util/bufferiszero.c
index 02df82b4ff..a904b747c7 100644
--- a/util/bufferiszero.c
+++ b/util/bufferiszero.c
@@ -28,40 +28,58 @@
 
 static bool (*buffer_is_zero_accel)(const void *, size_t);
 
-static bool buffer_is_zero_integer(const void *buf, size_t len)
+static bool buffer_is_zero_int_lt256(const void *buf, size_t len)
 {
-    if (unlikely(len < 8)) {
-        /* For a very small buffer, simply accumulate all the bytes.  */
-        const unsigned char *p = buf;
-        const unsigned char *e = buf + len;
-        unsigned char t = 0;
+    uint64_t t;
+    const uint64_t *p, *e;
 
-        do {
-            t |= *p++;
-        } while (p < e);
-
-        return t == 0;
-    } else {
-        /* Otherwise, use the unaligned memory access functions to
-           handle the beginning and end of the buffer, with a couple
-           of loops handling the middle aligned section.  */
-        uint64_t t = ldq_he_p(buf);
-        const uint64_t *p = (uint64_t *)(((uintptr_t)buf + 8) & -8);
-        const uint64_t *e = (uint64_t *)(((uintptr_t)buf + len) & -8);
-
-        for (; p + 8 <= e; p += 8) {
-            if (t) {
-                return false;
-            }
-            t = p[0] | p[1] | p[2] | p[3] | p[4] | p[5] | p[6] | p[7];
-        }
-        while (p < e) {
-            t |= *p++;
-        }
-        t |= ldq_he_p(buf + len - 8);
-
-        return t == 0;
+    /*
+     * Use unaligned memory access functions to handle
+     * the beginning and end of the buffer, with a couple
+     * of loops handling the middle aligned section.
+     */
+    if (unlikely(len <= 8)) {
+        return (ldl_he_p(buf) | ldl_he_p(buf + len - 4)) == 0;
     }
+
+    t = ldq_he_p(buf) | ldq_he_p(buf + len - 8);
+    p = QEMU_ALIGN_PTR_DOWN(buf + 8, 8);
+    e = QEMU_ALIGN_PTR_DOWN(buf + len - 1, 8);
+
+    while (p < e) {
+        t |= *p++;
+    }
+    return t == 0;
+}
+
+static bool buffer_is_zero_int_ge256(const void *buf, size_t len)
+{
+    /*
+     * Use unaligned memory access functions to handle
+     * the beginning and end of the buffer, with a couple
+     * of loops handling the middle aligned section.
+     */
+    uint64_t t = ldq_he_p(buf) | ldq_he_p(buf + len - 8);
+    const uint64_t *p = QEMU_ALIGN_PTR_DOWN(buf + 8, 8);
+    const uint64_t *e = QEMU_ALIGN_PTR_DOWN(buf + len - 1, 8);
+
+    /* Collect a partial block at the tail end. */
+    t |= e[-7] | e[-6] | e[-5] | e[-4] | e[-3] | e[-2] | e[-1];
+
+    /*
+     * Loop over 64 byte blocks.
+     * With the head and tail removed, e - p >= 30,
+     * so the loop must iterate at least 3 times.
+     */
+    do {
+        if (t) {
+            return false;
+        }
+        t = p[0] | p[1] | p[2] | p[3] | p[4] | p[5] | p[6] | p[7];
+        p += 8;
+    } while (p < e - 7);
+
+    return t == 0;
 }
 
 #if defined(CONFIG_AVX2_OPT) || defined(__SSE2__)
@@ -173,7 +191,7 @@ select_accel_cpuinfo(unsigned info)
         { CPUINFO_AVX2,    buffer_zero_avx2 },
 #endif
         { CPUINFO_SSE2,    buffer_zero_sse2 },
-        { CPUINFO_ALWAYS,  buffer_is_zero_integer },
+        { CPUINFO_ALWAYS,  buffer_is_zero_int_ge256 },
     };
 
     for (unsigned i = 0; i < ARRAY_SIZE(all); ++i) {
@@ -211,7 +229,7 @@ bool test_buffer_is_zero_next_accel(void)
     return false;
 }
 
-#define INIT_ACCEL buffer_is_zero_integer
+#define INIT_ACCEL buffer_is_zero_int_ge256
 #endif
 
 static bool (*buffer_is_zero_accel)(const void *, size_t) = INIT_ACCEL;
@@ -232,7 +250,7 @@ bool buffer_is_zero_ool(const void *buf, size_t len)
     if (likely(len >= 256)) {
         return buffer_is_zero_accel(buf, len);
     }
-    return buffer_is_zero_integer(buf, len);
+    return buffer_is_zero_int_lt256(buf, len);
 }
 
 bool buffer_is_zero_ge256(const void *buf, size_t len)
-- 
2.34.1


