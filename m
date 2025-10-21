Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9226ACCD1A7
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 15:58:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBEj8-00017M-Cc; Tue, 21 Oct 2025 11:56:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1vBEj5-00016O-Ux
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 11:56:44 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1vBEj2-0007pp-Ma
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 11:56:43 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-33db8fde85cso2402224a91.0
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 08:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1761062198; x=1761666998; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f5rIQfR0LdOWH1gZfogqGGKNzbK2Da+vWsJhiDZXltU=;
 b=ettL4Yk386GxmCiHsIok/lq9fRLGJyfMNTGpUdWsdZJnZt9UkXgJQj4aQ+UbCEN6Kw
 sfbnlcqLc8Wo3RyJx15q//eBipexm0TVrttdbXWc8BQLWqdWARFqDSHS68NzF/I/2WJD
 fBW7RvQN/u6W+X2jSCGORTfglLf/EFrJP5iZAmdnzUj7JhShNAkOY8hCky9q/lp8BWDD
 gax///jWDHlFXpehojQPZYqSkIhHVXudV6oZA2VgQSdIFYpoSzXcoJc/BRK2AKG3M+wO
 7yS8HuOLTXP/P7xzV9fBxb/mYXM3IWnkZM8zWgf/KST1wxqDWefcuuR6/VpWYhn6G8eP
 UlKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761062198; x=1761666998;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=f5rIQfR0LdOWH1gZfogqGGKNzbK2Da+vWsJhiDZXltU=;
 b=qiB0fP8exmcVXBJO+R3aYRjE5MHWx7J1wU7SViVq5gn/AmzsbBy28KYdbiJnUzxbb/
 4l3jBgYCEOcj5LxWEFVWmQFESGpuz2/eHLERlpMCApFw4NiBqWJNOl+Kro41CnMvoiB6
 jAya4ZWvC2Ev+001JgZvaR+kigIMOSXQxisJHv/fklh+1svgBE9GB6HsFpFj1bQnY8AK
 759Z8TLDyKOg7eOPX9SDQHGDO9ZFeV4NsS7FuCccQNRlniLdvpmA46XnnG43PDCWAo/9
 91+37bS8pA1crGQSXEFtwSi7SpJprj60wx2iUdLctJlHodcWdK9VpFzS6f/MPSdTbxA1
 Bbeg==
X-Gm-Message-State: AOJu0YyeUC5m8yCgOHMCiGGPA/TGbi1BbIfepu4HqGmib+Oao1VVTCEE
 oqAsE4W/C7MY7okUQj+d1m38/8G9RZzVNleFfkV4WbCuXU6ZYkmdA4kJ2XjuSyYd1/M26RSjBir
 Xokb6JNDthQCMC+ROXC3poSGbAUHaaK38c0RMcFo5alyhaKC3TQUDNauaLndzglnlaHreDkiuQN
 NHrRMaWJSAjlIzDChoQLTNLgj4lPrLLzzT1t1gdQ==
X-Gm-Gg: ASbGncsf7rPeukMGB2KZpyulX2xmVazAe2+VaIAZCQJsOYoua61V7LD04/r5+TUmPAw
 7+1MMXTDNG5JuQt9ilzR1JSwRPT0w6XA2GWiGXQZ9R25wuhgfCxsc3B3YYF/w5FHr+4rGgqGbLV
 R22SyCs9GIvUP4/t6eEVYwUCxFm086zRPgOnLeB4b2spm9sMWNuGLi5Tl2cZCblQDHIUhDYOLPK
 5fo9ku1q/MLEaaKgW9Z21eyV7G/80QgcyeGHcAqWGvv9O0wh86OSrU8qMrvTL/gvIPw17Y2j4nJ
 T6sC1BToNBSjCA5OVD33g55A2uDXVdT4vbGsyr/uKeqDEjJrsh+v0hxDizxzivUyR3ybbl5ynox
 cAg/CJ6Cfo2FftajecZEpz/jkyT7klAYG2KUlfKh5D7EBGfOYAc86AZJf1b7l84msFmwQS4EbIz
 g56oy2IZmVdqZ9LOvMiJvtvK2PhphsWWap
X-Google-Smtp-Source: AGHT+IE3tDh4RrsD3PH84nIuLTMEa7pF2YbSrTFf2kInDR0bGp+RFzhwLSvuVo5UCnBak6GN00VnHA==
X-Received: by 2002:a17:90b:4c92:b0:32e:32f8:bf9f with SMTP id
 98e67ed59e1d1-33bcf8f9960mr20847794a91.30.1761062198330; 
 Tue, 21 Oct 2025 08:56:38 -0700 (PDT)
Received: from hsinchu26.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-33d5de11392sm11490177a91.7.2025.10.21.08.56.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Oct 2025 08:56:37 -0700 (PDT)
From: Jim Shu <jim.shu@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Michael Rolnik <mrolnik@gmail.com>, Helge Deller <deller@gmx.de>,
 Song Gao <gaosong@loongson.cn>, Laurent Vivier <laurent@vivier.eu>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Stafford Horne <shorne@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>, Chinmay Rath <rathc@linux.ibm.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Max Filippov <jcmvbkbc@gmail.com>,
 qemu-ppc@nongnu.org (open list:PowerPC TCG CPUs),
 qemu-s390x@nongnu.org (open list:S390 TCG CPUs),
 Jim Shu <jim.shu@sifive.com>
Subject: [PATCH v3 07/18] target/riscv: Add hard-coded CPU state of WG
 extension
Date: Tue, 21 Oct 2025 23:55:37 +0800
Message-ID: <20251021155548.584543-8-jim.shu@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251021155548.584543-1-jim.shu@sifive.com>
References: <20251021155548.584543-1-jim.shu@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=jim.shu@sifive.com; helo=mail-pj1-x1033.google.com
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
 target/riscv/cpu.h                |  2 ++
 target/riscv/cpu_cfg_fields.h.inc |  3 +++
 target/riscv/cpu_helper.c         | 18 ++++++++++++++++++
 3 files changed, 23 insertions(+)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 4c13012442..b121e3bca9 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -654,6 +654,8 @@ void riscv_cpu_set_aia_ireg_rmw_fn(CPURISCVState *env, uint32_t priv,
                                    void *rmw_fn_arg);
 
 RISCVException smstateen_acc_ok(CPURISCVState *env, int index, uint64_t bit);
+void riscv_cpu_set_wg_mwid(CPURISCVState *env, uint32_t mwid);
+void riscv_cpu_set_wg_mwidlist(CPURISCVState *env, uint32_t mwidlist);
 #endif /* !CONFIG_USER_ONLY */
 
 void riscv_cpu_set_mode(CPURISCVState *env, target_ulong newpriv, bool virt_en);
diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_fields.h.inc
index 44387a8db3..ba309d9c32 100644
--- a/target/riscv/cpu_cfg_fields.h.inc
+++ b/target/riscv/cpu_cfg_fields.h.inc
@@ -172,5 +172,8 @@ TYPED_FIELD(uint8_t,  pmp_regions, 0)
 
 TYPED_FIELD(int8_t, max_satp_mode, -1)
 
+TYPED_FIELD(uint32_t, mwid, 0)
+TYPED_FIELD(uint32_t, mwidlist, 0)
+
 #undef BOOL_FIELD
 #undef TYPED_FIELD
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 63acd70543..d2be660d58 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -135,6 +135,24 @@ bool riscv_env_smode_dbltrp_enabled(CPURISCVState *env, bool virt)
 #endif
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
2.43.0


