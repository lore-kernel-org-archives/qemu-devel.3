Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2112A606A31B
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2026 10:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=vPmALV4g
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJ7Jf-0004Ca-3Y; Tue, 20 Oct 2026 06:43:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xJ7Jc-00049r-Ux
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 06:43:32 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xJ7JV-0004Jt-Eu
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 06:43:32 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-48c4649b35bso2532896f8f.3
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 03:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792493004; x=1793097804; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=EQ7gfcnpJP7Ud8+3W5PCJuKE2nJX2Z7vYXXp9omA0HY=;
 b=vPmALV4gDGYamFoTuBJCIb9umi3/Lx5WPLZXtab3ko46NgZcyM9etroNXub7pf2Jtq
 E8dWdEi/tXNkglzAnczcZNHiAr6ZfSiFnajuH2Y4SfhZNrjvF6Kbn0Sm12QapvCVk9PR
 zHq2lPWDGgb4Vf/oultd/QGnwUre9kcr5FcPWHo/k7JSFs9R0z5EDdqPIJhhLKYOKWFz
 vpbF4lata2/hl9H5SzdcLTgCy+StZGUudlGbMPTXQhZukoBCx/Xe1glPalQ7Z/d9kkBt
 DXD3eQ1k9f3171H1OfZyQy6S4hES4obxDNGH/ypDydsHZOW4WhgBKVI187fJgZaV/QGO
 rN+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792493004; x=1793097804;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=EQ7gfcnpJP7Ud8+3W5PCJuKE2nJX2Z7vYXXp9omA0HY=;
 b=RR5Xxtl+0Uz3uF6KbCYEvD9x1eu5uWVaZDFHv3tcrkz7ZYPf55obKf8kIoj7FAemC6
 u7eVhjhtl36lWmMUq8JNF3hzZnpTKOZVuCfQOQ9sDH2D1wm7i97t98D4UP75jhejmDI1
 rKqVDY2IxQeLOuinNwT+uLZM/6whtd4EoVdTId83BB4ZCb9v1yfLOdTDNtVVgMQUO091
 jCXbpKtR8geptziO0mKmJPzhAQCG13bjU9qECvTQTs2A4riAJd0IBk5uiLNM1LQq6fym
 NXGsowaC83UsLwtWHsCZdiwJ6m8iqWq8PXKfz7FaCh3A0i6n3YUxlizwbdeR/s4Hf6MA
 XNOQ==
X-Gm-Message-State: AFq9FYIRlMRGDXkxVR8EgUt0goRJgqDT+02NCeOuOaq/N5GXfCzoRtXV
 DpPQrAvcHSkXroxfF/bEUkHY9AkvIoljoHeOzza57ZPhw/82HYaErDCV3fe6U2gte7Y=
X-Gm-Gg: AYBFou1eT2n/cetkjFfSnJB/beo6+7hHXg54UglzvVDzlAp3xFCi0mzf2/J7CNilSRB
 yax0Li9RkVkhpbVOC+YyJPWxpAaKyqKQdHQnuEjY49Jrt8sbmTcBrouYElD7LWkCC0lI41WJqSv
 EFP1vkR/+tPbgbRIXYdSJHALB90J3xpEb1ywaOXA5b3iW/SxJBYKYXkIRyC9uF0QTFvZZQvXiv6
 Ilda/uJC/zFBgtb5bnmf86rw75HEaAEdekZxxRC92tErg4ebwGeI82ORhrQcTR7tlJO1KIO5Zdy
 g8F4By/oj5YsvNtcdYu3PEaShtls1kZ77q0DHo3ANjJGtozoyXhUUs/2QKvCvNR8VNX+AHYLYLU
 /a3ZycC5GE5au3R5U/CeHTmD8AOvBByj7smfvZgDQSsIhYHuvDTP03du1GfQldxVe84X7Q8o8ba
 6CJJWCZsV6oyxc9cGF4e2wqk6cFplDnHzJMLgKKUWgyekHxGoKAq7Rb9YV3eXjiNt+HVpkODM=
X-Received: by 2002:a05:6000:607:b0:48d:f58f:c91 with SMTP id
 ffacd0b85a97d-48e07bb5919mr21536746f8f.19.1792493003575; 
 Tue, 20 Oct 2026 03:43:23 -0700 (PDT)
Received: from draig.lan ([185.124.0.158]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e1d820822sm5769631f8f.34.2026.10.20.03.43.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 03:43:21 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 92FE85F9E2;
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
Subject: [PATCH 03/23] target/ppc: wire up empty KVMAccelCPUClass
Date: Tue, 20 Oct 2026 11:42:57 +0100
Message-ID: <20261020104320.3686723-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261020104320.3686723-1-alex.bennee@linaro.org>
References: <20261020104320.3686723-1-alex.bennee@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x435.google.com
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
 target/ppc/kvm.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 8e89a6c665c..8e9328beeb9 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -50,6 +50,7 @@
 #include "system/kvm_int.h"
 #include "system/kvm.h"
 #include "accel/accel-cpu-target.h"
+#include "accel/kvm/cpu-ops.h"
 
 #include CONFIG_DEVICES
 
@@ -3080,17 +3081,22 @@ void kvm_arch_accel_class_init(ObjectClass *oc)
 {
 }
 
+static const KVMCPUOps ppc_kvm_cpu_ops = {
+};
+
 static void kvm_cpu_accel_class_init(ObjectClass *oc, const void *data)
 {
     AccelCPUClass *acc = ACCEL_CPU_CLASS(oc);
+    KVMAccelCPUClass *kacc = KVM_ACCEL_CPU_CLASS(oc);
 
     acc->cpu_target_realize = kvmppc_cpu_realize;
+    kacc->cpu_ops = &ppc_kvm_cpu_ops;
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


