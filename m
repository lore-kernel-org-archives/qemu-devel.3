Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2423CC5AD49
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 09:08:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMNd5-0005Aa-Ts; Tue, 03 Jun 2025 05:08:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uMNd4-0005A6-2g; Tue, 03 Jun 2025 05:08:18 -0400
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uMNd0-0004vG-Ro; Tue, 03 Jun 2025 05:08:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1748941695; x=1780477695;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=WMg88f9iGVIBagom6YEmBoKZSCfdB7N97smdC3wE9Q8=;
 b=QK9Da/XmpnXxB90jaCtWgiMaFiDMookJmqLERpdBqRuCgaLcW83rpw3B
 87ISAfiAkIEIv0VODkhF/Moimx1/q0vH+5KzB/iG0gcsJ/gELumO9vvKB
 iGWAKY8I4gnlHfiCoS+5WVSX1fEon90a749zP8GexP2LomkWv0NbgvK+8
 wGUnSDuB14GSzLjOXS1+NNxUbv0ihadQ4jNNb4oeNXZFFEhkSDqy4e1kt
 3Kq9sQ+Gp9V74RC/t/NYnZawm82xCZU7G7BTspkNuGDMOQ7pto70VlAus
 oA5woDIimzgDsU61yyU7Bh0aScHfS99bQ4feOaFp1Np1iNZQd/njTluiF w==;
X-CSE-ConnectionGUID: lVYFTWb+TH+QHOnVujas9w==
X-CSE-MsgGUID: LU6b/rRmQ52MPJQs2pr7pA==
X-IronPort-AV: E=McAfee;i="6700,10204,11451"; a="73504539"
X-IronPort-AV: E=Sophos;i="6.16,205,1744095600"; d="scan'208";a="73504539"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2025 02:08:11 -0700
X-CSE-ConnectionGUID: EmzvGMGDRWiOb5x83y25JQ==
X-CSE-MsgGUID: 5aPSnWKKSVSBkMpF6KE4jw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,205,1744095600"; d="scan'208";a="149847356"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa004.jf.intel.com with ESMTP; 03 Jun 2025 02:08:08 -0700
Date: Tue, 3 Jun 2025 17:29:19 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 qemu-rust@nongnu.org
Subject: Re: [PATCH 06/14] rust: qemu-api: add bindings to Error
Message-ID: <aD7AbxghCc5VYDhu@intel.com>
References: <20250530080307.2055502-1-pbonzini@redhat.com>
 <20250530080307.2055502-7-pbonzini@redhat.com>
 <877c1uffj3.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <877c1uffj3.fsf@pond.sub.org>
Received-SPF: pass client-ip=198.175.65.9; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.015,
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

> > +    /// Equivalent of the C function `error_propagate`.  Fill `*errp`
> 
> Uh, is it?  Let's see...
> 
> > +    /// with the information container in `self` if `errp` is not NULL;
> > +    /// then consume it.
> > +    ///
> > +    /// # Safety
> > +    ///
> > +    /// `errp` must be a valid argument to `error_propagate`;
> 
> Reminder for later: the valid @errp arguments for C error_propagate()
> are
> 
> * NULL
> 
> * &error_abort
> 
> * &error_fatal
> 
> * Address of some Error * variable containing NULL
> 
> * Address of some Error * variable containing non-NULL
> 
> The last one is *not* valid with error_setg().
> 
> > +    /// typically it is received from C code and need not be
> > +    /// checked further at the Rust↔C boundary.
> > +    pub unsafe fn propagate(self, errp: *mut *mut bindings::Error) {
> 
> Reminder, just to avoid confusion: C error_propagate() has the arguments
> in the opposite order.
> 
> > +        if errp.is_null() {
> > +            return;
> > +        }
> > +
> > +        let err = self.clone_to_foreign_ptr();
> > +
> > +        // SAFETY: caller guarantees errp is valid
> > +        unsafe {
> > +            errp.write(err);
> > +        }
> > +    }
> 
> In C, we have two subtly different ways to store into some Error **errp
> argument: error_setg() and error_propagate().
> 
> Their obvious difference is that error_setg() creates the Error object
> to store, while error_propagate() stores an existing Error object if
> any, else does nothing.
> 
> Their unobvious difference is behavior when the destination already
> contains an Error.  With error_setg(), this must not happen.
> error_propagate() instead throws away the new error.  This permits
> "first one wins" error accumulation.  Design mistake if you ask me.
> 
> Your Rust propagate() also stores an existing bindings::Error.  Note
> that "else does nothing" doesn't apply, because we always have an
> existing error object here, namely @self.  In the error_propagate() camp
> so far.
> 
> Let's examine the other aspect: how exactly "storing" behaves.
> 
> error_setg() according to its contract:
> 
>     If @errp is NULL, the error is ignored.  [...]
> 
>     If @errp is &error_abort, print a suitable message and abort().
> 
>     If @errp is &error_fatal, print a suitable message and exit(1).
> 
>     If @errp is anything else, *@errp must be NULL.
> 
> error_propagate() according to its contract:
> 
>     [...] if @dst_errp is NULL, errors are being ignored.  Free the
>     error object.
> 
>     Else, if @dst_errp is &error_abort, print a suitable message and
>     abort().
> 
>     Else, if @dst_errp is &error_fatal, print a suitable message and
>     exit(1).
> 
>     Else, if @dst_errp already contains an error, ignore this one: free
>     the error object.
> 
>     Else, move the error object from @local_err to *@dst_errp.
> 
> The second to last clause is where its storing differs from
> error_setg().
> 
> What does errp.write(err) do?  I *guess* it simply stores @err in @errp.
> Matches neither behavior.
> 
> If that's true, then passing &error_abort or &error_fatal to Rust does
> not work, and neither does error accumulation.  Not equivalent of C
> error_propagate().

I did some simple tests. yes, &error_abort or &error_fatal doesn't work.
Current @errp of realize() can work because @errp points to @local_err
in device_set_realized().

> Is "propagate" semantics what you want here?
> 
> If not, use another name.

I guess here we should call C version's error_propagate() instead of
write():

diff --git a/rust/qemu-api/src/error.rs b/rust/qemu-api/src/error.rs
index a91ce6fefaf4..56622065ad22 100644
--- a/rust/qemu-api/src/error.rs
+++ b/rust/qemu-api/src/error.rs
@@ -205,7 +205,7 @@ pub unsafe fn propagate(self, errp: *mut *mut bindings::Error) {

         // SAFETY: caller guarantees errp is valid
         unsafe {
-            errp.write(err);
+            bindings::error_propagate(errp, err);
         }
     }

---

Then Rust's propagate has the same behavior as C (Of course, here Rust
is actually using C's error_propagate, so the two are equivalent.)

Regards,
Zhao



