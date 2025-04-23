Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25D15C369D5
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 12:11:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7Ywg-0003Yc-7Y; Wed, 23 Apr 2025 08:11:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1u7YwG-0002jt-M2
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 08:10:54 -0400
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1u7YwE-00018I-9t
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 08:10:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1745410250; x=1776946250;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=SzjxN7YvnN7dkwK7ta6fQOvuFNswKInEEuv+HCw1lrU=;
 b=Q+DdjMpD3F66sPolzfJRyOwF08S3G6sNgcPmvEbjXYKhp9hBWZr+QF+q
 iUUO6lfRoT5YhvHZB/QyT4hjpkR6agyzhnCcw9xNQwKyDqNChi1Sv90lK
 tF+DID04+TyYPpIHV6dFDR++qWyD48hEd26Xog4cfc+apl1QSyXrSp0wr
 MOm1JOLv31c6r+L1zoscc98qUYD3mKv+HZbZP/83FzY6AptFfDPUYNyN9
 cTOikc8XianaTdPoWdw4/bgim8j8v6QvDvdU/8jEPa8Ass/MAxdQuBqad
 ZSK3cKUFPLffH1mQsg/p+ofXS4YK7CvbCPKBa+PxNbmeEAtFLz7YVeUUX A==;
X-CSE-ConnectionGUID: CpdH5Z7FTRyB9eT8juwZgw==
X-CSE-MsgGUID: llirutb2RMq5fYFajxTSfQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11411"; a="46878450"
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; d="scan'208";a="46878450"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Apr 2025 05:10:47 -0700
X-CSE-ConnectionGUID: X8YOOGGSREuyB7PKmtzNEw==
X-CSE-MsgGUID: aQjXp2F+RXuUPibew2CEaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; d="scan'208";a="136375272"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa003.fm.intel.com with ESMTP; 23 Apr 2025 05:10:43 -0700
Date: Wed, 23 Apr 2025 20:31:38 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Francesco Lavra <francescolavra.fl@gmail.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>
Subject: Re: [PATCH v8 13/55] i386/tdx: Support user configurable
 mrconfigid/mrowner/mrownerconfig
Message-ID: <aAjdqiTY/KNB+KtQ@intel.com>
References: <20250401130205.2198253-1-xiaoyao.li@intel.com>
 <20250401130205.2198253-14-xiaoyao.li@intel.com>
 <aAe49odpsz108aZb@intel.com>
 <e67699a5-8b62-45a0-8cf1-586440ec85ee@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e67699a5-8b62-45a0-8cf1-586440ec85ee@intel.com>
Received-SPF: pass client-ip=192.198.163.17; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.294,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On Wed, Apr 23, 2025 at 04:11:25PM +0800, Xiaoyao Li wrote:
> Date: Wed, 23 Apr 2025 16:11:25 +0800
> From: Xiaoyao Li <xiaoyao.li@intel.com>
> Subject: Re: [PATCH v8 13/55] i386/tdx: Support user configurable
>  mrconfigid/mrowner/mrownerconfig
> 
> On 4/22/2025 11:42 PM, Zhao Liu wrote:
> > > diff --git a/qapi/qom.json b/qapi/qom.json
> > > index f229bb07aaec..a8379bac1719 100644
> > > --- a/qapi/qom.json
> > > +++ b/qapi/qom.json
> > > @@ -1060,11 +1060,25 @@
> > >   #     pages.  Some guest OS (e.g., Linux TD guest) may require this to
> > >   #     be set, otherwise they refuse to boot.
> > >   #
> > > +# @mrconfigid: ID for non-owner-defined configuration of the guest TD,
> > > +#     e.g., run-time or OS configuration (base64 encoded SHA384 digest).
> > > +#     Defaults to all zeros.
> > 
> > Maybe a typo? s/Defaults/Default/
> 
> (It) defaults to all zeros.
> 
> If you grep the "defaults to", you can get a lot of it.

The comment can be relaxed, but please try to be precise with the doc.
You can add the omitted "It".



