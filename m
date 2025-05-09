Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18C23C3ABC3
	for <qemu-devel@archiver.kernel.org>; Fri,  9 May 2025 12:56:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDNH7-0007q9-50; Fri, 09 May 2025 08:56:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <magnuskulke@linux.microsoft.com>)
 id 1uDNH5-0007iZ-BD
 for qemu-devel@nongnu.org; Fri, 09 May 2025 08:56:23 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <magnuskulke@linux.microsoft.com>) id 1uDNH2-0004tx-Hf
 for qemu-devel@nongnu.org; Fri, 09 May 2025 08:56:23 -0400
Received: from example.com (unknown [167.220.208.69])
 by linux.microsoft.com (Postfix) with ESMTPSA id 052BF21199D8;
 Fri,  9 May 2025 05:56:16 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 052BF21199D8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1746795377;
 bh=4xYMO3zL4I0YCF/1EO9DtesMOhoZ4KdrGoBwevLBu7o=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=dko4QxcSzGXGepVFBmR5B9vwb1VUUPaGKG5YFdZjFh1NABH5iFmHYfrwDA+z45DBz
 O8kQXyAtYefBoG/y+PdNLWDxtewNol3IAxUaczodqJGXviUgT4cGk/ivharNoKgO+I
 aE/+IOUgAlfHTCb5c6Wg7kCwf0UcBsF8cVKtzz9k=
Date: Fri, 9 May 2025 14:56:10 +0200
From: Magnus Kulke <magnuskulke@linux.microsoft.com>
To: Wei Liu <wei.liu@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [CFT PATCH 0/4] target/i386/emulate: cleanups
Message-ID: <aB37anHZZtdO5BVY@example.com>
References: <20250502214841.242584-1-pbonzini@redhat.com>
 <aBkEvxV3b_ilLtY3@liuwe-devbox-ubuntu-v2.tail21d00.ts.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aBkEvxV3b_ilLtY3@liuwe-devbox-ubuntu-v2.tail21d00.ts.net>
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=magnuskulke@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

Hey Paolo,

I applied your patches to the x86 emulator in our MSHV branch. They
compile cleanly (some off this we had changed on our branch already). I
also performed some manual testing and didn't spot any regressions with
the changes in the emulator.

magnus

already). I also performed some manual testing and didn't spot any regressions with
the emulator.

On Mon, May 05, 2025 at 06:34:39PM +0000, Wei Liu wrote:
> Magnus, can you test this series on MSHV?
> 
> On Fri, May 02, 2025 at 11:48:37PM +0200, Paolo Bonzini wrote:
> > These are some improvements to the x86 emulator that I wrote but have no
> > way of testing (right now).
> > 
> > I tried to place them in order of importance so that, if something breaks,
> > it is possible to commit a subset.  I tried to compile the resulting code
> > on Linux but I have not run it.
> > 
> > Patch 1 is just to fix warnings on Linux.
> > 
> > Patch 2 is the most important, as it fixes some real horrors in the code.
> > 
> > Patch 3 makes flags handling use algorithms somewhat similar to TCG.
> > It should fix issues with 64-bit ALU operations, but it's also the one
> > where it's more likely to have a mistake.
> > 
> > Patch 4 is comparatively trivial, though I cannot exclude any screwups.
> > 
> > It should be possible to test this with both HVF and Hyper-V.
> > 
> > Paolo
> > 
> > Paolo Bonzini (4):
> >   target/i386/emulate: fix target_ulong format strings
> >   target/i386/emulate: stop overloading decode->op[N].ptr
> >   target/i386/emulate: mostly rewrite flags handling
> >   target/i386: remove lflags
> > 
> >  target/i386/cpu.h                |   6 -
> >  target/i386/emulate/x86_decode.h |   9 +-
> >  target/i386/emulate/x86_emu.h    |   8 +-
> >  target/i386/emulate/x86_flags.h  |  12 +-
> >  target/i386/emulate/x86_decode.c |  76 ++++++------
> >  target/i386/emulate/x86_emu.c    | 125 +++++++++----------
> >  target/i386/emulate/x86_flags.c  | 198 +++++++++++++------------------
> >  7 files changed, 197 insertions(+), 237 deletions(-)
> > 
> > -- 
> > 2.49.0
> > 

