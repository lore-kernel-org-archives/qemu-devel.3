Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C52DEF5851
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Feb 2026 20:19:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vrM6j-0004eC-Tb; Sat, 14 Feb 2026 15:19:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <haroldknowlden@gmail.com>)
 id 1vrKw3-0003Iz-65
 for qemu-devel@nongnu.org; Sat, 14 Feb 2026 14:04:07 -0500
Received: from mail-ot1-x32a.google.com ([2607:f8b0:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <haroldknowlden@gmail.com>)
 id 1vrKw1-00042X-Mr
 for qemu-devel@nongnu.org; Sat, 14 Feb 2026 14:04:06 -0500
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-7d195166b2cso1377607a34.3
 for <qemu-devel@nongnu.org>; Sat, 14 Feb 2026 11:04:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771095843; x=1771700643; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=xYWEyjpYVY2l7pzkthPd8PINyDJVvlVJRdS43y6R8B0=;
 b=COeD+XbZYPHOVhAM6/y+rYJ2HuKP280ICxVZHz3MysEqqaatsHNa+77VK9LqIW1Ryh
 DuI0gEX5Wwa16CofRE+zftb4Gw0KcluXq2hW/KCVgzLLMc6BMIAadmJYbusay+AItfCs
 S1wFcTlU/RU96sDw6Febx5vLJ7mx4E5PoL6tfwzGVXaVJPUgW6fFrS9+c0Rs/TV9QJLG
 i8DlKHn0X00u5D4iZYTUBBqIpWE+wiZnzOrV7dnAmvXrU/zYlCLT6EzsgiUWhj8LWMZq
 p42Ts/7KKXwNx7gDaGuhcC2B/00e6vtEKsJktEJIRiAibOeCjHWo64g7uzNvWW6rJHY/
 GcDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771095843; x=1771700643;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xYWEyjpYVY2l7pzkthPd8PINyDJVvlVJRdS43y6R8B0=;
 b=kaNGvxi+brhX4BPFcyxj3DcdfFPqFz+GGwk2/HUa6O2eviML55gQ2a92Cqo0j8nYuC
 QNFi161ndTy8noTOotX9X7p0cwXNLpJg0+cXIY7f2pUu0BwhYfBHBlyHCw2NpnydAyvT
 esbK8ObaY2VJyITn1QhDDY5OjwpDhSW6W9o6G8PAQNwZsqaE7D90r7ujSnvFyTBVXNlV
 q+vYrqXv0oeDrgJPxroNMTWT7BZvDh4ZO0xxzW/cjMzVaQ6ctv6XcPeQjTF7hv2y7QAw
 JFWCZnTu9ceXGFD+Gu21cSaX2CNiMTb6vVUk0kQItGyMCqWquLvnlAEnNWzNBY4uxEHv
 E4/Q==
X-Gm-Message-State: AOJu0YwonuoBf30y/asQJkO3tGDXXAlkinAWdUqIZOLz1C6YdS5+Kyg6
 9kzJnRkX9yGPhsLX4ULgpqSKlNCCrbEMDPHVOYgBuhJtPbcaZ7IpbBYVGJt69SjF
X-Gm-Gg: AZuq6aLG0OKlVWip5+sAtrslo4pYhxa5WSU4pu28vFuW3fiBiRSOX0TdVNpg6SqldkN
 8Qx36c+Jpj71NaFb1GXxG6A6bthQisd2Q6FvnoP5NW4PmPgJRLoPWYTDt6/mvKFPGpxx4X9Xeme
 NH4jpFqddmM81vRy6AuzD9LmmMasBFAsO0Bsm8Frwgns0MGAklMkG5YKpQ0AdiV8dgxKJTx4XkX
 vakaCItM+Y/lRNciPwpF/N2h2XXd9XuvnBNVwIYwhwjPC36P8MI1ujLDNwNVzlmAfFqEHcp3Tuz
 PnCnZfmb5K60VLrcMWajyND9x0oylcKCRynIoEiMUuskOukaZebi/WM+CCh4EpCyaKcYhRZlB62
 O0ARwNEJRjUlUVa7cVNFXNKcnT3oP+DZ+5wvCIXcccM3XNRfE1eENcofnWLqDcNpmuAy2d23vKK
 XOheZmdIM14BYMGkUU8blRvLUuGTW56ciL6IgNHYU=
X-Received: by 2002:a05:6830:240a:b0:7d1:569d:ce7b with SMTP id
 46e09a7af769-7d4c31cc549mr3704142a34.29.1771095842831; 
 Sat, 14 Feb 2026 11:04:02 -0800 (PST)
Received: from localhost.localdomain ([47.227.2.18])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d4a76e1e59sm8853025a34.17.2026.02.14.11.04.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Feb 2026 11:04:02 -0800 (PST)
From: ChaseKnowlden <haroldknowlden@gmail.com>
To: qemu-devel@nongnu.org
Cc: Marcelo Tosatti <mtosatti@redhat.com>, kvm@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 ChaseKnowlden <haroldknowlden@gmail.com>,
 GitHub Copilot <copilot@github.com>,
 Copilot <223556219+Copilot@users.noreply.github.com>
Subject: [PATCH] target/i386/kvm: Reset PMU state in kvm_init_pmu_info
Date: Sat, 14 Feb 2026 14:03:53 -0500
Message-ID: <20260214190353.29337-1-haroldknowlden@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32a;
 envelope-from=haroldknowlden@gmail.com; helo=mail-ot1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sat, 14 Feb 2026 15:19:10 -0500
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

The static variables pmu_version, num_pmu_gp_counters, and
num_pmu_fixed_counters persist across different VCPU initializations.
When kvm_init_pmu_info() returns early (e.g., when PMU is disabled or
there's a vendor mismatch), these variables retain stale values from
previous initializations.

This causes crashes during guest reboots, particularly with Windows XP,
when kvm_put_msrs() attempts to write PMU MSRs based on the stale
pmu_version value for a CPU that doesn't actually support PMU.

Fix this by resetting the PMU state variables to 0 at the start of
kvm_init_pmu_info() to ensure clean initialization for each VCPU.

Fixes: 4c7f05232c ("target/i386/kvm: reset AMD PMU registers during VM reset")
Signed-off-by: GitHub Copilot <copilot@github.com>

Co-authored-by: Copilot <223556219+Copilot@users.noreply.github.com>
---
 target/i386/kvm/kvm.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 9f1a4d4cbb..c636f1f487 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -2193,6 +2193,14 @@ static void kvm_init_pmu_info(struct kvm_cpuid2 *cpuid, X86CPU *cpu)
 {
     CPUX86State *env = &cpu->env;
 
+    /*
+     * Reset PMU state to avoid stale values from previous VCPU
+     * initializations affecting subsequent ones.
+     */
+    pmu_version = 0;
+    num_pmu_gp_counters = 0;
+    num_pmu_fixed_counters = 0;
+
     /*
      * If KVM_CAP_PMU_CAPABILITY is not supported, there is no way to
      * disable the AMD PMU virtualization.
-- 
2.53.0


