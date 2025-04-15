Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13C37C369AB
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 08:15:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4bQE-0008CR-HX; Tue, 15 Apr 2025 04:13:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1u4bQA-0007y0-9o
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 04:13:31 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1u4bQ5-0001yJ-EG
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 04:13:29 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-227cf12df27so42209495ad.0
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 01:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1744704802; x=1745309602; darn=nongnu.org;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to;
 bh=nwKYDLJebV8nfrFMI0a6Dc+oBkaaAbOXeXeNO1BXXr4=;
 b=XEv8i/vA5KnGtlRWW+zSvY4uyu2VCSIVBF/yyW4kW7ExdPJUiLpfbzqUmEXE2ZIQrD
 HfMWgjd/MhyWN0libU4nBCfh37MaN9RS1lhJRiaTaZBN+GEgUUGUYrFnD8bOPDWzvGWY
 2p9y8nn6QPmJlt8MoJrXbSdNNoCWfiz7FppzQo7IUeOoaG3FBOsBkdTWPZyIJkhLBZ2P
 I5mhirUMZ1CEXU7e6GACkLefTal/4Xar4ThoFSMSsb8CTRcsQuMcLuSLf4P56teJmQql
 IWnC50vm2q000smrHtUQA0HtrL07Yf5yTUwvlPE3544xdEA/bsBFx8sS65VOTz83uUJd
 poSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744704802; x=1745309602;
 h=references:in-reply-to:message-id:date:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nwKYDLJebV8nfrFMI0a6Dc+oBkaaAbOXeXeNO1BXXr4=;
 b=tDeuhg3ULP2ov11p4kK+dyy3ivaHxyDYasTZPcdB0f5lpQXWQb1s6lDwc/iITftPh3
 CrNwzyGRMvfRi21U3pXe4B+nULuoDyY7ar0R1RaNkzYEns6j1CCMpHde1yJ3TCziTyns
 GqwTT9RoR6HJemfucCr2kKoDq8OMevtPYJYm06WYEcHrZAU64e4tENh1TCxYeIdn6187
 kJj3LLIyBMkIBGPVFYh5iXdz0227hvljVDyi5FAwiNl6W0uC3s0+A711MEsaqI0yJ4Ul
 BV4ftSTWHcvLmR7f+Em0V+iQg/xa4raTKOJGxt+Fr0g8G1qIrf4DokYkBzHsGo8u+nhU
 HlxA==
X-Gm-Message-State: AOJu0Yz/e2xjN6RtFh1MmH+WsmGyyshsKeOSUkWIeduPLwoa5wgy+rVQ
 G1YJK3Db490jrteJriwREtKXs9HF4KddG2y9XNR1D5qy5uFiSsewm1x+0ab5r7BACcJ0M8GNnw+
 bWTOdA2XygK912VbaTx0QiGCnPcrvws9Xf+2+Yl21mJmtQT7pUkZ5NUy79Gq7J2/gIOrQSlIIuF
 qApmP/ropEuhgmCRNsQZ2MoKoX0huj4oLjbP5v
X-Gm-Gg: ASbGncvqzlRJen7fHuehw4F1gdgs7SQ5cWtQ/GA4tJvMnOHu1cOfd/oMfJIO1Zbrecr
 MrkDCnEAtDsnJemLSQ5mjVT2tR7hLJ9atgBBLg9JYm5ws9oT36p0VI2fI2bJGiUR5cBx68m72fp
 be3/iVYfqE0ZUHN4+IZ3xYn3pMH7hSZVAruPScSURGLNEMMVSLobg1uXCS/BXd6u9yWP6KqcLRF
 DvqUOPg2trc3wJEQBdLFQ7Dfb/ThEIdQ49qKpzKsnzXCfVvtUBBigKBOpGBAqDGVLC5wKdAPcIs
 SOQcQzyqC+5KTDwr7peKbZauE7I6dp1YfK/0ZaE03XwKcRVIhed71qz8KtDQUas=
X-Google-Smtp-Source: AGHT+IHhrvH9XlXhAvlkmB4dmg5rWUKj4tV7WNnPYMhXKUjnS7+SRsMCzgnSdbDAMF3pjBVcH54UxA==
X-Received: by 2002:a17:902:d490:b0:226:3392:3704 with SMTP id
 d9443c01a7336-22c24984d71mr35601285ad.12.1744704801308; 
 Tue, 15 Apr 2025 01:13:21 -0700 (PDT)
Received: from hsinchu26.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22ac7c95cd1sm111082335ad.150.2025.04.15.01.13.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Apr 2025 01:13:20 -0700 (PDT)
From: Jim Shu <jim.shu@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Michael Rolnik <mrolnik@gmail.com>, Helge Deller <deller@gmx.de>,
 Song Gao <gaosong@loongson.cn>, Laurent Vivier <laurent@vivier.eu>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
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
 qemu-ppc@nongnu.org (open list:PowerPC TCG CPUs),
 qemu-s390x@nongnu.org (open list:S390 TCG CPUs),
 Jim Shu <jim.shu@sifive.com>
Subject: [PATCH 06/17] target/riscv: Add hard-coded CPU state of WG extension
Date: Tue, 15 Apr 2025 16:12:20 +0800
Message-Id: <20250415081231.21186-7-jim.shu@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250415081231.21186-1-jim.shu@sifive.com>
References: <20250415081231.21186-1-jim.shu@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=jim.shu@sifive.com; helo=mail-pl1-x62c.google.com
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

Add hard-coded state of WG extension. 'mwid' is the M-mode WID of CPU.
'mwidlist' is the list of allowed WID value of 'mlwid' CSR.

These CPU states can be set by CPU option, or can be set by machine code
via newly added APIs. If we want different WG configs of CPUs, we should
set it by machine code.

Signed-off-by: Jim Shu <jim.shu@sifive.com>
---
 target/riscv/cpu.h        |  2 ++
 target/riscv/cpu_cfg.h    |  2 ++
 target/riscv/cpu_helper.c | 18 ++++++++++++++++++
 3 files changed, 22 insertions(+)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 51e49e03de..ac50928b57 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -613,6 +613,8 @@ void riscv_cpu_set_aia_ireg_rmw_fn(CPURISCVState *env, uint32_t priv,
                                    void *rmw_fn_arg);
 
 RISCVException smstateen_acc_ok(CPURISCVState *env, int index, uint64_t bit);
+void riscv_cpu_set_wg_mwid(CPURISCVState *env, uint32_t mwid);
+void riscv_cpu_set_wg_mwidlist(CPURISCVState *env, uint32_t mwidlist);
 #endif /* !CONFIG_USER_ONLY */
 
 void riscv_cpu_set_mode(CPURISCVState *env, target_ulong newpriv, bool virt_en);
diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index a5b045aa2f..86b6240989 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -196,6 +196,8 @@ struct RISCVCPUConfig {
     bool pmp;
     bool debug;
     bool misa_w;
+    uint32_t mwid;
+    uint32_t mwidlist;
 
     bool short_isa_string;
 
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index f4c4b69a3c..2c3a0d903b 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -231,6 +231,24 @@ void cpu_get_tb_cpu_state(CPURISCVState *env, vaddr *pc,
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
 RISCVPmPmm riscv_pm_get_pmm(CPURISCVState *env)
 {
 #ifndef CONFIG_USER_ONLY
-- 
2.17.1


