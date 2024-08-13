Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87D83C52D7C
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 20:13:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdxsd-00069d-6u; Tue, 13 Aug 2024 16:12:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sdxsb-00068d-HX
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 16:12:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sdxsY-00052N-1N
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 16:12:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723579942;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mR9lt0vW9gFFYO/c/SIvIOsr9Zo+gGFWHZcfLefsliQ=;
 b=TIr/ou81w8ReDMIG/0ynxjJtnYw7LGwcw/0kDUTKLchw1mpUr+gSmbKlvLvMAMMbgiV64G
 cQ6eOspaUVo2lcJWGUdQVgef9sZispbKcT/j/XQTU6cRo0T7Lq89rPmoX6rQ2MPb1paXo2
 168/5CdW5YZlk8Ab7qJNP9sET3S3tOY=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-324-6TLoYGHBN5GAIsDp470E4Q-1; Tue, 13 Aug 2024 16:12:20 -0400
X-MC-Unique: 6TLoYGHBN5GAIsDp470E4Q-1
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-44fea369811so8679491cf.0
 for <qemu-devel@nongnu.org>; Tue, 13 Aug 2024 13:12:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723579940; x=1724184740;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mR9lt0vW9gFFYO/c/SIvIOsr9Zo+gGFWHZcfLefsliQ=;
 b=CwyYuhXuJ/28sxsf+YCuplra5h+yE4J88k/8l5i7aX7wzfsdktPrYUjJpLBhTDCkoF
 yKFckG5wOqv3jyPI06C5p+lKCueEPfOJVARpJ4PuM5bZ8LpNzPrJGPtnRKjXf5qjXB3o
 Ei6lgsjJ1D5QzNgyZI+H5Hb5Y+LW+wS4Se7uqiHBApkUMXlr4fSF5Dr6oeSBoUbn+oI6
 L3u4Tj9un5VEwnaKbh1rB4IsuWb5dfJPF2tGhRQZSMxBRCt2C/9iTlk6MRC0353//BzR
 4Gq8U6u9t84Wh7YlSrQgKUmYEuOT41DbGAJZovg/3/47U+AAmpMI9HKoyxy1vK5xQN3/
 LHoA==
X-Gm-Message-State: AOJu0YzX+aSNEPFBeSULds7KiuK3ixnqw1j92ZvBDXQtcRXCb1Kuw1bD
 60bfmilqLX57VBtligA8U1PUl8OrnooOVz1LQnPkI9rsN5FI80olp5EFA3MCl+MMzj8Q+vlR7ef
 RY6peFZ/Y4H/Tycu4luYcTpWhDvMNO/CsT/vuluPSQ4FJjb9cLnlT
X-Received: by 2002:a05:6214:f2f:b0:6b5:ec9a:41ef with SMTP id
 6a1803df08f44-6bf5d16148cmr4630896d6.2.1723579940181; 
 Tue, 13 Aug 2024 13:12:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG/BNfE4XpJWv/9Rmjfy9gmf1Dqo0XLzgVOfmuyB37D43EBSuyaRgBzPpBPS0J/vIgncdZH+g==
X-Received: by 2002:a05:6214:f2f:b0:6b5:ec9a:41ef with SMTP id
 6a1803df08f44-6bf5d16148cmr4630626d6.2.1723579939519; 
 Tue, 13 Aug 2024 13:12:19 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6bd82e50f99sm36381556d6.104.2024.08.13.13.12.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Aug 2024 13:12:18 -0700 (PDT)
Date: Tue, 13 Aug 2024 16:12:16 -0400
From: Peter Xu <peterx@redhat.com>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH V2 00/11] Live update: cpr-exec
Message-ID: <Zru-IMUqg-6-1sbo@x1n>
References: <1719776434-435013-1-git-send-email-steven.sistare@oracle.com>
 <Zpk7Mf2c7LiNV2xC@x1n>
 <4f6200fa-c052-4295-b71a-c6deca11db9f@oracle.com>
 <Zq-oDMMYTktnQUIA@x1n>
 <ecbee102-262c-47e8-9da6-14e44f85f032@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ecbee102-262c-47e8-9da6-14e44f85f032@oracle.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Wed, Aug 07, 2024 at 03:47:47PM -0400, Steven Sistare wrote:
> On 8/4/2024 12:10 PM, Peter Xu wrote:
> > On Sat, Jul 20, 2024 at 05:26:07PM -0400, Steven Sistare wrote:
> > > On 7/18/2024 11:56 AM, Peter Xu wrote:
> > > > Steve,
> > > > 
> > > > On Sun, Jun 30, 2024 at 12:40:23PM -0700, Steve Sistare wrote:
> > > > > What?
> > > > 
> > > > Thanks for trying out with the cpr-transfer series.  I saw that that series
> > > > missed most of the cc list here, so I'm attaching the link here:
> > > > 
> > > > https://lore.kernel.org/r/1719776648-435073-1-git-send-email-steven.sistare@oracle.com
> > > > 
> > > > I think most of my previous questions for exec() solution still are there,
> > > > I'll try to summarize them all in this reply as much as I can.
> > > > 
> > > > > 
> > > > > This patch series adds the live migration cpr-exec mode, which allows
> > > > > the user to update QEMU with minimal guest pause time, by preserving
> > > > > guest RAM in place, albeit with new virtual addresses in new QEMU, and
> > > > > by preserving device file descriptors.
> > > > > 
> > > > > The new user-visible interfaces are:
> > > > >     * cpr-exec (MigMode migration parameter)
> > > > >     * cpr-exec-command (migration parameter)
> > > > 
> > > > I really, really hope we can avoid this..
> > > > 
> > > > It's super cumbersome to pass in a qemu cmdline in a qemu migration
> > > > parameter.. if we can do that with generic live migration ways, I hope we
> > > > stick with the clean approach.
> > > 
> > > This is no different than live migration, requiring a management agent to
> > > launch target qemu with all the arguments use to start source QEMU.  Now that
> > > same agent will send the arguments via cpr-exec-command.
> > 
> > It's still a bit different.
> > 
> > There we append "-incoming defer" only, which makes sense because we're
> > instructing a QEMU to take an incoming stream to load.  Now we append the
> > complete qemu cmdline within the QEMU itself, that was booted with exactly
> > the same cmdline.. :-( I would at least start to ask why we need to pass
> > the same thing twice..
> 
> Sometimes one must modify the command line arguments passed to new QEMU.
> This interface allows for that possibility.
> 
> In an earlier patch series, I proposed a cpr-exec command that took no arguments,
> and reused the old QEMU argv, which was remembered in main.  A reviewer pointed out
> how inflexible that was.  See my response to Daniel yesterday for more on the value
> of this flexibility.
> 
> This is not a burden for the mgmt agent.  It already knows the arguments because
> it can launch new qemu with the arguments for live migration.  Passing the arguments
> to cpr-exec-command is trivial.

Right, trivial as-is.  To me it's not a major blocker yet so far, but it's
still about being hackish, and I have this unpleasant feeling that we're
digging holes for our future.

> 
> > Not saying that this is no-go, but really looks unpretty to me from this
> > part.. especially if a cleaner solution seems possible.
> > 
> > > 
> > > > >     * anon-alloc (command-line option for -machine)
> > > > 
> > > > Igor questioned this, and I second his opinion..  We can leave the
> > > > discussion there for this one.
> > > 
> > > Continued on the other thread.
> > > 
> > > > > The user sets the mode parameter before invoking the migrate command.
> > > > > In this mode, the user issues the migrate command to old QEMU, which
> > > > > stops the VM and saves state to the migration channels.  Old QEMU then
> > > > > exec's new QEMU, replacing the original process while retaining its PID.
> > > > > The user specifies the command to exec new QEMU in the migration parameter
> > > > > cpr-exec-command.  The command must pass all old QEMU arguments to new
> > > > > QEMU, plus the -incoming option.  Execution resumes in new QEMU.
> > > > > 
> > > > > Memory-backend objects must have the share=on attribute, but
> > > > > memory-backend-epc is not supported.  The VM must be started
> > > > > with the '-machine anon-alloc=memfd' option, which allows anonymous
> > > > > memory to be transferred in place to the new process.
> > > > > 
> > > > > Why?
> > > > > 
> > > > > This mode has less impact on the guest than any other method of updating
> > > > > in place.
> > > > 
> > > > So I wonder whether there's comparison between exec() and transfer mode
> > > > that you recently proposed.
> > > 
> > > Not yet, but I will measure it.
> > 
> > Thanks.
> > 
> > > 
> > > > I'm asking because exec() (besides all the rest of things that I dislike on
> > > > it in this approach..) should be simply slower, logically, due to the
> > > > serialized operation to (1) tearing down the old mm, (2) reload the new
> > > > ELF, then (3) runs through the QEMU init process.
> > > > 
> > > > If with a generic migration solution, the dest QEMU can start running (2+3)
> > > > concurrently without even need to run (1).
> > > > 
> > > > In this whole process, I doubt (2) could be relatively fast, (3) I donno,
> > > > maybe it could be slow but I never measured; Paolo may have good idea as I
> > > > know he used to work on qboot.
> > > 
> > > We'll see, but in any case these take < 100 msec, which is a wonderfully short
> > 
> > I doubt whether it keeps <100ms when the VM is large.  Note that I think we
> > should cover the case where the user does 4k mapping for a large guest.
> > 
> > So I agree that 4k mapping over e.g. 1T without hugetlb may not be the
> > ideal case, but the question is I suspect there're indeed serious users
> > using QEMU like that, and if we have most exactly a parallel solution that
> > does cover this case, it is definitely preferrable to consider the other
> > from this POV, simply because there's nothing to lose there..
> > 
> > > pause time unless your customer is doing high speed stock trading.  If cpr-transfer
> > > is faster still, that's gravy, but cpr-exec is still great.
> > > 
> > > > For (1), I also doubt in your test cases it's fast, but it may not always
> > > > be fast.  Consider the guest has a huge TBs of shared mem, even if the
> > > > memory will be completely shared between src/dst QEMUs, the pgtable won't!
> > > > It means if the TBs are mapped in PAGE_SIZE tearing down the src QEMU
> > > > pgtable alone can even take time, and that will be accounted in step (1)
> > > > and further in exec() request.
> > > 
> > > Yes, there is an O(n) effect here, but it is a fast O(n) when the memory is
> > > backed by huge pages.  In UEK, we make it faster still by unmapping in parallel
> > > with multiple threads.  I don't have the data handy but can share after running
> > > some experiments.  Regardless, this time is negligible for small and medium
> > > size guests, which form the majority of instances in a cloud.
> > 
> > Possible.  It's just that it sounds like a good idea to avoid having the
> > downtime taking any pgtable tearing down into account here for the old mm,
> > irrelevant of how much time it'll take.  It's just that I suspect some use
> > case can take fair amount of time.
> 
> Here is the guest pause time, measured as the interval from the start
> of the migrate command to the new QEMU guest reaching the running state.
> The average over 10 runs is shown, in msecs.
> Huge pages are enabled.
> Guest memory is memfd.
> The kernel is 6.9.0  (not UEK, so no parallel unmap)
> The system is old and slow: Intel(R) Xeon(R) CPU E5-2699 v4 @ 2.20GHz
> 
>         cpr-exec    cpr-transfer
> 256M    180         148
> 16G     190         150
> 128G    250         159
> 1T      300 ?       159 ?                // extrapolated
> 
> At these scales, the difference between exec and transfer is not significant.
> A provider would choose one vs the other based on ease of implementation in
> their mgmt agent and container environment.

Thanks. Are these maximum huge page the memsize can take (either 2M or 1G),
or is this only about 2M?

> 
> For small pages and large memory, cpr-exec can take multiple seconds, and
> the UEK parallel unmap reduces that further.  But, that is the exception,
> not the rule.  Providers strive to back huge memories with huge pages.  It
> makes no sense to use such a valuable resource in the crappiest way possible
> (ie with small pages).

I can't say nobody uses small pages when memory is large.  The thing is
hugetlb loses features comparing to small pages; or say, merely all the
memory features Linux provides.  So I won't be surprised if someone tells
me there's TB level VMs that is using small page on purpose for any of
those features (swap, ksm, etc.).  I had vague memory there was customers
using such setup in the past, without remembering the reasons.

I do wish a design that will perform well even there, so it works for all
cases we can think of so far.  Not to mention cpr-transfer seems to
outperforms everywhere too.  Unless the "management layer benefits" are so
strong.. it seems to me we have a clear choice.  I understand it may affect
your plan, but let's be fair, or.. is it not the case?

> 
> > So I think this is "one point less" for exec() solution, while the issue
> > can be big or small on its own.  What matters is IMHO where exec() is
> > superior so that we'd like to pay for this.  I'll try to stop saying "let's
> > try to avoid using exec() as it sounds risky", but we still need to compare
> > with solid pros and cons.
> > 
> > > 
> > > > All these fuss will be avoided if you use a generic live migration model
> > > > like cpr-transfer you proposed.  That's also cleaner.
> > > > 
> > > > > The pause time is much lower, because devices need not be torn
> > > > > down and recreated, DMA does not need to be drained and quiesced, and minimal
> > > > > state is copied to new QEMU.  Further, there are no constraints on the guest.
> > > > > By contrast, cpr-reboot mode requires the guest to support S3 suspend-to-ram,
> > > > > and suspending plus resuming vfio devices adds multiple seconds to the
> > > > > guest pause time.  Lastly, there is no loss of connectivity to the guest,
> > > > > because chardev descriptors remain open and connected.
> > > > 
> > > > Again, I raised the question on why this would matter, as after all mgmt
> > > > app will need to coop with reconnections due to the fact they'll need to
> > > > support a generic live migration, in which case reconnection is a must.
> > > > 
> > > > So far it doesn't sound like a performance critical path, for example, to
> > > > do the mgmt reconnects on the ports.  So this might be an optimization that
> > > > most mgmt apps may not care much?
> > > 
> > > Perhaps.  I view the chardev preservation as nice to have, but not essential.
> > > It does not appear in this series, other than in docs.  It's easy to implement
> > > given the CPR foundation.  I suggest we continue this discussion when I post
> > > the chardev series, so we can focus on the core functionality.
> > 
> > It's just that it can affect our decision on choosing the way to go.
> > 
> > For example, do we have someone from Libvirt or any mgmt layer can help
> > justify this point?
> > 
> > As I said, I thought most facilities for reconnection should be ready, but
> > I could miss important facts in mgmt layers..
> 
> I will more deeply study reconnects in the mgmt layer, run some experiments to
> see if it is seamless for the end user, and get back to you, but it will take
> some time.
> > > > > These benefits all derive from the core design principle of this mode,
> > > > > which is preserving open descriptors.  This approach is very general and
> > > > > can be used to support a wide variety of devices that do not have hardware
> > > > > support for live migration, including but not limited to: vfio, chardev,
> > > > > vhost, vdpa, and iommufd.  Some devices need new kernel software interfaces
> > > > > to allow a descriptor to be used in a process that did not originally open it.
> > > > 
> > > > Yes, I still think this is a great idea.  It just can also be built on top
> > > > of something else than exec().
> > > > 
> > > > > 
> > > > > In a containerized QEMU environment, cpr-exec reuses an existing QEMU
> > > > > container and its assigned resources.  By contrast, consider a design in
> > > > > which a new container is created on the same host as the target of the
> > > > > CPR operation.  Resources must be reserved for the new container, while
> > > > > the old container still reserves resources until the operation completes.
> > > > 
> > > > Note that if we need to share RAM anyway, the resources consumption should
> > > > be minimal, as mem should IMHO be the major concern (except CPU, but CPU
> > > > isn't a concern in this scenario) in container world and here the shared
> > > > guest mem shouldn't be accounted to the dest container.  So IMHO it's about
> > > > the metadata QEMU/KVM needs to do the hypervisor work, it seems to me, and
> > > > that should be relatively small.
> > > > 
> > > > In that case I don't yet see it a huge improvement, if the dest container
> > > > is cheap to initiate.
> > > 
> > > It's about reserving memory and CPUs, and transferring those reservations from
> > > the old instance to the new, and fiddling with the OS mechanisms that enforce
> > > reservations and limits.  The devil is in the details, and with the exec model,
> > > the management agent can ignore all of that.
> > > 
> > > You don't see it as a huge improvement because you don't need to write the
> > > management code.  I do!
> > 
> > Heh, possibly true.
> > 
> > Could I ask what management code you're working on?  Why that management
> > code doesn't need to already work out these problems with reconnections
> > (like pre-CPR ways of live upgrade)?
> 
> OCI - Oracle Cloud Infrastructure.
> Mgmt needs to manage reconnections for live migration, and perhaps I could
> leverage that code for live update, but happily I did not need to.  Regardless,
> reconnection is the lesser issue.  The bigger issue is resource management and
> the container environment.  But I cannot justify that statement in detail without
> actually trying to implement cpr-transfer in OCI.

I see.  Is OCI open source somewhere?

If it's close-sourced, maybe it'll be helpful to see how the exec() design
could benefit other open source mgmt applications.

> 
> > > Both modes are valid and useful - exec in container, or launch a new container.
> > > I have volunteered to implement the cpr-transfer mode for the latter, a mode
> > > I do not use.  Please don't reward me by dropping the mode I care about :)
> > > Both modes can co-exist.  The presence of the cpr-exec specific code in qemu
> > > will not hinder future live migration development.
> > 
> > I'm trying to remove some of my "prejudices" on exec() :).  Hopefully that
> > proved more or less that I simply wanted to be fair on making a design
> > decision.  I don't think I have a strong opinion, but it looks to me not
> > ideal to merge two solutions if both modes share the use case.
> > 
> > Or if you think both modes should service different purpose, we might
> > consider both, but that needs to be justified - IOW, we shouldn't merge
> > anything that will never be used.
> 
> The use case is the same for both modes, but they are simply different
> transport methods for moving descriptors from old QEMU to new.  The developer
> of the mgmt agent should be allowed to choose.

It's out of my capability to review the mgmt impact on this one.  This is
all based on the idea that I think most mgmt apps supports reconnections
pretty well. If that's the case, I'd definitely go for the transfer mode.
I'm not sure whether there's anyone from mgmt layer would like to share
some opinion; Dan could be the most suitable in the loop already.

Thanks,

-- 
Peter Xu


