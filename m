Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47B73C3ABDD
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 16:03:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHPQ4-0007XW-Aq; Tue, 20 May 2025 12:02:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uHPQ1-0007Vf-2Z; Tue, 20 May 2025 12:02:17 -0400
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uHPPx-0005JI-9h; Tue, 20 May 2025 12:02:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1747756933; x=1779292933;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=rXyivNAP7GuLXxMV2DCwcIAVUgLC5pLZeZ/iwDqxFl8=;
 b=C0esmcE13wm6ESt25hU4xVA7ulFNLFUtGnqfyA66QSAL654IiPrd3bzf
 /LDGYF/jeZg6AJoah8/1ZcZcSiSv0G+nLu8KT5yUsTdeBenJZReP+pvNp
 G7TWW0Erml+Ns+MUhhN9lLq6bCkYjQXnW/x1uPAld2jsViQWTkWL8F3HM
 2tDJcMuJwPrSAG2gxIv+Ld3bt/hccSiIIF+tYDmWP/al1KA6NsE7zrWPW
 s1Uxp3Trv4wkJoaxFCemF0f1c6VuTOK8voQQwjbqbYEugr7cE9LXkZDxG
 GqgvFcSuZLnfp6zOFbrS0oFBTJMIwZDgbwuEaagP4WlsCHj9BqUM8ImZ+ A==;
X-CSE-ConnectionGUID: XelY7rLySmW5TpjrPGRniw==
X-CSE-MsgGUID: qkx2ctIlRpyzdOb9+VDTNg==
X-IronPort-AV: E=McAfee;i="6700,10204,11439"; a="52325502"
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; d="scan'208";a="52325502"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 May 2025 09:02:09 -0700
X-CSE-ConnectionGUID: oiWHrhykQyKyeuBwDjMolA==
X-CSE-MsgGUID: 0xwU7rueQN2x/53GFlg3VQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; d="scan'208";a="140261931"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa010.fm.intel.com with ESMTP; 20 May 2025 09:02:08 -0700
Date: Wed, 21 May 2025 00:23:14 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <bonzini@gnu.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-rust@nongnu.org,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Daniel Berrange <berrange@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: Rust in QEMU update, April 2025
Message-ID: <aCysct2L8Bosqy0N@intel.com>
References: <d3d1944e-2482-4aa7-b621-596246a08107@gnu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d3d1944e-2482-4aa7-b621-596246a08107@gnu.org>
Received-SPF: pass client-ip=192.198.163.13; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.487,
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

(Resend as the previous email may have failed.)

> Remaining unsafe code
> '''''''''''''''''''''
> 
> qdev bindings cover basic classes and interfaces, including
> GPIO pins, timers, clocks and MemoryRegionOps.  VMState
> still needs unsafe callbacks for pre_save/post_load, with
> the final version waiting for a bump of the minimum supported
> Rust version to 1.83.0.
> 
> Apart from VMState, the remaining instances of `unsafe` blocks in the
> pl011 and HPET code can all be removed without bumping the language
> version.
> 
> HPET does some very simple memory accesses; a good safe solution
> for this may be the ``vm-memory`` crate.  While I have not looked into
> using it, ``vm-memory`` and ``vm-virtio`` were written with QEMU's
> use cases in mind.

I'm working on this and trying to wrap simple memory access by
vm-memory.
 
> A coding style for devices
> ''''''''''''''''''''''''''
> 
> pl011 and HPET were developed independently and sometimes have different
> idioms that could be unified.  Peter Maydell made several observations:
> 
>   Something I do notice is that there's some inconsistency in
>   how we've structured things between the two devices, e.g.:

...
 
>   * pl011 has defined named fields for its registers, but hpet does
>     things like::
> 
>        self.config.get() & (1 << HPET_CFG_LEG_RT_SHIFT) != 0

On the one hand, this way is more friendly and easy to review for C
developers (comparing with the C version), and on the other hand,
there are similar writeups in other projects (crosvm/firecracker). So,
HPET also shows a clumsy and conservative approach :-).

>   * pl011 has a split between PL011State and PL011Registers,
>     but HPET does not. As I mentioned in an email thread a
>     little while back, I feel like the State/Registers split
>     is something we should either make a more clear deliberate
>     formalised separation that's part of how we recommend
>     device models should be designed

Sorry, I just noticed this point.

I tried to abstract a HPETRegisters but found out it didn't work well in
HPET case...So I didn't insist.

The following is the lesson I learned when I wrote HPET in Rust in the
first time (copied from my HPET v2 cover letter [*]):

Additional Experience
=====================

PL011 provides a pattern to group all registers in one BqlRefCell
instead of multiple BqlCells.

I also tried to leverage this design to HPET, but it didn't fit very
well with this issue:
 * HPETState abstracts many helpers to check register bit and tell
   caller about the state, e.g., is_legacy_mode(),
   is_timer_int_active(), etc.
   
   But this also means these helpers can't be used in BqlRefCell::
   borrow_mut() context again, otherwise, they would cause the runtime
   bql check panic.

 - Some cases are easy to fix, i.e, use borrow_mut to modify the
   registers after the helpers' call.

 - Some cases would by tricky, like memory write callback, since it has
   complex logic and it's hard to decouple register changes from the
   reset logic as clearly as PL011 does. 

   The fix for this case is either to avoid using register helpers
   again in the borrow_mut context of write(), or to use BqlCell
   instead of BqlRefCell to get finer-grained access control to avoid
   refactoring code logic.

   I chose the latter.


So I think this might be a practical lesson that the choice of BqlCell
and BqlRefCell is also indeed related to code logic: If the code logic
is too complex to decouple borrow() and borrow_mut() (and the compiler
doesn't check this, only the runtime's panic_already_borrowed() will
complains!) , then BqlCell should be chosen. Because fine-grained access
is easier to control and avoid errors. :-)

[*]: https://lore.kernel.org/qemu-devel/20250125125137.1223277-1-zhao1.liu@intel.com/

Thanks,
Zhao


