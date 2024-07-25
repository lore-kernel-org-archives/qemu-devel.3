Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 980F4C3DA49
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2024 20:52:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sX5Qi-0005tf-1g; Thu, 25 Jul 2024 16:51:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sX5Qe-0005rk-6k
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 16:51:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sX5QV-0001rB-WD
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 16:51:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721940660;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0TRSzPBcxjm5TEyUVQiD4/U25Z4w4e7FZY73nOkT9RE=;
 b=FwCzZBTAF/5r/uUqKOsjvkd6qmjSpgWjPjmbegm2ix4ZJKChfL4zknrO5jZRLsIffon8pj
 a16WI8oYUVQywGuP7T7dQ3ZU+0vr72l3HVIoxH3swDvudEScYhN+6gbma3xbi+FlQSi0KT
 Jf5otsVzGOb8bd7hKZE5Yc7Mi4Kew5o=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-66-4TkyW_CYNHq5orZVo_5_vw-1; Thu, 25 Jul 2024 16:50:59 -0400
X-MC-Unique: 4TkyW_CYNHq5orZVo_5_vw-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4280a434147so1397875e9.3
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2024 13:50:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721940658; x=1722545458;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0TRSzPBcxjm5TEyUVQiD4/U25Z4w4e7FZY73nOkT9RE=;
 b=p4rDc0wyWuvPqMCLfNyTEjbNob/NfGA/689npJY8A1XXF32DYipE4CIAnrCaPhn2q2
 jnzh+O7vnYtGKbg8GoXLPxKoEYJEb/IqrojYm8guemVahdgHuwRfsGPLBTN5+euuz7jx
 Ysl/lTrLDMeYrufhmQai8cHgpJHM7FBajZ6ahtKAON5Jyhxv58A/B/QlBSPI/iCiBMO/
 H4/1wZPHcDn2X8FmTQ7Yafbzg8n8M94WhIa9ORd1RpzVsYWw4bT0IyADcPQNH2ldrPVH
 oLANO3/6cayM8n4nalFVMTj+hFEwICZOpGX7OboDrpwhKmgAj7Mp4bJy9b0tZ3fDk2wl
 zK/g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXV+2UybZ7l7bfJchfme19gazHG42Q/y1NGZz1XX4UvQjgnGKMMVu4q1AXCGkSTemVpjJSJ7LymxejsFr9fyq9L8JdunDE=
X-Gm-Message-State: AOJu0YwnVKUpleWmAHQW3dD6sTH2vfkw4rJqJ7iz7rtbzwZTpt4aD3Xk
 B/u+gR78H/YVHHHdRVqgIyXNnKoU/QRDTPjxndq0n4U6jxGDbObTYj2yo5rQXy8g+XbvW1p6ZOI
 9s8Tf+DuYrexG6LRd8/uYCXdcAiCQxUHCG/cG2NCYborm4/9pf7s2
X-Received: by 2002:a05:600c:5494:b0:426:6ed2:6130 with SMTP id
 5b1f17b1804b1-42805708639mr26435585e9.14.1721940657759; 
 Thu, 25 Jul 2024 13:50:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHoEPQMNc9hD+uG29YGXpuoiH409yodxUDLC7kZ9PMGvkPO91aZcH5CMLfzEXGDuU2yH4Kk6w==
X-Received: by 2002:a05:600c:5494:b0:426:6ed2:6130 with SMTP id
 5b1f17b1804b1-42805708639mr26435175e9.14.1721940656863; 
 Thu, 25 Jul 2024 13:50:56 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f7:28ce:f21a:7e1e:6a9:f708])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4280573f935sm50565255e9.14.2024.07.25.13.50.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 13:50:56 -0700 (PDT)
Date: Thu, 25 Jul 2024 16:50:48 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Richard Cochran <richardcochran@gmail.com>,
 Peter Hilber <peter.hilber@opensynergy.com>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-rtc@vger.kernel.org,
 "Ridoux, Julien" <ridouxj@amazon.com>, virtio-dev@lists.linux.dev,
 "Luu, Ryan" <rluu@amazon.com>, "Chashper, David" <chashper@amazon.com>,
 "Mohamed Abuelfotoh, Hazem" <abuehaze@amazon.com>,
 "Christopher S . Hall" <christopher.s.hall@intel.com>,
 Jason Wang <jasowang@redhat.com>, John Stultz <jstultz@google.com>,
 netdev@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Marc Zyngier <maz@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Alessandro Zummo <a.zummo@towertech.it>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 qemu-devel <qemu-devel@nongnu.org>, Simon Horman <horms@kernel.org>
Subject: Re: [PATCH] ptp: Add vDSO-style vmclock support
Message-ID: <20240725163843-mutt-send-email-mst@kernel.org>
References: <20240725081502-mutt-send-email-mst@kernel.org>
 <f55e6dfc4242d69eed465f26d6ad7719193309dc.camel@infradead.org>
 <20240725082828-mutt-send-email-mst@kernel.org>
 <db786be69aed3800f1aca71e8c4c2a6930e3bb0b.camel@infradead.org>
 <20240725083215-mutt-send-email-mst@kernel.org>
 <98813a70f6d3377d3a9d502fd175be97334fcc87.camel@infradead.org>
 <20240725100351-mutt-send-email-mst@kernel.org>
 <2a27205bfc61e19355d360f428a98e2338ff68c3.camel@infradead.org>
 <20240725122603-mutt-send-email-mst@kernel.org>
 <0959390cad71b451dc19e5f9396d3f4fdb8fd46f.camel@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0959390cad71b451dc19e5f9396d3f4fdb8fd46f.camel@infradead.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Jul 25, 2024 at 08:35:40PM +0100, David Woodhouse wrote:
> On Thu, 2024-07-25 at 12:38 -0400, Michael S. Tsirkin wrote:
> > On Thu, Jul 25, 2024 at 04:18:43PM +0100, David Woodhouse wrote:
> > > The use case isn't necessarily for all users of gettimeofday(), of
> > > course; this is for those applications which *need* precision time.
> > > Like distributed databases which rely on timestamps for coherency, and
> > > users who get fined millions of dollars when LM messes up their clocks
> > > and they put wrong timestamps on financial transactions.
> > 
> > I would however worry that with all this pass through,
> > applications have to be coded to each hypervisor or even
> > version of the hypervisor.
> 
> Yes, that would be a problem. Which is why I feel it's so important to
> harmonise the contents of the shared memory, and I'm implementing it
> both QEMU and $DAYJOB, as well as aligning with virtio-rtc.


Writing an actual spec for this would be another thing that might help.

> I don't think the structure should be changing between hypervisors (and
> especially versions). We *will* see a progression from simply providing
> the disruption signal, to providing the full clock information so that
> guests don't have to abort transactions while they resync their clock.
> But that's perfectly fine.
> 
> And it's also entirely agnostic to the mechanism by which the memory
> region is *discovered*. It doesn't matter if it's ACPI, DT, a
> hypervisor enlightenment, a BAR of a simple PCI device, virtio, or
> anything else.
> 
> ACPI is one of the *simplest* options for a hypervisor and guest to
> implement, and doesn't prevent us from using the same structure in
> virtio-rtc. I'm happy enough using ACPI and letting virtio-rtc come
> along later.
> 
> > virtio has been developed with the painful experience that we keep
> > making mistakes, or coming up with new needed features,
> > and that maintaining forward and backward compatibility
> > becomes a whole lot harder than it seems in the beginning.
> 
> Yes. But as you note, this shared memory structure is a userspace ABI
> all of its own, so we get to make a completely *different* kind of
> mistake :)
> 


So, something I still don't completely understand.
Can't the VDSO thing be written to by kernel?
Let's say on LM, an interrupt triggers and kernel copies
data from a specific device to the VDSO.

Is that problematic somehow? I imagine there is a race where
userspace reads vdso after lm but before kernel updated
vdso - is that the concern?

Then can't we fix it by interrupting all CPUs right after LM?

To me that seems like a cleaner approach - we then compartmentalize
the ABI issue - kernel has its own ABI against userspace,
devices have their own ABI against kernel.
It'd mean we need a way to detect that interrupt was sent,
maybe yet another counter inside that structure.

WDYT?

By the way the same idea would work for snapshots -
some people wanted to expose that info to userspace, too.

-- 
MST


