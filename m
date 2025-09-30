Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB094CAC5B8
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 08:35:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3Vom-0006G3-6H; Tue, 30 Sep 2025 04:34:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1v3Voi-0006FR-JN; Tue, 30 Sep 2025 04:34:36 -0400
Received: from mgamail.intel.com ([192.198.163.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1v3VoS-0004Lj-KM; Tue, 30 Sep 2025 04:34:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1759221261; x=1790757261;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=XCYBHdWFnAHJy2lZ8v6AJlWDsa9aJoHiYZLd17M0hqM=;
 b=kPtZvpLT0/5DqeH8QewuaJ2moddDRrvd9e61hWA3tuBWhh1QMp80tJ/t
 WmBGVX3d6+NjUfyHgY18drrlWwsRhrlwWZj0cRsiphB6nAs0UbysMwvfu
 rDgacVN66kZ0fnU0EN7roRmv29euTKuQNotKkHCeWUO+f31HDTjOneKG+
 Eelu/o901ky8zyvadcC0F5BH04sdw7h9xNJg2CVxHs/y/57ZN1N39GYRR
 lkL7HZAapjJIM/zcZDSop53v2V5fcePXz4eJ1Pc6oaTXj3Ck4VTF7hjE7
 ocWPVMTE/0tcx14SGP3xMMUxiCBjM4vpwyLnylcVBIvKyOex2VjZcrMzx A==;
X-CSE-ConnectionGUID: sOwwAd1YSMmecn+W8hDSAQ==
X-CSE-MsgGUID: cUeWuCaJTl+xaN6AQgIFjA==
X-IronPort-AV: E=McAfee;i="6800,10657,11568"; a="49033833"
X-IronPort-AV: E=Sophos;i="6.18,303,1751266800"; d="scan'208";a="49033833"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Sep 2025 01:34:12 -0700
X-CSE-ConnectionGUID: XHA0BA5/Swivmjq9zSNGaQ==
X-CSE-MsgGUID: 0iRrWZ0MQSC3N0Apu2+bRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,303,1751266800"; d="scan'208";a="209421370"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa001.fm.intel.com with ESMTP; 30 Sep 2025 01:34:11 -0700
Date: Tue, 30 Sep 2025 16:56:10 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 qemu-devel@nongnu.org, qemu-rust@nongnu.org
Subject: Re: [PATCH] subprojects: Update .gitignore for syn
Message-ID: <aNubKjqYulKoLJ6q@intel.com>
References: <20250930075351.1853721-1-zhao1.liu@intel.com>
 <aNuP98uhOzOd5glp@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aNuP98uhOzOd5glp@redhat.com>
Received-SPF: pass client-ip=192.198.163.16; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.513,
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

> IMHO we should get rid of all the version numbers, and use wildcard
> matches instead, to eliminate the bug scenario entirely, as people
> will repeatedly forgot to change these versions.

(Manos had the similar comment before.) 

My thought is that exact matching could help identify outdated
subprojects, notifying developers to clean them up and free up a little
local space?

Regrads,
Zhao


