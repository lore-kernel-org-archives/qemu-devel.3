Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E668EFCE56
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 00:53:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxwxK-0006EO-Le; Wed, 04 Mar 2026 19:52:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1vxwxI-0006E3-1q
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 19:52:44 -0500
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1vxwxG-0001Da-9Z
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 19:52:43 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 965AC61340;
 Thu,  5 Mar 2026 00:52:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39414C4CEF7;
 Thu,  5 Mar 2026 00:52:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1772671960;
 bh=fwGZAvEnOWJP1q88WAtMQ66ow+06FNYeMCKKffwLsNk=;
 h=Date:From:To:cc:Subject:In-Reply-To:References:From;
 b=FqcfnY3P0kA97DAbjwb4HiVnesUTQqEmhtNX2YYJEgXrujXjDqjDZDquiZl0d017M
 BVyUwf2Kx4hrvxjgVvUHiJ+pTSzRUc+Uyk4aqzdZotfyBqI9yB338+ACLBrkqUpHUK
 IIhDkllhxR0HLN1yQ/aERVbYq13OW8+4IlBgxx1mXKUWT8UZCYed5Hxr7Fgj8jD9lW
 UIvbjbBC4fZewgO0zPp4w2I2Vhm6DGTVAv2HY1etoD7QaysKhK7w0dnMNncjrzPzOL
 YhN7SymeUQMuJo1arxO/0gPuIz22Y1RGKqBqTr5u2k4uSAE6LcoNXXZs5PP2YoD6pC
 0ll/DQYEvL/WQ==
Date: Wed, 4 Mar 2026 16:52:37 -0800 (PST)
From: Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To: "Edgar E. Iglesias" <edgar.iglesias@amd.com>
cc: Stefano Stabellini <sstabellini@kernel.org>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-devel@nongnu.org, 
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 anthony@xenproject.org, xen-devel@lists.xenproject.org
Subject: Re: [PATCH v1 3/5] physmem: xen: Conditionalize use of the
 mapcache
In-Reply-To: <aajS8ahPOaE_g5q1@zapote>
Message-ID: <alpine.DEB.2.22.394.2603041652200.250016@ubuntu-linux-20-04-desktop>
References: <20260304015222.979224-1-edgar.iglesias@gmail.com>
 <20260304015222.979224-4-edgar.iglesias@gmail.com>
 <alpine.DEB.2.22.394.2603041606480.250016@ubuntu-linux-20-04-desktop>
 <aajS8ahPOaE_g5q1@zapote>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1595222509-1772671960=:250016"
Received-SPF: pass client-ip=172.105.4.254;
 envelope-from=sstabellini@kernel.org; helo=tor.source.kernel.org
X-Spam_score_int: 0
X-Spam_score: -0.0
X-Spam_bar: /
X-Spam_report: (-0.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.703, RCVD_IN_VALIDITY_SAFE_BLOCKED=1.386,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1595222509-1772671960=:250016
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Thu, 5 Mar 2026, Edgar E. Iglesias wrote:
> On Wed, Mar 04, 2026 at 04:07:23PM -0800, Stefano Stabellini wrote:
> > On Wed, 4 Mar 2026, Edgar E. Iglesias wrote:
> > > From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>
> > > 
> > > Conditionalize use of the mapcache. This is in preparation
> > > to optionally disable the mapcache at runtime.
> > > 
> > > Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
> > > ---
> > >  system/physmem.c | 13 +++++++------
> > >  1 file changed, 7 insertions(+), 6 deletions(-)
> > > 
> > > diff --git a/system/physmem.c b/system/physmem.c
> > > index e5ff26acec..64e6d50f8f 100644
> > > --- a/system/physmem.c
> > > +++ b/system/physmem.c
> > > @@ -578,7 +578,8 @@ MemoryRegion *flatview_translate(FlatView *fv, hwaddr addr, hwaddr *xlat,
> > >                                      is_write, true, &as, attrs);
> > >      mr = section.mr;
> > >  
> > > -    if (xen_enabled() && memory_access_is_direct(mr, is_write, attrs)) {
> > > +    if (xen_map_cache_enabled() &&
> > > +        memory_access_is_direct(mr, is_write, attrs)) {
> > >          hwaddr page = ((addr & TARGET_PAGE_MASK) + TARGET_PAGE_SIZE) - addr;
> > >          *plen = MIN(page, *plen);
> > >      }
> > 
> > All the other changes make sense. For this one, the code inside the if
> > check is not strictly related to the mapcache. Are you sure it should be
> > changed?
> 
> Hi, yes, when the mapcache is on, we limit translations to the current page
> because the next page might not be mapped/locked or could be in a different
> mapcache bucket with a different virtual address. When mapcache is off, guest
> RAM is fully mapped (same as non‑Xen), so we can skip capping plen and allow a
> larger mapping.
> 
> Perhaps we should add a comment to clarify?

Yes please! Add a one-line in-code comment, and with that:

Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>
--8323329-1595222509-1772671960=:250016--

