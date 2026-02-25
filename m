Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B593FD45FA
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 23:17:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvO86-0001D3-E9; Wed, 25 Feb 2026 18:17:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vvO7z-0000bP-OA
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 18:17:13 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vvO7y-0002vn-0c
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 18:17:11 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-48374014a77so2749575e9.3
 for <qemu-devel@nongnu.org>; Wed, 25 Feb 2026 15:17:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772061428; x=1772666228; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=rE+HjiUTPQ9o90Zshj3SAz4DZQ3CFdCGHSGhweXU4Pk=;
 b=Ad+ENI3uGIfRAHejLjtM3ofB7ErM6+B+qBthJM6R1tswSp+fJKFzwmITx4WmvXfmCy
 sryii3QwMnPRAYs6Ijls1ZK4jjrJOETdY3RJhKebEp2GcnqhLMDV6k6Zyw0vmBzEF4sz
 uY5qoFaB9ToZrhyJLGpW/+DCRdmVlP79xCd0Uj43Oi1Q8VBPcfkaMeqJkXiW2Zo0Mcag
 Ao2Vv6a52rOorZAjPw3PQbD/dzr6QnGe69lIq1AmmrK7Nsdcb8B8q/e0G/01npk2mGP3
 Axx440gJAs5FKn2NI4IvJSFpmwC3iHj7cVcOxwrPqBTAk8+02pk/n3JNAXN0pFc8jPvG
 QaJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772061428; x=1772666228;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=rE+HjiUTPQ9o90Zshj3SAz4DZQ3CFdCGHSGhweXU4Pk=;
 b=TSAbeqgq0zXM+/KyJY4/vJMBh8U1E1jqsg32jg9Urv9IG3xPWR93sMV1oqbufYHSGR
 naDgHd4zx5s6ofapNHA3IVqraJdTEMtMestMGPeMN5D/MbC8b1E2M4q5QnBEzt7EgJzS
 /6JoktKroQeAxqou/2OFkNDrngKNO135VGCTNI76ktVaUo6gHJJTI9XWzJhO1O+ETH2F
 RkrY+oHsTxJ42K9ZM+YKrQwwo//S4xq2hquCscBtERh03YI7iAUtRuW6bTm+bNt5Efus
 CwWGxzmQRlvlL1R2au4NqcYzUvWWkqKEH+wyoV3dDNuBE4ZlXJIKx7uCFvWjCVVaOsNX
 qfnA==
X-Gm-Message-State: AOJu0YxUlBFlyw7jT4zE5g2sxL4qatzg7aN7bfB1dfsu2fDvwY2hFRqy
 0yk0gBqtf+9TUJXWNGYONzSd20wa1PYbP6OzuT3MjKQJV7usBDJ04FcqeX0tIxbqISmYxq+c83Z
 Yh+udFdE=
X-Gm-Gg: ATEYQzwEMtXXMy4HX/+nQdVOPEiLRuRaDQm580QqvszFkEO1p7zmd54qfz16qgkU7VP
 tOBHErKYkFai6tlESFXXEP1Cu+C/r9bgfJa6tfU4xxGoc1nNahH/odjTKmXGTD8qhBM42c16Nlg
 BXsIt1OamGLZDJRa3R+gK8ZRvZMA2xhhjo2eNdKYnyBhyHpAG9OcmcKCvzItQEHs3OrwLtmCWtF
 2gJxKTEqsJz+yo75jpUo26K/o1e1GHXIhc4ZPVxzD1SQJJETwRwTlwnDtLeHM9ExwBZgGlFtn7H
 pSotVx1yhQfc/9Skgc42FYKyOb8n+GQ7XQomZV8EtT++1+AemUWqMlDcFfLh+JsF0iEB25I/Y0a
 5zLVKuLgNsJvLML9rdRAcg3NzEdHl8PdePcG6wr7Ekw4qWZnkNJenEUXKDFb9b0rcSzVPLNElKP
 Gu9uBxWfIdJgIpVinNzJ7GRUBM28a/bxb4M+uS0jVw1o8H99vp8J0tj46X2dUIuS3e89BhxkGl
X-Received: by 2002:a05:600c:3115:b0:483:3380:ca0c with SMTP id
 5b1f17b1804b1-483a9611795mr365809865e9.35.1772061428033; 
 Wed, 25 Feb 2026 15:17:08 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483c3addb3asm4536535e9.0.2026.02.25.15.17.07
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 25 Feb 2026 15:17:07 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 26/70] target/i386: Remove MonitorDef register entries
 available via gdbstub
Date: Thu, 26 Feb 2026 00:13:26 +0100
Message-ID: <20260225231411.96482-27-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260225231411.96482-1-philmd@linaro.org>
References: <20260225231411.96482-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

All these registers are already provided by via gdbstub parsed XML
and handler by the gdb_get_register() helper in the monitor/hmp.c
file. Remove as now unreachable code.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20260219191955.83815-19-philmd@linaro.org>
---
 target/i386/monitor.c | 39 ---------------------------------------
 1 file changed, 39 deletions(-)

diff --git a/target/i386/monitor.c b/target/i386/monitor.c
index 99b32cb7b0f..446428602ef 100644
--- a/target/i386/monitor.c
+++ b/target/i386/monitor.c
@@ -602,46 +602,7 @@ static target_long monitor_get_pc(Monitor *mon, const struct MonitorDef *md,
 
 const MonitorDef monitor_defs[] = {
 #define SEG(name, seg) \
-    { name, offsetof(CPUX86State, segs[seg].selector), NULL, MD_I32 },\
-    { name ".base", offsetof(CPUX86State, segs[seg].base) },\
     { name ".limit", offsetof(CPUX86State, segs[seg].limit), NULL, MD_I32 },
-
-    { "eax", offsetof(CPUX86State, regs[0]) },
-    { "ecx", offsetof(CPUX86State, regs[1]) },
-    { "edx", offsetof(CPUX86State, regs[2]) },
-    { "ebx", offsetof(CPUX86State, regs[3]) },
-    { "esp|sp", offsetof(CPUX86State, regs[4]) },
-    { "ebp|fp", offsetof(CPUX86State, regs[5]) },
-    { "esi", offsetof(CPUX86State, regs[6]) },
-    { "edi", offsetof(CPUX86State, regs[7]) },
-#ifdef TARGET_X86_64
-    { "r8", offsetof(CPUX86State, regs[8]) },
-    { "r9", offsetof(CPUX86State, regs[9]) },
-    { "r10", offsetof(CPUX86State, regs[10]) },
-    { "r11", offsetof(CPUX86State, regs[11]) },
-    { "r12", offsetof(CPUX86State, regs[12]) },
-    { "r13", offsetof(CPUX86State, regs[13]) },
-    { "r14", offsetof(CPUX86State, regs[14]) },
-    { "r15", offsetof(CPUX86State, regs[15]) },
-    { "r16", offsetof(CPUX86State, regs[16]) },
-    { "r17", offsetof(CPUX86State, regs[17]) },
-    { "r18", offsetof(CPUX86State, regs[18]) },
-    { "r19", offsetof(CPUX86State, regs[19]) },
-    { "r20", offsetof(CPUX86State, regs[20]) },
-    { "r21", offsetof(CPUX86State, regs[21]) },
-    { "r22", offsetof(CPUX86State, regs[22]) },
-    { "r23", offsetof(CPUX86State, regs[23]) },
-    { "r24", offsetof(CPUX86State, regs[24]) },
-    { "r25", offsetof(CPUX86State, regs[25]) },
-    { "r26", offsetof(CPUX86State, regs[26]) },
-    { "r27", offsetof(CPUX86State, regs[27]) },
-    { "r28", offsetof(CPUX86State, regs[28]) },
-    { "r29", offsetof(CPUX86State, regs[29]) },
-    { "r30", offsetof(CPUX86State, regs[30]) },
-    { "r31", offsetof(CPUX86State, regs[31]) },
-#endif
-    { "eflags", offsetof(CPUX86State, eflags) },
-    { "eip", offsetof(CPUX86State, eip) },
     SEG("cs", R_CS)
     SEG("ds", R_DS)
     SEG("es", R_ES)
-- 
2.52.0


