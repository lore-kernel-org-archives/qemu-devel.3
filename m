Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EB6DD3B9B7
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2024 16:13:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFyBO-0006rK-Qc; Tue, 26 Nov 2024 11:12:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tFyBD-0006mc-0g; Tue, 26 Nov 2024 11:12:47 -0500
Received: from mgamail.intel.com ([192.198.163.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tFyBB-0000g2-Fu; Tue, 26 Nov 2024 11:12:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1732637566; x=1764173566;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=0oaJEibH+FOP2hyVlMA0xFu8KZX3CJL3iZrEw7r/6/A=;
 b=mBrV4MOapO+fbS5PG5yobu47fv9v4nR0FGp3psqLec6fVLnp2XVonUDn
 zjzFsUW1soBTTnDYSPv0uYPTLR9lieKSfSAgoJNHJqMP2qr0YsLh9SIed
 +7oqPI8lhezWmuuUawYsNlKIIG5BPdNV8h6JtKnT7QPyS5XJesZCsGL1v
 XUFfo8kqQ6AFzrdxSZ3rWiXLilRPaNrA29aOv7e7CJngRdDq35NMR4S5g
 FIDjFJjljoPhVLEF8ASC3ImXUJ9YqstoQAwwn9cHMPUS0rGz2DUd+Jj6U
 Nw9rSrZ7zTsxDfWNeG4kq8D4lUN2l53aJYP7RF65XVcMU4/TFUhYb8SeS g==;
X-CSE-ConnectionGUID: eSJ/AjKQTaec6aGlO6FuiQ==
X-CSE-MsgGUID: woKecO4dSVe8fMrQMXvMDw==
X-IronPort-AV: E=McAfee;i="6700,10204,11268"; a="20399395"
X-IronPort-AV: E=Sophos;i="6.12,186,1728975600"; d="scan'208";a="20399395"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Nov 2024 08:12:44 -0800
X-CSE-ConnectionGUID: 0dwSVV9BTJua9o0puNA80Q==
X-CSE-MsgGUID: Q2eu35jvQRyaxEmQR9L0aA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,186,1728975600"; d="scan'208";a="91277672"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by fmviesa006.fm.intel.com with ESMTP; 26 Nov 2024 08:12:43 -0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 2/2] hw/timer/hpet: Drop the unused macro
Date: Wed, 27 Nov 2024 00:30:46 +0800
Message-Id: <20241126163046.3344931-3-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241126163046.3344931-1-zhao1.liu@intel.com>
References: <20241126163046.3344931-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.16; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

HPET_TN_CFG_BITS_READONLY_OR_RESERVED is not used in any place since
HPET_TN_CFG_WRITE_MASK has been already used to check and fix the
writable bits in hpet_ram_write().

Drop this unused macro.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 include/hw/timer/hpet.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/hw/timer/hpet.h b/include/hw/timer/hpet.h
index d17a8d43199e..71e8c62453d1 100644
--- a/include/hw/timer/hpet.h
+++ b/include/hw/timer/hpet.h
@@ -58,7 +58,6 @@
 #define HPET_TN_CFG_WRITE_MASK  0x7f4e
 #define HPET_TN_INT_ROUTE_SHIFT      9
 #define HPET_TN_INT_ROUTE_CAP_SHIFT 32
-#define HPET_TN_CFG_BITS_READONLY_OR_RESERVED 0xffff80b1U
 
 struct hpet_fw_entry
 {
-- 
2.34.1


