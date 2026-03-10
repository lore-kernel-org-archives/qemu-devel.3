Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7042BEB105A
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 14:22:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzxyf-0006Tv-NZ; Tue, 10 Mar 2026 10:22:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vzxyd-0006TW-Pd
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 10:22:28 -0400
Received: from mgamail.intel.com ([192.198.163.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vzxyT-0008Ts-C4
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 10:22:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773152537; x=1804688537;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=LY0ugd6G2ux3QLQzKlVN3OVRTEmcSaTPW4XfKkhfTho=;
 b=Hu4WsVn4/TDSRILs7gv1YiWsLDGcsM+JBV7t3ipIZm/hIMpvtb2d0FHE
 2ITfQwerdR8hu+UxF+V3hmQBIXYTfQhCnkH0RHl4aIoawNc7++csOs3by
 3QPfbxpVQKytuGAM5N6eX+pTk37//tS7LvKKlkz4BaglyubGOr48H0v7i
 z7jKOvz/mJxPk5fSu3UpM8OxksqvBrsTF9b3Ha6VdvGDRkLDOBRma8NoQ
 BdIXS8dat8E/5r44oh6btc2lZx3cpQGCSwwS1oFjmJpqQUcj3xrdzjkco
 +NF3I8XTn4XtPSKpMWQcTfVRxaxA7GPKY+YchaA01QBd/17OAa/rmtN8W w==;
X-CSE-ConnectionGUID: PIiKSI3dRH+aecZsewaBMA==
X-CSE-MsgGUID: b8CzsI4USTuxav7SmY242Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11725"; a="84833851"
X-IronPort-AV: E=Sophos;i="6.23,112,1770624000"; d="scan'208";a="84833851"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Mar 2026 07:22:14 -0700
X-CSE-ConnectionGUID: 1c9+EKOOSj+UR8ZOkwdXDQ==
X-CSE-MsgGUID: LOb8wqZiSSKe7JZnaWjmLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,112,1770624000"; d="scan'208";a="216903347"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa010.fm.intel.com with ESMTP; 10 Mar 2026 07:22:12 -0700
Date: Tue, 10 Mar 2026 22:48:23 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Yi Liu <yi.l.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v2 00/10] hw/i386/pc: Remove deprecated 3.1 machines
Message-ID: <abAvNziZxBIc6+o6@intel.com>
References: <20260309145013.44327-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260309145013.44327-1-philmd@linaro.org>
Received-SPF: pass client-ip=192.198.163.11; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Mar 09, 2026 at 03:50:02PM +0100, Philippe Mathieu-Daudé wrote:
> Date: Mon,  9 Mar 2026 15:50:02 +0100
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> Subject: [PATCH v2 00/10] hw/i386/pc: Remove deprecated 3.1 machines
> X-Mailer: git-send-email 2.53.0
> 
> 1 y.o. dust Thomas asked me to rebase & post:
> 
> The versioned 'pc' and 'q35' machines up to 3.1 been marked
> as deprecated two releases ago, and are older than 6 years,
> so according to our support policy we can remove them.
> 
> v2: Remove xenfv-3.1 in patch #1
> 
> Philippe Mathieu-Daudé (10):
>   hw/i386/pc: Remove deprecated pc-q35/pc-i440fx/xenfv 3.1 machines
>   hw/i386/pc: Remove PCMachineClass::pvh_enabled field
>   hw/i386/x86: Remove @pvh_enabled argument in x86_load_linux()
>   hw/core/boards: Remove MachineClass::smbus_no_migration_support field
>   hw/i386/pc: Remove pc_compat_3_1[] array
>   hw/i386/iommu: Remove IntelIOMMUState::dma_drain field
>   target/i386/cpu: Remove X86CPU::intel_pt_auto_level field
>   hw/core/machine: Remove the hw_compat_3_1[] array
>   hw/pci-bridge/pcie_rp: Remove PCIESlot::disable_acs field
>   hw/tpm: Remove CRBState::ppi_enabled field

Just a rough idea - not sure whether patches 9 and 10 should be
deprecated before removal. Maybe someone might still use them for
emulating older systems?

If you feel it needs to be deprecated first, I could add these two
properties to my series about deprecated property support (v3) -
v3 will take some time.

Thanks,
Zhao


