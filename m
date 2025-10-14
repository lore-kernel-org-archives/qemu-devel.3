Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0EE2CCD184
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 04:57:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8X5c-0007Vr-JP; Tue, 14 Oct 2025 00:56:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1v8X5a-0007VT-7R
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 00:56:46 -0400
Received: from mgamail.intel.com ([192.198.163.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1v8X5X-0002Zd-Hn
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 00:56:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760417804; x=1791953804;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=3w0qkxDq2tXlfDXFJaaWsCgIzXkP+lGC6jqtPbe1cho=;
 b=GGMyailE0nnKR53/Qx8v+rFEH4JIDhjsmgWs22JqVo/2iGhFkB3GO73/
 nM6aIT/YxityzUZf21+9vQ6tEg2wSb99aJyrLfhgMSFQj/7duLxTj7oi/
 yDQRgP0ZfExnbEX0imKM5EOgPwjD3QZAbhYs5RFf1k6mgcclQlVINup8a
 wJ0uBCQWXL/tGhY5kqFjZfdLi+sA9GO2zRcaMzbJR8jMr1lq021dN6Hks
 B9m831JIXP1OU1nnYibu8kfbm9K7YQpTUolSv35Sz442rc6gTEoUn21c5
 C6TQTtQInRtp2B8wn2CYTKZk5SirXYiM8dJ6A+HBEfhU5KMWa+I80gPC3 g==;
X-CSE-ConnectionGUID: fNJIiC4UQNG/fFNHattWvg==
X-CSE-MsgGUID: 41R2tBUPQzauQjKzhCR/dA==
X-IronPort-AV: E=McAfee;i="6800,10657,11581"; a="61779168"
X-IronPort-AV: E=Sophos;i="6.19,227,1754982000"; d="scan'208";a="61779168"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Oct 2025 21:56:41 -0700
X-CSE-ConnectionGUID: C6ROJ3dYRGGPDsjVPabEVw==
X-CSE-MsgGUID: 94xaixZIRmGkdTGJIaxGDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,227,1754982000"; d="scan'208";a="185804304"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa003.jf.intel.com with ESMTP; 13 Oct 2025 21:56:40 -0700
Date: Tue, 14 Oct 2025 13:18:44 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 11/11] rust: migration: implement ToMigrationState as
 part of impl_vmstate_bitsized
Message-ID: <aO3dNAqr0ijuTDeI@intel.com>
References: <20251001075005.1041833-1-pbonzini@redhat.com>
 <20251001075210.1042479-11-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251001075210.1042479-11-pbonzini@redhat.com>
Received-SPF: pass client-ip=192.198.163.18; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Wed, Oct 01, 2025 at 09:52:10AM +0200, Paolo Bonzini wrote:
> Date: Wed,  1 Oct 2025 09:52:10 +0200
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 11/11] rust: migration: implement ToMigrationState as part
>  of impl_vmstate_bitsized
> X-Mailer: git-send-email 2.51.0
> 
> This is most likely desirable, and is the easiest way to migrate
> a bit-sized value without peeking at the innards of the bilge crate.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  rust/migration/src/vmstate.rs | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


