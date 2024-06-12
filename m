Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7241AC27C53
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2024 08:16:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHJ8W-0002YJ-1V; Wed, 12 Jun 2024 04:15:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1sHJ8U-0002TN-Lm
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 04:15:14 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1sHJ8R-0006Oq-V8
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 04:15:14 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1f6b0a40721so47263005ad.2
 for <qemu-devel@nongnu.org>; Wed, 12 Jun 2024 01:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1718180110; x=1718784910; darn=nongnu.org;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to;
 bh=el4zPCh6MA7yt0wMvmZSek8pCRQ+TGyMHlmrAHD52rE=;
 b=IyjLIFnLWBqQEQf0CjX9WVC+1vXR0OLkkwm45PpzJnTG/iMacunwHpv+GTV9Y7VXoj
 H3SXzR2zfJp03hd7ZayRWZmJrGJkWAJfprb0FQSWBcyzNF2qw/tfd6xSLaMdMIziEWt0
 Bzfy/7Y3IRbUBj7/6A4fa+aZE42kP74izi88UGUrClJ7d/7RhPJ5DteHGOhsFSyvyLH0
 XysDDdbcvlFCODE4cH8mHHAaT4TKHJlX6ylaOYwSbVNUyydtQNn+b7RPmkBMJpNF3PGO
 R01+n7lKu5UmTvLBP+mE51DpEFW/yrschOtSJBL19lJUQu7iXbrtYAVFnyHP5DBXtV+a
 UnIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718180110; x=1718784910;
 h=references:in-reply-to:message-id:date:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=el4zPCh6MA7yt0wMvmZSek8pCRQ+TGyMHlmrAHD52rE=;
 b=rYrhayyx3NcQZZUsGbk3/hRq64WHUvVO+0v9wFYUW/dKOTOr5C+T+jmyEKpob2eEsQ
 n3r5B6+d3Il/Fsp8zDmUE+gARiRzZAmiR1aUtGYBWJ64hxZRxrueEIU4fXsOwyA+3/dG
 q4aXufMqxBU2wYp3gzC2CitTcpNxyabhzr8gfMX0+tJ2v5R5ELkR7/qpxW09SzP3DZcI
 QnxaH3ERbbZ3dDad8cOTWyv8RwHaD0qBs9nXtXGO596QaGFFKmDL3j9TnQdZv1T387H0
 wXTviC4XIwewb/15rS0vxzIMpMHig1BSo6vvYIArG3BSNGrZaZZq3pRDjYlzcFKrMFSr
 2/iw==
X-Gm-Message-State: AOJu0YyQ5US3plRfQ9c06SHuCiFC8jfnjFSrK0zlldgmd3HXK7/Hsu2G
 qFP/qACurIjwHpA0cyZKi5vF5jIqveQRd25DLTF72WPeFCJldwi50qbKjMVAnoJbQbRAWR+mPPT
 /XhweKbNRD+Q5/zYQDeI6bATPTJcdMJOFT3NWNnGymyBGxJ9oUSJJcRIlZ1WrRpNLHrcHEl5Y4R
 /0KH5zqJn9VkRYIdZo1J0xtDRoE3dR8y1FdWAIgx6AWA==
X-Google-Smtp-Source: AGHT+IFnhn4/AVuIA7BK0PPox1Lg0y+LEUdi4+TqzWjD8p+wIF7opIsUWNHMprWx0xcNxlpH593RHg==
X-Received: by 2002:a17:903:983:b0:1f6:39d8:dc4f with SMTP id
 d9443c01a7336-1f83b55f8ccmr14197785ad.10.1718180110071; 
 Wed, 12 Jun 2024 01:15:10 -0700 (PDT)
Received: from hsinchu26.internal.sifive.com
 (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f8393e8e53sm11363875ad.16.2024.06.12.01.15.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Jun 2024 01:15:09 -0700 (PDT)
From: Jim Shu <jim.shu@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Michael Rolnik <mrolnik@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Song Gao <gaosong@loongson.cn>, Laurent Vivier <laurent@vivier.eu>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Stafford Horne <shorne@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Max Filippov <jcmvbkbc@gmail.com>,
 qemu-arm@nongnu.org (open list:ARM TCG CPUs),
 qemu-ppc@nongnu.org (open list:PowerPC TCG CPUs),
 qemu-s390x@nongnu.org (open list:S390 TCG CPUs),
 Jim Shu <jim.shu@sifive.com>
Subject: [RFC PATCH 06/16] target/riscv: Add hard-coded CPU state of WG
 extension
Date: Wed, 12 Jun 2024 16:14:06 +0800
Message-Id: <20240612081416.29704-7-jim.shu@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240612081416.29704-1-jim.shu@sifive.com>
References: <20240612081416.29704-1-jim.shu@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=jim.shu@sifive.com; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Add hard-coded state of WG extension. 'mwid' is the M-mode WID of CPU.
'mwidlist' is the list of allowed WID value of 'mlwid' CSR.

These CPU states can be set by CPU option, or can be set by machine code
via newly added APIs. If we want different WG configs of CPUs, we should
set it by machine code.

Signed-off-by: Jim Shu <jim.shu@sifive.com>
---
 target/riscv/cpu.c        |  2 ++
 target/riscv/cpu.h        |  2 ++
 target/riscv/cpu_cfg.h    |  2 ++
 target/riscv/cpu_helper.c | 18 ++++++++++++++++++
 4 files changed, 24 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index d70eedf957..4e87fa4d5b 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -2291,6 +2291,8 @@ static Property riscv_cpu_properties[] = {
      * it with -x and default to 'false'.
      */
     DEFINE_PROP_BOOL("x-misa-w", RISCVCPU, cfg.misa_w, false),
+    DEFINE_PROP_UINT32("mwid", RISCVCPU, cfg.mwid, UINT32_MAX),
+    DEFINE_PROP_UINT32("mwidlist", RISCVCPU, cfg.mwidlist, UINT32_MAX),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 6fe0d712b4..2d3bfedbba 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -540,6 +540,8 @@ void riscv_cpu_set_aia_ireg_rmw_fn(CPURISCVState *env, uint32_t priv,
                                    void *rmw_fn_arg);
 
 RISCVException smstateen_acc_ok(CPURISCVState *env, int index, uint64_t bit);
+void riscv_cpu_set_wg_mwid(CPURISCVState *env, uint32_t mwid);
+void riscv_cpu_set_wg_mwidlist(CPURISCVState *env, uint32_t mwidlist);
 #endif /* !CONFIG_USER_ONLY */
 
 void riscv_cpu_set_mode(CPURISCVState *env, target_ulong newpriv);
diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index 23e779ae08..de9c134b15 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -166,6 +166,8 @@ struct RISCVCPUConfig {
     bool pmp;
     bool debug;
     bool misa_w;
+    uint32_t mwid;
+    uint32_t mwidlist;
 
     bool short_isa_string;
 
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 161df34626..ff20ab6ab8 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -149,6 +149,24 @@ void cpu_get_tb_cpu_state(CPURISCVState *env, vaddr *pc,
     *pflags = flags;
 }
 
+#ifndef CONFIG_USER_ONLY
+void riscv_cpu_set_wg_mwid(CPURISCVState *env, uint32_t mwid)
+{
+    CPUState *cs = env_cpu(env);
+    RISCVCPU *cpu = RISCV_CPU(cs);
+
+    cpu->cfg.mwid = mwid;
+}
+
+void riscv_cpu_set_wg_mwidlist(CPURISCVState *env, uint32_t mwidlist)
+{
+    CPUState *cs = env_cpu(env);
+    RISCVCPU *cpu = RISCV_CPU(cs);
+
+    cpu->cfg.mwidlist = mwidlist;
+}
+#endif /* CONFIG_USER_ONLY */
+
 void riscv_cpu_update_mask(CPURISCVState *env)
 {
     target_ulong mask = 0, base = 0;
-- 
2.17.1


