Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A671BC531F9
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jul 2026 08:09:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wntuR-0006yr-Ml; Sun, 26 Jul 2026 04:08:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ahshehab24@gmail.com>)
 id 1wntuP-0006wq-OM
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 04:08:29 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ahshehab24@gmail.com>)
 id 1wntuN-0007Dy-NW
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 04:08:29 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-476a130c138so1735086f8f.0
 for <qemu-devel@nongnu.org>; Sun, 26 Jul 2026 01:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785053305; x=1785658105; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=yBhga8BoD8LBHCthuK5Q4biQb8UnlAKLeKghegcYlOY=;
 b=NueBCi9+1iZfdpIiXPaOubLz8ZJGPvRuadrrPUmxUG/7Zna5xJC4kXxYoBGjO6uk5s
 s1bCebsn6rPUpXsuA4Qa8lLRVkaNlMjCQmy1MsZRvkUIRrmIy5aJrWdsZuXQFngUv9Ue
 g1sP2vqPEUJXTgyPYErdB0lbnIHv2rofEZPZNOJYRXQiTM7IRA3PJ+JWKpJZTlPpqPZj
 uyyzbzlPA0M9QO9DAbUJsFfUuo0MXIDl6wR6fsCU05eZD1dlvHl/HFzVDAtvcSgpfiIE
 zqGMcU9kN1w0zc/hz69cXAhmRAgj1jsv73BQmDhv5GRjThz20RK2Tr/vo7OwdAYpyhyr
 WAJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785053305; x=1785658105;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yBhga8BoD8LBHCthuK5Q4biQb8UnlAKLeKghegcYlOY=;
 b=nJhlea5iPZXiU7MDRMOoUeud6kzL07To2sM2yWjnXDfTwarKgY1TYZAZG/YrxgFuyb
 uAnXlCM67Pj0WWaET/qKjdhjVnbxLRTR/yFX1neQ64Nf1kV57lgkBx+3MXaVWZbvReiK
 fc1Q2V7iNhvnsTobfP7mddmHQRt1W+95ECmpi0oHmlpfnMlcTmqR0IRRq611CPXMg9bv
 ncetAINc0NgC+sI9xCY4tmL0pEIntP+CWS7tcDSfeuNEvn7yWS8bHVi5wKKRGG8rwIEj
 757nDgvF2XDCMGWYw5rpfSFHWDYKOmNIus20/h+mmgF6emYzODYnDiIDCFmpzVHjkLad
 TuAw==
X-Gm-Message-State: AOJu0YxtwhWFY3DudTzDw6htWsIq+KXHU56OLcvU8lxAX9QASoiUuQlB
 JpqWY1s3PSABp7ElnvZfa76eBmswteFshzaNN1LfVSUpBHHx7eICXNGtfZHcjGspJWI=
X-Gm-Gg: AR+sD12BNcAE1NBIGAdhmtPj0ehZ6YkGs+WE/cE6Z4FmcGaGAAiVzHViYIDZc31l5+M
 z+jog1Yp3VmaYKDvFK4ZeJZduPaSwEXuUxsrhIjyYBcl39B7zYG+JUWDM5hspZjStjCL8p36FwI
 ztCNzmL+0XC9iroACsJKcpUKNPigmyvRVrceLphJBZgH0Yrr3yW7YJONESaPoFfhdAFkJtOCnjV
 r6lsCitnmf9qIlLnqGHven7nysrmDoS+NwgS6uYQfIIi+/vEySWBaWvZtJT1NcytX7RdSlz84PV
 aEYP4smCC4itWGyQ+MbxxnNQPOLWvCqFWEo6wnGhz3FYfX09hcXpPDPO+ixX5I/4FZYizcwcQBX
 CDLCI2sDYro/AniR2dMHCX2Vz8wSgNAsVv6ca9eD+LM8/8978EDzzM5D5Af/VWHJGsbgBwTo86e
 ou1OK8vOiaeZf78bfbHfXEzwPQ
X-Received: by 2002:a05:6000:184e:b0:47f:9220:3d with SMTP id
 ffacd0b85a97d-47f9feaa5bbmr5342261f8f.58.1785053304801; 
 Sun, 26 Jul 2026 01:08:24 -0700 (PDT)
Received: from 5520-BMRXQ93.eg.si-vision.com ([41.33.244.227])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85c6dc25sm37896516f8f.33.2026.07.26.01.08.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Jul 2026 01:08:24 -0700 (PDT)
From: A-Shehab <ahshehab24@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, daniel.barboza@oss.qualcomm.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 debug@rivosinc.com, A-Shehab <ahshehab24@gmail.com>
Subject: [PATCH v2] target/riscv: allow menvcfg/henvcfg LPE and SSE bits on
 RV32
Date: Sun, 26 Jul 2026 11:05:37 +0300
Message-ID: <20260726080537.13913-1-ahshehab24@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=ahshehab24@gmail.com; helo=mail-wr1-x42f.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The Zicfilp landing-pad enable (LPE, bit 2) and Zicfiss shadow-stack
enable (SSE, bit 3) controls live in the low 32 bits of menvcfg and
henvcfg, and the CFI specification defines them for both RV32 and RV64.

QEMU only adds MENVCFG_LPE/MENVCFG_SSE (and the henvcfg equivalents) to
the writable mask inside the "riscv_cpu_mxl(env) == MXL_RV64" block, so
on RV32 these bits are silently dropped and the features cannot be
enabled. This is inconsistent with write_senvcfg(), which already
handles SENVCFG_LPE/SENVCFG_SSE regardless of MXLEN.

Hoist the LPE/SSE mask handling out of the RV64-only block in
write_menvcfg() and write_henvcfg() so the bits become writable on RV32
as well. The upper-half writers (write_menvcfgh/write_henvcfgh) are
unaffected because these bits reside in the low 32 bits.

Reproducible on qemu-system-riscv32 -cpu rv32,zicfilp=true,zicfiss=true:
an M-mode write of menvcfg.{LPE,SSE} reads back as zero, while the same
program on rv64 keeps the bits set.

Fixes: 4923f672e3d7 ("target/riscv: Introduce elp state and enabling controls for zicfilp")
Fixes: 8205bc127a83 ("target/riscv: introduce ssp and enabling controls for zicfiss")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/4045
Signed-off-by: A-Shehab <ahshehab24@gmail.com>
---
v2: Rebase on current master; the file moved from target/riscv/csr.c to
    target/riscv/tcg/csr.c (noted by Daniel Henrique Barboza). No
    functional change.

v1: https://lore.kernel.org/qemu-devel/20260719111749.23777-1-ahshehab24@gmail.com/

 target/riscv/tcg/csr.c | 45 +++++++++++++++++++++++++-----------------
 1 file changed, 27 insertions(+), 18 deletions(-)

diff --git a/target/riscv/tcg/csr.c b/target/riscv/tcg/csr.c
index 36f2004bc5..0182e4c408 100644
--- a/target/riscv/tcg/csr.c
+++ b/target/riscv/tcg/csr.c
@@ -3216,6 +3216,19 @@ static RISCVException write_menvcfg(CPURISCVState *env, int csrno,
                     MENVCFG_CBZE;
     bool stce_changed = false;
 
+    /*
+     * menvcfg.LPE (Zicfilp) and menvcfg.SSE (Zicfiss) reside in the low
+     * 32 bits and are defined for both RV32 and RV64, so they must be
+     * writable regardless of MXLEN.
+     */
+    if (cfg->ext_zicfilp) {
+        mask |= MENVCFG_LPE;
+    }
+
+    if (cfg->ext_zicfiss) {
+        mask |= MENVCFG_SSE;
+    }
+
     if (riscv_cpu_mxl(env) == MXL_RV64) {
         mask |= (cfg->ext_svpbmt ? MENVCFG_PBMTE : 0) |
                 (cfg->ext_sstc ? MENVCFG_STCE : 0) |
@@ -3223,14 +3236,6 @@ static RISCVException write_menvcfg(CPURISCVState *env, int csrno,
                 (cfg->ext_svadu ? MENVCFG_ADUE : 0) |
                 (cfg->ext_ssdbltrp ? MENVCFG_DTE : 0);
 
-        if (env_archcpu(env)->cfg.ext_zicfilp) {
-            mask |= MENVCFG_LPE;
-        }
-
-        if (env_archcpu(env)->cfg.ext_zicfiss) {
-            mask |= MENVCFG_SSE;
-        }
-
         /* Update PMM field only if the value is valid according to Zjpm v1.0 */
         if (env_archcpu(env)->cfg.ext_smnpm &&
             get_field(val, MENVCFG_PMM) != PMM_FIELD_RESERVED) {
@@ -3378,20 +3383,24 @@ static RISCVException write_henvcfg(CPURISCVState *env, int csrno,
         return ret;
     }
 
+    /*
+     * henvcfg.LPE (Zicfilp) and henvcfg.SSE (Zicfiss) reside in the low
+     * 32 bits and are defined for both RV32 and RV64, so they must be
+     * writable regardless of MXLEN.
+     */
+    if (cfg->ext_zicfilp) {
+        mask |= HENVCFG_LPE;
+    }
+
+    /* H can light up SSE for VS only if HS had it from menvcfg */
+    if (cfg->ext_zicfiss && get_field(env->menvcfg, MENVCFG_SSE)) {
+        mask |= HENVCFG_SSE;
+    }
+
     if (riscv_cpu_mxl(env) == MXL_RV64) {
         mask |= env->menvcfg & (HENVCFG_PBMTE | HENVCFG_STCE | HENVCFG_ADUE |
                                 HENVCFG_DTE);
 
-        if (env_archcpu(env)->cfg.ext_zicfilp) {
-            mask |= HENVCFG_LPE;
-        }
-
-        /* H can light up SSE for VS only if HS had it from menvcfg */
-        if (env_archcpu(env)->cfg.ext_zicfiss &&
-            get_field(env->menvcfg, MENVCFG_SSE)) {
-            mask |= HENVCFG_SSE;
-        }
-
         /* Update PMM field only if the value is valid according to Zjpm v1.0 */
         if (env_archcpu(env)->cfg.ext_ssnpm &&
             get_field(val, HENVCFG_PMM) != PMM_FIELD_RESERVED) {
-- 
2.53.0


