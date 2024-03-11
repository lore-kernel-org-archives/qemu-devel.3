Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64734C54E67
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 07:43:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjaJ0-0006ka-Aj; Mon, 11 Mar 2024 03:42:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rjaIy-0006jL-6H
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 03:42:40 -0400
Received: from mgamail.intel.com ([198.175.65.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rjaIw-0006Mg-3p
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 03:42:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1710142958; x=1741678958;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=iEobmFBO4MAjOydJzEV5iPMLvs5WoBUKWwSHn/YHlAc=;
 b=jFZplcyVo783pl5hPrN+CEk93jkVC8MEaNh4EEut/zuY/COxomDgaUlb
 /0wwHc7W7qo6bp3BgsAL9uE6UYOuqfXxNCJjdALrFNn3cmqiVKzRoY6I8
 RL4DtzFJoeCLfKL+xuc1qSqtioeXRrUSJMBvIpWbGdYwYivo/iKgsCDcf
 IKC8NXxyHGKTUBFtBUoowVg54pRc5v7xMmlDjSZrce9hRtr8I1hHqB6pi
 iZk3QJ253hXZ6gBOElARuPlG1t/ae0vPrEhx+rWkR1CoDWEZka/mzA7JP
 g+1EqDeptQvr7g/uA9s2G30YQRiMPTrZzjKErTbERz/HlahPD2xkRZDzn A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11009"; a="16229062"
X-IronPort-AV: E=Sophos;i="6.07,116,1708416000"; d="scan'208";a="16229062"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Mar 2024 00:42:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,116,1708416000"; d="scan'208";a="34215895"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by fmviesa002.fm.intel.com with ESMTP; 11 Mar 2024 00:42:34 -0700
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v3 0/3] hw/core: Cleanup and reorder headers
Date: Mon, 11 Mar 2024 15:56:18 +0800
Message-Id: <20240311075621.3224684-1-zhao1.liu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=198.175.65.12;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.945,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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

From: Zhao Liu <zhao1.liu@intel.com>

Hi list,

This is the v3 based on the commit 7489f7f3f81d ("Merge tag 'hw-misc-
20240309' of https://github.com/philmd/qemu into staging")

This series identifies unused headers by manually checking item (of
headers) calls in .c files, and is tested by full compilation (tested by
"./configure" and then "make").

Thanks and Best Regards,
Zhao

---
Changelog:

Changes since v2:
  * Dropped the reorder patches since QEMU has no (alphabetical) order
    requirement for included headers.
  * Re-included hw/core/cpu.h in hw/core/numa.c since
    CPU_UNSET_NUMA_NODE_ID is defined in this header.

Changes since v1:
  * Per Peter and Philippe's comments in v1, kept directly included
    headers to avoid implicit header inclusions.

v2: https://lore.kernel.org/qemu-devel/20240116074647.3644821-1-zhao1.liu@linux.intel.com/
v1: https://lore.kernel.org/qemu-devel/20240115094852.3597165-1-zhao1.liu@linux.intel.com/

---
Zhao Liu (3):
  hw/core: Cleanup unused included headers in cpu-common.c
  hw/core: Cleanup unused included header in machine-qmp-cmds.c
  hw/core: Cleanup unused included headers in numa.c

 hw/core/cpu-common.c       | 4 ----
 hw/core/machine-qmp-cmds.c | 1 -
 hw/core/numa.c             | 2 --
 3 files changed, 7 deletions(-)

-- 
2.34.1


