Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E639C02181
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2025 12:59:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taaJT-0002dX-Q2; Wed, 22 Jan 2025 07:58:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1taaJJ-0002cr-I2; Wed, 22 Jan 2025 07:58:22 -0500
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1taaJG-0000eJ-EN; Wed, 22 Jan 2025 07:58:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1737550698; x=1769086698;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=ipbAxuZxFhW142d2e62uwekR4pXBAo3dPEEOMmcq0as=;
 b=LaAm8Kym9xNRBYq5+Mz6i4icnI1zR+uVbV0dt730URLEPkJteOH+GeOf
 5xjutfJJBxhQ19qhE+fAZatE0xs7HQggXrY/RqxpS+cJJEJcdVJxFuGoK
 Cs5eiTo5QVFjXfGewgyPXs5AVnJ/j9wdMyRxXghuB1aFhfLnZ2/ovLVmv
 Ifh2UMkCbCv1Wi7gGTmpioArfiwCo1hwbfTjs+lvlKIY/ecs/Qtd/vQDe
 UBX00NFTBJsRxUKPjULIL0B90Uw9aRu5AP5gue8AC/qh+o3ae3CEK7doT
 BJYQzHKkc/esa90kyXhnsCFD+W/RZqAbprfEz3ZaqCEyFzto0l1tqMEBS Q==;
X-CSE-ConnectionGUID: z8L4j1J8QumDrj8ILPzxEg==
X-CSE-MsgGUID: zNBF1ZMeQsqfztNTveXTTQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11322"; a="63356912"
X-IronPort-AV: E=Sophos;i="6.13,225,1732608000"; d="scan'208";a="63356912"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jan 2025 04:58:05 -0800
X-CSE-ConnectionGUID: hWj8Iu2bThSGWl7ipDXx4A==
X-CSE-MsgGUID: Fk7CudnCTI2BXBialRV4ZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="107003265"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa010.jf.intel.com with ESMTP; 22 Jan 2025 04:58:05 -0800
Date: Wed, 22 Jan 2025 21:17:26 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
Subject: Re: [PATCH 07/10] rust: qemu_api: add vmstate_struct
Message-ID: <Z5Dv5pQYiXxMA7w+@intel.com>
References: <20250117090046.1045010-1-pbonzini@redhat.com>
 <20250117090046.1045010-8-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250117090046.1045010-8-pbonzini@redhat.com>
Received-SPF: pass client-ip=192.198.163.7; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -73
X-Spam_score: -7.4
X-Spam_bar: -------
X-Spam_report: (-7.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
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

On Fri, Jan 17, 2025 at 10:00:43AM +0100, Paolo Bonzini wrote:
> Date: Fri, 17 Jan 2025 10:00:43 +0100
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 07/10] rust: qemu_api: add vmstate_struct
> X-Mailer: git-send-email 2.47.1
> 
> It is not type safe, but it's the best that can be done without
> const_refs_static.  It can also be used with BqlCell and BqlRefCell.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  rust/qemu-api/src/vmstate.rs | 33 +++++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)

...

> +#[doc(alias = "VMSTATE_STRUCT")]
> +#[macro_export]
> +macro_rules! vmstate_struct {
> +    ($struct_name:ty, $field_name:ident $([0 .. $num:ident $(* $factor:expr)?])?, $vmsd:expr, $type:ty $(,)?) => {
> +        $crate::bindings::VMStateField {
> +            name: ::core::concat!(::core::stringify!($field_name), "\0")
> +                .as_bytes()
> +                .as_ptr() as *const ::std::os::raw::c_char,
> +            $(.num_offset: $crate::offset_of!($struct_name, $num),)?
> +            offset: {
> +                $crate::assert_field_type!($struct_name, $field_name, $type);
> +                $crate::offset_of!($struct_name, $field_name)
> +            },
> +            size: ::core::mem::size_of::<$type>(),
> +            flags: $crate::bindings::VMStateFlags::VMS_STRUCT,
> +            vmsd: unsafe { $vmsd },

Yes, this `unsafe` is fitting.

> +            ..$crate::zeroable::Zeroable::ZERO $(
> +                .with_varray_flag($crate::call_func_with_field!(
> +                    $crate::vmstate::vmstate_varray_flag,
> +                    $struct_name,
> +                    $num))
> +               $(.with_varray_multiply($factor))?)?
> +        }
> +    };
> +}
> +

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


