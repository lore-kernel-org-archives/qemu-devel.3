Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADD30D3CC88
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 01:09:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgBrq-0000ti-HJ; Wed, 14 Jan 2026 20:09:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zide.chen@intel.com>)
 id 1vgBro-0000tT-Oq
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 20:09:40 -0500
Received: from mgamail.intel.com ([198.175.65.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zide.chen@intel.com>)
 id 1vgBrn-0004sR-5g
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 20:09:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1768439379; x=1799975379;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=nKfA7oo3iz6NvIQgBLyXvj0eZxvS2QvpIqQx4MrvuoU=;
 b=FBzdAZi6zh+37/Mc2kg0KnUBa0IRZ4EYq8wQ5B0bjwXQgyoqtdxYjzff
 3yStzAxjOKHFjFiYqyA2/E61OsvteYex9myVVHZCnpp/2tvJ7SK+no5ws
 nI/Mnn+pKW0KOd4dmaXCbBx1ciuFVWtUfiSc7oW4/SV1SK2TWujovSKff
 PAE9WWKp1lSe44mwfwNSN8fk566W0kWIuzOagF/rafFH/YtMOnkhQqzWo
 V3hr1yNgqDfUmL2ek6z7+tO/FhZDtDmyf7cU9mZlN+pIOv5BBqjhRPphg
 jw7Xcxfino3pGSE/isR3z0qIwpHqdiPoDbyKVNv+igkhC6ktcwq9guNns w==;
X-CSE-ConnectionGUID: ZDugqfuZQF+BiUGPyk6CFg==
X-CSE-MsgGUID: W81oRo69RYyXoaejdHz1nw==
X-IronPort-AV: E=McAfee;i="6800,10657,11671"; a="69723963"
X-IronPort-AV: E=Sophos;i="6.21,226,1763452800"; d="scan'208";a="69723963"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jan 2026 17:09:37 -0800
X-CSE-ConnectionGUID: ttJ52xNnST253F5pAA8OGw==
X-CSE-MsgGUID: M37YBMv5QM6LqbjoKOvHhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,226,1763452800"; d="scan'208";a="235544620"
Received: from fhuang-mobl1.amr.corp.intel.com (HELO [10.125.38.93])
 ([10.125.38.93])
 by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jan 2026 17:09:37 -0800
Message-ID: <fe918947-054b-4b53-b065-2b51a3fe1835@intel.com>
Date: Wed, 14 Jan 2026 17:09:36 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 3/5] target/i386/kvm: rename architectural PMU variables
To: Dongli Zhang <dongli.zhang@oracle.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org
Cc: pbonzini@redhat.com, zhao1.liu@intel.com, mtosatti@redhat.com,
 sandipan.das@amd.com, babu.moger@amd.com, likexu@tencent.com,
 like.xu.linux@gmail.com, groug@kaod.org, khorenko@virtuozzo.com,
 alexander.ivanov@virtuozzo.com, den@virtuozzo.com,
 davydov-max@yandex-team.ru, xiaoyao.li@intel.com,
 dapeng1.mi@linux.intel.com, joe.jin@oracle.com, ewanhai-oc@zhaoxin.com,
 ewanhai@zhaoxin.com
References: <20260109075508.113097-1-dongli.zhang@oracle.com>
 <20260109075508.113097-4-dongli.zhang@oracle.com>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <20260109075508.113097-4-dongli.zhang@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=198.175.65.17; envelope-from=zide.chen@intel.com;
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



On 1/8/2026 11:53 PM, Dongli Zhang wrote:
> AMD does not have what is commonly referred to as an architectural PMU.
> Therefore, we need to rename the following variables to be applicable for
> both Intel and AMD:
> 
> - has_architectural_pmu_version
> - num_architectural_pmu_gp_counters
> - num_architectural_pmu_fixed_counters
> 
> For Intel processors, the meaning of pmu_version remains unchanged.
> 
> For AMD processors:
> 
> pmu_version == 1 corresponds to versions before AMD PerfMonV2.
> pmu_version == 2 corresponds to AMD PerfMonV2.
> 
> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
> Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
> Reviewed-by: Sandipan Das <sandipan.das@amd.com>
> ---
LGTM.
Reviewed-by: Zide Chen <zide.chen@intel.com>

