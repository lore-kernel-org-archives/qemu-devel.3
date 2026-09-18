Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13C35C982E1
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 12:04:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7XJw-0000M5-OJ; Fri, 18 Sep 2026 08:04:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wangyize7@huawei.com>)
 id 1x7UqI-0006qX-SC; Fri, 18 Sep 2026 05:25:14 -0400
Received: from canpmsgout03.his.huawei.com ([113.46.200.218])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wangyize7@huawei.com>)
 id 1x7UqE-0002I8-JA; Fri, 18 Sep 2026 05:25:14 -0400
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=qzZOCur4BGqUx5xfENpBZYTSs+U/Bs6R7I9nIxljxEU=;
 b=W58LaI3+G7xlTJOxfyISX2GCMCnQxIzZ9DNwfo9F3rUSelobFsfEHB0G+N/4fFJ2P9YJgXPHm
 PuL8QijMGF34206ePa1OchhXjjTwLyUvGsKBGPzsXn15squDDT6IwE/W6KuFJ0JhjJVy5qlHs3Y
 tUgNunHPPUlKKxTlHoW5QFE=
Received: from mail.maildlp.com (unknown [172.19.162.140])
 by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4hmRjw0Y6NzpSyG;
 Fri, 18 Sep 2026 17:13:08 +0800 (CST)
Received: from dggpemr200003.china.huawei.com (unknown [7.185.36.25])
 by mail.maildlp.com (Postfix) with ESMTPS id 3087620333;
 Fri, 18 Sep 2026 17:24:57 +0800 (CST)
Received: from huawei.com (10.50.159.234) by dggpemr200003.china.huawei.com
 (7.185.36.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 18 Sep
 2026 17:24:56 +0800
From: Yize Wang <wangyize7@huawei.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <mst@redhat.com>, <cohuck@redhat.com>, <pbonzini@redhat.com>,
 <peter.maydell@linaro.org>, <zhengchuan@huawei.com>,
 <jiangjiacheng@huawei.com>, <wangyize7@huawei.com>, <yize_w1110@163.com>
Subject: [PATCH 1/4] Sync KVM ARM VGIC batch register UAPI to QEMU headers
Date: Fri, 18 Sep 2026 17:18:53 +0800
Message-ID: <20260918092120.370805-2-wangyize7@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260918092120.370805-1-wangyize7@huawei.com>
References: <20260918092120.370805-1-wangyize7@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.50.159.234]
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 dggpemr200003.china.huawei.com (7.185.36.25)
Received-SPF: pass client-ip=113.46.200.218; envelope-from=wangyize7@huawei.com;
 helo=canpmsgout03.his.huawei.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 18 Sep 2026 08:02:22 -0400
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

Add KVM_DEV_ARM_VGIC_GRP_BATCH_REGS,  KVM_DEV_ARM_VGIC_BATCH_MAX, and
kvm_dev_arm_vgic_batch_entry struct to arm64 QEMU vendored kernel headers.

Signed-off-by: Chuan Zheng <zhengchuan@huawei.com>
Signed-off-by: Yize Wang <wangyize7@huawei.com>
---
 linux-headers/asm-arm64/kvm.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/linux-headers/asm-arm64/kvm.h b/linux-headers/asm-arm64/kvm.h
index 6aefe79738..26ba4fb9cb 100644
--- a/linux-headers/asm-arm64/kvm.h
+++ b/linux-headers/asm-arm64/kvm.h
@@ -405,11 +405,20 @@ enum {
 #define KVM_DEV_ARM_VGIC_GRP_LEVEL_INFO  7
 #define KVM_DEV_ARM_VGIC_GRP_ITS_REGS 8
 #define KVM_DEV_ARM_VGIC_GRP_MAINT_IRQ  9
+#define KVM_DEV_ARM_VGIC_GRP_BATCH_REGS 10
 #define KVM_DEV_ARM_VGIC_LINE_LEVEL_INFO_SHIFT	10
 #define KVM_DEV_ARM_VGIC_LINE_LEVEL_INFO_MASK \
 			(0x3fffffULL << KVM_DEV_ARM_VGIC_LINE_LEVEL_INFO_SHIFT)
 #define KVM_DEV_ARM_VGIC_LINE_LEVEL_INTID_MASK	0x3ff
 #define VGIC_LEVEL_INFO_LINE_LEVEL	0
+#define KVM_DEV_ARM_VGIC_BATCH_MAX	4096
+
+struct kvm_dev_arm_vgic_batch_entry {
+	__u32 group;
+	__u64 attr;
+	__u32 val;
+	__s32 error;
+};
 
 #define   KVM_DEV_ARM_VGIC_CTRL_INIT		0
 #define   KVM_DEV_ARM_ITS_SAVE_TABLES           1
-- 
2.43.0


