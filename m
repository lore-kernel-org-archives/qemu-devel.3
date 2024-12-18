Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F5FCE77188
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 14:32:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNv5o-0002ir-Tw; Wed, 18 Dec 2024 09:32:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tNv5n-0002iZ-7F; Wed, 18 Dec 2024 09:32:03 -0500
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tNv5l-0004Sc-4n; Wed, 18 Dec 2024 09:32:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1734532321; x=1766068321;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=lQn+n1AHmBQZlaKonmtE/ndf7VLJYjcoTcINcciu0b8=;
 b=E0U26ValexPT6ED3Z7FT1gtZLuk426RIZaX9U5UCl8WKQoZbwc8i9dUU
 hX/0xIK8dhP4RZ0+LwqogZPvAOi+Qq4qTdHUAs4/2VtvNZ/UE0HcTp14n
 E7RGzWvw88y9iozGCNl2L1c4iMrXkCMq+I8vnVMxq4nApINnwDpGMYo79
 NZltHP4Z0/u5tEL8H7Eeg36133Go5CT1lhSxcEXOnqU3kQ0UfKITclf+F
 RB5HtAPK6miWSmNevuGzrsnhVnN4nv2a5tTNrn11Ek9hZAD+Q14jvXPsa
 AeAeSE7qlD0ntgSfCvdaUkaNz8DInHp+1JrzvUpAW0TmhVL+XrAW4ra3Q w==;
X-CSE-ConnectionGUID: wRCPMQQ+RkKZtDGnpjTkHw==
X-CSE-MsgGUID: bqyiM8EoTkqgkBIlxay2jw==
X-IronPort-AV: E=McAfee;i="6700,10204,11290"; a="37848945"
X-IronPort-AV: E=Sophos;i="6.12,244,1728975600"; d="scan'208";a="37848945"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Dec 2024 06:27:54 -0800
X-CSE-ConnectionGUID: YDU5rfTiQZuSXPiHBvbzYQ==
X-CSE-MsgGUID: Ea37yrEqRKiWWAPJG5zVww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,244,1728975600"; d="scan'208";a="128670474"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa002.jf.intel.com with ESMTP; 18 Dec 2024 06:27:53 -0800
Date: Wed, 18 Dec 2024 22:46:33 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-rust@nongnu.org,
 Junjie Mao <junjie.mao@hotmail.com>
Subject: Re: [PATCH 24/26] rust: qom: move device_id to PL011 class side
Message-ID: <Z2LgScN1f/C3UdcD@intel.com>
References: <20241209123717.99077-1-pbonzini@redhat.com>
 <20241209123717.99077-25-pbonzini@redhat.com>
 <Z2D2zk2Wdlqc5q2k@intel.com>
 <CABgObfY=jyu96eZ+ZcU9GXU+amt2wRm53vpvubHYTaeY9MWd2A@mail.gmail.com>
 <Z2JycooziPsfV8vX@intel.com>
 <CABgObfboJFTRMsuqO055g11ZWNx1qKNxrLgvYLc-Hh6RcmWtOw@mail.gmail.com>
 <d01798d5-1c93-48f7-bb78-d4602a13baac@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d01798d5-1c93-48f7-bb78-d4602a13baac@redhat.com>
Received-SPF: pass client-ip=192.198.163.13; envelope-from=zhao1.liu@intel.com;
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

On Wed, Dec 18, 2024 at 11:26:35AM +0100, Paolo Bonzini wrote:
> Date: Wed, 18 Dec 2024 11:26:35 +0100
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: Re: [PATCH 24/26] rust: qom: move device_id to PL011 class side
> 
> On 12/18/24 08:14, Paolo Bonzini wrote:
> >     Moving on to another topic, about the gap (or question :-)) where a
> >     child class inherits the ClassInitImpl trait from the parent, please see
> >     my test case example below: Doing something similar to SysBusDevice and
> >     DeviceState using a generic T outside of the QOM library would violate
> >     the orphan rule.
> > 
> > Ugh, you're right. Maybe ClassInitImpl should just be merged into
> > ObjectImpl etc. as a default method implementation. I will check.
> 
> Ok, I think we can make it mostly a documentation issue:
> 
> diff --git a/rust/qemu-api/src/qom.rs b/rust/qemu-api/src/qom.rs
> index 2b472915707..ee95eda0447 100644
> --- a/rust/qemu-api/src/qom.rs
> +++ b/rust/qemu-api/src/qom.rs
> @@ -451,13 +451,14 @@ pub trait ObjectImpl: ObjectType + ClassInitImpl<Self::Class> {
>  /// Each struct will implement this trait with `T` equal to each
>  /// superclass.  For example, a device should implement at least
>  /// `ClassInitImpl<`[`DeviceClass`](crate::qdev::DeviceClass)`>` and
> -/// `ClassInitImpl<`[`ObjectClass`]`>`.
> +/// `ClassInitImpl<`[`ObjectClass`]`>`.  Such implementations are
> +/// made in one of two ways.
>  ///
> -/// Fortunately, this is almost never necessary.  Instead, the Rust
> -/// implementation of methods will usually come from a trait like
> -/// [`ObjectImpl`] or [`DeviceImpl`](crate::qdev::DeviceImpl).
> -/// `ClassInitImpl` then can be provided by blanket implementations
> -/// that operate on all implementors of the `*Impl`* trait.  For example:
> +/// For most superclasses, `ClassInitImpl` is provided by the `qemu-api`
> +/// crate itself.  The Rust implementation of methods will come from a
> +/// trait like [`ObjectImpl`] or [`DeviceImpl`](crate::qdev::DeviceImpl),
> +/// and `ClassInitImpl` is provided by blanket implementations that
> +/// operate on all implementors of the `*Impl`* trait.  For example:
>  ///
>  /// ```ignore
>  /// impl<T> ClassInitImpl<DeviceClass> for T
> @@ -469,11 +470,37 @@ pub trait ObjectImpl: ObjectType + ClassInitImpl<Self::Class> {
>  /// after initializing the `DeviceClass` part of the class struct,
>  /// the parent [`ObjectClass`] is initialized as well.
>  ///
> -/// The only case in which a manual implementation of the trait is needed
> -/// is for interfaces (note that there is no Rust example yet for using
> -/// interfaces).  In this case, unlike the C case, the Rust class _has_
> -/// to define its own class struct `FooClass` to go together with
> -/// `ClassInitImpl<FooClass>`.
> +/// In some other cases, manual implementation of the trait is needed.
> +/// These are the following:
> +///
> +/// * for classes that implement interfaces, the Rust code _has_
> +///   to define its own class struct `FooClass` and implement
> +///   `ClassInitImpl<FooClass>`.  `ClassInitImpl<FooClass>`'s
> +///   `class_init` method will then forward to multiple other
> +///   `class_init`s, for the interfaces as well as the superclass.
> +///   (Note that there is no Rust example yet for using
> +///   interfaces).
> +///
> +/// * for classes implemented outside the ``qemu-api`` crate, it's
> +///   not possible to add blanket implementations like the above one,
> +///   due to orphan rules.  In that case, the easiest solution is to
> +///   implement `ClassInitImpl<YourSuperclass>` for each subclass,
> +///   and not have a `YourSuperclassImpl` trait at all:
> +///
> +///   ```ignore
> +///   impl ClassInitImpl<YourSuperclass> for YourSubclass {
> +///       fn class_init(klass: &mut YourSuperclass) {
> +///           klass.some_method = Some(Self::some_method);
> +///           <Self as ClassInitImpl<SysBusDeviceClass>>::class_init(&mut klass.parent_class);
> +///       }
> +///   }
> +///   ```

BTW, maybe we could also squash my previous example in test? :-)

> +///
> +///   While this method incurs a small amount of code duplication,
> +///   it is generally limited to the recursive call on the last line.
> +///   This is because classes defined in Rust do not need the same
> +///   glue code that is needed when the classes are defined in C code.

Now I understand this advantage.

> +///   You may consider using a macro if you have many subclasses.

Yes, a custom macro is enough!

>  pub trait ClassInitImpl<T> {
>      /// Initialize `klass` to point to the virtual method implementations
>      /// for `Self`.  On entry, the virtual method pointers are set to

All the above changes look good to me!

> Optionally, something like this can be squashed in this patch, but I
> do not think it's worth the savings of... 3 lines of code:
> 
> diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
> index 41220c99a83..cbd3abb96ec 100644
> --- a/rust/hw/char/pl011/src/device.rs
> +++ b/rust/hw/char/pl011/src/device.rs
> @@ -46,11 +46,6 @@ fn index(&self, idx: hwaddr) -> &Self::Output {
>      }
>  }
> -impl DeviceId {
> -    const ARM: Self = Self(&[0x11, 0x10, 0x14, 0x00, 0x0d, 0xf0, 0x05, 0xb1]);
> -    const LUMINARY: Self = Self(&[0x11, 0x00, 0x18, 0x01, 0x0d, 0xf0, 0x05, 0xb1]);
> -}
> -
>  #[repr(C)]
>  #[derive(Debug, qemu_api_macros::Object, qemu_api_macros::offsets)]
>  /// PL011 Device Model in QEMU
> @@ -112,7 +107,8 @@ unsafe impl ObjectType for PL011State {
>  impl ClassInitImpl<PL011Class> for PL011State {
>      fn class_init(klass: &mut PL011Class) {
> -        klass.device_id = DeviceId::ARM;
> +        klass.device_id = DeviceId(&[0x11, 0x10, 0x14, 0x00, 0x0d, 0xf0, 0x05, 0xb1]);
> +
>          <Self as ClassInitImpl<SysBusDeviceClass>>::class_init(&mut klass.parent_class);
>      }
>  }
> @@ -628,7 +624,8 @@ pub struct PL011Luminary {
>  impl ClassInitImpl<PL011Class> for PL011Luminary {
>      fn class_init(klass: &mut PL011Class) {
> -        klass.device_id = DeviceId::LUMINARY;
> +        klass.device_id = DeviceId(&[0x11, 0x00, 0x18, 0x01, 0x0d, 0xf0, 0x05, 0xb1]);
> +
>          <Self as ClassInitImpl<SysBusDeviceClass>>::class_init(&mut klass.parent_class);
>      }
>  }

Still fine for me. :-)

Regards,
Zhao



