Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66285CCD19A
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 07:47:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLGQH-00076D-9T; Tue, 18 Nov 2025 02:46:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vLGQ4-00073o-OF
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 02:46:34 -0500
Received: from mgamail.intel.com ([192.198.163.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vLGQ3-0000vO-7g
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 02:46:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763451991; x=1794987991;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=u3yCc6xj7EMhaBRQaQuxB3xeSTwO9P6ETK7zC/lQAyw=;
 b=ctJXxJbxReBjf27H3HWuPaOVlYY82nZFBc0zR00n/J/X33ngZBKEP8Rj
 nNmb/6qoCK8Z6NVlJ/21220DS6L7QPyOdd2nBx6ipVlJCYKtxKIMr8LDp
 4do0aNDABxDELyxqodp+VqnGPiz7AHpZZy2N2/V0A6oYn5cZ1fG9nvAm3
 vm+jAxjr6CGq9lJyRSm8hy5RcGX5DgYevl/M7L1Mu3nhL5y+byIuCU0Hd
 eyt/ttCvAKbL1JOTYZ+9Oi607S4ZfhkgpgmuyICu2k5VaIUkW7syAs7wN
 t19eP9gIrmSkVWbruIZLSXHiCgY0p3y7nJiPAzA9J0uK//OfmuXYQIADI w==;
X-CSE-ConnectionGUID: Hq0vLFJBSK+/xExo8bldMA==
X-CSE-MsgGUID: z0tjtRhrQE2eGNlk44ddNA==
X-IronPort-AV: E=McAfee;i="6800,10657,11616"; a="76142123"
X-IronPort-AV: E=Sophos;i="6.19,314,1754982000"; d="scan'208";a="76142123"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Nov 2025 23:46:26 -0800
X-CSE-ConnectionGUID: KjA14gVORniUXiu+I/5c8g==
X-CSE-MsgGUID: 0hShYtBxRNKn+Ofj4z6LdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,314,1754982000"; d="scan'208";a="190479569"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by fmviesa006.fm.intel.com with ESMTP; 17 Nov 2025 23:46:25 -0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,
	Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 2/2] i386/cpu: Drop incorrect comment for CPUID 0x1E
Date: Tue, 18 Nov 2025 16:08:37 +0800
Message-Id: <20251118080837.837505-3-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251118080837.837505-1-zhao1.liu@intel.com>
References: <20251118080837.837505-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.9; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

The information (tmul_maxk and tmul_maxn) in CPUID 0x1E.0x0.EBX is
defined for architecture, not for SPR.

This is to say, these "hardcoded" values won't change in future. If
the TMUL component needs to be extended for new palettes, there'll
likely be the new TMUL instructions, or new types of AMX instructions
that are _parallel_ to TMUL that operate in particular palettes,
instead of changing current tmul_maxk and tmul_maxn fields in CPUID
0x1E.0x0.EBX.

Furthermore, the previous attempt [*] to make the 0x1E.0x0.EBX fields
user-configurable is incorrect and unnecessary.

Therefore, drop the incorrect and misleading comment.

[*]: https://lore.kernel.org/qemu-devel/20230106083826.5384-2-lei4.wang@intel.com/

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 target/i386/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 41d224330d05..0c954202cea8 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -8403,7 +8403,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
         break;
     }
     case 0x1E: {
-        /* AMX TMUL, for now hardcoded for Sapphire Rapids */
+        /* AMX TMUL */
         *eax = 0;
         *ebx = 0;
         *ecx = 0;
-- 
2.34.1


