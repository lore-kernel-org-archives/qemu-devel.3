Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DDDAC3ABC0
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 23:51:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCoQM-0001Cc-F2; Wed, 07 May 2025 19:43:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uCoQ2-0000TC-6t
 for qemu-devel@nongnu.org; Wed, 07 May 2025 19:43:18 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uCoQ0-0002cv-CB
 for qemu-devel@nongnu.org; Wed, 07 May 2025 19:43:17 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-22e8461d872so4775925ad.3
 for <qemu-devel@nongnu.org>; Wed, 07 May 2025 16:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746661395; x=1747266195; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HNwQBodHKU/YNnzJ0OLvvAjHAnJFIjZ/+9H8rnLNev8=;
 b=kvUNr9EfSUGiAzkd/GHH8pMBPwXV4Wwrrai9WUuxg/vhP9wCNcr2r9ts5jltJzsSOv
 OOdbyFxuqpY7gXbJ7lprKRlrsb3H30/zVzcw74HMsmtZ0K1EKbq4FtqAKvVM4TqpSjgl
 ST3xDP/qHCtoJzy59LV2cLR4IChIn7OREEz/rEGLanc6XIYWCyYCmFpMDnlxItZ1PqJ2
 Ayk6aGGNqW09sSF2gZdRQ0uyp8rSImEVSXJ2zgHYbpmh7nxTUaZ6L4o4za66dtpl8ZbB
 e9nMCJ9CrC5ymSwRlQjuM70FPkWgL7xbqsjtqLCObGvO8PniIDUVHkyBq6+NAU/D279s
 cYsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746661395; x=1747266195;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HNwQBodHKU/YNnzJ0OLvvAjHAnJFIjZ/+9H8rnLNev8=;
 b=qL2I8Qb5BtpOGf+g+6I65hHBQC0BhEe5ILwa/F8g1Ak3ruqSzLE0jvIph7f+iyFIc1
 /KtaqDhUQ7HRuX57dEPNsvGvOvbCi/A33RpX1R0e0cd0POa8ZSSTWHkhC0QTZorFpyZi
 C4aCwuRRL9NJwem6F8zfU5dFe4BHQEBQ6QOc+AChnL72o0dDIKlSqWj+P1Ru6/5K/4Fp
 hWtGKtekWbKNgdEr5/A1hSB/qqDkLfknG+3JY4lTPswLn0BCWCCVXwamxSUiKUAFx9Dm
 PlvKg1e+UExqnMEOsEXFBWLn11EX6957k03DXb8qHF+Dnq5GTcRMhwxnrx5Ufa5eX9fg
 azBQ==
X-Gm-Message-State: AOJu0Ywl88B6ijE5FXvr00fsggu0qjweVoJ6a/bZ5lgOl9aB3+EiA2yr
 CNBZrrGuWXyCKyMJTJ8HOL5vPPkB5j8Z8LIQ9M7CnZnFScjVCHyAEetK1gdQvLHg8fXUsqbNrQ6
 krvD0wg==
X-Gm-Gg: ASbGnctrwZEpYhrUXHJ6H/SRPbMF06ZGlW5kHxzr5mWx+pQgJtWJVsFcXRroj/AH5pT
 gE21QM+Q6lFujKPRx9tb0sm42mpf+0lttWIAfXkmuycJcKQ1B0jMwe6VzBngOKkbprrckxIS31B
 poP5Mm1WRZCAIgF7hEYYgmXMu+qDh+p4oxlqt5hBcFMO9Kfs57X5giPiT7duJxM8FUapYcHGIDn
 686a6ue/ZssHbqydvTY5wc0XRe/BokTSJUolZbc9zhvbuNq1Db8VLhGiIY6crchA7Juxj/24A2k
 QpBUqIkUAf+7aiQcqhblJ54b2UVioPDiROMD+ni2
X-Google-Smtp-Source: AGHT+IHzJdvFnh9XOsFcRbkcBf5qvX2uV6HTIjm/MkuKOh9F3IM/eLfP1ilS43wd1wjfnqd63Z7PaA==
X-Received: by 2002:a17:903:2b07:b0:223:5c33:56a2 with SMTP id
 d9443c01a7336-22e863e371emr16940145ad.28.1746661395022; 
 Wed, 07 May 2025 16:43:15 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e815806fdsm6491325ad.17.2025.05.07.16.43.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 May 2025 16:43:14 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, anjo@rev.ng, Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, alex.bennee@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v7 37/49] target/arm/machine: move cpu_post_load kvm bits to
 kvm_arm_cpu_post_load function
Date: Wed,  7 May 2025 16:42:28 -0700
Message-ID: <20250507234241.957746-38-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250507234241.957746-1-pierrick.bouvier@linaro.org>
References: <20250507234241.957746-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62f.google.com
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/kvm_arm.h |  4 +++-
 target/arm/kvm.c     | 13 ++++++++++++-
 target/arm/machine.c |  8 +-------
 3 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
index b638e09a687..c4178d1327c 100644
--- a/target/arm/kvm_arm.h
+++ b/target/arm/kvm_arm.h
@@ -83,8 +83,10 @@ void kvm_arm_cpu_pre_save(ARMCPU *cpu);
  * @cpu: ARMCPU
  *
  * Called from cpu_post_load() to update KVM CPU state from the cpreg list.
+ *
+ * Returns: true on success, or false if write_list_to_kvmstate failed.
  */
-void kvm_arm_cpu_post_load(ARMCPU *cpu);
+bool kvm_arm_cpu_post_load(ARMCPU *cpu);
 
 /**
  * kvm_arm_reset_vcpu:
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index b6c39ca61fa..a08a269ad61 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -938,13 +938,24 @@ void kvm_arm_cpu_pre_save(ARMCPU *cpu)
     }
 }
 
-void kvm_arm_cpu_post_load(ARMCPU *cpu)
+bool kvm_arm_cpu_post_load(ARMCPU *cpu)
 {
+    if (!write_list_to_kvmstate(cpu, KVM_PUT_FULL_STATE)) {
+        return false;
+    }
+    /* Note that it's OK for the TCG side not to know about
+     * every register in the list; KVM is authoritative if
+     * we're using it.
+     */
+    write_list_to_cpustate(cpu);
+
     /* KVM virtual time adjustment */
     if (cpu->kvm_adjvtime) {
         cpu->kvm_vtime = *kvm_arm_get_cpreg_ptr(cpu, KVM_REG_ARM_TIMER_CNT);
         cpu->kvm_vtime_dirty = true;
     }
+
+    return true;
 }
 
 void kvm_arm_reset_vcpu(ARMCPU *cpu)
diff --git a/target/arm/machine.c b/target/arm/machine.c
index 868246a98c0..e442d485241 100644
--- a/target/arm/machine.c
+++ b/target/arm/machine.c
@@ -976,15 +976,9 @@ static int cpu_post_load(void *opaque, int version_id)
     }
 
     if (kvm_enabled()) {
-        if (!write_list_to_kvmstate(cpu, KVM_PUT_FULL_STATE)) {
+        if (!kvm_arm_cpu_post_load(cpu)) {
             return -1;
         }
-        /* Note that it's OK for the TCG side not to know about
-         * every register in the list; KVM is authoritative if
-         * we're using it.
-         */
-        write_list_to_cpustate(cpu);
-        kvm_arm_cpu_post_load(cpu);
     } else {
         if (!write_list_to_cpustate(cpu)) {
             return -1;
-- 
2.47.2


