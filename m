Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD70AF589DA
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 13:52:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFuT9-0000xj-Jn; Thu, 23 Apr 2026 09:51:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFuT6-0000x8-C9
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 09:51:48 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFuT4-0006HY-FJ
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 09:51:48 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-48374014a77so87460165e9.3
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 06:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776952304; x=1777557104; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=USyA8v7aEKp3s5luzNdxwloj99EpgracOTgDV5g1QHE=;
 b=nQB3k2TlA8LEyq/rndt3HYz0xLkamWGaeKtf+crgNmv5nGg8s6eDP8Gv6aLSLpn2Y5
 RN9X4CD+ZQc6GniVaCS98sDt0NndvApHEdV5M2NDJkEP5hcF9yPRdV58T5HcNl0ijAAB
 DpEuJ/HFGBsZ2E+Z8uOGu5AorSFL67iJj7LFc/gm2WOiBrzHA7Sods+TSCQuEldFDUue
 Xv2grj4OvSeZ6pdzYc61sN2XHRPChTEOkGA7+R757gXA5jdHhPiMe4r2/yZyb7w8sOBu
 GHdkPhu8l1k3WwFpXzto5A7DF+uK7CecEt20jeNtwguwm4qmkrG9UvmxCMHinM26h5jv
 Bp5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776952304; x=1777557104;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=USyA8v7aEKp3s5luzNdxwloj99EpgracOTgDV5g1QHE=;
 b=QuwubOt5dgE+YOEbDeaOZqHRT9d7ypAuUkDEs8g3yU6P1SFjCTxUrBwBPk3InI8Zdz
 cRrRj1+2imPPaxS/MeE+fDATPEUH50iPtgkDyhb816F6rrEsHJ7QYZ2yLewZIpFHzecj
 3NVx5RyYrPt3QLS47Np2lS7YZ3zZ6cN2QEdIcDHDxjNfGkfUOuxZwHuA/7z1IYFuDkKf
 LptuPA+qRaMh8hdTRxPkjXMB1kTG07scUrQwWFnkZqnlltDXm2ASB15Mi1c55VlVBP+w
 3vbDPlDAwYzFUUcjyh3HLFMcFeRvUEjR9lgKzReSAFQJumj5UBesltkAWZqaR9ijX61f
 nHAA==
X-Gm-Message-State: AOJu0Yyg1FVOW5LaYi+8DaS+WD3JXVAU6yfzRf7lIFXcCw+WpSzDOeZH
 0D3tnqPw7jUn8asjUeVMa4XhZyBPxNUhiOmc6b1HtIbbc5dVxasPiEej5497dl/FJ3gYaOpLpoh
 UjQfgx4g=
X-Gm-Gg: AeBDiesixrh4Z06dp4TiVk42GsLumInSW0ety+Saktd4owElDnMJ4ADuag6kMqpLn4A
 FTCmXv3xmimwyGXj6GCsP0OvJL2lxh3SFWLJgsF1g8T6HGPaFC0PIJtLSQ4fXYvGD1jbwljuU2o
 0TUo1fsY0/POtwCSQQ3x1QubfHsJjieUThq1Aspo4tBWY57xvx/OoaMOs9Jc1F8uA+c+/d2Pr/O
 i3HmoJpaRT18o19+36YXM8/ps6hb2yn+2dmK7JZwph6jslKKtoyP25JbBkKytdb9SPG+Vl5FbBc
 Uu1+SSYbZZbwMRFJFAz4xLM6MYbjMcmVqgOgGyj0fbSgPkkSMedyTD0MX51njEU8t6w0FW8yXjy
 s+5XPKdxXGxf7+epyaf7QPC56somX8s5fPWhQAa0rWrGkOX1S83Q7bLBJSFoVsvIV+2xlp7y/T1
 J4KpjOhT2jG75M1nNO0ITd9sqOwwWfN3NepvwKuwNN/bu6TNymcPB9yZDceYaCJAWYLzv2FGT+r
 86uLXhETj8=
X-Received: by 2002:a05:600c:1390:b0:483:709e:f238 with SMTP id
 5b1f17b1804b1-488fb78ea6fmr391933805e9.29.1776952304388; 
 Thu, 23 Apr 2026 06:51:44 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fb7b2634sm164816635e9.28.2026.04.23.06.51.41
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 23 Apr 2026 06:51:42 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, qemu-s390x@nongnu.org,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 David Hildenbrand <david@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>,
 Eric Farman <farman@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 8/9] target/s390x: Compile crypto_helper.c as common unit
Date: Thu, 23 Apr 2026 15:50:34 +0200
Message-ID: <20260423135035.50126-9-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260423135035.50126-1-philmd@linaro.org>
References: <20260423135035.50126-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

In order do build crypto_helper.c as a common unit we need to
replace:

  "accel/tcg/cpu-ldst.h" -> "accel/tcg/cpu-ldst-common.h"

and update the cpu_ld/st_be_data_ra() API by cpu_ld/st_mmu() one.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/s390x/tcg/crypto_helper.c | 39 +++++++++++++++++---------------
 target/s390x/tcg/meson.build     |  2 +-
 2 files changed, 22 insertions(+), 19 deletions(-)

diff --git a/target/s390x/tcg/crypto_helper.c b/target/s390x/tcg/crypto_helper.c
index 074d745eb3f..ae392bce0e7 100644
--- a/target/s390x/tcg/crypto_helper.c
+++ b/target/s390x/tcg/crypto_helper.c
@@ -17,7 +17,7 @@
 #include "s390x-internal.h"
 #include "tcg_s390x.h"
 #include "exec/helper-proto.h"
-#include "accel/tcg/cpu-ldst.h"
+#include "accel/tcg/cpu-ldst-common.h"
 #include "accel/tcg/cpu-mmu-index.h"
 
 static uint64_t R(uint64_t x, int c)
@@ -123,44 +123,44 @@ static void sha512_bda_be64(uint64_t a[8], uint64_t w[16])
 static void sha512_read_icv(CPUS390XState *env, const int mmu_idx,
                             uint64_t addr, uint64_t a[8], uintptr_t ra)
 {
-    int i;
+    const MemOpIdx oi = make_memop_idx(MO_BE | MO_64 | MO_UNALN, mmu_idx);
 
-    for (i = 0; i < 8; i++, addr += 8) {
+    for (int i = 0; i < 8; i++, addr += 8) {
         addr = wrap_address(env, addr);
-        a[i] = cpu_ldq_be_data_ra(env, addr, ra);
+        a[i] = cpu_ldq_mmu(env, addr, oi, ra);
     }
 }
 
 static void sha512_write_ocv(CPUS390XState *env, const int mmu_idx,
                              uint64_t addr, uint64_t a[8], uintptr_t ra)
 {
-    int i;
+    const MemOpIdx oi = make_memop_idx(MO_BE | MO_64 | MO_UNALN, mmu_idx);
 
-    for (i = 0; i < 8; i++, addr += 8) {
+    for (int i = 0; i < 8; i++, addr += 8) {
         addr = wrap_address(env, addr);
-        cpu_stq_be_data_ra(env, addr, a[i], ra);
+        cpu_stq_mmu(env, addr, a[i], oi, ra);
     }
 }
 
 static void sha512_read_block(CPUS390XState *env, const int mmu_idx,
                               uint64_t addr, uint64_t a[16], uintptr_t ra)
 {
-    int i;
+    const MemOpIdx oi = make_memop_idx(MO_BE | MO_64 | MO_UNALN, mmu_idx);
 
-    for (i = 0; i < 16; i++, addr += 8) {
+    for (int i = 0; i < 16; i++, addr += 8) {
         addr = wrap_address(env, addr);
-        a[i] = cpu_ldq_be_data_ra(env, addr, ra);
+        a[i] = cpu_ldq_mmu(env, addr, oi, ra);
     }
 }
 
 static void sha512_read_mbl_be64(CPUS390XState *env, const int mmu_idx,
                                  uint64_t addr, uint8_t a[16], uintptr_t ra)
 {
-    int i;
+    const MemOpIdx oi = make_memop_idx(MO_8, mmu_idx);
 
-    for (i = 0; i < 16; i++, addr += 1) {
+    for (int i = 0; i < 16; i++, addr += 1) {
         addr = wrap_address(env, addr);
-        a[i] = cpu_ldub_data_ra(env, addr, ra);
+        a[i] = cpu_ldb_mmu(env, addr, oi, ra);
     }
 }
 
@@ -200,13 +200,14 @@ static int cpacf_sha512(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
 
     /* KLMD: Process partial/empty block last. */
     if (type == S390_FEAT_TYPE_KLMD && len < 128) {
+        const MemOpIdx oi = make_memop_idx(MO_8, mmu_idx);
         uint8_t x[128];
 
         /* Read the remainder of the message byte-per-byte. */
         for (i = 0; i < len; i++) {
             uint64_t addr = wrap_address(env, *message_reg + processed + i);
 
-            x[i] = cpu_ldub_data_ra(env, addr, ra);
+            x[i] = cpu_ldb_mmu(env, addr, oi, ra);
         }
         /* Pad the remainder with zero and set the top bit. */
         memset(x + len, 0, 128 - len);
@@ -248,6 +249,7 @@ static int cpacf_sha512(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
 static void fill_buf_random(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
                             uint64_t *buf_reg, uint64_t *len_reg)
 {
+    const MemOpIdx oi = make_memop_idx(MO_8, mmu_idx);
     uint8_t tmp[256];
     uint64_t len = *len_reg;
     int buf_reg_len = 64;
@@ -262,7 +264,7 @@ static void fill_buf_random(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
 
         qemu_guest_getrandom_nofail(tmp, block);
         for (size_t i = 0; i < block; ++i) {
-            cpu_stb_data_ra(env, wrap_address(env, *buf_reg), tmp[i], ra);
+            cpu_stb_mmu(env, wrap_address(env, *buf_reg), tmp[i], oi, ra);
             *buf_reg = deposit64(*buf_reg, 0, buf_reg_len, *buf_reg + 1);
             --*len_reg;
         }
@@ -279,7 +281,7 @@ uint32_t HELPER(msa)(CPUS390XState *env, uint32_t r1, uint32_t r2, uint32_t r3,
     const uint8_t fc = env->regs[0] & 0x7fULL;
     uint8_t subfunc[16] = { 0 };
     uint64_t param_addr;
-    int i;
+    MemOpIdx oi;
 
     switch (type) {
     case S390_FEAT_TYPE_KMAC:
@@ -300,9 +302,10 @@ uint32_t HELPER(msa)(CPUS390XState *env, uint32_t r1, uint32_t r2, uint32_t r3,
 
     switch (fc) {
     case 0: /* query subfunction */
-        for (i = 0; i < 16; i++) {
+        oi = make_memop_idx(MO_8, mmu_idx);
+        for (int i = 0; i < 16; i++) {
             param_addr = wrap_address(env, env->regs[1] + i);
-            cpu_stb_data_ra(env, param_addr, subfunc[i], ra);
+            cpu_stb_mmu(env, param_addr, subfunc[i], oi, ra);
         }
         break;
     case 3: /* CPACF_*_SHA_512 */
diff --git a/target/s390x/tcg/meson.build b/target/s390x/tcg/meson.build
index ed6441f6f44..36cb0e079ed 100644
--- a/target/s390x/tcg/meson.build
+++ b/target/s390x/tcg/meson.build
@@ -1,11 +1,11 @@
 s390x_ss.add(when: 'CONFIG_TCG', if_true: files(
-  'crypto_helper.c',
   'int_helper.c',
   'mem_helper.c',
   'misc_helper.c',
 ))
 s390x_common_ss.add(when: 'CONFIG_TCG', if_true: files(
   'cc_helper.c',
+  'crypto_helper.c',
   'excp_helper.c',
   'fpu_helper.c',
   'translate.c',
-- 
2.53.0


