Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A4F6ECE564
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 13:56:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1so1Lw-0006cP-3X; Tue, 10 Sep 2024 09:56:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1so1Lt-0006bn-0A
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 09:56:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1so1Lr-0005Le-BZ
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 09:56:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725976574;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=spqhTNVJHhEhdKNaoWNom/Wy0L3Nm7AzxOZR3GPa0jc=;
 b=E1tv8hZxXXvkkmRKhhlhsoebT3FVUqycYBBr5GNLQMGBnhM9D5Zi4aWyZWLHEGP5yBUjkM
 vpZAnGqjnSlCU3hBYrMTiV4tSx530IRUWd4aFB9iCNy4aBBEqVgHiXrxXpctHHLft80MtR
 Bk1hflFYSDJP8qZFVp0m/eIdoK05ASI=
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com
 [209.85.221.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-454-Ui3fjwUwPJW1yLOqas-ixg-1; Tue, 10 Sep 2024 09:56:11 -0400
X-MC-Unique: Ui3fjwUwPJW1yLOqas-ixg-1
Received: by mail-vk1-f199.google.com with SMTP id
 71dfb90a1353d-501061b4a41so1701294e0c.0
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 06:56:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725976570; x=1726581370;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=spqhTNVJHhEhdKNaoWNom/Wy0L3Nm7AzxOZR3GPa0jc=;
 b=ej1MOOLcuPlxHkaxENxVR6Er7WIQcmyFKts6wFcBtNuayNVmSK0bKbXkbpS0mHfV4T
 IyA7CRFN8Lpvlp4pFf8jgyZy21OVkaroWkLAggrQDUj/ZDogXzkqJ6/YcTZlIIl73s8J
 acpcSUFu8elnwIEwaMFLEhjBqRjEHYhjOvi4mtQwXxyI48T9oO7yFgiif4tbDdcB1tvX
 PAU2SwdEqPApxYo9tNFXq+nQj0YCp20l0aDgvzjWK0C7hkuzFErkjyQJ7Et9FUTSTiPg
 Xk4nXcgxZYSXJhZE+zfEOlqlToiAR5NippzCSp2QD++Xf2q3KZtBeTz08WzFk3LjrZs3
 oxwg==
X-Gm-Message-State: AOJu0YxhBhKp2qGklRFr6u/1tCxY2LKnMC9gCDrxNv/OcSMNS2+3lF0v
 m9vdo/v6DBd25WEqoPabuADmJW7fK9lcBLw9iJnkLuWBFAoOqArjkCbOzvaFS6tBb0bNwJDHOTF
 ozn4RC9nThSo3cmvXC6TpCTNxjcmWsAF/9SDHfkdR4of7t4SpvQxy
X-Received: by 2002:a05:6122:3282:b0:4f5:abe4:50e2 with SMTP id
 71dfb90a1353d-50207c69ffdmr15737594e0c.6.1725976570476; 
 Tue, 10 Sep 2024 06:56:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHThpWTJWnOIKO7aFwx1fq8deA8VX8wZBP4O4RSgGD7/Z5hjdVEUWJoldgt5fkbX7uzOGaw/g==
X-Received: by 2002:a05:6122:3282:b0:4f5:abe4:50e2 with SMTP id
 71dfb90a1353d-50207c69ffdmr15737557e0c.6.1725976570078; 
 Tue, 10 Sep 2024 06:56:10 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6c534786c12sm29928886d6.146.2024.09.10.06.56.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2024 06:56:09 -0700 (PDT)
Date: Tue, 10 Sep 2024 09:56:07 -0400
From: Peter Xu <peterx@redhat.com>
To: Yong Huang <yong.huang@smartx.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH RESEND RFC 03/10] qapi/migration: Introduce periodic CPU
 throttling parameters
Message-ID: <ZuBP90uSWiJWXTgQ@x1n>
References: <cover.1725891841.git.yong.huang@smartx.com>
 <0bbcdfd86f35830e0a398220663aac5afd8b7e1e.1725891841.git.yong.huang@smartx.com>
 <Zt9o5r1ZWOxnjctC@x1n>
 <CAK9dgma+kmV=sXPu-RUnT8mkQmRUJXRRkiDXfFDoT+6JBu-nHw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK9dgma+kmV=sXPu-RUnT8mkQmRUJXRRkiDXfFDoT+6JBu-nHw@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
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

On Tue, Sep 10, 2024 at 01:47:04PM +0800, Yong Huang wrote:
> On Tue, Sep 10, 2024 at 5:30 AM Peter Xu <peterx@redhat.com> wrote:
> 
> > On Mon, Sep 09, 2024 at 10:25:36PM +0800, Hyman Huang wrote:
> > > To activate the periodic CPU throttleing feature, introduce
> > > the cpu-periodic-throttle.
> > >
> > > To control the frequency of throttling, introduce the
> > > cpu-periodic-throttle-interval.
> > >
> > > Signed-off-by: Hyman Huang <yong.huang@smartx.com>
> >
> > Considering that I would still suggest postcopy over auto-converge, IMO we
> >
> 
> We are considering the hybrid of precopy and postcopy in fact, and i
> entirely agree with what you are saying: postcopy migration is an
> alternative
> solution to deal with migrations that refuse to converge, or take too long
> to converge. But enabling this feature may not be easy in production since
> the
> recovery requires upper apps to interface, the hugepages and spdk/dpdk

Libvirt should support recovery, while vhost-user should also be supported
in general by both qemu/libvirt.  Huge page is indeed still the issue,
though.

> scenarios also need to be considered and re-test.
> Considering auto-converge is the main policy in the industry, the
> optimization
> may still make sense. We would like to try to optimize the auto-converge in
> huge
> VM case and, IMHO, it doesn't conflict with postcopy.

Yeah, that's OK.

> 
> 
> > should be cautious on adding more QMP interfaces on top of auto-converge,
> > because that means more maintenance burden everywhere.. and it's against
> > our goal to provide, hopefully, one solution for the long term for
> > convergence issues.
> >
> > Postcopy has a major issue with VFIO, but auto converge isn't anything
> > better from that regard.. as we can't yet throttle a device so far anyway.
> > Throttling of DMA probably means DMA faults, then postcopy might be doable
> > too.  Meanwhile we're looking at working out 1G postcopy at some point.
> >
> > So I wonder whether we can make any further optmization for auto-converge
> > (if we still really want that..) to be at least transparent, so that they
> >
> 
> Thanks for the advice and of course yes.
> So, at first, We'll try to avoid adding the new periodic throttle parameter
> and make it be transparent ?

That'll be my take on this, so we can keep relatively focused for hopefully
all migration developers around QEMU in the near future.  I wonder this
could be a good measure so we at least try to reduce part of the burden.

I don't think it's a published rule, it's just something I thought about
when glancing your series.  So feel free to share your thoughts.  Btw I'll
not be able to read into details yet in the next few days due to flooded
inbox.. sorry for that.  But I'll come back after I flush the rest.

Thanks,

-- 
Peter Xu


