Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 330EDC3DA41
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2024 19:11:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRci4-0006Zo-Dj; Wed, 10 Jul 2024 15:10:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sRci0-0006YP-Ey
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 15:10:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sRchw-0007Qx-Vh
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 15:10:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720638626;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=b1dzatwcRhBoluw+oSbGKKZbgzg6h0QV0IFr61TRz8Y=;
 b=ikiyeg5hh8M9ONXZRfI2iaDXqxgukC2CH7ATORE63NI7lZDT4vsQr1BsGl0+vfSbS0lKy0
 fbVCpuSWPeqWJ2gR85nVjOdIatVxKgNlhfS/JMl1TXU9hgscbAuowlJaXJ0FLYEq2M4VjT
 umM/oLUBlkI/R+Jx91VQG5Dmjha1zTM=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-147-R_1LRLSIOYWhCwdgH_kKvA-1; Wed, 10 Jul 2024 15:10:25 -0400
X-MC-Unique: R_1LRLSIOYWhCwdgH_kKvA-1
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-447dfad3387so199431cf.2
 for <qemu-devel@nongnu.org>; Wed, 10 Jul 2024 12:10:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720638625; x=1721243425;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b1dzatwcRhBoluw+oSbGKKZbgzg6h0QV0IFr61TRz8Y=;
 b=E+YMhJKV0BrH+jEjpuCs9hJ0LnAfxM6AFJzy4rnhI5Hi//vxd47twRogE8y36aVOnZ
 Qw3Wk24sxQ7zWGwOTR/f4TWedqSeeCAufQzZIqJin0pfmHOfWKliqtnAdzgB9us0kbzK
 GtbHA5HZ6Wvy7oVIHvwNuSBdmOu15eznV+WCGZzdy0C1nCQK5gT78BJZ18hG6whmlnoA
 lJfojyGkLafPvcgPSVavt1CJb+tK0zW69BHBxnK2iB4jW2oPUX9eLRpR35vYXvcsXqvj
 iNsUxCRABi5p4f5BLcIqRBXFk2lBLK1NfJ283DEnR1wAKBOoruK9fb+unwDRaUaBNzh3
 Lclw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXZFEJZZ+bMvky4YYg5nlBoyLGa553ngegPwlsHQ//qKf+v7T+j/I4YEzLLJ1qJwirgnoRL5JFrjnGHs3MJv+0k6N/5OqM=
X-Gm-Message-State: AOJu0Yx0YT5wIXD6CaP4hHYsMaK7D6RIlUsiRrDf+ZX0JTgaAAZ6oFrw
 5FzK9MEX3XcBzJSEO6pJVkdfwvmKCi29ULHbd97+vlsmTQQuO9FxbD/kKb/CO8iQJfliCjwzX0t
 LqFu66eq6yp2RAkS0VxNf6EslSPI8P/foYJEq22Irs4bDdSG6FWvA
X-Received: by 2002:a05:620a:4586:b0:79c:d2fc:8b27 with SMTP id
 af79cd13be357-79f19c02b26mr700879885a.7.1720638624443; 
 Wed, 10 Jul 2024 12:10:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHoBKbXYZ0TychSNNpClvjv3qm+3jNNLQusyewBG3rCGR3Uqhm1m/MM0EEELkTNd2lHPg13kA==
X-Received: by 2002:a05:620a:4586:b0:79c:d2fc:8b27 with SMTP id
 af79cd13be357-79f19c02b26mr700877685a.7.1720638624069; 
 Wed, 10 Jul 2024 12:10:24 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-79f18ff69ebsm220306285a.22.2024.07.10.12.10.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jul 2024 12:10:23 -0700 (PDT)
Date: Wed, 10 Jul 2024 15:10:21 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: "Wang, Lei" <lei4.wang@intel.com>, qemu-devel@nongnu.org,
 "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>
Subject: Re: [RFC PATCH 6/7] migration/multifd: Move payload storage out of
 the channel parameters
Message-ID: <Zo7cncqkxB89AUBe@x1n>
References: <20240620212111.29319-1-farosas@suse.de>
 <20240620212111.29319-7-farosas@suse.de>
 <e60bc0c7-dc49-400e-88f1-a30c32943f25@intel.com>
 <Zn15y693g0AkDbYD@x1n> <877cdtfcsi.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <877cdtfcsi.fsf@suse.de>
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

On Wed, Jul 10, 2024 at 01:10:37PM -0300, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > On Thu, Jun 27, 2024 at 11:27:08AM +0800, Wang, Lei wrote:
> >> > Or graphically:
> >> > 
> >> > 1) client fills the active slot with data. Channels point to nothing
> >> >    at this point:
> >> >   [a]      <-- active slot
> >> >   [][][][] <-- free slots, one per-channel
> >> > 
> >> >   [][][][] <-- channels' p->data pointers
> >> > 
> >> > 2) multifd_send() swaps the pointers inside the client slot. Channels
> >> >    still point to nothing:
> >> >   []
> >> >   [a][][][]
> >> > 
> >> >   [][][][]
> >> > 
> >> > 3) multifd_send() finds an idle channel and updates its pointer:
> >> 
> >> It seems the action "finds an idle channel" is in step 2 rather than step 3,
> >> which means the free slot is selected based on the id of the channel found, am I
> >> understanding correctly?
> >
> > I think you're right.
> >
> > Actually I also feel like the desription here is ambiguous, even though I
> > think I get what Fabiano wanted to say.
> >
> > The free slot should be the first step of step 2+3, here what Fabiano
> > really wanted to suggest is we move the free buffer array from multifd
> > channels into the callers, then the caller can pass in whatever data to
> > send.
> >
> > So I think maybe it's cleaner to write it as this in code (note: I didn't
> > really change the code, just some ordering and comments):
> >
> > ===8<===
> > @@ -710,15 +710,11 @@ static bool multifd_send(MultiFDSlots *slots)
> >       */
> >      active_slot = slots->active;
> >      slots->active = slots->free[p->id];
> > -    p->data = active_slot;
> > -
> > -    /*
> > -     * By the next time we arrive here, the channel will certainly
> > -     * have consumed the active slot. Put it back on the free list
> > -     * now.
> > -     */
> >      slots->free[p->id] = active_slot;
> >  
> > +    /* Assign the current active slot to the chosen thread */
> > +    p->data = active_slot;
> > ===8<===
> >
> > The comment I removed is slightly misleading to me too, because right now 
> > active_slot contains the data hasn't yet been delivered to multifd, so
> > we're "putting it back to free list" not because of it's free, but because
> > we know it won't get used until the multifd send thread consumes it
> > (because before that the thread will be busy, and we won't use the buffer
> > if so in upcoming send()s).
> >
> > And then when I'm looking at this again, I think maybe it's a slight
> > overkill, and maybe we can still keep the "opaque data" managed by multifd.
> > One reason might be that I don't expect the "opaque data" payload keep
> > growing at all: it should really be either RAM or device state as I
> > commented elsewhere in a relevant thread, after all it's a thread model
> > only for migration purpose to move vmstates..
> 
> Some amount of flexibility needs to be baked in. For instance, what
> about the handshake procedure? Don't we want to use multifd threads to
> put some information on the wire for that as well?

Is this an orthogonal question?

What I meant above is it looks fine to me to keep "device state" in
multifd.c, as long as it is not only about VFIO.

What you were saying seems to be about how to identify this is a device
state, then I just hope VFIO shares the same flag with any future device
that would also like to send its state via multifd, like:

#define MULTIFD_FLAG_DEVICE_STATE (32 << 1)

Then set it in MultiFDPacket_t.flags.  The dest qemu should route that
packet to the device vmsd / save_entry for parsing.

> 
> > Putting it managed by multifd thread should involve less change than this
> > series, but it could look like this:
> >
> > typedef enum {
> >     MULTIFD_PAYLOAD_RAM = 0,
> >     MULTIFD_PAYLOAD_DEVICE_STATE = 1,
> > } MultifdPayloadType;
> >
> > typedef enum {
> >     MultiFDPages_t ram_payload;
> >     MultifdDeviceState_t device_payload;
> > } MultifdPayload;
> >
> > struct MultiFDSendData {
> >     MultifdPayloadType type;
> >     MultifdPayload data;
> > };
> 
> Is that an union up there? So you want to simply allocate in multifd the

Yes.

> max amount of memory between the two types of payload? But then we'll

Yes.

> need a memset(p->data, 0, ...) at every round of sending to avoid giving
> stale data from one client to another. That doesn't work with the

I think as long as the one to enqueue will always setup the fields, we
don't need to do memset.  I am not sure if it's a major concern to always
set all the relevant fields in the multifd enqueue threads.  It sounds like
the thing we should always better do.

> current ram migration because it wants p->pages to remain active across
> several calls of multifd_queue_page().

I don't think I followed here.

What I meant: QEMU maintains SendData[8], now a bunch of pages arrives, it
enqueues "pages" into a free slot index 2 (set type=pages), then before
thread 2 finished sending the bunch of pages, SendData[2] will always
represent those pages without being used by anything else. What did I miss?

> 
> >
> > Then the "enum" makes sure the payload only consumes only the max of both
> > types; a side benefit to save some memory.
> >
> > I think we need to make sure MultifdDeviceState_t is generic enough so that
> > it will work for mostly everything (especially normal VMSDs).  In this case
> > the VFIO series should be good as that was currently defined as:
> >
> > typedef struct {
> >     MultiFDPacketHdr_t hdr;
> >
> >     char idstr[256] QEMU_NONSTRING;
> >     uint32_t instance_id;
> >
> >     /* size of the next packet that contains the actual data */
> >     uint32_t next_packet_size;
> > } __attribute__((packed)) MultiFDPacketDeviceState_t;
> 
> This is the packet, a different thing. Not sure if your paragraph above
> means to talk about that or really MultifdDeviceState, which is what is
> exchanged between the multifd threads and the client code.

I meant the wire protocol looks great from that POV.  We may need similar
thing for the type==device_state slots just to be generic.

> 
> >
> > IIUC that was what we need exactly with idstr+instance_id, so as to nail
> > exactly at where should the "opaque device state" go to, then load it with
> > a buffer-based loader when it's ready (starting from VFIO, to get rid of
> > qemufile).  For VMSDs in the future if ever possible, that should be a
> > modified version of vmstate_load() where it may take buffers not qemufiles.
> >
> > To Maciej: please see whether above makes sense to you, and if you also
> > agree please consider that with your VFIO work.
> >
> > Thanks,
> >
> >> 
> >> >   []
> >> >   [a][][][]
> >> > 
> >> >   [a][][][]
> >> >   ^idle
> 

-- 
Peter Xu


