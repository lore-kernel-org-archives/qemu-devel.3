Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA763CD4F35
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2026 07:44:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wN4Ft-0006ds-AE; Wed, 13 May 2026 03:43:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wN4Fo-0006dQ-9l
 for qemu-devel@nongnu.org; Wed, 13 May 2026 03:43:40 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wN4Fj-0001dk-Mq
 for qemu-devel@nongnu.org; Wed, 13 May 2026 03:43:37 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-488ab2db91aso69252415e9.3
 for <qemu-devel@nongnu.org>; Wed, 13 May 2026 00:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778658212; x=1779263012; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3iOGX1/yVXUGiky37h9jQxUvbyutlaP7Ae4GonUwahs=;
 b=jchb5kW+7xsw3JrJhtdwpww6SRu6HbvEdyRvKA9VX26nDpgVLfh4QO/2oev+WUyXAv
 I/5nzFpWj4NPvqi8W+zeEN17KLG4iBmegRLalgYgtWtVBSHnySyn3Qa9KoTQu5I3oKrB
 RF2OLGuyvydB584+mYj1Tjs7ds1NxYfAdLzqPC95rxXLelQ9Elan/RX9ogvo+5bh6h9/
 qOZpi6oZ+OBYFk4krktkBg36YTNIY82ibOdIgn+y0xECJcb4N6e9ax6XzCLGWehRzMjQ
 WEHBl+c3hJB+mZfwtQpo00Ohy5BuT9dRl2YGdbJskPKho9FbBBMzxHYJCL/rk0U3NueO
 XaRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778658212; x=1779263012;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3iOGX1/yVXUGiky37h9jQxUvbyutlaP7Ae4GonUwahs=;
 b=gRRJELu+PdS5QNS+3eK153/9jWMJLlqBx0pgTPpX+mvgrgSsksBGgcMY7Py0Z5EuWQ
 lndM1AfEqgWCLxuISIH2f8ATchdmigVSbbrhRold+dwcu35ji4MCK+VUBZ3J7UzJnBW4
 W/ghc7zdV1JPoNb/HtL0/cVrhxMVR6w10d+PdmyAxGzmp65LyIWaGiLQc0M1URleBPFd
 nf8+ubhbylgXq8pVorqRQwp5e+xvijYr/BM8TAOsIu2qC/TT0CKC7nK14/z3YeAuvMO7
 CL+WM7hmyAUw5RdXq4oHFOQF89pG31YmDhvocsQoXMk/YMDf2Y6Pvxfd8PRcw26sNu5C
 O3ZA==
X-Gm-Message-State: AOJu0Ywm0/T/2TI7mQOExH6p+48GVqE1yZ2uUcnn+sbCHvB3WplvdWuo
 cljmuyxyU8Bf5YASwklc5lsvMsfL0Xju4Cr4cHZszKBjUdDqIBm7UprEKsgv91+N+WkLSN3QB5y
 5nAOnge4=
X-Gm-Gg: Acq92OFU+tcACsapGar5OYCOkAahOpzNEaTqFTZ4+jpnhXdcDQwnJ7EhK6542qHRj27
 W0vyd2szddKfAtauAtFuOBj4Fy8pwxl9Z55UulL6orj+gsTg+lWqQkYuomTjpuOosslbbabKeVk
 wPpgIzZc/vF9F9rXH6UG2vQn85cjFzYgzr6TEVN2zR+d2JI0N0RrCPs9NWXMIB5oUokrd5htaFh
 k94YQ9ld7iQa22uWD2L88o6lEl4BzeOZdwovBrwjnJfW0VGHlyEimp8R/EbFZ8reQM6AeG+UHHK
 JNmYQ7W8jCSJOihoBcRF2OlK481rDX5NluNIUcYoRhBpDoKPC3IT9GDUNp0ehwQIW04RF3LHmAw
 /rC+wGNAik1z6LVA/xAEBN1OUgX6Hlh01VEGTIWkxntAroErozL1sknl2ETDrFI5NX6pcv3M+wK
 NY9xSelRuW742dQFl9AU7o28Q3T1W/HNHOG8SCpW3pIGunsrGFtpp9MmNARhPKMkm3z2E3RwsB
X-Received: by 2002:a05:600c:c87:b0:48a:58ae:992f with SMTP id
 5b1f17b1804b1-48fce9d92b0mr20565265e9.16.1778658211909; 
 Wed, 13 May 2026 00:43:31 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fc8d62422sm60249665e9.11.2026.05.13.00.43.31
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 13 May 2026 00:43:31 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 1/2] target/hppa: Use DisasContext::mo_align in system
 emulation
Date: Wed, 13 May 2026 09:43:22 +0200
Message-ID: <20260513074323.10616-2-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260513074323.10616-1-philmd@linaro.org>
References: <20260513074323.10616-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

Rename 'unalign' as 'mo_align' and use it in system emulation too.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/hppa/translate.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index cf57ec518d4..c3d1027b4e2 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -91,16 +91,14 @@ typedef struct DisasContext {
     bool is_pa20;
     bool insn_start_updated;
 
-#ifdef CONFIG_USER_ONLY
-    MemOp unalign;
-#endif
+    MemOp mo_align;
 } DisasContext;
 
 #ifdef CONFIG_USER_ONLY
-#define UNALIGN(C)       (C)->unalign
+#define UNALIGN(C)       (C)->mo_align
 #define MMU_DISABLED(C)  false
 #else
-#define UNALIGN(C)       MO_ALIGN
+#define UNALIGN(C)       (C)->mo_align
 #define MMU_DISABLED(C)  MMU_IDX_MMU_DISABLED((C)->mmu_idx)
 #endif
 
@@ -4654,12 +4652,13 @@ static void hppa_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
 #ifdef CONFIG_USER_ONLY
     ctx->privilege = PRIV_USER;
     ctx->mmu_idx = MMU_USER_IDX;
-    ctx->unalign = (ctx->tb_flags & TB_FLAG_UNALIGN ? MO_UNALN : MO_ALIGN);
+    ctx->mo_align = (ctx->tb_flags & TB_FLAG_UNALIGN) ? MO_UNALN : MO_ALIGN;
 #else
     ctx->privilege = (ctx->tb_flags >> TB_FLAG_PRIV_SHIFT) & 3;
     ctx->mmu_idx = (ctx->tb_flags & PSW_D
                     ? PRIV_P_TO_MMU_IDX(ctx->privilege, ctx->tb_flags & PSW_P)
                     : ctx->tb_flags & PSW_W ? MMU_ABS_W_IDX : MMU_ABS_IDX);
+    ctx->mo_align = MO_ALIGN;
 #endif
 
     cs_base = ctx->base.tb->cs_base;
-- 
2.53.0


