Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50C1BC3DA42
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2024 21:56:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRfIG-000768-Ku; Wed, 10 Jul 2024 17:56:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sRfIB-00074x-53
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 17:56:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sRfI8-0000Gw-Rw
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 17:56:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720648557;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UBXqyo73AdKn1QzpqjD7sHMxiSUBiuDp2q6UKLHT8Es=;
 b=UEQlz7FtXC0EyMvUxZQqhywyJ7sr3852uJu+CDx9Lyx4HGpZb57LHqCU7TjNsQhmJZOr74
 zmsBcGTHGVM7YXoFO0IuAxKTktTrAhQYe7BTx3+H1I6wTHBNJNsjIT4vaD789wKPtJHRHw
 2XW2w64VqENqGuoEU9qe+B6fK+qTV7E=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-551-rlOPGgYWOIy-aQFrnKleew-1; Wed, 10 Jul 2024 17:55:56 -0400
X-MC-Unique: rlOPGgYWOIy-aQFrnKleew-1
Received: by mail-oi1-f197.google.com with SMTP id
 5614622812f47-3d92e5d767aso48891b6e.3
 for <qemu-devel@nongnu.org>; Wed, 10 Jul 2024 14:55:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720648556; x=1721253356;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UBXqyo73AdKn1QzpqjD7sHMxiSUBiuDp2q6UKLHT8Es=;
 b=GDbbHpKt81Rx22RRVuaCleS8Gas6kI91qWzVjjlQrz+IBem4gqqnWyT9nwVoz3Xc3A
 5RcLuuxQxjEQW1B3oKc8gm1Rc98bWwStOLDIekorS9wkB4as+IuXKXGX8OXIqLcU93Ps
 fbXfXR+A0iRQftzL1by46QOeZnF0w2eiR0cyJ8E+82T8+PfXNjnR2QkElY/yYkHQ23Cl
 wI/qccaosUVIW0uqspf4ADIJMtJynGIEI1gljEoBnTNlRjv3ZT4pU1J76yaVB8dXpIJM
 BYJZZbyilVqi2Ey0gUu8X1H45LDjIzBb7PnU4HKHoAZk31RgRPRGfCV6ZKPi9oaMbMSn
 CHEg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVXonqyPgWcghPyePWLvj4AajYp9EKwsyyJXL/DEdRm/65UPEqJgXWnlSgVIUpjD8nfi7DUbPVNWYPV53iK2884Uknm6f8=
X-Gm-Message-State: AOJu0YzCBmRUu8GIxJgtWW7ZVyhatc2K1bO0kEXnl8/ubETfjPWx4IRP
 7gHti5NgeNaS1f7dHESU4GQafQIynDYD9Eym6X0imZiiMqC9yTKxQYJSU+Mlc9RBL2pePwX4GfT
 451ITK2GEQ+TQLnXUzBBmERFYlTc16+mOT84olFzD1QTy9g9iMDRH
X-Received: by 2002:a05:6870:3324:b0:258:476d:a781 with SMTP id
 586e51a60fabf-2603a9f77f5mr876130fac.3.1720648555538; 
 Wed, 10 Jul 2024 14:55:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGXmyMIhQCHMlZiCzRfy38YSlBqMzJJX9W1t5oC6HRPs+22WJWG0DNLRX3HzqB/nYtl11sfyA==
X-Received: by 2002:a05:6870:3324:b0:258:476d:a781 with SMTP id
 586e51a60fabf-2603a9f77f5mr876099fac.3.1720648554961; 
 Wed, 10 Jul 2024 14:55:54 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-79f19028226sm230414885a.56.2024.07.10.14.55.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jul 2024 14:55:54 -0700 (PDT)
Date: Wed, 10 Jul 2024 17:55:52 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: "Wang, Lei" <lei4.wang@intel.com>, qemu-devel@nongnu.org,
 "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>
Subject: Re: [RFC PATCH 6/7] migration/multifd: Move payload storage out of
 the channel parameters
Message-ID: <Zo8DaHbWlrNe3RXL@x1n>
References: <20240620212111.29319-1-farosas@suse.de>
 <20240620212111.29319-7-farosas@suse.de>
 <e60bc0c7-dc49-400e-88f1-a30c32943f25@intel.com>
 <Zn15y693g0AkDbYD@x1n> <877cdtfcsi.fsf@suse.de>
 <Zo7cncqkxB89AUBe@x1n> <87y169dmu3.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87y169dmu3.fsf@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Jul 10, 2024 at 05:16:36PM -0300, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > On Wed, Jul 10, 2024 at 01:10:37PM -0300, Fabiano Rosas wrote:
> >> Peter Xu <peterx@redhat.com> writes:
> >> 
> >> > On Thu, Jun 27, 2024 at 11:27:08AM +0800, Wang, Lei wrote:
> >> >> > Or graphically:
> >> >> > 
> >> >> > 1) client fills the active slot with data. Channels point to nothing
> >> >> >    at this point:
> >> >> >   [a]      <-- active slot
> >> >> >   [][][][] <-- free slots, one per-channel
> >> >> > 
> >> >> >   [][][][] <-- channels' p->data pointers
> >> >> > 
> >> >> > 2) multifd_send() swaps the pointers inside the client slot. Channels
> >> >> >    still point to nothing:
> >> >> >   []
> >> >> >   [a][][][]
> >> >> > 
> >> >> >   [][][][]
> >> >> > 
> >> >> > 3) multifd_send() finds an idle channel and updates its pointer:
> >> >> 
> >> >> It seems the action "finds an idle channel" is in step 2 rather than step 3,
> >> >> which means the free slot is selected based on the id of the channel found, am I
> >> >> understanding correctly?
> >> >
> >> > I think you're right.
> >> >
> >> > Actually I also feel like the desription here is ambiguous, even though I
> >> > think I get what Fabiano wanted to say.
> >> >
> >> > The free slot should be the first step of step 2+3, here what Fabiano
> >> > really wanted to suggest is we move the free buffer array from multifd
> >> > channels into the callers, then the caller can pass in whatever data to
> >> > send.
> >> >
> >> > So I think maybe it's cleaner to write it as this in code (note: I didn't
> >> > really change the code, just some ordering and comments):
> >> >
> >> > ===8<===
> >> > @@ -710,15 +710,11 @@ static bool multifd_send(MultiFDSlots *slots)
> >> >       */
> >> >      active_slot = slots->active;
> >> >      slots->active = slots->free[p->id];
> >> > -    p->data = active_slot;
> >> > -
> >> > -    /*
> >> > -     * By the next time we arrive here, the channel will certainly
> >> > -     * have consumed the active slot. Put it back on the free list
> >> > -     * now.
> >> > -     */
> >> >      slots->free[p->id] = active_slot;
> >> >  
> >> > +    /* Assign the current active slot to the chosen thread */
> >> > +    p->data = active_slot;
> >> > ===8<===
> >> >
> >> > The comment I removed is slightly misleading to me too, because right now 
> >> > active_slot contains the data hasn't yet been delivered to multifd, so
> >> > we're "putting it back to free list" not because of it's free, but because
> >> > we know it won't get used until the multifd send thread consumes it
> >> > (because before that the thread will be busy, and we won't use the buffer
> >> > if so in upcoming send()s).
> >> >
> >> > And then when I'm looking at this again, I think maybe it's a slight
> >> > overkill, and maybe we can still keep the "opaque data" managed by multifd.
> >> > One reason might be that I don't expect the "opaque data" payload keep
> >> > growing at all: it should really be either RAM or device state as I
> >> > commented elsewhere in a relevant thread, after all it's a thread model
> >> > only for migration purpose to move vmstates..
> >> 
> >> Some amount of flexibility needs to be baked in. For instance, what
> >> about the handshake procedure? Don't we want to use multifd threads to
> >> put some information on the wire for that as well?
> >
> > Is this an orthogonal question?
> 
> I don't think so. You say the payload data should be either RAM or
> device state. I'm asking what other types of data do we want the multifd
> channel to transmit and suggesting we need to allow room for the
> addition of that, whatever it is. One thing that comes to mind that is
> neither RAM or device state is some form of handshake or capabilities
> negotiation.

Indeed what I thought was multifd payload should be either ram or device,
nothing else.  The worst case is we can add one more into the union, but I
can't think of.

I wonder why handshake needs to be done per-thread.  I was naturally
thinking the handshake should happen sequentially, talking over everything
including multifd.  IMO multifd to have these threads are mostly for the
sake of performance.  I sometimes think we have some tiny places where we
"over-engineered" multifd, e.g. on attaching ZLIB/ZSTD/... flags on each
packet header, even if they should never change, and that is the part of
thing we can put into handshake too, and after handshake we should assume
both sides and all threads are in sync.  There's no need to worry
compressor per-packet, per-channel.  It could be a global thing and done
upfront, even if Libvirt didn't guarantee those.

> 
> >
> > What I meant above is it looks fine to me to keep "device state" in
> > multifd.c, as long as it is not only about VFIO.
> >
> > What you were saying seems to be about how to identify this is a device
> > state, then I just hope VFIO shares the same flag with any future device
> > that would also like to send its state via multifd, like:
> >
> > #define MULTIFD_FLAG_DEVICE_STATE (32 << 1)
> >
> > Then set it in MultiFDPacket_t.flags.  The dest qemu should route that
> > packet to the device vmsd / save_entry for parsing.
> 
> Sure, that part I agree with, no issue here.
> 
> >
> >> 
> >> > Putting it managed by multifd thread should involve less change than this
> >> > series, but it could look like this:
> >> >
> >> > typedef enum {
> >> >     MULTIFD_PAYLOAD_RAM = 0,
> >> >     MULTIFD_PAYLOAD_DEVICE_STATE = 1,
> >> > } MultifdPayloadType;
> >> >
> >> > typedef enum {
> >> >     MultiFDPages_t ram_payload;
> >> >     MultifdDeviceState_t device_payload;
> >> > } MultifdPayload;
> >> >
> >> > struct MultiFDSendData {
> >> >     MultifdPayloadType type;
> >> >     MultifdPayload data;
> >> > };
> >> 
> >> Is that an union up there? So you want to simply allocate in multifd the
> >
> > Yes.
> >
> >> max amount of memory between the two types of payload? But then we'll
> >
> > Yes.
> >
> >> need a memset(p->data, 0, ...) at every round of sending to avoid giving
> >> stale data from one client to another. That doesn't work with the
> >
> > I think as long as the one to enqueue will always setup the fields, we
> > don't need to do memset.  I am not sure if it's a major concern to always
> > set all the relevant fields in the multifd enqueue threads.  It sounds like
> > the thing we should always better do.
> 
> Well, writing to a region of memory that was "owned" by another multifd
> client and already has a bunch of data there is somewhat prone to
> bugs. Just forget to set something and now things start to behave
> weirdly. I guess that's just the price of having an union. I'm not
> against that, but I would maybe prefer to have each client hold its own
> data and not have to think about anything else. Much of this feeling
> comes from how the RAM code currently works (more on that below).

IIUC so far not using union is fine.  However in the future what if we
extend device states to vcpus?  In that case the vcpu will need to have its
own array of SendData[], even though it will share the same structure with
what VFIO would use.

If with an union, and if we can settle it'll be either PAGES or DEV_STATE,
then when vcpu state is involved, vcpu will simply enqueue the same
DEV_STATE.

One thing to mention is that when with an union we may probably need to get
rid of multifd_send_state->pages already.  The object can't be a global
cache (in which case so far it's N+1, N being n_multifd_channels, while "1"
is the extra buffer as only RAM uses it).  In the union world we'll need to
allocate M+N SendData, where N is still the n_multifd_channels, and M is
the number of users, in VFIO's case, VFIO allocates the cached SendData and
use that to enqueue, right after enqueue it'll get a free one by switching
it with another one in the multifd's array[N].  Same to RAM.  Then there'll
be N+2 SendData and VFIO/RAM needs to free their own SendData when cleanup
(multifd owns the N per-thread only).

> 
> >
> >> current ram migration because it wants p->pages to remain active across
> >> several calls of multifd_queue_page().
> >
> > I don't think I followed here.
> >
> > What I meant: QEMU maintains SendData[8], now a bunch of pages arrives, it
> > enqueues "pages" into a free slot index 2 (set type=pages), then before
> > thread 2 finished sending the bunch of pages, SendData[2] will always
> > represent those pages without being used by anything else. What did I miss?
> >
> 
> You're missing multifd_send_state->pages and the fact that it holds
> unsent data on behalf of the client. At every call to
> multifd_queue_pages(), the RAM code expects the previously filled pages
> structure to be there. Since we intend to have more than one multifd
> client, now the other client (say device state) might run, it will take
> that slot and fill it with it's own stuff (or rather fill p->send_data
> and multifd_send_pages() switches the pointer). Next call to
> multifd_queue_pages(), it will take multifd_send_state->pages and
> there'll be garbage there.

Please see above to see whether that may answer here too; in general I
think we need to drop multifd_send_state->pages, but let SendData caches be
managed by the users, so instead of multifd managing N+1 SendData, it only
manages N, leaving the rest to possible users of multifd.  It also means
it's a must any multifd enqueue user will first provide a valid cache
object of SendData.

> 
> The code is not: take a free slot from the next idle channel and fill it
> with data.
> 
> It is: take from multifd_send_state the active slot which *might* have
> previously been consumed by the last channel and (continue to) fill it
> with data.
> 
> "might", because successive calls to multifd_queue_page() don't need to
> call multifd_send_page() to flush to the channel.
> 
> >> 
> >> >
> >> > Then the "enum" makes sure the payload only consumes only the max of both
> >> > types; a side benefit to save some memory.
> >> >
> >> > I think we need to make sure MultifdDeviceState_t is generic enough so that
> >> > it will work for mostly everything (especially normal VMSDs).  In this case
> >> > the VFIO series should be good as that was currently defined as:
> >> >
> >> > typedef struct {
> >> >     MultiFDPacketHdr_t hdr;
> >> >
> >> >     char idstr[256] QEMU_NONSTRING;
> >> >     uint32_t instance_id;
> >> >
> >> >     /* size of the next packet that contains the actual data */
> >> >     uint32_t next_packet_size;
> >> > } __attribute__((packed)) MultiFDPacketDeviceState_t;
> >> 
> >> This is the packet, a different thing. Not sure if your paragraph above
> >> means to talk about that or really MultifdDeviceState, which is what is
> >> exchanged between the multifd threads and the client code.
> >
> > I meant the wire protocol looks great from that POV.  We may need similar
> > thing for the type==device_state slots just to be generic.
> >
> >> 
> >> >
> >> > IIUC that was what we need exactly with idstr+instance_id, so as to nail
> >> > exactly at where should the "opaque device state" go to, then load it with
> >> > a buffer-based loader when it's ready (starting from VFIO, to get rid of
> >> > qemufile).  For VMSDs in the future if ever possible, that should be a
> >> > modified version of vmstate_load() where it may take buffers not qemufiles.
> >> >
> >> > To Maciej: please see whether above makes sense to you, and if you also
> >> > agree please consider that with your VFIO work.
> >> >
> >> > Thanks,
> >> >
> >> >> 
> >> >> >   []
> >> >> >   [a][][][]
> >> >> > 
> >> >> >   [a][][][]
> >> >> >   ^idle
> >> 
> 

-- 
Peter Xu


