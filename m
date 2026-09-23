Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60238C98304
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 20:36:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9Tgk-0008Gp-Ij; Wed, 23 Sep 2026 16:35:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x9Tg7-00089v-EK
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 16:34:57 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x9Tg5-00050i-UU
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 16:34:55 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-853e2610bb4so97684b3a.0
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 13:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790195692; x=1790800492; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=38rPl2WErEqztjtaSaH7D3tBNYi/tw8oBqoCI67UoZw=;
 b=YjOxHSts4ALB/Np4TC0FJPDq1Z82Dmh+Za7Sorl0nXX8l2WPNYov/3FgCSgi8AlhWD
 BIjMQUqymAFiL+8dFQFUGHB6bkybWU+VAcsQw2E8EXdjeXSKZd/q5W0LIqGy++V6tywe
 XnXRURwgQqZE+JyWILg1dcCWoRnuShPfQB/SDAZZngvdUiDrf46ZN5FfbZU0zzcnP91u
 /dXBPTM9HUxDMCdUzBzbih5+xcQSx+wHdhvLByZwgqLZrCdl/X7N1uvmivxC3g/czeLl
 i7kvc+HEoC27XIe+6H5dF6RW1j3oludALuJ0c+JBzP+fIgqggLBpWF6rcbfbvXPUF45v
 mG1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790195692; x=1790800492;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=38rPl2WErEqztjtaSaH7D3tBNYi/tw8oBqoCI67UoZw=;
 b=SYaE4dt06lZDJNRL7BBwjEOS2RvLPUL5zFzzxA7kNKLcfzdQ66pQ83Dk4Q647869cz
 dpWkmJ22kfj0JU8rB7WN5qH9/XbiNyynJ8XB5ACmusbVJ1XXEIGRAN8Z9OP4gXfX+m8Y
 aCD25wCo4U1fVLxrBd2HOihxRY4ZU8bWuKCNd9agzVAZZIkqZDbOWOn2m7Cy/PNSsO8O
 xCcNcMFOqwZCEJe54itXN1MfV+xDp0xqVjjxejuAmLSCQEhX7q7ulFpuiUbJQzPTAmgf
 BfnU+RjlLBrrKMPpts/FPdBWiI0Z0q9rCGbHUvENIn/iXg+MM8CRfB+/+oBiT6yfuKpP
 lr6g==
X-Gm-Message-State: AFuF++nvuGqMifiIOVKS7RtDd0QO2L2Ke1Fx+ql086Vbu2GEvWVVaKmQ
 SMmHkFM33jXNGXCkbJtH7D3RTRPDfGSf/rZSZk/sLzjdc0+LMvIlI3Ki5aVR4zYRBxWb5ePTICX
 wgXVg
X-Gm-Gg: AYBFou2lwBQIXFBfGZPkltZswzcbQVRpcM/jp2leDsLDsL8ZS8xw5hiYqNvX5JzVGR/
 8dczMQyVvgVvqn1+WyP774PsuxGenl7QHOzZ+VdBI/UdICSwwJZTDykMYye7XyzeeJKs8BBCjvj
 +a+BMuUm14See/oMpmcvR4hnidBKtsYunx19w9eD/cIE+mBkwZ5gwiHByThOx6OeXbpUjuDAC5r
 nhnxwI/H4dSuGnPxuYfBk7iW9BDStB/rGWDWkidt74hRrurcgiVjbqpYHMdkRUmlLNuwixBypeZ
 nIvczVcwFR+diJ39M12WnTMgfeduy8WODjGDG5inF41pq4SNnb38QP0jNSsf9Z2/IW44+H4wCa+
 UdQWcgat2AXlFuSL394Hvf9RTqGL75Rol7Q2UMnG/FxRbzQ39K62iVaOTA658HxwqgYT9vBA1VW
 PeQjczJCfqonOa23G92FPPRI7hJzO5Wbatv1bXV5qnxREF5lQsIaLROdAxaS91vL9w/KYizzYDN
 PLTs4FUZH5SO19C9tClIZNdX0OI8R99Wg+kklSW
X-Received: by 2002:a05:6a00:1885:b0:869:31b1:4ce3 with SMTP id
 d2e1a72fcca58-87e9dac908dmr152660b3a.9.1790195692211; 
 Wed, 23 Sep 2026 13:34:52 -0700 (PDT)
Received: from stoup (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-87d3894211asm1678638b3a.36.2026.09.23.13.34.51
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 13:34:51 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 09/16] tests/tcg/s390x: Add regression test for #4449
Date: Wed, 23 Sep 2026 13:34:34 -0700
Message-ID: <20260923203441.31276-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260923203441.31276-1-richard.henderson@linaro.org>
References: <20260923203441.31276-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tests/tcg/s390x/issue4449.c | 31 +++++++++++++++++++++++++++++++
 tests/tcg/s390x/meson.build |  1 +
 2 files changed, 32 insertions(+)
 create mode 100644 tests/tcg/s390x/issue4449.c

diff --git a/tests/tcg/s390x/issue4449.c b/tests/tcg/s390x/issue4449.c
new file mode 100644
index 00000000000..0c9c80e8cac
--- /dev/null
+++ b/tests/tcg/s390x/issue4449.c
@@ -0,0 +1,31 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#include <assert.h>
+
+#define CASE(name, old, cst, sh)                                        \
+    static void __attribute__((noinline)) case_##name(void) {           \
+        unsigned long t1, got;                                          \
+        __asm__("lhi  %0," #cst "\n\t"   /* low 32 known, high not */   \
+                "lghi %1," #old "\n\t"   /* whole register constant */  \
+                "sllk %1,%0," #sh "\n\t" /* 32-bit write = deposit */   \
+                "brc 15,1f\n\t"          /* ends the translation block */ \
+                "nop\n"                                                 \
+                "1:"                                                    \
+                : "=r"(t1), "=r"(got) : : );                            \
+        unsigned long want = (unsigned)(cst) << (sh);                   \
+        assert(got == want);                                            \
+    }
+
+CASE(a, 256, 128, 1);
+CASE(b, 128, 128, 0);
+CASE(c, 512, 128, 2);
+CASE(d,   2,   1, 1);
+
+int main()
+{
+    case_a();
+    case_b();
+    case_c();
+    case_d();
+    return 0;
+}
diff --git a/tests/tcg/s390x/meson.build b/tests/tcg/s390x/meson.build
index 57ea6c5ca55..39a480033de 100644
--- a/tests/tcg/s390x/meson.build
+++ b/tests/tcg/s390x/meson.build
@@ -84,6 +84,7 @@ tests += {
   'cpacf-pcc.c': {},
   'cpacf-pckmo.c': {},
   'cpacf-prno.c': {},
+  'issue4449.c': {},
 }
 
 foreach src: tests_s390x_pgm
-- 
2.53.0


