Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7313DC87FCB
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Aug 2025 07:13:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukHH0-0003uS-TY; Fri, 08 Aug 2025 03:12:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1ukHGu-0003rV-ML; Fri, 08 Aug 2025 03:12:12 -0400
Received: from mgamail.intel.com ([192.198.163.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1ukHGr-0006XB-CG; Fri, 08 Aug 2025 03:12:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1754637130; x=1786173130;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=CteLYT6wRcET5ARdrmT6cgT1SUnvYhbhxg3VKlmkq1Q=;
 b=dK0w3G60P/dWn7guGQ/xLetGsJLABgXY1SuhWWcy3IukxYsr5Iiu64HL
 N030RjBXje4rLktoUtzB68QRIpcLByryOHmmiudZzUcYRuPIf9QD+YeKk
 0rXOzcr1M0ZnJescic7bfNzB1fd+N986d6BIhyfB20vphSy/sgxkrzbXx
 lWZ+57OtDfrxmuDd1GvgwtxjciH8vQT0ljRA6Ilyl2U1LabiWwJLAFzVH
 nGJCZpwNjklpFJA1sjsn4N9YVyETtlnKj5VGMCY/OKGgl7TKGblP5uMo0
 wDaHuu2PmBskPGEmlTSDhUWXH7NqhtoV2zU9zDyL4iA88qsbZExkbm4Jg Q==;
X-CSE-ConnectionGUID: uniNsfBjSyG+eiLOTh7XrA==
X-CSE-MsgGUID: gml+mj0oQhu+gBWHZCJuGw==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="60789887"
X-IronPort-AV: E=Sophos;i="6.17,274,1747724400"; d="scan'208";a="60789887"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Aug 2025 00:12:03 -0700
X-CSE-ConnectionGUID: VWuqEdMNQfKdDt3CcwzLww==
X-CSE-MsgGUID: N5CijSIoRVe/Bqgg0ZHIiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,274,1747724400"; d="scan'208";a="170513367"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa004.fm.intel.com with ESMTP; 08 Aug 2025 00:12:00 -0700
Date: Fri, 8 Aug 2025 15:33:39 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Junjie Mao <junjie.mao@hotmail.com>,
 qemu-devel@nongnu.org, qemu-rust@nongnu.org,
 Dapeng Mi <dapeng1.mi@linux.intel.com>,
 Chuanxiao Dong <chuanxiao.dong@intel.com>
Subject: Re: [RFC 07/26] subprojects: Add winapi crate
Message-ID: <aJWoUwDK9It+gSZv@intel.com>
References: <20250807123027.2910950-1-zhao1.liu@intel.com>
 <20250807123027.2910950-8-zhao1.liu@intel.com>
 <c7e99d14-eccc-4e97-8b11-1342fe0c5aa6@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c7e99d14-eccc-4e97-8b11-1342fe0c5aa6@redhat.com>
Received-SPF: pass client-ip=192.198.163.12; envelope-from=zhao1.liu@intel.com;
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

On Thu, Aug 07, 2025 at 03:17:52PM +0200, Paolo Bonzini wrote:
> Date: Thu, 7 Aug 2025 15:17:52 +0200
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: Re: [RFC 07/26] subprojects: Add winapi crate
> 
> On 8/7/25 14:30, Zhao Liu wrote:
> > Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> 
> I created https://github.com/rust-vmm/vm-memory/pull/335 so this is not
> needed.

Nice! This is better than what I had previously considered for fixing
Windows compilation. Thanks.

-Zhao


