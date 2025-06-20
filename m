Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19FD8C7115C
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 13:12:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSbUG-0004Li-1i; Fri, 20 Jun 2025 09:08:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSbUB-0003uq-MJ
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 09:08:52 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSbUA-0004n5-4n
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 09:08:51 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-453398e90e9so13153315e9.1
 for <qemu-devel@nongnu.org>; Fri, 20 Jun 2025 06:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750424928; x=1751029728; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NW0Hu04oFurHIvjEpsNrwT15qBihdHLv3c5t8qKFRhE=;
 b=o89ByaXz+Pps94E89f9dHuZPL5KCt6vEYrxACT9y/kTAahnwfAN4dItaqCrXGYtOzt
 1ngW8ahYCs35i0r1XFmybGtgHAwegX5dAeLrLNRLdx7L2B9b+opwWfVoEiWaGIKmvGj+
 fe4datHUbRount2Ksf097RX17t/RJycuwGNrMZW9rdcItXTypCGqP+FI0wNZYPE8kIKp
 lqPNj/d+j3fA2xMEVgyYfm/kc/BM9rNJbpeiBmPtszerieETYhmANW7XDbU9oNPj2681
 j0v776IlU7uAfgYBXpbCSqQNYMt+DS67LM6xUiH1f+LvppNxwqByTMWE6q7feUehkAod
 WyQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750424928; x=1751029728;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NW0Hu04oFurHIvjEpsNrwT15qBihdHLv3c5t8qKFRhE=;
 b=ItSU1qlUoLDe9jtM66rEeBV8NxQqg3aDEofkfXnFH8iXIng7/m/LCj9PYfaovf5u5X
 01myQot6O2dVpWb//O6+9F4yqIH8AVqQSb0T9nMux9BbkhgKLJiWiJREW0/qdzB4S66X
 /yAKrFZ34x2ErfeVXqFXzTGXuDKTNvQm9Jjhc8xgSpNhXlavgktv5mfvjFqQsxpoWLiA
 dhj/Tvker+rR7Frt6qDApUzipgyYC3cV1+J7LDP/QWR4QkdhGwwKD8hfkGtRBeBOYRtr
 OyskeLBFugYy0YXTEXckOZiYBq25W44z4qJiBeq7imxBgCf2NMjSeIrAlJecE9VotLRu
 nPFg==
X-Gm-Message-State: AOJu0Yzu/WZ5R6yXg7f+1PGWMPLt1W+WlYKFgedIBdgEET5uyl/zjrLD
 p19cUoDqPmAyxTQuRXnoQw3OsG8gT5LeAbRFZIFcN2zNsbBeLqN+ueCSpu7fC1XfYkFLQCGKCuk
 0OWbEdFw=
X-Gm-Gg: ASbGncuVKjvT6tuMmZ/LrbkApGKezt/qLovZ5K0cER40YEGnj/wsifQmKzR1DBoWfC+
 /r0U2u5ewujZMdoJX2TOW/rpXSXwHPRwVOXQRINSX/BEjOVOcp1gIKg7oD3ahTnx3/kxvTDSFaB
 dzyIap7MNoUr5yMw7ERPURpWSX5gO2C2XcdRzVJEOaaW1Zijp0rAB9mhPW6g0uTYUyCNUx5a2WE
 mbnCx/x2vlQhCPVCkHZIf4CBVGYwCjd39GBZfrMt1S45TscCyIwF6nSW7aaKxwNteQeoD9jS5e7
 Y631Ufaqwbc4lKVUG8PsJY5GzMb9oA4k8aiXwnCb9GE4KUSR529vqfarXJnHAtBxRStq60n1Cs5
 NeWG1o9GWFY0vnSM2oCfG1KXTFQAm6QZqaJe9
X-Google-Smtp-Source: AGHT+IGUxGQ9nSF7X2qks3F5L0LQ6lJ+WfpvhuThp4HFmarf7Jsr/FvLwKNQzlPqKQDhSjDBkrHhqg==
X-Received: by 2002:a05:600c:1991:b0:444:c28f:e81a with SMTP id
 5b1f17b1804b1-453659f5888mr23208755e9.27.1750424928234; 
 Fri, 20 Jun 2025 06:08:48 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a6d0f18152sm2006529f8f.27.2025.06.20.06.08.46
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Jun 2025 06:08:47 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Leif Lindholm <leif.lindholm@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Radoslaw Biernacki <rad@semihalf.com>, Alexander Graf <agraf@csgraf.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>, Cleber Rosa <crosa@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, kvm@vger.kernel.org,
 qemu-arm@nongnu.org, Eric Auger <eric.auger@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 John Snow <jsnow@redhat.com>
Subject: [PATCH v2 17/26] target/arm/hvf: Really set Generic Timer counter
 frequency
Date: Fri, 20 Jun 2025 15:07:00 +0200
Message-ID: <20250620130709.31073-18-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250620130709.31073-1-philmd@linaro.org>
References: <20250620130709.31073-1-philmd@linaro.org>
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

Setting ARMCPU::gt_cntfrq_hz in hvf_arch_init_vcpu() is
not correct because the timers have already be initialized
with the default frequency.

Set it earlier in the AccelOpsClass::cpu_target_realize()
handler instead, and assert the value is correct when
reaching hvf_arch_init_vcpu().

Fixes: a1477da3dde ("hvf: Add Apple Silicon support")
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/hvf/hvf.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index fd493f45af1..52199c4ff9d 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1004,6 +1004,13 @@ cleanup:
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
@@ -1015,7 +1022,9 @@ int hvf_arch_init_vcpu(CPUState *cpu)
     int i;
 
     env->aarch64 = true;
-    asm volatile("mrs %0, cntfrq_el0" : "=r"(arm_cpu->gt_cntfrq_hz));
+
+    /* system count frequency sanity check */
+    assert(arm_cpu->gt_cntfrq_hz == get_cntfrq_el0());
 
     /* Allocate enough space for our sysreg sync */
     arm_cpu->cpreg_indexes = g_renew(uint64_t, arm_cpu->cpreg_indexes,
@@ -1084,6 +1093,10 @@ int hvf_arch_init_vcpu(CPUState *cpu)
 
 bool hvf_arch_cpu_realize(CPUState *cs, Error **errp)
 {
+    ARMCPU *cpu = ARM_CPU(cs);
+
+    cpu->gt_cntfrq_hz = get_cntfrq_el0();
+
     return true;
 }
 
-- 
2.49.0


