Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 282B6D232E8
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 06:58:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ve6QI-00055q-IJ; Fri, 09 Jan 2026 01:56:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1ve6Px-0004HA-4t
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 01:56:18 -0500
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1ve6Pq-0002sb-66
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 01:56:11 -0500
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-c4464dfeae8so2638632a12.3
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 22:56:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767941767; x=1768546567; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2xIQ2oDkyqqP6zHisgTSSzc9Apfdg/ajRkvqrRxBrWc=;
 b=hdlHuA3EJMvSMbLzxzGvNgBBms6IKKHQ6cWztvH2+Pj7BOd9lynP+LbxLBEw3VGZt6
 K4FRPOl/C8gUpkPpT/PIxaIVdaHIyV4/bgWhU9H/OkR+IjKt1cCiPDh334dlPn87UXKc
 rcKZFWSQZY47HMzRt/c7k1y2UFAoTCGphbYsBatqQ66PGPCoFJA7nnimG8kCdwnKYw9s
 08bPQNN7T7Wf+H/OqqHOLuwS+cVyIuvE+FQiUKFdb8XaShBwcoNCiZ2rjhZCprcrf78f
 oSAU/nLhJdOsop5NL4Z9IBW/vVT1Nd51OevP6oLgXqBZWsFOE/ZhTdTi7Gim3Y9UNwZd
 n0+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767941767; x=1768546567;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2xIQ2oDkyqqP6zHisgTSSzc9Apfdg/ajRkvqrRxBrWc=;
 b=e+KJFaIDgySg0uCgHq4tpEYKYTczioWzcEjLP5K4HXSJKppTeITaPuTJNpDRmUuPPa
 RUsp6NvFXskbMSPf0Qfp/jXz/DfdC6z+oT5dFFFvTIQ2Yjrj0T0oDSYfgsmJcw9jjvXN
 1OImE6yXxjUTsg3k1HNTM3KOP7vCRo8iMHWENJezJuxbpJuUVyhoN4l+Y516dEGFdIpj
 ts4V7USWcbR/3KgGBC8Kq3GHhE6yiPCWpmKjhnFZ0tCNUALfoQ2OOosat5KQcDfihyQe
 PTnJu0z+voXjwXQnseoiAhoYAKEcY10RSPvYlXehPzUbmAWYNysu32OhOIJ+DGUpvTxx
 DiKA==
X-Gm-Message-State: AOJu0YyxQN5YIQuLb9E7PjUlqGrP2rwYojZ5dSEyMmeTenSOr/1IjCc3
 Cvjd7tk78OnnNaeUIxlFqe/jAQh9ZBYEqVkgIwWJphPGt2kgv+xOvN6FcbsxuQ==
X-Gm-Gg: AY/fxX4tbHSSuJ2177tTfMs6iYLXuXQLIAWGhlMl2xkF76+wU2xn1FtL7b8tSdgx4jx
 ugJihP3b+AMZ29UnRl/DNOhzoyeuu0mbrhNRDmGV9h2L4+OlFf5pKvbHTukgNyC7jm8etj30lxM
 htVzcPeva5s3sPiedJnLf5qLzx3nv/KJJ1VvYGDFF/GeKP/7vyFjLBi4KUruNNLBQNRyZdbfvY1
 AI4sD/2zj1TO3qYyuH+I38NefLNsC0Kxc9NY+mBwOd0GiOc9o/ukXmsFtvz4wZGiY9VwGv75/q0
 +UMLuMqG53ESRdAKws8Ydw2dl/Sakj/nu9pmPNXGrl5i6b8xclDsFEJal2E2XdhQJJLIVzkAhj4
 934QhTIBPUvq9mZwS6mDsbXUzD8xPYczrHzo9W8/cCSwfVH3sf6pO5UDcycOJImWvGSJQWooE6Y
 eOs9jWygoONcMFisYpHUp53PyC3BuEFIznTeuZ+HqAWbr7pOSTG04JdO7qqY6iHqbDbV+5U7lTN
 a0PCwqmnxxEiwl114w=
X-Google-Smtp-Source: AGHT+IH5HbDeMSW/Xr0Ksvwl8G+VtH8lTB7m/yGLNAihgfFbT4yzfnyyhuFZ/ZXjMVJEyp0BsNOhYg==
X-Received: by 2002:a05:6a20:3d90:b0:366:14ac:e1fc with SMTP id
 adf61e73a8af0-3898f9f0241mr7889569637.78.1767941767406; 
 Thu, 08 Jan 2026 22:56:07 -0800 (PST)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c4cc02ecfaasm9953644a12.14.2026.01.08.22.56.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jan 2026 22:56:06 -0800 (PST)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Nikita Novikov <n.novikov@syntacore.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PULL 18/34] hw/intc/riscv_aplic: Expand inactive source handling for
 AIA target[i]
Date: Fri,  9 Jan 2026 16:54:43 +1000
Message-ID: <20260109065459.19987-19-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260109065459.19987-1-alistair.francis@wdc.com>
References: <20260109065459.19987-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x52a.google.com
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

According to the RISC-V AIA v1.0, section 4.5.2 ("Source configurations"),
register target[i] shall be read-only zero when interrupt source i is inactive
in this domain. A source is inactive if it is delegated to a child domain or
its source mode is INACTIVE.

The previous implementation only checked SM == INACTIVE. This patch adds
full compliance:
- Return zero on read if D == 1 or SM == INACTIVE
- Ignore writes in both cases

Fixes: b6f1244678 ("intc/riscv_aplic: Fix target register read when source is inactive")
Signed-off-by: Nikita Novikov <n.novikov@syntacore.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Message-ID: <20251029-n-novikov-aplic_aia_ro-v1-1-39fec74c918a@syntacore.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/intc/riscv_aplic.c | 28 +++++++++++++++++++++++++---
 1 file changed, 25 insertions(+), 3 deletions(-)

diff --git a/hw/intc/riscv_aplic.c b/hw/intc/riscv_aplic.c
index 92ff0ecaa7..cf6c4148a3 100644
--- a/hw/intc/riscv_aplic.c
+++ b/hw/intc/riscv_aplic.c
@@ -193,6 +193,26 @@ void riscv_aplic_set_kvm_msicfgaddr(RISCVAPLICState *aplic, hwaddr addr)
 #endif
 }
 
+/*
+ * APLIC target[i] must be read-only zero if the source i is inactive
+ * in this domain (delegated or SM == INACTIVE)
+ */
+static inline bool riscv_aplic_source_active(RISCVAPLICState *aplic,
+                                             uint32_t irq)
+{
+    uint32_t sc, sm;
+
+    if ((irq == 0) || (aplic->num_irqs <= irq)) {
+        return false;
+    }
+    sc = aplic->sourcecfg[irq];
+    if (sc & APLIC_SOURCECFG_D) {
+        return false;
+    }
+    sm = sc & APLIC_SOURCECFG_SM_MASK;
+    return sm != APLIC_SOURCECFG_SM_INACTIVE;
+}
+
 static bool riscv_aplic_irq_rectified_val(RISCVAPLICState *aplic,
                                           uint32_t irq)
 {
@@ -635,7 +655,7 @@ static void riscv_aplic_request(void *opaque, int irq, int level)
 
 static uint64_t riscv_aplic_read(void *opaque, hwaddr addr, unsigned size)
 {
-    uint32_t irq, word, idc, sm;
+    uint32_t irq, word, idc;
     RISCVAPLICState *aplic = opaque;
 
     /* Reads must be 4 byte words */
@@ -703,8 +723,7 @@ static uint64_t riscv_aplic_read(void *opaque, hwaddr addr, unsigned size)
     } else if ((APLIC_TARGET_BASE <= addr) &&
             (addr < (APLIC_TARGET_BASE + (aplic->num_irqs - 1) * 4))) {
         irq = ((addr - APLIC_TARGET_BASE) >> 2) + 1;
-        sm = aplic->sourcecfg[irq] & APLIC_SOURCECFG_SM_MASK;
-        if (sm == APLIC_SOURCECFG_SM_INACTIVE) {
+        if (!riscv_aplic_source_active(aplic, irq)) {
             return 0;
         }
         return aplic->target[irq];
@@ -841,6 +860,9 @@ static void riscv_aplic_write(void *opaque, hwaddr addr, uint64_t value,
     } else if ((APLIC_TARGET_BASE <= addr) &&
             (addr < (APLIC_TARGET_BASE + (aplic->num_irqs - 1) * 4))) {
         irq = ((addr - APLIC_TARGET_BASE) >> 2) + 1;
+        if (!riscv_aplic_source_active(aplic, irq)) {
+            return;
+        }
         if (aplic->msimode) {
             aplic->target[irq] = value;
         } else {
-- 
2.52.0


