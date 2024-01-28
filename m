Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B051C47DDB
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jan 2024 04:43:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTx01-0004fs-BH; Sat, 27 Jan 2024 23:42:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rTwzz-0004e2-If
 for qemu-devel@nongnu.org; Sat, 27 Jan 2024 23:42:27 -0500
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rTwzx-0004HV-UV
 for qemu-devel@nongnu.org; Sat, 27 Jan 2024 23:42:27 -0500
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-29080973530so1599299a91.1
 for <qemu-devel@nongnu.org>; Sat, 27 Jan 2024 20:42:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706416944; x=1707021744; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M8UjEMO1j2vm3/2aeEMHpkVHZcyY+4Tl4SZGy9Fx+X8=;
 b=xwpUCp6Z0/wMQUDar6h13ph8N6Cqlh3gAnSXJ9T+2EJt5wlB1QGShLOznRzbElZHHI
 yu/M+DvIERJbrPVJMXYKtXPgCPbbS+VLWsPQyYb4y+uwsSOdSURoUtcIewIgOc1spyVd
 /qLOFZoQdf3yLF+iK4pf09d+cyfMOz4JbikQ9RAzrrgNW20ozen8f1TleczAF7o6x1wq
 pLwRUvkRM5U6WnzAsOUQE20H5wukl0uV7INw0s8jc4ZaJuzhNb3oo5U+ld+wuFQAjQ89
 ojsIEVB0l5DBChWWiQS5ZIk3cIIBx5X9/d3klhOB6e5J2YpR1Q7QBi3KCA43nBeCcpCc
 2PEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706416944; x=1707021744;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=M8UjEMO1j2vm3/2aeEMHpkVHZcyY+4Tl4SZGy9Fx+X8=;
 b=MrPfpUhc9oiDOS4NEGRV6X5Ogoc1zGyP2bxPKXZI24erlNHsGsUI3TN7I2RuV3cpbC
 h5atIzE9Yy1+rr/7B+DTXpCJxTuuKBF0jPJj3/NMx9P9E5n1AQkmzqVUpi8+YkEJuFbE
 Nxq30mbacOZ8p6/hij6gvZE4/RbudmtnNNBqg7Iz9kzgxuFVQrMXAUW7J+5hE77rol7w
 jU6xB4jK9CNnoG7xxjN1HC3Nz0Ga6aw4roNfwkLRS6/Ck8caBFMIcP5F64s5OPlH69bg
 7sVxNd2O4cqbE0Igavy4fqUm2DV8JrPnCYfkcXVEUIO3ml5g6osbSBdxPYH/RxGQJ6y/
 e+zw==
X-Gm-Message-State: AOJu0YwcwL6NBLel+1kiLRDmbIP8ZHMTRtnJS8Z/ujs6jnTX1Kd4Uzfa
 r/H1mVyC2kHw+wOojZxoE52xy+bxIOhmBBfQryHDzj70Yj0FGzFhMNS26sUtbS/OvnjlcM/LCqR
 0GiEGOg==
X-Google-Smtp-Source: AGHT+IHesmxOMg60A/XeOaybajAeK/+Za+rEP9yJMVYwQr6p/PQTpPP0TX/HDSoPZ5Vnn2TqmFmISg==
X-Received: by 2002:a17:90a:9f0c:b0:290:cd3:a2d2 with SMTP id
 n12-20020a17090a9f0c00b002900cd3a2d2mr1592139pjp.3.1706416944267; 
 Sat, 27 Jan 2024 20:42:24 -0800 (PST)
Received: from stoup..
 (ppp121-45-131-89.bri-pow-que-bras31.tpg.internode.on.net. [121.45.131.89])
 by smtp.gmail.com with ESMTPSA id
 w24-20020a17090aaf9800b002906e09e1d1sm5631873pjq.18.2024.01.27.20.42.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Jan 2024 20:42:23 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>
Subject: [PATCH 02/33] include/exec: Move vaddr defines to separate file
Date: Sun, 28 Jan 2024 14:41:42 +1000
Message-Id: <20240128044213.316480-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240128044213.316480-1-richard.henderson@linaro.org>
References: <20240128044213.316480-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1034.google.com
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


