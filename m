Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C099C61DD6
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 12:39:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1kFZ-0002xi-SD; Wed, 02 Sep 2026 08:39:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1x1kFY-0002uG-0T
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 08:39:32 -0400
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1x1kFW-0007Wy-Dq
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 08:39:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788352770; x=1819888770;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=PSxZcwZZ8LUd29wdb4Q6M5PwFfcGpulctdIJEEKex5g=;
 b=fLRS9SXO7kZ228OnO5P2pzzX2cinqjxl0ryFqyW+nLnMEeJCJPZFKN1b
 5XVSuW58hhJ7JIo7+p04k0lG+KoIogl/ULTIg5hH99nYs1g7cyw7mrsac
 HoaxzR72ycQdl6uSON8xBBjCn+mKRZVoR21T4cmeaDqgTAjJISnebgibb
 A9iGZq47SsqNQEy9QCN5XJqUNmYiJ7n4PA/DHcjGF51A2lM2szMNuJEDE
 pQEjqZWkqSuNh5p0LRxnw3pMCMgsGf6HJargCrNShrH9WYXoecI/y/XRJ
 teddGYTA4YHVhUebIZWiz2jco7ROs1dJ0XKpGMiBzRzgzCpyF70pgxsTR Q==;
X-CSE-ConnectionGUID: x9p6haaZSRKN9xPE+lUjBw==
X-CSE-MsgGUID: IRi0FY36Qzat5Q0qxjcKcw==
X-IronPort-AV: E=McAfee;i="6800,10657,11893"; a="99142578"
X-IronPort-AV: E=Sophos;i="6.25,257,1779174000"; d="scan'208";a="99142578"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Sep 2026 05:39:28 -0700
X-CSE-ConnectionGUID: kN9256K5TTmjmWgGAXSeCA==
X-CSE-MsgGUID: qdy8jhzeR4+0w1Y7Kvi85w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,257,1779174000"; d="scan'208";a="265096232"
Received: from zhaoliu1-desk.sh.intel.com (HELO localhost) ([10.238.208.118])
 by fmviesa006.fm.intel.com with ESMTP; 02 Sep 2026 05:39:26 -0700
Date: Wed, 2 Sep 2026 20:39:25 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Ewan Hai-oc <ewanhai-oc@zhaoxin.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, ewanhai@zhaoxin.com,
 cobechen@zhaoxin.com
Subject: Re: [PATCH v4 4/4] target/i386: Enable new cryptographic features in
 YongFeng-v4
Message-ID: <apgY/fK8Pi8X1oft@intel.com>
References: <20260826084838.2107629-1-ewanhai-oc@zhaoxin.com>
 <20260826084838.2107629-5-ewanhai-oc@zhaoxin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260826084838.2107629-5-ewanhai-oc@zhaoxin.com>
Received-SPF: pass client-ip=198.175.65.11; envelope-from=zhao1.liu@intel.com;
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

On Wed, Aug 26, 2026 at 04:48:38PM +0800, Ewan Hai-oc wrote:
> Date: Wed, 26 Aug 2026 16:48:38 +0800
> From: Ewan Hai-oc <ewanhai-oc@zhaoxin.com>
> Subject: [PATCH v4 4/4] target/i386: Enable new cryptographic features in
>  YongFeng-v4
> X-Mailer: git-send-email 2.34.1
> 
> Add YongFeng-v4 with the SM2, CCS, RNG2, PHE2 and RSA feature pairs
> enabled.
> 
> Link: https://lore.kernel.org/all/20260610023512.3690734-1-ewanhai-oc@zhaoxin.com/
> Signed-off-by: Ewan Hai <ewanhai-oc@zhaoxin.com>
> ---
>  target/i386/cpu.c | 22 ++++++++++++++++++----
>  1 file changed, 18 insertions(+), 4 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


