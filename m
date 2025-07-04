Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5824FC83F03
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 09:54:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXd7l-0006MR-QH; Fri, 04 Jul 2025 05:54:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uXd7c-0006Je-2t
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 05:54:20 -0400
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uXd7X-0008SA-Jy
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 05:54:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751622856; x=1783158856;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=7a9+P8cFf8usiWhMqJ5dnpH8Nu0pfOoPxzmDBwgBXOs=;
 b=VknkgnYSxOiWGGgmOzHNLhHF2qCc0UO2ab4XqliHU9FtQgtBUk82c+eg
 aNqRvYYh0ie8vVhITpSbNRXKQ/CVHcd3KrF2Sins6e1T0vo2otTay7BHw
 qjVivBU03vMaXR2HMhsW0+e0/s4iROJBTL3+xr/aUKVdym90U/pfxf8KB
 X0gatRelYrIJNluji/B8xWppS37hKdklLkQtNwxoiDWM9MMxw+JtO5qiK
 e27tqUtmKB5FeY8BuM7bgFcp9rW8sF1NqQMJl8QG03yO+0IfkaHDa8qBS
 ix4pkNyoflYjviZaVaTsKZdmkhzqILk0z6NDhu80DIMWpB4Kx9XcKHniu A==;
X-CSE-ConnectionGUID: hyIADgIsRy2hBFYSXfVr6w==
X-CSE-MsgGUID: UHqd8gdKQ72eaP1iUHeHoQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11483"; a="64202604"
X-IronPort-AV: E=Sophos;i="6.16,286,1744095600"; d="scan'208";a="64202604"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jul 2025 02:54:13 -0700
X-CSE-ConnectionGUID: wKeRTb8yTE+pxF/QGHLdhw==
X-CSE-MsgGUID: EgStgWSdQcSr2EEK3s2Caw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,286,1744095600"; d="scan'208";a="159162186"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa004.jf.intel.com with ESMTP; 04 Jul 2025 02:54:12 -0700
Date: Fri, 4 Jul 2025 18:15:37 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v6 21/39] accel/kvm: Remove kvm_cpu_synchronize_state()
 stub
Message-ID: <aGepyeVJvTVZ+hvy@intel.com>
References: <20250703173248.44995-1-philmd@linaro.org>
 <20250703173248.44995-22-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250703173248.44995-22-philmd@linaro.org>
Received-SPF: pass client-ip=198.175.65.11; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237,
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

On Thu, Jul 03, 2025 at 07:32:27PM +0200, Philippe Mathieu-Daudé wrote:
> Date: Thu,  3 Jul 2025 19:32:27 +0200
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> Subject: [PATCH v6 21/39] accel/kvm: Remove kvm_cpu_synchronize_state() stub
> X-Mailer: git-send-email 2.49.0
> 
> Since commit 57038a92bb0 ("cpus: extract out kvm-specific code
> to accel/kvm") the kvm_cpu_synchronize_state() stub is not
> necessary.
> 
> Fixes: e0715f6abce ("kvm: remove kvm specific functions from global includes")
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  accel/stubs/kvm-stub.c | 4 ----
>  1 file changed, 4 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


