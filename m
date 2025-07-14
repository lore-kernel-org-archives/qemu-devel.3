Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E40BDC83F1B
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 09:33:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubFYJ-00035e-3W; Mon, 14 Jul 2025 05:32:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1ubFTo-00013U-HD
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 05:28:21 -0400
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1ubFTl-0003Dn-0X
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 05:28:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1752485289; x=1784021289;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=y5wgNskGOoh9tLjNUX982TkoIpnwHs22FL3BDBnj5yQ=;
 b=CtrVyG4CxWaer4/3JguQaJ+NVgzJDVOIoBqiURE31FTYQaIffa8obP8i
 CWA+zB4hijW4+OoW1lVsJdODO9Pvgg6IR0jvYyoTqKCaDOj7Px2mk2L7G
 Si93LBjLy2kmhilos6U4OmqGX0neezIOE6VOf9Id4I+HGf5PMUlUi48VG
 e7UW2SmHo3fKDwhgYcac7obk4E+bzRCLElTGmyXq4RACXmCvja7UA+S1/
 xi5XOWHdMsxi2qtAeeRP0WwNd7UIp368xz2WEmueRlFvTmF1paymyHu3c
 m+nk3hrPHa2TAb9DRxToUo5aEd3AgLedmgPowKNI/bq8YLAoH5vnV6LQj w==;
X-CSE-ConnectionGUID: H9jhb7aESqezeglaVFAbTQ==
X-CSE-MsgGUID: MxJhBUf3St+KEHGkxavFsw==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="66029304"
X-IronPort-AV: E=Sophos;i="6.16,310,1744095600"; d="scan'208";a="66029304"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jul 2025 02:28:08 -0700
X-CSE-ConnectionGUID: gHTvAJr6TF6P+PilZuLMiw==
X-CSE-MsgGUID: Celz1Q8ARmmuzhsWgoHPvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,310,1744095600"; d="scan'208";a="187882753"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by orviesa002.jf.intel.com with ESMTP; 14 Jul 2025 02:28:07 -0700
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,
	Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PATCH 5/5] qemu-options: Add description of tdx-guest object
Date: Mon, 14 Jul 2025 17:19:53 +0800
Message-ID: <20250714091953.448226-6-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250714091953.448226-1-xiaoyao.li@intel.com>
References: <20250714091953.448226-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.10; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Add description of tdx-guest object so that QEMU doc page can have the
description.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 qemu-options.hx | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/qemu-options.hx b/qemu-options.hx
index 5c400114c2e5..50c7874bbce9 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -5994,6 +5994,46 @@ SRST
                  -machine ...,confidential-guest-support=sev0 \\
                  .....
 
+    ``-object tdx-guest,id=id,[attributes=attrs,sept-ve-disable=on|off,mrconfigid=sha384_digest,mrowner=sha384_digest,mrownerconfig=sha384_digest,quote-generation-socket=socketaddr]``
+        Create an Intel Trusted Domain eXtensions (TDX) guest object, which is
+        the type of ``confidentiala-guest-support`` object. When pass the object
+        ID to machine's ``confidentiala-guest-support`` property, it can create
+        a TDX guest.
+
+        The ``attributes`` is a 64-bit integer, which specifies the TD
+        attributes of the TD.
+
+        The ``sept-ve-disable`` controls the bit 28 of TD attributes
+        specifically. When it's on, the EPT violation conversion to #VE on
+        guest access of PENDING pages is disabled. Some guest OS (e.g., Linux
+        TD guest) may require this to be set, otherwise they refuse to boot.
+        The default value is on.
+
+        The ``mrconfigid`` is base64 encoded SHA384 digest, which provides the
+        ID for non-owner-defined configuration of the guest TD, e.g., run-time
+        or OS configuration. The default value is all zeros.
+
+        The ``mrowner`` is base64 encoded SHA384 digest, which provides the ID
+        for guest TD's owner. The default value is all zeros.
+
+        The ``mrownerconfig`` is base64 encoded SHA384 digest, which provides
+        the ID for owner-defined configuration of the guest TD, e.g., the
+        configuration specific to the workload rather than the run-time of OS.
+        The default value is all zeros.
+
+        The ``quote-generation-socket`` specifies the socket address of the
+        Quote Generation Service (QGS). QGS is a daemon running on the host.
+        QEMU forwards the <GetQuote> request from TD guest to QGS and sents the
+        reply (which contains generated QUOTE on success) from QGS to guest TD.
+
+        .. parsed-literal::
+
+             # |qemu_system_x86| \\
+                 ... \\
+                 -object tdx-guest,id=tdx0, \\
+                 -machine ...,confidential-guest-support=tdx0 \\
+                 ...
+
     ``-object authz-simple,id=id,identity=string``
         Create an authorization object that will control access to
         network services.
-- 
2.43.0


