Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98487C4345F
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2024 15:13:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2ubJ-0005oF-8H; Fri, 03 May 2024 11:13:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s2ubG-0005lD-Es
 for qemu-devel@nongnu.org; Fri, 03 May 2024 11:13:26 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s2ubE-00076W-OT
 for qemu-devel@nongnu.org; Fri, 03 May 2024 11:13:26 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1e3ca546d40so80478805ad.3
 for <qemu-devel@nongnu.org>; Fri, 03 May 2024 08:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714749203; x=1715354003; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j2qk0rBcBkKKFEgVV+rMjuUu0W/Dg2i9vyIUDLqamH4=;
 b=BIE5RkmNEdnNaZkd0yv5E3GlkPOEyXoWOE+xt/mAEXv8pC90L7FFw+uFZtMg2BENaX
 2RumZrpG65+41G14yWfkJm8MFNuyEnLXgZjQCST8u7KoZyZ2T0fYHAawLUTTSnT+pcXp
 INNq0ynkd6Wl4xikOxfwXQaRxxbm6vabRYz7dag+RnzKllCvlwzKEubxOmVOVWfx8B4w
 +MYEFTvmBLFLwaPSTymwpv1cc+kjveuQHSDUzROingC0zx+KwBnR9MubSwF5MgBgftWO
 u6MTDKWKRIcQo/hShmQJg/DaEeRdSqx3fX0QIvIYQ1Y0Cwh4hYH6iEJSpL8G0maob8Ie
 trbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714749203; x=1715354003;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=j2qk0rBcBkKKFEgVV+rMjuUu0W/Dg2i9vyIUDLqamH4=;
 b=qlshUi0hmz4MMxfSdEGJ/DVodBglGh4ImhmSfxKqr3Tsi1+JKDY2kdp5K1lTbpG/JG
 bR0YN8rNTMuP4OuKiEJAZz5/1vF9ujMT3CHTNJZPHQmj4ZWTX9yRNJL7rIQnF6ClZbNJ
 L2sx4c04YBLZfzUX1LdyoqDm20JGrMdSvw9zEMDxWAzhvuMzOhymmSQY9KR7qLxvlcgg
 ewMQ3y0RIj1cko4uMR31eQKB7URR1hh0pCK2MUqEZ9axAnWCM3TaYgM9sMOFagto2b7+
 4jOLBuJAr8k/k31fEwi8p/iSDjyLHT83dXZUV+4VPSHSS4JMo3yox8e3+9DKv5HbPt4k
 FzXg==
X-Gm-Message-State: AOJu0YzbB5uc887Babp+1oKhQvQ8ePegTsi6NxQ60KyL1sbMGXBP2GXK
 RnnRwhfHQlqC3yne+LomoDmfP5LUTFn8QoxiImfNzUVD4vFF098hagpa6+/42sYXG8De40oZUlG
 W
X-Google-Smtp-Source: AGHT+IEXRSKnBTz6oqGwJR8uM2WDbBCAMaq4Ef7p0eLFDF30TKAzoaLgm0AuoTcb3UBZWNjxGyyGrQ==
X-Received: by 2002:a17:903:11d0:b0:1e5:5bd7:87a4 with SMTP id
 q16-20020a17090311d000b001e55bd787a4mr3582066plh.16.1714749203332; 
 Fri, 03 May 2024 08:13:23 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 p10-20020a170902c70a00b001e81c778784sm3366611plp.67.2024.05.03.08.13.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 May 2024 08:13:22 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 08/10] util/bufferiszero: Simplify
 test_buffer_is_zero_next_accel
Date: Fri,  3 May 2024 08:13:12 -0700
Message-Id: <20240503151314.336357-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240503151314.336357-1-richard.henderson@linaro.org>
References: <20240503151314.336357-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

Because the three alternatives are monotonic, we don't need
to keep a couple of bitmasks, just identify the strongest
alternative at startup.

Generalize test_buffer_is_zero_next_accel and init_accel
by always defining an accel_table array.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 util/bufferiszero.c | 81 ++++++++++++++++++++-------------------------
 1 file changed, 35 insertions(+), 46 deletions(-)

diff --git a/util/bufferiszero.c b/util/bufferiszero.c
index f9af7841ba..7218154a13 100644
--- a/util/bufferiszero.c
+++ b/util/bufferiszero.c
@@ -27,7 +27,6 @@
 #include "host/cpuinfo.h"
 
 typedef bool (*biz_accel_fn)(const void *, size_t);
-static biz_accel_fn buffer_is_zero_accel;
 
 static bool buffer_is_zero_int_lt256(const void *buf, size_t len)
 {
@@ -179,60 +178,35 @@ buffer_zero_avx2(const void *buf, size_t len)
 }
 #endif /* CONFIG_AVX2_OPT */
 
-static unsigned __attribute__((noinline))
-select_accel_cpuinfo(unsigned info)
-{
-    /* Array is sorted in order of algorithm preference. */
-    static const struct {
-        unsigned bit;
-        biz_accel_fn fn;
-    } all[] = {
+static biz_accel_fn const accel_table[] = {
+    buffer_is_zero_int_ge256,
+    buffer_zero_sse2,
 #ifdef CONFIG_AVX2_OPT
-        { CPUINFO_AVX2,    buffer_zero_avx2 },
+    buffer_zero_avx2,
 #endif
-        { CPUINFO_SSE2,    buffer_zero_sse2 },
-        { CPUINFO_ALWAYS,  buffer_is_zero_int_ge256 },
-    };
+};
 
-    for (unsigned i = 0; i < ARRAY_SIZE(all); ++i) {
-        if (info & all[i].bit) {
-            buffer_is_zero_accel = all[i].fn;
-            return all[i].bit;
-        }
+static unsigned best_accel(void)
+{
+    unsigned info = cpuinfo_init();
+
+#ifdef CONFIG_AVX2_OPT
+    if (info & CPUINFO_AVX2) {
+        return 2;
     }
-    return 0;
+#endif
+    return info & CPUINFO_SSE2 ? 1 : 0;
 }
 
-static unsigned used_accel;
-
-static void __attribute__((constructor)) init_accel(void)
-{
-    used_accel = select_accel_cpuinfo(cpuinfo_init());
-}
-
-#define INIT_ACCEL NULL
-
-bool test_buffer_is_zero_next_accel(void)
-{
-    /*
-     * Accumulate the accelerators that we've already tested, and
-     * remove them from the set to test this round.  We'll get back
-     * a zero from select_accel_cpuinfo when there are no more.
-     */
-    unsigned used = select_accel_cpuinfo(cpuinfo & ~used_accel);
-    used_accel |= used;
-    return used;
-}
 #else
-bool test_buffer_is_zero_next_accel(void)
-{
-    return false;
-}
-
-#define INIT_ACCEL buffer_is_zero_int_ge256
+#define best_accel() 0
+static biz_accel_fn const accel_table[1] = {
+    buffer_is_zero_int_ge256
+};
 #endif
 
-static biz_accel_fn buffer_is_zero_accel = INIT_ACCEL;
+static biz_accel_fn buffer_is_zero_accel;
+static unsigned accel_index;
 
 bool buffer_is_zero_ool(const void *buf, size_t len)
 {
@@ -257,3 +231,18 @@ bool buffer_is_zero_ge256(const void *buf, size_t len)
 {
     return buffer_is_zero_accel(buf, len);
 }
+
+bool test_buffer_is_zero_next_accel(void)
+{
+    if (accel_index != 0) {
+        buffer_is_zero_accel = accel_table[--accel_index];
+        return true;
+    }
+    return false;
+}
+
+static void __attribute__((constructor)) init_accel(void)
+{
+    accel_index = best_accel();
+    buffer_is_zero_accel = accel_table[accel_index];
+}
-- 
2.34.1


