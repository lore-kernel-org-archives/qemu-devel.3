Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 421B2C677C4
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Jun 2025 07:53:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPGGQ-0004l5-I2; Wed, 11 Jun 2025 03:52:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uPGGO-0004k2-Nx; Wed, 11 Jun 2025 03:52:49 -0400
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uPGGJ-00061T-8T; Wed, 11 Jun 2025 03:52:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749628363; x=1781164363;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=04SiF/OboX+MLcxzOl8OgSz81IT+tGuMxoZHlGHkKek=;
 b=YvBgxSBkU7sALOJFn4T/F7fCLaceX39KO7UYsT/erxspfmuJKaqG0Pm3
 F1rJ7OLj048em1Zs9T0/d2J/h1zi5lAvbcTt1pnl7HI01LiHIe97mK8Yc
 fMXY5OsWTT92RYErFtUHcoyjciuPqBTPpNuYil7ntJ9xCyUO0V2xoI/z4
 VDg2Qg+A8VxYq4IUDNHQh7vZ4VIFi+b/kRtNgDVRLntzlIUDBKCUaHLlf
 A+e4O6bh3kLX6axqPhudU5ymu6rblSV4xpAiBTmLD8oGs0ikWp1xx5IkD
 V6hPTDnsTsgiok7pPXjQ7X2Gcb51S2gK1PTKjowTrSwmr1+LDkFjWcDsC A==;
X-CSE-ConnectionGUID: Fkz7lXXkQrqQdDUMeIKpgQ==
X-CSE-MsgGUID: nV2kxIM+QaKsaYf9hcJK9g==
X-IronPort-AV: E=McAfee;i="6800,10657,11460"; a="51622168"
X-IronPort-AV: E=Sophos;i="6.16,227,1744095600"; d="scan'208";a="51622168"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Jun 2025 00:52:35 -0700
X-CSE-ConnectionGUID: nwfqJUZuRJehoV7W4+6z7g==
X-CSE-MsgGUID: ZKLkKQ1aTiW5+wo21NhKOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,227,1744095600"; d="scan'208";a="146985878"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa006.jf.intel.com with ESMTP; 11 Jun 2025 00:52:34 -0700
Date: Wed, 11 Jun 2025 16:13:49 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com,
 qemu-rust@nongnu.org, armbru@redhat.com, mkletzan@redhat.com
Subject: Re: [PATCH preview 0/3] reviving minimal QAPI generation from 2021
Message-ID: <aEk6vdosWZgyQGXD@intel.com>
References: <20250605101124.367270-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250605101124.367270-1-pbonzini@redhat.com>
Received-SPF: pass client-ip=198.175.65.21; envelope-from=zhao1.liu@intel.com;
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

On Thu, Jun 05, 2025 at 12:11:21PM +0200, Paolo Bonzini wrote:
> Date: Thu,  5 Jun 2025 12:11:21 +0200
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH preview 0/3] reviving minimal QAPI generation from 2021
> X-Mailer: git-send-email 2.49.0
> 
> This is just an extremely minimal extraction from the patches at
> https://patchew.org/QEMU/20210907121943.3498701-1-marcandre.lureau@redhat.com/,
> limited to generating structs and enums from the QAPI schema.
> It does not include them in any crate and does not compile them.
> 
> While I'm not going to work on this, I was curious how much work it
> was to produce *some* kind of Rust QAPI struct, which could be a first
> step towards using serde as an interface to C visitors, like this:
> 
> trait QapiType: FreeForeign {
>     unsafe fn visit(v: bindings::Visitor, name: *const c_char, obj: *mut <Self as FreeForeign>::Foreign, errp: *mut *mut bindings::Error);
> }
> 
> fn to_c<T: QAPIType>(obj: &T) -> *mut <T as FreeForeign>::Foreign {
>     let mut ptr = libc::calloc(...);
>     let mut ser = QapiSerializer::<T>::new(ptr);
>     obj.serialize(&mut ser).unwrap();
>     ptr.cast()
> }
> 
> unsafe fn from_c<T: QAPIType>(obj: *const <T as FreeForeign>::Foreign) -> T {
>     let mut de = QapiDeserializer::new(T::visit, obj as *const c_void);
>     let value = de::Deserialize::deserialize(&mut de).unwrap();
>     de.end().unwrap();
>     value
> }
> 
> /* Generated code below: */
> 
> impl QapiType for UefiVariable {
>     unsafe fn visit(v: bindings::Visitor, name: *const c_char, obj: *mut bindings::UefiVariable, errp: *mut *mut bindings::Error) {
>         unsafe extern "C" visit_type_DumpGuestMemoryFormat(v: bindings::Visitor, name: *const c_char, obj: *mut bindings::UefiVariable, errp: *mut *mut bindings::Error) {
>         unsafe { visit_type_DumpGuestMemoryFormat(v, name, obj, errp); }
>     }
> }
> 
> impl FreeForeign for UefiVariable {
>     type Foreign = bindings::UefiVariable;

My question seems to be different from Marc-André's...

As patch 3 did, qapi will generate Rust types:

- char* is mapped to String, scalars to there corresponding Rust types
- enums are simply aliased from FFI
- has_foo/foo members are mapped to Option<T>
- lists are represented as Vec<T>
- structures have Rust versions, with To/From FFI conversions

It seems we still need some raw bindings (generated by bindgen) as the
`type Foreign`, and then implement Foreign traits for the Rust
structures generated by this patch.

For this example, UefiVariable is generated by qapi (patch 3) and
bindings::UefiVariable is generated by bindgen. Ah! I feel I'm wrong,
could you please correct me?

Thanks,
Zhao

>     unsafe fn free_foreign(p: *mut bindings::UefiVariable) {
>         unsafe extern "C" qapi_free_UefiVariable(p: *mut bindings::UefiVariable);
>         unsafe { qapi_free_UefiVariable(p); }
>     }
> }
> 
> impl CloneToForeign for UefiVariable {
>     fn clone_to_foreign(&self) -> OwnedPointer<Self> {
>         OwnedPointer::new(qapi::to_c(self))
>     }
> }
> 
> impl FromForeign for UefiVariable {
>     unsafe fn cloned_from_foreign(obj: *const bindings::UefiVariable) -> Self {
>         qapi::from_c(obj)
>     }
> }
> 
> The FFI types could be generated by qapi-gen, as in Marc-André's
> proposal, or from bindgen.
> 
> I am not sure what approach is better---whether to use serde or to
> automatically generate the marshaling and unmarshaling code; and whether
> to use bindgen or generate C-compatible FFI types---but it made sense,
> from the point of view of extracting "some" code from Marc-André's
> proof of concept and enticing other people, :) to start from high-level
> types.
> 

