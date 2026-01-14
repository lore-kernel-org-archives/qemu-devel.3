Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58C0BD31A0E
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Jan 2026 04:54:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfsnX-00042y-Ub; Tue, 13 Jan 2026 23:47:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1vfsnQ-0003qi-Ek
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 23:47:54 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1vfsnN-0003lc-BL
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 23:47:50 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-29f102b013fso75525605ad.2
 for <qemu-devel@nongnu.org>; Tue, 13 Jan 2026 20:47:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768366067; x=1768970867; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=67A9pmsOmD3VIwoIzZX+CzBTINC+AlN1BFRXkGK7aDA=;
 b=JoeFtqSX3yKGlbS8jfuLpXY3e9/a5ytCRHqOSVrLDeRMaA7pZLRvAl07n2Fx/KxfcH
 9RTEy9KW+HFqwxmiUM/hEhJXX210094/SSjmjzYGSd1L/cvzMZOPiVnNUOj0/r2f3MEc
 wU3vAOOUowsFeyhKOGSFhZwKH+tmvfeAfiYk70CIsyG7rdjVAuAf2VykhxpvMsUwDXLI
 2aIPG7tdZwzkSil+Ymj/WECtUTmAUfeaRd+gzzRHQ6YChoAYZt8lhXYMNCUy7IXvmUqp
 LiqUZ4TW45/TAfkSzUaCxUkG48rNQGipduqxe3k9bE6Aqj5+9IckOSYn/ktKXWbwvMLz
 7HTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768366067; x=1768970867;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=67A9pmsOmD3VIwoIzZX+CzBTINC+AlN1BFRXkGK7aDA=;
 b=eYq49f3wGTASxPNFAZkWkYmf2xovKnXUSnmCc6UNWF/Pa2GlG1X9DCvAJAwXzdKTb5
 h0MhmliFmmALPpqKIh0/R4lLpU/8m4MVsMxcFvrvoAHByHoBhM4U03HHwhk2AY3A7ac8
 a959sFy2ZixVd2ToJXel8IR61yfiLc2SLt7+2TETkEBdg52WlpEpV6ALwwAXTaxIYG41
 6jVxzhkhcgd3ucwogysBv6KrMM9RWUNoTGh4gD1g+Tq6P/GANTJSJeCZaO2k4gSUVBk7
 KstQF6UgTx4QYFfgV7HYryLkhOB5+2vSc/YdtunfEWOeobGky9Syy6cH9XaEYcGew11X
 612g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVjeb5Hk2GyZjvQg5W1PhhzRi1GUczAIW3mKOQN95aGEfQ0MZytJU64P23zsIr98Q2Z2PHOnv/kc5lH@nongnu.org
X-Gm-Message-State: AOJu0YwM+Vj5l8xUHfQ3i8m1b29ATaSaFdpEhQfoYTBpRwWcURvMYx0m
 OmfRkePDcROsx0E08yte7iIeTd3znoXzoaJxXeHh9i1dIruI9r75CQJg6csSEg==
X-Gm-Gg: AY/fxX6uDNwMTcmrdFOrClTFx7kAxiCVSX9Gw4aXG/PMsf3zfCitW4Fo/CcPfwb46oc
 kY55kneppj1krFYtjx6a0lyq6GCMwn9s5BjR10+dl2CTMd1zUFspiu9TLDDsqD7EPv+GgMKmLYd
 QFDmmxTnZPQWDucDJjin8C+cmcFXR6MxiRZazT3z2FvAgp7YFEeO7Uo2ENiQWeG/3DxuzlUCFo2
 dUSb1dqRTI0eCU/A6nBn2gqkR1o5AXq0ibHVK/mEfwFnvwtGKSKKzdDYycHmOVJh6xk+jD7mnjP
 PjMwiBulN942HAbhKlbaq9Cssz0LWXYnL+8lwNtb5DQJqhfJiYfgrZ90xgCPn77nEM7kdZjhORY
 HEabnTrS3SsO8Vgmr8zzw4EiFf9hhe+cbLRwhEDSr0rJmJ4qQ5Fj5j5x7PjSDeEOZy0IERXdOff
 xIowbdG/dYMrt7SqXd3a1P/uP0YEg9ntiyaLfXhErog7rvzc6o31MiTtLTFWF0wHnMf2/YTQ==
X-Received: by 2002:a17:903:b84:b0:297:e3c4:b2b0 with SMTP id
 d9443c01a7336-2a599e56a0fmr15606515ad.54.1768366067440; 
 Tue, 13 Jan 2026 20:47:47 -0800 (PST)
Received: from lima-default (123.253.188.110.qld.leaptel.network.
 [123.253.188.110]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a3e3c49037sm216111905ad.36.2026.01.13.20.47.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jan 2026 20:47:47 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, bin.meng@windriver.com,
 vivahavey@gmail.com, Alvin Chang <alvinga@andestech.com>,
 Yu-Ming Chang <yumin686@andestech.com>, Joel Stanley <joel@jms.id.au>
Subject: [RFC PATCH 05/25] target/riscv/debug: Update itrigger_enabled after
 changing privilege
Date: Wed, 14 Jan 2026 14:46:38 +1000
Message-ID: <20260114044701.1173347-6-npiggin@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260114044701.1173347-1-npiggin@gmail.com>
References: <20260114044701.1173347-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

The !icount_enabled() path should update itrigger_enabled after changing
privilege, which can change whether or not an icount trigger is enabled.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/riscv/cpu_helper.c | 7 +++++++
 target/riscv/debug.c      | 7 +++++++
 target/riscv/debug.h      | 3 +++
 3 files changed, 17 insertions(+)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index dd6c861a90..e096da939b 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -1030,9 +1030,12 @@ void riscv_ctr_add_entry(CPURISCVState *env, target_long src, target_long dst,
 
 void riscv_cpu_set_mode(CPURISCVState *env, target_ulong newpriv, bool virt_en)
 {
+    bool change = false;
+
     g_assert(newpriv <= PRV_M && newpriv != PRV_RESERVED);
 
     if (newpriv != env->priv || env->virt_enabled != virt_en) {
+        change = true;
         if (icount_enabled()) {
             riscv_itrigger_update_priv(env);
         }
@@ -1075,6 +1078,10 @@ void riscv_cpu_set_mode(CPURISCVState *env, target_ulong newpriv, bool virt_en)
             riscv_cpu_update_mip(env, 0, 0);
         }
     }
+
+    if (change) {
+        riscv_cpu_debug_change_priv(env);
+    }
 }
 
 /*
diff --git a/target/riscv/debug.c b/target/riscv/debug.c
index 2effbb49af..51c5934bfa 100644
--- a/target/riscv/debug.c
+++ b/target/riscv/debug.c
@@ -1090,6 +1090,13 @@ void riscv_trigger_realize(CPURISCVState *env)
     }
 }
 
+void riscv_cpu_debug_change_priv(CPURISCVState *env)
+{
+    if (!icount_enabled()) {
+        env->itrigger_enabled = riscv_itrigger_enabled(env);
+    }
+}
+
 void riscv_trigger_reset_hold(CPURISCVState *env)
 {
     target_ulong tdata1 = build_tdata1(env, TRIGGER_TYPE_AD_MATCH, 0, 0);
diff --git a/target/riscv/debug.h b/target/riscv/debug.h
index f76b8f944a..5a14b7894e 100644
--- a/target/riscv/debug.h
+++ b/target/riscv/debug.h
@@ -153,4 +153,7 @@ void riscv_trigger_reset_hold(CPURISCVState *env);
 
 bool riscv_itrigger_enabled(CPURISCVState *env);
 void riscv_itrigger_update_priv(CPURISCVState *env);
+
+void riscv_cpu_debug_change_priv(CPURISCVState *env);
+
 #endif /* RISCV_DEBUG_H */
-- 
2.51.0


