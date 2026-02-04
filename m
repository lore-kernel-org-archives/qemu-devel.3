Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C5E1EA7940
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 18:29:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnhbq-0003Q4-Ar; Wed, 04 Feb 2026 13:28:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vnhbp-0003LH-5r
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 13:28:13 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vnhbn-00017w-KL
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 13:28:12 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-432d2c7a8b9so137316f8f.2
 for <qemu-devel@nongnu.org>; Wed, 04 Feb 2026 10:28:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770229690; x=1770834490; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xOcVEoIy22xT6BELs0cJqqzemyJ5KqwhxzuTFdiT2QI=;
 b=R2rU2gYP8TGxLTCgY880ki8sE4gN5UgKT6oHIwU6E8AjY+ln/vC5vhdU0vTYKGesB0
 9u2sJZLOPQNnTPPeGVto6HAP2AW2ULlEDsrYlGs0tWWcm8jFLNGryx8i4+DZ+zwPlO/u
 lwr11bA7ntH/upJn6c8u09zIQMe2jpCQbb75mFLyn4sWgfej6vu9dcedo/NizvkXCVFL
 yLW2CPE7n0WLv64Ru/u5fn1xtZGcMijg2RCIGxlac0hAV5mLDWcuvUjZG7aW2vGOASDX
 jus6h4KQiZ5+Dm2pMq8SJc/m0LIArM16q/rOB1MxghBZ849kBXrCbAKFxtyXKWqvvBrY
 soDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770229690; x=1770834490;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xOcVEoIy22xT6BELs0cJqqzemyJ5KqwhxzuTFdiT2QI=;
 b=PUiCeTwP/4F+Sa4qalo0PtnMn2ytgkPHOPcfjdGO0kcXJ5bZKSMbGXt41J1ztFS6Zl
 XtRsnPAuSjP9Hwdved69QAbrFPyMDy1IZB8CM+fH873/Jc3+9hF84p8ezA99oCPCgkZ3
 isZiQ6uH6RThm0RL8OH7if37fVDogsb+PGTi0+yShUYhEbIxPDN4Kdm/n6Vx8rBic3A6
 XjIDz87kLyyXZSvtH2xsQ19VqkfievZKLF1Ze2tavlvkf05ZnAuFPLdL4qaOjAsbfGUU
 EXIyXq7Iw2CVww2OImyggBVqos16284s8AizdUbAmfgM2HrrmL3otF6jgis4hzG4eKSA
 hr+w==
X-Gm-Message-State: AOJu0Yz9I32xPqhmExL12hdpJZQvjJrG1a4KoHtMCH5eDXghFLq0ACgO
 7VppttvgMUuODuuTWUl1H5sPCTtjGAHRTmCpzZEkD4wKRJc1SYC4tbiOXAa6fT2h8yNmz14gABU
 5aREQzqU=
X-Gm-Gg: AZuq6aKQPBuDpG8Q9eNMxutZ7GQjeb91FtyUMXhLQ/0JcVADqiC6fabpPIUB/GYg/hS
 X+PggXWTfAKGnP8kofaDA2zlbnSDo5g817N1X77mRoJX+HbXvriLn3CpUCXZXIzrSt18WXGLAMY
 3piqOIPcYE+dX3SqXaRZz77u8JXdXSm7IMzipHy4yWdSB4q5TyjIpfPqXyL5rOLLIjDRDs0OnrC
 D0Rw7ca0+XjW4ssuPYbJMVkhwGPbI4ThOXJhjvfVvEji/S4LsTj7bPxM7+k+PzFPujq6y+NutOw
 FxD/qNtweTEwkDMRsv1NmhQ4Cps7RZPmHAyuKuhDYF1PM3sGksfbd/ujKcMZz9j6FmDewixWegm
 qPmp+2R9K31qp3bXsRQXjfANWqoTrDtPKlY/tOiMWCqSH5zf33/+g+jlu+waoewWpvPFv3UERET
 J5FeJp7Fie0mtsCHwuEwlb0UrbIs2px0pnRY6TEdAznW/jg1rEUIKOJ/OAdFEP
X-Received: by 2002:a05:6000:184d:b0:435:a3c5:a528 with SMTP id
 ffacd0b85a97d-43618056b5amr6034532f8f.39.1770229687513; 
 Wed, 04 Feb 2026 10:28:07 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43617e38fbbsm8667302f8f.13.2026.02.04.10.28.06
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 04 Feb 2026 10:28:06 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 David Hildenbrand <david@kernel.org>, Thomas Huth <thuth@redhat.com>,
 qemu-s390x@nongnu.org, Eric Farman <farman@linux.ibm.com>,
 Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 6/9] target/s390x: Add more unreachable KVM stubs
Date: Wed,  4 Feb 2026 19:27:19 +0100
Message-ID: <20260204182722.44062-7-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260204182722.44062-1-philmd@linaro.org>
References: <20260204182722.44062-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

Next patch will move s390x system objects from the target
specific source set to the common one. Unfortunately the
kvm_enabled() macro won't be evaluable at built-time
anymore. Add stubs for KVM symbols unreachable at runtime.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Acked-by: Thomas Huth <thuth@redhat.com>
---
 target/s390x/kvm/stubs.c | 76 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 75 insertions(+), 1 deletion(-)

diff --git a/target/s390x/kvm/stubs.c b/target/s390x/kvm/stubs.c
index 046e1f922b7..196127baa51 100644
--- a/target/s390x/kvm/stubs.c
+++ b/target/s390x/kvm/stubs.c
@@ -4,8 +4,9 @@
 
 #include "qemu/osdep.h"
 
-#include "kvm_s390x.h"
+#include "target/s390x/kvm/kvm_s390x.h"
 #include "target/s390x/kvm/pv.h"
+#include "target/s390x/cpu_models.h"
 
 int kvm_s390_get_protected_dump(void)
 {
@@ -104,3 +105,76 @@ int kvm_s390_dump_completion_data(void *buff)
 {
     return 0;
 }
+
+bool kvm_s390_apply_cpu_model(const S390CPUModel *model,  Error **errp)
+{
+    g_assert_not_reached();
+}
+
+void kvm_s390_access_exception(S390CPU *cpu, uint16_t code, uint64_t te_code)
+{
+    g_assert_not_reached();
+}
+
+int kvm_s390_mem_op(S390CPU *cpu, vaddr addr, uint8_t ar, void *hostbuf,
+                    int len, bool is_write)
+{
+    g_assert_not_reached();
+}
+
+int kvm_s390_mem_op_pv(S390CPU *cpu, vaddr addr, void *hostbuf, int len,
+                       bool is_write)
+{
+    g_assert_not_reached();
+}
+
+int kvm_s390_set_cpu_state(S390CPU *cpu, uint8_t cpu_state)
+{
+    g_assert_not_reached();
+}
+
+void kvm_s390_vcpu_interrupt_pre_save(S390CPU *cpu)
+{
+    g_assert_not_reached();
+}
+
+int kvm_s390_vcpu_interrupt_post_load(S390CPU *cpu)
+{
+    g_assert_not_reached();
+}
+
+int kvm_s390_get_hpage_1m(void)
+{
+    g_assert_not_reached();
+}
+
+void kvm_s390_enable_css_support(S390CPU *cpu)
+{
+    g_assert_not_reached();
+}
+
+int kvm_s390_assign_subch_ioeventfd(EventNotifier *notifier, uint32_t sch,
+                                    int vq, bool assign)
+{
+    g_assert_not_reached();
+}
+
+void kvm_s390_cmma_reset(void)
+{
+    g_assert_not_reached();
+}
+
+void kvm_s390_crypto_reset(void)
+{
+    g_assert_not_reached();
+}
+
+void kvm_s390_set_diag318(CPUState *cs, uint64_t diag318_info)
+{
+    g_assert_not_reached();
+}
+
+int kvm_s390_topology_set_mtcr(uint64_t attr)
+{
+    g_assert_not_reached();
+}
-- 
2.52.0


