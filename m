Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 963F9C2BD09
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2024 19:52:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLpj3-0007ap-Ht; Mon, 24 Jun 2024 15:51:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mail@maciej.szmigiero.name>)
 id 1sLpj1-0007ah-W7
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 15:51:40 -0400
Received: from vps-vb.mhejs.net ([37.28.154.113])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mail@maciej.szmigiero.name>)
 id 1sLpiy-0007H4-Mg
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 15:51:39 -0400
Received: from MUA by vps-vb.mhejs.net with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.94.2)
 (envelope-from <mail@maciej.szmigiero.name>)
 id 1sLpim-000650-BH; Mon, 24 Jun 2024 21:51:24 +0200
Message-ID: <b0dc8bc4-742b-474b-a4c4-4e190fd6af37@maciej.szmigiero.name>
Date: Mon, 24 Jun 2024 21:51:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?Q?Re=3A_=5BPATCH_v1_00/13=5D_Multifd_=F0=9F=94=80_device_st?=
 =?UTF-8?Q?ate_transfer_support_with_VFIO_consumer?=
To: Peter Xu <peterx@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, Joao Martins <joao.m.martins@oracle.com>,
 qemu-devel@nongnu.org
References: <cover.1718717584.git.maciej.szmigiero@oracle.com>
 <ZniFH14DT6ycjbrL@x1n>
Content-Language: en-US, pl-PL
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Autocrypt: addr=mail@maciej.szmigiero.name; keydata=
 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
In-Reply-To: <ZniFH14DT6ycjbrL@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=37.28.154.113;
 envelope-from=mail@maciej.szmigiero.name; helo=vps-vb.mhejs.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

Hi Peter,

On 23.06.2024 22:27, Peter Xu wrote:
> On Tue, Jun 18, 2024 at 06:12:18PM +0200, Maciej S. Szmigiero wrote:
>> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
>>
>> This is an updated v1 patch series of the RFC (v0) series located here:
>> https://lore.kernel.org/qemu-devel/cover.1713269378.git.maciej.szmigiero@oracle.com/
> 
> OK I took some hours thinking about this today, and here's some high level
> comments for this series.  I'll start with which are more relevant to what
> Fabiano has already suggested in the other thread, then I'll add some more.
> 
> https://lore.kernel.org/r/20240620212111.29319-1-farosas@suse.de

That's a long list, thanks for these comments.

I have responded to them inline below.

> 1. Multifd device state support
> ===============================
> 
> As Fabiano suggested in his RFC post, we may need one more layer of
> abstraction to represent VFIO's demand on allowing multifd to send
> arbitrary buffer to the wire.  This can be more than "how to pass the
> device state buffer to the sender threads".
> 
> So far, MultiFDMethods is only about RAM.  If you pull the latest master
> branch Fabiano just merged yet two more RAM compressors that are extended
> on top of MultiFDMethods model.  However still they're all about RAM.  I
> think it's better to keep it this way, so maybe MultiFDMethods should some
> day be called MultiFDRamMethods.
> 
> multifd_send_fill_packet() may only be suitable for RAM buffers, not adhoc
> buffers like what VFIO is using. multifd_send_zero_page_detect() may not be
> needed either for arbitrary buffers.  Most of those are still page-based.
> 
> I think it also means we shouldn't call ->send_prepare() when multifd send
> thread notices that it's going to send a VFIO buffer.  So it should look
> like this:
> 
>    int type = multifd_payload_type(p->data);
>    if (type == MULTIFD_PAYLOAD_RAM) {
>        multifd_send_state->ops->send_prepare(p, &local_err);
>    } else {
>        // VFIO buffers should belong here
>        assert(type == MULTIFD_PAYLOAD_DEVICE_STATE);
>        ...
>    }
> 
> It also means it shouldn't contain code like:
> 
> nocomp_send_prepare():
>      if (p->is_device_state_job) {
>          return nocomp_send_prepare_device_state(p, errp);
>      } else {
>          return nocomp_send_prepare_ram(p, errp);
>      }
> 
> nocomp should only exist in RAM world, not VFIO's.
> 
> And it looks like you agree with Fabiano's RFC proposal, please work on top
> of that to provide that layer.  Please make sure it outputs the minimum in
> "$ git grep device_state migration/multifd.c" when you work on the new
> version.  Currently:
> 
> $ git grep device_state migration/multifd.c | wc -l
> 59
> 
> The hope is zero, or at least a minimum with good reasons.

I guess you mean "grep -i" in the above example, since otherwise
the above command will find only lowercase "device_state".

On the other hand, your example code above has uppercase
"DEVICE_STATE", suggesting that it might be okay?

Overall, using Fabiano's patch set as a base for mine makes sense to me.

> 2. Frequent mallocs/frees
> =========================
> 
> Fabiano's series can also help to address some of these, but it looks like
> this series used malloc/free more than the opaque data buffer.  This is not
> required to get things merged, but it'll be nice to avoid those if possible.

Ack - as long as its not making the code messy/fragile, of course.

> 3. load_state_buffer() and VFIODeviceStatePacket protocol
> =========================================================
> 
> VFIODeviceStatePacket is the new protocol you introduced into multifd
> packets, along with the new load_state_buffer() hook for loading such
> buffers.  My question is whether it's needed at all, or.. whether it can be
> more generic (and also easier) to just allow taking any device state in the
> multifd packets, then load it with vmstate load().
> 
> I mean, the vmstate_load() should really have worked on these buffers, if
> after all VFIO is looking for: (1) VFIO_MIG_FLAG_DEV_DATA_STATE as the
> first flag (uint64), size as the 2nd, then (2) load that rest buffer into
> VFIO kernel driver.  That is the same to happen during the blackout window.
> It's not clear to me why load_state_buffer() is needed.
> 
> I also see that you're also using exactly the same chunk size for such
> buffering (VFIOMigration.data_buffer_size).
> 
> I think you have a "reason": VFIODeviceStatePacket and loading of the
> buffer data resolved one major issue that wasn't there before but start to
> have now: multifd allows concurrent arrivals of vfio buffers, even if the
> buffer *must* be sequentially loaded.
> 
> That's a major pain for current VFIO kernel ioctl design, IMHO.  I think I
> used to ask nVidia people on whether the VFIO get_state/set_state interface
> can allow indexing or tagging of buffers but I never get a real response.
> IMHO that'll be extremely helpful for migration purpose on concurrency if
> it can happen, rather than using a serialized buffer.  It means
> concurrently save/load one VFIO device could be extremely hard, if not
> impossible.

I am pretty sure that the current kernel VFIO interface requires for the
buffers to be loaded in-order - accidentally providing the out of order
definitely breaks the restore procedure.

> Now in your series IIUC you resolved that by using vfio_load_bufs_thread(),
> holding off the load process but only until sequential buffers are
> received.  I think that causes one issue that I'll mention below as a
> separate topic.  But besides that, my point is, this is not the reason that
> you need to introduce VFIODeviceStatePacket, load_state_buffer() and so on.
> My understanding is that we do need one way to re-serialize the buffers,
> but it doesn't need load_state_buffer(), instead it can call vmstate_load()
> in order, properly invoke vfio_load_state() with the right buffers.  It'll
> just be nice if VFIO can keep its "load state" logic at one place.

Re-using the .load_state hook for multifd device state date has a few
additional issues:
* This hook accepts a QEMUFile parameter, not a buffer.

* Due to the above, it (and the functions it calls) expects being able to
read all the required data in one go.

In other words, there's no way for this hook to suspend its execution and
return because the next piece of data it wants hasn't arrived yet.

Specifically, this hook is only able to exit at VFIO_MIG_FLAG_END_OF_STATE
boundaries in the incoming stream.

* The hook is expected to be called from the main migration thread, and
so calls to it are expected to be effectively serialized.

It can also safely call core QEMU functions, like it does from
vfio_load_device_config_state() -> vfio_pci_load_config() -> vmstate_load_state().
This actually fails when called from any other thread (in some memory region
modification function, as far as I remember).

In contrast to that, .load_state_buffer hook is prepared to deal with getting
calls from multiple multifd receive threads.

> One benefit of that is with such a more generic framework, QEMU can easily
> extend this infra to other device states, so that logically we can consider
> sending non-VFIO device states also in the multifd buffers.  However with
> your current solution, new structures are needed, new hooks, a lot of new
> codes around, however less problems it solved..  That's not optimal.

This all relies on a promise than the current .load_state hooks can be
efficiently called from multiple multifd receive threads, which isn't true
today.

Due to the reasons I specified above I think modifying these existing
hooks would be more complex than just introducing a new one with the
proper semantics.

> 4. Risk of OOM on unlimited VFIO buffering
> ==========================================
> 
> This follows with above bullet, but my pure question to ask here is how
> does VFIO guarantees no OOM condition by buffering VFIO state?
> 
> I mean, currently your proposal used vfio_load_bufs_thread() as a separate
> thread to only load the vfio states until sequential data is received,
> however is there an upper limit of how much buffering it could do?  IOW:
> 
> vfio_load_state_buffer():
> 
>    if (packet->idx >= migration->load_bufs->len) {
>        g_array_set_size(migration->load_bufs, packet->idx + 1);
>    }
> 
>    lb = &g_array_index(migration->load_bufs, typeof(*lb), packet->idx);
>    ...
>    lb->data = g_memdup2(&packet->data, data_size - sizeof(*packet));
>    lb->len = data_size - sizeof(*packet);
>    lb->is_present = true;
> 
> What if garray keeps growing with lb->data allocated, which triggers the
> memcg limit of the process (if QEMU is in such process)?  Or just deplete
> host memory and causing OOM kill.
> 
> I think we may need to find a way to throttle max memory usage of such
> buffering.
> 
> So far this will be more of a problem indeed if this will be done during
> VFIO iteration phases, but I still hope a solution can work with both
> iteration phase and the switchover phase, even if you only do that in
> switchover phase 

Unfortunately, this issue will be hard to fix since the source can
legitimately send the very first buffer (chunk) of data as the last one
(at the very end of the transmission).

In this case, the target will need to buffer nearly the whole data.

We can't stop the receive on any channel, either, since the next missing
buffer can arrive at that channel.

However, I don't think purposely DoSing the target QEMU is a realistic
security concern in the typical live migration scenario.

I mean the source can easily force the target QEMU to exit just by
feeding it wrong migration data.

In case someone really wants to protect against the impact of
theoretically unbounded QEMU memory allocations during live migration
on the rest of the system they can put the target QEMU process
(temporally) into a memory-limited cgroup.

> (and I don't know why you don't care about VFIO iteration
> phase, if you cared enough on how VFIO works now with migration.. literally
> that should help VFIO migrates faster on 25G+ networks, with/without a
> shorter blackout window).

I do care about the VM live phase, too.

Just to keep the complexity in bounds for the first version I wanted to
deal with the most pressing issue first - downtime.

I am not against accommodating the VM live phase changes if they don't
significantly expand the patch set size.
  
> 5. Worker thread model
> ======================
> 
> I'm so far not happy with what this proposal suggests on creating the
> threads, also the two new hooks mostly just to create these threads..

That VFIO .save_live_complete_precopy_begin handler crates a new
per-device thread is an implementation detail for this particular
driver.

The whole idea behind this and save_live_complete_precopy_end hook was
that details how the particular device driver does its own async saving
is abstracted away from the migration core.

The device then can do what's best / most efficient for it to do.

> I know I suggested that.. but that's comparing to what I read in the even
> earlier version, and sorry I wasn't able to suggest something better at
> that time because I simply thought less.
> 
> As I mentioned in the other reply elsewhere, I think we should firstly have
> these threads ready to take data at the start of migration, so that it'll
> work when someone wants to add vfio iteration support.  Then the jobs
> (mostly what vfio_save_complete_precopy_async_thread() does now) can be
> enqueued into the thread pools.

I'm not sure that we can get way with using fewer threads than devices
as these devices might not support AIO reads from their migration file
descriptor.

mlx5 devices, for example, seems to support only poll()ed / non-blocking
reads at best - with unknown performance in comparison with issuing
blocking reads from dedicated threads.

On the other hand, handling a single device from multiple threads in
parallel is generally not possible due to difficulty of establishing in
which order the buffers were read.

And if we need a per-VFIO device thread anyway then using a thread pool
doesn't help much - but brings extra complexity.

In terms of starting the loading thread earlier to load also VM live
phase data it looks like a small change to the code so it shouldn't be
a problem.

> It's better to create the thread pool owned by migration, rather than
> threads owned by VFIO, because it also paves way for non-VFIO device state
> save()s, as I mentioned also above on the multifd packet header.  Maybe we
> can have a flag in the packet header saying "this is device xxx's state,
> just load it".

I think the same could be done by simply implementing these hooks in other
device types than VFIO, right?

And if we notice that these implementations share a bit of code then we
can think about making a common helper library out of this code.

After, all that's just an implementation detail that does not impact
the underlying bit stream protocol.

> I'd start looking at util/thread-pool.c, removing all the AIO implications
> but simply provide a raw thread pool for what thread_pool_submit() is
> doing.
> 
> I know this is a lot, but I really think this is the right thing.. but we
> can discuss, and you can correct me on my mistakes if there is.
> 
> If you want I can have a look at this pool model and prepare a patch, so
> you can work on other vfio relevant stuff and pick that up, if that helps
> you trying to reach the goal of landing this whole stuff in 9.1.

I would certainly help with the amount of work (thanks for the offer!),
but as I wrote above I am not really convinced that adapting the existing
thread pool utils for this usage is really the way to go here.

> But I hope I explained more or less in this email on why I think this
> feature is more involved than it looks like, and not yet mature from
> design. And I hope I'm not purly asking for too much: merging this VFIO
> series first then refactor on top can mean dropping too much unneeded code
> after adding them, not to mention the protocol going to need another break.
> 
> It just doesn't sound like the right thing to do.
> 
> Thanks,
> 

Thanks,
Maciej


