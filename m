Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44340C3ABBC
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 18:35:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uC0eM-0003sw-MW; Mon, 05 May 2025 14:34:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.liu@kernel.org>)
 id 1uC0eL-0003sg-Cn
 for qemu-devel@nongnu.org; Mon, 05 May 2025 14:34:45 -0400
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.liu@kernel.org>)
 id 1uC0eJ-0005Lm-M6
 for qemu-devel@nongnu.org; Mon, 05 May 2025 14:34:45 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 8A46B4A7C4;
 Mon,  5 May 2025 18:34:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08885C4CEE4;
 Mon,  5 May 2025 18:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1746470081;
 bh=q+91s0sBEvCTyvCh7enGpqill/4QCzZug+WbAw6S86k=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=MdXH+/YrjOAHkFv8vR/7EioH7b70aVc3UVhnzP7X/3rlkUT2X7sl2crV3gVYpKvAG
 awH1N0q/EI+aVCd0eVJWcfVOYtHNEcPORL2P9F7ImrfsWHKDXsOtxnngRycEJOcrgT
 vUZQpPUXyzflr6NU8R2BwxVCjZcgnYl14+cvrs4C+QHlikvLUok9wJpOjCsk4shYjT
 LlTTWgqlkhca7vIIedKsO/+wxH1ttjCSu5aQHHGYYwOzD/u1NNw7j7S/eQ/+4OIHL+
 ETjZQrMqv931cPmjrPODUUzqIXLYIK0ldYZWG6pgsbc9X8YkQ4KnXaQMHwtDjOWZ2W
 fT7Zy/B3t2joQ==
Date: Mon, 5 May 2025 18:34:39 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Magnus Kulke <magnuskulke@linux.microsoft.com>
Cc: qemu-devel@nongnu.org, wei.liu@kernel.org
Subject: Re: [CFT PATCH 0/4] target/i386/emulate: cleanups
Message-ID: <aBkEvxV3b_ilLtY3@liuwe-devbox-ubuntu-v2.tail21d00.ts.net>
References: <20250502214841.242584-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250502214841.242584-1-pbonzini@redhat.com>
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=wei.liu@kernel.org; helo=sea.source.kernel.org
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.414,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Magnus, can you test this series on MSHV?

On Fri, May 02, 2025 at 11:48:37PM +0200, Paolo Bonzini wrote:
> These are some improvements to the x86 emulator that I wrote but have no
> way of testing (right now).
> 
> I tried to place them in order of importance so that, if something breaks,
> it is possible to commit a subset.  I tried to compile the resulting code
> on Linux but I have not run it.
> 
> Patch 1 is just to fix warnings on Linux.
> 
> Patch 2 is the most important, as it fixes some real horrors in the code.
> 
> Patch 3 makes flags handling use algorithms somewhat similar to TCG.
> It should fix issues with 64-bit ALU operations, but it's also the one
> where it's more likely to have a mistake.
> 
> Patch 4 is comparatively trivial, though I cannot exclude any screwups.
> 
> It should be possible to test this with both HVF and Hyper-V.
> 
> Paolo
> 
> Paolo Bonzini (4):
>   target/i386/emulate: fix target_ulong format strings
>   target/i386/emulate: stop overloading decode->op[N].ptr
>   target/i386/emulate: mostly rewrite flags handling
>   target/i386: remove lflags
> 
>  target/i386/cpu.h                |   6 -
>  target/i386/emulate/x86_decode.h |   9 +-
>  target/i386/emulate/x86_emu.h    |   8 +-
>  target/i386/emulate/x86_flags.h  |  12 +-
>  target/i386/emulate/x86_decode.c |  76 ++++++------
>  target/i386/emulate/x86_emu.c    | 125 +++++++++----------
>  target/i386/emulate/x86_flags.c  | 198 +++++++++++++------------------
>  7 files changed, 197 insertions(+), 237 deletions(-)
> 
> -- 
> 2.49.0
> 

