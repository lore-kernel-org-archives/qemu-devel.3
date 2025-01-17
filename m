Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE101C0218A
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 06:03:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYfNd-0001Mk-T1; Fri, 17 Jan 2025 00:58:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tYfNB-0008NB-My
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 00:58:32 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tYfN8-0006AB-I0
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 00:58:24 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-218c8aca5f1so42095125ad.0
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2025 21:58:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737093501; x=1737698301; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VW53uR3NvUkmC3jsWTu7x63ix67e7PmVJga18/0vL3c=;
 b=et0Rj1PDs1WR+eDTzDbLb5dGE4qv6h1MweHcCMkVOou4Wu1UCIg13ZkL2jjoPIwrnP
 q4GCYxLb4t37RraKBpRQeQp1aNkIMPxl+kcn1ynWBHAHqftWmgch3RrnHILCpqCspK4x
 aB9e8/nRfOkENbKAXf9EOIa6s+8X6TOgL18BqyndeR7Qq3Vh3leV2Ff9bB4mZEfpmUh2
 3ASA/bf414x1HgkiExjnc4nqyREnfHYKlSOh67nnFQ48Tf9MuCjsPF0V/9d7ryoEcAAF
 kRXwZpOMeD+nnUY334DVPRwMOJ8Z3OWmJ0dapAf1tSljHNsp1FzLKdaozU8nxPhHfQuI
 VtJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737093501; x=1737698301;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VW53uR3NvUkmC3jsWTu7x63ix67e7PmVJga18/0vL3c=;
 b=J3hKbhmX8YlxdPlixnv6Uu3XIw+Za7OBx6o3NKIMhh1Hb7/tZfKCi4/WHl0ZcQYwhK
 nOXyFTQldpig/SUzuJd/QbvqTpqYo1nqaXrvVPHGIgfbj37HsyObvqYshylPOTugoJ92
 4+ICK5Ip2mL23vpvPR2JsXqvMXrcDej4OLOluveRF45/+1FA9GTBTop6RaNrzVB6DTyG
 6b0AlKZLI905TJrL+Pl5gX/W8i7MqwYPSbvdHR3BfpotCt4CmB3SQZN4l3KgTuLgH2X6
 9ngjyWxRKweWSUbRTUz07ZSJLfuj1glUxXhqEn8c/0s56pKHo2aKEOy/gJ+TpbvTjBf8
 Sndg==
X-Gm-Message-State: AOJu0Yy1kOg9Lw2dcGrBFZr09m+JOWb8PM/JpaLQMQC2eIyljZq+p6tH
 BSCGpXdqBZ8+4PqENb1e3SFR2kL0lC6rbYtGDCjaxVelLd6jj98ksxh2cQ==
X-Gm-Gg: ASbGncvx3lRKyBCoVGMl7cLrtDIAa5rssZMYQyQ6+n4Whw3GXub/ljUkk8e9pxzCagy
 3YGLpNSZ4cWkUJtTJ0su7OjOg5CXvnk4mGjmGQ1fW8TuHELGaAMiJ9T1HPAiJ+QrP/9Hc9sjR4Q
 ulvo9SGGyfJdNfr5SRyE0JZSchhqOD+VwkpF9JXY/te1bLTP1Oc0QyEG5x69pPzDo3n9bHRT9EB
 nDUfaAgiAGJ7ixaRqAkXXiZXcagABH7T6r543BdfPVIaXiKRnrArfZdDeRRPZj3fTgVE6HHoPuX
 S64RiUdLCVSkUUhEFxUTV5WF5CeAI8D5vj0qA9D+Y/Z7RD2k2ZaaOW4VlHD0
X-Google-Smtp-Source: AGHT+IH7nu6+2bCpRcje+SLNoQgd6Z95wnAebVrLHHZzR2ybj4kqFGMoFO8U3ZvUI9QyPcfIReBXqA==
X-Received: by 2002:a17:902:d48a:b0:216:6f1e:5799 with SMTP id
 d9443c01a7336-21c355ee2b7mr25420905ad.35.1737093501126; 
 Thu, 16 Jan 2025 21:58:21 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21c2d3d6fbbsm8563595ad.168.2025.01.16.21.58.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jan 2025 21:58:20 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
 =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 41/50] target/riscv: Implement Ssdbltrp sret,
 mret and mnret behavior
Date: Fri, 17 Jan 2025 15:55:43 +1000
Message-ID: <20250117055552.108376-42-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250117055552.108376-1-alistair.francis@wdc.com>
References: <20250117055552.108376-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62c.google.com
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

From: Clément Léger <cleger@rivosinc.com>

When the Ssdbltrp extension is enabled, SSTATUS.SDT field is cleared
when executing sret. When executing mret/mnret, SSTATUS.SDT is cleared
when returning to U, VS or VU and VSSTATUS.SDT is cleared when returning
to VU from HS.

Signed-off-by: Clément Léger <cleger@rivosinc.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20250110125441.3208676-4-cleger@rivosinc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/op_helper.c | 35 ++++++++++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index c825336519..59c4bf28ed 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -294,6 +294,18 @@ target_ulong helper_sret(CPURISCVState *env)
                         get_field(mstatus, MSTATUS_SPIE));
     mstatus = set_field(mstatus, MSTATUS_SPIE, 1);
     mstatus = set_field(mstatus, MSTATUS_SPP, PRV_U);
+
+    if (riscv_cpu_cfg(env)->ext_ssdbltrp) {
+        if (riscv_has_ext(env, RVH)) {
+            target_ulong prev_vu = get_field(env->hstatus, HSTATUS_SPV) &&
+                                   prev_priv == PRV_U;
+            /* Returning to VU from HS, vsstatus.sdt = 0 */
+            if (!env->virt_enabled && prev_vu) {
+                env->vsstatus = set_field(env->vsstatus, MSTATUS_SDT, 0);
+            }
+        }
+        mstatus = set_field(mstatus, MSTATUS_SDT, 0);
+    }
     if (env->priv_ver >= PRIV_VERSION_1_12_0) {
         mstatus = set_field(mstatus, MSTATUS_MPRV, 0);
     }
@@ -304,7 +316,6 @@ target_ulong helper_sret(CPURISCVState *env)
         target_ulong hstatus = env->hstatus;
 
         prev_virt = get_field(hstatus, HSTATUS_SPV);
-
         hstatus = set_field(hstatus, HSTATUS_SPV, 0);
 
         env->hstatus = hstatus;
@@ -344,6 +355,22 @@ static void check_ret_from_m_mode(CPURISCVState *env, target_ulong retpc,
         riscv_raise_exception(env, RISCV_EXCP_INST_ACCESS_FAULT, GETPC());
     }
 }
+static target_ulong ssdbltrp_mxret(CPURISCVState *env, target_ulong mstatus,
+                                   target_ulong prev_priv,
+                                   target_ulong prev_virt)
+{
+    /* If returning to U, VS or VU, sstatus.sdt = 0 */
+    if (prev_priv == PRV_U || (prev_virt &&
+        (prev_priv == PRV_S || prev_priv == PRV_U))) {
+        mstatus = set_field(mstatus, MSTATUS_SDT, 0);
+        /* If returning to VU, vsstatus.sdt = 0 */
+        if (prev_virt && prev_priv == PRV_U) {
+            env->vsstatus = set_field(env->vsstatus, MSTATUS_SDT, 0);
+        }
+    }
+
+    return mstatus;
+}
 
 target_ulong helper_mret(CPURISCVState *env)
 {
@@ -361,6 +388,9 @@ target_ulong helper_mret(CPURISCVState *env)
     mstatus = set_field(mstatus, MSTATUS_MPP,
                         riscv_has_ext(env, RVU) ? PRV_U : PRV_M);
     mstatus = set_field(mstatus, MSTATUS_MPV, 0);
+    if (riscv_cpu_cfg(env)->ext_ssdbltrp) {
+        mstatus = ssdbltrp_mxret(env, mstatus, prev_priv, prev_virt);
+    }
     if ((env->priv_ver >= PRIV_VERSION_1_12_0) && (prev_priv != PRV_M)) {
         mstatus = set_field(mstatus, MSTATUS_MPRV, 0);
     }
@@ -402,6 +432,9 @@ target_ulong helper_mnret(CPURISCVState *env)
     if (prev_priv < PRV_M) {
         env->mstatus = set_field(env->mstatus, MSTATUS_MPRV, false);
     }
+    if (riscv_cpu_cfg(env)->ext_ssdbltrp) {
+        env->mstatus = ssdbltrp_mxret(env, env->mstatus, prev_priv, prev_virt);
+    }
 
     if (riscv_has_ext(env, RVH) && prev_virt) {
         riscv_cpu_swap_hypervisor_regs(env);
-- 
2.47.1


