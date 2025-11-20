Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BACACFA441
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Nov 2025 20:19:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMB82-0004XR-DI; Thu, 20 Nov 2025 15:19:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vMB80-0004XI-G9
 for qemu-devel@nongnu.org; Thu, 20 Nov 2025 15:19:40 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vMB7w-0001Q4-Ut
 for qemu-devel@nongnu.org; Thu, 20 Nov 2025 15:19:40 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-42b38693c4dso666718f8f.3
 for <qemu-devel@nongnu.org>; Thu, 20 Nov 2025 12:19:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763669975; x=1764274775; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j3j2FTpR0aj6OQBGpq/AXoTS1vEHZTJrzZrKRCUXjeU=;
 b=YgxIA+TjXzdlrsY8konRkNQuoEDCK1V+claw64BcFNl9b/u1V6c6VD+StQU714X1Zh
 +UWN6JRasEOUjUzu2W7DzAaC7fhZJ2WNbxV1BW0qlwFIzxKSz8WryOuF6wab209I/g30
 Bf7uXJ04DjQuJibqcE6yFm2wsKAFGpGrZObB9K1+fmWe9MQO8G771wxaunFnwMyZqcZ5
 LOImcnz1XBHUf6s5qTJ/zq4QDrOLCTtUBYYcBB9UdgI9XO4Bw33slFLRFMgj7fLQPVus
 0GHSCX9uD15ilfvpBJOotJkZ1ItLAPJYfzLL4TTFzGCHv2f9GmjhlOhZ1pzHVxjNuA5r
 nxeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763669975; x=1764274775;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=j3j2FTpR0aj6OQBGpq/AXoTS1vEHZTJrzZrKRCUXjeU=;
 b=bj+GdaKspnnEaBjiTmjhWQbdsXYNr4IirNBfBxtR2KA4BOR/TG35/UI3xiajB4Dq3V
 CwMKtLpnyRgFaFopVhWn5/vKzCmBNqqYS/3u1LR8tIdO3zAtPn4eOBpInTLckpPCfPDU
 pfZkaksbzdFBVQS1dVtxVixadmaCwwa4YFw7ZOjhzrLqoEZtF3szUH2Tx1nImKfyxGI0
 Nm7RHLKwyygNvh2fpeF3S+JDGOrbJydxPufKMarCGdPhu3qZ1m7vCp6ut3yMM0S0GWqU
 Y7GsY2PzE7bpC+v7Kdwy1DGeTB8niLU8bOtMtR/PeNrH2odMeM7qrnBWeQQxLPQo75rC
 7Yag==
X-Gm-Message-State: AOJu0Yzvlj3idZtvsbyv7qi37Npa76FNYIfPL+FhOy80LNTaFU+eUlZg
 sM03f0T/tfEV4sXGMuWrhwftLgnQ0GIAVkzoO3JJ/xeVLhxltXyTy/kKSAola8hQ4tIQjsc8jej
 hWbH24Kt/PQ==
X-Gm-Gg: ASbGncvfHZxmo+oyHmN7cF9L6D57dye/8wcmxjHvsbsui7Zf91rx6IP7sxkhjp6mJmW
 lkCx10mpl9lu8teOGq+OOGh/nRvU/NVbocnXmCnJ94wWBTm+rg/3p89u7IY3gocqNECffQircdA
 FxyccQG2m7uCMU7EEdaDgYbRS7YfZIvMfvQo9dLBoQs/y8GgC0GD89Rqqg5rvU1Bl67Im+kAVxw
 /f7Cc8/l8xiZ7EghOjlKDXgNElYyq47vAyk8/XD3q6liFM+nRcSmuuwnbBGXrV37UbbVQpifb2R
 m93ReUjEpJrKXRFPqC7wv9wGXhOZG74eryVKX+/x/AWlScE7F/x8MNZfJef5//R3vfoZuZTF+K0
 SrApHFvujvlUR52ltrC5MbArnvAVqolR54iyXzgOF1/Pai4L5T7Lh9J48t2DYiAvoeXD0HT8YEk
 itahwiG4RosRmJsXwvuy52psGpIl5Lw7s0DLPTsEHv/K9TJkkIsxoMV56ICl9U
X-Google-Smtp-Source: AGHT+IFJ5l+oeM8L0Bvn+yLFHfpEI3FDY+LxP5YMTnt7z1hNrW+iLd/CgQHjCnnTGKR6l81kCwwj8w==
X-Received: by 2002:a05:6000:4312:b0:42b:3592:1b92 with SMTP id
 ffacd0b85a97d-42cb9a67bcamr4829105f8f.47.1763669975117; 
 Thu, 20 Nov 2025 12:19:35 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42cb7f363e4sm7142835f8f.12.2025.11.20.12.19.34
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 20 Nov 2025 12:19:34 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [RFC-PATCH-for-11.0 v2 2/8] target/alpha: Use little-endian variant
 of cpu_ldl_code()
Date: Thu, 20 Nov 2025 21:19:13 +0100
Message-ID: <20251120201919.8460-3-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251120201919.8460-1-philmd@linaro.org>
References: <20251120201919.8460-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

Alpha instructions are always stored in little-endian order.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/alpha/mem_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/alpha/mem_helper.c b/target/alpha/mem_helper.c
index 2113fe33ae2..d04d086b59d 100644
--- a/target/alpha/mem_helper.c
+++ b/target/alpha/mem_helper.c
@@ -30,7 +30,7 @@ static void do_unaligned_access(CPUAlphaState *env, vaddr addr, uintptr_t retadd
     cpu_restore_state(env_cpu(env), retaddr);
 
     pc = env->pc;
-    insn = cpu_ldl_code(env, pc);
+    insn = cpu_ldl_le_code(env, pc);
 
     env->trap_arg0 = addr;
     env->trap_arg1 = insn >> 26;                /* opcode */
-- 
2.51.0


