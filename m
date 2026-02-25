Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B316FD45FA
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 23:22:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvOAH-0007GZ-Rc; Wed, 25 Feb 2026 18:19:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vvOA3-00079x-HT
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 18:19:22 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vvOA0-0003Rq-CV
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 18:19:18 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-483703e4b08so1954165e9.1
 for <qemu-devel@nongnu.org>; Wed, 25 Feb 2026 15:19:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772061554; x=1772666354; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=3PMPYRPo9wawXBw9HepTAWPF5vs6ZhQZDkMazwroLWM=;
 b=JEVaHyh6TERarEAJbQeVTH8QLtMc58Dl0Q/HwksSvtPIPR5PyixrnNG5c2VM6tXjo/
 INVNGRsSibSNq1hPv4TZ0YCPU4uluawxB2idAGiftd/vqUGgnOiRwWOGV8f3wRxVRhT3
 A4lKWRgS7vWEN5aaN9Qn3B+Dmv08JE1JU4xrnnsNtFhpyjhLrRuIjzy1+uSYqGbPXAJb
 5MdGtIxLpBhaxGTGgpbrrZvJMfjvN7woEIaS32KoQ6jenROW2Z5KSqUnsWw80XpJJdzB
 MG0LWezVMfjRQYN4FxcVAocrPib7l1ldobUrKEc5nQNPJnITxhG2ToKEDZp5a+B+18jf
 f45A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772061554; x=1772666354;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=3PMPYRPo9wawXBw9HepTAWPF5vs6ZhQZDkMazwroLWM=;
 b=YpxxQ0DJXZULMdk6Ul4XtJoqh08TY1xchWoSztZoEWtf2SxgRtLRSIOyrLuyp4QxZQ
 3Xb26gnrULoU3+7s4wFYt0zAj7KEgARELTaDYjP7FFQENItmKV5EbsIQyictCaR8aZbS
 iwt8CKPjfKrAiMrokWVtVbOPZ0IZGEAN6u7Pl/yRfynkgE9gX2Obn6NxLvwzuHLPREkF
 HYNV2JfgcdrZKYI4qsaVsz7r+JQA0xRDiDoiw5mC6Izk+KlxqcYeSmw8/urTSmVX964B
 w/42VXvwuYWHjLPgi2GX0YEj4Of0psqbRgPBxaTTwAAekWfB/kydc/nBy8lK4UgXFxQW
 MLyg==
X-Gm-Message-State: AOJu0YxHLeRpu+ncoa5t6+fq4pnBAltdE+DNZEVbpJuiNnFg1h4X+6fR
 2Ld1o/3Lvh7MZ74xBDVn2aQasjDD/NJp2B3NB5HZeq6yt2vzvPbpmKvQAPfP1xocD5ui+ulgd68
 IWoXh+P8=
X-Gm-Gg: ATEYQzy+O3SI9Uy/eNFFNVmO8tExHtsaJfxLUNnaV3yRTZGhwCokKBceZaUqOc1bIUm
 vp2RBanTbR+KVmR380WFLjx69SPaAe2s8QrThIWOHAKI8Ykftk8buregMxmgUiKlgHsejhOWNI3
 wNflsfLUL9ygDCw44zhDiOv/t4zZuiLvetLYc3gKI3d9l0y0XrQzWcXyTK48I0vuOUIny62MJIp
 MLv5JvdQ8Z07YY2GLy0Vy2mhhzxN4AuqLd9VvF5EV2/9yCNxE2IJEEhRRDRxlwc4BMZZSavUhoM
 CMi8rNWdoseIJjTGTqixWyS97Pzxm/nBeB/IJ899/2HsSxxBWwHIQN6S33w2sUa/6mw3s1rauS6
 M4GaCsb5pLTZjhV/AB16JbmiWUvIr+rYrD3ssl7Vlh6mQbSwg+oZzdYMklk+GShNNxRU75FDXa1
 R1UGbxpMgKN7PxrWFadBeV3IDqa73dGKZcZwhZWbQbc/7u1Q3Ee0C+Sv5pdfwn5VLiOmOOUrBA
X-Received: by 2002:a05:600c:3510:b0:475:ddad:c3a9 with SMTP id
 5b1f17b1804b1-483c33d6447mr12927625e9.13.1772061554539; 
 Wed, 25 Feb 2026 15:19:14 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483c3b84023sm4007815e9.12.2026.02.25.15.19.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 25 Feb 2026 15:19:14 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 44/70] target/sparc: Expand gdb_get_regl() in gdb_get_rega()
Date: Thu, 26 Feb 2026 00:13:44 +0100
Message-ID: <20260225231411.96482-45-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260225231411.96482-1-philmd@linaro.org>
References: <20260225231411.96482-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

Convert the gdb_get_rega() macro to an inlined function,
expanding gdb_get_regl() via a TARGET_SPARC64 definition check.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20260219191955.83815-37-philmd@linaro.org>
---
 target/sparc/gdbstub.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/target/sparc/gdbstub.c b/target/sparc/gdbstub.c
index d19819cd1a9..792bf70a145 100644
--- a/target/sparc/gdbstub.c
+++ b/target/sparc/gdbstub.c
@@ -22,11 +22,14 @@
 #include "cpu.h"
 #include "gdbstub/helpers.h"
 
-#ifdef TARGET_ABI32
-#define gdb_get_rega(buf, val) gdb_get_reg32(buf, val)
+static inline int gdb_get_rega(GByteArray *buf, uint64_t val)
+{
+#if defined(TARGET_ABI32) || !defined(TARGET_SPARC64)
+    return gdb_get_reg32(buf, val);
 #else
-#define gdb_get_rega(buf, val) gdb_get_regl(buf, val)
+    return gdb_get_reg64(buf, val);
 #endif
+}
 
 int sparc_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
 {
-- 
2.52.0


