Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD559CD8CB9
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 14:15:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXJhn-0007g9-MA; Wed, 10 Jun 2026 10:14:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1wXJhl-0007fc-9G; Wed, 10 Jun 2026 10:14:53 -0400
Received: from mgamail.intel.com ([198.175.65.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1wXJhj-0000Cd-I7; Wed, 10 Jun 2026 10:14:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781100891; x=1812636891;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=u5B2JAvem5tUT4Xhm6L6GDKFQz9xXwYqRjog62rVbns=;
 b=KJ7kSVXfJJzl8ffY7A062do60IIN3ba9btQrEGCFsEaHZsxQvvBmwrNx
 DDHvYECom1AxtlYBjaUSNZLBR8sKZa6tJcq/O9DKtfjHJMtRMadpK/pzN
 h8y04vxVbccWygelT1QeEIc4Es3dukBbl08LR3NezM5/TH+/YGPji4/ch
 PvwLjIWuIzfV8hJ9sAZkgH+EVZsEVxRqCjWeB8DDn9TdeqB5dxXl7YqmG
 0NetXuZ/uzM1E/8SZkMyeHBQFFC94mfWqoVyPWJFWfkGf0SxhGj7JKnTs
 SKfGS0EwG5BSdvL8f9ft3cEJpSDTXGO2xatX1b8ZEEO6Mb2MlwcziU6u7 g==;
X-CSE-ConnectionGUID: KPOZGWimRZm0/TQw9ZqbvA==
X-CSE-MsgGUID: 0PwNxUdmTqOOOucSctCRYw==
X-IronPort-AV: E=McAfee;i="6800,10657,11812"; a="81871495"
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; d="scan'208";a="81871495"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jun 2026 07:14:46 -0700
X-CSE-ConnectionGUID: vF+rsnUBTNSvPjtr9pNXRQ==
X-CSE-MsgGUID: H2wlLNRzQkif5nuhEIE/jg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; d="scan'208";a="241768159"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa006.fm.intel.com with ESMTP; 10 Jun 2026 07:14:44 -0700
Date: Wed, 10 Jun 2026 22:42:51 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org, armbru@redhat.com,
 marcandre.lureau@redhat.com
Subject: Re: [PATCH v3 13/19] scripts/qapi: pull c_name and lstrip from
 camel_to_upper to caller
Message-ID: <ail369d+m8qF69DB@intel.com>
References: <20260526175618.227743-1-pbonzini@redhat.com>
 <20260526175618.227743-14-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260526175618.227743-14-pbonzini@redhat.com>
Received-SPF: pass client-ip=198.175.65.19; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, May 26, 2026 at 07:56:12PM +0200, Paolo Bonzini wrote:
> Date: Tue, 26 May 2026 19:56:12 +0200
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH v3 13/19] scripts/qapi: pull c_name and lstrip from
>  camel_to_upper to caller
> X-Mailer: git-send-email 2.54.0
> 
> Allow using camel_to_upper for other languages too.
> 
> In particular, the lstrip() is needed to avoid reserved C identifiers,
> for example:
> 
>     typedef enum __org_qemu_x_Enum {
>         __ORG_QEMU_X_ENUM___ORG_QEMU_X_VALUE,
>         __ORG_QEMU_X_ENUM__MAX,
>     } __org_qemu_x_Enum;
> 
> Insulate Rust from this, since underscores have a different meaning
> in Rust (though only for the sake of warnings).
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  scripts/qapi/common.py | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


