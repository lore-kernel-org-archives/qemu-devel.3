Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C653C19F32
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 08:59:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqTY3-00080L-0A; Fri, 07 Mar 2025 03:59:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tqTY0-0007yX-54
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 03:59:12 -0500
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tqTXy-0002bU-B2
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 03:59:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1741337950; x=1772873950;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=lcLY1x1iW003ARIIYfypc8gSXCdCsMc0qubiz9RJXy8=;
 b=TvsusSPxF+dX/IvjyzSJ9pKPXPAqDnD2QDwc2Z4dPQnm+X/A3WwT/UT3
 PwRSIOh9ddsMzBog4Pu5iDBQA6Ya/W8ecYMI/VmPqtyvKMYckXDJE8xXk
 zrU9kIV3Nwpqf920mIUlD3jLBEc0YYZr1WYLqSofT8RRoJvWIpNylcLqM
 KAMDFRCKV32NAVgnWENLUnLRG2b/7IDdbkJIxNFW9FltVo9lEPrX9Sy3k
 WHOf2/U1N1Ek6+ON7NKu62wtqInp8ltGnIWJa9tiRaEgITu2dzycm5+Ps
 SV0SClDm4i5AkUERvTopfa/i8Vi8+HvwlW5PMRUyjkgwvjU0eYzSUbsEU w==;
X-CSE-ConnectionGUID: emsayoJjT924HkW0u/dQfA==
X-CSE-MsgGUID: qcAq3riFRBiVhCga1/N1+g==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="42521574"
X-IronPort-AV: E=Sophos;i="6.14,228,1736841600"; d="scan'208";a="42521574"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Mar 2025 00:59:07 -0800
X-CSE-ConnectionGUID: lflAClxPRXafbSNVjWQY3Q==
X-CSE-MsgGUID: nQXLNZKkRem5CEU/Z4hs7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="123459836"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa003.fm.intel.com with ESMTP; 07 Mar 2025 00:59:03 -0800
Date: Fri, 7 Mar 2025 17:19:11 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Dongli Zhang <dongli.zhang@oracle.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, pbonzini@redhat.com,
 mtosatti@redhat.com, sandipan.das@amd.com, babu.moger@amd.com,
 likexu@tencent.com, like.xu.linux@gmail.com,
 zhenyuw@linux.intel.com, groug@kaod.org, khorenko@virtuozzo.com,
 alexander.ivanov@virtuozzo.com, den@virtuozzo.com,
 davydov-max@yandex-team.ru, xiaoyao.li@intel.com,
 dapeng1.mi@linux.intel.com, joe.jin@oracle.com
Subject: Re: [PATCH v2 06/10] target/i386/kvm: rename architectural PMU
 variables
Message-ID: <Z8q6D8fqFmegi4uW@intel.com>
References: <20250302220112.17653-1-dongli.zhang@oracle.com>
 <20250302220112.17653-7-dongli.zhang@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250302220112.17653-7-dongli.zhang@oracle.com>
Received-SPF: pass client-ip=192.198.163.15; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

> +/*
> + * For Intel processors, the meaning is the architectural PMU version
> + * number.
> + *
> + * For AMD processors: 1 corresponds to the prior versions, and 2
> + * corresponds to AMD PerfMonV2.
> + */
> +static uint32_t has_pmu_version;

The "has_" prefix sounds like a boolean type. So what about "pmu_version"?

Others look good to me,

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


