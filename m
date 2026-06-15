Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D772DCD98DA
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 20:00:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZDT1-0001as-VJ; Mon, 15 Jun 2026 15:59:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wZDSv-0001af-D2
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 15:59:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wZDSt-00006t-1r
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 15:59:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781553561;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2tSZFiyvQ8Y9o9RBZD0Jur29taRURhpFQ64Zpw5BBiI=;
 b=chJ1gBaOBNDGr8SnQgxMT0qPQkDBQvE5qyktlQjF3RE8puH+D0ct2uI2BJ7KE+nV99tpBi
 8LBrkm5YdppXsxvM6idpoWO9JwLPq+vRywpCTtczURITv9i4r5JukHhIDhTxyXFGehLZPA
 AGaO8o+qaYd7/IJoTSvrgwMuwmb1rjA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-29-O8aBVspaOSSQgO9SXUSjsw-1; Mon, 15 Jun 2026 15:59:20 -0400
X-MC-Unique: O8aBVspaOSSQgO9SXUSjsw-1
X-Mimecast-MFC-AGG-ID: O8aBVspaOSSQgO9SXUSjsw_1781553559
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-490b7959b9fso38738225e9.2
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 12:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781553559; x=1782158359; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=2tSZFiyvQ8Y9o9RBZD0Jur29taRURhpFQ64Zpw5BBiI=;
 b=s/UrAJqzjMLHms9NoOKwF5E+0CWAKKiuk+OGBrznY4bXZSG388a02qq7JJIzlBIJJh
 T4u6PMr5OZa3DASVN42ZKdBozWTXp6YH+R0ou5USxNxnljlVVVLDUoTJDr7vrgb78SPz
 0FU01gWuph2bv+tobhPR4zeksOR1I1ej9UnbJ+SNuWUpeFoPiEgX4cEMTbu428XXQmKV
 XT4o96GKeLjWPljQOgluPrPyRJsQA+nvMIezK5xctCKSCJc5MliVbwZzd8un60jcyA0/
 dBLtQh5QfdzwTYX/+HCQQ3S3dbv/YIafuYmJYshH8cdFBmvmJNmvUw1/q5g0SZCF4Gl9
 JdEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781553559; x=1782158359;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2tSZFiyvQ8Y9o9RBZD0Jur29taRURhpFQ64Zpw5BBiI=;
 b=A0uZd8I43GuOOjndbTwSEhkIv/8JiTaS8lgo3uDw+RnBk9zsMr8uCBv51DeIAumYYT
 +CyNTpzSgh8KdqQQ9O1qQZTr0TPfTL5iMnqGBXDLA0WXO4m+v413RZkf+IUIIylGDzk0
 kndmmqTMoVB4Ne3kZseAEKLVFEce8OigbsiqHgGsSqysS9Cif10NTYNUPLls7Ss2eNzn
 LVErNeA6hwqHwVz3lE7r3gcbfxHkwfGqxEoCYtJLezIZbuFL/CTXpZ16nArcYNXAmGCe
 fVOogayq36OPEdj62jGi9w0ptFzWuKBoSNq24S+rQHKG2PCbfY2yVvS/PmQoSgp/4qH2
 OP7w==
X-Forwarded-Encrypted: i=1;
 AFNElJ/GOu6eyc3Z/wYVRClbh0LL/MNq8nPdP+3h+SHc8hcuUGYRt0EG7lfqvhuQ6EVcCfi9l7TtwYg8JQN5@nongnu.org
X-Gm-Message-State: AOJu0Yx6cX5eZ4bSfvt9zYvVIT+CnL6dOfMhXFh2iHK8q7+F1znV/ZLK
 YtS50JRvYyXzX/iSC0Pnw+CraMztFJMrb5IZKnfDWDAIddAEBOglwkf9plWiMMVsbpj3oxy1uxK
 BOMTvzJ8Y/BU/g3SJLP+Skje2dn2+7q61xY5cMvR9dTTQL0CpiDYfDUYw
X-Gm-Gg: Acq92OFShK0SEPFEPj2q6zPuyuXVtkRflHVvhmOBgvREDePWTP8bRA82Ihhb3x7nvYP
 BuaWsogq5G1txwqYxfUYu9DNhD7m7CsLuUrQPfliTSsdO33fNVyZPnixn9D08ch/Jc0aI8bqqLt
 JWN2HiXBvXP3UgzFoM+a3Ln824bwAmcvW9nszwEqPd0vW7jSVDWeGMKHdZC+ciIFu0bAKOiLh/B
 6Q6atCsMa/k6KR6hGPw+zGWxFfqL8QJvt01PCBxP2vF7mFbTcz0X3NkV9Iqva99Puer3WSaIGJ0
 g6l3cJiAiqAkR1bvvTjnYRsN2H4wvNm4LoMhRyILqXXLeFJzh+VaOIhIsHH3m6pol/FioEWM7hR
 ya4RDAqycmLOyXX6r0BDNzNHRF4SdGQBx3tZ81Vhnjio=
X-Received: by 2002:a05:600c:c171:b0:490:ae52:499c with SMTP id
 5b1f17b1804b1-4922ffae9c1mr9720775e9.21.1781553558975; 
 Mon, 15 Jun 2026 12:59:18 -0700 (PDT)
X-Received: by 2002:a05:600c:c171:b0:490:ae52:499c with SMTP id
 5b1f17b1804b1-4922ffae9c1mr9720355e9.21.1781553558458; 
 Mon, 15 Jun 2026 12:59:18 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f26f23fsm36954467f8f.9.2026.06.15.12.59.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2026 12:59:17 -0700 (PDT)
Date: Mon, 15 Jun 2026 15:59:14 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Gavin Shan <gshan@redhat.com>,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, jugraham@redhat.com,
 shan.gavin@gmail.com, qemu-block@nongnu.org
Subject: Re: [PATCH RFCv1] virtio: Inherit max bounce buffer size from bus
 parent if possible
Message-ID: <20260615155855-mutt-send-email-mst@kernel.org>
References: <20260610041036-mutt-send-email-mst@kernel.org>
 <20260610183046.GB121666@fedora>
 <20260610165710-mutt-send-email-mst@kernel.org>
 <20260611142022.GA202155@fedora>
 <20260611103513-mutt-send-email-mst@kernel.org>
 <CAFEAcA8RAsmrAArKz0X7NU6sCnKTC-e413TgwLp1gt2vJGLgPw@mail.gmail.com>
 <20260611110543-mutt-send-email-mst@kernel.org>
 <20260611183708.GA222320@fedora>
 <20260611165238-mutt-send-email-mst@kernel.org>
 <20260615155411.GA450713@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260615155411.GA450713@fedora>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Jun 15, 2026 at 11:54:11AM -0400, Stefan Hajnoczi wrote:
> On Thu, Jun 11, 2026 at 04:54:36PM -0400, Michael S. Tsirkin wrote:
> > On Thu, Jun 11, 2026 at 02:37:08PM -0400, Stefan Hajnoczi wrote:
> > > On Thu, Jun 11, 2026 at 11:09:35AM -0400, Michael S. Tsirkin wrote:
> > > > On Thu, Jun 11, 2026 at 04:04:20PM +0100, Peter Maydell wrote:
> > > > > On Thu, 11 Jun 2026 at 15:46, Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > > >
> > > > > > On Thu, Jun 11, 2026 at 10:20:22AM -0400, Stefan Hajnoczi wrote:
> > > > > > > Gavin posted the lspci output:
> > > > > > >
> > > > > > >   Region 0: Memory at 661ffd000000 (64-bit, prefetchable) [size=16M]
> > > > > > >   Region 2: Memory at 662000000000 (64-bit, prefetchable) [size=128G]
> > > > > > >   Region 4: Memory at 661ffe000000 (64-bit, prefetchable) [size=32M]
> > > > > > >
> > > > > > > These are prefetchable memory BARs, so I would expect them to be
> > > > > > > mmappable. Why does QEMU have no way of knowing upfront whether they can
> > > > > > > be mmapped?
> > > > > >
> > > > > >
> > > > > > They can be mmapped.  The issue is just that after mmap flatview uses
> > > > > > memcpy/memmove on them, and that might not match what guest driver is
> > > > > > expecting specifically for 1/2/4/8 byte accesses.
> > > > > 
> > > > > Huh? The guest driver has nothing to do with it, surely.
> > > > 
> > > > My answer is I don't know.
> > > > 
> > > > But the commit that introduced the regression says:
> > > > 
> > > > 	 The assumption here is that accesses initiated by the VM are
> > > > 	    driven by a device specific driver, which knows the device
> > > > 	    capabilities. 
> > > > 
> > > > > The
> > > > > problem is that for some PCI devices (like the network card
> > > > > mentioned in 4a2e242bbb30's commit message) the BAR is *not*
> > > > > safe for arbitrary access (because the actual real host hardware
> > > > > inside it is not RAM).
> > > > 
> > > > But we don't do arbitrary access. Why would we?
> > > > 
> > > > > That commit disabled direct access
> > > > > for all vfio MRs, which is safe but overcautious. Would
> > > > > "direct access is OK if this is a prefetchable memory BAR" be OK?
> > > > > Or do some prefetchable memory BARs still have restrictions
> > > > > beyond those of real RAM?
> > > 
> > > I wonder the same thing.
> > 
> > pci spec mostly made prefetcheable the default, and made
> > it a very weak signal.
> > 
> > but really, direct access is just always ok. bounce buffers
> > just do not have the bug of memory core besides that
> > they buy us nothing.
> 
> What is the next step here?
> 
> Stefan

Gavin seems to be iterating.

> > > > > 
> > > > > > Removing mmap is one solution, this is what vfio does now.
> > > > > > Fixing flatview is another.
> > > > > 
> > > > > No, you can't fix this in flatview. If a BAR is not safe for
> > > > > direct access then it is not safe for direct access.
> > > > > 
> > > > > -- PMM
> > > > 
> > > > There's no such thing as "not safe for direct access" in PCI.
> > > > All operations are memory operations.
> > > > What can be unsafe is accesses of specific width and length.
> > > > 
> > > > So we should not use variable length memcpy/memmove which
> > > > do that. Fixes length memcpy/memmove exactly mimic what
> > > > guest does, so they are safe.
> > > 
> > > The bounce buffer approach doesn't seem like a solution to me: if the
> > > device has alignment and size restrictions on accesses, then the bounce
> > > buffer won't get them right because it doesn't know where the registers
> > > live within the BAR.
> > > 
> > > Also, the guest initiated I/O to a VIRTIO device pointing to a buffer in
> > > another PCI device's BAR. In this case any failure to handle BAR
> > > accesses would be the guest's problem. It cannot assume that the VIRTIO
> > > device follows a specific DMA transfer pattern with respect to
> > > alignment/size.
> > > 
> > > Stefan
> > 
> > 



