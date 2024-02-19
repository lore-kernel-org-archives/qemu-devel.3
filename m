Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95798C5475B
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Feb 2024 08:35:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rbz2V-0008Vy-Af; Mon, 19 Feb 2024 03:30:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rbz2Q-0008R8-2k; Mon, 19 Feb 2024 03:30:10 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rbz2N-00025s-Et; Mon, 19 Feb 2024 03:30:09 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1d94323d547so25654315ad.3; 
 Mon, 19 Feb 2024 00:30:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708331404; x=1708936204; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FP9KRL+SerwXW0dsmmqgLA3tloMgPQHHxabviXvEun8=;
 b=B6DhGJU3S7xXQqRc+y0H2WygYUkSnfVoYPp3vk2p9icYgECOVsvyBS8IYTMGoMOlQs
 fHGYUf/vdyUqsO+Ay3sTbzN1nj66dvEv9THi1fBiBdpHb/0etnp5xA8QhBMlM1xILdTD
 aGukDMBbL8XlbP0Er7JmJMqxBQp11lK7BKwEBw5QFitqcwH+hubRz5Z19WkrZIs/pe4J
 F0a25QV37Qs7vaGpvzecfmt+b1S9RCnUS9KEFMMrP/CJaZIOhyuPHKrEmR7LTNxtKX+U
 yaCJ+O+G5AfaqTbFBr/EGj9dxwna92TwX/yjlN5nHse8afuFTBSTLGYNIW1jmPbecUE8
 MQOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708331404; x=1708936204;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FP9KRL+SerwXW0dsmmqgLA3tloMgPQHHxabviXvEun8=;
 b=MESSPrjI8E3CjzGO8kT+68FHqEjT1bJyvqx/U1cUW5ZYU7kbNzPMy5p78hnd+zPQxC
 oewsQomLwe7RT4uUnFZBL0V5t3O+o0PQCslcuKINzULzuu+6TtcpEJJkm2ktcjrKT6iW
 HA7yrKnxU2vyWwsg+CtXkNYJ+5Dd4nU51OsPhIKBgwzjOaJ7wAVISxjrkEWjKmLY+oCd
 cOPb0tEWO2PmEavdEA4Ij4VrsVtaa4EQ2EGg/RHvanJB+V8XR0am2UkWU5wJlt77QrcU
 l1jqToTwWTw5Uu3ysMoKno/IHRw6nEqkI3wPQ3EOwM0X+weIEYksO3uB3lE8/QzUy03I
 jRaA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW0uFl8kdsXcvGAflKsfjPSzGUIH+dzGlNjsvykDo1Gpf2q3KSm+yq6L+UAAQqLa+imsMc2WDORL+mEWk77LR44wPfWwtTOxu7hOgZD+oAJUTF9e8PY7Eh7JySY
X-Gm-Message-State: AOJu0YwnhT+//yja1Kt6te1KsClrkzULg1Fg4O4uVD8PUjESwkGJDg/R
 4V0kAYTU4AiovL57hZvfUwVsu3qPgk6ZL3uFlQqRynXwiiE8kPzk9RfvZGWi
X-Google-Smtp-Source: AGHT+IEeAb6uvwX05f0at7obTEnn9K5tMlSdDRbSlKuZUU3RQVMdwiwc6Fa7v6i4IJ7oTBqkMVAFww==
X-Received: by 2002:a17:903:2288:b0:1db:c703:3fca with SMTP id
 b8-20020a170903228800b001dbc7033fcamr6163519plh.13.1708331404276; 
 Mon, 19 Feb 2024 00:30:04 -0800 (PST)
Received: from wheely.local0.net ([1.146.38.93])
 by smtp.gmail.com with ESMTPSA id
 mo7-20020a1709030a8700b001db5ecd115bsm3838348plb.276.2024.02.19.00.30.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Feb 2024 00:30:04 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-stable@nongnu.org
Subject: [PULL 02/49] target/ppc: Fix crash on machine check caused by ifetch
Date: Mon, 19 Feb 2024 18:28:51 +1000
Message-ID: <20240219082938.238302-3-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240219082938.238302-1-npiggin@gmail.com>
References: <20240219082938.238302-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

is_prefix_insn_excp() loads the first word of the instruction address
which caused an exception, to determine whether or not it was prefixed
so the prefix bit can be set in [H]SRR1.

This works if the instruction image can be loaded, but if the exception
was caused by an ifetch, this load could fail and cause a recursive
exception and crash. Machine checks caused by ifetch are not excluded
from the prefix check and can crash (see issue 2108 for an example).

Fix this by excluding machine checks caused by ifetch from the prefix
check.

Cc: qemu-stable@nongnu.org
Acked-by: Cédric Le Goater <clg@kaod.org>
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2108
Fixes: 55a7fa34f89 ("target/ppc: Machine check on invalid real address access on POWER9/10")
Fixes: 5a5d3b23cb2 ("target/ppc: Add SRR1 prefix indication to interrupt handlers")
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/excp_helper.c | 36 +++++++++++++++++++++++++-----------
 1 file changed, 25 insertions(+), 11 deletions(-)

diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index 2ec6429e36..98952de267 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -1312,6 +1312,10 @@ static bool is_prefix_insn_excp(PowerPCCPU *cpu, int excp)
 {
     CPUPPCState *env = &cpu->env;
 
+    if (!(env->insns_flags2 & PPC2_ISA310)) {
+        return false;
+    }
+
     if (!tcg_enabled()) {
         /*
          * This does not load instructions and set the prefix bit correctly
@@ -1322,6 +1326,15 @@ static bool is_prefix_insn_excp(PowerPCCPU *cpu, int excp)
     }
 
     switch (excp) {
+    case POWERPC_EXCP_MCHECK:
+        if (!(env->error_code & PPC_BIT(42))) {
+            /*
+             * Fetch attempt caused a machine check, so attempting to fetch
+             * again would cause a recursive machine check.
+             */
+            return false;
+        }
+        break;
     case POWERPC_EXCP_HDSI:
         /* HDSI PRTABLE_FAULT has the originating access type in error_code */
         if ((env->spr[SPR_HDSISR] & DSISR_PRTABLE_FAULT) &&
@@ -1332,10 +1345,10 @@ static bool is_prefix_insn_excp(PowerPCCPU *cpu, int excp)
              * instruction at NIP would cause recursive faults with the same
              * translation).
              */
-            break;
+            return false;
         }
-        /* fall through */
-    case POWERPC_EXCP_MCHECK:
+        break;
+
     case POWERPC_EXCP_DSI:
     case POWERPC_EXCP_DSEG:
     case POWERPC_EXCP_ALIGN:
@@ -1346,17 +1359,13 @@ static bool is_prefix_insn_excp(PowerPCCPU *cpu, int excp)
     case POWERPC_EXCP_VPU:
     case POWERPC_EXCP_VSXU:
     case POWERPC_EXCP_FU:
-    case POWERPC_EXCP_HV_FU: {
-        uint32_t insn = ppc_ldl_code(env, env->nip);
-        if (is_prefix_insn(env, insn)) {
-            return true;
-        }
+    case POWERPC_EXCP_HV_FU:
         break;
-    }
     default:
-        break;
+        return false;
     }
-    return false;
+
+    return is_prefix_insn(env, ppc_ldl_code(env, env->nip));
 }
 #else
 static bool is_prefix_insn_excp(PowerPCCPU *cpu, int excp)
@@ -3224,6 +3233,7 @@ void ppc_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr,
 
     switch (env->excp_model) {
 #if defined(TARGET_PPC64)
+    case POWERPC_EXCP_POWER8:
     case POWERPC_EXCP_POWER9:
     case POWERPC_EXCP_POWER10:
         /*
@@ -3245,6 +3255,10 @@ void ppc_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr,
             env->error_code |= PPC_BIT(42);
 
         } else { /* Fetch */
+            /*
+             * is_prefix_insn_excp() tests !PPC_BIT(42) to avoid fetching
+             * the instruction, so that must always be clear for fetches.
+             */
             env->error_code = PPC_BIT(36) | PPC_BIT(44) | PPC_BIT(45);
         }
         break;
-- 
2.42.0


