Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82C4AE8785A
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 19:07:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnLjT-0001Aw-9M; Tue, 03 Feb 2026 14:06:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vnLjR-0001AS-Qw
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 14:06:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vnLjP-00038s-2S
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 14:06:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770145592;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Dpi1fAKX9oUohLhbdHmU428yqMvlA1Nr+Fea/q0NGEo=;
 b=TZGia3M0LvF77G4CxLqkENJpEcDEZeT6qnRPtmoKc9KorzwegduZw3U5MFwSnyscKoFTqC
 BD54nml8tIRz47+Z1+UBBlcyqbH7ofVgUEJIGA4W20aOqkGQhHNJKURNU0mqlvArcqIapN
 HJJ62M7HVsf0Y09kQtoQC7tZdueMINw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-492-ZFDd-2hVPei4AgpZHIQ1NQ-1; Tue, 03 Feb 2026 14:06:31 -0500
X-MC-Unique: ZFDd-2hVPei4AgpZHIQ1NQ-1
X-Mimecast-MFC-AGG-ID: ZFDd-2hVPei4AgpZHIQ1NQ_1770145590
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-47ee432070aso48121995e9.1
 for <qemu-devel@nongnu.org>; Tue, 03 Feb 2026 11:06:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770145590; x=1770750390; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Dpi1fAKX9oUohLhbdHmU428yqMvlA1Nr+Fea/q0NGEo=;
 b=uLMEFtxAPn6gYYSrNAx+w70fInAbaS+056a4XdJluh/n0TB5EDmvp1xF4R0tme9qxV
 PsfhrgYV5cj55dBmmvx3QinhyOnZnPZVxHDPHfTgSUvJHI4XjCsqK2nmWUxwlVF1l9pO
 5CgW/VukgGfaEaYyXhfXFkN/w7oZvvkgBC+rnkqYUQFIHZhHYLFyw0CNyOeGWxEcnKxE
 PCq5JtsCMfBSssKygUBNTFeu/xtNghVRTqGzv7jVi5RUOMhrUfAb/kRll5iLE4Js4MnY
 aBpUxIuLg3/ZLjUcd5VzhCkZMI1V+68tb5YWy/FtTXSnZq3GtUQsd12fH3ym9UzXk5rh
 3qdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770145590; x=1770750390;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Dpi1fAKX9oUohLhbdHmU428yqMvlA1Nr+Fea/q0NGEo=;
 b=OSx9LXNjfl4YlICQ8VwvL7mEGXkE9WxI7sYP9bMRajvW3v8QWj3w38zAKAlLO5xN+o
 czJQLnHmHFU5ZhCuTz1aVX3XVpKR9ATOo9Tcn/U0kbxJAuEpv13XPu/zdzQ3LHQd8F/S
 rwBUP8rSILMuMxXG06hRi35lX9PcJORBCUKnHuLUWe/N/aZWr6MQ+1U+n/HP6hqc3YOj
 SQR3vfuk4HI+41OWGop9d3SgYoSMlxPAqlwxg9MPHws6ckRUA8dIXJe6wtTNagI4tyGI
 F2ez3NcHTHyJiPC5PdNEuNwE2yw0Y+s4DDS95zYb47xTYwYYVztwr1wjVnAHV2xdOMV6
 aZMA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXB6tOTtv28MN4bUA5JUxoHJ3h8e6tGnJwiiYw3NgXgZ4hD9gOvWdoXANcBeeW8CCe29XW/zOw2uUAx@nongnu.org
X-Gm-Message-State: AOJu0YyTdUU/ihP0dvVTqJzICUbf3aoXIS65QJn/yigVCplpm+lwkZBk
 LglTAM8/B/+MO8gOCjAUO6QXPAxcT323JsY+4/O2fb+jZVlu7B908fbGl2k1/fcBNFsDvUsp/Sn
 ENF3oClO2FhMuL1N9q3R9dmRHmegFhWWEtaPqBCH7w2hADwu8D9GHyac2
X-Gm-Gg: AZuq6aLiXU0Zz774zIJG9xKV9UmwomyXkjYcZWQSfIO7LCEwXENMyU84h/XPBwNnPCC
 iWxHi0eCm+FQbTpLfxhPYneUQt6nKavjJGzWskR2mwO7Y9m+jLnXGPT/dVkOwugKoyiLZJSJuPf
 iN8ne6ScKU2NIJ7h5yD1eThlenmoUtqb4iH9nWJN0YEUFpLWAaJWifM2chkYFijQCV+/kYNvpHL
 S5Hm0MJs982jm26ksi2AgvwZPzY62LXZ6jloHd4G9ACFysJlDERVueeCH9lLjQgTaMDh+HLXoj3
 q6swTDidKIbJ2CRFF2SmDal+hhBO8Awn0Sgc0Yzhq63zW5C21yi6aSA2mFGE3RLnWHM+COVWLv6
 IVA/bbtLsndTKVwo8BTf2qtzOJ/sOhEOL+Q==
X-Received: by 2002:a05:600c:3555:b0:477:9b35:3e49 with SMTP id
 5b1f17b1804b1-4830e93e9eamr10936585e9.3.1770145589871; 
 Tue, 03 Feb 2026 11:06:29 -0800 (PST)
X-Received: by 2002:a05:600c:3555:b0:477:9b35:3e49 with SMTP id
 5b1f17b1804b1-4830e93e9eamr10936225e9.3.1770145589441; 
 Tue, 03 Feb 2026 11:06:29 -0800 (PST)
Received: from redhat.com (IGLD-80-230-34-155.inter.net.il. [80.230.34.155])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4830515381esm85519285e9.11.2026.02.03.11.06.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Feb 2026 11:06:28 -0800 (PST)
Date: Tue, 3 Feb 2026 14:06:25 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Subject: Re: [PATCH v3 04/11] hw/virtio: Use
 VirtIODevice::access_is_big_endian field
Message-ID: <20260203140109-mutt-send-email-mst@kernel.org>
References: <20260201232924.93399-1-philmd@linaro.org>
 <20260201232924.93399-5-philmd@linaro.org>
 <20260202024316-mutt-send-email-mst@kernel.org>
 <87bji7pa2e.fsf@draig.linaro.org>
 <20260202105847-mutt-send-email-mst@kernel.org>
 <20260202185233.GC405548@fedora>
 <1c0fc67a-1ded-4200-b9d0-e20a06cb5b4b@linaro.org>
 <1804511f-a048-4eb8-9cf3-1c75bdf4b277@linaro.org>
 <20260203055247-mutt-send-email-mst@kernel.org>
 <2426d548-2c6f-4bef-9c30-efb97dcc69dd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2426d548-2c6f-4bef-9c30-efb97dcc69dd@linaro.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, Feb 03, 2026 at 09:31:04AM -0800, Pierrick Bouvier wrote:
> On 2/3/26 3:07 AM, Michael S. Tsirkin wrote:
> > On Mon, Feb 02, 2026 at 07:22:16PM -0800, Pierrick Bouvier wrote:
> > > On 2/2/26 11:25 AM, Pierrick Bouvier wrote:
> > > > On 2/2/26 10:52 AM, Stefan Hajnoczi wrote:
> > > > > 
> > > > > This command-line lets you benchmark virtio-blk without actual I/O
> > > > > slowing down the request processing:
> > > > > 
> > > > >      qemu-system-x86_64 \
> > > > >          -M accel=kvm \
> > > > >          -cpu host \
> > > > >          -m 4G \
> > > > >          --blockdev file,node-name=drive0,filename=boot.img,cache.direct=on,aio=native \
> > > > >          --blockdev null-co,node-name=drive1,size=$((10 * 1024 * 1024 * 1024)) \
> > > > >          --object iothread,id=iothread0 \
> > > > >          --device virtio-blk-pci,drive=drive0,iothread=iothread0 \
> > > > >          --device virtio-blk-pci,drive=drive1,iothread=iothread0
> > > > > 
> > > > > Here is a fio command-line for 4 KiB random reads:
> > > > > 
> > > > >      fio \
> > > > >          --ioengine=libaio \
> > > > >          --direct=1 \
> > > > >          --runtime=30 \
> > > > >          --ramp_time=10 \
> > > > >          --rw=randread \
> > > > >          --bs=4k \
> > > > >          --iodepth=128 \
> > > > >          --filename=/dev/vdb \
> > > > >          --name=randread
> > > > > 
> > > > > This is just a single vCPU, but it should be enough to see if there is
> > > > > any difference in I/O Operations Per Second (IOPS) or efficiency
> > > > > (IOPS/CPU utilization).
> > > > > 
> > > > Thanks very much for the info Stefan. I didn't even know null-co
> > > > blockdev, so it definitely would have taken some time to find all this.
> > > > 
> > > > For what it's worth, I automated the benchmark here (need podman for
> > > > build), so it can be reused for future changes:
> > > > https://github.com/pbo-linaro/qemu-linux-stack/tree/x86_64_io_benchmark
> > > > 
> > > > ./build.sh && ./run.sh path/to/qemu-system-x86_64
> > > > 
> > > > My initial testing showed a 50% slow down, which was more than
> > > > surprising. After profiling, the extra time is spent here:
> > > > https://github.com/qemu/qemu/blob/587f4a1805c83a4e1d59dd43cb14e0a834843d1d/target-info.c#L30
> > > > 
> > > > When we merged target-info, there have been several versions over a long
> > > > time, and I was 100% sure we were updating the target_info structure,
> > > > instead of reparsing the target_name every time. Unfortunately, that's
> > > > not the case. I'll fix that.
> > > > 
> > > > With that fix, there is no difference in performance (<1%).
> > > > 
> > > > I'll respin a v4 with the target info fix, initial v1 changes and
> > > > benchmark results.
> > > > 
> > > > Thanks for pointing the performance issue, there was one for sure.
> > > > 
> > > > Regards,
> > > > Pierrick
> > > 
> > > After proper benchmarking, I get those results (in kIOPS) over 20 runs, all
> > > including target_arch fix I mentioned.
> > > 
> > > reference: mean=239.2 var=12.16
> > > v1: mean=232.2 var=37.06
> > > v4-wip (optimized virtio_access_is_big_endian): mean=235.05 var=18.64
> > > 
> > > So basically, we have a 1.7% performance hit on a torture benchmark.
> > > Is that acceptable for you, or should we dig more?
> > > 
> > > Regards,
> > > Pierrick
> > 
> > Could we use some kind of linker trick?
> > Split just the ring manipulation code from
> > virtio.c and keep it target specific.
> > 
> 
> While it would allow to extract the common part, unfortunately, as long as
> we keep a target specific part, we still have a problem to solve.
>
>
> Indeed, some symbols (may be ring manipulation code, or just functions
> mentioned below) will still be duplicated, and in the end, when we'll link
> two targets needing different versions, we'll have a conflict.

Shrug. The generic slower one can be made stronger and be used then.
This is not an new or unsolveable problem.


> Since our goal for a single-binary is to have at least arm and another base
> architecture, we are in this situation now.
> 
> So the only solutions left are:
> - accept the 1.7% regression, and we can provide more "real world"
> benchmarks to show that it gets absorbed in all existing layers
> - compute virtio_access_is_big_endian once and reuse this everywhere: that's
> what Philippe implemented in his patches.
> 
> What would you prefer?


Let's find a way where people who are not interested in a single binary
do not have to pay the price, please.

> > 
> > Or it could be that even just these two would be enough:
> > 
> > static inline uint16_t virtio_lduw_phys_cached(VirtIODevice *vdev,
> >                                                 MemoryRegionCache *cache,
> >                                                 hwaddr pa)
> > {
> >      if (virtio_access_is_big_endian(vdev)) {
> >          return lduw_be_phys_cached(cache, pa);
> >      }
> >      return lduw_le_phys_cached(cache, pa);
> > }
> > 
> > static inline void virtio_stw_phys_cached(VirtIODevice *vdev,
> >                                            MemoryRegionCache *cache,
> >                                            hwaddr pa, uint16_t value)
> > {
> >      if (virtio_access_is_big_endian(vdev)) {
> >          stw_be_phys_cached(cache, pa, value);
> >      } else {
> >          stw_le_phys_cached(cache, pa, value);
> >      }
> > }
> > 
> > 
> > 
> > 
> > 
> > 
> 
> Regards,
> Pierrick


