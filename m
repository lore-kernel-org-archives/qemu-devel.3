Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95EFDC54E67
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Mar 2024 22:24:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpFCG-0002n9-4h; Tue, 26 Mar 2024 18:23:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rpFCE-0002m3-Kw
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 18:23:06 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rpFCC-00044b-Up
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 18:23:06 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-6e6ce174d45so4516442b3a.3
 for <qemu-devel@nongnu.org>; Tue, 26 Mar 2024 15:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711491783; x=1712096583; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=6YBJjSBn4egJqzEYD4EAYt1+uubsMfVYYuDQBsk59/w=;
 b=Tf/Xwx1+IwuENGGnNO7p1oCqA4VR8epC7o5GW2a/ho4qZJIC9aczVYlcO58xQi/S6M
 U4Kty3OCuwDhLJA/r5b8Mun798XI282K487aWRRlNB0VA1uWzfmOxxf1LlntLKT0huQL
 Hzj7YevKxTAeGHjiqM5mnQ5MSBBPwpgTt1W5BC92qEDxcmAMGyU3ORVePzHZbDFkXs3L
 Tq9OKFc9fuGxtbk3T4M5Qewd5CH1hxMs7eXNssnSE+RKsJrp1spKzdUBpXxFcPto1SnL
 onTrks4EResqFUi1AfV0uAd7PExmYtNXQPz5/gzRopBDzJlRk2GoAaLtQaax/uYuACxo
 sx3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711491783; x=1712096583;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6YBJjSBn4egJqzEYD4EAYt1+uubsMfVYYuDQBsk59/w=;
 b=HAdo0C2obRqgZUa48O3prJNA6d3UkTduY+ANRUovH1MYRRFiywiCHhH8hi4TCQLFTP
 SSSzQaHPkwLkRAgz4s8veFcQltb8N0tJRvklQYSfCwonQvEEQk6sn+0wKBf1jNq6CVOW
 iX5fzWO2P6RsyZKS4erpsoNIUl12DesdexHw/uEtUMmRirMv4+zvWToAr8RDAO/IbKbW
 9UdWOVvHcZYNpznI/WnXbLoXWOROmrSGB2XvBtwxkbCefVaZ1hJnCS2Q5wSF74EqaUz1
 LSJJFEHCGNrgoSYkPWpxnOCJFxKP+lb1zLxHlDhA1HElrvGG+vxS8qBbYRc1dJWy4sLn
 pV3g==
X-Gm-Message-State: AOJu0YxoBNbCPNFaXgQE7mGnCMhNP/84pIT/NYqDzv4/53G1HqNY5jJM
 h/btNT6Iq+RnlDtcJ+/FfZDdOlW/HPJBKDC7+xufu68cuoNSRk4uRayP7aLpAOp6I2oTzmpBy1U
 x
X-Google-Smtp-Source: AGHT+IHXIVjbbBWwusKoh2ZVNMWLu08SpMNdNSObLn4+M9YIjHrw5PVO5XKJjFArIT5IxEpNdcRGMA==
X-Received: by 2002:a05:6a20:158e:b0:1a3:abcf:dba with SMTP id
 h14-20020a056a20158e00b001a3abcf0dbamr12096115pzj.37.1711491783244; 
 Tue, 26 Mar 2024 15:23:03 -0700 (PDT)
Received: from stoup.. (173-197-098-125.biz.spectrum.com. [173.197.98.125])
 by smtp.gmail.com with ESMTPSA id
 le12-20020a170902fb0c00b001e0f366139esm1962577plb.119.2024.03.26.15.23.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Mar 2024 15:23:02 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
Subject: [PATCH for-9.0] tcg/optimize: Fix sign_mask for logical right-shift
Date: Tue, 26 Mar 2024 12:22:59 -1000
Message-Id: <20240326222259.528099-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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

The 'sign' computation is attempting to locate the sign bit that has
been repeated, so that we can test if that bit is known zero.  That
computation can be zero if there are no known sign repetitions.

Cc: qemu-stable@nongnu.org
Fixes: 93a967fbb57 ("tcg/optimize: Propagate sign info for shifting")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2248
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c                    |  2 +-
 tests/tcg/aarch64/test-2248.c     | 25 +++++++++++++++++++++++++
 tests/tcg/aarch64/Makefile.target |  1 +
 3 files changed, 27 insertions(+), 1 deletion(-)
 create mode 100644 tests/tcg/aarch64/test-2248.c

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 752cc5c56b..275db77b42 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -2376,7 +2376,7 @@ static bool fold_shift(OptContext *ctx, TCGOp *op)
          * will not reduced the number of input sign repetitions.
          */
         sign = (s_mask & -s_mask) >> 1;
-        if (!(z_mask & sign)) {
+        if (sign && !(z_mask & sign)) {
             ctx->s_mask = s_mask;
         }
         break;
diff --git a/tests/tcg/aarch64/test-2248.c b/tests/tcg/aarch64/test-2248.c
new file mode 100644
index 0000000000..6cc20e3c6c
--- /dev/null
+++ b/tests/tcg/aarch64/test-2248.c
@@ -0,0 +1,25 @@
+#include <assert.h>
+
+__attribute__((noinline))
+long test(long x, long y, long sh)
+{
+    long r;
+    asm("cmp   %1, %2\n\t"
+        "cset  x12, lt\n\t"
+        "and   w11, w12, #0xff\n\t"
+        "cmp   w11, #0\n\t"
+        "csetm x14, ne\n\t"
+        "lsr   x13, x14, %3\n\t"
+        "sxtb  %0, w13"
+        : "=r"(r)
+        : "r"(x), "r"(y), "r"(sh)
+        : "x11", "x12", "x13", "x14");
+    return r;
+}
+
+int main()
+{
+    long r = test(0, 1, 2);
+    assert(r == -1);
+    return 0;
+}
diff --git a/tests/tcg/aarch64/Makefile.target b/tests/tcg/aarch64/Makefile.target
index ea3e232e65..0efd565f05 100644
--- a/tests/tcg/aarch64/Makefile.target
+++ b/tests/tcg/aarch64/Makefile.target
@@ -10,6 +10,7 @@ VPATH 		+= $(AARCH64_SRC)
 
 # Base architecture tests
 AARCH64_TESTS=fcvt pcalign-a64 lse2-fault
+AARCH64_TESTS += test-2248
 
 fcvt: LDFLAGS+=-lm
 
-- 
2.34.1


