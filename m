Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4337E7545C
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Dec 2025 15:23:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vYQhG-0000XG-1R; Wed, 24 Dec 2025 10:22:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vYQh0-0000Wi-UK
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 10:22:29 -0500
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vYQgz-0004Z6-AJ
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 10:22:26 -0500
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-64d30dc4ed7so6047574a12.0
 for <qemu-devel@nongnu.org>; Wed, 24 Dec 2025 07:22:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766589743; x=1767194543; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hkVIzod7Jlt9VwHGoLmEeZpRAVX+tz7dmFt8d4zgWHg=;
 b=RQN6DnewFJNGfyf4temC/2rz5Ry+mCgRKmdNBN83TG2q64oEj83xNIP4HZdw6BfIVr
 HeG9M5YiL+If0hebFZIz8A4gg+JX76TM6YZnpKD36MazeBwzk4uxqIwq2PumqQkEqCbU
 z9rXvn5a3yITxEegOtLZKWucoG2qh9GVqhzFzmKYQYVCDuSEcfb/xZ5SVZ7y/ylP+VWt
 Y6/1+UZAShTfXhxaKxxKDiezWslTBBf46f88stKV5D1SJQByxqwzuXU1N8gTHJ0nLDnj
 bSQWmSFgNIptQo3Iozka8qCELY0ZEheE0epGTNA8BLypQ2GSs90RkbHnIlDgbu7Ydh9t
 tyYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766589743; x=1767194543;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hkVIzod7Jlt9VwHGoLmEeZpRAVX+tz7dmFt8d4zgWHg=;
 b=XF5fmcuPDaT3CQxa+wH350kPGyS75lJPms+l1MH0KmRMvUMqvG3oy99cRcgKuKXZWA
 fkhXRVFhAaywoJyeE0KXi7t6OWrLg63OKMrmPGw8Cx7btALAnr2N06eVMOoiSbIE8Z6D
 DuJeivrJWvk6SOO2bRFcO4KFsLFGvK7JMPi4eUQBXoNMxVYlVhJIsDpsrw+3NM+oDNeu
 AckXbxFAJieb/K64h8TvuQ5aYW+94uGt0ONoISfEUyuz6CpXXJKPYlGTa8cauhP+eOdQ
 vlzF6ZDueb4XY6IXXmW5wbtAa4kLM9ECFTgh6uvcwtYzssUr6tBuuE/wNvbcbch/LRqT
 V2EQ==
X-Gm-Message-State: AOJu0YxQOw6EI36RkF+u53vJ9YaHdNvVRchGcZ0ayke/5Jhr53qzd1Il
 3Jb28QQFZgsk8JEKyWsUyx7Gq3IFpU4qRP9Z4NNDodt0QqubtKfqJMn1rFGuu9brsuhbTuqkkG2
 xyvei9sw=
X-Gm-Gg: AY/fxX7HgmK8hdb8JVeCugxYiWivU38V0G62xWfSl1yYyu22ONQA8m1HMMue6l0v2RP
 K5PGkMt0EZSeTX6uMbMD385xJnyVC6k2E8PtiAeFxAbBZ13A46hxDB8I0qKROjVgpezRHK211lo
 vvdemedCZgZcJDHU/oH2Y9CYoBseiJhs2rBR4mjbWlVAUUJoffgKxTY3uGxjIF+3XJNwsjKH4jS
 fac/eSFdRLgHK15+UZlGHoBsr6QUUIN7gA6QmyAglJXhwoOaR0VSiGc8D5wlXzXsDqFMt7esH8Z
 FyI9o+h2xmmnCTPoTY0lDnWMT0OtZV0wDa5TTzKiYlRqsec8KX21QBGfcslwxOTlzw6o5GysnBf
 W7T+voO7fOVAEvF2BTIh0fhsr4ck4jiY8CZXGqPTJSI+lhxz+TKw/hl4pfpsMa3Up0RtEhiykuY
 RTxBu8lM1CQxk+Z274trRb9oeKWJMXcd+AkrqEFAn3g9BYuObDLDXahDJorxvM
X-Google-Smtp-Source: AGHT+IFCFP/Ws3smhbQ3ehynm4pyGDC9i8FAOml6nKbdNtopSP407NTKck6KGvaBY0p+NtUgYyY6jw==
X-Received: by 2002:a17:907:e109:b0:b80:4030:1eca with SMTP id
 a640c23a62f3a-b804030298fmr1323500966b.2.1766589743301; 
 Wed, 24 Dec 2025 07:22:23 -0800 (PST)
Received: from localhost.localdomain (188.171.88.92.rev.sfr.net.
 [92.88.171.188]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8037ae2de9sm1833760166b.26.2025.12.24.07.22.19
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 24 Dec 2025 07:22:22 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 David Hildenbrand <david@kernel.org>
Subject: [PATCH v3 01/25] system/physmem: Inline and remove leul_to_cpu()
Date: Wed, 24 Dec 2025 16:21:44 +0100
Message-ID: <20251224152210.87880-2-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251224152210.87880-1-philmd@linaro.org>
References: <20251224152210.87880-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52d.google.com
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

leul_to_cpu() is only used within physmem.c: inline it
and remove.
Since @bitmap is of 'unsigned long' type, use its size
with ldn_le_p() instead of using HOST_LONG_BITS.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/qemu/bswap.h | 11 -----------
 system/physmem.c     |  5 +++--
 2 files changed, 3 insertions(+), 13 deletions(-)

diff --git a/include/qemu/bswap.h b/include/qemu/bswap.h
index 39ba64046a6..65a1b3634f4 100644
--- a/include/qemu/bswap.h
+++ b/include/qemu/bswap.h
@@ -375,17 +375,6 @@ static inline void stq_be_p(void *ptr, uint64_t v)
     stq_he_p(ptr, be_bswap(v, 64));
 }
 
-static inline unsigned long leul_to_cpu(unsigned long v)
-{
-#if HOST_LONG_BITS == 32
-    return le_bswap(v, 32);
-#elif HOST_LONG_BITS == 64
-    return le_bswap(v, 64);
-#else
-# error Unknown sizeof long
-#endif
-}
-
 /* Store v to p as a sz byte value in host order */
 #define DO_STN_LDN_P(END) \
     static inline void stn_## END ## _p(void *ptr, int sz, uint64_t v)  \
diff --git a/system/physmem.c b/system/physmem.c
index c9869e4049f..1292f49095f 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -1254,7 +1254,8 @@ uint64_t physical_memory_set_dirty_lebitmap(unsigned long *bitmap,
 
             for (k = 0; k < nr; k++) {
                 if (bitmap[k]) {
-                    unsigned long temp = leul_to_cpu(bitmap[k]);
+                    unsigned long temp = ldn_le_p(&bitmap[k],
+                                                  sizeof(bitmap[k]));
 
                     nbits = ctpopl(temp);
                     qatomic_or(&blocks[DIRTY_MEMORY_VGA][idx][offset], temp);
@@ -1301,7 +1302,7 @@ uint64_t physical_memory_set_dirty_lebitmap(unsigned long *bitmap,
          */
         for (i = 0; i < len; i++) {
             if (bitmap[i] != 0) {
-                c = leul_to_cpu(bitmap[i]);
+                c = ldn_le_p(&bitmap[i], sizeof(bitmap[i]));
                 nbits = ctpopl(c);
                 if (unlikely(global_dirty_tracking & GLOBAL_DIRTY_DIRTY_RATE)) {
                     total_dirty_pages += nbits;
-- 
2.52.0


