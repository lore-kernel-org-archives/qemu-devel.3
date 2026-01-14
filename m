Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0B7ED31A09
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Jan 2026 04:50:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfsoy-0007Bj-Di; Tue, 13 Jan 2026 23:49:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1vfsoe-0006z6-Tm
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 23:49:09 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1vfsoc-00049o-P2
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 23:49:08 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2a0ac29fca1so52788535ad.2
 for <qemu-devel@nongnu.org>; Tue, 13 Jan 2026 20:49:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768366144; x=1768970944; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H0wkxMxuLksSJG2HBXSoSzL8cM026VEw8G4DFyhgQmI=;
 b=TjCWVlY7dAlCJ39fi7yO4XrV/ndWRP/ewTZeDhFqiE07XXamhtX2546FGbIu1gSDId
 atwvlckBZ3kkp+BohCrg+Lg5XRGrIZQQWLwf2Cwl44ispATh6S+gh6BpO/Gd0GmfA2Zo
 LCfDFvc+4n4gW8pH7mneiXYFOj/eJGI3f8in9DavhPyfZxWbtLAfUVAM3UDU3KFZz1RQ
 8uO5zqta+/+tjAjSYVd8ACsSVGGCdP1T27IKrcy2KxhC7ZBgXCp3UyKHtwQVPAaz9ewO
 gjPMKmd9RcTvWTEjKVfCfjSz4lknzXYv7w6CQ5CIxyxFqGipOw7FEzQk7MeOE6J2g+8W
 sNEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768366144; x=1768970944;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=H0wkxMxuLksSJG2HBXSoSzL8cM026VEw8G4DFyhgQmI=;
 b=n0YeIljTonuOZJXRtZEQvpNbkNxOSJTbRszaO+o233tI+7OdkNd0vpgtw6h+jrGRYO
 uO1k2nJMI7tzrsKrQt/6u9inuXeM9qnEgqmEGcbD2VXDJMenJn8KB2tULu2K+EMKBKnA
 cG7yUQmVf5wKwD/S3fRKIFfQwUxgNOsijDG0Jbm5OZsBGGULVqj+NsIraVt1t0z/Druo
 kHUEe9nvi57tLv/byhsus4X6eP3a+boTA+dnaChey/R6zYNnvy7fIv2tMVuWsHkk6Tr6
 dPNKTV9cPKDtawe8aiheDmA2On0UPUiRBPmRL9NWZqSm1rmbjq4Jvgqf/O27rElhU6mK
 TZNA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU53epFC64CtAnq6abp7fL5W34saSkwNChM/HfrvSSBPISA7PgHDjeNg4O6NR8z/L9MyMg1SHYVRQY5@nongnu.org
X-Gm-Message-State: AOJu0YzpF7V/j4NmTRwt/5jUQXfJBo3BLJ5WU9z73MULWlPvwjhFfXyY
 8BJW2pcVknWrYhWmZLKo3J8fI60aL2W+xIt1n2f1L0Ll4YNCi89uX+zg
X-Gm-Gg: AY/fxX6VjBFpUbI9pft90qX1hK9Yxf22X/S8n4laMbnm6g0O0VvypQg39Qp/+dy5IPt
 IVhbb9PxuDyvC1UdM5LAEFqRtcl4rPfukPZEBY7QxbL6/GK6xDCkA1a1IWftNsJUYCTHf6CiQ4q
 CN6LBDmiHY5JBUCyDVCthk6CUXPERRZD4Lw8D8qENjEkcJ2QOtQZKLbvs6mUMC1+BX5L9zJBMZQ
 D1+sFG3vFECopTmcV/C9ZzSXpitA9wKXgyDeOvnq3MROrzYQOBGPnu33Qtiuvcuc0md3O4r0H3n
 BNR2qVMTf68la+4exT/izVzgvgJw8WoLL4e905XQFhd1rB4rVDmpY7ZEMMdAGXlnL4LoxL4hD0T
 FLIc1eCkbAKXT+PTLva6lldm5yeKSmUou8GmsYDqaRyL+wxoIQanVR+vVucJqZ068CJAjon5pRk
 hmTuqc4gdCzTIQOjNvqQS24kyTCm6H9OrHBJOpFTWZeTdNmL8kdepj6OjF3R4=
X-Received: by 2002:a17:903:1b47:b0:2a3:bf5f:926b with SMTP id
 d9443c01a7336-2a599e8f884mr15538695ad.47.1768366144022; 
 Tue, 13 Jan 2026 20:49:04 -0800 (PST)
Received: from lima-default (123.253.188.110.qld.leaptel.network.
 [123.253.188.110]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a3e3c49037sm216111905ad.36.2026.01.13.20.48.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jan 2026 20:49:03 -0800 (PST)
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
Subject: [RFC PATCH 20/25] target/riscv/debug: Migrate mcontext using new
 sdtrig vmstate
Date: Wed, 14 Jan 2026 14:46:53 +1000
Message-ID: <20260114044701.1173347-21-npiggin@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260114044701.1173347-1-npiggin@gmail.com>
References: <20260114044701.1173347-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62d.google.com
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

The debug migration state does not include mcontext. Change to using
a new sdtrig vmstate format that allows for all architectural state
if mcontext != 0.

This means a machine is sometimes-migratable, which on second
thoughts is probably bad. Is there a better way to do this, or could
we just break compat and move to the new vmstate?

Not yet signed off.
---
 target/riscv/machine.c | 58 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 57 insertions(+), 1 deletion(-)

diff --git a/target/riscv/machine.c b/target/riscv/machine.c
index fdd5e8b67b..23a5f60d2a 100644
--- a/target/riscv/machine.c
+++ b/target/riscv/machine.c
@@ -221,8 +221,10 @@ static const VMStateDescription vmstate_kvmtimer = {
 static bool debug_needed(void *opaque)
 {
     RISCVCPU *cpu = opaque;
+    CPURISCVState *env = &cpu->env;
 
-    return cpu->cfg.debug;
+    return cpu->cfg.debug &&
+           env->sdtrig_state.mcontext == 0;
 }
 
 static int debug_pre_save(void *opaque)
@@ -273,6 +275,59 @@ static const VMStateDescription vmstate_debug = {
     }
 };
 
+/*
+ * This is a newer version of the debug (sdtrig) state, required
+ * to migrate hcontext/mcontext.
+ */
+static bool sdtrig_needed(void *opaque)
+{
+    RISCVCPU *cpu = opaque;
+    CPURISCVState *env = &cpu->env;
+
+    return cpu->cfg.debug &&
+           env->sdtrig_state.mcontext != 0;
+}
+
+static int sdtrig_post_load(void *opaque, int version_id)
+{
+    RISCVCPU *cpu = opaque;
+    CPURISCVState *env = &cpu->env;
+
+    riscv_cpu_debug_post_load(env);
+
+    return 0;
+}
+
+static const VMStateDescription vmstate_sdtrig_trigger = {
+    .name = "cpu/sdtrig/trigger",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINTTL(tdata1, SdtrigTrigger),
+        VMSTATE_UINTTL(tdata2, SdtrigTrigger),
+        VMSTATE_UINTTL(tdata3, SdtrigTrigger),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static const VMStateDescription vmstate_sdtrig = {
+    .name = "cpu/sdtrig",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = sdtrig_needed,
+    .post_load = sdtrig_post_load,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINTTL(env.sdtrig_state.trigger_cur, RISCVCPU),
+        VMSTATE_UINTTL(env.sdtrig_state.tcontrol, RISCVCPU),
+        VMSTATE_UINTTL(env.sdtrig_state.mcontext, RISCVCPU),
+        VMSTATE_UINTTL(env.sdtrig_state.scontext, RISCVCPU),
+        VMSTATE_STRUCT_ARRAY(env.sdtrig_state.triggers, RISCVCPU,
+                             RV_MAX_SDTRIG_TRIGGERS,
+                             0, vmstate_sdtrig_trigger, SdtrigTrigger),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 static int riscv_cpu_post_load(void *opaque, int version_id)
 {
     RISCVCPU *cpu = opaque;
@@ -514,6 +569,7 @@ const VMStateDescription vmstate_riscv_cpu = {
 #endif
         &vmstate_envcfg,
         &vmstate_debug,
+        &vmstate_sdtrig,
         &vmstate_smstateen,
         &vmstate_jvt,
         &vmstate_elp,
-- 
2.51.0


