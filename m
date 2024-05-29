Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37FAFC25B7C
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 06:05:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCCQ1-0005V8-4u; Wed, 29 May 2024 02:04:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sCCPy-0005Tw-U8
 for qemu-devel@nongnu.org; Wed, 29 May 2024 02:04:10 -0400
Received: from mgamail.intel.com ([198.175.65.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sCCPw-0002st-Pg
 for qemu-devel@nongnu.org; Wed, 29 May 2024 02:04:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1716962649; x=1748498649;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=GiBateYmHe2PHoW3E69/7MW/e509Zc752zxffOJzEvc=;
 b=BQ7gKYD4yucnQhcwvh2n/24K1VbKIlhVc7nbkgAqg6BPKaVJMp5BacF3
 PkYBpwNpyEWg9rhNdHjNoOtHIAmKcsFOgLqJ11Zr/+tHKdnOmWtFpc3Yp
 pI3BBygi6r8tJHx49Ay1CT5mJ7hzcwofmCjzfaVYGkxOCjxUM5s0CsC44
 h9FV8LQ049/wopFCYPxMwZkEOaMSi3GsdXb1csrXdNYu0qMp665RNGvDU
 TTeHnMiPCJa02i5hxA5wfiK/EdQygCN+8EhF6QzjZ8swPe1UIpamMP7pQ
 80t2WCM+46dTtYzIfUKNOypskyxKluxLfbHu/2Tbs5WeA881AN8tEl7h8 Q==;
X-CSE-ConnectionGUID: hVfs476eR6CnJGGNHMCIcw==
X-CSE-MsgGUID: 83tARlJHSKue++ZSquDwzw==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="13187456"
X-IronPort-AV: E=Sophos;i="6.08,197,1712646000"; d="scan'208";a="13187456"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 May 2024 23:04:06 -0700
X-CSE-ConnectionGUID: oFIvIjXJS36OmUnxJch0Aw==
X-CSE-MsgGUID: pNLxWI3yTcGbC8DglWkPiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,197,1712646000"; d="scan'208";a="40144659"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by orviesa003.jf.intel.com with ESMTP; 28 May 2024 23:04:04 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Thomas Huth <thuth@redhat.com>,
 qemu-devel@nongnu.org
Cc: Yongwei Ma <yongwei.ma@intel.com>,
	Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 0/8] tests/unit/test-smp-sparse: Misc Cleanup and Add Module
 Test
Date: Wed, 29 May 2024 14:19:17 +0800
Message-Id: <20240529061925.350323-1-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.20; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.034,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hi,

Since the module support has landed in x86, and it's time to add the
module's -smp test cases to cover the relevant code path.

This series adds the module tests to ensure that this new level does
not break the current topology information calculations. It also
includes some misc cleanup.

Thanks and Best Regadrs,
Zhao
---
Zhao Liu (8):
  tests/unit/test-smp-parse: Fix comments of drawers and books case
  tests/unit/test-smp-parse: Fix comment of parameters=1 case
  tests/unit/test-smp-parse: Fix an invalid topology case
  tests/unit/test-smp-parse: Use default parameters=0 when not set in
    -smp
  tests/unit/test-smp-parse: Make test cases aware of module level
  tests/unit/test-smp-parse: Test "modules" parameter in -smp
  tests/unit/test-smp-parse: Test "modules" and "dies" combination case
  tests/unit/test-smp-parse: Test the full 8-levels topology hierarchy

 tests/unit/test-smp-parse.c | 373 ++++++++++++++++++++++++++++++------
 1 file changed, 311 insertions(+), 62 deletions(-)

-- 
2.34.1


