Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 500CEC4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 14:29:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzdbj-0001bg-1Q; Wed, 24 Apr 2024 10:28:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1rzdbZ-0001b2-Bj
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 10:28:13 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1rzdbX-0002Kl-FS
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 10:28:13 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a4702457ccbso787486266b.3
 for <qemu-devel@nongnu.org>; Wed, 24 Apr 2024 07:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1713968890; x=1714573690; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=8URZwColG6b2Ul/T5fmUlC8IId+JoTiAiMuSRfn8IBU=;
 b=JO07uFz9wwV3U1o7feaWaNbhCKP7surDvlanWv/A0lGQH70joAwFuAGWxpccqljyKy
 kBHSBkrwQxhtNJy9geIgto52K2ecn/et8hLN+D0F2ghdiBJv7YnEgnH+7LcHCNIFlSji
 ZRS0WH9jKtLC+7BruSNRErg95FSNX1jRGxKk+43uWvo55aHooHfnrkpIb0/9Rds8ikWd
 TvEUAqE8QddCtFljYsdwAGJeUPE7KwVvTLcNS91stB2Hi/pLcqlKLvtyxGIa+L3r74BW
 VbEzDRHpWr0fd4heGL845L8whdQqzTeIfdl0cYAT4FR1N7wgIYEZoWxJDSFCFQ/q0Qwp
 Vu0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713968890; x=1714573690;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8URZwColG6b2Ul/T5fmUlC8IId+JoTiAiMuSRfn8IBU=;
 b=ayGBdpDKu0m7CXOXxZCwaXDR7Dqz8A4mMd9RfZl7S0Ozg5DrAtXKZ2kLQu2QO8K0h+
 ETvrdcwEZBgQVrEY4DTnSssvPIyuR+Q1kjkuORnNO6eVM3JJKg2UkTpgRXpSfHVIPOj5
 5MxeKCtIp+cHvcbU53Aj+cjGWvXCTUFiTUfphbMYg7x7OJUfTrw0BcB+BgmlwRlLlsB8
 SUJ3Bdzr2+65q0c5NI56tHURT8aNGuJ5hkCDIuNhUQfYYTaR1gxKfWIY4NA1ClsCE0Jp
 29zVFXk7VHfZ/OlX6wgxwV+6jlP1lKX5fMK5yOlUg28dkZA+dbtkSfOey2OH3wrYfjQc
 emLg==
X-Gm-Message-State: AOJu0YxHtbQAksXwRgn7VLUmupiWZu5CKNpA4VgQwx9F0/lfvZzQSOAL
 VAdz0AVUtMDEv8AcJxG76tOTNfAkImHLCLJrVqzrm7oAf37LXFmc/qTFtfGVi3dv1p1vnhIL6nE
 oamk=
X-Google-Smtp-Source: AGHT+IH00Fxyfl84ZXtXvBrogSIf5qxkA/jem/2CLo+aygJd+spu5wN2TVqQPLfQ4c3aNf/BaKsXwA==
X-Received: by 2002:a17:906:2412:b0:a55:a126:ac29 with SMTP id
 z18-20020a170906241200b00a55a126ac29mr1821992eja.62.1713968889840; 
 Wed, 24 Apr 2024 07:28:09 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz.
 [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
 by smtp.gmail.com with ESMTPSA id
 d18-20020a1709064c5200b00a587ba46e77sm2332650ejw.16.2024.04.24.07.28.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Apr 2024 07:28:09 -0700 (PDT)
From: Andrew Jones <ajones@ventanamicro.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: christoph.muellner@vrull.eu, palmer@dabbelt.com, alistair.francis@wdc.com,
 bin.meng@windriver.com, liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com
Subject: [PATCH v3] target/riscv: Raise exceptions on wrs.nto
Date: Wed, 24 Apr 2024 16:28:09 +0200
Message-ID: <20240424142808.62936-2-ajones@ventanamicro.com>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-type: text/plain
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=ajones@ventanamicro.com; helo=mail-ej1-x62c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 PP_MIME_FAKE_ASCII_TEXT=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Implementing wrs.nto to always just return is consistent with the
specification, as the instruction is permitted to terminate the
stall for any reason, but it's not useful for virtualization, where
we'd like the guest to trap to the hypervisor in order to allow
scheduling of the lock holding VCPU. Change to always immediately
raise exceptions when the appropriate conditions are present,
otherwise continue to just return. Note, immediately raising
exceptions is also consistent with the specification since the
time limit that should expire prior to the exception is
implementation-specific.

Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
Reviewed-by: Christoph Müllner <christoph.muellner@vrull.eu>
---
v3:
 - Sending again, hoping the ü remains in Müllner
v2:
 - Added #ifndef CONFIG_USER_ONLY around helper call

 target/riscv/helper.h                       |  1 +
 target/riscv/insn_trans/trans_rvzawrs.c.inc | 29 ++++++++++++++-------
 target/riscv/op_helper.c                    | 11 ++++++++
 3 files changed, 32 insertions(+), 9 deletions(-)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index 8a635238514d..451261ce5a4f 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -132,6 +132,7 @@ DEF_HELPER_6(csrrw_i128, tl, env, int, tl, tl, tl, tl)
 DEF_HELPER_1(sret, tl, env)
 DEF_HELPER_1(mret, tl, env)
 DEF_HELPER_1(wfi, void, env)
+DEF_HELPER_1(wrs_nto, void, env)
 DEF_HELPER_1(tlb_flush, void, env)
 DEF_HELPER_1(tlb_flush_all, void, env)
 /* Native Debug */
diff --git a/target/riscv/insn_trans/trans_rvzawrs.c.inc b/target/riscv/insn_trans/trans_rvzawrs.c.inc
index 32efbff4d5a5..0eef03383889 100644
--- a/target/riscv/insn_trans/trans_rvzawrs.c.inc
+++ b/target/riscv/insn_trans/trans_rvzawrs.c.inc
@@ -16,7 +16,7 @@
  * this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
-static bool trans_wrs(DisasContext *ctx)
+static bool trans_wrs_sto(DisasContext *ctx, arg_wrs_sto *a)
 {
     if (!ctx->cfg_ptr->ext_zawrs) {
         return false;
@@ -40,12 +40,23 @@ static bool trans_wrs(DisasContext *ctx)
     return true;
 }
 
-#define GEN_TRANS_WRS(insn)                                     \
-static bool trans_ ## insn(DisasContext *ctx, arg_ ## insn *a)  \
-{                                                               \
-    (void)a;                                                    \
-    return trans_wrs(ctx);                                      \
-}
+static bool trans_wrs_nto(DisasContext *ctx, arg_wrs_nto *a)
+{
+    if (!ctx->cfg_ptr->ext_zawrs) {
+        return false;
+    }
 
-GEN_TRANS_WRS(wrs_nto)
-GEN_TRANS_WRS(wrs_sto)
+    /*
+     * Depending on the mode of execution, mstatus.TW and hstatus.VTW, wrs.nto
+     * should raise an exception when the implementation-specific bounded time
+     * limit has expired. Our time limit is zero, so we either return
+     * immediately, as does our implementation of wrs.sto, or raise an
+     * exception, as handled by the wrs.nto helper.
+     */
+#ifndef CONFIG_USER_ONLY
+    gen_helper_wrs_nto(tcg_env);
+#endif
+
+    /* We only get here when helper_wrs_nto() doesn't raise an exception. */
+    return trans_wrs_sto(ctx, NULL);
+}
diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index f414aaebdbab..2baf5bc3ca19 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -380,6 +380,17 @@ void helper_wfi(CPURISCVState *env)
     }
 }
 
+void helper_wrs_nto(CPURISCVState *env)
+{
+    if (env->virt_enabled && (env->priv == PRV_S || env->priv == PRV_U) &&
+        get_field(env->hstatus, HSTATUS_VTW) &&
+        !get_field(env->mstatus, MSTATUS_TW)) {
+        riscv_raise_exception(env, RISCV_EXCP_VIRT_INSTRUCTION_FAULT, GETPC());
+    } else if (env->priv != PRV_M && get_field(env->mstatus, MSTATUS_TW)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+    }
+}
+
 void helper_tlb_flush(CPURISCVState *env)
 {
     CPUState *cs = env_cpu(env);
-- 
2.44.0


