Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83758C61DD3
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 06:32:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2NT8-0002t4-9x; Fri, 04 Sep 2026 02:32:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1x2NT5-0002ol-9B; Fri, 04 Sep 2026 02:32:07 -0400
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1x2NT3-00064U-7d; Fri, 04 Sep 2026 02:32:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788503526; x=1820039526;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=zriIRq2vJy1ysgxcDuxY8pCvpt55v5hWB6MGQlh7J+Y=;
 b=FRpvVa1DdyXGRBPa8vvCIpjpmO7zE580iZ4fb/yNpLQGjWITUh9sQe4n
 S72cEZ0ytefqJSbjSYJiPzP1xjSX0GjrvveSuaI+bMuhERCs5FQJNbW5S
 q3aOjWw9U699OQH1oaj77BwwB9xg0pc+sozzQkVj5+oXkxmFolm7D0g2e
 KgjGYU/+E5XUmPR4/ZVJUzKdhwhyGVRSmHqofTrD1Ml3CT5RbP/HdvF+P
 XIIX+1+96r8mhXlzPyEgB3koZTqJacZYYC8zuGhMrOhHYa3xrAd/gleNN
 reH0s6DiHz8u5EX0PFswjhZgTpInktaCVHNbn/lUHkKDi3JK0kFAkEZ6y g==;
X-CSE-ConnectionGUID: Qc91kt8USQCYs6jDDC6Dgg==
X-CSE-MsgGUID: WnWQFBdwSKmnG9R3CBDS3Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11895"; a="89053586"
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; d="scan'208";a="89053586"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Sep 2026 23:32:04 -0700
X-CSE-ConnectionGUID: q7hXIhmZTi+Wbj7PJ5BQwQ==
X-CSE-MsgGUID: H9QoENy7RQ63x66Oh08aQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; d="scan'208";a="263755527"
Received: from junjie-desk-dev.bj.intel.com ([10.238.152.71])
 by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Sep 2026 23:31:59 -0700
From: Junjie Cao <junjie.cao@intel.com>
To: Chen Pei <cp0613@linux.alibaba.com>
Cc: palmer@dabbelt.com, alistair.francis@wdc.com, mst@redhat.com,
 imammedo@redhat.com, sunilvl@ventanamicro.com, sunilvl@oss.qualcomm.com,
 jic23@kernel.org, pbonzini@redhat.com, liwei1518@gmail.com,
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 chao.liu@processmission.com, anisinha@redhat.com, dave.jiang@intel.com,
 alison.schofield@intel.com, guoren@kernel.org, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, linux-cxl@vger.kernel.org
Subject: Re: [PATCH v5 6/6] tests/qtest: Update RISC-V CXL ACPI golden master
 binaries
Date: Fri,  4 Sep 2026 14:31:51 +0800
Message-ID: <20260904063152.452367-1-junjie.cao@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260831132340.5345-7-cp0613@linux.alibaba.com>
References: <20260831132340.5345-7-cp0613@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.18; envelope-from=junjie.cao@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Hi Chen Pei,

On Mon, 31 Aug 2026 21:23:37 +0800, Chen Pei wrote:
>         QWordMemory (... 0x400100000 .. 0x40010FFFF ...) // 64-bit MMIO

Reviewed-by: Junjie Cao <junjie.cao@intel.com>
Tested-by: Junjie Cao <junjie.cao@intel.com>

Golden matches on 99e54ab5e7 with the in-tree edk2-stable202608 blob
(5/6 paths renamed) and on riscv-to-apply.next 392d659bfb, still on
the edk2-stable202408 blob (1/6 rebased over the gpex_pcie_init() move
to device-common.c).

Many thanks,
Junjie

