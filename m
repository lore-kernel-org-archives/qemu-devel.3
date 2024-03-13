Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E326BC54E66
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 19:32:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkUKK-0007I5-JT; Wed, 13 Mar 2024 15:31:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rkUK8-0006xO-KX
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 15:31:44 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rkUK6-0002TX-SA
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 15:31:36 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-6e6adc557b6so262917b3a.2
 for <qemu-devel@nongnu.org>; Wed, 13 Mar 2024 12:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1710358292; x=1710963092; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dQxZomeoNn9i8QHNEyNqDc/x9f1sWSuEH/Pg+YiDFJs=;
 b=Lh1hCjNRKlM3JWhIhH15gG3iRWX3+JFCiW4n5kFAccOsYg1hBjgpVNz/0iASjBUYGq
 H8BL2+R04dVXL/mme2iEwBmM0NzoY4nw5ZvjF1QF3EqsKT2nNgT5Tzej2o9atOBwffBl
 JN1qdzzF/4ZFvUtEVWwCrX1zufi8w+pMftc1Mwhth8EHCag+g33bWWprpD/LEqRWc2nv
 T/FKaxEzHegipFkelKcGfDlRodBr+UARciY00Zz9z/l23A7CR82lV3wrNS3MYHCEP0rm
 MbeGFXEbaa/XeHrfO9FQUn0/jhagzfgacGAoclJERO6gFMcpIhPRywjooBoT2oLLuFDE
 bBwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710358292; x=1710963092;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dQxZomeoNn9i8QHNEyNqDc/x9f1sWSuEH/Pg+YiDFJs=;
 b=P6uFbNQLToZ2PIgBRsq9NoCjT6eyhCKXZjM3ixeyzGj8VczIAM8YYD21hsBN4+PLbq
 leSppSHuKB6gJpjuqdjJWVb1g0iiFRcWY5lgHGM5ZCKMFvxyHdb+Tuf6gIZ35S5VjMVA
 FjpOjgvK9mBosfCsxSXZ+FhcKrTnGhVZ9IPgxqj5iHtg8ET/PAockhaMbtH1UnypwB76
 flMbiOPKKQMJEJx4HK0/INGPbTTuSFnfSaF5t6/sUe6E7JPZvQRW9NPWN+bSea72ZU0T
 +irPVzpGeGPdvijxro071CjuIOzitKcT0IxtQ0ch+o4PuIfwXksrSpzzlXemeqwX0tV9
 bxBQ==
X-Gm-Message-State: AOJu0YzPc8uv4eDg+SNtpSuBxQfu5Luysa/8r7QK7apCm4OQPImpGu2s
 +OlN4aWF5ue/ryz6VHIzT6bDRA3O8dVnbKTre5jIxSVy9eX/jP8VkvNGwZjRcHCMg0Uc0mEwv4x
 r
X-Google-Smtp-Source: AGHT+IF2IX4GlWL8B//geHu6J/3ylLHGbQPkKJgNj0PnC8OacyeZ0YJWzqR6qpytVWYSCktvcZN47g==
X-Received: by 2002:a05:6a20:d90b:b0:1a2:a596:4dce with SMTP id
 jd11-20020a056a20d90b00b001a2a5964dcemr3971976pzb.58.1710358292105; 
 Wed, 13 Mar 2024 12:31:32 -0700 (PDT)
Received: from grind.dc1.ventanamicro.com ([177.94.15.159])
 by smtp.gmail.com with ESMTPSA id
 k10-20020a628e0a000000b006e5a915a9e7sm8912421pfe.10.2024.03.13.12.31.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Mar 2024 12:31:31 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 richard.henderson@linaro.org, philmd@linaro.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH for-9.0 v13 8/8] target/riscv/vector_helper.c: optimize loops
 in ldst helpers
Date: Wed, 13 Mar 2024 16:30:59 -0300
Message-ID: <20240313193059.405329-9-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240313193059.405329-1-dbarboza@ventanamicro.com>
References: <20240313193059.405329-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Change the for loops in ldst helpers to do a single increment in the
counter, and assign it env->vstart, to avoid re-reading from vstart
every time.

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/riscv/vector_helper.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 7260a5972b..b29b8f9116 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -209,7 +209,7 @@ vext_ldst_stride(void *vd, void *v0, target_ulong base,
 
     VSTART_CHECK_EARLY_EXIT(env);
 
-    for (i = env->vstart; i < env->vl; i++, env->vstart++) {
+    for (i = env->vstart; i < env->vl; env->vstart = ++i) {
         k = 0;
         while (k < nf) {
             if (!vm && !vext_elem_mask(v0, i)) {
@@ -277,7 +277,7 @@ vext_ldst_us(void *vd, target_ulong base, CPURISCVState *env, uint32_t desc,
     VSTART_CHECK_EARLY_EXIT(env);
 
     /* load bytes from guest memory */
-    for (i = env->vstart; i < evl; i++, env->vstart++) {
+    for (i = env->vstart; i < evl; env->vstart = ++i) {
         k = 0;
         while (k < nf) {
             target_ulong addr = base + ((i * nf + k) << log2_esz);
@@ -393,7 +393,7 @@ vext_ldst_index(void *vd, void *v0, target_ulong base,
     VSTART_CHECK_EARLY_EXIT(env);
 
     /* load bytes from guest memory */
-    for (i = env->vstart; i < env->vl; i++, env->vstart++) {
+    for (i = env->vstart; i < env->vl; env->vstart = ++i) {
         k = 0;
         while (k < nf) {
             if (!vm && !vext_elem_mask(v0, i)) {
-- 
2.43.2


