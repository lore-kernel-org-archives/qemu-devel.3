Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89F9FC44500
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Jan 2026 08:55:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viqT2-0006oF-Vf; Thu, 22 Jan 2026 03:55:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1viqSM-0005Tg-VW
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 03:54:28 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1viqSJ-0005ve-KG
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 03:54:21 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-47ff94b46afso5396615e9.1
 for <qemu-devel@nongnu.org>; Thu, 22 Jan 2026 00:54:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769072056; x=1769676856; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=C+0Piivd21vQE6A4CdNID8lz8yLVyi4mjIvdMsFQpEs=;
 b=wKo0WKc7T2UpelsyOMVfH0tuZI9DMXTDkIsMtfGhgP4f9+Op7iyGZSQpaL481zllYU
 40osDlkXIc5H26nlG6RWLe2HYfgT3gEhOvifpmDFj66j1lI0hjQ1wOxRfeSrwJxN2bws
 9ePntVf3dn0WYbG23z8zXHXW6QbZFn0kZzwbAUExg+K6Sd66m1DndUC+/teLEX+JPeh4
 ky1Qc3bVX8mRVyqJ0mZ2YhkHcTzJn+CfiCYTcaeHZAu960WHk+grYubfgomC0ZrFEHyD
 02Z9ZPFLpBZfm/DGnWlKaesmNaBlNtFWZT4PEu1fA+vjUvKNHqEm0jHkgGrX+yOafNuR
 L36w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769072056; x=1769676856;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=C+0Piivd21vQE6A4CdNID8lz8yLVyi4mjIvdMsFQpEs=;
 b=YkVH3oNDlHJedcwS1kV0kT9uF/9NJNzwuR7UYeBS8tbM99ycJt7GnrZh7dSkPb9diC
 +fWsXyZZxgXCXqgKs2yrSGh+0gH16bi8QugEhkFUMH15k834V+546gi00Zrc5rCBDq1/
 himVY6DVArrx/0ObSLHS1jDXRFG3nOQE+ImnkOnWnRGSppyT//C7RsvyM8KxNNDpX/04
 ZZoLIuRUgY++bg+/tPxSe665ni3LtfAoDRn4ksCqz/NzxnBmCA7Gjnj7s0aDxf5ltMkR
 o89KkNdYvU/KYDzMqf9Hy71Aw6arsjaJW7enELieiweM4tp2xA29n90w7OidFyQEdiSJ
 JBrw==
X-Gm-Message-State: AOJu0Yxcy6PQ7w+r1bDP2qChwg4Zt6h0r3j+wSe0o1yjmqJZAj9ta9Pe
 GU4iGlojEUksfeSEjvLx2GY7q0LA9itTBqHUkRJ9FTL2PQbckpQt9DZpNi22UXdWrgVZygq2rL1
 hbfuSNHM=
X-Gm-Gg: AZuq6aKUVOArOnidQJ7yyQUNwqQFjjDEOElnCey7Ej/XSICyezIdPU/e1R39cUqF3dp
 dst3z/O3wWSOK1NZ8yccYZd/cuVtfOfdbbb0LR2K6irxshnCHSoTPUiPu1R/VSVRRVYBEcS4ma8
 DcUoB6kr0g/R5kaqgvdSuukUwcxDXgGn1nSq/qW8GO3+Pgr1kl3lGlx/qCtuMPsNDrbVtZwlaAo
 dPKyqI51J8T2aaVd652MuuW/86DGlECWu3ncOX8yHzY0q7X0/WgOjiUlIttOcsARb490y+8Si2S
 lyceTAUbyNJj0AfXVza9dvJJn64oHtWN4w4eJigripMORjocTSL/rurn7lV5NtpfIteo1m5jtqe
 DQRxpSqsBEIYwvKU6QEVWMdA951G1fCIMGTaJzDNrJeAgdGLvqRuY2FFHtbYmUY2jmfgDPQkOZZ
 b8zSlRas8qLvykaRcPYaZ8eoPSiYACkXKy+PcCYy3vrDj/rcSwlCtJcejkNlDg
X-Received: by 2002:a05:600c:8691:b0:47d:7004:f488 with SMTP id
 5b1f17b1804b1-480470b7d42mr22616155e9.10.1769072056262; 
 Thu, 22 Jan 2026 00:54:16 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4804704b712sm50737105e9.8.2026.01.22.00.54.15
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 22 Jan 2026 00:54:15 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 12/31] system: Allow restricting the legacy ld/st_phys()
 'native-endian' API
Date: Thu, 22 Jan 2026 09:52:35 +0100
Message-ID: <20260122085255.95035-13-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260122085255.95035-1-philmd@linaro.org>
References: <20260122085255.95035-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

Guard the native endian APIs we want to remove by surrounding
them with TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API #ifdef'ry.

Since all targets can check the definition, do not poison it.

Once a target gets cleaned we'll set the definition in the
target config, then the target won't be able to use the legacy
API anymore.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260109165058.59144-15-philmd@linaro.org>
---
 include/system/memory_ldst_phys.h.inc | 2 ++
 scripts/make-config-poison.sh         | 1 +
 2 files changed, 3 insertions(+)

diff --git a/include/system/memory_ldst_phys.h.inc b/include/system/memory_ldst_phys.h.inc
index f4c91dc7a91..66bbd3061c2 100644
--- a/include/system/memory_ldst_phys.h.inc
+++ b/include/system/memory_ldst_phys.h.inc
@@ -31,8 +31,10 @@ static inline void glue(stb_phys, SUFFIX)(ARG1_DECL, hwaddr addr, uint8_t val)
                                     MEMTXATTRS_UNSPECIFIED, NULL);
 }
 
+#ifndef TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API
 #define ENDIANNESS
 #include "system/memory_ldst_phys_endian.h.inc"
+#endif /* TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API */
 
 #define ENDIANNESS  _le
 #include "system/memory_ldst_phys_endian.h.inc"
diff --git a/scripts/make-config-poison.sh b/scripts/make-config-poison.sh
index 937357b3531..b4d61e8bc9e 100755
--- a/scripts/make-config-poison.sh
+++ b/scripts/make-config-poison.sh
@@ -11,6 +11,7 @@ exec sed -n \
   -e '/CONFIG_USER_ONLY/d' \
   -e '/CONFIG_SOFTMMU/d' \
   -e '/TARGET_NOT_USING_LEGACY_LDST_PHYS_API/d' \
+  -e '/TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API/d' \
   -e '/^#define / {' \
   -e    's///' \
   -e    's/ .*//' \
-- 
2.52.0


