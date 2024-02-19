Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AB8DC48BC3
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Feb 2024 08:36:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rbz3I-0000Za-1k; Mon, 19 Feb 2024 03:31:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rbz3E-0000Ra-7c; Mon, 19 Feb 2024 03:31:00 -0500
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rbz3C-0002Hm-DW; Mon, 19 Feb 2024 03:30:59 -0500
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-6e45bd5014dso65946b3a.1; 
 Mon, 19 Feb 2024 00:30:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708331456; x=1708936256; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DpJTcCEBaucSP+9TveiDuIoWZzeK5xPgEMIfuzilfqU=;
 b=S6DQSo0A/Y3j2de7Fn10zDEsqdKC2u4uQEjHGkn1LQ+56sAGJZlVybmlQN+jjgDqYC
 x8rTAJM8qxo6JqFTbGGCUdO2MDTeMVABvRGzCsgLq5zD8ViaZYd95geuWLrSLEHc3poj
 DtPQqp4aYCNE73TvsRrM9zEJquSXv+wE0xGCA+0bxmyUu7VF/84PRPFoeOuS8acg2Hl1
 pNZ6Bo0kDzt4O3SMY5xcfgHO/JjniPlN9L8BDkV5adaMz9TJvZQcAaClhQhgRiA1/3zc
 IE+tYJe8eaa7r7m5qugA6Ala2T9Tt8DrvPM8L0KE60+xD1y+vsc9ujPhlbLU10NrR7qy
 k8aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708331456; x=1708936256;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DpJTcCEBaucSP+9TveiDuIoWZzeK5xPgEMIfuzilfqU=;
 b=G2Z8SqKTuAVWObl8WfRmyPTC0afzRM7oKXNgVRDfNsTRGfxmx18eOEqF2GVKfvD/qe
 cexSDtnFu7N2WVZFhjM9iEazJYcL6r19i2022ZCbDO5oiQ3YeE4c5jKqkIAg3ue0v+Ef
 q9/jmBBguiTVWBBqlMLlaGdbIfXQ2oZsytRP2Y6I+qDxNDkmHI5G79K3paSeMfRhmGxI
 H6N1C5x6NiTA3gZQ9faezp6f6q32JB3WAldI2xyYfrooyzsQS6x+dF/sX4kIikTLGpPo
 QZUupjumk8jhlQu6qcl6qKHvhDjQBuhSkz+vrSVP+NDbFzduLBC146iX6E0GK/wySSN2
 J90g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWu1r3eWJ4jS1L6vdHpfhZ8VbGE4i2vcjiEy37sOFCiQroTZwiDmEwFM+RCes/V5hQvkkQzMm6y5Ssd/xt2QSM5a2pe
X-Gm-Message-State: AOJu0YxCtQoVyxs9KwQjiVeo4yjzhNT0PUIcNIkZot8cqOKrwXwBHsOI
 paz+ukQwjOTF4mecmMCi6CDAIv7OU9HF2kqkM+AAQEpWg0NdiwdTQhqxZYvY
X-Google-Smtp-Source: AGHT+IHk9J2elGgP8PTZMwNj9mavhaXu7zU2nbGgMkSzQwPb6o6YQ38BfLrhpsMIUC5AsRVav7C7jw==
X-Received: by 2002:a17:902:6b05:b0:1db:a2bc:22c8 with SMTP id
 o5-20020a1709026b0500b001dba2bc22c8mr7784496plk.58.1708331455944; 
 Mon, 19 Feb 2024 00:30:55 -0800 (PST)
Received: from wheely.local0.net ([1.146.38.93])
 by smtp.gmail.com with ESMTPSA id
 mo7-20020a1709030a8700b001db5ecd115bsm3838348plb.276.2024.02.19.00.30.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Feb 2024 00:30:55 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: [PULL 12/49] target/ppc: Rename registers to match ISA
Date: Mon, 19 Feb 2024 18:29:01 +1000
Message-ID: <20240219082938.238302-13-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240219082938.238302-1-npiggin@gmail.com>
References: <20240219082938.238302-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42a.google.com
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

Several registers have names that don't match the ISA (or convention
with other QEMU PPC registers), making them unintuitive to use with
GDB.

Fortunately most of these registers are obscure and/or have not been
correctly implemented in the gdb server (e.g., DEC, TB, CFAR), so risk
of breaking users should be low.

QEMU should follow the ISA for register name convention (where there is
no established GDB name).

Acked-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/cpu_init.c    | 20 ++++++++++----------
 target/ppc/helper_regs.c |  2 +-
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 9931372a08..9bccddb350 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -5062,7 +5062,7 @@ static void register_970_hid_sprs(CPUPPCState *env)
 
 static void register_970_hior_sprs(CPUPPCState *env)
 {
-    spr_register(env, SPR_HIOR, "SPR_HIOR",
+    spr_register(env, SPR_HIOR, "HIOR",
                  SPR_NOACCESS, SPR_NOACCESS,
                  &spr_read_hior, &spr_write_hior,
                  0x00000000);
@@ -5070,11 +5070,11 @@ static void register_970_hior_sprs(CPUPPCState *env)
 
 static void register_book3s_ctrl_sprs(CPUPPCState *env)
 {
-    spr_register(env, SPR_CTRL, "SPR_CTRL",
+    spr_register(env, SPR_CTRL, "CTRL",
                  SPR_NOACCESS, SPR_NOACCESS,
                  SPR_NOACCESS, &spr_write_CTRL,
                  0x00000000);
-    spr_register(env, SPR_UCTRL, "SPR_UCTRL",
+    spr_register(env, SPR_UCTRL, "UCTRL",
                  &spr_read_ureg, SPR_NOACCESS,
                  &spr_read_ureg, SPR_NOACCESS,
                  0x00000000);
@@ -5465,7 +5465,7 @@ static void register_book3s_purr_sprs(CPUPPCState *env)
 static void register_power6_dbg_sprs(CPUPPCState *env)
 {
 #if !defined(CONFIG_USER_ONLY)
-    spr_register(env, SPR_CFAR, "SPR_CFAR",
+    spr_register(env, SPR_CFAR, "CFAR",
                  SPR_NOACCESS, SPR_NOACCESS,
                  &spr_read_cfar, &spr_write_cfar,
                  0x00000000);
@@ -5483,7 +5483,7 @@ static void register_power5p_common_sprs(CPUPPCState *env)
 static void register_power6_common_sprs(CPUPPCState *env)
 {
 #if !defined(CONFIG_USER_ONLY)
-    spr_register_kvm(env, SPR_DSCR, "SPR_DSCR",
+    spr_register_kvm(env, SPR_DSCR, "DSCR",
                      SPR_NOACCESS, SPR_NOACCESS,
                      &spr_read_generic, &spr_write_generic,
                      KVM_REG_PPC_DSCR, 0x00000000);
@@ -5695,7 +5695,7 @@ static void register_power8_book4_sprs(CPUPPCState *env)
                      &spr_read_generic, &spr_write_generic,
                      KVM_REG_PPC_ACOP, 0);
     /* PID is only in BookE in ISA v2.07 */
-    spr_register_kvm(env, SPR_BOOKS_PID, "PID",
+    spr_register_kvm(env, SPR_BOOKS_PID, "PIDR",
                      SPR_NOACCESS, SPR_NOACCESS,
                      &spr_read_generic, &spr_write_pidr,
                      KVM_REG_PPC_PID, 0);
@@ -5716,7 +5716,7 @@ static void register_power7_book4_sprs(CPUPPCState *env)
                      &spr_read_generic, &spr_write_generic,
                      KVM_REG_PPC_ACOP, 0);
     /* PID is only in BookE in ISA v2.06 */
-    spr_register_kvm(env, SPR_BOOKS_PID, "PID",
+    spr_register_kvm(env, SPR_BOOKS_PID, "PIDR",
                      SPR_NOACCESS, SPR_NOACCESS,
                      &spr_read_generic, &spr_write_generic32,
                      KVM_REG_PPC_PID, 0);
@@ -5750,7 +5750,7 @@ static void register_power9_mmu_sprs(CPUPPCState *env)
                     &spr_read_generic, &spr_write_generic,
                     0x0000000000000000);
     /* PID is part of the BookS ISA from v3.0 */
-    spr_register_kvm(env, SPR_BOOKS_PID, "PID",
+    spr_register_kvm(env, SPR_BOOKS_PID, "PIDR",
                      SPR_NOACCESS, SPR_NOACCESS,
                      &spr_read_generic, &spr_write_pidr,
                      KVM_REG_PPC_PID, 0);
@@ -5791,7 +5791,7 @@ static void register_power10_dexcr_sprs(CPUPPCState *env)
             &spr_read_generic, &spr_write_generic32,
             0);
 
-    spr_register(env, SPR_UDEXCR, "DEXCR",
+    spr_register(env, SPR_UDEXCR, "UDEXCR",
             &spr_read_dexcr_ureg, SPR_NOACCESS,
             &spr_read_dexcr_ureg, SPR_NOACCESS,
             0);
@@ -5802,7 +5802,7 @@ static void register_power10_dexcr_sprs(CPUPPCState *env)
             &spr_read_generic, &spr_write_generic32,
             0);
 
-    spr_register(env, SPR_UHDEXCR, "HDEXCR",
+    spr_register(env, SPR_UHDEXCR, "UHDEXCR",
             &spr_read_dexcr_ureg, SPR_NOACCESS,
             &spr_read_dexcr_ureg, SPR_NOACCESS,
             0);
diff --git a/target/ppc/helper_regs.c b/target/ppc/helper_regs.c
index e0b2dcd02e..8324ff22db 100644
--- a/target/ppc/helper_regs.c
+++ b/target/ppc/helper_regs.c
@@ -490,7 +490,7 @@ void register_non_embedded_sprs(CPUPPCState *env)
                      &spr_read_generic, &spr_write_generic,
                      KVM_REG_PPC_DAR, 0x00000000);
     /* Timer */
-    spr_register(env, SPR_DECR, "DECR",
+    spr_register(env, SPR_DECR, "DEC",
                  SPR_NOACCESS, SPR_NOACCESS,
                  &spr_read_decr, &spr_write_decr,
                  0x00000000);
-- 
2.42.0


