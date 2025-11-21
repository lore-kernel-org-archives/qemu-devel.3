Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E3F2CFA468
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Nov 2025 08:22:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMMPC-0001KT-5F; Fri, 21 Nov 2025 03:22:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vMMPA-0001K4-5k
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 03:22:08 -0500
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vMMP8-00060q-Af
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 03:22:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763713327; x=1795249327;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=Rrd9lPZxETwt8dsqNHVFn2mbZUq8Ng2lPaHkt76xy0o=;
 b=RttAusHbX8iOIkqjhp7J5RIqxD00QzZBGUlKgxi26KyteR7us2p6YbvG
 zNcXT150utfQWrImx/uNIxVihe/wLEGcFYfRlGUQts1gxocJWpM/N1GO9
 roLrE0YEBMUNDR6fCMZ1itmA1iAL5RnozMu/LQ30pUkStu4BQBMHkY/Dq
 XE3KpHe4h8VZTYRbw41SUeifKCMoJUlhqc7hR9c4M6PEp5hd7BuqHG+f8
 9hY9Ku8bdS153oHWiP14G3JstXAnFhe8RcbrcuK7dWRtaB/shDkU6iFbY
 C0EqeutXNs+HgFsjoC7iuXlgEf66IMtcXMwVGK4I8UiKLTsC6kEgJCSji A==;
X-CSE-ConnectionGUID: OcDZr1ecT3SXg+B/sJNr1A==
X-CSE-MsgGUID: LmT+8Dt4SaWCi+eInKKHUA==
X-IronPort-AV: E=McAfee;i="6800,10657,11619"; a="68407960"
X-IronPort-AV: E=Sophos;i="6.20,215,1758610800"; d="scan'208";a="68407960"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Nov 2025 00:22:04 -0800
X-CSE-ConnectionGUID: UVNah6h/T/yhRknxH/3Kxg==
X-CSE-MsgGUID: 5A3WrBdoQ8mMbEKwY83Qog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,215,1758610800"; d="scan'208";a="191881411"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by fmviesa008.fm.intel.com with ESMTP; 21 Nov 2025 00:22:02 -0800
From: Zhao Liu <zhao1.liu@intel.com>
To: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, devel@lists.libvirt.org,
 Markus Armbruster <armbru@redhat.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH] docs/deprecated: Remove undeprecated SMP description
Date: Fri, 21 Nov 2025 16:44:16 +0800
Message-Id: <20251121084416.1031466-1-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.13; envelope-from=zhao1.liu@intel.com;
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

"Unsupported 'parameter=1' SMP configuration" was proposed to be
deprecated in the commit 54c4ea8f3ae6 ("hw/core/machine-smp: Deprecate
unsupported "parameter=1" SMP configurations").

But the related code was reverted later in the commit 9d7950edb0cd
("hw/core: allow parameter=1 for SMP topology on any machine").

Thus, this SMP behavior is still valid and is not actually deprecated.

Remove outdated document descriptions.

Reported-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 docs/about/deprecated.rst | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 03e29915f0aa..bbfcce4a1ab3 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -54,20 +54,6 @@ as short-form boolean values, and passed to plugins as ``arg_name=on``.
 However, short-form booleans are deprecated and full explicit ``arg_name=on``
 form is preferred.
 
-``-smp`` (Unsupported "parameter=1" SMP configurations) (since 9.0)
-'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
-
-Specified CPU topology parameters must be supported by the machine.
-
-In the SMP configuration, users should provide the CPU topology parameters that
-are supported by the target machine.
-
-However, historically it was allowed for users to specify the unsupported
-topology parameter as "1", which is meaningless. So support for this kind of
-configurations (e.g. -smp drawers=1,books=1,clusters=1 for x86 PC machine) is
-marked deprecated since 9.0, users have to ensure that all the topology members
-described with -smp are supported by the target machine.
-
 QEMU Machine Protocol (QMP) commands
 ------------------------------------
 
-- 
2.34.1


