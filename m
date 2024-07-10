Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E91FC41513
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2024 03:31:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRO0d-0001E1-OM; Tue, 09 Jul 2024 23:28:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sRO0Z-0000xP-SV
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 23:28:43 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sRO0K-0003n5-Jp
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 23:28:43 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-70aec66c936so4113751b3a.0
 for <qemu-devel@nongnu.org>; Tue, 09 Jul 2024 20:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720582105; x=1721186905; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q2ROPOTsOZR6XgFa32G2l+m6EsgEMNZclNZBvV6yeOg=;
 b=WelwTHQrBKJCZ7mD4FflzdLlXczc9T96H+bEVRqns4Ovded2fFekoyhknDRa7R+oYW
 gIZ+ylRkuJK4+kyCGt4ncSZzHnTbz4CmOUVDb6DKs51qbqq5eNbxGssHLI1UBtRQq8AA
 clkorqqMe0oRBrOkEqOdDSmkxSWaUpFfY3n6V3gFLoNKhAc/JKLsu+IP7PchuwGuYmDa
 12RRWP/IYn/px3tk3gDYcSP/FP5b4Qjlej52g/cQKF0e3DfdVOIOcbx6KCtgshjzm4qm
 qwwdQ0o97OzVTiS4BIYJBnxfBCxswAiMO0jVPbwhl2tzJI6/pxKyvlaiGqv2PoPNKPXo
 ekGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720582105; x=1721186905;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Q2ROPOTsOZR6XgFa32G2l+m6EsgEMNZclNZBvV6yeOg=;
 b=AFAQI6KEpOAafKIlTcV/hiQJubVpYN0XRivg3lIKyIGMmx9nI+oUgyL5Vkh0KawYqC
 lF+6fXTyjQapLj1e5aWgWpttMXhMmwv9+GeZelBvvOvuKjqpz0a4/rS5iJ3I0lzFVBVs
 W0gd0FFx4cha2LcWVlZJMn/5tu5Ca6U/gEsoQSLZbITpeFievko6TVtMuVlfbYgVYVc+
 fWYa0k8seF9wCqnKC8gudDS3hVDkxXNma8nxGLrTSmTRHKCJlQsUueVBY+k0vC5COUyk
 stO/raAB35nAtLyxnC4xmvcALYp+f/yB8/5tMKU0UhWVNzNcxspc1XjIvUMjC87XnJeY
 f6XA==
X-Gm-Message-State: AOJu0Yxaa/EURNP7jyD8FSe6WeXB7P0qScsSHKX9Klav7Lf1tp05Pq46
 rz5kYVOZyNt9tZtNXcxc2+lXgBV2wo4I0nvdkY8WhpnTnBkA/VclRPp4uOyFpvVf5u7LBZQhR1P
 LMM0=
X-Google-Smtp-Source: AGHT+IG+in3GLvVs2R+GN0G5h8RGXmFxzz8gj4xs5zKY+OX6ABZwS05mPla7EqK8jsYJeo/yN3B4pQ==
X-Received: by 2002:a05:6a00:9285:b0:704:32dc:c4e4 with SMTP id
 d2e1a72fcca58-70b4351f97bmr5273776b3a.1.1720582104861; 
 Tue, 09 Jul 2024 20:28:24 -0700 (PDT)
Received: from stoup.. (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70b438f5679sm2687280b3a.90.2024.07.09.20.28.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jul 2024 20:28:24 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongu.org, qemu-s390x@nongnu.org,
 qemu-riscv@nongnu.org, balaton@eik.bme.hu, max.chou@sifive.com
Subject: [PATCH v2 09/13] target/ppc: Improve helper_dcbz for user-only
Date: Tue,  9 Jul 2024 20:28:10 -0700
Message-ID: <20240710032814.104643-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240710032814.104643-1-richard.henderson@linaro.org>
References: <20240710032814.104643-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 SUSPICIOUS_RECIPS=2.51 autolearn=no autolearn_force=no
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

Mark the reserve_addr check unlikely.  Use tlb_vaddr_to_host
instead of probe_write, relying on the memset itself to test
for page writability.  Use set/clear_helper_retaddr so that
we can properly unwind on segfault.

With this, a trivial loop around guest memset will spend
nearly 50% of runtime within helper_dcbz and host memset.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/ppc/mem_helper.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/target/ppc/mem_helper.c b/target/ppc/mem_helper.c
index 24bae3b80c..fa4c4f9fa9 100644
--- a/target/ppc/mem_helper.c
+++ b/target/ppc/mem_helper.c
@@ -280,20 +280,26 @@ static void dcbz_common(CPUPPCState *env, target_ulong addr,
     addr &= mask;
 
     /* Check reservation */
-    if ((env->reserve_addr & mask) == addr)  {
+    if (unlikely((env->reserve_addr & mask) == addr))  {
         env->reserve_addr = (target_ulong)-1ULL;
     }
 
     /* Try fast path translate */
+#ifdef CONFIG_USER_ONLY
+    haddr = tlb_vaddr_to_host(env, addr, MMU_DATA_STORE, mmu_idx);
+#else
     haddr = probe_write(env, addr, dcbz_size, mmu_idx, retaddr);
-    if (haddr) {
-        memset(haddr, 0, dcbz_size);
-    } else {
+    if (unlikely(!haddr)) {
         /* Slow path */
         for (int i = 0; i < dcbz_size; i += 8) {
             cpu_stq_mmuidx_ra(env, addr + i, 0, mmu_idx, retaddr);
         }
     }
+#endif
+
+    set_helper_retaddr(retaddr);
+    memset(haddr, 0, dcbz_size);
+    clear_helper_retaddr();
 }
 
 void helper_dcbz(CPUPPCState *env, target_ulong addr, int mmu_idx)
-- 
2.43.0


