Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B479CCAC5BC
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 14:14:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v299r-0000XZ-UB; Fri, 26 Sep 2025 10:10:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v2996-0008Kp-5B
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 10:10:00 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v298V-0005jG-Hq
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 10:09:54 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3f99ac9acc4so1875021f8f.3
 for <qemu-devel@nongnu.org>; Fri, 26 Sep 2025 07:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758895753; x=1759500553; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=0qm1lRq8C6le9ftLJGpNis68tJFVXuU6K3wCRCZ8GAo=;
 b=pOaALlX3AKtewy3Ee98ZUsWYZNbcfpj8Vu7NB56QFMlvlLgkj9n+QkDT/V1dGl9tnl
 Om1yHBTdPn5Ll2/XKn9pfMCqKSn1JnzjPyAfeb1RqkS1lF1fIqgzs2cP0zGge1oGzsOF
 xNKI3RtqSA+0OluzfQUKxC8d3oC3u4/hvKZY6yGDmOIhkqHxJYHQUcRwq3lfqq8RrnwG
 Kh3GiF9n7y8EqBNxl73PN6VsTQqQT2i80Hrtz/2jJLq8cqC6bii8A/zUbI4P0IA99qst
 WCbQIq4dT0cpW69z43mWQQj4356+GUgUHI/kIEaPyoKKsqswHKzRQwyIBnJ9UNACbbuI
 XKkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758895753; x=1759500553;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0qm1lRq8C6le9ftLJGpNis68tJFVXuU6K3wCRCZ8GAo=;
 b=A/yYx0khWOxBnB+hoSyTQ+Q7+fky02GwxfMnmEWdH4w/WmUCFHU01KSBXkq9TshpNM
 ze6vNc0x4RUVB5JocrNfDCxwvL4qs6LI4Af1n+ok/KHdjMrvVNdXLJmk3OHgtZGHZMUU
 TO0mL6Kb0+9U71vcmeIy6fbqWeYniRy3k+PMRWbadVQBEMgectvz8K8saLxXbYjH0pcO
 ETYudq2VmKGnaE8H7vI84Tt/Vt03NnBZxmKyHw/4V4Gr48aMqUnm8EJs7h1XesEJcMr0
 eexXNrR/CKwNW/bJWGCgRuKp4tMakB+6hTOqvaiF69HPx7FWwT2x4Fsdjp23UTuAhbqZ
 DHqg==
X-Gm-Message-State: AOJu0YyE/DbbCQJio0XpOLsyzqMIJgNbcnLXebodP2Y/I7ut4WXXMdCK
 dYI/0VVuuqh6SiUgsh/8cNSre19mZJPO7uDLZDMLvzko+rzcLYHYle4KpOmmqgzUI8bWuZbr/Yx
 bBMOe
X-Gm-Gg: ASbGncsktSG9daJtA2sf/hG/2CMgrgW3JXTV6yXrQZyu8aKRTZg2GNBnLGMwVd9RSh3
 9T/eDPCplGD1NPrpj6gqClhCYteAqX12ZTAsZ43qnrKnPj6Ya6qeyA0rk8xIGGH5gAITql7UlOb
 HJaielcMyyiJ1xFOm8V0cpAtZPhGcGMEPBk6/yu6MdpElFQd3XoNevvf2XqPLUitaD6+TDGoWe2
 i5reVH6+n+42VDX77evzeu/1sKXalpZnUC6+AqxmTW9NhjcjUcDbvI+0fV2qdA38g5v4peYnZfu
 M6M67oN9Jk8474daj0jLEXI6soHnhLclvbU1bNeELw6pfV7ZE57OW+NNNbvpVYRWX01oa/nWBkE
 773Lc2RYslPWibEWbi3sMUp+A7CUinJ9q6DuZGtQ=
X-Google-Smtp-Source: AGHT+IFOWZoLmMkZ/PDS+xbf471Dgo2Gcg2rMKFF7zXkDndm/o2H5h28qLoY7lh/wW+wiSTOBC2MyQ==
X-Received: by 2002:a05:6000:1862:b0:3e1:2d70:673e with SMTP id
 ffacd0b85a97d-40e4886e028mr6571662f8f.37.1758895753403; 
 Fri, 26 Sep 2025 07:09:13 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-410f2007372sm6338315f8f.16.2025.09.26.07.09.12
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Sep 2025 07:09:12 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 26/44] target/arm: Add key parameter to add_cpreg_to_hashtable
Date: Fri, 26 Sep 2025 15:08:26 +0100
Message-ID: <20250926140844.1493020-27-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250926140844.1493020-1-peter.maydell@linaro.org>
References: <20250926140844.1493020-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Richard Henderson <richard.henderson@linaro.org>

Hoist the computation of key into the caller, where
state is a known constant.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
[PMM: added comment about CRN key field increment]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 40 ++++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index ade16138e75..8a8fa8c40e9 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -7369,26 +7369,13 @@ void register_cp_regs_for_features(ARMCPU *cpu)
 static void add_cpreg_to_hashtable(ARMCPU *cpu, const ARMCPRegInfo *r,
                                    CPState state, CPSecureState secstate,
                                    int cp, int crm, int opc1, int opc2,
-                                   const char *name)
+                                   const char *name, uint32_t key)
 {
     CPUARMState *env = &cpu->env;
-    uint32_t key;
     ARMCPRegInfo *r2;
-    bool is64 = r->type & ARM_CP_64BIT;
     bool ns = secstate & ARM_CP_SECSTATE_NS;
     size_t name_len;
 
-    switch (state) {
-    case ARM_CP_STATE_AA32:
-        key = ENCODE_CP_REG(cp, is64, ns, r->crn, crm, opc1, opc2);
-        break;
-    case ARM_CP_STATE_AA64:
-        key = ENCODE_AA64_CP_REG(r->opc0, opc1, r->crn, crm, opc2);
-        break;
-    default:
-        g_assert_not_reached();
-    }
-
     /* Overriding of an existing definition must be explicitly requested. */
     if (!(r->type & ARM_CP_OVERRIDE)) {
         const ARMCPRegInfo *oldreg = get_arm_cp_reginfo(cpu->cp_regs, key);
@@ -7493,22 +7480,28 @@ static void add_cpreg_to_hashtable_aa32(ARMCPU *cpu, const ARMCPRegInfo *r,
      * (same for secure and non-secure world) or banked.
      */
     char *name;
+    bool is64 = r->type & ARM_CP_64BIT;
+    uint32_t key = ENCODE_CP_REG(cp, is64, 0, r->crn, crm, opc1, opc2);
 
     assert(!(r->type & ARM_CP_ADD_TLBI_NXS)); /* aa64 only */
 
     switch (r->secure) {
-    case ARM_CP_SECSTATE_S:
     case ARM_CP_SECSTATE_NS:
+        key |= CP_REG_AA32_NS_MASK;
+        /* fall through */
+    case ARM_CP_SECSTATE_S:
         add_cpreg_to_hashtable(cpu, r, ARM_CP_STATE_AA32, r->secure,
-                               cp, crm, opc1, opc2, r->name);
+                               cp, crm, opc1, opc2, r->name, key);
         break;
     case ARM_CP_SECSTATE_BOTH:
         name = g_strdup_printf("%s_S", r->name);
         add_cpreg_to_hashtable(cpu, r, ARM_CP_STATE_AA32, ARM_CP_SECSTATE_S,
-                               cp, crm, opc1, opc2, name);
+                               cp, crm, opc1, opc2, name, key);
         g_free(name);
+
+        key |= CP_REG_AA32_NS_MASK;
         add_cpreg_to_hashtable(cpu, r, ARM_CP_STATE_AA32, ARM_CP_SECSTATE_NS,
-                               cp, crm, opc1, opc2, r->name);
+                               cp, crm, opc1, opc2, r->name, key);
         break;
     default:
         g_assert_not_reached();
@@ -7518,6 +7511,8 @@ static void add_cpreg_to_hashtable_aa32(ARMCPU *cpu, const ARMCPRegInfo *r,
 static void add_cpreg_to_hashtable_aa64(ARMCPU *cpu, const ARMCPRegInfo *r,
                                         int crm, int opc1, int opc2)
 {
+    uint32_t key = ENCODE_AA64_CP_REG(r->opc0, opc1, r->crn, crm, opc2);
+
     if ((r->type & ARM_CP_ADD_TLBI_NXS) &&
         cpu_isar_feature(aa64_xs, cpu)) {
         /*
@@ -7532,18 +7527,23 @@ static void add_cpreg_to_hashtable_aa64(ARMCPU *cpu, const ARMCPRegInfo *r,
          */
         ARMCPRegInfo nxs_ri = *r;
         g_autofree char *name = g_strdup_printf("%sNXS", r->name);
+        uint32_t nxs_key;
 
         assert(nxs_ri.crn < 0xf);
         nxs_ri.crn++;
+        /* Also increment the CRN field inside the key value */
+        nxs_key = key + (1 << CP_REG_ARM64_SYSREG_CRN_SHIFT);
         if (nxs_ri.fgt) {
             nxs_ri.fgt |= R_FGT_NXS_MASK;
         }
+
         add_cpreg_to_hashtable(cpu, &nxs_ri, ARM_CP_STATE_AA64,
-                               ARM_CP_SECSTATE_NS, 0, crm, opc1, opc2, name);
+                               ARM_CP_SECSTATE_NS, 0, crm, opc1, opc2,
+                               name, nxs_key);
     }
 
     add_cpreg_to_hashtable(cpu, r, ARM_CP_STATE_AA64, ARM_CP_SECSTATE_NS,
-                           0, crm, opc1, opc2, r->name);
+                           0, crm, opc1, opc2, r->name, key);
 }
 
 void define_one_arm_cp_reg(ARMCPU *cpu, const ARMCPRegInfo *r)
-- 
2.43.0


