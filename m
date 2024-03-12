Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0B04C54E5D
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 15:05:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk3g8-0005O2-Qz; Tue, 12 Mar 2024 11:04:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rk3g6-0005Mz-Pq; Tue, 12 Mar 2024 11:04:30 -0400
Received: from mgamail.intel.com ([198.175.65.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rk3g4-0003wS-B5; Tue, 12 Mar 2024 11:04:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1710255868; x=1741791868;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=zKVu4CIIFGU5Pv0k8/n8uDFwylm40wNiRfakYrrfwEI=;
 b=RjMSxj0rEjTGQUhaEkAtqq3lmaEcxfgkUvnwM7CQzHeR9XEZ57YU4wRh
 w0wFnuB+E7ReZ1LS/be5rwLWbStIcLYshh5KbQEpt3hTa8HHiRP+LGExC
 eF+DTNhLNUV/j50Peeha/WSbSC6l8uIfqgKJDftaZ03SJm0EBeBij1MNj
 QWz74Gwo6zLDzO0LUvNPUk1Zz/MHa0ylb97grqYILGHMngHuqE3/0UgL0
 bVsrgBqHuiAnSrR9QZrsX3xSnmtMiGCPsURhL1ztraxR/LT1aVDO14W9a
 0Ffc6Y7C+Rl17uVJ37r/SmDwRi5euktpW5cHqEX6MwBgDq0cbEZbMs59z g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11011"; a="8785603"
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="8785603"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Mar 2024 08:04:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; d="scan'208";a="16134554"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa003.fm.intel.com with ESMTP; 12 Mar 2024 08:04:22 -0700
Date: Tue, 12 Mar 2024 23:18:11 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, qemu-block@nongnu.org,
 philmd@linaro.org
Subject: Re: [PATCH 06/10] qapi: Inline QERR_INVALID_PARAMETER_TYPE
 definition (constant value)
Message-ID: <ZfByM/+eJYxHsIbm@intel.com>
References: <20240312141343.3168265-1-armbru@redhat.com>
 <20240312141343.3168265-7-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240312141343.3168265-7-armbru@redhat.com>
Received-SPF: pass client-ip=198.175.65.15; envelope-from=zhao1.liu@intel.com;
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

On Tue, Mar 12, 2024 at 03:13:39PM +0100, Markus Armbruster wrote:
> Date: Tue, 12 Mar 2024 15:13:39 +0100
> From: Markus Armbruster <armbru@redhat.com>
> Subject: [PATCH 06/10] qapi: Inline QERR_INVALID_PARAMETER_TYPE definition
>  (constant value)
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
> Mechanical transformation using the following
> coccinelle semantic patch:
> 
>     @match@
>     expression errp;
>     expression param;
>     constant value;
>     @@
>          error_setg(errp, QERR_INVALID_PARAMETER_TYPE, param, value);
> 
>     @script:python strformat depends on match@
>     value << match.value;
>     fixedfmt; // new var
>     @@
>     fixedfmt = f'"Invalid parameter type for \'%s\', expected: {value[1:-1]}"'
>     coccinelle.fixedfmt = cocci.make_ident(fixedfmt)
> 
>     @replace@
>     expression match.errp;
>     expression match.param;
>     constant match.value;
>     identifier strformat.fixedfmt;
>     @@
>     -    error_setg(errp, QERR_INVALID_PARAMETER_TYPE, param, value);
>     +    error_setg(errp, fixedfmt, param);
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  qapi/qobject-input-visitor.c | 32 ++++++++++++++++----------------
>  qapi/string-input-visitor.c  |  8 ++++----
>  qom/object.c                 | 12 ++++++++----
>  3 files changed, 28 insertions(+), 24 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


