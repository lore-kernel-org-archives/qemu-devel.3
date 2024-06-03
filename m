Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED397C25B76
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 11:22:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE5gx-0003xR-Co; Mon, 03 Jun 2024 07:17:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sE5gb-0003Kp-Ge
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 07:17:11 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sE5gW-0006AY-SL
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 07:17:08 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1f32a3b9491so31627075ad.0
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 04:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717413423; x=1718018223; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IQJJohChSJ2PfThq4oGFFdMUA1uJJ98Ep3im4MVkieI=;
 b=YkNByRgFLkSqqVR39eEOVsKaWCEHX2h11jbHza2IAu3iH6wLMZBzicEivo+G9968JY
 Sojctz3pF1jtMOCcjZVkffwDGon9X0bJ5p05vamJG7VMm8D+QXl10mEIJDZ8Q0sGHjoU
 gNT1VttppscY9kzMiToWqu/ZHDJ9gDO43Me2Qb1TSAg+aYKc1pvj8p55hSAjrijGw7j6
 2zD0n3ir5RpoCWl/7k3n6oKf+J656G8DMzwPe7dxJgo4dm+sVR/4XF8WFPQlnHOlvFKN
 BlF9E6BsXdjn7bS3pPWIcUusXm882giECWixe3DfASY29YeAAwc3QqYd3DgMHGV0BZnp
 hyMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717413423; x=1718018223;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IQJJohChSJ2PfThq4oGFFdMUA1uJJ98Ep3im4MVkieI=;
 b=v4s1KEKGkgZCqoB+kqA5JvuiiYcGcnQDbZhXhqGG33Hr0GeAShVb6L0oMdmmWp+vWd
 MYdhiWb+tT/3cTuvb69tszBZv45XKo+rMT4ihqJDtMcxG4Lv8zxgEY8lnLKPQ+x6A89C
 4Tc0mxcFq/3HaMmsBVY6LqAbMOJ+jkMXrmSD5QbfXBVKvSFcmqlJUdBKySluBZ5iYWFm
 ybszQU0/TjLHh8IB8VRzETWouh1tOZ74EKUvm2or5j3tFHmPw8TInK3TQ45mDE03YMi4
 hr2u5VU+s3wMVq7FceHKxjB3UoybiJAAqobQ0RT88LeNVVbhyjQB82hZO2hrBrADOdsK
 vScA==
X-Gm-Message-State: AOJu0Yyig1tLYxDHLaQ+2KyQHPUt//k2GND8Y9rY1Ft/zrBb6eeYc1uv
 QhQdqqV2unRYI88Rq750ggj2kAX8MO8rMZKCrw/YyzurSbqdknKISQ9JYw==
X-Google-Smtp-Source: AGHT+IFDcVN/Zi24+mlDpaNxKCLv7t6flHKhup9IN1B89YiNfP8b+LZ5Yk8tVoiNNf/93DuP1nas2Q==
X-Received: by 2002:a17:902:ea09:b0:1f6:677b:ea17 with SMTP id
 d9443c01a7336-1f6677bec49mr46363865ad.51.1717413423272; 
 Mon, 03 Jun 2024 04:17:03 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f6323e18c7sm62375435ad.177.2024.06.03.04.17.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jun 2024 04:17:02 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Andrew Jones <ajones@ventanamicro.com>,
 =?UTF-8?q?Christoph=20M=C3=BCllner?= <christoph.muellner@vrull.eu>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 03/27] target/riscv: Raise exceptions on wrs.nto
Date: Mon,  3 Jun 2024 21:16:19 +1000
Message-ID: <20240603111643.258712-4-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240603111643.258712-1-alistair.francis@wdc.com>
References: <20240603111643.258712-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x634.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Andrew Jones <ajones@ventanamicro.com>

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
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20240424142808.62936-2-ajones@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/helper.h                       |  1 +
 target/riscv/op_helper.c                    | 11 ++++++++
 target/riscv/insn_trans/trans_rvzawrs.c.inc | 29 ++++++++++++++-------
 3 files changed, 32 insertions(+), 9 deletions(-)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index 8a63523851..451261ce5a 100644
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
diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index f414aaebdb..2baf5bc3ca 100644
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
diff --git a/target/riscv/insn_trans/trans_rvzawrs.c.inc b/target/riscv/insn_trans/trans_rvzawrs.c.inc
index 32efbff4d5..0eef033838 100644
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
-- 
2.45.1


