Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB2EDC83F03
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 11:18:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXeQS-0004It-BN; Fri, 04 Jul 2025 07:17:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uXeQ8-000406-9c
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 07:17:35 -0400
Received: from mgamail.intel.com ([198.175.65.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uXeQ6-0005HQ-PY
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 07:17:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751627851; x=1783163851;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=KCjltM41xz3GfHdkUZZ2fiuscRqEgHXJZnCRkBJ2cIY=;
 b=ll0LRC2LOUoXtlk3/pnhgarTOohH/+9tg5DCwiPNE/j0ssaJHnxJ4HFP
 HCm1IAf0Ic/wRQ/0WefdeZCJT7X+MyX5gdt4VIYKYs4NSdGgc2nsLKK8Y
 6+corPMD2LW+U4ZHGcZOL4QZyVlDRt2Iy9pmYzNsphHXNzVBPMRjoXLVu
 7GER+JHW4X4CeyWblbXWezZtQ1/ZAj4aS9H8oTqeVgVseLA0Rl3yHRyX/
 pxQDJLRdhJMTQhtu27Q7m9ilvBUTkH/pJX3GxOCkw0ooMQ363yuhjsStv
 fqhzpytSLnsX08j7pTTQu56qGk6KkOSSK5B8cGOVQAsnWQX2HGGMy5xnx Q==;
X-CSE-ConnectionGUID: niShlUWgRRK90afZysrFUg==
X-CSE-MsgGUID: 19WSiL3MT4enAlwDMLCYWA==
X-IronPort-AV: E=McAfee;i="6800,10657,11483"; a="65414903"
X-IronPort-AV: E=Sophos;i="6.16,287,1744095600"; d="scan'208";a="65414903"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jul 2025 04:17:29 -0700
X-CSE-ConnectionGUID: W3RpXJjkSTWLpn4jyS21xg==
X-CSE-MsgGUID: 9tb+FDaSSaaH2Vx1rgW6HQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,287,1744095600"; d="scan'208";a="159177282"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa004.jf.intel.com with ESMTP; 04 Jul 2025 04:17:28 -0700
Date: Fri, 4 Jul 2025 19:38:54 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v6 35/39] accel: Remove unused MachineState argument of
 AccelClass::setup_post()
Message-ID: <aGe9ThU+ivSYKkOX@intel.com>
References: <20250703173248.44995-1-philmd@linaro.org>
 <20250703173248.44995-36-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250703173248.44995-36-philmd@linaro.org>
Received-SPF: pass client-ip=198.175.65.12; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.218,
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

On Thu, Jul 03, 2025 at 07:32:41PM +0200, Philippe Mathieu-Daudé wrote:
> Date: Thu,  3 Jul 2025 19:32:41 +0200
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> Subject: [PATCH v6 35/39] accel: Remove unused MachineState argument of
>  AccelClass::setup_post()
> X-Mailer: git-send-email 2.49.0
> 
> This method only accesses xen_domid/xen_domid_restrict, which are both
> related to the 'accelerator', not the machine. Besides, xen_domid aims
> to be in Xen AccelState and xen_domid_restrict a xen_domid_restrict
> QOM property.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  include/qemu/accel.h | 2 +-
>  accel/accel-system.c | 2 +-
>  accel/xen/xen-all.c  | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


