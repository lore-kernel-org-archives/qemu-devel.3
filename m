Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C4E1606A31E
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Nov 2026 21:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hWn23oRI;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=eX+re51D
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWKs4-0002PJ-W3; Wed, 25 Nov 2026 16:49:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xWKs0-0002Ow-VJ
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 16:49:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xWKry-0006ne-Vd
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 16:49:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795643377;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qeb1uJG6VgqEuNOToaPR5VOfaMGr+zDuu0f8Lq5/O+M=;
 b=hWn23oRInRCa9CBJLwshKkxC+JF+SDcP/dr5x9UVRdIJvjxX3cUpLuRVzUGsZeeaImCudq
 WpHTVKv8W5EFG6WaDlUyxmcLA7kL++/Cj4M2Tj74ZPxFLG4ETJVXmat+c6K8cuw+AGSS3I
 EkvdVX/U4tX6g/XOyNwGTedaCVQbykw=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-505-tjvieKcKNzqPyEQGa34gQw-1; Wed, 25 Nov 2026 21:49:36 +0000
X-MC-Unique: tjvieKcKNzqPyEQGa34gQw-1
X-Mimecast-MFC-AGG-ID: tjvieKcKNzqPyEQGa34gQw_1795643375
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-55dbf67a45dso10965031cf.2
 for <qemu-devel@nongnu.org>; Wed, 25 Nov 2026 13:49:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1795643375; x=1796248175; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=qeb1uJG6VgqEuNOToaPR5VOfaMGr+zDuu0f8Lq5/O+M=;
 b=eX+re51DNsCpl4dGT5n5NM3G9vyPiQd/IzXfyc2j3kpFwVJPlpFDFz1O1f96IVydYx
 COZ+6kDfy3IPWDZucbjXIUajWe1jIjNWjM1/ex74zMat8+LC/mUYA9CGjmOQG0XghBuh
 SUVXNP9dfvmSrEELdRnr32qZAbckCXiYZEFHSQURcMMtgstG56C1woj0y0eLCWlRPeMp
 2664oakZaSlkymYllV48yx7Lma4h28Zumv69C8yAoaDnWKeuFBv3jxFmd7+aAK0+jLsi
 yHWhz08w7yy3UC55Q6QTWn0ROnb8rV2XUKbhiDeBr6zc5lo53t7bzRkiaK6U4p5moR/u
 2aiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795643375; x=1796248175;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=qeb1uJG6VgqEuNOToaPR5VOfaMGr+zDuu0f8Lq5/O+M=;
 b=eVXpka+YbP/MFIibqtZHxD6rmacRHvy84LsGdo1BD4/Y7zqKGLoY74ZjR1WGCfG73s
 08jbt9FeYr+7CvI3mh3c8hz/xopWT32vH1Lqvx1E7fV7FkuF2Jk0p2RSeyqwly0wNblI
 zWw19RsRI2vEADCBc3v4rZwh9yu7DoAGGzFnE0u3T/z05yfds6EUCkCOj183xRr6aO2P
 Y3apoTnEKJc6xfBQEHG/34Jk3eCjuT3L/d4w2hybrENZIgP1eiKe9Pd0Ys2mBaMQN1v+
 lLrjOpFbNbequv/PC1JsYy+SW47kwdB/M+jG8Uq2NVNJLTewUZd0GwMCH9bC7UuBwD8E
 lMqg==
X-Forwarded-Encrypted: i=1;
 AL+hErGGii9r9DNMVzwrf0uMl2s+nCYU7lRCTRk5dVl+XHvANhe1CtN7YGVr+XkL03Wddfitdp7VT14Rjds4@nongnu.org
X-Gm-Message-State: APuU4Z+PCdJOAvUta5oe4P0mRgiccxWepnlQ8u7dzDToWQnh1ySChx4L
 3z9E1y4xn6DJG3t/z38kmHPSDVruJvN/mEORGTFY6HIccDG7u99UObiv2LBiJ8h90pED/Wuux5d
 qfgyMJiJBjKZCxnvd5LbPUidnQKHKpLotX0zfHZHGKcCWZQu0HPIfqa6a
X-Gm-Gg: AZFdTZcytQuBi19+8OEMLICWVn2QVDEwIIeG1hFy2GSjMUmHmnJxAp9Z77GUOqeCBnu
 3BZkOyTWAfw8OnXGLz1osTRNKNxnuJxT0E9RXcsoujfpYDxrdDlCX/MAOH6qYTo+vcpCkojXxBp
 ieYu4iRDHaJ/wTyCgHaC9Dj2vBuc2BKnSSwc+AKNhc0VuAPVu0Aj5p58MLf+1M87vTimxFU74D9
 xWS3iMFd2PT5MEBJuD7GvSLBZc2C5qbfiqNwRo2wIXcg057O9Maac2IwWmHt8FX2pMkfU4SSzkX
 0dsjbTynfghjcMrdNhnjVrf0KrRcCV1H7xIa2NVNzfBM7Vse+VnzoQ5fwsA6j3I2Nesb15V6kQL
 S/MOs1FyFduXiRcY6vneeVR8M+x4Cr4ko81KqESAR+ITG
X-Received: by 2002:a05:622a:312:b0:55b:c839:65a8 with SMTP id
 d75a77b69052e-55d769f4a6emr372459171cf.34.1795643375227; 
 Wed, 25 Nov 2026 13:49:35 -0800 (PST)
X-Received: by 2002:a05:622a:312:b0:55b:c839:65a8 with SMTP id
 d75a77b69052e-55d769f4a6emr372458771cf.34.1795643374646; 
 Wed, 25 Nov 2026 13:49:34 -0800 (PST)
Received: from localhost ([142.188.212.246]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-55d7882bf70sm167472151cf.11.2026.11.25.13.49.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 13:49:33 -0800 (PST)
Date: Wed, 25 Nov 2026 16:49:31 -0500
From: Peter Xu <peterx@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-stable@nongnu.org, Elliot Berman <eberman@anduril.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH-for-11.2?] system/memory: Invalidate TBs on ROM device
 mode switch
Message-ID: <awdX62VmBVeMM3__@zhexu-thinkpadt14gen5.rmtcaon.csb>
References: <20261124182722.78535-1-philmd@oss.qualcomm.com>
 <awXxps0Z4PjS85DT@zhexu-thinkpadt14gen5.rmtcaon.csb>
 <eecb8487-0fca-4028-823d-f70215628f20@oss.qualcomm.com>
 <awbpz7SZ5grn9gyi@zhexu-thinkpadt14gen5.rmtcaon.csb>
 <5cb298ce-7f9b-40fd-b553-879a567e78a5@oss.qualcomm.com>
 <6da6b191-6ec2-49bf-b25d-aeedac071b40@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6da6b191-6ec2-49bf-b25d-aeedac071b40@linaro.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 25, 2026 at 01:00:27PM -0800, Richard Henderson wrote:
> On 11/25/26 11:11, Philippe Mathieu-Daudé wrote:
> > On 25/11/26 14:59, Peter Xu wrote:
> > > On Tue, Nov 24, 2026 at 11:29:15PM +0100, Philippe Mathieu-Daudé wrote:
> > > > On 24/11/26 21:20, Peter Xu wrote:
> > > > > On Tue, Nov 24, 2026 at 07:27:22PM +0100, Philippe Mathieu-Daudé wrote:
> > > > > > A ROM device changes its contents with direct stores while in MMIO
> > > > > > mode. TCG does not see these stores, so translated blocks built from
> > > > > > the old contents survive the switch back to ROMD mode and the guest
> > > > > > executes stale code.
> > > > > > 
> > > > > > Make memory_region_rom_device_set_romd() drop the TBs of the whole
> > > > > > region on both transitions: before leaving ROMD mode (if currently
> > > > > > in it), and after entering ROMD mode, for TBs another vCPU built
> > > > > > before its TLB was flushed.
> > > > > 
> > > > > Pure question: should we flush once, but only when
> > > > > ROMD->MMIO?  Said that,
> > > > > IIUC we need to flush after switching to MMIO to avoid the race you
> > > > > mentioned, that is something like:
> > > > > 
> > > > >     if (mr_is_romd(mr) && romd_mode) {
> > > > >         set_romd(false);
> > > > >         flush();
> > > > >     }
> > > > > 
> > > > > It's based on my limited understanding / assumption that
> > > > > during MMIO state
> > > > > TCG won't be able to cache invalid TB on these regions.
> > > > > 
> > > > > So when switching ROMD->MMIO, invalidated TBs can exist,
> > > > > hence flush only
> > > > > once, after updating romd=false.  When switching back from
> > > > > MMIO- >ROMD, no
> > > > > chance caching anything wrong.
> > > > 
> > > > This doesn't run. Its flush comes after romd is cleared, and
> > > > memory_region_flush_rom_device() asserts that the region is still in
> > > > romd mode. The reproducer aborts with:
> > > > 
> > > > Assertion failed: (memory_region_is_romd(mr)), function
> > > > memory_region_flush_rom_device
> > > 
> > > IIUC that assertion was not required and can be removed, based on its
> > > comment?
> > > 
> > > So my pure question was really about why we need two TB flushes
> > > rather than
> > > one: the pflash changed causing stale TB which I can understand.  What I
> > > suggested was "making sure nobody caches this pflash, then drop all
> > > existing TB" approach, which requries removal of the assertion.  I
> > > assumed
> > > that works, but maybe not really - I tried to read slightly more into TCG
> > > just now and noticed maybe there's yet another layer of caching on TLB so
> > > the stale mapping can still be visible.  Said that, IMO it would be great
> > > if we can explain why two flushes are needed rather than one.  That
> > > means,
> > > if we think the 2nd flush guards everything somehow (including the stale
> > > TLB async work hasn't flushed), then it seems to me we can then drop the
> > > 1st flush (ROMD->MMIO switch).
> > 
> > Wow you are right, having the flush on entering romd, after the contents
> > are written, is what closes the window, and is enough!
> > 
> > -- >8 --
> > diff --git a/system/memory.c b/system/memory.c
> > index 2e3ce773ce97..8e11d42bedce 100644
> > --- a/system/memory.c
> > +++ b/system/memory.c
> > @@ -2252,12 +2252,16 @@ void memory_region_set_nonvolatile(MemoryRegion
> > *mr, bool nonvolatile)
> >   void memory_region_rom_device_set_romd(MemoryRegion *mr, bool romd_mode)
> >   {
> >       if (mr->romd_mode == romd_mode) {
> >           return;
> >       }
> >       memory_region_transaction_begin();
> >       mr->romd_mode = romd_mode;
> >       memory_region_update_pending |= mr->enabled;
> >       memory_region_transaction_commit();
> > +    if (romd_mode) {
> > +        /* Drop TBs another vCPU built from the old contents, once
> > written */
> > +        memory_region_flush_rom_device(mr, 0, memory_region_size(mr));
> > +    }
> >   }
> > ---
> > 
> > Thanks a lot for the review!
> 
> Grepping around accel/tcg/, we're also caching romd in cputlb.  We need to
> flush those entries when exiting romd mode.
> 
> I think that can wait until 12.0 though...

Ah, that might be the "async TLB flush work" I saw when glimpsing over the
code.

I wanted to see if there's a way to synchronously flush it then it should
be doable to flush even during ROMD->MMIO switch once and for all (dropping
assert), but at least at that time I didn't find it for TCG and I was
surprised as I expected synchronous remote TLB flush should be very
commonly used.. so I could have missed something there.

-- 
Peter Xu


