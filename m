Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F7EECCD19A
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 07:47:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLGQV-0007B1-Co; Tue, 18 Nov 2025 02:46:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vLGQ3-00073C-59
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 02:46:31 -0500
Received: from mgamail.intel.com ([192.198.163.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vLGQ0-0000vb-AA
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 02:46:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763451988; x=1794987988;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=PUZISDYrocHYKBv1q7HljlOEOaD9HTduMbi5u14w+PY=;
 b=MjPzfaLiwdyr7f3RaKAu51W/AtVwgWgpzSNPtnamswxjjeXH96wzD6si
 d7+oArk95RtTH2YLj91pRB9akrJGdypOBnzG50tIu+JDuZsgw/aG2dH4S
 a1Ad0fOSK8b/FMfMtzRFaP/XNDRiTaeJYPqS9Xr0C1rrQSU/A+vrck+fM
 gM4FGYveLIvq3hnTkefUnuePk29RK2pvLR0/4xP82Q+nWz9ROuwEGP1AZ
 kboBluT6gRTYOJesO76qK5fxrTZ0vCxB2FGJIP7L5xxdV3jrZyPPrVJ9u
 yndnslFKcIVdLI89BHfzT4zPMGa3TLyDJTh/ywjRpqkUDiubYi28b7Qvr g==;
X-CSE-ConnectionGUID: T5vUDVreSauxDq8x+iyb7w==
X-CSE-MsgGUID: 10N7j3swS3CAg+Qan9J/Yg==
X-IronPort-AV: E=McAfee;i="6800,10657,11616"; a="76142120"
X-IronPort-AV: E=Sophos;i="6.19,314,1754982000"; d="scan'208";a="76142120"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Nov 2025 23:46:25 -0800
X-CSE-ConnectionGUID: fgZ+ykTXSrSyctPY+8oqvw==
X-CSE-MsgGUID: ImjKHWnHQl6OAp3mKvr0Vg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,314,1754982000"; d="scan'208";a="190479566"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by fmviesa006.fm.intel.com with ESMTP; 17 Nov 2025 23:46:24 -0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,
	Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 1/2] i386/cpu: Drop incorrect comment for CPUID 0x1D
Date: Tue, 18 Nov 2025 16:08:36 +0800
Message-Id: <20251118080837.837505-2-zhao1.liu@intel.com>
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

The information in CPUID 0x1D.0x1 is for tile palette 1, and is not
SPR-specific.

This is to say, these "hardcoded" values won't change in future. If
the palette needs to be extended, a new tile palette (maybe in a new
subleaf) will be introduced instead of changing current information of
tile palette 1.

Furthermore, the previous attempt [*] to make the 0x1D.0x1 fields
user-configurable is incorrect and unnecessary.

Therefore, drop the incorrect and misleading comment.

[*]: https://lore.kernel.org/qemu-devel/20230106083826.5384-2-lei4.wang@intel.com/

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 target/i386/cpu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index f703b1478d71..41d224330d05 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -8381,7 +8381,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
         *edx = 0; /* EDX is reserved. */
         break;
     case 0x1D: {
-        /* AMX TILE, for now hardcoded for Sapphire Rapids*/
+        /* AMX TILE */
         *eax = 0;
         *ebx = 0;
         *ecx = 0;
@@ -8394,6 +8394,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
             /* Highest numbered palette subleaf */
             *eax = INTEL_AMX_TILE_MAX_SUBLEAF;
         } else if (count == 1) {
+            /* Tile palette 1 */
             *eax = INTEL_AMX_TOTAL_TILE_BYTES |
                    (INTEL_AMX_BYTES_PER_TILE << 16);
             *ebx = INTEL_AMX_BYTES_PER_ROW | (INTEL_AMX_TILE_MAX_NAMES << 16);
-- 
2.34.1


