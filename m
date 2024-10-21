Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63FD1D15DAD
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 15:26:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2uHf-00041v-Kc; Mon, 21 Oct 2024 11:25:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t2uHZ-00041S-9n
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 11:25:21 -0400
Received: from mgamail.intel.com ([198.175.65.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t2uHV-00060x-Ip
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 11:25:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1729524317; x=1761060317;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=lX8khoCWP33qY2kW9E9QHVM2sVkeOz9CQxzV3n2vUdM=;
 b=Q7wYcdJveX5U8Mo5ehDcNYHpBfAUwnF45VodisgyiIM+xCF2dMAUnIgV
 KgI8JpiV+5Cvortnj8oZC7hvCFlaR8fiyIR781+VYO1UjAUYVUkUDcuOM
 m0SYjkkL41yeSg2gyfff5d9jAcswC7oLr+P248o/JvZYfFpSL7djZwKNb
 w2x1OtbhEXVNdBeDckQvfoGFQaWbOAvpdJ6urHd/ILvcwxFyOAtIe2qig
 eAErHHrKJErEZ97gijVP/r/RSPfO+cEyI48d0WAsq6pcshXHTrC7hHdD/
 AlerssRcM8DLgLRvOzJqoO+gg8qcuswSm3YPdYMYmSmdmtyW8Cc34MuaF g==;
X-CSE-ConnectionGUID: IA1dumE4Rt2eLphfil//Tw==
X-CSE-MsgGUID: uGdGnK5zQjSnIeFr4niZAA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="28890551"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; d="scan'208";a="28890551"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Oct 2024 08:25:14 -0700
X-CSE-ConnectionGUID: pYqfXwrnSBCem0Fe0NrnAQ==
X-CSE-MsgGUID: tQv/hUp0SoWy3xbMWX+iTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,221,1725346800"; d="scan'208";a="83562427"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa003.fm.intel.com with ESMTP; 21 Oct 2024 08:25:13 -0700
Date: Mon, 21 Oct 2024 23:41:29 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-devel@nongnu.org
Subject: Re: [Question] What is the =?gb2312?Q?defi?=
 =?gb2312?B?bml0aW9uIG9mIKGwcHJpdmF0ZaGx?= fields in QOM?
Message-ID: <ZxZ2KS6hi3Y2HdtC@intel.com>
References: <ZxPZ5oUDRcVroh7o@intel.com>
 <CAFEAcA8m4OeDHopFxCL3MP-cmu-PO5=2+MjNBG7YCudpKdoqDA@mail.gmail.com>
 <ZxZjqypRL7d2rMuQ@intel.com>
 <CAFEAcA-imJJQO=WAmCAHBY1MtszuPyyaD9OHWMRx88h-fjVvsw@mail.gmail.com>
 <ZxZwwe1ULIUqEdKN@intel.com>
 <CAFEAcA9E_-J3EJ+izeErnHDAwaP1LoctRaihu=5xTYrMSnqVig@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=gb2312
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFEAcA9E_-J3EJ+izeErnHDAwaP1LoctRaihu=5xTYrMSnqVig@mail.gmail.com>
Received-SPF: pass client-ip=198.175.65.19; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, CHARSET_FARAWAY_HEADER=3.2,
 DKIMWL_WL_HIGH=-0.421, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Mon, Oct 21, 2024 at 04:06:08PM +0100, Peter Maydell wrote:
> Date: Mon, 21 Oct 2024 16:06:08 +0100
> From: Peter Maydell <peter.maydell@linaro.org>
> Subject: Re: [Question] What is the definition of ¡°private¡± fields in
>  QOM?
> 
> On Mon, 21 Oct 2024 at 16:02, Zhao Liu <zhao1.liu@intel.com> wrote:
> >
> > On Mon, Oct 21, 2024 at 03:20:39PM +0100, Peter Maydell wrote:
> > > What I mean by "the private/public markers are unnecessary" is
> > > that they don't tell the reader anything, because all the fields
> > > in a QOM device struct are private.
> >
> > This time I really understand the question of whether it's okay to
> > directly access parent_obj/parent_class. :-)
> >
> > > If you're not in the implementation of that class, then you shouldn't
> > > really be directly touching any of the fields in the state struct.
> > > (In some places we take a shortcut and do it. But really it's almost
> > > never necessary.)
> >
> > Thank you for your further explanation! I hadn¡¯t noticed that. So, for
> > other code (code outside the class/object implementation) to access the
> > fields other than parent_obj/parent_class of class/state struct, the
> > most ideal way would be to use the set/get property interfaces as
> > much as possible instead of accessing them directly, right?
> 
> Yes, or whatever APIs (functions etc) are provided for working
> with the class. If you have a specific example we could probably
> make some more concrete suggestions.

My initial confusion stemmed from seeing the private comment and
noticing that there are many direct accesses to parent_obj/parent_class
in QEMU (which I could list in my reply to Daniel). Now I understand
that these examples are only valid within the class/object
implementation or in QOM code.

For instance, an example in KVM is a misuse:

accel/kvm/kvm-all.c:4285:                        cpu->parent_obj.canonical_path,
accel/kvm/kvm-all.c:4377:            if (!apply_str_list_filter(cpu->parent_obj.canonical_path, targets)) {


At the same time, I¡¯ve been thinking that the current C implementation
seems to have no way to prevent such misuse. So for Rust's class/state,
should parent_class/parent_obj also be defined as private (for example,
by removing the pub keyword from PL011State in rust/hw/char/pl011/src/
device.rs)?

However, through our discussion, I realized that in QOM, "private" does
not only refer to parent_obj/parent_class, but all fields belong to
this category. If everything is strictly defined as private in Rust, it
seems impractical¡­

Thanks,
Zhao


