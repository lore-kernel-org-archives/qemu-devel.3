Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC7BBC77B7C
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Jun 2025 03:57:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUHFK-0002tZ-7t; Tue, 24 Jun 2025 23:56:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uUHFH-0002tF-D4
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 23:56:23 -0400
Received: from mgamail.intel.com ([198.175.65.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uUHFC-0002E9-9H
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 23:56:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750823778; x=1782359778;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=eBRKdMh4xvaBD32Nm5VsgJAXiiHv8wyA7sQUVoDNXFQ=;
 b=ltQk/KhYPHZ1N8TXz9L0fUtVMcFMXsJvkKQ/Y7yk9lE9x9JKVGrG0saR
 dQNxMCp3l9VT4JmUU1pBgmZ6VNSiTmc1rgwpJyfrT2mS5eUMPLP8pgQgj
 6pz84fCS6xIofTctZlkYfoWloC50defd90i66rPT2JF+q/srh9R7EyIFk
 xJCjkyrdHRyYFD3RE2ULDx0nijL4/7zpgtRl1thkRj5M4YZ/Ys9AOT7o+
 1d5o3tThkV4mMpwpaanArjYM8L2JLvP+6mvD4Z6aCHex+TgsscNvqX/CV
 8dIaGLQzn+GnWOtGgVy6z01Aa1NOxLz+zhe9gPxFi3MxOty+o1bbEvV5R w==;
X-CSE-ConnectionGUID: VNI0JIY/T8KW5yZzuwltkg==
X-CSE-MsgGUID: Ruxrj672Tom4rQavqWecPw==
X-IronPort-AV: E=McAfee;i="6800,10657,11474"; a="52800068"
X-IronPort-AV: E=Sophos;i="6.16,263,1744095600"; d="scan'208";a="52800068"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jun 2025 20:56:12 -0700
X-CSE-ConnectionGUID: gg6yrXE4QFSEzf6TYTw1Qw==
X-CSE-MsgGUID: 4yQDocMNTjeQEA8J+lQA0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,263,1744095600"; d="scan'208";a="151848916"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by orviesa009.jf.intel.com with ESMTP; 24 Jun 2025 20:56:11 -0700
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 xiaoyao.li@intel.com, qemu-devel@nongnu.org
Subject: [PATCH 0/2] i386: Don't build TDX for 32-bit target 
Date: Wed, 25 Jun 2025 11:49:01 +0800
Message-ID: <20250625034903.2770272-1-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.20; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Build errors of TDX were reported when built on 32-bit host[1][2].
People were agreed to disable TDX on 32-bit build[3].

This series implemnts the agreement that it makes TDX available when
!I386.

[1] https://lore.kernel.org/qemu-devel/20250602173101.1052983-1-clg@redhat.com/
[2] https://lore.kernel.org/qemu-devel/b8171c39-6a92-4078-a59a-a63d7452e1e9@kaod.org/
[3] https://lore.kernel.org/qemu-devel/a838e7cc-968e-4ca4-ba60-bbf201d689aa@redhat.com/

Xiaoyao Li (2):
  i386/Kconfig: Make I386 and X86_64 independant
  i386/tdx: Don't build TDX for 32bit target

 hw/i386/Kconfig     | 12 ++++++------
 target/i386/Kconfig |  1 -
 2 files changed, 6 insertions(+), 7 deletions(-)

-- 
2.43.0


