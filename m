Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97AEAC369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 15:22:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7FRk-0003Nk-Mo; Tue, 22 Apr 2025 11:22:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1u7FRh-0003Me-LE
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 11:22:02 -0400
Received: from mgamail.intel.com ([192.198.163.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1u7FRc-0000Iz-VX
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 11:22:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1745335317; x=1776871317;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=sTE8M4Y2S4Pb9ckTIDo7DkjKh+sAIl66MjnAQIrYd9o=;
 b=WrJBsmzYewCloiFp04p/ewJkEnUk+PyHTJN2MMQ06hn47M/hgcm5GeGz
 q1Z8W5+bDV5VFj95JyZCrET09j360iev5m5H+grXysknkV2XIQzIPBoOt
 8hqZFzNIShRh4aI58PmeQO/TX1vuvKo4FXVAaOsK9cq9WbVg7VMjWNYre
 AJSt/E9cvnIKipou3M8/FjRYOEbvScniQyK8vPeIa8qnCkh0Mn8enpC2o
 C46T/Prb7lB56kn/Rbfz47OQcKCu7qYtO8oaWSCoL8TXW74PN3vMWxI7I
 VtnSpO6XWpCGA2X80PuzgybQBqIJ3bVORV4DvbG+wbYbF1gFZl92X97HK Q==;
X-CSE-ConnectionGUID: 9znbkgjKTXCY+Shs7LzFnw==
X-CSE-MsgGUID: JW/sRSmYTgWM1kxfGry/Kg==
X-IronPort-AV: E=McAfee;i="6700,10204,11411"; a="46018204"
X-IronPort-AV: E=Sophos;i="6.15,231,1739865600"; d="scan'208";a="46018204"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Apr 2025 08:21:53 -0700
X-CSE-ConnectionGUID: t3oCLPuRT+aPS23a8JAk4w==
X-CSE-MsgGUID: S8AjcWI0RMaLqo4fsxQ8Lg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,231,1739865600"; d="scan'208";a="132997944"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa008.jf.intel.com with ESMTP; 22 Apr 2025 08:21:51 -0700
Date: Tue, 22 Apr 2025 23:42:46 +0800
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
Message-ID: <aAe49odpsz108aZb@intel.com>
References: <20250401130205.2198253-1-xiaoyao.li@intel.com>
 <20250401130205.2198253-14-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=gb2312
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250401130205.2198253-14-xiaoyao.li@intel.com>
Received-SPF: pass client-ip=192.198.163.19; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.411,
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

> diff --git a/qapi/qom.json b/qapi/qom.json
> index f229bb07aaec..a8379bac1719 100644
> --- a/qapi/qom.json
> +++ b/qapi/qom.json
> @@ -1060,11 +1060,25 @@
>  #     pages.  Some guest OS (e.g., Linux TD guest) may require this to
>  #     be set, otherwise they refuse to boot.
>  #
> +# @mrconfigid: ID for non-owner-defined configuration of the guest TD,
> +#     e.g., run-time or OS configuration (base64 encoded SHA384 digest).
> +#     Defaults to all zeros.

Maybe a typo? s/Defaults/Default/

> +#
> +# @mrowner: ID for the guest TD¡¯s owner (base64 encoded SHA384 digest).
> +#     Defaults to all zeros.

Ditto.

> +#
> +# @mrownerconfig: ID for owner-defined configuration of the guest TD,
> +#     e.g., specific to the workload rather than the run-time or OS
> +#     (base64 encoded SHA384 digest).  Defaults to all zeros.
> +#
>  # Since: 10.1
>  ##
>  { 'struct': 'TdxGuestProperties',
>    'data': { '*attributes': 'uint64',
> -            '*sept-ve-disable': 'bool' } }
> +            '*sept-ve-disable': 'bool',
> +            '*mrconfigid': 'str',
> +            '*mrowner': 'str',
> +            '*mrownerconfig': 'str' } }
>  

Overall LGTM, (with Daniel's comment fixed,)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>



