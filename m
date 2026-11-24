Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D85606A322
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 10:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kamZnkYh
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVnfX-00053n-9b; Tue, 24 Nov 2026 05:22:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1xVnfU-00052D-Pd; Tue, 24 Nov 2026 05:22:33 -0500
Received: from mgamail.intel.com ([192.198.163.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1xVnfR-0008Q7-Fo; Tue, 24 Nov 2026 05:22:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795515750; x=1827051750;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=CDN1O/pggsi6hOP1JqRPTrezMCyX9fCd7H+FP2YiYvA=;
 b=kamZnkYh0aGhrmrKCNbqTNkxW1p1ke2PqGa3RAkhBs70MFSQLVAeIo43
 8f9OAsPbL/+W83l6NjzuE9u74+xFfZbAHIJ1IgR3itW9lZ2kpuJpOvJOp
 eB/FD77BpqyULo1kCAcwNyyLSitTi0UUQeFvtod3lMCuiDbqW/qWP8Vr6
 bv3N26vT4fbDD5i40Ds0G46QWF65z3xIfQF8kj/cfsMjmiRzbcGabLydU
 T8IDrWRbU1YPcnLQOHIWY+LgHHvhfsVBOdmb8Y/GyeT4wBq+OZPmFxL3Y
 /jnLn7pklxs/hXpU12rj/JqZ66qguKknF0p+9Wj+8PvB2BtFHC+ORkmWK A==;
X-CSE-ConnectionGUID: 6hzwufSjT4Gjst4qF7df4Q==
X-CSE-MsgGUID: k3jfGN7nT0mO0dBxWg/LsA==
X-IronPort-AV: E=McAfee;i="6800,10657,11975"; a="4233593"
X-IronPort-AV: E=Sophos;i="6.27,230,1787036400"; 
   d="scan'208";a="4233593"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Nov 2026 02:22:25 -0800
X-CSE-ConnectionGUID: xbp1IpulSUSXxs1WwXZD0w==
X-CSE-MsgGUID: qF6dGcQvQLOebuk0yLOpTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,230,1787036400"; d="scan'208";a="13318705"
Received: from zhaoliu1-desk.sh.intel.com (HELO localhost) ([10.112.226.173])
 by fmviesa011.fm.intel.com with ESMTP; 24 Nov 2026 02:22:22 -0800
Date: Tue, 24 Nov 2026 18:22:21 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>
Cc: Peter Xu <peterx@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 qemu-devel@nongnu.org, qemu-rust@nongnu.org
Subject: Re: [PATCH 2/3] rust/hpet: Move vmstate_validate!() check into
 post_load
Message-ID: <awVlXbIGVsp+xkOL@intel.com>
References: <20261124095814.437738-1-zhao1.liu@intel.com>
 <20261124095814.437738-3-zhao1.liu@intel.com>
 <ae1dc71f-ca73-4175-af3b-767c0adedc79@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae1dc71f-ca73-4175-af3b-767c0adedc79@oss.qualcomm.com>
Received-SPF: pass client-ip=192.198.163.9; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> > -const VMSTATE_HPET: VMStateDescription<HPETState> =
> > -    VMStateDescriptionBuilder::<HPETState>::new()
> > -        .name(c"hpet")
> > -        .version_id(2)
> > -        .minimum_version_id(2)
> > -        .pre_save(&HPETState::pre_save)
> > -        .post_load(&HPETState::post_load)
> > -        .fields(vmstate_fields! {
> > -            vmstate_of!(HPETState, regs),
> > -            vmstate_of!(HPETState, num_timers_save),
> > -            vmstate_validate!(HPETState, VALIDATE_TIMERS_NAME, HPETState::validate_num_timers),
> > -            vmstate_of!(HPETState, timers[0 .. num_timers_save], HPETState::validate_num_timers).with_version_id(0),
> > -        })
> > -        .subsections(vmstate_subsections!(
> > -            VMSTATE_HPET_RTC_IRQ_LEVEL,
> > -            VMSTATE_HPET_OFFSET,
> > -        ))
> > -        .build();
> > +const VMSTATE_HPET: VMStateDescription<HPETState> = VMStateDescriptionBuilder::<HPETState>::new()
> > +    .name(c"hpet")
> > +    .version_id(2)
> > +    .minimum_version_id(2)
> > +    .pre_save(&HPETState::pre_save)
> > +    .post_load(&HPETState::post_load)
> > +    .fields(vmstate_fields! {
> > +        vmstate_of!(HPETState, regs),
> > +        vmstate_of!(HPETState, num_timers_save),
> > +        vmstate_of!(HPETState, timers[0 .. num_timers]).with_version_id(0),
> > +    })
> > +    .subsections(vmstate_subsections!(
> > +        VMSTATE_HPET_RTC_IRQ_LEVEL,
> > +        VMSTATE_HPET_OFFSET,
> > +    ))
> > +    .build();
> 
> Doing the indentation change in a preliminary patch would ease review.

Yeah, but this style change was from rustfmt's complaints about
this patch, so I've merged rustfmt's changes into this patch as
well... this ensures this individual patch could pass all checks.

Thanks,
Zhao


