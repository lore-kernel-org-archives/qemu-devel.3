Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0719FDEE2D
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 17:05:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFxTy-0003Ff-6m; Thu, 23 Apr 2026 13:04:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFxTY-0001qR-Cv
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 13:04:32 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFxTW-0005op-J0
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 13:04:27 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4891c00e7aeso45133025e9.2
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 10:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776963865; x=1777568665; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2+dlrVOsNPHtgWGTf3x2VGDZydKVga1ZwBAM/XkoOYY=;
 b=sCnDhuB3ZAyT2wrOAo5H16zUQIj3rgvLp8qunMc6UatUz98hHGMzb4/JsRFIyn51Jr
 p1674Ud4gVZtGgOAlcpmeeXxRvCN5M9vZ83TFRBvjQ5kqFr9RYiF0oYSeKvsQ0oTE5Bf
 CRPVIF6rifzq7nSuZb/TxL23OBWQVqhmgpXn1+e4tpEM5VZw5LS/yF1dL1aWvIgxjtrj
 mtEBTQexiyDyWBHY7oytUzlSjLQv7K/nkEFvlxGZYjmG00qFcMfEfQlojfRNGjrzdehv
 fZzeK2RmbSW/cn4G6FHC70Kgr4ug68q+CaATPi5tFVOKI0okDyJKuNwRVi6+m/4GESNu
 7FDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776963865; x=1777568665;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2+dlrVOsNPHtgWGTf3x2VGDZydKVga1ZwBAM/XkoOYY=;
 b=epMWcFVggMae+gWd+L7+Sxh5TJcz/FBUffMTfPALSuTwzi/lN7/UT6WBBZy92CaHPr
 6/6oqF7JjwVpXDGnTay6UjgbFPcyw76kAErZmYJ5fYBSsrZ0Cf2x08XTRENy66VRo/PE
 OgySpigG8U6LEhZOmuZns47MBGXcjVAD7ASjKd1vuDLcAmdp3SobN2pMj9FzVb8dmKIx
 9mCjc0JGL/K7v/3rB+4MCEboGWdtjP5aBwCP2vZBFkkKwPaYL9rOcNKylRkpc+pvlbxc
 tmt8I8KwM4pfOwyiqbq4kUYj/WjBHj7Kjg4lnB8iJrV+Jiwj4z1nwPu2BH4ODjrHKemL
 WO3Q==
X-Gm-Message-State: AOJu0Yx0YMfba3qMr9UgnmaJnQYXtayQpT8j1j9X10RpRthgRQLKNuX8
 ycAwYltSO/nRB+Mwn9EAI1skR30sBPr02qlTgIzjYFMeLbP/0/3nCaFQKi5CwZvGX31S/EpbIig
 F8I9zeZY=
X-Gm-Gg: AeBDiesSROZ6kIr+osY8y+6Gj0m+Sg8PoIq1evy9shIsXm6o9RAyueDphFfXDEib690
 r4ZQag1P32IeXQgXu6EZAdypsao837IW3LmK1qFVU0NBtOHhhPo0zLG0MUtL3aEjavUSRak09ye
 9Ol1hm3sJMhN9j4+zevgpkwcEngl5gx5wAo7MFH0cM5XApgWW1bBe6Pb7aPiXTsDAipRT2MSiZk
 VkqwZrx7WxJAh0FCAZYnf/QhCa9/mDg0xDSkmnhq3cKzm3/ts5H6gyAnsqyu0tqsqVVEFGDwA/2
 4Jk+D7a+OtzYCjaoXLVjZooE1vFwPiu/0Ac44dCZRminOEitHIuYA9KyvhubLjrtxiyOVj64Mi1
 GBsFQeKo5JAXXlcaAJmzlkBCA6tiUVMsFuFDcIACPmSZJdgPH3jlMW/XJqqtCs485U9wS1HuKE5
 nNtjrIi3HxVUHXoEpFR7i8Qn4LJwCDA24UnLIOwAMcn3NZ5fN9gooBWqJUITfagCGmcMRB9koAS
 atCUocZuYs=
X-Received: by 2002:a05:600c:46cb:b0:488:a723:ea53 with SMTP id
 5b1f17b1804b1-488fb744fbemr398891365e9.7.1776963864601; 
 Thu, 23 Apr 2026 10:04:24 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fc1c0354sm497194745e9.11.2026.04.23.10.04.23
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 23 Apr 2026 10:04:23 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Roman Bolshakov <rbolshakov@ddn.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Mads Ynddal <mads@ynddal.dk>, qemu-arm@nongnu.org,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <agraf@csgraf.de>,
 Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 15/16] accel/hvf: fix double hv_vcpu_destroy() causing
 teardown error on ARM
Date: Thu, 23 Apr 2026 19:02:27 +0200
Message-ID: <20260423170229.64655-16-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260423170229.64655-1-philmd@linaro.org>
References: <20260423170229.64655-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

From: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>

The following callstack causes hv_vcpu_destroy() to be called twice,
producing HV_BAD_ARGUMENT on the already-destroyed handler:

hvf_vcpu_destroy
 |
 |_ hv_vcpu_destroy
 |
 |_ hvf_arch_vcpu_destroy
     |
     |_ hv_vcpu_destroy

The first hv_vcpu_destroy call covers both x86 and arm. Let's remove the
second one, as it is redundant.

This reverts commit feee55d36a1c5d494ee73812d279b439bb05137c.

Signed-off-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <ee6f642af1dab29aaf99f86ac9254ddd25765bf8.1776172276.git.matheus.bernardino@oss.qualcomm.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/hvf/hvf.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 33595bac72c..a905d9bc370 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1219,13 +1219,8 @@ void hvf_arm_set_cpu_features_from_host(ARMCPU *cpu)
 
 void hvf_arch_vcpu_destroy(CPUState *cpu)
 {
-    hv_return_t ret;
-
     timer_free(cpu->accel->wfi_timer);
     cpu->accel->wfi_timer = NULL;
-
-    ret = hv_vcpu_destroy(cpu->accel->fd);
-    assert_hvf_ok(ret);
 }
 
 hv_return_t hvf_arch_vm_create(MachineState *ms, uint32_t pa_range)
-- 
2.53.0


