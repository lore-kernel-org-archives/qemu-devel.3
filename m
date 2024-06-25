Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80B7EC30653
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2024 23:58:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMFem-0006E0-UF; Tue, 25 Jun 2024 19:33:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mail@maciej.szmigiero.name>)
 id 1sMFeX-00069D-Bz
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 19:32:45 -0400
Received: from vps-vb.mhejs.net ([37.28.154.113])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mail@maciej.szmigiero.name>)
 id 1sMFdy-0003jF-4N
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 19:32:39 -0400
Received: from MUA by vps-vb.mhejs.net with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.94.2)
 (envelope-from <mail@maciej.szmigiero.name>)
 id 1sMEtu-0005Lu-OX; Wed, 26 Jun 2024 00:44:34 +0200
Message-ID: <9e85016e-ac72-4207-8e69-8cba054cefb7@maciej.szmigiero.name>
Date: Wed, 26 Jun 2024 00:44:29 +0200
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
 <b0dc8bc4-742b-474b-a4c4-4e190fd6af37@maciej.szmigiero.name>
 <Znr9mOo_t0DkkLbD@x1n>
Content-Language: en-US, pl-PL
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Autocrypt: addr=mail@maciej.szmigiero.name; keydata=
 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
In-Reply-To: <Znr9mOo_t0DkkLbD@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=37.28.154.113;
 envelope-from=mail@maciej.szmigiero.name; helo=vps-vb.mhejs.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, T_SPF_HELO_TEMPERROR=0.01,
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

On 25.06.2024 19:25, Peter Xu wrote:
> On Mon, Jun 24, 2024 at 09:51:18PM +0200, Maciej S. Szmigiero wrote:
>> Hi Peter,
> 
> Hi, Maciej,
> 
>>
>> On 23.06.2024 22:27, Peter Xu wrote:
>>> On Tue, Jun 18, 2024 at 06:12:18PM +0200, Maciej S. Szmigiero wrote:
>>>> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
>>>>
>>>> This is an updated v1 patch series of the RFC (v0) series located here:
>>>> https://lore.kernel.org/qemu-devel/cover.1713269378.git.maciej.szmigiero@oracle.com/
>>>
>>> OK I took some hours thinking about this today, and here's some high level
>>> comments for this series.  I'll start with which are more relevant to what
>>> Fabiano has already suggested in the other thread, then I'll add some more.
>>>
>>> https://lore.kernel.org/r/20240620212111.29319-1-farosas@suse.de
>>
>> That's a long list, thanks for these comments.
>>
>> I have responded to them inline below.
>>
(..)
>>
>>> 3. load_state_buffer() and VFIODeviceStatePacket protocol
>>> =========================================================
>>>
>>> VFIODeviceStatePacket is the new protocol you introduced into multifd
>>> packets, along with the new load_state_buffer() hook for loading such
>>> buffers.  My question is whether it's needed at all, or.. whether it can be
>>> more generic (and also easier) to just allow taking any device state in the
>>> multifd packets, then load it with vmstate load().
>>>
>>> I mean, the vmstate_load() should really have worked on these buffers, if
>>> after all VFIO is looking for: (1) VFIO_MIG_FLAG_DEV_DATA_STATE as the
>>> first flag (uint64), size as the 2nd, then (2) load that rest buffer into
>>> VFIO kernel driver.  That is the same to happen during the blackout window.
>>> It's not clear to me why load_state_buffer() is needed.
>>>
>>> I also see that you're also using exactly the same chunk size for such
>>> buffering (VFIOMigration.data_buffer_size).
>>>
>>> I think you have a "reason": VFIODeviceStatePacket and loading of the
>>> buffer data resolved one major issue that wasn't there before but start to
>>> have now: multifd allows concurrent arrivals of vfio buffers, even if the
>>> buffer *must* be sequentially loaded.
>>>
>>> That's a major pain for current VFIO kernel ioctl design, IMHO.  I think I
>>> used to ask nVidia people on whether the VFIO get_state/set_state interface
>>> can allow indexing or tagging of buffers but I never get a real response.
>>> IMHO that'll be extremely helpful for migration purpose on concurrency if
>>> it can happen, rather than using a serialized buffer.  It means
>>> concurrently save/load one VFIO device could be extremely hard, if not
>>> impossible.
>>
>> I am pretty sure that the current kernel VFIO interface requires for the
>> buffers to be loaded in-order - accidentally providing the out of order
>> definitely breaks the restore procedure.
> 
> Ah, I didn't mean that we need to do it with the current API.  I'm talking
> about whether it's possible to have a v2 that will support those otherwise
> we'll need to do "workarounds" like what you're doing with "unlimited
> buffer these on dest, until we receive continuous chunk of data" tricks.

Better kernel API might be possible in the long term but for now we have
to live with what we have right now.

After all, adding true unordered loading - I mean not just moving the
reassembly process from QEMU to the kernel but making the device itself
accept buffers out out order - will likely be pretty complex (requiring
adding such functionality to the device firmware, etc).

> And even with that trick, it'll still need to be serialized on the read()
> syscall so it won't scale either if the state is huge.  For that issue
> there's no workaround we can do from userspace.

The read() calls for multiple VFIO devices can be issued in parallel,
and in fact they are in my patch set.

(..)
>>> 4. Risk of OOM on unlimited VFIO buffering
>>> ==========================================
>>>
>>> This follows with above bullet, but my pure question to ask here is how
>>> does VFIO guarantees no OOM condition by buffering VFIO state?
>>>
>>> I mean, currently your proposal used vfio_load_bufs_thread() as a separate
>>> thread to only load the vfio states until sequential data is received,
>>> however is there an upper limit of how much buffering it could do?  IOW:
>>>
>>> vfio_load_state_buffer():
>>>
>>>     if (packet->idx >= migration->load_bufs->len) {
>>>         g_array_set_size(migration->load_bufs, packet->idx + 1);
>>>     }
>>>
>>>     lb = &g_array_index(migration->load_bufs, typeof(*lb), packet->idx);
>>>     ...
>>>     lb->data = g_memdup2(&packet->data, data_size - sizeof(*packet));
>>>     lb->len = data_size - sizeof(*packet);
>>>     lb->is_present = true;
>>>
>>> What if garray keeps growing with lb->data allocated, which triggers the
>>> memcg limit of the process (if QEMU is in such process)?  Or just deplete
>>> host memory and causing OOM kill.
>>>
>>> I think we may need to find a way to throttle max memory usage of such
>>> buffering.
>>>
>>> So far this will be more of a problem indeed if this will be done during
>>> VFIO iteration phases, but I still hope a solution can work with both
>>> iteration phase and the switchover phase, even if you only do that in
>>> switchover phase
>>
>> Unfortunately, this issue will be hard to fix since the source can
>> legitimately send the very first buffer (chunk) of data as the last one
>> (at the very end of the transmission).
>>
>> In this case, the target will need to buffer nearly the whole data.
>>
>> We can't stop the receive on any channel, either, since the next missing
>> buffer can arrive at that channel.
>>
>> However, I don't think purposely DoSing the target QEMU is a realistic
>> security concern in the typical live migration scenario.
>>
>> I mean the source can easily force the target QEMU to exit just by
>> feeding it wrong migration data.
>>
>> In case someone really wants to protect against the impact of
>> theoretically unbounded QEMU memory allocations during live migration
>> on the rest of the system they can put the target QEMU process
>> (temporally) into a memory-limited cgroup.
> 
> Note that I'm not worrying about DoS of a malicious src QEMU, and I'm
> exactly talking about the generic case where QEMU (either src or dest, in
> that case normally both) is put into the memcg and if QEMU uses too much
> memory it'll literally get killed even if no DoS issue at all.
> 
> In short, we hopefully will have a design that will always work with QEMU
> running in a container, without 0.5% chance dest qemu being killed, if you
> see what I meant.
> 
> The upper bound of VFIO buffering will be needed so the admin can add that
> on top of the memcg limit and as long as QEMU keeps its words it'll always
> work without sudden death.
> 
> I think I have some idea about resolving this problem.  That idea can
> further complicate the protocol a little bit.  But before that let's see
> whether we can reach an initial consensus on this matter first, on whether
> this is a sane request.  In short, we'll need to start to have a
> configurable size to say how much VFIO can buffer, maybe per-device, or
> globally.  Then based on that we need to have some logic guarantee that
> over-mem won't happen, also without heavily affecting concurrency (e.g.,
> single thread is definitely safe and without caching, but it can be
> slower).

Here, I think I can add a per-device limit parameter on the number of
buffers received out-of-order or waiting to be loaded into the device -
with a reasonable default.

(..)
>>> 5. Worker thread model
>>> ======================
>>>
>>> I'm so far not happy with what this proposal suggests on creating the
>>> threads, also the two new hooks mostly just to create these threads..
>>
>> That VFIO .save_live_complete_precopy_begin handler crates a new
>> per-device thread is an implementation detail for this particular
>> driver.
>>
>> The whole idea behind this and save_live_complete_precopy_end hook was
>> that details how the particular device driver does its own async saving
>> is abstracted away from the migration core.
>>
>> The device then can do what's best / most efficient for it to do.
> 
> Yes, and what I was thinking is whether it does it in form of "enqueue a
> task to migration worker threads", rather than "creating its own threads in
> the device hooks, and managing those threads alone".
> 
> It's all about whether such threading can be reused by non-VFIO devices.
> They can't be reused if VFIO is in charge here, and it will make migration
> less generic.
> 
> My current opinion is they can and should be re-usable. Consider if someone
> starts to teach multifd carry non-vfio data (e.g. a generic VMSD), then we
> can enqueue a task, do e.g. ioctl(KVM_GET_REGS) in those threads (rather
> than VFIO read()).

Theoretically, it's obviously possible to wrap every operation in a request
to some thread pool.


But that would bring a lot of complexity, since instead of performing these
operation directly now the requester will need to:
1) Prepare some "Operation" structure with the parameters of the requested
operation (task).
In your case this could be QEMU_OP_GET_VCPU_REGS operation using
"OperationGetVCPURegs" struct containing vCPU number parameter = 1.

2) Submit this operation to the thread pool and wait for it to complete,

3) Thread pool needs to check whether it has any free threads in the pool
available to perform this operation.

If not, and the count of threads that are CPU-bound (~aren't sleeping on
some I/O operation) is less than the number of logical CPUs in the system
the thread pool needs to spawn a new thread since there's some CPU capacity
available,

4) The operation needs to be dispatched to the actual execution thread,

5) The execution thread needs to figure out which operation it needs to
actually do, fetch the necessary parameters from the proper "Operation"
structure, maybe take the necessary locks, before it can actually perform
the requested operation,

6) The execution thread needs to serialize (write) the operation result
back into some "OperationResult" structure, like "OperationGetVCPURegsResult",

7) The execution thread needs to submit this result back to the requester,

8) The thread pool needs to decide whether to keep this (now idle) execution
thread in the pool as a reserve thread or terminate it immediately,

9) The requester needs to be resumed somehow (returned from wait) now that
the operation it requested is complete,

10) The requester needs the fetch the operation results from the proper
"OperationResult" structure and decode them accordingly.


As you can see, that's *a lot* of extra code that needs to be maintained
for just a single operation type.

>>
>>> I know I suggested that.. but that's comparing to what I read in the even
>>> earlier version, and sorry I wasn't able to suggest something better at
>>> that time because I simply thought less.
>>>
>>> As I mentioned in the other reply elsewhere, I think we should firstly have
>>> these threads ready to take data at the start of migration, so that it'll
>>> work when someone wants to add vfio iteration support.  Then the jobs
>>> (mostly what vfio_save_complete_precopy_async_thread() does now) can be
>>> enqueued into the thread pools.
>>
>> I'm not sure that we can get way with using fewer threads than devices
>> as these devices might not support AIO reads from their migration file
>> descriptor.
> 
> It doesn't need to use AIO reads - I'll be happy if the thread model can be
> generic, VFIO can still enqueue a task that does blocking reads.
> 
> It can take a lot of time, but it's fine: others who like to enqueue too
> and see all threads busy, they should simply block there and waiting for
> the worker threads to be freed again.  It's the same when there's no
> migration worker threads as it means the read() will block the main
> migration thread.

Oh no, waiting for another device blocking read to complete before
scheduling another device blocking read is surely going to negatively
impact the performance.

For best performance we need to maximize parallelism - that means
reading (and loading) all the VFIO devices present in parallel.

The whole point of having per-device threads is for the whole operation
to be I/O bound but never CPU bound on a reasonably fast machine - and
especially not number-of-threads-in-pool bound.

> Now we can have multiple worker threads doing things concurrently if
> possible (some of them may not, especially when BQL will be required, but
> that's a separate thing, and many device save()s may not need BQL, and when
> it needs we can take it in the enqueued tasks).
> 
>>
>> mlx5 devices, for example, seems to support only poll()ed / non-blocking
>> reads at best - with unknown performance in comparison with issuing
>> blocking reads from dedicated threads.
>>
>> On the other hand, handling a single device from multiple threads in
>> parallel is generally not possible due to difficulty of establishing in
>> which order the buffers were read.
>>
>> And if we need a per-VFIO device thread anyway then using a thread pool
>> doesn't help much - but brings extra complexity.
>>
>> In terms of starting the loading thread earlier to load also VM live
>> phase data it looks like a small change to the code so it shouldn't be
>> a problem.
> 
> That's good to know.  Please still consider a generic thread model and see
> what that would also work for your VFIO use case.
> 
> If you see what thread-pool.c did right now is it'll dynamically create
> threads on the fly.  I think that's something we can do too but just apply
> an upper limit to the thread numbers.

We have an upper limit on the count of saving threads already - it's the
count of VFIO devices in the VM.

The API in util/thread-pool.c is very basic and basically only allows
submitting either AIO operations or generic function call operation
but still within some AioContext.

There's almost none of the operation execution logic I described above -
all of these would need to be written and maintained.

>>
>>> It's better to create the thread pool owned by migration, rather than
>>> threads owned by VFIO, because it also paves way for non-VFIO device state
>>> save()s, as I mentioned also above on the multifd packet header.  Maybe we
>>> can have a flag in the packet header saying "this is device xxx's state,
>>> just load it".
>>
>> I think the same could be done by simply implementing these hooks in other
>> device types than VFIO, right?
>>
>> And if we notice that these implementations share a bit of code then we
>> can think about making a common helper library out of this code.
>>
>> After, all that's just an implementation detail that does not impact
>> the underlying bit stream protocol.
> 
> You're correct.
> 
> However, it still affects a few things.
> 
> Firstly, it may mean that we may not even need those two extra vmstate
> hooks: the enqueue can happen already with save_state() if the migration
> worker model exists.
> 
> So instead of this:
> 
>          vfio_save_state():
>          if (migration->multifd_transfer) {
>                  /* Emit dummy NOP data */
>                  qemu_put_be64(f, VFIO_MIG_FLAG_END_OF_STATE);
>                  return;
>          }
> 
> We can already do:
> 
>          if (migration->multifd_transfer) {
>                  // enqueue task to load state for this vfio device
>                  ...
>                  return;
>          }
> 
> IMHO it'll be much cleaner in VFIO code, and much cleaner too for migration
> code.

The save_state hook is executed too late - only after all iterable
hooks have already transferred all their data.

We want to start saving this device state as early as possible to not
have to wait for any other device to transfer its data first.

That's why the code introduces save_live_complete_precopy_begin hook
that's guaranteed to be the very first hook called during switchover
phase device state saving.

> Another (possibly personal) reason is, I will not dare to touch VFIO code
> too much to do such a refactoring later.  I simply don't have the VFIO
> devices around and I won't be able to test.  So comparing to other things,
> I hope VFIO stuff can land more stable than others because I am not
> confident at least myself to clean it.

That's a fair request, will keep this on mind.

> I simply also don't like random threads floating around, considering that
> how we already have slightly a mess with migration on other reasons (we can
> still have random TLS threads floating around, I think... and they can
> cause very hard to debug issues). I feel shaky to maintain it when any
> device can also start to create whatever threads they can during migration.

The threads themselves aren't very expensive as long as their number
is kept within reasonable bounds.

4 additional threads (present only during active migration operation)
with 4 VFIO devices is really not a lot.

(..)
> 
> Thanks,
> 

Thanks,
Maciej


