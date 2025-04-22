Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41D3EC369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 14:36:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7EjE-0005Qq-9s; Tue, 22 Apr 2025 10:36:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1u7Eiy-0005OC-Rd
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 10:35:49 -0400
Received: from mgamail.intel.com ([198.175.65.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1u7Eiw-0002k9-VY
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 10:35:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1745332548; x=1776868548;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=rockSBm6e8LPWsjb0m0J68AhC1lgm0+HhnaCQDNSUAc=;
 b=A5Q/U2fTIZlTGhe8tZx3REvlCtoCFYbcQ1yLAX4U/zzFTnejJVq+64AU
 w7lN5tK7vUBxCgk0AvfTVnRE71rOGvGkZdopDxiKASS91WlaleF0pIg4n
 rqcKIp896P5kGBIFXM1aKl75rlzycnTQURBGd+eUoOkyLqLX5bgi2XfkB
 WfLew35MCW0iRWK4rc+2SWZbFBvTkeOvsuHwbfju2PrY4Shz2fBBmtvpv
 /Z/Bf8M87O/PuROszGmRG3HODsdvQqwK0aWTD/I5VLx4Nzlbmgx9q8pPd
 6suW5VaOyOmx+zjIzfbmGyK8hqLZmZG8jjVZo2rDrrHVrLZaJZtbcm6uf w==;
X-CSE-ConnectionGUID: HzfiSn4TSdavs7rwKc6H/w==
X-CSE-MsgGUID: wQt+TV4USRmuSjGYVS4teQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11411"; a="46598558"
X-IronPort-AV: E=Sophos;i="6.15,231,1739865600"; d="scan'208";a="46598558"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Apr 2025 07:35:46 -0700
X-CSE-ConnectionGUID: DOTabLMJQVSkxy9bsX47Hw==
X-CSE-MsgGUID: V8YMdCIIQ3m8v9BrYnlrog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,231,1739865600"; d="scan'208";a="131981827"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa006.jf.intel.com with ESMTP; 22 Apr 2025 07:35:42 -0700
Date: Tue, 22 Apr 2025 22:56:37 +0800
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
Subject: Re: [PATCH v8 09/55] i386/tdx: Add property sept-ve-disable for
 tdx-guest object
Message-ID: <aAeuJeCuEQO3mv27@intel.com>
References: <20250401130205.2198253-1-xiaoyao.li@intel.com>
 <20250401130205.2198253-10-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250401130205.2198253-10-xiaoyao.li@intel.com>
Received-SPF: pass client-ip=198.175.65.20; envelope-from=zhao1.liu@intel.com;
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

On Tue, Apr 01, 2025 at 09:01:19AM -0400, Xiaoyao Li wrote:
> Date: Tue,  1 Apr 2025 09:01:19 -0400
> From: Xiaoyao Li <xiaoyao.li@intel.com>
> Subject: [PATCH v8 09/55] i386/tdx: Add property sept-ve-disable for
>  tdx-guest object
> X-Mailer: git-send-email 2.34.1
> 
> Bit 28 of TD attribute, named SEPT_VE_DISABLE. When set to 1, it disables
> EPT violation conversion to #VE on guest TD access of PENDING pages.
> 
> Some guest OS (e.g., Linux TD guest) may require this bit as 1.
> Otherwise refuse to boot.
> 
> Add sept-ve-disable property for tdx-guest object, for user to configure
> this bit.
> 
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> Acked-by: Gerd Hoffmann <kraxel@redhat.com>
> Acked-by: Markus Armbruster <armbru@redhat.com>
> ---
> Changes in v4:
> - collect Acked-by from Markus
> 
> Changes in v3:
> - update the comment of property @sept-ve-disable to make it more
>   descriptive and use new format. (Daniel and Markus)
> ---
>  qapi/qom.json         |  8 +++++++-
>  target/i386/kvm/tdx.c | 23 +++++++++++++++++++++++
>  2 files changed, 30 insertions(+), 1 deletion(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


