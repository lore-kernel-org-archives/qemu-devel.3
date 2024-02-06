Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD004C48260
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Feb 2024 03:07:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXBmY-0006y4-76; Mon, 05 Feb 2024 22:05:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rXBmV-0006wE-Oa
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 22:05:55 -0500
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rXBmQ-0003Jp-Gs
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 22:05:55 -0500
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-6e0523fbc27so514850b3a.3
 for <qemu-devel@nongnu.org>; Mon, 05 Feb 2024 19:05:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707188749; x=1707793549; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tm00fo32ukKBaFGSugm65eVz3+HZdTUwSvO4kdDzRYM=;
 b=x9eDtN+T0iAt78E0EV+sP9GWYQaBhJJ7jIh+RL8InKhzgP55imRHcUqoSr8CVbY7eF
 q8DvGfz3lBhpw6OqV5PVOLzdHtI6RYd3QuPI6U4264xmkQJ5GSZVXMx4fCxO8VSeAMPi
 3IHre6wIqPyxCUGtG7jdMgG6YCr8j+BpGQO59sGAWYTjsfHvGVdvTTD+iZHty0S/ddTm
 cdRZI0ssA+mypUPeeUzNAWAhNskwD/cjIE5VsOgtfyJFdp64xUnJoVcFWhj7QdcASrSS
 iO8n//PpqNyFkx6HLj/utUWkdqCt9y8Uiwg+Pmp5CYj0yNxOeTfRxCzok277oKSVHAJe
 +J/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707188749; x=1707793549;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tm00fo32ukKBaFGSugm65eVz3+HZdTUwSvO4kdDzRYM=;
 b=nI4r9eh1blIB7pS3Qwc2BR56H8dp8jnm5G8unpY644nHmhxm3OIvGuVI8Z5FTyOuEp
 UtIBQDLQstL4KLcmdMLJ2qWqYm8UAAeU0xqL6+TGPcoJFjGEpy6/lHDBnWRiEEj8uW0U
 oU2C7+d4VQ388vM2WTqIXgs8dbI556av14QtVmF7aEN5t1B/lgbFqBr4ZYMToiDzaL0T
 krIWp2MwErBa3xzbZOFuTwN9j0vUDylqSjUMsTXQ7QVm+sQTEnjlYCDVPW2GaTSVNNtE
 m3WuPcHUB+5xQ6LVKCSfTpC9zuOAPsGQgU0d8TJK+G+IPSNE8+I8+9d3zWcqr5qCIvi+
 o/bA==
X-Gm-Message-State: AOJu0YyzNLQXs4xfPDQRI4g7c5MyLUNqwV38F4/hglbv98tnHbKnZs3b
 y5BvPEkksM6I//j3+msMjviRrRL83iFdNrTr7mRYQCM2VCTHTVFYyUO8IpfoBaXUAl4as0JEHL4
 aRzM=
X-Google-Smtp-Source: AGHT+IE5dQ7GBVEM7w+To9YgNR1JoU4z7VlR6r/cHeYD9I7C5OY0lKGm408rHBWqMqkOJ0RHsu9XSg==
X-Received: by 2002:aa7:874c:0:b0:6e0:5424:6b3a with SMTP id
 g12-20020aa7874c000000b006e054246b3amr987791pfo.11.1707188749199; 
 Mon, 05 Feb 2024 19:05:49 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCU1Y4di2MPgGrpFmen04hrz1M+h89gix+A0v+6dXJzquMB0uqGKoV2Fa1HA+jUoqhgZVTLR3TNZFwjnm8/gD60yh5/VD//MS4rM
Received: from stoup.. ([43.252.112.200]) by smtp.gmail.com with ESMTPSA id
 r14-20020a62e40e000000b006e025030700sm627478pfh.190.2024.02.05.19.05.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Feb 2024 19:05:48 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	gustavo.romero@linaro.org
Subject: [PATCH v2 6/6] target/arm: Fix SVE/SME gross MTE suppression checks
Date: Tue,  6 Feb 2024 13:05:27 +1000
Message-Id: <20240206030527.169147-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240206030527.169147-1-richard.henderson@linaro.org>
References: <20240206030527.169147-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

The TBI and TCMA bits are located within mtedesc, not desc.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/sme_helper.c |  8 ++++----
 target/arm/tcg/sve_helper.c | 12 ++++++------
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/target/arm/tcg/sme_helper.c b/target/arm/tcg/sme_helper.c
index 1ee2690ceb..904bfdac43 100644
--- a/target/arm/tcg/sme_helper.c
+++ b/target/arm/tcg/sme_helper.c
@@ -573,8 +573,8 @@ void sme_ld1_mte(CPUARMState *env, void *za, uint64_t *vg,
     desc = extract32(desc, 0, SIMD_DATA_SHIFT + SVE_MTEDESC_SHIFT);
 
     /* Perform gross MTE suppression early. */
-    if (!tbi_check(desc, bit55) ||
-        tcma_check(desc, bit55, allocation_tag_from_addr(addr))) {
+    if (!tbi_check(mtedesc, bit55) ||
+        tcma_check(mtedesc, bit55, allocation_tag_from_addr(addr))) {
         mtedesc = 0;
     }
 
@@ -750,8 +750,8 @@ void sme_st1_mte(CPUARMState *env, void *za, uint64_t *vg, target_ulong addr,
     desc = extract32(desc, 0, SIMD_DATA_SHIFT + SVE_MTEDESC_SHIFT);
 
     /* Perform gross MTE suppression early. */
-    if (!tbi_check(desc, bit55) ||
-        tcma_check(desc, bit55, allocation_tag_from_addr(addr))) {
+    if (!tbi_check(mtedesc, bit55) ||
+        tcma_check(mtedesc, bit55, allocation_tag_from_addr(addr))) {
         mtedesc = 0;
     }
 
diff --git a/target/arm/tcg/sve_helper.c b/target/arm/tcg/sve_helper.c
index bce4295d28..6853f58c19 100644
--- a/target/arm/tcg/sve_helper.c
+++ b/target/arm/tcg/sve_helper.c
@@ -5800,8 +5800,8 @@ void sve_ldN_r_mte(CPUARMState *env, uint64_t *vg, target_ulong addr,
     desc = extract32(desc, 0, SIMD_DATA_SHIFT + SVE_MTEDESC_SHIFT);
 
     /* Perform gross MTE suppression early. */
-    if (!tbi_check(desc, bit55) ||
-        tcma_check(desc, bit55, allocation_tag_from_addr(addr))) {
+    if (!tbi_check(mtedesc, bit55) ||
+        tcma_check(mtedesc, bit55, allocation_tag_from_addr(addr))) {
         mtedesc = 0;
     }
 
@@ -6156,8 +6156,8 @@ void sve_ldnfff1_r_mte(CPUARMState *env, void *vg, target_ulong addr,
     desc = extract32(desc, 0, SIMD_DATA_SHIFT + SVE_MTEDESC_SHIFT);
 
     /* Perform gross MTE suppression early. */
-    if (!tbi_check(desc, bit55) ||
-        tcma_check(desc, bit55, allocation_tag_from_addr(addr))) {
+    if (!tbi_check(mtedesc, bit55) ||
+        tcma_check(mtedesc, bit55, allocation_tag_from_addr(addr))) {
         mtedesc = 0;
     }
 
@@ -6410,8 +6410,8 @@ void sve_stN_r_mte(CPUARMState *env, uint64_t *vg, target_ulong addr,
     desc = extract32(desc, 0, SIMD_DATA_SHIFT + SVE_MTEDESC_SHIFT);
 
     /* Perform gross MTE suppression early. */
-    if (!tbi_check(desc, bit55) ||
-        tcma_check(desc, bit55, allocation_tag_from_addr(addr))) {
+    if (!tbi_check(mtedesc, bit55) ||
+        tcma_check(mtedesc, bit55, allocation_tag_from_addr(addr))) {
         mtedesc = 0;
     }
 
-- 
2.34.1


