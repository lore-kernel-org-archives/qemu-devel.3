Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3249CA5FEE
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Jan 2026 06:40:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhivk-0008GE-SX; Mon, 19 Jan 2026 01:40:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vhivc-0008Dy-BL; Mon, 19 Jan 2026 01:39:56 -0500
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vhivZ-0004Hl-OP; Mon, 19 Jan 2026 01:39:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1768804794; x=1800340794;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=lPXeWH0ivt6gw1JCJFBC/xnC4csFZZNwnsRSzpHyr0w=;
 b=D+bLPU9pYZOzg4weBHu9w+pe2n4qP9Xqeonl4DC+84y0t4POtEt3RPRl
 35lrnhS55uoeA26WnsBBUEWoEYttNoXDOIvOTFhYATnSh8+4pRA85aXwD
 9sPoCDCjqPozcN8IAWi+yUuAQzmOdaxL6vVYusHLza0azBsLr6AKRwr+x
 eWrbVrBRTwu1iyRYr2nss7q+QEIf4V80zWWksz8bnasDP/49sqmpvzbvs
 5mupAtjvpbgPIX0HsdWnRZ8V/alLnkAAo7ZowVQpIOfx6zFntX783VEG7
 E5y6HAEC1nSdwLo05sbO3cT4sXEX0nCCQgnTmC6IWU2uc8FKwH+lpS92X w==;
X-CSE-ConnectionGUID: u5N1flJ+TJKPQ8UphdsbWw==
X-CSE-MsgGUID: NStk9ryRQOy6JJ4IMOBDvQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11675"; a="87427050"
X-IronPort-AV: E=Sophos;i="6.21,237,1763452800"; d="scan'208";a="87427050"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jan 2026 22:39:51 -0800
X-CSE-ConnectionGUID: 5UDmtpScTq6xDvJRE44fyw==
X-CSE-MsgGUID: sZOl5pHIToO5BZyGjHr5yg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,237,1763452800"; d="scan'208";a="243353735"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa001.jf.intel.com with ESMTP; 18 Jan 2026 22:39:50 -0800
Date: Mon, 19 Jan 2026 15:05:20 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 qemu-rust@nongnu.org
Subject: Re: [PATCH v2 11/16] scripts/qapi: pull c_name from camel_to_upper
 to caller
Message-ID: <aW3XsMGCCZB2kFQ+@intel.com>
References: <20260108131043.490084-1-pbonzini@redhat.com>
 <20260108131043.490084-12-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260108131043.490084-12-pbonzini@redhat.com>
Received-SPF: pass client-ip=198.175.65.10; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.077,
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

On Thu, Jan 08, 2026 at 02:10:38PM +0100, Paolo Bonzini wrote:
> Date: Thu,  8 Jan 2026 14:10:38 +0100
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH v2 11/16] scripts/qapi: pull c_name from camel_to_upper to
>  caller
> X-Mailer: git-send-email 2.52.0
> 
> Allow using it for other languages too.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  scripts/qapi/common.py | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


