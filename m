Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EBA4D0C5F9
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2024 09:49:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4GwQ-0005Zb-5m; Fri, 25 Oct 2024 05:49:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t4GwN-0005Z3-EA
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 05:49:07 -0400
Received: from mgamail.intel.com ([198.175.65.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t4GwL-0004u7-Pz
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 05:49:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1729849746; x=1761385746;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=m3Wfu3++iK9KnA4c8PdVi4vqpS66wqp4zYKoFwGFA1c=;
 b=Vy38ux8MtHjiiwtYdGNt7DF4L0QaW7ecfpJegVxbW0IIkkEhDFcylnu7
 keXA68yeZ9cCgiFtnFm+BZOdKMo+8jH/REeX9kqWjcr5UGup/nl/SgXkH
 U6XPM3O4bICET6WATdub8JhKlaN8rka5cIkYwd3wtDQY+jmWQkrktlHWv
 wjDOlCmk1OleS6Dk8zh3NT4cTZqSVJseGmdhg5JTBblYsgg9VRk0nyMvW
 PdfCwyQOk+Z2J98AepIJpyceSsilVayHJ3L/AmBsZPVR7P/JwLWbjeKar
 Wo8O6hREbAuPZL5+FLnpKRgy6Q6iTFLtpo7PeqmPLoPfutyJjQwNIYyVX Q==;
X-CSE-ConnectionGUID: ks/Nr0VURK+WIBRZHNEnhA==
X-CSE-MsgGUID: wh0iIVMHTr+VjIEulVTtNQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="29374427"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; d="scan'208";a="29374427"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Oct 2024 02:49:04 -0700
X-CSE-ConnectionGUID: wVXFr2yXT9SEG2WpzMmw+g==
X-CSE-MsgGUID: O43oNQbLSFOkL4U0fH05kw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,231,1725346800"; d="scan'208";a="85429399"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa005.fm.intel.com with ESMTP; 25 Oct 2024 02:49:02 -0700
Date: Fri, 25 Oct 2024 18:05:20 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Junjie Mao <junjie.mao@hotmail.com>
Subject: Re: [PATCH v2 13/13] rust: do not use TYPE_CHARDEV unnecessarily
Message-ID: <ZxttYDRNxfLg/gUe@intel.com>
References: <20241021163538.136941-1-pbonzini@redhat.com>
 <20241021163538.136941-14-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241021163538.136941-14-pbonzini@redhat.com>
Received-SPF: pass client-ip=198.175.65.19; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.263,
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

On Mon, Oct 21, 2024 at 06:35:38PM +0200, Paolo Bonzini wrote:
> Date: Mon, 21 Oct 2024 18:35:38 +0200
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH v2 13/13] rust: do not use TYPE_CHARDEV unnecessarily
> X-Mailer: git-send-email 2.46.2
> 
> In the invocation of qdev_prop_set_chr(), "chardev" is the name of a
> property rather than a type and has to match the name of the property
> in device_class.rs.  Do not use TYPE_CHARDEV here, just like in the C
> version of pl011_create.
> 
> Reviewed-by: Junjie Mao <junjie.mao@hotmail.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  rust/hw/char/pl011/src/device.rs | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


