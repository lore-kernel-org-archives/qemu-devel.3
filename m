Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1A0CD339A3
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2024 07:43:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5gsU-0003P3-JH; Tue, 29 Oct 2024 03:42:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1t5gsH-0003Np-Rk
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 03:42:46 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1t5gsC-0001IF-DZ
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 03:42:45 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-72097a5ca74so226499b3a.3
 for <qemu-devel@nongnu.org>; Tue, 29 Oct 2024 00:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1730187758; x=1730792558;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uuJZ19WtLdxfjQyVMkBdMKCy8aHM7u7Y3NgldeRpHgw=;
 b=YfK8apgzk+TDWJmuVKLjgTiV2BF6FvUi818W7ZsoEGZHju4l8Lxp8/UJy7Vapt8eaV
 fwRF92ARcCCmf5DDM0LOuhiu9JgHQsvcy3AiCCTyvuXoyedT5E8mMChzmSqd1iqvQK56
 SVc3H1qR+ilcVizU0MJuDANLuwGXFDUWjFAcXGL5/hvJcNDNhbv+CMg9tCkwGidGxnMu
 8XhSGWEgs3PITqZdnGkm4nu0RtGvrNH1MxxlSlQ02M71SLGlM2jP7Nz6bwEHyDb7gCQA
 8+4qMY+voH5xQ6N17dpUrEAodyUSTgLv6HuUsb1DoWVRVju0yFYsdesnGmj5oMOyFh6V
 wkbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730187758; x=1730792558;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uuJZ19WtLdxfjQyVMkBdMKCy8aHM7u7Y3NgldeRpHgw=;
 b=ZUDShlMlk7PE+cxEfFtrgWQXEnZdn0GPpCbHq44a9ou7TtugQLr/sy5esgNUbN+m7m
 LdMCl0qhpk13ztp1SEtBGGbAcg81e7dAPstSr/TdX1gnnK+wfA/QPufkbqFJC5AvXGkL
 aIgAwLhFW6wZDQXXNDEAAErkvcm8EIeuMTFp2oxGeEu/Nwa4xslc0uxiW4FOlsqKcxqg
 uubdDW/4dU2fIlKuhipwFbDGkGKs1V7Cv+lWSb6tdGvv55EXr0e3HVB2mVQTGVcCVxZ9
 srgUZNuI6YRwcu387tv0usmMIs12M0Ts7R8gCPrlNZyd8Q8H+KIh3y2wmcgevFmgPWzo
 W2cA==
X-Gm-Message-State: AOJu0YzbVqzcnchJdcILp+cSZYoMZ4H2QU6+rGLJY/8Mi8LWExc9qBJw
 wMzbrfI2QI2v9SW09YboVT2VKChfoNiXD2ljkP31BuKmq1tgIXz39VInJ9moyck=
X-Google-Smtp-Source: AGHT+IHThn+szCg4E27r/Iyamy4GkVJEo0c+oDZ8z1ZnGwwRZxGMt09eT5huFz+lyD9r0xCKZ5z4ig==
X-Received: by 2002:a05:6a20:9f95:b0:1d9:23ab:470 with SMTP id
 adf61e73a8af0-1d9a840afd3mr16357467637.29.1730187758025; 
 Tue, 29 Oct 2024 00:42:38 -0700 (PDT)
Received: from [157.82.207.107] ([157.82.207.107])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72057a20241sm6982699b3a.165.2024.10.29.00.42.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Oct 2024 00:42:37 -0700 (PDT)
Message-ID: <a8b4472c-8741-4f80-87e5-b406c56d1acd@daynix.com>
Date: Tue, 29 Oct 2024 16:42:30 +0900
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
 <6a989d04-6416-4bd9-98ac-e1230a1095a9@daynix.com>
 <CAAibmn3YEOT0O55-bwJkpi_oEGkA1WwvhC0w3jGbgXOZLTVa0w@mail.gmail.com>
 <CAAibmn3HZeDeK8FrYhHa1GGwc+N8rBuB2VvMRm7LCt0mUGmsYQ@mail.gmail.com>
 <27ced2db-472d-47ae-9047-9efc0b589a1e@daynix.com>
 <CAAibmn17=iTaEW0Q_E_n6gsS7vd-d8-w36yee9f2eZ+SR-d-ng@mail.gmail.com>
 <dbb394d4-f8fe-484d-974c-c84275f7a1c7@daynix.com>
 <CAAibmn1Th6w6JJcxgD7HA62qo-Lk0yV-Cg4XK9OYEtDvvQbhrg@mail.gmail.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <CAAibmn1Th6w6JJcxgD7HA62qo-Lk0yV-Cg4XK9OYEtDvvQbhrg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::429;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x429.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=unavailable autolearn_force=no
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

On 2024/10/29 6:06, Phil Dennis-Jordan wrote:
> 
> 
> On Mon, 28 Oct 2024 at 17:06, Akihiko Odaki <akihiko.odaki@daynix.com 
> <mailto:akihiko.odaki@daynix.com>> wrote:
> 
>     On 2024/10/28 23:13, Phil Dennis-Jordan wrote:
>      >
>      >
>      > On Mon, 28 Oct 2024 at 15:02, Akihiko Odaki
>     <akihiko.odaki@daynix.com <mailto:akihiko.odaki@daynix.com>
>      > <mailto:akihiko.odaki@daynix.com
>     <mailto:akihiko.odaki@daynix.com>>> wrote:
>      >
>      >     On 2024/10/28 22:31, Phil Dennis-Jordan wrote:
>      >      >
>      >      >
>      >      > On Mon, 28 Oct 2024 at 10:00, Phil Dennis-Jordan
>      >     <phil@philjordan.eu <mailto:phil@philjordan.eu>
>     <mailto:phil@philjordan.eu <mailto:phil@philjordan.eu>>
>      >      > <mailto:phil@philjordan.eu <mailto:phil@philjordan.eu>
>     <mailto:phil@philjordan.eu <mailto:phil@philjordan.eu>>>> wrote:
>      >      >
>      >      >
>      >      >          >      >
>      >      >          >      > Hmm. I think if we were to use that, we
>     would
>      >     need to
>      >      >         create a new
>      >      >          >      > QemuEvent for every job and destroy it
>     afterward,
>      >      >         which seems
>      >      >          >     expensive.
>      >      >          >      > We can't rule out multiple concurrent
>     jobs being
>      >      >         submitted, and the
>      >      >          >      > QemuEvent system only supports a single
>     producer as
>      >      >         far as I can
>      >      >          >     tell.
>      >      >          >      >
>      >      >          >      > You can probably sort of hack around it with
>      >     just one
>      >      >         QemuEvent by
>      >      >          >      > putting the qemu_event_wait into a loop
>     and turning
>      >      >         the job.done
>      >      >          >     flag
>      >      >          >      > into an atomic (because it would now
>     need to be
>      >      >         checked outside the
>      >      >          >      > lock) but this all seems unnecessarily
>     complicated
>      >      >         considering the
>      >      >          >      > QemuEvent uses the same mechanism QemuCond/
>      >     QemuMutex
>      >      >         internally
>      >      >          >     on macOS
>      >      >          >      > (the only platform relevant here), except we
>      >     can use it as
>      >      >          >     intended with
>      >      >          >      > QemuCond/QemuMutex rather than having to
>     work
>      >     against the
>      >      >          >     abstraction.
>      >      >          >
>      >      >          >     I don't think it's going to be used
>     concurrently. It
>      >      >         would be difficult
>      >      >          >     to reason even for the framework if it
>     performs memory
>      >      >          >     unmapping/mapping/reading operations
>     concurrently.
>      >      >          >
>      >      >          >
>      >      >          > I've just performed a very quick test by
>     wrapping the job
>      >      >         submission/
>      >      >          > wait in the 2 mapMemory callbacks and the 1
>     readMemory
>      >      >         callback with
>      >      >          > atomic counters and logging whenever a counter went
>      >     above 1.
>      >      >          >
>      >      >          >   * Overall, concurrent callbacks across all
>     types were
>      >      >         common (many per
>      >      >          > second when the VM is busy). It's not exactly a
>      >     "thundering
>      >      >         herd" (I
>      >      >          > never saw >2) but it's probably not a bad idea
>     to use
>      >     a separate
>      >      >          > condition variable for each job type. (task map,
>      >     surface map,
>      >      >         memory read)
>      >      >          >   * While I did not observe any concurrent
>     memory mapping
>      >      >         operations
>      >      >          > *within* a type of memory map (2 task mappings or 2
>      >     surface
>      >      >         mappings) I
>      >      >          > did see very occasional concurrent memory *read*
>      >     callbacks.
>      >      >         These would,
>      >      >          > as far as I can tell, not be safe with QemuEvents,
>      >     unless we
>      >      >         placed the
>      >      >          > event inside the job struct and init/destroyed
>     it on every
>      >      >         callback
>      >      >          > (which seems like excessive overhead).
>      >      >
>      >      >         I think we can tolerate that overhead. init/destroy
>      >     essentially
>      >      >         sets the
>      >      >         fields in the data structure and I estimate its
>     total size is
>      >      >         about 100
>      >      >         bytes. It is probably better than waking an
>     irrelevant thread
>      >      >         up. I also
>      >      >         hope that keeps the code simple; it's not worthwhile
>      >     adding code to
>      >      >         optimize this.
>      >      >
>      >      >
>      >      >     At least pthread_cond_{init,destroy} and
>      >      >     pthread_mutex_{init,destroy} don't make any syscalls,
>     so yeah
>      >     it's
>      >      >     probably an acceptable overhead.
>      >      >
>      >      >
>      >      > I've just experimented with QemuEvents created on-demand
>     and ran
>      >     into
>      >      > some weird deadlocks, which then made me sit down and
>     think about it
>      >      > some more. I've come to the conclusion that creating (and
>     crucially,
>      >      > destroying) QemuEvents on demand in this way is not safe.
>      >      >
>      >      > Specifically, you must not call qemu_event_destroy() - which
>      >      > transitively destroys the mutex and condition variable -
>     unless
>      >     you can
>      >      > guarantee that the qemu_event_set() call on that event
>     object has
>      >     completed.
>      >      >
>      >      > In qemu_event_set, the event object's value is atomically
>     set to
>      >     EV_SET.
>      >      > If the previous value was EV_BUSY, qemu_futex_wake() is
>     called.
>      >     All of
>      >      > this is outside any mutex, however, so apart from memory
>     coherence
>      >      > (there are barriers) this can race with the waiting thread.
>      >      > qemu_event_wait() reads the event's value. If EV_FREE, it's
>      >     atomically
>      >      > set to EV_BUSY. Then the mutex is locked, the value is checked
>      >     again,
>      >      > and if it's still EV_BUSY, it waits for the condition
>     variable,
>      >      > otherwise the mutex is immediately unlocked again. If the
>     trigger
>      >      > thread's qemu_event_set() flip to EV_SET occurs between
>     the waiting
>      >      > thread's two atomic reads of the value, the waiting thread
>     will
>      >     never
>      >      > wait for the condition variable, but the trigger thread
>     WILL try to
>      >      > acquire the mutex and signal the condition variable in
>      >      > qemu_futex_wake(), by which  time the waiting thread may have
>      >     advanced
>      >      > outside of qemu_event_wait().
>      >
>      >     Sorry if I'm making a mistake again, but the waiting thread won't
>      >     set to
>      >     EV_BUSY unless the value is EV_FREE on the second read so the
>     trigger
>      >     thread will not call qemu_futex_wake() if it manages to set
>     to EV_SET
>      >     before the second read, will it?
>      >
>      >
>      > This sequence of events will cause the problem:
>      >
>      > WAITER (in qemu_event_wait):
>      > value = qatomic_load_acquire(&ev->value);
>      > -> EV_FREE
>      >
>      > TRIGGER (in qemu_event_set):
>      > qatomic_read(&ev->value) != EV_SET
>      > -> EV_FREE (condition is false)
>      >
>      > WAITER:
>      > qatomic_cmpxchg(&ev->value, EV_FREE, EV_BUSY) == EV_SET
>      > -> cmpxchg returns EV_FREE, condition false.
>      > ev->value =  EV_BUSY.
>      > > TRIGGER:
>      >          int old = qatomic_xchg(&ev->value, EV_SET);
>      >          smp_mb__after_rmw();
>      >          if (old == EV_BUSY) {
>      > -> old = EV_BUSY, condition true.
>      > ev->value = EV_SET
>      >
>      > WAITER (in qemu_futex_wait(ev, EV_BUSY)):
>      >      pthread_mutex_lock(&ev->lock);
>      >      if (ev->value == val) {
>      > -> false, because value is EV_SET
>      >
>      > WAITER:
>      >      pthread_mutex_unlock(&ev->lock);
>      >      …
>      >      qemu_event_destroy(&job->done_event);
>      >
>      > TRIGGER (in qemu_futex_wake(ev, INT_MAX)):
>      >      pthread_mutex_lock(&ev->lock);
>      > -> hangs, because mutex has been destroyed
> 
>     Thanks for clarification. This is very insightful.
> 
> 
>      >
>      >      >
>      >      > This is all fine usually, BUT if you destroy the QemuEvent
>      >     immediately
>      >      > after the qemu_event_wait() call, qemu_futex_wake() may try to
>      >     lock a
>      >      > mutex that has been destroyed, or signal a condition variable
>      >     which has
>      >      > been destroyed. I don't see a reasonable way of making
>     this safe
>      >     other
>      >      > than using long-lived mutexes and condition variables. And
>      >     anyway, we
>      >      > have much, MUCH bigger contention/performance issues
>     coming from
>      >     almost
>      >      > everything being covered by the BQL. (If waking these
>     callbacks
>      >     can even
>      >      > be considered an issue: I haven't seen it show up in
>     profiling,
>      >     whereas
>      >      > BQL contention very much does.)
>      >      >
>      >      > I'll submit v5 of this patch set with separate condition
>      >     variables for
>      >      > each job type. This should make the occurrence of waking
>     the wrong
>      >      > thread quite rare, while reasoning about correctness is pretty
>      >      > straightforward. I think that's good enough.
> 
>     What about using QemuSemaphore then? It does not seem to have the
>     problem same with QemuEvent.
> 
> 
> Nowhere else in the code base uses short-lived semaphores, and while I 
> can't immediately see a risk (the mutex is held during both post and 
> wait) there might be some non-obvious problem with the approach. 
> Internally, the semaphores use condition variables. The solution using 
> condition variables directly already works, is safe, relatively easy to 
> reason about, and does not cause any performance issues. There is a tiny 
> inefficiency about waking up a thread unnecessarily in the rare case 
> when two callbacks of the same kind occur concurrently. In practice, 
> it's irrelevant. Thanks to the awkward mismatch of the 
> PVGraphics.framework's libdispatch based approach and Qemu's BQL/AIO/BH 
> approach, we are already sending messages to other threads very 
> frequently. This isn't ideal, but not fixable without drastically 
> reducing the need to acquire the BQL across Qemu.

I found several usage of ephemeral semaphores:
h_random() in hw/ppc/spapr_rng.c
colo_process_checkpoint() in migration/colo.c
postcopy_thread_create() in migration/postcopy-ram.c

I'm sure short-lived semaphores will keep working (or break migration in 
strange ways).

> 
> I do not think it is worth spending even more time trying to fix this 
> part of the code which isn't broken in the first place.

I'm sorry to bring you to this mess, which I didn't really expect. I 
thought combining a shared pair of conditional variable and mutex and 
job-specific bools is unnecessarily complex, and having one 
synchronization primitive for each job will be simpler and will just work.

However, there was a pitfall with QemuEvent as you demonstrated and now 
I grep QemuEvent and QemuSemaphore to find all such ephemeral usage is 
written with QemuSemaphore instead of QemuEvent. I think the critical 
problem here is that it is not documented that qemu_event_destroy() 
cannot be used immediately after qemu_event_wait(). We would not run 
into this situation if it is written. I will write a patch to add such a 
documentation comment.

