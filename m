Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B737DC47DB3
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 23:02:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUadK-0005vY-Ts; Mon, 29 Jan 2024 18:01:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rUadE-0005ue-H5
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 18:01:38 -0500
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rUadC-0008N1-MZ
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 18:01:36 -0500
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-5d8b276979aso1294555a12.2
 for <qemu-devel@nongnu.org>; Mon, 29 Jan 2024 15:01:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706569291; x=1707174091; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M8UjEMO1j2vm3/2aeEMHpkVHZcyY+4Tl4SZGy9Fx+X8=;
 b=A5lTa/SJuGD45c6dyta1F29CneQKXnpI65VRqxIV+cV1lFna0Pttcttkdhhi//XFPd
 LITsH7nK/9BvFoxCDWe5amtNDMHkL03rjOCdmEGLmxOEnqcFkRz1LiqtOg3c7WIGkziN
 ha8zD1llWJoZTtlbW4kSDB0Ia+FdnJ8f68SDMI3SdMYtVuNwe2WihnTCDvMkZv4guhTr
 +8e1meSYyIoh+sDgMSrBef8SkpUGRLmJt4TKTt6OPhHgO3pKkA20L9sVWVLoipQWpjnp
 UXWdgJbw+AEwoT5t1jtw5niEmoxn9OQgkmhvG/3lPsoJ8cGMP+pYsMO5hRCell73snn7
 ilUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706569291; x=1707174091;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=M8UjEMO1j2vm3/2aeEMHpkVHZcyY+4Tl4SZGy9Fx+X8=;
 b=TdXDZVEd3+g37Kpox+XNRcq/8UBkc3WUoH9C2ok6G8mzoXTZ376mzMtQqyUffcAXc2
 eoNJu9PK2ot2K7GBrtcMwV3kp9LlPt2lMRRD/QmaVrmyZpBwmKxMc5dqAO5wtyK7yATX
 ijiFpOtQ62WXCnjjqQR73L71ILNKSjmBU7hammviNK8yl5K3Vz4ms7oWMiDItZS0Lpo6
 EFe9leNTinUZEQKLkDv4XPy/PqZPPqUPff8ckOqFW8GaiY4UaxSmZxRo2UEdW7Rl3FVz
 Y8wfjiK3/3T8WuMsJD/IL0QR9qDDu/JUzw3Lqc9bJBZYR6SfqONiWnAlLRaWZVfKQabx
 YXVg==
X-Gm-Message-State: AOJu0YzLPyaWGYSS/h94hA97zx6rpb2g4oMfX0OYhOW8oFxVMjAqyf9D
 LCr1RARiZRPipuAcQCxo5kPZ1EP2cxtI6XBEkU3gT2sxWpfBORI17c3gx7dORXBAMKnT2n7yCY3
 8auc=
X-Google-Smtp-Source: AGHT+IHPhJt8i7vtlXplm8sf40EHpIqlYEZV0xie0de3YXpi5eEPjwrD8a75z1R9KBTGbk9Kr10afg==
X-Received: by 2002:a05:6a20:252e:b0:19c:8fa7:66da with SMTP id
 j46-20020a056a20252e00b0019c8fa766damr2771537pzd.1.1706569291303; 
 Mon, 29 Jan 2024 15:01:31 -0800 (PST)
Received: from stoup.. ([103.210.27.218]) by smtp.gmail.com with ESMTPSA id
 r10-20020aa78b8a000000b006ddcf56fb78sm6419368pfd.62.2024.01.29.15.01.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jan 2024 15:01:30 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>
Subject: [PULL 02/31] include/exec: Move vaddr defines to separate file
Date: Tue, 30 Jan 2024 09:00:52 +1000
Message-Id: <20240129230121.8091-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240129230121.8091-1-richard.henderson@linaro.org>
References: <20240129230121.8091-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x534.google.com
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

From: Anton Johansson <anjo@rev.ng>

Needed to work around circular includes. vaddr is currently defined in
cpu-common.h and needed by hw/core/cpu.h, but cpu-common.h also need
cpu.h to know the size of the CPUState.

[Maybe we can instead move parts of cpu-common.h w. hw/core/cpu.h to
sort out the circular inclusion.]

Signed-off-by: Anton Johansson <anjo@rev.ng>
Message-Id: <20240119144024.14289-7-anjo@rev.ng>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
[rth: Add include of vaddr.h into cpu-common.h]
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/cpu-common.h | 13 +------------
 include/exec/vaddr.h      | 18 ++++++++++++++++++
 2 files changed, 19 insertions(+), 12 deletions(-)
 create mode 100644 include/exec/vaddr.h

diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index fef3138d29..3109c6b67d 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -3,6 +3,7 @@
 
 /* CPU interfaces that are target independent.  */
 
+#include "exec/vaddr.h"
 #ifndef CONFIG_USER_ONLY
 #include "exec/hwaddr.h"
 #endif
@@ -14,18 +15,6 @@
 #define EXCP_YIELD      0x10004 /* cpu wants to yield timeslice to another */
 #define EXCP_ATOMIC     0x10005 /* stop-the-world and emulate atomic */
 
-/**
- * vaddr:
- * Type wide enough to contain any #target_ulong virtual address.
- */
-typedef uint64_t vaddr;
-#define VADDR_PRId PRId64
-#define VADDR_PRIu PRIu64
-#define VADDR_PRIo PRIo64
-#define VADDR_PRIx PRIx64
-#define VADDR_PRIX PRIX64
-#define VADDR_MAX UINT64_MAX
-
 void cpu_exec_init_all(void);
 void cpu_exec_step_atomic(CPUState *cpu);
 
diff --git a/include/exec/vaddr.h b/include/exec/vaddr.h
new file mode 100644
index 0000000000..b9844afc77
--- /dev/null
+++ b/include/exec/vaddr.h
@@ -0,0 +1,18 @@
+/* Define vaddr.  */
+
+#ifndef VADDR_H
+#define VADDR_H
+
+/**
+ * vaddr:
+ * Type wide enough to contain any #target_ulong virtual address.
+ */
+typedef uint64_t vaddr;
+#define VADDR_PRId PRId64
+#define VADDR_PRIu PRIu64
+#define VADDR_PRIo PRIo64
+#define VADDR_PRIx PRIx64
+#define VADDR_PRIX PRIX64
+#define VADDR_MAX UINT64_MAX
+
+#endif
-- 
2.34.1


