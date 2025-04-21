Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD984C369AB
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Apr 2025 17:07:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u6ubs-00076D-Cu; Mon, 21 Apr 2025 13:07:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1u6ubp-00075X-Bw
 for qemu-devel@nongnu.org; Mon, 21 Apr 2025 13:07:05 -0400
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1u6ubn-0007We-37
 for qemu-devel@nongnu.org; Mon, 21 Apr 2025 13:07:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
 :Subject; bh=pcQ6xEwxCmImny0xLp5z++xBAhdY0CLLJjUrAML0X+0=; b=rQDlo4SLdarunIU7
 EWOTlbITE7Jc/r+DudacDfTMcamUVFWMMKrlF1tLoTRE1Zr49gYYAP0azSczqKqlXN4vSCgX685Oe
 3Spebl8AMy6fOh5uWkaTDuZVngxv8q1F8gGuL6BvslTq8bAFYeLHkSLxlX9JRa15HhNepCPis2M+o
 R6cTW/u3NOIqI3OnxDjHiCL7co1DqsfqvoWdxdAjheHScgKQDh8EsAuOWrt+9fCa9N+9ySKRjjOQK
 QzHibfmoM5+jB1ohZjB8VK0t++YNs0kOWhlU5Vl+6gdFoP0c2Bc1TEscPs8BuZJ8BoRINqFQ/lzYQ
 Qde+X8/qnVI7lgdjiw==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
 (envelope-from <dg@treblig.org>) id 1u6ubk-00Cs6Y-0P;
 Mon, 21 Apr 2025 17:07:00 +0000
Date: Mon, 21 Apr 2025 17:07:00 +0000
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: Dongli Zhang <dongli.zhang@oracle.com>
Cc: steven.sistare@oracle.com, qemu-devel@nongnu.org
Subject: Re: Trying cpr
Message-ID: <aAZ7NNxTAn8u8egY@gallifrey>
References: <aAZKaMkKYPlmBMcZ@gallifrey>
 <df432912-de0c-4a77-8008-0c07b23f42f0@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <df432912-de0c-4a77-8008-0c07b23f42f0@oracle.com>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 17:01:39 up 348 days,  4:15,  1 user,  load average: 0.00, 0.00, 0.00
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

* Dongli Zhang (dongli.zhang@oracle.com) wrote:
> 
> 
> On 4/21/25 6:38 AM, Dr. David Alan Gilbert wrote:
> > Hi Steve,
> >   I've just had a go with cpr-transfer, it's quite interesting.
> > I was just trying it on my (AMD) desktop.
> > 
> > * I was running with qemu displaying graphics, and after migration
> > the source display got updated every time I moved my mouse into the
> > source window; the VM was still stopped, but I guess that means
> > the source GUI is still parsing the guest VRAM and displaying it.
> > I'm not sure if there's any other interactions - e.g. is there any
> > situation where the source GUI will try and write into the shared
> > guest ram?
> > 
> > * Given that you pass fd's over the CPR socket, had you considered
> > passing main migration fd's over it as well, that way you'd
> > only need one incoming.
> > 
> > * The guest noticed the time skew:
> >   timekeeping watchdog on CPU1: Marking clocksource 'tsc' as unstable because the skew is too large:
> >      'kvm-clock' wd_nsec: 556248511 wd_new: 4a93129e69 wd_alst: 4a71eaf0aa mask: (all f's)
> >      'tsc' cs_nsec: 514023131 cs_now: 1047f1d8489 cs_last: 10414538c1 mask: (all f's)
> >      Clocksource 'tsc' skewed -42225380 ns (-42 ms) over watchdog 'kvm-clock' interval of 556248511 ns (556 ms)
> >      'kvm-clock' (not 'tsc') is current clocksource
> 
> Here the guest kernel uses kvm-clock to measure the accuracy of tsc.
> 
> While there is a chance that the accuracy of tsc is broken, it is more likely
> the kvm-clock's accuracy is broken.

Well, remember that with CPR there's a live migration going on and a brief
pause; so it's always a fun question about what happens with clocks; however
with CPR I guess there's a better chance of it being solvable than general
live migration.

> That is, suppose the TSC is still good enough, it is marked unstable because the
> kernel uses an inaccurate kvm-clock to measure tsc.
> 
> How about the guest kernel version? Does it have the below patch?

It's debian's 6.12.12 as the guest, and    git describe b50db7095
v5.16-rc2-5-gb50db7095fe0

so I'd say yes, should have that patch.

> Or is this an
> AMD server (by default X86_FEATURE_CONSTANT_TSC isn't set)?

It's an AMD single socket desktop (3950X) [with 6.14.2 kernel]

> 
> x86/tsc: Disable clocksource watchdog for TSC on qualified platorms
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=b50db7095fe002fa3e16605546cba66bf1b68a3e
> 
> In addition, I assume the cpr-transfer doesn't re-create a new KVM instance (fd).
> 
> I used to encounter similar issue during vCPU hotplug.
> 
> KVM: x86: Don't unnecessarily force masterclock update on vCPU hotplug
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c52ffadc65e28ab461fd055e9991e8d8106a0056
> 
> David Woodhouse has a patchset related to kvmclock and live migration.
> 
> [RFC PATCH v3 00/21] Cleaning up the KVM clock mess
> https://lore.kernel.org/all/20240522001817.619072-1-dwmw2@infradead.org/
> 
> Maciej also fixed a similar clock unstable issue.
> 
> target/i386: Reset TSCs of parked vCPUs too on VM reset
> https://gitlab.com/qemu-project/qemu/-/commit/3f2a05b31ee9ce2ddb6c75a9bc3f5e7f7af9a76f

Thanks.

Dave

> Dongli Zhang
> 
> > 
> >   (That was hand copied, probably with some typos - who knew the
> >    GUI doesn't let you copy/paste from serial0...)
> > 
> > 
> > The source commandline was:
> > ./try/qemu-system-x86_64  -object memory-backend-file,id=ram0,size=4G,mem-path=/dev/shm/qemuram0,share=on -m 4G -machine memory-backend=ram0,aux-ram-share=on -cpu host --enable-kvm -smp 16 -drive if=virtio,file=/discs/more/images/debian-13-nocloud-amd64-daily.qcow2 -qmp stdio
> > 
> > The dest commandline was:
> > ./try/qemu-system-x86_64 -object memory-backend-file,id=ram0,size=4G,mem-path=/dev/shm/qemuram0,share=on -m 4G -machine memory-backend=ram0,aux-ram-share=on -cpu host --enable-kvm -smp 16 -drive if=virtio,file=/discs/more/images/debian-13-nocloud-amd64-daily.qcow2 -incoming tcp:0:44444 -incoming '{"channel-type": "cpr", "addr": { "transport": "socket", "type": "unix", "path": "cpr.sock"}}'
> > 
> > Dave
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

