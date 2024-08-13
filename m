Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00A34C52D7C
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 09:17:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdneF-0006Js-4j; Tue, 13 Aug 2024 05:16:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sdne7-0006IY-UH; Tue, 13 Aug 2024 05:16:53 -0400
Received: from mgamail.intel.com ([198.175.65.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sdne3-00057j-Lj; Tue, 13 Aug 2024 05:16:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1723540608; x=1755076608;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=8NtQ+m2aKB6iYToa6t7dybTia62yHNGP3KJBraXxCpU=;
 b=fmpxhrHGhIEbm0zhozQMFg32psDfrhg1+0B0LQpXX8nmYCvE3QS5QB3S
 pkAn6yOE+Ln92cOa98i9z43j7UE9Ja1Fbx+ujsdg1FyqwMhbnnWfb/WY9
 K/pt5tGjhmDqbgK6Kj3zfvfodLnvHoWnOKj9KW4aQlvVZAK7aMqA67Jfv
 q/LUq8LU4P2z0R6GuP+Z3sBPj5AhHJGrD9Jol4dWn8lkwFMJ5oB04lQ6m
 St2/mldpsmBYSWjzbBkN+EHdJ3wnpZw922O6rgv/0k+iuIXvGxuJue1wU
 rZyqrsPJWh0pDurV/r4+sXbDBfq+qUrMRYb42iQw/OppXtUP65toxXQdD w==;
X-CSE-ConnectionGUID: a1VfiEX6T/ChsYq/tDhlXQ==
X-CSE-MsgGUID: 8HcbFrRNTIyqloRgfTFiZA==
X-IronPort-AV: E=McAfee;i="6700,10204,11162"; a="21824693"
X-IronPort-AV: E=Sophos;i="6.09,285,1716274800"; d="scan'208";a="21824693"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Aug 2024 02:16:38 -0700
X-CSE-ConnectionGUID: ok7MbNc3QYiteuVonTEdAA==
X-CSE-MsgGUID: ryPaxXe7SMOiwPdyXLvAvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,285,1716274800"; d="scan'208";a="62994836"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa005.fm.intel.com with ESMTP; 13 Aug 2024 02:16:36 -0700
Date: Tue, 13 Aug 2024 17:32:27 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Kamil =?utf-8?Q?Szcz=C4=99k?= <kamil@szczek.dev>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>
Subject: Re: [PATCH] hw/i386/pc: Add a description for the i8042 property
Message-ID: <ZrsoK2XdWIUgd5zN@intel.com>
References: <15fhXFY6x78KW8P5gw0eKTW8kc17zejrJFxqnOyoBy6vw4W9rCmgDhoxssWosWFs_dbFtfsyjn9wpPrV3x8Nlzhy8mTJSEnXCr4qyHAhXSw=@szczek.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <15fhXFY6x78KW8P5gw0eKTW8kc17zejrJFxqnOyoBy6vw4W9rCmgDhoxssWosWFs_dbFtfsyjn9wpPrV3x8Nlzhy8mTJSEnXCr4qyHAhXSw=@szczek.dev>
Received-SPF: pass client-ip=198.175.65.17; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.126,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Mon, Aug 12, 2024 at 05:23:31PM +0000, Kamil Szczęk wrote:
> Date: Mon, 12 Aug 2024 17:23:31 +0000
> From: Kamil Szczęk <kamil@szczek.dev>
> Subject: [PATCH] hw/i386/pc: Add a description for the i8042 property
> 
> While working on exposing the i8042 property in libvirt I noticed that
> the property is missing a description. This adds a simple description
> so that QEMU users don't have to dig in the source code to figure out
> what this option does.
> 
> Signed-off-by: Kamil Szczęk <kamil@szczek.dev>
> ---
>  hw/i386/pc.c | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


