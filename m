Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DECBC5DF97
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 09:12:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wz9fU-0005zy-L8; Wed, 26 Aug 2026 05:11:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1wz9fT-0005zm-9T; Wed, 26 Aug 2026 05:11:35 -0400
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1wz9fR-0005LD-HR; Wed, 26 Aug 2026 05:11:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787735494; x=1819271494;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=enulYgN4bOHFj18b/dPnpcvAtknFGQvdJtJcUnxHILY=;
 b=EpUfg9MChzhBBjPGzOkrXJCRDaTqLu2rZbUguPJTrgyIVBMG5X+7hH/y
 Htp4tMB+oNHag883fOnI5drgBMTgmvfZjSgnpO/YZax/7dBrkhNTZKXn6
 PolhJ2OYREN/Jgxez9FvqyaNQg3hX/Znrse9nxTZiF1dpSaGcvxK8jAdP
 +NpZ/dAJq4GFQv1x/7An3/+ZLe6IHDp0hqlXVBJ19rYazdvTW9PfMntWv
 HaAUxprhLrgE8MX283rDQBD2Qvr4DFZxCfb3c1OufLl22kGdwKRPpLhn9
 gO6xJ1vGYq1OKs99FgpJvGC5efx63uwjyhofr/PzTuHjQtosQiBicu0/E Q==;
X-CSE-ConnectionGUID: jFARUMOSSjeZSXbHzL2Pjg==
X-CSE-MsgGUID: wmUIgxBIRsiuAifQHiGnlQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11886"; a="105736488"
X-IronPort-AV: E=Sophos;i="6.25,244,1779174000"; d="scan'208";a="105736488"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Aug 2026 02:11:28 -0700
X-CSE-ConnectionGUID: QPahd9U1QYmmsjP+gBhDGw==
X-CSE-MsgGUID: /vkprnWlSWucL+0J7komGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,244,1779174000"; d="scan'208";a="292379615"
Received: from zhaoliu1-desk.sh.intel.com (HELO localhost) ([10.238.208.118])
 by fmviesa001.fm.intel.com with ESMTP; 26 Aug 2026 02:11:27 -0700
Date: Wed, 26 Aug 2026 17:11:26 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
Subject: Re: [PATCH 8/9] scripts: rename get-wraps-from-cargo-registry.py
Message-ID: <ao6tvhi/tOx2P+e7@intel.com>
References: <20260821083925.2008135-1-pbonzini@redhat.com>
 <20260821083925.2008135-9-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260821083925.2008135-9-pbonzini@redhat.com>
Received-SPF: pass client-ip=192.198.163.8; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On Fri, Aug 21, 2026 at 10:39:23AM +0200, Paolo Bonzini wrote:
> Date: Fri, 21 Aug 2026 10:39:23 +0200
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 8/9] scripts: rename get-wraps-from-cargo-registry.py
> X-Mailer: git-send-email 2.55.0
> 
> It does more than that now.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  .../{get-wraps-from-cargo-registry.py => update-cargo-wraps.py}   | 0
>  1 file changed, 0 insertions(+), 0 deletions(-)
>  rename scripts/{get-wraps-from-cargo-registry.py => update-cargo-wraps.py} (100%)

Just a nit, these places were missed ;).

$ grep -nr get-wraps-from-cargo-registry.py
MAINTAINERS:3780:F: scripts/get-wraps-from-cargo-registry.py
scripts/update-cargo-wraps.py:6:get-wraps-from-cargo-registry.py - Update Meson subprojects from a Cargo
docs/about/build-platforms.rst:131:  script, ``scripts/get-wraps-from-cargo-registry.py``, that automatically


