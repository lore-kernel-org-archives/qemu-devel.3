Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2869DCAC5B9
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 14:27:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v29A9-0000pn-BN; Fri, 26 Sep 2025 10:11:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v299O-000081-HX
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 10:10:18 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v298X-0005kj-Ao
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 10:10:02 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-46e326e4e99so12248235e9.1
 for <qemu-devel@nongnu.org>; Fri, 26 Sep 2025 07:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758895758; x=1759500558; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=yZEFx/GNhVkQj1G0HF9zfJ7+hUERk6GLhLOLXCxKnsc=;
 b=WJHWg2PSElYFfo83bWTPjFEZQfEzFwvJrXUs+2QmzY+NFCgJFHvGv0MBBLSXk07Mdv
 gCM2uihJoNDTGrumlM6rW5yQ+JofxjaEOqD1yxuaEnTqNjwOM93Ag5pn3fdP6qKl26vR
 h33LaJiweQo423XLjks/uMO1UNT8G/Frvg0hnTR5oKxVyMcoDRFCALuWh2sFl8ntYY4e
 aYkKKy8ApsIVsiIXqViQZ31IEfbQANhjOkN96GW29ksA9SmZ3EzkiwrWmQvZRTKHVPVC
 eZufcRE80tU0Zh2KIoqX8t0hGmsriv96pt406TtXXb+uoYdHhXI/EhDTYFz9O/etswZ1
 q7Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758895758; x=1759500558;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yZEFx/GNhVkQj1G0HF9zfJ7+hUERk6GLhLOLXCxKnsc=;
 b=pmBpjPG7/MKt0zJ+koCHtmjzxSRd+DlAulSNxb+JwGD3EZOWU3ipa7jJARuSjwrzIP
 DsxuLgDeqqYnwEPLJs0uLifkyaW1YIlvIqB+rWmp4y85YzfuWrtwubNTxGDOJ3Wo+MGD
 cU2s8LcUTQYmtLh0tCcCXiRXQt7r1exQVzu/qfrVOCZm5oWIrdGZuwXHb+CQh62eyxLj
 VO6YEqBcuuPG5IHRihT9M+5OQQMC8X66W574mpWM4+7xO7jgtoLGL4/MQcTgP58X4XFJ
 MfXZM0OtgdzseGLVnjeIEu+9W5x6mf1KOzaSBTidhlGCfPgbj+jTgJYt23J1WDPh0UzB
 X+JA==
X-Gm-Message-State: AOJu0YzNzzqon/itgxp9BoLl8/7qCq9Uk2eeVTpgmce2Va0bem2AvN4U
 b0rtaqf7adEM7mPfBAY1seWRnogdJBVjrSy8tG8OHqXo9pPfC1ZExJDOmsBf4tk2IF4pJyD7Z1y
 O3c6Y
X-Gm-Gg: ASbGnctccdjy/AndbzhbT/SsJTi0EddMB656SlBO83FICbS50v8axW59VigsJmaOxiI
 1oMv65R0E8PTj81Xfs++8S3i+BKoXW4uLJsjpf9A+sx4ywFhaIdoPzziKJvhkBUdfYbYinauYe+
 mhoYUTkP3joo4kEYMX0OjYJMsuYfldPbx9rqeRK172oWnFTDMg9Zcw0fNx9RkL4ViU0QTI/l/vU
 mWp1DpODXcHg3O8Fy30o/HEYff3ZRGMNo9HHcbE/MkA7ra5ey5etDx/9DHfwAxQaoqJXe+4RaiJ
 8rqBhLJgyUv+DSaeRTL9xs1+ijwvcJ5fPCa1bwy9bIlvsx3m6Uvfai4YnF8k6W65OyW06EOrqeA
 aESPr4Rk9z2/L69UygwLiI0uJYj2JTthFT/DXg04=
X-Google-Smtp-Source: AGHT+IG6mx6ouGnhLaaeYs0SfVVodUX6c9+5lmbuhWVgngsjOYxAEhrZuedhHa4ZWU6nHYK9sZWJUw==
X-Received: by 2002:a05:6000:24c6:b0:3f4:ad3f:7c35 with SMTP id
 ffacd0b85a97d-40f69cd780fmr5764685f8f.27.1758895758130; 
 Fri, 26 Sep 2025 07:09:18 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-410f2007372sm6338315f8f.16.2025.09.26.07.09.17
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Sep 2025 07:09:17 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 31/44] target/arm: Move writeback of CP_ANY fields
Date: Fri, 26 Sep 2025 15:08:31 +0100
Message-ID: <20250926140844.1493020-32-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250926140844.1493020-1-peter.maydell@linaro.org>
References: <20250926140844.1493020-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x331.google.com
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

Move the writeback of cp, crm, opc1, opc2 to define_one_arm_cp_reg,
which means we don't have to pass all those parameters down
to subroutines.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 52 ++++++++++++++++++++++-----------------------
 1 file changed, 26 insertions(+), 26 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 274b7b5808e..4063c8a0b6f 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -7390,7 +7390,6 @@ static ARMCPRegInfo *alloc_cpreg(const ARMCPRegInfo *in, const char *suffix)
  */
 static void add_cpreg_to_hashtable(ARMCPU *cpu, ARMCPRegInfo *r,
                                    CPState state, CPSecureState secstate,
-                                   int cp, int crm, int opc1, int opc2,
                                    uint32_t key)
 {
     CPUARMState *env = &cpu->env;
@@ -7457,12 +7456,8 @@ static void add_cpreg_to_hashtable(ARMCPU *cpu, ARMCPRegInfo *r,
 
     /*
      * Update fields to match the instantiation, overwiting wildcards
-     * such as CP_ANY, ARM_CP_STATE_BOTH, or ARM_CP_SECSTATE_BOTH.
+     * such as ARM_CP_STATE_BOTH or ARM_CP_SECSTATE_BOTH.
      */
-    r->cp = cp;
-    r->crm = crm;
-    r->opc1 = opc1;
-    r->opc2 = opc2;
     r->state = state;
     r->secure = secstate;
 
@@ -7478,8 +7473,7 @@ static void add_cpreg_to_hashtable(ARMCPU *cpu, ARMCPRegInfo *r,
     g_hash_table_insert(cpu->cp_regs, (gpointer)(uintptr_t)key, r);
 }
 
-static void add_cpreg_to_hashtable_aa32(ARMCPU *cpu, ARMCPRegInfo *r,
-                                        int cp, int crm, int opc1, int opc2)
+static void add_cpreg_to_hashtable_aa32(ARMCPU *cpu, ARMCPRegInfo *r)
 {
     /*
      * Under AArch32 CP registers can be common
@@ -7487,7 +7481,8 @@ static void add_cpreg_to_hashtable_aa32(ARMCPU *cpu, ARMCPRegInfo *r,
      */
     ARMCPRegInfo *r_s;
     bool is64 = r->type & ARM_CP_64BIT;
-    uint32_t key = ENCODE_CP_REG(cp, is64, 0, r->crn, crm, opc1, opc2);
+    uint32_t key = ENCODE_CP_REG(r->cp, is64, 0, r->crn,
+                                 r->crm, r->opc1, r->opc2);
 
     assert(!(r->type & ARM_CP_ADD_TLBI_NXS)); /* aa64 only */
 
@@ -7496,27 +7491,26 @@ static void add_cpreg_to_hashtable_aa32(ARMCPU *cpu, ARMCPRegInfo *r,
         key |= CP_REG_AA32_NS_MASK;
         /* fall through */
     case ARM_CP_SECSTATE_S:
-        add_cpreg_to_hashtable(cpu, r, ARM_CP_STATE_AA32, r->secure,
-                               cp, crm, opc1, opc2, key);
+        add_cpreg_to_hashtable(cpu, r, ARM_CP_STATE_AA32, r->secure, key);
         break;
     case ARM_CP_SECSTATE_BOTH:
         r_s = alloc_cpreg(r, "_S");
-        add_cpreg_to_hashtable(cpu, r_s, ARM_CP_STATE_AA32, ARM_CP_SECSTATE_S,
-                               cp, crm, opc1, opc2, key);
+        add_cpreg_to_hashtable(cpu, r_s, ARM_CP_STATE_AA32,
+                               ARM_CP_SECSTATE_S, key);
 
         key |= CP_REG_AA32_NS_MASK;
-        add_cpreg_to_hashtable(cpu, r, ARM_CP_STATE_AA32, ARM_CP_SECSTATE_NS,
-                               cp, crm, opc1, opc2, key);
+        add_cpreg_to_hashtable(cpu, r, ARM_CP_STATE_AA32,
+                               ARM_CP_SECSTATE_NS, key);
         break;
     default:
         g_assert_not_reached();
     }
 }
 
-static void add_cpreg_to_hashtable_aa64(ARMCPU *cpu, ARMCPRegInfo *r,
-                                        int crm, int opc1, int opc2)
+static void add_cpreg_to_hashtable_aa64(ARMCPU *cpu, ARMCPRegInfo *r)
 {
-    uint32_t key = ENCODE_AA64_CP_REG(r->opc0, opc1, r->crn, crm, opc2);
+    uint32_t key = ENCODE_AA64_CP_REG(r->opc0, r->opc1,
+                                      r->crn, r->crm, r->opc2);
 
     if ((r->type & ARM_CP_ADD_TLBI_NXS) &&
         cpu_isar_feature(aa64_xs, cpu)) {
@@ -7542,12 +7536,11 @@ static void add_cpreg_to_hashtable_aa64(ARMCPU *cpu, ARMCPRegInfo *r,
         }
 
         add_cpreg_to_hashtable(cpu, nxs_ri, ARM_CP_STATE_AA64,
-                               ARM_CP_SECSTATE_NS, 0, crm, opc1, opc2,
-                               nxs_key);
+                               ARM_CP_SECSTATE_NS, nxs_key);
     }
 
-    add_cpreg_to_hashtable(cpu, r, ARM_CP_STATE_AA64, ARM_CP_SECSTATE_NS,
-                           0, crm, opc1, opc2, key);
+    add_cpreg_to_hashtable(cpu, r, ARM_CP_STATE_AA64,
+                           ARM_CP_SECSTATE_NS, key);
 }
 
 void define_one_arm_cp_reg(ARMCPU *cpu, const ARMCPRegInfo *r)
@@ -7767,17 +7760,24 @@ void define_one_arm_cp_reg(ARMCPU *cpu, const ARMCPRegInfo *r)
                     r2->type |= ARM_CP_ALIAS | ARM_CP_NO_GDB;
                 }
 
+                /* Overwrite CP_ANY with the instantiation. */
+                r2->crm = crm;
+                r2->opc1 = opc1;
+                r2->opc2 = opc2;
+
                 switch (r->state) {
                 case ARM_CP_STATE_AA32:
-                    add_cpreg_to_hashtable_aa32(cpu, r2, cp, crm, opc1, opc2);
+                    add_cpreg_to_hashtable_aa32(cpu, r2);
                     break;
                 case ARM_CP_STATE_AA64:
-                    add_cpreg_to_hashtable_aa64(cpu, r2, crm, opc1, opc2);
+                    add_cpreg_to_hashtable_aa64(cpu, r2);
                     break;
                 case ARM_CP_STATE_BOTH:
                     r3 = alloc_cpreg(r2, NULL);
-                    add_cpreg_to_hashtable_aa32(cpu, r2, cp, crm, opc1, opc2);
-                    add_cpreg_to_hashtable_aa64(cpu, r3, crm, opc1, opc2);
+                    r2->cp = cp;
+                    add_cpreg_to_hashtable_aa32(cpu, r2);
+                    r3->cp = 0;
+                    add_cpreg_to_hashtable_aa64(cpu, r3);
                     break;
                 default:
                     g_assert_not_reached();
-- 
2.43.0


