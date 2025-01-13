Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67EC5C02180
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2025 19:58:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXQYd-0007iO-Or; Mon, 13 Jan 2025 14:57:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tXQYG-0006Rt-OY
 for qemu-devel@nongnu.org; Mon, 13 Jan 2025 14:56:48 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tXQYC-0007Vd-8m
 for qemu-devel@nongnu.org; Mon, 13 Jan 2025 14:56:44 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-385e06af753so2379326f8f.2
 for <qemu-devel@nongnu.org>; Mon, 13 Jan 2025 11:56:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736798198; x=1737402998; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8+YIN1f80FVmcBoMH1oRH2tR6JuH5Kh9JlAiouQJECQ=;
 b=bYG0stNoIA+QqJXQum+oTOafFUL/oMZSOvTFO0CINPBSxk2WRBkcMo/jcrlVECbjHn
 RrROtFd5+sOLDBF3o2Y/cjtl7KQxytFGuO6hMPusJZYdApuHtJeVsdQklbt7Totr3OA1
 431j9/anREwXjrHcSPMfRsEXzWMp5SkYLnDZwVfq+Q9kqWVlHbhSoOFY+t4zm+aJG0QN
 eU4h2j6TDQoHSoPLKvJCzB4uEtXSKtnhxTiURIPz1wtMsCHIy9IReioUprkZFRyKwmas
 W/hYWh8pEIruPJVe81Y/fy3x1RCOnSHmqbQOqtAUMnw5FZInZQuif+Ya0jrWxPMzlHM4
 PxTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736798198; x=1737402998;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8+YIN1f80FVmcBoMH1oRH2tR6JuH5Kh9JlAiouQJECQ=;
 b=HKxZ7iLfKXIsYe/6j9g0V36yN7hHpcThISNvmGMu4NWTnei6suJcRbFgTLwthPC+T5
 fY2YxzntVD4j9Do1MQ4+eUSm/5bOBLU+1LEs+263bqXTjw1A7yQ5LMb1AQTnIvvzNfRD
 aq17mxcwdNYZufzG1GJ5SUgIAMPQogqLMXfmKC2v1Wc5+YB6HJO7PjhkH9qPZgszZJjL
 oJb/jIXzSWWvojRkZvXgiYvzas5iUjGttslOaJ9h7zuF2sr/64Gd6eFNBY/pqcp0dt6L
 6Q2Q9JFcFsWDp4iL8Jk8bLMHwqiE8lym3hakwuL9sC5AWa0J8IcmE/pH/hmLQq2NgEbm
 AhZQ==
X-Gm-Message-State: AOJu0YzEKa2zcP2fX8qNFpX3oYgtM0ggMJeSqh1K8yFga4/MNfz8R3UB
 i0UGK97nkDZMp4KHD/4eb4jnf6XquzyE9LRDlIGQCXRllgLXNkx7SAPWlz7+mZ3zuzHhunSEwJ8
 znVo=
X-Gm-Gg: ASbGncvcLXtfGmcWAi0eSYV9uXuUK8onq8PYsr3xK2+sgrHSMW81sgPyGm41zX0GdDX
 Q3sYQC5///OkNHNJui/5VJVqT+Oj2gdF3SFVFtfApAY8EdzWz4z+VudI6Q1vohfX8EzJCFsOBQg
 PWfiFcm/pGXr5l8zJOS8AeXoIWjw55k5vZ9jE0UmnOUDrgZ+Uls0fOE3msTcOR3FSinrgh8jlyT
 Ndvb1db3wsMMiVdfMcSfVuzuwZ5Hq6N8337eXqR9E+085M4MKFjeW25CT6LGv7JGFSgQt5JOH5Z
 wX/bp44gZ8Qm87KtZkUmWopT0VhKwsg=
X-Google-Smtp-Source: AGHT+IGGVSho9HN5HdosSioJKzvlvhjx36tctxHK8i65YvOr0uUi5uzGEhG7f6DBEDe1mbyFARYP0g==
X-Received: by 2002:a05:6000:2a3:b0:386:3684:c97e with SMTP id
 ffacd0b85a97d-38a87309ca0mr21630331f8f.23.1736798198277; 
 Mon, 13 Jan 2025 11:56:38 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e3840bfsm13212260f8f.39.2025.01.13.11.56.36
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 13 Jan 2025 11:56:37 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paul Burton <paulburton@kernel.org>, Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>
Subject: [PATCH v2 14/19] hw/mips/bootloader: Propagate CPU env to bl_gen_s[w,
 d]()
Date: Mon, 13 Jan 2025 20:55:20 +0100
Message-ID: <20250113195525.57150-15-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250113195525.57150-1-philmd@linaro.org>
References: <20250113195525.57150-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

Propagate the target specific CPU env to the locally
declared bl_gen_sw() and bl_gen_sd() functions.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/mips/bootloader.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/hw/mips/bootloader.c b/hw/mips/bootloader.c
index 464ed5f4f1a..288dccce473 100644
--- a/hw/mips/bootloader.c
+++ b/hw/mips/bootloader.c
@@ -194,7 +194,8 @@ static void bl_gen_sw_nm(void **ptr, bl_reg rt, uint8_t rs, uint16_t ofs12)
     st_nm32_p(ptr, insn);
 }
 
-static void bl_gen_sw(void **p, bl_reg rt, uint8_t base, uint16_t offset)
+static void bl_gen_sw(const CPUMIPSState *env, void **p,
+                      bl_reg rt, uint8_t base, uint16_t offset)
 {
     if (bootcpu_supports_isa(ISA_NANOMIPS32)) {
         bl_gen_sw_nm(p, rt, base, offset);
@@ -203,7 +204,8 @@ static void bl_gen_sw(void **p, bl_reg rt, uint8_t base, uint16_t offset)
     }
 }
 
-static void bl_gen_sd(void **p, bl_reg rt, uint8_t base, uint16_t offset)
+static void bl_gen_sd(const CPUMIPSState *env, void **p,
+                      bl_reg rt, uint8_t base, uint16_t offset)
 {
     if (bootcpu_supports_isa(ISA_MIPS3)) {
         bl_gen_i_type(p, 0x3f, base, rt, offset);
@@ -292,9 +294,9 @@ void bl_gen_write_ulong(const MIPSCPU *cpu, void **p,
     bl_gen_load_ulong(env, p, BL_REG_K0, val);
     bl_gen_load_ulong(env, p, BL_REG_K1, addr);
     if (bootcpu_supports_isa(ISA_MIPS3)) {
-        bl_gen_sd(p, BL_REG_K0, BL_REG_K1, 0x0);
+        bl_gen_sd(env, p, BL_REG_K0, BL_REG_K1, 0x0);
     } else {
-        bl_gen_sw(p, BL_REG_K0, BL_REG_K1, 0x0);
+        bl_gen_sw(env, p, BL_REG_K0, BL_REG_K1, 0x0);
     }
 }
 
@@ -305,7 +307,7 @@ void bl_gen_write_u32(const MIPSCPU *cpu, void **p,
 
     bl_gen_li(env, p, BL_REG_K0, val);
     bl_gen_load_ulong(env, p, BL_REG_K1, addr);
-    bl_gen_sw(p, BL_REG_K0, BL_REG_K1, 0x0);
+    bl_gen_sw(env, p, BL_REG_K0, BL_REG_K1, 0x0);
 }
 
 void bl_gen_write_u64(const MIPSCPU *cpu, void **p,
@@ -315,5 +317,5 @@ void bl_gen_write_u64(const MIPSCPU *cpu, void **p,
 
     bl_gen_dli(env, p, BL_REG_K0, val);
     bl_gen_load_ulong(env, p, BL_REG_K1, addr);
-    bl_gen_sd(p, BL_REG_K0, BL_REG_K1, 0x0);
+    bl_gen_sd(env, p, BL_REG_K0, BL_REG_K1, 0x0);
 }
-- 
2.47.1


