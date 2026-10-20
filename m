Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE46606A319
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2026 10:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=WLk8/Ghn
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJ7Jv-0004ML-9V; Tue, 20 Oct 2026 06:43:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xJ7Jd-0004BN-Vy
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 06:43:34 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xJ7JW-0004KK-3G
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 06:43:33 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-48e10a70540so1300435f8f.1
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 03:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792493004; x=1793097804; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=W1YwD7IMkeAO6OcLReHpxRqQRfDPA/W1esQDN17JAFU=;
 b=WLk8/GhnBAieYOmX5YzfTP0mUrMUmVZAg2B+KvR39R/M5uB5DJ+7uF26XOABPfeqeP
 vRk7l4jSFagwJqIL7hNe7aj5datw3BXx+bb/tQQNL/eI5Gvn+8/NfxEazDUlJCOIHg1P
 YCWgJyAcISEIgOoNXzFEsTRALa73sK35O5uhgG/LBayB+71L9gnZfJ+A/KVzVk5Gj6GT
 QsOLGr9OAfBk9IgZb2BL9nnfdE1StgvhNqPjI+llNilprLpnL1Nj2LW8Glu6Bj8oG9qV
 ZXNEDqDj99KMhX98okb8zcPyBhyh9PO85uHDHwHV7oOxh/mFzfRa6bQkgav02e1dI30o
 FNGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792493004; x=1793097804;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=W1YwD7IMkeAO6OcLReHpxRqQRfDPA/W1esQDN17JAFU=;
 b=K6vQbdvlAaV01HdiL8vYG/1dLO6q1bhjxvauAWRLNmmLqbTZnPKa6Zb9VT+fz4RnXN
 20XqapxXsdQeARxWhngKH4wKqwbazsij4O2mG3nI4Ekp3flG5JQBUlz58mcYHVd6ckKf
 zufv8Cw8uVhM5UH3auhIsH0uk4ZBs2brn3xJW2QI/FsoSJ7oOK3W82U8OJ4CVIX06KjC
 i6emp5wLtQkFV+hOKECRuC0GCRDYW92mTLUz8Byg+JFRKVmI8eXL+U1XpWfEHtCTxby0
 0GwDQCvkJc49vtBrUsmeodY3GInhPgbVgW6DUO01PPfS+flMNSTpwv0MzrhV22JdxESa
 lRyg==
X-Gm-Message-State: AFq9FYKnAzx2FSEHZPTT2hEvhsS1qY5O/Q573Z6Sr9qJA71zH037vLUE
 Bp/V+5NBTetHxiUigXXGJzi8Z1HqS2IT46m/J7Cv6ccnJREvmPxo1YDiQonMoZcwibo=
X-Gm-Gg: AYBFou2OL5oQkQti9ojQwVZ70895MKyUUPjbXV6dZ0lAET3BY1NP0lExu53oXg084tN
 a94+YCKgb8xNkY8wy2lr3+Bhkoto8Pg746kdKbGsXwfQ7XR3Da4DcPBwXvTg1I9SH2z89wty73g
 YPthm1P26pQqb3/e0IA96sEM1/GLxp7WJYHfFrR4RS+UIbiT/nEs/msZSFIUa39PjpSQln9BW/L
 HIB0SjDnrKLV2lVjb5wd/4LfnT0E9BPbjuPZUg1SOyLP7pWE0QY32dpuJVM7sLujkbkqWMDW6N9
 itc2tpz8xlAvftJEp+qbveQFCpE3EiuGsLFlIJfQijpDIJUGnJhClZL4fG7KcKqdW1o2PdqgeOc
 +FexvcYFCzcw6DZTJrl+LOmgzt/8hnQTejmXDH2xESVyEG8v43XU97g3sFE+/MDS+6K/LYt8WWg
 OsPFiR4DfflT1M1vfQu6FK691hcBlSANLMexgogHm4I9Rb5YbAoxVwAul1sLVhZJq/69IMww==
X-Received: by 2002:a05:600c:8b6f:b0:4a1:d307:d578 with SMTP id
 5b1f17b1804b1-4a1d75e6d1amr197176025e9.11.1792493004251; 
 Tue, 20 Oct 2026 03:43:24 -0700 (PDT)
Received: from draig.lan ([185.124.0.158]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1f2c9e9c3sm56999645e9.3.2026.10.20.03.43.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 03:43:21 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id B08A65FA43;
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
Subject: [PATCH 04/23] target/riscv: wire up empty KVMAccelCPUClass
Date: Tue, 20 Oct 2026 11:42:58 +0100
Message-ID: <20261020104320.3686723-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261020104320.3686723-1-alex.bennee@linaro.org>
References: <20261020104320.3686723-1-alex.bennee@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42f.google.com
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

We will fill in the functions in future commits.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/riscv/kvm/kvm-cpu.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index 45ad5e1525a..b3fa0548c8a 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -33,6 +33,7 @@
 #include "cpu.h"
 #include "trace.h"
 #include "accel/accel-cpu-target.h"
+#include "accel/kvm/cpu-ops.h"
 #include "hw/pci/pci.h"
 #include "exec/memattrs.h"
 #include "system/address-spaces.h"
@@ -2195,18 +2196,23 @@ void riscv_kvm_cpu_finalize_features(RISCVCPU *cpu, Error **errp)
     kvm_riscv_destroy_scratch_vcpu(&kvmcpu);
 }
 
+static const KVMCPUOps riscv_kvm_cpu_ops = {
+};
+
 static void kvm_cpu_accel_class_init(ObjectClass *oc, const void *data)
 {
     AccelCPUClass *acc = ACCEL_CPU_CLASS(oc);
+    KVMAccelCPUClass *kacc = KVM_ACCEL_CPU_CLASS(oc);
 
     acc->cpu_instance_init = kvm_cpu_instance_init;
     acc->cpu_target_realize = kvm_cpu_realize;
+    kacc->cpu_ops = &riscv_kvm_cpu_ops;
 }
 
 static const TypeInfo kvm_cpu_accel_type_info = {
     .name = ACCEL_CPU_NAME("kvm"),
 
-    .parent = TYPE_ACCEL_CPU,
+    .parent = TYPE_KVM_ACCEL_CPU,
     .class_init = kvm_cpu_accel_class_init,
     .abstract = true,
 };
-- 
2.47.3


