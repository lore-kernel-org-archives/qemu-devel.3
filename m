Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DED41C02198
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 08:56:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfxga-0002Fu-OR; Thu, 06 Feb 2025 03:56:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tfxgD-0002Bl-H1; Thu, 06 Feb 2025 03:56:18 -0500
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tfxg8-0002ul-Rp; Thu, 06 Feb 2025 03:56:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738832169; x=1770368169;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=fQR0TLXvClroks2hWUKN6sdJ/ANfiOsQYzy7EqbMrBY=;
 b=JQ2KBkOORLW4UabyNk565UpRPkb6jXtT3u4hge9Cz/lc2dK1JmWDW97+
 6PYRYocENKvfTDlLXFF1PINhHMjavY4gqK/7N4xRKoqBZnn9oECycv2Ed
 Rv7UjYq1NTEkftKz+nKwmZ0WfroFyEHuARe8VBhyioRlMDujdBMzpLeYP
 ouDiY6MUZXfJVMV0X1zyPaslWV3rjsDvI3a7A/R/WuM8WA3W/oBwpYdcq
 uOnjBs2e+ujPiqpjXC1IAfyJCX8LuHTxVEln4Neqwsm6szhjG8O2k7znq
 Mxi/1BbDUrYopCM34PwIyDf7moPNlve7qal3v6D4SYRqm+bK3BpIO/viD Q==;
X-CSE-ConnectionGUID: SB2dIfk6TJK3n5E22BoOpQ==
X-CSE-MsgGUID: gX+Wl2UcS3CJvr3PHYrCHQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="39581772"
X-IronPort-AV: E=Sophos;i="6.13,264,1732608000"; d="scan'208";a="39581772"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Feb 2025 00:56:05 -0800
X-CSE-ConnectionGUID: tKe42gNZRVW18Dv+i0Xeog==
X-CSE-MsgGUID: ikoylS+lScihDs/eA7etcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,264,1732608000"; d="scan'208";a="111350079"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa008.fm.intel.com with ESMTP; 06 Feb 2025 00:56:03 -0800
Date: Thu, 6 Feb 2025 17:15:33 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
Subject: Re: [PATCH 10/10] rust: bindings for MemoryRegionOps
Message-ID: <Z6R9tSD5T5tkCYsP@intel.com>
References: <20250117194003.1173231-1-pbonzini@redhat.com>
 <20250117194003.1173231-11-pbonzini@redhat.com>
 <Z5d4PTtIRhgZ0tss@intel.com>
 <CABgObfYc5ccC16=K7KVmdLP-jmvwVbxqv1L6c4Oe55MSK4ndng@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABgObfYc5ccC16=K7KVmdLP-jmvwVbxqv1L6c4Oe55MSK4ndng@mail.gmail.com>
Received-SPF: pass client-ip=192.198.163.15; envelope-from=zhao1.liu@intel.com;
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

> > > +pub struct MemoryRegionOps<T>(
> > > +    bindings::MemoryRegionOps,
> > > +    // Note: quite often you'll see PhantomData<fn(&T)> mentioned when discussing
> > > +    // covariance and contravariance; you don't need any of those to understand
> > > +    // this usage of PhantomData.  Quite simply, MemoryRegionOps<T> *logically*
> > > +    // holds callbacks that take an argument of type &T, except the type is erased
> > > +    // before the callback is stored in the bindings::MemoryRegionOps field.
> > > +    // The argument of PhantomData is a function pointer in order to represent
> > > +    // that relationship; while that will also provide desirable and safe variance
> > > +    // for T, variance is not the point but just a consequence.
> > > +    PhantomData<fn(&T)>,
> > > +);
> >
> > Wow, it can be wrapped like this!
> 
> I like your enthusiasm but I'm not sure what you refer to. ;) Maybe
> it's worth documenting this pattern, so please tell me more (after
> your holidays).

Throughout the entire holiday, I couldn't think of a better way to
express this. I find it particularly useful when wrapping multiple
callbacks. In the future, I want to explore more use cases where this
pattern can be applied.

> > > +impl MemoryRegion {
> > > +    // inline to ensure that it is not included in tests, which only
> > > +    // link to hwcore and qom.  FIXME: inlining is actually the opposite
> > > +    // of what we want, since this is the type-erased version of the
> > > +    // init_io function below.  Look into splitting the qemu_api crate.
> >
> > Ah, I didn't understand the issue described in this comment. Why would
> > inlining affect the linking of tests?
> 
> If you don't inline it, do_init_io will always be linked into the
> tests because it is a non-generic function. The tests then fail to
> link, because memory_region_init_io is undefined.

I find even if I drop the `inline` attribution, the test.rs can still be
compiled (by `make check`), I think it's because test.rs hasn't involved
memory related tests so that do_init_io isn't linked into test.rs.

> This is ugly because do_init_io exists *exactly* to extract the part
> that is not generic. (See
> https://users.rust-lang.org/t/soft-question-significantly-improve-rust-compile-time-via-minimizing-generics/103632/8
> for an example of this; I think there's even a procedural macro crate
> that does that for you, but I can't find it right now).

Thanks! I see. I agree to keep `inline` anyway.


