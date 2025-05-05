Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B6F3C3ABAC
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 01:55:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBl1X-0005pk-6b; Sun, 04 May 2025 21:53:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBl12-00048f-Qq
 for qemu-devel@nongnu.org; Sun, 04 May 2025 21:53:09 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBl0z-0002fq-3E
 for qemu-devel@nongnu.org; Sun, 04 May 2025 21:53:08 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-7fd35b301bdso4722081a12.2
 for <qemu-devel@nongnu.org>; Sun, 04 May 2025 18:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746409984; x=1747014784; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RCBMR6tP31v0B0NBZf6LKRmnPLfJofFf8No/ewC08TY=;
 b=aHm0EiNss56yYovQnuDU7CSdDiB0XLABb0KkkpqS8otjaY79XZe+QQ63bPRSITWTo7
 gXDREWhK3+RpVT1E9Dv+yhA58uLRJwfHmqSSHMOd8Wkt20Fh0iT0tNXubJiWh5j9Pgnl
 8RClfteON4PmO+Sv2lt/RShGAmqx4uSs0e+wONtrd6WpXs45RmdgZXZ2Gu7v00h/1jxc
 uXdmESl5bMYGU2pAc/rbaNqmngZjk+oYPa6bN+d0QkIAPa1pqzqGsDg8UGeYe+dtlMWm
 n6avD8kPtSv1FR5v2l/CUKQI0g7VcDTWs/b/2A9ChSthS3ciQkLMI9JMnVImkcFABHE7
 VQww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746409984; x=1747014784;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RCBMR6tP31v0B0NBZf6LKRmnPLfJofFf8No/ewC08TY=;
 b=WapdTFylf2z2OaEdOVQbOKt7cnv6eG66QRKsnAEdj8X55t34L/pIBoJSzMwfhk0ozU
 SwaYq3yCFl9AaVwyPCnUAn89TcQelB9afZ3cRueHtSwZwxTtwt4EFFrATuh9UB5XVNB0
 zV92OCmSQ29Bjk+X1IKmkEDw1AjhSsx0efVfz29+gSjK3dezyPJX9eGPTM38+kzJqCDi
 93I/CaPD7+HF9Sk8yT7P0BRzWTZs3OUE36dXhVqngVUEXaj2m9eH7XVj++G1k0J8Koo4
 nrnpC0mM7Ikvi290+Aqnh9ZtVurI4U1csX6QYhpL16gJ/8q5mF5kl4egBEILn9Ipd16B
 t9NA==
X-Gm-Message-State: AOJu0YyyLWjh/8MrXS5SsfNmy3sXOtlgPzTpa5CmPlJf/mKz/ZLar1TP
 /KAWDoP3aaEYHlCjm8nFQ3Mh9XooFk9BcnuVDyUHRAcTUxnwkHxIqq9FXkaSakRpKQeKo19xY3S
 swDg=
X-Gm-Gg: ASbGnctqXDE3CRUWBb4ms/K9Zruf1KXPmmton7yp/2gik+SAWbI/kXllIsArLtlSk3d
 yrMnSg8gjslRoY8AbeHcfxFoR4SOU5//wt8yKlFkg9vdy4XiTapMuB3hG0Rj6U1hRLyUbTbYVjA
 k15kv1ow2i2A3cyBFBZcXwV1+mhrKFO01n0K7130WO8GrpqjU3gScbGvhBnEtbIkDAvqag+A1KB
 pp3XhRstkywyVCrqQKbmH9bmsan0SU5WQlrChjmTVtGxf2YK9vcPXy22GIOEmKTNHvZWq16Tu/3
 4VJN7RBwFRPG1MFU9AZG2wf3oNmgXII2ZBQGHbdS
X-Google-Smtp-Source: AGHT+IE14LFS/k60IBKIkWbmJ21gqOAFxrj51tLDJH6tuiS+nErdOLx6heXp6VXr6xQ79bIRJuVdBw==
X-Received: by 2002:a05:6a21:3295:b0:1f5:8e54:9f10 with SMTP id
 adf61e73a8af0-20e979c9932mr8906025637.34.1746409983790; 
 Sun, 04 May 2025 18:53:03 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b1fb3920074sm4462101a12.11.2025.05.04.18.53.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 May 2025 18:53:03 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 richard.henderson@linaro.org, alex.bennee@linaro.org, kvm@vger.kernel.org,
 Peter Maydell <peter.maydell@linaro.org>, anjo@rev.ng,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v5 38/48] target/arm/machine: move cpu_post_load kvm bits to
 kvm_arm_cpu_post_load function
Date: Sun,  4 May 2025 18:52:13 -0700
Message-ID: <20250505015223.3895275-39-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250505015223.3895275-1-pierrick.bouvier@linaro.org>
References: <20250505015223.3895275-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x531.google.com
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
index d156c790b66..00fc82db711 100644
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
index 8f68aa10298..8132f2345c5 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -977,13 +977,24 @@ void kvm_arm_cpu_pre_save(ARMCPU *cpu)
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


