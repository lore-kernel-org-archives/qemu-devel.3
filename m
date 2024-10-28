Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3956D13570
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2024 07:43:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5KPB-0006BA-Uc; Mon, 28 Oct 2024 03:43:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1t5KOv-0006AS-Fb
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 03:42:57 -0400
Received: from mail-oi1-x236.google.com ([2607:f8b0:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1t5KOq-0005XS-Pl
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 03:42:57 -0400
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-3e6010a3bbfso2302395b6e.2
 for <qemu-devel@nongnu.org>; Mon, 28 Oct 2024 00:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1730101371; x=1730706171;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FO5MvA6Sq/yZZq8wbgS7l9gg98Zi7tWGBeZ/nI52374=;
 b=zol6GYKSpojiAsqm3tE1ACvi+PYwc/umRZl71ihNKpvyi1XymfPGCDtteFrVMsRDh6
 X6JrfAUz3vfSzyxX2R0XDugMlduyZMSaEXhYnqC1RkuFoP60Pa9CDj6uFwPCJY6IDvm3
 63OSAu3UJteOduaugo6r+Pyi+GMhhWZGajZpbfY3VwZVNoUQ44FuaVLBom9MNysQpOg+
 aU9mcF5tHPNz2u8kRzwlrfoBkUQEzblMDB+WATftVvAhDc1baLo2QdCvPnUwmIlGJZhl
 jiED41q56CKQR/7ORAbseAH2sYPf90C1Na4N+A0QcGNRG8fgayIKuzfJAULHd9rULjp/
 SFjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730101371; x=1730706171;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FO5MvA6Sq/yZZq8wbgS7l9gg98Zi7tWGBeZ/nI52374=;
 b=L4eqo+FC3USpCKA4wP1WnPR5zpsXQa9GZ4X2aEEOdptyRJEM1fnaR85P8Jt4NQG5Td
 xx8/A20t54VkwF+VZOBn6I3ltQvX+lItS4HhzcOnHGnsdlNHdqHTRSsAd37QxP6pLPzd
 Jcl6bbMSPOvzNLuQQPpog+nEHw5TSnWus2okQUfp6dfjLHyCZhPQBiL4PFlkoZTyMSd5
 sHI7T64xfX3a4F9gMRFjf54amhBv+kPf5+hLWo7MTFbxmuhsWtpxCpCmov2BnYXjgNIz
 z9Hi1eIGrRz24l+Mgt5icK5vFsQLLeKQs+sPsWi5Fg2fgh3h1UFQD1uYGuh7nJ4eN1Ek
 vxWw==
X-Gm-Message-State: AOJu0YxZsDSkiuTJhmul4ouj5MH6hEHlvI/O1k90Xc3BcSU6eQ3SYM7j
 b3aVRwTvdJe3D/6+9sx9liv6rS/sVz5ajWf0j2a5dJnXVJMVAodjOIp4j3SthnQ=
X-Google-Smtp-Source: AGHT+IGAF1esX/cDFqFPIpRpsu4aObv4fMYYJEgcNUp4YAmYCuLCu4wJKNb8S/pGHv8qmX77TMowfA==
X-Received: by 2002:a05:6808:6490:b0:3e6:3d39:2b94 with SMTP id
 5614622812f47-3e63d392e66mr3570827b6e.5.1730101371098; 
 Mon, 28 Oct 2024 00:42:51 -0700 (PDT)
Received: from [157.82.207.107] ([157.82.207.107])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7edc8660ddesm5122257a12.16.2024.10.28.00.42.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Oct 2024 00:42:50 -0700 (PDT)
Message-ID: <6a989d04-6416-4bd9-98ac-e1230a1095a9@daynix.com>
Date: Mon, 28 Oct 2024 16:42:42 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 02/15] hw/display/apple-gfx: Introduce
 ParavirtualizedGraphics.Framework support
To: Phil Dennis-Jordan <phil@philjordan.eu>
Cc: qemu-devel@nongnu.org, agraf@csgraf.de, peter.maydell@linaro.org,
 pbonzini@redhat.com, rad@semihalf.com, quic_llindhol@quicinc.com,
 marcin.juszkiewicz@linaro.org, stefanha@redhat.com, mst@redhat.com,
 slp@redhat.com, richard.henderson@linaro.org, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, gaosong@loongson.cn, jiaxun.yang@flygoat.com,
 chenhuacai@kernel.org, kwolf@redhat.com, hreitz@redhat.com,
 philmd@linaro.org, shorne@gmail.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, bmeng.cn@gmail.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, jcmvbkbc@gmail.com,
 marcandre.lureau@redhat.com, berrange@redhat.com, qemu-arm@nongnu.org,
 qemu-block@nongnu.org, qemu-riscv@nongnu.org,
 Alexander Graf <graf@amazon.com>
References: <20241024102813.9855-1-phil@philjordan.eu>
 <20241024102813.9855-3-phil@philjordan.eu>
 <9e310d5e-ab73-47b9-b9ed-5a16d4db3fb9@daynix.com>
 <CAAibmn0NA+K63OvrsBpN1HivndyZo-fgeLwzY8AVE4hPrQR26w@mail.gmail.com>
 <dd2aae75-348d-44ad-bbd9-5d45aad15bc6@daynix.com>
 <CAAibmn1z+7yizwH8DogfcCWOWzA8Ox6e=p+Hc1pu-CS4SjAirg@mail.gmail.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <CAAibmn1z+7yizwH8DogfcCWOWzA8Ox6e=p+Hc1pu-CS4SjAirg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::236;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-oi1-x236.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On 2024/10/26 19:24, Phil Dennis-Jordan wrote:
> 
> 
> On Sat, 26 Oct 2024 at 06:40, Akihiko Odaki <akihiko.odaki@daynix.com 
> <mailto:akihiko.odaki@daynix.com>> wrote:
> 
>     On 2024/10/26 4:43, Phil Dennis-Jordan wrote:
>      >
>      >
>      > On Fri, 25 Oct 2024 at 08:03, Akihiko Odaki
>     <akihiko.odaki@daynix.com <mailto:akihiko.odaki@daynix.com>
>      > <mailto:akihiko.odaki@daynix.com
>     <mailto:akihiko.odaki@daynix.com>>> wrote:
>      >
>      >     On 2024/10/24 19:28, Phil Dennis-Jordan wrote:
>      >      > +    /* For running PVG memory-mapping requests in the AIO
>     context */
>      >      > +    QemuCond job_cond;
>      >      > +    QemuMutex job_mutex;
>      >
>      >     Use: QemuEvent
>      >
>      >
>      > Hmm. I think if we were to use that, we would need to create a new
>      > QemuEvent for every job and destroy it afterward, which seems
>     expensive.
>      > We can't rule out multiple concurrent jobs being submitted, and the
>      > QemuEvent system only supports a single producer as far as I can
>     tell.
>      >
>      > You can probably sort of hack around it with just one QemuEvent by
>      > putting the qemu_event_wait into a loop and turning the job.done
>     flag
>      > into an atomic (because it would now need to be checked outside the
>      > lock) but this all seems unnecessarily complicated considering the
>      > QemuEvent uses the same mechanism QemuCond/QemuMutex internally
>     on macOS
>      > (the only platform relevant here), except we can use it as
>     intended with
>      > QemuCond/QemuMutex rather than having to work against the
>     abstraction.
> 
>     I don't think it's going to be used concurrently. It would be difficult
>     to reason even for the framework if it performs memory
>     unmapping/mapping/reading operations concurrently.
> 
> 
> I've just performed a very quick test by wrapping the job submission/ 
> wait in the 2 mapMemory callbacks and the 1 readMemory callback with 
> atomic counters and logging whenever a counter went above 1.
> 
>   * Overall, concurrent callbacks across all types were common (many per 
> second when the VM is busy). It's not exactly a "thundering herd" (I 
> never saw >2) but it's probably not a bad idea to use a separate 
> condition variable for each job type. (task map, surface map, memory read)
>   * While I did not observe any concurrent memory mapping operations 
> *within* a type of memory map (2 task mappings or 2 surface mappings) I 
> did see very occasional concurrent memory *read* callbacks. These would, 
> as far as I can tell, not be safe with QemuEvents, unless we placed the 
> event inside the job struct and init/destroyed it on every callback 
> (which seems like excessive overhead).

I think we can tolerate that overhead. init/destroy essentially sets the 
fields in the data structure and I estimate its total size is about 100 
bytes. It is probably better than waking an irrelevant thread up. I also 
hope that keeps the code simple; it's not worthwhile adding code to 
optimize this.

> 
> My recommendation would be to split it up into 3 pairs of mutex/cond; 
> this will almost entirely remove any contention, but continue to be safe 
> for when it does occur. I don't think QemuEvent is a realistic option 
> (too tricky to get right) for the observed-concurrent readMemory 
> callback. I'm nervous about assuming the mapMemory callbacks will NEVER 
> be called concurrently, but at a push I'll acquiesce to switching those 
> to QemuEvent in the absence of evidence of concurrency.> >     PGDevice.h also notes
>     raiseInterrupt needs to be thread-safe while it doesn't make such notes
>     for memory operations. This actually makes sense.
> 
>     If it's ever going to be used concurrently, it's better to have
>     QemuEvent for each job to avoid the thundering herd problem.
 > >      >
>      >      > +
>      >      > +    dispatch_queue_t render_queue;
>      >      > +    /* The following fields should only be accessed from
>     the BQL: */
>      >
>      >     Perhaps it may be better to document fields that can be accessed
>      >     *without* the BQL; most things in QEMU implicitly require the
>     BQL.
>      >
>      >      > +    bool gfx_update_requested;
>      >      > +    bool new_frame_ready;
>      >      > +    bool using_managed_texture_storage;
>      >      > +} AppleGFXState;
>      >      > +
>      >      > +void apple_gfx_common_init(Object *obj, AppleGFXState *s,
>     const
>      >     char* obj_name);
>      >      > +void apple_gfx_common_realize(AppleGFXState *s,
>      >     PGDeviceDescriptor *desc,
>      >      > +                              Error **errp);
>      >      > +uintptr_t apple_gfx_host_address_for_gpa_range(uint64_t
>      >     guest_physical,
>      >      > +                                               uint64_t
>     length,
>      >     bool read_only);
>      >      > +void apple_gfx_await_bh_job(AppleGFXState *s, bool
>     *job_done_flag);
>      >      > +
>      >      > +#endif
>      >      > +
>      >      > diff --git a/hw/display/apple-gfx.m b/hw/display/apple-gfx.m
>      >      > new file mode 100644
>      >      > index 00000000000..46be9957f69
>      >      > --- /dev/null
>      >      > +++ b/hw/display/apple-gfx.m
>      >      > @@ -0,0 +1,713 @@
>      >      > +/*
>      >      > + * QEMU Apple ParavirtualizedGraphics.framework device
>      >      > + *
>      >      > + * Copyright © 2023 Amazon.com, Inc. or its affiliates. All
>      >     Rights Reserved.
>      >      > + *
>      >      > + * This work is licensed under the terms of the GNU GPL,
>     version
>      >     2 or later.
>      >      > + * See the COPYING file in the top-level directory.
>      >      > + *
>      >      > + * ParavirtualizedGraphics.framework is a set of
>     libraries that
>      >     macOS provides
>      >      > + * which implements 3d graphics passthrough to the host
>     as well as a
>      >      > + * proprietary guest communication channel to drive it. This
>      >     device model
>      >      > + * implements support to drive that library from within QEMU.
>      >      > + */
>      >      > +
>      >      > +#include "qemu/osdep.h"
>      >      > +#import <ParavirtualizedGraphics/ParavirtualizedGraphics.h>
>      >      > +#include <mach/mach_vm.h>
>      >      > +#include "apple-gfx.h"
>      >      > +#include "trace.h"
>      >      > +#include "qemu-main.h"
>      >      > +#include "exec/address-spaces.h"
>      >      > +#include "migration/blocker.h"
>      >      > +#include "monitor/monitor.h"
>      >      > +#include "qemu/main-loop.h"
>      >      > +#include "qemu/cutils.h"
>      >      > +#include "qemu/log.h"
>      >      > +#include "qapi/visitor.h"
>      >      > +#include "qapi/error.h"
>      >      > +#include "ui/console.h"
>      >      > +
>      >      > +static const PGDisplayCoord_t apple_gfx_modes[] = {
>      >      > +    { .x = 1440, .y = 1080 },
>      >      > +    { .x = 1280, .y = 1024 },
>      >      > +};
>      >      > +
>      >      > +/* This implements a type defined in
>     <ParavirtualizedGraphics/
>      >     PGDevice.h>
>      >      > + * which is opaque from the framework's point of view.
>     Typedef
>      >     PGTask_t already
>      >      > + * exists in the framework headers. */
>      >      > +struct PGTask_s {
>      >      > +    QTAILQ_ENTRY(PGTask_s) node;
>      >      > +    mach_vm_address_t address;
>      >      > +    uint64_t len;
>      >      > +};
>      >      > +
>      >      > +static Error *apple_gfx_mig_blocker;
>      >
>      >     This does not have to be a static variable.
>      >
>      >
>      > Hmm, the first 5 or so examples of migration blockers in other
>     devices
>      > etc. I could find were all declared in this way. What are you
>     suggesting
>      > as the alternative? And why not use the same pattern as in most
>     of the
>      > rest of the code base?
> 
>     I was wrong. This is better to be a static variable to ensure we won't
>     add the same blocker in case we have two device instances.
> 
>      >
>      >      > +
>      >      > +static void
>     apple_gfx_render_frame_completed(AppleGFXState *s,
>      >      > +                                             uint32_t width,
>      >     uint32_t height);
>      >      > +
>      >      > +static inline dispatch_queue_t get_background_queue(void)
>      >
>      >     Don't add inline. The only effect for modern compilers of
>     inline is to
>      >     suppress the unused function warnings.
>      >
>      >      > +{
>      >      > +    return
>      >     dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
>      >      > +}
>      >      > +
>      >      > +static PGTask_t *apple_gfx_new_task(AppleGFXState *s,
>     uint64_t len)
>      >      > +{
>      >      > +    mach_vm_address_t task_mem;
>      >      > +    PGTask_t *task;
>      >      > +    kern_return_t r;
>      >      > +
>      >      > +    r = mach_vm_allocate(mach_task_self(), &task_mem, len,
>      >     VM_FLAGS_ANYWHERE);
>      >      > +    if (r != KERN_SUCCESS || task_mem == 0) {
>      >
>      >     Let's remove the check for task_mem == 0. We have no reason to
>      >     reject it
>      >     if the platform insists it allocated a memory at address 0 though
>      >     such a
>      >     situation should never happen in practice.
>      >
>      >      > +        return NULL;
>      >      > +    }
>      >      > +
>      >      > +    task = g_new0(PGTask_t, 1);
>      >      > +
>      >      > +    task->address = task_mem;
>      >      > +    task->len = len;
>      >      > +    QTAILQ_INSERT_TAIL(&s->tasks, task, node);
>      >      > +
>      >      > +    return task;
>      >      > +}
>      >      > +
>      >      > +typedef struct AppleGFXIOJob {
>      >      > +    AppleGFXState *state;
>      >      > +    uint64_t offset;
>      >      > +    uint64_t value;
>      >      > +    bool completed;
>      >      > +} AppleGFXIOJob;
>      >      > +
>      >      > +static void apple_gfx_do_read(void *opaque)
>      >      > +{
>      >      > +    AppleGFXIOJob *job = opaque;
>      >      > +    job->value = [job->state->pgdev mmioReadAtOffset:job-
>      >offset];
>      >      > +    qatomic_set(&job->completed, true);
>      >      > +    aio_wait_kick();
>      >      > +}
>      >      > +
>      >      > +static uint64_t apple_gfx_read(void *opaque, hwaddr offset,
>      >     unsigned size)
>      >      > +{
>      >      > +    AppleGFXIOJob job = {
>      >      > +        .state = opaque,
>      >      > +        .offset = offset,
>      >      > +        .completed = false,
>      >      > +    };
>      >      > +    AioContext *context = qemu_get_aio_context();
>      >      > +    dispatch_queue_t queue = get_background_queue();
>      >      > +
>      >      > +    dispatch_async_f(queue, &job, apple_gfx_do_read);
>      >      > +    AIO_WAIT_WHILE(context, !qatomic_read(&job.completed));
>      >      > +
>      >      > +    trace_apple_gfx_read(offset, job.value);
>      >      > +    return job.value;
>      >      > +}
>      >      > +
>      >      > +static void apple_gfx_do_write(void *opaque)
>      >      > +{
>      >      > +    AppleGFXIOJob *job = opaque;
>      >      > +    [job->state->pgdev mmioWriteAtOffset:job->offset
>     value:job-
>      >      >value];
>      >      > +    qatomic_set(&job->completed, true);
>      >      > +    aio_wait_kick();
>      >      > +}
>      >      > +
>      >      > +static void apple_gfx_write(void *opaque, hwaddr offset,
>      >     uint64_t val,
>      >      > +                            unsigned size)
>      >      > +{
>      >      > +    /* The methods mmioReadAtOffset: and especially
>      >     mmioWriteAtOffset: can
>      >      > +     * trigger and block on operations on other dispatch
>     queues,
>      >     which in turn
>      >      > +     * may call back out on one or more of the callback
>     blocks.
>      >     For this reason,
>      >      > +     * and as we are holding the BQL, we invoke the I/O
>     methods
>      >     on a pool
>      >      > +     * thread and handle AIO tasks while we wait. Any work in
>      >     the callbacks
>      >      > +     * requiring the BQL will in turn schedule BHs which this
>      >     thread will
>      >      > +     * process while waiting. */
>      >      > +    AppleGFXIOJob job = {
>      >      > +        .state = opaque,
>      >      > +        .offset = offset,
>      >      > +        .value = val,
>      >      > +        .completed = false,
>      >      > +    };
>      >      > +    AioContext *context = qemu_get_current_aio_context();
>      >      > +    dispatch_queue_t queue = get_background_queue();
>      >      > +
>      >      > +    dispatch_async_f(queue, &job, apple_gfx_do_write);
>      >      > +    AIO_WAIT_WHILE(context, !qatomic_read(&job.completed));
>      >      > +
>      >      > +    trace_apple_gfx_write(offset, val);
>      >      > +}
>      >      > +
>      >      > +static const MemoryRegionOps apple_gfx_ops = {
>      >      > +    .read = apple_gfx_read,
>      >      > +    .write = apple_gfx_write,
>      >      > +    .endianness = DEVICE_LITTLE_ENDIAN,
>      >      > +    .valid = {
>      >      > +        .min_access_size = 4,
>      >      > +        .max_access_size = 8,
>      >      > +    },
>      >      > +    .impl = {
>      >      > +        .min_access_size = 4,
>      >      > +        .max_access_size = 4,
>      >      > +    },
>      >      > +};
>      >      > +
>      >      > +static void
>     apple_gfx_render_new_frame_bql_unlock(AppleGFXState *s)
>      >      > +{
>      >      > +    BOOL r;
>      >      > +    uint32_t width = surface_width(s->surface);
>      >      > +    uint32_t height = surface_height(s->surface);
>      >      > +    MTLRegion region = MTLRegionMake2D(0, 0, width, height);
>      >      > +    id<MTLCommandBuffer> command_buffer = [s->mtl_queue
>      >     commandBuffer];
>      >      > +    id<MTLTexture> texture = s->texture;
>      >      > +
>      >      > +    assert(bql_locked());
>      >      > +    [texture retain];
>      >      > +
>      >      > +    bql_unlock();
>      >      > +
>      >      > +    /* This is not safe to call from the BQL due to PVG-
>     internal
>      >     locks causing
>      >      > +     * deadlocks. */
>      >      > +    r = [s->pgdisp
>     encodeCurrentFrameToCommandBuffer:command_buffer
>      >      > +                                             texture:texture
>      >      > +                                              region:region];
>      >      > +    if (!r) {
>      >      > +        [texture release];
>      >      > +        bql_lock();
>      >      > +        --s->pending_frames;
>      >      > +        bql_unlock();
>      >      > +        qemu_log_mask(LOG_GUEST_ERROR,
>      >     "apple_gfx_render_new_frame_bql_unlock: "
>      >
>      >     Use: __func__
>      >
>      >      > +
>      >     "encodeCurrentFrameToCommandBuffer:texture:region: failed\n");
>      >      > +        return;
>      >      > +    }
>      >      > +
>      >      > +    if (s->using_managed_texture_storage) {
>      >      > +        /* "Managed" textures exist in both VRAM and RAM and
>      >     must be synced. */
>      >      > +        id<MTLBlitCommandEncoder> blit = [command_buffer
>      >     blitCommandEncoder];
>      >      > +        [blit synchronizeResource:texture];
>      >      > +        [blit endEncoding];
>      >      > +    }
>      >      > +    [texture release];
>      >      > +    [command_buffer addCompletedHandler:
>      >      > +        ^(id<MTLCommandBuffer> cb)
>      >      > +        {
>      >      > +            dispatch_async(s->render_queue, ^{
>      >      > +                apple_gfx_render_frame_completed(s,
>     width, height);
>      >      > +            });
>      >      > +        }];
>      >      > +    [command_buffer commit];
>      >      > +}
>      >      > +
>      >      > +static void copy_mtl_texture_to_surface_mem(id<MTLTexture>
>      >     texture, void *vram)
>      >      > +{
>      >      > +    /* TODO: Skip this entirely on a pure Metal or headless/
>      >     guest-only
>      >      > +     * rendering path, else use a blit command encoder? Needs
>      >     careful
>      >      > +     * (double?) buffering design. */
>      >      > +    size_t width = texture.width, height = texture.height;
>      >      > +    MTLRegion region = MTLRegionMake2D(0, 0, width, height);
>      >      > +    [texture getBytes:vram
>      >      > +          bytesPerRow:(width * 4)
>      >      > +        bytesPerImage:(width * height * 4)
>      >      > +           fromRegion:region
>      >      > +          mipmapLevel:0
>      >      > +                slice:0];
>      >      > +}copy_mtl_texture_to_surface_mem
>      >      > +
>      >      > +static void
>     apple_gfx_render_frame_completed(AppleGFXState *s,
>      >      > +                                             uint32_t width,
>      >     uint32_t height)
>      >      > +{
>      >      > +    bql_lock();
>      >      > +    --s->pending_frames;
>      >      > +    assert(s->pending_frames >= 0);
>      >      > +
>      >      > +    /* Only update display if mode hasn't changed since we
>      >     started rendering. */
>      >      > +    if (width == surface_width(s->surface) &&
>      >      > +        height == surface_height(s->surface)) {
>      >      > +        copy_mtl_texture_to_surface_mem(s->texture, s->vram);
>      >      > +        if (s->gfx_update_requested) {
>      >      > +            s->gfx_update_requested = false;
>      >      > +            dpy_gfx_update_full(s->con);
>      >      > +            graphic_hw_update_done(s->con);
>      >      > +            s->new_frame_ready = false;
>      >      > +        } else {
>      >      > +            s->new_frame_ready = true;
>      >      > +        }
>      >      > +    }
>      >      > +    if (s->pending_frames > 0) {
>      >      > +        apple_gfx_render_new_frame_bql_unlock(s);
>      >      > +    } else {
>      >      > +        bql_unlock();
>      >      > +    }
>      >      > +}
>      >      > +
>      >      > +static void apple_gfx_fb_update_display(void *opaque)
>      >      > +{
>      >      > +    AppleGFXState *s = opaque;
>      >      > +
>      >      > +    assert(bql_locked());
>      >      > +    if (s->new_frame_ready) {
>      >      > +        dpy_gfx_update_full(s->con);
>      >      > +        s->new_frame_ready = false;
>      >      > +        graphic_hw_update_done(s->con);
>      >      > +    } else if (s->pending_frames > 0) {
>      >      > +        s->gfx_update_requested = true;
>      >      > +    } else {
>      >      > +        graphic_hw_update_done(s->con);
>      >      > +    }
>      >      > +}
>      >      > +
>      >      > +static const GraphicHwOps apple_gfx_fb_ops = {
>      >      > +    .gfx_update = apple_gfx_fb_update_display,
>      >      > +    .gfx_update_async = true,
>      >      > +};
>      >      > +
>      >      > +static void update_cursor(AppleGFXState *s)
>      >      > +{
>      >      > +    assert(bql_locked());
>      >      > +    dpy_mouse_set(s->con, s->pgdisp.cursorPosition.x,
>      >      > +                  s->pgdisp.cursorPosition.y, s-
>      >cursor_show);
>      >      > +}
>      >      > +
>      >      > +static void set_mode(AppleGFXState *s, uint32_t width,
>     uint32_t
>      >     height)
>      >      > +{
>      >      > +    MTLTextureDescriptor *textureDescriptor;
>      >      > +
>      >      > +    if (s->surface &&
>      >      > +        width == surface_width(s->surface) &&
>      >      > +        height == surface_height(s->surface)) {
>      >      > +        return;
>      >      > +    }
>      >      > +
>      >      > +    g_free(s->vram);
>      >      > +    [s->texture release];
>      >      > +
>      >      > +    s->vram = g_malloc0_n(width * height, 4);
>      >      > +    s->surface = qemu_create_displaysurface_from(width,
>     height,
>      >     PIXMAN_LE_a8r8g8b8,
>      >      > +                                                 width *
>     4, s-
>      >      >vram);> +> +    @autoreleasepool {
>      >      > +        textureDescriptor =
>      >      > +            [MTLTextureDescriptor
>      >      > +
>      >     texture2DDescriptorWithPixelFormat:MTLPixelFormatBGRA8Unorm
>      >      > +                                             width:width
>      >      > +                                            height:height
>      >      > +                                         mipmapped:NO];
>      >      > +        textureDescriptor.usage = s-
>      >pgdisp.minimumTextureUsage;
>      >      > +        s->texture = [s->mtl
>      >     newTextureWithDescriptor:textureDescriptor];
>      >
>      >
>      >     What about creating pixman_image_t from s-
>      >texture.buffer.contents?
>      >     This
>      >     should save memory usage by removing the duplication of texture.
>      >
>      >
>      > We need explicit control over when the GPU vs when the CPU may
>     access
>      > the texture - only one of them may access them at a time. As far
>     as I
>      > can tell, we can't control when the rest of Qemu might access the
>      > pixman_image used in the console surface?
> 
>     You are right; we need to have duplicate buffers. We can still avoid
>     copying by using two MTLTextures for double-buffering instead of having
>     a MTLTexture and a pixman_image and copying between them for
>     MTLStorageModeManaged.
> 
> Do I understand correctly that you intend to swap the surface->image on 
> every frame, or even the surface->image->data? If so, it's my 
> understanding from reading the source of a bunch of UI implementations a 
> few weeks ago that this is neither supported nor safe, as some 
> implementations take long-lived references to these internal data 
> structures until a dpy_gfx_switch callback. And the implementations for 
> those callbacks are in turn very expensive in some cases. This is why my 
> conclusion in the v4 thread was that double-buffering was infeasible 
> with the current architecture.

By the way, can't we take the BQL after 
encodeCurrentFrameToCommandBuffer and keep it until the completion 
handler? PVG requires the BQL unlocked for forward progress due to the 
bottom half usage in callbacks, but Metal doesn't.

> 
>      >
>      >      > +    }
>      >      > +
>      >      > +    s->using_managed_texture_storage =
>      >      > +        (s->texture.storageMode == MTLStorageModeManaged);
>      >      > +    dpy_gfx_replace_surface(s->con, s->surface);
>      >      > +}
>      >      > +
>      >      > +static void create_fb(AppleGFXState *s)
>      >      > +{
>      >      > +    s->con = graphic_console_init(NULL, 0,
>     &apple_gfx_fb_ops, s);
>      >      > +    set_mode(s, 1440, 1080);
>      >      > +
>      >      > +    s->cursor_show = true;
>      >      > +}
>      >      > +
>      >      > +static size_t apple_gfx_get_default_mmio_range_size(void)
>      >      > +{
>      >      > +    size_t mmio_range_size;
>      >      > +    @autoreleasepool {
>      >      > +        PGDeviceDescriptor *desc = [PGDeviceDescriptor new];
>      >      > +        mmio_range_size = desc.mmioLength;
>      >      > +        [desc release];
>      >      > +    }
>      >      > +    return mmio_range_size;
>      >      > +}
>      >      > +
>      >      > +void apple_gfx_common_init(Object *obj, AppleGFXState *s,
>     const
>      >     char* obj_name)
>      >      > +{
>      >      > +    size_t mmio_range_size =
>      >     apple_gfx_get_default_mmio_range_size();
>      >      > +
>      >      > +    trace_apple_gfx_common_init(obj_name, mmio_range_size);
>      >      > +    memory_region_init_io(&s->iomem_gfx, obj,
>     &apple_gfx_ops, s,
>      >     obj_name,
>      >      > +                          mmio_range_size);
>      >      > +
>      >      > +    /* TODO: PVG framework supports serialising device state:
>      >     integrate it! */
>      >      > +}
>      >      > +
>      >      > +typedef struct AppleGFXMapMemoryJob {
>      >      > +    AppleGFXState *state;
>      >      > +    PGTask_t *task;
>      >      > +    uint64_t virtual_offset;
>      >      > +    PGPhysicalMemoryRange_t *ranges;
>      >      > +    uint32_t range_count;
>      >      > +    bool read_only;
>      >      > +    bool success;
>      >      > +    bool done;
>      >      > +} AppleGFXMapMemoryJob;
>      >      > +
>      >      > +uintptr_t apple_gfx_host_address_for_gpa_range(uint64_t
>      >     guest_physical,
>      >      > +                                               uint64_t
>     length,
>      >     bool read_only)
>      >      > +{
>      >      > +    MemoryRegion *ram_region;
>      >      > +    uintptr_t host_address;
>      >      > +    hwaddr ram_region_offset = 0;
>      >      > +    hwaddr ram_region_length = length;
>      >      > +
>      >      > +    ram_region =
>     address_space_translate(&address_space_memory,
>      >      > +                                         guest_physical,
>      >      > +                                         &ram_region_offset,
>      >      > +                                       
>       &ram_region_length, !
>      >     read_only,
>      >      > +                                       
>       MEMTXATTRS_UNSPECIFIED);
>      >
>      >     Call memory_region_ref() so that it won't go away.
>      >
>      >      > +
>      >      > +    if (!ram_region || ram_region_length < length ||
>      >      > +        !memory_access_is_direct(ram_region, !read_only)) {
>      >      > +        return 0;
>      >      > +    }
>      >      > +
>      >      > +    host_address =
>      >     (mach_vm_address_t)memory_region_get_ram_ptr(ram_region);
>      >
>      >     host_address is typed as uintptr_t, not mach_vm_address_t.
>      >
>      >      > +    if (host_address == 0) {
>      >      > +        return 0;
>      >      > +    }
>      >      > +    host_address += ram_region_offset;
>      >      > +
>      >      > +    return host_address;
>      >      > +}
>      >      > +
>      >      > +static void apple_gfx_map_memory(void *opaque)
>      >      > +{
>      >      > +    AppleGFXMapMemoryJob *job = opaque;
>      >      > +    AppleGFXState *s = job->state;
>      >      > +    PGTask_t *task                  = job->task;
>      >      > +    uint32_t range_count            = job->range_count;
>      >      > +    uint64_t virtual_offset         = job->virtual_offset;
>      >      > +    PGPhysicalMemoryRange_t *ranges = job->ranges;
>      >      > +    bool read_only                  = job->read_only;
>      >      > +    kern_return_t r;
>      >      > +    mach_vm_address_t target, source;
>      >      > +    vm_prot_t cur_protection, max_protection;
>      >      > +    bool success = true;
>      >      > +
>      >      > +    g_assert(bql_locked());
>      >      > +
>      >      > +    trace_apple_gfx_map_memory(task, range_count,
>      >     virtual_offset, read_only);
>      >      > +    for (int i = 0; i < range_count; i++) {
>      >      > +        PGPhysicalMemoryRange_t *range = &ranges[i];
>      >      > +
>      >      > +        target = task->address + virtual_offset;
>      >      > +        virtual_offset += range->physicalLength;
>      >      > +
>      >      > +        trace_apple_gfx_map_memory_range(i, range-
>      >physicalAddress,
>      >      > +                                         range-
>      >physicalLength);
>      >      > +
>      >      > +        source = apple_gfx_host_address_for_gpa_range(range-
>      >      >physicalAddress,
>      >      > +                                                      range-
>      >      >physicalLength,
>      >      > +                                                     
>     read_only);
>      >      > +        if (source == 0) {
>      >      > +            success = false;
>      >      > +            continue;
>      >      > +        }
>      >      > +
>      >      > +        MemoryRegion* alt_mr = NULL;
>      >      > +        mach_vm_address_t alt_source =
>      >     (mach_vm_address_t)gpa2hva(&alt_mr, range->physicalAddress,
>     range-
>      >      >physicalLength, NULL);
>      >      > +        g_assert(alt_source == source);
>      >
>      >     Remove this; I guess this is for debugging.
>      >
>      >      > +
>      >      > +        cur_protection = 0;
>      >      > +        max_protection = 0;
>      >      > +        // Map guest RAM at range->physicalAddress into
>     PG task
>      >     memory range
>      >      > +        r = mach_vm_remap(mach_task_self(),
>      >      > +                          &target, range->physicalLength,
>      >     vm_page_size - 1,
>      >      > +                          VM_FLAGS_FIXED |
>     VM_FLAGS_OVERWRITE,
>      >      > +                          mach_task_self(),
>      >      > +                          source, false /* shared mapping, no
>      >     copy */,
>      >      > +                          &cur_protection, &max_protection,
>      >      > +                          VM_INHERIT_COPY);
>      >      > +        trace_apple_gfx_remap(r, source, target);
>      >      > +        g_assert(r == KERN_SUCCESS);
>      >      > +    }
>      >      > +
>      >      > +    qemu_mutex_lock(&s->job_mutex);
>      >      > +    job->success = success;
>      >      > +    job->done = true;
>      >      > +    qemu_cond_broadcast(&s->job_cond);
>      >      > +    qemu_mutex_unlock(&s->job_mutex);
>      >      > +}
>      >      > +
>      >      > +void apple_gfx_await_bh_job(AppleGFXState *s, bool
>     *job_done_flag)
>      >      > +{
>      >      > +    qemu_mutex_lock(&s->job_mutex);
>      >      > +    while (!*job_done_flag) {
>      >      > +        qemu_cond_wait(&s->job_cond, &s->job_mutex);
>      >      > +    }
>      >      > +    qemu_mutex_unlock(&s->job_mutex);
>      >      > +}
>      >      > +
>      >      > +typedef struct AppleGFXReadMemoryJob {
>      >      > +    AppleGFXState *s;
>      >      > +    hwaddr physical_address;
>      >      > +    uint64_t length;
>      >      > +    void *dst;
>      >      > +    bool done;
>      >      > +} AppleGFXReadMemoryJob;
>      >      > +
>      >      > +static void apple_gfx_do_read_memory(void *opaque)
>      >      > +{
>      >      > +    AppleGFXReadMemoryJob *job = opaque;
>      >      > +    AppleGFXState *s = job->s;
>      >      > +
>      >      > +    cpu_physical_memory_read(job->physical_address, job->dst,
>      >     job->length);
>      >
>      >     Use: dma_memory_read()
>      >
>      >      > +
>      >      > +    qemu_mutex_lock(&s->job_mutex);
>      >      > +    job->done = true;
>      >      > +    qemu_cond_broadcast(&s->job_cond);
>      >      > +    qemu_mutex_unlock(&s->job_mutex);
>      >      > +}
>      >      > +
>      >      > +static void apple_gfx_read_memory(AppleGFXState *s, hwaddr
>      >     physical_address,
>      >      > +                                  uint64_t length, void *dst)
>      >      > +{
>      >      > +    AppleGFXReadMemoryJob job = {
>      >      > +        s, physical_address, length, dst
>      >      > +    };
>      >      > +
>      >      > +    trace_apple_gfx_read_memory(physical_address, length,
>     dst);
>      >      > +
>      >      > +    /* Traversing the memory map requires RCU/BQL, so do
>     it in a
>      >     BH. */
>      >      > +    aio_bh_schedule_oneshot(qemu_get_aio_context(),
>      >     apple_gfx_do_read_memory,
>      >      > +                            &job);
>      >      > +    apple_gfx_await_bh_job(s, &job.done);
>      >      > +}
>      >      > +
>      >      > +static void
>      >     apple_gfx_register_task_mapping_handlers(AppleGFXState *s,
>      >      > +
>      >       PGDeviceDescriptor *desc)
>      >      > +{
>      >      > +    desc.createTask = ^(uint64_t vmSize, void * _Nullable *
>      >     _Nonnull baseAddress) {
>      >      > +        PGTask_t *task = apple_gfx_new_task(s, vmSize);
>      >      > +        *baseAddress = (void *)task->address;
>      >      > +        trace_apple_gfx_create_task(vmSize, *baseAddress);
>      >      > +        return task;
>      >      > +    };
>      >      > +
>      >      > +    desc.destroyTask = ^(PGTask_t * _Nonnull task) {
>      >      > +        trace_apple_gfx_destroy_task(task);
>      >      > +        QTAILQ_REMOVE(&s->tasks, task, node);
>      >      > +        mach_vm_deallocate(mach_task_self(), task->address,
>      >     task->len);
>      >      > +        g_free(task);
>      >      > +    };
>      >      > +
>      >      > +    desc.mapMemory = ^bool(PGTask_t * _Nonnull task, uint32_t
>      >     range_count,
>      >      > +                       uint64_t virtual_offset, bool
>     read_only,
>      >      > +                       PGPhysicalMemoryRange_t * _Nonnull
>     ranges) {
>      >      > +        AppleGFXMapMemoryJob job = {
>      >      > +            .state = s,
>      >      > +            .task = task, .ranges = ranges, .range_count =
>      >     range_count,
>      >      > +            .read_only = read_only, .virtual_offset =
>      >     virtual_offset,
>      >      > +            .done = false, .success = true,
>      >      > +        };
>      >      > +        if (range_count > 0) {
>      >      > +            aio_bh_schedule_oneshot(qemu_get_aio_context(),
>      >      > +                                    apple_gfx_map_memory,
>     &job);
>      >      > +            apple_gfx_await_bh_job(s, &job.done);
>      >      > +        }
>      >      > +        return job.success;
>      >      > +    };
>      >      > +
>      >      > +    desc.unmapMemory = ^bool(PGTask_t * _Nonnull task,
>     uint64_t
>      >     virtualOffset,
>      >      > +                         uint64_t length) {
>      >      > +        kern_return_t r;
>      >      > +        mach_vm_address_t range_address;
>      >      > +
>      >      > +        trace_apple_gfx_unmap_memory(task, virtualOffset,
>     length);
>      >      > +
>      >      > +        /* Replace task memory range with fresh pages,
>     undoing
>      >     the mapping
>      >      > +         * from guest RAM. */
>      >      > +        range_address = task->address + virtualOffset;
>      >      > +        r = mach_vm_allocate(mach_task_self(),
>     &range_address,
>      >     length,
>      >      > +                             VM_FLAGS_FIXED |
>     VM_FLAGS_OVERWRITE);
>      >      > +        g_assert(r == KERN_SUCCESS);error_setg
>      >
>      >     An extra error_setg
>      >
>      >      > +
>      >      > +        return true;
>      >      > +    };
>      >      > +
>      >      > +    desc.readMemory = ^bool(uint64_t physical_address,
>     uint64_t
>      >     length,
>      >      > +                            void * _Nonnull dst) {
>      >      > +        apple_gfx_read_memory(s, physical_address,
>     length, dst);
>      >      > +        return true;
>      >      > +    };
>      >      > +}
>      >      > +
>      >      > +static PGDisplayDescriptor
>      >     *apple_gfx_prepare_display_descriptor(AppleGFXState *s)
>      >      > +{
>      >      > +    PGDisplayDescriptor *disp_desc = [PGDisplayDescriptor
>     new];
>      >      > +
>      >      > + disp_desc.name <http://disp_desc.name> <http://
>     disp_desc.name <http://disp_desc.name>> = @"QEMU display";
>      >      > +    disp_desc.sizeInMillimeters = NSMakeSize(400.,
>     300.); /* A
>      >     20" display */
>      >      > +    disp_desc.queue = dispatch_get_main_queue();
>      >      > +    disp_desc.newFrameEventHandler = ^(void) {
>      >      > +        trace_apple_gfx_new_frame();
>      >      > +        dispatch_async(s->render_queue, ^{
>      >      > +            /* Drop frames if we get too far ahead. */
>      >      > +            bql_lock();
>      >      > +            if (s->pending_frames >= 2) {
>      >      > +                bql_unlock();
>      >      > +                return;
>      >      > +            }
>      >      > +            ++s->pending_frames;
>      >      > +            if (s->pending_frames > 1) {
>      >      > +                bql_unlock();
>      >      > +                return;
>      >      > +            }
>      >      > +            @autoreleasepool {
>      >      > +                apple_gfx_render_new_frame_bql_unlock(s);
>      >      > +            }
>      >      > +        });
>      >      > +    };
>      >      > +    disp_desc.modeChangeHandler = ^(PGDisplayCoord_t
>     sizeInPixels,
>      >      > +                                    OSType pixelFormat) {
>      >      > +        trace_apple_gfx_mode_change(sizeInPixels.x,
>     sizeInPixels.y);
>      >      > +
>      >      > +        BQL_LOCK_GUARD();
>      >      > +        set_mode(s, sizeInPixels.x, sizeInPixels.y);
>      >      > +    };
>      >      > +    disp_desc.cursorGlyphHandler = ^(NSBitmapImageRep *glyph,
>      >      > +                                     PGDisplayCoord_t
>     hotSpot) {
>      >      > +        [glyph retain];
>      >      > +        dispatch_async(get_background_queue(), ^{
>      >      > +            BQL_LOCK_GUARD();
>      >      > +            uint32_t bpp = glyph.bitsPerPixel;
>      >      > +            size_t width = glyph.pixelsWide;
>      >      > +            size_t height = glyph.pixelsHigh;
>      >      > +            size_t padding_bytes_per_row =
>     glyph.bytesPerRow -
>      >     width * 4;
>      >      > +            const uint8_t* px_data = glyph.bitmapData;
>      >      > +
>      >      > +            trace_apple_gfx_cursor_set(bpp, width, height);
>      >      > +
>      >      > +            if (s->cursor) {
>      >      > +                cursor_unref(s->cursor);
>      >      > +                s->cursor = NULL;
>      >      > +            }
>      >      > +
>      >      > +            if (bpp == 32) { /* Shouldn't be anything
>     else, but
>      >     just to be safe...*/
>      >      > +                s->cursor = cursor_alloc(width, height);
>      >      > +                s->cursor->hot_x = hotSpot.x;
>      >      > +                s->cursor->hot_y = hotSpot.y;
>      >      > +
>      >      > +                uint32_t *dest_px = s->cursor->data;
>      >      > +
>      >      > +                for (size_t y = 0; y < height; ++y) {
>      >      > +                    for (size_t x = 0; x < width; ++x) {
>      >      > +                        /* NSBitmapImageRep's red & blue
>      >     channels are swapped
>      >      > +                         * compared to QEMUCursor's. */
>      >      > +                        *dest_px =
>      >      > +                            (px_data[0] << 16u) |
>      >      > +                            (px_data[1] <<  8u) |
>      >      > +                            (px_data[2] <<  0u) |
>      >      > +                            (px_data[3] << 24u);
>      >      > +                        ++dest_px;
>      >      > +                        px_data += 4;
>      >      > +                    }
>      >      > +                    px_data += padding_bytes_per_row;
>      >      > +                }
>      >      > +                dpy_cursor_define(s->con, s->cursor);
>      >      > +                update_cursor(s);
>      >      > +            }
>      >      > +            [glyph release];
>      >      > +        });
>      >      > +    };
>      >      > +    disp_desc.cursorShowHandler = ^(BOOL show) {
>      >      > +        dispatch_async(get_background_queue(), ^{
>      >      > +            BQL_LOCK_GUARD();
>      >      > +            trace_apple_gfx_cursor_show(show);
>      >      > +            s->cursor_show = show;
>      >      > +            update_cursor(s);
>      >      > +        });
>      >      > +    };
>      >      > +    disp_desc.cursorMoveHandler = ^(void) {
>      >      > +        dispatch_async(get_background_queue(), ^{
>      >      > +            BQL_LOCK_GUARD();
>      >      > +            trace_apple_gfx_cursor_move();
>      >      > +            update_cursor(s);
>      >      > +        });
>      >      > +    };
>      >      > +
>      >      > +    return disp_desc;
>      >      > +}
>      >      > +
>      >      > +static NSArray<PGDisplayMode*>*
>      >     apple_gfx_prepare_display_mode_array(void)
>      >      > +{
>      >      > +    PGDisplayMode *modes[ARRAY_SIZE(apple_gfx_modes)];
>      >      > +    NSArray<PGDisplayMode*>* mode_array = nil;
>      >      > +    int i;
>      >      > +
>      >      > +    for (i = 0; i < ARRAY_SIZE(apple_gfx_modes); i++) {
>      >      > +        modes[i] =
>      >      > +            [[PGDisplayMode alloc]
>      >     initWithSizeInPixels:apple_gfx_modes[i] refreshRateInHz:60.];
>      >      > +    }
>      >      > +
>      >      > +    mode_array = [NSArray arrayWithObjects:modes
>      >     count:ARRAY_SIZE(apple_gfx_modes)];
>      >      > +
>      >      > +    for (i = 0; i < ARRAY_SIZE(apple_gfx_modes); i++) {
>      >      > +        [modes[i] release];
>      >      > +        modes[i] = nil;
>      >      > +    }
>      >      > +
>      >      > +    return mode_array;
>      >      > +}
>      >      > +
>      >      > +static id<MTLDevice> copy_suitable_metal_device(void)
>      >      > +{
>      >      > +    id<MTLDevice> dev = nil;
>      >      > +    NSArray<id<MTLDevice>> *devs = MTLCopyAllDevices();
>      >      > +
>      >      > +    /* Prefer a unified memory GPU. Failing that, pick a non-
>      >     removable GPU. */
>      >      > +    for (size_t i = 0; i < devs.count; ++i) {
>      >      > +        if (devs[i].hasUnifiedMemory) {
>      >      > +            dev = devs[i];
>      >      > +            break;
>      >      > +        }
>      >      > +        if (!devs[i].removable) {
>      >      > +            dev = devs[i];
>      >      > +        }
>      >      > +    }
>      >      > +
>      >      > +    if (dev != nil) {
>      >      > +        [dev retain];
>      >      > +    } else {
>      >      > +        dev = MTLCreateSystemDefaultDevice();
>      >      > +    }
>      >      > +    [devs release];
>      >      > +
>      >      > +    return dev;
>      >      > +}
>      >      > +
>      >      > +void apple_gfx_common_realize(AppleGFXState *s,
>      >     PGDeviceDescriptor *desc,
>      >      > +                              Error **errp)
>      >      > +{
>      >      > +    PGDisplayDescriptor *disp_desc = nil;
>      >      > +
>      >      > +    if (apple_gfx_mig_blocker == NULL) {
>      >      > +        error_setg(&apple_gfx_mig_blocker,
>      >      > +                  "Migration state blocked by apple-gfx
>     display
>      >     device");
>      >      > +        if (migrate_add_blocker(&apple_gfx_mig_blocker,
>     errp) < 0) {
>      >      > +            return;
>      >      > +        }
>      >      > +    }
>      >      > +
>      >      > +    QTAILQ_INIT(&s->tasks);
>      >      > +    s->render_queue = dispatch_queue_create("apple-
>     gfx.render",
>      >      > +                                           
>     DISPATCH_QUEUE_SERIAL);
>      >      > +    s->mtl = copy_suitable_metal_device();
>      >      > +    s->mtl_queue = [s->mtl newCommandQueue];
>      >      > +
>      >      > +    desc.device = s->mtl;
>      >      > +
>      >      > +    apple_gfx_register_task_mapping_handlers(s, desc);
>      >      > +
>      >      > +    s->pgdev = PGNewDeviceWithDescriptor(desc);
>      >      > +
>      >      > +    disp_desc = apple_gfx_prepare_display_descriptor(s);
>      >      > +    s->pgdisp = [s->pgdev newDisplayWithDescriptor:disp_desc
>      >      > +                                              port:0
>      >     serialNum:1234];
>      >      > +    [disp_desc release];
>      >      > +    s->pgdisp.modeList =
>     apple_gfx_prepare_display_mode_array();
>      >      > +
>      >      > +    create_fb(s);
>      >      > +
>      >      > +    qemu_mutex_init(&s->job_mutex);
>      >      > +    qemu_cond_init(&s->job_cond);
>      >      > +}
>      >      > diff --git a/hw/display/meson.build b/hw/display/meson.build
>      >      > index 20a94973fa2..619e642905a 100644
>      >      > --- a/hw/display/meson.build
>      >      > +++ b/hw/display/meson.build
>      >      > @@ -61,6 +61,10 @@ system_ss.add(when: 'CONFIG_ARTIST',
>     if_true:
>      >     files('artist.c'))
>      >      >
>      >      >   system_ss.add(when: 'CONFIG_ATI_VGA', if_true:
>     [files('ati.c',
>      >     'ati_2d.c', 'ati_dbg.c'), pixman])
>      >      >
>      >      > +system_ss.add(when: 'CONFIG_MAC_PVG',         if_true:
>      >     [files('apple-gfx.m'), pvg, metal])
>      >      > +if cpu == 'aarch64'
>      >      > +  system_ss.add(when: 'CONFIG_MAC_PVG_MMIO',  if_true:
>      >     [files('apple-gfx-mmio.m'), pvg, metal])
>      >      > +endif
>      >      >
>      >      >   if config_all_devices.has_key('CONFIG_VIRTIO_GPU')
>      >      >     virtio_gpu_ss = ss.source_set()
>      >      > diff --git a/hw/display/trace-events b/hw/display/trace-events
>      >      > index 781f8a33203..214998312b9 100644
>      >      > --- a/hw/display/trace-events
>      >      > +++ b/hw/display/trace-events
>      >      > @@ -191,3 +191,29 @@ dm163_bits_ppi(unsigned dest_width)
>      >     "dest_width : %u"
>      >      >   dm163_leds(int led, uint32_t value) "led %d: 0x%x"
>      >      >   dm163_channels(int channel, uint8_t value) "channel %d:
>     0x%x"
>      >      >   dm163_refresh_rate(uint32_t rr) "refresh rate %d"
>      >      > +
>      >      > +# apple-gfx.m
>      >      > +apple_gfx_read(uint64_t offset, uint64_t res)
>      >     "offset=0x%"PRIx64" res=0x%"PRIx64
>      >      > +apple_gfx_write(uint64_t offset, uint64_t val)
>      >     "offset=0x%"PRIx64" val=0x%"PRIx64
>      >      > +apple_gfx_create_task(uint32_t vm_size, void *va)
>     "vm_size=0x%x
>      >     base_addr=%p"
>      >      > +apple_gfx_destroy_task(void *task) "task=%p"
>      >      > +apple_gfx_map_memory(void *task, uint32_t range_count,
>     uint64_t
>      >     virtual_offset, uint32_t read_only) "task=%p range_count=0x%x
>      >     virtual_offset=0x%"PRIx64" read_only=%d"
>      >      > +apple_gfx_map_memory_range(uint32_t i, uint64_t phys_addr,
>      >     uint64_t phys_len) "[%d] phys_addr=0x%"PRIx64"
>     phys_len=0x%"PRIx64
>      >      > +apple_gfx_remap(uint64_t retval, uint64_t source, uint64_t
>      >     target) "retval=%"PRId64" source=0x%"PRIx64" target=0x%"PRIx64
>      >      > +apple_gfx_unmap_memory(void *task, uint64_t virtual_offset,
>      >     uint64_t length) "task=%p virtual_offset=0x%"PRIx64"
>     length=0x%"PRIx64
>      >      > +apple_gfx_read_memory(uint64_t phys_address, uint64_t length,
>      >     void *dst) "phys_addr=0x%"PRIx64" length=0x%"PRIx64" dest=%p"
>      >      > +apple_gfx_raise_irq(uint32_t vector) "vector=0x%x"
>      >      > +apple_gfx_new_frame(void) ""
>      >      > +apple_gfx_mode_change(uint64_t x, uint64_t y) "x=%"PRId64"
>      >     y=%"PRId64
>      >      > +apple_gfx_cursor_set(uint32_t bpp, uint64_t width, uint64_t
>      >     height) "bpp=%d width=%"PRId64" height=0x%"PRId64
>      >      > +apple_gfx_cursor_show(uint32_t show) "show=%d"
>      >      > +apple_gfx_cursor_move(void) ""
>      >      > +apple_gfx_common_init(const char *device_name, size_t
>     mmio_size)
>      >     "device: %s; MMIO size: %zu bytes"
>      >      > +
>      >      > +# apple-gfx-mmio.m
>      >      > +apple_gfx_mmio_iosfc_read(uint64_t offset, uint64_t res)
>      >     "offset=0x%"PRIx64" res=0x%"PRIx64
>      >      > +apple_gfx_mmio_iosfc_write(uint64_t offset, uint64_t val)
>      >     "offset=0x%"PRIx64" val=0x%"PRIx64
>      >      > +apple_gfx_iosfc_map_memory(uint64_t phys, uint64_t len,
>     uint32_t
>      >     ro, void *va, void *e, void *f, void* va_result, int success)
>      >     "phys=0x%"PRIx64" len=0x%"PRIx64" ro=%d va=%p e=%p f=%p ->
>     *va=%p,
>      >     success = %d"
>      >      > +apple_gfx_iosfc_unmap_memory(void *a, void *b, void *c,
>     void *d,
>      >     void *e, void *f) "a=%p b=%p c=%p d=%p e=%p f=%p"
>      >      > +apple_gfx_iosfc_raise_irq(uint32_t vector) "vector=0x%x"
>      >      > +
>      >      > diff --git a/meson.build b/meson.build
>      >      > index d26690ce204..0e124eff13f 100644
>      >      > --- a/meson.build
>      >      > +++ b/meson.build
>      >      > @@ -761,6 +761,8 @@ socket = []
>      >      >   version_res = []
>      >      >   coref = []
>      >      >   iokit = []
>      >      > +pvg = []
>      >      > +metal = []
>      >      >   emulator_link_args = []
>      >      >   midl = not_found
>      >      >   widl = not_found
>      >      > @@ -782,6 +784,8 @@ elif host_os == 'darwin'
>      >      >     coref = dependency('appleframeworks', modules:
>     'CoreFoundation')
>      >      >     iokit = dependency('appleframeworks', modules: 'IOKit',
>      >     required: false)
>      >      >     host_dsosuf = '.dylib'
>      >      > +  pvg = dependency('appleframeworks', modules:
>      >     'ParavirtualizedGraphics')
>      >      > +  metal = dependency('appleframeworks', modules: 'Metal')
>      >      >   elif host_os == 'sunos'
>      >      >     socket = [cc.find_library('socket'),
>      >      >               cc.find_library('nsl'),
>      >
> 


