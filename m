Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF58ECA1010
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Sep 2025 17:11:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uuZwb-0001KY-3A; Fri, 05 Sep 2025 13:09:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1uuZwW-0001JL-1u
 for qemu-devel@nongnu.org; Fri, 05 Sep 2025 13:09:44 -0400
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1uuZwM-0005S9-Br
 for qemu-devel@nongnu.org; Fri, 05 Sep 2025 13:09:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
 :Subject; bh=jP2U6R93yMT0Rx+zrwNBIHOLhbux+QNJkFxMXHgpcQ4=; b=gAh4Z2Y+5nxAWL6L
 a1J6F00wnQTq0i3xAWsVyXt/KvYBU7MV9XZTJnUaHwJ4ck7bp3mwIenh6xYLi9925bEt7HbKbrW9C
 ZO9GdS2jGB9Ie0wJ8v3YNXcfjqq5yOUMwaNs1z4l/w4BPORlhpE2QPXfSM08FlMMX7z6HDn9tPbiC
 HXDSESsgXI+aRXdebnbEOL/wBiyjB+41yL1mqnl8SaJtYvZ0AsbjTsPkQXrQuutm3HsEc2uNVsx0n
 /M9kOWI7pf739LvfdX5Xbwr+ANRMTMcHDIOnX4UTYyIC4B4mtkYJGbEPoluJNPZIweQIK1zRSIJS3
 9Dp8sNO/wksmBffL9w==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
 (envelope-from <dg@treblig.org>) id 1uuZvt-008xWV-2Q;
 Fri, 05 Sep 2025 17:09:05 +0000
Date: Fri, 5 Sep 2025 17:09:05 +0000
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: Peter Xu <peterx@redhat.com>
Cc: Steve Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org,
 Fabiano Rosas <farosas@suse.de>, Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [PATCH V3 0/9] Live update: cpr-exec
Message-ID: <aLsZMXHDc4uKMkyx@gallifrey>
References: <1755191843-283480-1-git-send-email-steven.sistare@oracle.com>
 <aLsUQWjW8gyZjySs@x1.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <aLsUQWjW8gyZjySs@x1.local>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-34-amd64 (x86_64)
X-Uptime: 17:05:18 up 131 days,  1:18,  1 user,  load average: 0.00, 0.04, 0.01
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

* Peter Xu (peterx@redhat.com) wrote:
> Add Vladimir and Dan.
> 
> On Thu, Aug 14, 2025 at 10:17:14AM -0700, Steve Sistare wrote:
> > This patch series adds the live migration cpr-exec mode.  
> > 
> > The new user-visible interfaces are:
> >   * cpr-exec (MigMode migration parameter)
> >   * cpr-exec-command (migration parameter)
> > 
> > cpr-exec mode is similar in most respects to cpr-transfer mode, with the 
> > primary difference being that old QEMU directly exec's new QEMU.  The user
> > specifies the command to exec new QEMU in the migration parameter
> > cpr-exec-command.
> > 
> > Why?
> > 
> > In a containerized QEMU environment, cpr-exec reuses an existing QEMU
> > container and its assigned resources.  By contrast, cpr-transfer mode
> > requires a new container to be created on the same host as the target of
> > the CPR operation.  Resources must be reserved for the new container, while
> > the old container still reserves resources until the operation completes.
> > Avoiding over commitment requires extra work in the management layer.
> 
> Can we spell out what are these resources?
> 
> CPR definitely relies on completely shared memory.  That's already not a
> concern.
> 
> CPR resolves resources that are bound to devices like VFIO by passing over
> FDs, these are not over commited either.
> 
> Is it accounting QEMU/KVM process overhead?  That would really be trivial,
> IMHO, but maybe something else?
> 
> > This is one reason why a cloud provider may prefer cpr-exec.  A second reason
> > is that the container may include agents with their own connections to the
> > outside world, and such connections remain intact if the container is reused.
> 
> We discussed about this one.  Personally I still cannot understand why this
> is a concern if the agents can be trivially started as a new instance.  But
> I admit I may not know the whole picture.  To me, the above point is more
> persuasive, but I'll need to understand which part that is over-commited
> that can be a problem.

> After all, cloud hosts should preserve some extra memory anyway to make
> sure dynamic resources allocations all the time (e.g., when live migration
> starts, KVM pgtables can drastically increase if huge pages are enabled,
> for PAGE_SIZE trackings), I assumed the over-commit portion should be less
> that those.. and when it's also temporary (src QEMU will release all
> resources after live upgrade) then it looks manageable.

k8s used to find it very hard to change the amount of memory allocated to a
container after launch (although I heard that's getting fixed); so you'd
need more excess at the start even if your peek during hand over is only
very short.

Dave
> 
> > 
> > How?
> > 
> > cpr-exec preserves descriptors across exec by clearing the CLOEXEC flag,
> > and by sending the unique name and value of each descriptor to new QEMU
> > via CPR state.
> > 
> > CPR state cannot be sent over the normal migration channel, because devices
> > and backends are created prior to reading the channel, so this mode sends
> > CPR state over a second migration channel that is not visible to the user.
> > New QEMU reads the second channel prior to creating devices or backends.
> > 
> > The exec itself is trivial.  After writing to the migration channels, the
> > migration code calls a new main-loop hook to perform the exec.
> > 
> > Example:
> > 
> > In this example, we simply restart the same version of QEMU, but in
> > a real scenario one would use a new QEMU binary path in cpr-exec-command.
> > 
> >   # qemu-kvm -monitor stdio
> >   -object memory-backend-memfd,id=ram0,size=1G
> >   -machine memory-backend=ram0 -machine aux-ram-share=on ...
> > 
> >   QEMU 10.1.50 monitor - type 'help' for more information
> >   (qemu) info status
> >   VM status: running
> >   (qemu) migrate_set_parameter mode cpr-exec
> >   (qemu) migrate_set_parameter cpr-exec-command qemu-kvm ... -incoming file:vm.state
> >   (qemu) migrate -d file:vm.state
> >   (qemu) QEMU 10.1.50 monitor - type 'help' for more information
> >   (qemu) info status
> >   VM status: running
> > 
> > Steve Sistare (9):
> >   migration: multi-mode notifier
> >   migration: add cpr_walk_fd
> >   oslib: qemu_clear_cloexec
> >   vl: helper to request exec
> >   migration: cpr-exec-command parameter
> >   migration: cpr-exec save and load
> >   migration: cpr-exec mode
> >   migration: cpr-exec docs
> >   vfio: cpr-exec mode
> 
> The other thing is, as Vladimir is working on (looks like) a cleaner way of
> passing FDs fully relying on unix sockets, I want to understand better on
> the relationships of his work and the exec model.
> 
> I still personally think we should always stick with unix sockets, but I'm
> open to be convinced on above limitations.  If exec is better than
> cpr-transfer in any way, the hope is more people can and should adopt it.
> 
> We also have no answer yet on how cpr-exec can resolve container world with
> seccomp forbidding exec.  I guess that's a no-go.  It's definitely a
> downside instead.  Better mention that in the cover letter.
> 
> Thanks,
> 
> -- 
> Peter Xu
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

