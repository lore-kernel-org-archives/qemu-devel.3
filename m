Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB18AD116F3
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Dec 2025 01:13:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQEwc-0001Jj-Nx; Mon, 01 Dec 2025 20:12:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vQEwW-0001In-M2
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 20:12:38 -0500
Received: from mail-oa1-x2f.google.com ([2001:4860:4864:20::2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vQEwU-0007B6-FF
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 20:12:36 -0500
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-3e7f68df436so2967856fac.1
 for <qemu-devel@nongnu.org>; Mon, 01 Dec 2025 17:12:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764637951; x=1765242751; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x+nTrV+MISVUTBqxbLE/Tz8uUSABBgmkkZf5VTW5OmQ=;
 b=Jlva2oNs80eUquuzVhU7SqN6A2ydeXx23z8B4nGDLpmA9eQpL1YrYuS9vVbAayTVtt
 Uuwdjyinsw+niRTTYYWgA0huTOSwWhWbXVWMpGs7puQMhrrjZ6JSzY0IIpn5+5C+wwMg
 lVXRCsHfShVAcEtNVLoXGC827Ea2VJaUCjmZOYvv/F+pOJVfjB3E8ZJb6ZGiz1mTD4DC
 HTcM7s2voBttxLm5obkZR1PNBQPP31iDafBMpjp4rddQBjN34/teGaEdJ/HQAFrA4Lpm
 ONAxxwrQDZflBPoWl/isqssMTX/q1uIByUh+2lc2T69J77wGXxOKChO3RzSbR0mcupJS
 0e/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764637951; x=1765242751;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=x+nTrV+MISVUTBqxbLE/Tz8uUSABBgmkkZf5VTW5OmQ=;
 b=kEtY5x6Hi4lUmaKi/KpxKw6w5J+1C7rygwdu1w/eJkqYg9Du8+F/RTLXZlrfX28TJT
 Uj+j7uv5hyR4osrnDMszhw02977WjFli68TNbX+3lHhzLYXRso3Oev7LtP3aO/NQz/uK
 jTrwrOi9jSqwGFezordv8QeF+9Lgi14lV9njgbkAgDIS4fY/2D0TGPgYSRWbIaJMh/Sp
 UTu/s5AEnW/ZYNAvC9M+TNiufQJJ7lcwWLAA2c9mM/656LoPkNqMYo2Vacf6DfePI47d
 zNwBN/LYF7xvMbiWjuElZs6I9aTxanVD2XOrbZ/q9HoQmpmOlzK8MmrrGB4q1rIKN8n8
 nY5A==
X-Gm-Message-State: AOJu0Yzyqx26BFkEcAucTf2AwmTM6b+M1/ZV2a4vj6ot+SRdc90VWrL3
 D15nwAbvi4DGTgJ4fdQWbaUw/F75yHpUv98kF6vOgwVnU6E8MeAF5stRvdHD7M+zxHng61K4P4f
 AA9yYtLE=
X-Gm-Gg: ASbGnctdKOuY6S9kFnCFIgDHlfti11VDOTbMnsSl4EdJBWO9Qy/t+sNumBc7dhsRror
 PKL9yh9ixX0KkV2alj+M/YjOs2p9x2zab3JWt0I5wSV9c3D1f+e8XxLtwsy7Nyg10T1vCe0A/zd
 EpfFaQi/3AIJgzl+Kmmj2x1SXnF9zSrX+EoMH5E8fn6s2VGlMig38LTVeQzSedYL37kd+MXI5Pp
 YUB0Y21tV9xdAbr2WRtCXQdIZJJWZj7XUwGyNcn21dggbK9LMvvkFVrX4lBr0F49IyB69TGLjX0
 h+Me/ooVTX3r7ZppM7R4YmzuwaCJShAC89dNdJKMME02fZOz/QhPAiCDUaWQkGGyZc7ydp8IHNk
 RPQYkGQY3itrZTrIw+H93AJkWr+2AN3QEXCuEAJHlVIt0ADJ66OAg18+uuO5Ktc5bFun7FUEKep
 Y3HYDzKFJ8qBwOHns=
X-Google-Smtp-Source: AGHT+IFxPSeEVWl4lSDwIFsuJh3i6+ApICrzDi2M33UXTO6N8vpIuugYeBefZ0+Eb6sYp2BboepsBw==
X-Received: by 2002:a05:6870:8193:b0:3d2:1a91:2f1e with SMTP id
 586e51a60fabf-3f14f18483emr481285fac.8.1764637951387; 
 Mon, 01 Dec 2025 17:12:31 -0800 (PST)
Received: from stoup.. ([201.144.25.11]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3f0dd05bc9asm6458709fac.22.2025.12.01.17.12.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Dec 2025 17:12:30 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org,
	peter.maydell@linaro.org
Subject: [PATCH 1/2] tcg/tci: Introduce INDEX_op_tci_qemu_{ld,st}_rrr
Date: Mon,  1 Dec 2025 17:12:26 -0800
Message-ID: <20251202011228.503007-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251202011228.503007-1-richard.henderson@linaro.org>
References: <20251202011228.503007-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2f;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2f.google.com
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

Since d182123974c4, the number of bits in a MemOpIdx
tops out at 17.  This fixes an assert in tcg_out_op_rrm.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tci.c                    | 19 +++++++++++++++++++
 tcg/tci/tcg-target-opc.h.inc |  2 ++
 tcg/tci/tcg-target.c.inc     | 14 ++++++++++++--
 3 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/tcg/tci.c b/tcg/tci.c
index 700e672616..e15d4e8e08 100644
--- a/tcg/tci.c
+++ b/tcg/tci.c
@@ -794,12 +794,24 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
             taddr = regs[r1];
             regs[r0] = tci_qemu_ld(env, taddr, oi, tb_ptr);
             break;
+        case INDEX_op_tci_qemu_ld_rrr:
+            tci_args_rrr(insn, &r0, &r1, &r2);
+            taddr = regs[r1];
+            oi = regs[r2];
+            regs[r0] = tci_qemu_ld(env, taddr, oi, tb_ptr);
+            break;
 
         case INDEX_op_qemu_st:
             tci_args_rrm(insn, &r0, &r1, &oi);
             taddr = regs[r1];
             tci_qemu_st(env, taddr, regs[r0], oi, tb_ptr);
             break;
+        case INDEX_op_tci_qemu_st_rrr:
+            tci_args_rrr(insn, &r0, &r1, &r2);
+            taddr = regs[r1];
+            oi = regs[r2];
+            tci_qemu_st(env, taddr, regs[r0], oi, tb_ptr);
+            break;
 
         case INDEX_op_qemu_ld2:
             tcg_debug_assert(TCG_TARGET_REG_BITS == 32);
@@ -1050,6 +1062,13 @@ int print_insn_tci(bfd_vma addr, disassemble_info *info)
                            op_name, str_r(r0), str_r(r1), oi);
         break;
 
+    case INDEX_op_tci_qemu_ld_rrr:
+    case INDEX_op_tci_qemu_st_rrr:
+        tci_args_rrr(insn, &r0, &r1, &r2);
+        info->fprintf_func(info->stream, "%-12s  %s, %s, %s",
+                           op_name, str_r(r0), str_r(r1), str_r(r2));
+        break;
+
     case INDEX_op_qemu_ld2:
     case INDEX_op_qemu_st2:
         tci_args_rrrr(insn, &r0, &r1, &r2, &r3);
diff --git a/tcg/tci/tcg-target-opc.h.inc b/tcg/tci/tcg-target-opc.h.inc
index 4eb32ed736..f8bfffc125 100644
--- a/tcg/tci/tcg-target-opc.h.inc
+++ b/tcg/tci/tcg-target-opc.h.inc
@@ -13,3 +13,5 @@ DEF(tci_rotl32, 1, 2, 0, TCG_OPF_NOT_PRESENT)
 DEF(tci_rotr32, 1, 2, 0, TCG_OPF_NOT_PRESENT)
 DEF(tci_setcond32, 1, 2, 1, TCG_OPF_NOT_PRESENT)
 DEF(tci_movcond32, 1, 2, 1, TCG_OPF_NOT_PRESENT)
+DEF(tci_qemu_ld_rrr, 1, 2, 0, TCG_OPF_NOT_PRESENT)
+DEF(tci_qemu_st_rrr, 0, 3, 0, TCG_OPF_NOT_PRESENT)
diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
index 35c66a4836..532f87262c 100644
--- a/tcg/tci/tcg-target.c.inc
+++ b/tcg/tci/tcg-target.c.inc
@@ -1188,7 +1188,12 @@ static const TCGOutOpStore outop_st = {
 static void tgen_qemu_ld(TCGContext *s, TCGType type, TCGReg data,
                          TCGReg addr, MemOpIdx oi)
 {
-    tcg_out_op_rrm(s, INDEX_op_qemu_ld, data, addr, oi);
+    if (oi & ~0xffff) {
+        tcg_out_movi(s, TCG_TYPE_I32, TCG_REG_TMP, oi);
+        tcg_out_op_rrr(s, INDEX_op_tci_qemu_ld_rrr, data, addr, TCG_REG_TMP);
+    } else {
+        tcg_out_op_rrm(s, INDEX_op_qemu_ld, data, addr, oi);
+    }
 }
 
 static const TCGOutOpQemuLdSt outop_qemu_ld = {
@@ -1213,7 +1218,12 @@ static const TCGOutOpQemuLdSt2 outop_qemu_ld2 = {
 static void tgen_qemu_st(TCGContext *s, TCGType type, TCGReg data,
                          TCGReg addr, MemOpIdx oi)
 {
-    tcg_out_op_rrm(s, INDEX_op_qemu_st, data, addr, oi);
+    if (oi & ~0xffff) {
+        tcg_out_movi(s, TCG_TYPE_I32, TCG_REG_TMP, oi);
+        tcg_out_op_rrr(s, INDEX_op_tci_qemu_st_rrr, data, addr, TCG_REG_TMP);
+    } else {
+        tcg_out_op_rrm(s, INDEX_op_qemu_st, data, addr, oi);
+    }
 }
 
 static const TCGOutOpQemuLdSt outop_qemu_st = {
-- 
2.43.0


