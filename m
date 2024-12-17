Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE66BE77184
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 16:10:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNa5V-0002fI-7L; Tue, 17 Dec 2024 11:06:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tNa4M-0001w1-9P
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 11:05:11 -0500
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tNa4J-0002kr-Mp
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 11:05:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1734451508; x=1765987508;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=bo86RRfkr3shVB+cRKwVtLE8HuM1MXjOYJ7K7zRqdXU=;
 b=G7GPLR3j32QgEQOX+OJnBHpxj9dvPXvmqgoiFbjnjuR7MYnpuHFs5cY7
 qxNqr26s60qWieL11wFDN32VNm4raNQrd7LK52W7TwJaJoR/mmtqRtHMy
 K5XRzWDYBrJYF4X/9hTl5fQIgs9mB/vjFKHvZF5Wmzd9lODMAgbAt4pkP
 uxyYV20qK7FrVwBiBp73rSjzhOKwfvo5Qmtzl+ZCLu9DUBDpLFhnjdqDX
 94KK7Yqivjpl4MVEdPPfpE0HbwF+9FS+rTYe9QAbBj52eOjEW1NlgL4hN
 0aqzw8WOiY+q+wypwLigRe196J95fMpd736nmLMP9oOMLSGSdKwL8dn8Q g==;
X-CSE-ConnectionGUID: J7ZXAwbgT5+8fOmulyg7IQ==
X-CSE-MsgGUID: IemNg2qTRkORbnb1FZPUlw==
X-IronPort-AV: E=McAfee;i="6700,10204,11288"; a="52294485"
X-IronPort-AV: E=Sophos;i="6.12,242,1728975600"; d="scan'208";a="52294485"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Dec 2024 08:05:05 -0800
X-CSE-ConnectionGUID: 1pLt2+9cR3y1jBA5/W6pxw==
X-CSE-MsgGUID: qZtreTkoSoyAj1VrHL4AjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,242,1728975600"; d="scan'208";a="102409761"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa004.fm.intel.com with ESMTP; 17 Dec 2024 08:05:03 -0800
Date: Wed, 18 Dec 2024 00:23:42 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Stefano Stabellini <sstabellini@kernel.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paul Durrant <paul@xen.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Anton Johansson <anjo@rev.ng>,
 Anthony PERARD <anthony@xenproject.org>, xen-devel@lists.xenproject.org
Subject: Re: [PATCH 2/3] system/numa: Remove unnecessary 'exec/cpu-common.h'
 header
Message-ID: <Z2GljuPLP2xO3JTN@intel.com>
References: <20241217151305.29196-1-philmd@linaro.org>
 <20241217151305.29196-3-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241217151305.29196-3-philmd@linaro.org>
Received-SPF: pass client-ip=198.175.65.10; envelope-from=zhao1.liu@intel.com;
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

On Tue, Dec 17, 2024 at 04:13:04PM +0100, Philippe Mathieu-Daudé wrote:
> Date: Tue, 17 Dec 2024 16:13:04 +0100
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> Subject: [PATCH 2/3] system/numa: Remove unnecessary 'exec/cpu-common.h'
>  header
> X-Mailer: git-send-email 2.45.2
> 
> Nothing requires definitions from "exec/cpu-common.h",
> do not include this header.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  include/sysemu/numa.h | 1 -
>  1 file changed, 1 deletion(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


