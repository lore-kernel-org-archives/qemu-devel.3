Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89F95C54E5D
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 14:52:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk3UN-0004ZY-NT; Tue, 12 Mar 2024 10:52:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rk3UJ-0004Qn-5Q; Tue, 12 Mar 2024 10:52:19 -0400
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rk3U9-0001iG-6Z; Tue, 12 Mar 2024 10:52:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1710255129; x=1741791129;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=lDWM2FfxXBXMH53kKBnxakVPcpbq+vdHWHLhQQkXZ7E=;
 b=WJpunZ/wpJPjsR9KNdChveblGvbD8PkhB/V1EGHERh/t92vZ+gMq4mpL
 E4EXRG6MmUtSwBeoajQwFp2GGE0CkkXSTY3lMq41vY4/oaNyCZI14TwfL
 X/wPfBiD5DQTMZunrz4Xs82+Gy9ipkVPvstZSHY5LJ6Htf7I9ssAOLkDR
 UUgqmlpyMEswhmmKGofdNtM2PRrJsIQVyZ3FBB1zCNTfg1aFI6eRi1nc+
 +ckZi4u3zZ6AL+eSPTRZ763TK/PGaYDHx9l6smnA+rJb0fmDIaZyiiOvb
 CW9LrTuc6HqYIrbZfwNCEggpYjwhOZ+oXT0a6hWQ/jWW8FdD3Ocbnx0Ll w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11011"; a="27440755"
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; d="scan'208";a="27440755"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Mar 2024 07:51:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; d="scan'208";a="16219037"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa003.jf.intel.com with ESMTP; 12 Mar 2024 07:51:56 -0700
Date: Tue, 12 Mar 2024 23:05:44 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, qemu-block@nongnu.org,
 philmd@linaro.org
Subject: Re: [PATCH 01/10] error: Drop superfluous #include "qapi/qmp/qerror.h"
Message-ID: <ZfBvSMlvfTPJdepi@intel.com>
References: <20240312141343.3168265-1-armbru@redhat.com>
 <20240312141343.3168265-2-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240312141343.3168265-2-armbru@redhat.com>
Received-SPF: pass client-ip=198.175.65.9; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Tue, Mar 12, 2024 at 03:13:34PM +0100, Markus Armbruster wrote:
> Date: Tue, 12 Mar 2024 15:13:34 +0100
> From: Markus Armbruster <armbru@redhat.com>
> Subject: [PATCH 01/10] error: Drop superfluous #include "qapi/qmp/qerror.h"
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  backends/iommufd.c | 1 -
>  chardev/char-fe.c  | 1 -
>  system/rtc.c       | 1 -
>  3 files changed, 3 deletions(-)
> 

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
 

