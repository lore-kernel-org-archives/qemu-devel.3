Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ADF6E7718B
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Dec 2024 08:36:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQMs3-0001mz-EQ; Wed, 25 Dec 2024 03:35:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tQMs2-0001mh-4A
 for qemu-devel@nongnu.org; Wed, 25 Dec 2024 03:35:58 -0500
Received: from mgamail.intel.com ([192.198.163.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tQMrz-00042h-6c
 for qemu-devel@nongnu.org; Wed, 25 Dec 2024 03:35:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1735115755; x=1766651755;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=uO6hCPgf7javtmzMy1gVoLHPESpB6844lQlM8zhgMYs=;
 b=ThAA3PbjbDxkMqjmRn1V3WknhidEutHwea63SFvHR9xPQdRcJ8Zi92tM
 x1htxJc00Xgvj3li83MZh4efCCg8TnViAJoYFW8iQXNt5Er+l8dWiM9Vu
 lxS8nfnjEMVjbfcviLHm5PgYhFtosAEaYsqVEPqACw9a7nbytVyKiFnZD
 Nbnn0fyP2fRJJtkeEWMBL3lJmNJhrZa2nUpWkxG4sP0BPYuKRW9UH3KI9
 xZCO+b4BnYk5eoz+4ojxvpziHm5D3iQBZlHou1dHtonqM39VBZSy8A2TB
 cATfqI+UhziV3RLtpKzSC1/bag9RFd4GM0bzlWq8lKoWzbpl+AyaqH1Va Q==;
X-CSE-ConnectionGUID: RFBEv0iaTr6EMI1Z84H51w==
X-CSE-MsgGUID: d8UbsMLqR0idF+l4ztlZ+A==
X-IronPort-AV: E=McAfee;i="6700,10204,11296"; a="34875250"
X-IronPort-AV: E=Sophos;i="6.12,262,1728975600"; d="scan'208";a="34875250"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Dec 2024 00:35:51 -0800
X-CSE-ConnectionGUID: WPEfVdSkRwmH4HfSVDGcLA==
X-CSE-MsgGUID: AQkrzgyTQam2zcWCvdddLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="100495477"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa008.jf.intel.com with ESMTP; 25 Dec 2024 00:35:51 -0800
Date: Wed, 25 Dec 2024 16:54:32 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, junjie.mao@hotmail.com
Subject: Re: [PATCH 01/12] rust: qom: add ParentField
Message-ID: <Z2vISD28uK11AevU@intel.com>
References: <20241220142955.652636-1-pbonzini@redhat.com>
 <20241220142955.652636-2-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241220142955.652636-2-pbonzini@redhat.com>
Received-SPF: pass client-ip=192.198.163.18; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
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

On Fri, Dec 20, 2024 at 03:29:43PM +0100, Paolo Bonzini wrote:
> Date: Fri, 20 Dec 2024 15:29:43 +0100
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 01/12] rust: qom: add ParentField
> X-Mailer: git-send-email 2.47.1
> 
> Add a type that, together with the C function object_deinit, ensures the
> correct drop order for QOM objects relative to their superclasses.
> 
> Right now it is not possible to implement the Drop trait for QOM classes
> that are defined in Rust, as the drop() function would not be called when
> the object goes away; instead what is called is ObjectImpl::INSTANCE_FINALIZE.
> It would be nice for INSTANCE_FINALIZE to just drop the object, but this has
> a problem: suppose you have
> 
>    pub struct MySuperclass {
>        parent: DeviceState,
>        field: Box<MyData>,
>        ...
>    }
> 
>    impl Drop for MySuperclass {
>        ...
>    }
> 
>    pub struct MySubclass {
>        parent: MySuperclass,
>        ...
>    }
> 
> and an instance_finalize implementation that is like
> 
>     unsafe extern "C" fn drop_object<T: ObjectImpl>(obj: *mut Object) {
>         unsafe { std::ptr::drop_in_place(obj.cast::<T>()) }
>     }
> 
> When instance_finalize is called for MySubclass, it will walk the struct's
> list of fields and call the drop method for MySuperclass.  Then, object_deinit
> recurses to the superclass and calls the same drop method again.  This
> will cause double-freeing of the Box<Data>.
> 
> What's happening here is that QOM wants to control the drop order of
> MySuperclass and MySubclass's fields.  To do so, the parent field must
> be marked ManuallyDrop<>, which is quite ugly.  Instead, add a wrapper
> type ParentField<> that is specific to QOM.  This hides the implementation
> detail of *what* is special about the ParentField, and will also be easy
> to check in the #[derive(Object)] macro.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  rust/hw/char/pl011/src/device.rs |  6 ++--
>  rust/qemu-api/src/qom.rs         | 56 +++++++++++++++++++++++++++++---
>  rust/qemu-api/tests/tests.rs     |  4 +--
>  3 files changed, 57 insertions(+), 9 deletions(-)

...

>  unsafe extern "C" fn rust_instance_init<T: ObjectImpl>(obj: *mut Object) {
>      // SAFETY: obj is an instance of T, since rust_instance_init<T>
>      // is called from QOM core as the instance_init function
> @@ -151,8 +198,9 @@ fn as_ref(&self) -> &$parent {
>  ///
>  /// - the struct must be `#[repr(C)]`;
>  ///
> -/// - the first field of the struct must be of the instance struct corresponding
> -///   to the superclass, which is `ObjectImpl::ParentType`
> +/// - the first field of the struct must be of type
> +///   [`ParentField<T>`](ParentField), where `T` is the parent type
> +///   [`ObjectImpl::ParentType`]
>  ///
>  /// - likewise, the first field of the `Class` must be of the class struct
>  ///   corresponding to the superclass, which is `ObjectImpl::ParentType::Class`.

I think the "likewise" word should be deleted as well, since Class'
parent field doesn't need any wrapper because Class also doesn't have
finalize method. The remaining description is clear enough.

Others look good to me!

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>



