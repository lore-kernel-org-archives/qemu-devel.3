Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E65AED26D7B
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 16:48:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1veFf0-0008Gk-Uh; Fri, 09 Jan 2026 11:48:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1veFen-00084I-Ip
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 11:48:15 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1veFel-0006k8-TX
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 11:48:13 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-47d493a9b96so26645785e9.1
 for <qemu-devel@nongnu.org>; Fri, 09 Jan 2026 08:48:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767977290; x=1768582090; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dXc5hcdRDOQRVV1w0BOluuYdMWqS1m8Oxjrrz11uXg4=;
 b=XasPYLJJq8UKvF42kxxgF28bSZo16V6gn8YE64gdeklam4EhCyn3y3fAJPi6ZaOED4
 O5QyoxOYudWtzO82yBvCokpZWh8J1doOtoKUJjbZGreS1pwMVrq7d2T+DcH6KPUGNMHh
 RTgxbacdzCGeMMHFmhqpTIa4Eg5o3whsiKKCnvZr1rJa7syeMpn+9Z2v3KigUTbWjFLi
 fLjpxKSsT+i+zOYA2fgzrHaOcrqCkPLvXEYh9LyeF6cp9ZnIBJ3/eid2dUIU86iT1WP/
 8ekdonX6i8fKjue9MJjbMiswkn9UHzOjFzVoYjFH6pLDJugcv9o41BMtQZ7jhliVb6Hf
 qx8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767977290; x=1768582090;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dXc5hcdRDOQRVV1w0BOluuYdMWqS1m8Oxjrrz11uXg4=;
 b=cTxe9XGW/gkK6R5hWGIJqWxTS0J9BhkeQ/zwdbVxX5S+tkJ2RNJSrLqzXdCFZyYpwE
 7GdjWbhpkooDL9EK5T8q+E558VsTiFsB9M1C4LWeMGuskH46Ub+pwZ0+D+FF3an3Ku8S
 GoQRZzqLEv12VBRrpAFeib1XQqBBi066FcaLVs6BDZCjioHPb3MYYG/xmy+sRoDxSSpR
 SL9OkjMb8bVsM88O22Ec2N5d8HE2M8SwiJunb7CzA/D5k5ZAiCXmUFYs/3ba/R4Gd737
 Nt9eHE7GRSTqAcKLotr07jZQGqpLrFvmPCq4ve3q8KunCgrsFggQLf6ZIeP5ss+bienO
 Z62Q==
X-Gm-Message-State: AOJu0YyWjTTE7BG6PlWJQhekcx/RheMhbmaurEkslJ1zghDQ3rfpCvJ6
 ZEOyCP+M8ElrWO+PRn9XZSBE5apq7YPW3TBo8EaevV1zE5coqpmvg1bnRFoX9ErFPSv4M88J6kc
 LVLpE2+s=
X-Gm-Gg: AY/fxX7zFAj5l7DUTGkX4rEOhsJ6g1mCDRv4HU6p3mk+TiVx/vz7QaG7+vc2mqmrTWM
 qZuaffoaSr8PtB4ir+9NKZqEn0z0i/ShjJAT2wsOPPVauBHQUe2ypu8ArdYMfgMlpPJKN7IZ4M1
 pEy3IFZikuRM+77YFKDcyP7kXcEG5Cjp/o25Rqn+CiKNMKik5xdjG0QsCsd/C5kDKLRsb+XaUqg
 wcVQRw8RsUPIubF53oy8OYZgYsE8QLwyJsKWlp2+Sstmq9U6wQpGlnOsj7PL3lAqSCyXXpm9ACB
 5QOeIngc1+LAx+9tXF5fKl3t+M2r1s3JFxyT3zIQ20z767ktMuEQIgHkDLe84sGE260JwmDACaK
 TSCNHxOwKrIuMzllIfiU8tBrx8s9PcbB3zY7yNbZPE/lj/DWgSObXpDDoomnK1p0PuHpatVhBhV
 i9cno9EEn7oVq+Mzj+zB4wfsk8akMYLahe+jEXsXCNhWZymEwEVMSqxdzuM2+Z
X-Google-Smtp-Source: AGHT+IHNn0rzJon3y3WGWkePTOpXyXl3TkEHJnHVUwJybm3GZ19wK90UqfTyyF8zi/UQMxwmzM1Jeg==
X-Received: by 2002:a05:600c:3e8f:b0:477:5897:a0c4 with SMTP id
 5b1f17b1804b1-47d84b0b315mr115590995e9.4.1767977290096; 
 Fri, 09 Jan 2026 08:48:10 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d7f668e03sm227215895e9.14.2026.01.09.08.48.09
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 09 Jan 2026 08:48:09 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v2 4/4] bswap: Consistently use builtin bswap() functions
Date: Fri,  9 Jan 2026 17:47:42 +0100
Message-ID: <20260109164742.58041-5-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260109164742.58041-1-philmd@linaro.org>
References: <20260109164742.58041-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Since these headers use some __builtin_bswap*(), use it
consistently in all the cases, allowing to remove the
"qemu/bswap.h" inclusion (which only defines bswap* to
the builtin equivalent).

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/qemu/host-utils.h | 7 +++----
 include/qemu/int128.h     | 7 +++----
 2 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/include/qemu/host-utils.h b/include/qemu/host-utils.h
index dd558589cb5..181d026b6c7 100644
--- a/include/qemu/host-utils.h
+++ b/include/qemu/host-utils.h
@@ -30,7 +30,6 @@
 #ifndef HOST_UTILS_H
 #define HOST_UTILS_H
 
-#include "qemu/bswap.h"
 #include "qemu/int128.h"
 
 #ifdef CONFIG_INT128
@@ -380,7 +379,7 @@ static inline uint16_t revbit16(uint16_t x)
     return __builtin_bitreverse16(x);
 #else
     /* Assign the correct byte position.  */
-    x = bswap16(x);
+    x = __builtin_bswap16(x);
     /* Assign the correct nibble position.  */
     x = ((x & 0xf0f0) >> 4)
       | ((x & 0x0f0f) << 4);
@@ -403,7 +402,7 @@ static inline uint32_t revbit32(uint32_t x)
     return __builtin_bitreverse32(x);
 #else
     /* Assign the correct byte position.  */
-    x = bswap32(x);
+    x = __builtin_bswap32(x);
     /* Assign the correct nibble position.  */
     x = ((x & 0xf0f0f0f0u) >> 4)
       | ((x & 0x0f0f0f0fu) << 4);
@@ -426,7 +425,7 @@ static inline uint64_t revbit64(uint64_t x)
     return __builtin_bitreverse64(x);
 #else
     /* Assign the correct byte position.  */
-    x = bswap64(x);
+    x = __builtin_bswap64(x);
     /* Assign the correct nibble position.  */
     x = ((x & 0xf0f0f0f0f0f0f0f0ull) >> 4)
       | ((x & 0x0f0f0f0f0f0f0f0full) << 4);
diff --git a/include/qemu/int128.h b/include/qemu/int128.h
index 174bd7dafb8..7b3b071c512 100644
--- a/include/qemu/int128.h
+++ b/include/qemu/int128.h
@@ -1,8 +1,6 @@
 #ifndef INT128_H
 #define INT128_H
 
-#include "qemu/bswap.h"
-
 /*
  * With TCI, we need to use libffi for interfacing with TCG helpers.
  * But libffi does not support __int128_t, and therefore cannot pass
@@ -189,7 +187,8 @@ static inline Int128 bswap128(Int128 a)
 #if __has_builtin(__builtin_bswap128)
     return __builtin_bswap128(a);
 #else
-    return int128_make128(bswap64(int128_gethi(a)), bswap64(int128_getlo(a)));
+    return int128_make128(__builtin_bswap64(int128_gethi(a)),
+                          __builtin_bswap64(int128_getlo(a)));
 #endif
 }
 
@@ -451,7 +450,7 @@ static inline void int128_subfrom(Int128 *a, Int128 b)
 
 static inline Int128 bswap128(Int128 a)
 {
-    return int128_make128(bswap64(a.hi), bswap64(a.lo));
+    return int128_make128(__builtin_bswap64(a.hi), __builtin_bswap64(a.lo));
 }
 
 static inline int clz128(Int128 a)
-- 
2.52.0


