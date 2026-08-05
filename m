Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB15DC55ABA
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2026 11:06:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrZQQ-0000lT-Jl; Wed, 05 Aug 2026 07:04:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <snambakam@linux.microsoft.com>)
 id 1wrZQO-0000jm-LW
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 07:04:40 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <snambakam@linux.microsoft.com>) id 1wrZQL-0000CI-Vu
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 07:04:40 -0400
Received: from fedora.hsd1.wa.comcast.net (unknown [52.148.140.42])
 by linux.microsoft.com (Postfix) with ESMTPSA id 1A2E620B716C;
 Wed,  5 Aug 2026 04:04:16 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1A2E620B716C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1785927856;
 bh=LWWPECdd7trZNFf94dG6xpNIuU8Yn0i5MN5bN/aqB+A=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=YqpS+TH0f7HQDBtfEPknq2m0RL4xbBCPp3NfCUWeskp1Uk9flxxrsRfE4rHK1WtdV
 qOFYQIyjytZLj+H0g6pCFdjrt+xF7kF0+omOptH5UTIvLAeTAN3xTX46YrjgnWBSIl
 ZjOhk3+bKxiLnqAK9tVX5PhSIYcSYepe8i7G65uw=
From: Sriram Nambakam <snambakam@linux.microsoft.com>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org
Subject: [RFC PATCH v1 3/5] linux-headers: sync kvm_para.h VBS VTL hypercalls
Date: Wed,  5 Aug 2026 04:04:30 -0700
Message-ID: <20260805110432.25167-4-snambakam@linux.microsoft.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260805110432.25167-1-snambakam@linux.microsoft.com>
References: <20260805110432.25167-1-snambakam@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=snambakam@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_PASS=-0.001,
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

Import the two new VBS secure-plane hypercall numbers from the kernel
UAPI: KVM_HC_VBS_VTL_RETURN (16) and KVM_HC_VBS_SET_MEM_ATTRS (17).

Signed-off-by: Sriram Nambakam <snambakam@linux.microsoft.com>
(cherry picked from commit 92f71c68c2eb42588694ac23fb4a6a8ef8dfa12b)
---
 include/standard-headers/linux/kvm_para.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/standard-headers/linux/kvm_para.h b/include/standard-headers/linux/kvm_para.h
index ad19aac9d0..def451c43c 100644
--- a/include/standard-headers/linux/kvm_para.h
+++ b/include/standard-headers/linux/kvm_para.h
@@ -33,6 +33,8 @@
 #define KVM_HC_VM_PLANES_CONFIG		13
 #define KVM_HC_VM_PLANES_ACTIVATE	14
 #define KVM_HC_VBS_VTL_CALL		15
+#define KVM_HC_VBS_VTL_RETURN		16
+#define KVM_HC_VBS_SET_MEM_ATTRS	17
 
 /*
  * hypercalls use architecture specific
-- 
2.55.0


