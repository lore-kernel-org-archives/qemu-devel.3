Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67038E83840
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Feb 2026 22:53:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vs7TJ-0003Ds-Uo; Mon, 16 Feb 2026 17:53:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vs7TC-00034d-D0
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 17:53:34 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vs7TA-0006eJ-Ch
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 17:53:33 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4836f4cbe0bso25767855e9.3
 for <qemu-devel@nongnu.org>; Mon, 16 Feb 2026 14:53:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771282411; x=1771887211; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z4b7EKIXUxIIWUL8kF3shWPR4w8ejLWmhqz7rlqrrl8=;
 b=hFYSWW6eJjSmR+pHPpMb3g0zGZ9OhhpNpedB3U68f3vD4XtJmTQa22/pRi6ip7ehe4
 DWjhFS97+M4emOgEZgNRONV8pHeiy4orrgYprGu/uTxaLyJ733ZpCvfwL7BVLQ/PAZNN
 iXBaba86cWxW9NSY6i52ODb8z97XCd8HnKqvTW6jX6PRlFY0czMlfap8uEZr7uBM35i2
 cP9qdWxj/henB8TeE7cf9LwlOBZrVgP38VrmPcT/DtXK9LcqqKGqWJxvSGRLMT8YWAi5
 rSbcmDLmnY6A/htTpQrAOalrFDjO70/qJZ8OUQxQ/g07rkS+ozWHsgg1jQgKsqfATkvn
 4L0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771282411; x=1771887211;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=z4b7EKIXUxIIWUL8kF3shWPR4w8ejLWmhqz7rlqrrl8=;
 b=CievFM0W0JQ1Ck9QppZzb9bcN4gYp6DAkbLiK8MXuJqoW84jpA13PfW+AeHz/dPNWl
 Oy1Lwsb+KJuR7oT6FgKDTMcfaN2vTRZe+8biH+LLuNpWNtdY/S2hSb4OOvkcQ21lg8bK
 uT/3YtZOeTStpo4cgJPWyC095z4oem14DjZgZC9rLI8ndWzqOELiT3nKbWwVErlZNXTL
 dik2z0QF3liEa8zWT+xvyDQUKD/26SsgBkDZkX1zxWc3LlQxq6XTGbkdCJT2wQ3BdrYg
 0QMTP32QE7yWhNBQIlPDuIly7BqNjEGV+v7M+AGi8y80D96JY/kUrq7xE20m8epX+JTY
 03Iw==
X-Gm-Message-State: AOJu0Yw9fzsCa3AqOIaFHgLlXcf7N9qKG51i3DVJ0PEhbumBjPUsc0VA
 xpGDGKKNthE9YKQ0B7HKBSi1Yn4eXIGlFvJcZCF72hFPOf3Q9xY9km57T0KE5pLV4LZJdbBnDMc
 CBbYYK+A=
X-Gm-Gg: AZuq6aJjKvtinI2yqd/VGKl0jqctyCWeUvxUE9shxcgcMqDBbT+dKRW7HT8BtiJmxAz
 wwvTB88Qbv2HMPv2scWfiIQD7g4GjADIp/WJ1yhw9JRHhC1gzRmoIdkvvwltD6EUeIdfChn44PX
 Q4mgclx++OFGeno9ih3U4lTn+gtxqaMEciRG9FjRPXZn4Mk4DZW6te32A4KM+rOTcDCRcwBpDtE
 UantCIHg1nkDS3IMjzg8p0/3HEZfxdJdWXgCbk8xQTJyQ1AqrhL9C+xhTEX85ysmL7Xt6HAyC5H
 RayZ7qylV5SyYOdx53OyPbnFLQ0V/XAEJ0zyYznqZ3dB3a5pfI2GgF/jJv4R+OWu24tCN8IUc90
 WrMRyvbEVLE/aB6ivUrb25jl6Yaqy1XlQTg1zniIps5gqrQBF24T1XuTPDa1h0J+4v6HoKlyCVN
 83QwxjApI1QYsruwEijMhwXEl/MCIrBPZkw07veXe3r1QeBkSRuW1nKoo4bQ8F/lOxuTHxV31As
 GuoqXkV3AY=
X-Received: by 2002:a05:600c:3e05:b0:480:1e9e:f9b with SMTP id
 5b1f17b1804b1-4838dbae8b7mr39855925e9.16.1771282410582; 
 Mon, 16 Feb 2026 14:53:30 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4835d99e194sm356624765e9.8.2026.02.16.14.53.29
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 16 Feb 2026 14:53:30 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Nicholas Piggin <npiggin@gmail.com>, Chinmay Rath <rathc@linux.ibm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, unisono@quyllur.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-ppc@nongnu.org
Subject: [PATCH 08/11] target/sparc: Remove MonitorDef register entries
 available via gdbstub
Date: Mon, 16 Feb 2026 23:52:24 +0100
Message-ID: <20260216225228.53959-9-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260216225228.53959-1-philmd@linaro.org>
References: <20260216225228.53959-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

All these registers are already provided by via gdbstub parsed XML
and handler by the gdb_get_register() helper in the monitor/hmp.c
file. Remove as now unreachable code.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/sparc/monitor.c | 107 -----------------------------------------
 1 file changed, 107 deletions(-)

diff --git a/target/sparc/monitor.c b/target/sparc/monitor.c
index 73f15aa272d..a60671a60a4 100644
--- a/target/sparc/monitor.c
+++ b/target/sparc/monitor.c
@@ -39,114 +39,8 @@ void hmp_info_tlb(Monitor *mon, const QDict *qdict)
     dump_mmu(env1);
 }
 
-#ifndef TARGET_SPARC64
-static target_long monitor_get_psr(Monitor *mon, const struct MonitorDef *md,
-                                   int val)
-{
-    CPUArchState *env = mon_get_cpu_env(mon);
-
-    return cpu_get_psr(env);
-}
-#endif
-
-static target_long monitor_get_reg(Monitor *mon, const struct MonitorDef *md,
-                                   int val)
-{
-    CPUArchState *env = mon_get_cpu_env(mon);
-    return env->regwptr[val];
-}
-
 const MonitorDef monitor_defs[] = {
-    { "g0", offsetof(CPUSPARCState, gregs[0]) },
-    { "g1", offsetof(CPUSPARCState, gregs[1]) },
-    { "g2", offsetof(CPUSPARCState, gregs[2]) },
-    { "g3", offsetof(CPUSPARCState, gregs[3]) },
-    { "g4", offsetof(CPUSPARCState, gregs[4]) },
-    { "g5", offsetof(CPUSPARCState, gregs[5]) },
-    { "g6", offsetof(CPUSPARCState, gregs[6]) },
-    { "g7", offsetof(CPUSPARCState, gregs[7]) },
-    { "o0", 0, monitor_get_reg },
-    { "o1", 1, monitor_get_reg },
-    { "o2", 2, monitor_get_reg },
-    { "o3", 3, monitor_get_reg },
-    { "o4", 4, monitor_get_reg },
-    { "o5", 5, monitor_get_reg },
-    { "o6", 6, monitor_get_reg },
-    { "o7", 7, monitor_get_reg },
-    { "l0", 8, monitor_get_reg },
-    { "l1", 9, monitor_get_reg },
-    { "l2", 10, monitor_get_reg },
-    { "l3", 11, monitor_get_reg },
-    { "l4", 12, monitor_get_reg },
-    { "l5", 13, monitor_get_reg },
-    { "l6", 14, monitor_get_reg },
-    { "l7", 15, monitor_get_reg },
-    { "i0", 16, monitor_get_reg },
-    { "i1", 17, monitor_get_reg },
-    { "i2", 18, monitor_get_reg },
-    { "i3", 19, monitor_get_reg },
-    { "i4", 20, monitor_get_reg },
-    { "i5", 21, monitor_get_reg },
-    { "i6", 22, monitor_get_reg },
-    { "i7", 23, monitor_get_reg },
-    { "pc", offsetof(CPUSPARCState, pc) },
-    { "npc", offsetof(CPUSPARCState, npc) },
-    { "y", offsetof(CPUSPARCState, y) },
-#ifndef TARGET_SPARC64
-    { "psr", 0, &monitor_get_psr, },
-    { "wim", offsetof(CPUSPARCState, wim) },
-#endif
-    { "tbr", offsetof(CPUSPARCState, tbr) },
-    { "fsr", offsetof(CPUSPARCState, fsr) },
-    { "f0", offsetof(CPUSPARCState, fpr[0].l.upper) },
-    { "f1", offsetof(CPUSPARCState, fpr[0].l.lower) },
-    { "f2", offsetof(CPUSPARCState, fpr[1].l.upper) },
-    { "f3", offsetof(CPUSPARCState, fpr[1].l.lower) },
-    { "f4", offsetof(CPUSPARCState, fpr[2].l.upper) },
-    { "f5", offsetof(CPUSPARCState, fpr[2].l.lower) },
-    { "f6", offsetof(CPUSPARCState, fpr[3].l.upper) },
-    { "f7", offsetof(CPUSPARCState, fpr[3].l.lower) },
-    { "f8", offsetof(CPUSPARCState, fpr[4].l.upper) },
-    { "f9", offsetof(CPUSPARCState, fpr[4].l.lower) },
-    { "f10", offsetof(CPUSPARCState, fpr[5].l.upper) },
-    { "f11", offsetof(CPUSPARCState, fpr[5].l.lower) },
-    { "f12", offsetof(CPUSPARCState, fpr[6].l.upper) },
-    { "f13", offsetof(CPUSPARCState, fpr[6].l.lower) },
-    { "f14", offsetof(CPUSPARCState, fpr[7].l.upper) },
-    { "f15", offsetof(CPUSPARCState, fpr[7].l.lower) },
-    { "f16", offsetof(CPUSPARCState, fpr[8].l.upper) },
-    { "f17", offsetof(CPUSPARCState, fpr[8].l.lower) },
-    { "f18", offsetof(CPUSPARCState, fpr[9].l.upper) },
-    { "f19", offsetof(CPUSPARCState, fpr[9].l.lower) },
-    { "f20", offsetof(CPUSPARCState, fpr[10].l.upper) },
-    { "f21", offsetof(CPUSPARCState, fpr[10].l.lower) },
-    { "f22", offsetof(CPUSPARCState, fpr[11].l.upper) },
-    { "f23", offsetof(CPUSPARCState, fpr[11].l.lower) },
-    { "f24", offsetof(CPUSPARCState, fpr[12].l.upper) },
-    { "f25", offsetof(CPUSPARCState, fpr[12].l.lower) },
-    { "f26", offsetof(CPUSPARCState, fpr[13].l.upper) },
-    { "f27", offsetof(CPUSPARCState, fpr[13].l.lower) },
-    { "f28", offsetof(CPUSPARCState, fpr[14].l.upper) },
-    { "f29", offsetof(CPUSPARCState, fpr[14].l.lower) },
-    { "f30", offsetof(CPUSPARCState, fpr[15].l.upper) },
-    { "f31", offsetof(CPUSPARCState, fpr[15].l.lower) },
 #ifdef TARGET_SPARC64
-    { "f32", offsetof(CPUSPARCState, fpr[16]) },
-    { "f34", offsetof(CPUSPARCState, fpr[17]) },
-    { "f36", offsetof(CPUSPARCState, fpr[18]) },
-    { "f38", offsetof(CPUSPARCState, fpr[19]) },
-    { "f40", offsetof(CPUSPARCState, fpr[20]) },
-    { "f42", offsetof(CPUSPARCState, fpr[21]) },
-    { "f44", offsetof(CPUSPARCState, fpr[22]) },
-    { "f46", offsetof(CPUSPARCState, fpr[23]) },
-    { "f48", offsetof(CPUSPARCState, fpr[24]) },
-    { "f50", offsetof(CPUSPARCState, fpr[25]) },
-    { "f52", offsetof(CPUSPARCState, fpr[26]) },
-    { "f54", offsetof(CPUSPARCState, fpr[27]) },
-    { "f56", offsetof(CPUSPARCState, fpr[28]) },
-    { "f58", offsetof(CPUSPARCState, fpr[29]) },
-    { "f60", offsetof(CPUSPARCState, fpr[30]) },
-    { "f62", offsetof(CPUSPARCState, fpr[31]) },
     { "asi", offsetof(CPUSPARCState, asi) },
     { "pstate", offsetof(CPUSPARCState, pstate) },
     { "cansave", offsetof(CPUSPARCState, cansave) },
@@ -154,7 +48,6 @@ const MonitorDef monitor_defs[] = {
     { "otherwin", offsetof(CPUSPARCState, otherwin) },
     { "wstate", offsetof(CPUSPARCState, wstate) },
     { "cleanwin", offsetof(CPUSPARCState, cleanwin) },
-    { "fprs", offsetof(CPUSPARCState, fprs), NULL, MD_I32 },
 #endif
     { NULL },
 };
-- 
2.52.0


