Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 221D5C02181
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2025 16:21:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tZuWe-0002gU-Mn; Mon, 20 Jan 2025 11:21:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tZuWb-0002fz-GI; Mon, 20 Jan 2025 11:21:17 -0500
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tZuWY-0005ZK-Up; Mon, 20 Jan 2025 11:21:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1737390075; x=1768926075;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=+iTxf/rzsT6x3RpKtv9b2/5/o8XDPL4U6LuZ9aV5Js4=;
 b=lsZcmPC/hpT+juXSi0KlQUgLd2f7MvqVhPX+zLTcFcvX9noebcN2yqVq
 rPvZqSKe89CRZPFVoPf9c0prFOrt1bjw1MkAaBGX63zxxGnmrwD9j9eVF
 Hswi3qXgAIq4RfYyf3fGZ53ztEbPTJWiCcAqwO7T2QPAQEi1Zcx94dlh2
 RsuXmWH2jD6zI+808tDhO5Y0WBnRo6kLG4U/iUigceXQKg1vEK3YrHCp3
 Gj5VrQbAQ+bOwAtojUAlQ78WCXSbMeIJygdKw3qjKoGldsKwQ9c6qRWRB
 BhU1CusRwuKBMdo0pHhAEPueRje+6Vjc38lRDKoN0MchgSqEXVxy/BI/Q g==;
X-CSE-ConnectionGUID: go3K4oSiRd69jNs4rLjISg==
X-CSE-MsgGUID: vcGFiHhKREubZjKt1OHdEw==
X-IronPort-AV: E=McAfee;i="6700,10204,11321"; a="37946643"
X-IronPort-AV: E=Sophos;i="6.13,219,1732608000"; d="scan'208";a="37946643"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jan 2025 08:21:12 -0800
X-CSE-ConnectionGUID: vC5L1ANbSRqcgqs0rvhEOw==
X-CSE-MsgGUID: z2CXwILhSni7aeN+Df3P+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,219,1732608000"; d="scan'208";a="106498554"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa007.fm.intel.com with ESMTP; 20 Jan 2025 08:21:11 -0800
Date: Tue, 21 Jan 2025 00:40:04 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
Subject: Re: [PATCH 01/10] rust: qemu-api: add sub-subclass to the
 integration tests
Message-ID: <Z458ZAMFg7aOKSVu@intel.com>
References: <20250117194003.1173231-1-pbonzini@redhat.com>
 <20250117194003.1173231-2-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250117194003.1173231-2-pbonzini@redhat.com>
Received-SPF: pass client-ip=198.175.65.16; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -73
X-Spam_score: -7.4
X-Spam_bar: -------
X-Spam_report: (-7.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-3,
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

On Fri, Jan 17, 2025 at 08:39:54PM +0100, Paolo Bonzini wrote:
> Date: Fri, 17 Jan 2025 20:39:54 +0100
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 01/10] rust: qemu-api: add sub-subclass to the integration
>  tests
> X-Mailer: git-send-email 2.47.1
> 
> From: Zhao Liu <zhao1.liu@intel.com>
> 
> missing signed-off-by from zhao

Thanks a lot!

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>

> ---
>  rust/qemu-api/tests/tests.rs | 56 ++++++++++++++++++++++++++++++++++--
>  1 file changed, 53 insertions(+), 3 deletions(-)
> 

