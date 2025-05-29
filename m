Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E2BBC5AE59
	for <qemu-devel@archiver.kernel.org>; Thu, 29 May 2025 07:59:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKYAH-0005M2-BO; Thu, 29 May 2025 03:59:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uKYA9-0005FH-KF; Thu, 29 May 2025 03:58:54 -0400
Received: from mgamail.intel.com ([192.198.163.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uKYA2-0000F6-Kj; Thu, 29 May 2025 03:58:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1748505527; x=1780041527;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=DGGoseyG1muW2Pj2PQZN4Acck6K2Ob22b9R4grP7w6c=;
 b=aGPNdHwUbmdfpVW2YQlr2eUbH9u/aAPbfx4aChs2nUDgoC6D1H1DHfxz
 CqzwIfQHpQkkijEX63IkawrgP6rB/FeqCSuh0Sn17FEDZ8jDlvo4g2QSe
 vFzefmR4PW2LI+Cre4tVgcAoe8ORmbq0qz/WetFgLncntkMyg5tsaDYzD
 jdQd40K4tI42oCccp0qFsYs8Ep1GeHLO3apEe3S/iXH5fNnbEGXtZxG5N
 Kpr+gCmPNkEsZQcbyG/9YdV55TidVo+O9F/IF8fcw5/p2UqydLywNAgST
 H5WrBfWjHsVF48orQlJsIcyC9JNKMoop+VL7YMzOn+r75JKNzjBi+bSZI w==;
X-CSE-ConnectionGUID: NkWiLABDRpeSl/yw8m58TQ==
X-CSE-MsgGUID: jtIuvCGeT/6QA/6C48VZNg==
X-IronPort-AV: E=McAfee;i="6700,10204,11447"; a="61188322"
X-IronPort-AV: E=Sophos;i="6.15,323,1739865600"; d="scan'208";a="61188322"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 May 2025 00:52:33 -0700
X-CSE-ConnectionGUID: 3Be/HnOJQmCBwmnZntQYcg==
X-CSE-MsgGUID: 0L1BrizuTpSkbvv2OMBb0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,323,1739865600"; d="scan'208";a="144125229"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa007.jf.intel.com with ESMTP; 29 May 2025 00:52:31 -0700
Date: Thu, 29 May 2025 16:13:41 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, qemu-rust@nongnu.org
Subject: Re: [PATCH 03/12] subprojects: add the foreign crate
Message-ID: <aDgXNWvh9xCI653S@intel.com>
References: <20250526142254.1061009-1-pbonzini@redhat.com>
 <20250526142455.1061519-3-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250526142455.1061519-3-pbonzini@redhat.com>
Received-SPF: pass client-ip=192.198.163.11; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -72
X-Spam_score: -7.3
X-Spam_bar: -------
X-Spam_report: (-7.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.904,
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

On Mon, May 26, 2025 at 04:24:46PM +0200, Paolo Bonzini wrote:
> Date: Mon, 26 May 2025 16:24:46 +0200
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 03/12] subprojects: add the foreign crate
> X-Mailer: git-send-email 2.49.0
> 
> This is a cleaned up and separated version of the patches at
> https://lore.kernel.org/all/20240701145853.1394967-4-pbonzini@redhat.com/
> https://lore.kernel.org/all/20240701145853.1394967-5-pbonzini@redhat.com/
>
> Its first user will be the Error bindings; for example a QEMU Error ** can be
> converted to a Rust Option using
> 
>      unsafe { Option::<Error>::from_foreign(c_error) }
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  subprojects/.gitignore                        |  1 +
>  subprojects/foreign-0.2-rs.wrap               |  7 +++++

It seems you've already released v0.3.0.

>  .../packagefiles/foreign-0.2-rs/meson.build   | 26 +++++++++++++++++++
>  3 files changed, 34 insertions(+)
>  create mode 100644 subprojects/foreign-0.2-rs.wrap
>  create mode 100644 subprojects/packagefiles/foreign-0.2-rs/meson.build

I went through foreign crate and it was really helpful (and there are also
missing changes as anyhow crate patch). With nits fixed,

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


Maybe off topic, it seems the Owned<T> wrapper is very similar to
OwnedPointer<T>. Is it possible to integrate the two? i.e., build
Owned<T: ObjectType> based on OwnedPointer<T: FreeForeign>?

Thanks,
Zhao


