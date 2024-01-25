Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F13A6C47258
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jan 2024 05:47:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSsZj-0007pr-GZ; Thu, 25 Jan 2024 00:46:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rSsZi-0007pX-8r
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 00:46:54 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rSsZg-0008Bs-Jl
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 00:46:53 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-40eccf4a91dso9144015e9.2
 for <qemu-devel@nongnu.org>; Wed, 24 Jan 2024 21:46:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706161611; x=1706766411; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1YhPWyC91/ZoF+G+aVXM2Nb81LOfH7Ct4OFLJMJHbq0=;
 b=lE7cZ+tSYh99SwXHQvvviK700CjV2y9Yh7mBE/hcBQ5ohjCQm+5NnkFwSZTqeXMHOc
 AJaxo5+MT4KZhWMcMSreL2JI6FMOdka/a3YPeisFWEFWxHHLMaxzwVpdaIGYZVXUvuPB
 BvZa/odiNE8vstXVZeHsRAX9ozE6HKj2gt6jXno0AY4FEnwigZmG6E4dk8QgICgAitRO
 plahEzohegurcVoBpynnnQVPERk6jB/qIsyWcXzu09VJkAXkwE5TjFWOwBBSFxjxZa6i
 larVLzaL5h/gSt7yrLzhtcliYeZ5cAMmWs3LDlQ7E2n6yc1S38H+/F87L4c0Q2dDfdps
 0W7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706161611; x=1706766411;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1YhPWyC91/ZoF+G+aVXM2Nb81LOfH7Ct4OFLJMJHbq0=;
 b=uZ0qpKgr54gWvSYWLQ/BBZTtGE09p8KEy720sVnNOn+mguIVISIxm//E+E81Bae/RR
 ICTi15efPf9r0hQ9/pLmV9l8340JV7wK9eoc5pV6XXD0sAOyLV2dngi63p/hd0fLtC79
 +OdusxJL9j4D4O65j00PCXZaU+vRwgjUEiq+06ZmaJM67fuO1+sSy8y1KO2CxZy6hL/B
 UGSlWO+shjaiVx1Ju20R0GOyeiT4onIoEY8DFb++j8+nFU+Bs4nBtOZ+8fl86p3SGr6+
 wzqi4aULV3KraTe5z/6GRaedvn4UEpyrZcAn/13BryO3zGWQATUMfEmf8xG1ZneEk6mR
 Dfjw==
X-Gm-Message-State: AOJu0YxhFfsbZHBAmoTCI4bXyvTtd7hGGhUjbI0Mk8m6pg0n/Hs8wRLU
 EeutYMpA4dy+FRLsVnVg6Za9dyt+z5nPod4Iqnai6hSAbkNZ0RXXzAlcb2CCxngWRBEyq003q9D
 R
X-Google-Smtp-Source: AGHT+IGgHCQvVC9377H85T/vJFmGs9KQjIjDrV7/Z99MJ0b0sSDUVB/NPeEgDKfbkNPz5Z51wVZ8Lg==
X-Received: by 2002:a1c:740d:0:b0:40e:55bb:a0b8 with SMTP id
 p13-20020a1c740d000000b0040e55bba0b8mr151428wmc.157.1706161611046; 
 Wed, 24 Jan 2024 21:46:51 -0800 (PST)
Received: from m1x-phil.lan (lec62-h02-176-184-19-125.dsl.sta.abo.bbox.fr.
 [176.184.19.125]) by smtp.gmail.com with ESMTPSA id
 f7-20020a05600c4e8700b0040e4914f28dsm1228615wmq.18.2024.01.24.21.46.50
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 24 Jan 2024 21:46:50 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v6 3/4] accel/tcg: Remove #ifdef TARGET_I386 from perf.c
Date: Thu, 25 Jan 2024 06:46:29 +0100
Message-ID: <20240125054631.78867-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240125054631.78867-1-philmd@linaro.org>
References: <20240125054631.78867-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Ilya Leoshkevich <iii@linux.ibm.com>

Preparation for moving perf.c to tcg/.

This affects only profiling guest code, which has code in a non-0 based
segment, e.g., 16-bit code, which is not particularly important.

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20231212003837.64090-4-iii@linux.ibm.com>
---
 accel/tcg/perf.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/accel/tcg/perf.c b/accel/tcg/perf.c
index ba75c1bbe4..68a46b1b52 100644
--- a/accel/tcg/perf.c
+++ b/accel/tcg/perf.c
@@ -337,10 +337,6 @@ void perf_report_code(uint64_t guest_pc, TranslationBlock *tb,
         q[insn].address = gen_insn_data[insn * start_words + 0];
         if (tb_cflags(tb) & CF_PCREL) {
             q[insn].address |= (guest_pc & qemu_target_page_mask());
-        } else {
-#if defined(TARGET_I386)
-            q[insn].address -= tb->cs_base;
-#endif
         }
         q[insn].flags = DEBUGINFO_SYMBOL | (jitdump ? DEBUGINFO_LINE : 0);
     }
-- 
2.41.0


