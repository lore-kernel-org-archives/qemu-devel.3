Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E9B7CAC5B0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 09:16:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4FMg-0005u1-Hx; Thu, 02 Oct 2025 05:12:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v4FMe-0005tL-26
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 05:12:41 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v4FME-0002WC-K6
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 05:12:39 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-46e326e4e99so10646325e9.1
 for <qemu-devel@nongnu.org>; Thu, 02 Oct 2025 02:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759396328; x=1760001128; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E5i3kC5TI+8HL+d/5fQ2rHWMtMwDQb+xa/XGlcT3N6c=;
 b=FcW8D4VP/gqj2U0+aepdx+nQj485bP0jWwTmz9qdh+i9RebQfqA0k+6V9kuBV2Af98
 fESrxfbCxY5punaFZdFBcZQQG/TOVuUH8JiOR3qvDDJRuKDE9TcqAdjww8ZHmuRrYSbZ
 psEolZvUFPoZ2Blh0C7KePV5EXBntca8VN5+LJ1S8FlJR5UJH9UP/O2pz11bfMCbStEb
 yBUK7YG2GTSrVOMV0RucmbcJcmR3RPE5kCr7bc6mSmRVJ4HwUpuFrJS8q3kBd6jsR2yA
 c2OWuwE19FMVBwqHEq/5kQA9nGFO81sXdH5pPgFx/QSN+aChIumnRLF79EM/mendTVG6
 Zqqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759396328; x=1760001128;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E5i3kC5TI+8HL+d/5fQ2rHWMtMwDQb+xa/XGlcT3N6c=;
 b=Mnggq3gB3GKRISJuKntK/HpdJnYUw+qlXSVeuQQNBjPw3eXTLvTQwqrnb5jZ0L+pIt
 81FBP4QvSYR1FqFYj/X8Cdd1sxVFqK9/jP+bJ0a0vsKWnENUB66dpFxKaggxwY/oZC+z
 D5QmqLjtWGTsAkYWJw9ACsCL1QMOY51cGCtz5UKO8h8tA1U3dhL7xMAhNf/ZeaXCr2XE
 TtZwxanSGlJhF89bjKGPjzVs5YifTQPTjqmD15LI0ra+G+4CBMWF4gIugeUZRKh2G3Oe
 esNv5Fh0kV4cbY2HzHM0lB69TIHif1/qUt1BGI2hV9ipCP2pH+abmpzhneXaXPZ0Boqo
 xStQ==
X-Gm-Message-State: AOJu0YwrffiHclIFDie8qqJnMCdcsKIp3ZFL8kmb5Amhap0cVK5Z81rO
 upUBOu3wP5RwZzovOuJCEo9D2RGx+sQ1KGQz+G8yJZkqV3kUWiLZfeK30tXEbLjIlPW5auFArXo
 cTQQ8CZLlOw==
X-Gm-Gg: ASbGncseXaxb6LoNwFofy7x9F+12Ilr+oGTj4hcITJbQgcanAMOapacsjp1qByw9gro
 4fhxxo4ifdHRmy7J3KxOiVKCoc2FqF+WhGPye8XynnoEleuvaXqpBF35HqXgkSFBpm/oxyMp0wG
 6xw15L5k5v0HFtRw/+eKM7Z55gJJJAoxRFTzMp+5GkKJgdztHpK/6drKBR862XuDfK7BLUZqT8C
 BL3Oddgi2ZQQC+uwSEXFSgneMO6CxjEEpbyiRJgpTHvhYT//VU0UvrUaLaclaqcvXnhWPvApet3
 HmenmWaIgKfa2WbjtTyyPhrnJLf2q/qTg7zeOCLXxgO4nk7pt7O0noG+Hjgj9k1mO0bls0HHwUD
 2o1ejN7d1G0i0/8F32vzJzhV7yH4a+57duHenslqahex0mKO5mEOYoi59hfhDxZ1qEmiZ+yQba9
 AD7s7O8cw6VBguYfllDxkJq7aM2kcYyA==
X-Google-Smtp-Source: AGHT+IEFMx4IIWWMWAAZi5nmfyx6AoW34PPMRvPgRABxL+CuW9ltTm2Y1KFxP6Dqc8Orf4iYhupoEw==
X-Received: by 2002:a05:6000:1861:b0:404:c253:a38 with SMTP id
 ffacd0b85a97d-4255d2d640fmr1601685f8f.28.1759396328077; 
 Thu, 02 Oct 2025 02:12:08 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e6917a577sm25991755e9.1.2025.10.02.02.12.07
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 02 Oct 2025 02:12:07 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 7/9] target/s390x: Reduce s390_store_adtl_status() scope
Date: Thu,  2 Oct 2025 11:11:30 +0200
Message-ID: <20251002091132.65703-8-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251002091132.65703-1-philmd@linaro.org>
References: <20251002091132.65703-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

s390_store_adtl_status() is only called within sigp.c,
move it and the SigpAdtlSaveArea structure definition
there where it belongs, with other SIGP handling code.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/s390x/s390x-internal.h |  1 -
 target/s390x/helper.c         | 40 -----------------------------------
 target/s390x/sigp.c           | 40 +++++++++++++++++++++++++++++++++++
 3 files changed, 40 insertions(+), 41 deletions(-)

diff --git a/target/s390x/s390x-internal.h b/target/s390x/s390x-internal.h
index 1fb752aa1d6..a49dca94a75 100644
--- a/target/s390x/s390x-internal.h
+++ b/target/s390x/s390x-internal.h
@@ -325,7 +325,6 @@ hwaddr s390_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
 hwaddr s390_cpu_get_phys_addr_debug(CPUState *cpu, vaddr addr);
 #define S390_STORE_STATUS_DEF_ADDR offsetof(LowCore, floating_pt_save_area)
 int s390_store_status(S390CPU *cpu, hwaddr addr, bool store_arch);
-int s390_store_adtl_status(S390CPU *cpu, hwaddr addr, hwaddr len);
 LowCore *cpu_map_lowcore(CPUS390XState *env);
 void cpu_unmap_lowcore(CPUS390XState *env, LowCore *lowcore);
 #endif /* CONFIG_USER_ONLY */
diff --git a/target/s390x/helper.c b/target/s390x/helper.c
index b01b7d9bbbf..84321e1d68e 100644
--- a/target/s390x/helper.c
+++ b/target/s390x/helper.c
@@ -248,43 +248,3 @@ int s390_store_status(S390CPU *cpu, hwaddr addr, bool store_arch)
 
     return 0;
 }
-
-typedef struct SigpAdtlSaveArea {
-    uint64_t    vregs[32][2];                     /* 0x0000 */
-    uint8_t     pad_0x0200[0x0400 - 0x0200];      /* 0x0200 */
-    uint64_t    gscb[4];                          /* 0x0400 */
-    uint8_t     pad_0x0420[0x1000 - 0x0420];      /* 0x0420 */
-} SigpAdtlSaveArea;
-QEMU_BUILD_BUG_ON(sizeof(SigpAdtlSaveArea) != 4096);
-
-#define ADTL_GS_MIN_SIZE 2048 /* minimal size of adtl save area for GS */
-int s390_store_adtl_status(S390CPU *cpu, hwaddr addr, hwaddr len)
-{
-    SigpAdtlSaveArea *sa;
-    hwaddr save = len;
-    int i;
-
-    sa = cpu_physical_memory_map(addr, &save, true);
-    if (!sa) {
-        return -EFAULT;
-    }
-    if (save != len) {
-        cpu_physical_memory_unmap(sa, len, 1, 0);
-        return -EFAULT;
-    }
-
-    if (s390_has_feat(S390_FEAT_VECTOR)) {
-        for (i = 0; i < 32; i++) {
-            sa->vregs[i][0] = cpu_to_be64(cpu->env.vregs[i][0]);
-            sa->vregs[i][1] = cpu_to_be64(cpu->env.vregs[i][1]);
-        }
-    }
-    if (s390_has_feat(S390_FEAT_GUARDED_STORAGE) && len >= ADTL_GS_MIN_SIZE) {
-        for (i = 0; i < 4; i++) {
-            sa->gscb[i] = cpu_to_be64(cpu->env.gscb[i]);
-        }
-    }
-
-    cpu_physical_memory_unmap(sa, len, 1, len);
-    return 0;
-}
diff --git a/target/s390x/sigp.c b/target/s390x/sigp.c
index 5e95c4978f9..1464be76983 100644
--- a/target/s390x/sigp.c
+++ b/target/s390x/sigp.c
@@ -172,6 +172,46 @@ static void sigp_store_status_at_address(CPUState *cs, run_on_cpu_data arg)
     si->cc = SIGP_CC_ORDER_CODE_ACCEPTED;
 }
 
+typedef struct SigpAdtlSaveArea {
+    uint64_t    vregs[32][2];                     /* 0x0000 */
+    uint8_t     pad_0x0200[0x0400 - 0x0200];      /* 0x0200 */
+    uint64_t    gscb[4];                          /* 0x0400 */
+    uint8_t     pad_0x0420[0x1000 - 0x0420];      /* 0x0420 */
+} SigpAdtlSaveArea;
+QEMU_BUILD_BUG_ON(sizeof(SigpAdtlSaveArea) != 4096);
+
+#define ADTL_GS_MIN_SIZE 2048 /* minimal size of adtl save area for GS */
+static int s390_store_adtl_status(S390CPU *cpu, hwaddr addr, hwaddr len)
+{
+    SigpAdtlSaveArea *sa;
+    hwaddr save = len;
+    int i;
+
+    sa = cpu_physical_memory_map(addr, &save, true);
+    if (!sa) {
+        return -EFAULT;
+    }
+    if (save != len) {
+        cpu_physical_memory_unmap(sa, len, 1, 0);
+        return -EFAULT;
+    }
+
+    if (s390_has_feat(S390_FEAT_VECTOR)) {
+        for (i = 0; i < 32; i++) {
+            sa->vregs[i][0] = cpu_to_be64(cpu->env.vregs[i][0]);
+            sa->vregs[i][1] = cpu_to_be64(cpu->env.vregs[i][1]);
+        }
+    }
+    if (s390_has_feat(S390_FEAT_GUARDED_STORAGE) && len >= ADTL_GS_MIN_SIZE) {
+        for (i = 0; i < 4; i++) {
+            sa->gscb[i] = cpu_to_be64(cpu->env.gscb[i]);
+        }
+    }
+
+    cpu_physical_memory_unmap(sa, len, 1, len);
+    return 0;
+}
+
 #define ADTL_SAVE_LC_MASK  0xfUL
 static void sigp_store_adtl_status(CPUState *cs, run_on_cpu_data arg)
 {
-- 
2.51.0


