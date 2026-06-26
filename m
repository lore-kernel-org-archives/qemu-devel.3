Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A473CC43211
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 14:48:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wd7qO-0000mC-F6; Fri, 26 Jun 2026 10:47:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aadeshveer07@gmail.com>)
 id 1wd7qN-0000m4-Aw
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 10:47:47 -0400
Received: from mail-oi1-x234.google.com ([2607:f8b0:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aadeshveer07@gmail.com>)
 id 1wd7qL-0003kM-4n
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 10:47:47 -0400
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-489f0c807c5so663082b6e.0
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 07:47:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782485263; cv=none;
 d=google.com; s=arc-20260327;
 b=YGLCQ5pC09EBNC/Cmme6Rjpaj7UTUnGbFk/s0GDogL7wjezohFbSao5PTkUA/gAFx9
 DUoheNDYHbSDCaTz2qPJJqPHQfeuX145jCPkEBK92W0kBlLbm3XovyauSNeCLH62kp7A
 UvrfElqSHnV+/9cxT5W+J3KtNCw54kS3rN3Gfz8rEiFBASe1nEQv0jGGYONQmZDz+cEg
 DuwhdGYi4M5Qqhnf9Ms2WmoPJj0HYE4aH1VXAEV1tLOiZ3P9EGBzSxVAPoFolMzox7fO
 /9KJzp03U9FIlG8rU7B5YQfWSZYZvzaQuS849mJ2TPOVoNEcVxOnAwNauNO7xiyurCCf
 eM7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=9MIyBOpDz5o2haaFjxr3B6CeYcxoT3LBpxyNO1XP8SI=;
 fh=M53F9OyMyXaprNYz5ycy0QOslAkZgr8cpZk3PVQ0YK0=;
 b=EOpR2xl423PkA3vUgLNm/bcln8gx4IEdXaa3VBfFVx4RTq1y90bMw5XJZ9VeMUHM/Z
 EBgHZswo8sSHTy4mw0veQTqizo6c9HCZwR9/F9Kj/r7Gkkbk9cw6xnwAltEZ7hss3jlG
 j2fS0JBwjRy1BST5zWhA7GGu1/g0RZeGJienmxWxVsk8TFMlw2jSiuDMTFVCjMo5lCOW
 m1YlUzpk1qjsQzdGV9wSGx+7sMRlr/qkO6BZu6rW4pHlnelrgM5zLqKMvCwyUIq3z0l1
 0hq2pNClmdpKeqoSftcPv19Z/xa6P6FzorwXo8zTW7XC1wECkUj0kPI5WRvIOLam9mMc
 vT4g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782485263; x=1783090063; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9MIyBOpDz5o2haaFjxr3B6CeYcxoT3LBpxyNO1XP8SI=;
 b=hn7HTOz8EHGBkLbZqggKFoFBnpiyFMsDjuPq2hQRwmWsJOz+YpB9JCoXzX/PAQj3h6
 9BBnLOj5RPNGigoznyh7txvstQpt3LC9wHemR2LllXvTEFuLIlvrrM0eFD0BpIkZq/uN
 jhTavS5qA6Luk90K92yQ9Pu9+Qlsf8WS9ag0KIt24Yfo1sGJGM+tCBGWkAw3mNX86Red
 A0hmdTa66XVmvhqOPYv5ENBcg9HKdpJxQuIOZbeSslzPaeQK5M6xFTfMlMq0/WiRMiXv
 pHINWyQY8ho5dTwvdcOrsPSxpGDNd0eROtuNm042PZb7kOwXZCYZfyiPzI1c6bvKC7WC
 56Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782485263; x=1783090063;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9MIyBOpDz5o2haaFjxr3B6CeYcxoT3LBpxyNO1XP8SI=;
 b=VuIkaoJqvIbeQgwzxFC+ScKpBQLsnyTcsDZzOD6luhpsVo2/npw5UIAjx/HNgI6bBY
 KMRnjT3bZMLRNj8ZvBVP0gAyLwNNNHGNN8OjcX4HesBJGNyRU41pcM3dTC5vCDc3O+1T
 UCi/mSy99cuYw+IpGgZ+iwXqH7eku1J9lkg5jkUdGkB4KHMCV5BxwypEcjTlY/cC3VsM
 R2jM7GbdwpUUOAGWbyMm2HVeTavkuIONT/fiBqNSr2+yotUZGWPupMNh/vWAyPl53e6/
 VcqaLNuxfktZM1zg3KS5s4qTQmr7iiB7+RsDBOkRiLpFVY2XIIxdirIi07HnR/veo8ZN
 PRTw==
X-Gm-Message-State: AOJu0YwIdTp8xXtpizMtvVPElPIobfd/wQHH1urBjfIjZJwSBJadTgj2
 m9xzXuWYPWk9B3S7P26ahSRlKy3bxx98tPwsXNxrAKFloqQ4dVDG4+YronK1XkGiAzu0aLfGFdA
 NmaabZFfKD4+gEdoJN6NaPZM17BeZa4I=
X-Gm-Gg: AfdE7cnXKhrTy8FyW0YDeh+wYJw8aqF9S1YfEpPGcpLYqrgHeRGREQk8Y1AgNS/xt4o
 Cbc+3Nlq2SUd13arpWof1mmpB9KKkheZ4vNMf4oSAGfOEivhfKtcwTJaPVrrvJEhov+/PhPqiCQ
 dsIrWMtqzhqMcEWNczSxo8IUduMv/EM3FufMXn7GPtv1e66srgV5SHsikOI9MqR6T25Lx7Uy3Qo
 FFFegSuRr+mD0jelGaI+1pnP8Gixv7r/QpX4EtO1tOY/r9xrBNXBl8hYh75cKxIbgXA5AyxyWkx
 pprzBb2GpUVCUU9QD+1Biju3RCaVfVC8CTULtQ==
X-Received: by 2002:a05:6808:19a0:b0:485:7c46:b866 with SMTP id
 5614622812f47-48ee4591b84mr13488303b6e.16.1782485263390; Fri, 26 Jun 2026
 07:47:43 -0700 (PDT)
MIME-Version: 1.0
References: <20260618032010.88755-1-aadeshveer07@gmail.com>
 <20260618032010.88755-4-aadeshveer07@gmail.com> <871pdwouvl.fsf@suse.de>
In-Reply-To: <871pdwouvl.fsf@suse.de>
From: Aadeshveer Singh <aadeshveer07@gmail.com>
Date: Fri, 26 Jun 2026 20:17:32 +0530
X-Gm-Features: AVVi8Ce-XaYbFLnlGgkLXbU5F_oN0iM-BcwpGQIHXroUkPe7k_k6atkMvq_Y_K0
Message-ID: <CA++cPvJpRH9RSTsVV0OP=i1oY23CrYN01HNBj8ms7Bhit=3ewQ@mail.gmail.com>
Subject: Re: [RFC PATCH 3/5] migration: add eager load thread for fast
 snapshot load
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, pbonzini@redhat.com, 
 philmd@mailo.com, lvivier@redhat.com, ayoub@saferwall.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::234;
 envelope-from=aadeshveer07@gmail.com; helo=mail-oi1-x234.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Jun 24, 2026 at 8:20=E2=80=AFPM Fabiano Rosas <farosas@suse.de> wro=
te:
>
> Aadeshveer Singh <aadeshveer07@gmail.com> writes:
>
> > In fast snapshot load a thread is needed for actively loading in pages
> > along with the fault path so that the guest is not dependent on fault
> > thread indefinitely.
> >
>
> In the paragraph above, "dependent on fault thread indefinitely" is a
> bit vague: it's not clear why that condition might be undesirable or why
> it's indefinte.
>
> How is that different from normal postcopy? Is the point that postcopy
> will have transferred most of the memory in precopy so the fault thread
> has way less pages to deal with whereas here is the opposite, just a few
> pages have been potentially loaded with a large chunk still waiting to
> be faulted in?
>
> Is this new eager thread something that could be used even for normal
> postcopy? Kind of sounds like a separate sub-feature. Does the fast
> snapshot work at all without this?
>

Yes, the difference is the starting state of the RAM. In normal
network postcopy, the precopy phase has already transferred the vast
majority of the memory. The fault thread only has to fetch a small,
finite number of remaining active pages.

In this snapshot load, we skip precopy entirely. The VM starts with 0%
of its RAM loaded.

If we relied only on the fault thread, a page would load only if the
guest OS explicitly accessed it. The hypervisor should not make any
assumptions about the guest; this is what introduces the
indefiniteness of load time.
If the guest OS never touches background pages, those pages will never
load from disk. This would cause the migration state to hang
indefinitely in POSTCOPY_ACTIVE, waiting for pages that might never be
requested.

As you noted in Patch 0, this indefinite POSTCOPY_ACTIVE state would
permanently block the user from ever issuing a subsequent savevm or
migration command. The eager thread guarantees a deterministic end to
the migration state machine.

> > Add postcopy_ram_eager_load_thread(), for the eager thread which
> > iterates over all non ignored blocks calling ram_block_load_eager()
> > each. ram_block_load_eager then iterates to load in all pages using
> > postcopy_mapped_ram_load_page(), with a different channel, which takes
> > care of not loading in pages already loaded by fault thread. On
> > completion the thread schedules postcopy_ram_eager_load_bh() to destroy
> > the incoming migration state and set states to completed/end.
> >
>
> Ok, so that answers my question from the cover letter, we're holding the
> migration until all pages have been loaded. So it's yet another reason
> to have the eager thread. Still, the fast snapshot load can be fast
> while having a slow migration overall I suppose.
>
> To be clear, I'm not arguing against the design, only trying to frame
> the dependencies.
>

Yes, your summary is correct.

The "fast" in this feature refers strictly to the VM downtime (the
time it takes for the guest to resume execution). The overall
migration time is still fundamentally bound by the disk I/O required
to load the entire RAM, so the total migration duration is essentially
the same as a standard load or even slower than the current snapshot
load.

Holding the migration state open until the eager thread finishes
ensures we have a deterministic endpoint, keeping the VM safe from
conflicting operations (like a second savevm) while its memory is
still being populated in the background.

> > Add postcopy_ram_eager_load_setup() to create the thread. Added joining
> > logic in postcopy_incoming_cleanup().
> >
> > Add tracepoints for entry and exit to eager load thread.
> >
> > Signed-off-by: Aadeshveer Singh <aadeshveer07@gmail.com>
> > ---
> >  migration/migration.h    |  5 +++
> >  migration/postcopy-ram.c | 75 ++++++++++++++++++++++++++++++++++++++++
> >  migration/postcopy-ram.h |  2 ++
> >  migration/trace-events   |  2 ++
> >  4 files changed, 84 insertions(+)
> >
> > diff --git a/migration/migration.h b/migration/migration.h
> > index 841f49b215..7bb54a6584 100644
> > --- a/migration/migration.h
> > +++ b/migration/migration.h
> > @@ -42,6 +42,7 @@
> >  #define  MIGRATION_THREAD_DST_FAULT         "mig/dst/fault"
> >  #define  MIGRATION_THREAD_DST_LISTEN        "mig/dst/listen"
> >  #define  MIGRATION_THREAD_DST_PREEMPT       "mig/dst/preempt"
> > +#define  MIGRATION_THREAD_DST_EAGER         "mig/dst/eager"
> >
> >  struct PostcopyBlocktimeContext;
> >  typedef struct ThreadPool ThreadPool;
> > @@ -120,6 +121,10 @@ struct MigrationIncomingState {
> >      bool           have_listen_thread;
> >      QemuThread     listen_thread;
> >
> > +    /* Thread to load pages eagerly in fast snapshot load case */
> > +    bool have_eager_load_thread;
> > +    QemuThread eager_load_thread;
> > +
> >      /* For the kernel to send us notifications */
> >      int       userfault_fd;
> >      /* To notify the fault_thread to wake, e.g., when need to quit */
> > diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
> > index 1ec20a07dd..0ee294a381 100644
> > --- a/migration/postcopy-ram.c
> > +++ b/migration/postcopy-ram.c
> > @@ -2289,9 +2289,84 @@ int postcopy_incoming_cleanup(MigrationIncomingS=
tate *mis)
> >          mis->have_listen_thread =3D false;
> >      }
> >
> > +    if (mis->have_eager_load_thread) {
> > +        qemu_thread_join(&mis->eager_load_thread);
> > +        mis->have_eager_load_thread =3D false;
> > +    }
> > +
> >      if (migrate_postcopy_ram()) {
> >          rc =3D postcopy_ram_incoming_cleanup(mis);
> >      }
> >
> >      return rc;
> >  }
> > +
> > +/*
> > + * Called by postcopy_ram_eager_load_thread over all blocks to load in=
 all the
> > + * pending pages of given ram block
> > + */
> > +static int ram_block_load_eager(RAMBlock *rb, void *opaque)
> > +{
> > +    MigrationIncomingState *mis =3D opaque;
> > +    void *host =3D qemu_ram_get_host_addr(rb);
> > +    void *target;
> > +    int ret =3D 0;
> > +
> > +    for (ram_addr_t page_loc =3D 0; page_loc < rb->used_length;
> > +         page_loc +=3D TARGET_PAGE_SIZE) {
> > +        target =3D (uint8_t *)host + page_loc;
> > +        ret =3D postcopy_mapped_ram_load_page(mis, rb, page_loc, (uint=
64_t)target,
> > +                                            0);
> > +        if (ret) {
> > +            break;
> > +        }
> > +    }
> > +    return ret;
> > +}
> > +
> > +/*
> > + * Bottom half for fast snapshot load, scheduled by eager load thread
> > + */
> > +static void postcopy_ram_eager_load_bh(void *opaque)
> > +{
> > +    MigrationIncomingState *mis =3D opaque;
> > +    postcopy_state_set(POSTCOPY_INCOMING_END);
> > +    migrate_set_state(&mis->state, MIGRATION_STATUS_POSTCOPY_ACTIVE,
> > +                      MIGRATION_STATUS_COMPLETED);
> > +    migration_incoming_state_destroy();
> > +}
> > +
> > +/*
> > + * Used by fast snapshot load to eagerly load in all pages of RAM and =
schedule
> > + * cleanup after entire RAM is loaded
> > + */
> > +static void *postcopy_ram_eager_load_thread(void *opaque)
> > +{
> > +    MigrationIncomingState *mis =3D opaque;
> > +
> > +    trace_postcopy_ram_eager_load_thread_entry();
> > +    rcu_register_thread();
> > +    qemu_event_set(&mis->thread_sync_event);
> > +
> > +    if (foreach_not_ignored_block(ram_block_load_eager, mis)) {
> > +        error_report("ram_block_load_eager failed");
> > +    }
> > +
> > +    migration_bh_schedule(postcopy_ram_eager_load_bh, mis);
> > +
> > +    rcu_unregister_thread();
> > +    trace_postcopy_ram_eager_load_thread_exit();
> > +    return NULL;
> > +}
> > +
> > +/*
> > + * Create thread for eager loading in fast snapshot load case
> > + */
> > +int postcopy_ram_eager_load_setup(MigrationIncomingState *mis)
> > +{
> > +    postcopy_thread_create(
> > +        mis, &mis->eager_load_thread, MIGRATION_THREAD_DST_EAGER,
> > +        postcopy_ram_eager_load_thread, QEMU_THREAD_JOINABLE);
> > +    mis->have_eager_load_thread =3D true;
> > +    return 0;
> > +}
> > diff --git a/migration/postcopy-ram.h b/migration/postcopy-ram.h
> > index a080dd65a7..b3ba42e447 100644
> > --- a/migration/postcopy-ram.h
> > +++ b/migration/postcopy-ram.h
> > @@ -202,4 +202,6 @@ void mark_postcopy_blocktime_begin(uintptr_t addr, =
uint32_t ptid,
> >  int postcopy_incoming_setup(MigrationIncomingState *mis, Error **errp)=
;
> >  int postcopy_incoming_cleanup(MigrationIncomingState *mis);
> >
> > +int postcopy_ram_eager_load_setup(MigrationIncomingState *mis);
> > +
> >  #endif
> > diff --git a/migration/trace-events b/migration/trace-events
> > index de99d976ab..38f11e1e9f 100644
> > --- a/migration/trace-events
> > +++ b/migration/trace-events
> > @@ -314,6 +314,8 @@ postcopy_blocktime_tid_cpu_map(int cpu, uint32_t ti=
d) "cpu: %d, tid: %u"
> >  postcopy_blocktime_begin(uint64_t addr, uint64_t time, int cpu, bool e=
xists) "addr: 0x%" PRIx64 ", time: %" PRIu64 ", cpu: %d, exist: %d"
> >  postcopy_blocktime_end(uint64_t addr, uint64_t time, int affected_cpu,=
 int affected_non_cpus) "addr: 0x%" PRIx64 ", time: %" PRIu64 ", affected_c=
pus: %d, affected_non_cpus: %d"
> >  postcopy_blocktime_end_one(int cpu, uint8_t left_faults) "cpu: %d, lef=
t_faults: %" PRIu8
> > +postcopy_ram_eager_load_thread_entry(void) ""
> > +postcopy_ram_eager_load_thread_exit(void) ""
> >
> >  # exec.c
> >  migration_exec_outgoing(const char *cmd) "cmd=3D%s"

