Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3EF3C25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2024 18:40:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCkgV-0001mH-GD; Thu, 30 May 2024 14:39:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sCkgU-0001ls-9y
 for qemu-devel@nongnu.org; Thu, 30 May 2024 14:39:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sCkgS-0002Qq-Ae
 for qemu-devel@nongnu.org; Thu, 30 May 2024 14:39:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717094366;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=O3fg3AD9tLOpSpPoqPmSTCO4ln9FVKLVQ9RApRogROY=;
 b=NRVggTZ7hgMVi0CZdjr4phTR8M2YPoGlPPGN91C8oc7PiaCVLtahXNL3X1UAv7O61/nY4r
 9QSsA1Xc/TEby+pzFlUkyzgvF0Ivf7YyGlzw7oKW3rxDczKbXI96sV6ZLdLT+rcdLYRivl
 sKHaNXRVYswdBmoBQcTT1OfMtLNILDI=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-677-5nhOgMbNOt-b27tUOKbPhQ-1; Thu, 30 May 2024 14:39:25 -0400
X-MC-Unique: 5nhOgMbNOt-b27tUOKbPhQ-1
Received: by mail-oo1-f69.google.com with SMTP id
 006d021491bc7-5b9b2a518b9so269641eaf.0
 for <qemu-devel@nongnu.org>; Thu, 30 May 2024 11:39:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717094364; x=1717699164;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O3fg3AD9tLOpSpPoqPmSTCO4ln9FVKLVQ9RApRogROY=;
 b=cCAxQbG41Q00gTZQJ5okcJaWcWYX6bLrMMzLhRkSDjK8nGjMpE1oUvLeg9x4kJeCpu
 NKq50ykY8Krm5sEJymopazwobHPgbCusSzkXiMwsB8jmEnEkVehND0nSs4NYsdxi5r2+
 T0EpSnFPF/7Cu8JCtlQTU3gMEmnBrLmKgj92QOI2TKGwU3IqsGAROzo5qxzdlaGrUYBo
 lu5rsrvMGWBQ71Y3Iz90TJgbdsyogdBSQe0wEHhndxjRkaTJPfOCUJ7/1Jl56JEOX+XH
 Jcg8YeDIpOjr1G1B/S9dCsY7Wx8RBWd6VHJ5gohvXsJ3XffHAelC81XQ/PrXAK53fTtV
 ejgQ==
X-Gm-Message-State: AOJu0YxJxqwcTiy52wP968Wu2dV9MWoZihfLLHbN5g7hKNgkWPkF2635
 zLi0vTYB5iK9iZLPe0+a1/7FhOy+8siA4Pnsfz/nKZk9oN7BKVG5a6zMbqGMoFdWfCAy2+RLRBk
 P9z04G7IiLLoSjnc4eD4rmPzm3o+lZBfc8L8ABgABZPAo6oNujAMl
X-Received: by 2002:a05:6870:d394:b0:24f:d9fe:8ba5 with SMTP id
 586e51a60fabf-25060b2c4f5mr3021826fac.2.1717094363606; 
 Thu, 30 May 2024 11:39:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFRFryxSAum+QZ7pEgn/HgoH1yktcFo6cnYvudTHYdCyuTt90NvgkGKpzGz08TUGeqVomQAHw==
X-Received: by 2002:a05:6870:d394:b0:24f:d9fe:8ba5 with SMTP id
 586e51a60fabf-25060b2c4f5mr3021772fac.2.1717094362664; 
 Thu, 30 May 2024 11:39:22 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-43ff23c8084sm748411cf.34.2024.05.30.11.39.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 May 2024 11:39:22 -0700 (PDT)
Date: Thu, 30 May 2024 14:39:19 -0400
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
Message-ID: <ZljH1zbqisK6VowI@x1n>
References: <1714406135-451286-1-git-send-email-steven.sistare@oracle.com>
 <1714406135-451286-20-git-send-email-steven.sistare@oracle.com>
 <ZlZQVijf2weEmzYK@x1n>
 <c3f23e83-81d7-469a-aa04-29785fa6f8d7@oracle.com>
 <ZleBOx6pN6KCn0a2@x1n>
 <e0cb49da-9799-4a26-8844-f5055b6ae45b@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e0cb49da-9799-4a26-8844-f5055b6ae45b@oracle.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.085,
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

On Thu, May 30, 2024 at 01:12:40PM -0400, Steven Sistare wrote:
> On 5/29/2024 3:25 PM, Peter Xu wrote:
> > On Wed, May 29, 2024 at 01:31:53PM -0400, Steven Sistare wrote:
> > > On 5/28/2024 5:44 PM, Peter Xu wrote:
> > > > On Mon, Apr 29, 2024 at 08:55:28AM -0700, Steve Sistare wrote:
> > > > > Preserve fields of RAMBlocks that allocate their host memory during CPR so
> > > > > the RAM allocation can be recovered.
> > > > 
> > > > This sentence itself did not explain much, IMHO.  QEMU can share memory
> > > > using fd based memory already of all kinds, as long as the memory backend
> > > > is path-based it can be shared by sharing the same paths to dst.
> > > > 
> > > > This reads very confusing as a generic concept.  I mean, QEMU migration
> > > > relies on so many things to work right.  We mostly asks the users to "use
> > > > exactly the same cmdline for src/dst QEMU unless you know what you're
> > > > doing", otherwise many things can break.  That should also include ramblock
> > > > being matched between src/dst due to the same cmdlines provided on both
> > > > sides.  It'll be confusing to mention this when we thought the ramblocks
> > > > also rely on that fact.
> > > > 
> > > > So IIUC this sentence should be dropped in the real patch, and I'll try to
> > > > guess the real reason with below..
> > > 
> > > The properties of the implicitly created ramblocks must be preserved.
> > > The defaults can and do change between qemu releases, even when the command-line
> > > parameters do not change for the explicit objects that cause these implicit
> > > ramblocks to be created.
> > 
> > AFAIU, QEMU relies on ramblocks to be the same before this series.  Do you
> > have an example?  Would that already cause issue when migrate?
> 
> Alignment has changed, and used_length vs max_length changed when
> resizeable ramblocks were introduced.  I have dealt with these issues
> while supporting cpr for our internal use, and the learned lesson is to
> explicitly communicate the creation-time parameters to new qemu.

Why used_length can change?  I'm looking at ram_mig_ram_block_resized():

    if (!migration_is_idle()) {
        /*
         * Precopy code on the source cannot deal with the size of RAM blocks
         * changing at random points in time - especially after sending the
         * RAM block sizes in the migration stream, they must no longer change.
         * Abort and indicate a proper reason.
         */
        error_setg(&err, "RAM block '%s' resized during precopy.", rb->idstr);
        migration_cancel(err);
        error_free(err);
    }

We sent used_length upfront of a migration during SETUP phase.  Looks like
what you're describing can be something different, though?

Regarding to rb->align: isn't that mostly a constant, reflecting the MR's
alignment?  It's set when ramblock is created IIUC:

    rb->align = mr->align;

When will the alignment change?

> 
> These are not an issue for migration because the ramblock is re-created
> and the data copied into the new memory.
> 
> > > > > Mirror the mr->align field in the RAMBlock to simplify the vmstate.
> > > > > Preserve the old host address, even though it is immediately discarded,
> > > > > as it will be needed in the future for CPR with iommufd.  Preserve
> > > > > guest_memfd, even though CPR does not yet support it, to maintain vmstate
> > > > > compatibility when it becomes supported.
> > > > 
> > > > .. It could be about the vfio vaddr update feature that you mentioned and
> > > > only for iommufd (as IIUC vfio still relies on iova ranges, then it won't
> > > > help here)?
> > > > 
> > > > If so, IMHO we should have this patch (or any variance form) to be there
> > > > for your upcoming vfio support.  Keeping this around like this will make
> > > > the series harder to review.  Or is it needed even before VFIO?
> > > 
> > > This patch is needed independently of vfio or iommufd.
> > > 
> > > guest_memfd is independent of vfio or iommufd.  It is a recent addition
> > > which I have not tried to support, but I added this placeholder field
> > > to it can be supported in the future without adding a new field later
> > > and maintaining backwards compatibility.
> > 
> > Is guest_memfd the only user so far, then?  If so, would it be possible we
> > split it as a separate effort on top of the base cpr-exec support?
> 
> I don't understand the question.  I am indeed deferring support for guest_memfd
> to a future time.  For now, I am adding a blocker, and reserving a field for
> it in the preserved ramblock attributes, to avoid adding a subsection later.

I meant I'm thinking whether the new ramblock vmsd may not be required for
the initial implementation.

E.g., IIUC vaddr is required by iommufd, and so far that's not part of the
initial support.

Then I think a major thing is about the fds to be managed that will need to
be shared.  If we put guest_memfd aside, it can be really, mostly, about
VFIO fds.  For that, I'm wondering whether you looked into something like
this:

commit da3e04b26fd8d15b344944504d5ffa9c5f20b54b
Author: Zhenzhong Duan <zhenzhong.duan@intel.com>
Date:   Tue Nov 21 16:44:10 2023 +0800

    vfio/pci: Make vfio cdev pre-openable by passing a file handle

I just notice this when I was thinking of a way where it might be possible
to avoid QEMU vfio-pci open the device at all, then I found we have
something like that already..

Then if the mgmt wants, IIUC that fd can be passed down from Libvirt
cleanly to dest qemu in a no-exec context.  Would this work too, and
cleaner / reusing existing infrastructures?

I think it's nice to always have libvirt managing most, or possible, all
fds that qemu uses, then we don't even need scm_rights.  But I didn't look
deeper into this, just a thought.

When thinking about this, I also wonder how cpr-exec handles the limited
environments like cgroups and especially seccomps.  I'm not sure what's the
status of that in most cloud environments, but I think exec() / fork() is
definitely not always on the seccomp whitelist, and I think that's also
another reason why we can think about avoid using them.

-- 
Peter Xu


