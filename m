Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A4C4CAC5B9
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 14:14:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v298w-0007lC-9B; Fri, 26 Sep 2025 10:09:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v298X-0007NZ-AS
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 10:09:25 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v298H-0005gN-SJ
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 10:09:24 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3fa528f127fso1672498f8f.1
 for <qemu-devel@nongnu.org>; Fri, 26 Sep 2025 07:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758895743; x=1759500543; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=hmq5rsrkyK1cIRiW7N5ULq/MI81nZOA1l+kOhxa2dsg=;
 b=y8mdFIuakxZBnZvpO2xSINCEQAdBCRE9iQV2yRLQE+Li30tAOFQ9YezFnEfSJSvAlc
 cSIpziw4viZ5+SQgPkOZFRJ4y+muBg8phxhuHQzu6/wsmIVP711+/s/JmtP5IC/uvcAY
 A0uabJ3P0z9yjfsC7+KxQE6+yZf7HE9cgE+c0j87bms3YMZI5ldj7OAoj72dKEZpaehD
 LJvY3WyA3dJTeeyt3FyBXffbNHOLVo34eBe5a50/Rw6GxgWCBeYaKTfdFCTSMSfnDuCb
 qpe9lVEBmAtrg+M5zklIquXuGMKX3CXq2S3iYFCXHnmj3aDlG2ElpffMx7mpH9i21wAq
 C+zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758895743; x=1759500543;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hmq5rsrkyK1cIRiW7N5ULq/MI81nZOA1l+kOhxa2dsg=;
 b=Ic6RFBJPrZQn2yaLzgpr0CBKf8ZnrQRxmVmErCY1M0/zAR9pi/EK/qo0BxCn3pbb1g
 4LBaLK3xBzwqBFTZCc8hnQ231XHW3HhAPkYd/61H5A+fhh3Y5e3VB2ncuwfa5Jw8k+H5
 EWutyQAPLBICH60HQKigxJHnguWWwbazPqxdVqh/uQ4GZHfF28n6n48rT4wBzZmIv723
 GTbx3n0pd8q/iiD71ebkSWK8l6iousAOw3xlLu4Y52gTqxwL7bEl5jKQ3dyzBxH1qWs6
 Z5czmzUCAogPUZEkKu++OBRgh+t8N8uHyf2JX5SluO8AEVByKYrkdlu4UIgeVbGlTKDq
 TRbw==
X-Gm-Message-State: AOJu0YwE9ujLAuRvxrfrjdXh22rZnFhiQ20bK1C6h4vf3DZJNDdPxQue
 e3dFaap4h0pbadLWMvjyH4CfPrhmDdPbzwQHyR5HaIpHEaNKqnFs8Kwmiues97HsmIs4eNbvdbA
 JVlpP
X-Gm-Gg: ASbGncsQdhFgPuBPvXIaa79YyNZTbSmqq/p8jVcJYHkxAjeVvOMtTcgTyYlfcQNUxyX
 EHeWbWhKemD/qxfmRyuDfn9jVIUCdr40UC1/z2Ceex4ClSQUA1B75toMy7WU0yxauPnMj2wrS4b
 LIZ4r0WUwVUFwDrVwxZJmzqNa2iNzLCJsqmMkL0p21EDXK7Tlr3MIKoJYaLMYfBsreMeYXWWJDG
 pu5FoA8AF2WDdK5F3cTnmIm/pkozDBi9/kSyY31gRKCXBu+V6CujmKAVr8U2sKCMbqwvNum5nYN
 cB2FkQZRybsb8I6iFaj3qn8cqb1wfnbkStI98R2/CY36aFe51miQ8uxqbjpZitFv92a6f682xwq
 eb9OeWEOrteXK1iLDT+DFGXZcQNnQTnJVnayP/3/db9S7S9kRfA==
X-Google-Smtp-Source: AGHT+IFsvWV+cchlmoud+DZffYIUIXmA7NpIYmMK9ga+b53uaL0SwlGpaPJFZepmTbfkQGpkZWRPGA==
X-Received: by 2002:a05:6000:610:b0:3ee:11d1:2a1e with SMTP id
 ffacd0b85a97d-40f5fea54d4mr6462948f8f.10.1758895743334; 
 Fri, 26 Sep 2025 07:09:03 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-410f2007372sm6338315f8f.16.2025.09.26.07.09.02
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Sep 2025 07:09:02 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 16/44] target/arm: Replace cpreg_field_is_64bit with
 cpreg_field_type
Date: Fri, 26 Sep 2025 15:08:16 +0100
Message-ID: <20250926140844.1493020-17-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250926140844.1493020-1-peter.maydell@linaro.org>
References: <20250926140844.1493020-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x436.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Prepare for 128-bit fields by using a better query api.

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpregs.h  | 10 ++++++----
 target/arm/gdbstub.c |  7 +++++--
 target/arm/helper.c  | 18 +++++++++++++-----
 3 files changed, 24 insertions(+), 11 deletions(-)

diff --git a/target/arm/cpregs.h b/target/arm/cpregs.h
index 6fb1994afa0..74bae7309a3 100644
--- a/target/arm/cpregs.h
+++ b/target/arm/cpregs.h
@@ -22,6 +22,7 @@
 #define TARGET_ARM_CPREGS_H
 
 #include "hw/registerfields.h"
+#include "exec/memop.h"
 #include "target/arm/kvm-consts.h"
 #include "cpu.h"
 
@@ -1078,12 +1079,13 @@ void raw_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value);
 void arm_cp_reset_ignore(CPUARMState *env, const ARMCPRegInfo *ri);
 
 /*
- * Return true if this reginfo struct's field in the cpu state struct
- * is 64 bits wide.
+ * Return MO_32 if the field in CPUARMState is uint32_t or
+ * MO_64 if the field in CPUARMState is uint64_t.
  */
-static inline bool cpreg_field_is_64bit(const ARMCPRegInfo *ri)
+static inline MemOp cpreg_field_type(const ARMCPRegInfo *ri)
 {
-    return (ri->state == ARM_CP_STATE_AA64) || (ri->type & ARM_CP_64BIT);
+    return (ri->state == ARM_CP_STATE_AA64 || (ri->type & ARM_CP_64BIT)
+            ? MO_64 : MO_32);
 }
 
 static inline bool cp_access_ok(int current_el,
diff --git a/target/arm/gdbstub.c b/target/arm/gdbstub.c
index 2d331fff445..4e2ac49b6a9 100644
--- a/target/arm/gdbstub.c
+++ b/target/arm/gdbstub.c
@@ -247,10 +247,13 @@ static int arm_gdb_get_sysreg(CPUState *cs, GByteArray *buf, int reg)
     key = cpu->dyn_sysreg_feature.data.cpregs.keys[reg];
     ri = get_arm_cp_reginfo(cpu->cp_regs, key);
     if (ri) {
-        if (cpreg_field_is_64bit(ri)) {
+        switch (cpreg_field_type(ri)) {
+        case MO_64:
             return gdb_get_reg64(buf, (uint64_t)read_raw_cp_reg(env, ri));
-        } else {
+        case MO_32:
             return gdb_get_reg32(buf, (uint32_t)read_raw_cp_reg(env, ri));
+        default:
+            g_assert_not_reached();
         }
     }
     return 0;
diff --git a/target/arm/helper.c b/target/arm/helper.c
index fe298670f12..26941ecd4f8 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -63,20 +63,28 @@ int compare_u64(const void *a, const void *b)
 uint64_t raw_read(CPUARMState *env, const ARMCPRegInfo *ri)
 {
     assert(ri->fieldoffset);
-    if (cpreg_field_is_64bit(ri)) {
+    switch (cpreg_field_type(ri)) {
+    case MO_64:
         return CPREG_FIELD64(env, ri);
-    } else {
+    case MO_32:
         return CPREG_FIELD32(env, ri);
+    default:
+        g_assert_not_reached();
     }
 }
 
 void raw_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
 {
     assert(ri->fieldoffset);
-    if (cpreg_field_is_64bit(ri)) {
+    switch (cpreg_field_type(ri)) {
+    case MO_64:
         CPREG_FIELD64(env, ri) = value;
-    } else {
+        break;
+    case MO_32:
         CPREG_FIELD32(env, ri) = value;
+        break;
+    default:
+        g_assert_not_reached();
     }
 }
 
@@ -2754,7 +2762,7 @@ static void vmsa_ttbr_write(CPUARMState *env, const ARMCPRegInfo *ri,
                             uint64_t value)
 {
     /* If the ASID changes (with a 64-bit write), we must flush the TLB.  */
-    if (cpreg_field_is_64bit(ri) &&
+    if (cpreg_field_type(ri) == MO_64 &&
         extract64(raw_read(env, ri) ^ value, 48, 16) != 0) {
         ARMCPU *cpu = env_archcpu(env);
         tlb_flush(CPU(cpu));
-- 
2.43.0


