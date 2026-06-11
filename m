Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D93E5CD98CE
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 15:10:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXh2Q-0005up-N6; Thu, 11 Jun 2026 11:09:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wXh2P-0005uI-8E
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 11:09:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wXh2N-0006wv-LV
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 11:09:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781190582;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=a7W2CargfE8xR1DCZz7K2E1bJJouHNJWNgxaxM3VxVA=;
 b=V0+zm3Ea5j5aTHz94AgIHtVkZIZeau9KSDA4pVJBF4h+prKrX4mKB/UVRrTzCEVnGO9TWJ
 VYs2/AiAwsIhX1LTUUR78+RWJKrdhZmeP5/IOjbClVt9fWaSuQBkIWHfqVe3FENAG9EQiE
 SqGLQ0FmPqJv9Bsk1+NPeeCjIKMdHOE=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-225-MnNmuso4PaaZHvPl1IsZsw-1; Thu, 11 Jun 2026 11:09:41 -0400
X-MC-Unique: MnNmuso4PaaZHvPl1IsZsw-1
X-Mimecast-MFC-AGG-ID: MnNmuso4PaaZHvPl1IsZsw_1781190580
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-bef1e83c990so791980966b.1
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 08:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781190580; x=1781795380; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=a7W2CargfE8xR1DCZz7K2E1bJJouHNJWNgxaxM3VxVA=;
 b=qZKNnQJkEGfm/h4+foWXnXKXD0xLLQdZHnjdSIKaumfOoPjghz9y0PIckfbQHLMu3B
 sEGDgYozeP3FAZf+FXKr/7S6xs4yhnmFHcBMPpp0mTR0/FOqMAG39HzUexUfLS6DLXSO
 Xb8dxopD3INiGmonfN/4HfJnXpb8mP5gv7hqw1mtlgn6ILSnhkwRHZMsU5L6UBuSMHmx
 1g5IhN1g90EWohJCvw5rdrUF7DwSjF9TI1kX221YZkpZHRF84bONESF4nfsKmxR1zZPf
 z8ipekXwMtNcVViIhfvfskXRau4X1QDig7MuVRZo/1fW5CsCVvLYfRzi1zJk8CsdosBP
 9ZUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781190580; x=1781795380;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a7W2CargfE8xR1DCZz7K2E1bJJouHNJWNgxaxM3VxVA=;
 b=Ybo8vzs0Hp56DI/HMG9LPJxPNnXpDtQJ191sKrK+LWarKWie0/dodlPeSq+kMF2/iA
 6UGkR+PstNTCOm0vE26WgDMjPbLuJTW5wZixJLRP0rUZsRc9nQ/MM49/1R2QXhgTziHJ
 9DLf1X6gSZKox8IWOTNRoIPeefAXLsTcCI7tGCLbxPAsIuHnW0cg3b0dx446PsGR5Jv/
 0zLHDA2C/Bc3I7JNcTsMbJaLHjI2d+2dXe0+POsn2GZJbmFVOhSounbniKV0aq0CoEqo
 hoxHIKlH1JmZh7RYuZwhWd/yrEyGUv95htotlEy6FbQTzYQwbc5A3moAlDM7B8Cprg35
 A6Og==
X-Forwarded-Encrypted: i=1;
 AFNElJ+8UI8SQ4QQyQfAoF4diRWoGv9kqfynxAncM+FjqYs0sgNfjkxTI8KAJSPB2c1JYUJ32w6UA7FwVIaK@nongnu.org
X-Gm-Message-State: AOJu0YxwtWaI0v3OBuVx7JGv+zo5wc4t/45KuH33960BiqbijCA0J69Z
 G2yoXqXtL62swP6MfoaR+3BuhGzHWFwtMVKVeeYtyOWPy9gibEOHqWKF1cxfIy15rkboYoBIUNG
 1u+JwOtf/WTGvjwlA857ZJ5gT1mWFc4e3rxgfy203odFiUwoMD7jJyxyQ
X-Gm-Gg: Acq92OHJrgFoAShafKznw+EbMqHwoDnk23v9lTF3TOq/OSXwsw6J54ZRzgjGzWLai7M
 C2gKhgJwiCyBm2lwAZG1b4KqDGCLHtugblD4FU8oFEoxUz1+LjBuPcaNpUIqVyK3eKFLROWft9g
 ZbUVV3F7LxZIb/tL/Hv3mP2E/wocNb/JROtA03nGwdzpEMjCSGrLwi9Q9toQtL+6s1ADwDjNix4
 Wc0Ykt2BpvW6m51uMXIreqrr8x45I+QMU4Q0m2rmaIYnpLa9+qQkP9mVInPR6fB1HKmw6mGf5HR
 ekPThgMAaY9bqR8x9kcwQlQrzcNfGOdwcqhXJxD+fH12gbSjRRaT8pbVx0IVdmDVwWesxVy+A4T
 PEz/BKfAuLrunzfmIJIj88+sg6D+paFNrK17vdB/qP5MyIODTtQnc8w==
X-Received: by 2002:a17:907:78a:b0:bee:215e:5480 with SMTP id
 a640c23a62f3a-bfc84a05ccdmr168811566b.9.1781190579689; 
 Thu, 11 Jun 2026 08:09:39 -0700 (PDT)
X-Received: by 2002:a17:907:78a:b0:bee:215e:5480 with SMTP id
 a640c23a62f3a-bfc84a05ccdmr168808266b.9.1781190579106; 
 Thu, 11 Jun 2026 08:09:39 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bfcb0f14759sm80876966b.6.2026.06.11.08.09.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2026 08:09:38 -0700 (PDT)
Date: Thu, 11 Jun 2026 11:09:35 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Gavin Shan <gshan@redhat.com>,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, jugraham@redhat.com,
 shan.gavin@gmail.com, qemu-block@nongnu.org
Subject: Re: [PATCH RFCv1] virtio: Inherit max bounce buffer size from bus
 parent if possible
Message-ID: <20260611110543-mutt-send-email-mst@kernel.org>
References: <20260608001821.850921-1-gshan@redhat.com>
 <20260610041036-mutt-send-email-mst@kernel.org>
 <20260610183046.GB121666@fedora>
 <20260610165710-mutt-send-email-mst@kernel.org>
 <20260611142022.GA202155@fedora>
 <20260611103513-mutt-send-email-mst@kernel.org>
 <CAFEAcA8RAsmrAArKz0X7NU6sCnKTC-e413TgwLp1gt2vJGLgPw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA8RAsmrAArKz0X7NU6sCnKTC-e413TgwLp1gt2vJGLgPw@mail.gmail.com>
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

On Thu, Jun 11, 2026 at 04:04:20PM +0100, Peter Maydell wrote:
> On Thu, 11 Jun 2026 at 15:46, Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Thu, Jun 11, 2026 at 10:20:22AM -0400, Stefan Hajnoczi wrote:
> > > Gavin posted the lspci output:
> > >
> > >   Region 0: Memory at 661ffd000000 (64-bit, prefetchable) [size=16M]
> > >   Region 2: Memory at 662000000000 (64-bit, prefetchable) [size=128G]
> > >   Region 4: Memory at 661ffe000000 (64-bit, prefetchable) [size=32M]
> > >
> > > These are prefetchable memory BARs, so I would expect them to be
> > > mmappable. Why does QEMU have no way of knowing upfront whether they can
> > > be mmapped?
> >
> >
> > They can be mmapped.  The issue is just that after mmap flatview uses
> > memcpy/memmove on them, and that might not match what guest driver is
> > expecting specifically for 1/2/4/8 byte accesses.
> 
> Huh? The guest driver has nothing to do with it, surely.

My answer is I don't know.

But the commit that introduced the regression says:

	 The assumption here is that accesses initiated by the VM are
	    driven by a device specific driver, which knows the device
	    capabilities. 

> The
> problem is that for some PCI devices (like the network card
> mentioned in 4a2e242bbb30's commit message) the BAR is *not*
> safe for arbitrary access (because the actual real host hardware
> inside it is not RAM).

But we don't do arbitrary access. Why would we?

> That commit disabled direct access
> for all vfio MRs, which is safe but overcautious. Would
> "direct access is OK if this is a prefetchable memory BAR" be OK?
> Or do some prefetchable memory BARs still have restrictions
> beyond those of real RAM?
> 
> > Removing mmap is one solution, this is what vfio does now.
> > Fixing flatview is another.
> 
> No, you can't fix this in flatview. If a BAR is not safe for
> direct access then it is not safe for direct access.
> 
> -- PMM

There's no such thing as "not safe for direct access" in PCI.
All operations are memory operations.
What can be unsafe is accesses of specific width and length.

So we should not use variable length memcpy/memmove which
do that. Fixes length memcpy/memmove exactly mimic what
guest does, so they are safe.

-- 
MST


