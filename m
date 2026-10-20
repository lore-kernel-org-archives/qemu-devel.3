Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9469606A319
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2026 11:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=PfhsTX4X
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJ7Jc-00049d-P3; Tue, 20 Oct 2026 06:43:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xJ7JX-00046N-VH
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 06:43:28 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xJ7JU-0004JB-7a
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 06:43:27 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-48e0d885929so2345237f8f.3
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 03:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792493003; x=1793097803; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=lQ4MX1q3rcBPurkumbq9wX+jGqxuJWd5pa2EGbSUiwo=;
 b=PfhsTX4XEwtiyVdTdH9YhbyhJMwq/on2U1XmTH0fElEQ9g28KCWNyTxZOiAzb1zj/P
 lYqHdU6lHDqIvjjE+LVhc16YcolT/H3tJphMnyC65wbtzQvpKvmQkVmQ5wJpJkAi5998
 AqgcCcxBS7wSa8IFTrlkPOmbPd3eb2jc1hw1Q6ieyrb5FbMlFLfuLGT1v++V7W1QdyxS
 qilrus1NKbdvxFWyRRasn7G44m6qSVGC6YGgNTL+cgUPZNycm43MISafuRXfJQjtLp3x
 ebKIMVE37wiBPZTU4hXW+ZWFqv4nngLs/SgDLGeyyr9ZIiLnv6EQz7WbSvT2mpoyn1lq
 pAaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792493003; x=1793097803;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=lQ4MX1q3rcBPurkumbq9wX+jGqxuJWd5pa2EGbSUiwo=;
 b=COp5O71BxIAYzOzm/c7DZdw0S5HQXKia5W+vtdT6RgGrz7JFriYfAJ4D0T97SPGQuj
 PgQ3NHemi8yVSStR3wML9ZojWV/pLZYdnRR4L5QVBYspb0OMjiXDN9pOg+WJaJhdspzA
 JL609wkIf9n3+mlZjNWgbZ6l/cfAchi/LTKgNKBS2+M3FaIvQ+cf1OG8ZjyKQtspawVI
 zclKE2dRLbYwcT1+mFf4oWrGodS8QyoQ7swVc2F3kcnQMQKStTwmsdTWXAwH1MhHWDCr
 a5LgrxZrSQQOLRowDLN7gQ18o1nQ77C+PZw3N/CaKQIVYVViSMRFEcty/Z7yND4YBPL5
 XuNg==
X-Gm-Message-State: AFq9FYINZfqm4xKVCZrnLij1jUI9r9gUCvLPBQIYKpABfPxEgNZBeMv0
 AaIqyzXgj+Kp2eO8pQpwmcNobJKxRWgVrhXN2mZWo5ozPsganRhhY3Vwh90gHnbUT8k=
X-Gm-Gg: AYBFou1V1HBq9tXiqEiU7aybXweWuu9tkFuNiXCXgfNRSvutf/R7DBhN5l2TdXJaEEs
 GCBsyzDtFPELf1fyvq0baUXE52pm03WPqDDUjLltUxz9Wkz5lcEz1fNNwM3w7fAy4y2+K0VgLdq
 OEspZPuj2s+hvXHMMxSfD5ZOCcFMIlNuI5943g5ZEtpoKW3D0l6VypC3ODVHUre1sWPRyIU+geN
 WaRRf28UvEmO8PQMzb0FJJ/dAcS+J0EgX7skxMbCim3kdCi3XScGgc7mYrIx7y35uhyCAqmPP9E
 B8pls/680EX9+MMs1Gsy6IX1U9aPOTpjRYOhVBOq/KDrXGPiQq++HaMd8ycZaHaujHl+EHUWjMG
 gtpEi8RmktM0TvTDYVFGdIqKiFDmSWcG+iMVNoIBEE3TiP1UE5SiwqMQvKEPBUl+AzlRTDqcpC/
 JeWCl6Ekt+SVANkr/oDnT6b+MwWjkoie3Ik96jTVHdKEwq3LjygAlTGL4fPU7O5kA0rYbPsw==
X-Received: by 2002:a05:6000:46cd:b0:48d:f014:63ee with SMTP id
 ffacd0b85a97d-48e07bbc7d5mr13979635f8f.20.1792493002522; 
 Tue, 20 Oct 2026 03:43:22 -0700 (PDT)
Received: from draig.lan ([185.124.0.158]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e1d80fb69sm4788951f8f.18.2026.10.20.03.43.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 03:43:21 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 57CA35F915;
 Tue, 20 Oct 2026 11:43:20 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Bibo Mao <maobibo@loongson.cn>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Song Gao <17746591750@163.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 David Hildenbrand <david@kernel.org>, Bernhard Beschow <shentey@gmail.com>,
 Halil Pasic <pasic@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Paul Durrant <paul@xen.org>,
 =?UTF-8?q?Bj=C3=B6rn=20Walk?= <bwalk@linux.ibm.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, qemu-s390x@nongnu.org,
 David Woodhouse <dwmw2@infradead.org>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-ppc@nongnu.org,
 Marcelo Tosatti <mtosatti@redhat.com>, kvm@vger.kernel.org,
 qemu-arm@nongnu.org, linux-edac@vger.kernel.org,
 Glenn Miles <milesg@linux.ibm.com>, Chao Liu <chao.liu@processmission.com>,
 Cornelia Huck <cohuck@redhat.com>, Gautam Menghani <gautam@linux.ibm.com>,
 Xianglai Li <lixianglai@loongson.cn>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Chinmay Rath <rathc@linux.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Amit Machhiwal <amachhiw@linux.ibm.com>, Zhao Liu <zhao1.liu@intel.com>,
 Weiwei Li <liwei1518@gmail.com>, Peter Maydell <peter.maydell@linaro.org>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, qemu-riscv@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 01/23] accel: introduce KVMAccelClass and KVMCPUOps
Date: Tue, 20 Oct 2026 11:42:55 +0100
Message-ID: <20261020104320.3686723-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261020104320.3686723-1-alex.bennee@linaro.org>
References: <20261020104320.3686723-1-alex.bennee@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42e.google.com
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
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Introduce a new class derived from AccelCPUClass. It only exists to to
contain the new KVMCPUOps which will allow for a QOM-ified access to
what was previously kvm_arch_foo direct linking. This anticipates a
world where we have a KVM interface capable of launching multiple
architectures.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 include/accel/kvm/cpu-ops.h | 53 +++++++++++++++++++++++++++++++++++++
 accel/kvm/kvm-accel-ops.c   |  9 +++++++
 2 files changed, 62 insertions(+)
 create mode 100644 include/accel/kvm/cpu-ops.h

diff --git a/include/accel/kvm/cpu-ops.h b/include/accel/kvm/cpu-ops.h
new file mode 100644
index 00000000000..662d0c553c7
--- /dev/null
+++ b/include/accel/kvm/cpu-ops.h
@@ -0,0 +1,53 @@
+/*
+ * KVM CPU-specific operations
+ *
+ * Copyright 2026 Linaro Ltd
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef ACCEL_KVM_CPU_OPS_H
+#define ACCEL_KVM_CPU_OPS_H
+
+#include "qom/object.h"
+#include "hw/core/cpu.h"
+#include "accel/accel-cpu-target.h"
+
+/**
+ * struct KVMCPUOps - Target-specific per-vCPU operations for KVM
+ */
+typedef struct KVMCPUOps {
+} KVMCPUOps;
+
+#define TYPE_KVM_ACCEL_CPU "kvm-accel-cpu"
+
+/**
+ * struct KVMAccelCPUClass - KVM-specific accelerator CPU class
+ *
+ * @parent_class: The parent #AccelCPUClass
+ */
+typedef struct KVMAccelCPUClass {
+    AccelCPUClass parent_class;
+
+    const KVMCPUOps *cpu_ops;
+} KVMAccelCPUClass;
+
+DECLARE_CLASS_CHECKERS(KVMAccelCPUClass, KVM_ACCEL_CPU, TYPE_KVM_ACCEL_CPU)
+
+/**
+ * kvm_get_cpu_ops - Retrieve the KVMCPUOps table for a CPU
+ * @cpu: The #CPUState
+ *
+ * Returns: A pointer to the active #KVMCPUOps, or NULL if the CPU class does
+ *          not have an attached KVM accelerator class.
+ */
+static inline const KVMCPUOps *kvm_get_cpu_ops(const CPUState *cpu)
+{
+    if (cpu->cc->accel_cpu) {
+        KVMAccelCPUClass *kacc = KVM_ACCEL_CPU_CLASS(cpu->cc->accel_cpu);
+        return kacc->cpu_ops;
+    }
+    return NULL;
+}
+
+#endif /* ACCEL_KVM_CPU_OPS_H */
diff --git a/accel/kvm/kvm-accel-ops.c b/accel/kvm/kvm-accel-ops.c
index 47244d33f7d..445d7d7f545 100644
--- a/accel/kvm/kvm-accel-ops.c
+++ b/accel/kvm/kvm-accel-ops.c
@@ -18,6 +18,7 @@
 #include "qemu/main-loop.h"
 #include "exec/cpu-common.h"
 #include "accel/accel-cpu-ops.h"
+#include "accel/kvm/cpu-ops.h"
 #include "system/kvm.h"
 #include "system/kvm_int.h"
 #include "system/runstate.h"
@@ -121,8 +122,16 @@ static const TypeInfo kvm_accel_ops_type = {
     .abstract = true,
 };
 
+static const TypeInfo kvm_accel_cpu_type = {
+    .name = TYPE_KVM_ACCEL_CPU,
+    .parent = TYPE_ACCEL_CPU,
+    .class_size = sizeof(KVMAccelCPUClass),
+    .abstract = true,
+};
+
 static void kvm_accel_ops_register_types(void)
 {
     type_register_static(&kvm_accel_ops_type);
+    type_register_static(&kvm_accel_cpu_type);
 }
 type_init(kvm_accel_ops_register_types);
-- 
2.47.3


