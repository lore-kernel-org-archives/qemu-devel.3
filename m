Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8570CD5BCB
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2024 15:34:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smEU4-0004Fl-9a; Thu, 05 Sep 2024 11:33:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1smEU2-0004EZ-NK
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 11:33:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1smEU0-0007Aa-Oj
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 11:33:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725550395;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DisE3Yoi97HgCQXoNv/wqUnc8ztLJ41+YcssRtQiiHI=;
 b=c8bXx+PECbmByIkTzv/x+kShDiT6MgfP+5HlKhHJ2owRXdZ35hIGZZBR3MLF/ypZWAJdaz
 tROUzPoxHwp3pcpRUyi6/8Z9b9JrxBTpNulgkXvW9i6scRj4EF6yQsk0rlI4O1CAtXDxcl
 K8/VSSJ6vdl27HeaPb7YU7DZ384ZQt0=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-325-VZgL_e5PN5m-N0Rtgd6WQQ-1; Thu, 05 Sep 2024 11:33:08 -0400
X-MC-Unique: VZgL_e5PN5m-N0Rtgd6WQQ-1
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-457de9445f2so16355541cf.0
 for <qemu-devel@nongnu.org>; Thu, 05 Sep 2024 08:32:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725550378; x=1726155178;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DisE3Yoi97HgCQXoNv/wqUnc8ztLJ41+YcssRtQiiHI=;
 b=vVmEI6AzXU5uPJfveH49V8Zc7tskIEv97OW6LcreMeMTConuJrYpDUJhtQpYCedUhT
 mKfhyFhrJmMq+j0vD83//3GgOnPOKKV7IRSF/Vj9eLXuqsS3l6YcmyhZW2dtV9o2hJS5
 LgSolTL2URIicj7vLIYhZ1zRVe0EMjdI1q1qMF49vMqxgUcd+1dTq02UuJBMLQHtXn11
 l5qpNg78OD2JrjUActK9nRu+9zkRZcpWvLlKhXKQDTxbLcb9MjCV4+szmPNpl1Wwahhb
 xrRHKF9yRX+P0ON9Sh7qORYgSlyU/jKybevqEdnrZ/435yQ3moH9xdjrDT+REMcGSsnp
 cdRQ==
X-Gm-Message-State: AOJu0YxiyPbEwjsprxe60didp9XnZIEy8nGKeaeoXc2ABR48q1M/TuCe
 /SqA9luylLeI0bRy08FuR03ByNw7iNYpb8DDK9j16Udk9bcYhTVOw0HRjg0UaMUoCpMkt86qcff
 rOwvCzIfTHTYJeMeatcYt0nrwXsuL3TDreoJZpJGhrM+YShBvHs1gsgnBVBpnapnBQt+nrKZCgt
 +pQUlQpCwRVctbvVchuR0pFd5K1sQ=
X-Received: by 2002:a05:622a:4108:b0:454:e7e5:79df with SMTP id
 d75a77b69052e-4567f4f55a0mr259476111cf.9.1725550378061; 
 Thu, 05 Sep 2024 08:32:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHkEs5RydWWRJpRhbjT22/qJxzoMKV5TG6ebtJiX8zRcwv3Vy4iK9xSQamEJXDNvX5tAJ1Kuvl9Zp2EuDqv0JU=
X-Received: by 2002:a05:622a:4108:b0:454:e7e5:79df with SMTP id
 d75a77b69052e-4567f4f55a0mr259475541cf.9.1725550377396; Thu, 05 Sep 2024
 08:32:57 -0700 (PDT)
MIME-Version: 1.0
References: <20240904223510.3519358-1-peterx@redhat.com>
 <20240904223510.3519358-2-peterx@redhat.com>
In-Reply-To: <20240904223510.3519358-2-peterx@redhat.com>
From: Juraj Marcin <jmarcin@redhat.com>
Date: Thu, 5 Sep 2024 17:32:46 +0200
Message-ID: <CAC2qdxCW=ddmK1TLC4Agh4cGnMV60BKNpN_Nrrz-KuPbDfh-ew@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] KVM: Dynamic sized kvm memslots array
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Vitaly Kuznetsov <vkuznets@redhat.com>, 
 Prasad Pandit <ppandit@redhat.com>, Julia Suvorova <jusual@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, 
 Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>, 
 qemu-stable <qemu-stable@nongnu.org>, Zhiyi Guo <zhguo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jmarcin@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Thu, Sep 5, 2024 at 12:35=E2=80=AFAM Peter Xu <peterx@redhat.com> wrote:
>
> Zhiyi reported an infinite loop issue in VFIO use case.  The cause of tha=
t
> was a separate discussion, however during that I found a regression of
> dirty sync slowness when profiling.
>
> Each KVMMemoryListerner maintains an array of kvm memslots.  Currently it=
's
> statically allocated to be the max supported by the kernel.  However afte=
r
> Linux commit 4fc096a99e ("KVM: Raise the maximum number of user memslots"=
),
> the max supported memslots reported now grows to some number large enough
> so that it may not be wise to always statically allocate with the max
> reported.
>
> What's worse, QEMU kvm code still walks all the allocated memslots entrie=
s
> to do any form of lookups.  It can drastically slow down all memslot
> operations because each of such loop can run over 32K times on the new
> kernels.
>
> Fix this issue by making the memslots to be allocated dynamically.
>
> Here the initial size was set to 16 because it should cover the basic VM
> usages, so that the hope is the majority VM use case may not even need to
> grow at all (e.g. if one starts a VM with ./qemu-system-x86_64 by default
> it'll consume 9 memslots), however not too large to waste memory.
>
> There can also be even better way to address this, but so far this is the
> simplest and should be already better even than before we grow the max
> supported memslots.  For example, in the case of above issue when VFIO wa=
s
> attached on a 32GB system, there are only ~10 memslots used.  So it could
> be good enough as of now.
>
> In the above VFIO context, measurement shows that the precopy dirty sync
> shrinked from ~86ms to ~3ms after this patch applied.  It should also app=
ly
> to any KVM enabled VM even without VFIO.
>
> NOTE: we don't have a FIXES tag for this patch because there's no real
> commit that regressed this in QEMU. Such behavior existed for a long time=
,
> but only start to be a problem when the kernel reports very large
> nr_slots_max value.  However that's pretty common now (the kernel change
> was merged in 2021) so we attached cc:stable because we'll want this chan=
ge
> to be backported to stable branches.
>
> Cc: qemu-stable <qemu-stable@nongnu.org>
> Reported-by: Zhiyi Guo <zhguo@redhat.com>
> Tested-by: Zhiyi Guo <zhguo@redhat.com>
> Acked-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  include/sysemu/kvm_int.h |  1 +
>  accel/kvm/kvm-all.c      | 93 +++++++++++++++++++++++++++++++++-------
>  accel/kvm/trace-events   |  1 +
>  3 files changed, 80 insertions(+), 15 deletions(-)
>
> diff --git a/include/sysemu/kvm_int.h b/include/sysemu/kvm_int.h
> index 1d8fb1473b..48e496b3d4 100644
> --- a/include/sysemu/kvm_int.h
> +++ b/include/sysemu/kvm_int.h
> @@ -46,6 +46,7 @@ typedef struct KVMMemoryListener {
>      MemoryListener listener;
>      KVMSlot *slots;
>      unsigned int nr_used_slots;
> +    unsigned int nr_slots_allocated;
>      int as_id;
>      QSIMPLEQ_HEAD(, KVMMemoryUpdate) transaction_add;
>      QSIMPLEQ_HEAD(, KVMMemoryUpdate) transaction_del;
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index 75d11a07b2..f9368494a8 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -69,6 +69,9 @@
>  #define KVM_GUESTDBG_BLOCKIRQ 0
>  #endif
>
> +/* Default num of memslots to be allocated when VM starts */
> +#define  KVM_MEMSLOTS_NR_ALLOC_DEFAULT                      16
> +
>  struct KVMParkedVcpu {
>      unsigned long vcpu_id;
>      int kvm_fd;
> @@ -165,6 +168,57 @@ void kvm_resample_fd_notify(int gsi)
>      }
>  }
>
> +/**
> + * kvm_slots_grow(): Grow the slots[] array in the KVMMemoryListener
> + *
> + * @kml: The KVMMemoryListener* to grow the slots[] array
> + * @nr_slots_new: The new size of slots[] array
> + *
> + * Returns: True if the array grows larger, false otherwise.
> + */
> +static bool kvm_slots_grow(KVMMemoryListener *kml, unsigned int nr_slots=
_new)
> +{
> +    unsigned int i, cur =3D kml->nr_slots_allocated;
> +    KVMSlot *slots;
> +
> +    if (nr_slots_new > kvm_state->nr_slots) {
> +        nr_slots_new =3D kvm_state->nr_slots;
> +    }
> +
> +    if (cur >=3D nr_slots_new) {
> +        /* Big enough, no need to grow, or we reached max */
> +        return false;
> +    }
> +
> +    if (cur =3D=3D 0) {
> +        slots =3D g_new0(KVMSlot, nr_slots_new);
> +    } else {
> +        assert(kml->slots);
> +        slots =3D g_renew(KVMSlot, kml->slots, nr_slots_new);
> +        /*
> +         * g_renew() doesn't initialize extended buffers, however kvm
> +         * memslots require fields to be zero-initialized. E.g. pointers=
,
> +         * memory_size field, etc.
> +         */
> +        memset(&slots[cur], 0x0, sizeof(slots[0]) * (nr_slots_new - cur)=
);
> +    }
> +
> +    for (i =3D cur; i < nr_slots_new; i++) {
> +        slots[i].slot =3D i;
> +    }
> +
> +    kml->slots =3D slots;
> +    kml->nr_slots_allocated =3D nr_slots_new;
> +    trace_kvm_slots_grow(cur, nr_slots_new);
> +
> +    return true;
> +}
> +
> +static bool kvm_slots_double(KVMMemoryListener *kml)
> +{
> +    return kvm_slots_grow(kml, kml->nr_slots_allocated * 2);
> +}
> +
>  unsigned int kvm_get_max_memslots(void)
>  {
>      KVMState *s =3D KVM_STATE(current_accel());
> @@ -193,15 +247,20 @@ unsigned int kvm_get_free_memslots(void)
>  /* Called with KVMMemoryListener.slots_lock held */
>  static KVMSlot *kvm_get_free_slot(KVMMemoryListener *kml)
>  {
> -    KVMState *s =3D kvm_state;
>      int i;
>
> -    for (i =3D 0; i < s->nr_slots; i++) {
> +retry:
> +    for (i =3D 0; i < kml->nr_slots_allocated; i++) {
>          if (kml->slots[i].memory_size =3D=3D 0) {
>              return &kml->slots[i];
>          }
>      }
>
> +    /* If no free slots, try to grow first by doubling */
> +    if (kvm_slots_double(kml)) {
> +        goto retry;

At this point we know all previously allocated slots were used and
there should be a free slot just after the last used slot (at the
start of the region zeroed in the grow function). Wouldn't it be
faster to return it here right away, instead of iterating through
slots that should still be used again?

> +    }
> +
>      return NULL;
>  }
>
> @@ -222,10 +281,9 @@ static KVMSlot *kvm_lookup_matching_slot(KVMMemoryLi=
stener *kml,
>                                           hwaddr start_addr,
>                                           hwaddr size)
>  {
> -    KVMState *s =3D kvm_state;
>      int i;
>
> -    for (i =3D 0; i < s->nr_slots; i++) {
> +    for (i =3D 0; i < kml->nr_slots_allocated; i++) {
>          KVMSlot *mem =3D &kml->slots[i];
>
>          if (start_addr =3D=3D mem->start_addr && size =3D=3D mem->memory=
_size) {
> @@ -267,7 +325,7 @@ int kvm_physical_memory_addr_from_host(KVMState *s, v=
oid *ram,
>      int i, ret =3D 0;
>
>      kvm_slots_lock();
> -    for (i =3D 0; i < s->nr_slots; i++) {
> +    for (i =3D 0; i < kml->nr_slots_allocated; i++) {
>          KVMSlot *mem =3D &kml->slots[i];
>
>          if (ram >=3D mem->ram && ram < mem->ram + mem->memory_size) {
> @@ -1071,7 +1129,7 @@ static int kvm_physical_log_clear(KVMMemoryListener=
 *kml,
>
>      kvm_slots_lock();
>
> -    for (i =3D 0; i < s->nr_slots; i++) {
> +    for (i =3D 0; i < kml->nr_slots_allocated; i++) {
>          mem =3D &kml->slots[i];
>          /* Discard slots that are empty or do not overlap the section */
>          if (!mem->memory_size ||
> @@ -1719,12 +1777,8 @@ static void kvm_log_sync_global(MemoryListener *l,=
 bool last_stage)
>      /* Flush all kernel dirty addresses into KVMSlot dirty bitmap */
>      kvm_dirty_ring_flush();
>
> -    /*
> -     * TODO: make this faster when nr_slots is big while there are
> -     * only a few used slots (small VMs).
> -     */
>      kvm_slots_lock();
> -    for (i =3D 0; i < s->nr_slots; i++) {
> +    for (i =3D 0; i < kml->nr_slots_allocated; i++) {
>          mem =3D &kml->slots[i];
>          if (mem->memory_size && mem->flags & KVM_MEM_LOG_DIRTY_PAGES) {
>              kvm_slot_sync_dirty_pages(mem);
> @@ -1839,12 +1893,9 @@ void kvm_memory_listener_register(KVMState *s, KVM=
MemoryListener *kml,
>  {
>      int i;
>
> -    kml->slots =3D g_new0(KVMSlot, s->nr_slots);
>      kml->as_id =3D as_id;
>
> -    for (i =3D 0; i < s->nr_slots; i++) {
> -        kml->slots[i].slot =3D i;
> -    }
> +    kvm_slots_grow(kml, KVM_MEMSLOTS_NR_ALLOC_DEFAULT);
>
>      QSIMPLEQ_INIT(&kml->transaction_add);
>      QSIMPLEQ_INIT(&kml->transaction_del);
> @@ -2461,6 +2512,18 @@ static int kvm_init(MachineState *ms)
>          s->nr_slots =3D 32;
>      }
>
> +    /*
> +     * A VM will at least require a few memslots to work, or it can even
> +     * fail to boot.  Make sure the supported value is always at least
> +     * larger than what we will initially allocate.
> +     */
> +    if (s->nr_slots < KVM_MEMSLOTS_NR_ALLOC_DEFAULT) {
> +        ret =3D -EINVAL;
> +        fprintf(stderr, "KVM max supported number of slots (%d) too smal=
l\n",
> +                s->nr_slots);
> +        goto err;
> +    }
> +
>      s->nr_as =3D kvm_check_extension(s, KVM_CAP_MULTI_ADDRESS_SPACE);
>      if (s->nr_as <=3D 1) {
>          s->nr_as =3D 1;
> diff --git a/accel/kvm/trace-events b/accel/kvm/trace-events
> index 37626c1ac5..ad2ae6fca5 100644
> --- a/accel/kvm/trace-events
> +++ b/accel/kvm/trace-events
> @@ -36,3 +36,4 @@ kvm_io_window_exit(void) ""
>  kvm_run_exit_system_event(int cpu_index, uint32_t event_type) "cpu_index=
 %d, system_even_type %"PRIu32
>  kvm_convert_memory(uint64_t start, uint64_t size, const char *msg) "star=
t 0x%" PRIx64 " size 0x%" PRIx64 " %s"
>  kvm_memory_fault(uint64_t start, uint64_t size, uint64_t flags) "start 0=
x%" PRIx64 " size 0x%" PRIx64 " flags 0x%" PRIx64
> +kvm_slots_grow(unsigned int old, unsigned int new) "%u -> %u"
> --
> 2.45.0
>

--=20

Juraj Marcin


