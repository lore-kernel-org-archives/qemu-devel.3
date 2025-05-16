Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39D2EC3ABC9
	for <qemu-devel@archiver.kernel.org>; Fri, 16 May 2025 08:50:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFqm3-0005Ym-Nq; Fri, 16 May 2025 04:50:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uFqm0-0005Vw-Az
 for qemu-devel@nongnu.org; Fri, 16 May 2025 04:50:32 -0400
Received: from mgamail.intel.com ([198.175.65.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uFqlx-0007Ae-6g
 for qemu-devel@nongnu.org; Fri, 16 May 2025 04:50:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1747385430; x=1778921430;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=iF0d9+RYKhNvucQBkvKEvBCOsrxadGdQz+bO0b8DWNo=;
 b=c1qYE8fanQvppcgsX+aQs2lVi/ICPQNCWBkbzpFlID2EZc5FHACpsQDL
 8DJfEMq2p6HFYBB8SuVRL0znieGE8VhwFQEOsLEBX8yucp6nCFDi9mTfs
 x6DLeQ3VXbefoEhg8wv4J7RNJXqdecrO1uiWNe8tynS9kS+vidQ80qHZA
 7BRaWqf2NJoUbpy0VtFwQtvwTu7xDjfNUQg+N4KD9M3YGa40ZnjAlkmY3
 FosDsWXp63Lu5oCvQKcEKf6+qTFg8JNHYMr1KlMy0cLnsnpoPBoT2KaJw
 5Jqf7gTlsU+gGSP0hGBHQrN/206HLgzrePd0TrRmZ8nucDCZ14YHm+Dfp A==;
X-CSE-ConnectionGUID: LOiOs2ifRliC+o2/eVfPVA==
X-CSE-MsgGUID: WremOmBrTRiEJrQdW43oYA==
X-IronPort-AV: E=McAfee;i="6700,10204,11434"; a="49334655"
X-IronPort-AV: E=Sophos;i="6.15,293,1739865600"; d="scan'208";a="49334655"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 May 2025 01:50:27 -0700
X-CSE-ConnectionGUID: 5W8KXdRKQYSeLljveFkGQw==
X-CSE-MsgGUID: mqYCxg8JSz+c+KkHd0K58Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,293,1739865600"; d="scan'208";a="161939631"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by fmviesa002.fm.intel.com with ESMTP; 16 May 2025 01:50:25 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,
	Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 0/2] qapi/misc-target: Rename SGX related items to follow QAPI
 naming style
Date: Fri, 16 May 2025 17:11:28 +0800
Message-Id: <20250516091130.2374221-1-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.17; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -60
X-Spam_score: -6.1
X-Spam_bar: ------
X-Spam_report: (-6.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
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

QAPI requires strict PascalCase naming style, i.e., only the first
letter of a single word is allowed to be uppercase, which could help
with readability.

Rename SGXEPCSection & SGXInfo to SgxEpcSection & SgxInfo.

Thanks and Best Regards,
Zhao
---
Zhao Liu (2):
  qapi/misc-target: Rename SGXEPCSection to SgxEpcSection
  qapi/misc-target: Rename SGXInfo to SgxInfo

 hw/i386/sgx-stub.c    |  4 ++--
 hw/i386/sgx.c         | 32 ++++++++++++++++----------------
 qapi/misc-target.json | 18 +++++++++---------
 3 files changed, 27 insertions(+), 27 deletions(-)

-- 
2.34.1


