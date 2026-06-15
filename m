Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 955A8CD98C7
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 12:04:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZ63U-000577-Hw; Mon, 15 Jun 2026 08:04:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cui.tao@linux.dev>) id 1wZ33l-0006lz-CH
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 04:52:45 -0400
Received: from out-188.mta0.migadu.com ([91.218.175.188])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cui.tao@linux.dev>) id 1wZ33j-0005Qi-Hx
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 04:52:45 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1781513561;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gKsRpz1I0PRfQSc7rC4V93zNNuRaBw7cvpNExO+4siI=;
 b=ixcp704aMcx7Gllce9NGNoWaYWZVZBbHSTD55HPWckaZQMPcpE/L6vFuuPsWGtm6ViARjs
 oGLabsQXWj57Nzcf7Bxd8f+zM/VdrlT8kcIyKK5TnEKe/Zx8TrED5UmDnNVapN4IgRPUps
 tpcxetXmCpxrWNnr1vkkNF9BIHcF4iU=
From: Tao Cui <cui.tao@linux.dev>
To: qemu-devel@nongnu.org
Cc: Song Gao <gaosong@loongson.cn>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 kvm@vger.kernel.org, Tao Cui <cuitao@kylinos.cn>
Subject: [PATCH 1/2] linux-headers: Add LoongArch PV TLB flush definitions
Date: Mon, 15 Jun 2026 16:52:13 +0800
Message-ID: <20260615085214.44526-2-cui.tao@linux.dev>
In-Reply-To: <20260615085214.44526-1-cui.tao@linux.dev>
References: <20260615085214.44526-1-cui.tao@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
Received-SPF: pass client-ip=91.218.175.188; envelope-from=cui.tao@linux.dev;
 helo=out-188.mta0.migadu.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 15 Jun 2026 08:04:28 -0400
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

From: Tao Cui <cuitao@kylinos.cn>

Sync the LoongArch PV TLB flush definitions from the kernel:
KVM_LOONGARCH_VM_FEAT_PV_TLB_FLUSH VM feature and KVM_FEATURE_PV_TLB_FLUSH
guest feature.

Signed-off-by: Tao Cui <cuitao@kylinos.cn>
---
 linux-headers/asm-loongarch/kvm.h      | 1 +
 linux-headers/asm-loongarch/kvm_para.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/linux-headers/asm-loongarch/kvm.h b/linux-headers/asm-loongarch/kvm.h
index cd0b5c11ca..e4cd4bbf89 100644
--- a/linux-headers/asm-loongarch/kvm.h
+++ b/linux-headers/asm-loongarch/kvm.h
@@ -106,6 +106,7 @@ struct kvm_fpu {
 #define  KVM_LOONGARCH_VM_FEAT_PTW		8
 #define  KVM_LOONGARCH_VM_FEAT_MSGINT		9
 #define  KVM_LOONGARCH_VM_FEAT_PV_PREEMPT	10
+#define  KVM_LOONGARCH_VM_FEAT_PV_TLB_FLUSH	11
 
 /* Device Control API on vcpu fd */
 #define KVM_LOONGARCH_VCPU_CPUCFG	0
diff --git a/linux-headers/asm-loongarch/kvm_para.h b/linux-headers/asm-loongarch/kvm_para.h
index 3fd87a096b..98494784ed 100644
--- a/linux-headers/asm-loongarch/kvm_para.h
+++ b/linux-headers/asm-loongarch/kvm_para.h
@@ -16,6 +16,7 @@
 #define  KVM_FEATURE_IPI		1
 #define  KVM_FEATURE_STEAL_TIME		2
 #define  KVM_FEATURE_PREEMPT		3
+#define  KVM_FEATURE_PV_TLB_FLUSH	4
 /* BIT 24 - 31 are features configurable by user space vmm */
 #define  KVM_FEATURE_VIRT_EXTIOI	24
 #define  KVM_FEATURE_USER_HCALL		25
-- 
2.43.0


