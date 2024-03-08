Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 108D9C5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 21:56:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riiB1-0007gx-Dq; Fri, 08 Mar 2024 16:54:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1riiB0-0007gV-At
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 16:54:50 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1riiAy-0001pM-Rx
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 16:54:50 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1dc09556599so22257995ad.1
 for <qemu-devel@nongnu.org>; Fri, 08 Mar 2024 13:54:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1709934887; x=1710539687; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vqdrEu+JdpuCyxKRmCNFt9jzGsTG0D7Mm4+hNkdQdMw=;
 b=j8kyjFXOb2kIc/xbO4XNA3eO4jzbfhgmb28CAoRqelEtT1RUtLYvKzjvWKI5UuEQs4
 ZeCeVS3++/2ko6QuByFBUsxsyD6vqF7vNWZiz9FS4W0GRl+fHqENGKJL0dQyTFKWw4os
 hMhyolNyiexbBWvgehxRYH+3FwHux3GF3kKP6RwvX79GES18JKZjUh0BH1M0GRY51bU2
 lsGvTsW/1lFsG2aV0955RIo7saKpBue9ETN6iWrqthuKc6CEcdSVigseWtAD44+uKgne
 SsPYdKtmAccxClL/gctuRtfu5dua17ygNOKNfPFqHyhaRP1chgJ9nUwujVIRx6sqDPR+
 IL8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709934887; x=1710539687;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vqdrEu+JdpuCyxKRmCNFt9jzGsTG0D7Mm4+hNkdQdMw=;
 b=C/xb5jWmRZdSHBqDIDmWcmsz2sfZSmZS+CoZwAVwi5Z4qb49Tlz5V+yrPGpjQta2Gl
 +spdwNA8eSXoy8JNfMW1N7O77LsFX5gZsLGYXWEp4LkVkf+r1e4qayD5iJdPTR3VGKJb
 WnH7m5TRfcv1kRuqN5Rg/GCtdqvsl8XfbABlWzez0W2azk6WNJ9f0G9UckgAvJ9NDV68
 0rUkiAuV22kkPfkyD1G6cN4Dlph/Fi2Vxpu0EkWJAIDiJjAJSFHRHhUdxOSP+Bi/3EUZ
 l1BTYzI/u06oouSmkfseUXSbqOq9pUjBEHd9Npj5YWuKRkQCTQrm2ZWdwUqxJEBURZjs
 Qpdw==
X-Gm-Message-State: AOJu0YxamSPQ2eGcLMlURlUi4nsfyWHQ+r9VSd6BIzfnzDyM6IEwvA3+
 TZahi9WF/tSmKXQ6ZreGOjvvAqTxmbT/gOdsP0Khr90cxl7WUMjJsOyNmhyFgVbP4Uan4a1lXly
 U
X-Google-Smtp-Source: AGHT+IG1VeGv6gNKTA5/DkiD04JdE4ivV0RGgHvxk7pdlvehSFL+SHAw4amq1HYO8KaGWvX2oydYkw==
X-Received: by 2002:a17:902:f688:b0:1dd:75c6:fab9 with SMTP id
 l8-20020a170902f68800b001dd75c6fab9mr508973plg.3.1709934886752; 
 Fri, 08 Mar 2024 13:54:46 -0800 (PST)
Received: from grind.. ([177.94.15.159]) by smtp.gmail.com with ESMTPSA id
 d3-20020a170902b70300b001dd66e6ec91sm107702pls.140.2024.03.08.13.54.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Mar 2024 13:54:46 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 richard.henderson@linaro.org, philmd@linaro.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v8 10/10] target/riscv/vector_helper.c: optimize loops in ldst
 helpers
Date: Fri,  8 Mar 2024 18:53:50 -0300
Message-ID: <20240308215402.117405-11-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240308215402.117405-1-dbarboza@ventanamicro.com>
References: <20240308215402.117405-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x62e.google.com
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
index 1941c0e5f3..2e50341806 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -190,7 +190,7 @@ vext_ldst_stride(void *vd, void *v0, target_ulong base,
     uint32_t esz = 1 << log2_esz;
     uint32_t vma = vext_vma(desc);
 
-    for (i = env->vstart; i < env->vl; i++, env->vstart++) {
+    for (i = env->vstart; i < env->vl; env->vstart = ++i) {
         k = 0;
         while (k < nf) {
             if (!vm && !vext_elem_mask(v0, i)) {
@@ -255,7 +255,7 @@ vext_ldst_us(void *vd, target_ulong base, CPURISCVState *env, uint32_t desc,
     uint32_t esz = 1 << log2_esz;
 
     /* load bytes from guest memory */
-    for (i = env->vstart; i < evl; i++, env->vstart++) {
+    for (i = env->vstart; i < evl; env->vstart = ++i) {
         k = 0;
         while (k < nf) {
             target_ulong addr = base + ((i * nf + k) << log2_esz);
@@ -368,7 +368,7 @@ vext_ldst_index(void *vd, void *v0, target_ulong base,
     uint32_t vma = vext_vma(desc);
 
     /* load bytes from guest memory */
-    for (i = env->vstart; i < env->vl; i++, env->vstart++) {
+    for (i = env->vstart; i < env->vl; env->vstart = ++i) {
         k = 0;
         while (k < nf) {
             if (!vm && !vext_elem_mask(v0, i)) {
-- 
2.43.2


