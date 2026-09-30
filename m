Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E26BCA5FC1
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 08:48:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBpyq-0007So-C6; Wed, 30 Sep 2026 04:48:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1xBpyL-0007ES-4L; Wed, 30 Sep 2026 04:47:34 -0400
Received: from mgamail.intel.com ([198.175.65.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1xBpyC-0002Hj-UL; Wed, 30 Sep 2026 04:47:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790758041; x=1822294041;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=Ds7Xfcyj4KgtoY0TYtL/h3LN1TCzLfzqW1/Vkmul6h4=;
 b=LNMLilhmgeIIRIdhZyWiWt2GSTYGXNhro2hx5hNdjLeTr6zGFaDX0Okw
 jAroBkPBpy3OGDNyoQJ02mngDfaC6nkAzYdX/JgSpP8CplW4mvgvErrHw
 VoKhHPBGrRfqdXN2xMCfgOtbhA/B1x9Oc0JrOZuQ0Ng0t1qnAb6EbhP2g
 xBw7VveDDg1K87Wt3LUmUn0CZN5pWpSuP/ikWW+mYoJdtIHEBB0rzzoEV
 NxApr0Rv0NibW2WMY06llrFVHUNKWqL33quUSqrtcnB83pgmkGqwVPDvj
 EtEPUiRf3DjVGO3w7SnqfKX/TZaDhZkqX9AVW999ZBYNsu8NUF2az46AD Q==;
X-CSE-ConnectionGUID: elfmvWJxQuGYRygIinDFsw==
X-CSE-MsgGUID: oUV7AjN2Q/if9/Xrjgz7yQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11920"; a="90444546"
X-IronPort-AV: E=Sophos;i="6.27,132,1787036400"; d="scan'208";a="90444546"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Sep 2026 01:47:17 -0700
X-CSE-ConnectionGUID: sIiUjzTXSy+jG0N4NHgjDw==
X-CSE-MsgGUID: mXBBrOVrTDSc/V/juSSKaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,132,1787036400"; d="scan'208";a="274236505"
Received: from zhaoliu1-desk.sh.intel.com (HELO localhost) ([10.112.226.173])
 by fmviesa006.fm.intel.com with ESMTP; 30 Sep 2026 01:47:12 -0700
Date: Wed, 30 Sep 2026 16:47:11 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Yonggang Luo <luoyonggang@gmail.com>
Cc: qemu-devel@nongnu.org, Chao Liu <chao.liu@processmission.com>,
 Eric Blake <eblake@redhat.com>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>,
 Markus Armbruster <armbru@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Stafford Horne <shorne@gmail.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Fabiano Rosas <farosas@suse.de>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 qemu-riscv@nongnu.org, Laurent Vivier <lvivier@redhat.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Song Gao <17746591750@163.com>,
 Philippe Mathieu-Daude <philmd@mailo.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Laurent Vivier <laurent@vivier.eu>, Weiwei Li <liwei1518@gmail.com>
Subject: Re: [PATCH v3 10/10] machine: match the versioned virt example to
 arm virt
Message-ID: <arzMjw8+B072oh0l@intel.com>
References: <20260926081551.29-1-luoyonggang@gmail.com>
 <20260926081551.29-11-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260926081551.29-11-luoyonggang@gmail.com>
Received-SPF: pass client-ip=198.175.65.19; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
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

On Sat, Sep 26, 2026 at 04:15:50PM +0800, Yonggang Luo wrote:
> Date: Sat, 26 Sep 2026 16:15:50 +0800
> From: Yonggang Luo <luoyonggang@gmail.com>
> Subject: [PATCH v3 10/10] machine: match the versioned virt example to arm
>  virt
> X-Mailer: git-send-email 2.52.0.windows.1
> 
> The comment still showed MACHINE_VER_TYPE_NAME("virt") and left out
> machine_class_set_name(). Show the arm-virt QOM type, keep the -M name
> as virt-<version>, and name the latest helper
> DEFINE_VIRT_MACHINE_AS_LATEST.
> 
> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> ---
>  include/hw/core/boards.h | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


