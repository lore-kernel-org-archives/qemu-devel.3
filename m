Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A757C44506
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 21:03:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiIHR-00063Q-2a; Fri, 10 Jul 2026 16:57:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wiIFb-0002Ng-7Q
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 16:55:13 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wiIFL-00011r-Gc
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 16:55:10 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-848595b338cso1566883b3a.0
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 13:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783716884; x=1784321684; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cta3/Q1WePeftyAZ1tIJUWYuQmdzSHeLF7F4WBnHI1o=;
 b=kL3e8RQT2PuGtHex3zHc0QwC112sBgvFQ9xtOa/jDPYMHyLmSsh6INZ0NiSZ9dyQjX
 XtzMHykIdG9+bsmyku3hPWPs/3EiGgBHVOgXCcGd+h1T0Lr6I0K4Mt4yn25+w3isr5+H
 d3DCFF0HDUuaM082pxZn5T1zyG/LbRiAjcLGAxDeTiRCYqsLT9YBGiHlP5nvD8v+82vl
 8C4e/ZwcMDshyukvCvsbjHPSs+cMFuqYfvACsr26BESF4K5N7epRAXnAAgExex0Gs88e
 VipWlhX+sPKy2PY303JGatHZO/tYP4CgzNVjhJadj2c6jSwG4OMDiEL7EOWo8lby2kEj
 glxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783716884; x=1784321684;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=cta3/Q1WePeftyAZ1tIJUWYuQmdzSHeLF7F4WBnHI1o=;
 b=sS2p0e22Q2onnpPg5zsN1534yT5A2gMkZbHFXF7GLqGfTc+CHVaucYlP2JK2MN12nZ
 EM3MqQGUZZEtSAvi9Tkv10RWtqdZqNsdjqHcpHSWKKbr8rWyMWxZeeYQMDuq8/6Ip47w
 p5+vNsshfLOPBfdxMIPP7S5F1MW3eSijvrHsfOutKivCD0UbKWGnWkDOaHB0sA0n5QJX
 GVg5vDMaLVq4NsQ9AVkrvyaQhGZnCwvQS18jqdwgh9ze0JSsRXuCcj0N1DwAOILas5Cp
 ypw5Usf7ag1lZzMA3yyNQsaj32CJmrB23xyvIc8lLn65RkWnQfe46aaxSQpEKnRNBC4r
 F6Mw==
X-Gm-Message-State: AOJu0YyUQP1RGb2hLGFxhlQp1oXuWpQl2SRFb4uXl6Df9aiP16R9S3eL
 hm5mDBaaBMcHprP47op3H9jBe4nho+jUl7M/NzerrqV9IFIf+gjviArVOv8yaMUeP8LjSeE273j
 LhOqT
X-Gm-Gg: AfdE7clcLueTtsLfeQ5A7dbBl1cVbILACLKX/Ot69koaCuhrcfb3YXvhoL7OhAk/Ryn
 BAcsNnIzF2QEoQxpYccshaFUiW78pmF5qkcBesw+5vWve6d6iadBHOGak0p5VYchWYnCKzA6rIW
 zVLV3do5DlbIuCs/XE6TpjnCatY34RSur0j0o92e3h3/rmYpCa1VZ5OkHITlRzx28jFZx3baFFN
 yEoP6grkETG6Fke2GqZ1pt2tPmcCoyPhZgEwxeAwXghHqzNev9QwZbydCEDO08SqCj+uJi+KNV4
 il8yN+uEWObrM/D0MZcP7fOEeo35DmOxSn/JYIxh2o+WaOcGK7TrZB/cpyf7FjH9mgUM4DlxfNI
 Qm+s7JAbJ8TXn2xtHtkNRdR85/Jsm9Zk1Ch+lWzS52FOczICpEgTtLW1W1Hco921PV423wFYL6R
 pi8GBdXsKDp82CPmWmbg==
X-Received: by 2002:a05:6a00:bd91:b0:848:731a:fa55 with SMTP id
 d2e1a72fcca58-8488974b0fdmr494515b3a.48.1783716883761; 
 Fri, 10 Jul 2026 13:54:43 -0700 (PDT)
Received: from stoup.. ([71.212.146.49]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-847f6d76106sm10780574b3a.40.2026.07.10.13.54.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 13:54:43 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org, jcmvbkbc@gmail.com
Subject: [PATCH v3 39/51] target/xtensa: Rename xtensa_breakpoint_handler
Date: Fri, 10 Jul 2026 13:53:49 -0700
Message-ID: <20260710205401.836304-40-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260710205401.836304-1-richard.henderson@linaro.org>
References: <20260710205401.836304-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 SUSPICIOUS_RECIPS=2.51 autolearn=no autolearn_force=no
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

Rename to xtensa_cpu_debug_excp_handler, since it also handles
watchpoints, and that's the name of the tcg_ops cpu hook.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/xtensa/cpu.h    | 2 +-
 target/xtensa/cpu.c    | 2 +-
 target/xtensa/helper.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/xtensa/cpu.h b/target/xtensa/cpu.h
index 119a0b8187..928d300772 100644
--- a/target/xtensa/cpu.h
+++ b/target/xtensa/cpu.h
@@ -592,7 +592,7 @@ void xtensa_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr, vaddr addr,
                                       MemTxResult response, uintptr_t retaddr);
 hwaddr xtensa_cpu_get_phys_addr_debug(CPUState *cpu, vaddr addr);
 bool xtensa_debug_check_breakpoint(CPUState *cs, CPUBreakpoint *bp);
-void xtensa_breakpoint_handler(CPUState *cs, CPUBreakpoint *hit);
+void xtensa_cpu_debug_excp_handler(CPUState *cs, CPUBreakpoint *hit);
 #endif
 void xtensa_cpu_dump_state(CPUState *cpu, FILE *f, int flags);
 void xtensa_count_regs(const XtensaConfig *config,
diff --git a/target/xtensa/cpu.c b/target/xtensa/cpu.c
index eb6758b694..82b7493ff4 100644
--- a/target/xtensa/cpu.c
+++ b/target/xtensa/cpu.c
@@ -330,7 +330,7 @@ static const TCGCPUOps xtensa_tcg_ops = {
     .do_transaction_failed = xtensa_cpu_do_transaction_failed,
     .do_unaligned_access = xtensa_cpu_do_unaligned_access,
     .debug_check_breakpoint = xtensa_debug_check_breakpoint,
-    .debug_excp_handler = xtensa_breakpoint_handler,
+    .debug_excp_handler = xtensa_cpu_debug_excp_handler,
 #endif /* !CONFIG_USER_ONLY */
 };
 
diff --git a/target/xtensa/helper.c b/target/xtensa/helper.c
index aa012068de..7643e97b2c 100644
--- a/target/xtensa/helper.c
+++ b/target/xtensa/helper.c
@@ -220,7 +220,7 @@ static uint32_t check_hw_breakpoints(CPUXtensaState *env)
     return 0;
 }
 
-void xtensa_breakpoint_handler(CPUState *cs, CPUBreakpoint *hit)
+void xtensa_cpu_debug_excp_handler(CPUState *cs, CPUBreakpoint *hit)
 {
     CPUXtensaState *env = cpu_env(cs);
 
-- 
2.43.0


