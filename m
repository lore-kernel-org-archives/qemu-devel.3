Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B254CCA0FED
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 01:07:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ur4bT-0003gv-DQ; Tue, 26 Aug 2025 21:05:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ur4bR-0003fz-L8
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 21:05:29 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ur4bM-0007FF-4S
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 21:05:29 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-771f69fd6feso2003516b3a.1
 for <qemu-devel@nongnu.org>; Tue, 26 Aug 2025 18:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756256722; x=1756861522; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W0ZHX+tn8nkbaFtS2dHaq5l6wD0P0NOK8ivJm8HB/sE=;
 b=wQb44mi3s0kJRrTbc5GsVL4jHgROnzTqE8FCWb/KvDPSsfJX3MVOB+zX+vLA3zxSL2
 SoeEhzJJwl6+2GO2se8v0eu9IxjYkY3xR+XpMYD61hl1wL9bt0AdZqsuvMb7xlV51h3J
 zk8uG2UAVfynpv28DABV89DtJd0vMKmG1ZolMFfNYcmnjoVAf+9mK0V8R/SOka5YBAF0
 Ul7ztkjblco/eTiTyKmxM5BAEAQMdDzIEXXFyd/TEITzZYmhTAebd38iXLEoHmrYCiF8
 TOvMAl4LihImK/ZcDScD5+iK36CkaYUaaK3/1Fu9UQNxpqVi74YE+ckhQmFqwG+13Xo+
 w1Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756256722; x=1756861522;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W0ZHX+tn8nkbaFtS2dHaq5l6wD0P0NOK8ivJm8HB/sE=;
 b=g+C6baZGQ4wK0r7FXypPY6ggkCmf6uRYLZiORGKn3WPN/ra8d2DzuDFYczMvsW/MlB
 Y7M7AH+ua+OcAAR8HJkeTLxOjcvh2nOvDB00Fh+KfaTEbHoPJL/9DK9ACln89ix5NO2G
 Cnj8idB4ozKrCKHqIaymG2HcOXGs1no6Fk+yWE6NPOytWvxrB7cGD4P4h7UDKDuxHR0r
 /cBa8WkJXEHcCFhwRoStbPrMUry/7wJtv4Dn7jstBsq4J4zmA2SHrPbAPH5yt+4Y8sI/
 XEf1xufutYcXejLzqp8JL2yFGmid7eRnlAyj5qa+0LzQL55ubd9LNhkPx4QHwO+WeI0T
 kI+A==
X-Gm-Message-State: AOJu0YyY6vp/Pi+7GbynlAElh+chdFGqj7oK9ZvgejlppdOiYLLKIrbr
 2alMmLancO+KRedpnrwn04Mn1HyQ/UzuvKV7D4rqyTXQhygE9oPh+b7ngaPB6hhJNwpUh8e9XQj
 xFuG4qy4=
X-Gm-Gg: ASbGncvWF90okW5hn5r/wMwiOviXP+AM1McYxAPN67AHzned6bTf+46uSwvuv3RazTj
 Xs8WQ5fXmiafHG+R6DWNbSqx6JETCDKpxBunPt8DLQGnzNF0iBWThKHIZZTLsIcq8/pQkGDlj7x
 Jkct1qxO3P/9gFNVURgrOt0p0M3SiwPNT/RORC4k/Bvh2WqJqVwtrETbv004PcJxlqI9crld1tj
 ycjtpIN51F3nsDHWCEx3z8SRWHcyBTgMIAvnAYHzhJKWlUXAZNo+hrRMMsS+FOmyTHPGfNjOwJQ
 7sgQ4dcEgWsVAjFl19jxHZAqg68YpPE9qCzfB+P/r7kMXJdD+ZK494oeWgZvsjbcK9FlbJIvu92
 khNyY/f6CU6NaP5Mbt3dQWDP7jw==
X-Google-Smtp-Source: AGHT+IHp9JMUDaUPvFVZUSXN8/WZtHQuHKk+gEeUXJsCBdAhtiyDOjKl+fT8uT6sUPNVkuRxov8PDQ==
X-Received: by 2002:a05:6a00:248f:b0:770:34f9:49d2 with SMTP id
 d2e1a72fcca58-77034f94ca1mr17500150b3a.1.1756256722350; 
 Tue, 26 Aug 2025 18:05:22 -0700 (PDT)
Received: from stoup.. ([144.6.121.55]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7720274534esm1419241b3a.47.2025.08.26.18.05.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Aug 2025 18:05:21 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 4/7] target/arm/hvf: Add KVMID_TO_HVF, HVF_TO_KVMID
Date: Wed, 27 Aug 2025 11:03:51 +1000
Message-ID: <20250827010453.4059782-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250827010453.4059782-1-richard.henderson@linaro.org>
References: <20250827010453.4059782-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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

Conversion between KVM system registers ids and the HVF system
register ids is trivial.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/hvf/hvf.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index f0e4b75e6a..2577dc1c0c 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -403,6 +403,26 @@ struct hvf_sreg_match {
     uint32_t cp_idx;
 };
 
+/*
+ * QEMU uses KVM system register ids in the migration format.
+ * Conveniently, HVF uses the same encoding of the op* and cr* parameters
+ * within the low 16 bits of the ids.  Thus conversion between the
+ * formats is trivial.
+ */
+
+#define KVMID_TO_HVF(KVM)  ((KVM) & 0xffff)
+#define HVF_TO_KVMID(HVF)  \
+    (CP_REG_ARM64 | CP_REG_SIZE_U64 | CP_REG_ARM64_SYSREG | (HVF))
+
+/* Verify this at compile-time. */
+
+#define DEF_SYSREG(HVF_ID, ...) \
+  QEMU_BUILD_BUG_ON(HVF_ID != KVMID_TO_HVF(KVMID_AA64_SYS_REG64(__VA_ARGS__)));
+
+#include "sysreg.c.inc"
+
+#undef DEF_SYSREG
+
 #define DEF_SYSREG(HVF_ID, crn, crm, op0, op1, op2) \
     { HVF_ID, HVF_SYSREG(crn, crm, op0, op1, op2) },
 
-- 
2.43.0


