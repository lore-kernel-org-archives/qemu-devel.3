Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EBD3C369C2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Apr 2025 10:55:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5MsS-0007cw-3U; Thu, 17 Apr 2025 06:53:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1u5MsM-0007X2-M3
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 06:53:47 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1u5MsK-0003Oo-5b
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 06:53:46 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-7376dd56f60so414698b3a.3
 for <qemu-devel@nongnu.org>; Thu, 17 Apr 2025 03:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1744887222; x=1745492022; darn=nongnu.org;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to;
 bh=nwKYDLJebV8nfrFMI0a6Dc+oBkaaAbOXeXeNO1BXXr4=;
 b=IuVNSOsKQ6zMRtyTx8/XKs+2edbSXgt++x/xSJZR15pqzdAqh0IBguK7AT93tjrI9N
 7NGWV33JlCcIADUNLeuYn1rPqNNyV+uyRcN1DbyyNWSScJVdWuK1hcB6K/IYOkRjFgaJ
 xgzmkQRTIFsNijS6TxUTSUhqgsOT7pYrNXWDIQKf+6iVj6PH3erb49vulv0msuOTgaoB
 xSuNTV1NJDWt1IHKSp4GndzayiROXW6iP+ooPIUzcajjvhYqmitFznMKL9hoOT3z8BaS
 peCQDtQ/Mfa5mRg8OF5I4oXkguf4vtyi+c/SmS+CVWu4zwqvdZkTqJhcncTdo87Lj2QJ
 Swuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744887222; x=1745492022;
 h=references:in-reply-to:message-id:date:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nwKYDLJebV8nfrFMI0a6Dc+oBkaaAbOXeXeNO1BXXr4=;
 b=efAJuvG7mFjHhy+OcVv7pkdWv1ZTv07qCGcw7RSH18+dUvLHk9SEXHYJyPmVIqtkDw
 jHYHN88l0rK1yvqyAOD2sa5tN83hS0f0loBkouQSw081xpLqS+Rmu2mOD9jPnRtp0NCn
 sUJpxjydgWR+32AAsaZn8Ks6lzvpw7TAoWUYmBcEn7D336lHHg/43gBxEZAKxpr8NqoN
 4LjQ3lDuUhtQcprnpg1sNY5f8xfDgOfaeXQvPeuiOuNpHHe2kk7Nr5mc5DC+RbJJiEjr
 fUyHOjv0sLI8bWpdPqw0buCLJE7FgD+Cgx++Bfy5hIxUcL7+ZsKPuLhawoja0BLr1zAB
 lnDg==
X-Gm-Message-State: AOJu0YxDnv/QM3IyvYAv9gpnxWD25+NZkIezLGkhHTLDOXMH8GD0nnG8
 0VIEhJ3CWvvdwnwsgVkOq7KQLGeHvXyH2V4fI4HEiRs6pVL/jDghuZCBgfhuXaVpSW1VltxM7Bo
 n/X8pXx2+zyJ9EgWZ1Ub/7M1kg+DUHq2oVH3PBFomk9ivO45puWzJOd13nngwD39QkNc9kkYGe+
 nQ8/mK/7Id+fRRv2bmUJLaY9pox2giaDWj/g==
X-Gm-Gg: ASbGnct3DwJRQIIsmva2xdbaIFhSkHs+2/Q15B4TQmGNR7Ay6DesBc/oos9Q9TcOr4K
 WU7M4gK4jrJ1ATB6lmJulhj48Q88uxwFTCjXS1fD/Jr1wEswbaam7qS14MjSvPLHku+8cVnozjC
 Tk9BBemoPwhegTCa78pZAWl0mxubxjjfRrDwEuN5qahiXDRO9eYFd5dSs7j5SH3LJMPEju2q0I/
 If5n9J1SfK+OC0KTYHOdnW0XUa2/+z02IptylRpOK5cEFxXmF1ZfqmkMj8byep/8KQnh90ODJIE
 eeUtn3+M3jPmNTCVy7Tr6Y75LITIO0/pujL34sH/VeQM/DLRLMvowPi3I9LVu68=
X-Google-Smtp-Source: AGHT+IEtAT+0wGCf8mT+gDNa+Ynb8Ljy3iul0+oHiooH2s8FGiapW9pti1/nUioVpzgnp2NNFNq2IQ==
X-Received: by 2002:a05:6a00:4501:b0:737:6d4b:f5f8 with SMTP id
 d2e1a72fcca58-73c267d36bdmr7470882b3a.17.1744887221840; 
 Thu, 17 Apr 2025 03:53:41 -0700 (PDT)
Received: from hsinchu26.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73bd230ddaasm12366251b3a.138.2025.04.17.03.53.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Apr 2025 03:53:41 -0700 (PDT)
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
 Nicholas Piggin <npiggin@gmail.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Max Filippov <jcmvbkbc@gmail.com>,
 qemu-ppc@nongnu.org (open list:PowerPC TCG CPUs),
 qemu-s390x@nongnu.org (open list:S390 TCG CPUs),
 Jim Shu <jim.shu@sifive.com>
Subject: [PATCH v2 07/18] target/riscv: Add hard-coded CPU state of WG
 extension
Date: Thu, 17 Apr 2025 18:52:38 +0800
Message-Id: <20250417105249.18232-8-jim.shu@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250417105249.18232-1-jim.shu@sifive.com>
References: <20250417105249.18232-1-jim.shu@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=jim.shu@sifive.com; helo=mail-pf1-x434.google.com
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


