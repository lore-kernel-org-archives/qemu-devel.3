Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77628CCD1A5
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 05:52:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDG9O-0006lX-Mx; Mon, 27 Oct 2025 01:52:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vDG9M-0006lA-Jq
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 01:52:12 -0400
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vDG9K-0002DL-PF
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 01:52:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1761544331; x=1793080331;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=dgAPBuZx390lqBcklwscubjP06yyRgvQZJEJVOUVjyE=;
 b=Hv7iQD12R1xppx3pBhGwDSDGyjigPwK6y0U5D51JNLQHycyRqEh01Bo7
 4VUiJ+yIiJw7Rv1z5YGOM1PJLgP7ukwM/NwvMhkkx5dfALPtWF+6LUwpe
 5S3rj7z+THLSkChkS1obJDwx5DJza8PIqvSGsqbqBw3exxQ0Apu0PW890
 yCTNB2KskOsxXels/K59jazHMHzX6R+B+bzejQ90g4biyzyDgPIYAQK+a
 7EKVvo1V6g/KrFbXvwjFKgYgQuLzuIzuTt0D4+LF1GkKdHzs37G8hdsT9
 1CmRtrPYE9BjITI0rNxJCfodkuUk5mKuN4A9MMArAojpenhLeIenGWVed w==;
X-CSE-ConnectionGUID: gJPTmy9YQyO8cVf41o3clQ==
X-CSE-MsgGUID: 7CM8YGCHS6KLlMEhgzxcEw==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="74962254"
X-IronPort-AV: E=Sophos;i="6.19,258,1754982000"; d="scan'208";a="74962254"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Oct 2025 22:52:08 -0700
X-CSE-ConnectionGUID: VrN7U0npQICatud3JgfV7w==
X-CSE-MsgGUID: KmH8iI2CTwiQc8cJFi1Zzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,258,1754982000"; d="scan'208";a="184178451"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa010.jf.intel.com with ESMTP; 26 Oct 2025 22:52:07 -0700
Date: Mon, 27 Oct 2025 14:14:16 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Ewan Hai <ewanhai-oc@zhaoxin.com>
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org, ewanhai@zhaoxin.com,
 cobechen@zhaoxin.com
Subject: Re: [PATCH 3/3] target/i386: Introduce Zhaoxin Shijidadao-Server CPU
 model
Message-ID: <aP8NuLzItpNzt6DJ@intel.com>
References: <20250923021133.190725-1-ewanhai-oc@zhaoxin.com>
 <20250923021133.190725-4-ewanhai-oc@zhaoxin.com>
 <aPsnqxDZR4KxgcdN@intel.com>
 <53c9af0b-49e2-4ec3-8846-01d44b2a9745@zhaoxin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <53c9af0b-49e2-4ec3-8846-01d44b2a9745@zhaoxin.com>
Received-SPF: pass client-ip=192.198.163.10; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

> >> In QEMU, vCPU models default to '.version = 1'. Since there is currently
> >> no '.features[index]' mapping for the "x-force-cpuid-0x1f" property, this
> >> patch adds that property to the v1 version of the model.
> > 
> > I'm preparing the CPU model for Diamond Rapids, and also meet this
> > issue.
> > 
> > Well, I happen to have a patch for this and I think you could give it
> > a try. :)
> 
> That's good news. I'll test your patch and update mine accordingly.
> When I send out v2, should I note in the cover letter that my patches are based
> on your "0x1f option" patch?

Please feel free to pick that patch into your series.

Regards,
Zhao



