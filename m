Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8219CAC5AE
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 17:03:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1Ss0-0008WG-R3; Wed, 24 Sep 2025 13:01:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v1Srt-0008Uk-CX
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 13:01:29 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v1Srj-0006BJ-2O
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 13:01:24 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3f0ae439b56so64121f8f.3
 for <qemu-devel@nongnu.org>; Wed, 24 Sep 2025 10:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758733265; x=1759338065; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=5twlT9Aj+jo3jZSm3BkT07rcpXempHPtHwyizZ7JP1s=;
 b=vJrlr409TZK5pLfMnTZC5Qt6dT2EAXrFSZ6f1BQL8YoXg0sM4DEvIt1w65dudpJ33U
 Seh3UdL7Kdw3fBVXl214RdJoR3TPuPrAYY68avNPpHGmJLnXKNLX99o3nyf/QTrl8p1k
 ugJ4bfZph7SX2mvdMOLZZq58W9ZCcpxNFZ/SG2lSwCHYYcotip/XG/50n5SRK/AD0/b5
 EJoETkTotjN6dX2aD+IEkcccoS8+FixZ9zWiWgOkt1FCMk1yikro9AYly0Bnx67VDiIA
 Zp4CP5W4qn3uco0XlhjH5FhqwLEXRKQz4KsqOPesPCLxd4Zz2RoXgsPw6w16LACtjnZN
 zEMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758733265; x=1759338065;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5twlT9Aj+jo3jZSm3BkT07rcpXempHPtHwyizZ7JP1s=;
 b=Uc3A27C/9qwS9FEwSY3+z+dwIVzSamw9w7UNbNOkOze7K+2QqsuZtxHeTOySile3Ef
 exPwxUO0vrcX70166A0TxJznj0DtGk8gprCrwxIO/Cp5D6QUdbJFsc0dn5NSyFeZSWmC
 a5KC69rsLk2glTOzzL/tLnQM1vG5+ydM8EMXcvns1BhmSvvuTiZSbT3fFwEyTnV1TrJg
 hw96M2SI2moZM2QHTN9Gea5R+zeabc5vjVxriTpJGgAuq2FZ2b85GESuo3LMPGLCZXoZ
 B4bi9kpScFgNIZdJb4pfosHqTmXHJA2//0MuoiHTIuPH2b33x8b+FWT/yGsaKwY3mDOd
 JvxA==
X-Gm-Message-State: AOJu0YzmkylyUgTGkbgRacdW72lNkGP4YkntqKh5Forfap4qzNQ2K7TW
 02aLBfAqJZWXMf9qRaayHyVY9bvlA5IdQ2r4+y7opAa5rzb3a1JiE/3pLtnb4V/7IFbkkXhsvQB
 1NA/GzKPgaA==
X-Gm-Gg: ASbGnctKB0aRDWXGHssNUj1HCoz2V6+d0eqZfAyHNMtecKe/n5pRAP77oMplDZqD0KE
 99K8FPiqz2Nel61zR5jJI0B3zD+keuX32A8gcGibxLUGY4pnXmCd8XextGcJsnK1ymUKIX26i2a
 Iq8hkcTqinwFYNpMRBzmSziwbLvvagNom+PjCjAvX74QYhY28WVzLrcSVnVTWuSmdEpy+cCrpMj
 EXL6b3kO4QgSCagtUpoCea+oTH9awif0FypHvu+ecjgjhvbLdnNDMfbgGeS/DjxSQOvbeF4JN7S
 GAUohIoznCLb+rOcJKSZMH+t22PbFd0iw6ahqIT+HPQ523uf+dcCNx5V9wq5wN2c+YpYJuNrBRX
 trfupju/zRXdTNZ4a3NvyrJ4mx5HbJhEfsPzEfXCUPejqaX23m4wULHJ8hZVcOpHJh3n/96wu
X-Google-Smtp-Source: AGHT+IHJf+0m61SyO2IEvpL5iv0WY1aX9bf6TKuoaLoT101njPGF+yb1DPMLaM0QQooF74tyto0m6A==
X-Received: by 2002:a05:6000:2f88:b0:3ee:6fe9:418b with SMTP id
 ffacd0b85a97d-40e4c2d313dmr626257f8f.63.1758733265487; 
 Wed, 24 Sep 2025 10:01:05 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3fb8ebb0d91sm16160892f8f.54.2025.09.24.10.01.04
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 24 Sep 2025 10:01:04 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] target/alpha: Access CPUState::cpu_index via helper
Date: Wed, 24 Sep 2025 19:01:03 +0200
Message-ID: <20250924170103.52585-1-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
---
 target/alpha/helper.h     | 1 +
 target/alpha/sys_helper.c | 5 +++++
 target/alpha/translate.c  | 3 +--
 3 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/target/alpha/helper.h b/target/alpha/helper.h
index d60f2087031..604af4213c9 100644
--- a/target/alpha/helper.h
+++ b/target/alpha/helper.h
@@ -93,6 +93,7 @@ DEF_HELPER_FLAGS_2(tbis, TCG_CALL_NO_RWG, void, env, i64)
 DEF_HELPER_FLAGS_1(tb_flush, TCG_CALL_NO_RWG, void, env)
 
 DEF_HELPER_1(halt, void, i64)
+DEF_HELPER_1(whoami, i64, env)
 
 DEF_HELPER_FLAGS_0(get_vmtime, TCG_CALL_NO_RWG, i64)
 DEF_HELPER_FLAGS_0(get_walltime, TCG_CALL_NO_RWG, i64)
diff --git a/target/alpha/sys_helper.c b/target/alpha/sys_helper.c
index 51e32544287..a757a558900 100644
--- a/target/alpha/sys_helper.c
+++ b/target/alpha/sys_helper.c
@@ -73,3 +73,8 @@ void helper_set_alarm(CPUAlphaState *env, uint64_t expire)
         timer_del(cpu->alarm_timer);
     }
 }
+
+uint64_t HELPER(whoami)(CPUAlphaState *env)
+{
+    return env_cpu(env)->cpu_index;
+}
diff --git a/target/alpha/translate.c b/target/alpha/translate.c
index cebab0318cf..3e01bb36efa 100644
--- a/target/alpha/translate.c
+++ b/target/alpha/translate.c
@@ -1128,8 +1128,7 @@ static DisasJumpType gen_call_pal(DisasContext *ctx, int palcode)
             break;
         case 0x3C:
             /* WHAMI */
-            tcg_gen_ld32s_i64(ctx->ir[IR_V0], tcg_env,
-                -offsetof(AlphaCPU, env) + offsetof(CPUState, cpu_index));
+            gen_helper_whoami(ctx->ir[IR_V0], tcg_env);
             break;
 
         case 0x3E:
-- 
2.51.0


