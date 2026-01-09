Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A420BD232E8
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 07:03:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ve6Q3-0004ag-A2; Fri, 09 Jan 2026 01:56:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1ve6PW-0003qe-O1
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 01:55:52 -0500
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1ve6PU-0002qk-8U
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 01:55:50 -0500
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-7fc0c1d45a4so2298557b3a.0
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 22:55:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767941744; x=1768546544; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9GF62D8w+t5tOHjlaB64FQW97L9nZQ8HVKav0Ih1kSE=;
 b=BP1SQrlEQ4Ve2Fd7pK2rnqqFh/xRfhvcDqAnOBA8A5TaomuT7d6IF5K7w0e4mChTNc
 IfCYkUDOdXs1RGsHOkGWwPcnGGaWeJuxOuLU2+eGx8Ge8Gi5hvKZGl9KmbWjLQ8t+Fqh
 DIEa7Lq95r/8ys2CdXu0epLhktC1uiJ1/mtd47PP6tF1Cu6kPD9M4zq8WkeVqlDFeKqm
 nUPTOMZ2pdv0QLqwVtM357dy2IEYPTWsN5ZdKz6zMYWp3Q46WqZv0ipmg387Owl9lpqv
 OFa8c+1k5otOJAuIqCr1MoV4C51zzFqSE+bbf/m+O4+eN8tHmojW6VhUZgYUmAhsix38
 NOjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767941744; x=1768546544;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9GF62D8w+t5tOHjlaB64FQW97L9nZQ8HVKav0Ih1kSE=;
 b=mOD/UgIa+zBN0ZhgiJFndgiodgWgLoBOItHB1Bp9gGy1Zs+/OB3cozONC0yvQbeWYY
 YO6cLtpD5M6tbZOgTtaMGJ3D1tIjiZj8YG7rw22bAxXbW3rKg0KUqP7n+P7vVrL6CrFZ
 m33RHZgPTOXppMv2nqdJZ45KSly+V9gh3LMBQr+yOMNo08PtQkk96TB8QMCxbWLAO/pj
 hb9+a5j28GokLAd/Jr4xsw9XbBA9SuWenyo1YX03q/v3Otk4Zx3y0TqpfLX9lvcev9z6
 AZJJSmzECvqce9DNJtAPOHijHIOskGB8t4Bqs+EkMKN+3gqrjG4dvuaB9fuwQkjXDuHy
 bEvQ==
X-Gm-Message-State: AOJu0Yxisg7STlE8WkZd/jpZC15XT5DRdPyzwnWNOH2kIb0zVJfh8Im+
 vg2IZighs2hSATL31GMsVQSoE7OrisSfHO3jpHOrbdIRp/p1hGwcYjwTN2Al9Q==
X-Gm-Gg: AY/fxX6mC2A/P7t0XJUxQ3w/QC3CE1L+7iwIZTQKFPUe8VZBFzqgXpW+v1J64bPVNFk
 ZcSOwbhZEU1gnHovpxjblpyp/wn9aXeTEgFN9M+N8bcGW8PrRj385AzlOK3KcDHprmxwaCyHXg3
 LFtSLAwXRi8+0xf2EVei5P4FN0wOmcO94nq3BJH/4l/m7s9wjvsATZyuGsFJby6xicg6s59bJ+e
 F+eEFJa8EhXa52y0DsBqQZuIcpXRYTWMqCpIKQbc8D7SjcD51z5fWmUtbhp3x7R76XCV4CDe3i+
 FxyrdXX9sLU0oTM/EPAdlsx9wJJasPj2aLvzsIgXccZZJGnvDASDhfpIqjqv7JPCT8lq6jbNyBE
 SAhyks9TPnztLvXTLHDxYwKN90sI6zzsCJ5HwurSSiDxT1ycqZT10GKesVGQJx1hgUp+gERPbtv
 NonqJCrZzLLS2VN/LPcSyD0JwQuW4xkCQQ/NyZA3bQ4eKv2Ezt8KNvCV5RMVLuGURPQCSLNTcUM
 +DnNdkU9N7YBglOJy1Ifoo1yCwF5A==
X-Google-Smtp-Source: AGHT+IHaiFhlVPvuI/0Noe1aFcZRbU4Zd0Yfsj1KDOskTouUutP0rrg1kltZXzDxrWWUyoj9unawJg==
X-Received: by 2002:a05:6a20:2444:b0:366:14ac:e20b with SMTP id
 adf61e73a8af0-3898fa669d1mr8458828637.73.1767941744455; 
 Thu, 08 Jan 2026 22:55:44 -0800 (PST)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c4cc02ecfaasm9953644a12.14.2026.01.08.22.55.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jan 2026 22:55:43 -0800 (PST)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 11/34] target/riscv: Fix size of mhartid
Date: Fri,  9 Jan 2026 16:54:36 +1000
Message-ID: <20260109065459.19987-12-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260109065459.19987-1-alistair.francis@wdc.com>
References: <20260109065459.19987-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x435.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Anton Johansson <anjo@rev.ng>

and update formatting in log.

Signed-off-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20251027181831.27016-3-anjo@rev.ng>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20251103033713.904455-3-alistair.francis@wdc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h         | 2 +-
 target/riscv/cpu_helper.c  | 2 +-
 target/riscv/machine.c     | 2 +-
 target/riscv/tcg/tcg-cpu.c | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index bc6e093ca2..7b2c11af6b 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -280,7 +280,7 @@ struct CPUArchState {
     target_ulong geilen;
     uint64_t resetvec;
 
-    target_ulong mhartid;
+    uint64_t mhartid;
     /*
      * For RV32 this is 32-bit mstatus and 32-bit mstatush.
      * For RV64 this is a 64-bit mstatus.
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index c4fb68b5de..dd6c861a90 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -2280,7 +2280,7 @@ void riscv_cpu_do_interrupt(CPUState *cs)
                      riscv_cpu_get_trap_name(cause, async));
 
     qemu_log_mask(CPU_LOG_INT,
-                  "%s: hart:"TARGET_FMT_ld", async:%d, cause:"TARGET_FMT_lx", "
+                  "%s: hart:%"PRIu64", async:%d, cause:"TARGET_FMT_lx", "
                   "epc:0x"TARGET_FMT_lx", tval:0x"TARGET_FMT_lx", desc=%s\n",
                   __func__, env->mhartid, async, cause, env->pc, tval,
                   riscv_cpu_get_trap_name(cause, async));
diff --git a/target/riscv/machine.c b/target/riscv/machine.c
index f6ca017211..ab0bc32e1f 100644
--- a/target/riscv/machine.c
+++ b/target/riscv/machine.c
@@ -450,7 +450,7 @@ const VMStateDescription vmstate_riscv_cpu = {
         VMSTATE_UINTTL(env.priv, RISCVCPU),
         VMSTATE_BOOL(env.virt_enabled, RISCVCPU),
         VMSTATE_UINT64(env.resetvec, RISCVCPU),
-        VMSTATE_UINTTL(env.mhartid, RISCVCPU),
+        VMSTATE_UINT64(env.mhartid, RISCVCPU),
         VMSTATE_UINT64(env.mstatus, RISCVCPU),
         VMSTATE_UINT64(env.mip, RISCVCPU),
         VMSTATE_UINT64(env.miclaim, RISCVCPU),
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index bb03f8dc0c..cdc05f60e9 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -489,7 +489,7 @@ static void riscv_cpu_disable_priv_spec_isa_exts(RISCVCPU *cpu)
                 continue;
             }
 #ifndef CONFIG_USER_ONLY
-            warn_report("disabling %s extension for hart 0x" TARGET_FMT_lx
+            warn_report("disabling %s extension for hart 0x%" PRIx64
                         " because privilege spec version does not match",
                         edata->name, env->mhartid);
 #else
-- 
2.52.0


