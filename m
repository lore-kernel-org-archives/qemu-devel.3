Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2558B606A31D
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2026 10:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=pH4snO+n
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJ7Jm-0004HZ-L3; Tue, 20 Oct 2026 06:43:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xJ7Jf-0004DC-CC
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 06:43:35 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xJ7JW-0004Ko-MS
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 06:43:35 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-48bbb06e746so1592875f8f.3
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 03:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792493005; x=1793097805; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=xpvK8hxiiby7P5GAABphDAJ86oAgF7lyRnWJr7JT/sM=;
 b=pH4snO+n+tK8npEh5Hcs3JcM0q1mTOJ9zdmziUOKQ3QBteryHWf/cF8v5QFC3V2pzf
 71k8E7OOqxh7zbAuxXK+RVTTFUH7z5MnevEmwSbsofHTfL91V0Hixo8cniQHClyZB5hF
 Tk4NBcCah652FlMstMgCsurf8DuY7V5XtvUzpT8XZ4uDVQwqVbfyH7t5AITo7yHPyGSZ
 srxrhp3u44+N21zHBy2Hy4WkOI2hEAof70OQ7aBGtsdqUnU8AitYOvjZhXr5iyI8S7L0
 ykwIRX0ucApkb5gyy/cKnczdvJW+2yn4Wom4joTGwGdEq3OR6Dyr3jbEJqYUDM6bAThx
 h9nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792493005; x=1793097805;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=xpvK8hxiiby7P5GAABphDAJ86oAgF7lyRnWJr7JT/sM=;
 b=HQGQT0jNuovdODKU7MQG6RJYS/psJQAFiEvfMi+iIiiV2LLUpxQXuJFE5Q2J4qJYZf
 5WTighHtFWKsUwjmobgJejtzcM3pKRWFUALIcVX/ooCsI3nFEo2PVtQP18B3L9DnhRcE
 XgqNA0YLVGwEbylGMH+Ywh/8KHwYta7T87dHYrCZtvGDWjptjXEOQylOp3XPzGcBi79J
 A3hkssIqkdQmImfXBP7bOnUDka0e6yRFyave1SNT4/Fo2vQuqMeahOZb9UgkHOg8TSS8
 ZO2tiqYu3/DHhqg05pKQex+YKs11ajDg8xAQkncW9FDHeSnrZ5Dlkcg0Tx8jliwOTWoq
 Y59w==
X-Gm-Message-State: AFq9FYJ/UPjftcQeX9QmjPUbxzolB0Yctpxs3k8hHEFXnQu5rymBdnho
 JvTo37yDk+LFAuyCKwtfQ9WeQPvKNZfp32B0hDxBJwHn50YB+9t/m/x/0dcIrqtZNU0=
X-Gm-Gg: AYBFou0U+R+4VhrgGeIK5rb+Y2uV8gG++dwwmcu7LED119gDFsly+MESKXNQCUqa/vd
 4UBHo/mLUXOZedD90pTcbFRDGCsHZ3QNu+wBp2PFGHAig+wS0D0wCa37Wjc6PhjjtClhEyiNbJd
 cazeJwD44U3KbMULRExGz110ByPN+cuALOC/jeA1TajWKUMLC5mi907i7aydb/6dd433SnAiwUl
 p8mO7CcY25qsiA2LrRUyk0OcGyS9WlmNpf6CL/JgLtf/tWlrCzPba8Lw64E5bamRQ/6Bn/rLxxU
 7o0PyE2NMFrjUplG+O+g3VngEj54wbRuCHBYJ+1qo/OsPM9Zybw0M6lwQSsLcBuyQqf9BT9+wjm
 0bx0QX7fJkNzRAwA5hBZuk4eAoepZEzbRWZigf+9wQihooGfk4hVAi/yy1zvePMcBi6ymAKTM4a
 QK3uGsEdVwRVRXd6T8Zh9KMwgGsBS1le2JUyUgkaS8WVrW9amPcJ9zHRw5LBkalz0T35BRx+s=
X-Received: by 2002:a05:6000:2388:b0:48d:dec7:974c with SMTP id
 ffacd0b85a97d-48e07985764mr20442510f8f.7.1792493005061; 
 Tue, 20 Oct 2026 03:43:25 -0700 (PDT)
Received: from draig.lan ([185.124.0.158]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e1d818237sm5338778f8f.27.2026.10.20.03.43.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 03:43:24 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id CBA755FA65;
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
Subject: [PATCH 05/23] target/arm: wire up empty KVMAccelCPUClass
Date: Tue, 20 Oct 2026 11:42:59 +0100
Message-ID: <20261020104320.3686723-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261020104320.3686723-1-alex.bennee@linaro.org>
References: <20261020104320.3686723-1-alex.bennee@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x434.google.com
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
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

We will fill in the functions in future commits.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/arm/kvm.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 3d905f8565d..7a3c957c3a5 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -42,6 +42,8 @@
 #include "hw/acpi/ghes.h"
 #include "target/arm/gtimer.h"
 #include "migration/blocker.h"
+#include "accel/accel-cpu-target.h"
+#include "accel/kvm/cpu-ops.h"
 
 const KVMCapabilityInfo kvm_arch_required_capabilities[] = {
     KVM_CAP_INFO(DEVICE_CTRL),
@@ -2662,3 +2664,26 @@ void arm_gic_cap_kvm_probe(GICCapability *v2, GICCapability *v3)
 
     kvm_arm_destroy_scratch_host_vcpu(fdarray);
 }
+
+static const KVMCPUOps arm_kvm_cpu_ops = {
+};
+
+static void kvm_cpu_accel_class_init(ObjectClass *oc, const void *data)
+{
+    KVMAccelCPUClass *kacc = KVM_ACCEL_CPU_CLASS(oc);
+
+    kacc->cpu_ops = &arm_kvm_cpu_ops;
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


