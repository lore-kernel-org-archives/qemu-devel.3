Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09762C3ABAC
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 17:05:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAtob-0004Dc-IU; Fri, 02 May 2025 13:04:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.liu@kernel.org>)
 id 1uAtoP-00046h-SR
 for qemu-devel@nongnu.org; Fri, 02 May 2025 13:04:34 -0400
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.liu@kernel.org>)
 id 1uAtoO-0004vb-4G
 for qemu-devel@nongnu.org; Fri, 02 May 2025 13:04:33 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 1860B44E5C;
 Fri,  2 May 2025 17:04:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 369C3C4CEE4;
 Fri,  2 May 2025 17:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1746205468;
 bh=+c2rjTWIinoPYlvqKoquzKoBYlmgGgjbqZHmTTsUbbo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=rgnBZTKpgJi+LUG00j7D45mK7FPZQE4YUR3kW1nsbms6qEYU0Bo51OlJbJ1OmnqSm
 Fe6ZhA0WnGSw6KcjkIgsKt6YPzOXezL4/tSprWlLt2VPXI7rigJjwwJ4tMiepBj1UL
 Zd+stoOuwpyvovoVm0Nv0qVOAwFAin+5K8zfF3x3ehmV/k/wQ2eNi5SZ11j7gsgJNr
 cujCK908Jp4kgH4B3TqA6CkP7nSZMGFTPq23DN4r0yE6Ep5j07wB78QFdRSHVoyMVe
 evnxD4FeTto/IikebmFXgtgjIjNMFKoCqXy7AyTPW13zugxmhAU4GBG81lxzTjL52P
 DyfiyRZ4YBwdA==
Date: Fri, 2 May 2025 17:04:26 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Magnus Kulke <magnuskulke@linux.microsoft.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Cameron Esfahani <dirty@apple.com>, Wei Liu <wei.liu@kernel.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>
Subject: Re: [PATCH v3] target/i386/emulate: remove rflags leftovers
Message-ID: <aBT7GuLHnnS8cQCB@liuwe-devbox-ubuntu-v2.tail21d00.ts.net>
References: <20250429093319.5010-1-magnuskulke@linux.microsoft.com>
 <CABgObfaxzxdBf3f-JwKA8osOwZZQf-dqpsambpAFhPvkvjDo8w@mail.gmail.com>
 <aBDBExDzR57PcRre@example.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aBDBExDzR57PcRre@example.com>
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=wei.liu@kernel.org; helo=sea.source.kernel.org
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.644,
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

On Tue, Apr 29, 2025 at 02:17:01PM +0200, Magnus Kulke wrote:
> On Tue, Apr 29, 2025 at 12:02:48PM +0200, Paolo Bonzini wrote:
> > Il mar 29 apr 2025, 11:33 Magnus Kulke <magnuskulke@linux.microsoft.com> ha
> > scritto:
> > 
> > > Fixes: c901905ea670 ("target/i386/emulate: remove flags_mask")
> > >
> > > In c901905ea670 rflags have been removed from `x86_decode`, but there
> > > were some leftovers.
> > >
> > > Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
> > >
> > 
> > Thanks, I will queue thos; I have some more emulator patches but no way to
> > test that, could you please help?
> > 
> > Paolo
> > 
> 
> Yes, I'm using the generalized emulator in the context of adding the MSHV
> accelerator. (I'll probably get around sending an RFC patchset this week for
> it). There were minor compilation issues w/ the emulator code, that I had to
> fix to make it compile on Linux. However I don't have access to an x86_64
> Mac for development either, so I can't test a HVF build.
> 

I still have my loaner Macbook for a few more days. If I have not
returned it when Paolo posts his patches I can build test HVF.

Thanks,
Wei.

