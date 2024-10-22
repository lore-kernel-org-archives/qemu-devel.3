Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8542DD2C562
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 14:53:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3GFy-0000ag-OX; Tue, 22 Oct 2024 10:53:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t3GFx-0000aQ-5v
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 10:53:09 -0400
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t3GFt-0001XO-Nx
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 10:53:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1729608785; x=1761144785;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=nHBEgdpC0eHDJXKkKzzfzz2gaka6J2LrJilHwz5nJ2g=;
 b=I2yQLM2W7I7bRSSCYk7E9V8dIKatU68D2/cv5yRfHvp1XKR/PrtS3kI+
 WR571eSdxs4BI4D1EYhzg5d6g/pC+EEjKWH/1jNQUNFq5rONG0QbA2D21
 z11ufOtP6H41cR7/C77p/XzeDM7kKwkbpNeR4Q2R3zRPrsCFHB1+g+3Re
 gRtxHUwZLA+oOTTmRxgGmG6ZdWvtPXX8mfJ7a7rc6v0R0JSgqbakCsD6n
 DuxtcIWu+8lgkenhQcdeGtYAOwRgiEJ+gl5xEGjPse+E3G4VMzK2WpQ9c
 c7C2ahSPUL7MjOdyiy9hdsTbKJqlvwl6AsSxEB9eboDlYsDqTtLRhBtxk A==;
X-CSE-ConnectionGUID: kgDxRM/dTIGAo23MSnmTww==
X-CSE-MsgGUID: 4ugpl5DCRmyUA9M5xlHl+g==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="39696603"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; d="scan'208";a="39696603"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Oct 2024 07:53:02 -0700
X-CSE-ConnectionGUID: Q3f1ONtKSLiCA7/WBqPb5A==
X-CSE-MsgGUID: b+AP9iRnT/SObME/50k3HQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,223,1725346800"; d="scan'208";a="80708110"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa008.jf.intel.com with ESMTP; 22 Oct 2024 07:53:00 -0700
Date: Tue, 22 Oct 2024 23:09:17 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Peter Maydell <peter.maydell@linaro.org>,
 Junjie Mao <junjie.mao@hotmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-devel@nongnu.org
Subject: Re: [Question] What is the =?gb2312?Q?defi?=
 =?gb2312?B?bml0aW9uIG9mIKGwcHJpdmF0ZaGx?= fields in QOM?
Message-ID: <ZxfAHeFz0+ZU4SA/@intel.com>
References: <ZxPZ5oUDRcVroh7o@intel.com>
 <CAFEAcA8m4OeDHopFxCL3MP-cmu-PO5=2+MjNBG7YCudpKdoqDA@mail.gmail.com>
 <ZxZjqypRL7d2rMuQ@intel.com>
 <CAFEAcA-imJJQO=WAmCAHBY1MtszuPyyaD9OHWMRx88h-fjVvsw@mail.gmail.com>
 <ZxZwwe1ULIUqEdKN@intel.com>
 <CAFEAcA9E_-J3EJ+izeErnHDAwaP1LoctRaihu=5xTYrMSnqVig@mail.gmail.com>
 <ZxZ2KS6hi3Y2HdtC@intel.com>
 <CAFEAcA9V0yUCOkAWGumoOD_SMk-saS4OU5gL67gj7SRT0v4cPg@mail.gmail.com>
 <ME0P300MB10401C7825D982CE03574134954C2@ME0P300MB1040.AUSP300.PROD.OUTLOOK.COM>
 <CAFEAcA9m=zy3MMcE+tZwpms36BUx+DsGvt7h1jSuqidFOx0aeA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=gb2312
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFEAcA9m=zy3MMcE+tZwpms36BUx+DsGvt7h1jSuqidFOx0aeA@mail.gmail.com>
Received-SPF: pass client-ip=198.175.65.11; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, CHARSET_FARAWAY_HEADER=3.2,
 DKIMWL_WL_HIGH=-0.519, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Oct 22, 2024 at 09:42:03AM +0100, Peter Maydell wrote:
> Date: Tue, 22 Oct 2024 09:42:03 +0100
> From: Peter Maydell <peter.maydell@linaro.org>
> Subject: Re: [Question] What is the definition of ¡°private¡± fields in
>  QOM?
> 
> On Tue, 22 Oct 2024 at 04:24, Junjie Mao <junjie.mao@hotmail.com> wrote:
> > Peter Maydell <peter.maydell@linaro.org> writes:
> > > For Rust we get to make a fresh start on these things. If
> > > we do mark all these fields not public, what would break?
> > >
> >
> > The only thing that breaks today is std::mem::offset_of! which respects
> > field visibility. Defining a Property const structure requires getting
> > the field offset outside of the state context.
> >
> > To me properties are still private to the device state and must be
> > accessed via their getters & setters. A solution to that is to keep
> > properties private but make their offsets public in our alternative to
> > offset_of!.
> 
> Yes, conceptually I agree that the fields underlying a
> property are private and the public interface is the
> prop get/set API. (In C the prop/get set can if it
> likes do things like enforcing value limits, so looking
> directly at the underlying field would bypass that.)
> 
> At any rate it sounds like it would be a good idea to
> at least mark as not-public all the fields we can do that
> way, and have a comment
>   /* pub only because they are properties */
> for the fields used by the Property structs, even if we
> don't yet have a better way to deal with the latter.

Thank you both, Peter and Junjie!! I understand that the benefit of
declaring private states/classes in Rust is to avoid unnecessary
dependencies between different module/crates and to better manage
interactions between them. I'll go ahead and try out the methods you
both mentioned to compare them.

Regards,
Zhao


