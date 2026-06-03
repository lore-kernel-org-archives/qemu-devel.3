Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAD3BCD6E4A
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 02:07:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUazw-0003KV-N5; Tue, 02 Jun 2026 22:06:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1wUazc-00035N-1F
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 22:06:04 -0400
Received: from mgamail.intel.com ([192.198.163.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1wUayr-0007xN-2S
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 22:06:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780452317; x=1811988317;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=4VMG3OiO/x6pXdn8WljNJ8cDz+phOxkj/A11L60YP2s=;
 b=nQLJadkonKbpDiB5vq8mYYX3i0cFQ0Iew54aCihLMGrsLSzH6XWwpuGi
 ddEy4wKQXporFUZN9xP3a64ZAEagTc3DWKon3pKU9fPYbzpOgwu/AyIQx
 1N0g2QmAoS9uuzor4JmOCtoYVYQjZR21TejqGbSA+EGCfErezOJIgVcv3
 cX2Y7QTyHswOU2L3dwx3w+M/g/Zcl+DJSmmA2CL5VGSSpdRULQmQKG+Ge
 eDxcLm1ePmC37dvPmpVLK8QlrRTFmytf9Luh68gtNOB5I5ITouRkXgda0
 /VJv9FHXqO10Gn9+MjSstaRlSJbEn64wAVpjwJH8QYS2RDbZmysDOBxvz Q==;
X-CSE-ConnectionGUID: M499B/hjQJe1KelhbafXJA==
X-CSE-MsgGUID: dhOt2A1GTviDMBwT6h9p3w==
X-IronPort-AV: E=McAfee;i="6800,10657,11805"; a="68792603"
X-IronPort-AV: E=Sophos;i="6.24,184,1774335600"; d="scan'208";a="68792603"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jun 2026 19:05:13 -0700
X-CSE-ConnectionGUID: ohmnJIOfTtKGBZqLr5o0oA==
X-CSE-MsgGUID: NSc0z3plT2yvYhI2poVlBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,184,1774335600"; d="scan'208";a="274324113"
Received: from junjie-desk-dev.bj.intel.com ([10.238.152.71])
 by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jun 2026 19:05:12 -0700
From: Junjie Cao <junjie.cao@intel.com>
To: jic23@kernel.org
Cc: nifan.cxl@gmail.com,
	qemu-devel@nongnu.org,
	junjie.cao@intel.com
Subject: Re: [PATCH 0/3] hw/cxl: add trace-events coverage
Date: Wed,  3 Jun 2026 09:48:06 +0800
Message-ID: <20260603014806.905331-1-junjie.cao@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260603013106.904517-1-junjie.cao@intel.com>
References: <20260603013106.904517-1-junjie.cao@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Adding correct maintainer/reviewer addresses — sorry for the noise.

