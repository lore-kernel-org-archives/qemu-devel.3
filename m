Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36DCDCA5FDD
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 20:21:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCjkW-0007M7-Kk; Fri, 02 Oct 2026 16:20:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1xCjkB-00078H-4e
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 16:20:35 -0400
Received: from mail-pz2-x29.google.com ([2607:f8b0:4864:3b::29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1xCjk9-0005je-EG
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 16:20:34 -0400
Received: by mail-pz2-x29.google.com with SMTP id
 41be03b00d2f7-cc7d27b7410so2338294a12.1
 for <qemu-devel@nongnu.org>; Fri, 02 Oct 2026 13:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790972430; x=1791577230; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=iODePatmvGNDBqYJx04Bbg2cZsIs56+xqllvlfLUyUI=;
 b=LgRjcC+nPL/Ck4yZS4uU8jnbGxRfbY03KDPtynE7DjI+n0QvjfA3sHHXxHsnXqrVpl
 OYSEsQYMlhkGwTQ4Q51Ap0VvkpscSWi7rup/Q8T53ctB/daM39MR8kAqBCQiCritGsQT
 HHVAIJn5ca6KgCd5qDbuG07b59X+UNJdga6pcuih6NyzljWioIPiVCzu9ccf/KYRy1kF
 AI3njr5j+y/r//jSNmM43s+PvvXJLrnryX7AxdQkpIIzzcLN/hqoMQ3IM2kCzRzlL3/l
 wuzJSPXUHngiNYZIqzLd+G820SDpQFUTDyS8qOpNSTVPZarLNhQRsmzToJ4T0ioocdto
 QzOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790972430; x=1791577230;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=iODePatmvGNDBqYJx04Bbg2cZsIs56+xqllvlfLUyUI=;
 b=ko3fCCl7AJExyFj3kKYgAfGFGzdFwmO1MNulC1snmT68Fk6F6AjOCxXwu6pQHNqYDH
 +mjuLG9CM9qsOAnYL7Jvf6mGKij+Z4MoCs2mnKO2zpuF5BThvIM06k8TDuhhn4LlwcYk
 9+8NGM07SzfzLNb/4pPW+Cy8mTdt1yQSfMfxYjRagui0xGevBVIuKnYGWHsS4afRRVqH
 dmMavElFw/3+h7Ufbp19xEOcsx9lh0hG69Q2YU3Pws5UW2YK3UBRAQXSIvfUZMH/1C2a
 Usp09t0AULrLVVr+Hq3UzETCmdU2cn2eUJ8gw9I+vfvsErN1E+4myJBGJ/xveOm/lG3e
 CqEw==
X-Gm-Message-State: AFq9FYIA2HBz3qEpujfD+zPQcZXqKWbyP6NWtsPZ4gateLda99peCqDP
 mAekRv95ySJf/o9UrNNVdCU0/npiDGzkx5i+wRS5H93+Z2mWwXb92oOFaCRvWRwX1bw=
X-Gm-Gg: AYBFou3wWmi4MyrNiXEtuPkV/NOI1+LMkwtC7tK1U9mIOOWo84cHbyEL2ayTJbLCine
 PTJ+6neafI1K7nJinW+cHpyhge+obPBcZoCoiTOSohIssS7qDHr+XYIXKPwq7+v6He19TdB9gnc
 FUm9YfCcYYqmYK4BYmOk6YKpvu4lZlg73lkayxgWUGOMLY/Gz9UatcYomqpUe00CRWgX3zpePNU
 MJVGXVrbOAsuKIu1qwVaBMYa/oxjAuf4QBcZbwR3+Xc8ytKcJ+2hlj4T9jgxKr/vPLVyBRpBcmA
 E7imFX/7NbuCXLSdwg7kUZ9EBw+TjwQ8+Fzo0YGUuq30v/zAKbv6oe1Ts8LWM7bfE5eCnE1ZZJe
 QFAj8zTyBcU92JhKZLZJNpi8pWAo3kAPmg5RFXvuI3Q2YF1ZaIc6JIiHC15KJZ/2CQe53EwOt/b
 gsn1VeVYYIXYxWdYPcIWA5MmHPhKXvu8y2X7VpDKh5paj7SUxp/ApkVEQeIliDZ5XKI87/pyZyW
 1QOkIzsFvUKxqslEsMFbhnQAA==
X-Received: by 2002:a17:90b:3b41:b0:3a7:a34:6f94 with SMTP id
 98e67ed59e1d1-3a70a3476c5mr1235372a91.65.1790972430400; 
 Fri, 02 Oct 2026 13:20:30 -0700 (PDT)
Received: from p14s.cg.shawcable.net
 ([2604:3d09:148c:c800:61ac:e744:6559:a357])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e49f6a99acsm12399415ad.34.2026.10.02.13.20.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 13:20:29 -0700 (PDT)
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: berrange@redhat.com, kchamart@redhat.com,
 pierrick.bouvier@oss.qualcomm.com, peter.maydell@linaro.org,
 mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com, eblake@redhat.com,
 armbru@redhat.com, enju.kohei@fujitsu.com, lorenzo.pieralisi@linaro.org,
 gshan@redhat.com
Cc: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	kvm@vger.kernel.org
Subject: [RFC v5 01/22] linux-headers: Add RME related definitions
Date: Fri,  2 Oct 2026 14:20:05 -0600
Message-ID: <20261002202026.1204110-2-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261002202026.1204110-1-mathieu.poirier@linaro.org>
References: <20261002202026.1204110-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::29;
 envelope-from=mathieu.poirier@linaro.org; helo=mail-pz2-x29.google.com
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

From: Jean-Philippe Brucker <jean-philippe@linaro.org>

This is a temporary patch intended for testing purposes only. It provides
definitions related to supporting Realms by the QEMU-VMM.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 linux-headers/linux/kvm.h | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/linux-headers/linux/kvm.h b/linux-headers/linux/kvm.h
index 7850bd464222..686c199e2558 100644
--- a/linux-headers/linux/kvm.h
+++ b/linux-headers/linux/kvm.h
@@ -689,14 +689,19 @@ struct kvm_enable_cap {
  * address size for the VM. Bits[7-0] are reserved for the guest
  * PA size shift (i.e, log2(PA_Size)). For backward compatibility,
  * value 0 implies the default IPA size, 40bits.
+ *
+ * Bits[30-31] are reserved for the VM type
  */
 #define KVM_VM_TYPE_ARM_IPA_SIZE_MASK	0xffULL
 #define KVM_VM_TYPE_ARM_IPA_SIZE(x)		\
 	((x) & KVM_VM_TYPE_ARM_IPA_SIZE_MASK)
 
+#define KVM_VM_TYPE_ARM_NORMAL		0
+#define KVM_VM_TYPE_ARM_REALM		(1UL << 30)
 #define KVM_VM_TYPE_ARM_PROTECTED	(1UL << 31)
 #define KVM_VM_TYPE_ARM_MASK		(KVM_VM_TYPE_ARM_IPA_SIZE_MASK | \
-					 KVM_VM_TYPE_ARM_PROTECTED)
+					 KVM_VM_TYPE_ARM_PROTECTED | \
+					 KVM_VM_TYPE_ARM_REALM)
 
 /*
  * ioctls for /dev/kvm fds:
@@ -988,6 +993,7 @@ struct kvm_enable_cap {
 #define KVM_CAP_S390_HPAGE_2G 249
 #define KVM_CAP_PPC_COMPAT_CAPS 250
 #define KVM_CAP_GUEST_MEMFD_MEMORY_ATTRIBUTES 252
+#define KVM_CAP_ARM_RMI 253
 
 struct kvm_irq_routing_irqchip {
 	__u32 irqchip;
@@ -1674,4 +1680,14 @@ struct kvm_pre_fault_memory {
 	__u64 padding[5];
 };
 
+#define KVM_ARM_RMI_POPULATE	  _IOWR(KVMIO, 0xd7, struct kvm_arm_rmi_populate)
+#define KVM_ARM_RMI_POPULATE_FLAGS_MEASURE     (1 << 0)
+struct kvm_arm_rmi_populate {
+	__u64 base;
+	__u64 size;
+	__u64 source_uaddr;
+	__u32 flags;
+	__u32 reserved;
+};
+
 #endif /* __LINUX_KVM_H */
-- 
2.43.0


