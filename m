Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E441E7FDD0
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 21:07:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vn14B-00059g-To; Mon, 02 Feb 2026 16:02:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vn13o-00034B-KE
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 16:02:21 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vn13k-0004Zy-KT
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 16:02:15 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-48039fdc8aeso29424595e9.3
 for <qemu-devel@nongnu.org>; Mon, 02 Feb 2026 13:02:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770066131; x=1770670931; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OVs3esTbLv+RrO48KXXh1/vvzTrWgrJXJOlx+4h95e8=;
 b=SEJk+MaxeNxo0R9VpB3FU2oSWmSlG4SidJ0d5DISq61gVIepSsXaJlvBY1OOFO/2Rp
 5w/KaWQgrXm3QnCu47jIOf8WjaXRSnH5SPVwZbsR7jz6wpf9swmJ7rOBvL6G/NkinnuA
 AqWaifIQS8h53OlI4mTcfZFi9CmzuNKx/7Jpy2w/CApMkFdBdhSDDE0+PkgC/03Dbh+1
 MuF9dU6SaglvmuhYJhmuuz+pTxRJqK1OXNaIf2tYw/mccDEBfxITTZMshDtzmr2nyQgS
 ZndMPMuBKUfTpJ+4RVNYtTjVSS+GPN35anOl+81zgkRVJbEYSFaYi7pFI56R4gS5UYmI
 O+Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770066131; x=1770670931;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=OVs3esTbLv+RrO48KXXh1/vvzTrWgrJXJOlx+4h95e8=;
 b=PRysTblZjGreySVIZ9aUVWAxRC8tMrZ5p/IKKeN/QezgRIW5PihUj+fOYy13das2Bc
 WBU8Id2MtcVvWHzJ9PWdGKC0Wx0oJ/6DFysdfErQIFDPUNX2UINBne0yompUnzk1LKoE
 ENhBll/RDcZ/7nLxUdBf30oQOSBPM2CZl4Hhs8MR+DZlrYh66VsLqBqaxOTyVM+9TEW+
 FLA+3uyCAFq4jbivC9F8byd88aX4BIcnsqh/Mrz4Y9PFmz2jErhVBqZ3rUX9Z7XqkgFs
 +m3eHXOlJLGFnRIcCvme7s5VZRZ4anfyDArb1TIXDT3dzAI8NexhwRsGv0FNcXf1Hbgf
 2Q/w==
X-Gm-Message-State: AOJu0Yxk62YNeEA/1p0hc4UsW22HYDLHHvShfw0DA/sNmWc/uJL5wPyg
 hfZPsn3+KzjyXSTqsDQtNc9rPfIOMa+CFuKCM/V5dCrzNwze1IEcjAzWUzCvBOTbsXLVjYErsyA
 l+9lE75g=
X-Gm-Gg: AZuq6aJCxhWNz/JnIXp4vWN+MIHQXt0NTcTHYSdubhl5qm/DV0yQA0mdGKkaGMDNnSa
 fuSjs9816IsjXFCt+Y9vg6AIcNX9KEOyczUX+h1d8M2ocm441h/ojgLLa50h558dUDL6cZVVeCi
 OMo0MBRsmomOc2HRTAaPy6ZBUv6S3pLsQ+H1YH70Na2uxUdt5lorUczacTnQGGop4op84MdK9Ej
 t04Rj3sQkKr7+rE4nZ8SA6SVTykoMXnke5a2kZqf4GTBNw3bYXlYKqoU0rMGeTRR85n/Zhdom4r
 C6o+hBsZAOYHrVdV21w6DPdK3+UeL3JwRI9xSxLAmDn3hzrAGgQO+KI8+P/IjnXYj7o7wsN0Kus
 A+at/U9VGjckwcjhyWQ5D1GHdvKZW6iLrIEVWFYFkYEM3hYnxdag4X0e4QCOgZQe04MTnIjwZBz
 4+pyhmMqPG9u0zrDGGzFxZ1i71VqJxOlUMtJCZp4s4DkDx7jJk+SbY0g9BIJ41
X-Received: by 2002:a05:600c:8b0a:b0:477:b48d:ba7a with SMTP id
 5b1f17b1804b1-482db495b79mr174147105e9.32.1770066130772; 
 Mon, 02 Feb 2026 13:02:10 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483051286e0sm13670975e9.5.2026.02.02.13.02.09
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 02 Feb 2026 13:02:10 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>, Nicholas Piggin <npiggin@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Chinmay Rath <rathc@linux.ibm.com>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v6 09/11] target/ppc: Introduce ppc_env_is_little_endian()
 helper
Date: Mon,  2 Feb 2026 22:01:03 +0100
Message-ID: <20260202210106.93257-10-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260202210106.93257-1-philmd@linaro.org>
References: <20260202210106.93257-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

Centralize endianness check on MSR via a common helper.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Anton Johansson <anjo@rev.ng>
---
 target/ppc/internal.h   | 5 +++++
 target/ppc/cpu_init.c   | 9 +++------
 target/ppc/gdbstub.c    | 2 +-
 target/ppc/mem_helper.c | 8 ++++----
 4 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/target/ppc/internal.h b/target/ppc/internal.h
index c3d3590cc89..e6e60de95a4 100644
--- a/target/ppc/internal.h
+++ b/target/ppc/internal.h
@@ -24,6 +24,11 @@
 #include "exec/page-protection.h"
 #include "accel/tcg/tb-cpu-state.h"
 
+static inline bool ppc_env_is_little_endian(const CPUPPCState *env)
+{
+    return FIELD_EX64(env->msr, MSR, LE);
+}
+
 /**
  * ppc_data_endian_env:
  * @env: the cpu context
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 0808284b722..c5cec7c2ed9 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -7364,7 +7364,7 @@ static bool ppc_cpu_is_big_endian(CPUState *cs)
 {
     cpu_synchronize_state(cs);
 
-    return !FIELD_EX64(cpu_env(cs)->msr, MSR, LE);
+    return !ppc_env_is_little_endian(cpu_env(cs));
 }
 
 static bool ppc_get_irq_stats(InterruptStatsProvider *obj,
@@ -7456,11 +7456,8 @@ static void ppc_disas_set_info(CPUState *cs, disassemble_info *info)
 {
     CPUPPCState *env = cpu_env(cs);
 
-    if ((env->msr >> MSR_LE) & 1) {
-        info->endian = BFD_ENDIAN_LITTLE;
-    } else {
-        info->endian = BFD_ENDIAN_BIG;
-    }
+    info->endian = ppc_env_is_little_endian(env) ? BFD_ENDIAN_LITTLE
+                                                 : BFD_ENDIAN_BIG;
     info->mach = env->bfd_mach;
     if (!env->bfd_mach) {
 #ifdef TARGET_PPC64
diff --git a/target/ppc/gdbstub.c b/target/ppc/gdbstub.c
index 3b28d4e21c7..b19c0f1ea9c 100644
--- a/target/ppc/gdbstub.c
+++ b/target/ppc/gdbstub.c
@@ -84,7 +84,7 @@ static int ppc_gdb_register_len(int n)
 void ppc_maybe_bswap_register(CPUPPCState *env, uint8_t *mem_buf, int len)
 {
 #ifndef CONFIG_USER_ONLY
-    if (!FIELD_EX64(env->msr, MSR, LE)) {
+    if (!ppc_env_is_little_endian(env)) {
         /* do nothing */
     } else if (len == 4) {
         bswap32s((uint32_t *)mem_buf);
diff --git a/target/ppc/mem_helper.c b/target/ppc/mem_helper.c
index ca84131d1a9..119dc1df233 100644
--- a/target/ppc/mem_helper.c
+++ b/target/ppc/mem_helper.c
@@ -420,7 +420,7 @@ target_ulong helper_lscbx(CPUPPCState *env, target_ulong addr, uint32_t reg,
         int adjust = HI_IDX * (n_elems - 1);                    \
         int sh = sizeof(r->element[0]) >> 1;                    \
         int index = (addr & 0xf) >> sh;                         \
-        bool byteswap = FIELD_EX64(env->msr, MSR, LE);          \
+        bool byteswap = ppc_env_is_little_endian(env);          \
                                                                 \
         if (byteswap) {                                         \
             index = n_elems - index - 1;                        \
@@ -446,7 +446,7 @@ LVE(LVEWX, cpu_ldl_be_data_ra, bswap32, u32)
         int adjust = HI_IDX * (n_elems - 1);                            \
         int sh = sizeof(r->element[0]) >> 1;                            \
         int index = (addr & 0xf) >> sh;                                 \
-        bool byteswap = FIELD_EX64(env->msr, MSR, LE);                  \
+        bool byteswap = ppc_env_is_little_endian(env);                  \
                                                                         \
         if (byteswap) {                                                 \
             index = n_elems - index - 1;                                \
@@ -479,7 +479,7 @@ void helper_##name(CPUPPCState *env, target_ulong addr,                 \
     t.s128 = int128_zero();                                             \
     if (nb) {                                                           \
         nb = (nb >= 16) ? 16 : nb;                                      \
-        if (FIELD_EX64(env->msr, MSR, LE) && !lj) {                     \
+        if (ppc_env_is_little_endian(env) && !lj) {                     \
             for (i = 16; i > 16 - nb; i--) {                            \
                 t.VsrB(i - 1) = cpu_ldub_data_ra(env, addr, GETPC());   \
                 addr = addr_add(env, addr, 1);                          \
@@ -510,7 +510,7 @@ void helper_##name(CPUPPCState *env, target_ulong addr,           \
     }                                                             \
                                                                   \
     nb = (nb >= 16) ? 16 : nb;                                    \
-    if (FIELD_EX64(env->msr, MSR, LE) && !lj) {                   \
+    if (ppc_env_is_little_endian(env) && !lj) {                   \
         for (i = 16; i > 16 - nb; i--) {                          \
             cpu_stb_data_ra(env, addr, xt->VsrB(i - 1), GETPC()); \
             addr = addr_add(env, addr, 1);                        \
-- 
2.52.0


