Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66371C4345F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 08:38:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3trf-0003Ak-EE; Mon, 06 May 2024 04:38:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1s3trK-0002tc-Dy
 for qemu-devel@nongnu.org; Mon, 06 May 2024 04:38:09 -0400
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1s3trI-0000h1-R1
 for qemu-devel@nongnu.org; Mon, 06 May 2024 04:38:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1714984685; x=1746520685;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=R4trk+H0mPF/t62AN97t8+Kv8Yiy7IDTzo4yU4vF/s4=;
 b=T3BoHEQos5Nw6TRAUFNTUmsdLPpU9ze4+RGIjO6+AiQt0EA+StjFmkwA
 6EZLB+VQmHp3Emluk46rKFfJvudIJ0hdEre1J7rrAU+Ywb0meJjjCpCsF
 UGU4qk+Z08sjD3uC5eSTO0PUurP5kk9dW9H1UZvZR3hC6HU2upFoFkUme
 UnhSLVj0JiXSScOH6QTHc75BVbCutpSoZe4o4Z81prpBkQxy4idWFZN3H
 kQLppDyBEf/g/8fK0/F5zZAMtiWY7YOsjTc+sgrLXpkJxXSMNSw+G/TOU
 HaXrz/PSBBFC/h5BLqoC8l41U1lw2IPwbzS/PxdP+mm7/Y90Ty9pa3nBz A==;
X-CSE-ConnectionGUID: XR/IcldeQEK0SSaxrRuOiQ==
X-CSE-MsgGUID: aUrQxcajToS2ne0ucrBkHQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11064"; a="14533377"
X-IronPort-AV: E=Sophos;i="6.07,257,1708416000"; d="scan'208";a="14533377"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 May 2024 01:38:04 -0700
X-CSE-ConnectionGUID: psUkXkENSL2KfBdKRk4RKg==
X-CSE-MsgGUID: 3HDy4qf6SWOs6ysskfFemw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,257,1708416000"; d="scan'208";a="28186755"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by fmviesa010.fm.intel.com with ESMTP; 06 May 2024 01:38:01 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Marcelo Tosatti <mtosatti@redhat.com>
Cc: Xiaoyao Li <xiaoyao.li@intel.com>, Pankaj Gupta <pankaj.gupta@amd.com>,
 Zide Chen <zide.chen@intel.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v2 6/6] target/i386/confidential-guest: Fix comment of
 x86_confidential_guest_kvm_type()
Date: Mon,  6 May 2024 16:51:53 +0800
Message-Id: <20240506085153.2834841-7-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240506085153.2834841-1-zhao1.liu@intel.com>
References: <20240506085153.2834841-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.14; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.431,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Update the comment to match the X86ConfidentialGuestClass
implementation.

Reported-by: Xiaoyao Li <xiaoyao.li@intel.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Pankaj Gupta <pankaj.gupta@amd.com>
---
 target/i386/confidential-guest.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/confidential-guest.h b/target/i386/confidential-guest.h
index 532e172a60b6..06d54a120227 100644
--- a/target/i386/confidential-guest.h
+++ b/target/i386/confidential-guest.h
@@ -44,7 +44,7 @@ struct X86ConfidentialGuestClass {
 /**
  * x86_confidential_guest_kvm_type:
  *
- * Calls #X86ConfidentialGuestClass.unplug callback of @plug_handler.
+ * Calls #X86ConfidentialGuestClass.kvm_type() callback.
  */
 static inline int x86_confidential_guest_kvm_type(X86ConfidentialGuest *cg)
 {
-- 
2.34.1


