Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 717A1C3ABC3
	for <qemu-devel@archiver.kernel.org>; Tue, 13 May 2025 14:11:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEqL8-0006du-Co; Tue, 13 May 2025 10:10:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uEqL4-0006Mq-Iq
 for qemu-devel@nongnu.org; Tue, 13 May 2025 10:10:35 -0400
Received: from mgamail.intel.com ([198.175.65.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uEqL2-0004X8-Cv
 for qemu-devel@nongnu.org; Tue, 13 May 2025 10:10:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1747145432; x=1778681432;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=eSkolR/s15ot4AWI7NFqfgpjlUndLDF7wZ/DlxzLWuM=;
 b=Ec1gNkgRrJeC4s8ArMZB/A6j+QGfw4gqSQw2PWzAcL3wXDJZISizy7Qc
 B6h71D66LfDzlOHdwIUCN9ZXsjteTypV+RWk4MRzHhuD0VzkzQrsD8YlZ
 zneemHgHXg3d9CNIAR0k0lTs37mW8Z7LJDVJ3MiXozNeJnM4bdRI3TyQD
 Gt+ujh+8As6ifMmvtt9qdHigFnfUISuO6gl6uLjza3UWmoSMv4lqq4Zha
 bEggcCx9H8yEYRgsftw9DLZ30toHBdsek6gksEC/+GbtL9uTGEfhV+GiM
 fnHT8L86iCH48xwk8ws8SJ9W7B+yo3q8/EwY0mUMAA46NcTNWuLlVh/um A==;
X-CSE-ConnectionGUID: K3pA3pMMRkGfV8wT5JR1nw==
X-CSE-MsgGUID: AfnFGISQToqXs+p1u5V8vw==
X-IronPort-AV: E=McAfee;i="6700,10204,11431"; a="60393330"
X-IronPort-AV: E=Sophos;i="6.15,285,1739865600"; d="scan'208";a="60393330"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 May 2025 07:10:29 -0700
X-CSE-ConnectionGUID: Vd5CDqssQLeqRHhzocSNKQ==
X-CSE-MsgGUID: Opem0+RyRJWC+V6YCdxWaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,285,1739865600"; d="scan'208";a="138132779"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by fmviesa008.fm.intel.com with ESMTP; 13 May 2025 07:10:27 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,
	Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 0/2] qapi/misc-target: Fix the doc of query-sgx and
 query-sgx-capabilities
Date: Tue, 13 May 2025 22:31:29 +0800
Message-Id: <20250513143131.2008078-1-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.12; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -58
X-Spam_score: -5.9
X-Spam_bar: -----
X-Spam_report: (-5.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.549,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Hi all,

There're 2 QMP commands: query-sgx and query-sgx-capabilities, but
their outputs are very similar and the documentation lacks clear
differentiation.

From the codes, query-sgx is used to gather guest's SGX capabilities
(including SGX related CPUIDs and EPC sections' size, in SGXInfo), and
query-sgx-capabilities is used to gather host's SGX capabilities 
(descripted by SGXInfo as well).

Therefore, fix their documentation to reflect this difference.

Thanks and Best Regards,
Zhao
---
Zhao Liu (2):
  qapi/misc-target: Fix the doc related SGXEPCSection
  qapi/misc-target: Fix the doc to distinguish query-sgx and
    query-sgx-capabilities

 qapi/misc-target.json | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

-- 
2.34.1


