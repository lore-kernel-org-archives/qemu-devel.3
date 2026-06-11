Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56B9ECD98C6
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 06:13:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXYec-0003Aw-55; Thu, 11 Jun 2026 02:12:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1wXYeZ-000389-3g
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 02:12:35 -0400
Received: from mgamail.intel.com ([192.198.163.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1wXYeX-00022w-61
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 02:12:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781158353; x=1812694353;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=BUNLGwD+0i+08MCyLkeMRlHgU+eAkvx4YYnjadRebno=;
 b=IEpxUGYwrVnwV79r7u4GQCjIWpHSRZy8E7zO+2Kva1gAvnIZBn1Zseo8
 8jhOh0cjzKSNlvFsBNpKZ1mkSLVya/KjjTGYxQlAaEdu9doME/pyatHK/
 w9tw87gkoFVQ79jfTEN5AuBdVhzVXYQ7WtyhQllQBiuHxyS3rj01jcFm5
 ySaPrKFM6Ce7Ay6Q01+TbgZkngH/LqRe5J+kFyCanvUyV8Lh8wgPg9MpO
 DCcrwYakROYupOqo1xZL0Zu/nTn4olV0aAnjXlvrms4vtoSN6P6Ud8m3V
 jElUi7MmSPfcyKdV/DVW6x+LBiquD6Tfm8/pfZA0LJnkQu7iyn2wntjqL A==;
X-CSE-ConnectionGUID: p/DGFkopQJSd+lKzsrvaIw==
X-CSE-MsgGUID: MdoF13iATm2c2LotI2amWg==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="69508013"
X-IronPort-AV: E=Sophos;i="6.24,198,1774335600"; d="scan'208";a="69508013"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jun 2026 23:12:26 -0700
X-CSE-ConnectionGUID: UoImxv8cRayOpb8ZH6MjVw==
X-CSE-MsgGUID: k5krbMSlQTiH4aAKEoQhkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,198,1774335600"; d="scan'208";a="276576432"
Received: from junjie-desk-dev.bj.intel.com ([10.238.152.71])
 by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jun 2026 23:12:25 -0700
From: Junjie Cao <junjie.cao@intel.com>
To: jic23@kernel.org
Cc: fan.ni@samsung.com,
	qemu-devel@nongnu.org,
	junjie.cao@intel.com
Subject: Re: [PATCH 3/3] hw/cxl: trace event log activity and CFMWS address
 decoding
Date: Thu, 11 Jun 2026 13:49:11 +0800
Message-ID: <20260611054911.1163902-1-junjie.cao@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260609161134.30d5e1cf@jic23-huawei>
References: <20260609161134.30d5e1cf@jic23-huawei>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.16; envelope-from=junjie.cao@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Jonathan,

Thanks so much for the detailed review. All points addressed in v2.

