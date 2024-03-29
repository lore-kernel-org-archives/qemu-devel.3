Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5C59CD1288
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Mar 2024 10:07:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rq98A-00029V-Oa; Fri, 29 Mar 2024 06:06:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rq982-00028e-JA
 for qemu-devel@nongnu.org; Fri, 29 Mar 2024 06:06:32 -0400
Received: from mgamail.intel.com ([192.198.163.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rq97z-00017E-Qp
 for qemu-devel@nongnu.org; Fri, 29 Mar 2024 06:06:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1711706788; x=1743242788;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=EAlsIr9gV/OWidz8nIWqoCkuvpdnZz9VytfSWf5d/ic=;
 b=Dpotuzxdo6Vyu2HEjqBd3RpQCqHBZRSarfiC/GRaHdyHPBtPvAGT5/Jl
 ML7JRaWnQffkjOEjJBASMeUBMFd5bANeTSkN1j0QAndLZmtWcHU96toC1
 OtZV5y2Gic6wX/4pcXl4ODh3N790B74t2jNSZ+Mu75gXVxQspmaY2PNYE
 to6KiEuX1RdXaLmYoHUmobzGUQtG/mKjNgugrwZxvBdGls1wB7Q1br6BP
 2lNgJX3F8DCHwj0fHnEV0J4G1k0KL9uq23BjagzhFYBoxDqMJDZEtbo74
 6SHEnE/KOt4cmTSRD/LNlrdoGZTs7+Bpx+zX909LiroUBEgQ100hhPN6x Q==;
X-CSE-ConnectionGUID: 9put4kvVTDSLMrXDPPBjqw==
X-CSE-MsgGUID: y01UVaM6TgWc0uP3Y2p0Ew==
X-IronPort-AV: E=McAfee;i="6600,9927,11027"; a="17519246"
X-IronPort-AV: E=Sophos;i="6.07,164,1708416000"; d="scan'208";a="17519246"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Mar 2024 03:06:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,164,1708416000"; d="scan'208";a="21441989"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by fmviesa003.fm.intel.com with ESMTP; 29 Mar 2024 03:06:24 -0700
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Tim Wiederhake <twiederh@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH for-9.1 7/7] target/i386/kvm: Update comment in
 kvm_cpu_realizefn()
Date: Fri, 29 Mar 2024 18:19:54 +0800
Message-Id: <20240329101954.3954987-8-zhao1.liu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240329101954.3954987-1-zhao1.liu@linux.intel.com>
References: <20240329101954.3954987-1-zhao1.liu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=192.198.163.11;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.08,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

From: Zhao Liu <zhao1.liu@intel.com>

With the guest_phys_bits and legacy_kvmclock change, update the comment
about function call flow.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 target/i386/kvm/kvm-cpu.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/target/i386/kvm/kvm-cpu.c b/target/i386/kvm/kvm-cpu.c
index 753f90c18bd6..5b48b023c33b 100644
--- a/target/i386/kvm/kvm-cpu.c
+++ b/target/i386/kvm/kvm-cpu.c
@@ -60,7 +60,10 @@ static bool kvm_cpu_realizefn(CPUState *cs, Error **errp)
      *  -> x86_cpu_expand_features()
      *  -> cpu_exec_realizefn():
      *            -> accel_cpu_common_realize()
-     *               kvm_cpu_realizefn() -> host_cpu_realizefn()
+     *               kvm_cpu_realizefn()
+     *                       -> update cpu_pm, ucode_rev, kvmclock
+     *                          host_cpu_realizefn()
+     *                          update guest_phys_bits on Host support
      *  -> cpu_common_realizefn()
      *  -> check/update ucode_rev, phys_bits, mwait
      */
-- 
2.34.1


