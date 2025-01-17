Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B6BAC02183
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 06:05:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYfL0-0004cE-Uq; Fri, 17 Jan 2025 00:56:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tYfKz-0004c1-9X
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 00:56:09 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tYfKx-0005sz-Jo
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 00:56:09 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-218c8aca5f1so42062355ad.0
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2025 21:56:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737093366; x=1737698166; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uedKBcnXSpud33OwbKbFByWq7chPSjJFEr8H92X9P1k=;
 b=BEtIkbC9KzKcayQlDqXBAP/Kjk3ZDrvvm0bW40MWmAkGGEbnqiL8L8iXdpXzzD83zv
 dxyEqLyUL2szOSTOwhIB2n+spmcPAvh83O+VDHrsekm6C01IyK9pvWgsOoyE4Jbdw1el
 laws7+/9f0SOxxK3EwyHikh3uTIDlp0aWf6+7HK9RzVL0bxYzkWMW9C3IDcWxSwunPZU
 nxwyJFEod9g3ZFetCntQc7Zimt0xfhP9UOXknGJTVrKSkKggZA6vsf3uX2EOFZUUj7Vl
 F/GlQX/DANDTyeaw3RgWNa/x4YpWQu2n8AQ9cGuV1IpFFM3HgZeW3TTrVrWL5VdHgPvp
 PLtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737093366; x=1737698166;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uedKBcnXSpud33OwbKbFByWq7chPSjJFEr8H92X9P1k=;
 b=uUgvz80HWGkWignQYhyMH/hpUKFlJMlgeuw2SwT7yxZH02ZkUFFdVy1tZ9HQ0OnsMc
 obSs98nf1I9QMiUTu9M0+Xyw8BDb5So6Fvc+Eh9X7SCBaJcaigmXnqQmbuxHkZKnV14B
 T20Ri9SESEWVSD2dlEBNAChdNMKWPPx6HlGC1hVMQkUaMH3kiWPDj2GRe/5BLA2/ywU3
 Qc95VFFSJEOPM0xfxDpEIYembuQaxo7L13XhG5WMdRk0PdvPirY/GwY4CYVapLETLmGi
 atwnbtgBDBzH9IVy1HeagVXw4YXgOBPhEYiUSszNV84ksPdmo2LjmtLTy5fb0bZrZIdQ
 gv3A==
X-Gm-Message-State: AOJu0YwCdwihjiOSy5Nmwa5iA7avbSStI/eiS+up2YQWWfY5jH3gqOTI
 dB/AZRwvIgBcX6lcLJIYHFXlPKh7pwkpr72hFziyM2LPLe0WO4xxMqCk/Q==
X-Gm-Gg: ASbGncshNpV7KHz+x/QpmUlNTztYrY7g6m8r1LG0BuQC71iycOMvgHtgjqAZ0Igqi1X
 zu7axxlpdDTlAwce3aaOyLtL+HiUtKsKvPgLuX4z8ALXexZd2m6TxSV+M2uBKmktQCu2p+dtBQP
 aR6GfO4Ov98132wH4rn3KMwyxyC1oWazg7tMg+uPxdCuftKxf/e4c8H1FiWfQtWZg15bYwVX27Q
 ZpWJ6qMs/0CMsaqLVFyZ24o0qkVzDRFOqDBU+vabIyHt86o7Mlvzd86paq/qKMCsspyD+/Nk24l
 vZLs1xJDGCLSmU8Wbd59ib8/I8RI3NC8iFgzFV2R3ipea69o2Gomu3XfTXx2
X-Google-Smtp-Source: AGHT+IFiB3Iwg+CYH4CSmAkbU68eghEG91SIVFtP4KUU93HVN17cezZud+S+QZmHTevhGK1b2Yd2gQ==
X-Received: by 2002:a17:902:7c0d:b0:216:356b:2685 with SMTP id
 d9443c01a7336-21c353ef7a8mr17733935ad.11.1737093365979; 
 Thu, 16 Jan 2025 21:56:05 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21c2d3d6fbbsm8563595ad.168.2025.01.16.21.56.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jan 2025 21:56:05 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Craig Blackmore <craig.blackmore@embecosm.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Max Chou <max.chou@sifive.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 01/50] target/riscv: rvv: fix typo in vext continuous ldst
 function names
Date: Fri, 17 Jan 2025 15:55:03 +1000
Message-ID: <20250117055552.108376-2-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250117055552.108376-1-alistair.francis@wdc.com>
References: <20250117055552.108376-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x633.google.com
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
2.47.1


