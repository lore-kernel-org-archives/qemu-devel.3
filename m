Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6DA5CFD62A
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Jan 2026 13:10:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdTIs-0007H7-UE; Wed, 07 Jan 2026 08:10:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vdTIk-0006kp-41
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 08:10:14 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vdTIi-0000Qo-CN
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 08:10:13 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-432755545fcso1172818f8f.1
 for <qemu-devel@nongnu.org>; Wed, 07 Jan 2026 05:10:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767791409; x=1768396209; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5Cs0mvcCcwZ/i+ygFt7FDPPIj7PbgqNY+1moJF/HNjU=;
 b=I1N9DZIGJxAfOH2s0uFNZMU5hiDLssZUzS3ZWKjAZecPR3DPFFiKhy8WJJBKhgWuHz
 +houe7rkB67K0ZZDA0XIGbFuvekx5d0SL/711ygwZ/aV2bm0MNwaOAi7fhMQ6MJfChG2
 cotfcfMlFkploUBehfM5IevkGXm7jtLeeX0Gyx/9neWS08Voic5UH2ZsI1plToGPYMKb
 dFubN27/x3UdSxLldgOZZ8RS13dUInt4RwirCWZOeLln4+DUVlib73rFHPRRZCZpmCtP
 VQm47wU6VxT3s2qd1lqlNdHEB+ehu5koenektFwwDu8I+C2nhtTkH3dbfKsIaEKV+xAV
 iBGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767791409; x=1768396209;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5Cs0mvcCcwZ/i+ygFt7FDPPIj7PbgqNY+1moJF/HNjU=;
 b=Si63VWasUyi/iJXbOhaCPAkd8YCrvqqr63FgjOzCbu5DuMDtmnprp4oPsR/rokMWXl
 UQCPb6w9N6f6mQmc/8Hkw8k3nQK0nqKLT1aX3ioyGLCJjnUaarbet5U8nH2AkYwA+U/i
 zA1S3JO1zC/bW/0P6Y2VVmrYB17ymLixtmeqtdP0KU70GOl4XoEAvpDm5BRBagt6zc6X
 xu0fdM5wpUx0Q7EQjfLosOSjf58O+LXox8Gwp6gppYzQh1V52ebbqB4AKTZD2vQu0CJi
 0ECC0V4AuqVnTC0HMAyMm+rSXzcwyfoQrPbpa4JRC8YNW7sTEAC6SZlCD0ef1E3gLYLn
 SUUA==
X-Gm-Message-State: AOJu0YyqlOmsgYl5UmVYfIXbVZcNt93ybXnWmeanyGOTXgnKp+SNH5DX
 kqWpPMUKzkpefcDEQHYp3uli5bU+zqtBFextuXoP4GGPX8ZsacaLbRe2ARzYxVV/Ckazl4Xw7GO
 tJC9sAVU=
X-Gm-Gg: AY/fxX56b333t3qipE5thUZYSX65XmBHxQnkXRdaNA8oYG76zE4HCJ1E1IvkzK8RMjy
 5qGkmAHxD9gDVkTOd4kWmQ52TqYEq2EiUuqHgQmVUW6hecX2h5Ez0xeJJtdeYvNivyQZX1Gb9kt
 g6F/7VCvn/xY3J71pfHBvXcMSwP/Ki5qGXSG3qaQtjSEqsubudQey+bfQxGuoMI+xixM5w6DtHN
 v9YbDUDUc/p0gMnZvut5k6naSUIDMwrBh/ef7bmYXwxYVR0PzSEWiIyKt+dkIINxZvOf/9jqKV5
 AgWAIgAcBqUmNOCWW7XYgrAtbxLtV+Wj+JhAEOaZvp/imogVxOdYY+f6tY++KDvjo7TBtYc2yl4
 NDFnqvs7+xDt4ubG4fJ8jghbOsCx4fRug6fFdedSxdP3R5YHQPMxvDlTi6JEjCDckekAmGpXR3c
 3OR+iSOEzOOCn/g5Q0CC8/MV0vCHYkgaE+T6cDroy5GxFdBmp5Oki9TJBKKJAY
X-Google-Smtp-Source: AGHT+IH7IAtEGk8cgjS2QxOhY4XEBYztXNqAwLwBC1Bxrn2Pg8f3xlYRNV5vXeaZ/1lpvILikZ6d1w==
X-Received: by 2002:adf:f98d:0:b0:431:266:d142 with SMTP id
 ffacd0b85a97d-432c364309fmr2621684f8f.26.1767791409349; 
 Wed, 07 Jan 2026 05:10:09 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd5ee24esm10461497f8f.33.2026.01.07.05.10.08
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 07 Jan 2026 05:10:08 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>
Subject: [PATCH 17/18] target/s390x: Add more unreachable KVM stubs
Date: Wed,  7 Jan 2026 14:08:05 +0100
Message-ID: <20260107130807.69870-18-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260107130807.69870-1-philmd@linaro.org>
References: <20260107130807.69870-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

Next patch will move s390x system objects from the target
specific source set to the common one. Unfortunately the
kvm_enabled() macro won't be evaluable at built-time
anymore. Add stubs for KVM symbols unreachable at runtime.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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


