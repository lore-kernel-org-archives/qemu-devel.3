Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17F6AC3DA63
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 20:41:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWMHv-0003IU-3A; Tue, 23 Jul 2024 16:39:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sWMHr-0003HS-V6
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 16:39:08 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sWMHq-0003un-9s
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 16:39:07 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4277a5ed48bso44882085e9.2
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 13:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721767144; x=1722371944; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sVpySpyrjhMtcWBGxVtjyNF2MUS6wyprjn1PN1O1F+w=;
 b=aT+LAzluqB7+nCIMVw4o7j9fOk36aFCuzlxdVIbf+DA+y11sEAl8/7GFQrgSNj6eDF
 8I6vUEHxE2v3YpzIo5xD9vu56ernbBJ93AkA0UU9qNwe3cTYVyLhxY+OdGb/66Ar+3vj
 pasLf1iK8fVUsIZj9WOHNRKrfbkEyYECzO0y3AaFPslLzgX6MVvr1goPrg9iOuG2tRpp
 kJk3zS9gY9GGIYOzpBYOc2RSJriJzpc2BwUKhXzHwRYbaVwxUrJRVUjy/ERTlXxBADCz
 qOWcI1LjRFwKtLSJzV64zeVnXfUaqNLYFLqJ5kYPEcq5Q/Th3jR5IFKiCeJ/9qAbNSf4
 Y3RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721767144; x=1722371944;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sVpySpyrjhMtcWBGxVtjyNF2MUS6wyprjn1PN1O1F+w=;
 b=lI5e8sRHtgWEPOx9lfndxRm42GsSAsauatGN1opavkJQlquFTmL8EoZ9AgS9d9R3tQ
 g0umCQLwzbJPtHnAfPYYK4wCVYF37HCnVt3oGtEpofhop+TY4xMm7cr+MrHPVOgJMcGb
 t4xCNboE6R91VA/ksxFmXVwGBxeChmEIMDqP3yWUAjTGQLkgRqzukCY37Z/c/tWsaSO+
 RqSt1nPDmaaKJ1FgOzC+bhPdUsmphLY8xcNOv3o2WJcbNzNhJ+sGIgHJY88+jFTVVdHL
 SOltvnCfgO2Hyr6U33PdKPdQN1y9cPIMEEdBK8uZ7KiKQ7A3i+fy1ySkpe0hBC4IIed+
 6Qdg==
X-Gm-Message-State: AOJu0Yyc9+73fXocfIgw7mq9WRgNcKu/LczNbxbkCDLXwCZhXwg+5TrB
 leiZx20ut28gv2g/FiRoFAKeH/qx8ftUaWOiEEXFrMqL7FewwM3MkcosE5099+S43+/MobO67gs
 mjhs=
X-Google-Smtp-Source: AGHT+IGI0VXaOZnQDIADJZ/nJrjJPvXOn4YNqkpnolIPyChdlEgfLD/HF4jqqe7/7SeagPdHLOVkFg==
X-Received: by 2002:a05:600c:4ecc:b0:426:6921:e3e5 with SMTP id
 5b1f17b1804b1-427f95af393mr5855e9.24.1721767144522; 
 Tue, 23 Jul 2024 13:39:04 -0700 (PDT)
Received: from localhost.localdomain
 (vbo91-h01-176-184-50-4.dsl.sta.abo.bbox.fr. [176.184.50.4])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427f9399b13sm458445e9.27.2024.07.23.13.39.03
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 23 Jul 2024 13:39:04 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 01/28] accel: Restrict probe_access*() functions to TCG
Date: Tue, 23 Jul 2024 22:38:28 +0200
Message-ID: <20240723203855.65033-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240723203855.65033-1-philmd@linaro.org>
References: <20240723203855.65033-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

This API is specific to TCG (already handled by hardware
accelerators), so restrict it with #ifdef'ry. Remove
unnecessary stubs.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20240529155918.6221-1-philmd@linaro.org>
---
 include/exec/exec-all.h |  7 ++++++-
 accel/stubs/tcg-stub.c  | 14 --------------
 2 files changed, 6 insertions(+), 15 deletions(-)

diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index b6b46ad13c7..72240ef4263 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -301,6 +301,9 @@ static inline void tlb_flush_range_by_mmuidx_all_cpus_synced(CPUState *cpu,
 {
 }
 #endif
+
+#if defined(CONFIG_TCG)
+
 /**
  * probe_access:
  * @env: CPUArchState
@@ -357,6 +360,7 @@ int probe_access_flags(CPUArchState *env, vaddr addr, int size,
                        bool nonfault, void **phost, uintptr_t retaddr);
 
 #ifndef CONFIG_USER_ONLY
+
 /**
  * probe_access_full:
  * Like probe_access_flags, except also return into @pfull.
@@ -392,7 +396,8 @@ int probe_access_full_mmu(CPUArchState *env, vaddr addr, int size,
                           MMUAccessType access_type, int mmu_idx,
                           void **phost, CPUTLBEntryFull **pfull);
 
-#endif
+#endif /* !CONFIG_USER_ONLY */
+#endif /* CONFIG_TCG */
 
 static inline tb_page_addr_t tb_page_addr0(const TranslationBlock *tb)
 {
diff --git a/accel/stubs/tcg-stub.c b/accel/stubs/tcg-stub.c
index dd890d6cf69..7f4208fddf2 100644
--- a/accel/stubs/tcg-stub.c
+++ b/accel/stubs/tcg-stub.c
@@ -18,20 +18,6 @@ void tb_flush(CPUState *cpu)
 {
 }
 
-int probe_access_flags(CPUArchState *env, vaddr addr, int size,
-                       MMUAccessType access_type, int mmu_idx,
-                       bool nonfault, void **phost, uintptr_t retaddr)
-{
-     g_assert_not_reached();
-}
-
-void *probe_access(CPUArchState *env, vaddr addr, int size,
-                   MMUAccessType access_type, int mmu_idx, uintptr_t retaddr)
-{
-     /* Handled by hardware accelerator. */
-     g_assert_not_reached();
-}
-
 G_NORETURN void cpu_loop_exit(CPUState *cpu)
 {
     g_assert_not_reached();
-- 
2.41.0


