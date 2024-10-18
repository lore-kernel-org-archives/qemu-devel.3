Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79B0CD2FFE3
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2024 10:01:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1jn7-0005Fg-Hf; Fri, 18 Oct 2024 06:01:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t1jn5-0005FI-Hc
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 06:01:03 -0400
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t1jn4-0003g9-0o
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 06:01:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1729245662; x=1760781662;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=5ufCzBdmKPj60fl5mufwTvDv/tqBFn2MI7Lp8YJsNZU=;
 b=XqAQsZGcJ4lsq2L6Ch5wv5e8f+toDJaywh0A7N9SUFglMkOHJjzeXPqI
 UnoYX59pfY1g7SSE9YBG/fhzQJZLNQ70XA5P0Gfk4MyPz3LL8MGJPV2YT
 oXUlq5FThEA3hayoNvN6OtGPutgSID1+gqPdfdQqLJJjaM+BUpQ5w2xfk
 6n+SzGsaYrOJ0A1vj14vngvOxjTDYlArFU9HcDu7FdzQxyD/V/ntRlSym
 QnZ7sJP+SnZhpRd5wbmYnbBEUPtUIgPU8Os9bU374FApeDqDzjMSAn/2e
 DMwQUkvKYDgSsHwGLw7Frl5TdKZ0WeEzBaRpjcjVqLkgqwkrHEEIfzh/a A==;
X-CSE-ConnectionGUID: DLK7dIWuQOuOpFdN8kYZVA==
X-CSE-MsgGUID: 0iifwqznRuSsZIB2lL3bEw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="28874479"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; d="scan'208";a="28874479"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Oct 2024 03:01:01 -0700
X-CSE-ConnectionGUID: OcTKzu2NSdyC2Y11Rr0u+Q==
X-CSE-MsgGUID: c6WGjDT6T4qTmahEKd3k9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,213,1725346800"; d="scan'208";a="83461282"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa004.fm.intel.com with ESMTP; 18 Oct 2024 03:00:59 -0700
Date: Fri, 18 Oct 2024 18:17:15 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v2 31/31] system: remove unused qerror.h header
Message-ID: <ZxI1q0ucLSSo0Ijc@intel.com>
References: <20241017113344.883424-1-berrange@redhat.com>
 <20241017113344.883424-32-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241017113344.883424-32-berrange@redhat.com>
Received-SPF: pass client-ip=198.175.65.16; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.068,
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

Hi Daniel,

On Thu, Oct 17, 2024 at 12:33:43PM +0100, Daniel P. Berrangé wrote:
> Date: Thu, 17 Oct 2024 12:33:43 +0100
> From: "Daniel P. Berrangé" <berrange@redhat.com>
> Subject: [PATCH v2 31/31] system: remove unused qerror.h header
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>  system/rtc.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/system/rtc.c b/system/rtc.c
> index e3bc2095f9..216d2aee3a 100644
> --- a/system/rtc.c
> +++ b/system/rtc.c
> @@ -25,7 +25,6 @@
>  #include "qemu/osdep.h"
>  #include "qemu/cutils.h"
>  #include "qapi/error.h"
> -#include "qapi/qmp/qerror.h"
>  #include "qemu/error-report.h"
>  #include "qemu/option.h"
>  #include "qemu/timer.h"
> -- 
> 2.46.0
> 

Ah, this qerror.h is added by patch 23 accidentally.

Regards,
Zhao


