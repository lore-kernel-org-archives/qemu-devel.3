Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 748A9C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2024 17:06:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxrg9-0003T2-Og; Fri, 19 Apr 2024 13:05:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1rxrg8-0003St-D0
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 13:05:36 -0400
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1rxrg6-00062V-5M
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 13:05:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
 :Subject; bh=Z/bviJe+05iK8FCnwT25jYhJ2U8j8pAOtYayFutz8T0=; b=aeC26RZ5ZB8AvKyh
 gVixGkwigAJwBJ3FHt3r2jvaSORglVXVJKvYMWxIS5e/q0g2KT3K8ua3rgFqXa7p7lrwVb90A3N3B
 v+kkoF7nYmmIH2kR5rYbYNHdDDVNh88VE3PBE056GYIefr1BygNgC8kDmq5jUEO95ucCJV2fYUqub
 JA4Ko4i252TRj9Jy+rJUS/rlLJF9bhbyDph1YAAE/v+gHSDdFH/+KzZ97dOskTbYAk34kDn+sCsxd
 AtuTXjKe8FrfEWoUcO5rHPpH+cgZN9OtpKDC5CFdUvThFW43pc8DgvFyVrDdtg3R6k9FP759yaspV
 wxF4H9gjKICRkDbS/g==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
 (envelope-from <dg@treblig.org>) id 1rxrg0-0026lA-14;
 Fri, 19 Apr 2024 17:05:28 +0000
Date: Fri, 19 Apr 2024 17:05:28 +0000
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Don Porter <porter@cs.unc.edu>, qemu-devel@nongnu.org, pbonzini@redhat.com
Subject: Re: Add 'info pg' command to monitor
Message-ID: <ZiKkWCjreGOMFX5p@gallifrey>
References: <20240415160818.2316599-1-porter@cs.unc.edu>
 <CAFEAcA88myOeQwZ212q9R4EHBPpJbQ1qZYjuz6SS=HZbqS+NCQ@mail.gmail.com>
 <fadb288a-4c44-42c9-b706-f5595d97f952@cs.unc.edu>
 <CAFEAcA9Fe8TerNSrg_AfmpFZNL_4B9WV0OccFdLakJhtCN+m4A@mail.gmail.com>
 <bff71578-42ad-4af0-9ba6-e0962dd73710@cs.unc.edu>
 <CAFEAcA-nLjJoqujX-4kW4kWrrWbaQ037jGCNG75OB+KJybe8Ng@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <CAFEAcA-nLjJoqujX-4kW4kWrrWbaQ037jGCNG75OB+KJybe8Ng@mail.gmail.com>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-17-amd64 (x86_64)
X-Uptime: 17:00:42 up 107 days, 19:50,  1 user,  load average: 0.14, 0.07, 0.01
User-Agent: Mutt/2.2.12 (2023-09-09)
Received-SPF: pass client-ip=2a00:1098:5b::1; envelope-from=dg@treblig.org;
 helo=mx.treblig.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

* Peter Maydell (peter.maydell@linaro.org) wrote:
> On Tue, 16 Apr 2024 at 19:11, Don Porter <porter@cs.unc.edu> wrote:
> >
> > On 4/16/24 13:03, Peter Maydell wrote:
> > > On Tue, 16 Apr 2024 at 17:53, Don Porter <porter@cs.unc.edu> wrote:
> > >> There is still a lot I am learning about the code base, but it seems
> > >> that qemu_get_guest_memory_mapping() does most of what one would need.
> > >> It currently only returns the "leaves" of the page table tree in a list.
> > >>
> > >> What if I extend this function with an optional argument to either
> > >> 1) return the interior nodes of the page table in additional lists (and
> > >> then parse+print in the monitor code), or
> > >> 2) inline the monitor printing in the arch-specific hook, and pass a
> > >> flag to get_guest_memory_mapping() that turns on/off the statements that
> > >> pretty print the page tables?
> > >>
> > >> It looks like most CPUs implement this function as part of checkpointing.
> > > As far as I can see only x86 implements the get_memory_mapping
> > > function, so once again somebody has added some bit of
> > > functionality that does a walk of the page tables that is
> > > x86 only and that shares no code with any of the other
> > > page table walking code :-(
> >
> > My mistake - get_memory_mappings() is only implemented in x86.
> >
> > In doing some searching of the code, many architectures implement
> > mmu_translate() and
> > get_physical_address() functions, but they are not standardized. I also
> > see your larger point
> > about replicating page walking code in x86.
> >
> > I imagine you have something in mind that abstracts things like the
> > height of the radix tree,
> > entries per node, checking permissions, printing the contents, etc.
> >
> > Perhaps I should start by trying to merge the x86 page walking code into
> > one set of common
> > helper functions, get more feedback (perhaps on a new patch thread?),
> > and then consider
> > how to abstract across architectures after getting feedback on this?
> 
> I think the cross-architecture abstraction is probably the
> trickiest part. I would actually be happy for us to drop
> 'info tlb' and 'info mem' entirely if we have a cross-arch
> command that gives basically the same information -- we don't
> IMHO need more than one command for this, and we only have
> multiple commands for basically legacy reasons. And for the
> human monitor (HMP) we don't need to keep things around
> for backwards compatibility.

I'm not sure what happens for the (MIPS/SPARC ?) where it's not
a traditional table hierarchy.

The other thing you might want (and I'm not sure how it interacts
with any of this) is to specify the root of the MMU tree (i.e. CR3
value for those in Intel thinking) to dump different processes etc.

Dave

> thanks
> -- PMM
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

