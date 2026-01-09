Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B226BD232E8
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 07:02:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ve6RG-0005tt-0Z; Fri, 09 Jan 2026 01:57:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1ve6Py-0004HZ-Aa
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 01:56:18 -0500
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1ve6Pw-0002st-AC
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 01:56:18 -0500
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-c026e074373so2039520a12.1
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 22:56:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767941771; x=1768546571; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/I2ae6W/g5Y8Bus0uQM50dGXtk4AiQeiFr067MHCGJI=;
 b=e2Nhj/CCn70Vu1jgfuDcarsufrIR+VvJ3P2W/7wgq8D4kPesX1Rvwgn9ECURBJtEKO
 WiN6nEBSIJ3maAqrwFgQlB0VX3EWl0npgINKNYBsPWTEBIg81n1eXRAnj9uB1ti6qhwI
 7qOvq0q7e074Zj5D75OyVnLfLB9xhq6uexJzawjnt+ny5Bi5EjRVv53jAj/TboLGEdaY
 h3o83vDckFKRLcCwHSCins4onjpaovI3HHDj4idVpA1ivDSf4RjjxmD39XwPKF2hrYAG
 AjxieQGU//3SG8erJtTGiNekgieXyGS93K0Gt0ZAPbBJa+z85VMX+73RBfoRy5WsGm97
 7vlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767941771; x=1768546571;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/I2ae6W/g5Y8Bus0uQM50dGXtk4AiQeiFr067MHCGJI=;
 b=UvuZbljDyT+tYDXI5VF+bMcWFOiF4r40CeuRVlfB8gscNubQDmwVkxiA7oYGJ4wKik
 6skXEQVhTPefuuznV0SEbae8sesyFNKIZ/YMJErmPlPLCNFf9nGrsFkd2W28+dU9N9qI
 DzSWCfY7X8apKPgEFHsPvhzY9+EhJIPowturD4F1f3bpmT1wPKpH7wx9sWX46O1KKZpD
 p5GyQNYUYmXC27fRuhz955jOhhjed9u5ewcCSbvr8YmF6WbaUkgfM/qJssyv3ZomX96J
 toBcnP9wTOSG4qnzSdNX3SEynxQtwldkBMbKZOtUgnJ6QbXImQnZ8jI0tb1NaF8ALJoO
 ypsA==
X-Gm-Message-State: AOJu0YydpdAMGGygcgc2OOGQoECCBt4CIhG1w1XDueeNTnwbpcZPFnHp
 BtHZkZ7JV0d0LGbCkZpEnIvuCOBpQaMdtuR917Yn6FQ6Z1BeFrvsau69N5IDfA==
X-Gm-Gg: AY/fxX5QGHV/4fDMEHk9nWi79pfVy2G4NyaPMDJMxbrXLYyaSe016qujpSreqUr/469
 WR9gaYBtoTRdp6YGLtZZ0uOCcJV5HjoAEWkBK1uStrn1gAzofC4Z2Bz7Dwe8AEaUfOibSVnHdK/
 7H19YBM+brnbIN6a8m+/s2Ig6IWwHVxFu8RaLYMxJu3MGUL+0oI/UeREshCziLNhdXx22Zr4kQJ
 Wpglt9J6QWKB/1XmDF0LmphcJJ+K39SKWX3926/saDq7Gip3sjtcKW6hUtLSNVt31XZN4Tgygwv
 WVJDobWe8wSBuEvWSBUBrY1NAyXoU1myTUnM71G4Emw6K9IqrjdUlkyHPG1IcegDw29I3jEv4pH
 I8Gjo6bmR01iOQcS17Tg3o4ghZ2+z7j0X+0ZAtZkC7wK4f+ZcPSvL4G+TSZooAKrRa40azNr6vO
 jSWWx4B3BOAtEr0L/9nMvTDGIKYncdh6MhmJ5pyRUCqYjDnSEtKIF/jplDub7EH1zbnJ7gA0qOC
 nTDU/ebTO7RT3Un+N8=
X-Google-Smtp-Source: AGHT+IFHK2C77j14aymb0XkzLf40qjD1saQkYXOSlq5V2nIGtXAP1mmZXr+zGAJOQo4KowUcS1rT5A==
X-Received: by 2002:a05:6a20:3943:b0:34e:1009:4205 with SMTP id
 adf61e73a8af0-3898f8f2eafmr7533949637.27.1767941770622; 
 Thu, 08 Jan 2026 22:56:10 -0800 (PST)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c4cc02ecfaasm9953644a12.14.2026.01.08.22.56.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jan 2026 22:56:09 -0800 (PST)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Nikita Novikov <n.novikov@syntacore.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PULL 19/34] hw/intc/riscv_aplic: Factor out source_active() and
 remove duplicate checks
Date: Fri,  9 Jan 2026 16:54:44 +1000
Message-ID: <20260109065459.19987-20-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260109065459.19987-1-alistair.francis@wdc.com>
References: <20260109065459.19987-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x529.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Nikita Novikov <n.novikov@syntacore.com>

Refactor the APLIC code to consolidate repeated conditions checking
whether an interrupt source is valid, delegated, or inactive.

Signed-off-by: Nikita Novikov <n.novikov@syntacore.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Message-ID: <20251029-n-novikov-aplic_aia_ro-v1-2-39fec74c918a@syntacore.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/intc/riscv_aplic.c | 44 +++++++------------------------------------
 1 file changed, 7 insertions(+), 37 deletions(-)

diff --git a/hw/intc/riscv_aplic.c b/hw/intc/riscv_aplic.c
index cf6c4148a3..8f70043111 100644
--- a/hw/intc/riscv_aplic.c
+++ b/hw/intc/riscv_aplic.c
@@ -216,22 +216,13 @@ static inline bool riscv_aplic_source_active(RISCVAPLICState *aplic,
 static bool riscv_aplic_irq_rectified_val(RISCVAPLICState *aplic,
                                           uint32_t irq)
 {
-    uint32_t sourcecfg, sm, raw_input, irq_inverted;
+    uint32_t sm, raw_input, irq_inverted;
 
-    if (!irq || aplic->num_irqs <= irq) {
-        return false;
-    }
-
-    sourcecfg = aplic->sourcecfg[irq];
-    if (sourcecfg & APLIC_SOURCECFG_D) {
-        return false;
-    }
-
-    sm = sourcecfg & APLIC_SOURCECFG_SM_MASK;
-    if (sm == APLIC_SOURCECFG_SM_INACTIVE) {
+    if (!riscv_aplic_source_active(aplic, irq)) {
         return false;
     }
 
+    sm = aplic->sourcecfg[irq] & APLIC_SOURCECFG_SM_MASK;
     raw_input = (aplic->state[irq] & APLIC_ISTATE_INPUT) ? 1 : 0;
     irq_inverted = (sm == APLIC_SOURCECFG_SM_LEVEL_LOW ||
                     sm == APLIC_SOURCECFG_SM_EDGE_FALL) ? 1 : 0;
@@ -284,22 +275,13 @@ static void riscv_aplic_set_pending_raw(RISCVAPLICState *aplic,
 static void riscv_aplic_set_pending(RISCVAPLICState *aplic,
                                     uint32_t irq, bool pending)
 {
-    uint32_t sourcecfg, sm;
+    uint32_t sm;
 
-    if ((irq <= 0) || (aplic->num_irqs <= irq)) {
-        return;
-    }
-
-    sourcecfg = aplic->sourcecfg[irq];
-    if (sourcecfg & APLIC_SOURCECFG_D) {
-        return;
-    }
-
-    sm = sourcecfg & APLIC_SOURCECFG_SM_MASK;
-    if (sm == APLIC_SOURCECFG_SM_INACTIVE) {
+    if (!riscv_aplic_source_active(aplic, irq)) {
         return;
     }
 
+    sm = aplic->sourcecfg[irq] & APLIC_SOURCECFG_SM_MASK;
     if ((sm == APLIC_SOURCECFG_SM_LEVEL_HIGH) ||
         (sm == APLIC_SOURCECFG_SM_LEVEL_LOW)) {
         if (!aplic->msimode) {
@@ -370,19 +352,7 @@ static void riscv_aplic_set_enabled_raw(RISCVAPLICState *aplic,
 static void riscv_aplic_set_enabled(RISCVAPLICState *aplic,
                                     uint32_t irq, bool enabled)
 {
-    uint32_t sourcecfg, sm;
-
-    if ((irq <= 0) || (aplic->num_irqs <= irq)) {
-        return;
-    }
-
-    sourcecfg = aplic->sourcecfg[irq];
-    if (sourcecfg & APLIC_SOURCECFG_D) {
-        return;
-    }
-
-    sm = sourcecfg & APLIC_SOURCECFG_SM_MASK;
-    if (sm == APLIC_SOURCECFG_SM_INACTIVE) {
+    if (!riscv_aplic_source_active(aplic, irq)) {
         return;
     }
 
-- 
2.52.0


