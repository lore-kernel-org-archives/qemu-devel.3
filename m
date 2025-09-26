Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19414CAC5B8
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 14:31:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v29A7-0000p0-91; Fri, 26 Sep 2025 10:11:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v299N-00006i-A1
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 10:10:17 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v298Y-0005ki-Mf
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 10:10:02 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3ece0e4c5faso2050774f8f.1
 for <qemu-devel@nongnu.org>; Fri, 26 Sep 2025 07:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758895757; x=1759500557; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=+TKuT+/hIikpcraTr+q4FAKa4j7Yp774WfscMXmqb7w=;
 b=cPxEttfe9Yg0/EX3wT1Iz7Ho3y6YJOz5dyCx7ym0OCr+HF3qpCoXNde3sEf0txu4iS
 QxQmEkvX76AYpLk4ydMMvuGAND/7v2pQDs52jfe+JcbjdkQbXmS2O5PuT+vadZPKwnhX
 QK4AslXG0VL18MPF5t1OtANDgDNF8nEeUjPZNYMZqy9dhdx7GABXWTMNQwKlp/HEg65+
 y7bI5h3aD52dgM9ehHXno0FGk0sMI2bXwuZGfhmUmtd9DkoyRf7YyFana/jQVnMVZO5V
 jBFipTLyq8WDaYtwoLHavV+numUTt3RkVXcAUAXbaq7j9p+uRJ+/Up37bBiDGWUqPLIE
 nfcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758895757; x=1759500557;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+TKuT+/hIikpcraTr+q4FAKa4j7Yp774WfscMXmqb7w=;
 b=K2aDUEsihvJ07xOUuYEQE8ktG27tMTkK0OHrZGf59M8KbMfGmOlEaPqF08HA4vP6Uo
 +cQwgU9Q7NXUobPDbvtPSzUv4QEmIIJC+LKBR/ahCL1sr8pVPp7aBkOz6/sK9xByT63F
 xgY0h85PAvFdBMYms1wYzGVmnUxVV/s/dHkVTeMX+OJRdWmVry++zwrdDXSMmLkL5reR
 fqKdcvcc0XG01nkT5SKVo5+5A8mJs6rH0gtzRo7RwnC0/s3KVNny4V46AGmoMl0pUMUA
 BzCdA5Y1VlJW2EVjzbMfmDlTblBDayzyYWXhlDIvhA/elHn1wM/eV1+Ep9+MK7P0XEYj
 CPyQ==
X-Gm-Message-State: AOJu0Ywe2yLyZhsdhGVy/wNKY5DuCg6n250QYkiFve9U3RdkSHx7t4sZ
 Eky8+Zn1siewoAPWKi4p1g1R6Ykjugf3dLlJpp8HsZZ506hxklnNyBOFwe1SpCtgCuvkUR0N5HX
 m9CGm
X-Gm-Gg: ASbGncukRs4YKSys8L0mLH9EWUnDd2ukg/442Bk5Bja7JfLDGkX+XGlRLo+0HMITdnz
 DJqQLc59yjYFiRMIHOZiCfLjlCbQBsJYMQBiyho4OxojqsFhBs+u6mvuviDjGlOouS/PumsIS3N
 PFZTI6F3ykelKvL6/eauxOQip/NuzgBmvIX+sPIlzSOdg9oarF+SeA4g44Ut05R621ifCekF1hL
 NBGsU85e+debLa0xAB1weFpwR1VvoZUNZo2sWixWTYV15JgpTpGncXLMjEtu4ncyTg45JTrpvtk
 zqGGeukHqFfGtGn5bq1eL+8872LWC+c9TojbjfxxW363t4h6ffoOXvj92hH9OZnhCU8uC1qOAfB
 f7BmmsRzTr6+82qRaHmD8TeymRNHdgsG6Ndyvva2ddDLRxQ6j+A==
X-Google-Smtp-Source: AGHT+IG2prdz1XZ9eGTDiIzjqcNPqZtzxR1a6lghZb8RmLUFF/BaQgC0oKbzs7MLxKQs4HWuS8Vpcg==
X-Received: by 2002:a05:6000:2dc5:b0:3e9:a1cb:ea93 with SMTP id
 ffacd0b85a97d-40e43b08e26mr6436522f8f.21.1758895757124; 
 Fri, 26 Sep 2025 07:09:17 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-410f2007372sm6338315f8f.16.2025.09.26.07.09.16
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Sep 2025 07:09:16 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 30/44] target/arm: Move alias setting for wildcards
Date: Fri, 26 Sep 2025 15:08:30 +0100
Message-ID: <20250926140844.1493020-31-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250926140844.1493020-1-peter.maydell@linaro.org>
References: <20250926140844.1493020-1-peter.maydell@linaro.org>
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

From: Richard Henderson <richard.henderson@linaro.org>

Move this test from add_cpreg_to_hashtable to
define_one_arm_cp_reg_with_opaque, where we can also
simplify it based on the loop variables.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
[PMM: adjusted placement of comma in a comment]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index a199320f140..274b7b5808e 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -7448,20 +7448,12 @@ static void add_cpreg_to_hashtable(ARMCPU *cpu, ARMCPRegInfo *r,
     }
 
     /*
-     * By convention, for wildcarded registers only the first
-     * entry is used for migration; the others are marked as
-     * ALIAS so we don't try to transfer the register
-     * multiple times. Special registers (ie NOP/WFI) are
-     * never migratable and not even raw-accessible.
+     * Special registers (ie NOP/WFI) are never migratable and
+     * are not even raw-accessible.
      */
     if (r->type & ARM_CP_SPECIAL_MASK) {
         r->type |= ARM_CP_NO_RAW;
     }
-    if (((r->crm == CP_ANY) && crm != 0) ||
-        ((r->opc1 == CP_ANY) && opc1 != 0) ||
-        ((r->opc2 == CP_ANY) && opc2 != 0)) {
-        r->type |= ARM_CP_ALIAS | ARM_CP_NO_GDB;
-    }
 
     /*
      * Update fields to match the instantiation, overwiting wildcards
@@ -7765,6 +7757,16 @@ void define_one_arm_cp_reg(ARMCPU *cpu, const ARMCPRegInfo *r)
                 ARMCPRegInfo *r2 = alloc_cpreg(r, NULL);
                 ARMCPRegInfo *r3;
 
+                /*
+                 * By convention, for wildcarded registers only the first
+                 * entry is used for migration; the others are marked as
+                 * ALIAS so we don't try to transfer the register
+                 * multiple times.
+                 */
+                if (crm != crmmin || opc1 != opc1min || opc2 != opc2min) {
+                    r2->type |= ARM_CP_ALIAS | ARM_CP_NO_GDB;
+                }
+
                 switch (r->state) {
                 case ARM_CP_STATE_AA32:
                     add_cpreg_to_hashtable_aa32(cpu, r2, cp, crm, opc1, opc2);
-- 
2.43.0


