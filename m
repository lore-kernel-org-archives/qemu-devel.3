Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3C92C27C4F
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Jun 2024 20:27:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLTo7-0001lH-5s; Sun, 23 Jun 2024 16:27:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sLTo6-0001l6-2z
 for qemu-devel@nongnu.org; Sun, 23 Jun 2024 16:27:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sLTo3-0007tq-Od
 for qemu-devel@nongnu.org; Sun, 23 Jun 2024 16:27:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719174442;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1cx+h8HAzd+0wacsOfEA8Wu4EUijKFkp74yhJ/czf/s=;
 b=TzHVvQ4elT3WQGIKL1pEM3tgbj1ehUp4v5VUjx1VwYS3bDr0yJ05NBHGOgmFeIt2nqW9uY
 PsmY2u6Hc5tE94aKGb2VVuS+hkud8q50X3ZuG+GGhXnxFm7XYfnur3Ktwj/OlsnQA0vT6D
 ZJ8ceEVZFQVOWqF6oKNjy5isdA7Va4A=
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com
 [209.85.160.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-466-4taIrSI1M_u2AxwYLXsKJg-1; Sun, 23 Jun 2024 16:27:16 -0400
X-MC-Unique: 4taIrSI1M_u2AxwYLXsKJg-1
Received: by mail-oa1-f72.google.com with SMTP id
 586e51a60fabf-25b503272c2so865768fac.2
 for <qemu-devel@nongnu.org>; Sun, 23 Jun 2024 13:27:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719174436; x=1719779236;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1cx+h8HAzd+0wacsOfEA8Wu4EUijKFkp74yhJ/czf/s=;
 b=Sg/fmy5juA4x04ecdNmAxMJ58Ahp2gGSRcyqRybhiK0L2QzqoOkcsDV7ktUei72uiu
 CSqZLqRPR4/jHaphuvyIHUo4vdCHrHp2/LbBV5GK4DM/EglykkanOOQtl8x7l8O0gzEU
 l6JxPG9uXwoOgVTd0jYn0palY3SZXdTEuW32rr+DOJlN7Ap8zMtacW07j24sIlo1J3lq
 Xq8+NWm1rH4fOye9pN/cEmWijl0U4oTDBXfoCGlyzLoz7qGWTtoMLZ8YHkszdtt8CfxJ
 0DXzrfII/kiyPIKbHl2xqqEeGNNe9LHTPIJob6ztv0/91I38VWPaAWyIYAFqqH47FAbO
 giWw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUgDAUzWBY3hg/HK84x478xHKwT0cCnqc1ZoWLaOwAHlOjns3FHbEiKXBhcxS/CKbGH6tygLbG6C4ICCeqLmgwSYTFelvE=
X-Gm-Message-State: AOJu0YwOCeYFp4n6ZRum1rUHjetcIgFLQG4/JLuhFfPvIbNWXzEnAkH4
 CWK0A6J6mc3/1f9ZqhC7vleWrsqNHZC9B3D0cGpCYvKnAm7KUvlYvU5lp5I0eFCG8Gv+/I+XLii
 jZBpxRlfvWv4M7ueqBstcb81nEbnFeOFP1ZRNsZxxA8uCY4vZZHwG
X-Received: by 2002:a05:6820:826:b0:5ba:ca86:a025 with SMTP id
 006d021491bc7-5c1e5ca2a82mr5914150eaf.0.1719174435446; 
 Sun, 23 Jun 2024 13:27:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEUKU6+0oFw3Gt2e/SlEE7wnE6jTRy9G8PfbkNCQngnjIG89343JvrIe2tCcumG5YtpQXiQ/Q==
X-Received: by 2002:a05:6820:826:b0:5ba:ca86:a025 with SMTP id
 006d021491bc7-5c1e5ca2a82mr5914130eaf.0.1719174434856; 
 Sun, 23 Jun 2024 13:27:14 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6b51ed407dbsm28178926d6.50.2024.06.23.13.27.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Jun 2024 13:27:14 -0700 (PDT)
Date: Sun, 23 Jun 2024 16:27:11 -0400
From: Peter Xu <peterx@redhat.com>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v1 00/13] =?utf-8?Q?Multifd_?= =?utf-8?B?8J+UgA==?=
 device state transfer support with VFIO consumer
Message-ID: <ZniFH14DT6ycjbrL@x1n>
References: <cover.1718717584.git.maciej.szmigiero@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1718717584.git.maciej.szmigiero@oracle.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.149,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Tue, Jun 18, 2024 at 06:12:18PM +0200, Maciej S. Szmigiero wrote:
> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
> 
> This is an updated v1 patch series of the RFC (v0) series located here:
> https://lore.kernel.org/qemu-devel/cover.1713269378.git.maciej.szmigiero@oracle.com/

OK I took some hours thinking about this today, and here's some high level
comments for this series.  I'll start with which are more relevant to what
Fabiano has already suggested in the other thread, then I'll add some more.

https://lore.kernel.org/r/20240620212111.29319-1-farosas@suse.de

1. Multifd device state support
===============================

As Fabiano suggested in his RFC post, we may need one more layer of
abstraction to represent VFIO's demand on allowing multifd to send
arbitrary buffer to the wire.  This can be more than "how to pass the
device state buffer to the sender threads".

So far, MultiFDMethods is only about RAM.  If you pull the latest master
branch Fabiano just merged yet two more RAM compressors that are extended
on top of MultiFDMethods model.  However still they're all about RAM.  I
think it's better to keep it this way, so maybe MultiFDMethods should some
day be called MultiFDRamMethods.

multifd_send_fill_packet() may only be suitable for RAM buffers, not adhoc
buffers like what VFIO is using. multifd_send_zero_page_detect() may not be
needed either for arbitrary buffers.  Most of those are still page-based.

I think it also means we shouldn't call ->send_prepare() when multifd send
thread notices that it's going to send a VFIO buffer.  So it should look
like this:

  int type = multifd_payload_type(p->data);
  if (type == MULTIFD_PAYLOAD_RAM) {
      multifd_send_state->ops->send_prepare(p, &local_err);
  } else {
      // VFIO buffers should belong here
      assert(type == MULTIFD_PAYLOAD_DEVICE_STATE);
      ...
  }

It also means it shouldn't contain code like:

nocomp_send_prepare():
    if (p->is_device_state_job) {
        return nocomp_send_prepare_device_state(p, errp);
    } else {
        return nocomp_send_prepare_ram(p, errp);
    }

nocomp should only exist in RAM world, not VFIO's.

And it looks like you agree with Fabiano's RFC proposal, please work on top
of that to provide that layer.  Please make sure it outputs the minimum in
"$ git grep device_state migration/multifd.c" when you work on the new
version.  Currently:

$ git grep device_state migration/multifd.c | wc -l
59

The hope is zero, or at least a minimum with good reasons.

2. Frequent mallocs/frees
=========================

Fabiano's series can also help to address some of these, but it looks like
this series used malloc/free more than the opaque data buffer.  This is not
required to get things merged, but it'll be nice to avoid those if possible.

3. load_state_buffer() and VFIODeviceStatePacket protocol
=========================================================

VFIODeviceStatePacket is the new protocol you introduced into multifd
packets, along with the new load_state_buffer() hook for loading such
buffers.  My question is whether it's needed at all, or.. whether it can be
more generic (and also easier) to just allow taking any device state in the
multifd packets, then load it with vmstate load().

I mean, the vmstate_load() should really have worked on these buffers, if
after all VFIO is looking for: (1) VFIO_MIG_FLAG_DEV_DATA_STATE as the
first flag (uint64), size as the 2nd, then (2) load that rest buffer into
VFIO kernel driver.  That is the same to happen during the blackout window.
It's not clear to me why load_state_buffer() is needed.

I also see that you're also using exactly the same chunk size for such
buffering (VFIOMigration.data_buffer_size).

I think you have a "reason": VFIODeviceStatePacket and loading of the
buffer data resolved one major issue that wasn't there before but start to
have now: multifd allows concurrent arrivals of vfio buffers, even if the
buffer *must* be sequentially loaded.

That's a major pain for current VFIO kernel ioctl design, IMHO.  I think I
used to ask nVidia people on whether the VFIO get_state/set_state interface
can allow indexing or tagging of buffers but I never get a real response.
IMHO that'll be extremely helpful for migration purpose on concurrency if
it can happen, rather than using a serialized buffer.  It means
concurrently save/load one VFIO device could be extremely hard, if not
impossible.

Now in your series IIUC you resolved that by using vfio_load_bufs_thread(),
holding off the load process but only until sequential buffers are
received.  I think that causes one issue that I'll mention below as a
separate topic.  But besides that, my point is, this is not the reason that
you need to introduce VFIODeviceStatePacket, load_state_buffer() and so on.
My understanding is that we do need one way to re-serialize the buffers,
but it doesn't need load_state_buffer(), instead it can call vmstate_load()
in order, properly invoke vfio_load_state() with the right buffers.  It'll
just be nice if VFIO can keep its "load state" logic at one place.

One benefit of that is with such a more generic framework, QEMU can easily
extend this infra to other device states, so that logically we can consider
sending non-VFIO device states also in the multifd buffers.  However with
your current solution, new structures are needed, new hooks, a lot of new
codes around, however less problems it solved..  That's not optimal.

4. Risk of OOM on unlimited VFIO buffering
==========================================

This follows with above bullet, but my pure question to ask here is how
does VFIO guarantees no OOM condition by buffering VFIO state?

I mean, currently your proposal used vfio_load_bufs_thread() as a separate
thread to only load the vfio states until sequential data is received,
however is there an upper limit of how much buffering it could do?  IOW:

vfio_load_state_buffer():

  if (packet->idx >= migration->load_bufs->len) {
      g_array_set_size(migration->load_bufs, packet->idx + 1);
  }

  lb = &g_array_index(migration->load_bufs, typeof(*lb), packet->idx);
  ...
  lb->data = g_memdup2(&packet->data, data_size - sizeof(*packet));
  lb->len = data_size - sizeof(*packet);
  lb->is_present = true;

What if garray keeps growing with lb->data allocated, which triggers the
memcg limit of the process (if QEMU is in such process)?  Or just deplete
host memory and causing OOM kill.

I think we may need to find a way to throttle max memory usage of such
buffering.

So far this will be more of a problem indeed if this will be done during
VFIO iteration phases, but I still hope a solution can work with both
iteration phase and the switchover phase, even if you only do that in
switchover phase (and I don't know why you don't care about VFIO iteration
phase, if you cared enough on how VFIO works now with migration.. literally
that should help VFIO migrates faster on 25G+ networks, with/without a
shorter blackout window).

5. Worker thread model
======================

I'm so far not happy with what this proposal suggests on creating the
threads, also the two new hooks mostly just to create these threads..

I know I suggested that.. but that's comparing to what I read in the even
earlier version, and sorry I wasn't able to suggest something better at
that time because I simply thought less.

As I mentioned in the other reply elsewhere, I think we should firstly have
these threads ready to take data at the start of migration, so that it'll
work when someone wants to add vfio iteration support.  Then the jobs
(mostly what vfio_save_complete_precopy_async_thread() does now) can be
enqueued into the thread pools.

It's better to create the thread pool owned by migration, rather than
threads owned by VFIO, because it also paves way for non-VFIO device state
save()s, as I mentioned also above on the multifd packet header.  Maybe we
can have a flag in the packet header saying "this is device xxx's state,
just load it".

I'd start looking at util/thread-pool.c, removing all the AIO implications
but simply provide a raw thread pool for what thread_pool_submit() is
doing.

I know this is a lot, but I really think this is the right thing.. but we
can discuss, and you can correct me on my mistakes if there is.

If you want I can have a look at this pool model and prepare a patch, so
you can work on other vfio relevant stuff and pick that up, if that helps
you trying to reach the goal of landing this whole stuff in 9.1.

But I hope I explained more or less in this email on why I think this
feature is more involved than it looks like, and not yet mature from
design. And I hope I'm not purly asking for too much: merging this VFIO
series first then refactor on top can mean dropping too much unneeded code
after adding them, not to mention the protocol going to need another break.

It just doesn't sound like the right thing to do.

Thanks,

-- 
Peter Xu


