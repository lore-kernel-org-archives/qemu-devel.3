Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38000C54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 15:08:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk3jH-0007ya-VH; Tue, 12 Mar 2024 11:07:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rk3iz-0007uN-20; Tue, 12 Mar 2024 11:07:30 -0400
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rk3is-0004Xb-I9; Tue, 12 Mar 2024 11:07:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1710256043; x=1741792043;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=JJHrut3RgQDlSlARJA5yiTl15Q854TbQpnkeEm5rWbY=;
 b=hF1aLLqIVuNMma3G15KrMbqSRUZdsjbFgKeSathc1uu4rUYN5+Vtimnv
 uvwV7hjw1suJQTW/6sR1EWZMzRevigDUwBkt6RrGEZVWPWDmSBUA5hC1b
 8bKaan/Qy+L0yB0xvaIBndJ9rdZ+tYTaLcf3QyP5ofEdCVKSliepL9zj+
 xScpPm+TvrRFfUqUpVzO0kyICXO1HtUtM307/m/BKhxohOprdUT9skmGY
 Ams0jziw1c9fdSF3SbMMrF8LNVfm1vX//tDTsJ0pZHMMKELp16Lsv2VIC
 RWkO634N1Y79XEmSdWJPCkHTCaQbh7FXC1ETpNH/5OVlF5GC4HXtVwtki Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11011"; a="22488782"
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; d="scan'208";a="22488782"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Mar 2024 08:07:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; d="scan'208";a="16223157"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa003.jf.intel.com with ESMTP; 12 Mar 2024 08:07:15 -0700
Date: Tue, 12 Mar 2024 23:21:04 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, qemu-block@nongnu.org,
 philmd@linaro.org
Subject: Re: [PATCH 07/10] qapi: Inline and remove
 QERR_INVALID_PARAMETER_TYPE definition
Message-ID: <ZfBy4LKRR24pCIYc@intel.com>
References: <20240312141343.3168265-1-armbru@redhat.com>
 <20240312141343.3168265-8-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240312141343.3168265-8-armbru@redhat.com>
Received-SPF: pass client-ip=192.198.163.8; envelope-from=zhao1.liu@intel.com;
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

On Tue, Mar 12, 2024 at 03:13:40PM +0100, Markus Armbruster wrote:
> Date: Tue, 12 Mar 2024 15:13:40 +0100
> From: Markus Armbruster <armbru@redhat.com>
> Subject: [PATCH 07/10] qapi: Inline and remove QERR_INVALID_PARAMETER_TYPE
>  definition
> 
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> 
> Address the comment added in commit 4629ed1e98
> ("qerror: Finally unused, clean up"), from 2015:
> 
>   /*
>    * These macros will go away, please don't use
>    * in new code, and do not add new ones!
>    */
> 
> Manual changes (escaping the format in qapi/visit.py).
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  include/qapi/qmp/qerror.h | 3 ---
>  qom/object.c              | 4 ++--
>  scripts/qapi/visit.py     | 5 ++---
>  3 files changed, 4 insertions(+), 8 deletions(-)
>

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


