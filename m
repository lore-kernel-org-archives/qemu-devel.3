Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2A96E7316F
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 13:36:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmu4L-0007Gb-4t; Mon, 02 Feb 2026 08:34:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vmu4G-00076x-TC
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 08:34:17 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vmu4E-0002iD-GV
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 08:34:16 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4806f9e61f9so22651295e9.1
 for <qemu-devel@nongnu.org>; Mon, 02 Feb 2026 05:34:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770039253; x=1770644053; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gLvC5MaXe0awrq4wxvHbYeODF5FYi1/mHsfwhmhjVlU=;
 b=iQMXfeKFUedlJJ2IPctuMtN3wCwTVzkzG5Fz+ugFGPyuhihsxMkxogutw3+dtPGDyv
 TXI1FHnbAzT5c0L36Ddc10XZHB2ctUYnkQT0eXbC3U94nKNEzu00wBllo/WmIjPE0INI
 uAG/9WN5b7dx4DivYAuSeX7dibUX0eQr1E8GpCQUFCKgGgNA/QgwujlzhSMAz0rPok3g
 /jBYLpOjcI9WzNWfQh6InIGpWDJBMS5xhYBbXzYdhrihX3lj3RLaNc2tzlTzaBTZQf9a
 ocartZmSZZyWB1PHcQvBZXXROGM0p50+lEN9BBr3DOfvNkVyIWD8+a/LYW6YUWoaSJdc
 vaMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770039253; x=1770644053;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gLvC5MaXe0awrq4wxvHbYeODF5FYi1/mHsfwhmhjVlU=;
 b=Z+88YrIrV6xvXBqsowhcEtH+trNbzY0tSg+yebGTKpOCLcnkKK/a1LB32crPTedWmf
 oUpasDkmQoLuxhO9VCsPn8DpLQ5QJlAPuoF7++lN2S5RE5luHuFpwx6+to1xq12ORqQJ
 TTK4+hMOUSSw1HzbPy/AEFEngr8Bx3F+pXs7wG4ul5tJN7m+rGUVdBGhuLkPwqB87qkj
 L/I+jtRK7LiAuOOw9qd7qpjdBPAP/jISILyfhc+fTZw3Sry1fGsKYy6GLNlq2ZzvCLcf
 A10RbLTunfXhFl5W5Pa7EXJKOJSXqi6djFwfvqlPkaluvbbtnwvnB9aSBdYMvs7gnl1r
 V42w==
X-Forwarded-Encrypted: i=1;
 AJvYcCX1hLERWEYef7Asj6XdlDKQseG/04eEA9CR24jrZrECo6kGGynA/3qUJ8agdwiv6wBBpK2QqiE7/zMK@nongnu.org
X-Gm-Message-State: AOJu0Yyb9fz8toqihDcfUOONe3cKfiznh90PbciuUwx0HD6oj6cm65P+
 Vd2ilNdJqC4BVHq54WKBNnPm4eq2l2NaXv0mfb6P4+fzcxDoY5698xhPwuRR0kK/GLM=
X-Gm-Gg: AZuq6aLVhKbuAshSXPVaUfphHdWCtVafx5vwUDYeYBYHyMobsbLjD3PwhmQxIc0h+Yc
 3y1xCI/YrArgsVpV0DcQFxBZpFDK8clN0jfLAzaDMZpaGtmmhiaGX/kbTJZnURaNDXghZtPTZc3
 3J7J52Le01+W59tXdg7jeX6WcQJ6lcm3CyxI/IxktzEIllV/SQqaoo1KifOd2xnYkPLNMklGyJ+
 bjQ5CjCynVhik+7uPt1zEQPAAD3HXlPMrXYww0Qp3vHRBmo1zr2unFExaXSP2DBvO6kV57JQX8v
 a3YerXGDPaxSiD3PobmgHsQ90sFVmWA4ZZj20MthyLeGPU/Xn1EMuSS1qDwTRN3T6xPIULwvZG+
 HxnSCoFyhQz9pXFrHT1VsFEhhosvuXfZW4WXwWIp2RAHC7vJ4wFag3wxbJ92oEk1Y7SeAE8gO/z
 K9Kbg0n7oSeKYW3RS0ZBGAkBTr1o29DA==
X-Received: by 2002:a05:600c:a00a:b0:480:69b6:dfed with SMTP id
 5b1f17b1804b1-482db47d0d1mr159151945e9.24.1770039253035; 
 Mon, 02 Feb 2026 05:34:13 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48066c42895sm478054495e9.14.2026.02.02.05.34.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Feb 2026 05:34:12 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v3 15/15] target/arm: Permit configurations with SME but not
 SVE
Date: Mon,  2 Feb 2026 13:33:53 +0000
Message-ID: <20260202133353.2231685-16-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260202133353.2231685-1-peter.maydell@linaro.org>
References: <20260202133353.2231685-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x330.google.com
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

In commit f7767ca30179 ("target/arm: Disable SME if SVE is disabled")
we added code that forces SME to be disabled if SVE is disabled.
This was something we did in the run-up to a release to avoid an
assertion failure in smcr_write() if the user disabled SVE on the
'max' CPU without disabling SME also.

Now that we have corrected the code so that it doesn't assert
in an SME-without-SVE setup, we can let users select it.

This effectively reverts f7767ca30179.

Note that this now means that command lines like "-cpu max,sve=off"
which used to turn off SME and SVE will now give you a CPU with SME
but not SVE.  This is permitted by our loose "max can always give you
extra stuff" rules, but may be unexpected to users.  Mention this in
the CPU property documentation.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/system/arm/cpu-features.rst | 10 ++++++++--
 target/arm/cpu.c                 | 10 ----------
 2 files changed, 8 insertions(+), 12 deletions(-)

diff --git a/docs/system/arm/cpu-features.rst b/docs/system/arm/cpu-features.rst
index 024119449c..3db1f19401 100644
--- a/docs/system/arm/cpu-features.rst
+++ b/docs/system/arm/cpu-features.rst
@@ -323,12 +323,18 @@ SVE CPU Property Parsing Semantics
       enable SVE2). There are not generally any lower-level controls
       for disabling specific SVE sub-features.
 
+  11) Disabling SVE does not automatically disable SME. If you want to
+      disable both you must use ``sve=off,sme=off``. In particular,
+      for the ``max`` CPU, ``sve=off`` alone will give you a CPU with
+      SME only (and which therefore still has the SVE vector registers).
+      Most users will want to disable both at once.
+
 SVE CPU Property Examples
 -------------------------
 
-  1) Disable SVE::
+  1) Disable SVE and SME::
 
-     $ qemu-system-aarch64 -M virt -cpu max,sve=off
+     $ qemu-system-aarch64 -M virt -cpu max,sve=off,sme=off
 
   2) Implicitly enable all vector lengths for the ``max`` CPU type::
 
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 586202071d..32cd076f6e 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1571,16 +1571,6 @@ void arm_cpu_finalize_features(ARMCPU *cpu, Error **errp)
             return;
         }
 
-        /*
-         * FEAT_SME is not architecturally dependent on FEAT_SVE (unless
-         * FEAT_SME_FA64 is present). However our implementation currently
-         * assumes it, so if the user asked for sve=off then turn off SME also.
-         * (KVM doesn't currently support SME at all.)
-         */
-        if (cpu_isar_feature(aa64_sme, cpu) && !cpu_isar_feature(aa64_sve, cpu)) {
-            object_property_set_bool(OBJECT(cpu), "sme", false, &error_abort);
-        }
-
         arm_cpu_sme_finalize(cpu, &local_err);
         if (local_err != NULL) {
             error_propagate(errp, local_err);
-- 
2.43.0


