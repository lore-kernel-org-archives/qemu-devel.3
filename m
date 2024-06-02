Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D295C25B74
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Jun 2024 05:36:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sDdt5-0005XF-Ee; Sun, 02 Jun 2024 01:36:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sDdt2-0005WG-Re; Sun, 02 Jun 2024 01:36:08 -0400
Received: from mgamail.intel.com ([192.198.163.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sDdt0-0002B2-QK; Sun, 02 Jun 2024 01:36:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1717306567; x=1748842567;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=3WaybShHrTo0oGSdFwEFlUTgdU/ecCDERa31TwrKso4=;
 b=aCbP+WB/CIAWEgu/hIOW8P5RZBX+rCVtmeRPgC6JZLVbK4/gSQ7AzlsL
 FLcyMhMmyuMmCRnv4sEivR8BNghAhk9GV/1xzeBVUcwUBuTqiqmL3Xruk
 PvR3rE7bqezXh3wPjfO5CFUGXI7npqS7cHAH7oaTv1O3zvhHSvmE1+V30
 LJhPDYP/T0NKFEh/zbIhtyXtHXWedZU/QwVpMKoFYp6wOl6yxn3hHx2vU
 WuzH/zcbMhKqWA7k9VJ9R31J8h1eHb0AKVxSaDTSLQMAR5ZYbX7KySnOA
 Qgp5MoQyzluWyNucGSli4GDKSv6hwiRNptKkRXdJfK+lzw75c+fzWJM/n g==;
X-CSE-ConnectionGUID: W+FAlfOYTomfWNUhqNBS4Q==
X-CSE-MsgGUID: mKWSPNSSS06NAYETfLzITQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11090"; a="24475377"
X-IronPort-AV: E=Sophos;i="6.08,208,1712646000"; d="scan'208";a="24475377"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jun 2024 22:36:04 -0700
X-CSE-ConnectionGUID: KeD1hLweScGdzUxn7/G5wA==
X-CSE-MsgGUID: S/PoCQbhTxmoCYt+iYi/oQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,208,1712646000"; d="scan'208";a="36485936"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa010.jf.intel.com with ESMTP; 01 Jun 2024 22:36:02 -0700
Date: Sun, 2 Jun 2024 13:51:27 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-trivial@nongnu.org
Subject: Re: [PATCH] accel/kvm: Fix two lines with hard-coded tabs
Message-ID: <ZlwIX2izGFJzlNvy@intel.com>
References: <20240531170952.505323-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240531170952.505323-1-peter.maydell@linaro.org>
Received-SPF: pass client-ip=192.198.163.9; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.041,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Fri, May 31, 2024 at 06:09:52PM +0100, Peter Maydell wrote:
> Date: Fri, 31 May 2024 18:09:52 +0100
> From: Peter Maydell <peter.maydell@linaro.org>
> Subject: [PATCH] accel/kvm: Fix two lines with hard-coded tabs
> X-Mailer: git-send-email 2.34.1
> 
> In kvm-all.c, two lines have been accidentally indented with
> hard-coded tabs rather than spaces. Normalise to match the rest
> of the file.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  accel/kvm/kvm-all.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


