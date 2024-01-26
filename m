Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79F93C47422
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jan 2024 14:39:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTNHM-0002Rz-3K; Fri, 26 Jan 2024 09:34:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rTNHJ-0002MW-FW
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 09:33:57 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rTNHH-0007y3-FR
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 09:33:57 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-33ade380b9fso569794f8f.2
 for <qemu-devel@nongnu.org>; Fri, 26 Jan 2024 06:33:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706279634; x=1706884434; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=VH/lIqQG7z5pWQD+ZUbSPEPHh0W87PjWxNhH7leqI34=;
 b=pxfbL3x8liC28yBalDVO78fNqAm7S8D306lWonqpSmdm6Vyks6Bves3hGmcz/KzCmv
 P2qpLPLEaK0N9I8wsr22xqPaF68OPopufXme4NWmUdsS814MnpDN4yTerswCPumcUT5i
 yr1x8poFxiMPxKoUZznpz0fbYVgSUuArzgiGQNXTFCqOLgM6Fvmg8KZKzvQRZH4RxDc1
 i/wHTgO6KTxjHHL8faPYe8SzV4KRKDJaeTg/zUGXzNMdJCnsuU1OJtCi47KZGz3ZTt3r
 zgOFV44+UniVmE8QLOKg46dUPeOnNJ07KXRH68KM39dEW51xiP+BdTf2/mw3w6rboAhC
 2n5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706279634; x=1706884434;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VH/lIqQG7z5pWQD+ZUbSPEPHh0W87PjWxNhH7leqI34=;
 b=dSpS8raMJr2OA7BoaPOp+a4u3pRQoQDTDyDP3gk7+CP6TNU+uWWNnMR2opRqMUqNhY
 hnnrwbrU/cA+asGc4+lxKTVt8qyUTO1sAhiScAXlaZ6hVISlbVgEyP1/Tk5yljJPZPIc
 IY3oYudK8FaldJjP0zuksfpZOyn4wo1tte/BKAxd2EUTdaXUMjY4StV3jhA1Qc/JnKF+
 759ZoRY3+Gnz4BC7tW5DgIx+/0/LklgQuC7ryTxNY+Z1xz+m82vx4rx6c/dN0EEVPFx4
 z4dgjMUbcXqXEmkWMYcG0N6JPaB+oNU9Jt7s0A2N5bxDMfRQdf94c61nfCD/hGlTZ4Ve
 B50Q==
X-Gm-Message-State: AOJu0YyooSJSOLFLLbo+QzGSKZ2/HXRCTmYWAhp8cuTKeHYnuHR94NI8
 RBQZuo1bUgd+6Ci4cUvHMkyBre1oxQoPtNwHU0kJMNpJ3So26MC2/vt7bsIE2h0TaV9l/uOxEec
 J
X-Google-Smtp-Source: AGHT+IGy5UZwvZDf5pZzkB0r4UefF+sGlNxHPMje43sV/A8kXJ6MOA4HNTyLzgHca3dfAkHGOkdMxA==
X-Received: by 2002:a05:6000:1a54:b0:337:c409:717d with SMTP id
 t20-20020a0560001a5400b00337c409717dmr560655wry.159.1706279634193; 
 Fri, 26 Jan 2024 06:33:54 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 n5-20020a5d4845000000b00337f722e5ccsm1396207wrs.65.2024.01.26.06.33.53
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jan 2024 06:33:54 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 27/36] target/arm: Move e2h_access() helper around
Date: Fri, 26 Jan 2024 14:33:32 +0000
Message-Id: <20240126143341.2101237-28-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240126143341.2101237-1-peter.maydell@linaro.org>
References: <20240126143341.2101237-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x432.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

e2h_access() was added in commit bb5972e439 ("target/arm:
Add VHE timer register redirection and aliasing") close to
the generic_timer_cp_reginfo[] array, but isn't used until
vhe_reginfo[] definition. Move it closer to the other e2h
helpers.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20240118200643.29037-19-philmd@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index e068d353831..e07b2af8a3d 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -3345,20 +3345,6 @@ static const ARMCPRegInfo generic_timer_cp_reginfo[] = {
     },
 };
 
-static CPAccessResult e2h_access(CPUARMState *env, const ARMCPRegInfo *ri,
-                                 bool isread)
-{
-    if (arm_current_el(env) == 1) {
-        /* This must be a FEAT_NV access */
-        /* TODO: FEAT_ECV will need to check CNTHCTL_EL2 here */
-        return CP_ACCESS_OK;
-    }
-    if (!(arm_hcr_el2_eff(env) & HCR_E2H)) {
-        return CP_ACCESS_TRAP;
-    }
-    return CP_ACCESS_OK;
-}
-
 #else
 
 /*
@@ -6546,6 +6532,21 @@ static const ARMCPRegInfo el3_cp_reginfo[] = {
 };
 
 #ifndef CONFIG_USER_ONLY
+
+static CPAccessResult e2h_access(CPUARMState *env, const ARMCPRegInfo *ri,
+                                 bool isread)
+{
+    if (arm_current_el(env) == 1) {
+        /* This must be a FEAT_NV access */
+        /* TODO: FEAT_ECV will need to check CNTHCTL_EL2 here */
+        return CP_ACCESS_OK;
+    }
+    if (!(arm_hcr_el2_eff(env) & HCR_E2H)) {
+        return CP_ACCESS_TRAP;
+    }
+    return CP_ACCESS_OK;
+}
+
 /* Test if system register redirection is to occur in the current state.  */
 static bool redirect_for_e2h(CPUARMState *env)
 {
-- 
2.34.1


