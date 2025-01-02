Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB793E77188
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2025 18:11:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTPbb-00075W-G8; Thu, 02 Jan 2025 13:07:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tTPbD-0006xv-T2
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 13:07:12 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tTPb7-000583-QF
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 13:07:09 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-21628b3fe7dso154567245ad.3
 for <qemu-devel@nongnu.org>; Thu, 02 Jan 2025 10:07:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735841224; x=1736446024; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=l/zHxQ1TEO67dkYLX1iTmVjmncRezW7iF6ZKF+ZcFKs=;
 b=gzgd/x72G2hBHfY6dYD16q8uiy0rH3oGSW0TRWmLCROLZ/DPt+/QJxEjZO+8QKSe2t
 exC9I8wyAcBw6miS2IGyQgoJ9YgAr2cRC796ab1Npr6tIKCcGIB1z4PKxy1Y4yaM4v1u
 4Gi3bp3K34/FvqpYTINdQf8ChizMRt/TiWCSUGjjMEgs3SbJFc8JV12oFwX9Yiy+OeIL
 /sf+C5Gm4EeRARD+qc+uBnVimMdehVmAh25idtX8jebbiKyuajYPWsd1u0yxYTmUCThy
 FpOaK6KFi0EuvXbzIj4B9K+e9i4ecfMqH1+gZcbXFwwXWJrwmSasUkieikekMdst1vmu
 3ddQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735841224; x=1736446024;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=l/zHxQ1TEO67dkYLX1iTmVjmncRezW7iF6ZKF+ZcFKs=;
 b=IKVsy5ZqMgl5Ll76x1fDj4H3Z+avpmC8mHFn+mcR/JHKw/3u+9Qy55z2iHPrmL4A62
 QkpveS3TcyyDp9R31cNJvTF7M4RDzM8Vpf6lnpR/P+FjnAerAPjNkU7spgu4whyANi/4
 f1nTbCx5E16GBGPzh/8jVO4Lo0RlCZTB/sP1xlAyBVbcxRFOPNYc3b+LeMkjv/eLn8Vb
 Ifk8yX6W2LVpx2ciMdYYnO8Iv1tIiSM1KhCbYFxWYyh4eowncOqMSLKqzgT7pb+KhiRy
 Mus0WgUkuntqmAlPJdiBHmyDC2YLSLyWtVRT2Z0qtGEVcPfZkQV9Lma6trpWtkWH5GL1
 Oupg==
X-Gm-Message-State: AOJu0YxhHWFtop0a9HH6icA40tXSDiuqAYe4XRxzrW5b1+tmX5oCeDNl
 jkTYiIz+jUqPuPrh1quW9NKY1XC3DQp2fy4eZbQbV5eTnF46LKTc6B+enf62Fz+frEFMehDz3n4
 P
X-Gm-Gg: ASbGnct6+AzawwQyFiKhr3SMwF1eEXAERpyb//Lb6iubnDoqpOKfz3OVpAtXCzoJ1Qs
 ojIlZ4UP7hswV+vSjF/Ks+F3cuVKwi/dtfl+ONu5WDMySK2gMPCPHrcY2r040zK4TrydixqsqEd
 G5/1CtMLThWpgDqtUqYRYeq75w1xTFPrt2aFpqz1bGVpliq2Z69Z79xUnPz/c2Woa8Wl9LoyFBw
 RIAsVudevpR6UQTk8h9Vto3WWue0Rp0RMkaTXUphcszggjq2rVc1vvckJX6pg==
X-Google-Smtp-Source: AGHT+IGJm7qnQHXpQjZsZI1yr7U2l/Vx180+k9+rJ42kvXmxQR9y2nsSoSyq6Kjk3ROV70Emkyu7QA==
X-Received: by 2002:a05:6a21:9103:b0:1e0:d766:8da1 with SMTP id
 adf61e73a8af0-1e5e083e4f5mr71288347637.39.1735841224463; 
 Thu, 02 Jan 2025 10:07:04 -0800 (PST)
Received: from stoup.. ([63.239.63.212]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72ad3393d5fsm20604456b3a.154.2025.01.02.10.07.04
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jan 2025 10:07:04 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 11/73] tcg: Add tcg_op_deposit_valid
Date: Thu,  2 Jan 2025 10:05:51 -0800
Message-ID: <20250102180654.1420056-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250102180654.1420056-1-richard.henderson@linaro.org>
References: <20250102180654.1420056-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg.h |  1 +
 tcg/tcg.c         | 22 ++++++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
index d8591d6c9e..a27b8d77e9 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -831,6 +831,7 @@ typedef struct TCGTargetOpDef {
 } TCGTargetOpDef;
 
 bool tcg_op_supported(TCGOpcode op, TCGType type);
+bool tcg_op_deposit_valid(TCGType type, unsigned ofs, unsigned len);
 
 void tcg_gen_call0(void *func, TCGHelperInfo *, TCGTemp *ret);
 void tcg_gen_call1(void *func, TCGHelperInfo *, TCGTemp *ret, TCGTemp *);
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 3a0ad03fd5..657534c6a9 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -2254,6 +2254,28 @@ bool tcg_op_supported(TCGOpcode op, TCGType type)
     }
 }
 
+bool tcg_op_deposit_valid(TCGType type, unsigned ofs, unsigned len)
+{
+    switch (type) {
+    case TCG_TYPE_I32:
+        tcg_debug_assert(ofs < 32);
+        tcg_debug_assert(len > 0);
+        tcg_debug_assert(len <= 32);
+        tcg_debug_assert(ofs + len <= 32);
+        return TCG_TARGET_HAS_deposit_i32 && TCG_TARGET_deposit_i32_valid(ofs, len);
+
+    case TCG_TYPE_I64:
+        tcg_debug_assert(ofs < 64);
+        tcg_debug_assert(len > 0);
+        tcg_debug_assert(len <= 64);
+        tcg_debug_assert(ofs + len <= 64);
+        return TCG_TARGET_HAS_deposit_i64 && TCG_TARGET_deposit_i64_valid(ofs, len);
+
+    default:
+        g_assert_not_reached();
+    }
+}
+
 static TCGOp *tcg_op_alloc(TCGOpcode opc, TCGType type, unsigned nargs);
 
 static void tcg_gen_callN(void *func, TCGHelperInfo *info,
-- 
2.43.0


