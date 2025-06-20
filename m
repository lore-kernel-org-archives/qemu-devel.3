Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F202C7115B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 16:54:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSezY-0004Jh-Bg; Fri, 20 Jun 2025 12:53:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uSezR-0004JU-EP
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 12:53:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uSezO-0001YY-OM
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 12:53:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750438397;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rSsk4jn+OBLz1Mo727gUcebERmYgU22qwW4AhJwD94I=;
 b=JmQU1o+05qmv6ZYgHhMBahOqmFNeb06XVQhJ772SOo1QBrm8+5i+a/JAPXCUHB1v4oEEoW
 Ou2LsW160AEUzkdEB8TyqnaL7mZUeDszl5UgKqEEaGWrvZxpyPT7yEphXCUB35eFdkmbFd
 zrDyCGlP1ScKsaH4iKAE/fYLSlnV2zE=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-197-UWEvIT0PNJ2CTgfe5HtSgQ-1; Fri, 20 Jun 2025 12:53:13 -0400
X-MC-Unique: UWEvIT0PNJ2CTgfe5HtSgQ-1
X-Mimecast-MFC-AGG-ID: UWEvIT0PNJ2CTgfe5HtSgQ_1750438393
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-235196dfc50so19980725ad.1
 for <qemu-devel@nongnu.org>; Fri, 20 Jun 2025 09:53:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750438392; x=1751043192;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rSsk4jn+OBLz1Mo727gUcebERmYgU22qwW4AhJwD94I=;
 b=abcAbWDD18+POlnmGPYWaxycO6uJKP+N+1r+jAHpR8uzM8kcUXHKgNahbf98N9hSzR
 1npYMkj8Upy7FpUDtO5ZPVcC0LoscV8gkA458dwpH/gBc/U3D4HKb4gdkCoUd1bWBBvt
 xrS4frl2z3SUY+4Thh53t9r6FBc01OYcPrGb+MsyAiBEpyBefhPTGUmqXWBLn4LnSeqv
 dMCpx6qK2nbxHInyQN9xf3+ntC8S+21azRi0UPcl7FjIBoLbLjf1fhJ80ttRZLug3VpL
 qrOiqyJOtxpzKFPXiSRqgPahBijz3niNzgqotu0ddJ3FcWkSvochGg+2HWa9EvKuhyN6
 PrlA==
X-Gm-Message-State: AOJu0YyGGnJ4EgajP+vZzah7kLB7XU55H05e3Xvox9b5uT/s+a49PUX2
 +Hekf/1G8Qdch1lSttKF9vR6+H6kZgWObWB3bGNR0mawU9G0hS/H1gxI80hdhfTmrcf6qX8ITdG
 aYbGjNotODZwxvO0woWWg47cLm9LcCTbncj3Q6dpgidRffj1GJetuMYkA
X-Gm-Gg: ASbGnctCSuSzXb/jIAeWsLeUJUzOjL7avI0Gz0+Q6VKtizGVOwA04jTp914d+ZjTkAn
 0FepNQIVBaKqyXoF3z7feOldfLblGrr0gLzvDv5e9hINpDebqWdfV14PDp1k7IVgYazLm/y8M0w
 G5TIatLgDm6eWn2pbcCbhMpuNplcHNKBQAqFAgzFa91HdoOMBsLfWyJoyEeNUcny9Kspg42J3IA
 yzJw8lZzRtD3P10HhgvyeWuE8VbUVeARMSjilDMA/HyMxAPUFBZUhLhgFdmri6qmavqlkztAAsx
 x6+QUsJkIkuwyQ==
X-Received: by 2002:a17:902:cecb:b0:235:efbb:9537 with SMTP id
 d9443c01a7336-237daf6597amr43855835ad.3.1750438392572; 
 Fri, 20 Jun 2025 09:53:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHzdSTXVVpI47zlkG/VLAn5qfp6RXI+p98jmvsr+uTr3UfYG2LRJxDy50aAuVRuobUcBaSxcA==
X-Received: by 2002:a17:902:cecb:b0:235:efbb:9537 with SMTP id
 d9443c01a7336-237daf6597amr43855455ad.3.1750438392133; 
 Fri, 20 Jun 2025 09:53:12 -0700 (PDT)
Received: from x1.local ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b31f119f124sm2069495a12.32.2025.06.20.09.53.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Jun 2025 09:53:11 -0700 (PDT)
Date: Fri, 20 Jun 2025 12:53:06 -0400
From: Peter Xu <peterx@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, kraxel@redhat.com, mst@redhat.com,
 anisinha@redhat.com, elena.ufimtseva@oracle.com,
 jag.raman@oracle.com, pbonzini@redhat.com, david@redhat.com,
 philmd@linaro.org
Subject: Re: [PATCH 1/3] memory: reintroduce BQL-free fine-grained PIO/MMIO
Message-ID: <aFWR8rM7-4y1R0GG@x1.local>
References: <20250620151418.1166195-1-imammedo@redhat.com>
 <20250620151418.1166195-2-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250620151418.1166195-2-imammedo@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.897,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Fri, Jun 20, 2025 at 05:14:16PM +0200, Igor Mammedov wrote:
> This patch brings back Jan's idea [1] of BQL-free IO access,
> with a twist that whitelist read access only.
> 
> (as BQL-free write access in [1] used to cause issues [2]
> and still does (Windows crash) if write path is not lock protected)

Can we add some explanation on why it would fail on lockless writes?

I saw that acpi_pm_tmr_write() is no-op, so I don't yet understand what
raced, and also why guest writes to it at all..

Thanks,

> 
> However with limiting it read path only, guest boots without issues.
> This will let us make read access ACPI PM/HPET timers cheaper,
> and prevent guest VCPUs BQL contention in case of workload
> that heavily uses the timers.
> 
> 2) 196ea13104f (memory: Add global-locking property to memory regions)
>    ... de7ea885c539 (kvm: Switch to unlocked MMIO)
> 3) https://bugzilla.redhat.com/show_bug.cgi?id=1322713
>    1beb99f787 (Revert "acpi: mark PMTIMER as unlocked")
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
>  include/system/memory.h   | 10 +++++++++-
>  hw/remote/vfio-user-obj.c |  2 +-
>  system/memory.c           |  5 +++++
>  system/memory_ldst.c.inc  | 18 +++++++++---------
>  system/physmem.c          |  9 +++++----
>  5 files changed, 29 insertions(+), 15 deletions(-)
> 
> diff --git a/include/system/memory.h b/include/system/memory.h
> index fc35a0dcad..1afabf2d94 100644
> --- a/include/system/memory.h
> +++ b/include/system/memory.h
> @@ -775,6 +775,7 @@ struct MemoryRegion {
>      bool nonvolatile;
>      bool rom_device;
>      bool flush_coalesced_mmio;
> +    bool lockless_ro_io;
>      bool unmergeable;
>      uint8_t dirty_log_mask;
>      bool is_iommu;
> @@ -2253,6 +2254,13 @@ void memory_region_set_flush_coalesced(MemoryRegion *mr);
>   */
>  void memory_region_clear_flush_coalesced(MemoryRegion *mr);
>  
> +/**
> + * memory_region_enable_lockless_ro_io: Enable lockless (BQL) read-only acceess.
> + *
> + * Enable BQL-free readonly access for devices with fine-grained locking.
> + */
> +void memory_region_enable_lockless_ro_io(MemoryRegion *mr);
> +
>  /**
>   * memory_region_add_eventfd: Request an eventfd to be triggered when a word
>   *                            is written to a location.
> @@ -3002,7 +3010,7 @@ MemTxResult address_space_write_cached_slow(MemoryRegionCache *cache,
>                                              hwaddr len);
>  
>  int memory_access_size(MemoryRegion *mr, unsigned l, hwaddr addr);
> -bool prepare_mmio_access(MemoryRegion *mr);
> +bool prepare_mmio_access(MemoryRegion *mr, bool read);
>  
>  static inline bool memory_region_supports_direct_access(MemoryRegion *mr)
>  {
> diff --git a/hw/remote/vfio-user-obj.c b/hw/remote/vfio-user-obj.c
> index ea6165ebdc..936a9befd4 100644
> --- a/hw/remote/vfio-user-obj.c
> +++ b/hw/remote/vfio-user-obj.c
> @@ -381,7 +381,7 @@ static int vfu_object_mr_rw(MemoryRegion *mr, uint8_t *buf, hwaddr offset,
>           * The read/write logic used below is similar to the ones in
>           * flatview_read/write_continue()
>           */
> -        release_lock = prepare_mmio_access(mr);
> +        release_lock = prepare_mmio_access(mr, !is_write);
>  
>          access_size = memory_access_size(mr, size, offset);
>  
> diff --git a/system/memory.c b/system/memory.c
> index 63b983efcd..5192195473 100644
> --- a/system/memory.c
> +++ b/system/memory.c
> @@ -2558,6 +2558,11 @@ void memory_region_clear_flush_coalesced(MemoryRegion *mr)
>      }
>  }
>  
> +void memory_region_enable_lockless_ro_io(MemoryRegion *mr)
> +{
> +    mr->lockless_ro_io = true;
> +}
> +
>  void memory_region_add_eventfd(MemoryRegion *mr,
>                                 hwaddr addr,
>                                 unsigned size,
> diff --git a/system/memory_ldst.c.inc b/system/memory_ldst.c.inc
> index 7f32d3d9ff..919357578c 100644
> --- a/system/memory_ldst.c.inc
> +++ b/system/memory_ldst.c.inc
> @@ -35,7 +35,7 @@ static inline uint32_t glue(address_space_ldl_internal, SUFFIX)(ARG1_DECL,
>      RCU_READ_LOCK();
>      mr = TRANSLATE(addr, &addr1, &l, false, attrs);
>      if (l < 4 || !memory_access_is_direct(mr, false, attrs)) {
> -        release_lock |= prepare_mmio_access(mr);
> +        release_lock |= prepare_mmio_access(mr, true);
>  
>          /* I/O case */
>          r = memory_region_dispatch_read(mr, addr1, &val,
> @@ -104,7 +104,7 @@ static inline uint64_t glue(address_space_ldq_internal, SUFFIX)(ARG1_DECL,
>      RCU_READ_LOCK();
>      mr = TRANSLATE(addr, &addr1, &l, false, attrs);
>      if (l < 8 || !memory_access_is_direct(mr, false, attrs)) {
> -        release_lock |= prepare_mmio_access(mr);
> +        release_lock |= prepare_mmio_access(mr, true);
>  
>          /* I/O case */
>          r = memory_region_dispatch_read(mr, addr1, &val,
> @@ -171,7 +171,7 @@ uint8_t glue(address_space_ldub, SUFFIX)(ARG1_DECL,
>      RCU_READ_LOCK();
>      mr = TRANSLATE(addr, &addr1, &l, false, attrs);
>      if (!memory_access_is_direct(mr, false, attrs)) {
> -        release_lock |= prepare_mmio_access(mr);
> +        release_lock |= prepare_mmio_access(mr, true);
>  
>          /* I/O case */
>          r = memory_region_dispatch_read(mr, addr1, &val, MO_8, attrs);
> @@ -208,7 +208,7 @@ static inline uint16_t glue(address_space_lduw_internal, SUFFIX)(ARG1_DECL,
>      RCU_READ_LOCK();
>      mr = TRANSLATE(addr, &addr1, &l, false, attrs);
>      if (l < 2 || !memory_access_is_direct(mr, false, attrs)) {
> -        release_lock |= prepare_mmio_access(mr);
> +        release_lock |= prepare_mmio_access(mr, true);
>  
>          /* I/O case */
>          r = memory_region_dispatch_read(mr, addr1, &val,
> @@ -278,7 +278,7 @@ void glue(address_space_stl_notdirty, SUFFIX)(ARG1_DECL,
>      RCU_READ_LOCK();
>      mr = TRANSLATE(addr, &addr1, &l, true, attrs);
>      if (l < 4 || !memory_access_is_direct(mr, true, attrs)) {
> -        release_lock |= prepare_mmio_access(mr);
> +        release_lock |= prepare_mmio_access(mr, false);
>  
>          r = memory_region_dispatch_write(mr, addr1, val, MO_32, attrs);
>      } else {
> @@ -315,7 +315,7 @@ static inline void glue(address_space_stl_internal, SUFFIX)(ARG1_DECL,
>      RCU_READ_LOCK();
>      mr = TRANSLATE(addr, &addr1, &l, true, attrs);
>      if (l < 4 || !memory_access_is_direct(mr, true, attrs)) {
> -        release_lock |= prepare_mmio_access(mr);
> +        release_lock |= prepare_mmio_access(mr, false);
>          r = memory_region_dispatch_write(mr, addr1, val,
>                                           MO_32 | devend_memop(endian), attrs);
>      } else {
> @@ -378,7 +378,7 @@ void glue(address_space_stb, SUFFIX)(ARG1_DECL,
>      RCU_READ_LOCK();
>      mr = TRANSLATE(addr, &addr1, &l, true, attrs);
>      if (!memory_access_is_direct(mr, true, attrs)) {
> -        release_lock |= prepare_mmio_access(mr);
> +        release_lock |= prepare_mmio_access(mr, false);
>          r = memory_region_dispatch_write(mr, addr1, val, MO_8, attrs);
>      } else {
>          /* RAM case */
> @@ -411,7 +411,7 @@ static inline void glue(address_space_stw_internal, SUFFIX)(ARG1_DECL,
>      RCU_READ_LOCK();
>      mr = TRANSLATE(addr, &addr1, &l, true, attrs);
>      if (l < 2 || !memory_access_is_direct(mr, true, attrs)) {
> -        release_lock |= prepare_mmio_access(mr);
> +        release_lock |= prepare_mmio_access(mr, false);
>          r = memory_region_dispatch_write(mr, addr1, val,
>                                           MO_16 | devend_memop(endian), attrs);
>      } else {
> @@ -475,7 +475,7 @@ static void glue(address_space_stq_internal, SUFFIX)(ARG1_DECL,
>      RCU_READ_LOCK();
>      mr = TRANSLATE(addr, &addr1, &l, true, attrs);
>      if (l < 8 || !memory_access_is_direct(mr, true, attrs)) {
> -        release_lock |= prepare_mmio_access(mr);
> +        release_lock |= prepare_mmio_access(mr, false);
>          r = memory_region_dispatch_write(mr, addr1, val,
>                                           MO_64 | devend_memop(endian), attrs);
>      } else {
> diff --git a/system/physmem.c b/system/physmem.c
> index a8a9ca309e..60e330de99 100644
> --- a/system/physmem.c
> +++ b/system/physmem.c
> @@ -2881,11 +2881,12 @@ int memory_access_size(MemoryRegion *mr, unsigned l, hwaddr addr)
>      return l;
>  }
>  
> -bool prepare_mmio_access(MemoryRegion *mr)
> +bool prepare_mmio_access(MemoryRegion *mr, bool read)
>  {
>      bool release_lock = false;
>  
> -    if (!bql_locked()) {
> +    if (!bql_locked() &&
> +        !(read && mr->lockless_ro_io == true)) {
>          bql_lock();
>          release_lock = true;
>      }
> @@ -2935,7 +2936,7 @@ static MemTxResult flatview_write_continue_step(MemTxAttrs attrs,
>      if (!memory_access_is_direct(mr, true, attrs)) {
>          uint64_t val;
>          MemTxResult result;
> -        bool release_lock = prepare_mmio_access(mr);
> +        bool release_lock = prepare_mmio_access(mr, false);
>  
>          *l = memory_access_size(mr, *l, mr_addr);
>          /*
> @@ -3032,7 +3033,7 @@ static MemTxResult flatview_read_continue_step(MemTxAttrs attrs, uint8_t *buf,
>          /* I/O case */
>          uint64_t val;
>          MemTxResult result;
> -        bool release_lock = prepare_mmio_access(mr);
> +        bool release_lock = prepare_mmio_access(mr, true);
>  
>          *l = memory_access_size(mr, *l, mr_addr);
>          result = memory_region_dispatch_read(mr, mr_addr, &val, size_memop(*l),
> -- 
> 2.43.5
> 

-- 
Peter Xu


