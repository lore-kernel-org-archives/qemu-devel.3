Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A016BFF5134
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2026 19:34:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wABUC-0005eJ-7V; Tue, 07 Apr 2026 14:49:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wABSZ-0003Pl-Kb
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 14:47:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wA8CO-0002Gh-HN
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 11:18:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775575118;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=08CEGWkn9PA5TdbEvfzmdCL/uM89wxifjdh0E8COvQs=;
 b=O7XKvQpxlhBggEi8hp8RsqYOeoWpKezAyszZXIPAcYlSupyjRvSvInBwOuEcZb3NuAvpMX
 BTh9qZZjdPIWYzln4tNQaF3dkFzIFY1eSFQ1Z1oeyj0N2/ndcvBlfR3q9eJw/KLkrOMc8P
 ZtEw4pxKD/dzPLEhdcr+yS7ybe0pH+g=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-398-VqbERtyWPxqOSQdpEzp31w-1; Tue, 07 Apr 2026 11:18:37 -0400
X-MC-Unique: VqbERtyWPxqOSQdpEzp31w-1
X-Mimecast-MFC-AGG-ID: VqbERtyWPxqOSQdpEzp31w_1775575116
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-8d5010ea6b5so830863985a.0
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2026 08:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1775575116; x=1776179916; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=08CEGWkn9PA5TdbEvfzmdCL/uM89wxifjdh0E8COvQs=;
 b=hW7DGw0GRbccAcoU6ZSUzvxZ/CQ9a4pW6x2PDTVAuu0Kp6lsuXYxPdGR3EaEq40Qfh
 7ijSdBFEULC9a3tYGEjYxqNeVEDdRMYc6lqqfY3a6+CCyWUIq42kbaNCVLLLivX99eAc
 XBP5qjhAIGGHCzLHhbCoKFqaKnxolxeFTZGfcJAVXzr5S4XSa9a77dtjvl2xy2Nkbz6Q
 jKJI326HdkCY5t+1TkFxX++BQOgC1UgIFJX4/Oyca+8bWvFMmUzubDUVwm8XA4f6kpIv
 tGoW7YbehftodoKeoX2aIjgKqrXs4p/3DJYZRhIJO7zmjFZlhgFLYKaEY+Ls7QIO2J3J
 U57A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775575116; x=1776179916;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=08CEGWkn9PA5TdbEvfzmdCL/uM89wxifjdh0E8COvQs=;
 b=f6OLVrlKz0c9pWQqiL3nxnl0CYUlP9NGwZiJMXyMZWSp9MoAQqxGZmQmF3tobHbq0c
 zzGNQsjuP5gl3fqaJk7N/N7QJNYt9W3VnPl0z/KAq60gW0dgrc4ZIvhPglOiRNKmrZ8+
 tvHi798bn0pQW/yzObfHQrQX2gGDOwexlA1Byet//fSCFTH2r0V+fflxz4CcQd0WWmP2
 xzbLLnhbNkMzIkM2QjSDa6Mi49yCk3M/lp0znPvXTa1ecrnhSgvJuv61et7vZCeHklav
 hhSvqxF+NVj+cKARqIGmh1/j9RP0SN7WK9s4aieAJ5fBy9ZauFRMmhAV4X+PZmGFD8Zr
 rM0A==
X-Gm-Message-State: AOJu0YwAsNjDcdOlFHyxXPy0UjONQsVCuxGYpxlfx5x8uKZELdGVD2H/
 zSLL0ZpyaLun00PIsrsyePOOrUYj8qWeigwBoF0x1II2jt0at7ho2ATBzwQAYVin4rUZDzdNj4E
 1Hp2hAFRjRuUE1chk+eyKPoNWcHSnjKm/MjKkKzTmjEQXWYFom64nAX5i
X-Gm-Gg: AeBDietO2M7dsqFCAwfBMRiiVkxO4wcloViBH0hFD0/XEnSQS6FG4/mQAEVCNzAL3G5
 N+TZY282LeeSzABINy9l7SNXm/xkeD5e9oAFZ3V5sjo3jyoTz8H9xGAuaCOPKiMHmpWpLZN3QoT
 1iM/PbhnkgiemTo0RYDoEtl+Pionv3cZoJlsjDMHXzQHDk+GfbUqBAzTXjW/GIT3AUl1OGUtylT
 SF3uCFOS2LL/chIxXqr3EzNEmdz5FKWlriu0Swyvmtyg1He3NhBQj+XjbzDAIBUM+HdXrCeeBGv
 Mr7nbCY8mxigBX6wYcUVg3fOkA5cOhHymmt5W/EUds18RVst8yYQaP5XL24yDXYC/Evp2y7oEEE
 rV4hh3QI9lX/Z2qCTryB/vjrJOsW1IFRO0Nf3WabRR5jzJ3A=
X-Received: by 2002:a05:620a:1995:b0:8cd:b2e9:7f6f with SMTP id
 af79cd13be357-8d41db51383mr2364170785a.33.1775575116319; 
 Tue, 07 Apr 2026 08:18:36 -0700 (PDT)
X-Received: by 2002:a05:620a:1995:b0:8cd:b2e9:7f6f with SMTP id
 af79cd13be357-8d41db51383mr2364160885a.33.1775575115618; 
 Tue, 07 Apr 2026 08:18:35 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8d2a5c5fe8esm1343894385a.16.2026.04.07.08.18.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Apr 2026 08:18:35 -0700 (PDT)
Date: Tue, 7 Apr 2026 11:18:33 -0400
From: Peter Xu <peterx@redhat.com>
To: Avihai Horon <avihaih@nvidia.com>
Cc: qemu-devel@nongnu.org, Juraj Marcin <jmarcin@redhat.com>,
 Kirti Wankhede <kwankhede@nvidia.com>,
 "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Joao Martins <joao.m.martins@oracle.com>,
 Alex Williamson <alex@shazbot.org>,
 Yishai Hadas <yishaih@nvidia.com>, Fabiano Rosas <farosas@suse.de>,
 Pranav Tyagi <prtyagi@redhat.com>, Zhiyi Guo <zhguo@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Subject: Re: [PATCH RFC 03/12] vfio/migration: Throttle vfio_save_block() on
 data size to read
Message-ID: <adUgSfBxal6TSzqw@x1.local>
References: <20260319231302.123135-1-peterx@redhat.com>
 <20260319231302.123135-4-peterx@redhat.com>
 <d075580a-ad4f-4047-b012-e5d9e4d6bc80@nvidia.com>
 <ac2B3VF8CSu3ytEE@x1.local>
 <dc9e5884-c532-43e6-813d-e302a3cd970b@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <dc9e5884-c532-43e6-813d-e302a3cd970b@nvidia.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Mon, Apr 06, 2026 at 02:21:40PM +0300, Avihai Horon wrote:
> 
> On 4/1/2026 11:36 PM, Peter Xu wrote:
> > External email: Use caution opening links or attachments
> > 
> > 
> > On Wed, Mar 25, 2026 at 04:10:14PM +0200, Avihai Horon wrote:
> > > Hi Peter,
> > Avihai,
> > 
> > > Thanks for sending this series.
> > Thanks for taking a look.
> > 
> > > On 3/20/2026 1:12 AM, Peter Xu wrote:
> > > > External email: Use caution opening links or attachments
> > > > 
> > > > 
> > > > During precopy phase, VFIO maintains two counters for init/dirty data
> > > > tracking for query estimations.
> > > > 
> > > > VFIO fetches data during precopy by reading from the VFIO fd, after
> > > > fetching it'll deduct the read size.
> > > > 
> > > > Here since the fd's size can dynamically change, I think it means VFIO may
> > > > read more than what it "thought" were there for fetching.
> > > > 
> > > > I highly suspect it's also relevant to a weird case in the function of
> > > > vfio_update_estimated_pending_data(), where when VFIO reads 0 from the FD
> > > > it will _reset_ the two counters, instead of asserting both of them being
> > > > zeros, which looks pretty hackish.
> > > > 
> > > > Just guarantee it from userspace level that VFIO won't read more than what
> > > > it expects for now.
> > > The VFIO_MIG_GET_PRECOPY_INFO ioctl returns an estimation of the data size
> > > currently available for reading. So, even if the ioctl returns X bytes, it
> > > may be that there are more than X bytes to read or less than X bytes.
> > > The code was written in a flexible way to handle such discrepancies.
> > > 
> > > Because we are dealing with an estimation, I don't think we can assert that
> > > the counters are zero, and I don't think reading only up to the cached size
> > > gives us any benefit:
> > > If the estimation is lower than actual available data, we are just deferring
> > > sending of the remaining data to a later stage.
> > Since we'll introduce cached size, having the read() only happen with the
> > size reported still makes sense to me.
> > 
> > We're not deferring to later that much, when dirty data reaches zero, we'll
> > re-sync with everything including VFIO's VFIO_MIG_GET_PRECOPY_INFO.  So
> > it's just splitting one last-phase read() into two smaller read()s.  To me,
> > it sounds still OK if with that we can make sure the counter won't overflow.
> 
> The counter doesn't overflow today as well (thanks to the MIN calculation).
> 
> > 
> > > If the estimation is higher than actual available data, we may still read()
> > > zero when the cached values are not zero.
> > > 
> > > I think we should keep the code as is.
> > > 
> > > Does that make sense?
> > I can understand what got reported in VFIO_MIG_GET_PRECOPY_INFO may not be
> > the total size of dirty data, but what the userapp can read.  That part is
> > fine.
> > 
> > Now, do you mean the size reported could shrink as well?
> 
> Yes.
> 
> >    Could you explain
> > why, and when, dirtied data size can shrink?
> 
> First of all, the sizes of VFIO_MIG_GET_PRECOPY_INFO are defined as an
> estimation, so anything can be reported there.
> 
> But specifically for mlx5, VFIO_MIG_GET_PRECOPY_INFO includes two steps -
> query and save: first, the driver queries the device for the *expected*
> amount of data (that's the returned init/dirty sizes) and then the driver
> async-ly saves the data.
> The query returns the *expected* amount of data, but the actual data
> returned in the save may be smaller.
> 
> Regarding VFIO_DEVICE_FEATURE_MIG_DATA_SIZE , I don't have a concrete
> example of data "shrink".
> But I can think of a device that all its data is precopy-able and
> VFIO_DEVICE_FEATURE_MIG_DATA_SIZE may return X data remaining while actual
> data is smaller than X, simply because the uAPI defines that it's an
> estimate.
> 
> What I am trying to say is that VFIO_MIG_GET_PRECOPY_INFO and
> VFIO_DEVICE_FEATURE_MIG_DATA_SIZE sizes are estimates which are good enough
> for telling QEMU how much data is remaining, but shouldn't be used to make
> precise calculations on how much to read(). At least I don't see the benefit
> from it.

If it can shrink too, then yes, there's no point.

I think what I'll do is assuming both ioctls can report anything (including
garbage.. which sadly also follows the API definition), then make sure it
keeps working and make the best use of estimations based on them.

Thanks for the answers.

-- 
Peter Xu


