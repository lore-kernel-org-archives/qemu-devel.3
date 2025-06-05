Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ED92C61CE7
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Jun 2025 08:09:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uN5eA-0002XG-IV; Thu, 05 Jun 2025 04:08:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uN5e8-0002Wh-Bo; Thu, 05 Jun 2025 04:08:20 -0400
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uN5e6-0006zi-4J; Thu, 05 Jun 2025 04:08:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749110898; x=1780646898;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=/H6fOiGes8RNvPIoYQeQ+oamLmBDlB+hwhF0MUKvjX4=;
 b=mRMzkOLSoyDrfp0iLjxwUYHRYV9V6H04vyeT6nGsVxjdD+ZZFTlYz7+S
 crv+rVwK/z9QU+RoO8Z1d7TBpuUTsF1SDqBtyU0r9wsv0wUxy66AL77d6
 4x1U9CFf8reI+M8LdMyhTgcJbZ7naacRp0k5L088seg8U7o7QL+WjqtBH
 bzNvhvDeXSiMqPd5c6b7OoQE0atzxyqonWGECCPpty8Yr5zARqTNltAaD
 oOEOYzXaRVgm2OAp/CbdlaYDoacTq/r0J8OH/5vd/jx0PGVfxWKPImpAF
 4MSszbyvIREVra7D3uZXOJLArXmnvr3oxHArL8gFtTKUJXNXSNNA+4KQX w==;
X-CSE-ConnectionGUID: cUllEyr2Qy2019+vmMnXVg==
X-CSE-MsgGUID: rYI+/iyETfqqAwc7lvUgEQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11454"; a="51285653"
X-IronPort-AV: E=Sophos;i="6.16,211,1744095600"; d="scan'208";a="51285653"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jun 2025 01:08:15 -0700
X-CSE-ConnectionGUID: QfbEB4KgQgO/ZyscvWGifA==
X-CSE-MsgGUID: /LIkIDbzRGONqBX++A+BlQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,211,1744095600"; d="scan'208";a="145940217"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa010.fm.intel.com with ESMTP; 05 Jun 2025 01:08:09 -0700
Date: Thu, 5 Jun 2025 16:29:22 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Alireza Sanaee <alireza.sanaee@huawei.com>
Cc: mst@redhat.com, anisinha@redhat.com, armbru@redhat.com,
 berrange@redhat.com, dapeng1.mi@linux.intel.com,
 eric.auger@redhat.com, farman@linux.ibm.com,
 gustavo.romero@linaro.org, imammedo@redhat.com,
 jiangkunkun@huawei.com, jonathan.cameron@huawei.com,
 linuxarm@huawei.com, mtosatti@redhat.com, peter.maydell@linaro.org,
 philmd@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 richard.henderson@linaro.org, shameerali.kolothum.thodi@huawei.com,
 shannon.zhaosl@gmail.com, yangyicong@hisilicon.com, maobibo@loongson.cn
Subject: Re: [PATCH v12 3/6] bios-tables-test: prepare to change ARM ACPI
 virt PPTT
Message-ID: <aEFVYrrRXPQQJI3x@intel.com>
References: <20250604133439.1592-1-alireza.sanaee@huawei.com>
 <20250604133439.1592-4-alireza.sanaee@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250604133439.1592-4-alireza.sanaee@huawei.com>
Received-SPF: pass client-ip=198.175.65.16; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.128,
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

On Wed, Jun 04, 2025 at 02:34:36PM +0100, Alireza Sanaee wrote:
> Date: Wed, 4 Jun 2025 14:34:36 +0100
> From: Alireza Sanaee <alireza.sanaee@huawei.com>
> Subject: [PATCH v12 3/6] bios-tables-test: prepare to change ARM ACPI virt
>  PPTT
> X-Mailer: git-send-email 2.34.1
> 
> Prepare to update `build_pptt` function to add cache description
> functionalities, thus add binaries in this patch.
> 
> Signed-off-by: Alireza Sanaee <alireza.sanaee@huawei.com>
> ---
>  tests/qtest/bios-tables-test-allowed-diff.h | 3 +++
>  1 file changed, 3 insertions(+)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


