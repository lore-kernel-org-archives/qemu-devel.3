Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A64A7606A319
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2026 11:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=MhdW5VBk
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJ7U6-0004x6-DR; Tue, 20 Oct 2026 06:54:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xJ7Ru-0001Dp-S3
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 06:52:07 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xJ7Rp-0006fh-Of
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 06:52:06 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-48e0d1c095dso1759568f8f.1
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 03:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792493515; x=1793098315; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Ko6yZh9M1s2VW5tIdG2OCTSHQVjujibVM95DZEJ7phw=;
 b=MhdW5VBk8JK1lv2xTomhmWZhsPiHismVa7v5GiTIPMguVKMSPwssovYYGWygTESLDV
 fnfZwkMaxL33cF9wdoiGWAcNLT2R1VPIK2V4nyGwWnM/iDOnrSNZ1Fi1JLxUZTswRxq+
 guqYugaYSZ2YNdZZ+efhdI/rBgUfSZEYbdNDyxxKD0A1k08+7o+9OMHonvYfilUL0A/5
 1DjFbsdHscFiwy+io2/gw6Bzz7UC+QRUpEJO40OhqX3gVF4KKrCKijHo4U4zGI/WxDnC
 ao3wAQTH5Il4NvXQIhefK4hah7F2BcIxCSExU4wF+D0lRgSJsOLanoGEA52KVCkiONBx
 tahQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792493515; x=1793098315;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Ko6yZh9M1s2VW5tIdG2OCTSHQVjujibVM95DZEJ7phw=;
 b=z7N2wXt+eANpfBZwKJDURznpJtv9x7lRWCCMcqWUaJnzLKP+TXGS+c+YWgioiYUdHw
 1O63ApFmBc/MO/VQR0CyN86WylZowG/lCw2c8HgXQ84+/NOnBZvkdp+eCAXRkBTRpsCy
 uQHrYDr8YDOk32Levlj6B9jUSQ+B2MdDHNBcHZgQOjZ/RF4s/gx5H3k/8B1ACq6zD7ny
 U2OIJER07+ttjTPc5EMX/O7EqQAFcWv9vBQ+0/UG7jO0kgYtBMHM7fsVju35nJg0IVAI
 8lQiO7lgarloG5eCDxa1X/t37LSuuNjq7s7T5zoIHMyU6EH8GOdf8603avgHGov6WEMm
 tOwg==
X-Gm-Message-State: AFq9FYLyIZEbq1LGlnv5QsDIHQKr96wRtbMffFTZit2lk3llLa18MFAn
 RJf1dJt0ZKlBcuReumgSsamtu8NmLI6xRJ2wmDgvZEZInCTGDd+otl19QzKkNRct5Ug=
X-Gm-Gg: AYBFou08yxcqt14LKV6SAzsEg1eBEpjoCG0fZWjzD4i2j7yfx2MmWf8pRQ+BuChFD/7
 faMQcZf73+xE5oXxgazpVgwet1NYyhI3+L07g4KB47LjH6pMOq1UNi7Y2K3uBNFGICewcnhrp6n
 +nTILSpphbBJs3nrWKa1dIJdDdwu4nQKCPBsBr/d6hE27al083c/w9AEBOQ/Vsf3E0gmEqRygzK
 2N0OBbtdnotNSRzijWL5ZrC4Vpx5aylaY6syPqxHi3MA3yqeBobqbJkvM8zTfN1wJK0CQphQPSN
 57KzFCBS9TSfRf08No3TLp3UPoriRvhN/PFBllVZJSFWFEQDNF5zPyWV6BEPzDAfScomAV5IUcm
 8cPXI85jTNlGFNAZvjFiZuY0XV7PD34pBRKwt0fVmTdjVzS2hAayjZlnJfCwCawJYzmzGPjf+wI
 U8Rt3+/A3ugzO7Pi9Z2mKW03aATKBBgrNB+IeKFK2io/JBpR3GeZpPduL7ppK/VcCc5Cgj8g==
X-Received: by 2002:a05:6000:29d2:b0:48b:f93:3b87 with SMTP id
 ffacd0b85a97d-48e07fc7a04mr13714326f8f.30.1792493514603; 
 Tue, 20 Oct 2026 03:51:54 -0700 (PDT)
Received: from draig.lan ([185.124.0.158]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e1d80f9cdsm5176970f8f.11.2026.10.20.03.51.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 03:51:53 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 95B4C5FA43;
 Tue, 20 Oct 2026 11:43:24 +0100 (BST)
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
Subject: [PATCH 22/23] accel/kvm: cache KVMCPUOps
Date: Tue, 20 Oct 2026 11:43:16 +0100
Message-ID: <20261020104320.3686723-23-alex.bennee@linaro.org>
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

Doing a QOM cast each time we need KVMCPUOps is overkill, especially
considering it is a single static assignment when we configure the
accelerator. Cache the value on kvm_init_vcpu and use it.

We also assert that anytime the system asks for KVMCPUOps it should be
at a point we can honour the request.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 include/accel/kvm/cpu-ops.h | 13 +++++++++----
 include/hw/core/cpu.h       |  3 +++
 accel/kvm/kvm-all.c         |  4 ++++
 3 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/include/accel/kvm/cpu-ops.h b/include/accel/kvm/cpu-ops.h
index d43bc845ad5..075bac1d494 100644
--- a/include/accel/kvm/cpu-ops.h
+++ b/include/accel/kvm/cpu-ops.h
@@ -156,11 +156,16 @@ DECLARE_CLASS_CHECKERS(KVMAccelCPUClass, KVM_ACCEL_CPU, TYPE_KVM_ACCEL_CPU)
  */
 static inline const KVMCPUOps *kvm_get_cpu_ops(const CPUState *cpu)
 {
-    if (cpu->cc->accel_cpu) {
-        KVMAccelCPUClass *kacc = KVM_ACCEL_CPU_CLASS(cpu->cc->accel_cpu);
-        return kacc->cpu_ops;
+    if (cpu) {
+        if (cpu->kvm_cpu_ops) {
+            return cpu->kvm_cpu_ops;
+        }
+        if (cpu->cc->accel_cpu) {
+            KVMAccelCPUClass *kacc = KVM_ACCEL_CPU_CLASS(cpu->cc->accel_cpu);
+            return kacc->cpu_ops;
+        }
     }
-    return NULL;
+    g_assert_not_reached();
 }
 
 #endif /* ACCEL_KVM_CPU_OPS_H */
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 456154df6f6..1e164036286 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -473,6 +473,8 @@ struct qemu_work_item;
  *    ring is enabled.
  * @kvm_fetch_index: Keeps the index that we last fetched from the per-vCPU
  *    dirty ring structure.
+ * @kvm_cpu_ops: Cached pointer to the KVMCPUOps table to avoid QOM lookups
+ *    in the run loop.
  *
  * @neg_align: The CPUState is the common part of a concrete ArchCPU
  * which is allocated when an individual CPU instance is created. As
@@ -554,6 +556,7 @@ struct CPUState {
     uint32_t kvm_fetch_index;
     uint64_t dirty_pages;
     int kvm_vcpu_stats_fd;
+    const struct KVMCPUOps *kvm_cpu_ops;
 
     /* Use by accel-block: CPU is executing an ioctl() */
     QemuLockCnt in_ioctl_lock;
diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 5189cdc6a01..041113ed9b5 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -746,6 +746,9 @@ int kvm_init_vcpu(CPUState *cpu, Error **errp)
     KVMState *s = kvm_state;
     int ret;
 
+    assert(ops);
+    cpu->kvm_cpu_ops = ops;
+
     trace_kvm_init_vcpu(cpu->cpu_index, kvm_vcpu_id(cpu));
 
     if (ops->pre_create_vcpu) {
@@ -4111,6 +4114,7 @@ int kvm_on_sigbus(int code, void *addr)
      * we can only get action optional here.
      */
     assert(code != BUS_MCEERR_AR);
+    assert(first_cpu);
     ops = kvm_get_cpu_ops(first_cpu);
     if (ops && ops->on_sigbus_vcpu) {
         ops->on_sigbus_vcpu(first_cpu, code, addr);
-- 
2.47.3


