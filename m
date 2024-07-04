Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3E4AC3271F
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 08:32:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPHtP-0006fm-Fg; Thu, 04 Jul 2024 04:32:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sPHtK-0006Pc-6x; Thu, 04 Jul 2024 04:32:34 -0400
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sPHtE-00051M-Rp; Thu, 04 Jul 2024 04:32:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1720081949; x=1751617949;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=m49gTWXS6ca2p8lqTCdnmzYMtneKlZAzq3sovEPigys=;
 b=DwjCbnOMErMJkIK3PN+shkv6hVSxHxU/KfK+T/5ZDn7L/291udGSInLS
 A/ZmwZDWTMQ7DJm9HTwJhlMmXF/u4oMNT10ieNUOy27FtranISWTTUSgx
 /6MW1IzvuDyZC+KuY2xz4KjZVl1tcy/igVCoMnsDUc+tJCPaFq44u7Nm+
 62BYu7TQ9CliPG6R1J2fCHWtna8PvQnwzhGSpKbrZq4oORqeJKuQmCZ6j
 hWRZKN9HHQm50KvtT1pD0jIgCV+XDEgq7zHponWz3kxrZQ3T7ZxwnIgw0
 HmfnqZdWO0/KcjDYCWAdH0RFYhNDGwgx2P4cZfbMnVF2UmrllU7R2Buj7 A==;
X-CSE-ConnectionGUID: D65HesfHS0alymoKTAicxg==
X-CSE-MsgGUID: m4T8espFQWCHeHF5uzB/5g==
X-IronPort-AV: E=McAfee;i="6700,10204,11122"; a="17215688"
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; d="scan'208";a="17215688"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jul 2024 01:32:25 -0700
X-CSE-ConnectionGUID: HhYFVVGiTM2/9Sj8/iPrwg==
X-CSE-MsgGUID: H+wxlzMNQhS/xyjcE004qw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; d="scan'208";a="46597203"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by fmviesa010.fm.intel.com with ESMTP; 04 Jul 2024 01:32:24 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 0/4] trivial: Fix superfluous trailing semicolon
Date: Thu,  4 Jul 2024 16:47:55 +0800
Message-Id: <20240704084759.1824420-1-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.17; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Hi,

I checked the files in QEMU to fix these few errors about "superfluous
trailing semicolon" to honor the requirement in checkpatch.pl.

Thanks and Best Regards,
Zhao
---
Zhao Liu (4):
  accel/kvm/kvm-all: Fix superfluous trailing semicolon
  hw/i386/x86: Fix superfluous trailing semicolon
  util/oslib-posix: Fix superfluous trailing semicolon
  target/hexagon/imported/mmvec: Fix superfluous trailing semicolon

 accel/kvm/kvm-all.c                    | 2 +-
 hw/i386/x86.c                          | 2 +-
 target/hexagon/imported/mmvec/ext.idef | 2 +-
 util/oslib-posix.c                     | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

-- 
2.34.1


