Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65956C61DC2
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 13:38:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzDp7-0006Y3-Ag; Wed, 26 Aug 2026 09:37:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1wzDp6-0006Xr-9R; Wed, 26 Aug 2026 09:37:48 -0400
Received: from mgamail.intel.com ([192.198.163.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1wzDp4-0004kd-3W; Wed, 26 Aug 2026 09:37:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787751466; x=1819287466;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=N/ewH1XUjCFXF1ttKhEJj8Pkw0zsvEYKLlERLNbB4Is=;
 b=UKYw733b+XzdoWdSzVxIBzZ/RdZCNJpROaUfE/6e4bHGZbxpaV7KCKo6
 YxMYjmvur6sU/JBRF3n8JtabLwSZ9yFG28dYQg7PeNGSDrf1Rk3bk5QE5
 hDjuiT7qXMXffdvdi7AYxuAzNPMqfHisGAA1/2qtXas9+kJVTgALhPbTM
 3VEuwZl7eaK44is5gdo9FLH7Ah0nWgfcdrLKUl2Mop9RnJ33jyVSSqGXd
 5MHUMx7PnaLMDl+HRsiRUMahwbx8m+k4sZ78qfmJHQkyPBP4No53UbWsD
 0USpvOplr9vY89DZaoNlVMwOEdTtvileEwnVrTENBYFBMqoCtMheoHrxc w==;
X-CSE-ConnectionGUID: NFCajo+jRKeZY3QR8ydRkw==
X-CSE-MsgGUID: VDp0pQEGSLib7hhEUolScw==
X-IronPort-AV: E=McAfee;i="6800,10657,11886"; a="88249831"
X-IronPort-AV: E=Sophos;i="6.25,244,1779174000"; d="scan'208";a="88249831"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Aug 2026 06:37:41 -0700
X-CSE-ConnectionGUID: 8Bi5SUYJTHWTAzEIU7h1wA==
X-CSE-MsgGUID: KGVcK7WGQfy5sjzSoFgxnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,244,1779174000"; d="scan'208";a="269529694"
Received: from junjie-desk-dev.bj.intel.com (HELO
 junjie-desk-dev.tail2c02c1.ts.net) ([10.238.152.71])
 by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Aug 2026 06:37:37 -0700
From: Junjie Cao <junjie.cao@intel.com>
To: Chen Pei <cp0613@linux.alibaba.com>
Cc: palmer@dabbelt.com, alistair.francis@wdc.com, mst@redhat.com,
 imammedo@redhat.com, sunilvl@ventanamicro.com, sunilvl@oss.qualcomm.com,
 jic23@kernel.org, pbonzini@redhat.com, liwei1518@gmail.com,
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 chao.liu@processmission.com, anisinha@redhat.com, dave.jiang@intel.com,
 alison.schofield@intel.com, guoren@kernel.org, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, linux-cxl@vger.kernel.org
Subject: Re: [PATCH 0/4] hw/riscv/virt: Add CXL support to the RISC-V virt
 machine
Date: Wed, 26 Aug 2026 21:37:24 +0800
Message-ID: <20260826133725.355433-1-junjie.cao@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260821081954.1171-1-cp0613@linux.alibaba.com>
References: <20260821081954.1171-1-cp0613@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.14; envelope-from=junjie.cao@intel.com;
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

On Fri, 21 Aug 2026 16:19:50 +0800, Chen Pei wrote:
>   - hw/riscv/virt: The MMIO-window patch no longer touches the common
>     gpex code (Igor).  The gpex_cfg.cxl_mmio32 field and the is_cxl
>     static _CRS branch are dropped; the ACPI0016 _CRS now comes from the
>     generic build_crs() path.  Since EDK2 does not enumerate the pxb-cxl
>     expander bridge, riscv simulates the firmware PCI initialization
>     (reserved window + depth-first bridge bus numbers) and re-applies it
>     via a reset handler.

Ran this on master eea8fe61b8 (it still applies clean on bde2492aac).
riscv64 bios-tables-test passes. In the generated DSDT the PC0C _CRS
now comes out of build_crs() with the reserved window
0x70000000-0x7FFFFFFF and a bus range [0x0C,0x0D] taken from the real
subordinate, PCI0 shrunk to 0x40000000-0x6FFFFFFF, and the CEDT CHBS
and CFMWS matching the machine memmap. The machine-global window
synthesis and the +15 bus range from v2 are gone.

system_reset from the monitor leaves the root port with the same
window and secondary/subordinate numbers, so the reset handler does
what it says.

One larger question on 3/4 about where that enumeration should come
from, and a note on 4/4.

Tested-by: Junjie Cao <junjie.cao@intel.com>

Many thanks,
Junjie

