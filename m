Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92F46C54E66
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 07:02:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjw90-0007nn-MM; Tue, 12 Mar 2024 03:01:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rjw8o-0007nH-KU
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 03:01:40 -0400
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rjw8m-0003ZN-8V
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 03:01:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1710226896; x=1741762896;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=RzG+D96D8mZb6YJN7oWJdLmE3xTnPWbAv+i3uRMGRBY=;
 b=U8eWFlUZ3WajYKFLf0+KnzPI52nmTkfziUAEKb1cGIEqoyq/MVz3hXyP
 RShZWGMjRPI9BDC90ZzHS+FWEocC0edcMa1Dx+4uLCxZpJY5CRranP+ca
 zq3GpxlVG4RKbeH3xKRejQd1k/9kz7Zq4/IFfVc7tpYnvFOqahlFGHOzL
 WTXkyMpSGydJ7GpknWDLCl0T5MGU2BQp+JOOIiHceauqssnAlwGmpIIvn
 6YDmDGzFXsRXSrdxGg5Jcmsp1hU5imQJCSaEX9VZMqMmmOaT6SReu3tuH
 4C7RFuBoB2gMlzSNhboDQdS0vE5+EHv71cND42q0eZfgBEVyEWNDgfyNm A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11010"; a="5093574"
X-IronPort-AV: E=Sophos;i="6.07,118,1708416000"; 
   d="scan'208";a="5093574"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Mar 2024 00:01:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,118,1708416000"; d="scan'208";a="16125741"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by orviesa005.jf.intel.com with ESMTP; 12 Mar 2024 00:01:24 -0700
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Thomas Huth <thuth@redhat.com>,
 qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH] docs/about/deprecated.rst: Move SMP configurations item to
 system emulator section
Date: Tue, 12 Mar 2024 15:15:12 +0800
Message-Id: <20240312071512.3283513-1-zhao1.liu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=192.198.163.15;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.029,
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

In the commit 54c4ea8f3ae6 ("hw/core/machine-smp: Deprecate unsupported
'parameter=1' SMP configurations"), the SMP related item is put under
the section "User-mode emulator command line arguments" instead of
"System emulator command line arguments".

-smp is a system emulator command, so move SMP configurations item to
system emulator section.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
based on 7489f7f3f81d.

Note: the git diff understood my move of SMP item as the move of the
whole "User-mode emulator command line arguments" section, which may
cause confusion about the contents of this patch.
---
 docs/about/deprecated.rst | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index dfd681cd024e..2f9277c9158c 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -47,16 +47,6 @@ as short-form boolean values, and passed to plugins as ``arg_name=on``.
 However, short-form booleans are deprecated and full explicit ``arg_name=on``
 form is preferred.
 
-User-mode emulator command line arguments
------------------------------------------
-
-``-p`` (since 9.0)
-''''''''''''''''''
-
-The ``-p`` option pretends to control the host page size.  However,
-it is not possible to change the host page size, and using the
-option only causes failures.
-
 ``-smp`` (Unsupported "parameter=1" SMP configurations) (since 9.0)
 '''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
 
@@ -71,6 +61,16 @@ configurations (e.g. -smp drawers=1,books=1,clusters=1 for x86 PC machine) is
 marked deprecated since 9.0, users have to ensure that all the topology members
 described with -smp are supported by the target machine.
 
+User-mode emulator command line arguments
+-----------------------------------------
+
+``-p`` (since 9.0)
+''''''''''''''''''
+
+The ``-p`` option pretends to control the host page size.  However,
+it is not possible to change the host page size, and using the
+option only causes failures.
+
 QEMU Machine Protocol (QMP) commands
 ------------------------------------
 
-- 
2.34.1


