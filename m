Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FE6AC87FC9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 22:15:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhF50-0001De-GS; Wed, 30 Jul 2025 18:15:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uhF4w-0001Aa-Tv
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 18:15:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uhF4u-0004IR-E0
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 18:15:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753913714;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HnJBv4LzvXlCSX/ac54n+H9vrMKHbOQlVoZvvmq3pIg=;
 b=UXZXEqg41FScI2jsM3cEIDYNBWaVmRfFBDvRSquRk34691GzhoB9YOaxDldxIzIxrYOy95
 JA8D6UOMpNJB1TDWI2Anbd0yDnF2osvsI0u2UifYo0QMVnqvo+YYAzQLj/m3/Rlx5qf3vD
 74RTI6YlOqFj4MNLFUbAjE9l8GxEpZM=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-246-ZW6yrGu5OmWpsO11-aqo4g-1; Wed, 30 Jul 2025 18:15:11 -0400
X-MC-Unique: ZW6yrGu5OmWpsO11-aqo4g-1
X-Mimecast-MFC-AGG-ID: ZW6yrGu5OmWpsO11-aqo4g_1753913711
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-7e665a0cddcso64622785a.0
 for <qemu-devel@nongnu.org>; Wed, 30 Jul 2025 15:15:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753913711; x=1754518511;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HnJBv4LzvXlCSX/ac54n+H9vrMKHbOQlVoZvvmq3pIg=;
 b=YXxoMF5VZOi1xWAnRGscdx5sP+5a6iDkwubWPy+40oc8Gk92Bf1zUEVtMk3dsuoofF
 S6UyKcsaUnK8r3oSeSCUJSDrl4uK54eXwRXsIBS2CJ0+ySJ1nEijny4AycEUWqw7EjD4
 9P5TPbjSVT2TCm0FP8NGYt19ZrgfVtsol63N5Eu3cvmIpu1fjixTjhigGUg+FKEEhEE2
 9REeRC3s+jhiM38gtB5LjD0d6N7dDAAYtbT0v1OlTx7CZvPr7M1++/r51rvxQ1I1bR2X
 tX8W3QntGrrv5SCecZvpnVR7QQPk7uoN+cDFAfxqmqI+v2Mhduy5Vgbr3MyduChjSFph
 F59Q==
X-Gm-Message-State: AOJu0YxKeuvWOkSx2CLvbqOFRmJNlI2b7QZPCAJkxUP3hedM1bFLLpFS
 TMcwPzkBNy1tB3xiqNoCZ1ajI8JSoKbb8g0w0NnK3ck3R5UaA2OQUXw8Z8eyU49nNjqA31erKuX
 2IpAamZFfFwxmwPZmF5ldRS6P/mpjIZJYKzQAfuJoe2X3Pr8AsHHNtO78
X-Gm-Gg: ASbGncvbRjKZFEp8N7gViyHr+q46oafR0y1VG0Ibh4U8ySBb6hVSHqt+KEGx/AJHy+t
 nIn4Zr3IMo1ZYl0RiFudj7DwREdOQtwuDVd0zAd3RLzeywrsAfzWP1Y3Jh5Sz0RF0hGuT/02EiL
 /PlruZSbOik+ttWnzoi7TvSAUeR9WvLvwEv0ofiqYDSNn00b1HSv6Vhz1oQUNbM/rfeKz4MrfwC
 Z2lFonBorxAbdTr8664Vd/s5dpRzgcrYQnYWPzQvh8NXgsEkH2Ozhs77mqic2Lcl9L7oG64JU8J
 bC98suuIZ8vcZY5m4V+D5k+HoNIG9NYuB/0BfOCPlZoiOH2lWUhASq48g6qfRWuhA1tR/2ZAl4n
 u0QUTl1vHL6rNsgxZVPFzyw==
X-Received: by 2002:a05:620a:1791:b0:7e6:2faf:883a with SMTP id
 af79cd13be357-7e66efd4436mr574578785a.29.1753913708694; 
 Wed, 30 Jul 2025 15:15:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF+MGF76evxfjSM0sOQQ+j/wOOnNf60nQaYCNa3D2NA4g/GY84cKigMW/mKoioOWEg58RBjDA==
X-Received: by 2002:a05:620a:1791:b0:7e6:2faf:883a with SMTP id
 af79cd13be357-7e66efd4436mr574574985a.29.1753913708293; 
 Wed, 30 Jul 2025 15:15:08 -0700 (PDT)
Received: from x1.local
 (bras-base-aurron9134w-grc-11-174-89-135-171.dsl.bell.ca. [174.89.135.171])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7e67f5947e9sm12298385a.1.2025.07.30.15.15.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Jul 2025 15:15:07 -0700 (PDT)
Date: Wed, 30 Jul 2025 18:15:03 -0400
From: Peter Xu <peterx@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, mst@redhat.com,
 mtosatti@redhat.com, kraxel@redhat.com, peter.maydell@linaro.org
Subject: Re: [PATCH v2 5/6] hpet: make main counter read lock-less
Message-ID: <aIqZZ5bePh7Jmq3c@x1.local>
References: <20250730123934.1787379-1-imammedo@redhat.com>
 <20250730123934.1787379-6-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250730123934.1787379-6-imammedo@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Jul 30, 2025 at 02:39:33PM +0200, Igor Mammedov wrote:
> Make access to main HPET counter lock-less when enable/disable
> state isn't changing (which is the most of the time).
> 
> A read will fallback to locked access if the state change happens
> in the middle of read or read happens in the middle of the state
> change.
> 
> This basically uses the same approach as cpu_get_clock(),
> modulo instead of busy wait it piggibacks to taking device lock
> to wait until HPET reaches consistent state.

The open-coded seqlock will slightly add complexity of the hpet code.  Is
it required? IOW, is it common to have concurrent writters while reading?

How bad it is to spin on read waiting for the writer to finish?

Thanks,

> 
> As result micro benchmark of concurrent reading of HPET counter
> with large number of vCPU shows over 80% better (less) latency.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
>  hw/timer/hpet.c | 48 ++++++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 44 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/timer/hpet.c b/hw/timer/hpet.c
> index 97687697c9..d822ca1cd0 100644
> --- a/hw/timer/hpet.c
> +++ b/hw/timer/hpet.c
> @@ -74,6 +74,7 @@ struct HPETState {
>      MemoryRegion iomem;
>      uint64_t hpet_offset;
>      bool hpet_offset_saved;
> +    unsigned state_version;
>      qemu_irq irqs[HPET_NUM_IRQ_ROUTES];
>      uint32_t flags;
>      uint8_t rtc_irq_level;
> @@ -430,17 +431,44 @@ static uint64_t hpet_ram_read(void *opaque, hwaddr addr,
>      trace_hpet_ram_read(addr);
>      addr &= ~4;
>  
> -    QEMU_LOCK_GUARD(&s->lock);
>      if ((addr <= 0xff) && (addr == HPET_COUNTER)) {
> -        if (hpet_enabled(s)) {
> -            cur_tick = hpet_get_ticks(s);
> -        } else {
> +        unsigned version;
> +        bool release_lock = false;
> +redo:
> +        version = qatomic_load_acquire(&s->state_version);
> +        if (unlikely(version & 1)) {
> +                /*
> +                 * Updater is running, state can be inconsistent
> +                 * wait till it's done before reading counter
> +                 */
> +                release_lock = true;
> +                qemu_mutex_lock(&s->lock);
> +        }
> +
> +        if (unlikely(!hpet_enabled(s))) {
>              cur_tick = s->hpet_counter;
> +        } else {
> +            cur_tick = hpet_get_ticks(s);
> +        }
> +
> +        /*
> +         * ensure counter math happens before we check version again
> +         */
> +        smp_rmb();
> +        if (unlikely(version != qatomic_load_acquire(&s->state_version))) {
> +            /*
> +             * counter state has changed, re-read counter again
> +             */
> +            goto redo;
> +        }
> +        if (unlikely(release_lock)) {
> +            qemu_mutex_unlock(&s->lock);
>          }
>          trace_hpet_ram_read_reading_counter(addr & 4, cur_tick);
>          return cur_tick >> shift;
>      }
>  
> +    QEMU_LOCK_GUARD(&s->lock);
>      /*address range of all global regs*/
>      if (addr <= 0xff) {
>          switch (addr) {
> @@ -500,6 +528,11 @@ static void hpet_ram_write(void *opaque, hwaddr addr,
>              old_val = s->config;
>              new_val = deposit64(old_val, shift, len, value);
>              new_val = hpet_fixup_reg(new_val, old_val, HPET_CFG_WRITE_MASK);
> +            /*
> +             * Odd versions mark the critical section, any readers will be
> +             * forced into lock protected read if they come in the middle of it
> +             */
> +            qatomic_inc(&s->state_version);
>              s->config = new_val;
>              if (activating_bit(old_val, new_val, HPET_CFG_ENABLE)) {
>                  /* Enable main counter and interrupt generation. */
> @@ -518,6 +551,13 @@ static void hpet_ram_write(void *opaque, hwaddr addr,
>                      hpet_del_timer(&s->timer[i]);
>                  }
>              }
> +            /*
> +             * even versions mark the end of critical section,
> +             * any readers started before config change, but were still executed
> +             * during the change, will be forced to re-read counter state
> +             */
> +            qatomic_inc(&s->state_version);
> +
>              /* i8254 and RTC output pins are disabled
>               * when HPET is in legacy mode */
>              if (activating_bit(old_val, new_val, HPET_CFG_LEGACY)) {
> -- 
> 2.47.1
> 

-- 
Peter Xu


