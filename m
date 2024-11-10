Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D691E6781D
	for <qemu-devel@archiver.kernel.org>; Sun, 10 Nov 2024 14:52:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tA9Ha-0002LS-AU; Sun, 10 Nov 2024 09:51:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tA9HY-0002LC-J2
 for qemu-devel@nongnu.org; Sun, 10 Nov 2024 09:51:16 -0500
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tA9HV-0007vD-SW
 for qemu-devel@nongnu.org; Sun, 10 Nov 2024 09:51:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1731250274; x=1762786274;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=CH2uhPtbXXaXRBzc4RZJhOnRq6SvFQ3JDMPJEIMWH0Y=;
 b=RlxIWNQVSpT0XUJIBNu0wj+fTOBU4jz3flq9GuYu3pau0LV/tjVxkgB+
 ttqt6IcJuOKzOapbViI6EMAkPdyAnlMZjUjbstLmE9fZhjwBj3ZfkzCwg
 khXfpFYnRSqxkcjDX4tOSVzpksONx0nvkx5jPS8ygdrbcLMySXSxu0Z9i
 8cuyoNevDCXXQTkaHUQcch3P3NVu2gj49BK4Wa6LKrN3F0KWdhCiw3sLe
 L8KAECuJx4zXD1Ss8FtD7WjhZPD3OlDt13BHcJjKaJu5D7NuZ8p8k56ig
 VRJ9m14QjsVp8DXjs8Yky/3B9RG29/j4dU5YIGD9jO3Gy48xACNjXBH9e A==;
X-CSE-ConnectionGUID: CSIYKk7iTTecoEp9kl4QaA==
X-CSE-MsgGUID: 9vs/rm9gSGCNHHvK9KkS+g==
X-IronPort-AV: E=McAfee;i="6700,10204,11252"; a="56467588"
X-IronPort-AV: E=Sophos;i="6.12,143,1728975600"; d="scan'208";a="56467588"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Nov 2024 06:51:10 -0800
X-CSE-ConnectionGUID: ekUl5uqzSuOJpncFPEN3kQ==
X-CSE-MsgGUID: O1gj71zMSLKuEdGiI0dbyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,143,1728975600"; d="scan'208";a="86467566"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by orviesa010.jf.intel.com with ESMTP; 10 Nov 2024 06:51:09 -0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org,
	Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH for 9.2 0/2] machine: Miscellaneous coverity fixes
Date: Sun, 10 Nov 2024 23:08:59 +0800
Message-Id: <20241110150901.130647-1-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.7; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.118,
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

This series fixes coverity issues (CID 1565389 and 1565391) introduced
by smp-cache [1] [2].

[1]: https://lore.kernel.org/qemu-devel/20241105224727.53059-1-philmd@linaro.org/T/#mcdb1aabb7909cc379d2776d33b420565d0befc7a
[2]: https://lore.kernel.org/qemu-devel/20241105224727.53059-1-philmd@linaro.org/T/#m11915b461f463ce11872b2cc3f25c439fd3f3a77

Thanks and Best Regards,
Zhao
---
Zhao Liu (2):
  hw/core/machine-smp: Initialize caches_bitmap before reading
  hw/core/machine-smp: Fix error message parameter

 hw/core/machine-smp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

-- 
2.34.1


