Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60C3DC02182
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 11:43:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taCdP-0005JL-1N; Tue, 21 Jan 2025 06:41:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1taCdN-0005FV-3J
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 06:41:29 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1taCdH-0003No-2b
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 06:41:28 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4361b6f9faeso35076495e9.1
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2025 03:41:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737459681; x=1738064481; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZpYqX6c238IVN8ObNqaQEL0twXm4e68BH00WB9vFFrA=;
 b=D8gRT90CbaFwhZAyuo6iH4FnIgPnfB6SVf4vinwB5YkTyLHl6t+3BqSk9PAknnHABj
 Pogr5SLdIpEpNpCYD3hKmfDftSJHQ1/U+Q7pJyjp37yo/RnXeMrKoGiVpS9LeNjQutgz
 8Q3qmVaLNszoNTuD9F7q51tkuPqRrrwAr73GT+SLifvBl9UmFF/9NL+Hmv4wPldVqjcB
 OHFsCc1r4z3wnpvBN/sxhHwo+V3V8h0qEVGMqn0wOvfvV6JQR1aMZ8FXDDTKI5zTlvYJ
 JWZtYqTZtsGjnOKUklpPZ5U18ptPSW5C8Ul/oDrc1lCy3K9BgzUPwpEuD3e+8Yu+/Bg0
 w7iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737459681; x=1738064481;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZpYqX6c238IVN8ObNqaQEL0twXm4e68BH00WB9vFFrA=;
 b=Gc2EUYytNPZBw2aAdy6YxbESIpogGjaUwBhWe9rzJ6ORRuShc1WDwY9ailT92JIB0+
 uy8AfV/tszoGJezKTJ4deh1dD6AlZlVQ6982SnDiUPN7FaOHLO5n4tD2jMhfaOkD1CEA
 bz4bkQvn9mu4ODdZv6scTTCvyuZxDsm2U27gssJ57gj3CVWIlqinmC8G9P2sjmJKn7Hd
 CobUfC8nT8XQrvDI5WfmUwySn1bAcyPWYyfHENdesYYDK6aeO+kFPPk86NszjoycHHVt
 mQcP1DNxPag3uiueXXHgtFfpJOHWZlvd2pMxhVJPwVdvlRwt2AMzpUc0sGxK0/AoXHES
 ZRug==
X-Gm-Message-State: AOJu0Yz+8W1kFtV6G3QLtfK+XusJbgjfRXCWYPoewsrlb4ehrc7ZejTN
 7wGfqDm03c3JKIu/EJdm6cZjP8u/2growWHNzAqoJnDDktNmZNJ1L6NYpNN2QAWZAmyDJy037Xv
 D3h8=
X-Gm-Gg: ASbGncvCiE3aUEdfc2yl0hK6L/9lWxKUDGrJr69ZPpgGdeC32Vsf2RMIzHS1A6jmy54
 PDUVlcjXwtg6UF3jXozfLf7UFpYeCFxsFFOmD6ykYVmDgbHWW0ov0/b7VaqGdiGwc+aQFx23AmY
 9++6ArARCgzDEov4Pqn+HC+D2TTqJtaRW6nF97r0t4a/Tsr4OFC25sqAF2h62iy5gF5TO3HnN8W
 yekSheAdLR+wT3vw65B8QTVAXqBohDJFe7EdHV1B0WQRbJWdnk3zt4l5rNof3wqm9Sch8scLenL
 nNltTWBsOGoW6nzG1LYdLYzSBT1WLGV6vMWvNBAyiqYY
X-Google-Smtp-Source: AGHT+IECj/AjCUgw1aODfaV1DbdsklgNdgfzkjy2bPPCeT2mx7sdBBOvETv2hoHFNOd/sSopUJmBqw==
X-Received: by 2002:a05:600c:4f53:b0:434:fa73:a906 with SMTP id
 5b1f17b1804b1-438918c5d0fmr139458315e9.4.1737459681114; 
 Tue, 21 Jan 2025 03:41:21 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-437c7499b28sm245220405e9.8.2025.01.21.03.41.20
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 21 Jan 2025 03:41:20 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 05/11] disas: Prefer cached CpuClass over CPU_GET_CLASS() macro
Date: Tue, 21 Jan 2025 12:40:50 +0100
Message-ID: <20250121114056.53949-6-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250121114056.53949-1-philmd@linaro.org>
References: <20250121114056.53949-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

CpuState caches its CPUClass since commit 6fbdff87062
("cpu: cache CPUClass in CPUState for hot code paths"),
use it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 disas/disas-common.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/disas/disas-common.c b/disas/disas-common.c
index de61f6d8a12..57505823cb7 100644
--- a/disas/disas-common.c
+++ b/disas/disas-common.c
@@ -67,9 +67,8 @@ void disas_initialize_debug_target(CPUDebug *s, CPUState *cpu)
         s->info.endian =  BFD_ENDIAN_LITTLE;
     }
 
-    CPUClass *cc = CPU_GET_CLASS(cpu);
-    if (cc->disas_set_info) {
-        cc->disas_set_info(cpu, &s->info);
+    if (cpu->cc->disas_set_info) {
+        cpu->cc->disas_set_info(cpu, &s->info);
     }
 }
 
-- 
2.47.1


