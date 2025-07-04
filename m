Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67354C83F03
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 11:28:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXeaC-00055c-A8; Fri, 04 Jul 2025 07:27:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uXeaA-00055F-QY
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 07:27:54 -0400
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uXea8-00034L-3G
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 07:27:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751628472; x=1783164472;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=W0PwnYPSV580UDtMjRuKRGFdWZXpfSJZbC/LxCMJ/wo=;
 b=IQKKgfsHx4MHSlZ2jHdr94r/fO+Qq+azTXtpbPP7JUR3j+02OLE3ramK
 EJkMBtallV84HhHh+weGa/3roq4Yy1auIHtGDjRjOgAsRL9wNOPFjn6B8
 8hxU2KDTkPXkWn7dvskIdG77IsJTHXeUR2RGa9qKKP6GKiuCxf/bNL0k2
 p6qax2OpqpqEBBGOoGV8iS9KhVHz9T0izWsqoeTWHOos+h9ZmiLZxT8RK
 z5qia6t5akeNQZ62Av2+UYUtOeGFhGykWDQSfEF1XQuVunDY4EZ9ZlpC/
 hQkqEb7TrD6Z9zPMaFy52xY9z8YQtGD0qfoOJppyze8oS4XNL1EWdBBtC g==;
X-CSE-ConnectionGUID: IVHWTYlIThamqMEr7JflfQ==
X-CSE-MsgGUID: 1m0FHxrETku9tXLMvIv4CA==
X-IronPort-AV: E=McAfee;i="6800,10657,11483"; a="76510991"
X-IronPort-AV: E=Sophos;i="6.16,287,1744095600"; d="scan'208";a="76510991"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jul 2025 04:27:49 -0700
X-CSE-ConnectionGUID: Kj+ZXNaFR7+n/6TwSidk4g==
X-CSE-MsgGUID: ojftwFVZTki9FfaIMwJgKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,287,1744095600"; d="scan'208";a="185640682"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa002.jf.intel.com with ESMTP; 04 Jul 2025 04:27:48 -0700
Date: Fri, 4 Jul 2025 19:49:13 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v6 05/39] accel/kvm: Remove kvm_init_cpu_signals() stub
Message-ID: <aGe/uf/eiKgWzexa@intel.com>
References: <20250703173248.44995-1-philmd@linaro.org>
 <20250703173248.44995-6-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250703173248.44995-6-philmd@linaro.org>
Received-SPF: pass client-ip=198.175.65.9; envelope-from=zhao1.liu@intel.com;
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

On Thu, Jul 03, 2025 at 07:32:11PM +0200, Philippe Mathieu-Daudé wrote:
> Date: Thu,  3 Jul 2025 19:32:11 +0200
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> Subject: [PATCH v6 05/39] accel/kvm: Remove kvm_init_cpu_signals() stub
> X-Mailer: git-send-email 2.49.0
> 
> Since commit 57038a92bb0 ("cpus: extract out kvm-specific code
> to accel/kvm") the kvm_init_cpu_signals() stub is not necessary.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  accel/stubs/kvm-stub.c | 5 -----
>  1 file changed, 5 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


