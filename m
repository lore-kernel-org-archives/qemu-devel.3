Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51F04CA0FE1
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Aug 2025 09:34:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqTZl-00051k-5V; Mon, 25 Aug 2025 05:33:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uqTZh-00050x-Nr
 for qemu-devel@nongnu.org; Mon, 25 Aug 2025 05:33:13 -0400
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uqTZa-00087m-Kp
 for qemu-devel@nongnu.org; Mon, 25 Aug 2025 05:33:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1756114386; x=1787650386;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=p0hMioeV02n2xJ99grAeHjV1AMAAU4W1bDFUcK9uEog=;
 b=IOy/c2w+WneJM2cnEPNpbt1yag7EIqpVfgxjXJM3yijT0ceJXhEVSacX
 1CUXqABN0GT0L5ZjKSm1yc8HYjXN31pKXeP/CP/l6cPrpEl+62SVNAmhR
 KVUCWLVXaHP3lXiNQ3HjMZPXBk1rIaAJDJj5hwBSQ411ae/Guh8Q1riC6
 dx4J+txfBSg8LfT45rtBrZcXPPt2gUskMIiqfGbnFY/slNdLQD2ojkbDR
 oC1Nqs1epdhlXZNdtPoOVyVIr5MKiJriLrgiOEsX0zYuKJiD+HATspKr4
 g9GWkeT+EXGCSwsFbvqfWYc/jBKrAwSijHkkAWIkqtUej3IHTaSHclfyf Q==;
X-CSE-ConnectionGUID: WFNuEqtoTbuFXKmh4+5e5A==
X-CSE-MsgGUID: 0T2yNzDsTMu5SXU8jAz44A==
X-IronPort-AV: E=McAfee;i="6800,10657,11532"; a="68591545"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; d="scan'208";a="68591545"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Aug 2025 02:33:02 -0700
X-CSE-ConnectionGUID: pn6k/TFvSrm3gnabKz4xQQ==
X-CSE-MsgGUID: vtQfJptmRASde5Na9HH/DQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; d="scan'208";a="200143886"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa001.fm.intel.com with ESMTP; 25 Aug 2025 02:33:00 -0700
Date: Mon, 25 Aug 2025 17:54:46 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, tanishdesai37@gmail.com, stefanha@redhat.com,
 berrange@redhat.com, mads@ynddal.dk
Subject: Re: [PATCH 07/14] rust: add trace crate
Message-ID: <aKwy5joqsgmBPOFI@intel.com>
References: <20250822122655.1353197-1-pbonzini@redhat.com>
 <20250822122655.1353197-8-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250822122655.1353197-8-pbonzini@redhat.com>
Received-SPF: pass client-ip=198.175.65.11; envelope-from=zhao1.liu@intel.com;
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

> diff --git a/rust/trace/src/lib.rs b/rust/trace/src/lib.rs
> new file mode 100644
> index 00000000000..9b931ddf1de
> --- /dev/null
> +++ b/rust/trace/src/lib.rs
> @@ -0,0 +1,23 @@
> +//! This crate provides macros that aid in using QEMU's tracepoint
> +//! functionality.
> +
> +#[macro_export]
> +/// Define the trace-points from the named directory (which should have slashes
> +/// replaced by underscore characters) as functions in a module called `trace`.
> +///
> +/// ```ignore
> +/// ::trace::include_trace!("hw_char");
> +/// // ...
> +/// trace::trace_pl011_read_fifo_rx_full();
> +/// ```
> +macro_rules! include_trace {
> +    ($name:literal) => {
> +        mod trace {
> +            #[cfg(not(MESON))]
> +            include!(concat!(env!("MESON_BUILD_ROOT"), "/trace/", $name, ".rs"));

nit: missing the "trace-" prefix~

include!(concat!(env!("MESON_BUILD_ROOT"), "/trace/", "trace-", $name, ".rs"));

> +            #[cfg(MESON)]
> +            include!(concat!("@MESON_BUILD_ROOT@/trace/", $name, ".rs"));

ditto

> +        }
> +    };
> +}

this is the nice work!

(but it breaks the doing `cargo build` directly without meson virt env.
 For `cfd(not(MESON)) case`, could we support placing trace files under
 local folder? like

 include!(concat!(env!("CARGO_MANIFEST_DIR"), "src/", "trace-", $name, ".rs"));

 Or should we add a build.rs like qemu-api does?)

Thanks,
Zhao


