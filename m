Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A439D47CD0
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 11:22:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vghtM-00053R-1N; Fri, 16 Jan 2026 06:21:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vghsz-0003xJ-2M
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 06:21:02 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vghsx-0007KA-HP
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 06:21:00 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4801c1ad878so11394395e9.1
 for <qemu-devel@nongnu.org>; Fri, 16 Jan 2026 03:20:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768562458; x=1769167258; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=jLRYK6we5h/yu2QPNnJNrmjTWkLPDUWx0vKsKYLQdpc=;
 b=jUd7QIEaqD98ZjvcYtGCO6v88JcnVR0QIhRdQUbeSl5OvVNC5cJyi/fiMjaa4kJrr6
 SNEufWPVJXJHtLEyYdauIbzlq5wLbfhio/C1KP7ATTcN7XP1qq/lwO8OO+ToQihv2U1A
 eKQDAhVMCk/5BlutSMJShYGnOZEn2yjLxHZDdNBwnlSG8I5CuuV7QmawuMppaGCKrMpc
 qiRkqQcVpftcXQiVKB6Kq0EMBJSPJqlKpXQT0zYfB6dSDEq0sJDlryBoJMwsWSZgSRz9
 Zk2PKmbORfsAm1BmXx0bdfLIXp16oqT6TkuToHJ2dMCzR/0+vvOgA3nGWWkEotmYsSfe
 jU5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768562458; x=1769167258;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=jLRYK6we5h/yu2QPNnJNrmjTWkLPDUWx0vKsKYLQdpc=;
 b=MGvE/BblxPj+kaO5pyWCdLIX/t6Opzk8/39BhA/OmUO3PDIm+ArQteUjIJMGTX5lRV
 8G8fy8C0OixLoIpl+rziqn3HtVFHnl5Pq4Bn6zo8e/EBjBSA3Ku+N6Vynh1rFY4zwcrJ
 FOY8phHtRlluN6TTrzFnafvDYYd04DjKzGLn7ssCExbUGr1LacDsny1iuSsP9DeUqMVh
 WG3sjSayYJ765b7xXurQ3ahw5LGISPbvV2EhbHmuH0ZGB3kQYpWRKPam4xxLBicZibSF
 RTpJr/r1TGtnSM2/irKYfKMIB1V4heO57r1sdpfQMpRO+29EeGEESv3JjRQSv1MqCjab
 QLAQ==
X-Gm-Message-State: AOJu0Ywx5PS1bQo2Plt+9zANHF4vD9zcFFg7BLYAGn4Dc2N2xhkWI3Qm
 qkMgV0GZ7fZ2/CNuSIVm7usJA+TEAsLcEEQDAb+c1miLLhWmK2j3zp0PlYZ6aEZsfv2oePiVhvn
 3QVUPplk=
X-Gm-Gg: AY/fxX7U5f44QCPAZl8Ik3sOYdC2ils1spe//76WLaOL9myF+4iMYaZJ04gYaCmz3Jm
 Sywp9RlhHPOdkPxj1PmIFwkDXMdoQklxjgy0DrGyoxaHzC/l43udWV4rruUjDdqT02YRuC/olE+
 buleVg2JyyMklPbSxCI1Pxfifer85w3ZShzcxP9OL4UlR1g4GhbYemYbzH+3mpifIrnc/nWDWeh
 H0zWgP7cE93F8E5VTt+35UjG3rarssVQhV/pmdHjB0rNCI6VO25NLmHXrfnMf+30KyQ0z4aA72z
 x2fAVRrMACAxeeF1FTkaJu7Sc8mkfvcqI4xGtyrqvXXYckXq4fX9JJYSLhkH8zfB5HJ37X5YTdO
 K0YMRZkeBLt4mn87oOAuG91LcpRK1VZBlWqyK59A64LqnUTtjpArFLevLqiS94rgHL6r5vCq49j
 LsE6Ve9uYWf7LSI8Eeub3HyNrnC7qOkTCGHzvmypGnH9K3I8y4giKKTHVxK7Yi
X-Received: by 2002:a05:600c:890b:b0:47a:935f:61a0 with SMTP id
 5b1f17b1804b1-4801fd3bdbemr20014705e9.0.1768562457825; 
 Fri, 16 Jan 2026 03:20:57 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4801e879542sm39894845e9.4.2026.01.16.03.20.57
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 16 Jan 2026 03:20:57 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 25/30] target/arm/hvf: Really set Generic Timer counter
 frequency
Date: Fri, 16 Jan 2026 12:18:02 +0100
Message-ID: <20260116111807.36053-26-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260116111807.36053-1-philmd@linaro.org>
References: <20260116111807.36053-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Setting ARMCPU::gt_cntfrq_hz in hvf_arch_init_vcpu() is
not correct because the timers have already be initialized
with the default frequency.

Set it earlier in the AccelOpsClass::cpu_target_realize()
handler instead, and assert the value is correct when
reaching hvf_arch_init_vcpu().

Fixes: a1477da3dde ("hvf: Add Apple Silicon support")
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Message-ID: <20251103101034.59039-19-philmd@linaro.org>
---
 target/arm/hvf/hvf.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index bf8bed1495d..e4c0d936f1f 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -897,6 +897,13 @@ cleanup:
     return ret;
 }
 
+static uint64_t get_cntfrq_el0(void)
+{
+    uint64_t freq_hz = 0;
+    asm volatile("mrs %0, cntfrq_el0" : "=r"(freq_hz));
+    return freq_hz;
+}
+
 int hvf_arch_init_vcpu(CPUState *cpu)
 {
     ARMCPU *arm_cpu = ARM_CPU(cpu);
@@ -908,7 +915,9 @@ int hvf_arch_init_vcpu(CPUState *cpu)
     int i;
 
     env->aarch64 = true;
-    asm volatile("mrs %0, cntfrq_el0" : "=r"(arm_cpu->gt_cntfrq_hz));
+
+    /* system count frequency sanity check */
+    assert(arm_cpu->gt_cntfrq_hz == get_cntfrq_el0());
 
     /* Allocate enough space for our sysreg sync */
     arm_cpu->cpreg_indexes = g_renew(uint64_t, arm_cpu->cpreg_indexes,
@@ -974,6 +983,15 @@ int hvf_arch_init_vcpu(CPUState *cpu)
 
 bool hvf_arch_cpu_realize(CPUState *cs, Error **errp)
 {
+    ARMCPU *cpu = ARM_CPU(cs);
+
+    /*
+     * We must set the counter frequency HVF will be using
+     * early, before arm_cpu_realizefn initializes the timers
+     * with it.
+     */
+    cpu->gt_cntfrq_hz = get_cntfrq_el0();
+
     return true;
 }
 
-- 
2.52.0


