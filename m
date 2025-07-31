Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8A53C83F17
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Jul 2025 08:32:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhOiE-0006vM-BZ; Thu, 31 Jul 2025 04:32:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uhOi8-0006sd-Ka
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 04:32:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uhOi3-000083-6N
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 04:32:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753950735;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tfe4c0W0kn5d7yjhyE0kabLsPO9r4eHXt3bBOJb9Rv8=;
 b=VLI4+yKEqImeDZJrxNHOeqXQS38jOXU2OnTYEs5ljbxwzvl12axc7scoAvLUWYyhQISbFA
 FYevUXsmkIO+y00O85HHk3cZkWU2d45oO0apUvfNsTU7FHBNNn+K7cuzPINk60561eItK2
 PYRPO7zPEDXpPc6fxztGSAsuPiEGFJc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-204-S_GK6BtLNo20YScglaPkoA-1; Thu, 31 Jul 2025 04:32:13 -0400
X-MC-Unique: S_GK6BtLNo20YScglaPkoA-1
X-Mimecast-MFC-AGG-ID: S_GK6BtLNo20YScglaPkoA_1753950732
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3b7931d3d76so491481f8f.1
 for <qemu-devel@nongnu.org>; Thu, 31 Jul 2025 01:32:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753950732; x=1754555532;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tfe4c0W0kn5d7yjhyE0kabLsPO9r4eHXt3bBOJb9Rv8=;
 b=Aw8IySZi5Zb8qmXDdnZaz42nwKgsra1j1lFyHYzDG18gvxFhOeZglyvLwJQGf8taZY
 ZMz2NITddIQqlwjn9xv1e7DmMHAAVqHwrIAMqxz//hZFjVpJB2rMOGsdSwRYqCOwaTHu
 aE3qLlaEgTeIN7OGyVvDOX47s1FilAsJX47wOgrANHv4XjECyrDDz9P+fevNN3PIbNFd
 aG9NPUZsZzixllbvucKJxUdPQOb9s/PWAkLPamGSpKiBpgDc0evVQL2vOVPbzaOBm674
 FwhwxKiPkoXGoIote2BXRqnhNJBwVv+58ZMUc5WH1P14+AZmKLfGkM7oVXgraRqhPiGw
 jPQw==
X-Gm-Message-State: AOJu0YwZ+CBWo4JJ9ZBgKeojBt0vQdVN7yh7sHKzxcWa5osoM0XQ4P0z
 8MnvyQI4COCXoZHtV+x3jOihxL0VJ2tFYdQ52Px6i8mfiQbFd76ClOvNGFqBk/zJHRZt0Azs65I
 GqTq45RIZCWeMnlbrWhqr9hIwGh1TdPvmUsdGBhh5L1M1qfldQKfunoW2
X-Gm-Gg: ASbGncvE2Q5ZHn+LWXTU1Ttp+LSPjl3Pgy4UWlihSgqU8EbjEX2CMgj7TWKXIfdHQZR
 wwMFbuiyj6bigaAYoOXbrjnV2xSp4IbgolmbcsezZGTjV6nV7FUAxU/3wvw+JLb3MMJuFFalfHI
 p1Eammae4pAsWCOwUu1B20yJJnYrk8kg6Vu/t6exiFdT5TZgCWWc//sqYTjvA5LmSNjX+rwq/pu
 ipTWaAB+CIuxvicRXERyvUNpAjW41YjFvzxYqbhRf68Kfp/g8v2k0KOFzZruwWTqUjGSlV9FXod
 6AgJAqPZAEuUeFU5XdCpXsw+s6GJXA==
X-Received: by 2002:a5d:5f51:0:b0:3b7:8da6:1baf with SMTP id
 ffacd0b85a97d-3b794fd5940mr4897154f8f.16.1753950732075; 
 Thu, 31 Jul 2025 01:32:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG1B+VTY6EyLsm+xvbaZvTsIVAPExGTo1vB8Qqjb9Pvz0inqouzYRSkOTnGhwkJNQHki5yEyw==
X-Received: by 2002:a5d:5f51:0:b0:3b7:8da6:1baf with SMTP id
 ffacd0b85a97d-3b794fd5940mr4897127f8f.16.1753950731615; 
 Thu, 31 Jul 2025 01:32:11 -0700 (PDT)
Received: from fedora ([85.93.96.130]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c4a2f03sm1558580f8f.72.2025.07.31.01.32.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Jul 2025 01:32:11 -0700 (PDT)
Date: Thu, 31 Jul 2025 10:32:10 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, mst@redhat.com,
 mtosatti@redhat.com, kraxel@redhat.com, peter.maydell@linaro.org
Subject: Re: [PATCH v2 5/6] hpet: make main counter read lock-less
Message-ID: <20250731103210.292dfecb@fedora>
In-Reply-To: <aIqZZ5bePh7Jmq3c@x1.local>
References: <20250730123934.1787379-1-imammedo@redhat.com>
 <20250730123934.1787379-6-imammedo@redhat.com>
 <aIqZZ5bePh7Jmq3c@x1.local>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Wed, 30 Jul 2025 18:15:03 -0400
Peter Xu <peterx@redhat.com> wrote:

> On Wed, Jul 30, 2025 at 02:39:33PM +0200, Igor Mammedov wrote:
> > Make access to main HPET counter lock-less when enable/disable
> > state isn't changing (which is the most of the time).
> > 
> > A read will fallback to locked access if the state change happens
> > in the middle of read or read happens in the middle of the state
> > change.
> > 
> > This basically uses the same approach as cpu_get_clock(),
> > modulo instead of busy wait it piggibacks to taking device lock
> > to wait until HPET reaches consistent state.  
> 
> The open-coded seqlock will slightly add complexity of the hpet code.  Is
> it required? IOW, is it common to have concurrent writters while reading?

Write path has to be lock protected for correctness sake even though
concurrent writers are not likely.

I've tried seqlock as well, the difference wrt seqlock is few LOC only
it didn't make HPET code any simpler.

> How bad it is to spin on read waiting for the writer to finish?
that will waste CPU cycles, and on large NUMA system it will generate
more cross node traffic. (i.e. it would scale badly, though TBH
I don't have numbers. I think measuring it would be hard as it
would drown in the noise.)

hence I've opted for a more effective option, to halt readers
until update is done. (at the cost of latency spike when that
unlikely event happens)

> Thanks,
> 
> > 
> > As result micro benchmark of concurrent reading of HPET counter
> > with large number of vCPU shows over 80% better (less) latency.
> > 
> > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > ---
> >  hw/timer/hpet.c | 48 ++++++++++++++++++++++++++++++++++++++++++++----
> >  1 file changed, 44 insertions(+), 4 deletions(-)
> > 
> > diff --git a/hw/timer/hpet.c b/hw/timer/hpet.c
> > index 97687697c9..d822ca1cd0 100644
> > --- a/hw/timer/hpet.c
> > +++ b/hw/timer/hpet.c
> > @@ -74,6 +74,7 @@ struct HPETState {
> >      MemoryRegion iomem;
> >      uint64_t hpet_offset;
> >      bool hpet_offset_saved;
> > +    unsigned state_version;
> >      qemu_irq irqs[HPET_NUM_IRQ_ROUTES];
> >      uint32_t flags;
> >      uint8_t rtc_irq_level;
> > @@ -430,17 +431,44 @@ static uint64_t hpet_ram_read(void *opaque, hwaddr addr,
> >      trace_hpet_ram_read(addr);
> >      addr &= ~4;
> >  
> > -    QEMU_LOCK_GUARD(&s->lock);
> >      if ((addr <= 0xff) && (addr == HPET_COUNTER)) {
> > -        if (hpet_enabled(s)) {
> > -            cur_tick = hpet_get_ticks(s);
> > -        } else {
> > +        unsigned version;
> > +        bool release_lock = false;
> > +redo:
> > +        version = qatomic_load_acquire(&s->state_version);
> > +        if (unlikely(version & 1)) {
> > +                /*
> > +                 * Updater is running, state can be inconsistent
> > +                 * wait till it's done before reading counter
> > +                 */
> > +                release_lock = true;
> > +                qemu_mutex_lock(&s->lock);
> > +        }
> > +
> > +        if (unlikely(!hpet_enabled(s))) {
> >              cur_tick = s->hpet_counter;
> > +        } else {
> > +            cur_tick = hpet_get_ticks(s);
> > +        }
> > +
> > +        /*
> > +         * ensure counter math happens before we check version again
> > +         */
> > +        smp_rmb();
> > +        if (unlikely(version != qatomic_load_acquire(&s->state_version))) {
> > +            /*
> > +             * counter state has changed, re-read counter again
> > +             */
> > +            goto redo;
> > +        }
> > +        if (unlikely(release_lock)) {
> > +            qemu_mutex_unlock(&s->lock);
> >          }
> >          trace_hpet_ram_read_reading_counter(addr & 4, cur_tick);
> >          return cur_tick >> shift;
> >      }
> >  
> > +    QEMU_LOCK_GUARD(&s->lock);
> >      /*address range of all global regs*/
> >      if (addr <= 0xff) {
> >          switch (addr) {
> > @@ -500,6 +528,11 @@ static void hpet_ram_write(void *opaque, hwaddr addr,
> >              old_val = s->config;
> >              new_val = deposit64(old_val, shift, len, value);
> >              new_val = hpet_fixup_reg(new_val, old_val, HPET_CFG_WRITE_MASK);
> > +            /*
> > +             * Odd versions mark the critical section, any readers will be
> > +             * forced into lock protected read if they come in the middle of it
> > +             */
> > +            qatomic_inc(&s->state_version);
> >              s->config = new_val;
> >              if (activating_bit(old_val, new_val, HPET_CFG_ENABLE)) {
> >                  /* Enable main counter and interrupt generation. */
> > @@ -518,6 +551,13 @@ static void hpet_ram_write(void *opaque, hwaddr addr,
> >                      hpet_del_timer(&s->timer[i]);
> >                  }
> >              }
> > +            /*
> > +             * even versions mark the end of critical section,
> > +             * any readers started before config change, but were still executed
> > +             * during the change, will be forced to re-read counter state
> > +             */
> > +            qatomic_inc(&s->state_version);
> > +
> >              /* i8254 and RTC output pins are disabled
> >               * when HPET is in legacy mode */
> >              if (activating_bit(old_val, new_val, HPET_CFG_LEGACY)) {
> > -- 
> > 2.47.1
> >   
> 


