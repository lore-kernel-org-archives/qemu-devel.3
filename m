Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB703D17159
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 02:20:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t34Vg-0001YN-96; Mon, 21 Oct 2024 22:20:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t34Vd-0001Xo-C8
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 22:20:33 -0400
Received: from mgamail.intel.com ([198.175.65.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t34Va-0002E8-CI
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 22:20:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1729563630; x=1761099630;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=/z4bkz5DSU3PN+XsM48s2xIL9AwW0D1ypYVs8Z1CYiw=;
 b=UfZclYU53hWo6T/fVsH6GIcUuu24W5YhQdOiJurTM9TeZ9GgRu3vytp3
 8wzUYBsDmJSRF5BRdvKtsfoq1sJBR/98vqyDhqkOyOtGr+ZdypTImT8Go
 dGNtfVQyl/m8wUelIczw9EEh5HBvkuLSTs0idkwtCG/D1WHiScD/bC5cE
 Eu8taQdRjLXby/Tyybz7rinXyLOOdL6+2hi2ulK9rALyxdaECRXKgBgCT
 V6N8fC5YDPh2l5CnMrVFqN4hOWt7peotxVogUScqJMjGw/BQQsPPC9qde
 kx9wln/R4lME9yJPAoCdPvUxcTAkTRY8UrU36sReWjtcarcuo9ULCpY8B A==;
X-CSE-ConnectionGUID: QmyN1liARE2INEA06wymOw==
X-CSE-MsgGUID: F3P0wEeGSSeVfjJEKLkGfA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="28953473"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; d="scan'208";a="28953473"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Oct 2024 19:20:27 -0700
X-CSE-ConnectionGUID: ichHOL/LREWbhk+hYq/XOw==
X-CSE-MsgGUID: FERbFIwURrCAKb7E029hmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,222,1725346800"; d="scan'208";a="79707229"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by fmviesa009.fm.intel.com with ESMTP; 21 Oct 2024 19:20:26 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,
	Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH] MAINTAINERS: Add myself as a reviewer of x86 general
 architecture support
Date: Tue, 22 Oct 2024 10:36:28 +0800
Message-Id: <20241022023628.1743686-1-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.19; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -64
X-Spam_score: -6.5
X-Spam_bar: ------
X-Spam_report: (-6.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.421,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=-1.699,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

X86 architecture has always been a focus of my work. I would like to
help to review more related patches.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index c21d6a2f9e1e..d103c1149cbb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -132,6 +132,7 @@ F: configs/targets/mips*
 
 X86 general architecture support
 M: Paolo Bonzini <pbonzini@redhat.com>
+R: Zhao Liu <zhao1.liu@intel.com>
 S: Maintained
 F: configs/devices/i386-softmmu/default.mak
 F: configs/targets/i386-softmmu.mak
-- 
2.34.1


