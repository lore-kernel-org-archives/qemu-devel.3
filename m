Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD5CCE7FDDA
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 21:04:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vn14D-0005PO-Tq; Mon, 02 Feb 2026 16:02:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vn13h-0002y6-4j
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 16:02:12 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vn13e-0004Yp-KM
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 16:02:08 -0500
Received: by mail-wm1-x344.google.com with SMTP id
 5b1f17b1804b1-4806bf39419so780235e9.1
 for <qemu-devel@nongnu.org>; Mon, 02 Feb 2026 13:02:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770066124; x=1770670924; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ujg9U+BCTaj4+l5p4USlgs7ND8+2HFwZDCMj5HdauaY=;
 b=MTLCl09Zvhrq9jr/wggNTycmketbh1a6jG2L+7jdYYEQwxe4uCAI1+uFNQROLzXFlU
 QuBhcxNnhy+8sAOYLc5opnEAAafA4CBxbXav2kJd7/k9+Uq5to/Ud7RC7GiFZ33vwZm/
 6ZahrUa+jQyXkiP7sTEwgwJRRx5LXVKYsRzLpFwJOc2ShtzY+XPu+BbOVe+QOeXxjFue
 3AYXwriw1w9ONq+keokYHWRH1cpsXgeME1tY2q0DeUzDxbA3MWLRyrZo49u01uftRWW8
 2+JMnC2VrbheM3sqMRM3Rj2TgVWoUgAO+UeS8BeK6ADANEjYK4bKoGlFHyhyEODyuBZG
 OYAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770066124; x=1770670924;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ujg9U+BCTaj4+l5p4USlgs7ND8+2HFwZDCMj5HdauaY=;
 b=KhIlpaGXeLQwwZ1M8n3lccfYjWCcAzzcv0any1W7OwJtjwYy232v0Eo70IMfNt2blL
 1ETK8JibcaLGU8fNqvuJwWsT7faXlTe9ZoYWSTmXP4ykEaIDWn/U+ejJMSmirxhYE5aV
 zHAde+F5IvbnDd72qyM4ilCZbJ4uHxh6o96fSqaO8bCwSUaC1o3LaJbZewqsLc4Fg+Lk
 TlUMmfCSsc7LZJsy7EOqBP7D0NgvBKl1xINzs8ivfmgS0AZ5cFko7LhlHajL8mzyyHl/
 FeoVFrPaj1ErS6UkkxzGQBiXPxQt0dRKyH79JfaCyIwKv7reJ5Oc2sIVHTrww7NO9E7x
 p8IA==
X-Gm-Message-State: AOJu0YyBtmmx69FqDHf2e78qbBpa7bHMIniv1evPQ7+J3pBmyTDpxmfZ
 m/Qa4OwcEvS8zw+6B1LmcxZGkw3cSRclP4A0UC/KGqZBdHiY5I7aBFakZWOSZnQajGUs9y9bEvN
 zPjw8xxDpag==
X-Gm-Gg: AZuq6aJWywgSToWHhFgBc5dq4vwH7orKsp/8oWGnniA2RcLPFTONkpIKyHCwo7bWHmy
 VgKWXU+wVJXUyR7ba1KmZHVacDA4PryStx+KThGnQ623D2YOvRdXL44RnhZrn295u3pFLoInjR/
 P0p6n8285bQalfFUjG64ibMByonIP9F39vcP0CWNwCpYQqneW9c4+erpKTSYxOximDKon7ojwWo
 /sn0/H/0J6cu3vMjciJhTSkMC6Y7laDieOfzD8yRT/smfWipasiR0m3SKCeJmZlmIOiSgdESiFX
 05AcUkN0IoJtacnHCZuJxQtivXrIrDZaauDGONtThGqh0DN4wQdyuFpFDkvxb4jz4Do1SzAPKnS
 +1F184Z8OJVnHUdvDaWQdKvgo26RvMMbXsxqA4is+T6oqji28o7poZz0PppcA7u1MTxJCPIR5pU
 kk1K9238RnVWCOv0Vvff0UrcsG4dEjsaJj87pgBmyXjK79gTYYRWKagbYWiZ6O
X-Received: by 2002:a05:600c:3e8f:b0:477:9a61:fd06 with SMTP id
 5b1f17b1804b1-48305136156mr11885165e9.8.1770066123828; 
 Mon, 02 Feb 2026 13:02:03 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4830511cc4dsm13270355e9.3.2026.02.02.13.02.02
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 02 Feb 2026 13:02:03 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>, Nicholas Piggin <npiggin@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Chinmay Rath <rathc@linux.ibm.com>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v6 08/11] target/ppc: Check endianness via env in
 ppc_disas_set_info()
Date: Mon,  2 Feb 2026 22:01:02 +0100
Message-ID: <20260202210106.93257-9-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260202210106.93257-1-philmd@linaro.org>
References: <20260202210106.93257-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x344.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

disas_set_info() shouldn't bother with env->hflags,
access env->msr directly.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Anton Johansson <anjo@rev.ng>
---
 target/ppc/cpu_init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 58816c51a74..0808284b722 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -7456,7 +7456,7 @@ static void ppc_disas_set_info(CPUState *cs, disassemble_info *info)
 {
     CPUPPCState *env = cpu_env(cs);
 
-    if ((env->hflags >> MSR_LE) & 1) {
+    if ((env->msr >> MSR_LE) & 1) {
         info->endian = BFD_ENDIAN_LITTLE;
     } else {
         info->endian = BFD_ENDIAN_BIG;
-- 
2.52.0


