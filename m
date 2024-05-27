Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DF79C25B79
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 21:21:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBhkd-0007Dz-Uq; Mon, 27 May 2024 17:19:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sBhkc-0007CU-0o
 for qemu-devel@nongnu.org; Mon, 27 May 2024 17:19:26 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sBhka-0003dq-HJ
 for qemu-devel@nongnu.org; Mon, 27 May 2024 17:19:25 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-6f4603237e0so123953b3a.0
 for <qemu-devel@nongnu.org>; Mon, 27 May 2024 14:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716844763; x=1717449563; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s42oGtCBkIpp0pUZgYqorqQOAJjXWlk92oUDYENOXNg=;
 b=nM4hAIUT+L/bwH9AEzrTk5CWPbMteFZmiowaRpBWxnNJ+voa4eDsH9xwdnDyjsV/Y4
 M7jLJpYF1JxLavldlC60dx1/5qKMXSgN5VYiOsxttxcDFnncAxzwHQU302IzyZg3pmhg
 P2eeD5vjgAcKbL743bai6Y2+GcxvzNMKcE33fSdVj+d+FoYe3Pqh6UIO1m/bC7sojVQH
 08rkuqlj9nzIDL6oQGirEIg6/YfkJNv2slHQPowokbfRR0pLRd1Xe/gCYfuDiS9/Z5P+
 sjjJLMgVBq710LJxo7xGD6Vmom325kI0+UvZS/B8x761H+Pa1ezJJQw47rsLqMFA9RLm
 KAUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716844763; x=1717449563;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=s42oGtCBkIpp0pUZgYqorqQOAJjXWlk92oUDYENOXNg=;
 b=S+HyGk52DfsnKv9Mr/rGNIV+gJKE+2W6fbjpFTJPo83E9cnTTelsbdcWbxzR/8sHlp
 mYKjJaZaMm81T4ZhTl76qzwVKv0vHvaDRqDgceBQHYNhI2n8Z7xnqL7Z1X41xCbD1YJL
 5Z0VPYcmWkb3Ycgill5jPvGDe/CFYfaZmrU6d1vOGexCH66BK8JPlHhOHVwMyAh2HTSP
 XiKh0t1yqvEPJKVGWfHDykeoL53taUnQ+EWOpB0h14vmjFlyEK5zBRIvsMQKwDq6u/cg
 QdECp3qLI6LBBYKLeObxQRQ3T1sXgAx8kwwscpgWA0vOMwNNPWrbvwRttNMXtqDwL7bQ
 Hluw==
X-Gm-Message-State: AOJu0YzItr/zG4BOrYvRfZm+HtWQuHCLCr5ZfnzdC/y9fBN4PMEbPFEm
 WnSk70HOuxEwVf4ux7ejTtjv8wPtDKtY/yaCTLXTGFvVh59rFFqSwVGF2SM6YiQ2EqDCnpMphpw
 e
X-Google-Smtp-Source: AGHT+IF/osUwFKxLkPzY7doU16StrLpe8oGjPt4GlcSexSLT/LexKvyz8U+1psrRlFZHWGGhVPiIbA==
X-Received: by 2002:a05:6a00:4007:b0:6f3:8468:8bb with SMTP id
 d2e1a72fcca58-6f8ea1d0715mr13576491b3a.17.1716844762975; 
 Mon, 27 May 2024 14:19:22 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-6f8fd1d4d5fsm5265876b3a.165.2024.05.27.14.19.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 May 2024 14:19:22 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: git@xen0n.name,
	gaosong@loongson.cn
Subject: [PATCH 10/18] tcg/loongarch64: Support LASX in tcg_out_dupi_vec
Date: Mon, 27 May 2024 14:19:04 -0700
Message-Id: <20240527211912.14060-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240527211912.14060-1-richard.henderson@linaro.org>
References: <20240527211912.14060-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/loongarch64/tcg-target.c.inc | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index 9a8f67cf3e..c7d0c7839b 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -1743,7 +1743,12 @@ static void tcg_out_dupi_vec(TCGContext *s, TCGType type, unsigned vece,
     int64_t value = sextract64(v64, 0, 8 << vece);
     if (-0x200 <= value && value <= 0x1FF) {
         uint32_t imm = (vece << 10) | ((uint32_t)v64 & 0x3FF);
-        tcg_out_opc_vldi(s, rd, imm);
+
+        if (type == TCG_TYPE_V256) {
+            tcg_out_opc_xvldi(s, rd, imm);
+        } else {
+            tcg_out_opc_vldi(s, rd, imm);
+        }
         return;
     }
 
-- 
2.34.1


