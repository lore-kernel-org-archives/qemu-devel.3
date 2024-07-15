Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29405C3DA59
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2024 12:45:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTL5E-0001uf-2v; Mon, 15 Jul 2024 08:45:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sTL4z-0001cM-GK
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 08:45:23 -0400
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sTL4u-0004tB-2B
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 08:45:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1721047516; x=1752583516;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=HgCxm632MKI+ageSXo76+sPRdrBooforP1/ih5wmQEE=;
 b=j6aHo24mASlkGbVPlUgGYXD43+VrdVz/c4aMwyRFsR9X4LkM/YldMp47
 slqPrhOZvKI3sHqomKFgV/c8ueQlvTq3Rz2PrLDU/khFvarDid9BOjVH7
 rR2tREM7qu18ePfL+YmXZUnjWUV0IEfXpBMA9+Gs5VsOhiAMBv+q9Q+qG
 m6TbWrbjSeD3EXS93Ij9b5TuQW0hhsx78jWAkpsSB/dM/8BB9WRrlNe8y
 JBwa73SoiIDshcG6rLA5uwb43CXqYq/XVZ2ui7iEFHEC2xiYtXe8lfVMN
 i3no7pOCU92waVR9Iz0LheVb5a3VIxUAWv8+u99eSYpE85hy24/NIIdL5 Q==;
X-CSE-ConnectionGUID: tBU/AjaqQHO4AUBmmAdfpw==
X-CSE-MsgGUID: tqbs83CPQ06xfZZYj+bKyQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11133"; a="18377068"
X-IronPort-AV: E=Sophos;i="6.09,210,1716274800"; d="scan'208";a="18377068"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jul 2024 05:45:12 -0700
X-CSE-ConnectionGUID: NgNQpvSES92NzU9mYNTslw==
X-CSE-MsgGUID: 3VcObhf5Tai7eUqEKlc8eQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,210,1716274800"; d="scan'208";a="87119060"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa001.jf.intel.com with ESMTP; 15 Jul 2024 05:45:11 -0700
Date: Mon, 15 Jul 2024 21:00:51 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH] meson: Update meson-buildoptions.sh
Message-ID: <ZpUdgyNb2lFga9PU@intel.com>
References: <20240705054903.2100562-1-zhao1.liu@intel.com>
 <Zoe625Z3JxlB4G5D@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zoe625Z3JxlB4G5D@redhat.com>
Received-SPF: pass client-ip=198.175.65.21; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

On Fri, Jul 05, 2024 at 10:20:27AM +0100, Daniel P. Berrangé wrote:
> Date: Fri, 5 Jul 2024 10:20:27 +0100
> From: "Daniel P. Berrangé" <berrange@redhat.com>
> Subject: Re: [PATCH] meson: Update meson-buildoptions.sh
> 
> On Fri, Jul 05, 2024 at 01:49:03PM +0800, Zhao Liu wrote:
> > Update meson-buildoptions.sh to stay in sync with meson_options.txt.
> > 
> > Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> > ---
> >  scripts/meson-buildoptions.sh | 14 +++++++-------
> >  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> 

Thanks!

BTW, could you please help merge this change? Because recently this
script has been "polluting" my git staging workspace during
development.

Regards,
Zhao


