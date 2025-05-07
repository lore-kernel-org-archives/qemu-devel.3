Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07EA6C369DC
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 05:50:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCXfD-0002lp-Bp; Wed, 07 May 2025 01:49:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uCXfB-0002lV-0g
 for qemu-devel@nongnu.org; Wed, 07 May 2025 01:49:49 -0400
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uCXf8-0004m8-EM
 for qemu-devel@nongnu.org; Wed, 07 May 2025 01:49:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1746596987; x=1778132987;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=6srOwmxYkkxOMyYwDK6MriQ02JNwNkmPhZF+3e085Ko=;
 b=J6QizcgevpgqbVHr3z5QVkyzspfiobKLWP0ugx/x7jOsZTb+S8+vC1n0
 x/bdu1grWfJJJLevcMsY7I4ZOjF6Yg2k8xjn9j5F6gYm8U1RmyyONgv/m
 VivaGsdTxmbh0Hym0ysHGYAbj9Z4JYR6m7tU2VTaxhjy1f1xgy5taVPWC
 z4LrBWiNvWA5aEivoqJsWnp/oMBiMPrQJZLGl1d2qO3Au9j4+Cy3PHfQI
 dr7tgyGoWMHUjy8jd+84TzUSL3EiwjWFTG9qNE8PbolvEoE/GgQJ0AF6Z
 KniAjwsSbaMOgrYXl3hLD+4UQVu6wKO0Rg5eIEmsAa7OPSb+Hhr9vHRfw Q==;
X-CSE-ConnectionGUID: 3eeP2ebQSd6SSmxEj/pEfg==
X-CSE-MsgGUID: Jyy17k9cQhaWOWGS2ypHtw==
X-IronPort-AV: E=McAfee;i="6700,10204,11425"; a="52120486"
X-IronPort-AV: E=Sophos;i="6.15,268,1739865600"; d="scan'208";a="52120486"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 May 2025 22:49:43 -0700
X-CSE-ConnectionGUID: Kb18GIyDSjCBwC8ZIx01Fg==
X-CSE-MsgGUID: GCYbHms3S0StHsGit7ZsGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,268,1739865600"; d="scan'208";a="140580390"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa003.jf.intel.com with ESMTP; 06 May 2025 22:49:39 -0700
Date: Wed, 7 May 2025 14:10:39 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Huacai Chen <chenhuacai@kernel.org>, Amit Shah <amit@kernel.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Sergio Lopez <slp@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Jason Wang <jasowang@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?iso-8859-1?Q?Cl=E9ment?= Mathieu--Drif <clement.mathieu--drif@eviden.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Yi Liu <yi.l.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>
Subject: Re: [PATCH v3 01/19] hw/i386/pc: Remove deprecated pc-q35-2.6 and
 pc-i440fx-2.6 machines
Message-ID: <aBr5XwjPDS6yn5Ff@intel.com>
References: <20250502185652.67370-1-philmd@linaro.org>
 <20250502185652.67370-2-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250502185652.67370-2-philmd@linaro.org>
Received-SPF: pass client-ip=198.175.65.14; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -57
X-Spam_score: -5.8
X-Spam_bar: -----
X-Spam_report: (-5.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.414,
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

On Fri, May 02, 2025 at 08:56:33PM +0200, Philippe Mathieu-Daudé wrote:
> Date: Fri,  2 May 2025 20:56:33 +0200
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> Subject: [PATCH v3 01/19] hw/i386/pc: Remove deprecated pc-q35-2.6 and
>  pc-i440fx-2.6 machines
> X-Mailer: git-send-email 2.47.1
> 
> These machines has been supported for a period of more than 6 years.
> According to our versioned machine support policy (see commit
> ce80c4fa6ff "docs: document special exception for machine type
> deprecation & removal") they can now be removed.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> ---
>  hw/i386/pc_piix.c | 14 --------------
>  hw/i386/pc_q35.c  | 14 --------------
>  2 files changed, 28 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


