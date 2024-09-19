Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69CE5CF3962
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2024 16:30:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1srK2Y-0003Wo-4w; Thu, 19 Sep 2024 12:29:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1srK2U-0003Vl-IJ
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 12:29:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1srK2R-0008RY-TP
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 12:29:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726763389;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=geVXq9sudmm8z2UhOnWjyW7zxA3OSFv3GjlrV/2IZWI=;
 b=DE2VQ4fIcBbbHvdBy4Zybn2BYHKlGIcYAlPXIrp8rCsA4gnDdPK6SDk/gtXvO/pkfuyypU
 dYvfSdQ+O0mnME7Y4PErJv/pJzpZ7575o2JdSQBGIDBHCNOCmZlqDDhCd7Evb0CLRJoXxo
 WTHMkMVlKoa25WzL58xq6MKaPwbkOI8=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-534-yp-plt2SPBaYQhaj7ERxEg-1; Thu, 19 Sep 2024 12:29:47 -0400
X-MC-Unique: yp-plt2SPBaYQhaj7ERxEg-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-6c5135456cbso23354536d6.0
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2024 09:29:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726763387; x=1727368187;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=geVXq9sudmm8z2UhOnWjyW7zxA3OSFv3GjlrV/2IZWI=;
 b=t2HPwa8MypsifeqGqsJ+BJGnXtkaq5xv1yx03ZsmeySxV0EUZaZ337VzfXVihNJSGu
 AIoqi8OU1Xio71eYoEbN4KID1nubyAnpF/MMAV/gXgrCH2zN49Y0VYuJ4CaKqslE9tA5
 BWQxWmlZpP4IvlhP4URDqRi7lgggceMpQ7ZsFhIR9PuyVDmKaIT231CZN3ixiX2rbKez
 QLnGLz9S4yAbqyNeAgLjs0w0PbYP7hlH6GwBX6eFRpwx3ZmzPycjshGsRJVJ9MF2wkG3
 0vFVSSjgQgbvLaK9foGXZ2pVzGF3sG6bnHDxrvLIUtfFhViUCZPGPeBXRXbiOPLUpjeA
 Y4tg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV/alViJVwAf5pqVXodY41xR2huML9e9wzDCMuOqSBKhh0jz4u4aTg+y5Ke0ayo84ewMxlBOMNEjMr6@nongnu.org
X-Gm-Message-State: AOJu0YwOnJnpMZZCvh1zzvDvtY2QB84SETMfgzIjxj87KpLg05Qet8Bx
 +wh2zqpYCtHrYR7FeKu916ENThetgDcXH/o8CIotG/NtB4diDnCl60AItzmez5sBjHY1BDx2QXf
 FlgYD6kstZKl7MKqgZXunt9/jFlOTBFA+KNZeJmSU7Pse0fVVEP6h
X-Received: by 2002:a05:6214:2b87:b0:6c5:1fe5:f84c with SMTP id
 6a1803df08f44-6c57df33cc1mr319223326d6.20.1726763387243; 
 Thu, 19 Sep 2024 09:29:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHslC3n537kqKG9H43uTGY1ETtOojftGdoX2WzE/TItJYFWhLfdI11/yNOIuxQWlE1xfRtH2A==
X-Received: by 2002:a05:6214:2b87:b0:6c5:1fe5:f84c with SMTP id
 6a1803df08f44-6c57df33cc1mr319223056d6.20.1726763386869; 
 Thu, 19 Sep 2024 09:29:46 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6c75e4949basm8994116d6.67.2024.09.19.09.29.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Sep 2024 09:29:45 -0700 (PDT)
Date: Thu, 19 Sep 2024 12:29:43 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>
Subject: Re: [PULL v2 0/6] Migration 20240917 patches
Message-ID: <ZuxRd1vu3PXT_VpK@x1n>
References: <20240918183151.6413-1-peterx@redhat.com>
 <CAFEAcA9MsybcOa9pGeU7EHuqvRqfBk4TSwYR_tkHF2Xbc19Yuw@mail.gmail.com>
 <ZuwSGJODsyj_bA4P@x1n>
 <CAFEAcA_9HKtTciFtrs9T9PG06GgYdoDoCASeBi7wO9CswA=1tw@mail.gmail.com>
 <87r09feo2f.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87r09feo2f.fsf@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Thu, Sep 19, 2024 at 11:05:28AM -0300, Fabiano Rosas wrote:
> Peter Maydell <peter.maydell@linaro.org> writes:
> 
> > On Thu, 19 Sept 2024 at 12:59, Peter Xu <peterx@redhat.com> wrote:
> >>
> >> On Thu, Sep 19, 2024 at 10:08:25AM +0100, Peter Maydell wrote:
> >> > Thanks for looking at the issues with the migration tests.
> >> > This run went through first time without my needing to retry any
> >> > jobs, so fingers crossed that we have at least improved the reliability.
> >> > (I have a feeling there's still something funny with the k8s runners,
> >> > but that's not migration-test specific, it's just that test tends
> >> > to be the longest running and so most likely to be affected.)
> >>
> >> Kudos all go to Fabiano for debugging the hard problem.
> >>
> >> And yes, please let either of us know if it fails again, we can either keep
> >> looking, or still can disable it when necessary (if it takes long to debug).
> >
> > On the subject of potential races in the migration code,
> > there's a couple of outstanding Coverity issues that might
> > be worth looking at. If they're false-positives let me know
> > and I can reclassify them in Coverity.
> >
> > CID 1527402: In migrate_fd_cleanup() Coverity thinks there's
> > a race because we read s->to_dst_file in the "if (s->to_dst_file)"
> > check without holding the qemu_file_lock. This might be a
> > false-positive because the race Coverity identifies happens
> > if two threads both call migrate_fd_cleanup() at the same
> > time, which is probably not permitted. (But OTOH taking a
> > mutex gets you for free any necessary memory barriers...)
> 
> Yes, we shouldn't rely on mental gymnastics to prove that there's no
> concurrent access.
> 
> @peterx, that RH bug you showed me could very well be caused by this
> race, except that I don't see how fd_cleanup could race with
> itself. Just having the lock would probably save us time even thinking
> about it.

I can send a patch for this one.

> 
> >
> > CID 1527413: In postcopy_pause_incoming() we read
> > mis->postcopy_qemufile_dst without holding the
> > postcopy_prio_thread_mutex which we use to protect the write
> > to that field, so Coverity thinks there's a race if two
> > threads call this function at once.
> 
> At first sight, it seems like a real problem. We did a good pass on
> these races on the source side, but the destination side hasn't been
> investigated yet.

I think it's probably safe and no real race could happen.  The rational
being that during postcopy (aka, when ram load thread is running), this
postcopy_qemufile_dst can only be modified by one thread, which is the ram
listen thread itself.  The other consumer of it is the fast load thread,
but that thread should only read postcopy_qemufile_dst, not update.

IOW, here the "if (postcopy_qemufile_dst)" is not about saying "whether
anyone else can released it", instead it's about "whether preempt mode is
enabled, and whether we have the fast channel at all".

When it's set, it means preempt is enabled, and it will never become NULL
in that case.

Here I _think_ we can replace it with a migrate_postcopy_preempt() safely,
because AFAICT that must be created when with it enabled.  However the
tricky part is the next line, which does the shutdown():

        qemu_file_shutdown(mis->postcopy_qemufile_dst);

That's unfortunately not replaceable, and that's so far the only way (and
pretty traditional way... as you pointed out below..) that we can kick one
qemufile read() out.  In this specific case, the fast thread normally holds
the mutex meanwhile read() on this qemufile via one qemu_get_be64() of
ram_load_postcopy(), then we kick it out with the shutdown().

IOW both facts need to be true here for the fast load thread on: (1) mutex
held, and (2) block at qemu_get_be64().  So there's no way we can take the
mutex before the shutdown() or we deadlock.. it'll be easier if we have
other way to kick the qemu_get_be64(), e.g. if it could be a generic poll()
then we can have it poll on both the qemufile and another eventfd.  But
we're stick with the qemufile API here..

So in short: I don't have a good and simple solution for this one.. but I
am 99.9999% sure it's safe.

> 
> Unfortunately, these QEMUFile races are not trivial to fix due to
> several design pain points, such as:
> 
> - the QEMUFile pointer validity being sometimes used to imply no error
>   has happened before;
> 
> - the various shutdown() calls that serve both as a way to kick a read()
>   that's stuck, but also to cause some other part of the code to realise
>   there has been an error (due to the point above);
> 
> - the yank feature which has weird semantics regarding whether it
>   operates on an iochannel or qemufile;
> 
> - migrate_fd_cancel() that _can_ run concurrently with anything else;
> 
> - the need to ensure the other end of migration also reacts to
>   error/cancel on this side;

Right.  Ultimately it's about relying on shutdown() for kicking qemufile
ops out as of now..  that _may_ not always hold locks.  The other example
is qmp_yank() on a migration channel, which invokes the same iochannel
shutdown() via migration_yank_iochannel().

> 
> >
> > (The only other migration Coverity issue is CID 1560071,
> > which is the "better to use pstrcpy()" not-really-a-bug
> > we discussed in another thread.)
> >
> > thanks
> > -- PMM
> 

-- 
Peter Xu


