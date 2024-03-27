Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A001EC47DD9
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Mar 2024 10:27:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpQUs-0007gx-GD; Wed, 27 Mar 2024 06:27:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rpQUD-0007OD-Id
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 06:26:27 -0400
Received: from mgamail.intel.com ([192.198.163.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rpQU4-0007Zu-IP
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 06:26:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1711535176; x=1743071176;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=T2q8tIsDejUmCf9z6MLJdMNBBd9A9qw2SbxPUFF/E0E=;
 b=cp9xzuvqmplt7cOQTDGPaRucBjkUMR7arK9WLX5K9XLD9mpJq2bC/zp7
 xhrjkfMsgCGeA3JvjSy5IcnrVS40kIC+Ml7iT/SAmf5a+DBKbvGJ9ZnfF
 mIDqykWb5oMMxY9/tz5uX0Vz3xVEAnKV8r1EJwoRkyFd3EOpFz9AeVssG
 0DjmKuthl9N0OdnomoFpNARKe6va2EedkE8YzH0NWlH9ycqx7j+Cpm57q
 DnOEVcliXNaRdTgzOVYARGZzbFLVqzEBB1bgsFnn5qhtINUhNNhnLr08V
 jCaDCg5aXOWFdcOAB6zdlq0AEbd4kv5fHSWobNsMt2prvAeHyv7XDxRSn A==;
X-CSE-ConnectionGUID: KCTid6X8RNyET5rw8RbuJQ==
X-CSE-MsgGUID: UlhJo3qbRpy60oD6mCCcrg==
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="6489752"
X-IronPort-AV: E=Sophos;i="6.07,158,1708416000"; 
   d="scan'208";a="6489752"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Mar 2024 03:25:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,158,1708416000"; d="scan'208";a="16354463"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by fmviesa008.fm.intel.com with ESMTP; 27 Mar 2024 03:25:57 -0700
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,
	Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 0/3] target/i386/cpu: Misc cleanup for warning message
Date: Wed, 27 Mar 2024 18:39:48 +0800
Message-Id: <20240327103951.3853425-1-zhao1.liu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=192.198.163.19;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.088,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Hi Paolo and list,

In i386, there're 2 cases useing static variables to implement warning
only once.

So consolidate the use of warn_report_once() in i386 part. (Based on
the commit 5012e522aca1 "Update version for v9.0.0-rc1 release")

Thanks and Best Regards,
Zhao
---
Zhao Liu (3):
  target/i386/host-cpu: Consolidate the use of warn_report_once()
  target/i386/cpu: Consolidate the use of warn_report_once()
  target/i386/cpu: Merge the warning and error messages for AMD HT check

 target/i386/cpu.c      | 13 +++++--------
 target/i386/host-cpu.c | 11 ++++-------
 2 files changed, 9 insertions(+), 15 deletions(-)

-- 
2.34.1


