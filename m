Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFAFBD3B9AC
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2024 16:13:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFyBP-0006se-Vb; Tue, 26 Nov 2024 11:13:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tFyBC-0006mU-0l; Tue, 26 Nov 2024 11:12:47 -0500
Received: from mgamail.intel.com ([192.198.163.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tFyBA-0000fL-16; Tue, 26 Nov 2024 11:12:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1732637564; x=1764173564;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=MqOjZcIcIZCUmlvGQssXiXVUklDmjInIUJAuz9HKaSk=;
 b=LoRPNFvf8IsVtlTgch31ma4+0ESJKURr4Bduq9s1kNZ8aPYmgG46wtIy
 fXzjTf1O6QcyJNdJawbFhYkxzLoIyNq4VGz7YvjG6ObBnRvb2g8xLM/W5
 0j6bh4XIix9fbxkr4UmAKfkOwiXIyPDWG8Lcn7JipACYXQ4RkxBabIcY3
 huAdIoyM0NtxOjmQwbvbiu7Kl/mvoHEX7nz7Viun/PnOtGLs5v7Q68rX+
 tLQz2XFT6CyjeuWUfKQRQlgpJ8OjU727ah+oRz6XVGGV+mjxcjQ0pn1jt
 wCspeV9LEChhh7RXmD2JcD9XpXBlLzriRpukR+2mri/UxcfceWAviokzi Q==;
X-CSE-ConnectionGUID: ZwtpWz5rT269sO0Q7dVPYA==
X-CSE-MsgGUID: WyhfGKv7SxGOX+lYu/em5w==
X-IronPort-AV: E=McAfee;i="6700,10204,11268"; a="20399386"
X-IronPort-AV: E=Sophos;i="6.12,186,1728975600"; d="scan'208";a="20399386"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Nov 2024 08:12:41 -0800
X-CSE-ConnectionGUID: CzMa7JzqQkiKIinm90QeiQ==
X-CSE-MsgGUID: Hii1RZReQOGzpkdEtjqpfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,186,1728975600"; d="scan'208";a="91277664"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by fmviesa006.fm.intel.com with ESMTP; 26 Nov 2024 08:12:39 -0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 0/2] hw/timer/hpet: miscellaneous cleanup
Date: Wed, 27 Nov 2024 00:30:44 +0800
Message-Id: <20241126163046.3344931-1-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
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

Hi,

This series just cleans up the outdated comment and macro.

No functional changes.

Thanks and Best Regards,
Zhao
---
Zhao Liu (2):
  hw/timer/hpet: Fix comment about capabilities register
  hw/timer/hpet: Drop the unused macro

 hw/timer/hpet.c         | 2 +-
 include/hw/timer/hpet.h | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

-- 
2.34.1


