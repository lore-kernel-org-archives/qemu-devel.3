Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AA99C87FD3
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Aug 2025 14:37:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukODG-0001ms-L5; Fri, 08 Aug 2025 10:36:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1ukODD-0001hw-Fx
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 10:36:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1ukOD7-0003vx-Lt
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 10:36:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754663801;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=P50zmfeIgiqCh5II9quC7NYeaAViMVA06B/CIbSz9F4=;
 b=S3HpWdbPWHPFEbqFWCnj1b+rE3Knid8FEydxf5Pb1jcE7hgd1po+cADouxp1AXGqKQ+LYC
 fatm+onA2dQJ274r2SWWv1uLVym+ogW8eSbmx1lyyuyQWZOx82YYvKnQtjbqNQ2WPZZN8r
 UjWQplM2TO/Cv/XwAUNu1v79jDvoPDs=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-500-cFmU5Jo8M_-OG3oVqSex1Q-1; Fri, 08 Aug 2025 10:36:40 -0400
X-MC-Unique: cFmU5Jo8M_-OG3oVqSex1Q-1
X-Mimecast-MFC-AGG-ID: cFmU5Jo8M_-OG3oVqSex1Q_1754663799
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-4b0791a8e8dso63484941cf.2
 for <qemu-devel@nongnu.org>; Fri, 08 Aug 2025 07:36:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754663799; x=1755268599;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=P50zmfeIgiqCh5II9quC7NYeaAViMVA06B/CIbSz9F4=;
 b=oJqXDSQ0TzDcUFOC4+n0UmODZNsaJe97/udUw5u9pq9Vf39qHZ4RB1Bb2NJYvc66Sm
 tvklsobpu3c+5A7dWnV2lOVL3PNYAxyHFRH57pX+nNr6iA9fIKFn+iQhb1LmJZ3We1ET
 DitJo9KY82NfuNOkjzUS8qb9FUAZ7VOtUDmwfdyzLUDq76+Q2AsNIc86PU3ugNv63VNh
 ggM5+WjQck3ewc5YAx4s2PXA0A0KPIOTxEs7fTbPGQUppOw9BfgzJXb9rAYKAz7EOIn3
 LBQaoQYnjjZihJ0TPYnprHCcuTodJsMB+OhuTVnpFVzjpb0F4HfQfEygT8b62qCVILaV
 jo9Q==
X-Gm-Message-State: AOJu0YxWLdMOzaR+/q3Xmj1/Q1ZSp1g9sOfWRT9tOX/OdL2hhg44NeHL
 sBtKgQPIy0yR6e1e2gm0orwUAcrVaeBLBFb7TU4vQngCcWfc3Ufip7LkYTT69lwCaDNhpdlGc3N
 0rIrIJsQxCIgGuMqPKxbs1iYI75c1pLKZ7j1wWq5jwKxbXZnnzKREN40L
X-Gm-Gg: ASbGnctV3BzTth/DyRWBMgZvGC0uuAzSv3OjHoL46ExK355hyg+fzzEmO2smckbN4Te
 2zMsH8lKnDaNUTwAGD+keEjOyj/q5NzGdEs3lEmv4mbSlr5FVUcEJwGIFiQOmBalz5TIPHdnsrF
 FZkBUOVlYcNBPpfAh4O7rxwdv2rPbYtB4BMH435wcdc9xAx2T3AhDS9RPfSj5LkKTFT5osjobdm
 qaMaGgUpDlv8LDIqMbKVI3Fb29AJfbAEQ/03tlFMNLyG/XF60MYpOENHo+0sOu/77DJaKFGchRS
 poBXU9zI2eSUDAE3E1QPKp1w1wiYOw==
X-Received: by 2002:ac8:7f8d:0:b0:4b0:8609:64 with SMTP id
 d75a77b69052e-4b0aec50157mr47631651cf.2.1754663799427; 
 Fri, 08 Aug 2025 07:36:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHzbHGgoK2ECb2ouHyMK33+rgkB4iTTLNddih2esO+lfz6KJeRbLcrRb/wOy4h/6fjohbDOyQ==
X-Received: by 2002:ac8:7f8d:0:b0:4b0:8609:64 with SMTP id
 d75a77b69052e-4b0aec50157mr47631101cf.2.1754663798805; 
 Fri, 08 Aug 2025 07:36:38 -0700 (PDT)
Received: from fedora ([85.93.96.130]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4b067e71186sm69020591cf.17.2025.08.08.07.36.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Aug 2025 07:36:38 -0700 (PDT)
Date: Fri, 8 Aug 2025 16:36:35 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, pbonzini@redhat.com,
 peterx@redhat.com, philmd@linaro.org, mtosatti@redhat.com
Subject: Re: [PATCH v3 01/10] memory: reintroduce BQL-free fine-grained
 PIO/MMIO
Message-ID: <20250808163635.461b52c7@fedora>
In-Reply-To: <2de4fa21-a9ec-454a-9c10-39dd77e16f38@redhat.com>
References: <20250808120137.2208800-1-imammedo@redhat.com>
 <20250808120137.2208800-2-imammedo@redhat.com>
 <2de4fa21-a9ec-454a-9c10-39dd77e16f38@redhat.com>
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

On Fri, 8 Aug 2025 14:12:54 +0200
David Hildenbrand <david@redhat.com> wrote:

> On 08.08.25 14:01, Igor Mammedov wrote:
> > This patch brings back Jan's idea [1] of BQL-free IO access
> > 
> > This will let us make access to ACPI PM/HPET timers cheaper,
> > and prevent BQL contention in case of workload that heavily
> > uses the timers with a lot of vCPUs.
> > 
> > 1) 196ea13104f (memory: Add global-locking property to memory regions)
> >     ... de7ea885c539 (kvm: Switch to unlocked MMIO)
> > 
> > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > ---
> > v3:
> >    add comment for 'mr->disable_reentrancy_guard = true'
> >      Peter Xu <peterx@redhat.com>
> > ---
> >   include/system/memory.h | 10 ++++++++++
> >   system/memory.c         | 15 +++++++++++++++
> >   system/physmem.c        |  2 +-
> >   3 files changed, 26 insertions(+), 1 deletion(-)
> > 
> > diff --git a/include/system/memory.h b/include/system/memory.h
> > index e2cd6ed126..d04366c994 100644
> > --- a/include/system/memory.h
> > +++ b/include/system/memory.h
> > @@ -833,6 +833,7 @@ struct MemoryRegion {
> >       bool nonvolatile;
> >       bool rom_device;
> >       bool flush_coalesced_mmio;
> > +    bool lockless_io;
> >       bool unmergeable;
> >       uint8_t dirty_log_mask;
> >       bool is_iommu;
> > @@ -2341,6 +2342,15 @@ void memory_region_set_flush_coalesced(MemoryRegion *mr);
> >    */
> >   void memory_region_clear_flush_coalesced(MemoryRegion *mr);
> >   
> > +/**
> > + * memory_region_enable_lockless_io: Enable lockless (BQL free) acceess.
> > + *
> > + * Enable BQL-free access for devices with fine-grained locking.
> > + *
> > + * @mr: the memory region to be updated.
> > + */
> > +void memory_region_enable_lockless_io(MemoryRegion *mr);  
> 
> Is this safe to use on any IO region, or could actually something break 
> when mis-used? In case it's the latter, I assume we would want to 
> carefully document under which scenarios this is safe to use.

"for devices with fine-grained locking" is defining scope of where it's
applicable, in another words devices enabling this need to take care
of any locking if necessary.

in this series PM timer didn't need any, while HPET required
some refactoring to make it lock-less on main timer reads,
while taking per device lock for everything else.


