Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39F74C87FC5
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Jul 2025 00:10:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uf60G-00066X-D3; Thu, 24 Jul 2025 20:09:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3LsuCaA4KChs1C5OI9381I4JFE7FF7C5.3FDH5DL-45M5CEFE7EL.FI7@flex--alexrichardson.bounces.google.com>)
 id 1uf603-00061C-6g
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 20:09:23 -0400
Received: from mail-pl1-x649.google.com ([2607:f8b0:4864:20::649])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3LsuCaA4KChs1C5OI9381I4JFE7FF7C5.3FDH5DL-45M5CEFE7EL.FI7@flex--alexrichardson.bounces.google.com>)
 id 1uf601-0004SC-Cm
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 20:09:22 -0400
Received: by mail-pl1-x649.google.com with SMTP id
 d9443c01a7336-23fae3a808bso1628355ad.3
 for <qemu-devel@nongnu.org>; Thu, 24 Jul 2025 17:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1753402158; x=1754006958; darn=nongnu.org;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=xeTKs6Akw7bNbP9o2V9XNUY70Fjt6JXSC9NzDIMyQ08=;
 b=o+yB0WINm8+cV5fJ21dpTBH/YIn80cMNKsuLQ1IhWZz5Her9kn9NmKkphPmxKcCOgP
 kQqtdrX062r5rpHqp6DkiksxOdVJrY2y1TEv/eFxJh1ZaH3b4NKyQNTayrJzSMRb6seb
 7uJyTLDoLRXePTFYM+z6WKQ5eU7E7CkKEWD/r0cnMYWbK8jhaJEhQdGQSRkMR2NC1wSJ
 vhXzB44YUrCtQ57BCKOYF7zGEe92vG3dHkhyRiASI0VLO21npzpNpcXWpRDyuplVmoYy
 +QMdtO663CN6/z7kLkvimQCVqRxW6hbCQvYQwC6tL83n9CZF4Cv8D9+wRPTQCCEoYoZM
 A2xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753402158; x=1754006958;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xeTKs6Akw7bNbP9o2V9XNUY70Fjt6JXSC9NzDIMyQ08=;
 b=Ld3d99hi3MMbhbgzPZRVUDJ7dcGrvKSsBVkoHtsMODESwaYvr2TOEE7fGfwnHunfps
 p2OYfMfPIEDeqoxLXMFtn27SwnsDrQXL+J9LOr//jMMtahes1glvkVbVJwemZJObNAXh
 itz6IrdN7TsXRImNUDaZlyT4Bbhov+pNhUnqVBxvQEgqcs6q/h5cewWdZcI5OaNC+wyT
 AzVImidNA0/oT1UoQ0WeBHF8C4ii2c3vV6N91XHoeOscUW0NKcpBRre+E2AbiPGaP44w
 WNNFMz9iEv8apdj5sn337QzeT8Ul98/OOL60U2ErZetrgg4cJYNLG1FC/WSzr5kIKdDo
 229A==
X-Gm-Message-State: AOJu0Yxd5Gt/uVX9SaTCiOeHAQF+RFnH81FK63WqiHQuNhsv4ClqYkAc
 S+shhJEB2hn4BeNQkOrq88yppntjB4BJXHdaL0oMJMye1YR0Lrxq5TC2mm7isegjtd1OTJ7djtK
 +6HBM5xLt9dhzOwhMwQHK7KD13DtY+w+E7VaY7kewjaiBCmLmYxwJ0i8yBUo+QEEd+aJHZYEig9
 Z6RqjfzQhjj0pW/oCOI/En0kCW8swd2i6Jo+aN6UhFXA/OQyAQ134ujhFtcw61dzI+YHTtr/EVZ
 cBP6A==
X-Google-Smtp-Source: AGHT+IFAqppbpPB5ofki4xRY8Z1XFXJIf0rWhTkJoX4YHi6ECIy4dOTHH5KSbOCNN/bpOvVxxZFV1ulo0CCFvim6IclZQQ==
X-Received: from plhd15.prod.google.com ([2002:a17:903:230f:b0:234:a0aa:5b34])
 (user=alexrichardson job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:b87:b0:235:f45f:ed2b with SMTP id
 d9443c01a7336-23f981619c9mr118846055ad.1.1753402158302; 
 Thu, 24 Jul 2025 17:09:18 -0700 (PDT)
Date: Thu, 24 Jul 2025 17:09:01 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.1.470.g6ba607880d-goog
Message-ID: <20250725000901.1204536-1-alexrichardson@google.com>
Subject: [PATCH v2] target/arm: add support for 64-bit PMCCNTR in AArch32 mode
From: Alex Richardson <alexrichardson@google.com>
To: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: Alex Richardson <alexrichardson@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::649;
 envelope-from=3LsuCaA4KChs1C5OI9381I4JFE7FF7C5.3FDH5DL-45M5CEFE7EL.FI7@flex--alexrichardson.bounces.google.com;
 helo=mail-pl1-x649.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

In the PMUv3, a new AArch32 64-bit (MCRR/MRRC) accessor for the
PMCCNTR was added. In QEMU we forgot to implement this, so only
provide the 32-bit accessor. Since we have a 64-bit PMCCNTR
sysreg for AArch64, adding the 64-bit AArch32 version is easy.

We add the PMCCNTR to the v8_cp_reginfo because PMUv3 was added
in the ARMv8 architecture. This is consistent with how we
handle the existing PMCCNTR support, where we always implement
it for all v7 CPUs. This is arguably something we should
clean up so it is gated on ARM_FEATURE_PMU and/or an ID
register check for the relevant PMU version, but we should
do that as its own tidyup rather than being inconsistent between
this PMCCNTR accessor and the others.

Since the register name is the same as the 32-bit PMCCNTR, we set
ARM_CP_NO_GDB to avoid generating an invalid GDB XML.

See https://developer.arm.com/documentation/ddi0601/2024-06/AArch32-Registers/PMCCNTR--Performance-Monitors-Cycle-Count-Register?lang=en

Signed-off-by: Alex Richardson <alexrichardson@google.com>
---
 target/arm/cpregs-pmu.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/target/arm/cpregs-pmu.c b/target/arm/cpregs-pmu.c
index 0f295b1376..ef176e4045 100644
--- a/target/arm/cpregs-pmu.c
+++ b/target/arm/cpregs-pmu.c
@@ -1276,6 +1276,12 @@ void define_pm_cpregs(ARMCPU *cpu)
               .access = PL0_R, .accessfn = pmreg_access, .type = ARM_CP_CONST,
               .fgt = FGT_PMCEIDN_EL0,
               .resetvalue = cpu->pmceid1 },
+            { .name = "PMCCNTR", .state = ARM_CP_STATE_AA32,
+              .cp = 15, .crm = 9, .opc1 = 0,
+              .access = PL0_RW, .accessfn = pmreg_access_ccntr, .resetvalue = 0,
+              .type = ARM_CP_ALIAS | ARM_CP_IO | ARM_CP_64BIT | ARM_CP_NO_GDB,
+              .fgt = FGT_PMCCNTR_EL0, .readfn = pmccntr_read,
+              .writefn = pmccntr_write,  },
         };
         define_arm_cp_regs(cpu, v8_pm_reginfo);
     }
-- 
2.50.1.470.g6ba607880d-goog


