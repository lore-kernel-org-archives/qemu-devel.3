Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E27F0C624D0
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 10:17:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1i2L-0006y0-Px; Wed, 02 Sep 2026 06:17:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1x1i2L-0006vp-06
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 06:17:45 -0400
Received: from mgamail.intel.com ([198.175.65.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1x1i2I-0005Gp-6q
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 06:17:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788344262; x=1819880262;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=GCVIbj/xGTDDwwWNAXoxHETUZ7Pnrwff7qXe4oPkzz8=;
 b=KPAUDcFRGkkx5WRMqPZOOwenbsVcElGs4lzbkR/ckg/+6g0rb3qUBCnc
 k9yTM1bokRn71L9b6IES8FKdnckEGf76zuj4BbextTa3vvq46afem8oNj
 LGida3fADCDWN2fEUSxET4Uh2gzCpXMWzQEWBl7TjZQDGrMFaOQhFeuNI
 5JJEtaqR5NH6xLZzshYpA7M9zZp0vCnuDSvcx01wrBcllV2t9kxWkcxv/
 thUMnH+QL8cSYEHIdBolHCPpuT0Rj6YBJ3BbzMXEQ4mo6tLHAK7mQkbSJ
 9m897R7l806ap110BFVAvU7p1nRYIfhwaPozwmmWWwDe8OGvx9WckdNY8 g==;
X-CSE-ConnectionGUID: SyxfnbS/ROqTJ5I06MAC3Q==
X-CSE-MsgGUID: 8XcE2I9BRrOuGjHpOrDk4g==
X-IronPort-AV: E=McAfee;i="6800,10657,11893"; a="92498028"
X-IronPort-AV: E=Sophos;i="6.25,257,1779174000"; d="scan'208";a="92498028"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Sep 2026 03:17:40 -0700
X-CSE-ConnectionGUID: 2sY2uzNYRGC6CT6l21mO0g==
X-CSE-MsgGUID: wVNOpjzmRfSicel8/s4p+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,257,1779174000"; d="scan'208";a="268066684"
Received: from zhaoliu1-desk.sh.intel.com (HELO localhost) ([10.238.208.118])
 by orviesa010.jf.intel.com with ESMTP; 02 Sep 2026 03:17:39 -0700
Date: Wed, 2 Sep 2026 18:17:38 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Kishen Maloor <kishen.maloor@intel.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, kvm@vger.kernel.org,
 sohil.mehta@intel.com, xiaoyao.li@intel.com,
 binbin.wu@linux.intel.com, farrah.chen@intel.com
Subject: Re: [PATCH 5/5] target/i386: Introduce ClearwaterForest-v5 to enable
 LASS
Message-ID: <apf3wqxIIFujdezs@intel.com>
References: <20260826035734.114685-1-kishen.maloor@intel.com>
 <20260826035734.114685-6-kishen.maloor@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260826035734.114685-6-kishen.maloor@intel.com>
Received-SPF: pass client-ip=198.175.65.15; envelope-from=zhao1.liu@intel.com;
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

On Tue, Aug 25, 2026 at 08:57:34PM -0700, Kishen Maloor wrote:
> Date: Tue, 25 Aug 2026 20:57:34 -0700
> From: Kishen Maloor <kishen.maloor@intel.com>
> Subject: [PATCH 5/5] target/i386: Introduce ClearwaterForest-v5 to enable
>  LASS
> X-Mailer: git-send-email 2.47.1
> 
> Add ClearwaterForest-v5 to expose Linear Address Space Separation (LASS)
> on the ClearwaterForest CPU model.
> 
> Signed-off-by: Kishen Maloor <kishen.maloor@intel.com>
> ---
>  target/i386/cpu.c | 8 ++++++++
>  1 file changed, 8 insertions(+)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


