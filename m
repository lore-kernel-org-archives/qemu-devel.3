Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 440F8E77187
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 15:02:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNvZB-0002Dy-F3; Wed, 18 Dec 2024 10:02:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tNvZ5-0002Bh-50; Wed, 18 Dec 2024 10:02:19 -0500
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tNvZ2-0006ef-4J; Wed, 18 Dec 2024 10:02:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1734534136; x=1766070136;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=/jJ8MVaAeqRT02E9ktCnGfI0BT8udNfG1X8f/KkdJNo=;
 b=KGkQ/NxX53srN6wJkBeVCrb20RJ0NglraqAQ9CDYCK32CQQMYgD2hqsb
 hxKBTA6X7Qf26tU270KeeBbiNnTaw7JZFzQnx8DEIsqeYGZn/UkqhK6xT
 e3J3YBOeKKoYRxsbnHjPIfinjZJL5tucbN9MlMW+mdEP8hRdVh1FGY5nC
 +VovoitdBUZyw0K6kLuamSCTVLOuCzp0N8W8oHFCb6aGpXmaC7D0pf98a
 QHdM5j/PkqmuPIPBVQOg56mywJJsAHMGVb1REixVtV5e+qbD3pYtJoN5e
 /vW/hMMxNaQsdMDw5IVigmI3JVxxCwohu8ShK4HZID6La9UJ54O0DNSDq g==;
X-CSE-ConnectionGUID: BZtcFWq9SiaFkHIfVHCPqA==
X-CSE-MsgGUID: 5V62+diWSe6AbnNbCg46Jw==
X-IronPort-AV: E=McAfee;i="6700,10204,11290"; a="37853999"
X-IronPort-AV: E=Sophos;i="6.12,244,1728975600"; d="scan'208";a="37853999"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Dec 2024 07:02:12 -0800
X-CSE-ConnectionGUID: qkP5p7r6Q62i7qjRjHs1bw==
X-CSE-MsgGUID: Ohg4AkJ2QpOKP+1o3TT04Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,244,1728975600"; d="scan'208";a="97782020"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa009.jf.intel.com with ESMTP; 18 Dec 2024 07:02:10 -0800
Date: Wed, 18 Dec 2024 23:20:49 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>
Subject: Re: [PATCH 22/71] hw/cpu: Constify all Property
Message-ID: <Z2LoUZ9hf/2kXUla@intel.com>
References: <20241213190750.2513964-1-richard.henderson@linaro.org>
 <20241213190750.2513964-27-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241213190750.2513964-27-richard.henderson@linaro.org>
Received-SPF: pass client-ip=192.198.163.13; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Fri, Dec 13, 2024 at 01:06:56PM -0600, Richard Henderson wrote:
> Date: Fri, 13 Dec 2024 13:06:56 -0600
> From: Richard Henderson <richard.henderson@linaro.org>
> Subject: [PATCH 22/71] hw/cpu: Constify all Property
> X-Mailer: git-send-email 2.43.0
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  hw/cpu/a15mpcore.c       | 2 +-
>  hw/cpu/a9mpcore.c        | 2 +-
>  hw/cpu/arm11mpcore.c     | 2 +-
>  hw/cpu/cluster.c         | 2 +-
>  hw/cpu/realview_mpcore.c | 2 +-
>  5 files changed, 5 insertions(+), 5 deletions(-)
> 

Hope I'm not late :-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


