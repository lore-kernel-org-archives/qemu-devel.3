Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9A6DCD5BB1
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 11:05:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRpbB-0007MZ-Io; Tue, 26 May 2026 07:05:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fritchleybohrer@gmail.com>)
 id 1wRpbA-0007Dz-19
 for qemu-devel@nongnu.org; Tue, 26 May 2026 07:05:24 -0400
Received: from mail-dy1-x1344.google.com ([2607:f8b0:4864:20::1344])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fritchleybohrer@gmail.com>)
 id 1wRpb8-0008Cq-93
 for qemu-devel@nongnu.org; Tue, 26 May 2026 07:05:23 -0400
Received: by mail-dy1-x1344.google.com with SMTP id
 5a478bee46e88-3042a388168so3124758eec.1
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 04:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779793521; x=1780398321; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HZ2SEKYQIUrZHs3Nx+7QeMR2uW/p7CVSETlES67ZrAA=;
 b=RykhbUjpy8bxu0htsvotfZ73mol4GH6Yn8lA4LVN56ex7U+8OP4/SELffATNfG2zJ8
 rGDd0AFOEsaimc5gUmkIn0BhqNfJPUfxcpLuKBWz+iq0FHs1YGppGp913IEUH9qfwL6r
 p6mzzm483YTqu+Ag7iUFcjO7e6GSR911xnBXwBeVUtEjNGyOTkbBPL4+rIvVrZ6C5C2F
 waoDey+2gCP39ATDSdD4Ti8v6s+Q++14EFBAx/OOWeuuie3gZ9YuTN8auyARJRA7KWc8
 hqSGcMxi/K7awcE/z4HTSxMw2h1lspvQhlhk7RShLR+jfdxn9XL6WJCY+jA5l43MgwX6
 bbWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779793521; x=1780398321;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HZ2SEKYQIUrZHs3Nx+7QeMR2uW/p7CVSETlES67ZrAA=;
 b=fCD+pSLYV8ZqTneWXFeYl1duMIQ1fD+W3coyVyD6LH9ep++zZSyBHE9/hDOvSDBwtf
 GAhQGeemUqxvuAMXDGKOip3gaJN7ALpguqiEPGt2JUbewsoA2NklsZc82/evqVKnphHo
 YduRN71YVKDs3h/rr6o6eUivWq4ECCFJUJ5TILIeAkuLC2NV6KspH6b1rWBGapSEukhW
 HlWierpPsqL904+tLaPPv0dM8YRyTXlaAl65KrXo1+wscwTnJfs3kxZn3MfSmieLLZ0N
 c7EtNwBmR3OdbGvh8yOIGLC9iRQE3EqtHsZgJyApfvux+9cmKnBXzEChYREgRA0iSm2a
 OYLA==
X-Gm-Message-State: AOJu0YzDWBmVi0HzM0FpMU35YJbDoHYleSYloi8s7eJBZirN1m67Kah1
 uEPiX6Ly3hWWc0vacyHsiEPAUNU1n5XB6TY8UKkCgRIZl0lc3hZ9igoPdtSSTf5VJi1H+A==
X-Gm-Gg: Acq92OG4hR6a3CA693KYEbbkIAp1IwaNMkACFGbEkcMgF1xTyEQZ6u4u6FjpdDG6fw+
 GayILGD2iJq02wCxzcLmWhm+GtncOac9cH81ojRER2XZgNyIz+hum/0rvN8ZdAnd+wBXxh7WzT7
 j0esHt6tqCbwNXtwK990i4w6eKgyFjA3v6adckWyWuNW+urO4OCVIslxk5gQSKDY+CtGvNSElAP
 FO/46QLY/KR9vV7IoHXqy94YZqzD9EWZzexHXgh48zaQmFMrjjIkGFh1/kg/YpWoTFOf6Arg3I6
 V8PGGek2/CG09WkxrA3KZG/WZq1iJY1n/o+MZDtKTuLbK1WfET8wCSfYn4AFJSevJOk4LiOAEpo
 8dqfgLuLQgg2UTsYiB4EolISWNDalTKH/BfeZAPcIP8yva7Oc5iSMI2bVS94zBjEb8R9No70wwU
 BHLKtjhHLXkwfM7dI231aLjZ7vWJX9D4Nqc8auJ/ZnPMqtvVRw7sEY7mg7OlImvV25/FxJn48ji
 9LU+JMOsdEaka0fZy82+A==
X-Received: by 2002:a05:7301:388a:b0:304:81b6:fd51 with SMTP id
 5a478bee46e88-30481b6fe6dmr2930315eec.6.1779793520496; 
 Tue, 26 May 2026 04:05:20 -0700 (PDT)
Received: from openkylin.. (ec2-3-101-81-203.us-west-1.compute.amazonaws.com.
 [3.101.81.203]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1366a2e634csm9250276c88.2.2026.05.26.04.05.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 04:05:19 -0700 (PDT)
From: Zephyr Li <fritchleybohrer@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com,
 chao.liu.zevorn@gmail.com, daniel.barboza@oss.qualcomm.com
Subject: [PATCH v2 3/5] target/riscv: Move riscv_raise_exception() to common
 code
Date: Tue, 26 May 2026 19:04:48 +0800
Message-ID: <79175d7516dd98709c9703feca3ef0bc7b9e6b86.1779792111.git.fritchleybohrer@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1779792111.git.fritchleybohrer@gmail.com>
References: <cover.1779792111.git.fritchleybohrer@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1344;
 envelope-from=fritchleybohrer@gmail.com; helo=mail-dy1-x1344.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Signed-off-by: Zephyr Li <fritchleybohrer@gmail.com>
---
 target/riscv/cpu_helper.c | 19 +++++++++++++++++++
 target/riscv/op_helper.c  | 15 ---------------
 2 files changed, 19 insertions(+), 15 deletions(-)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 678c106ae5..752752d520 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -39,6 +39,25 @@
 #include "pmp.h"
 #include "qemu/plugin.h"
 
+/* Exceptions processing helpers */
+G_NORETURN void riscv_raise_exception(CPURISCVState *env,
+                                      RISCVException exception,
+                                      uintptr_t pc)
+{
+    CPUState *cs = env_cpu(env);
+
+    trace_riscv_exception(exception,
+                          riscv_cpu_get_trap_name(exception, false),
+                          env->pc);
+
+    cs->exception_index = exception;
+#ifdef CONFIG_TCG
+    cpu_loop_exit_restore(cs, pc);
+#else
+    qemu_build_not_reached();
+#endif
+}
+
 target_ulong riscv_cpu_get_fflags(CPURISCVState *env)
 {
     int soft = get_float_exception_flags(&env->fp_status);
diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index 81873014cb..d17a8bbf10 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -28,21 +28,6 @@
 #include "exec/tlb-flags.h"
 #include "trace.h"
 
-/* Exceptions processing helpers */
-G_NORETURN void riscv_raise_exception(CPURISCVState *env,
-                                      RISCVException exception,
-                                      uintptr_t pc)
-{
-    CPUState *cs = env_cpu(env);
-
-    trace_riscv_exception(exception,
-                          riscv_cpu_get_trap_name(exception, false),
-                          env->pc);
-
-    cs->exception_index = exception;
-    cpu_loop_exit_restore(cs, pc);
-}
-
 void helper_raise_exception(CPURISCVState *env, uint32_t exception)
 {
     riscv_raise_exception(env, exception, 0);
-- 
2.43.0


