Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B67AC83F25
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 13:29:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udqYt-0007bR-GZ; Mon, 21 Jul 2025 09:28:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1udqYB-00009m-Ci
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 09:27:40 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1udqY7-0005HX-O5
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 09:27:26 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3a54700a46eso2386572f8f.1
 for <qemu-devel@nongnu.org>; Mon, 21 Jul 2025 06:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753104442; x=1753709242; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=qIaOxCI5fy5oW8HBDIV+uJ9KDuDzR7caM4buiAgm8WU=;
 b=KWNnlT6Qg6jJkqJRT2hJKv9QdN1f8IN784Aishs4SmxgoKwYbRu3MRLOTUFxQb/xua
 GjDE5y1Ju8s0cE9fs+LpNbGxF5Z25vfaJRMS3cI5aLL3ZKBbH7X8sUy0NVsH5qlAwA2l
 4dUlKUVrmwTQJzEMbDENweti//N76N+pqgERGE4rDGvT/+q6q1WvCHXwup/Ewk/gMHox
 uVvaNlP9ndnnNzF5etjibKpTf6ExUc4P5Wqr/ZrpdazLCuWj8QYbgSrrqjEzz7wjET1W
 4y3753XOC+12Oam2GEfYm4PZ8UO9fQrog45FMMufK9dReyD7u6K71ALnXL11vgpvnN4O
 9apw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753104442; x=1753709242;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qIaOxCI5fy5oW8HBDIV+uJ9KDuDzR7caM4buiAgm8WU=;
 b=Tcw9IJXVSiTkNg3ePqGwdRJS6l0l2FQ789KTDj+KOwCG6UZ95QYlEYYAY78ln3nWwo
 S8QDgbuTvc/dZcLYefXFlWoBnBolT0An9IV3JuQc6VQsmwbR+rKMqP8LfF4A16pJMI0Y
 eAOM35MuCgGJcJ4QWaNy2GqifCxeKLRv8/X/jmZqkcq+3nbBoPirAJUgN8k2GPfs/DfS
 eaPgGPaH/cjpJuHR/t3+nONuxryhYlCCR1VmVaGOj+cfhNITU9VxOZCWtA22dfKpc7Dr
 ZK8Kw898jTuWkJmv+pY3F2YM8dtUuBvesww8Nkp3RMWkeSkV2sueRx2yN+USO2J7eU5t
 xjNA==
X-Gm-Message-State: AOJu0YzYyuvHLfyAJa71P3tN0BsKjTxuxirlE+mfYpGrOXUZ1HJZtZFq
 gfNuCIhG/+bo1/q0VPj3mbM1LlogetJl1SysA7oGdWcc9IPirZMhOm+SHv/mSYoFZTXxG0rPj3n
 ++khE
X-Gm-Gg: ASbGnct8ROY0BHJBKL/8oUH5eoFPtwTPAMkFcsvMX1ps/m8qpfFDcdT476Ui1QtxZz9
 om+7feJEcz4i0PXPdudq8EytyWkktUnqIwGv/hAeLv5M9Qj1uquQWGY+oDwcV0269aUTZfNXvvo
 tW559yxRojg/oejVO0KloLUBtht3QSdds6PnJBhpSk7y1DUy0PjPVrlsx3c20dStRAnWer3nMvk
 1rjqy/3VwBJwdLc3bQ8MsRSWGf+rEgTVkfMFmhMBpnp72c0ANTNf51MMF6rc4M5oVJBbUra0ueC
 6WmYQ8LNMEYe0GaKPeEJc1F5M6OVUU/FaQZF3h8PY6SOUpdUj3MyHc3kp5SCPAFmi+OHG61c/uo
 AvBmASIgfmAHzkAoC+BGOxD69mf6T
X-Google-Smtp-Source: AGHT+IF32i2qZ8v//GNpQFaYUB4SGYBvDWMeJoXLWUGzs5Wl4XmPhvYIdaa9gGWb2NdQ5xESKRVJcQ==
X-Received: by 2002:a05:6000:4b0b:b0:3a6:d296:feaf with SMTP id
 ffacd0b85a97d-3b613e776fdmr13196354f8f.24.1753104441842; 
 Mon, 21 Jul 2025 06:27:21 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b61ca4c754sm10487946f8f.59.2025.07.21.06.27.21
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Jul 2025 06:27:21 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 02/20] target/arm: Correct encoding of Debug Communications
 Channel registers
Date: Mon, 21 Jul 2025 14:26:59 +0100
Message-ID: <20250721132718.2835729-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250721132718.2835729-1-peter.maydell@linaro.org>
References: <20250721132718.2835729-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x431.google.com
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

We don't implement the Debug Communications Channel (DCC), but
we do attempt to provide dummy versions of its system registers
so that software that tries to access them doesn't fall over.

However, we got the tx/rx register definitions wrong. These
should be:

AArch32:
  DBGDTRTX   p14 0 c0 c5 0  (on writes)
  DBGDTRRX   p14 0 c0 c5 0  (on reads)

AArch64:
  DBGDTRTX_EL0  2 3 0 5 0 (on writes)
  DBGDTRRX_EL0  2 3 0 5 0 (on reads)
  DBGDTR_EL0    2 3 0 4 0 (reads and writes)

where DBGDTRTX and DBGDTRRX are effectively different names for the
same 32-bit register, which has tx behaviour on writes and rx
behaviour on reads.  The AArch64-only DBGDTR_EL0 is a 64-bit wide
register whose top and bottom halves map to the DBGDTRRX and DBGDTRTX
registers.

Currently we have just one cpreg struct, which:
 * calls itself DBGDTR_EL0
 * uses the DBGDTRTX_EL0/DBGDTRRX_EL0 encoding
 * is marked as ARM_CP_STATE_BOTH but has the wrong opc1
   value for AArch32
 * is implemented as RAZ/WI

Correct the encoding so:
 * we name the DBGDTRTX/DBGDTRRX register correctly
 * we split it into AA64 and AA32 versions so we can get the
   AA32 encoding right
 * we implement DBGDTR_EL0 at its correct encoding

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2986
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250708141049.778361-1-peter.maydell@linaro.org
---
 target/arm/debug_helper.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/target/arm/debug_helper.c b/target/arm/debug_helper.c
index 69fb1d0d9ff..aee06d4d426 100644
--- a/target/arm/debug_helper.c
+++ b/target/arm/debug_helper.c
@@ -988,11 +988,20 @@ static const ARMCPRegInfo debug_cp_reginfo[] = {
       .opc0 = 2, .opc1 = 0, .crn = 0, .crm = 3, .opc2 = 2,
       .access = PL1_RW, .accessfn = access_tdcc,
       .type = ARM_CP_CONST, .resetvalue = 0 },
-    /* DBGDTRTX_EL0/DBGDTRRX_EL0 depend on direction */
-    { .name = "DBGDTR_EL0", .state = ARM_CP_STATE_BOTH, .cp = 14,
+    /* Architecturally DBGDTRTX is named DBGDTRRX when used for reads */
+    { .name = "DBGDTRTX_EL0", .state = ARM_CP_STATE_AA64,
       .opc0 = 2, .opc1 = 3, .crn = 0, .crm = 5, .opc2 = 0,
       .access = PL0_RW, .accessfn = access_tdcc,
       .type = ARM_CP_CONST, .resetvalue = 0 },
+    { .name = "DBGDTRTX", .state = ARM_CP_STATE_AA32, .cp = 14,
+      .opc1 = 0, .crn = 0, .crm = 5, .opc2 = 0,
+      .access = PL0_RW, .accessfn = access_tdcc,
+      .type = ARM_CP_CONST, .resetvalue = 0 },
+    /* This is AArch64-only and is a combination of DBGDTRTX and DBGDTRRX */
+    { .name = "DBGDTR_EL0", .state = ARM_CP_STATE_AA64,
+      .opc0 = 2, .opc1 = 3, .crn = 0, .crm = 4, .opc2 = 0,
+      .access = PL0_RW, .accessfn = access_tdcc,
+      .type = ARM_CP_CONST, .resetvalue = 0 },
     /*
      * OSECCR_EL1 provides a mechanism for an operating system
      * to access the contents of EDECCR. EDECCR is not implemented though,
-- 
2.43.0


