Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1619C5475B
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 09:58:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rho1r-0002Op-Ne; Wed, 06 Mar 2024 04:57:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <apatel@ventanamicro.com>)
 id 1rho1q-0002Nw-9X
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 04:57:38 -0500
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <apatel@ventanamicro.com>)
 id 1rho1o-000203-Ji
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 04:57:38 -0500
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-6e56da425b5so1538324b3a.0
 for <qemu-devel@nongnu.org>; Wed, 06 Mar 2024 01:57:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1709719055; x=1710323855; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xQNefR+krr1VU0A0aIDtBMVrljpCFp6IyvTRCLURPL8=;
 b=cZUGC0PsHiACYRKHiiKBSn2QvvWgc63z6rwRv/QTFnmX10jAIqzRB676SxkwGmSCmR
 OUeM7Ucqcu4Mls3MXuqu+y1Rvy2KAs1npidKreQ94KtLELPkS53Sd8M/RKqTQX38JiUw
 SgD6aCH4fuSHPigXiGgTo95CasLGC79jGC9Mqm57AT6YN8RaBkMD9827hLJn+gumc8Pp
 RxZ/zdiJLj3/St/01F3FhHFGo6t0S4Om+AfStMgTwnmbF4Prs4+BlrvPpKrFvT+KRRKO
 H6xmUYQgFYUzJRPojmKEo6SHphEObjFzq4zDN3ED2Np+gcIy4ShlzUEqCe16dxmgJeGU
 0EfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709719055; x=1710323855;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xQNefR+krr1VU0A0aIDtBMVrljpCFp6IyvTRCLURPL8=;
 b=BM1wfe8LHApThdL7a29TwuDcXQNH2WJcslNW+aBTnjSh2eGAN8i5aJJ2HcLrPohinp
 9T7dWw2eYaNYlIqJb2bjNAdyE2VfYvLnZjGS/voHWqjQfzVpNekFCIaIuhjDp+jFAW7W
 y/ZPdI5U+EQ4YCtv7LaXH3AyifFJ19YK/hY1UCUMeR77FdSxDGVQT52VmsZkXk3CGsLu
 Pyjn/3vdcB9da/95mVTsl+X86p6ra9sfmS2xHeDoURys3xdgO/XYjm0HJYIILUDF2/QD
 M40aOYznlY8pjxjpTOWBVvtVeWPbGvv72L2arx2SBjFL5j/8YyIUkOhbOJByppMYOr+6
 PKiw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUo0p63UFmIZjr4oem1a05QrhtGojReHRxty9C0VI4pTXXvAwKx0aBTJpPLo5h7VBmZVn0gm+srcCEq9szWkLK725FsRes=
X-Gm-Message-State: AOJu0Yw2u7TQlzdoVwJJIJMbY18tsSllxFNf2JxAuPEYrISYcnuEojLy
 oGT80OXpZ9JOfw56zzMLPYHa2E+wfVF8ruZQTFraz5FyD63NcTM1IH19IPcwKIs=
X-Google-Smtp-Source: AGHT+IFu+NwzcRrsXXSU1nbSJvT2Q8d8rOvxy9qrpNmMYqqimICZwglpLbf0gAU84iIE7vH51POlrQ==
X-Received: by 2002:a05:6a20:2d94:b0:1a1:4970:6dff with SMTP id
 bf20-20020a056a202d9400b001a149706dffmr3514889pzb.53.1709719055144; 
 Wed, 06 Mar 2024 01:57:35 -0800 (PST)
Received: from anup-ubuntu-vm.localdomain ([171.76.80.45])
 by smtp.gmail.com with ESMTPSA id
 z15-20020a170903018f00b001d9a41daf85sm12126170plg.256.2024.03.06.01.57.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Mar 2024 01:57:34 -0800 (PST)
From: Anup Patel <apatel@ventanamicro.com>
To: Peter Maydell <peter.maydell@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Atish Patra <atishp@atishpatra.org>, Anup Patel <anup@brainfault.org>,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH 1/2] hw/intc/riscv_aplic: Fix setipnum_le write emulation for
 APLIC MSI-mode
Date: Wed,  6 Mar 2024 15:27:21 +0530
Message-Id: <20240306095722.463296-2-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240306095722.463296-1-apatel@ventanamicro.com>
References: <20240306095722.463296-1-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=apatel@ventanamicro.com; helo=mail-pf1-x429.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

The writes to setipnum_le register in APLIC MSI-mode have special
consideration for level-triggered interrupts as-per section "4.9.2
Special consideration for level-sensitive interrupt sources" of the
RISC-V AIA specification.

Particularly, the below text from the RISC-V specification defines
the behaviour of writes to setipnum_le for level-triggered interrupts:

"A second option is for the interrupt service routine to write the
APLIC’s source identity number for the interrupt to the domain’s
setipnum register just before exiting. This will cause the interrupt’s
pending bit to be set to one again if the source is still asserting
an interrupt, but not if the source is not asserting an interrupt."

Fix setipnum_le write emulation for APLIC MSI-mode by implementing
the above behaviour in riscv_aplic_set_pending() function.

Fixes: e8f79343cfc8 ("hw/intc: Add RISC-V AIA APLIC device emulation")
Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 hw/intc/riscv_aplic.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/hw/intc/riscv_aplic.c b/hw/intc/riscv_aplic.c
index e98e258deb..775bb96164 100644
--- a/hw/intc/riscv_aplic.c
+++ b/hw/intc/riscv_aplic.c
@@ -218,13 +218,25 @@ static void riscv_aplic_set_pending(RISCVAPLICState *aplic,
     }
 
     sm = sourcecfg & APLIC_SOURCECFG_SM_MASK;
-    if ((sm == APLIC_SOURCECFG_SM_INACTIVE) ||
-        ((!aplic->msimode || (aplic->msimode && !pending)) &&
-         ((sm == APLIC_SOURCECFG_SM_LEVEL_HIGH) ||
-          (sm == APLIC_SOURCECFG_SM_LEVEL_LOW)))) {
+    if (sm == APLIC_SOURCECFG_SM_INACTIVE) {
         return;
     }
 
+    if ((sm == APLIC_SOURCECFG_SM_LEVEL_HIGH) ||
+        (sm == APLIC_SOURCECFG_SM_LEVEL_LOW)) {
+        if (!aplic->msimode || (aplic->msimode && !pending)) {
+            return;
+        }
+        if ((aplic->state[irq] & APLIC_ISTATE_INPUT) &&
+            (sm == APLIC_SOURCECFG_SM_LEVEL_LOW)) {
+            return;
+        }
+        if (!(aplic->state[irq] & APLIC_ISTATE_INPUT) &&
+            (sm == APLIC_SOURCECFG_SM_LEVEL_HIGH)) {
+            return;
+        }
+    }
+
     riscv_aplic_set_pending_raw(aplic, irq, pending);
 }
 
-- 
2.34.1


