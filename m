Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7158BCD8CB2
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 12:28:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXI25-0003HI-NU; Wed, 10 Jun 2026 08:27:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wXI24-0003H6-EA
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 08:27:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wXI22-0001Vc-QS
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 08:27:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781094462;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hSA2smhwNodqmefhsiCqcnWJwstPWSmyVQv/YhsnzW8=;
 b=MLxX0E1Ivuzmal16FRW+fCMSPB4oWxf3Sgj/u3B/oXDxTZgwWlsktq+HA3OoqIA348RKBp
 1vjwJSCARMH3aFoqibsxvfW3vrsu4pacW9ZXDQ8GF6b6SktjffRcYxhih4uIJQ5GcIngF/
 pTtahG8/ARkTCB1S6O9oihzEw6melFY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-584-OgdNEA0pM9O2oNurYTSHpw-1; Wed, 10 Jun 2026 08:27:35 -0400
X-MC-Unique: OgdNEA0pM9O2oNurYTSHpw-1
X-Mimecast-MFC-AGG-ID: OgdNEA0pM9O2oNurYTSHpw_1781094454
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-490aadb1386so35245395e9.0
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 05:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781094454; x=1781699254; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=hSA2smhwNodqmefhsiCqcnWJwstPWSmyVQv/YhsnzW8=;
 b=n39seaWHZBtT0LXriRLjl82AHFl6WMaX4BRotU7Wbkwc7mJvc1uJd8d2b3gMjZDCfs
 qbaW/mvHFfkCdTeKrAOCUngWVb/x4hj7DJxEhSmqijv9MtZfbt8nI8iy/VUP8oM9XVfw
 Co8UdF5EfQ7odcs6sDo824oFD2DlmOZtrWx8mY/Qbrf6jfuOQevk1OYzRLaD+YZVuFux
 gvPi4KtRVVxrwJ4j8pYbu6W65KphKII+7crdqo0wpiz80WP5HCjvpu6VHzTXRddf2ToX
 5GlePjrJeDuRLmD4i2oXbE81/ynvj9/sPecUvHuOBuxCoU1K7tBKM7Sz2QHOJoZ7EVzT
 H3tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781094454; x=1781699254;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hSA2smhwNodqmefhsiCqcnWJwstPWSmyVQv/YhsnzW8=;
 b=nThz0ZVMlpsOnO4Tdq9XHshKoseWdP/fh11AWbU5hlqvJdJ/XqqVeqGSnbI+nO2/cC
 l77yHh0rvWZ0P1gXutmzVtogBWOJmNFl8uGLi8TF4p3vUpnn3yp1mE+oo+c0ugNl+P+i
 PPck2/cj8d5177THfUTIsbaLoeaB5+GFsisAkzGxGaNtfLi2Eeq5BrYxOkgIJ/AFV8X4
 JF+GGEqyQC2feCqoCOZS/9+swT38xYTzZ/Ql0ZFEEtrfvQq3OhBc4uNWdnCNqGU1Vkni
 udpdi8uydnGBSNUZyyj+zTlCGcIWyvkT/n4cML2IwnRhGR1i9/4Q5i0GROSNVUXtbLKJ
 frcQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/DdHo5Cvp5LgwsWVqDBTyqd9wtIUqHDpIb4zqY3iukauWaGnGNEPv55k5yRMD8PuIhKfxiEf0lbEUX@nongnu.org
X-Gm-Message-State: AOJu0YxtU9FjkmffJ4cJcm/O22XlA0JAuRidJu4Ke4HxdMlZbKNxFBgg
 jWl7PqMnEKkC5wBlKLG7fCtzUtcY3S3rbaC9duzeUO0uJWrtnbJ/YBcNFk+dILHwU0548+YOxp4
 2lf3fPHWdp2N7/sm+xTbF2FyV0yziC1rJJOgFJKpu6GM5y8bSB5sD6Rq+
X-Gm-Gg: Acq92OHlNg0EYDQSByphM/qZg+Yu6DkIxwkENeDaHxDmSRsxWdIvOvxAWy9sqOMgV7J
 HBtg4u5JXdbcryu0DFxEtbV7ilSHrfUqTLtsq3tz5kQMxACMdJq8rnbyZASG1ZKhjkR78whxKbu
 U6zM8OtHPxyoVIo476vOvECyTUjsgoLn2SeihGVWvvJB5A2Dzm8aXlcCHCjx7N+Ddebe16SslOT
 qJ7QLmzWAr4G3GuW8mwhcfQcH3gfu2FGuoIdmP2wz96ebd3GDESE3kfo/+idWhgyszNFzBwwD2Q
 QAzIZkHly6GDQY2ErbuNWVA/j7b1kM4BjxzD9Ws8anKjEbU2TyfI8IZqtaq9MEsiJks4tild7PY
 ZF9C9GgskQxbegcKNKOihbqdceuIWT84mqnC5ub/OgDM2ruZfSUjkSw==
X-Received: by 2002:a05:600c:34d2:b0:48f:e230:29f4 with SMTP id
 5b1f17b1804b1-490c2d1fb35mr342803375e9.15.1781094453946; 
 Wed, 10 Jun 2026 05:27:33 -0700 (PDT)
X-Received: by 2002:a05:600c:34d2:b0:48f:e230:29f4 with SMTP id
 5b1f17b1804b1-490c2d1fb35mr342802855e9.15.1781094453420; 
 Wed, 10 Jun 2026 05:27:33 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490dc47d4e0sm63448975e9.0.2026.06.10.05.27.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 05:27:32 -0700 (PDT)
Date: Wed, 10 Jun 2026 08:27:29 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Gavin Shan <gshan@redhat.com>
Cc: Pavel Hrdina <phrdina@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, jugraham@redhat.com, shan.gavin@gmail.com
Subject: Re: [PATCH RFCv1] virtio: Inherit max bounce buffer size from bus
 parent if possible
Message-ID: <20260610082637-mutt-send-email-mst@kernel.org>
References: <20260608001821.850921-1-gshan@redhat.com>
 <aiaDgG26a6TUrKuM@redhat.com>
 <07ca74b4-52a8-4187-a57c-7c3277e574d3@redhat.com>
 <aiky9d9IwACIyKEC@phrdina-thinkpadt14gen4.rmtcz.csb>
 <674d5e21-88fa-4a10-a83c-eb6f7ce7032f@redhat.com>
 <20260610080947-mutt-send-email-mst@kernel.org>
 <eb0f0da1-11dd-4437-94fd-a65af55851e1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eb0f0da1-11dd-4437-94fd-a65af55851e1@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Jun 10, 2026 at 10:19:31PM +1000, Gavin Shan wrote:
> Hi Michael,
> 
> On 6/10/26 10:12 PM, Michael S. Tsirkin wrote:
> > On Wed, Jun 10, 2026 at 08:55:10PM +1000, Gavin Shan wrote:
> > > On 6/10/26 7:54 PM, Pavel Hrdina wrote:
> 
> [...]
> 
> > > > 
> > > > You did not answer the question that Daniel was asking, how will user
> > > > know that max-bounce-buffer-size should be used if it's necessary to fix
> > > > guest system hangs and how will user know what magic value should be set?
> > > > 
> > > 
> > > Sorry that I missed to answer Daniel's questions. For this specific case,
> > > user need to enlarge the bounce buffer size when seeing the following error
> > > message. We can add an explicit one in address_space_map() if the existing
> > > error message isn't obvious.
> > > 
> > >    qemu-system-aarch64: virtio: bogus descriptor or out of resources
> > > 
> > >    void *address_space_map(AddressSpace *as,
> > >                          hwaddr addr,
> > >                          hwaddr *plen,
> > >                          bool is_write,
> > >                          MemTxAttrs attrs)
> > >    {
> > >        if (!memory_access_is_direct(mr, is_write, attrs)) {
> > >            if (l == 0) {
> > >                error_report("Running out of bounce buffer size , enlarge it with max-bounce-buffer-size");
> > >                *plen = 0;
> > >                return NULL;
> > >            }
> > >        }
> > > 
> > > As to the value user should take for max-bounce-buffer-size, it is really case by case
> > > and decided by user. User needs to try 4096, 8192, ..., 0xFFFFFFFF to figure out the
> > > smallest value works for them. The worst case is to set 0xFFFFFFFF.
> > > 
> > 
> > 
> > This is not at all reasonable. All kind of fixes are possible but
> > fundamentally, bounce buffering data path is by itself already a
> > bad idea.
> > 
> > I have no idea what does bounce buffering device ram accomplish.
> > 
> > In the end, qemu still simply reads the memory from/to the buffer.
> > 
> > My suggestion is to first of all look for ways to mark the
> > memory as direct.
> > 
> 
> As I explained to Peter Xu in another reply, we can't simply mark the (RAM
> DEVICE) memory region is directly accessible. The memory region is initialized
> by memory_region_init_ram_device_ptr() in hw/vfio/region.c::vfio_region_mmap().
> 
> The  accesses to the memory region is handled by 'ram_device_mem_ops' where
> {ldn, stn}_he_p() are used in its read/write handler. They're different
> from memcpy() since the data endianness is well handled in {ldn, stn}_he_p().
> 
> Thanks,
> Gavin
> 

What is endianness set to, for this region?


