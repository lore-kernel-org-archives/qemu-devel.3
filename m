Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14089C3DA59
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 16:30:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVvuS-0003A6-IG; Mon, 22 Jul 2024 12:29:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sVvuP-00039I-IJ
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 12:29:09 -0400
Received: from mgamail.intel.com ([198.175.65.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sVvuL-0003dz-Fk
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 12:29:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1721665745; x=1753201745;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=YMKLojLNsmNohrHOq7u6Bjwj/AkU7Uy5uOBsZo5eFlI=;
 b=lQUY3pmUuTX9HKfedaecveY3+/plcmQnl1CTkmLdC757R4IQFqEJLu1q
 4D+XlC3MvM/cU2y9ayeFJ6K9DmI59wjLi9CYg/jnNC8iBS3LRQyINQBNW
 DEB6n6H0iANyjU80plB5ncQNcSUCw85RDFfok8kBYiKt3Mc5/IQuFgWlC
 eHtY96hUxKAzuN3UfRBsIpLAoCg9VShB9kjwOstjUYh/o+ls7RXIvFJGO
 VG3b6Gp8UFJQki+QZgwNIo4nBbWP5l5V3WVODfLYCliLB77z9gCLn5n8R
 uGMAGZNtlvQ5CNwcpCkTbPesAN/L169/z+LxsN78Xidk7qaKcCVxtR8Q2 Q==;
X-CSE-ConnectionGUID: LfUH5vE2SiO8X7z23qBa7A==
X-CSE-MsgGUID: L2OzLC9ESiSKzvlAN1aJVA==
X-IronPort-AV: E=McAfee;i="6700,10204,11141"; a="19094217"
X-IronPort-AV: E=Sophos;i="6.09,228,1716274800"; d="scan'208";a="19094217"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jul 2024 09:29:01 -0700
X-CSE-ConnectionGUID: nsl/uOcuRO6HagREIue7WQ==
X-CSE-MsgGUID: EwZZc5zXT0CDWWMyzuWeJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,228,1716274800"; d="scan'208";a="51829510"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by fmviesa008.fm.intel.com with ESMTP; 22 Jul 2024 09:28:59 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>
Cc: qemu-devel@nongnu.org,
	Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH] MAINTAINERS: Add myself as a reviewer of machine core
Date: Tue, 23 Jul 2024 00:44:12 +0800
Message-Id: <20240722164412.1163414-1-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.19; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
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

While working on a series of CPU/cache topology work, I became
interested in the machine core component and would like to help to
review more related patches.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7d9811458cb0..0c55fe72611d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1879,6 +1879,7 @@ M: Eduardo Habkost <eduardo@habkost.net>
 M: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
 R: Philippe Mathieu-Daudé <philmd@linaro.org>
 R: Yanan Wang <wangyanan55@huawei.com>
+R: Zhao Liu <zhao1.liu@intel.com>
 S: Supported
 F: hw/core/cpu-common.c
 F: hw/core/cpu-sysemu.c
-- 
2.34.1


