Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFB01D13570
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2024 09:02:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5Lci-0002bw-1T; Mon, 28 Oct 2024 05:01:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1t5Lc3-0002Ub-BY
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 05:00:35 -0400
Received: from mail-vk1-xa2b.google.com ([2607:f8b0:4864:20::a2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1t5Lbr-0004fp-0I
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 05:00:35 -0400
Received: by mail-vk1-xa2b.google.com with SMTP id
 71dfb90a1353d-50d487a93a5so1168344e0c.3
 for <qemu-devel@nongnu.org>; Mon, 28 Oct 2024 02:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1730106021; x=1730710821;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Xj2yI37FYSWmWOFCuXVZ++E9EEFPnnHDLT88Dh8g18M=;
 b=OQmxmtB3lto3YmLeSSxiIyx02zAQGGV/Ms0nRuDKXBpkl5kaEz9nJd7LcWRQV95QZh
 mRzTpNbpuI+0LxIkix6MGrQdfavif8Mi+N0q50ybm8jnpS7c/HpTrBQSdaMIhDp/dgct
 exph0i16XhwdpS5h68MdWtmKQRAa75a5WkR60EucrNXmfkSbWE3k3GEMZqDh3VvUENCw
 EbkR5G9x85nvNjc5hmOnkhU6qOu5MYxKMv3Zs8gTVLhCYpGz9F8rV7gQ+TugUKi+f692
 0O6h64NJqtEwFOLSXS3B6/j/NKMbBPQJkWQ6kSlHPAukvY+7ZofXbyfK9v08BqFN4pkL
 080Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730106021; x=1730710821;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Xj2yI37FYSWmWOFCuXVZ++E9EEFPnnHDLT88Dh8g18M=;
 b=lSNE7X5PE/z+i7O6WuKaLf4p3MQEvTlokJw1uiEEEm3ejBAVSR5B6NRtWQihHacFjY
 sDay88hTAOekP7nA8w2RKu9aX9dzLYx+LA38cyy/vD+OsH8udzlYRuEGy8vpu5K+59M+
 gFVLYXbAC70Sbdi920nf9F5i+dlV6ZGkYqNFQL/vunRx17j1mSfV5Py1G6oiIIq5V4LV
 pYCq22EIiMExi0RbsC2jGQRSoavmO6j98Kn+gp1UjfuGfNRUhVA2qfb2KzM4BVR3v18/
 mmbWEaOYauQIgfvjr+17aCXWaU4CnkMDeAEUItdkNLt1Jh7sXOYvp4uKLUg1Gx5XCB9g
 IakQ==
X-Gm-Message-State: AOJu0YwJO6k+t72p2+aidqCUlTp1BR2FpBMSiJ3kbUWObqUFbyEZKThe
 OzoNc3SzWZMjmTlnloUaebtdTiiL05W24+fuHvCNOVBpTQkrsXMJgQmNeDUvPy8m0gf40LlNpUk
 6iM5b97Sm61lMmq3gZvtlBqloYc0h2pzaMmbs
X-Google-Smtp-Source: AGHT+IEA/V6Z2Kzv2nOyohiIHAPiEAgFi4Mm+NsVM1Lwfwdla5C1kePKtobJEFrTKc24ZPjoIR5rO/xtpbawfyzQEgk=
X-Received: by 2002:a05:6122:65aa:b0:50d:85d7:d94b with SMTP id
 71dfb90a1353d-51015116a1dmr4005023e0c.11.1730106020759; Mon, 28 Oct 2024
 02:00:20 -0700 (PDT)
MIME-Version: 1.0
References: <20241024102813.9855-1-phil@philjordan.eu>
 <20241024102813.9855-3-phil@philjordan.eu>
 <9e310d5e-ab73-47b9-b9ed-5a16d4db3fb9@daynix.com>
 <CAAibmn0NA+K63OvrsBpN1HivndyZo-fgeLwzY8AVE4hPrQR26w@mail.gmail.com>
 <dd2aae75-348d-44ad-bbd9-5d45aad15bc6@daynix.com>
 <CAAibmn1z+7yizwH8DogfcCWOWzA8Ox6e=p+Hc1pu-CS4SjAirg@mail.gmail.com>
 <6a989d04-6416-4bd9-98ac-e1230a1095a9@daynix.com>
In-Reply-To: <6a989d04-6416-4bd9-98ac-e1230a1095a9@daynix.com>
From: Phil Dennis-Jordan <phil@philjordan.eu>
Date: Mon, 28 Oct 2024 10:00:09 +0100
Message-ID: <CAAibmn3YEOT0O55-bwJkpi_oEGkA1WwvhC0w3jGbgXOZLTVa0w@mail.gmail.com>
Subject: Re: [PATCH v4 02/15] hw/display/apple-gfx: Introduce
 ParavirtualizedGraphics.Framework support
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: qemu-devel@nongnu.org, agraf@csgraf.de, peter.maydell@linaro.org, 
 pbonzini@redhat.com, rad@semihalf.com, quic_llindhol@quicinc.com, 
 marcin.juszkiewicz@linaro.org, stefanha@redhat.com, mst@redhat.com, 
 slp@redhat.com, richard.henderson@linaro.org, eduardo@habkost.net, 
 marcel.apfelbaum@gmail.com, gaosong@loongson.cn, jiaxun.yang@flygoat.com, 
 chenhuacai@kernel.org, kwolf@redhat.com, hreitz@redhat.com, philmd@linaro.org, 
 shorne@gmail.com, palmer@dabbelt.com, alistair.francis@wdc.com, 
 bmeng.cn@gmail.com, liwei1518@gmail.com, dbarboza@ventanamicro.com, 
 zhiwei_liu@linux.alibaba.com, jcmvbkbc@gmail.com, marcandre.lureau@redhat.com, 
 berrange@redhat.com, qemu-arm@nongnu.org, qemu-block@nongnu.org, 
 qemu-riscv@nongnu.org, Alexander Graf <graf@amazon.com>
Content-Type: multipart/alternative; boundary="000000000000caadfd062585b22f"
Received-SPF: neutral client-ip=2607:f8b0:4864:20::a2b;
 envelope-from=phil@philjordan.eu; helo=mail-vk1-xa2b.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NEUTRAL=0.779 autolearn=no autolearn_force=no
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

--000000000000caadfd062585b22f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 28 Oct 2024 at 08:42, Akihiko Odaki <akihiko.odaki@daynix.com>
wrote:

> On 2024/10/26 19:24, Phil Dennis-Jordan wrote:
> >
> >
> > On Sat, 26 Oct 2024 at 06:40, Akihiko Odaki <akihiko.odaki@daynix.com
> > <mailto:akihiko.odaki@daynix.com>> wrote:
> >
> >     On 2024/10/26 4:43, Phil Dennis-Jordan wrote:
> >      >
> >      >
> >      > On Fri, 25 Oct 2024 at 08:03, Akihiko Odaki
> >     <akihiko.odaki@daynix.com <mailto:akihiko.odaki@daynix.com>
> >      > <mailto:akihiko.odaki@daynix.com
> >     <mailto:akihiko.odaki@daynix.com>>> wrote:
> >      >
> >      >     On 2024/10/24 19:28, Phil Dennis-Jordan wrote:
> >      >      > +    /* For running PVG memory-mapping requests in the AI=
O
> >     context */
> >      >      > +    QemuCond job_cond;
> >      >      > +    QemuMutex job_mutex;
> >      >
> >      >     Use: QemuEvent
> >      >
> >      >
> >      > Hmm. I think if we were to use that, we would need to create a n=
ew
> >      > QemuEvent for every job and destroy it afterward, which seems
> >     expensive.
> >      > We can't rule out multiple concurrent jobs being submitted, and
> the
> >      > QemuEvent system only supports a single producer as far as I can
> >     tell.
> >      >
> >      > You can probably sort of hack around it with just one QemuEvent =
by
> >      > putting the qemu_event_wait into a loop and turning the job.done
> >     flag
> >      > into an atomic (because it would now need to be checked outside
> the
> >      > lock) but this all seems unnecessarily complicated considering t=
he
> >      > QemuEvent uses the same mechanism QemuCond/QemuMutex internally
> >     on macOS
> >      > (the only platform relevant here), except we can use it as
> >     intended with
> >      > QemuCond/QemuMutex rather than having to work against the
> >     abstraction.
> >
> >     I don't think it's going to be used concurrently. It would be
> difficult
> >     to reason even for the framework if it performs memory
> >     unmapping/mapping/reading operations concurrently.
> >
> >
> > I've just performed a very quick test by wrapping the job submission/
> > wait in the 2 mapMemory callbacks and the 1 readMemory callback with
> > atomic counters and logging whenever a counter went above 1.
> >
> >   * Overall, concurrent callbacks across all types were common (many pe=
r
> > second when the VM is busy). It's not exactly a "thundering herd" (I
> > never saw >2) but it's probably not a bad idea to use a separate
> > condition variable for each job type. (task map, surface map, memory
> read)
> >   * While I did not observe any concurrent memory mapping operations
> > *within* a type of memory map (2 task mappings or 2 surface mappings) I
> > did see very occasional concurrent memory *read* callbacks. These would=
,
> > as far as I can tell, not be safe with QemuEvents, unless we placed the
> > event inside the job struct and init/destroyed it on every callback
> > (which seems like excessive overhead).
>
> I think we can tolerate that overhead. init/destroy essentially sets the
> fields in the data structure and I estimate its total size is about 100
> bytes. It is probably better than waking an irrelevant thread up. I also
> hope that keeps the code simple; it's not worthwhile adding code to
> optimize this.
>

At least pthread_cond_{init,destroy} and pthread_mutex_{init,destroy} don't
make any syscalls, so yeah it's probably an acceptable overhead.


> >
> > My recommendation would be to split it up into 3 pairs of mutex/cond;
> > this will almost entirely remove any contention, but continue to be saf=
e
> > for when it does occur. I don't think QemuEvent is a realistic option
> > (too tricky to get right) for the observed-concurrent readMemory
> > callback. I'm nervous about assuming the mapMemory callbacks will NEVER
> > be called concurrently, but at a push I'll acquiesce to switching those
> > to QemuEvent in the absence of evidence of concurrency.> >
>  PGDevice.h also notes
> >     raiseInterrupt needs to be thread-safe while it doesn't make such
> notes
> >     for memory operations. This actually makes sense.
> >
> >     If it's ever going to be used concurrently, it's better to have
> >     QemuEvent for each job to avoid the thundering herd problem.
>  > >      >
> >      >      > +
> >      >      > +    dispatch_queue_t render_queue;
> >      >      > +    /* The following fields should only be accessed from
> >     the BQL: */
> >      >
> >      >     Perhaps it may be better to document fields that can be
> accessed
> >      >     *without* the BQL; most things in QEMU implicitly require th=
e
> >     BQL.
> >      >
> >      >      > +    bool gfx_update_requested;
> >      >      > +    bool new_frame_ready;
> >      >      > +    bool using_managed_texture_storage;
> >      >      > +} AppleGFXState;
> >      >      > +
> >      >      > +void apple_gfx_common_init(Object *obj, AppleGFXState *s=
,
> >     const
> >      >     char* obj_name);
> >      >      > +void apple_gfx_common_realize(AppleGFXState *s,
> >      >     PGDeviceDescriptor *desc,
> >      >      > +                              Error **errp);
> >      >      > +uintptr_t apple_gfx_host_address_for_gpa_range(uint64_t
> >      >     guest_physical,
> >      >      > +                                               uint64_t
> >     length,
> >      >     bool read_only);
> >      >      > +void apple_gfx_await_bh_job(AppleGFXState *s, bool
> >     *job_done_flag);
> >      >      > +
> >      >      > +#endif
> >      >      > +
> >      >      > diff --git a/hw/display/apple-gfx.m
> b/hw/display/apple-gfx.m
> >      >      > new file mode 100644
> >      >      > index 00000000000..46be9957f69
> >      >      > --- /dev/null
> >      >      > +++ b/hw/display/apple-gfx.m
> >      >      > @@ -0,0 +1,713 @@
> >      >      > +/*
> >      >      > + * QEMU Apple ParavirtualizedGraphics.framework device
> >      >      > + *
> >      >      > + * Copyright =C2=A9 2023 Amazon.com, Inc. or its affilia=
tes.
> All
> >      >     Rights Reserved.
> >      >      > + *
> >      >      > + * This work is licensed under the terms of the GNU GPL,
> >     version
> >      >     2 or later.
> >      >      > + * See the COPYING file in the top-level directory.
> >      >      > + *
> >      >      > + * ParavirtualizedGraphics.framework is a set of
> >     libraries that
> >      >     macOS provides
> >      >      > + * which implements 3d graphics passthrough to the host
> >     as well as a
> >      >      > + * proprietary guest communication channel to drive it.
> This
> >      >     device model
> >      >      > + * implements support to drive that library from within
> QEMU.
> >      >      > + */
> >      >      > +
> >      >      > +#include "qemu/osdep.h"
> >      >      > +#import
> <ParavirtualizedGraphics/ParavirtualizedGraphics.h>
> >      >      > +#include <mach/mach_vm.h>
> >      >      > +#include "apple-gfx.h"
> >      >      > +#include "trace.h"
> >      >      > +#include "qemu-main.h"
> >      >      > +#include "exec/address-spaces.h"
> >      >      > +#include "migration/blocker.h"
> >      >      > +#include "monitor/monitor.h"
> >      >      > +#include "qemu/main-loop.h"
> >      >      > +#include "qemu/cutils.h"
> >      >      > +#include "qemu/log.h"
> >      >      > +#include "qapi/visitor.h"
> >      >      > +#include "qapi/error.h"
> >      >      > +#include "ui/console.h"
> >      >      > +
> >      >      > +static const PGDisplayCoord_t apple_gfx_modes[] =3D {
> >      >      > +    { .x =3D 1440, .y =3D 1080 },
> >      >      > +    { .x =3D 1280, .y =3D 1024 },
> >      >      > +};
> >      >      > +
> >      >      > +/* This implements a type defined in
> >     <ParavirtualizedGraphics/
> >      >     PGDevice.h>
> >      >      > + * which is opaque from the framework's point of view.
> >     Typedef
> >      >     PGTask_t already
> >      >      > + * exists in the framework headers. */
> >      >      > +struct PGTask_s {
> >      >      > +    QTAILQ_ENTRY(PGTask_s) node;
> >      >      > +    mach_vm_address_t address;
> >      >      > +    uint64_t len;
> >      >      > +};
> >      >      > +
> >      >      > +static Error *apple_gfx_mig_blocker;
> >      >
> >      >     This does not have to be a static variable.
> >      >
> >      >
> >      > Hmm, the first 5 or so examples of migration blockers in other
> >     devices
> >      > etc. I could find were all declared in this way. What are you
> >     suggesting
> >      > as the alternative? And why not use the same pattern as in most
> >     of the
> >      > rest of the code base?
> >
> >     I was wrong. This is better to be a static variable to ensure we
> won't
> >     add the same blocker in case we have two device instances.
> >
> >      >
> >      >      > +
> >      >      > +static void
> >     apple_gfx_render_frame_completed(AppleGFXState *s,
> >      >      > +                                             uint32_t
> width,
> >      >     uint32_t height);
> >      >      > +
> >      >      > +static inline dispatch_queue_t get_background_queue(void=
)
> >      >
> >      >     Don't add inline. The only effect for modern compilers of
> >     inline is to
> >      >     suppress the unused function warnings.
> >      >
> >      >      > +{
> >      >      > +    return
> >      >     dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0=
);
> >      >      > +}
> >      >      > +
> >      >      > +static PGTask_t *apple_gfx_new_task(AppleGFXState *s,
> >     uint64_t len)
> >      >      > +{
> >      >      > +    mach_vm_address_t task_mem;
> >      >      > +    PGTask_t *task;
> >      >      > +    kern_return_t r;
> >      >      > +
> >      >      > +    r =3D mach_vm_allocate(mach_task_self(), &task_mem, =
len,
> >      >     VM_FLAGS_ANYWHERE);
> >      >      > +    if (r !=3D KERN_SUCCESS || task_mem =3D=3D 0) {
> >      >
> >      >     Let's remove the check for task_mem =3D=3D 0. We have no rea=
son to
> >      >     reject it
> >      >     if the platform insists it allocated a memory at address 0
> though
> >      >     such a
> >      >     situation should never happen in practice.
> >      >
> >      >      > +        return NULL;
> >      >      > +    }
> >      >      > +
> >      >      > +    task =3D g_new0(PGTask_t, 1);
> >      >      > +
> >      >      > +    task->address =3D task_mem;
> >      >      > +    task->len =3D len;
> >      >      > +    QTAILQ_INSERT_TAIL(&s->tasks, task, node);
> >      >      > +
> >      >      > +    return task;
> >      >      > +}
> >      >      > +
> >      >      > +typedef struct AppleGFXIOJob {
> >      >      > +    AppleGFXState *state;
> >      >      > +    uint64_t offset;
> >      >      > +    uint64_t value;
> >      >      > +    bool completed;
> >      >      > +} AppleGFXIOJob;
> >      >      > +
> >      >      > +static void apple_gfx_do_read(void *opaque)
> >      >      > +{
> >      >      > +    AppleGFXIOJob *job =3D opaque;
> >      >      > +    job->value =3D [job->state->pgdev mmioReadAtOffset:j=
ob-
> >      >offset];
> >      >      > +    qatomic_set(&job->completed, true);
> >      >      > +    aio_wait_kick();
> >      >      > +}
> >      >      > +
> >      >      > +static uint64_t apple_gfx_read(void *opaque, hwaddr
> offset,
> >      >     unsigned size)
> >      >      > +{
> >      >      > +    AppleGFXIOJob job =3D {
> >      >      > +        .state =3D opaque,
> >      >      > +        .offset =3D offset,
> >      >      > +        .completed =3D false,
> >      >      > +    };
> >      >      > +    AioContext *context =3D qemu_get_aio_context();
> >      >      > +    dispatch_queue_t queue =3D get_background_queue();
> >      >      > +
> >      >      > +    dispatch_async_f(queue, &job, apple_gfx_do_read);
> >      >      > +    AIO_WAIT_WHILE(context,
> !qatomic_read(&job.completed));
> >      >      > +
> >      >      > +    trace_apple_gfx_read(offset, job.value);
> >      >      > +    return job.value;
> >      >      > +}
> >      >      > +
> >      >      > +static void apple_gfx_do_write(void *opaque)
> >      >      > +{
> >      >      > +    AppleGFXIOJob *job =3D opaque;
> >      >      > +    [job->state->pgdev mmioWriteAtOffset:job->offset
> >     value:job-
> >      >      >value];
> >      >      > +    qatomic_set(&job->completed, true);
> >      >      > +    aio_wait_kick();
> >      >      > +}
> >      >      > +
> >      >      > +static void apple_gfx_write(void *opaque, hwaddr offset,
> >      >     uint64_t val,
> >      >      > +                            unsigned size)
> >      >      > +{
> >      >      > +    /* The methods mmioReadAtOffset: and especially
> >      >     mmioWriteAtOffset: can
> >      >      > +     * trigger and block on operations on other dispatch
> >     queues,
> >      >     which in turn
> >      >      > +     * may call back out on one or more of the callback
> >     blocks.
> >      >     For this reason,
> >      >      > +     * and as we are holding the BQL, we invoke the I/O
> >     methods
> >      >     on a pool
> >      >      > +     * thread and handle AIO tasks while we wait. Any
> work in
> >      >     the callbacks
> >      >      > +     * requiring the BQL will in turn schedule BHs which
> this
> >      >     thread will
> >      >      > +     * process while waiting. */
> >      >      > +    AppleGFXIOJob job =3D {
> >      >      > +        .state =3D opaque,
> >      >      > +        .offset =3D offset,
> >      >      > +        .value =3D val,
> >      >      > +        .completed =3D false,
> >      >      > +    };
> >      >      > +    AioContext *context =3D qemu_get_current_aio_context=
();
> >      >      > +    dispatch_queue_t queue =3D get_background_queue();
> >      >      > +
> >      >      > +    dispatch_async_f(queue, &job, apple_gfx_do_write);
> >      >      > +    AIO_WAIT_WHILE(context,
> !qatomic_read(&job.completed));
> >      >      > +
> >      >      > +    trace_apple_gfx_write(offset, val);
> >      >      > +}
> >      >      > +
> >      >      > +static const MemoryRegionOps apple_gfx_ops =3D {
> >      >      > +    .read =3D apple_gfx_read,
> >      >      > +    .write =3D apple_gfx_write,
> >      >      > +    .endianness =3D DEVICE_LITTLE_ENDIAN,
> >      >      > +    .valid =3D {
> >      >      > +        .min_access_size =3D 4,
> >      >      > +        .max_access_size =3D 8,
> >      >      > +    },
> >      >      > +    .impl =3D {
> >      >      > +        .min_access_size =3D 4,
> >      >      > +        .max_access_size =3D 4,
> >      >      > +    },
> >      >      > +};
> >      >      > +
> >      >      > +static void
> >     apple_gfx_render_new_frame_bql_unlock(AppleGFXState *s)
> >      >      > +{
> >      >      > +    BOOL r;
> >      >      > +    uint32_t width =3D surface_width(s->surface);
> >      >      > +    uint32_t height =3D surface_height(s->surface);
> >      >      > +    MTLRegion region =3D MTLRegionMake2D(0, 0, width,
> height);
> >      >      > +    id<MTLCommandBuffer> command_buffer =3D [s->mtl_queu=
e
> >      >     commandBuffer];
> >      >      > +    id<MTLTexture> texture =3D s->texture;
> >      >      > +
> >      >      > +    assert(bql_locked());
> >      >      > +    [texture retain];
> >      >      > +
> >      >      > +    bql_unlock();
> >      >      > +
> >      >      > +    /* This is not safe to call from the BQL due to PVG-
> >     internal
> >      >     locks causing
> >      >      > +     * deadlocks. */
> >      >      > +    r =3D [s->pgdisp
> >     encodeCurrentFrameToCommandBuffer:command_buffer
> >      >      > +
>  texture:texture
> >      >      > +
> region:region];
> >      >      > +    if (!r) {
> >      >      > +        [texture release];
> >      >      > +        bql_lock();
> >      >      > +        --s->pending_frames;
> >      >      > +        bql_unlock();
> >      >      > +        qemu_log_mask(LOG_GUEST_ERROR,
> >      >     "apple_gfx_render_new_frame_bql_unlock: "
> >      >
> >      >     Use: __func__
> >      >
> >      >      > +
> >      >     "encodeCurrentFrameToCommandBuffer:texture:region: failed\n"=
);
> >      >      > +        return;
> >      >      > +    }
> >      >      > +
> >      >      > +    if (s->using_managed_texture_storage) {
> >      >      > +        /* "Managed" textures exist in both VRAM and RAM
> and
> >      >     must be synced. */
> >      >      > +        id<MTLBlitCommandEncoder> blit =3D [command_buff=
er
> >      >     blitCommandEncoder];
> >      >      > +        [blit synchronizeResource:texture];
> >      >      > +        [blit endEncoding];
> >      >      > +    }
> >      >      > +    [texture release];
> >      >      > +    [command_buffer addCompletedHandler:
> >      >      > +        ^(id<MTLCommandBuffer> cb)
> >      >      > +        {
> >      >      > +            dispatch_async(s->render_queue, ^{
> >      >      > +                apple_gfx_render_frame_completed(s,
> >     width, height);
> >      >      > +            });
> >      >      > +        }];
> >      >      > +    [command_buffer commit];
> >      >      > +}
> >      >      > +
> >      >      > +static void copy_mtl_texture_to_surface_mem(id<MTLTextur=
e>
> >      >     texture, void *vram)
> >      >      > +{
> >      >      > +    /* TODO: Skip this entirely on a pure Metal or
> headless/
> >      >     guest-only
> >      >      > +     * rendering path, else use a blit command encoder?
> Needs
> >      >     careful
> >      >      > +     * (double?) buffering design. */
> >      >      > +    size_t width =3D texture.width, height =3D texture.h=
eight;
> >      >      > +    MTLRegion region =3D MTLRegionMake2D(0, 0, width,
> height);
> >      >      > +    [texture getBytes:vram
> >      >      > +          bytesPerRow:(width * 4)
> >      >      > +        bytesPerImage:(width * height * 4)
> >      >      > +           fromRegion:region
> >      >      > +          mipmapLevel:0
> >      >      > +                slice:0];
> >      >      > +}copy_mtl_texture_to_surface_mem
> >      >      > +
> >      >      > +static void
> >     apple_gfx_render_frame_completed(AppleGFXState *s,
> >      >      > +                                             uint32_t
> width,
> >      >     uint32_t height)
> >      >      > +{
> >      >      > +    bql_lock();
> >      >      > +    --s->pending_frames;
> >      >      > +    assert(s->pending_frames >=3D 0);
> >      >      > +
> >      >      > +    /* Only update display if mode hasn't changed since =
we
> >      >     started rendering. */
> >      >      > +    if (width =3D=3D surface_width(s->surface) &&
> >      >      > +        height =3D=3D surface_height(s->surface)) {
> >      >      > +        copy_mtl_texture_to_surface_mem(s->texture,
> s->vram);
> >      >      > +        if (s->gfx_update_requested) {
> >      >      > +            s->gfx_update_requested =3D false;
> >      >      > +            dpy_gfx_update_full(s->con);
> >      >      > +            graphic_hw_update_done(s->con);
> >      >      > +            s->new_frame_ready =3D false;
> >      >      > +        } else {
> >      >      > +            s->new_frame_ready =3D true;
> >      >      > +        }
> >      >      > +    }
> >      >      > +    if (s->pending_frames > 0) {
> >      >      > +        apple_gfx_render_new_frame_bql_unlock(s);
> >      >      > +    } else {
> >      >      > +        bql_unlock();
> >      >      > +    }
> >      >      > +}
> >      >      > +
> >      >      > +static void apple_gfx_fb_update_display(void *opaque)
> >      >      > +{
> >      >      > +    AppleGFXState *s =3D opaque;
> >      >      > +
> >      >      > +    assert(bql_locked());
> >      >      > +    if (s->new_frame_ready) {
> >      >      > +        dpy_gfx_update_full(s->con);
> >      >      > +        s->new_frame_ready =3D false;
> >      >      > +        graphic_hw_update_done(s->con);
> >      >      > +    } else if (s->pending_frames > 0) {
> >      >      > +        s->gfx_update_requested =3D true;
> >      >      > +    } else {
> >      >      > +        graphic_hw_update_done(s->con);
> >      >      > +    }
> >      >      > +}
> >      >      > +
> >      >      > +static const GraphicHwOps apple_gfx_fb_ops =3D {
> >      >      > +    .gfx_update =3D apple_gfx_fb_update_display,
> >      >      > +    .gfx_update_async =3D true,
> >      >      > +};
> >      >      > +
> >      >      > +static void update_cursor(AppleGFXState *s)
> >      >      > +{
> >      >      > +    assert(bql_locked());
> >      >      > +    dpy_mouse_set(s->con, s->pgdisp.cursorPosition.x,
> >      >      > +                  s->pgdisp.cursorPosition.y, s-
> >      >cursor_show);
> >      >      > +}
> >      >      > +
> >      >      > +static void set_mode(AppleGFXState *s, uint32_t width,
> >     uint32_t
> >      >     height)
> >      >      > +{
> >      >      > +    MTLTextureDescriptor *textureDescriptor;
> >      >      > +
> >      >      > +    if (s->surface &&
> >      >      > +        width =3D=3D surface_width(s->surface) &&
> >      >      > +        height =3D=3D surface_height(s->surface)) {
> >      >      > +        return;
> >      >      > +    }
> >      >      > +
> >      >      > +    g_free(s->vram);
> >      >      > +    [s->texture release];
> >      >      > +
> >      >      > +    s->vram =3D g_malloc0_n(width * height, 4);
> >      >      > +    s->surface =3D qemu_create_displaysurface_from(width=
,
> >     height,
> >      >     PIXMAN_LE_a8r8g8b8,
> >      >      > +                                                 width *
> >     4, s-
> >      >      >vram);> +> +    @autoreleasepool {
> >      >      > +        textureDescriptor =3D
> >      >      > +            [MTLTextureDescriptor
> >      >      > +
> >      >     texture2DDescriptorWithPixelFormat:MTLPixelFormatBGRA8Unorm
> >      >      > +                                             width:width
> >      >      > +                                            height:heigh=
t
> >      >      > +                                         mipmapped:NO];
> >      >      > +        textureDescriptor.usage =3D s-
> >      >pgdisp.minimumTextureUsage;
> >      >      > +        s->texture =3D [s->mtl
> >      >     newTextureWithDescriptor:textureDescriptor];
> >      >
> >      >
> >      >     What about creating pixman_image_t from s-
> >      >texture.buffer.contents?
> >      >     This
> >      >     should save memory usage by removing the duplication of
> texture.
> >      >
> >      >
> >      > We need explicit control over when the GPU vs when the CPU may
> >     access
> >      > the texture - only one of them may access them at a time. As far
> >     as I
> >      > can tell, we can't control when the rest of Qemu might access th=
e
> >      > pixman_image used in the console surface?
> >
> >     You are right; we need to have duplicate buffers. We can still avoi=
d
> >     copying by using two MTLTextures for double-buffering instead of
> having
> >     a MTLTexture and a pixman_image and copying between them for
> >     MTLStorageModeManaged.
> >
> > Do I understand correctly that you intend to swap the surface->image on
> > every frame, or even the surface->image->data? If so, it's my
> > understanding from reading the source of a bunch of UI implementations =
a
> > few weeks ago that this is neither supported nor safe, as some
> > implementations take long-lived references to these internal data
> > structures until a dpy_gfx_switch callback. And the implementations for
> > those callbacks are in turn very expensive in some cases. This is why m=
y
> > conclusion in the v4 thread was that double-buffering was infeasible
> > with the current architecture.
>
> By the way, can't we take the BQL after
> encodeCurrentFrameToCommandBuffer and keep it until the completion
> handler? PVG requires the BQL unlocked for forward progress due to the
> bottom half usage in callbacks, but Metal doesn't.
>

What would be the advantage of this?

Also, if you're suggesting unlocking the BQL *inside* the completion
handler: I'm pretty sure locking on one thread and unlocking on another is
not supported.



> >
> >      >
> >      >      > +    }
> >      >      > +
> >      >      > +    s->using_managed_texture_storage =3D
> >      >      > +        (s->texture.storageMode =3D=3D MTLStorageModeMan=
aged);
> >      >      > +    dpy_gfx_replace_surface(s->con, s->surface);
> >      >      > +}
> >      >      > +
> >      >      > +static void create_fb(AppleGFXState *s)
> >      >      > +{
> >      >      > +    s->con =3D graphic_console_init(NULL, 0,
> >     &apple_gfx_fb_ops, s);
> >      >      > +    set_mode(s, 1440, 1080);
> >      >      > +
> >      >      > +    s->cursor_show =3D true;
> >      >      > +}
> >      >      > +
> >      >      > +static size_t apple_gfx_get_default_mmio_range_size(void=
)
> >      >      > +{
> >      >      > +    size_t mmio_range_size;
> >      >      > +    @autoreleasepool {
> >      >      > +        PGDeviceDescriptor *desc =3D [PGDeviceDescriptor
> new];
> >      >      > +        mmio_range_size =3D desc.mmioLength;
> >      >      > +        [desc release];
> >      >      > +    }
> >      >      > +    return mmio_range_size;
> >      >      > +}
> >      >      > +
> >      >      > +void apple_gfx_common_init(Object *obj, AppleGFXState *s=
,
> >     const
> >      >     char* obj_name)
> >      >      > +{
> >      >      > +    size_t mmio_range_size =3D
> >      >     apple_gfx_get_default_mmio_range_size();
> >      >      > +
> >      >      > +    trace_apple_gfx_common_init(obj_name,
> mmio_range_size);
> >      >      > +    memory_region_init_io(&s->iomem_gfx, obj,
> >     &apple_gfx_ops, s,
> >      >     obj_name,
> >      >      > +                          mmio_range_size);
> >      >      > +
> >      >      > +    /* TODO: PVG framework supports serialising device
> state:
> >      >     integrate it! */
> >      >      > +}
> >      >      > +
> >      >      > +typedef struct AppleGFXMapMemoryJob {
> >      >      > +    AppleGFXState *state;
> >      >      > +    PGTask_t *task;
> >      >      > +    uint64_t virtual_offset;
> >      >      > +    PGPhysicalMemoryRange_t *ranges;
> >      >      > +    uint32_t range_count;
> >      >      > +    bool read_only;
> >      >      > +    bool success;
> >      >      > +    bool done;
> >      >      > +} AppleGFXMapMemoryJob;
> >      >      > +
> >      >      > +uintptr_t apple_gfx_host_address_for_gpa_range(uint64_t
> >      >     guest_physical,
> >      >      > +                                               uint64_t
> >     length,
> >      >     bool read_only)
> >      >      > +{
> >      >      > +    MemoryRegion *ram_region;
> >      >      > +    uintptr_t host_address;
> >      >      > +    hwaddr ram_region_offset =3D 0;
> >      >      > +    hwaddr ram_region_length =3D length;
> >      >      > +
> >      >      > +    ram_region =3D
> >     address_space_translate(&address_space_memory,
> >      >      > +                                         guest_physical,
> >      >      > +
>  &ram_region_offset,
> >      >      > +
> >       &ram_region_length, !
> >      >     read_only,
> >      >      > +
> >       MEMTXATTRS_UNSPECIFIED);
> >      >
> >      >     Call memory_region_ref() so that it won't go away.
> >      >
> >      >      > +
> >      >      > +    if (!ram_region || ram_region_length < length ||
> >      >      > +        !memory_access_is_direct(ram_region, !read_only)=
)
> {
> >      >      > +        return 0;
> >      >      > +    }
> >      >      > +
> >      >      > +    host_address =3D
> >      >     (mach_vm_address_t)memory_region_get_ram_ptr(ram_region);
> >      >
> >      >     host_address is typed as uintptr_t, not mach_vm_address_t.
> >      >
> >      >      > +    if (host_address =3D=3D 0) {
> >      >      > +        return 0;
> >      >      > +    }
> >      >      > +    host_address +=3D ram_region_offset;
> >      >      > +
> >      >      > +    return host_address;
> >      >      > +}
> >      >      > +
> >      >      > +static void apple_gfx_map_memory(void *opaque)
> >      >      > +{
> >      >      > +    AppleGFXMapMemoryJob *job =3D opaque;
> >      >      > +    AppleGFXState *s =3D job->state;
> >      >      > +    PGTask_t *task                  =3D job->task;
> >      >      > +    uint32_t range_count            =3D job->range_count=
;
> >      >      > +    uint64_t virtual_offset         =3D job->virtual_off=
set;
> >      >      > +    PGPhysicalMemoryRange_t *ranges =3D job->ranges;
> >      >      > +    bool read_only                  =3D job->read_only;
> >      >      > +    kern_return_t r;
> >      >      > +    mach_vm_address_t target, source;
> >      >      > +    vm_prot_t cur_protection, max_protection;
> >      >      > +    bool success =3D true;
> >      >      > +
> >      >      > +    g_assert(bql_locked());
> >      >      > +
> >      >      > +    trace_apple_gfx_map_memory(task, range_count,
> >      >     virtual_offset, read_only);
> >      >      > +    for (int i =3D 0; i < range_count; i++) {
> >      >      > +        PGPhysicalMemoryRange_t *range =3D &ranges[i];
> >      >      > +
> >      >      > +        target =3D task->address + virtual_offset;
> >      >      > +        virtual_offset +=3D range->physicalLength;
> >      >      > +
> >      >      > +        trace_apple_gfx_map_memory_range(i, range-
> >      >physicalAddress,
> >      >      > +                                         range-
> >      >physicalLength);
> >      >      > +
> >      >      > +        source =3D
> apple_gfx_host_address_for_gpa_range(range-
> >      >      >physicalAddress,
> >      >      > +
> range-
> >      >      >physicalLength,
> >      >      > +
> >     read_only);
> >      >      > +        if (source =3D=3D 0) {
> >      >      > +            success =3D false;
> >      >      > +            continue;
> >      >      > +        }
> >      >      > +
> >      >      > +        MemoryRegion* alt_mr =3D NULL;
> >      >      > +        mach_vm_address_t alt_source =3D
> >      >     (mach_vm_address_t)gpa2hva(&alt_mr, range->physicalAddress,
> >     range-
> >      >      >physicalLength, NULL);
> >      >      > +        g_assert(alt_source =3D=3D source);
> >      >
> >      >     Remove this; I guess this is for debugging.
> >      >
> >      >      > +
> >      >      > +        cur_protection =3D 0;
> >      >      > +        max_protection =3D 0;
> >      >      > +        // Map guest RAM at range->physicalAddress into
> >     PG task
> >      >     memory range
> >      >      > +        r =3D mach_vm_remap(mach_task_self(),
> >      >      > +                          &target, range->physicalLength=
,
> >      >     vm_page_size - 1,
> >      >      > +                          VM_FLAGS_FIXED |
> >     VM_FLAGS_OVERWRITE,
> >      >      > +                          mach_task_self(),
> >      >      > +                          source, false /* shared
> mapping, no
> >      >     copy */,
> >      >      > +                          &cur_protection,
> &max_protection,
> >      >      > +                          VM_INHERIT_COPY);
> >      >      > +        trace_apple_gfx_remap(r, source, target);
> >      >      > +        g_assert(r =3D=3D KERN_SUCCESS);
> >      >      > +    }
> >      >      > +
> >      >      > +    qemu_mutex_lock(&s->job_mutex);
> >      >      > +    job->success =3D success;
> >      >      > +    job->done =3D true;
> >      >      > +    qemu_cond_broadcast(&s->job_cond);
> >      >      > +    qemu_mutex_unlock(&s->job_mutex);
> >      >      > +}
> >      >      > +
> >      >      > +void apple_gfx_await_bh_job(AppleGFXState *s, bool
> >     *job_done_flag)
> >      >      > +{
> >      >      > +    qemu_mutex_lock(&s->job_mutex);
> >      >      > +    while (!*job_done_flag) {
> >      >      > +        qemu_cond_wait(&s->job_cond, &s->job_mutex);
> >      >      > +    }
> >      >      > +    qemu_mutex_unlock(&s->job_mutex);
> >      >      > +}
> >      >      > +
> >      >      > +typedef struct AppleGFXReadMemoryJob {
> >      >      > +    AppleGFXState *s;
> >      >      > +    hwaddr physical_address;
> >      >      > +    uint64_t length;
> >      >      > +    void *dst;
> >      >      > +    bool done;
> >      >      > +} AppleGFXReadMemoryJob;
> >      >      > +
> >      >      > +static void apple_gfx_do_read_memory(void *opaque)
> >      >      > +{
> >      >      > +    AppleGFXReadMemoryJob *job =3D opaque;
> >      >      > +    AppleGFXState *s =3D job->s;
> >      >      > +
> >      >      > +    cpu_physical_memory_read(job->physical_address,
> job->dst,
> >      >     job->length);
> >      >
> >      >     Use: dma_memory_read()
> >      >
> >      >      > +
> >      >      > +    qemu_mutex_lock(&s->job_mutex);
> >      >      > +    job->done =3D true;
> >      >      > +    qemu_cond_broadcast(&s->job_cond);
> >      >      > +    qemu_mutex_unlock(&s->job_mutex);
> >      >      > +}
> >      >      > +
> >      >      > +static void apple_gfx_read_memory(AppleGFXState *s, hwad=
dr
> >      >     physical_address,
> >      >      > +                                  uint64_t length, void
> *dst)
> >      >      > +{
> >      >      > +    AppleGFXReadMemoryJob job =3D {
> >      >      > +        s, physical_address, length, dst
> >      >      > +    };
> >      >      > +
> >      >      > +    trace_apple_gfx_read_memory(physical_address, length=
,
> >     dst);
> >      >      > +
> >      >      > +    /* Traversing the memory map requires RCU/BQL, so do
> >     it in a
> >      >     BH. */
> >      >      > +    aio_bh_schedule_oneshot(qemu_get_aio_context(),
> >      >     apple_gfx_do_read_memory,
> >      >      > +                            &job);
> >      >      > +    apple_gfx_await_bh_job(s, &job.done);
> >      >      > +}
> >      >      > +
> >      >      > +static void
> >      >     apple_gfx_register_task_mapping_handlers(AppleGFXState *s,
> >      >      > +
> >      >       PGDeviceDescriptor *desc)
> >      >      > +{
> >      >      > +    desc.createTask =3D ^(uint64_t vmSize, void * _Nulla=
ble
> *
> >      >     _Nonnull baseAddress) {
> >      >      > +        PGTask_t *task =3D apple_gfx_new_task(s, vmSize)=
;
> >      >      > +        *baseAddress =3D (void *)task->address;
> >      >      > +        trace_apple_gfx_create_task(vmSize, *baseAddress=
);
> >      >      > +        return task;
> >      >      > +    };
> >      >      > +
> >      >      > +    desc.destroyTask =3D ^(PGTask_t * _Nonnull task) {
> >      >      > +        trace_apple_gfx_destroy_task(task);
> >      >      > +        QTAILQ_REMOVE(&s->tasks, task, node);
> >      >      > +        mach_vm_deallocate(mach_task_self(),
> task->address,
> >      >     task->len);
> >      >      > +        g_free(task);
> >      >      > +    };
> >      >      > +
> >      >      > +    desc.mapMemory =3D ^bool(PGTask_t * _Nonnull task,
> uint32_t
> >      >     range_count,
> >      >      > +                       uint64_t virtual_offset, bool
> >     read_only,
> >      >      > +                       PGPhysicalMemoryRange_t * _Nonnul=
l
> >     ranges) {
> >      >      > +        AppleGFXMapMemoryJob job =3D {
> >      >      > +            .state =3D s,
> >      >      > +            .task =3D task, .ranges =3D ranges, .range_c=
ount =3D
> >      >     range_count,
> >      >      > +            .read_only =3D read_only, .virtual_offset =
=3D
> >      >     virtual_offset,
> >      >      > +            .done =3D false, .success =3D true,
> >      >      > +        };
> >      >      > +        if (range_count > 0) {
> >      >      > +
> aio_bh_schedule_oneshot(qemu_get_aio_context(),
> >      >      > +                                    apple_gfx_map_memory=
,
> >     &job);
> >      >      > +            apple_gfx_await_bh_job(s, &job.done);
> >      >      > +        }
> >      >      > +        return job.success;
> >      >      > +    };
> >      >      > +
> >      >      > +    desc.unmapMemory =3D ^bool(PGTask_t * _Nonnull task,
> >     uint64_t
> >      >     virtualOffset,
> >      >      > +                         uint64_t length) {
> >      >      > +        kern_return_t r;
> >      >      > +        mach_vm_address_t range_address;
> >      >      > +
> >      >      > +        trace_apple_gfx_unmap_memory(task, virtualOffset=
,
> >     length);
> >      >      > +
> >      >      > +        /* Replace task memory range with fresh pages,
> >     undoing
> >      >     the mapping
> >      >      > +         * from guest RAM. */
> >      >      > +        range_address =3D task->address + virtualOffset;
> >      >      > +        r =3D mach_vm_allocate(mach_task_self(),
> >     &range_address,
> >      >     length,
> >      >      > +                             VM_FLAGS_FIXED |
> >     VM_FLAGS_OVERWRITE);
> >      >      > +        g_assert(r =3D=3D KERN_SUCCESS);error_setg
> >      >
> >      >     An extra error_setg
> >      >
> >      >      > +
> >      >      > +        return true;
> >      >      > +    };
> >      >      > +
> >      >      > +    desc.readMemory =3D ^bool(uint64_t physical_address,
> >     uint64_t
> >      >     length,
> >      >      > +                            void * _Nonnull dst) {
> >      >      > +        apple_gfx_read_memory(s, physical_address,
> >     length, dst);
> >      >      > +        return true;
> >      >      > +    };
> >      >      > +}
> >      >      > +
> >      >      > +static PGDisplayDescriptor
> >      >     *apple_gfx_prepare_display_descriptor(AppleGFXState *s)
> >      >      > +{
> >      >      > +    PGDisplayDescriptor *disp_desc =3D [PGDisplayDescrip=
tor
> >     new];
> >      >      > +
> >      >      > + disp_desc.name <http://disp_desc.name> <http://
> >     disp_desc.name <http://disp_desc.name>> =3D @"QEMU display";
> >      >      > +    disp_desc.sizeInMillimeters =3D NSMakeSize(400.,
> >     300.); /* A
> >      >     20" display */
> >      >      > +    disp_desc.queue =3D dispatch_get_main_queue();
> >      >      > +    disp_desc.newFrameEventHandler =3D ^(void) {
> >      >      > +        trace_apple_gfx_new_frame();
> >      >      > +        dispatch_async(s->render_queue, ^{
> >      >      > +            /* Drop frames if we get too far ahead. */
> >      >      > +            bql_lock();
> >      >      > +            if (s->pending_frames >=3D 2) {
> >      >      > +                bql_unlock();
> >      >      > +                return;
> >      >      > +            }
> >      >      > +            ++s->pending_frames;
> >      >      > +            if (s->pending_frames > 1) {
> >      >      > +                bql_unlock();
> >      >      > +                return;
> >      >      > +            }
> >      >      > +            @autoreleasepool {
> >      >      > +                apple_gfx_render_new_frame_bql_unlock(s)=
;
> >      >      > +            }
> >      >      > +        });
> >      >      > +    };
> >      >      > +    disp_desc.modeChangeHandler =3D ^(PGDisplayCoord_t
> >     sizeInPixels,
> >      >      > +                                    OSType pixelFormat) =
{
> >      >      > +        trace_apple_gfx_mode_change(sizeInPixels.x,
> >     sizeInPixels.y);
> >      >      > +
> >      >      > +        BQL_LOCK_GUARD();
> >      >      > +        set_mode(s, sizeInPixels.x, sizeInPixels.y);
> >      >      > +    };
> >      >      > +    disp_desc.cursorGlyphHandler =3D ^(NSBitmapImageRep
> *glyph,
> >      >      > +                                     PGDisplayCoord_t
> >     hotSpot) {
> >      >      > +        [glyph retain];
> >      >      > +        dispatch_async(get_background_queue(), ^{
> >      >      > +            BQL_LOCK_GUARD();
> >      >      > +            uint32_t bpp =3D glyph.bitsPerPixel;
> >      >      > +            size_t width =3D glyph.pixelsWide;
> >      >      > +            size_t height =3D glyph.pixelsHigh;
> >      >      > +            size_t padding_bytes_per_row =3D
> >     glyph.bytesPerRow -
> >      >     width * 4;
> >      >      > +            const uint8_t* px_data =3D glyph.bitmapData;
> >      >      > +
> >      >      > +            trace_apple_gfx_cursor_set(bpp, width,
> height);
> >      >      > +
> >      >      > +            if (s->cursor) {
> >      >      > +                cursor_unref(s->cursor);
> >      >      > +                s->cursor =3D NULL;
> >      >      > +            }
> >      >      > +
> >      >      > +            if (bpp =3D=3D 32) { /* Shouldn't be anythin=
g
> >     else, but
> >      >     just to be safe...*/
> >      >      > +                s->cursor =3D cursor_alloc(width, height=
);
> >      >      > +                s->cursor->hot_x =3D hotSpot.x;
> >      >      > +                s->cursor->hot_y =3D hotSpot.y;
> >      >      > +
> >      >      > +                uint32_t *dest_px =3D s->cursor->data;
> >      >      > +
> >      >      > +                for (size_t y =3D 0; y < height; ++y) {
> >      >      > +                    for (size_t x =3D 0; x < width; ++x)=
 {
> >      >      > +                        /* NSBitmapImageRep's red & blue
> >      >     channels are swapped
> >      >      > +                         * compared to QEMUCursor's. */
> >      >      > +                        *dest_px =3D
> >      >      > +                            (px_data[0] << 16u) |
> >      >      > +                            (px_data[1] <<  8u) |
> >      >      > +                            (px_data[2] <<  0u) |
> >      >      > +                            (px_data[3] << 24u);
> >      >      > +                        ++dest_px;
> >      >      > +                        px_data +=3D 4;
> >      >      > +                    }
> >      >      > +                    px_data +=3D padding_bytes_per_row;
> >      >      > +                }
> >      >      > +                dpy_cursor_define(s->con, s->cursor);
> >      >      > +                update_cursor(s);
> >      >      > +            }
> >      >      > +            [glyph release];
> >      >      > +        });
> >      >      > +    };
> >      >      > +    disp_desc.cursorShowHandler =3D ^(BOOL show) {
> >      >      > +        dispatch_async(get_background_queue(), ^{
> >      >      > +            BQL_LOCK_GUARD();
> >      >      > +            trace_apple_gfx_cursor_show(show);
> >      >      > +            s->cursor_show =3D show;
> >      >      > +            update_cursor(s);
> >      >      > +        });
> >      >      > +    };
> >      >      > +    disp_desc.cursorMoveHandler =3D ^(void) {
> >      >      > +        dispatch_async(get_background_queue(), ^{
> >      >      > +            BQL_LOCK_GUARD();
> >      >      > +            trace_apple_gfx_cursor_move();
> >      >      > +            update_cursor(s);
> >      >      > +        });
> >      >      > +    };
> >      >      > +
> >      >      > +    return disp_desc;
> >      >      > +}
> >      >      > +
> >      >      > +static NSArray<PGDisplayMode*>*
> >      >     apple_gfx_prepare_display_mode_array(void)
> >      >      > +{
> >      >      > +    PGDisplayMode *modes[ARRAY_SIZE(apple_gfx_modes)];
> >      >      > +    NSArray<PGDisplayMode*>* mode_array =3D nil;
> >      >      > +    int i;
> >      >      > +
> >      >      > +    for (i =3D 0; i < ARRAY_SIZE(apple_gfx_modes); i++) =
{
> >      >      > +        modes[i] =3D
> >      >      > +            [[PGDisplayMode alloc]
> >      >     initWithSizeInPixels:apple_gfx_modes[i] refreshRateInHz:60.]=
;
> >      >      > +    }
> >      >      > +
> >      >      > +    mode_array =3D [NSArray arrayWithObjects:modes
> >      >     count:ARRAY_SIZE(apple_gfx_modes)];
> >      >      > +
> >      >      > +    for (i =3D 0; i < ARRAY_SIZE(apple_gfx_modes); i++) =
{
> >      >      > +        [modes[i] release];
> >      >      > +        modes[i] =3D nil;
> >      >      > +    }
> >      >      > +
> >      >      > +    return mode_array;
> >      >      > +}
> >      >      > +
> >      >      > +static id<MTLDevice> copy_suitable_metal_device(void)
> >      >      > +{
> >      >      > +    id<MTLDevice> dev =3D nil;
> >      >      > +    NSArray<id<MTLDevice>> *devs =3D MTLCopyAllDevices()=
;
> >      >      > +
> >      >      > +    /* Prefer a unified memory GPU. Failing that, pick a
> non-
> >      >     removable GPU. */
> >      >      > +    for (size_t i =3D 0; i < devs.count; ++i) {
> >      >      > +        if (devs[i].hasUnifiedMemory) {
> >      >      > +            dev =3D devs[i];
> >      >      > +            break;
> >      >      > +        }
> >      >      > +        if (!devs[i].removable) {
> >      >      > +            dev =3D devs[i];
> >      >      > +        }
> >      >      > +    }
> >      >      > +
> >      >      > +    if (dev !=3D nil) {
> >      >      > +        [dev retain];
> >      >      > +    } else {
> >      >      > +        dev =3D MTLCreateSystemDefaultDevice();
> >      >      > +    }
> >      >      > +    [devs release];
> >      >      > +
> >      >      > +    return dev;
> >      >      > +}
> >      >      > +
> >      >      > +void apple_gfx_common_realize(AppleGFXState *s,
> >      >     PGDeviceDescriptor *desc,
> >      >      > +                              Error **errp)
> >      >      > +{
> >      >      > +    PGDisplayDescriptor *disp_desc =3D nil;
> >      >      > +
> >      >      > +    if (apple_gfx_mig_blocker =3D=3D NULL) {
> >      >      > +        error_setg(&apple_gfx_mig_blocker,
> >      >      > +                  "Migration state blocked by apple-gfx
> >     display
> >      >     device");
> >      >      > +        if (migrate_add_blocker(&apple_gfx_mig_blocker,
> >     errp) < 0) {
> >      >      > +            return;
> >      >      > +        }
> >      >      > +    }
> >      >      > +
> >      >      > +    QTAILQ_INIT(&s->tasks);
> >      >      > +    s->render_queue =3D dispatch_queue_create("apple-
> >     gfx.render",
> >      >      > +
> >     DISPATCH_QUEUE_SERIAL);
> >      >      > +    s->mtl =3D copy_suitable_metal_device();
> >      >      > +    s->mtl_queue =3D [s->mtl newCommandQueue];
> >      >      > +
> >      >      > +    desc.device =3D s->mtl;
> >      >      > +
> >      >      > +    apple_gfx_register_task_mapping_handlers(s, desc);
> >      >      > +
> >      >      > +    s->pgdev =3D PGNewDeviceWithDescriptor(desc);
> >      >      > +
> >      >      > +    disp_desc =3D apple_gfx_prepare_display_descriptor(s=
);
> >      >      > +    s->pgdisp =3D [s->pgdev
> newDisplayWithDescriptor:disp_desc
> >      >      > +                                              port:0
> >      >     serialNum:1234];
> >      >      > +    [disp_desc release];
> >      >      > +    s->pgdisp.modeList =3D
> >     apple_gfx_prepare_display_mode_array();
> >      >      > +
> >      >      > +    create_fb(s);
> >      >      > +
> >      >      > +    qemu_mutex_init(&s->job_mutex);
> >      >      > +    qemu_cond_init(&s->job_cond);
> >      >      > +}
> >      >      > diff --git a/hw/display/meson.build
> b/hw/display/meson.build
> >      >      > index 20a94973fa2..619e642905a 100644
> >      >      > --- a/hw/display/meson.build
> >      >      > +++ b/hw/display/meson.build
> >      >      > @@ -61,6 +61,10 @@ system_ss.add(when: 'CONFIG_ARTIST',
> >     if_true:
> >      >     files('artist.c'))
> >      >      >
> >      >      >   system_ss.add(when: 'CONFIG_ATI_VGA', if_true:
> >     [files('ati.c',
> >      >     'ati_2d.c', 'ati_dbg.c'), pixman])
> >      >      >
> >      >      > +system_ss.add(when: 'CONFIG_MAC_PVG',         if_true:
> >      >     [files('apple-gfx.m'), pvg, metal])
> >      >      > +if cpu =3D=3D 'aarch64'
> >      >      > +  system_ss.add(when: 'CONFIG_MAC_PVG_MMIO',  if_true:
> >      >     [files('apple-gfx-mmio.m'), pvg, metal])
> >      >      > +endif
> >      >      >
> >      >      >   if config_all_devices.has_key('CONFIG_VIRTIO_GPU')
> >      >      >     virtio_gpu_ss =3D ss.source_set()
> >      >      > diff --git a/hw/display/trace-events
> b/hw/display/trace-events
> >      >      > index 781f8a33203..214998312b9 100644
> >      >      > --- a/hw/display/trace-events
> >      >      > +++ b/hw/display/trace-events
> >      >      > @@ -191,3 +191,29 @@ dm163_bits_ppi(unsigned dest_width)
> >      >     "dest_width : %u"
> >      >      >   dm163_leds(int led, uint32_t value) "led %d: 0x%x"
> >      >      >   dm163_channels(int channel, uint8_t value) "channel %d:
> >     0x%x"
> >      >      >   dm163_refresh_rate(uint32_t rr) "refresh rate %d"
> >      >      > +
> >      >      > +# apple-gfx.m
> >      >      > +apple_gfx_read(uint64_t offset, uint64_t res)
> >      >     "offset=3D0x%"PRIx64" res=3D0x%"PRIx64
> >      >      > +apple_gfx_write(uint64_t offset, uint64_t val)
> >      >     "offset=3D0x%"PRIx64" val=3D0x%"PRIx64
> >      >      > +apple_gfx_create_task(uint32_t vm_size, void *va)
> >     "vm_size=3D0x%x
> >      >     base_addr=3D%p"
> >      >      > +apple_gfx_destroy_task(void *task) "task=3D%p"
> >      >      > +apple_gfx_map_memory(void *task, uint32_t range_count,
> >     uint64_t
> >      >     virtual_offset, uint32_t read_only) "task=3D%p range_count=
=3D0x%x
> >      >     virtual_offset=3D0x%"PRIx64" read_only=3D%d"
> >      >      > +apple_gfx_map_memory_range(uint32_t i, uint64_t phys_add=
r,
> >      >     uint64_t phys_len) "[%d] phys_addr=3D0x%"PRIx64"
> >     phys_len=3D0x%"PRIx64
> >      >      > +apple_gfx_remap(uint64_t retval, uint64_t source, uint64=
_t
> >      >     target) "retval=3D%"PRId64" source=3D0x%"PRIx64" target=3D0x=
%"PRIx64
> >      >      > +apple_gfx_unmap_memory(void *task, uint64_t
> virtual_offset,
> >      >     uint64_t length) "task=3D%p virtual_offset=3D0x%"PRIx64"
> >     length=3D0x%"PRIx64
> >      >      > +apple_gfx_read_memory(uint64_t phys_address, uint64_t
> length,
> >      >     void *dst) "phys_addr=3D0x%"PRIx64" length=3D0x%"PRIx64" des=
t=3D%p"
> >      >      > +apple_gfx_raise_irq(uint32_t vector) "vector=3D0x%x"
> >      >      > +apple_gfx_new_frame(void) ""
> >      >      > +apple_gfx_mode_change(uint64_t x, uint64_t y) "x=3D%"PRI=
d64"
> >      >     y=3D%"PRId64
> >      >      > +apple_gfx_cursor_set(uint32_t bpp, uint64_t width,
> uint64_t
> >      >     height) "bpp=3D%d width=3D%"PRId64" height=3D0x%"PRId64
> >      >      > +apple_gfx_cursor_show(uint32_t show) "show=3D%d"
> >      >      > +apple_gfx_cursor_move(void) ""
> >      >      > +apple_gfx_common_init(const char *device_name, size_t
> >     mmio_size)
> >      >     "device: %s; MMIO size: %zu bytes"
> >      >      > +
> >      >      > +# apple-gfx-mmio.m
> >      >      > +apple_gfx_mmio_iosfc_read(uint64_t offset, uint64_t res)
> >      >     "offset=3D0x%"PRIx64" res=3D0x%"PRIx64
> >      >      > +apple_gfx_mmio_iosfc_write(uint64_t offset, uint64_t val=
)
> >      >     "offset=3D0x%"PRIx64" val=3D0x%"PRIx64
> >      >      > +apple_gfx_iosfc_map_memory(uint64_t phys, uint64_t len,
> >     uint32_t
> >      >     ro, void *va, void *e, void *f, void* va_result, int success=
)
> >      >     "phys=3D0x%"PRIx64" len=3D0x%"PRIx64" ro=3D%d va=3D%p e=3D%p=
 f=3D%p ->
> >     *va=3D%p,
> >      >     success =3D %d"
> >      >      > +apple_gfx_iosfc_unmap_memory(void *a, void *b, void *c,
> >     void *d,
> >      >     void *e, void *f) "a=3D%p b=3D%p c=3D%p d=3D%p e=3D%p f=3D%p=
"
> >      >      > +apple_gfx_iosfc_raise_irq(uint32_t vector) "vector=3D0x%=
x"
> >      >      > +
> >      >      > diff --git a/meson.build b/meson.build
> >      >      > index d26690ce204..0e124eff13f 100644
> >      >      > --- a/meson.build
> >      >      > +++ b/meson.build
> >      >      > @@ -761,6 +761,8 @@ socket =3D []
> >      >      >   version_res =3D []
> >      >      >   coref =3D []
> >      >      >   iokit =3D []
> >      >      > +pvg =3D []
> >      >      > +metal =3D []
> >      >      >   emulator_link_args =3D []
> >      >      >   midl =3D not_found
> >      >      >   widl =3D not_found
> >      >      > @@ -782,6 +784,8 @@ elif host_os =3D=3D 'darwin'
> >      >      >     coref =3D dependency('appleframeworks', modules:
> >     'CoreFoundation')
> >      >      >     iokit =3D dependency('appleframeworks', modules: 'IOK=
it',
> >      >     required: false)
> >      >      >     host_dsosuf =3D '.dylib'
> >      >      > +  pvg =3D dependency('appleframeworks', modules:
> >      >     'ParavirtualizedGraphics')
> >      >      > +  metal =3D dependency('appleframeworks', modules: 'Meta=
l')
> >      >      >   elif host_os =3D=3D 'sunos'
> >      >      >     socket =3D [cc.find_library('socket'),
> >      >      >               cc.find_library('nsl'),
> >      >
> >
>
>

--000000000000caadfd062585b22f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: base64

PGRpdiBkaXI9Imx0ciI+PGRpdiBkaXI9Imx0ciI+PGJyPjwvZGl2Pjxicj48ZGl2IGNsYXNzPSJn
bWFpbF9xdW90ZSI+PGRpdiBkaXI9Imx0ciIgY2xhc3M9ImdtYWlsX2F0dHIiPk9uIE1vbiwgMjgg
T2N0IDIwMjQgYXQgMDg6NDIsIEFraWhpa28gT2Rha2kgJmx0OzxhIGhyZWY9Im1haWx0bzpha2lo
aWtvLm9kYWtpQGRheW5peC5jb20iPmFraWhpa28ub2Rha2lAZGF5bml4LmNvbTwvYT4mZ3Q7IHdy
b3RlOjxicj48L2Rpdj48YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJn
aW46MHB4IDBweCAwcHggMC44ZXg7Ym9yZGVyLWxlZnQ6MXB4IHNvbGlkIHJnYigyMDQsMjA0LDIw
NCk7cGFkZGluZy1sZWZ0OjFleCI+T24gMjAyNC8xMC8yNiAxOToyNCwgUGhpbCBEZW5uaXMtSm9y
ZGFuIHdyb3RlOjxicj4NCiZndDsgPGJyPg0KJmd0OyA8YnI+DQomZ3Q7IE9uIFNhdCwgMjYgT2N0
IDIwMjQgYXQgMDY6NDAsIEFraWhpa28gT2Rha2kgJmx0OzxhIGhyZWY9Im1haWx0bzpha2loaWtv
Lm9kYWtpQGRheW5peC5jb20iIHRhcmdldD0iX2JsYW5rIj5ha2loaWtvLm9kYWtpQGRheW5peC5j
b208L2E+IDxicj4NCiZndDsgJmx0O21haWx0bzo8YSBocmVmPSJtYWlsdG86YWtpaGlrby5vZGFr
aUBkYXluaXguY29tIiB0YXJnZXQ9Il9ibGFuayI+YWtpaGlrby5vZGFraUBkYXluaXguY29tPC9h
PiZndDsmZ3Q7IHdyb3RlOjxicj4NCiZndDsgPGJyPg0KJmd0O8KgIMKgIMKgT24gMjAyNC8xMC8y
NiA0OjQzLCBQaGlsIERlbm5pcy1Kb3JkYW4gd3JvdGU6PGJyPg0KJmd0O8KgIMKgIMKgICZndDs8
YnI+DQomZ3Q7wqAgwqAgwqAgJmd0Ozxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7IE9uIEZyaSwgMjUg
T2N0IDIwMjQgYXQgMDg6MDMsIEFraWhpa28gT2Rha2k8YnI+DQomZ3Q7wqAgwqAgwqAmbHQ7PGEg
aHJlZj0ibWFpbHRvOmFraWhpa28ub2Rha2lAZGF5bml4LmNvbSIgdGFyZ2V0PSJfYmxhbmsiPmFr
aWhpa28ub2Rha2lAZGF5bml4LmNvbTwvYT4gJmx0O21haWx0bzo8YSBocmVmPSJtYWlsdG86YWtp
aGlrby5vZGFraUBkYXluaXguY29tIiB0YXJnZXQ9Il9ibGFuayI+YWtpaGlrby5vZGFraUBkYXlu
aXguY29tPC9hPiZndDs8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0OyAmbHQ7bWFpbHRvOjxhIGhyZWY9
Im1haWx0bzpha2loaWtvLm9kYWtpQGRheW5peC5jb20iIHRhcmdldD0iX2JsYW5rIj5ha2loaWtv
Lm9kYWtpQGRheW5peC5jb208L2E+PGJyPg0KJmd0O8KgIMKgIMKgJmx0O21haWx0bzo8YSBocmVm
PSJtYWlsdG86YWtpaGlrby5vZGFraUBkYXluaXguY29tIiB0YXJnZXQ9Il9ibGFuayI+YWtpaGlr
by5vZGFraUBkYXluaXguY29tPC9hPiZndDsmZ3Q7Jmd0OyB3cm90ZTo8YnI+DQomZ3Q7wqAgwqAg
wqAgJmd0Ozxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqBPbiAyMDI0LzEwLzI0IDE5OjI4
LCBQaGlsIERlbm5pcy1Kb3JkYW4gd3JvdGU6PGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDC
oCAmZ3Q7ICvCoCDCoCAvKiBGb3IgcnVubmluZyBQVkcgbWVtb3J5LW1hcHBpbmcgcmVxdWVzdHMg
aW4gdGhlIEFJTzxicj4NCiZndDvCoCDCoCDCoGNvbnRleHQgKi88YnI+DQomZ3Q7wqAgwqAgwqAg
Jmd0O8KgIMKgIMKgICZndDsgK8KgIMKgIFFlbXVDb25kIGpvYl9jb25kOzxicj4NCiZndDvCoCDC
oCDCoCAmZ3Q7wqAgwqAgwqAgJmd0OyArwqAgwqAgUWVtdU11dGV4IGpvYl9tdXRleDs8YnI+DQom
Z3Q7wqAgwqAgwqAgJmd0Ozxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqBVc2U6IFFlbXVF
dmVudDxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7PGJyPg0KJmd0O8KgIMKgIMKgICZndDs8YnI+DQom
Z3Q7wqAgwqAgwqAgJmd0OyBIbW0uIEkgdGhpbmsgaWYgd2Ugd2VyZSB0byB1c2UgdGhhdCwgd2Ug
d291bGQgbmVlZCB0byBjcmVhdGUgYSBuZXc8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0OyBRZW11RXZl
bnQgZm9yIGV2ZXJ5IGpvYiBhbmQgZGVzdHJveSBpdCBhZnRlcndhcmQsIHdoaWNoIHNlZW1zPGJy
Pg0KJmd0O8KgIMKgIMKgZXhwZW5zaXZlLjxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7IFdlIGNhbiYj
Mzk7dCBydWxlIG91dCBtdWx0aXBsZSBjb25jdXJyZW50IGpvYnMgYmVpbmcgc3VibWl0dGVkLCBh
bmQgdGhlPGJyPg0KJmd0O8KgIMKgIMKgICZndDsgUWVtdUV2ZW50IHN5c3RlbSBvbmx5IHN1cHBv
cnRzIGEgc2luZ2xlIHByb2R1Y2VyIGFzIGZhciBhcyBJIGNhbjxicj4NCiZndDvCoCDCoCDCoHRl
bGwuPGJyPg0KJmd0O8KgIMKgIMKgICZndDs8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0OyBZb3UgY2Fu
IHByb2JhYmx5IHNvcnQgb2YgaGFjayBhcm91bmQgaXQgd2l0aCBqdXN0IG9uZSBRZW11RXZlbnQg
Ynk8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0OyBwdXR0aW5nIHRoZSBxZW11X2V2ZW50X3dhaXQgaW50
byBhIGxvb3AgYW5kIHR1cm5pbmcgdGhlIGpvYi5kb25lPGJyPg0KJmd0O8KgIMKgIMKgZmxhZzxi
cj4NCiZndDvCoCDCoCDCoCAmZ3Q7IGludG8gYW4gYXRvbWljIChiZWNhdXNlIGl0IHdvdWxkIG5v
dyBuZWVkIHRvIGJlIGNoZWNrZWQgb3V0c2lkZSB0aGU8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0OyBs
b2NrKSBidXQgdGhpcyBhbGwgc2VlbXMgdW5uZWNlc3NhcmlseSBjb21wbGljYXRlZCBjb25zaWRl
cmluZyB0aGU8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0OyBRZW11RXZlbnQgdXNlcyB0aGUgc2FtZSBt
ZWNoYW5pc20gUWVtdUNvbmQvUWVtdU11dGV4IGludGVybmFsbHk8YnI+DQomZ3Q7wqAgwqAgwqBv
biBtYWNPUzxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7ICh0aGUgb25seSBwbGF0Zm9ybSByZWxldmFu
dCBoZXJlKSwgZXhjZXB0IHdlIGNhbiB1c2UgaXQgYXM8YnI+DQomZ3Q7wqAgwqAgwqBpbnRlbmRl
ZCB3aXRoPGJyPg0KJmd0O8KgIMKgIMKgICZndDsgUWVtdUNvbmQvUWVtdU11dGV4IHJhdGhlciB0
aGFuIGhhdmluZyB0byB3b3JrIGFnYWluc3QgdGhlPGJyPg0KJmd0O8KgIMKgIMKgYWJzdHJhY3Rp
b24uPGJyPg0KJmd0OyA8YnI+DQomZ3Q7wqAgwqAgwqBJIGRvbiYjMzk7dCB0aGluayBpdCYjMzk7
cyBnb2luZyB0byBiZSB1c2VkIGNvbmN1cnJlbnRseS4gSXQgd291bGQgYmUgZGlmZmljdWx0PGJy
Pg0KJmd0O8KgIMKgIMKgdG8gcmVhc29uIGV2ZW4gZm9yIHRoZSBmcmFtZXdvcmsgaWYgaXQgcGVy
Zm9ybXMgbWVtb3J5PGJyPg0KJmd0O8KgIMKgIMKgdW5tYXBwaW5nL21hcHBpbmcvcmVhZGluZyBv
cGVyYXRpb25zIGNvbmN1cnJlbnRseS48YnI+DQomZ3Q7IDxicj4NCiZndDsgPGJyPg0KJmd0OyBJ
JiMzOTt2ZSBqdXN0IHBlcmZvcm1lZCBhIHZlcnkgcXVpY2sgdGVzdCBieSB3cmFwcGluZyB0aGUg
am9iIHN1Ym1pc3Npb24vIDxicj4NCiZndDsgd2FpdCBpbiB0aGUgMiBtYXBNZW1vcnkgY2FsbGJh
Y2tzIGFuZCB0aGUgMSByZWFkTWVtb3J5IGNhbGxiYWNrIHdpdGggPGJyPg0KJmd0OyBhdG9taWMg
Y291bnRlcnMgYW5kIGxvZ2dpbmcgd2hlbmV2ZXIgYSBjb3VudGVyIHdlbnQgYWJvdmUgMS48YnI+
DQomZ3Q7IDxicj4NCiZndDvCoCDCoCogT3ZlcmFsbCwgY29uY3VycmVudCBjYWxsYmFja3MgYWNy
b3NzIGFsbCB0eXBlcyB3ZXJlIGNvbW1vbiAobWFueSBwZXIgPGJyPg0KJmd0OyBzZWNvbmQgd2hl
biB0aGUgVk0gaXMgYnVzeSkuIEl0JiMzOTtzIG5vdCBleGFjdGx5IGEgJnF1b3Q7dGh1bmRlcmlu
ZyBoZXJkJnF1b3Q7IChJIDxicj4NCiZndDsgbmV2ZXIgc2F3ICZndDsyKSBidXQgaXQmIzM5O3Mg
cHJvYmFibHkgbm90IGEgYmFkIGlkZWEgdG8gdXNlIGEgc2VwYXJhdGUgPGJyPg0KJmd0OyBjb25k
aXRpb24gdmFyaWFibGUgZm9yIGVhY2ggam9iIHR5cGUuICh0YXNrIG1hcCwgc3VyZmFjZSBtYXAs
IG1lbW9yeSByZWFkKTxicj4NCiZndDvCoCDCoCogV2hpbGUgSSBkaWQgbm90IG9ic2VydmUgYW55
IGNvbmN1cnJlbnQgbWVtb3J5IG1hcHBpbmcgb3BlcmF0aW9ucyA8YnI+DQomZ3Q7ICp3aXRoaW4q
IGEgdHlwZSBvZiBtZW1vcnkgbWFwICgyIHRhc2sgbWFwcGluZ3Mgb3IgMiBzdXJmYWNlIG1hcHBp
bmdzKSBJIDxicj4NCiZndDsgZGlkIHNlZSB2ZXJ5IG9jY2FzaW9uYWwgY29uY3VycmVudCBtZW1v
cnkgKnJlYWQqIGNhbGxiYWNrcy4gVGhlc2Ugd291bGQsIDxicj4NCiZndDsgYXMgZmFyIGFzIEkg
Y2FuIHRlbGwsIG5vdCBiZSBzYWZlIHdpdGggUWVtdUV2ZW50cywgdW5sZXNzIHdlIHBsYWNlZCB0
aGUgPGJyPg0KJmd0OyBldmVudCBpbnNpZGUgdGhlIGpvYiBzdHJ1Y3QgYW5kIGluaXQvZGVzdHJv
eWVkIGl0IG9uIGV2ZXJ5IGNhbGxiYWNrIDxicj4NCiZndDsgKHdoaWNoIHNlZW1zIGxpa2UgZXhj
ZXNzaXZlIG92ZXJoZWFkKS48YnI+DQo8YnI+DQpJIHRoaW5rIHdlIGNhbiB0b2xlcmF0ZSB0aGF0
IG92ZXJoZWFkLiBpbml0L2Rlc3Ryb3kgZXNzZW50aWFsbHkgc2V0cyB0aGUgPGJyPg0KZmllbGRz
IGluIHRoZSBkYXRhIHN0cnVjdHVyZSBhbmQgSSBlc3RpbWF0ZSBpdHMgdG90YWwgc2l6ZSBpcyBh
Ym91dCAxMDAgPGJyPg0KYnl0ZXMuIEl0IGlzIHByb2JhYmx5IGJldHRlciB0aGFuIHdha2luZyBh
biBpcnJlbGV2YW50IHRocmVhZCB1cC4gSSBhbHNvIDxicj4NCmhvcGUgdGhhdCBrZWVwcyB0aGUg
Y29kZSBzaW1wbGU7IGl0JiMzOTtzIG5vdCB3b3J0aHdoaWxlIGFkZGluZyBjb2RlIHRvIDxicj4N
Cm9wdGltaXplIHRoaXMuPGJyPjwvYmxvY2txdW90ZT48ZGl2Pjxicj48L2Rpdj48ZGl2PkF0IGxl
YXN0IHB0aHJlYWRfY29uZF97aW5pdCxkZXN0cm95fSBhbmQgcHRocmVhZF9tdXRleF97aW5pdCxk
ZXN0cm95fSBkb24mIzM5O3QgbWFrZSBhbnkgc3lzY2FsbHMsIHNvIHllYWggaXQmIzM5O3MgcHJv
YmFibHkgYW4gYWNjZXB0YWJsZSBvdmVyaGVhZC48YnI+PC9kaXY+PGRpdj7CoDwvZGl2PjxibG9j
a3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjowcHggMHB4IDBweCAwLjhl
eDtib3JkZXItbGVmdDoxcHggc29saWQgcmdiKDIwNCwyMDQsMjA0KTtwYWRkaW5nLWxlZnQ6MWV4
Ij4NCiZndDsgPGJyPg0KJmd0OyBNeSByZWNvbW1lbmRhdGlvbiB3b3VsZCBiZSB0byBzcGxpdCBp
dCB1cCBpbnRvIDMgcGFpcnMgb2YgbXV0ZXgvY29uZDsgPGJyPg0KJmd0OyB0aGlzIHdpbGwgYWxt
b3N0IGVudGlyZWx5IHJlbW92ZSBhbnkgY29udGVudGlvbiwgYnV0IGNvbnRpbnVlIHRvIGJlIHNh
ZmUgPGJyPg0KJmd0OyBmb3Igd2hlbiBpdCBkb2VzIG9jY3VyLiBJIGRvbiYjMzk7dCB0aGluayBR
ZW11RXZlbnQgaXMgYSByZWFsaXN0aWMgb3B0aW9uIDxicj4NCiZndDsgKHRvbyB0cmlja3kgdG8g
Z2V0IHJpZ2h0KSBmb3IgdGhlIG9ic2VydmVkLWNvbmN1cnJlbnQgcmVhZE1lbW9yeSA8YnI+DQom
Z3Q7IGNhbGxiYWNrLiBJJiMzOTttIG5lcnZvdXMgYWJvdXQgYXNzdW1pbmcgdGhlIG1hcE1lbW9y
eSBjYWxsYmFja3Mgd2lsbCBORVZFUiA8YnI+DQomZ3Q7IGJlIGNhbGxlZCBjb25jdXJyZW50bHks
IGJ1dCBhdCBhIHB1c2ggSSYjMzk7bGwgYWNxdWllc2NlIHRvIHN3aXRjaGluZyB0aG9zZSA8YnI+
DQomZ3Q7IHRvIFFlbXVFdmVudCBpbiB0aGUgYWJzZW5jZSBvZiBldmlkZW5jZSBvZiBjb25jdXJy
ZW5jeS4mZ3Q7ICZndDvCoCDCoCDCoFBHRGV2aWNlLmggYWxzbyBub3Rlczxicj4NCiZndDvCoCDC
oCDCoHJhaXNlSW50ZXJydXB0IG5lZWRzIHRvIGJlIHRocmVhZC1zYWZlIHdoaWxlIGl0IGRvZXNu
JiMzOTt0IG1ha2Ugc3VjaCBub3Rlczxicj4NCiZndDvCoCDCoCDCoGZvciBtZW1vcnkgb3BlcmF0
aW9ucy4gVGhpcyBhY3R1YWxseSBtYWtlcyBzZW5zZS48YnI+DQomZ3Q7IDxicj4NCiZndDvCoCDC
oCDCoElmIGl0JiMzOTtzIGV2ZXIgZ29pbmcgdG8gYmUgdXNlZCBjb25jdXJyZW50bHksIGl0JiMz
OTtzIGJldHRlciB0byBoYXZlPGJyPg0KJmd0O8KgIMKgIMKgUWVtdUV2ZW50IGZvciBlYWNoIGpv
YiB0byBhdm9pZCB0aGUgdGh1bmRlcmluZyBoZXJkIHByb2JsZW0uPGJyPg0KwqAmZ3Q7ICZndDvC
oCDCoCDCoCAmZ3Q7PGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7ICs8YnI+DQom
Z3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZndDsgK8KgIMKgIGRpc3BhdGNoX3F1ZXVlX3QgcmVu
ZGVyX3F1ZXVlOzxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAgJmd0OyArwqAgwqAgLyog
VGhlIGZvbGxvd2luZyBmaWVsZHMgc2hvdWxkIG9ubHkgYmUgYWNjZXNzZWQgZnJvbTxicj4NCiZn
dDvCoCDCoCDCoHRoZSBCUUw6ICovPGJyPg0KJmd0O8KgIMKgIMKgICZndDs8YnI+DQomZ3Q7wqAg
wqAgwqAgJmd0O8KgIMKgIMKgUGVyaGFwcyBpdCBtYXkgYmUgYmV0dGVyIHRvIGRvY3VtZW50IGZp
ZWxkcyB0aGF0IGNhbiBiZSBhY2Nlc3NlZDxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAq
d2l0aG91dCogdGhlIEJRTDsgbW9zdCB0aGluZ3MgaW4gUUVNVSBpbXBsaWNpdGx5IHJlcXVpcmUg
dGhlPGJyPg0KJmd0O8KgIMKgIMKgQlFMLjxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7PGJyPg0KJmd0
O8KgIMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7ICvCoCDCoCBib29sIGdmeF91cGRhdGVfcmVxdWVz
dGVkOzxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAgJmd0OyArwqAgwqAgYm9vbCBuZXdf
ZnJhbWVfcmVhZHk7PGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7ICvCoCDCoCBi
b29sIHVzaW5nX21hbmFnZWRfdGV4dHVyZV9zdG9yYWdlOzxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7
wqAgwqAgwqAgJmd0OyArfSBBcHBsZUdGWFN0YXRlOzxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAg
wqAgwqAgJmd0OyArPGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7ICt2b2lkIGFw
cGxlX2dmeF9jb21tb25faW5pdChPYmplY3QgKm9iaiwgQXBwbGVHRlhTdGF0ZSAqcyw8YnI+DQom
Z3Q7wqAgwqAgwqBjb25zdDxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqBjaGFyKiBvYmpf
bmFtZSk7PGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7ICt2b2lkIGFwcGxlX2dm
eF9jb21tb25fcmVhbGl6ZShBcHBsZUdGWFN0YXRlICpzLDxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7
wqAgwqAgwqBQR0RldmljZURlc2NyaXB0b3IgKmRlc2MsPGJyPg0KJmd0O8KgIMKgIMKgICZndDvC
oCDCoCDCoCAmZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCBFcnJvciAqKmVycnApOzxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAgJmd0OyArdWlu
dHB0cl90IGFwcGxlX2dmeF9ob3N0X2FkZHJlc3NfZm9yX2dwYV9yYW5nZSh1aW50NjRfdDxicj4N
CiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqBndWVzdF9waHlzaWNhbCw8YnI+DQomZ3Q7wqAgwqAg
wqAgJmd0O8KgIMKgIMKgICZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgdWludDY0X3Q8YnI+DQomZ3Q7wqAg
wqAgwqBsZW5ndGgsPGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoGJvb2wgcmVhZF9vbmx5
KTs8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZndDsgK3ZvaWQgYXBwbGVfZ2Z4X2F3
YWl0X2JoX2pvYihBcHBsZUdGWFN0YXRlICpzLCBib29sPGJyPg0KJmd0O8KgIMKgIMKgKmpvYl9k
b25lX2ZsYWcpOzxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAgJmd0OyArPGJyPg0KJmd0
O8KgIMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7ICsjZW5kaWY8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0
O8KgIMKgIMKgICZndDsgKzxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAgJmd0OyBkaWZm
IC0tZ2l0IGEvaHcvZGlzcGxheS9hcHBsZS1nZngubSBiL2h3L2Rpc3BsYXkvYXBwbGUtZ2Z4Lm08
YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZndDsgbmV3IGZpbGUgbW9kZSAxMDA2NDQ8
YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZndDsgaW5kZXggMDAwMDAwMDAwMDAuLjQ2
YmU5OTU3ZjY5PGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7IC0tLSAvZGV2L251
bGw8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZndDsgKysrIGIvaHcvZGlzcGxheS9h
cHBsZS1nZngubTxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAgJmd0OyBAQCAtMCwwICsx
LDcxMyBAQDxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAgJmd0OyArLyo8YnI+DQomZ3Q7
wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZndDsgKyAqIFFFTVUgQXBwbGUgUGFyYXZpcnR1YWxpemVk
R3JhcGhpY3MuZnJhbWV3b3JrIGRldmljZTxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAg
Jmd0OyArICo8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZndDsgKyAqIENvcHlyaWdo
dCDCqSAyMDIzIEFtYXpvbi5jb20sIEluYy4gb3IgaXRzIGFmZmlsaWF0ZXMuIEFsbDxicj4NCiZn
dDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqBSaWdodHMgUmVzZXJ2ZWQuPGJyPg0KJmd0O8KgIMKgIMKg
ICZndDvCoCDCoCDCoCAmZ3Q7ICsgKjxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAgJmd0
OyArICogVGhpcyB3b3JrIGlzIGxpY2Vuc2VkIHVuZGVyIHRoZSB0ZXJtcyBvZiB0aGUgR05VIEdQ
TCw8YnI+DQomZ3Q7wqAgwqAgwqB2ZXJzaW9uPGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDC
oDIgb3IgbGF0ZXIuPGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7ICsgKiBTZWUg
dGhlIENPUFlJTkcgZmlsZSBpbiB0aGUgdG9wLWxldmVsIGRpcmVjdG9yeS48YnI+DQomZ3Q7wqAg
wqAgwqAgJmd0O8KgIMKgIMKgICZndDsgKyAqPGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDC
oCAmZ3Q7ICsgKiBQYXJhdmlydHVhbGl6ZWRHcmFwaGljcy5mcmFtZXdvcmsgaXMgYSBzZXQgb2Y8
YnI+DQomZ3Q7wqAgwqAgwqBsaWJyYXJpZXMgdGhhdDxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAg
wqAgwqBtYWNPUyBwcm92aWRlczxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAgJmd0OyAr
ICogd2hpY2ggaW1wbGVtZW50cyAzZCBncmFwaGljcyBwYXNzdGhyb3VnaCB0byB0aGUgaG9zdDxi
cj4NCiZndDvCoCDCoCDCoGFzIHdlbGwgYXMgYTxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAg
wqAgJmd0OyArICogcHJvcHJpZXRhcnkgZ3Vlc3QgY29tbXVuaWNhdGlvbiBjaGFubmVsIHRvIGRy
aXZlIGl0LiBUaGlzPGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoGRldmljZSBtb2RlbDxi
cj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAgJmd0OyArICogaW1wbGVtZW50cyBzdXBwb3J0
IHRvIGRyaXZlIHRoYXQgbGlicmFyeSBmcm9tIHdpdGhpbiBRRU1VLjxicj4NCiZndDvCoCDCoCDC
oCAmZ3Q7wqAgwqAgwqAgJmd0OyArICovPGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoCAm
Z3Q7ICs8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZndDsgKyNpbmNsdWRlICZxdW90
O3FlbXUvb3NkZXAuaCZxdW90Ozxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAgJmd0OyAr
I2ltcG9ydCAmbHQ7UGFyYXZpcnR1YWxpemVkR3JhcGhpY3MvUGFyYXZpcnR1YWxpemVkR3JhcGhp
Y3MuaCZndDs8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZndDsgKyNpbmNsdWRlICZs
dDttYWNoL21hY2hfdm0uaCZndDs8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZndDsg
KyNpbmNsdWRlICZxdW90O2FwcGxlLWdmeC5oJnF1b3Q7PGJyPg0KJmd0O8KgIMKgIMKgICZndDvC
oCDCoCDCoCAmZ3Q7ICsjaW5jbHVkZSAmcXVvdDt0cmFjZS5oJnF1b3Q7PGJyPg0KJmd0O8KgIMKg
IMKgICZndDvCoCDCoCDCoCAmZ3Q7ICsjaW5jbHVkZSAmcXVvdDtxZW11LW1haW4uaCZxdW90Ozxi
cj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAgJmd0OyArI2luY2x1ZGUgJnF1b3Q7ZXhlYy9h
ZGRyZXNzLXNwYWNlcy5oJnF1b3Q7PGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7
ICsjaW5jbHVkZSAmcXVvdDttaWdyYXRpb24vYmxvY2tlci5oJnF1b3Q7PGJyPg0KJmd0O8KgIMKg
IMKgICZndDvCoCDCoCDCoCAmZ3Q7ICsjaW5jbHVkZSAmcXVvdDttb25pdG9yL21vbml0b3IuaCZx
dW90Ozxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAgJmd0OyArI2luY2x1ZGUgJnF1b3Q7
cWVtdS9tYWluLWxvb3AuaCZxdW90Ozxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAgJmd0
OyArI2luY2x1ZGUgJnF1b3Q7cWVtdS9jdXRpbHMuaCZxdW90Ozxicj4NCiZndDvCoCDCoCDCoCAm
Z3Q7wqAgwqAgwqAgJmd0OyArI2luY2x1ZGUgJnF1b3Q7cWVtdS9sb2cuaCZxdW90Ozxicj4NCiZn
dDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAgJmd0OyArI2luY2x1ZGUgJnF1b3Q7cWFwaS92aXNpdG9y
LmgmcXVvdDs8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZndDsgKyNpbmNsdWRlICZx
dW90O3FhcGkvZXJyb3IuaCZxdW90Ozxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAgJmd0
OyArI2luY2x1ZGUgJnF1b3Q7dWkvY29uc29sZS5oJnF1b3Q7PGJyPg0KJmd0O8KgIMKgIMKgICZn
dDvCoCDCoCDCoCAmZ3Q7ICs8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZndDsgK3N0
YXRpYyBjb25zdCBQR0Rpc3BsYXlDb29yZF90IGFwcGxlX2dmeF9tb2Rlc1tdID0gezxicj4NCiZn
dDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAgJmd0OyArwqAgwqAgeyAueCA9IDE0NDAsIC55ID0gMTA4
MCB9LDxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAgJmd0OyArwqAgwqAgeyAueCA9IDEy
ODAsIC55ID0gMTAyNCB9LDxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAgJmd0OyArfTs8
YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZndDsgKzxicj4NCiZndDvCoCDCoCDCoCAm
Z3Q7wqAgwqAgwqAgJmd0OyArLyogVGhpcyBpbXBsZW1lbnRzIGEgdHlwZSBkZWZpbmVkIGluPGJy
Pg0KJmd0O8KgIMKgIMKgJmx0O1BhcmF2aXJ0dWFsaXplZEdyYXBoaWNzLzxicj4NCiZndDvCoCDC
oCDCoCAmZ3Q7wqAgwqAgwqBQR0RldmljZS5oJmd0Ozxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAg
wqAgwqAgJmd0OyArICogd2hpY2ggaXMgb3BhcXVlIGZyb20gdGhlIGZyYW1ld29yayYjMzk7cyBw
b2ludCBvZiB2aWV3Ljxicj4NCiZndDvCoCDCoCDCoFR5cGVkZWY8YnI+DQomZ3Q7wqAgwqAgwqAg
Jmd0O8KgIMKgIMKgUEdUYXNrX3QgYWxyZWFkeTxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAg
wqAgJmd0OyArICogZXhpc3RzIGluIHRoZSBmcmFtZXdvcmsgaGVhZGVycy4gKi88YnI+DQomZ3Q7
wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZndDsgK3N0cnVjdCBQR1Rhc2tfcyB7PGJyPg0KJmd0O8Kg
IMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7ICvCoCDCoCBRVEFJTFFfRU5UUlkoUEdUYXNrX3MpIG5v
ZGU7PGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7ICvCoCDCoCBtYWNoX3ZtX2Fk
ZHJlc3NfdCBhZGRyZXNzOzxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAgJmd0OyArwqAg
wqAgdWludDY0X3QgbGVuOzxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAgJmd0OyArfTs8
YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZndDsgKzxicj4NCiZndDvCoCDCoCDCoCAm
Z3Q7wqAgwqAgwqAgJmd0OyArc3RhdGljIEVycm9yICphcHBsZV9nZnhfbWlnX2Jsb2NrZXI7PGJy
Pg0KJmd0O8KgIMKgIMKgICZndDs8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgVGhpcyBk
b2VzIG5vdCBoYXZlIHRvIGJlIGEgc3RhdGljIHZhcmlhYmxlLjxicj4NCiZndDvCoCDCoCDCoCAm
Z3Q7PGJyPg0KJmd0O8KgIMKgIMKgICZndDs8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0OyBIbW0sIHRo
ZSBmaXJzdCA1IG9yIHNvIGV4YW1wbGVzIG9mIG1pZ3JhdGlvbiBibG9ja2VycyBpbiBvdGhlcjxi
cj4NCiZndDvCoCDCoCDCoGRldmljZXM8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0OyBldGMuIEkgY291
bGQgZmluZCB3ZXJlIGFsbCBkZWNsYXJlZCBpbiB0aGlzIHdheS4gV2hhdCBhcmUgeW91PGJyPg0K
Jmd0O8KgIMKgIMKgc3VnZ2VzdGluZzxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7IGFzIHRoZSBhbHRl
cm5hdGl2ZT8gQW5kIHdoeSBub3QgdXNlIHRoZSBzYW1lIHBhdHRlcm4gYXMgaW4gbW9zdDxicj4N
CiZndDvCoCDCoCDCoG9mIHRoZTxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7IHJlc3Qgb2YgdGhlIGNv
ZGUgYmFzZT88YnI+DQomZ3Q7IDxicj4NCiZndDvCoCDCoCDCoEkgd2FzIHdyb25nLiBUaGlzIGlz
IGJldHRlciB0byBiZSBhIHN0YXRpYyB2YXJpYWJsZSB0byBlbnN1cmUgd2Ugd29uJiMzOTt0PGJy
Pg0KJmd0O8KgIMKgIMKgYWRkIHRoZSBzYW1lIGJsb2NrZXIgaW4gY2FzZSB3ZSBoYXZlIHR3byBk
ZXZpY2UgaW5zdGFuY2VzLjxicj4NCiZndDsgPGJyPg0KJmd0O8KgIMKgIMKgICZndDs8YnI+DQom
Z3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZndDsgKzxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAg
wqAgwqAgJmd0OyArc3RhdGljIHZvaWQ8YnI+DQomZ3Q7wqAgwqAgwqBhcHBsZV9nZnhfcmVuZGVy
X2ZyYW1lX2NvbXBsZXRlZChBcHBsZUdGWFN0YXRlICpzLDxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7
wqAgwqAgwqAgJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB1aW50MzJfdCB3aWR0aCw8YnI+DQomZ3Q7wqAgwqAg
wqAgJmd0O8KgIMKgIMKgdWludDMyX3QgaGVpZ2h0KTs8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8Kg
IMKgIMKgICZndDsgKzxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAgJmd0OyArc3RhdGlj
IGlubGluZSBkaXNwYXRjaF9xdWV1ZV90IGdldF9iYWNrZ3JvdW5kX3F1ZXVlKHZvaWQpPGJyPg0K
Jmd0O8KgIMKgIMKgICZndDs8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgRG9uJiMzOTt0
IGFkZCBpbmxpbmUuIFRoZSBvbmx5IGVmZmVjdCBmb3IgbW9kZXJuIGNvbXBpbGVycyBvZjxicj4N
CiZndDvCoCDCoCDCoGlubGluZSBpcyB0bzxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqBz
dXBwcmVzcyB0aGUgdW51c2VkIGZ1bmN0aW9uIHdhcm5pbmdzLjxicj4NCiZndDvCoCDCoCDCoCAm
Z3Q7PGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7ICt7PGJyPg0KJmd0O8KgIMKg
IMKgICZndDvCoCDCoCDCoCAmZ3Q7ICvCoCDCoCByZXR1cm48YnI+DQomZ3Q7wqAgwqAgwqAgJmd0
O8KgIMKgIMKgZGlzcGF0Y2hfZ2V0X2dsb2JhbF9xdWV1ZShESVNQQVRDSF9RVUVVRV9QUklPUklU
WV9ERUZBVUxULCAwKTs8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZndDsgK308YnI+
DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZndDsgKzxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7
wqAgwqAgwqAgJmd0OyArc3RhdGljIFBHVGFza190ICphcHBsZV9nZnhfbmV3X3Rhc2soQXBwbGVH
RlhTdGF0ZSAqcyw8YnI+DQomZ3Q7wqAgwqAgwqB1aW50NjRfdCBsZW4pPGJyPg0KJmd0O8KgIMKg
IMKgICZndDvCoCDCoCDCoCAmZ3Q7ICt7PGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoCAm
Z3Q7ICvCoCDCoCBtYWNoX3ZtX2FkZHJlc3NfdCB0YXNrX21lbTs8YnI+DQomZ3Q7wqAgwqAgwqAg
Jmd0O8KgIMKgIMKgICZndDsgK8KgIMKgIFBHVGFza190ICp0YXNrOzxicj4NCiZndDvCoCDCoCDC
oCAmZ3Q7wqAgwqAgwqAgJmd0OyArwqAgwqAga2Vybl9yZXR1cm5fdCByOzxicj4NCiZndDvCoCDC
oCDCoCAmZ3Q7wqAgwqAgwqAgJmd0OyArPGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoCAm
Z3Q7ICvCoCDCoCByID0gbWFjaF92bV9hbGxvY2F0ZShtYWNoX3Rhc2tfc2VsZigpLCAmYW1wO3Rh
c2tfbWVtLCBsZW4sPGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoFZNX0ZMQUdTX0FOWVdI
RVJFKTs8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZndDsgK8KgIMKgIGlmIChyICE9
IEtFUk5fU1VDQ0VTUyB8fCB0YXNrX21lbSA9PSAwKSB7PGJyPg0KJmd0O8KgIMKgIMKgICZndDs8
YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgTGV0JiMzOTtzIHJlbW92ZSB0aGUgY2hlY2sg
Zm9yIHRhc2tfbWVtID09IDAuIFdlIGhhdmUgbm8gcmVhc29uIHRvPGJyPg0KJmd0O8KgIMKgIMKg
ICZndDvCoCDCoCDCoHJlamVjdCBpdDxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqBpZiB0
aGUgcGxhdGZvcm0gaW5zaXN0cyBpdCBhbGxvY2F0ZWQgYSBtZW1vcnkgYXQgYWRkcmVzcyAwIHRo
b3VnaDxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqBzdWNoIGE8YnI+DQomZ3Q7wqAgwqAg
wqAgJmd0O8KgIMKgIMKgc2l0dWF0aW9uIHNob3VsZCBuZXZlciBoYXBwZW4gaW4gcHJhY3RpY2Uu
PGJyPg0KJmd0O8KgIMKgIMKgICZndDs8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZn
dDsgK8KgIMKgIMKgIMKgIHJldHVybiBOVUxMOzxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAg
wqAgJmd0OyArwqAgwqAgfTxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAgJmd0OyArPGJy
Pg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7ICvCoCDCoCB0YXNrID0gZ19uZXcwKFBH
VGFza190LCAxKTs8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZndDsgKzxicj4NCiZn
dDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAgJmd0OyArwqAgwqAgdGFzay0mZ3Q7YWRkcmVzcyA9IHRh
c2tfbWVtOzxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAgJmd0OyArwqAgwqAgdGFzay0m
Z3Q7bGVuID0gbGVuOzxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAgJmd0OyArwqAgwqAg
UVRBSUxRX0lOU0VSVF9UQUlMKCZhbXA7cy0mZ3Q7dGFza3MsIHRhc2ssIG5vZGUpOzxicj4NCiZn
dDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAgJmd0OyArPGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDC
oCDCoCAmZ3Q7ICvCoCDCoCByZXR1cm4gdGFzazs8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKg
IMKgICZndDsgK308YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZndDsgKzxicj4NCiZn
dDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAgJmd0OyArdHlwZWRlZiBzdHJ1Y3QgQXBwbGVHRlhJT0pv
YiB7PGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7ICvCoCDCoCBBcHBsZUdGWFN0
YXRlICpzdGF0ZTs8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZndDsgK8KgIMKgIHVp
bnQ2NF90IG9mZnNldDs8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZndDsgK8KgIMKg
IHVpbnQ2NF90IHZhbHVlOzxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAgJmd0OyArwqAg
wqAgYm9vbCBjb21wbGV0ZWQ7PGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7ICt9
IEFwcGxlR0ZYSU9Kb2I7PGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7ICs8YnI+
DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZndDsgK3N0YXRpYyB2b2lkIGFwcGxlX2dmeF9k
b19yZWFkKHZvaWQgKm9wYXF1ZSk8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZndDsg
K3s8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZndDsgK8KgIMKgIEFwcGxlR0ZYSU9K
b2IgKmpvYiA9IG9wYXF1ZTs8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZndDsgK8Kg
IMKgIGpvYi0mZ3Q7dmFsdWUgPSBbam9iLSZndDtzdGF0ZS0mZ3Q7cGdkZXYgbW1pb1JlYWRBdE9m
ZnNldDpqb2ItPGJyPg0KJmd0O8KgIMKgIMKgICZndDtvZmZzZXRdOzxicj4NCiZndDvCoCDCoCDC
oCAmZ3Q7wqAgwqAgwqAgJmd0OyArwqAgwqAgcWF0b21pY19zZXQoJmFtcDtqb2ItJmd0O2NvbXBs
ZXRlZCwgdHJ1ZSk7PGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7ICvCoCDCoCBh
aW9fd2FpdF9raWNrKCk7PGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7ICt9PGJy
Pg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7ICs8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0
O8KgIMKgIMKgICZndDsgK3N0YXRpYyB1aW50NjRfdCBhcHBsZV9nZnhfcmVhZCh2b2lkICpvcGFx
dWUsIGh3YWRkciBvZmZzZXQsPGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoHVuc2lnbmVk
IHNpemUpPGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7ICt7PGJyPg0KJmd0O8Kg
IMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7ICvCoCDCoCBBcHBsZUdGWElPSm9iIGpvYiA9IHs8YnI+
DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZndDsgK8KgIMKgIMKgIMKgIC5zdGF0ZSA9IG9w
YXF1ZSw8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZndDsgK8KgIMKgIMKgIMKgIC5v
ZmZzZXQgPSBvZmZzZXQsPGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7ICvCoCDC
oCDCoCDCoCAuY29tcGxldGVkID0gZmFsc2UsPGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDC
oCAmZ3Q7ICvCoCDCoCB9Ozxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAgJmd0OyArwqAg
wqAgQWlvQ29udGV4dCAqY29udGV4dCA9IHFlbXVfZ2V0X2Fpb19jb250ZXh0KCk7PGJyPg0KJmd0
O8KgIMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7ICvCoCDCoCBkaXNwYXRjaF9xdWV1ZV90IHF1ZXVl
ID0gZ2V0X2JhY2tncm91bmRfcXVldWUoKTs8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKg
ICZndDsgKzxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAgJmd0OyArwqAgwqAgZGlzcGF0
Y2hfYXN5bmNfZihxdWV1ZSwgJmFtcDtqb2IsIGFwcGxlX2dmeF9kb19yZWFkKTs8YnI+DQomZ3Q7
wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZndDsgK8KgIMKgIEFJT19XQUlUX1dISUxFKGNvbnRleHQs
ICFxYXRvbWljX3JlYWQoJmFtcDtqb2IuY29tcGxldGVkKSk7PGJyPg0KJmd0O8KgIMKgIMKgICZn
dDvCoCDCoCDCoCAmZ3Q7ICs8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZndDsgK8Kg
IMKgIHRyYWNlX2FwcGxlX2dmeF9yZWFkKG9mZnNldCwgam9iLnZhbHVlKTs8YnI+DQomZ3Q7wqAg
wqAgwqAgJmd0O8KgIMKgIMKgICZndDsgK8KgIMKgIHJldHVybiBqb2IudmFsdWU7PGJyPg0KJmd0
O8KgIMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7ICt9PGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDC
oCDCoCAmZ3Q7ICs8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZndDsgK3N0YXRpYyB2
b2lkIGFwcGxlX2dmeF9kb193cml0ZSh2b2lkICpvcGFxdWUpPGJyPg0KJmd0O8KgIMKgIMKgICZn
dDvCoCDCoCDCoCAmZ3Q7ICt7PGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7ICvC
oCDCoCBBcHBsZUdGWElPSm9iICpqb2IgPSBvcGFxdWU7PGJyPg0KJmd0O8KgIMKgIMKgICZndDvC
oCDCoCDCoCAmZ3Q7ICvCoCDCoCBbam9iLSZndDtzdGF0ZS0mZ3Q7cGdkZXYgbW1pb1dyaXRlQXRP
ZmZzZXQ6am9iLSZndDtvZmZzZXQ8YnI+DQomZ3Q7wqAgwqAgwqB2YWx1ZTpqb2ItPGJyPg0KJmd0
O8KgIMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7dmFsdWVdOzxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7
wqAgwqAgwqAgJmd0OyArwqAgwqAgcWF0b21pY19zZXQoJmFtcDtqb2ItJmd0O2NvbXBsZXRlZCwg
dHJ1ZSk7PGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7ICvCoCDCoCBhaW9fd2Fp
dF9raWNrKCk7PGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7ICt9PGJyPg0KJmd0
O8KgIMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7ICs8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKg
IMKgICZndDsgK3N0YXRpYyB2b2lkIGFwcGxlX2dmeF93cml0ZSh2b2lkICpvcGFxdWUsIGh3YWRk
ciBvZmZzZXQsPGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoHVpbnQ2NF90IHZhbCw8YnI+
DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIHVuc2lnbmVkIHNpemUpPGJyPg0KJmd0O8KgIMKgIMKgICZndDvC
oCDCoCDCoCAmZ3Q7ICt7PGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7ICvCoCDC
oCAvKiBUaGUgbWV0aG9kcyBtbWlvUmVhZEF0T2Zmc2V0OiBhbmQgZXNwZWNpYWxseTxicj4NCiZn
dDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqBtbWlvV3JpdGVBdE9mZnNldDogY2FuPGJyPg0KJmd0O8Kg
IMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7ICvCoCDCoCDCoCogdHJpZ2dlciBhbmQgYmxvY2sgb24g
b3BlcmF0aW9ucyBvbiBvdGhlciBkaXNwYXRjaDxicj4NCiZndDvCoCDCoCDCoHF1ZXVlcyw8YnI+
DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgd2hpY2ggaW4gdHVybjxicj4NCiZndDvCoCDCoCDC
oCAmZ3Q7wqAgwqAgwqAgJmd0OyArwqAgwqAgwqAqIG1heSBjYWxsIGJhY2sgb3V0IG9uIG9uZSBv
ciBtb3JlIG9mIHRoZSBjYWxsYmFjazxicj4NCiZndDvCoCDCoCDCoGJsb2Nrcy48YnI+DQomZ3Q7
wqAgwqAgwqAgJmd0O8KgIMKgIMKgRm9yIHRoaXMgcmVhc29uLDxicj4NCiZndDvCoCDCoCDCoCAm
Z3Q7wqAgwqAgwqAgJmd0OyArwqAgwqAgwqAqIGFuZCBhcyB3ZSBhcmUgaG9sZGluZyB0aGUgQlFM
LCB3ZSBpbnZva2UgdGhlIEkvTzxicj4NCiZndDvCoCDCoCDCoG1ldGhvZHM8YnI+DQomZ3Q7wqAg
wqAgwqAgJmd0O8KgIMKgIMKgb24gYSBwb29sPGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDC
oCAmZ3Q7ICvCoCDCoCDCoCogdGhyZWFkIGFuZCBoYW5kbGUgQUlPIHRhc2tzIHdoaWxlIHdlIHdh
aXQuIEFueSB3b3JrIGluPGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoHRoZSBjYWxsYmFj
a3M8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZndDsgK8KgIMKgIMKgKiByZXF1aXJp
bmcgdGhlIEJRTCB3aWxsIGluIHR1cm4gc2NoZWR1bGUgQkhzIHdoaWNoIHRoaXM8YnI+DQomZ3Q7
wqAgwqAgwqAgJmd0O8KgIMKgIMKgdGhyZWFkIHdpbGw8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8Kg
IMKgIMKgICZndDsgK8KgIMKgIMKgKiBwcm9jZXNzIHdoaWxlIHdhaXRpbmcuICovPGJyPg0KJmd0
O8KgIMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7ICvCoCDCoCBBcHBsZUdGWElPSm9iIGpvYiA9IHs8
YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZndDsgK8KgIMKgIMKgIMKgIC5zdGF0ZSA9
IG9wYXF1ZSw8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZndDsgK8KgIMKgIMKgIMKg
IC5vZmZzZXQgPSBvZmZzZXQsPGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7ICvC
oCDCoCDCoCDCoCAudmFsdWUgPSB2YWwsPGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoCAm
Z3Q7ICvCoCDCoCDCoCDCoCAuY29tcGxldGVkID0gZmFsc2UsPGJyPg0KJmd0O8KgIMKgIMKgICZn
dDvCoCDCoCDCoCAmZ3Q7ICvCoCDCoCB9Ozxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAg
Jmd0OyArwqAgwqAgQWlvQ29udGV4dCAqY29udGV4dCA9IHFlbXVfZ2V0X2N1cnJlbnRfYWlvX2Nv
bnRleHQoKTs8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZndDsgK8KgIMKgIGRpc3Bh
dGNoX3F1ZXVlX3QgcXVldWUgPSBnZXRfYmFja2dyb3VuZF9xdWV1ZSgpOzxicj4NCiZndDvCoCDC
oCDCoCAmZ3Q7wqAgwqAgwqAgJmd0OyArPGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoCAm
Z3Q7ICvCoCDCoCBkaXNwYXRjaF9hc3luY19mKHF1ZXVlLCAmYW1wO2pvYiwgYXBwbGVfZ2Z4X2Rv
X3dyaXRlKTs8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZndDsgK8KgIMKgIEFJT19X
QUlUX1dISUxFKGNvbnRleHQsICFxYXRvbWljX3JlYWQoJmFtcDtqb2IuY29tcGxldGVkKSk7PGJy
Pg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7ICs8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0
O8KgIMKgIMKgICZndDsgK8KgIMKgIHRyYWNlX2FwcGxlX2dmeF93cml0ZShvZmZzZXQsIHZhbCk7
PGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7ICt9PGJyPg0KJmd0O8KgIMKgIMKg
ICZndDvCoCDCoCDCoCAmZ3Q7ICs8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZndDsg
K3N0YXRpYyBjb25zdCBNZW1vcnlSZWdpb25PcHMgYXBwbGVfZ2Z4X29wcyA9IHs8YnI+DQomZ3Q7
wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZndDsgK8KgIMKgIC5yZWFkID0gYXBwbGVfZ2Z4X3JlYWQs
PGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7ICvCoCDCoCAud3JpdGUgPSBhcHBs
ZV9nZnhfd3JpdGUsPGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7ICvCoCDCoCAu
ZW5kaWFubmVzcyA9IERFVklDRV9MSVRUTEVfRU5ESUFOLDxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7
wqAgwqAgwqAgJmd0OyArwqAgwqAgLnZhbGlkID0gezxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAg
wqAgwqAgJmd0OyArwqAgwqAgwqAgwqAgLm1pbl9hY2Nlc3Nfc2l6ZSA9IDQsPGJyPg0KJmd0O8Kg
IMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7ICvCoCDCoCDCoCDCoCAubWF4X2FjY2Vzc19zaXplID0g
OCw8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZndDsgK8KgIMKgIH0sPGJyPg0KJmd0
O8KgIMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7ICvCoCDCoCAuaW1wbCA9IHs8YnI+DQomZ3Q7wqAg
wqAgwqAgJmd0O8KgIMKgIMKgICZndDsgK8KgIMKgIMKgIMKgIC5taW5fYWNjZXNzX3NpemUgPSA0
LDxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAgJmd0OyArwqAgwqAgwqAgwqAgLm1heF9h
Y2Nlc3Nfc2l6ZSA9IDQsPGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7ICvCoCDC
oCB9LDxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAgJmd0OyArfTs8YnI+DQomZ3Q7wqAg
wqAgwqAgJmd0O8KgIMKgIMKgICZndDsgKzxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAg
Jmd0OyArc3RhdGljIHZvaWQ8YnI+DQomZ3Q7wqAgwqAgwqBhcHBsZV9nZnhfcmVuZGVyX25ld19m
cmFtZV9icWxfdW5sb2NrKEFwcGxlR0ZYU3RhdGUgKnMpPGJyPg0KJmd0O8KgIMKgIMKgICZndDvC
oCDCoCDCoCAmZ3Q7ICt7PGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7ICvCoCDC
oCBCT09MIHI7PGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7ICvCoCDCoCB1aW50
MzJfdCB3aWR0aCA9IHN1cmZhY2Vfd2lkdGgocy0mZ3Q7c3VyZmFjZSk7PGJyPg0KJmd0O8KgIMKg
IMKgICZndDvCoCDCoCDCoCAmZ3Q7ICvCoCDCoCB1aW50MzJfdCBoZWlnaHQgPSBzdXJmYWNlX2hl
aWdodChzLSZndDtzdXJmYWNlKTs8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZndDsg
K8KgIMKgIE1UTFJlZ2lvbiByZWdpb24gPSBNVExSZWdpb25NYWtlMkQoMCwgMCwgd2lkdGgsIGhl
aWdodCk7PGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7ICvCoCDCoCBpZCZsdDtN
VExDb21tYW5kQnVmZmVyJmd0OyBjb21tYW5kX2J1ZmZlciA9IFtzLSZndDttdGxfcXVldWU8YnI+
DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgY29tbWFuZEJ1ZmZlcl07PGJyPg0KJmd0O8KgIMKg
IMKgICZndDvCoCDCoCDCoCAmZ3Q7ICvCoCDCoCBpZCZsdDtNVExUZXh0dXJlJmd0OyB0ZXh0dXJl
ID0gcy0mZ3Q7dGV4dHVyZTs8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZndDsgKzxi
cj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAgJmd0OyArwqAgwqAgYXNzZXJ0KGJxbF9sb2Nr
ZWQoKSk7PGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7ICvCoCDCoCBbdGV4dHVy
ZSByZXRhaW5dOzxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAgJmd0OyArPGJyPg0KJmd0
O8KgIMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7ICvCoCDCoCBicWxfdW5sb2NrKCk7PGJyPg0KJmd0
O8KgIMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7ICs8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKg
IMKgICZndDsgK8KgIMKgIC8qIFRoaXMgaXMgbm90IHNhZmUgdG8gY2FsbCBmcm9tIHRoZSBCUUwg
ZHVlIHRvIFBWRy08YnI+DQomZ3Q7wqAgwqAgwqBpbnRlcm5hbDxicj4NCiZndDvCoCDCoCDCoCAm
Z3Q7wqAgwqAgwqBsb2NrcyBjYXVzaW5nPGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoCAm
Z3Q7ICvCoCDCoCDCoCogZGVhZGxvY2tzLiAqLzxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAg
wqAgJmd0OyArwqAgwqAgciA9IFtzLSZndDtwZ2Rpc3A8YnI+DQomZ3Q7wqAgwqAgwqBlbmNvZGVD
dXJyZW50RnJhbWVUb0NvbW1hbmRCdWZmZXI6Y29tbWFuZF9idWZmZXI8YnI+DQomZ3Q7wqAgwqAg
wqAgJmd0O8KgIMKgIMKgICZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgdGV4dHVyZTp0ZXh0dXJlPGJyPg0KJmd0
O8KgIMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCByZWdpb246cmVnaW9uXTs8
YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZndDsgK8KgIMKgIGlmICghcikgezxicj4N
CiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAgJmd0OyArwqAgwqAgwqAgwqAgW3RleHR1cmUgcmVs
ZWFzZV07PGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7ICvCoCDCoCDCoCDCoCBi
cWxfbG9jaygpOzxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAgJmd0OyArwqAgwqAgwqAg
wqAgLS1zLSZndDtwZW5kaW5nX2ZyYW1lczs8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKg
ICZndDsgK8KgIMKgIMKgIMKgIGJxbF91bmxvY2soKTs8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8Kg
IMKgIMKgICZndDsgK8KgIMKgIMKgIMKgIHFlbXVfbG9nX21hc2soTE9HX0dVRVNUX0VSUk9SLDxi
cj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAmcXVvdDthcHBsZV9nZnhfcmVuZGVyX25ld19m
cmFtZV9icWxfdW5sb2NrOiAmcXVvdDs8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0Ozxicj4NCiZndDvC
oCDCoCDCoCAmZ3Q7wqAgwqAgwqBVc2U6IF9fZnVuY19fPGJyPg0KJmd0O8KgIMKgIMKgICZndDs8
YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZndDsgKzxicj4NCiZndDvCoCDCoCDCoCAm
Z3Q7wqAgwqAgwqAmcXVvdDtlbmNvZGVDdXJyZW50RnJhbWVUb0NvbW1hbmRCdWZmZXI6dGV4dHVy
ZTpyZWdpb246IGZhaWxlZFxuJnF1b3Q7KTs8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKg
ICZndDsgK8KgIMKgIMKgIMKgIHJldHVybjs8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKg
ICZndDsgK8KgIMKgIH08YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZndDsgKzxicj4N
CiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAgJmd0OyArwqAgwqAgaWYgKHMtJmd0O3VzaW5nX21h
bmFnZWRfdGV4dHVyZV9zdG9yYWdlKSB7PGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoCAm
Z3Q7ICvCoCDCoCDCoCDCoCAvKiAmcXVvdDtNYW5hZ2VkJnF1b3Q7IHRleHR1cmVzIGV4aXN0IGlu
IGJvdGggVlJBTSBhbmQgUkFNIGFuZDxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqBtdXN0
IGJlIHN5bmNlZC4gKi88YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZndDsgK8KgIMKg
IMKgIMKgIGlkJmx0O01UTEJsaXRDb21tYW5kRW5jb2RlciZndDsgYmxpdCA9IFtjb21tYW5kX2J1
ZmZlcjxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqBibGl0Q29tbWFuZEVuY29kZXJdOzxi
cj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAgJmd0OyArwqAgwqAgwqAgwqAgW2JsaXQgc3lu
Y2hyb25pemVSZXNvdXJjZTp0ZXh0dXJlXTs8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKg
ICZndDsgK8KgIMKgIMKgIMKgIFtibGl0IGVuZEVuY29kaW5nXTs8YnI+DQomZ3Q7wqAgwqAgwqAg
Jmd0O8KgIMKgIMKgICZndDsgK8KgIMKgIH08YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKg
ICZndDsgK8KgIMKgIFt0ZXh0dXJlIHJlbGVhc2VdOzxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAg
wqAgwqAgJmd0OyArwqAgwqAgW2NvbW1hbmRfYnVmZmVyIGFkZENvbXBsZXRlZEhhbmRsZXI6PGJy
Pg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7ICvCoCDCoCDCoCDCoCBeKGlkJmx0O01U
TENvbW1hbmRCdWZmZXImZ3Q7IGNiKTxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAgJmd0
OyArwqAgwqAgwqAgwqAgezxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAgJmd0OyArwqAg
wqAgwqAgwqAgwqAgwqAgZGlzcGF0Y2hfYXN5bmMocy0mZ3Q7cmVuZGVyX3F1ZXVlLCBeezxicj4N
CiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAgJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
YXBwbGVfZ2Z4X3JlbmRlcl9mcmFtZV9jb21wbGV0ZWQocyw8YnI+DQomZ3Q7wqAgwqAgwqB3aWR0
aCwgaGVpZ2h0KTs8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZndDsgK8KgIMKgIMKg
IMKgIMKgIMKgIH0pOzxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAgJmd0OyArwqAgwqAg
wqAgwqAgfV07PGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7ICvCoCDCoCBbY29t
bWFuZF9idWZmZXIgY29tbWl0XTs8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZndDsg
K308YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZndDsgKzxicj4NCiZndDvCoCDCoCDC
oCAmZ3Q7wqAgwqAgwqAgJmd0OyArc3RhdGljIHZvaWQgY29weV9tdGxfdGV4dHVyZV90b19zdXJm
YWNlX21lbShpZCZsdDtNVExUZXh0dXJlJmd0Ozxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAg
wqB0ZXh0dXJlLCB2b2lkICp2cmFtKTxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAgJmd0
OyArezxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAgJmd0OyArwqAgwqAgLyogVE9ETzog
U2tpcCB0aGlzIGVudGlyZWx5IG9uIGEgcHVyZSBNZXRhbCBvciBoZWFkbGVzcy88YnI+DQomZ3Q7
wqAgwqAgwqAgJmd0O8KgIMKgIMKgZ3Vlc3Qtb25seTxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAg
wqAgwqAgJmd0OyArwqAgwqAgwqAqIHJlbmRlcmluZyBwYXRoLCBlbHNlIHVzZSBhIGJsaXQgY29t
bWFuZCBlbmNvZGVyPyBOZWVkczxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqBjYXJlZnVs
PGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7ICvCoCDCoCDCoCogKGRvdWJsZT8p
IGJ1ZmZlcmluZyBkZXNpZ24uICovPGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7
ICvCoCDCoCBzaXplX3Qgd2lkdGggPSB0ZXh0dXJlLndpZHRoLCBoZWlnaHQgPSB0ZXh0dXJlLmhl
aWdodDs8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZndDsgK8KgIMKgIE1UTFJlZ2lv
biByZWdpb24gPSBNVExSZWdpb25NYWtlMkQoMCwgMCwgd2lkdGgsIGhlaWdodCk7PGJyPg0KJmd0
O8KgIMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7ICvCoCDCoCBbdGV4dHVyZSBnZXRCeXRlczp2cmFt
PGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7ICvCoCDCoCDCoCDCoCDCoCBieXRl
c1BlclJvdzood2lkdGggKiA0KTxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAgJmd0OyAr
wqAgwqAgwqAgwqAgYnl0ZXNQZXJJbWFnZTood2lkdGggKiBoZWlnaHQgKiA0KTxicj4NCiZndDvC
oCDCoCDCoCAmZ3Q7wqAgwqAgwqAgJmd0OyArwqAgwqAgwqAgwqAgwqAgwqBmcm9tUmVnaW9uOnJl
Z2lvbjxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAgJmd0OyArwqAgwqAgwqAgwqAgwqAg
bWlwbWFwTGV2ZWw6MDxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAgJmd0OyArwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgc2xpY2U6MF07PGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDC
oCAmZ3Q7ICt9Y29weV9tdGxfdGV4dHVyZV90b19zdXJmYWNlX21lbTxicj4NCiZndDvCoCDCoCDC
oCAmZ3Q7wqAgwqAgwqAgJmd0OyArPGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7
ICtzdGF0aWMgdm9pZDxicj4NCiZndDvCoCDCoCDCoGFwcGxlX2dmeF9yZW5kZXJfZnJhbWVfY29t
cGxldGVkKEFwcGxlR0ZYU3RhdGUgKnMsPGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoCAm
Z3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoHVpbnQzMl90IHdpZHRoLDxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAg
wqAgwqB1aW50MzJfdCBoZWlnaHQpPGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7
ICt7PGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7ICvCoCDCoCBicWxfbG9jaygp
Ozxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAgJmd0OyArwqAgwqAgLS1zLSZndDtwZW5k
aW5nX2ZyYW1lczs8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZndDsgK8KgIMKgIGFz
c2VydChzLSZndDtwZW5kaW5nX2ZyYW1lcyAmZ3Q7PSAwKTs8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0
O8KgIMKgIMKgICZndDsgKzxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAgJmd0OyArwqAg
wqAgLyogT25seSB1cGRhdGUgZGlzcGxheSBpZiBtb2RlIGhhc24mIzM5O3QgY2hhbmdlZCBzaW5j
ZSB3ZTxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqBzdGFydGVkIHJlbmRlcmluZy4gKi88
YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZndDsgK8KgIMKgIGlmICh3aWR0aCA9PSBz
dXJmYWNlX3dpZHRoKHMtJmd0O3N1cmZhY2UpICZhbXA7JmFtcDs8YnI+DQomZ3Q7wqAgwqAgwqAg
Jmd0O8KgIMKgIMKgICZndDsgK8KgIMKgIMKgIMKgIGhlaWdodCA9PSBzdXJmYWNlX2hlaWdodChz
LSZndDtzdXJmYWNlKSkgezxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAgJmd0OyArwqAg
wqAgwqAgwqAgY29weV9tdGxfdGV4dHVyZV90b19zdXJmYWNlX21lbShzLSZndDt0ZXh0dXJlLCBz
LSZndDt2cmFtKTs8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZndDsgK8KgIMKgIMKg
IMKgIGlmIChzLSZndDtnZnhfdXBkYXRlX3JlcXVlc3RlZCkgezxicj4NCiZndDvCoCDCoCDCoCAm
Z3Q7wqAgwqAgwqAgJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgcy0mZ3Q7Z2Z4X3VwZGF0ZV9yZXF1
ZXN0ZWQgPSBmYWxzZTs8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZndDsgK8KgIMKg
IMKgIMKgIMKgIMKgIGRweV9nZnhfdXBkYXRlX2Z1bGwocy0mZ3Q7Y29uKTs8YnI+DQomZ3Q7wqAg
wqAgwqAgJmd0O8KgIMKgIMKgICZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIGdyYXBoaWNfaHdfdXBk
YXRlX2RvbmUocy0mZ3Q7Y29uKTs8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZndDsg
K8KgIMKgIMKgIMKgIMKgIMKgIHMtJmd0O25ld19mcmFtZV9yZWFkeSA9IGZhbHNlOzxicj4NCiZn
dDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAgJmd0OyArwqAgwqAgwqAgwqAgfSBlbHNlIHs8YnI+DQom
Z3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIHMtJmd0O25l
d19mcmFtZV9yZWFkeSA9IHRydWU7PGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7
ICvCoCDCoCDCoCDCoCB9PGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7ICvCoCDC
oCB9PGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7ICvCoCDCoCBpZiAocy0mZ3Q7
cGVuZGluZ19mcmFtZXMgJmd0OyAwKSB7PGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoCAm
Z3Q7ICvCoCDCoCDCoCDCoCBhcHBsZV9nZnhfcmVuZGVyX25ld19mcmFtZV9icWxfdW5sb2NrKHMp
Ozxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAgJmd0OyArwqAgwqAgfSBlbHNlIHs8YnI+
DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZndDsgK8KgIMKgIMKgIMKgIGJxbF91bmxvY2so
KTs8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZndDsgK8KgIMKgIH08YnI+DQomZ3Q7
wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZndDsgK308YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKg
IMKgICZndDsgKzxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAgJmd0OyArc3RhdGljIHZv
aWQgYXBwbGVfZ2Z4X2ZiX3VwZGF0ZV9kaXNwbGF5KHZvaWQgKm9wYXF1ZSk8YnI+DQomZ3Q7wqAg
wqAgwqAgJmd0O8KgIMKgIMKgICZndDsgK3s8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKg
ICZndDsgK8KgIMKgIEFwcGxlR0ZYU3RhdGUgKnMgPSBvcGFxdWU7PGJyPg0KJmd0O8KgIMKgIMKg
ICZndDvCoCDCoCDCoCAmZ3Q7ICs8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZndDsg
K8KgIMKgIGFzc2VydChicWxfbG9ja2VkKCkpOzxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAg
wqAgJmd0OyArwqAgwqAgaWYgKHMtJmd0O25ld19mcmFtZV9yZWFkeSkgezxicj4NCiZndDvCoCDC
oCDCoCAmZ3Q7wqAgwqAgwqAgJmd0OyArwqAgwqAgwqAgwqAgZHB5X2dmeF91cGRhdGVfZnVsbChz
LSZndDtjb24pOzxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAgJmd0OyArwqAgwqAgwqAg
wqAgcy0mZ3Q7bmV3X2ZyYW1lX3JlYWR5ID0gZmFsc2U7PGJyPg0KJmd0O8KgIMKgIMKgICZndDvC
oCDCoCDCoCAmZ3Q7ICvCoCDCoCDCoCDCoCBncmFwaGljX2h3X3VwZGF0ZV9kb25lKHMtJmd0O2Nv
bik7PGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7ICvCoCDCoCB9IGVsc2UgaWYg
KHMtJmd0O3BlbmRpbmdfZnJhbWVzICZndDsgMCkgezxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAg
wqAgwqAgJmd0OyArwqAgwqAgwqAgwqAgcy0mZ3Q7Z2Z4X3VwZGF0ZV9yZXF1ZXN0ZWQgPSB0cnVl
Ozxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAgJmd0OyArwqAgwqAgfSBlbHNlIHs8YnI+
DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZndDsgK8KgIMKgIMKgIMKgIGdyYXBoaWNfaHdf
dXBkYXRlX2RvbmUocy0mZ3Q7Y29uKTs8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZn
dDsgK8KgIMKgIH08YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZndDsgK308YnI+DQom
Z3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZndDsgKzxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAg
wqAgwqAgJmd0OyArc3RhdGljIGNvbnN0IEdyYXBoaWNId09wcyBhcHBsZV9nZnhfZmJfb3BzID0g
ezxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAgJmd0OyArwqAgwqAgLmdmeF91cGRhdGUg
PSBhcHBsZV9nZnhfZmJfdXBkYXRlX2Rpc3BsYXksPGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDC
oCDCoCAmZ3Q7ICvCoCDCoCAuZ2Z4X3VwZGF0ZV9hc3luYyA9IHRydWUsPGJyPg0KJmd0O8KgIMKg
IMKgICZndDvCoCDCoCDCoCAmZ3Q7ICt9Ozxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAg
Jmd0OyArPGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7ICtzdGF0aWMgdm9pZCB1
cGRhdGVfY3Vyc29yKEFwcGxlR0ZYU3RhdGUgKnMpPGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDC
oCDCoCAmZ3Q7ICt7PGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7ICvCoCDCoCBh
c3NlcnQoYnFsX2xvY2tlZCgpKTs8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZndDsg
K8KgIMKgIGRweV9tb3VzZV9zZXQocy0mZ3Q7Y29uLCBzLSZndDtwZ2Rpc3AuY3Vyc29yUG9zaXRp
b24ueCw8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZndDsgK8KgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIHMtJmd0O3BnZGlzcC5jdXJzb3JQb3NpdGlvbi55LCBzLTxicj4NCiZndDvC
oCDCoCDCoCAmZ3Q7Y3Vyc29yX3Nob3cpOzxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAg
Jmd0OyArfTxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAgJmd0OyArPGJyPg0KJmd0O8Kg
IMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7ICtzdGF0aWMgdm9pZCBzZXRfbW9kZShBcHBsZUdGWFN0
YXRlICpzLCB1aW50MzJfdCB3aWR0aCw8YnI+DQomZ3Q7wqAgwqAgwqB1aW50MzJfdDxicj4NCiZn
dDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqBoZWlnaHQpPGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDC
oCDCoCAmZ3Q7ICt7PGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7ICvCoCDCoCBN
VExUZXh0dXJlRGVzY3JpcHRvciAqdGV4dHVyZURlc2NyaXB0b3I7PGJyPg0KJmd0O8KgIMKgIMKg
ICZndDvCoCDCoCDCoCAmZ3Q7ICs8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZndDsg
K8KgIMKgIGlmIChzLSZndDtzdXJmYWNlICZhbXA7JmFtcDs8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0
O8KgIMKgIMKgICZndDsgK8KgIMKgIMKgIMKgIHdpZHRoID09IHN1cmZhY2Vfd2lkdGgocy0mZ3Q7
c3VyZmFjZSkgJmFtcDsmYW1wOzxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAgJmd0OyAr
wqAgwqAgwqAgwqAgaGVpZ2h0ID09IHN1cmZhY2VfaGVpZ2h0KHMtJmd0O3N1cmZhY2UpKSB7PGJy
Pg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7ICvCoCDCoCDCoCDCoCByZXR1cm47PGJy
Pg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7ICvCoCDCoCB9PGJyPg0KJmd0O8KgIMKg
IMKgICZndDvCoCDCoCDCoCAmZ3Q7ICs8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZn
dDsgK8KgIMKgIGdfZnJlZShzLSZndDt2cmFtKTs8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKg
IMKgICZndDsgK8KgIMKgIFtzLSZndDt0ZXh0dXJlIHJlbGVhc2VdOzxicj4NCiZndDvCoCDCoCDC
oCAmZ3Q7wqAgwqAgwqAgJmd0OyArPGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7
ICvCoCDCoCBzLSZndDt2cmFtID0gZ19tYWxsb2MwX24od2lkdGggKiBoZWlnaHQsIDQpOzxicj4N
CiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAgJmd0OyArwqAgwqAgcy0mZ3Q7c3VyZmFjZSA9IHFl
bXVfY3JlYXRlX2Rpc3BsYXlzdXJmYWNlX2Zyb20od2lkdGgsPGJyPg0KJmd0O8KgIMKgIMKgaGVp
Z2h0LDxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqBQSVhNQU5fTEVfYThyOGc4YjgsPGJy
Pg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHdpZHRo
ICo8YnI+DQomZ3Q7wqAgwqAgwqA0LCBzLTxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAg
Jmd0O3ZyYW0pOyZndDsgKyZndDsgK8KgIMKgIEBhdXRvcmVsZWFzZXBvb2wgezxicj4NCiZndDvC
oCDCoCDCoCAmZ3Q7wqAgwqAgwqAgJmd0OyArwqAgwqAgwqAgwqAgdGV4dHVyZURlc2NyaXB0b3Ig
PTxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAgJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAg
W01UTFRleHR1cmVEZXNjcmlwdG9yPGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7
ICs8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgdGV4dHVyZTJERGVzY3JpcHRvcldpdGhQ
aXhlbEZvcm1hdDpNVExQaXhlbEZvcm1hdEJHUkE4VW5vcm08YnI+DQomZ3Q7wqAgwqAgwqAgJmd0
O8KgIMKgIMKgICZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgd2lkdGg6d2lkdGg8YnI+DQomZ3Q7wqAgwqAgwqAg
Jmd0O8KgIMKgIMKgICZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGhlaWdodDpoZWlnaHQ8YnI+DQomZ3Q7wqAgwqAg
wqAgJmd0O8KgIMKgIMKgICZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgbWlwbWFwcGVkOk5PXTs8YnI+DQomZ3Q7wqAgwqAg
wqAgJmd0O8KgIMKgIMKgICZndDsgK8KgIMKgIMKgIMKgIHRleHR1cmVEZXNjcmlwdG9yLnVzYWdl
ID0gcy08YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O3BnZGlzcC5taW5pbXVtVGV4dHVyZVVzYWdlOzxi
cj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAgJmd0OyArwqAgwqAgwqAgwqAgcy0mZ3Q7dGV4
dHVyZSA9IFtzLSZndDttdGw8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgbmV3VGV4dHVy
ZVdpdGhEZXNjcmlwdG9yOnRleHR1cmVEZXNjcmlwdG9yXTs8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0
Ozxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7PGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoFdo
YXQgYWJvdXQgY3JlYXRpbmcgcGl4bWFuX2ltYWdlX3QgZnJvbSBzLTxicj4NCiZndDvCoCDCoCDC
oCAmZ3Q7dGV4dHVyZS5idWZmZXIuY29udGVudHM/PGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDC
oCDCoFRoaXM8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgc2hvdWxkIHNhdmUgbWVtb3J5
IHVzYWdlIGJ5IHJlbW92aW5nIHRoZSBkdXBsaWNhdGlvbiBvZiB0ZXh0dXJlLjxicj4NCiZndDvC
oCDCoCDCoCAmZ3Q7PGJyPg0KJmd0O8KgIMKgIMKgICZndDs8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0
OyBXZSBuZWVkIGV4cGxpY2l0IGNvbnRyb2wgb3ZlciB3aGVuIHRoZSBHUFUgdnMgd2hlbiB0aGUg
Q1BVIG1heTxicj4NCiZndDvCoCDCoCDCoGFjY2Vzczxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7IHRo
ZSB0ZXh0dXJlIC0gb25seSBvbmUgb2YgdGhlbSBtYXkgYWNjZXNzIHRoZW0gYXQgYSB0aW1lLiBB
cyBmYXI8YnI+DQomZ3Q7wqAgwqAgwqBhcyBJPGJyPg0KJmd0O8KgIMKgIMKgICZndDsgY2FuIHRl
bGwsIHdlIGNhbiYjMzk7dCBjb250cm9sIHdoZW4gdGhlIHJlc3Qgb2YgUWVtdSBtaWdodCBhY2Nl
c3MgdGhlPGJyPg0KJmd0O8KgIMKgIMKgICZndDsgcGl4bWFuX2ltYWdlIHVzZWQgaW4gdGhlIGNv
bnNvbGUgc3VyZmFjZT88YnI+DQomZ3Q7IDxicj4NCiZndDvCoCDCoCDCoFlvdSBhcmUgcmlnaHQ7
IHdlIG5lZWQgdG8gaGF2ZSBkdXBsaWNhdGUgYnVmZmVycy4gV2UgY2FuIHN0aWxsIGF2b2lkPGJy
Pg0KJmd0O8KgIMKgIMKgY29weWluZyBieSB1c2luZyB0d28gTVRMVGV4dHVyZXMgZm9yIGRvdWJs
ZS1idWZmZXJpbmcgaW5zdGVhZCBvZiBoYXZpbmc8YnI+DQomZ3Q7wqAgwqAgwqBhIE1UTFRleHR1
cmUgYW5kIGEgcGl4bWFuX2ltYWdlIGFuZCBjb3B5aW5nIGJldHdlZW4gdGhlbSBmb3I8YnI+DQom
Z3Q7wqAgwqAgwqBNVExTdG9yYWdlTW9kZU1hbmFnZWQuPGJyPg0KJmd0OyA8YnI+DQomZ3Q7IERv
IEkgdW5kZXJzdGFuZCBjb3JyZWN0bHkgdGhhdCB5b3UgaW50ZW5kIHRvIHN3YXAgdGhlIHN1cmZh
Y2UtJmd0O2ltYWdlIG9uIDxicj4NCiZndDsgZXZlcnkgZnJhbWUsIG9yIGV2ZW4gdGhlIHN1cmZh
Y2UtJmd0O2ltYWdlLSZndDtkYXRhPyBJZiBzbywgaXQmIzM5O3MgbXkgPGJyPg0KJmd0OyB1bmRl
cnN0YW5kaW5nIGZyb20gcmVhZGluZyB0aGUgc291cmNlIG9mIGEgYnVuY2ggb2YgVUkgaW1wbGVt
ZW50YXRpb25zIGEgPGJyPg0KJmd0OyBmZXcgd2Vla3MgYWdvIHRoYXQgdGhpcyBpcyBuZWl0aGVy
IHN1cHBvcnRlZCBub3Igc2FmZSwgYXMgc29tZSA8YnI+DQomZ3Q7IGltcGxlbWVudGF0aW9ucyB0
YWtlIGxvbmctbGl2ZWQgcmVmZXJlbmNlcyB0byB0aGVzZSBpbnRlcm5hbCBkYXRhIDxicj4NCiZn
dDsgc3RydWN0dXJlcyB1bnRpbCBhIGRweV9nZnhfc3dpdGNoIGNhbGxiYWNrLiBBbmQgdGhlIGlt
cGxlbWVudGF0aW9ucyBmb3IgPGJyPg0KJmd0OyB0aG9zZSBjYWxsYmFja3MgYXJlIGluIHR1cm4g
dmVyeSBleHBlbnNpdmUgaW4gc29tZSBjYXNlcy4gVGhpcyBpcyB3aHkgbXkgPGJyPg0KJmd0OyBj
b25jbHVzaW9uIGluIHRoZSB2NCB0aHJlYWQgd2FzIHRoYXQgZG91YmxlLWJ1ZmZlcmluZyB3YXMg
aW5mZWFzaWJsZSA8YnI+DQomZ3Q7IHdpdGggdGhlIGN1cnJlbnQgYXJjaGl0ZWN0dXJlLjxicj4N
Cjxicj4NCkJ5IHRoZSB3YXksIGNhbiYjMzk7dCB3ZSB0YWtlIHRoZSBCUUwgYWZ0ZXIgPGJyPg0K
ZW5jb2RlQ3VycmVudEZyYW1lVG9Db21tYW5kQnVmZmVyIGFuZCBrZWVwIGl0IHVudGlsIHRoZSBj
b21wbGV0aW9uIDxicj4NCmhhbmRsZXI/IFBWRyByZXF1aXJlcyB0aGUgQlFMIHVubG9ja2VkIGZv
ciBmb3J3YXJkIHByb2dyZXNzIGR1ZSB0byB0aGUgPGJyPg0KYm90dG9tIGhhbGYgdXNhZ2UgaW4g
Y2FsbGJhY2tzLCBidXQgTWV0YWwgZG9lc24mIzM5O3QuPGJyPjwvYmxvY2txdW90ZT48ZGl2Pjxi
cj48L2Rpdj48ZGl2PldoYXQgd291bGQgYmUgdGhlIGFkdmFudGFnZSBvZiB0aGlzPzwvZGl2Pjxk
aXY+PGJyPjwvZGl2PjxkaXY+QWxzbywgaWYgeW91JiMzOTtyZSBzdWdnZXN0aW5nIHVubG9ja2lu
ZyB0aGUgQlFMIDxpPmluc2lkZTwvaT4gdGhlIGNvbXBsZXRpb24gaGFuZGxlcjogSSYjMzk7bSBw
cmV0dHkgc3VyZSBsb2NraW5nIG9uIG9uZSB0aHJlYWQgYW5kIHVubG9ja2luZyBvbiBhbm90aGVy
IGlzIG5vdCBzdXBwb3J0ZWQuPGJyPjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+wqA8L2Rpdj48
YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46MHB4IDBweCAwcHgg
MC44ZXg7Ym9yZGVyLWxlZnQ6MXB4IHNvbGlkIHJnYigyMDQsMjA0LDIwNCk7cGFkZGluZy1sZWZ0
OjFleCI+DQomZ3Q7IDxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7PGJyPg0KJmd0O8KgIMKgIMKgICZn
dDvCoCDCoCDCoCAmZ3Q7ICvCoCDCoCB9PGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoCAm
Z3Q7ICs8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZndDsgK8KgIMKgIHMtJmd0O3Vz
aW5nX21hbmFnZWRfdGV4dHVyZV9zdG9yYWdlID08YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKg
IMKgICZndDsgK8KgIMKgIMKgIMKgIChzLSZndDt0ZXh0dXJlLnN0b3JhZ2VNb2RlID09IE1UTFN0
b3JhZ2VNb2RlTWFuYWdlZCk7PGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7ICvC
oCDCoCBkcHlfZ2Z4X3JlcGxhY2Vfc3VyZmFjZShzLSZndDtjb24sIHMtJmd0O3N1cmZhY2UpOzxi
cj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAgJmd0OyArfTxicj4NCiZndDvCoCDCoCDCoCAm
Z3Q7wqAgwqAgwqAgJmd0OyArPGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7ICtz
dGF0aWMgdm9pZCBjcmVhdGVfZmIoQXBwbGVHRlhTdGF0ZSAqcyk8YnI+DQomZ3Q7wqAgwqAgwqAg
Jmd0O8KgIMKgIMKgICZndDsgK3s8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZndDsg
K8KgIMKgIHMtJmd0O2NvbiA9IGdyYXBoaWNfY29uc29sZV9pbml0KE5VTEwsIDAsPGJyPg0KJmd0
O8KgIMKgIMKgJmFtcDthcHBsZV9nZnhfZmJfb3BzLCBzKTs8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0
O8KgIMKgIMKgICZndDsgK8KgIMKgIHNldF9tb2RlKHMsIDE0NDAsIDEwODApOzxicj4NCiZndDvC
oCDCoCDCoCAmZ3Q7wqAgwqAgwqAgJmd0OyArPGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDC
oCAmZ3Q7ICvCoCDCoCBzLSZndDtjdXJzb3Jfc2hvdyA9IHRydWU7PGJyPg0KJmd0O8KgIMKgIMKg
ICZndDvCoCDCoCDCoCAmZ3Q7ICt9PGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7
ICs8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZndDsgK3N0YXRpYyBzaXplX3QgYXBw
bGVfZ2Z4X2dldF9kZWZhdWx0X21taW9fcmFuZ2Vfc2l6ZSh2b2lkKTxicj4NCiZndDvCoCDCoCDC
oCAmZ3Q7wqAgwqAgwqAgJmd0OyArezxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAgJmd0
OyArwqAgwqAgc2l6ZV90IG1taW9fcmFuZ2Vfc2l6ZTs8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8Kg
IMKgIMKgICZndDsgK8KgIMKgIEBhdXRvcmVsZWFzZXBvb2wgezxicj4NCiZndDvCoCDCoCDCoCAm
Z3Q7wqAgwqAgwqAgJmd0OyArwqAgwqAgwqAgwqAgUEdEZXZpY2VEZXNjcmlwdG9yICpkZXNjID0g
W1BHRGV2aWNlRGVzY3JpcHRvciBuZXddOzxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAg
Jmd0OyArwqAgwqAgwqAgwqAgbW1pb19yYW5nZV9zaXplID0gZGVzYy5tbWlvTGVuZ3RoOzxicj4N
CiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAgJmd0OyArwqAgwqAgwqAgwqAgW2Rlc2MgcmVsZWFz
ZV07PGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7ICvCoCDCoCB9PGJyPg0KJmd0
O8KgIMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7ICvCoCDCoCByZXR1cm4gbW1pb19yYW5nZV9zaXpl
Ozxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAgJmd0OyArfTxicj4NCiZndDvCoCDCoCDC
oCAmZ3Q7wqAgwqAgwqAgJmd0OyArPGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7
ICt2b2lkIGFwcGxlX2dmeF9jb21tb25faW5pdChPYmplY3QgKm9iaiwgQXBwbGVHRlhTdGF0ZSAq
cyw8YnI+DQomZ3Q7wqAgwqAgwqBjb25zdDxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqBj
aGFyKiBvYmpfbmFtZSk8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZndDsgK3s8YnI+
DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZndDsgK8KgIMKgIHNpemVfdCBtbWlvX3Jhbmdl
X3NpemUgPTxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqBhcHBsZV9nZnhfZ2V0X2RlZmF1
bHRfbW1pb19yYW5nZV9zaXplKCk7PGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7
ICs8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZndDsgK8KgIMKgIHRyYWNlX2FwcGxl
X2dmeF9jb21tb25faW5pdChvYmpfbmFtZSwgbW1pb19yYW5nZV9zaXplKTs8YnI+DQomZ3Q7wqAg
wqAgwqAgJmd0O8KgIMKgIMKgICZndDsgK8KgIMKgIG1lbW9yeV9yZWdpb25faW5pdF9pbygmYW1w
O3MtJmd0O2lvbWVtX2dmeCwgb2JqLDxicj4NCiZndDvCoCDCoCDCoCZhbXA7YXBwbGVfZ2Z4X29w
cywgcyw8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgb2JqX25hbWUsPGJyPg0KJmd0O8Kg
IMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCBtbWlvX3JhbmdlX3NpemUpOzxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAg
Jmd0OyArPGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7ICvCoCDCoCAvKiBUT0RP
OiBQVkcgZnJhbWV3b3JrIHN1cHBvcnRzIHNlcmlhbGlzaW5nIGRldmljZSBzdGF0ZTo8YnI+DQom
Z3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgaW50ZWdyYXRlIGl0ISAqLzxicj4NCiZndDvCoCDCoCDC
oCAmZ3Q7wqAgwqAgwqAgJmd0OyArfTxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAgJmd0
OyArPGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7ICt0eXBlZGVmIHN0cnVjdCBB
cHBsZUdGWE1hcE1lbW9yeUpvYiB7PGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7
ICvCoCDCoCBBcHBsZUdGWFN0YXRlICpzdGF0ZTs8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKg
IMKgICZndDsgK8KgIMKgIFBHVGFza190ICp0YXNrOzxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAg
wqAgwqAgJmd0OyArwqAgwqAgdWludDY0X3QgdmlydHVhbF9vZmZzZXQ7PGJyPg0KJmd0O8KgIMKg
IMKgICZndDvCoCDCoCDCoCAmZ3Q7ICvCoCDCoCBQR1BoeXNpY2FsTWVtb3J5UmFuZ2VfdCAqcmFu
Z2VzOzxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAgJmd0OyArwqAgwqAgdWludDMyX3Qg
cmFuZ2VfY291bnQ7PGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7ICvCoCDCoCBi
b29sIHJlYWRfb25seTs8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZndDsgK8KgIMKg
IGJvb2wgc3VjY2Vzczs8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZndDsgK8KgIMKg
IGJvb2wgZG9uZTs8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZndDsgK30gQXBwbGVH
RlhNYXBNZW1vcnlKb2I7PGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7ICs8YnI+
DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZndDsgK3VpbnRwdHJfdCBhcHBsZV9nZnhfaG9z
dF9hZGRyZXNzX2Zvcl9ncGFfcmFuZ2UodWludDY0X3Q8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8Kg
IMKgIMKgZ3Vlc3RfcGh5c2ljYWwsPGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7
ICvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoHVpbnQ2NF90PGJyPg0KJmd0O8KgIMKgIMKgbGVuZ3RoLDxicj4NCiZn
dDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqBib29sIHJlYWRfb25seSk8YnI+DQomZ3Q7wqAgwqAgwqAg
Jmd0O8KgIMKgIMKgICZndDsgK3s8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZndDsg
K8KgIMKgIE1lbW9yeVJlZ2lvbiAqcmFtX3JlZ2lvbjs8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8Kg
IMKgIMKgICZndDsgK8KgIMKgIHVpbnRwdHJfdCBob3N0X2FkZHJlc3M7PGJyPg0KJmd0O8KgIMKg
IMKgICZndDvCoCDCoCDCoCAmZ3Q7ICvCoCDCoCBod2FkZHIgcmFtX3JlZ2lvbl9vZmZzZXQgPSAw
Ozxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAgJmd0OyArwqAgwqAgaHdhZGRyIHJhbV9y
ZWdpb25fbGVuZ3RoID0gbGVuZ3RoOzxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAgJmd0
OyArPGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7ICvCoCDCoCByYW1fcmVnaW9u
ID08YnI+DQomZ3Q7wqAgwqAgwqBhZGRyZXNzX3NwYWNlX3RyYW5zbGF0ZSgmYW1wO2FkZHJlc3Nf
c3BhY2VfbWVtb3J5LDxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAgJmd0OyArwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBn
dWVzdF9waHlzaWNhbCw8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZndDsgK8KgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
JmFtcDtyYW1fcmVnaW9uX29mZnNldCw8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZn
dDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgPGJyPg0KJmd0O8KgIMKgIMKgIMKgJmFtcDtyYW1fcmVnaW9uX2xlbmd0aCwgITxicj4N
CiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqByZWFkX29ubHksPGJyPg0KJmd0O8KgIMKgIMKgICZn
dDvCoCDCoCDCoCAmZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoDxicj4NCiZndDvCoCDCoCDCoCDCoE1FTVRYQVRUUlNfVU5TUEVD
SUZJRUQpOzxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7PGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDC
oCDCoENhbGwgbWVtb3J5X3JlZ2lvbl9yZWYoKSBzbyB0aGF0IGl0IHdvbiYjMzk7dCBnbyBhd2F5
Ljxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7PGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoCAm
Z3Q7ICs8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZndDsgK8KgIMKgIGlmICghcmFt
X3JlZ2lvbiB8fCByYW1fcmVnaW9uX2xlbmd0aCAmbHQ7IGxlbmd0aCB8fDxicj4NCiZndDvCoCDC
oCDCoCAmZ3Q7wqAgwqAgwqAgJmd0OyArwqAgwqAgwqAgwqAgIW1lbW9yeV9hY2Nlc3NfaXNfZGly
ZWN0KHJhbV9yZWdpb24sICFyZWFkX29ubHkpKSB7PGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDC
oCDCoCAmZ3Q7ICvCoCDCoCDCoCDCoCByZXR1cm4gMDs8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8Kg
IMKgIMKgICZndDsgK8KgIMKgIH08YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZndDsg
Kzxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAgJmd0OyArwqAgwqAgaG9zdF9hZGRyZXNz
ID08YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgKG1hY2hfdm1fYWRkcmVzc190KW1lbW9y
eV9yZWdpb25fZ2V0X3JhbV9wdHIocmFtX3JlZ2lvbik7PGJyPg0KJmd0O8KgIMKgIMKgICZndDs8
YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgaG9zdF9hZGRyZXNzIGlzIHR5cGVkIGFzIHVp
bnRwdHJfdCwgbm90IG1hY2hfdm1fYWRkcmVzc190Ljxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7PGJy
Pg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7ICvCoCDCoCBpZiAoaG9zdF9hZGRyZXNz
ID09IDApIHs8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZndDsgK8KgIMKgIMKgIMKg
IHJldHVybiAwOzxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAgJmd0OyArwqAgwqAgfTxi
cj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAgJmd0OyArwqAgwqAgaG9zdF9hZGRyZXNzICs9
IHJhbV9yZWdpb25fb2Zmc2V0Ozxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAgJmd0OyAr
PGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7ICvCoCDCoCByZXR1cm4gaG9zdF9h
ZGRyZXNzOzxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAgJmd0OyArfTxicj4NCiZndDvC
oCDCoCDCoCAmZ3Q7wqAgwqAgwqAgJmd0OyArPGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDC
oCAmZ3Q7ICtzdGF0aWMgdm9pZCBhcHBsZV9nZnhfbWFwX21lbW9yeSh2b2lkICpvcGFxdWUpPGJy
Pg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7ICt7PGJyPg0KJmd0O8KgIMKgIMKgICZn
dDvCoCDCoCDCoCAmZ3Q7ICvCoCDCoCBBcHBsZUdGWE1hcE1lbW9yeUpvYiAqam9iID0gb3BhcXVl
Ozxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAgJmd0OyArwqAgwqAgQXBwbGVHRlhTdGF0
ZSAqcyA9IGpvYi0mZ3Q7c3RhdGU7PGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7
ICvCoCDCoCBQR1Rhc2tfdCAqdGFza8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgID0gam9iLSZn
dDt0YXNrOzxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAgJmd0OyArwqAgwqAgdWludDMy
X3QgcmFuZ2VfY291bnTCoCDCoCDCoCDCoCDCoCDCoCA9IGpvYi0mZ3Q7cmFuZ2VfY291bnQ7PGJy
Pg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7ICvCoCDCoCB1aW50NjRfdCB2aXJ0dWFs
X29mZnNldMKgIMKgIMKgIMKgIMKgPSBqb2ItJmd0O3ZpcnR1YWxfb2Zmc2V0Ozxicj4NCiZndDvC
oCDCoCDCoCAmZ3Q7wqAgwqAgwqAgJmd0OyArwqAgwqAgUEdQaHlzaWNhbE1lbW9yeVJhbmdlX3Qg
KnJhbmdlcyA9IGpvYi0mZ3Q7cmFuZ2VzOzxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAg
Jmd0OyArwqAgwqAgYm9vbCByZWFkX29ubHnCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCA9IGpv
Yi0mZ3Q7cmVhZF9vbmx5Ozxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAgJmd0OyArwqAg
wqAga2Vybl9yZXR1cm5fdCByOzxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAgJmd0OyAr
wqAgwqAgbWFjaF92bV9hZGRyZXNzX3QgdGFyZ2V0LCBzb3VyY2U7PGJyPg0KJmd0O8KgIMKgIMKg
ICZndDvCoCDCoCDCoCAmZ3Q7ICvCoCDCoCB2bV9wcm90X3QgY3VyX3Byb3RlY3Rpb24sIG1heF9w
cm90ZWN0aW9uOzxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAgJmd0OyArwqAgwqAgYm9v
bCBzdWNjZXNzID0gdHJ1ZTs8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZndDsgKzxi
cj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAgJmd0OyArwqAgwqAgZ19hc3NlcnQoYnFsX2xv
Y2tlZCgpKTs8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZndDsgKzxicj4NCiZndDvC
oCDCoCDCoCAmZ3Q7wqAgwqAgwqAgJmd0OyArwqAgwqAgdHJhY2VfYXBwbGVfZ2Z4X21hcF9tZW1v
cnkodGFzaywgcmFuZ2VfY291bnQsPGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoHZpcnR1
YWxfb2Zmc2V0LCByZWFkX29ubHkpOzxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAgJmd0
OyArwqAgwqAgZm9yIChpbnQgaSA9IDA7IGkgJmx0OyByYW5nZV9jb3VudDsgaSsrKSB7PGJyPg0K
Jmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7ICvCoCDCoCDCoCDCoCBQR1BoeXNpY2FsTWVt
b3J5UmFuZ2VfdCAqcmFuZ2UgPSAmYW1wO3Jhbmdlc1tpXTs8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0
O8KgIMKgIMKgICZndDsgKzxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAgJmd0OyArwqAg
wqAgwqAgwqAgdGFyZ2V0ID0gdGFzay0mZ3Q7YWRkcmVzcyArIHZpcnR1YWxfb2Zmc2V0Ozxicj4N
CiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAgJmd0OyArwqAgwqAgwqAgwqAgdmlydHVhbF9vZmZz
ZXQgKz0gcmFuZ2UtJmd0O3BoeXNpY2FsTGVuZ3RoOzxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAg
wqAgwqAgJmd0OyArPGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7ICvCoCDCoCDC
oCDCoCB0cmFjZV9hcHBsZV9nZnhfbWFwX21lbW9yeV9yYW5nZShpLCByYW5nZS08YnI+DQomZ3Q7
wqAgwqAgwqAgJmd0O3BoeXNpY2FsQWRkcmVzcyw8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKg
IMKgICZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgcmFuZ2UtPGJyPg0KJmd0O8KgIMKgIMKgICZndDtwaHlzaWNhbExlbmd0
aCk7PGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7ICs8YnI+DQomZ3Q7wqAgwqAg
wqAgJmd0O8KgIMKgIMKgICZndDsgK8KgIMKgIMKgIMKgIHNvdXJjZSA9IGFwcGxlX2dmeF9ob3N0
X2FkZHJlc3NfZm9yX2dwYV9yYW5nZShyYW5nZS08YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKg
IMKgICZndDtwaHlzaWNhbEFkZHJlc3MsPGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoCAm
Z3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCByYW5nZS08YnI+DQomZ3Q7wqAgwqAgwqAgJmd0
O8KgIMKgIMKgICZndDtwaHlzaWNhbExlbmd0aCw8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKg
IMKgICZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgPGJyPg0KJmd0O8KgIMKgIMKgcmVhZF9v
bmx5KTs8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZndDsgK8KgIMKgIMKgIMKgIGlm
IChzb3VyY2UgPT0gMCkgezxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAgJmd0OyArwqAg
wqAgwqAgwqAgwqAgwqAgc3VjY2VzcyA9IGZhbHNlOzxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAg
wqAgwqAgJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgY29udGludWU7PGJyPg0KJmd0O8KgIMKgIMKg
ICZndDvCoCDCoCDCoCAmZ3Q7ICvCoCDCoCDCoCDCoCB9PGJyPg0KJmd0O8KgIMKgIMKgICZndDvC
oCDCoCDCoCAmZ3Q7ICs8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZndDsgK8KgIMKg
IMKgIMKgIE1lbW9yeVJlZ2lvbiogYWx0X21yID0gTlVMTDs8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0
O8KgIMKgIMKgICZndDsgK8KgIMKgIMKgIMKgIG1hY2hfdm1fYWRkcmVzc190IGFsdF9zb3VyY2Ug
PTxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAobWFjaF92bV9hZGRyZXNzX3QpZ3BhMmh2
YSgmYW1wO2FsdF9tciwgcmFuZ2UtJmd0O3BoeXNpY2FsQWRkcmVzcyw8YnI+DQomZ3Q7wqAgwqAg
wqByYW5nZS08YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZndDtwaHlzaWNhbExlbmd0
aCwgTlVMTCk7PGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7ICvCoCDCoCDCoCDC
oCBnX2Fzc2VydChhbHRfc291cmNlID09IHNvdXJjZSk7PGJyPg0KJmd0O8KgIMKgIMKgICZndDs8
YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgUmVtb3ZlIHRoaXM7IEkgZ3Vlc3MgdGhpcyBp
cyBmb3IgZGVidWdnaW5nLjxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7PGJyPg0KJmd0O8KgIMKgIMKg
ICZndDvCoCDCoCDCoCAmZ3Q7ICs8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZndDsg
K8KgIMKgIMKgIMKgIGN1cl9wcm90ZWN0aW9uID0gMDs8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8Kg
IMKgIMKgICZndDsgK8KgIMKgIMKgIMKgIG1heF9wcm90ZWN0aW9uID0gMDs8YnI+DQomZ3Q7wqAg
wqAgwqAgJmd0O8KgIMKgIMKgICZndDsgK8KgIMKgIMKgIMKgIC8vIE1hcCBndWVzdCBSQU0gYXQg
cmFuZ2UtJmd0O3BoeXNpY2FsQWRkcmVzcyBpbnRvPGJyPg0KJmd0O8KgIMKgIMKgUEcgdGFzazxi
cj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqBtZW1vcnkgcmFuZ2U8YnI+DQomZ3Q7wqAgwqAg
wqAgJmd0O8KgIMKgIMKgICZndDsgK8KgIMKgIMKgIMKgIHIgPSBtYWNoX3ZtX3JlbWFwKG1hY2hf
dGFza19zZWxmKCksPGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7ICvCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCAmYW1wO3RhcmdldCwgcmFuZ2UtJmd0O3Bo
eXNpY2FsTGVuZ3RoLDxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqB2bV9wYWdlX3NpemUg
LSAxLDxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAgJmd0OyArwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgVk1fRkxBR1NfRklYRUQgfDxicj4NCiZndDvCoCDCoCDC
oFZNX0ZMQUdTX09WRVJXUklURSw8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZndDsg
K8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIG1hY2hfdGFza19zZWxmKCks
PGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCBzb3VyY2UsIGZhbHNlIC8qIHNoYXJlZCBtYXBwaW5nLCBubzxi
cj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqBjb3B5ICovLDxicj4NCiZndDvCoCDCoCDCoCAm
Z3Q7wqAgwqAgwqAgJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
JmFtcDtjdXJfcHJvdGVjdGlvbiwgJmFtcDttYXhfcHJvdGVjdGlvbiw8YnI+DQomZ3Q7wqAgwqAg
wqAgJmd0O8KgIMKgIMKgICZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIFZNX0lOSEVSSVRfQ09QWSk7PGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7
ICvCoCDCoCDCoCDCoCB0cmFjZV9hcHBsZV9nZnhfcmVtYXAociwgc291cmNlLCB0YXJnZXQpOzxi
cj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAgJmd0OyArwqAgwqAgwqAgwqAgZ19hc3NlcnQo
ciA9PSBLRVJOX1NVQ0NFU1MpOzxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAgJmd0OyAr
wqAgwqAgfTxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAgJmd0OyArPGJyPg0KJmd0O8Kg
IMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7ICvCoCDCoCBxZW11X211dGV4X2xvY2soJmFtcDtzLSZn
dDtqb2JfbXV0ZXgpOzxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAgJmd0OyArwqAgwqAg
am9iLSZndDtzdWNjZXNzID0gc3VjY2Vzczs8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKg
ICZndDsgK8KgIMKgIGpvYi0mZ3Q7ZG9uZSA9IHRydWU7PGJyPg0KJmd0O8KgIMKgIMKgICZndDvC
oCDCoCDCoCAmZ3Q7ICvCoCDCoCBxZW11X2NvbmRfYnJvYWRjYXN0KCZhbXA7cy0mZ3Q7am9iX2Nv
bmQpOzxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAgJmd0OyArwqAgwqAgcWVtdV9tdXRl
eF91bmxvY2soJmFtcDtzLSZndDtqb2JfbXV0ZXgpOzxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAg
wqAgwqAgJmd0OyArfTxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAgJmd0OyArPGJyPg0K
Jmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7ICt2b2lkIGFwcGxlX2dmeF9hd2FpdF9iaF9q
b2IoQXBwbGVHRlhTdGF0ZSAqcywgYm9vbDxicj4NCiZndDvCoCDCoCDCoCpqb2JfZG9uZV9mbGFn
KTxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAgJmd0OyArezxicj4NCiZndDvCoCDCoCDC
oCAmZ3Q7wqAgwqAgwqAgJmd0OyArwqAgwqAgcWVtdV9tdXRleF9sb2NrKCZhbXA7cy0mZ3Q7am9i
X211dGV4KTs8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZndDsgK8KgIMKgIHdoaWxl
ICghKmpvYl9kb25lX2ZsYWcpIHs8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZndDsg
K8KgIMKgIMKgIMKgIHFlbXVfY29uZF93YWl0KCZhbXA7cy0mZ3Q7am9iX2NvbmQsICZhbXA7cy0m
Z3Q7am9iX211dGV4KTs8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZndDsgK8KgIMKg
IH08YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZndDsgK8KgIMKgIHFlbXVfbXV0ZXhf
dW5sb2NrKCZhbXA7cy0mZ3Q7am9iX211dGV4KTs8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKg
IMKgICZndDsgK308YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZndDsgKzxicj4NCiZn
dDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAgJmd0OyArdHlwZWRlZiBzdHJ1Y3QgQXBwbGVHRlhSZWFk
TWVtb3J5Sm9iIHs8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZndDsgK8KgIMKgIEFw
cGxlR0ZYU3RhdGUgKnM7PGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7ICvCoCDC
oCBod2FkZHIgcGh5c2ljYWxfYWRkcmVzczs8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKg
ICZndDsgK8KgIMKgIHVpbnQ2NF90IGxlbmd0aDs8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKg
IMKgICZndDsgK8KgIMKgIHZvaWQgKmRzdDs8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKg
ICZndDsgK8KgIMKgIGJvb2wgZG9uZTs8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZn
dDsgK30gQXBwbGVHRlhSZWFkTWVtb3J5Sm9iOzxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAg
wqAgJmd0OyArPGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7ICtzdGF0aWMgdm9p
ZCBhcHBsZV9nZnhfZG9fcmVhZF9tZW1vcnkodm9pZCAqb3BhcXVlKTxicj4NCiZndDvCoCDCoCDC
oCAmZ3Q7wqAgwqAgwqAgJmd0OyArezxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAgJmd0
OyArwqAgwqAgQXBwbGVHRlhSZWFkTWVtb3J5Sm9iICpqb2IgPSBvcGFxdWU7PGJyPg0KJmd0O8Kg
IMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7ICvCoCDCoCBBcHBsZUdGWFN0YXRlICpzID0gam9iLSZn
dDtzOzxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAgJmd0OyArPGJyPg0KJmd0O8KgIMKg
IMKgICZndDvCoCDCoCDCoCAmZ3Q7ICvCoCDCoCBjcHVfcGh5c2ljYWxfbWVtb3J5X3JlYWQoam9i
LSZndDtwaHlzaWNhbF9hZGRyZXNzLCBqb2ItJmd0O2RzdCw8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0
O8KgIMKgIMKgam9iLSZndDtsZW5ndGgpOzxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7PGJyPg0KJmd0
O8KgIMKgIMKgICZndDvCoCDCoCDCoFVzZTogZG1hX21lbW9yeV9yZWFkKCk8YnI+DQomZ3Q7wqAg
wqAgwqAgJmd0Ozxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAgJmd0OyArPGJyPg0KJmd0
O8KgIMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7ICvCoCDCoCBxZW11X211dGV4X2xvY2soJmFtcDtz
LSZndDtqb2JfbXV0ZXgpOzxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAgJmd0OyArwqAg
wqAgam9iLSZndDtkb25lID0gdHJ1ZTs8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZn
dDsgK8KgIMKgIHFlbXVfY29uZF9icm9hZGNhc3QoJmFtcDtzLSZndDtqb2JfY29uZCk7PGJyPg0K
Jmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7ICvCoCDCoCBxZW11X211dGV4X3VubG9jaygm
YW1wO3MtJmd0O2pvYl9tdXRleCk7PGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7
ICt9PGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7ICs8YnI+DQomZ3Q7wqAgwqAg
wqAgJmd0O8KgIMKgIMKgICZndDsgK3N0YXRpYyB2b2lkIGFwcGxlX2dmeF9yZWFkX21lbW9yeShB
cHBsZUdGWFN0YXRlICpzLCBod2FkZHI8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgcGh5
c2ljYWxfYWRkcmVzcyw8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZndDsgK8KgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHVpbnQ2NF90IGxl
bmd0aCwgdm9pZCAqZHN0KTxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAgJmd0OyArezxi
cj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAgJmd0OyArwqAgwqAgQXBwbGVHRlhSZWFkTWVt
b3J5Sm9iIGpvYiA9IHs8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZndDsgK8KgIMKg
IMKgIMKgIHMsIHBoeXNpY2FsX2FkZHJlc3MsIGxlbmd0aCwgZHN0PGJyPg0KJmd0O8KgIMKgIMKg
ICZndDvCoCDCoCDCoCAmZ3Q7ICvCoCDCoCB9Ozxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAg
wqAgJmd0OyArPGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7ICvCoCDCoCB0cmFj
ZV9hcHBsZV9nZnhfcmVhZF9tZW1vcnkocGh5c2ljYWxfYWRkcmVzcywgbGVuZ3RoLDxicj4NCiZn
dDvCoCDCoCDCoGRzdCk7PGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7ICs8YnI+
DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZndDsgK8KgIMKgIC8qIFRyYXZlcnNpbmcgdGhl
IG1lbW9yeSBtYXAgcmVxdWlyZXMgUkNVL0JRTCwgc28gZG88YnI+DQomZ3Q7wqAgwqAgwqBpdCBp
biBhPGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoEJILiAqLzxicj4NCiZndDvCoCDCoCDC
oCAmZ3Q7wqAgwqAgwqAgJmd0OyArwqAgwqAgYWlvX2JoX3NjaGVkdWxlX29uZXNob3QocWVtdV9n
ZXRfYWlvX2NvbnRleHQoKSw8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgYXBwbGVfZ2Z4
X2RvX3JlYWRfbWVtb3J5LDxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAgJmd0OyArwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgJmFtcDtqb2IpOzxicj4NCiZn
dDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAgJmd0OyArwqAgwqAgYXBwbGVfZ2Z4X2F3YWl0X2JoX2pv
YihzLCAmYW1wO2pvYi5kb25lKTs8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZndDsg
K308YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZndDsgKzxicj4NCiZndDvCoCDCoCDC
oCAmZ3Q7wqAgwqAgwqAgJmd0OyArc3RhdGljIHZvaWQ8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8Kg
IMKgIMKgYXBwbGVfZ2Z4X3JlZ2lzdGVyX3Rhc2tfbWFwcGluZ19oYW5kbGVycyhBcHBsZUdGWFN0
YXRlICpzLDxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAgJmd0OyArPGJyPg0KJmd0O8Kg
IMKgIMKgICZndDvCoCDCoCDCoCDCoFBHRGV2aWNlRGVzY3JpcHRvciAqZGVzYyk8YnI+DQomZ3Q7
wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZndDsgK3s8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKg
IMKgICZndDsgK8KgIMKgIGRlc2MuY3JlYXRlVGFzayA9IF4odWludDY0X3Qgdm1TaXplLCB2b2lk
ICogX051bGxhYmxlICo8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgX05vbm51bGwgYmFz
ZUFkZHJlc3MpIHs8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZndDsgK8KgIMKgIMKg
IMKgIFBHVGFza190ICp0YXNrID0gYXBwbGVfZ2Z4X25ld190YXNrKHMsIHZtU2l6ZSk7PGJyPg0K
Jmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7ICvCoCDCoCDCoCDCoCAqYmFzZUFkZHJlc3Mg
PSAodm9pZCAqKXRhc2stJmd0O2FkZHJlc3M7PGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDC
oCAmZ3Q7ICvCoCDCoCDCoCDCoCB0cmFjZV9hcHBsZV9nZnhfY3JlYXRlX3Rhc2sodm1TaXplLCAq
YmFzZUFkZHJlc3MpOzxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAgJmd0OyArwqAgwqAg
wqAgwqAgcmV0dXJuIHRhc2s7PGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7ICvC
oCDCoCB9Ozxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAgJmd0OyArPGJyPg0KJmd0O8Kg
IMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7ICvCoCDCoCBkZXNjLmRlc3Ryb3lUYXNrID0gXihQR1Rh
c2tfdCAqIF9Ob25udWxsIHRhc2spIHs8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZn
dDsgK8KgIMKgIMKgIMKgIHRyYWNlX2FwcGxlX2dmeF9kZXN0cm95X3Rhc2sodGFzayk7PGJyPg0K
Jmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7ICvCoCDCoCDCoCDCoCBRVEFJTFFfUkVNT1ZF
KCZhbXA7cy0mZ3Q7dGFza3MsIHRhc2ssIG5vZGUpOzxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAg
wqAgwqAgJmd0OyArwqAgwqAgwqAgwqAgbWFjaF92bV9kZWFsbG9jYXRlKG1hY2hfdGFza19zZWxm
KCksIHRhc2stJmd0O2FkZHJlc3MsPGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoHRhc2st
Jmd0O2xlbik7PGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7ICvCoCDCoCDCoCDC
oCBnX2ZyZWUodGFzayk7PGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7ICvCoCDC
oCB9Ozxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAgJmd0OyArPGJyPg0KJmd0O8KgIMKg
IMKgICZndDvCoCDCoCDCoCAmZ3Q7ICvCoCDCoCBkZXNjLm1hcE1lbW9yeSA9IF5ib29sKFBHVGFz
a190ICogX05vbm51bGwgdGFzaywgdWludDMyX3Q8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKg
IMKgcmFuZ2VfY291bnQsPGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7ICvCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHVpbnQ2NF90IHZpcnR1YWxfb2Zmc2V0LCBi
b29sPGJyPg0KJmd0O8KgIMKgIMKgcmVhZF9vbmx5LDxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAg
wqAgwqAgJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBQR1BoeXNpY2Fs
TWVtb3J5UmFuZ2VfdCAqIF9Ob25udWxsPGJyPg0KJmd0O8KgIMKgIMKgcmFuZ2VzKSB7PGJyPg0K
Jmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7ICvCoCDCoCDCoCDCoCBBcHBsZUdGWE1hcE1l
bW9yeUpvYiBqb2IgPSB7PGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7ICvCoCDC
oCDCoCDCoCDCoCDCoCAuc3RhdGUgPSBzLDxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAg
Jmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgLnRhc2sgPSB0YXNrLCAucmFuZ2VzID0gcmFuZ2VzLCAu
cmFuZ2VfY291bnQgPTxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqByYW5nZV9jb3VudCw8
YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIC5y
ZWFkX29ubHkgPSByZWFkX29ubHksIC52aXJ0dWFsX29mZnNldCA9PGJyPg0KJmd0O8KgIMKgIMKg
ICZndDvCoCDCoCDCoHZpcnR1YWxfb2Zmc2V0LDxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAg
wqAgJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgLmRvbmUgPSBmYWxzZSwgLnN1Y2Nlc3MgPSB0cnVl
LDxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAgJmd0OyArwqAgwqAgwqAgwqAgfTs8YnI+
DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZndDsgK8KgIMKgIMKgIMKgIGlmIChyYW5nZV9j
b3VudCAmZ3Q7IDApIHs8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZndDsgK8KgIMKg
IMKgIMKgIMKgIMKgIGFpb19iaF9zY2hlZHVsZV9vbmVzaG90KHFlbXVfZ2V0X2Fpb19jb250ZXh0
KCksPGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7ICvCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBhcHBsZV9nZnhfbWFwX21lbW9y
eSw8YnI+DQomZ3Q7wqAgwqAgwqAmYW1wO2pvYik7PGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDC
oCDCoCAmZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCBhcHBsZV9nZnhfYXdhaXRfYmhfam9iKHMsICZh
bXA7am9iLmRvbmUpOzxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAgJmd0OyArwqAgwqAg
wqAgwqAgfTxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAgJmd0OyArwqAgwqAgwqAgwqAg
cmV0dXJuIGpvYi5zdWNjZXNzOzxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAgJmd0OyAr
wqAgwqAgfTs8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZndDsgKzxicj4NCiZndDvC
oCDCoCDCoCAmZ3Q7wqAgwqAgwqAgJmd0OyArwqAgwqAgZGVzYy51bm1hcE1lbW9yeSA9IF5ib29s
KFBHVGFza190ICogX05vbm51bGwgdGFzayw8YnI+DQomZ3Q7wqAgwqAgwqB1aW50NjRfdDxicj4N
CiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqB2aXJ0dWFsT2Zmc2V0LDxicj4NCiZndDvCoCDCoCDC
oCAmZ3Q7wqAgwqAgwqAgJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqB1aW50NjRfdCBsZW5ndGgpIHs8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZndDsg
K8KgIMKgIMKgIMKgIGtlcm5fcmV0dXJuX3Qgcjs8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKg
IMKgICZndDsgK8KgIMKgIMKgIMKgIG1hY2hfdm1fYWRkcmVzc190IHJhbmdlX2FkZHJlc3M7PGJy
Pg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7ICs8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0
O8KgIMKgIMKgICZndDsgK8KgIMKgIMKgIMKgIHRyYWNlX2FwcGxlX2dmeF91bm1hcF9tZW1vcnko
dGFzaywgdmlydHVhbE9mZnNldCw8YnI+DQomZ3Q7wqAgwqAgwqBsZW5ndGgpOzxicj4NCiZndDvC
oCDCoCDCoCAmZ3Q7wqAgwqAgwqAgJmd0OyArPGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDC
oCAmZ3Q7ICvCoCDCoCDCoCDCoCAvKiBSZXBsYWNlIHRhc2sgbWVtb3J5IHJhbmdlIHdpdGggZnJl
c2ggcGFnZXMsPGJyPg0KJmd0O8KgIMKgIMKgdW5kb2luZzxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7
wqAgwqAgwqB0aGUgbWFwcGluZzxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAgJmd0OyAr
wqAgwqAgwqAgwqAgwqAqIGZyb20gZ3Vlc3QgUkFNLiAqLzxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7
wqAgwqAgwqAgJmd0OyArwqAgwqAgwqAgwqAgcmFuZ2VfYWRkcmVzcyA9IHRhc2stJmd0O2FkZHJl
c3MgKyB2aXJ0dWFsT2Zmc2V0Ozxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAgJmd0OyAr
wqAgwqAgwqAgwqAgciA9IG1hY2hfdm1fYWxsb2NhdGUobWFjaF90YXNrX3NlbGYoKSw8YnI+DQom
Z3Q7wqAgwqAgwqAmYW1wO3JhbmdlX2FkZHJlc3MsPGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDC
oCDCoGxlbmd0aCw8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZndDsgK8KgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgVk1fRkxBR1NfRklYRUQgfDxicj4N
CiZndDvCoCDCoCDCoFZNX0ZMQUdTX09WRVJXUklURSk7PGJyPg0KJmd0O8KgIMKgIMKgICZndDvC
oCDCoCDCoCAmZ3Q7ICvCoCDCoCDCoCDCoCBnX2Fzc2VydChyID09IEtFUk5fU1VDQ0VTUyk7ZXJy
b3Jfc2V0Zzxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7PGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDC
oCDCoEFuIGV4dHJhIGVycm9yX3NldGc8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0Ozxicj4NCiZndDvC
oCDCoCDCoCAmZ3Q7wqAgwqAgwqAgJmd0OyArPGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDC
oCAmZ3Q7ICvCoCDCoCDCoCDCoCByZXR1cm4gdHJ1ZTs8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8Kg
IMKgIMKgICZndDsgK8KgIMKgIH07PGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7
ICs8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZndDsgK8KgIMKgIGRlc2MucmVhZE1l
bW9yeSA9IF5ib29sKHVpbnQ2NF90IHBoeXNpY2FsX2FkZHJlc3MsPGJyPg0KJmd0O8KgIMKgIMKg
dWludDY0X3Q8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgbGVuZ3RoLDxicj4NCiZndDvC
oCDCoCDCoCAmZ3Q7wqAgwqAgwqAgJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgdm9pZCAqIF9Ob25udWxsIGRzdCkgezxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7
wqAgwqAgwqAgJmd0OyArwqAgwqAgwqAgwqAgYXBwbGVfZ2Z4X3JlYWRfbWVtb3J5KHMsIHBoeXNp
Y2FsX2FkZHJlc3MsPGJyPg0KJmd0O8KgIMKgIMKgbGVuZ3RoLCBkc3QpOzxicj4NCiZndDvCoCDC
oCDCoCAmZ3Q7wqAgwqAgwqAgJmd0OyArwqAgwqAgwqAgwqAgcmV0dXJuIHRydWU7PGJyPg0KJmd0
O8KgIMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7ICvCoCDCoCB9Ozxicj4NCiZndDvCoCDCoCDCoCAm
Z3Q7wqAgwqAgwqAgJmd0OyArfTxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAgJmd0OyAr
PGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7ICtzdGF0aWMgUEdEaXNwbGF5RGVz
Y3JpcHRvcjxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAqYXBwbGVfZ2Z4X3ByZXBhcmVf
ZGlzcGxheV9kZXNjcmlwdG9yKEFwcGxlR0ZYU3RhdGUgKnMpPGJyPg0KJmd0O8KgIMKgIMKgICZn
dDvCoCDCoCDCoCAmZ3Q7ICt7PGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7ICvC
oCDCoCBQR0Rpc3BsYXlEZXNjcmlwdG9yICpkaXNwX2Rlc2MgPSBbUEdEaXNwbGF5RGVzY3JpcHRv
cjxicj4NCiZndDvCoCDCoCDCoG5ld107PGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoCAm
Z3Q7ICs8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZndDsgKyA8YSBocmVmPSJodHRw
Oi8vZGlzcF9kZXNjLm5hbWUiIHJlbD0ibm9yZWZlcnJlciIgdGFyZ2V0PSJfYmxhbmsiPmRpc3Bf
ZGVzYy5uYW1lPC9hPiAmbHQ7PGEgaHJlZj0iaHR0cDovL2Rpc3BfZGVzYy5uYW1lIiByZWw9Im5v
cmVmZXJyZXIiIHRhcmdldD0iX2JsYW5rIj5odHRwOi8vZGlzcF9kZXNjLm5hbWU8L2E+Jmd0OyAm
bHQ7aHR0cDovLzxicj4NCiZndDvCoCDCoCDCoDxhIGhyZWY9Imh0dHA6Ly9kaXNwX2Rlc2MubmFt
ZSIgcmVsPSJub3JlZmVycmVyIiB0YXJnZXQ9Il9ibGFuayI+ZGlzcF9kZXNjLm5hbWU8L2E+ICZs
dDs8YSBocmVmPSJodHRwOi8vZGlzcF9kZXNjLm5hbWUiIHJlbD0ibm9yZWZlcnJlciIgdGFyZ2V0
PSJfYmxhbmsiPmh0dHA6Ly9kaXNwX2Rlc2MubmFtZTwvYT4mZ3Q7Jmd0OyA9IEAmcXVvdDtRRU1V
IGRpc3BsYXkmcXVvdDs7PGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7ICvCoCDC
oCBkaXNwX2Rlc2Muc2l6ZUluTWlsbGltZXRlcnMgPSBOU01ha2VTaXplKDQwMC4sPGJyPg0KJmd0
O8KgIMKgIMKgMzAwLik7IC8qIEE8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgMjAmcXVv
dDsgZGlzcGxheSAqLzxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAgJmd0OyArwqAgwqAg
ZGlzcF9kZXNjLnF1ZXVlID0gZGlzcGF0Y2hfZ2V0X21haW5fcXVldWUoKTs8YnI+DQomZ3Q7wqAg
wqAgwqAgJmd0O8KgIMKgIMKgICZndDsgK8KgIMKgIGRpc3BfZGVzYy5uZXdGcmFtZUV2ZW50SGFu
ZGxlciA9IF4odm9pZCkgezxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAgJmd0OyArwqAg
wqAgwqAgwqAgdHJhY2VfYXBwbGVfZ2Z4X25ld19mcmFtZSgpOzxicj4NCiZndDvCoCDCoCDCoCAm
Z3Q7wqAgwqAgwqAgJmd0OyArwqAgwqAgwqAgwqAgZGlzcGF0Y2hfYXN5bmMocy0mZ3Q7cmVuZGVy
X3F1ZXVlLCBeezxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAgJmd0OyArwqAgwqAgwqAg
wqAgwqAgwqAgLyogRHJvcCBmcmFtZXMgaWYgd2UgZ2V0IHRvbyBmYXIgYWhlYWQuICovPGJyPg0K
Jmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCBicWxfbG9j
aygpOzxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAgJmd0OyArwqAgwqAgwqAgwqAgwqAg
wqAgaWYgKHMtJmd0O3BlbmRpbmdfZnJhbWVzICZndDs9IDIpIHs8YnI+DQomZ3Q7wqAgwqAgwqAg
Jmd0O8KgIMKgIMKgICZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGJxbF91bmxvY2soKTs8
YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIHJldHVybjs8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZndDsgK8KgIMKgIMKg
IMKgIMKgIMKgIH08YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZndDsgK8KgIMKgIMKg
IMKgIMKgIMKgICsrcy0mZ3Q7cGVuZGluZ19mcmFtZXM7PGJyPg0KJmd0O8KgIMKgIMKgICZndDvC
oCDCoCDCoCAmZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCBpZiAocy0mZ3Q7cGVuZGluZ19mcmFtZXMg
Jmd0OyAxKSB7PGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7ICvCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCBicWxfdW5sb2NrKCk7PGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDC
oCAmZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCByZXR1cm47PGJyPg0KJmd0O8KgIMKgIMKg
ICZndDvCoCDCoCDCoCAmZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCB9PGJyPg0KJmd0O8KgIMKgIMKg
ICZndDvCoCDCoCDCoCAmZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCBAYXV0b3JlbGVhc2Vwb29sIHs8
YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIGFwcGxlX2dmeF9yZW5kZXJfbmV3X2ZyYW1lX2JxbF91bmxvY2socyk7PGJyPg0KJmd0O8Kg
IMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCB9PGJyPg0KJmd0O8Kg
IMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7ICvCoCDCoCDCoCDCoCB9KTs8YnI+DQomZ3Q7wqAgwqAg
wqAgJmd0O8KgIMKgIMKgICZndDsgK8KgIMKgIH07PGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDC
oCDCoCAmZ3Q7ICvCoCDCoCBkaXNwX2Rlc2MubW9kZUNoYW5nZUhhbmRsZXIgPSBeKFBHRGlzcGxh
eUNvb3JkX3Q8YnI+DQomZ3Q7wqAgwqAgwqBzaXplSW5QaXhlbHMsPGJyPg0KJmd0O8KgIMKgIMKg
ICZndDvCoCDCoCDCoCAmZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCBPU1R5cGUgcGl4ZWxGb3JtYXQpIHs8YnI+DQomZ3Q7wqAgwqAgwqAg
Jmd0O8KgIMKgIMKgICZndDsgK8KgIMKgIMKgIMKgIHRyYWNlX2FwcGxlX2dmeF9tb2RlX2NoYW5n
ZShzaXplSW5QaXhlbHMueCw8YnI+DQomZ3Q7wqAgwqAgwqBzaXplSW5QaXhlbHMueSk7PGJyPg0K
Jmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7ICs8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8Kg
IMKgIMKgICZndDsgK8KgIMKgIMKgIMKgIEJRTF9MT0NLX0dVQVJEKCk7PGJyPg0KJmd0O8KgIMKg
IMKgICZndDvCoCDCoCDCoCAmZ3Q7ICvCoCDCoCDCoCDCoCBzZXRfbW9kZShzLCBzaXplSW5QaXhl
bHMueCwgc2l6ZUluUGl4ZWxzLnkpOzxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAgJmd0
OyArwqAgwqAgfTs8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZndDsgK8KgIMKgIGRp
c3BfZGVzYy5jdXJzb3JHbHlwaEhhbmRsZXIgPSBeKE5TQml0bWFwSW1hZ2VSZXAgKmdseXBoLDxi
cj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAgJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBQR0Rpc3BsYXlDb29yZF90PGJyPg0K
Jmd0O8KgIMKgIMKgaG90U3BvdCkgezxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAgJmd0
OyArwqAgwqAgwqAgwqAgW2dseXBoIHJldGFpbl07PGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDC
oCDCoCAmZ3Q7ICvCoCDCoCDCoCDCoCBkaXNwYXRjaF9hc3luYyhnZXRfYmFja2dyb3VuZF9xdWV1
ZSgpLCBeezxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAgJmd0OyArwqAgwqAgwqAgwqAg
wqAgwqAgQlFMX0xPQ0tfR1VBUkQoKTs8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZn
dDsgK8KgIMKgIMKgIMKgIMKgIMKgIHVpbnQzMl90IGJwcCA9IGdseXBoLmJpdHNQZXJQaXhlbDs8
YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIHNp
emVfdCB3aWR0aCA9IGdseXBoLnBpeGVsc1dpZGU7PGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDC
oCDCoCAmZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCBzaXplX3QgaGVpZ2h0ID0gZ2x5cGgucGl4ZWxz
SGlnaDs8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZndDsgK8KgIMKgIMKgIMKgIMKg
IMKgIHNpemVfdCBwYWRkaW5nX2J5dGVzX3Blcl9yb3cgPTxicj4NCiZndDvCoCDCoCDCoGdseXBo
LmJ5dGVzUGVyUm93IC08YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgd2lkdGggKiA0Ozxi
cj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAgJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgY29u
c3QgdWludDhfdCogcHhfZGF0YSA9IGdseXBoLmJpdG1hcERhdGE7PGJyPg0KJmd0O8KgIMKgIMKg
ICZndDvCoCDCoCDCoCAmZ3Q7ICs8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZndDsg
K8KgIMKgIMKgIMKgIMKgIMKgIHRyYWNlX2FwcGxlX2dmeF9jdXJzb3Jfc2V0KGJwcCwgd2lkdGgs
IGhlaWdodCk7PGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7ICs8YnI+DQomZ3Q7
wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIGlmIChzLSZndDtj
dXJzb3IpIHs8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZndDsgK8KgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIGN1cnNvcl91bnJlZihzLSZndDtjdXJzb3IpOzxicj4NCiZndDvCoCDCoCDC
oCAmZ3Q7wqAgwqAgwqAgJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgcy0mZ3Q7Y3Vyc29y
ID0gTlVMTDs8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZndDsgK8KgIMKgIMKgIMKg
IMKgIMKgIH08YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZndDsgKzxicj4NCiZndDvC
oCDCoCDCoCAmZ3Q7wqAgwqAgwqAgJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgaWYgKGJwcCA9PSAz
MikgeyAvKiBTaG91bGRuJiMzOTt0IGJlIGFueXRoaW5nPGJyPg0KJmd0O8KgIMKgIMKgZWxzZSwg
YnV0PGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoGp1c3QgdG8gYmUgc2FmZS4uLiovPGJy
Pg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCBzLSZndDtjdXJzb3IgPSBjdXJzb3JfYWxsb2Mod2lkdGgsIGhlaWdodCk7PGJyPg0KJmd0O8Kg
IMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBzLSZndDtj
dXJzb3ItJmd0O2hvdF94ID0gaG90U3BvdC54Ozxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAg
wqAgJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgcy0mZ3Q7Y3Vyc29yLSZndDtob3RfeSA9
IGhvdFNwb3QueTs8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZndDsgKzxicj4NCiZn
dDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAgJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgdWlu
dDMyX3QgKmRlc3RfcHggPSBzLSZndDtjdXJzb3ItJmd0O2RhdGE7PGJyPg0KJmd0O8KgIMKgIMKg
ICZndDvCoCDCoCDCoCAmZ3Q7ICs8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZndDsg
K8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGZvciAoc2l6ZV90IHkgPSAwOyB5ICZsdDsgaGVpZ2h0
OyArK3kpIHs8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZndDsgK8KgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIGZvciAoc2l6ZV90IHggPSAwOyB4ICZsdDsgd2lkdGg7ICsreCkg
ezxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAgJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgLyogTlNCaXRtYXBJbWFnZVJlcCYjMzk7cyByZWQgJmFtcDsgYmx1
ZTxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqBjaGFubmVscyBhcmUgc3dhcHBlZDxicj4N
CiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAgJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAqIGNvbXBhcmVkIHRvIFFFTVVDdXJzb3ImIzM5O3MuICovPGJyPg0KJmd0
O8KgIMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCAqZGVzdF9weCA9PGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7ICvC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCAocHhfZGF0YVswXSAmbHQ7
Jmx0OyAxNnUpIHw8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZndDsgK8KgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIChweF9kYXRhWzFdICZsdDsmbHQ7wqAg
OHUpIHw8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZndDsgK8KgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIChweF9kYXRhWzJdICZsdDsmbHQ7wqAgMHUpIHw8
YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIChweF9kYXRhWzNdICZsdDsmbHQ7IDI0dSk7PGJyPg0KJmd0
O8KgIMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCArK2Rlc3RfcHg7PGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7ICvC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBweF9kYXRhICs9IDQ7PGJyPg0KJmd0
O8KgIMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCB9PGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7ICvCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCBweF9kYXRhICs9IHBhZGRpbmdfYnl0ZXNfcGVyX3Jvdzs8YnI+DQomZ3Q7
wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIH08YnI+
DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IGRweV9jdXJzb3JfZGVmaW5lKHMtJmd0O2Nvbiwgcy0mZ3Q7Y3Vyc29yKTs8YnI+DQomZ3Q7wqAg
wqAgwqAgJmd0O8KgIMKgIMKgICZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHVwZGF0ZV9j
dXJzb3Iocyk7PGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7ICvCoCDCoCDCoCDC
oCDCoCDCoCB9PGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7ICvCoCDCoCDCoCDC
oCDCoCDCoCBbZ2x5cGggcmVsZWFzZV07PGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoCAm
Z3Q7ICvCoCDCoCDCoCDCoCB9KTs8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZndDsg
K8KgIMKgIH07PGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7ICvCoCDCoCBkaXNw
X2Rlc2MuY3Vyc29yU2hvd0hhbmRsZXIgPSBeKEJPT0wgc2hvdykgezxicj4NCiZndDvCoCDCoCDC
oCAmZ3Q7wqAgwqAgwqAgJmd0OyArwqAgwqAgwqAgwqAgZGlzcGF0Y2hfYXN5bmMoZ2V0X2JhY2tn
cm91bmRfcXVldWUoKSwgXns8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZndDsgK8Kg
IMKgIMKgIMKgIMKgIMKgIEJRTF9MT0NLX0dVQVJEKCk7PGJyPg0KJmd0O8KgIMKgIMKgICZndDvC
oCDCoCDCoCAmZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCB0cmFjZV9hcHBsZV9nZnhfY3Vyc29yX3No
b3coc2hvdyk7PGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7ICvCoCDCoCDCoCDC
oCDCoCDCoCBzLSZndDtjdXJzb3Jfc2hvdyA9IHNob3c7PGJyPg0KJmd0O8KgIMKgIMKgICZndDvC
oCDCoCDCoCAmZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCB1cGRhdGVfY3Vyc29yKHMpOzxicj4NCiZn
dDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAgJmd0OyArwqAgwqAgwqAgwqAgfSk7PGJyPg0KJmd0O8Kg
IMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7ICvCoCDCoCB9Ozxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7
wqAgwqAgwqAgJmd0OyArwqAgwqAgZGlzcF9kZXNjLmN1cnNvck1vdmVIYW5kbGVyID0gXih2b2lk
KSB7PGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7ICvCoCDCoCDCoCDCoCBkaXNw
YXRjaF9hc3luYyhnZXRfYmFja2dyb3VuZF9xdWV1ZSgpLCBeezxicj4NCiZndDvCoCDCoCDCoCAm
Z3Q7wqAgwqAgwqAgJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgQlFMX0xPQ0tfR1VBUkQoKTs8YnI+
DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIHRyYWNl
X2FwcGxlX2dmeF9jdXJzb3JfbW92ZSgpOzxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAg
Jmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgdXBkYXRlX2N1cnNvcihzKTs8YnI+DQomZ3Q7wqAgwqAg
wqAgJmd0O8KgIMKgIMKgICZndDsgK8KgIMKgIMKgIMKgIH0pOzxicj4NCiZndDvCoCDCoCDCoCAm
Z3Q7wqAgwqAgwqAgJmd0OyArwqAgwqAgfTs8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKg
ICZndDsgKzxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAgJmd0OyArwqAgwqAgcmV0dXJu
IGRpc3BfZGVzYzs8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZndDsgK308YnI+DQom
Z3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZndDsgKzxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAg
wqAgwqAgJmd0OyArc3RhdGljIE5TQXJyYXkmbHQ7UEdEaXNwbGF5TW9kZSomZ3Q7Kjxicj4NCiZn
dDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqBhcHBsZV9nZnhfcHJlcGFyZV9kaXNwbGF5X21vZGVfYXJy
YXkodm9pZCk8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZndDsgK3s8YnI+DQomZ3Q7
wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZndDsgK8KgIMKgIFBHRGlzcGxheU1vZGUgKm1vZGVzW0FS
UkFZX1NJWkUoYXBwbGVfZ2Z4X21vZGVzKV07PGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDC
oCAmZ3Q7ICvCoCDCoCBOU0FycmF5Jmx0O1BHRGlzcGxheU1vZGUqJmd0OyogbW9kZV9hcnJheSA9
IG5pbDs8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZndDsgK8KgIMKgIGludCBpOzxi
cj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAgJmd0OyArPGJyPg0KJmd0O8KgIMKgIMKgICZn
dDvCoCDCoCDCoCAmZ3Q7ICvCoCDCoCBmb3IgKGkgPSAwOyBpICZsdDsgQVJSQVlfU0laRShhcHBs
ZV9nZnhfbW9kZXMpOyBpKyspIHs8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZndDsg
K8KgIMKgIMKgIMKgIG1vZGVzW2ldID08YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZn
dDsgK8KgIMKgIMKgIMKgIMKgIMKgIFtbUEdEaXNwbGF5TW9kZSBhbGxvY108YnI+DQomZ3Q7wqAg
wqAgwqAgJmd0O8KgIMKgIMKgaW5pdFdpdGhTaXplSW5QaXhlbHM6YXBwbGVfZ2Z4X21vZGVzW2ld
IHJlZnJlc2hSYXRlSW5Iejo2MC5dOzxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAgJmd0
OyArwqAgwqAgfTxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAgJmd0OyArPGJyPg0KJmd0
O8KgIMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7ICvCoCDCoCBtb2RlX2FycmF5ID0gW05TQXJyYXkg
YXJyYXlXaXRoT2JqZWN0czptb2Rlczxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqBjb3Vu
dDpBUlJBWV9TSVpFKGFwcGxlX2dmeF9tb2RlcyldOzxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAg
wqAgwqAgJmd0OyArPGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7ICvCoCDCoCBm
b3IgKGkgPSAwOyBpICZsdDsgQVJSQVlfU0laRShhcHBsZV9nZnhfbW9kZXMpOyBpKyspIHs8YnI+
DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZndDsgK8KgIMKgIMKgIMKgIFttb2Rlc1tpXSBy
ZWxlYXNlXTs8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZndDsgK8KgIMKgIMKgIMKg
IG1vZGVzW2ldID0gbmlsOzxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAgJmd0OyArwqAg
wqAgfTxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAgJmd0OyArPGJyPg0KJmd0O8KgIMKg
IMKgICZndDvCoCDCoCDCoCAmZ3Q7ICvCoCDCoCByZXR1cm4gbW9kZV9hcnJheTs8YnI+DQomZ3Q7
wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZndDsgK308YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKg
IMKgICZndDsgKzxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAgJmd0OyArc3RhdGljIGlk
Jmx0O01UTERldmljZSZndDsgY29weV9zdWl0YWJsZV9tZXRhbF9kZXZpY2Uodm9pZCk8YnI+DQom
Z3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZndDsgK3s8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8Kg
IMKgIMKgICZndDsgK8KgIMKgIGlkJmx0O01UTERldmljZSZndDsgZGV2ID0gbmlsOzxicj4NCiZn
dDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAgJmd0OyArwqAgwqAgTlNBcnJheSZsdDtpZCZsdDtNVExE
ZXZpY2UmZ3Q7Jmd0OyAqZGV2cyA9IE1UTENvcHlBbGxEZXZpY2VzKCk7PGJyPg0KJmd0O8KgIMKg
IMKgICZndDvCoCDCoCDCoCAmZ3Q7ICs8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZn
dDsgK8KgIMKgIC8qIFByZWZlciBhIHVuaWZpZWQgbWVtb3J5IEdQVS4gRmFpbGluZyB0aGF0LCBw
aWNrIGEgbm9uLTxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqByZW1vdmFibGUgR1BVLiAq
Lzxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAgJmd0OyArwqAgwqAgZm9yIChzaXplX3Qg
aSA9IDA7IGkgJmx0OyBkZXZzLmNvdW50OyArK2kpIHs8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8Kg
IMKgIMKgICZndDsgK8KgIMKgIMKgIMKgIGlmIChkZXZzW2ldLmhhc1VuaWZpZWRNZW1vcnkpIHs8
YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIGRl
diA9IGRldnNbaV07PGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7ICvCoCDCoCDC
oCDCoCDCoCDCoCBicmVhazs8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZndDsgK8Kg
IMKgIMKgIMKgIH08YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZndDsgK8KgIMKgIMKg
IMKgIGlmICghZGV2c1tpXS5yZW1vdmFibGUpIHs8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKg
IMKgICZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIGRldiA9IGRldnNbaV07PGJyPg0KJmd0O8KgIMKg
IMKgICZndDvCoCDCoCDCoCAmZ3Q7ICvCoCDCoCDCoCDCoCB9PGJyPg0KJmd0O8KgIMKgIMKgICZn
dDvCoCDCoCDCoCAmZ3Q7ICvCoCDCoCB9PGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoCAm
Z3Q7ICs8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZndDsgK8KgIMKgIGlmIChkZXYg
IT0gbmlsKSB7PGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7ICvCoCDCoCDCoCDC
oCBbZGV2IHJldGFpbl07PGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7ICvCoCDC
oCB9IGVsc2Ugezxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAgJmd0OyArwqAgwqAgwqAg
wqAgZGV2ID0gTVRMQ3JlYXRlU3lzdGVtRGVmYXVsdERldmljZSgpOzxicj4NCiZndDvCoCDCoCDC
oCAmZ3Q7wqAgwqAgwqAgJmd0OyArwqAgwqAgfTxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAg
wqAgJmd0OyArwqAgwqAgW2RldnMgcmVsZWFzZV07PGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDC
oCDCoCAmZ3Q7ICs8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZndDsgK8KgIMKgIHJl
dHVybiBkZXY7PGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7ICt9PGJyPg0KJmd0
O8KgIMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7ICs8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKg
IMKgICZndDsgK3ZvaWQgYXBwbGVfZ2Z4X2NvbW1vbl9yZWFsaXplKEFwcGxlR0ZYU3RhdGUgKnMs
PGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoFBHRGV2aWNlRGVzY3JpcHRvciAqZGVzYyw8
YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIEVycm9yICoqZXJycCk8YnI+DQomZ3Q7wqAgwqAgwqAg
Jmd0O8KgIMKgIMKgICZndDsgK3s8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZndDsg
K8KgIMKgIFBHRGlzcGxheURlc2NyaXB0b3IgKmRpc3BfZGVzYyA9IG5pbDs8YnI+DQomZ3Q7wqAg
wqAgwqAgJmd0O8KgIMKgIMKgICZndDsgKzxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAg
Jmd0OyArwqAgwqAgaWYgKGFwcGxlX2dmeF9taWdfYmxvY2tlciA9PSBOVUxMKSB7PGJyPg0KJmd0
O8KgIMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7ICvCoCDCoCDCoCDCoCBlcnJvcl9zZXRnKCZhbXA7
YXBwbGVfZ2Z4X21pZ19ibG9ja2VyLDxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAgJmd0
OyArwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgJnF1b3Q7TWlncmF0aW9uIHN0YXRlIGJsb2Nr
ZWQgYnkgYXBwbGUtZ2Z4PGJyPg0KJmd0O8KgIMKgIMKgZGlzcGxheTxicj4NCiZndDvCoCDCoCDC
oCAmZ3Q7wqAgwqAgwqBkZXZpY2UmcXVvdDspOzxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAg
wqAgJmd0OyArwqAgwqAgwqAgwqAgaWYgKG1pZ3JhdGVfYWRkX2Jsb2NrZXIoJmFtcDthcHBsZV9n
ZnhfbWlnX2Jsb2NrZXIsPGJyPg0KJmd0O8KgIMKgIMKgZXJycCkgJmx0OyAwKSB7PGJyPg0KJmd0
O8KgIMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCByZXR1cm47PGJy
Pg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7ICvCoCDCoCDCoCDCoCB9PGJyPg0KJmd0
O8KgIMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7ICvCoCDCoCB9PGJyPg0KJmd0O8KgIMKgIMKgICZn
dDvCoCDCoCDCoCAmZ3Q7ICs8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZndDsgK8Kg
IMKgIFFUQUlMUV9JTklUKCZhbXA7cy0mZ3Q7dGFza3MpOzxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7
wqAgwqAgwqAgJmd0OyArwqAgwqAgcy0mZ3Q7cmVuZGVyX3F1ZXVlID0gZGlzcGF0Y2hfcXVldWVf
Y3JlYXRlKCZxdW90O2FwcGxlLTxicj4NCiZndDvCoCDCoCDCoGdmeC5yZW5kZXImcXVvdDssPGJy
Pg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoDxicj4NCiZndDvCoCDC
oCDCoERJU1BBVENIX1FVRVVFX1NFUklBTCk7PGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDC
oCAmZ3Q7ICvCoCDCoCBzLSZndDttdGwgPSBjb3B5X3N1aXRhYmxlX21ldGFsX2RldmljZSgpOzxi
cj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAgJmd0OyArwqAgwqAgcy0mZ3Q7bXRsX3F1ZXVl
ID0gW3MtJmd0O210bCBuZXdDb21tYW5kUXVldWVdOzxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAg
wqAgwqAgJmd0OyArPGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7ICvCoCDCoCBk
ZXNjLmRldmljZSA9IHMtJmd0O210bDs8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZn
dDsgKzxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAgJmd0OyArwqAgwqAgYXBwbGVfZ2Z4
X3JlZ2lzdGVyX3Rhc2tfbWFwcGluZ19oYW5kbGVycyhzLCBkZXNjKTs8YnI+DQomZ3Q7wqAgwqAg
wqAgJmd0O8KgIMKgIMKgICZndDsgKzxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAgJmd0
OyArwqAgwqAgcy0mZ3Q7cGdkZXYgPSBQR05ld0RldmljZVdpdGhEZXNjcmlwdG9yKGRlc2MpOzxi
cj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAgJmd0OyArPGJyPg0KJmd0O8KgIMKgIMKgICZn
dDvCoCDCoCDCoCAmZ3Q7ICvCoCDCoCBkaXNwX2Rlc2MgPSBhcHBsZV9nZnhfcHJlcGFyZV9kaXNw
bGF5X2Rlc2NyaXB0b3Iocyk7PGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7ICvC
oCDCoCBzLSZndDtwZ2Rpc3AgPSBbcy0mZ3Q7cGdkZXYgbmV3RGlzcGxheVdpdGhEZXNjcmlwdG9y
OmRpc3BfZGVzYzxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAgJmd0OyArwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgcG9ydDowPGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoHNlcmlhbE51bToxMjM0XTs8
YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZndDsgK8KgIMKgIFtkaXNwX2Rlc2MgcmVs
ZWFzZV07PGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7ICvCoCDCoCBzLSZndDtw
Z2Rpc3AubW9kZUxpc3QgPTxicj4NCiZndDvCoCDCoCDCoGFwcGxlX2dmeF9wcmVwYXJlX2Rpc3Bs
YXlfbW9kZV9hcnJheSgpOzxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAgJmd0OyArPGJy
Pg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7ICvCoCDCoCBjcmVhdGVfZmIocyk7PGJy
Pg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7ICs8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0
O8KgIMKgIMKgICZndDsgK8KgIMKgIHFlbXVfbXV0ZXhfaW5pdCgmYW1wO3MtJmd0O2pvYl9tdXRl
eCk7PGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7ICvCoCDCoCBxZW11X2NvbmRf
aW5pdCgmYW1wO3MtJmd0O2pvYl9jb25kKTs8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKg
ICZndDsgK308YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZndDsgZGlmZiAtLWdpdCBh
L2h3L2Rpc3BsYXkvbWVzb24uYnVpbGQgYi9ody9kaXNwbGF5L21lc29uLmJ1aWxkPGJyPg0KJmd0
O8KgIMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7IGluZGV4IDIwYTk0OTczZmEyLi42MTllNjQyOTA1
YSAxMDA2NDQ8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZndDsgLS0tIGEvaHcvZGlz
cGxheS9tZXNvbi5idWlsZDxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAgJmd0OyArKysg
Yi9ody9kaXNwbGF5L21lc29uLmJ1aWxkPGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoCAm
Z3Q7IEBAIC02MSw2ICs2MSwxMCBAQCBzeXN0ZW1fc3MuYWRkKHdoZW46ICYjMzk7Q09ORklHX0FS
VElTVCYjMzk7LDxicj4NCiZndDvCoCDCoCDCoGlmX3RydWU6PGJyPg0KJmd0O8KgIMKgIMKgICZn
dDvCoCDCoCDCoGZpbGVzKCYjMzk7YXJ0aXN0LmMmIzM5OykpPGJyPg0KJmd0O8KgIMKgIMKgICZn
dDvCoCDCoCDCoCAmZ3Q7PGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7wqAgwqBz
eXN0ZW1fc3MuYWRkKHdoZW46ICYjMzk7Q09ORklHX0FUSV9WR0EmIzM5OywgaWZfdHJ1ZTo8YnI+
DQomZ3Q7wqAgwqAgwqBbZmlsZXMoJiMzOTthdGkuYyYjMzk7LDxicj4NCiZndDvCoCDCoCDCoCAm
Z3Q7wqAgwqAgwqAmIzM5O2F0aV8yZC5jJiMzOTssICYjMzk7YXRpX2RiZy5jJiMzOTspLCBwaXht
YW5dKTxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAgJmd0Ozxicj4NCiZndDvCoCDCoCDC
oCAmZ3Q7wqAgwqAgwqAgJmd0OyArc3lzdGVtX3NzLmFkZCh3aGVuOiAmIzM5O0NPTkZJR19NQUNf
UFZHJiMzOTsswqAgwqAgwqAgwqAgwqBpZl90cnVlOjxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAg
wqAgwqBbZmlsZXMoJiMzOTthcHBsZS1nZngubSYjMzk7KSwgcHZnLCBtZXRhbF0pPGJyPg0KJmd0
O8KgIMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7ICtpZiBjcHUgPT0gJiMzOTthYXJjaDY0JiMzOTs8
YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZndDsgK8KgIHN5c3RlbV9zcy5hZGQod2hl
bjogJiMzOTtDT05GSUdfTUFDX1BWR19NTUlPJiMzOTsswqAgaWZfdHJ1ZTo8YnI+DQomZ3Q7wqAg
wqAgwqAgJmd0O8KgIMKgIMKgW2ZpbGVzKCYjMzk7YXBwbGUtZ2Z4LW1taW8ubSYjMzk7KSwgcHZn
LCBtZXRhbF0pPGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7ICtlbmRpZjxicj4N
CiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAgJmd0Ozxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAg
wqAgwqAgJmd0O8KgIMKgaWYgY29uZmlnX2FsbF9kZXZpY2VzLmhhc19rZXkoJiMzOTtDT05GSUdf
VklSVElPX0dQVSYjMzk7KTxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAgJmd0O8KgIMKg
IMKgdmlydGlvX2dwdV9zcyA9IHNzLnNvdXJjZV9zZXQoKTxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7
wqAgwqAgwqAgJmd0OyBkaWZmIC0tZ2l0IGEvaHcvZGlzcGxheS90cmFjZS1ldmVudHMgYi9ody9k
aXNwbGF5L3RyYWNlLWV2ZW50czxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAgJmd0OyBp
bmRleCA3ODFmOGEzMzIwMy4uMjE0OTk4MzEyYjkgMTAwNjQ0PGJyPg0KJmd0O8KgIMKgIMKgICZn
dDvCoCDCoCDCoCAmZ3Q7IC0tLSBhL2h3L2Rpc3BsYXkvdHJhY2UtZXZlbnRzPGJyPg0KJmd0O8Kg
IMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7ICsrKyBiL2h3L2Rpc3BsYXkvdHJhY2UtZXZlbnRzPGJy
Pg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7IEBAIC0xOTEsMyArMTkxLDI5IEBAIGRt
MTYzX2JpdHNfcHBpKHVuc2lnbmVkIGRlc3Rfd2lkdGgpPGJyPg0KJmd0O8KgIMKgIMKgICZndDvC
oCDCoCDCoCZxdW90O2Rlc3Rfd2lkdGggOiAldSZxdW90Ozxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7
wqAgwqAgwqAgJmd0O8KgIMKgZG0xNjNfbGVkcyhpbnQgbGVkLCB1aW50MzJfdCB2YWx1ZSkgJnF1
b3Q7bGVkICVkOiAweCV4JnF1b3Q7PGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7
wqAgwqBkbTE2M19jaGFubmVscyhpbnQgY2hhbm5lbCwgdWludDhfdCB2YWx1ZSkgJnF1b3Q7Y2hh
bm5lbCAlZDo8YnI+DQomZ3Q7wqAgwqAgwqAweCV4JnF1b3Q7PGJyPg0KJmd0O8KgIMKgIMKgICZn
dDvCoCDCoCDCoCAmZ3Q7wqAgwqBkbTE2M19yZWZyZXNoX3JhdGUodWludDMyX3QgcnIpICZxdW90
O3JlZnJlc2ggcmF0ZSAlZCZxdW90Ozxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAgJmd0
OyArPGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7ICsjIGFwcGxlLWdmeC5tPGJy
Pg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7ICthcHBsZV9nZnhfcmVhZCh1aW50NjRf
dCBvZmZzZXQsIHVpbnQ2NF90IHJlcyk8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgJnF1
b3Q7b2Zmc2V0PTB4JSZxdW90O1BSSXg2NCZxdW90OyByZXM9MHglJnF1b3Q7UFJJeDY0PGJyPg0K
Jmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7ICthcHBsZV9nZnhfd3JpdGUodWludDY0X3Qg
b2Zmc2V0LCB1aW50NjRfdCB2YWwpPGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoCZxdW90
O29mZnNldD0weCUmcXVvdDtQUkl4NjQmcXVvdDsgdmFsPTB4JSZxdW90O1BSSXg2NDxicj4NCiZn
dDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAgJmd0OyArYXBwbGVfZ2Z4X2NyZWF0ZV90YXNrKHVpbnQz
Ml90IHZtX3NpemUsIHZvaWQgKnZhKTxicj4NCiZndDvCoCDCoCDCoCZxdW90O3ZtX3NpemU9MHgl
eDxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqBiYXNlX2FkZHI9JXAmcXVvdDs8YnI+DQom
Z3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZndDsgK2FwcGxlX2dmeF9kZXN0cm95X3Rhc2sodm9p
ZCAqdGFzaykgJnF1b3Q7dGFzaz0lcCZxdW90Ozxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAg
wqAgJmd0OyArYXBwbGVfZ2Z4X21hcF9tZW1vcnkodm9pZCAqdGFzaywgdWludDMyX3QgcmFuZ2Vf
Y291bnQsPGJyPg0KJmd0O8KgIMKgIMKgdWludDY0X3Q8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8Kg
IMKgIMKgdmlydHVhbF9vZmZzZXQsIHVpbnQzMl90IHJlYWRfb25seSkgJnF1b3Q7dGFzaz0lcCBy
YW5nZV9jb3VudD0weCV4PGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoHZpcnR1YWxfb2Zm
c2V0PTB4JSZxdW90O1BSSXg2NCZxdW90OyByZWFkX29ubHk9JWQmcXVvdDs8YnI+DQomZ3Q7wqAg
wqAgwqAgJmd0O8KgIMKgIMKgICZndDsgK2FwcGxlX2dmeF9tYXBfbWVtb3J5X3JhbmdlKHVpbnQz
Ml90IGksIHVpbnQ2NF90IHBoeXNfYWRkciw8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKg
dWludDY0X3QgcGh5c19sZW4pICZxdW90O1slZF0gcGh5c19hZGRyPTB4JSZxdW90O1BSSXg2NCZx
dW90Ozxicj4NCiZndDvCoCDCoCDCoHBoeXNfbGVuPTB4JSZxdW90O1BSSXg2NDxicj4NCiZndDvC
oCDCoCDCoCAmZ3Q7wqAgwqAgwqAgJmd0OyArYXBwbGVfZ2Z4X3JlbWFwKHVpbnQ2NF90IHJldHZh
bCwgdWludDY0X3Qgc291cmNlLCB1aW50NjRfdDxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAg
wqB0YXJnZXQpICZxdW90O3JldHZhbD0lJnF1b3Q7UFJJZDY0JnF1b3Q7IHNvdXJjZT0weCUmcXVv
dDtQUkl4NjQmcXVvdDsgdGFyZ2V0PTB4JSZxdW90O1BSSXg2NDxicj4NCiZndDvCoCDCoCDCoCAm
Z3Q7wqAgwqAgwqAgJmd0OyArYXBwbGVfZ2Z4X3VubWFwX21lbW9yeSh2b2lkICp0YXNrLCB1aW50
NjRfdCB2aXJ0dWFsX29mZnNldCw8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgdWludDY0
X3QgbGVuZ3RoKSAmcXVvdDt0YXNrPSVwIHZpcnR1YWxfb2Zmc2V0PTB4JSZxdW90O1BSSXg2NCZx
dW90Ozxicj4NCiZndDvCoCDCoCDCoGxlbmd0aD0weCUmcXVvdDtQUkl4NjQ8YnI+DQomZ3Q7wqAg
wqAgwqAgJmd0O8KgIMKgIMKgICZndDsgK2FwcGxlX2dmeF9yZWFkX21lbW9yeSh1aW50NjRfdCBw
aHlzX2FkZHJlc3MsIHVpbnQ2NF90IGxlbmd0aCw8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKg
IMKgdm9pZCAqZHN0KSAmcXVvdDtwaHlzX2FkZHI9MHglJnF1b3Q7UFJJeDY0JnF1b3Q7IGxlbmd0
aD0weCUmcXVvdDtQUkl4NjQmcXVvdDsgZGVzdD0lcCZxdW90Ozxicj4NCiZndDvCoCDCoCDCoCAm
Z3Q7wqAgwqAgwqAgJmd0OyArYXBwbGVfZ2Z4X3JhaXNlX2lycSh1aW50MzJfdCB2ZWN0b3IpICZx
dW90O3ZlY3Rvcj0weCV4JnF1b3Q7PGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7
ICthcHBsZV9nZnhfbmV3X2ZyYW1lKHZvaWQpICZxdW90OyZxdW90Ozxicj4NCiZndDvCoCDCoCDC
oCAmZ3Q7wqAgwqAgwqAgJmd0OyArYXBwbGVfZ2Z4X21vZGVfY2hhbmdlKHVpbnQ2NF90IHgsIHVp
bnQ2NF90IHkpICZxdW90O3g9JSZxdW90O1BSSWQ2NCZxdW90Ozxicj4NCiZndDvCoCDCoCDCoCAm
Z3Q7wqAgwqAgwqB5PSUmcXVvdDtQUklkNjQ8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKg
ICZndDsgK2FwcGxlX2dmeF9jdXJzb3Jfc2V0KHVpbnQzMl90IGJwcCwgdWludDY0X3Qgd2lkdGgs
IHVpbnQ2NF90PGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoGhlaWdodCkgJnF1b3Q7YnBw
PSVkIHdpZHRoPSUmcXVvdDtQUklkNjQmcXVvdDsgaGVpZ2h0PTB4JSZxdW90O1BSSWQ2NDxicj4N
CiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAgJmd0OyArYXBwbGVfZ2Z4X2N1cnNvcl9zaG93KHVp
bnQzMl90IHNob3cpICZxdW90O3Nob3c9JWQmcXVvdDs8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8Kg
IMKgIMKgICZndDsgK2FwcGxlX2dmeF9jdXJzb3JfbW92ZSh2b2lkKSAmcXVvdDsmcXVvdDs8YnI+
DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZndDsgK2FwcGxlX2dmeF9jb21tb25faW5pdChj
b25zdCBjaGFyICpkZXZpY2VfbmFtZSwgc2l6ZV90PGJyPg0KJmd0O8KgIMKgIMKgbW1pb19zaXpl
KTxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAmcXVvdDtkZXZpY2U6ICVzOyBNTUlPIHNp
emU6ICV6dSBieXRlcyZxdW90Ozxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAgJmd0OyAr
PGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7ICsjIGFwcGxlLWdmeC1tbWlvLm08
YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZndDsgK2FwcGxlX2dmeF9tbWlvX2lvc2Zj
X3JlYWQodWludDY0X3Qgb2Zmc2V0LCB1aW50NjRfdCByZXMpPGJyPg0KJmd0O8KgIMKgIMKgICZn
dDvCoCDCoCDCoCZxdW90O29mZnNldD0weCUmcXVvdDtQUkl4NjQmcXVvdDsgcmVzPTB4JSZxdW90
O1BSSXg2NDxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAgJmd0OyArYXBwbGVfZ2Z4X21t
aW9faW9zZmNfd3JpdGUodWludDY0X3Qgb2Zmc2V0LCB1aW50NjRfdCB2YWwpPGJyPg0KJmd0O8Kg
IMKgIMKgICZndDvCoCDCoCDCoCZxdW90O29mZnNldD0weCUmcXVvdDtQUkl4NjQmcXVvdDsgdmFs
PTB4JSZxdW90O1BSSXg2NDxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAgJmd0OyArYXBw
bGVfZ2Z4X2lvc2ZjX21hcF9tZW1vcnkodWludDY0X3QgcGh5cywgdWludDY0X3QgbGVuLDxicj4N
CiZndDvCoCDCoCDCoHVpbnQzMl90PGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoHJvLCB2
b2lkICp2YSwgdm9pZCAqZSwgdm9pZCAqZiwgdm9pZCogdmFfcmVzdWx0LCBpbnQgc3VjY2Vzcyk8
YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgJnF1b3Q7cGh5cz0weCUmcXVvdDtQUkl4NjQm
cXVvdDsgbGVuPTB4JSZxdW90O1BSSXg2NCZxdW90OyBybz0lZCB2YT0lcCBlPSVwIGY9JXAgLSZn
dDs8YnI+DQomZ3Q7wqAgwqAgwqAqdmE9JXAsPGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDC
oHN1Y2Nlc3MgPSAlZCZxdW90Ozxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqAgJmd0OyAr
YXBwbGVfZ2Z4X2lvc2ZjX3VubWFwX21lbW9yeSh2b2lkICphLCB2b2lkICpiLCB2b2lkICpjLDxi
cj4NCiZndDvCoCDCoCDCoHZvaWQgKmQsPGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoHZv
aWQgKmUsIHZvaWQgKmYpICZxdW90O2E9JXAgYj0lcCBjPSVwIGQ9JXAgZT0lcCBmPSVwJnF1b3Q7
PGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7ICthcHBsZV9nZnhfaW9zZmNfcmFp
c2VfaXJxKHVpbnQzMl90IHZlY3RvcikgJnF1b3Q7dmVjdG9yPTB4JXgmcXVvdDs8YnI+DQomZ3Q7
wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZndDsgKzxicj4NCiZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAg
wqAgJmd0OyBkaWZmIC0tZ2l0IGEvbWVzb24uYnVpbGQgYi9tZXNvbi5idWlsZDxicj4NCiZndDvC
oCDCoCDCoCAmZ3Q7wqAgwqAgwqAgJmd0OyBpbmRleCBkMjY2OTBjZTIwNC4uMGUxMjRlZmYxM2Yg
MTAwNjQ0PGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7IC0tLSBhL21lc29uLmJ1
aWxkPGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7ICsrKyBiL21lc29uLmJ1aWxk
PGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7IEBAIC03NjEsNiArNzYxLDggQEAg
c29ja2V0ID0gW108YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZndDvCoCDCoHZlcnNp
b25fcmVzID0gW108YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZndDvCoCDCoGNvcmVm
ID0gW108YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZndDvCoCDCoGlva2l0ID0gW108
YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZndDsgK3B2ZyA9IFtdPGJyPg0KJmd0O8Kg
IMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7ICttZXRhbCA9IFtdPGJyPg0KJmd0O8KgIMKgIMKgICZn
dDvCoCDCoCDCoCAmZ3Q7wqAgwqBlbXVsYXRvcl9saW5rX2FyZ3MgPSBbXTxicj4NCiZndDvCoCDC
oCDCoCAmZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgbWlkbCA9IG5vdF9mb3VuZDxicj4NCiZndDvCoCDC
oCDCoCAmZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgd2lkbCA9IG5vdF9mb3VuZDxicj4NCiZndDvCoCDC
oCDCoCAmZ3Q7wqAgwqAgwqAgJmd0OyBAQCAtNzgyLDYgKzc4NCw4IEBAIGVsaWYgaG9zdF9vcyA9
PSAmIzM5O2RhcndpbiYjMzk7PGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7wqAg
wqAgwqBjb3JlZiA9IGRlcGVuZGVuY3koJiMzOTthcHBsZWZyYW1ld29ya3MmIzM5OywgbW9kdWxl
czo8YnI+DQomZ3Q7wqAgwqAgwqAmIzM5O0NvcmVGb3VuZGF0aW9uJiMzOTspPGJyPg0KJmd0O8Kg
IMKgIMKgICZndDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqBpb2tpdCA9IGRlcGVuZGVuY3koJiMzOTth
cHBsZWZyYW1ld29ya3MmIzM5OywgbW9kdWxlczogJiMzOTtJT0tpdCYjMzk7LDxicj4NCiZndDvC
oCDCoCDCoCAmZ3Q7wqAgwqAgwqByZXF1aXJlZDogZmFsc2UpPGJyPg0KJmd0O8KgIMKgIMKgICZn
dDvCoCDCoCDCoCAmZ3Q7wqAgwqAgwqBob3N0X2Rzb3N1ZiA9ICYjMzk7LmR5bGliJiMzOTs8YnI+
DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZndDsgK8KgIHB2ZyA9IGRlcGVuZGVuY3koJiMz
OTthcHBsZWZyYW1ld29ya3MmIzM5OywgbW9kdWxlczo8YnI+DQomZ3Q7wqAgwqAgwqAgJmd0O8Kg
IMKgIMKgJiMzOTtQYXJhdmlydHVhbGl6ZWRHcmFwaGljcyYjMzk7KTxicj4NCiZndDvCoCDCoCDC
oCAmZ3Q7wqAgwqAgwqAgJmd0OyArwqAgbWV0YWwgPSBkZXBlbmRlbmN5KCYjMzk7YXBwbGVmcmFt
ZXdvcmtzJiMzOTssIG1vZHVsZXM6ICYjMzk7TWV0YWwmIzM5Oyk8YnI+DQomZ3Q7wqAgwqAgwqAg
Jmd0O8KgIMKgIMKgICZndDvCoCDCoGVsaWYgaG9zdF9vcyA9PSAmIzM5O3N1bm9zJiMzOTs8YnI+
DQomZ3Q7wqAgwqAgwqAgJmd0O8KgIMKgIMKgICZndDvCoCDCoCDCoHNvY2tldCA9IFtjYy5maW5k
X2xpYnJhcnkoJiMzOTtzb2NrZXQmIzM5OyksPGJyPg0KJmd0O8KgIMKgIMKgICZndDvCoCDCoCDC
oCAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBjYy5maW5kX2xpYnJhcnkoJiMzOTtuc2wmIzM5
OyksPGJyPg0KJmd0O8KgIMKgIMKgICZndDs8YnI+DQomZ3Q7IDxicj4NCjxicj4NCjwvYmxvY2tx
dW90ZT48L2Rpdj48L2Rpdj4NCg==
--000000000000caadfd062585b22f--

