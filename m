Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BB1FC2BBCA
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2024 17:46:12 +0000 (UTC)
Received: from [::1] (helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMA3N-0003PW-GU; Tue, 25 Jun 2024 13:34:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sM9yB-0001vx-W7
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 13:28:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sM9wm-0004zC-W4
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 13:28:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719336351;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eJNliWHCc+GGfLSFIb0el2nM+jWwi9dxVAIUG7j6IPw=;
 b=ViXrozSTnYQRRjfs8dIYBwQgCQQm0MnxVhJvBJWv27P7CMSAC3gW3WyVAyldrethrBhI3g
 L1MQFHFR2ugYJVfjOu6LpQOf6xfq4aPtU9tPsUCgTC1Tefr/gxFy7Ccs5HDDjOKFp9XAeQ
 svXR4ZbloXlZzVCQ5CZBYswb0pZEvqk=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-47-2Ep8qwYFPPSC8Z9WjblvmQ-1; Tue, 25 Jun 2024 13:25:49 -0400
X-MC-Unique: 2Ep8qwYFPPSC8Z9WjblvmQ-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-6b50433ada9so17892506d6.3
 for <qemu-devel@nongnu.org>; Tue, 25 Jun 2024 10:25:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719336349; x=1719941149;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eJNliWHCc+GGfLSFIb0el2nM+jWwi9dxVAIUG7j6IPw=;
 b=ody/JVLrpxPVkn1NDTNwcw11EvMf9vBj3hC478GjJ7Vk3ofYaQwlbU1TGyckGHfEiR
 U/c5BQGaHuX8N4lh/1bkgHk/i9zjVqrNiI/U2cQMhdO0WUoYgctzBRWemcBDmRcvEEbC
 g7w5H1P2knDNwsOAoKFPTnulg/qq6S9tSPUTRqZc4Xkx/7zodzWkEUXWcu5rXeR+M2Yf
 3d3N4Ms2WLPOGD3NJwwbvMBGNh0zCuoEuktNwV3oIQtCbLjlYAsA+nTHAp8L3zQ2WxJU
 jjk5JKNQVz7M2UC8nEcL6Rjo/btYRByR5cHqH23KiFdjEmRa30KHu6ujRNpG+dCjQauC
 G9aA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV60DFMPtfRd52mNrvurEkNi7N04qXRmV8BhKZ00BfYg7t8f2jSzIVzf2C5zpaZxDkRX/jb1Qm/P1DDydVW7/iwfw+SeqU=
X-Gm-Message-State: AOJu0YwUIs10sEBnUB6Z66fLyX4NEAvY5oD/n/hJM0BADijEC3lA1q0W
 voT06G6JUfR7oc7Hf2dm7Po+twanAHzQenw6zrko6JQVZ1vwleNpCt1v/ZMRVF1oAOVdmWg+64l
 n8OQikUy3m73KZ7U68sxlMqRIN+sdOSe6zEH/qVLG7sYyms3slGiG
X-Received: by 2002:a05:6214:234c:b0:6b5:6a3:7eb with SMTP id
 6a1803df08f44-6b5300dc9a8mr107139346d6.5.1719336348847; 
 Tue, 25 Jun 2024 10:25:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEAwOUOAUDO+y2Tk9vKIigkwubra5UnYDQna5/D+4e18zO4jx1UJv6R7h7vLn7EVkGiEmMSMA==
X-Received: by 2002:a05:6214:234c:b0:6b5:6a3:7eb with SMTP id
 6a1803df08f44-6b5300dc9a8mr107138826d6.5.1719336347913; 
 Tue, 25 Jun 2024 10:25:47 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6b51ef4ace1sm45463796d6.106.2024.06.25.10.25.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Jun 2024 10:25:47 -0700 (PDT)
Date: Tue, 25 Jun 2024 13:25:44 -0400
From: Peter Xu <peterx@redhat.com>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v1 00/13] =?utf-8?Q?Multifd_?= =?utf-8?B?8J+UgA==?=
 device state transfer support with VFIO consumer
Message-ID: <Znr9mOo_t0DkkLbD@x1n>
References: <cover.1718717584.git.maciej.szmigiero@oracle.com>
 <ZniFH14DT6ycjbrL@x1n>
 <b0dc8bc4-742b-474b-a4c4-4e190fd6af37@maciej.szmigiero.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b0dc8bc4-742b-474b-a4c4-4e190fd6af37@maciej.szmigiero.name>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Mon, Jun 24, 2024 at 09:51:18PM +0200, Maciej S. Szmigiero wrote:
> Hi Peter,

Hi, Maciej,

> 
> On 23.06.2024 22:27, Peter Xu wrote:
> > On Tue, Jun 18, 2024 at 06:12:18PM +0200, Maciej S. Szmigiero wrote:
> > > From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
> > > 
> > > This is an updated v1 patch series of the RFC (v0) series located here:
> > > https://lore.kernel.org/qemu-devel/cover.1713269378.git.maciej.szmigiero@oracle.com/
> > 
> > OK I took some hours thinking about this today, and here's some high level
> > comments for this series.  I'll start with which are more relevant to what
> > Fabiano has already suggested in the other thread, then I'll add some more.
> > 
> > https://lore.kernel.org/r/20240620212111.29319-1-farosas@suse.de
> 
> That's a long list, thanks for these comments.
> 
> I have responded to them inline below.
> 
> > 1. Multifd device state support
> > ===============================
> > 
> > As Fabiano suggested in his RFC post, we may need one more layer of
> > abstraction to represent VFIO's demand on allowing multifd to send
> > arbitrary buffer to the wire.  This can be more than "how to pass the
> > device state buffer to the sender threads".
> > 
> > So far, MultiFDMethods is only about RAM.  If you pull the latest master
> > branch Fabiano just merged yet two more RAM compressors that are extended
> > on top of MultiFDMethods model.  However still they're all about RAM.  I
> > think it's better to keep it this way, so maybe MultiFDMethods should some
> > day be called MultiFDRamMethods.
> > 
> > multifd_send_fill_packet() may only be suitable for RAM buffers, not adhoc
> > buffers like what VFIO is using. multifd_send_zero_page_detect() may not be
> > needed either for arbitrary buffers.  Most of those are still page-based.
> > 
> > I think it also means we shouldn't call ->send_prepare() when multifd send
> > thread notices that it's going to send a VFIO buffer.  So it should look
> > like this:
> > 
> >    int type = multifd_payload_type(p->data);
> >    if (type == MULTIFD_PAYLOAD_RAM) {
> >        multifd_send_state->ops->send_prepare(p, &local_err);
> >    } else {
> >        // VFIO buffers should belong here
> >        assert(type == MULTIFD_PAYLOAD_DEVICE_STATE);
> >        ...
> >    }
> > 
> > It also means it shouldn't contain code like:
> > 
> > nocomp_send_prepare():
> >      if (p->is_device_state_job) {
> >          return nocomp_send_prepare_device_state(p, errp);
> >      } else {
> >          return nocomp_send_prepare_ram(p, errp);
> >      }
> > 
> > nocomp should only exist in RAM world, not VFIO's.
> > 
> > And it looks like you agree with Fabiano's RFC proposal, please work on top
> > of that to provide that layer.  Please make sure it outputs the minimum in
> > "$ git grep device_state migration/multifd.c" when you work on the new
> > version.  Currently:
> > 
> > $ git grep device_state migration/multifd.c | wc -l
> > 59
> > 
> > The hope is zero, or at least a minimum with good reasons.
> 
> I guess you mean "grep -i" in the above example, since otherwise
> the above command will find only lowercase "device_state".
> 
> On the other hand, your example code above has uppercase
> "DEVICE_STATE", suggesting that it might be okay?

Yes that's definitely ok.  I could be over-cautious when I used the grep
example, but I hope you get my point where we should remove that
device_state pointer, rather than as generic as supporting multifd to take
device state buffers.

Especially, if that idea will also apply on top of non-VFIO devices,
e.g. when we extend that to a normal VMSD buffer to be delivered too using
that same mechanism, then I think it's even okay to have some
"device_state" there.  Personally I would still think those as justified
usages that are generic enough; after all I don't expect multifd to send
other things besides RAM and generic terms of device states.

> 
> Overall, using Fabiano's patch set as a base for mine makes sense to me.
> 
> > 2. Frequent mallocs/frees
> > =========================
> > 
> > Fabiano's series can also help to address some of these, but it looks like
> > this series used malloc/free more than the opaque data buffer.  This is not
> > required to get things merged, but it'll be nice to avoid those if possible.
> 
> Ack - as long as its not making the code messy/fragile, of course.
> 
> > 3. load_state_buffer() and VFIODeviceStatePacket protocol
> > =========================================================
> > 
> > VFIODeviceStatePacket is the new protocol you introduced into multifd
> > packets, along with the new load_state_buffer() hook for loading such
> > buffers.  My question is whether it's needed at all, or.. whether it can be
> > more generic (and also easier) to just allow taking any device state in the
> > multifd packets, then load it with vmstate load().
> > 
> > I mean, the vmstate_load() should really have worked on these buffers, if
> > after all VFIO is looking for: (1) VFIO_MIG_FLAG_DEV_DATA_STATE as the
> > first flag (uint64), size as the 2nd, then (2) load that rest buffer into
> > VFIO kernel driver.  That is the same to happen during the blackout window.
> > It's not clear to me why load_state_buffer() is needed.
> > 
> > I also see that you're also using exactly the same chunk size for such
> > buffering (VFIOMigration.data_buffer_size).
> > 
> > I think you have a "reason": VFIODeviceStatePacket and loading of the
> > buffer data resolved one major issue that wasn't there before but start to
> > have now: multifd allows concurrent arrivals of vfio buffers, even if the
> > buffer *must* be sequentially loaded.
> > 
> > That's a major pain for current VFIO kernel ioctl design, IMHO.  I think I
> > used to ask nVidia people on whether the VFIO get_state/set_state interface
> > can allow indexing or tagging of buffers but I never get a real response.
> > IMHO that'll be extremely helpful for migration purpose on concurrency if
> > it can happen, rather than using a serialized buffer.  It means
> > concurrently save/load one VFIO device could be extremely hard, if not
> > impossible.
> 
> I am pretty sure that the current kernel VFIO interface requires for the
> buffers to be loaded in-order - accidentally providing the out of order
> definitely breaks the restore procedure.

Ah, I didn't mean that we need to do it with the current API.  I'm talking
about whether it's possible to have a v2 that will support those otherwise
we'll need to do "workarounds" like what you're doing with "unlimited
buffer these on dest, until we receive continuous chunk of data" tricks.

And even with that trick, it'll still need to be serialized on the read()
syscall so it won't scale either if the state is huge.  For that issue
there's no workaround we can do from userspace.

> 
> > Now in your series IIUC you resolved that by using vfio_load_bufs_thread(),
> > holding off the load process but only until sequential buffers are
> > received.  I think that causes one issue that I'll mention below as a
> > separate topic.  But besides that, my point is, this is not the reason that
> > you need to introduce VFIODeviceStatePacket, load_state_buffer() and so on.
> > My understanding is that we do need one way to re-serialize the buffers,
> > but it doesn't need load_state_buffer(), instead it can call vmstate_load()
> > in order, properly invoke vfio_load_state() with the right buffers.  It'll
> > just be nice if VFIO can keep its "load state" logic at one place.
> 
> Re-using the .load_state hook for multifd device state date has a few
> additional issues:
> * This hook accepts a QEMUFile parameter, not a buffer.
> 
> * Due to the above, it (and the functions it calls) expects being able to
> read all the required data in one go.
> 
> In other words, there's no way for this hook to suspend its execution and
> return because the next piece of data it wants hasn't arrived yet.
> 
> Specifically, this hook is only able to exit at VFIO_MIG_FLAG_END_OF_STATE
> boundaries in the incoming stream.
> 
> * The hook is expected to be called from the main migration thread, and
> so calls to it are expected to be effectively serialized.
> 
> It can also safely call core QEMU functions, like it does from
> vfio_load_device_config_state() -> vfio_pci_load_config() -> vmstate_load_state().
> This actually fails when called from any other thread (in some memory region
> modification function, as far as I remember).
> 
> In contrast to that, .load_state_buffer hook is prepared to deal with getting
> calls from multiple multifd receive threads.

Ah yes, I forgot we're still using QEMUFiles to load states... that's a
pity, and that makes sense.  Also, when I read this again I noticed indeed
any channel/file based approach won't work for VFIO at least, due to the
fact that it needs to do caching for out-of-order buffers issue.

Then when I looked closer, it's a pity that "next_packet_size" field is not
after "flags"; that should really be part of your new MultiFDPacketHdr_t,
but indeed we won't achieve that without breaking current protocol.

When at it, if you want maybe you can also start to rename MultiFDPacket_t
to MultiFDRAMPacket_t already.

Now I think I agree with you: using a buffer as a generic concept to take
device states seems like a good idea, and we can start doing that from
VFIO.  Please keep that in mind that in all these paths it should be
generic enough for non-VFIO to do so.  From that POV I think your series
did a good job already indeed from this perspective, so now I think I'm ok
with it.

There's another slight unfortunate where MultiFDPacketDeviceState_t will
always need to send the idstr[]..  I think it is a good start, though, as
generic VMSD migrations will also need that (QEMU_VM_SECTION_FULL) so it's
not super efficient but generic enough.  You might want to look at how
current migration tackles that with load_section_id field, but that can be
for later, just fyi.  I wonder how find_se() could impact perf when
there're lots of devices, I never really measured it.

> 
> > One benefit of that is with such a more generic framework, QEMU can easily
> > extend this infra to other device states, so that logically we can consider
> > sending non-VFIO device states also in the multifd buffers.  However with
> > your current solution, new structures are needed, new hooks, a lot of new
> > codes around, however less problems it solved..  That's not optimal.
> 
> This all relies on a promise than the current .load_state hooks can be
> efficiently called from multiple multifd receive threads, which isn't true
> today.
> 
> Due to the reasons I specified above I think modifying these existing
> hooks would be more complex than just introducing a new one with the
> proper semantics.
> 
> > 4. Risk of OOM on unlimited VFIO buffering
> > ==========================================
> > 
> > This follows with above bullet, but my pure question to ask here is how
> > does VFIO guarantees no OOM condition by buffering VFIO state?
> > 
> > I mean, currently your proposal used vfio_load_bufs_thread() as a separate
> > thread to only load the vfio states until sequential data is received,
> > however is there an upper limit of how much buffering it could do?  IOW:
> > 
> > vfio_load_state_buffer():
> > 
> >    if (packet->idx >= migration->load_bufs->len) {
> >        g_array_set_size(migration->load_bufs, packet->idx + 1);
> >    }
> > 
> >    lb = &g_array_index(migration->load_bufs, typeof(*lb), packet->idx);
> >    ...
> >    lb->data = g_memdup2(&packet->data, data_size - sizeof(*packet));
> >    lb->len = data_size - sizeof(*packet);
> >    lb->is_present = true;
> > 
> > What if garray keeps growing with lb->data allocated, which triggers the
> > memcg limit of the process (if QEMU is in such process)?  Or just deplete
> > host memory and causing OOM kill.
> > 
> > I think we may need to find a way to throttle max memory usage of such
> > buffering.
> > 
> > So far this will be more of a problem indeed if this will be done during
> > VFIO iteration phases, but I still hope a solution can work with both
> > iteration phase and the switchover phase, even if you only do that in
> > switchover phase
> 
> Unfortunately, this issue will be hard to fix since the source can
> legitimately send the very first buffer (chunk) of data as the last one
> (at the very end of the transmission).
> 
> In this case, the target will need to buffer nearly the whole data.
> 
> We can't stop the receive on any channel, either, since the next missing
> buffer can arrive at that channel.
> 
> However, I don't think purposely DoSing the target QEMU is a realistic
> security concern in the typical live migration scenario.
> 
> I mean the source can easily force the target QEMU to exit just by
> feeding it wrong migration data.
> 
> In case someone really wants to protect against the impact of
> theoretically unbounded QEMU memory allocations during live migration
> on the rest of the system they can put the target QEMU process
> (temporally) into a memory-limited cgroup.

Note that I'm not worrying about DoS of a malicious src QEMU, and I'm
exactly talking about the generic case where QEMU (either src or dest, in
that case normally both) is put into the memcg and if QEMU uses too much
memory it'll literally get killed even if no DoS issue at all.

In short, we hopefully will have a design that will always work with QEMU
running in a container, without 0.5% chance dest qemu being killed, if you
see what I meant.

The upper bound of VFIO buffering will be needed so the admin can add that
on top of the memcg limit and as long as QEMU keeps its words it'll always
work without sudden death.

I think I have some idea about resolving this problem.  That idea can
further complicate the protocol a little bit.  But before that let's see
whether we can reach an initial consensus on this matter first, on whether
this is a sane request.  In short, we'll need to start to have a
configurable size to say how much VFIO can buffer, maybe per-device, or
globally.  Then based on that we need to have some logic guarantee that
over-mem won't happen, also without heavily affecting concurrency (e.g.,
single thread is definitely safe and without caching, but it can be
slower).

> 
> > (and I don't know why you don't care about VFIO iteration
> > phase, if you cared enough on how VFIO works now with migration.. literally
> > that should help VFIO migrates faster on 25G+ networks, with/without a
> > shorter blackout window).
> 
> I do care about the VM live phase, too.
> 
> Just to keep the complexity in bounds for the first version I wanted to
> deal with the most pressing issue first - downtime.
> 
> I am not against accommodating the VM live phase changes if they don't
> significantly expand the patch set size.

Makes sense.  Again, as long as the qemu (with this series applied) can
also take iterative vfio datas in the newer QEMUs if that'll come, I'll
be perfectly happy with that.

Or one step back, if that can't be achieved, I hope we figure out the
complexity and justify that, rather than completely ignoring the iteration
phase, then that'll be also good enough to me.

> > 5. Worker thread model
> > ======================
> > 
> > I'm so far not happy with what this proposal suggests on creating the
> > threads, also the two new hooks mostly just to create these threads..
> 
> That VFIO .save_live_complete_precopy_begin handler crates a new
> per-device thread is an implementation detail for this particular
> driver.
> 
> The whole idea behind this and save_live_complete_precopy_end hook was
> that details how the particular device driver does its own async saving
> is abstracted away from the migration core.
> 
> The device then can do what's best / most efficient for it to do.

Yes, and what I was thinking is whether it does it in form of "enqueue a
task to migration worker threads", rather than "creating its own threads in
the device hooks, and managing those threads alone".

It's all about whether such threading can be reused by non-VFIO devices.
They can't be reused if VFIO is in charge here, and it will make migration
less generic.

My current opinion is they can and should be re-usable. Consider if someone
starts to teach multifd carry non-vfio data (e.g. a generic VMSD), then we
can enqueue a task, do e.g. ioctl(KVM_GET_REGS) in those threads (rather
than VFIO read()).

> 
> > I know I suggested that.. but that's comparing to what I read in the even
> > earlier version, and sorry I wasn't able to suggest something better at
> > that time because I simply thought less.
> > 
> > As I mentioned in the other reply elsewhere, I think we should firstly have
> > these threads ready to take data at the start of migration, so that it'll
> > work when someone wants to add vfio iteration support.  Then the jobs
> > (mostly what vfio_save_complete_precopy_async_thread() does now) can be
> > enqueued into the thread pools.
> 
> I'm not sure that we can get way with using fewer threads than devices
> as these devices might not support AIO reads from their migration file
> descriptor.

It doesn't need to use AIO reads - I'll be happy if the thread model can be
generic, VFIO can still enqueue a task that does blocking reads.

It can take a lot of time, but it's fine: others who like to enqueue too
and see all threads busy, they should simply block there and waiting for
the worker threads to be freed again.  It's the same when there's no
migration worker threads as it means the read() will block the main
migration thread.

Now we can have multiple worker threads doing things concurrently if
possible (some of them may not, especially when BQL will be required, but
that's a separate thing, and many device save()s may not need BQL, and when
it needs we can take it in the enqueued tasks).

> 
> mlx5 devices, for example, seems to support only poll()ed / non-blocking
> reads at best - with unknown performance in comparison with issuing
> blocking reads from dedicated threads.
> 
> On the other hand, handling a single device from multiple threads in
> parallel is generally not possible due to difficulty of establishing in
> which order the buffers were read.
> 
> And if we need a per-VFIO device thread anyway then using a thread pool
> doesn't help much - but brings extra complexity.
> 
> In terms of starting the loading thread earlier to load also VM live
> phase data it looks like a small change to the code so it shouldn't be
> a problem.

That's good to know.  Please still consider a generic thread model and see
what that would also work for your VFIO use case.

If you see what thread-pool.c did right now is it'll dynamically create
threads on the fly.  I think that's something we can do too but just apply
an upper limit to the thread numbers.

> 
> > It's better to create the thread pool owned by migration, rather than
> > threads owned by VFIO, because it also paves way for non-VFIO device state
> > save()s, as I mentioned also above on the multifd packet header.  Maybe we
> > can have a flag in the packet header saying "this is device xxx's state,
> > just load it".
> 
> I think the same could be done by simply implementing these hooks in other
> device types than VFIO, right?
> 
> And if we notice that these implementations share a bit of code then we
> can think about making a common helper library out of this code.
> 
> After, all that's just an implementation detail that does not impact
> the underlying bit stream protocol.

You're correct.

However, it still affects a few things.

Firstly, it may mean that we may not even need those two extra vmstate
hooks: the enqueue can happen already with save_state() if the migration
worker model exists.

So instead of this:

        vfio_save_state():
        if (migration->multifd_transfer) {
                /* Emit dummy NOP data */
                qemu_put_be64(f, VFIO_MIG_FLAG_END_OF_STATE);
                return;
        }

We can already do:

        if (migration->multifd_transfer) {
                // enqueue task to load state for this vfio device
                ...
                return;
        }

IMHO it'll be much cleaner in VFIO code, and much cleaner too for migration
code.

Another (possibly personal) reason is, I will not dare to touch VFIO code
too much to do such a refactoring later.  I simply don't have the VFIO
devices around and I won't be able to test.  So comparing to other things,
I hope VFIO stuff can land more stable than others because I am not
confident at least myself to clean it.

I simply also don't like random threads floating around, considering that
how we already have slightly a mess with migration on other reasons (we can
still have random TLS threads floating around, I think... and they can
cause very hard to debug issues). I feel shaky to maintain it when any
device can also start to create whatever threads they can during migration.

> 
> > I'd start looking at util/thread-pool.c, removing all the AIO implications
> > but simply provide a raw thread pool for what thread_pool_submit() is
> > doing.
> > 
> > I know this is a lot, but I really think this is the right thing.. but we
> > can discuss, and you can correct me on my mistakes if there is.
> > 
> > If you want I can have a look at this pool model and prepare a patch, so
> > you can work on other vfio relevant stuff and pick that up, if that helps
> > you trying to reach the goal of landing this whole stuff in 9.1.
> 
> I would certainly help with the amount of work (thanks for the offer!),
> but as I wrote above I am not really convinced that adapting the existing
> thread pool utils for this usage is really the way to go here.

Yes let's figure that out first on the uncertainties, the plan is for
later.

Thanks,

-- 
Peter Xu


