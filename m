Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CACF8CAC592
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 18:51:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0ldP-0006XU-M6; Mon, 22 Sep 2025 14:51:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v0lcG-0005D9-Dp
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 14:50:24 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v0lc2-0004SY-Hj
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 14:50:24 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-77f2c7ba550so1514888b3a.1
 for <qemu-devel@nongnu.org>; Mon, 22 Sep 2025 11:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758567009; x=1759171809; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uYZVHQlk4d6HnzzfYjRHoTWH8habiT3aFxflfmcItEk=;
 b=rbCrY69zejy/6oHU0Gw/Ugz25+YC2rav6oYt4ytD3V6n6EPKHXz1q+clLJlDIjH+5e
 ryzepMyFrq3jhJN9Scm6//p1x50XSON9G3mnP8GELfAZzjrzuKN5cw5hvp2nnOaywo5a
 mJcMSys25urYyvVlMRSNEwfZ0I0Fu+KvRQgTZnBHdQiFqaN4ug/mFuWgxY48bsiEPOG2
 04tXhmLbvbXs892ZlQdLfcr5vUeNe4qC37k2n+se1dKSM0hXSti9IaHqeT95u6toXEn+
 vMYCKpeA61aZ+mcmdCh945wD3fCx03I4yXnFCalE0cE1QB7K0TTlj9LW1m0Q7aV2DqxB
 aHVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758567009; x=1759171809;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uYZVHQlk4d6HnzzfYjRHoTWH8habiT3aFxflfmcItEk=;
 b=UG31sepmcFtS4DcpfG6nPZttzwfZ9+V44LyHEy6O9bvX2xWJJ6gSC8bvKWCsECWlnw
 kyw08YCvSRzFqKEUhzYsfaBHqNxA+ICc3GJdfez9xqENXKv1rsfGNPbnNsaBL0nEwg58
 ONEbXqK1EDSs6hwx7PefuJSvJZYJvcCWSzKDFs0ARTJqgxwSNvjMh6Mc1ejU7FLm++49
 4tDM/qreeqIKiBezR9WUu7sY1JkLLdn3x/5fFNQADN/I7CNTRkpZxpDES32F9yGDgX7O
 Q9uN82nQDLLHiNRoC4A+tRrh4uw8DhvTZz2WjYKnXx4MK7m+FhHQJJjhLFx89jeRBeMH
 4Zsw==
X-Gm-Message-State: AOJu0Yy3ruaHavwWJHssMDypvfqW8IKze8seS9kG2MG852A3i+Q/iKwM
 ASluO7pRdGoVtgV3XMZ/OIuVM5sJQVlsN64d/zWD2d8JOTbGUynU8CT0G+Cbi3t5fRG8cRFOHv+
 d7a8i
X-Gm-Gg: ASbGnctxqLotZ9mTHHeSwlJKgIkXF68cVcwcfV73qcaOI9s2VErCOoM7y9rCFgyEaE0
 sFLSQVNZhNEwzBq1PO07ut1ftUDie05sQ90XjRGffV/5/krn2U83/vui0DbgwcpahQ+Lp/NsB0y
 UF6iApRMQG9wPFwfsFcUY1dS1Si4n4cFTuN5NSCBk6dxCfaGjL8yXl+0I0PA5OqPDT6u/aLBmyR
 aw5M4Im2pnfnLj8dR6TdmiSqF7ao3wgKNA6EXvP6+QP2zhz8nh+aSzqk2Dp4aq71WybKlKY41p1
 OQFLBzSWZ2s91gqM5z+iMDXrRqA1aq9upG1WU557kZFfdPk8PAoLcJoAG7oCwjIUWGB/pzzqpJD
 b010e6UpgeM0cf1+HXqMqqUv+A6Sk
X-Google-Smtp-Source: AGHT+IHeCYVE2fKIw3lDFjoSLtDVbfyu3rBP9/LY5YhAbRcsSgiBt51+kURs+rCZKMcgL3qscD3K+w==
X-Received: by 2002:a05:6a00:2190:b0:77d:52a1:ac6e with SMTP id
 d2e1a72fcca58-77e4eac6e2fmr16200123b3a.19.1758567008874; 
 Mon, 22 Sep 2025 11:50:08 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-77e5fe6de75sm10583861b3a.19.2025.09.22.11.50.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Sep 2025 11:50:08 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Gustavo Romero <gustavo.romero@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v5 36/76] target/arm: Implement FEAT_CHK
Date: Mon, 22 Sep 2025 11:48:44 -0700
Message-ID: <20250922184924.2754205-37-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250922184924.2754205-1-richard.henderson@linaro.org>
References: <20250922184924.2754205-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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

This feature contains only the CHKFEAT instruction.  It has
no ID enable, being back-allocated into the hint nop space.

Reviewed-by: Gustavo Romero <gustavo.romero@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-a64.c | 14 ++++++++++++++
 docs/system/arm/emulation.rst  |  1 +
 target/arm/tcg/a64.decode      |  1 +
 3 files changed, 16 insertions(+)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index d5c41fbb3a..9dfcf4f993 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -2124,6 +2124,20 @@ static bool trans_AUTIBSP(DisasContext *s, arg_AUTIBSP *a)
     return true;
 }
 
+static bool trans_CHKFEAT(DisasContext *s, arg_CHKFEAT *a)
+{
+    uint64_t feat_en = 0;
+
+    if (s->gcs_en) {
+        feat_en |= 1 << 0;
+    }
+    if (feat_en) {
+        TCGv_i64 x16 = cpu_reg(s, 16);
+        tcg_gen_andi_i64(x16, x16, ~feat_en);
+    }
+    return true;
+}
+
 static bool trans_CLREX(DisasContext *s, arg_CLREX *a)
 {
     tcg_gen_movi_i64(cpu_exclusive_addr, -1);
diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index 94a6192fa9..4b07af9eac 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -28,6 +28,7 @@ the following architecture extensions:
 - FEAT_BF16 (AArch64 BFloat16 instructions)
 - FEAT_BTI (Branch Target Identification)
 - FEAT_CCIDX (Extended cache index)
+- FEAT_CHK (Check Feature Status)
 - FEAT_CMOW (Control for cache maintenance permission)
 - FEAT_CRC32 (CRC32 instructions)
 - FEAT_Crypto (Cryptographic Extension)
diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 55ff6c504f..8283a9c83d 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -256,6 +256,7 @@ ERETA           1101011 0100 11111 00001 m:1 11111 11111 &reta  # ERETAA, ERETAB
     AUTIASP     1101 0101 0000 0011 0010 0011 101 11111
     AUTIBZ      1101 0101 0000 0011 0010 0011 110 11111
     AUTIBSP     1101 0101 0000 0011 0010 0011 111 11111
+    CHKFEAT     1101 0101 0000 0011 0010 0101 000 11111
   ]
   # The canonical NOP has CRm == op2 == 0, but all of the space
   # that isn't specifically allocated to an instruction must NOP
-- 
2.43.0


