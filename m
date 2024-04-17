Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2975CC4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2024 21:04:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxCRp-0007U3-Qv; Wed, 17 Apr 2024 17:04:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1rxCRg-0007Qt-By
 for qemu-devel@nongnu.org; Wed, 17 Apr 2024 17:03:59 -0400
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1rxCRZ-0001yc-UP
 for qemu-devel@nongnu.org; Wed, 17 Apr 2024 17:03:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
 :Subject; bh=6Lzu7UFXglkxxkctzIYpp62ODUWcqV2eCxT4Kyf7NVk=; b=XshqNHRPSFOfgySg
 DK+bn8Ge19HFEvMrbIUU8aipEwZTMpQmexZXNkXM88MpU7XCcVQEKtKi4BdjzQbUehhvHOR94b2UK
 xakVtoC9wpY7SuajB+pZ8BSM5bj9BSuDmbV7+QA62W+TygiqFHFn9H/c6p7396kI8VBdqeZKzyjdZ
 b0yjAA/lHMFmb8O5oj+r845bPvx4u8rJxC3D06hj6AHRDqeLoJJcbG9L2MpiNX5g6ftdYi7hyv299
 amU6iVZbw31Id3/OZfMDT2qrKn63FEvzwi5e9vQGH8iDZKSKL4kRS919tUX+O9yug7j6RB4At1k5N
 sV3MVXncwOxlW3icQw==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
 (envelope-from <dg@treblig.org>) id 1rxCRK-001ke1-05;
 Wed, 17 Apr 2024 21:03:34 +0000
Date: Wed, 17 Apr 2024 21:03:33 +0000
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: Don Porter <porter@cs.unc.edu>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 pbonzini@redhat.com
Subject: Re: Add 'info pg' command to monitor
Message-ID: <ZiA5JZ5jzsjrv9Bu@gallifrey>
References: <20240415160818.2316599-1-porter@cs.unc.edu>
 <CAFEAcA88myOeQwZ212q9R4EHBPpJbQ1qZYjuz6SS=HZbqS+NCQ@mail.gmail.com>
 <fadb288a-4c44-42c9-b706-f5595d97f952@cs.unc.edu>
 <CAFEAcA9Fe8TerNSrg_AfmpFZNL_4B9WV0OccFdLakJhtCN+m4A@mail.gmail.com>
 <bff71578-42ad-4af0-9ba6-e0962dd73710@cs.unc.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <bff71578-42ad-4af0-9ba6-e0962dd73710@cs.unc.edu>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-17-amd64 (x86_64)
X-Uptime: 21:00:34 up 105 days, 23:50,  1 user,  load average: 0.00, 0.02, 0.00
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

* Don Porter (porter@cs.unc.edu) wrote:
> On 4/16/24 13:03, Peter Maydell wrote:
> > On Tue, 16 Apr 2024 at 17:53, Don Porter <porter@cs.unc.edu> wrote:
> > > There is still a lot I am learning about the code base, but it seems
> > > that qemu_get_guest_memory_mapping() does most of what one would need.
> > > It currently only returns the "leaves" of the page table tree in a list.
> > > 
> > > What if I extend this function with an optional argument to either
> > > 1) return the interior nodes of the page table in additional lists (and
> > > then parse+print in the monitor code), or
> > > 2) inline the monitor printing in the arch-specific hook, and pass a
> > > flag to get_guest_memory_mapping() that turns on/off the statements that
> > > pretty print the page tables?
> > > 
> > > It looks like most CPUs implement this function as part of checkpointing.
> > As far as I can see only x86 implements the get_memory_mapping
> > function, so once again somebody has added some bit of
> > functionality that does a walk of the page tables that is
> > x86 only and that shares no code with any of the other
> > page table walking code :-(
> 
> My mistake - get_memory_mappings() is only implemented in x86.
> 
> In doing some searching of the code, many architectures implement
> mmu_translate() and
> get_physical_address() functions, but they are not standardized. I also see
> your larger point
> about replicating page walking code in x86.
> 
> I imagine you have something in mind that abstracts things like the height
> of the radix tree,
> entries per node, checking permissions, printing the contents, etc.
> 
> Perhaps I should start by trying to merge the x86 page walking code into one
> set of common
> helper functions, get more feedback (perhaps on a new patch thread?), and
> then consider
> how to abstract across architectures after getting feedback on this?
> 
> In looking at x86 code, I see the following places where there is page table
> walking code to
> potentially merge:
> 
> * target/i386/monitor.c - existing info commands
> 
> * target/i386/helper.c - get_phys_page_attrs_debug
> 
> * target/i386/arch_memory_mapping.c - implements get_memory_mapping
> 
> * tcg/sysemu/excp_helper.c: implements mmu_translate() and
> get_physical_address()

One thing to keep in mind (although I don't know the x86 code) is that
you want the monitor command not to change any state, nor to fail if
there's a particularly screwy page table; so no flagging exceptions
or flagging accessed bits or changing the state of the tcg.

Dave

> Thanks,
> 
> Don
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

