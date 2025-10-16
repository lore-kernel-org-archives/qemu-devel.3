Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14364CCD194
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 12:18:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9Mtu-000674-7A; Thu, 16 Oct 2025 08:16:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9Mts-000659-AI
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 08:16:08 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9Mth-000851-MB
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 08:16:05 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3ee130237a8so460972f8f.0
 for <qemu-devel@nongnu.org>; Thu, 16 Oct 2025 05:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760616944; x=1761221744; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=NcHn6tnpXWm0n21+w8vaM9zccGBWqwHOy+l8QY6n6fU=;
 b=YaHUfZtk6MVIa37WENNyfH5ZrpJNX5GMs7Tp5AEVcVlNlobzqF9OII/Q67tWYMHzmX
 0g1q8D8CCFv7engFuqbpq4JDbHkdDtuAUN4guleTzo0Pznu/k1wJd8JOJlK8gKP4o0sd
 YXFZ8bqbgt6gEI6jha7kUgduKvX+/O7VsFVvFBmB+3gEMAbhHcFLPV4zuTwAX1di2mjS
 jxq1wPYQJznmuJ2Q3l/sA2QmXWqKlE1Pr6VGZAzKZ7j3KdwvRS8V7WswZeIgt0abHhO+
 uiSQ6ZIN7oWhf1flY7oxBoUdJSbb6FHpxjrT42JRMg8O92rvypMvkkIWcwh2lbpYdlp7
 OVvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760616944; x=1761221744;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NcHn6tnpXWm0n21+w8vaM9zccGBWqwHOy+l8QY6n6fU=;
 b=bRJipHi/8Ng9k7vOzmyNWUt4GamFn2GOB5JFb1ezTxkBgfIGKK3kBBy4OPp+oDLlUA
 lXr/SwyDg07QAN7hvxZ5LDSYNoFTzjnFmwndorPztBklwSyCFfOC2XaFjqcRg4BIQp/0
 XAWLYnMVopBx5WdZfdZwBudG774gYY3jzQMcjdlBpWy1c12mHqRbRc0ELzv6NgH5yCAj
 CWT8NGLuzNxfNDr6emNxDDVoggX4cWXmKPXgxIndzM4mqOapVEsveMeMzQ2Lp+YmDF+K
 gTFMKsmJAvYLVmg72vrrTJxgnnstLVNMsHEzVKF1vcIZai7773XQHSUEXvEu3lnZrKr4
 i/6Q==
X-Gm-Message-State: AOJu0Yx0lH0PHIle1X+hkUF6qEgzsooUgEHcdvFrDzj/ZZIw+dC05VFJ
 2wqU9t/rUoNiEIbIixqrdEqAoPf+Ai/BW0R/U86Nl2F/kYdK8UyiwUGl5HV6vY8lQfSdoQwVASo
 WxirhyOM=
X-Gm-Gg: ASbGncvQWS+xbb1ZyNtKWKtIvBGGpL6oVQA0fyJDI20DuDQsQFIyIJUWV43TlhgZl0v
 9yrAkGy6FKSOq6qpbdlbgGQAYV20ylw5GcHEwFEB6LlOA8WWQbjG5s+VuVTOtsQbbOmgup2OL1h
 aHVC49JCqytg9/9iSq1dfeNEZ2bajZBY79vReP/wz7ZwF8XHSa0M1Ehd59fXNh2/T5hAXJFpZ1q
 TgBtrZeu4fac8n6Few1RfLf1ltBNbOpUOXws6pbygRPONHLgxzBI8DYkOpiIhqsTDpojnw1AHSe
 yGChx+VpecBG5fJb9xdRS/3BS85yyR+WRPkWN9mERXC70kiShtWut91qgm/2oA77xkOnwTA526k
 0MJYxUoNzDKVFP91IF/PJL37MSvPkXRbIxf2wPJSBSJdaAs5XC9vgLJtPjfPalgFmVMVgvdZy6J
 pzXmF8lCWuaJsF6rDi7cX2qhygAthJDuVogjuSEGhzoEsQ+8WaLTp12lzfNxgi0zOd
X-Google-Smtp-Source: AGHT+IEaAB11MlKIHnCwf0O9C5vNUtvidqzgKKwTWriEhMPVasGqe1/mqt5GD1la2dNomY/GmNN+JQ==
X-Received: by 2002:a05:6000:3102:b0:425:7e3f:f091 with SMTP id
 ffacd0b85a97d-4266e7d4485mr19984184f8f.37.1760616944470; 
 Thu, 16 Oct 2025 05:15:44 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce5e0efasm34314428f8f.41.2025.10.16.05.15.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 16 Oct 2025 05:15:44 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 02/75] target/alpha: Access CPUState::cpu_index via helper
Date: Thu, 16 Oct 2025 14:14:18 +0200
Message-ID: <20251016121532.14042-3-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251016121532.14042-1-philmd@linaro.org>
References: <20251016121532.14042-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

CPUState::cpu_index is a target agnostic field, meant
for common code (i.e. accel/ and system/ folders).

Target specific code should use the CPUClass::get_arch_id()
helper, even if there is a 1:1 mapping.

In preparation of generic changes around CPU indexing,
introduce the whoami helper to access the generic
CPUState::cpu_index field.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20250925010438.59755-1-philmd@linaro.org>
---
 target/alpha/helper.h     | 1 +
 target/alpha/sys_helper.c | 5 +++++
 target/alpha/translate.c  | 3 +--
 3 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/target/alpha/helper.h b/target/alpha/helper.h
index 788d2fbf289..954a5c8294c 100644
--- a/target/alpha/helper.h
+++ b/target/alpha/helper.h
@@ -92,6 +92,7 @@ DEF_HELPER_FLAGS_1(tbia, TCG_CALL_NO_RWG, void, env)
 DEF_HELPER_FLAGS_2(tbis, TCG_CALL_NO_RWG, void, env, i64)
 
 DEF_HELPER_1(halt, void, i64)
+DEF_HELPER_1(whami, i64, env)
 
 DEF_HELPER_FLAGS_0(get_vmtime, TCG_CALL_NO_RWG, i64)
 DEF_HELPER_FLAGS_0(get_walltime, TCG_CALL_NO_RWG, i64)
diff --git a/target/alpha/sys_helper.c b/target/alpha/sys_helper.c
index 87e37605c13..0e0a619975b 100644
--- a/target/alpha/sys_helper.c
+++ b/target/alpha/sys_helper.c
@@ -67,3 +67,8 @@ void helper_set_alarm(CPUAlphaState *env, uint64_t expire)
         timer_del(cpu->alarm_timer);
     }
 }
+
+uint64_t HELPER(whami)(CPUAlphaState *env)
+{
+    return env_cpu(env)->cpu_index;
+}
diff --git a/target/alpha/translate.c b/target/alpha/translate.c
index a492520075e..b1d8a4eb80a 100644
--- a/target/alpha/translate.c
+++ b/target/alpha/translate.c
@@ -1126,8 +1126,7 @@ static DisasJumpType gen_call_pal(DisasContext *ctx, int palcode)
             break;
         case 0x3C:
             /* WHAMI */
-            tcg_gen_ld32s_i64(ctx->ir[IR_V0], tcg_env,
-                -offsetof(AlphaCPU, env) + offsetof(CPUState, cpu_index));
+            gen_helper_whami(ctx->ir[IR_V0], tcg_env);
             break;
 
         case 0x3E:
-- 
2.51.0


