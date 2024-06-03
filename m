Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0282C25B75
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 22:30:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEGBU-0004jf-Q7; Mon, 03 Jun 2024 18:29:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sEGBT-0004hY-2m
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 18:29:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sEGBQ-00021U-EB
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 18:29:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717453779;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8eoR9GczqPu92gsNPUA/Z+EXuzTW6110CSPi145a7EI=;
 b=KAkPLNVsNx9d1BJbigFWnat1J6qn7tPPe/d0iqLGl6TY/vh8A4oFcyHjJmanBeNDTTovRR
 OamcEefAbxgAl6x1woCK7XoSKMVpSzOK7VrJrioN/fj23UVNKxcvr9/BIxI/81f6vmnp2n
 54Hg1v4siXUwnnjYydL+v524aehHSxg=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-257-f33dLEiHOImOf2xA_4rKuA-1; Mon, 03 Jun 2024 18:29:37 -0400
X-MC-Unique: f33dLEiHOImOf2xA_4rKuA-1
Received: by mail-ot1-f69.google.com with SMTP id
 46e09a7af769-6f908f002c2so395212a34.1
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 15:29:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717453777; x=1718058577;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8eoR9GczqPu92gsNPUA/Z+EXuzTW6110CSPi145a7EI=;
 b=OmFIt0Y+DBwjOhPbT3eGy7Xs48XeZ4HUkwemnCSCcunQutnp+z54714Ml5dFfyAkdD
 ZkLgRd45IJpVLEV4oeo3ZFV6VnAFSgNY5fEkp2ZdAcGBjXjSwQsoDLy4fyOvwcN38Tb4
 /TvnqTgNQ3BMK789ag35auUnkuqxFL7M+YWEK0ilgd37oJ3lq1CUcPmrwpefHAJmngl6
 n+OX1wPa1RZ/4HRqm+S9Tka1ULlbB/g/p1vTW8wSY9Ou9V4p97kNTX5VGz8OerlfMX2R
 TbKR2h1F2H6iCPsb2qOSp+63Ll436Mejo2X97XxBFYf02IuAW0TRessqv1f022EToAT2
 5XJQ==
X-Gm-Message-State: AOJu0Yy5wCVqd/Q0oRPD/3C7JEcTsb313eakxuA+71NcqxdSar/ONrBL
 L1AxLpG1j3GMwgHoVzDMCrgV0LrkGoktfSR41ZZXrIzkKcMm8zwr6Qx1iLnwKelUw24NtyGHoEf
 bOV/j44CfeG99xVNNup4s+cfqlWiWGTOz2ctjyI1gEN0y0zzzOon/
X-Received: by 2002:a05:6830:c8e:b0:6f9:37d8:c057 with SMTP id
 46e09a7af769-6f937d8c380mr712465a34.3.1717453776254; 
 Mon, 03 Jun 2024 15:29:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEoP8WGnwrQ/UItG9bcf4XVu3Nn8pcDa9Cs5di2QRLlWDKiQre86tTeGfSwnT4kPJ6NNAGsww==
X-Received: by 2002:a05:6830:c8e:b0:6f9:37d8:c057 with SMTP id
 46e09a7af769-6f937d8c380mr712443a34.3.1717453775544; 
 Mon, 03 Jun 2024 15:29:35 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-794f30614afsm317866185a.97.2024.06.03.15.29.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jun 2024 15:29:35 -0700 (PDT)
Date: Mon, 3 Jun 2024 18:29:32 -0400
From: Peter Xu <peterx@redhat.com>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH V1 19/26] physmem: preserve ram blocks for cpr
Message-ID: <Zl5DzHDsBlk5BhHZ@x1n>
References: <1714406135-451286-1-git-send-email-steven.sistare@oracle.com>
 <1714406135-451286-20-git-send-email-steven.sistare@oracle.com>
 <ZlZQVijf2weEmzYK@x1n>
 <c3f23e83-81d7-469a-aa04-29785fa6f8d7@oracle.com>
 <ZleBOx6pN6KCn0a2@x1n>
 <e0cb49da-9799-4a26-8844-f5055b6ae45b@oracle.com>
 <ZljH1zbqisK6VowI@x1n>
 <22df3040-bc08-46d4-bbbf-378a278476ff@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <22df3040-bc08-46d4-bbbf-378a278476ff@oracle.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Fri, May 31, 2024 at 03:32:11PM -0400, Steven Sistare wrote:
> On 5/30/2024 2:39 PM, Peter Xu wrote:
> > On Thu, May 30, 2024 at 01:12:40PM -0400, Steven Sistare wrote:
> > > On 5/29/2024 3:25 PM, Peter Xu wrote:
> > > > On Wed, May 29, 2024 at 01:31:53PM -0400, Steven Sistare wrote:
> > > > > On 5/28/2024 5:44 PM, Peter Xu wrote:
> > > > > > On Mon, Apr 29, 2024 at 08:55:28AM -0700, Steve Sistare wrote:
> > > > > > > Preserve fields of RAMBlocks that allocate their host memory during CPR so
> > > > > > > the RAM allocation can be recovered.
> > > > > > 
> > > > > > This sentence itself did not explain much, IMHO.  QEMU can share memory
> > > > > > using fd based memory already of all kinds, as long as the memory backend
> > > > > > is path-based it can be shared by sharing the same paths to dst.
> > > > > > 
> > > > > > This reads very confusing as a generic concept.  I mean, QEMU migration
> > > > > > relies on so many things to work right.  We mostly asks the users to "use
> > > > > > exactly the same cmdline for src/dst QEMU unless you know what you're
> > > > > > doing", otherwise many things can break.  That should also include ramblock
> > > > > > being matched between src/dst due to the same cmdlines provided on both
> > > > > > sides.  It'll be confusing to mention this when we thought the ramblocks
> > > > > > also rely on that fact.
> > > > > > 
> > > > > > So IIUC this sentence should be dropped in the real patch, and I'll try to
> > > > > > guess the real reason with below..
> > > > > 
> > > > > The properties of the implicitly created ramblocks must be preserved.
> > > > > The defaults can and do change between qemu releases, even when the command-line
> > > > > parameters do not change for the explicit objects that cause these implicit
> > > > > ramblocks to be created.
> > > > 
> > > > AFAIU, QEMU relies on ramblocks to be the same before this series.  Do you
> > > > have an example?  Would that already cause issue when migrate?
> > > 
> > > Alignment has changed, and used_length vs max_length changed when
> > > resizeable ramblocks were introduced.  I have dealt with these issues
> > > while supporting cpr for our internal use, and the learned lesson is to
> > > explicitly communicate the creation-time parameters to new qemu.
> > 
> > Why used_length can change?  I'm looking at ram_mig_ram_block_resized():
> > 
> >      if (!migration_is_idle()) {
> >          /*
> >           * Precopy code on the source cannot deal with the size of RAM blocks
> >           * changing at random points in time - especially after sending the
> >           * RAM block sizes in the migration stream, they must no longer change.
> >           * Abort and indicate a proper reason.
> >           */
> >          error_setg(&err, "RAM block '%s' resized during precopy.", rb->idstr);
> >          migration_cancel(err);
> >          error_free(err);
> >      }
> > 
> > We sent used_length upfront of a migration during SETUP phase.  Looks like
> > what you're describing can be something different, though?
> 
> I was imprecise.  used_length did not change; it was introduced as being
> different than max_length when resizeable ramblocks were introduced.
> 
> The max_length is not sent.  It is an implicit property of the implementation,
> and can change.  It is the size of the memfd mapping, so we need to know it
> and preserve it.
> 
> used_length is indeed sent during SETUP.  We could also send max_length
> at that time, and store both in the struct ramblock, and *maybe* that would
> be safe, but that is more fragile and less future proof than setting both
> properties to the correct value when the ramblock struct is created.
> 
> And BTW, the ramblock properties are sent using ad-hoc code in setup.
> I send them using nice clean vmstate.

Right, I agree that's not pretty at all... I wished we have had something
better, but that was just there for years.

When you said max_length can change, could you give an example?  I want to
know whether it means we have bug already, and bug fixing can even be done
before the rest.

Thinking now, maybe max_length is indeed fine to be changed acorss
migration?

Consider the fact that only used_length is used in both src/dst for
e.g. migration, dirty tracking, etc. purposes.  Basically we assumed that's
the "real size" of RAM irrelevant of "how large it used to be before
migration", or "how large it can grow after migration completes", while
max_length is "possible max value" here but isn't really important for
migration.

E.g., mem resize can allow a larger range after migration if the user
specifies max_length on dest to be larger than src max_length somehow, and
logically migration should still work indeed.  I just don't know whether
there'll be people using it like that.

> 
> > Regarding to rb->align: isn't that mostly a constant, reflecting the MR's
> > alignment?  It's set when ramblock is created IIUC:
> > 
> >      rb->align = mr->align;
> > 
> > When will the alignment change?
> 
> The alignment specified by the mr to allocate a new block is an implicit property
> of the implementation, and has changed before, from one qemu release to another.
> Not often, but it did, and could again in the future.  Communicating the alignment
> from old qemu to new qemu is future proof.

Same on this one; do you have examples around and share?

I hope we don't introduce things without good reasons.  If we're talking
about "alignment can change", it'll be very helpful to know what we're
fixing against (before CPR's need).

> 
> > > These are not an issue for migration because the ramblock is re-created
> > > and the data copied into the new memory.
> > > 
> > > > > > > Mirror the mr->align field in the RAMBlock to simplify the vmstate.
> > > > > > > Preserve the old host address, even though it is immediately discarded,
> > > > > > > as it will be needed in the future for CPR with iommufd.  Preserve
> > > > > > > guest_memfd, even though CPR does not yet support it, to maintain vmstate
> > > > > > > compatibility when it becomes supported.
> > > > > > 
> > > > > > .. It could be about the vfio vaddr update feature that you mentioned and
> > > > > > only for iommufd (as IIUC vfio still relies on iova ranges, then it won't
> > > > > > help here)?
> > > > > > 
> > > > > > If so, IMHO we should have this patch (or any variance form) to be there
> > > > > > for your upcoming vfio support.  Keeping this around like this will make
> > > > > > the series harder to review.  Or is it needed even before VFIO?
> > > > > 
> > > > > This patch is needed independently of vfio or iommufd.
> > > > > 
> > > > > guest_memfd is independent of vfio or iommufd.  It is a recent addition
> > > > > which I have not tried to support, but I added this placeholder field
> > > > > to it can be supported in the future without adding a new field later
> > > > > and maintaining backwards compatibility.
> > > > 
> > > > Is guest_memfd the only user so far, then?  If so, would it be possible we
> > > > split it as a separate effort on top of the base cpr-exec support?
> > > 
> > > I don't understand the question.  I am indeed deferring support for guest_memfd
> > > to a future time.  For now, I am adding a blocker, and reserving a field for
> > > it in the preserved ramblock attributes, to avoid adding a subsection later.
> > 
> > I meant I'm thinking whether the new ramblock vmsd may not be required for
> > the initial implementation.
> > 
> > E.g., IIUC vaddr is required by iommufd, and so far that's not part of the
> > initial support.
> > 
> > Then I think a major thing is about the fds to be managed that will need to
> > be shared.  If we put guest_memfd aside, it can be really, mostly, about
> > VFIO fds.
> 
> The block->fd must be preserved.  That is the fd of the memfd_create used
> by cpr.

Right, cpr needs all fds be passed over and I think that's a great idea.

It could be a matter of how do we mark those fds, how to pass them over,
and whether do we need to manage them one by one, or in a batch.

E.g., in my mind now I'm picturing something, I probably shared it bit by
bit in my previous replies when trying to review your series, but in
general, a cleaner approach may look like this:

  - QEMU provides a fd-manager, managing all relevant fds.  It can be
    ramblock fds, vfio fds, vhost fds, or whatever fds.  We "name" these
    fds in some way, so that we know how to recover on the other side.  We
    don't differenciate them with different vmsds: no need to migrate a fd
    in ramblock vmsd, then a fd in vfio vmsd, then a fd in vhost fd.  We
    migrate them all, then modules can try to fetch them on dest qemu,
    perhaps transparently (like qemu_open_internal() on /dev/fdsets), maybe
    not.  I haven't thought about that details.

  - FDs need to be passed over _before_ VM starts.  It might be easier to
    not attach that to a "pre" phase of "migration", but it might be doable
    in such way that: when cpr-xxx mode is supported, Libvirt can use a new
    QMP command to fetch all the FDs in one shot using scm rights (e.g.,
    "fd-manager-fetch"), then apply those list of fds _before_ dest QEMU
    try to initialize using another QMP command (e.g.,
    "fd-manager-apply"). QEMU src/dst don't talk at all on the FDs; they
    rely on Libvirt to set them up.  This will greatly simplify migration
    code on fd passovers; either using execve() or scm rights.

In this picture, neither execve() nor new migration protocol change needed.
Migration stream keeps just like a normal migration stream.

> 
> > For that, I'm wondering whether you looked into something like
> > this:
> > 
> > commit da3e04b26fd8d15b344944504d5ffa9c5f20b54b
> > Author: Zhenzhong Duan <zhenzhong.duan@intel.com>
> > Date:   Tue Nov 21 16:44:10 2023 +0800
> > 
> >      vfio/pci: Make vfio cdev pre-openable by passing a file handle
> > 
> > I just notice this when I was thinking of a way where it might be possible
> > to avoid QEMU vfio-pci open the device at all, then I found we have
> > something like that already..
> > 
> > Then if the mgmt wants, IIUC that fd can be passed down from Libvirt
> > cleanly to dest qemu in a no-exec context.  Would this work too, and
> > cleaner / reusing existing infrastructures?
> 
> That capability as currently defined would not work for cpr.  The fd is
> pre-created, but qemu still calls the kernel to configure it.  cpr skips
> all kernel configuration calls.

It's just an idea.  I didn't look into the details of it, but I suppose
from this part it might be similar to what cpr-exec would need when using a
new fd-manager or similar approach.  Basically we allow fds to be passed
over too, not from original qemu using exec() but from libvirt.  Would that
work for us?

> 
> > I think it's nice to always have libvirt managing most, or possible, all
> > fds that qemu uses, then we don't even need scm_rights.  But I didn't look
> > deeper into this, just a thought.
> 
> One could imagine a solution where the manager extracts internal properties
> of vfio, ramblock, etc and passes them as creation time parameters on the
> new qemu command line.  And, the manager pre-creates all fd's so they
> can be passed to old and new qemu. Lots of code required in qemu and in the
> manager, and all implicitly created objects would need to me made explicit.
> Yuck. The precreate vmstate approach is much simpler for all.

So please correct me here if I misunderstood, but isn't this a shared
problem with/without precreate vmsd?

IIUC we always need a way to pass over the fds in this case, either by
exec() or scm right or other approaches.  It looks to me that here
precreate is only the transport to deliver those fds, or am I wrong?

> 
> > When thinking about this, I also wonder how cpr-exec handles the limited
> > environments like cgroups and especially seccomps.  I'm not sure what's the
> > status of that in most cloud environments, but I think exec() / fork() is
> > definitely not always on the seccomp whitelist, and I think that's also
> > another reason why we can think about avoid using them.
> 
> Exec must be allowed to use cpr-exec mode.  Fork can remain blocked.   Currently
> the qemu sandbox option can block 'spawn', which blocks both exec and fork. I have
> a patch in my next series that makes this more fine grained, so one or the other
> can be blocked. Those unwilling to allow exec can wait for cpr-scm mode :)

The question is what cpr-scm will be different from cpr-exec, and whether
we'd like them both!  As a maintainer, I definitely want to maintain as
"less" as possible.. :-(

If they play similar role, I suggest we stick with one for sure and discuss
the design.  If cpr-exec will be accepted, I hope it's because we decided
to give up seccomp, rather than waiting for cpr-scm. :)

Thanks,

-- 
Peter Xu


