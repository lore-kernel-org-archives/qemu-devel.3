Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88CBDC3ABAD
	for <qemu-devel@archiver.kernel.org>; Sat,  3 May 2025 05:40:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uB5al-0005Ku-0h; Sat, 03 May 2025 01:39:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.liu@kernel.org>)
 id 1uB5aZ-0005Kc-UM
 for qemu-devel@nongnu.org; Sat, 03 May 2025 01:39:04 -0400
Received: from nyc.source.kernel.org ([147.75.193.91])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.liu@kernel.org>)
 id 1uB5aV-0000J2-Hj
 for qemu-devel@nongnu.org; Sat, 03 May 2025 01:39:02 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 9B2B0A49EF3;
 Sat,  3 May 2025 05:33:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F821C4CEE3;
 Sat,  3 May 2025 05:38:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1746250737;
 bh=ZfbRiN612nH3UzzW4BBK6LY7PUmEaUae03Uc84/hEpM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=YK+1ZYbz9MU/l2UG3QiLrH9eNVLS2GQX5rJR2LsYccSsDQG7UxvBLW3HJ275TvWyU
 VVIy1N/sBRrWgZ+YcorA0wWa+zIf3PptX4sT+xByzzfk8BX9L+Y/ZM7sm0pKHy3wQL
 XzAYtiLAr13CUGwtq4fKtT2CR0qhad03eFoL1NPpgO8WO6BLMFMRjsM9udWrf52O2I
 +mtU5rt5DkiZSqqlsM8gY3sh3np66l8YkLvIBOqbLj2z0dP9jQcBAwLDibsAKHTYPt
 7bxrE/dnsKhborry7RiDrn05Q0cI/B7FSb+A+GOpwigxCMuTW7VE3z6kDYEK4z7r8g
 Bau/0JpCUHqRg==
Date: Sat, 3 May 2025 05:38:56 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, wei.liu@kernel.org
Subject: Re: [CFT PATCH 0/4] target/i386/emulate: cleanups
Message-ID: <aBWr8FH9otBP5dqd@liuwe-devbox-ubuntu-v2.tail21d00.ts.net>
References: <20250502214841.242584-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250502214841.242584-1-pbonzini@redhat.com>
Received-SPF: pass client-ip=147.75.193.91; envelope-from=wei.liu@kernel.org;
 helo=nyc.source.kernel.org
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.644,
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

FWIW this series builds fine on for x86 HVF.

Thanks,
Wei.

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

