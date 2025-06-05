Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FEEDC5AE59
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Jun 2025 13:38:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNAmW-0001vE-Gw; Thu, 05 Jun 2025 09:37:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uNAmT-0001u6-AM; Thu, 05 Jun 2025 09:37:17 -0400
Received: from mgamail.intel.com ([198.175.65.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uNAmK-0008Ok-An; Thu, 05 Jun 2025 09:37:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749130629; x=1780666629;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=c3AYYTE4jXbTTJMfKgbjtc+QoEFK3LuNYXA8vE/YJ4s=;
 b=kobbXKGecmhETP/ZDe3aWLVghSINdhOIdW3ylng21+74fHu1QpuKg7Uq
 mpbwSZT3cnxvQCe6magBHKg6ZrzpY6aTMYWD5dt9o4m1cKS62io5WA1rs
 Z6fmjUjFL8xADnmr9smQ/Xge5uzzgJ9EQWkmG/LcvP8oYpLucrSO5QQco
 MnnYydwA7ZOiNl5WBfU61G8c8DwrQ8FKz8MoURlcMp2/lZN1yiUcSq6Gz
 Bi6qH5ZAgheoy37TCyyblo9CGCvMYox1HLKmz2TvrcoLLErbs9XVouty8
 Mk/89UPCl31zfoiFQfzl/+SEN+b1MzfIQJcGs8uMWT7mLDV13KpGw9XFZ Q==;
X-CSE-ConnectionGUID: XLoJ0V9QTKK/jIz69iUhlg==
X-CSE-MsgGUID: rY+HR2PzSuqF16eDH5aykQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11455"; a="51246687"
X-IronPort-AV: E=Sophos;i="6.16,212,1744095600"; d="scan'208";a="51246687"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jun 2025 06:37:05 -0700
X-CSE-ConnectionGUID: 37ZMDUOzR9icCqmlqBuOcg==
X-CSE-MsgGUID: b3v16a65TDSjX9lNECuymQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,212,1744095600"; d="scan'208";a="182716923"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa001.jf.intel.com with ESMTP; 05 Jun 2025 06:36:59 -0700
Date: Thu, 5 Jun 2025 21:58:13 +0800
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
Subject: Re: [PATCH v12 2/6] arm/virt.c: add cache hierarchy to device tree
Message-ID: <aEGidafjNMYHAgiO@intel.com>
References: <20250604133439.1592-1-alireza.sanaee@huawei.com>
 <20250604133439.1592-3-alireza.sanaee@huawei.com>
 <aEFnFI+wglkmLD5G@intel.com>
 <20250605104048.00000f00.alireza.sanaee@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250605104048.00000f00.alireza.sanaee@huawei.com>
Received-SPF: pass client-ip=198.175.65.17; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.132,
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

> Hi Zhao,
> 
> Thanks for the feedback, I was actually unsure about the structure, and
> was looking to get some feedback here, to see where to put what! I
> will go over the suggestions, and take note. In the meantime, let's see
> if we can get some more review here.

Sure! BTW, it's better to spilt the general code change (not ARM-specific
codes) into a separate patch. Anyway, it's up to you.

Regards,
Zhao


