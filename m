Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B30D7C54E5D
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 15:09:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk3kG-0001T4-E5; Tue, 12 Mar 2024 11:08:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rk3kE-0001IU-LK; Tue, 12 Mar 2024 11:08:46 -0400
Received: from mgamail.intel.com ([198.175.65.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rk3kD-0004sa-0I; Tue, 12 Mar 2024 11:08:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1710256125; x=1741792125;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=+5C3cUv2bFjTqCAepXmS5VleIqVI7+f/V/tKu6SvWWI=;
 b=ayt2aY9Mm4e11j0oSKJvsROj1GhFpJ/KxTISfjfUY0o5I2EZ1NOWOOMb
 VPfhOgVXjhwy2suSx6eg8Middi6hUAOgjWXQFfMIzOgNUgfEFWKc71Tgc
 K+EPpMiJVhmr4mvbDke/X2q4fZAUmDz2RtvIgT9CClS43CRc9NkQV8tMs
 8dY3FJY39dujOSsPuBhTyjOE++PiFwos1SUW5gvsmP88zSaQCmiiIdtyA
 oR7qYmrDDVNVaDd2BEcBL93geTnhrfi85ME5mX62X0mO5WtYmL1dUNsOJ
 xRq2PEhTdcOMz6vkV+6VOz16vqo9LxOixypAkEgLeq3+quhud4ktEre49 Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11011"; a="5102182"
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="5102182"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Mar 2024 08:08:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; d="scan'208";a="11530110"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa010.jf.intel.com with ESMTP; 12 Mar 2024 08:08:41 -0700
Date: Tue, 12 Mar 2024 23:22:29 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, qemu-block@nongnu.org,
 philmd@linaro.org
Subject: Re: [PATCH 10/10] qapi: Inline and remove QERR_PROPERTY_VALUE_BAD
 definition
Message-ID: <ZfBzNQUwUr/+vrN/@intel.com>
References: <20240312141343.3168265-1-armbru@redhat.com>
 <20240312141343.3168265-11-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240312141343.3168265-11-armbru@redhat.com>
Received-SPF: pass client-ip=198.175.65.17; envelope-from=zhao1.liu@intel.com;
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

On Tue, Mar 12, 2024 at 03:13:43PM +0100, Markus Armbruster wrote:
> Date: Tue, 12 Mar 2024 15:13:43 +0100
> From: Markus Armbruster <armbru@redhat.com>
> Subject: [PATCH 10/10] qapi: Inline and remove QERR_PROPERTY_VALUE_BAD
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
> Manual change. Remove the definition in
> include/qapi/qmp/qerror.h.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  include/qapi/qmp/qerror.h | 3 ---
>  hw/core/qdev-properties.c | 3 +--
>  2 files changed, 1 insertion(+), 5 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


