Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99196C0219E
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 10:44:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjybx-0002Js-2K; Mon, 17 Feb 2025 05:44:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tjybt-0002J7-UY
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 05:44:22 -0500
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tjybq-0001Jr-K4
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 05:44:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1739789058; x=1771325058;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=+RDQH78CtgRQ49m39KFNNaJo1U2umPFWTQamXO4LqnM=;
 b=brqW4XGwLC56IEz9gRxN36EzabFh/Bk8ytd44Mg58GBLmD7FXHnfAu3U
 arKa+zEXcuMlnR/rOvbLIL2DXgTWF1us39hLoIdTGYag3dBv9k6oNCrt7
 xBHeGqfBko56JgAeO2RUX5GVxhN9BV6iJppJNZuHfT37Wg/nlUNVaz5oL
 xrwu3jVIJMg/Vqk+eqIBEFEi2nfG/5EXVdzPJQpeGjuUpRNkUEhlci2uH
 pg7/iAO1MPVBLum2ZcCDWQ1Pgweko2L48xExcyTp4HtLPapVQLURbBEfk
 sh8OOnl9oF4oaxdyetxLF7QvLnvZQwePKuPJvHu5e7t/PqHLOWU1u0Ms4 g==;
X-CSE-ConnectionGUID: 51BXG3zYTuyuqAP1iZG1Sg==
X-CSE-MsgGUID: Ht5j8mI7Q1ehehyWyAxcZQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11347"; a="40602440"
X-IronPort-AV: E=Sophos;i="6.13,292,1732608000"; d="scan'208";a="40602440"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Feb 2025 02:44:14 -0800
X-CSE-ConnectionGUID: ZAG0oCmkTl2lqQtjhzgLkA==
X-CSE-MsgGUID: U9TVD2pbSCmD6okJ8nlw8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="118721057"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa005.fm.intel.com with ESMTP; 17 Feb 2025 02:44:13 -0800
Date: Mon, 17 Feb 2025 19:03:47 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL 23/27] i386: enable rust hpet for pc when rust is enabled
Message-ID: <Z7MXkxoMC/xpLiL2@intel.com>
References: <20250213160054.3937012-1-pbonzini@redhat.com>
 <20250213160054.3937012-24-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250213160054.3937012-24-pbonzini@redhat.com>
Received-SPF: pass client-ip=192.198.163.15; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.382,
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

Hi Paolo,

> --- a/hw/timer/Kconfig
> +++ b/hw/timer/Kconfig
> @@ -11,7 +11,7 @@ config A9_GTIMER
>  
>  config HPET
>      bool
> -    default y if PC
> +    default y if PC && !HAVE_RUST

+
+config X_HPET_RUST
+    bool
+    default y if PC && HAVE_RUST

>  config I8254
>      bool

This patch doesn't enable the configuration option of Rust HPET for PC.

Is it because the Rust HPET would break live migration, so we have to
disable it?

Thanks,
Zhao


