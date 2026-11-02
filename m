Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9364C60A3806
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 13:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=FIUbzllk
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNsDQ-0003xG-Ez; Mon, 02 Nov 2026 08:36:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xNsD5-0003K5-DK
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 08:36:32 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xNsD3-0002J0-4m
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 08:36:27 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-48e46e449e8so1860233f8f.3
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2026 05:36:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793626583; x=1794231383; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=OQO+t1vU0lYyhkW6nJ7lUduEhDAihAorPNs8zu7/Ijk=;
 b=FIUbzllklbwiIcIAKoYlScoLr1EOQOnk+5LhuCxZR5qHvI6VQbMxyMzqZ9IkZ/EGS3
 aNXeIU7g5qhGpaHYQSbPWXqCIad6iX/dJd9vY0ZJZa97d4rXuEbro5/r5YhmBgG67MGF
 WQR/8SfmaaLEytjHyRyW/EFYqgdN85CTT1Xp74d7Y2W3V2nGExDut9PuuhaXUc0LHEfx
 ULxvBiNDsgrQNZDaWpsSBHdAANTz0gF/fwy4rvAshixJV0W+/8+4w5aw+T/N/Zn54+W9
 kjj/YVlw8wHP0F+AoCGxgv50usPwJuxIy0kDMeLe8rCmeN7Ul52cqAszdg4Auy5sudZq
 LucA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793626583; x=1794231383;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=OQO+t1vU0lYyhkW6nJ7lUduEhDAihAorPNs8zu7/Ijk=;
 b=u7twhe/bsS4SVWBHE0TkzJcXPMur13m4uAEkEsuPVWx8hxjHwz7fIWPIlCupmFiZGj
 ondCKF7sAugVKveduxSI28HwaNbMQzf1BWkaMpuZ5fj4YIdqhsYCuapTgmZkMVItpvGk
 XE8HnqNZx9B0TjumZBwiWezqSsWQSXkAOecignGvL/lW0/8MYnX4T6scxe3uW0nQ03qs
 Fmac7IdyrOJY/5sewav+Us3k38UdBweJsXYaIlj4A7PKKdUlRga6abEcsbB2fDC+4LeZ
 MYRDFkJYyYY6Fc+jWTcqKwrKeYMe9IPWSzyvd64DZyKoPTuDU6HphIltyanWtc+2hNiB
 1LXQ==
X-Gm-Message-State: APuU4Z+fX7/+8TuJC0HaYSKjO2RTwB/SzbYkVQaRgIc2Zem9xw4G5TT7
 LMlItEILBFwUfZZ/0STaXpCR0HuaV/Fql8Mr8JkpcFtD3toKM6dtHJt5M7LlBhxESA/cgAZqfPQ
 bgJdLtbs=
X-Gm-Gg: AYBFou3U4BCui2E3/xY3m5fVO+0h3l3QxdFDAxoLY1wi6oq33hy3aKok4hFmdqSivup
 v+liDbqbI0wNJguAR7rHNXeiStq4UDWcSntaUdXR2Xv0JnhmJGuy+GGJeMdxgxzszcHFUr3PR2B
 Jh1RQYcXKXAjOFpK/mZboVOIQmIJT4rQSAzEUi+ZffLaZ1H9G7zU7bvKqI8WoswgGLG0CgrznXE
 4U+CSHP8hNe0IxCcZNzywOMsSScUEop9F/2TePKA2vOaWazL0A/Ye7+YYH/+vK4iqeI/1f1SbNw
 7p4IL+p1UlWeC2J45gQ+vFf7K9fwGZ4GGBEKbOdqAt/qbSE4TsbmWpozTrgrJ6WLCdu4pLGKBKk
 QPNKvcB3wujRyAuJ45D5kV3YbehSOE5YAZBEbkOT7N6T0qqoGp018fOUNv1i1PD7ljR0lQ9n4KL
 qQX6qZUamcil4ljmhzf4wL/yTHivXkGrLCqindVoCq0C1Pdk40MV1zXDREuLkTBiIjK4R2ce02W
 LAlMfsB2/7opHpuugOwwhSG19TEPGwYpzGu6KOpNMN6GmV57sWYK3B6acdyZztnswe/ANVnxWkH
 agU6UnRiiCIpNLI9hGFugCdJgs4F3ywsR348l/62oNsvOeM1ljTUYArY42Tt2SMkPnQ8pDkZJM7
 NnXGGCZjnvMpLYfB2UX52FFjfZrtXh1OMfA==
X-Received: by 2002:a5d:588e:0:b0:48e:b32:9d1c with SMTP id
 ffacd0b85a97d-48e6e4f5507mr20930102f8f.19.1793626583511; 
 Mon, 02 Nov 2026 05:36:23 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71a4d3e9sm22556760f8f.6.2026.11.02.05.36.22
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 05:36:22 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 30/47] target/arm/kvm: Pass an error handle to
 kvm_arm_init_cpreg_list
Date: Mon,  2 Nov 2026 13:35:30 +0000
Message-ID: <20261102133547.1375701-31-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261102133547.1375701-1-peter.maydell@linaro.org>
References: <20261102133547.1375701-1-peter.maydell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42f.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Eric Auger <eric.auger@redhat.com>

Pass an error handle to kvm_arm_init_cpreg_list(). A Subsequent patch
will do the same with kvm_arch_init_vcpu().

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Gustavo Romero <gromero@redhat.com>
Reviewed-by: Sebastian Ott <sebott@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20261030131406.461599-6-eric.auger@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/kvm.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 724bc08edfe..76b3996d3b5 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -865,6 +865,7 @@ static bool kvm_arm_reg_syncs_via_cpreg_list(uint64_t regidx)
 /**
  * kvm_arm_init_cpreg_list:
  * @cpu: ARMCPU
+ * @errp: Error handle
  *
  * Initialize the ARMCPU cpreg list according to the kernel's
  * definition of what CPU registers it knows about (and throw away
@@ -872,7 +873,7 @@ static bool kvm_arm_reg_syncs_via_cpreg_list(uint64_t regidx)
  *
  * Returns: 0 if success, else < 0 error code
  */
-static int kvm_arm_init_cpreg_list(ARMCPU *cpu)
+static int kvm_arm_init_cpreg_list(ARMCPU *cpu, Error **errp)
 {
     struct kvm_reg_list rl;
     struct kvm_reg_list *rlp;
@@ -882,12 +883,17 @@ static int kvm_arm_init_cpreg_list(ARMCPU *cpu)
     rl.n = 0;
     ret = kvm_vcpu_ioctl(cs, KVM_GET_REG_LIST, &rl);
     if (ret != -E2BIG) {
+        if (ret < 0) {
+            error_setg_errno(errp, -ret,
+                             "failed to get KVM register list size");
+        }
         return ret;
     }
     rlp = g_malloc(sizeof(struct kvm_reg_list) + rl.n * sizeof(uint64_t));
     rlp->n = rl.n;
     ret = kvm_vcpu_ioctl(cs, KVM_GET_REG_LIST, rlp);
     if (ret) {
+        error_setg_errno(errp, -ret, "failed to get KVM register list");
         goto out;
     }
     /* Sort the list we get back from the kernel, since cpreg_tuples
@@ -904,7 +910,7 @@ static int kvm_arm_init_cpreg_list(ARMCPU *cpu)
         case KVM_REG_SIZE_U64:
             break;
         default:
-            fprintf(stderr, "Can't handle size of register in kernel list\n");
+            error_setg(errp, "Can't handle size of register in kernel list");
             ret = -EINVAL;
             goto out;
         }
@@ -930,7 +936,7 @@ static int kvm_arm_init_cpreg_list(ARMCPU *cpu)
         /* Shouldn't happen unless kernel is inconsistent about
          * what registers exist.
          */
-        fprintf(stderr, "Initial read of kernel register state failed\n");
+        error_setg(errp, "Initial read of kernel register state failed");
         ret = -EINVAL;
         goto out;
     }
@@ -2008,6 +2014,7 @@ int kvm_arch_init_vcpu(CPUState *cs)
     uint64_t mpidr;
     ARMCPU *cpu = ARM_CPU(cs);
     CPUARMState *env = &cpu->env;
+    Error *local_err = NULL;
     uint64_t psciver;
 
     if (cpu->kvm_target == QEMU_KVM_ARM_TARGET_NONE) {
@@ -2106,7 +2113,11 @@ int kvm_arch_init_vcpu(CPUState *cs)
     SET_IDREG(&cpu->isar, MPIDR, mpidr);
     cpu->mp_affinity = mpidr & ARM64_AFFINITY_MASK;
 
-    return kvm_arm_init_cpreg_list(cpu);
+    ret = kvm_arm_init_cpreg_list(cpu, &local_err);
+    if (ret < 0) {
+        error_report_err(local_err);
+    }
+    return ret;
 }
 
 int kvm_arch_destroy_vcpu(CPUState *cs)
-- 
2.43.0


