Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73B20C3DA6D
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 15:12:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHOYW-0007oZ-AF; Tue, 20 May 2025 11:07:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uHOYM-0007bc-RJ; Tue, 20 May 2025 11:06:53 -0400
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uHOYK-0002xW-LP; Tue, 20 May 2025 11:06:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1747753609; x=1779289609;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=dQWJMRmIG8X88QoQzcqQefijJ/Xlp+Z5ZVgqvYLck4Y=;
 b=iI6AG2SyIh/dbeT9Ua3ySJqXYjmG0E5NnI7WPgRNqgCoTe4K9hlSjXzJ
 PnvUs6PWzaYCwJnnVy3yxAaG4OQq/j2wLIKuc6+F+xF8UPIVmQKrDn+A9
 PxVPUwQaeeaJITJTdW7fozEl9XtvBA6g1Dh+ZscdheWdyuBIip9GEE98g
 jGj6JHtO5BWCx12p++NmLw6dyJO66Nhki7t9d9ejENlLGvEyIuYtwIE60
 YTPh+CNU4BhruDR214b0alRsqJ7QJ8Zx83dv7x/PxzUYTh/A1sb5DUDvF
 hCTkpRFyF5814tkiTt8g5kh6FC8N6dTPUo9CQzxqX23Ws/yjUILf+o6LC g==;
X-CSE-ConnectionGUID: v3YgelzpQmKSA2F4qg4tbw==
X-CSE-MsgGUID: xLDRcngXQ7S9xdSMGJuITQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11439"; a="59922458"
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; d="scan'208";a="59922458"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 May 2025 08:06:45 -0700
X-CSE-ConnectionGUID: 9s3rAY29STKCYTduMviHJQ==
X-CSE-MsgGUID: jZxxUdnHQxOSU4nSJr8FNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; d="scan'208";a="144461836"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa003.jf.intel.com with ESMTP; 20 May 2025 08:06:43 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org,
 Dapeng Mi <dapeng1.mi@intel.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 0/5] hpet, rust: miscellaneous cleanup
Date: Tue, 20 May 2025 23:27:45 +0800
Message-Id: <20250520152750.2542612-1-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.11; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.487,
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

Hi,

This series is very miscellaneous:

It contains both the follow-up cleanup for HPET and a collection of tiny
patches that were previously missed.

Of this, I think Patch 3's commit message needs to be given a bit of
attention, where I attached my understanding (based on [*]) in detail,
in the hope that it can be confirmed or corrected. :-)

[*]: https://lore.kernel.org/qemu-devel/aCb2bvoJQ2NxCkqz@intel.com/

Thanks and Best Regards,
Zhao
--
Zhao Liu (5):
  hw/timer/hpet: Reorganize register decoding
  hw/timer/hpet: Adjust num_timers in hpet_init()
  rust/hpet: Drop BalCell wrapper for num_timers
  rust: Fix Zhao's email address
  rust: Fix the typos in doc

 hw/timer/hpet.c                      | 177 ++++++++++++++-------------
 rust/hw/char/pl011/src/device.rs     |   4 +-
 rust/hw/timer/hpet/src/fw_cfg.rs     |   2 +-
 rust/hw/timer/hpet/src/hpet.rs       |  39 +++---
 rust/hw/timer/hpet/src/lib.rs        |   2 +-
 rust/qemu-api/src/bitops.rs          |   2 +-
 rust/qemu-api/src/qom.rs             |   4 +-
 rust/qemu-api/src/timer.rs           |   2 +-
 rust/qemu-api/src/vmstate.rs         |   2 +-
 rust/qemu-api/tests/vmstate_tests.rs |   2 +-
 10 files changed, 117 insertions(+), 119 deletions(-)

-- 
2.34.1


