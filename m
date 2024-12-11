Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29B6CE7717D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 08:30:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLI68-0001WR-Gd; Wed, 11 Dec 2024 03:29:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tLI67-0001WF-NF; Wed, 11 Dec 2024 03:29:31 -0500
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tLI61-0004f0-Ln; Wed, 11 Dec 2024 03:29:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1733905766; x=1765441766;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=fpdGrgg/u8jB2bTx3wdentdKExrhoV3HbZoCmgbv02Y=;
 b=IGWXVJUYikodIKWiO1AiQn/SUSoUnozCvP8fiYxIVrDJ2f+aTK9HS1XN
 r2WzuqZwhr2Exgt+eGzixomOz0oMqPWt4/xmNzDnMVUtGPUJvxLWuVTtT
 HjI/mJuyW6FzPtXk7i2GVFQp79+Lw84FsjBRzdczzrkWE9D236ikGMzAv
 1oYM2JGj1TfZBBQKQkyuvcx7WkW4HP3gPHex9O8ZuulpnyKIQ04hQh+gt
 h626QiQx8D3rxJwM88OnHzmRMdlaGpG/tmhzBO4MI14MQjEZ3bDAHMFqa
 brCSGwAXKbJheWW2BmbvgH0ZtNbP5DoaF0MiylCt1zrJuWTYQvO7P1jK4 g==;
X-CSE-ConnectionGUID: i8hmbTKwQ8GkkM5CXuOdZw==
X-CSE-MsgGUID: +ZJfYn0HSaiqEtTaqDITmw==
X-IronPort-AV: E=McAfee;i="6700,10204,11282"; a="38059022"
X-IronPort-AV: E=Sophos;i="6.12,225,1728975600"; d="scan'208";a="38059022"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Dec 2024 00:29:23 -0800
X-CSE-ConnectionGUID: uQCvDu32T2efNr51pMD0LQ==
X-CSE-MsgGUID: 5ZNBchjbS3ez3//O3IFNPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,225,1728975600"; d="scan'208";a="96077937"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa010.fm.intel.com with ESMTP; 11 Dec 2024 00:29:21 -0800
Date: Wed, 11 Dec 2024 16:47:36 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org,
 Junjie Mao <junjie.mao@hotmail.com>
Subject: Re: [PATCH 16/26] rust: qom: change the parent type to an associated
 type
Message-ID: <Z1lRqJnB/o3UJ5q8@intel.com>
References: <20241209123717.99077-1-pbonzini@redhat.com>
 <20241209123717.99077-17-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241209123717.99077-17-pbonzini@redhat.com>
Received-SPF: pass client-ip=198.175.65.14; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.52,
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

On Mon, Dec 09, 2024 at 01:37:07PM +0100, Paolo Bonzini wrote:
> Date: Mon,  9 Dec 2024 13:37:07 +0100
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 16/26] rust: qom: change the parent type to an associated
>  type
> X-Mailer: git-send-email 2.47.1
> 
> Avoid duplicated code to retrieve the QOM type strings from the
> Rust type.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  rust/hw/char/pl011/src/device.rs | 6 ++++--
>  rust/qemu-api/src/definitions.rs | 8 ++------
>  rust/qemu-api/tests/tests.rs     | 3 +--
>  3 files changed, 7 insertions(+), 10 deletions(-)
> 

...
> @@ -76,11 +76,7 @@ pub trait ObjectImpl: ObjectType + ClassInitImpl {
>  
>      const TYPE_INFO: TypeInfo = TypeInfo {
>          name: Self::TYPE_NAME.as_ptr(),
> -        parent: if let Some(pname) = Self::PARENT_TYPE_NAME {
> -            pname.as_ptr()
> -        } else {
> -            core::ptr::null_mut()
> -        },
> +        parent: Self::ParentType::TYPE_NAME.as_ptr(),

Object is implemented at C side, so at leaset the ParentType should be
TYPE_OBJECT.

>          instance_size: core::mem::size_of::<Self>(),
>          instance_align: core::mem::align_of::<Self>(),
>          instance_init: match Self::INSTANCE_INIT {

Great!

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


