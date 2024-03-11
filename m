Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2340CC54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 14:02:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjgBx-0005NK-AA; Mon, 11 Mar 2024 09:59:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rjgBg-0005Go-RM
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 09:59:34 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rjgBf-0003hK-1M
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 09:59:32 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-6e6277f72d8so2856987b3a.1
 for <qemu-devel@nongnu.org>; Mon, 11 Mar 2024 06:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1710165568; x=1710770368; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6ixFEPVp8c6KmG9HvM9JwOcRXeyd4JQRHbHvx2xyG7g=;
 b=K2b9LVFJH3rcCXtpSznVmXRiSMNT7+QdGESh4KMcVZmNEssFGs/3hbC3Mh2wuhudiP
 h2QJDNKGY+uq3CbnlrmzaoTB+Z3S4keGUCF7QhusT8vAwrNqLOwdcugIi4OGlWPQtbx0
 HxNAV13skK6/VBawtLHjfH/sU6iy0SwwaFZEv7a3jafZFfwMJ1JMMont2OKahAagP8Gs
 rz94zLvn/246CKLZIn+ilBsoFI4nbPvRKc09DpOBUenKlKPyVEYm9u4TXQIJyK0cOG9H
 eDgIvjKjXZG0kzBy3G01q7Tf8GlQa6Sck78GCxXrRSIK888NGRd68o+ciDedQS7q4O4m
 D0Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710165568; x=1710770368;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6ixFEPVp8c6KmG9HvM9JwOcRXeyd4JQRHbHvx2xyG7g=;
 b=TUHmLUSMZFoJyPXNS36muv9di/fYXB4Kp8RgyfCRHs77Lnh7T9u+5yT7SfYELY7pU2
 t96N8R+r0sm330CzSF24kCj0KkyF0TJ55F3R+bFVtAvn2l8mHUmRHn4LLTdnaYeqz2AK
 SEEi6cNgXIHMNWlAygAyaO6q6zEOXPRI8qEm3/zadJNOhxrE4Asv58sNDasGpVG30Mho
 7DcdBV+r9sH/ARxbNluxwPnL+COow/tnjFgrWwh/WgcOw14AWea2KcBcpTRVsO3hRDmi
 I3A+Zi0STa0S/9czzeKpeinbv7mfXgUr2Mi9saXQrT8QBARJPba+xp0JKWFaRUS+0H0f
 4KhA==
X-Gm-Message-State: AOJu0YyD3yqG2Al55K0dbHDSy7nDeWBBlV0qMRShe2kcwQ76Fwl7yn0z
 1bxdIKrPBgNA6cTdKJfgHWk+8bpGQ+N0OMybEUdr89DLyVG+U8oihJ3V47Xt0cfCuQZlw9lYKki
 t
X-Google-Smtp-Source: AGHT+IHtVS5JaezrtmJlYOiXcyFJnGx7ob7Zhh+bepB7GsJO9jEz8oKCRNXYHEpRh9PhQeY3SNLJRg==
X-Received: by 2002:a05:6a20:8411:b0:1a0:f3d0:15af with SMTP id
 c17-20020a056a20841100b001a0f3d015afmr4244586pzd.34.1710165567721; 
 Mon, 11 Mar 2024 06:59:27 -0700 (PDT)
Received: from grind.. ([177.94.15.159]) by smtp.gmail.com with ESMTPSA id
 nm3-20020a17090b19c300b0029c12fa64b9sm1324920pjb.4.2024.03.11.06.59.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Mar 2024 06:59:27 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 richard.henderson@linaro.org, philmd@linaro.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v11 7/7] target/riscv/vector_helper.c: optimize loops in ldst
 helpers
Date: Mon, 11 Mar 2024 10:58:55 -0300
Message-ID: <20240311135855.225578-8-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240311135855.225578-1-dbarboza@ventanamicro.com>
References: <20240311135855.225578-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x42e.google.com
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
index b4360dbd52..712a2ee4dd 100644
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


