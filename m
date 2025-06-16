Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70CFCC71136
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Jun 2025 23:34:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRJKd-00058T-MO; Mon, 16 Jun 2025 19:33:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1uRJKb-00057w-67
 for qemu-devel@nongnu.org; Mon, 16 Jun 2025 19:33:37 -0400
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1uRJKY-0005rT-1V
 for qemu-devel@nongnu.org; Mon, 16 Jun 2025 19:33:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
 :Subject; bh=FQ9AVie1G3opC6SktC6DwSQCFYiO015Exy38SxOe1kk=; b=El/fY8UIGmwy+hKD
 EFhjQDl6etqkbrwFleIO3W6yF4k4S3PZaDqzEGa53I6uVPjWSrA2OMlrnk29YkRiUrNi5Fv76onDf
 g3hkgz9OhChZS8KQ4s7LqiwkmLLP54gyWaymsal1W0yypK8KBWOZms7pY8LHapFvYT4fG+q2mRMwk
 odt08sf/0Ld6EXU3ftcHABuXhS51hlEDB+OjXpUtX+pdCiwKSXfK5IHBzyAhKj39W42jChEG/SpfA
 wlt2AFahovgmX0NYmA+3vlj9OUg5uEiK+Y9JsI0lqQNaQvQZc8/BfUkw9fE+hlboBNxrFIePOImfH
 pgA0S/LMuz7lF5pinw==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
 (envelope-from <dg@treblig.org>) id 1uRJKO-009ze4-2z;
 Mon, 16 Jun 2025 23:33:24 +0000
Date: Mon, 16 Jun 2025 23:33:24 +0000
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: "Moger, Babu" <babu.moger@amd.com>
Cc: pbonzini@redhat.com, zhao1.liu@intel.com, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, davydov-max@yandex-team.ru
Subject: Re: [PATCH v7 4/6] target/i386: Add couple of feature bits in
 CPUID_Fn80000021_EAX
Message-ID: <aFCpxId3J3E1rNHL@gallifrey>
References: <cover.1746734284.git.babu.moger@amd.com>
 <a5f6283a59579b09ac345b3f21ecb3b3b2d92451.1746734284.git.babu.moger@amd.com>
 <aELfPr7snDmIirNk@gallifrey>
 <e7cdab23-de40-457d-aa69-f0e210206c16@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e7cdab23-de40-457d-aa69-f0e210206c16@amd.com>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-34-amd64 (x86_64)
X-Uptime: 23:28:48 up 50 days, 7:42, 1 user, load average: 0.00, 0.00, 0.00
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

* Moger, Babu (babu.moger@amd.com) wrote:
> Hi Dave,
> 
> On 6/6/25 07:29, Dr. David Alan Gilbert wrote:
> > * Babu Moger (babu.moger@amd.com) wrote:
> >> Add CPUID bit indicates that a WRMSR to MSR_FS_BASE, MSR_GS_BASE, or
> >> MSR_KERNEL_GS_BASE is non-serializing amd PREFETCHI that the indicates
> >> support for IC prefetch.
> >>
> >> CPUID_Fn80000021_EAX
> >> Bit    Feature description
> >> 20     Indicates support for IC prefetch.
> >> 1      FsGsKernelGsBaseNonSerializing.
> > 
> > I'm curious about this:
> >   a) Is this new CPUs are non-serialising on that write?
> >   b) If so, what happens if you run existing kernels/firmware on them?
> >   c) Bonus migration question; what happens if you live migrate from a host
> >      that claims to be serialising to one that has the extra non-serialising
> >      flag but is disabled in the emulated CPU model.
> 
> Good question. After looking at the AMD64 Architecture Programmer’s Manual
> again, these writes have always been non-serializing. Behavior has not
> changed.

Ah OK, then nothing to worry about.

> We're just reporting it through CPUID now. This information
> likely isn’t being used anywhere.

Seems curious to add it then!

> Let me know if you have any questions.

No, thanks for the reply.

Dave

> -- 
> Thanks
> Babu Moger
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

