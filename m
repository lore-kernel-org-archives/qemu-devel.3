Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AC3EE77198
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 08:17:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tV4bW-00041a-0T; Tue, 07 Jan 2025 03:06:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tV4ap-0000zx-9Y
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 03:05:39 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tV4aj-0003eJ-9C
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 03:05:39 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2165cb60719so225496135ad.0
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2025 00:05:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736237131; x=1736841931; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MxepohBjEtLtn9A7SojN7LUyZdE2QxIbN3WcYmCqLkQ=;
 b=EkzuWANe5mG1DZcRqqg5VuuGvBUjKKluoJUhYqvnNP38Wf2zn4qVBJlhecePnkIUSZ
 3IJQhRKfs9KatyYcvQuesYOmZG/KvtxMD+vDJbfgxOdICrEJvMzIM8um92EsbDc2nTaR
 mvX9fURVyp84SXQUMGRGZ1B8pIGcCHfwiAopi12YNTUSUe2XbOb2lKR0kGB4RK5owYLV
 G2U4VNTZ7RRBPRPNnCIEhAv4SP64Y8QfmgN9f9xo70GOO7k2WkJN4kRwf0nkPfr+nPZQ
 anLmW0vkNQXlmG5KUh/lGykv8GU0LnMrkmQ1P1XKSifJgz1UPODOQask0oilwsg21y6l
 qWKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736237131; x=1736841931;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MxepohBjEtLtn9A7SojN7LUyZdE2QxIbN3WcYmCqLkQ=;
 b=ouj8b726Vob+My7eI2ZidmnJJKT++htXG3hdCB+yHH8+9HCvHLETUJmsPRzwG/1Qou
 Tr2Dhy88IiVvvF+ZfUVlqqP/vsdPbTEZGXnQBZDkQGvMUjIxV0eHytGURN2ZuOjPY9Zy
 EBhi7+NS5fWZR0YL8FtUflTms0SqODg+5kPeJtcpDEupmc2miQsLMy9rCdvVkPsZPObi
 GRwW9ZGsG+2loSvM1fq23n9CyqK8lm8Ja/5xZuhcCmgaB80dNd7SqhpBCdLYXRgSq3Ea
 /szRfy6JqcVlmFZEw/POeDsgTPusye5+XZskBHSinOU5deuT7f8N5WVPqzJWRmbXmiuf
 Q0Xw==
X-Gm-Message-State: AOJu0YwMYP92CliYi/WjzgpYj/sbAhNi5NcK5ofaXo+YePVxBV55o5Ul
 zGSFFIpzQqNxgFWg4d88H2Fes+2swc5IYRtGvl1UAPb1d9NSdR/S+XyNEF/ri39FmOWklZUa4hq
 X
X-Gm-Gg: ASbGnctlRn71ZQTfXTk2aOAOf0lGS62438Cz+T6VPjJLETRxBW+WC8XYGcBkweWraPI
 90tpuU6NUDmrHkSnqkjljRyFTyggQDmQK/qYGdyIQmilZBRJ+ixwGeC6SZ5KMV2qn8FltWVEHMh
 nRY2vDf+ubbjEc61FoAaBnLbRd6q+AS8mQ5SEPuFvmfV5MCxWpDKPEDVSTo7qIPw+WrcigP0WhJ
 JMxLbop4cTmySLh1sCX6zD8k473GuCAl3QjdtFzN2O2ogjdQ1iO+p9AyTFkc4SbdKWS2PqFbRY7
 FbqhIzwO0xzh+LcKYQ==
X-Google-Smtp-Source: AGHT+IFdTRnyj6fSXa95JI6z/c7Ke9+X6OCpN6ZIVc6NOGWEoZ5Zoz4EKQMgp710BfPUx8VUee99Xg==
X-Received: by 2002:a05:6a00:240c:b0:725:9f02:489f with SMTP id
 d2e1a72fcca58-72abdee7688mr96722265b3a.26.1736237131011; 
 Tue, 07 Jan 2025 00:05:31 -0800 (PST)
Received: from stoup.. (76-14-228-138.or.wavecable.com. [76.14.228.138])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad84eb5dsm32577852b3a.86.2025.01.07.00.05.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2025 00:05:30 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	pierrick.bouvier@linaro.org
Subject: [PATCH v2 72/81] tcg/loongarch64: Do not accept constant argument to
 nor
Date: Tue,  7 Jan 2025 00:01:03 -0800
Message-ID: <20250107080112.1175095-73-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250107080112.1175095-1-richard.henderson@linaro.org>
References: <20250107080112.1175095-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

The instruction set does not implement nor with immediate.
There is no reason to pretend that we do.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/loongarch64/tcg-target.c.inc | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index bc300de523..24d00af2ee 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -1420,12 +1420,7 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
 
     case INDEX_op_nor_i32:
     case INDEX_op_nor_i64:
-        if (c2) {
-            tcg_out_opc_ori(s, a0, a1, a2);
-            tcg_out_opc_nor(s, a0, a0, TCG_REG_ZERO);
-        } else {
-            tcg_out_opc_nor(s, a0, a1, a2);
-        }
+        tcg_out_opc_nor(s, a0, a1, a2);
         break;
 
     case INDEX_op_extract_i32:
@@ -2327,8 +2322,7 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
 
     case INDEX_op_nor_i32:
     case INDEX_op_nor_i64:
-        /* LoongArch reg-imm bitops have their imms ZERO-extended */
-        return C_O1_I2(r, r, rU);
+        return C_O1_I2(r, r, r);
 
     case INDEX_op_clz_i32:
     case INDEX_op_clz_i64:
-- 
2.43.0


