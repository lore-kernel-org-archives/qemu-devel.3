Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B7B6606A322
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2026 10:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=TvvgZIbM
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJ7KH-0004pR-Dk; Tue, 20 Oct 2026 06:44:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xJ7Jo-0004Jh-OY
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 06:43:46 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xJ7JZ-0004NP-GP
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 06:43:44 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4a140e7405dso26647525e9.3
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 03:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792493008; x=1793097808; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=EmgF4PQPx9bMlndd3x44tzG0fL4M//RuzZARimvwNlE=;
 b=TvvgZIbMkbY3WFVYt20NT1IYS1J7042qre5IpobbaZqwpqLODE3xG7OKLqGk2ojc07
 Okc9LFR0hg3uN1r4ydMslswsFdBuO5KotIwm5gErdEhZPBIht8g5Bv1Ec6I13dIRRDCR
 5ZgPoSClLjLgsRhLdM6LMVfm+wg0otdtWixQbR/8A2pUmzrAmUJWArwajfzI3woOc1OH
 3G3Z7BYK1mejqu5QJDKNlZE+fXFQsrEh318pfslGcb2YW1soaMvPtkxpi44ifFOPt+ue
 RE0PL1IUHXANi1TkXdZ/wEEaUU3GHWmgHX/lAxUodysOCU6w8Yc07cUFXgl+c2CZJA+G
 rSsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792493008; x=1793097808;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=EmgF4PQPx9bMlndd3x44tzG0fL4M//RuzZARimvwNlE=;
 b=Yiau4Ma1TdiXb2wDjfk/VYueLCKnaLgWE35qDYy8COjFoi72s2h34BGi2BZcdpMPhs
 0k+JcTAf7pi3AZP+V5EgnnyoAodi5XTTWyZpw44Qj331NTyuRUoSZ5keGWz8lK+WQeFV
 tos8wKn4K6r4uHWYxAJJ+J6bJvKL41uCmxX2BWXlnwotZ2Z02qf/SGgs5hFtSGzIo5kM
 rr7bkCWrmC+8vbXfrn5xNRSUEUn4lSuDSNju+tU8DhuRA4zXir+OWVY0xQdXKLLI6aBo
 F1zKVyyFebMQ4sXkgiQbnboRj9JZhYaPbbJJvk8drB3Nez9CxpVwNeEuSWVxpTq5uPEP
 HmYw==
X-Gm-Message-State: AFq9FYJHc09/OH8mceO1mIxsYEMMuLiy5hfJYV1BkyiPZwUFvobR/mOH
 HBH3pTtOm9dpdCBNDTuEX60+AzUb56J8RxzXjcENq7aOnRBZsAdvaU6LTluFK/fl9/Y=
X-Gm-Gg: AYBFou21mND2KxqPsT7JqygDsvqcYpw0GAXzxF6ekWx160e9GqSb9gHXQ1jhTMW4rJA
 b20J2oKyapvhxSOtwzs7W19lnNArKGAS2GAAmXlhnji1PE20Ed/Y+yRRHkadUNzwQm0+1gO6IHX
 FjdAXJx4wI+026IUefpwNd4vackRDQL5p5rJRVKnhCfoMk2DLZKMf5KTkf0xoNqP+/EB05iocdC
 K6TPo3c44HcdzcZkmaqRfW1wCOGmqR4HKlRYfePghd2P4sTw8IZg6pqaPPfI7fwVyiT84Ah/shk
 H+0p6CM/n6cie9f6eeZveaKIV1ZzbQwhwjUw7Psz1vk81eNO0g+jK/0Lag8hUr95a4xkLN2pvTa
 IeHGRy4WGc4C2yLil14hPD2LTRpeLgStj6XeTBAWp+9t8EQtmvtI5bMdjcaNsIsC3g9qAjbSVry
 lsAcxpEDSKlyuKzGO21U4ffk1EIAV+lfBcGbLgn69oMCLTCfCqIfxqVjnM+thgEhbQrs7W/Q==
X-Received: by 2002:a05:600d:4187:b0:4a1:f99e:f22d with SMTP id
 5b1f17b1804b1-4a1f99ef467mr11426185e9.6.1792493007433; 
 Tue, 20 Oct 2026 03:43:27 -0700 (PDT)
Received: from draig.lan ([185.124.0.158]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1f863e709sm9184055e9.3.2026.10.20.03.43.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 03:43:24 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 14B1A5FACD;
 Tue, 20 Oct 2026 11:43:21 +0100 (BST)
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
Subject: [PATCH 07/23] target/loongarch: wire up empty KVMAccelCPUClass
Date: Tue, 20 Oct 2026 11:43:01 +0100
Message-ID: <20261020104320.3686723-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261020104320.3686723-1-alex.bennee@linaro.org>
References: <20261020104320.3686723-1-alex.bennee@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x335.google.com
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
 target/loongarch/kvm/kvm.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/target/loongarch/kvm/kvm.c b/target/loongarch/kvm/kvm.c
index 941142305e4..4bc08f195ed 100644
--- a/target/loongarch/kvm/kvm.c
+++ b/target/loongarch/kvm/kvm.c
@@ -29,6 +29,8 @@
 #include "cpu-csr.h"
 #include "kvm_loongarch.h"
 #include "trace.h"
+#include "accel/accel-cpu-target.h"
+#include "accel/kvm/cpu-ops.h"
 
 static bool cap_has_mp_state;
 static unsigned int brk_insn;
@@ -1648,3 +1650,26 @@ int kvm_loongarch_set_interrupt(LoongArchCPU *cpu, int irq, int level)
 void kvm_arch_accel_class_init(ObjectClass *oc)
 {
 }
+
+static const KVMCPUOps loongarch_kvm_cpu_ops = {
+};
+
+static void kvm_cpu_accel_class_init(ObjectClass *oc, const void *data)
+{
+    KVMAccelCPUClass *kacc = KVM_ACCEL_CPU_CLASS(oc);
+
+    kacc->cpu_ops = &loongarch_kvm_cpu_ops;
+}
+
+static const TypeInfo kvm_cpu_accel_type_info = {
+    .name = ACCEL_CPU_NAME("kvm"),
+    .parent = TYPE_KVM_ACCEL_CPU,
+    .class_init = kvm_cpu_accel_class_init,
+    .abstract = true,
+};
+
+static void kvm_cpu_accel_register_types(void)
+{
+    type_register_static(&kvm_cpu_accel_type_info);
+}
+type_init(kvm_cpu_accel_register_types);
-- 
2.47.3


