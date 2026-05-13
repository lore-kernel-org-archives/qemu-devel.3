Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 455ECCD4851
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2026 15:21:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNBOG-0002ns-4E; Wed, 13 May 2026 11:20:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1wNBOE-0002mS-Mb; Wed, 13 May 2026 11:20:50 -0400
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1wNBOD-00015A-Bc; Wed, 13 May 2026 11:20:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778685649; x=1810221649;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=CuepnACZaNT0p/LQs6RGoR4o9j9Uy65oj42D2z7vuEA=;
 b=DxNW5AMPxqF3mIstkiIpT3mDEWujXTf4fzwRkl1+muigfQZiLiGEb8fd
 iLQQv2la35NFkiiGuZjP2U0YvAj3oVh1v2Fam2Lz4XC7/i94Cdeftxv+y
 ECdMoekMVHZrPLfgx1r6JX5wMSkOy9nlyLU9yGYnE1+sT/Ebe1wZ3gFGJ
 BknXxVIpL+3jysS1e1sEiQ1sgcEe1ut+iyHlE+Q2PQD87ubCNBVI2+BW+
 nFzVT8zhJjTObD8f6g4GuN3NAWaulg2NkEp8kO7qIYkwBpQ926q00RTZO
 M/kdM4j2rzYpUFL/5DWtxKZX1XYkt9rFqSsOu3S/fKyNbiiAiEYAXGhhV g==;
X-CSE-ConnectionGUID: 8wgKEPdcSW2CeEctEI8r5g==
X-CSE-MsgGUID: LLzNjABkS/Gz6pYrmEAHKA==
X-IronPort-AV: E=McAfee;i="6800,10657,11785"; a="82184018"
X-IronPort-AV: E=Sophos;i="6.23,232,1770624000"; d="scan'208";a="82184018"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 May 2026 08:20:47 -0700
X-CSE-ConnectionGUID: OMUNrxn8T1uFks7faUvW5Q==
X-CSE-MsgGUID: 4/kzYageQ0CCrpYUzTG1QQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,232,1770624000"; d="scan'208";a="238210699"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa009.jf.intel.com with ESMTP; 13 May 2026 08:20:45 -0700
Date: Wed, 13 May 2026 23:48:30 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, anisinha@redhat.com,
 pbonzini@redhat.com, peter.maydell@linaro.org,
 shannon.zhaosl@gmail.com, philmd@linaro.org, rad@semihalf.com,
 leif.lindholm@oss.qualcomm.com, qemu-arm@nongnu.org
Subject: Re: [PATCH v2 04/21] tests: acpi: x86/q35: whitelist new WDAT table
Message-ID: <agSdTgyvBQrlYpeX@intel.com>
References: <20260303092532.2410177-1-imammedo@redhat.com>
 <20260303092532.2410177-5-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260303092532.2410177-5-imammedo@redhat.com>
Received-SPF: pass client-ip=192.198.163.13; envelope-from=zhao1.liu@intel.com;
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

On Tue, Mar 03, 2026 at 10:25:15AM +0100, Igor Mammedov wrote:
> Date: Tue,  3 Mar 2026 10:25:15 +0100
> From: Igor Mammedov <imammedo@redhat.com>
> Subject: [PATCH v2 04/21] tests: acpi: x86/q35: whitelist new WDAT table
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> Acked-by: Ani Sinha <anisinha@redhat.com>
> ---
>  tests/qtest/bios-tables-test-allowed-diff.h | 1 +
>  tests/data/acpi/x86/q35/WDAT.wdat           | 0
>  2 files changed, 1 insertion(+)
>  create mode 100644 tests/data/acpi/x86/q35/WDAT.wdat

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


