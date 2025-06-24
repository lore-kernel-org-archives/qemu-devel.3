Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB5CFC77B7C
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Jun 2025 10:57:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uU1L3-0006GC-DW; Tue, 24 Jun 2025 06:57:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uU1L1-0006Fp-6y
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 06:57:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uU1Kx-0003tr-Dj
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 06:57:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750762628;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kXyjj4iGn7X5bUj9ONNCvQXQsREXpb8azLRY7Kn/NXY=;
 b=XqcQyPyQ5KEdOJPoSM8Kg9MXQpD24WCLnQ6/l5lyElEJfOr/ey0R+saD5uynBiS7P+Itty
 e2NnT8OSPz9AqrAJejws4QBBv496iwAGwBLqV6OQXbnRJgQhUZWLkmcvEYRjI1Nr5lSYSD
 zyCP/m7x4F8xb0mDSlxPeabycz5hsMY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-189-1cl7AnvHMjyKFNp97ZjkUg-1; Tue, 24 Jun 2025 06:57:07 -0400
X-MC-Unique: 1cl7AnvHMjyKFNp97ZjkUg-1
X-Mimecast-MFC-AGG-ID: 1cl7AnvHMjyKFNp97ZjkUg_1750762626
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-45311704d22so33978325e9.2
 for <qemu-devel@nongnu.org>; Tue, 24 Jun 2025 03:57:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750762626; x=1751367426;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kXyjj4iGn7X5bUj9ONNCvQXQsREXpb8azLRY7Kn/NXY=;
 b=KZ46/4ZBPY9nItq4TMd7EdNZGBTLc2Qb8AMffT9aAJ0d6w+q56M952TUIDCQ5t83dK
 0WAUNof/1WBvUYOzLbTdMYafpM5cfPXxZpMpTZVw++yRMuBQcQrBgu/gZHJzEutwki61
 7NEIqIVl95E6ZMuCH3aKSoVLZwJWX0wBZ5VRDzX3aGcoY4vL4Js3dAyazam+4E+RoDi8
 9mbNaWJXGuUqN+D2xC3+rAdjhzePYrr07mYSG8PP6fwR8kuav1BY2kvjFNDezak/raLJ
 dlKZrbvNS96hWHP/WX2YIQN6zBqF0MBREyS4E2IlA3JeZoPHFJNFvwOxbapB6EnI6rml
 0Ssg==
X-Gm-Message-State: AOJu0YztI35csZJszlwp2MtyfrSWbDc4ZBZZwInSTVQFAtrxSe92cMjQ
 MkTrbouSSP2pHuuo60COFMAJDWsIvbZq8hedx8quCNkAXrwxetVCzIZqqBICQEmNmLmHL/aGaDd
 ziRNaQvKGqtIa1q7wCPP0KzsVhAyBJfZSuImugK1VFVDzND+3dbVXYYDQ
X-Gm-Gg: ASbGncsIrstXEVuwwm1Z+FqUB7kNZhklUQZAH1iOIad/FWBJNordNveV5Fak/q8qe8j
 xbNPJ319SxavmIAaUaWYL2r1OI+9fRdNYPt7Ehi7mJg20JFGh962eBLFAJH97TFW0+f+ceNhkxm
 ARLHmQUu+Pz2z6OC9/KSzPovxdjG/mBoohxU6IlgMMoVbcwC6cl4n8BJbzzEn3Ci5ohnaYZ/Ymy
 ktMrS559Ya2RBAgCIsumJjgDgrBusVMv93g4hIxS+cmtYUNSKqv9HRFKSV6FkdITU5/wDnFW1Wb
 1blK9QY5MaXP
X-Received: by 2002:a05:600c:138e:b0:442:f4a3:8c5c with SMTP id
 5b1f17b1804b1-453653b02c3mr195106105e9.10.1750762626054; 
 Tue, 24 Jun 2025 03:57:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE2RyIwsA0Ou23emkocoUn0m0az7hs1B7A7hSRovjCb1XzUO8ElxSXdoNl7hqMEjJg5NUWcag==
X-Received: by 2002:a05:600c:138e:b0:442:f4a3:8c5c with SMTP id
 5b1f17b1804b1-453653b02c3mr195105685e9.10.1750762625600; 
 Tue, 24 Jun 2025 03:57:05 -0700 (PDT)
Received: from fedora ([85.93.96.130]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45361461375sm155787415e9.14.2025.06.24.03.57.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Jun 2025 03:57:05 -0700 (PDT)
Date: Tue, 24 Jun 2025 12:57:04 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, kraxel@redhat.com, mst@redhat.com,
 anisinha@redhat.com, elena.ufimtseva@oracle.com, jag.raman@oracle.com,
 pbonzini@redhat.com, david@redhat.com, philmd@linaro.org
Subject: Re: [PATCH 1/3] memory: reintroduce BQL-free fine-grained PIO/MMIO
Message-ID: <20250624125704.40f635fd@fedora>
In-Reply-To: <aFlYRWc7rRwBGM8S@x1.local>
References: <20250620151418.1166195-1-imammedo@redhat.com>
 <20250620151418.1166195-2-imammedo@redhat.com>
 <aFWR8rM7-4y1R0GG@x1.local> <20250623145146.4462bf59@fedora>
 <aFlYRWc7rRwBGM8S@x1.local>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Mon, 23 Jun 2025 09:36:05 -0400
Peter Xu <peterx@redhat.com> wrote:

> On Mon, Jun 23, 2025 at 02:51:46PM +0200, Igor Mammedov wrote:
> > On Fri, 20 Jun 2025 12:53:06 -0400
> > Peter Xu <peterx@redhat.com> wrote:
> >   
> > > On Fri, Jun 20, 2025 at 05:14:16PM +0200, Igor Mammedov wrote:  
> > > > This patch brings back Jan's idea [1] of BQL-free IO access,
> > > > with a twist that whitelist read access only.
> > > > 
> > > > (as BQL-free write access in [1] used to cause issues [2]
> > > > and still does (Windows crash) if write path is not lock protected)    
> > > 
> > > Can we add some explanation on why it would fail on lockless writes?
> > > 
> > > I saw that acpi_pm_tmr_write() is no-op, so I don't yet understand what
> > > raced, and also why guest writes to it at all..  
> > 
> > root cause wasn't diagnosed back then, and I haven't able to
> > reproduce that as well. So I erred on side of caution and
> > implemented RO only.  
> 
> Ah OK, I think I got that feeling it can be reproduced as above mentioned
> "still does (Windows crash) if write ...".

that is leftover from experiments with lockless split irqchip,
as we need to use it with more then 255 vCPU, and then we are back
BQL contention as every IO exit will also trigger taking BQL
for non-in-kernel irqchip.

So this series addresses unboottable Windows issue only upto
255 vCPU. If I manage to make split irqchip checks lockless,
it will be a separate series on top.

> 
> > 
> > Theoretically write should be fine too, but I don't have
> > an idea how to test that.  
> 
> Then the question is how do we justify it will work this time..
> 
> If nobody can reproduce it anymore, there's indeed one way to go if we
> strongly want to have the optimization, which is to apply it again and wait
> for the reproducer to pop up once more.  Just like to double check is this
> the case, and we have no way to reproduce?

I'd prefer to reproduce issue if possible, but if that won't workout
it might be better to try and see it explodes elsewhere.
Let's see if I could reproduce with old Seabios as per Gerd's suggestions. 
 
> I also wonder whether it's still a bit late because such experiment might
> be better done at the start of release cycle.  Now we have roughly 3 weeks
> to soft-freeze (July 15).  I had a look, last time it was pretty late when
> reverting the change:
> 
> 975eb6a547 (tag: v2.6.0-rc4) Update version for v2.6.0-rc4 release
> 1beb99f787 Revert "acpi: mark PMTIMER as unlocked"
> 
> So there's also the question of whether we should land this for this
> release or next when open.

I don't see the need to rush this, so
+1 to the next cycle.


> Gerd mentioned this in the relevant bz:
> 
>         Note: root cause for the initrd issue noted in comment 5 is seabios
>         running into problems with ehci -> io errors -> corrupted initrd.
>         Sometimes it doesn't boot at all, probably in case the io errors
>         happen to hit the kernel not the initrd.
> 
> This seems to be the last piece of information we have had that is closest
> to the root cause.  I sincerely wished there's still some way to move
> forward, as it looks really close, but it might be that it was just too
> late for 2.6 so we didn't got time to keep looking back then.
> 
> Thanks,
> 


