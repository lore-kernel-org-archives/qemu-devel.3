Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B20D0C02187
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jan 2025 01:13:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tZJrn-00011V-IB; Sat, 18 Jan 2025 20:12:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tZJrm-00011N-7p
 for qemu-devel@nongnu.org; Sat, 18 Jan 2025 20:12:42 -0500
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tZJrk-00037e-OO
 for qemu-devel@nongnu.org; Sat, 18 Jan 2025 20:12:42 -0500
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-2ee76befe58so5795347a91.2
 for <qemu-devel@nongnu.org>; Sat, 18 Jan 2025 17:12:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737249159; x=1737853959; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yaTS6py126U4BbD4RQuuk4UG2ehBqDT81irsaHxix9k=;
 b=epSysjT6E9JrcqLHozkQGMr9ut5tipve0o/ypguJ9Ok7pk59zf2BVnjuf9i++fEjJ7
 npMyZBlJnLKuRWbYHEnIZhv+rjYWFF6gOKS8PZWljIcT7EWmRQN986QtjfwSszOH3yMa
 6GhQbwuU2HMZKgaYbUzWiC4qj8CxSN8JNbDSr7IVt4omf5ewkKtkcNYMNcJsD2aB2yf+
 qJzYZIazfkAvlxnljXr+p7ds8LhZWy3DZBhFTBYOl2hcAeikd5CGxoFhCvknuLLpjA3A
 mr02LeJXqoLgrWo48pUWFO+M9/WMVlb7CcE9H8fDY9+S67slj7rtfzOjKsXa/2iBv2Ag
 sDrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737249159; x=1737853959;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yaTS6py126U4BbD4RQuuk4UG2ehBqDT81irsaHxix9k=;
 b=EWm3GVdzwcKtKMWaU1YSOHg/QnVfJsAX/gR+Wrfrdp5IA19jZgO6G7y3or4ODftHtJ
 gxQYqnGfXBPQsZZRnWbU6p5Hg6al/tWG72Gu1banmobcShhfts6OBVQoeHPmikseq4wL
 05adDtLpZNj3cre9ngaVy+zxW4M8q+gYrnMjTB7pmMkcc58AQi88JfQ2IUrhcnTqq++O
 7vZhR6WdOkFJ6BPwnbPqgv0E7moOcBxCBCffhzsHNfWyi+QPHxbEvAamIrgtedIwKoZH
 y2pWM5qUv5F7vEBnKJYlyaV2DC5xq89mkMzSBvjLgt2tBvqwp2lIrrE9yF3AXUN2rAs8
 KIkQ==
X-Gm-Message-State: AOJu0YzV3BhFcl2Nf42BLD/hpGkGnpPrz6PKWicBEoapZ/xUKweH9riA
 FuQWUgnX4xaOkZlmZgEeHiK8ughCcE2P+JKDPns+lNwgSzYfqzkIqNYquQaV
X-Gm-Gg: ASbGncszfMX6vK77GlD4ixZhkqol+MkStPNJ2bBPNcWCgEjGizJkwcv/y8Y/E20Zr+7
 yXvaohIZikwkPZIAYi3qmQUDmzRDo6eJOPPeejSYonukfvPMVQRG4+u9C55IrHUH73/JPX+ugSl
 p0JEqU9ApnnHGMz1Y0QtvL3X5Sg3ANIvgmkubhJz6zzusr377/EE+eIfOJO+f2sXCyOZuswu1gh
 9/UELKyKiyqTv1LgyvrIzAlOmRz2LOpyBiV4/JRFSN2Kr05zrD/aiEXFIFDYKk3S4IVG3lq+DcB
 AnvG5LEoOzcQbZwGEvMWjJMWpSAIgteTIpYSTydbX1SeuM4EaQpUCxkqD/xoevv+oGWQhkZ4Eg=
 =
X-Google-Smtp-Source: AGHT+IGNtfaRdDLhRfAuoPkLcNbg5V7zZoZ8Hxm5R/90W2UqsYkwA9xTkGGh5NEOGoNNfEaLa7v9cA==
X-Received: by 2002:a17:90b:3a08:b0:2ee:c291:765a with SMTP id
 98e67ed59e1d1-2f782c8f352mr11972822a91.8.1737249159167; 
 Sat, 18 Jan 2025 17:12:39 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f776185b02sm4760314a91.21.2025.01.18.17.12.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Jan 2025 17:12:38 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Craig Blackmore <craig.blackmore@embecosm.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Max Chou <max.chou@sifive.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 01/50] target/riscv: rvv: fix typo in vext continuous ldst
 function names
Date: Sun, 19 Jan 2025 11:11:36 +1000
Message-ID: <20250119011225.11452-2-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250119011225.11452-1-alistair.francis@wdc.com>
References: <20250119011225.11452-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x1031.google.com
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

From: Craig Blackmore <craig.blackmore@embecosm.com>

Replace `continus` with `continuous`.

Signed-off-by: Craig Blackmore <craig.blackmore@embecosm.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Max Chou <max.chou@sifive.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20241218142353.1027938-2-craig.blackmore@embecosm.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/vector_helper.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index a85dd1d200..0f57e48cc5 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -195,7 +195,7 @@ GEN_VEXT_ST_ELEM(ste_w, uint32_t, H4, stl)
 GEN_VEXT_ST_ELEM(ste_d, uint64_t, H8, stq)
 
 static inline QEMU_ALWAYS_INLINE void
-vext_continus_ldst_tlb(CPURISCVState *env, vext_ldst_elem_fn_tlb *ldst_tlb,
+vext_continuous_ldst_tlb(CPURISCVState *env, vext_ldst_elem_fn_tlb *ldst_tlb,
                        void *vd, uint32_t evl, target_ulong addr,
                        uint32_t reg_start, uintptr_t ra, uint32_t esz,
                        bool is_load)
@@ -207,7 +207,7 @@ vext_continus_ldst_tlb(CPURISCVState *env, vext_ldst_elem_fn_tlb *ldst_tlb,
 }
 
 static inline QEMU_ALWAYS_INLINE void
-vext_continus_ldst_host(CPURISCVState *env, vext_ldst_elem_fn_host *ldst_host,
+vext_continuous_ldst_host(CPURISCVState *env, vext_ldst_elem_fn_host *ldst_host,
                         void *vd, uint32_t evl, uint32_t reg_start, void *host,
                         uint32_t esz, bool is_load)
 {
@@ -342,8 +342,8 @@ vext_page_ldst_us(CPURISCVState *env, void *vd, target_ulong addr,
 
     if (flags == 0) {
         if (nf == 1) {
-            vext_continus_ldst_host(env, ldst_host, vd, evl, env->vstart, host,
-                                    esz, is_load);
+            vext_continuous_ldst_host(env, ldst_host, vd, evl, env->vstart,
+                                      host, esz, is_load);
         } else {
             for (i = env->vstart; i < evl; ++i) {
                 k = 0;
@@ -357,7 +357,7 @@ vext_page_ldst_us(CPURISCVState *env, void *vd, target_ulong addr,
         env->vstart += elems;
     } else {
         if (nf == 1) {
-            vext_continus_ldst_tlb(env, ldst_tlb, vd, evl, addr, env->vstart,
+            vext_continuous_ldst_tlb(env, ldst_tlb, vd, evl, addr, env->vstart,
                                    ra, esz, is_load);
         } else {
             /* load bytes from guest memory */
-- 
2.48.1


