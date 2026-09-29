Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72328CA5FA5
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 10:06:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBUet-00071S-8Y; Tue, 29 Sep 2026 06:01:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xBUep-00070G-Qj
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 06:01:55 -0400
Received: from mail-wr2-x0e.google.com ([2a00:1450:4864:30::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xBUen-00089V-G7
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 06:01:55 -0400
Received: by mail-wr2-x0e.google.com with SMTP id
 ffacd0b85a97d-48af0707d41so338148f8f.1
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 03:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790676112; x=1791280912; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=m+lF7RXQd5W67CDHLzSCshhC0nrWXqxZbKpmhm460aY=;
 b=YXKyoqF/J+uvCxE2EFyeTVELthu2JSqFL26xiXHfyM7jM4IPadNhOpS7+bQHElgwjw
 5XKAG9PRVhvaIZBnMqOpTIrnG44Sg8I2MZ/GVRixHxquRG6/WhAVBK3db/J+ctjvtm/O
 /mvMpIwZurOOKNbTeVOs6FIt8uf5i84sDXRDGk7+wv5nz6MGNTsoqQsVz++lkRaomrQ+
 vW19vnP7nw4ncSt4TYH6eHJnbVYHjBSNojKLQMFyVOetEoLOm1UV5BwwdhjA2uev+jOH
 IjpX03UgCfhbNWkrcd3hcgNCGmuSaK3gKWrK1CwjQRJ7ltKR4dkX3QVhMIM/TUpx9SIc
 t/mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790676112; x=1791280912;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=m+lF7RXQd5W67CDHLzSCshhC0nrWXqxZbKpmhm460aY=;
 b=NfrJM3+5tgcyjG1UoLhsKpvenRU/sZgwwd3oUDo0nMK0xFVMHC2CcT2/eOPbQLybid
 sr/bqIq90xBXEJK6Irw9UmLH3V9enWyasygNAGQfmeN2fy6S0BDS3ONd46NG9i0l9ClY
 Rme4UV+8YrzSgODeMTNUyipG8usZWjJ5Vx4X5UzQRMI0Jx0xBvcuyCyqGM09cq26qrjm
 6d9tYKEO3YbrAfegPcFsfjGfYpmtNr3i3fClw6Qm3k1Z37jGrjuW+5cvsiLEspvugCcP
 G5a8xLi/QKpQSuuILdwXUW0VVEUgfpxEJ/9CK9tl/De5rT0kBWeHvQngGnpx+lWJSBwl
 vMWQ==
X-Gm-Message-State: AFq9FYJCgWEAPs0BE2lI3+mMChGvOoN03inEzH3HYfVTN6SLySpTWgj+
 EhU78B52mrqEtW2lN9OBcjcctWgDj6ByOZpxgPO13OP3H9a1as4tPwFhSsA4EGsieRYvOpKzlEQ
 UB3Vg
X-Gm-Gg: AYBFou2bS1U8RE3MBLAI/QQhfZs5nCfvFB7goeS1XvcJhYkrDYMm94xoNdghBDWxGGN
 1qso3Fyc/wfyvvRaby7B3jLhu1umx3et60BSXUmw0Iq9w/6Yjn1W3UDFBN7Vjzg5Ezjx+fRswOQ
 PSpv3xA8KNt0XLX9BEAT2OXOQySZ5wRTHC9EgZHDM9gT1L2ovJ4aR3Q6KnP+WR/u39Yafe3Q+VS
 KvNpVi1J2peYrm64PxrWqCfPbj4Tp9p2srwjrcwC97vX6/3HtgMy0s7w/2ykTMObGSxUb0zyQ/e
 G/7loih1XTP/paKvQPD3cm0bwUBOw/zE1f/qk4nP+9KxTO47h5drZfuyEoKp3YYsazmXyFIR1Vc
 xWLEuTRlfvHOkGuEACNIAOSIj1jurGv/cFZwt20yfwaQ+yCSm9AL62sMuGbvBWcuF+FOygGvNw2
 AMl3Mm/QNlEzDAm6yfMHYcxaP6bhsdXbz5VRVYrapOaQ9QtWa16Gnkk+w64PkD+BLTCoAUYlpFK
 BGKIa9xAonXScgtrqBoEbl6zXAduWu6o8H9kGLTKsXKJsHlyUXhVGA8S/LlfiAfnmQsJylsWB6p
 orWFvsyysNMU0Q==
X-Received: by 2002:a05:6000:2893:b0:488:7fdb:46b5 with SMTP id
 ffacd0b85a97d-48af1b2e134mr3268887f8f.20.1790676111803; 
 Tue, 29 Sep 2026 03:01:51 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48af4f88b37sm3091412f8f.5.2026.09.29.03.01.50
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 03:01:50 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 11/37] arm/kvm: get demuxed ID registers from kvm
Date: Tue, 29 Sep 2026 11:01:06 +0100
Message-ID: <20260929100133.2598676-12-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260929100133.2598676-1-peter.maydell@linaro.org>
References: <20260929100133.2598676-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:30::e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr2-x0e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Cornelia Huck <cohuck@redhat.com>

We now have the infrastructure in place to handle demuxed ID registers
from kvm. Use it to get the values that kvm emulates for CCSIDR_EL1.

Tested-by: Alireza Sanaee <alireza.sanaee@huawei.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Sebastian Ott <sebott@redhat.com>
Message-id: 20260916165117.39764-4-sebott@redhat.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
[PMM: rewrapped comment with overlength lines]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/kvm.c | 43 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index ed99be7fd80..3d905f8565d 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -244,6 +244,45 @@ static int get_host_cpu_reg(int fd, ARMHostCPUFeatures *ahcf,
     return ret;
 }
 
+
+/* CSSELR values supported by kvm; used to index KVM_REG_ARM_DEMUX_ID_CCSIDR */
+#define KVM_CSSELR_MAX 14
+/*
+ * QEMU historically supported CSSELR values 0..15. This difference
+ * doen't matter since CSSELR_EL1.Level == 0b111 is reserved and thus
+ * CSSELR values 14..15 will make CCSIDR read as zero. Larger CSSELR
+ * values will only be necessary when support for MTE Allocation Tag
+ * caches is added.
+ */
+#define QEMU_CSSELR_MAX 16
+
+static int get_host_cpu_reg_demux(int fd, ARMHostCPUFeatures *ahcf,
+                                  ARMIDRegisterIdx index, int subindex)
+{
+
+    struct kvm_one_reg one_reg = {
+        .id = KVM_REG_ARM64 | KVM_REG_SIZE_U32 | KVM_REG_ARM_DEMUX,
+    };
+
+    switch (index) {
+    case CCSIDR_EL1_IDX:
+        if (subindex >= QEMU_CSSELR_MAX) {
+            return -EINVAL;
+        } else if (subindex >= KVM_CSSELR_MAX) {
+            /* CSSELR_EL1.Level == 0b111 is reserved. */
+            ahcf->isar.idregs[index + subindex] = 0;
+            return 0;
+        }
+        one_reg.id |= KVM_REG_ARM_DEMUX_ID_CCSIDR | subindex;
+        one_reg.addr = (uintptr_t)&ahcf->isar.idregs[index + subindex];
+        break;
+    default:
+        return -EINVAL;
+    }
+
+    return ioctl(fd, KVM_GET_ONE_REG, &one_reg);
+}
+
 static uint32_t kvm_arm_sve_get_vls(int fd)
 {
     uint64_t vls[KVM_ARM64_SVE_VLS_WORDS];
@@ -454,6 +493,10 @@ static void kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
             /* Read the set of supported vector lengths. */
             arm_host_cpu_features.sve_vq_supported = kvm_arm_sve_get_vls(fd);
         }
+        /* Grab demuxed registers. */
+        for (int i = 0; i < QEMU_CSSELR_MAX; i++) {
+            err |= get_host_cpu_reg_demux(fd, ahcf, CCSIDR_EL1_IDX, i);
+        }
     }
 
     kvm_arm_destroy_scratch_host_vcpu(fdarray);
-- 
2.43.0


