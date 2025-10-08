Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0318DCAC5BB
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 16:08:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6Wh8-0006ZE-0K; Wed, 08 Oct 2025 12:07:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1v6Wgz-0006TH-SG; Wed, 08 Oct 2025 12:07:06 -0400
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1v6Wgu-0003Yl-I5; Wed, 08 Oct 2025 12:07:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1759939622; x=1791475622;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=NqnKVblzgHh4rHu/Zi6n6SF2/RxYHjTM6wJwcL6baeo=;
 b=bqd3c5fcVESL3oynnPQj+e87elMeOMiSZl/Mp12cBSP57rNjX5u1uTUr
 m6ixJxtVKSdfFLVI2tq+VH+SXkZABewbF9zpFEpv+xZ6GhSzFlP9ij1fQ
 ky1Mf30nLnNfVFMSEXyNZyiW1Z71zvRVZ2+DCLJ+lVZFbA/hfoBzWy7ZY
 4+WVTdB/pmjCsTVoEVnyfsQcRxprrXTwwxkmGFA6sERPnqeY5ONnAayP9
 YPbx0Bvo6tCE6GsmX2L0yAPQs5Ib6HX80EJE0nwlIbYDHxIE/q1TOTTxD
 du0+sSXQ0ijKnTT4Pfw2hXeOZ4mMcJKrYi5+9Q8YqafQWZsx2Xj4Vx3Bo Q==;
X-CSE-ConnectionGUID: rh0OGaTKRuqu8BsPv2/D7g==
X-CSE-MsgGUID: SjCNG4v8RA+7w8bSGrCvKA==
X-IronPort-AV: E=McAfee;i="6800,10657,11576"; a="87601273"
X-IronPort-AV: E=Sophos;i="6.19,213,1754982000"; d="scan'208";a="87601273"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Oct 2025 09:06:52 -0700
X-CSE-ConnectionGUID: zyMPlym6QVqo4IxncZ5QUA==
X-CSE-MsgGUID: RePIAqwLTZeWOOH5ahE6fA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,213,1754982000"; d="scan'208";a="217577075"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa001.jf.intel.com with ESMTP; 08 Oct 2025 09:06:50 -0700
Date: Thu, 9 Oct 2025 00:28:52 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: Re: [PATCH] rust: fix path to rust_root_crate.sh
Message-ID: <aOaRRH5VBQkSVmUB@intel.com>
References: <20251007194427.118871-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251007194427.118871-1-stefanha@redhat.com>
Received-SPF: pass client-ip=192.198.163.7; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
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

On Tue, Oct 07, 2025 at 03:44:27PM -0400, Stefan Hajnoczi wrote:
> Date: Tue,  7 Oct 2025 15:44:27 -0400
> From: Stefan Hajnoczi <stefanha@redhat.com>
> Subject: [PATCH] rust: fix path to rust_root_crate.sh
> 
> Generated Rust root crate source files contain the wrong path to the
> rust_root_crate.sh script.
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  scripts/rust/rust_root_crate.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


