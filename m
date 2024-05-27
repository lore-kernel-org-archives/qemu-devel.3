Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C771AC25B74
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 06:50:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBUBI-0004MU-Du; Mon, 27 May 2024 02:50:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sBUBG-0004Lk-FG
 for qemu-devel@nongnu.org; Mon, 27 May 2024 02:50:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sBUBE-0008Qx-KK
 for qemu-devel@nongnu.org; Mon, 27 May 2024 02:50:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716792599;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/ydN/EyaTB4DuHO1U7DU0E6kU7hv/TOrgk2fjMHpu9I=;
 b=g3KFYflH0ELnA2FO9pJai8WokACiQYeLFK406AuFWf1mxb1/2bVuIxkvQ1uiM2AW526+Nz
 jFO9dd0CCnhtCcxeqbnPM2bhXaF+xXfJ+iVeRxjlaKCUlFJQzrKPe5yD5soXKSw4US5rXf
 Ll6WxsGsAHERzsgc0Jrn2AEVhQJxNf4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-644-sOMkcmKSMZeUEgrxnoUQxA-1; Mon, 27 May 2024 02:49:55 -0400
X-MC-Unique: sOMkcmKSMZeUEgrxnoUQxA-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3550220c37bso1017669f8f.0
 for <qemu-devel@nongnu.org>; Sun, 26 May 2024 23:49:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716792594; x=1717397394;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/ydN/EyaTB4DuHO1U7DU0E6kU7hv/TOrgk2fjMHpu9I=;
 b=oS7zADu29vJTc40/GCKTEAS7QP3xXvdGKuRn3EZBkhrD8LHsNPxKcK1uey9M6BRf10
 TYuSw9FX9uxiXegq9V1LvXxVhJ8r0cmLUn6pdvbusqH7KrHtze0yvSX+oLQiFsa+ifIn
 jlKwRAF5vAvd5CAqbBbnYL5rtd18EhEF96zE7HwTcMZfFQtaqPxEkemWSHlbJ4O+zwAX
 ODKm2yhe3FVvWhVi+XjXvzTJ1tNprGPgn7Mz0ydF6pf0GCt3Ygpw+Jm6mz2HZ9124Fcm
 MRQTcHbQXJpgJfkfUOfKWKbPalv2yGiKHIvwEMVPMP4/QWMR85Pre1HakFgDYYSNd1GF
 76rQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVY+MFNcZz6Bff5GHcbMpj316ljymdll66s1rfeqn4cWxD520M3xUeIt5yarztQeDdj0dZ1tVCXgGuzSuzCnVYrf6wkGmc=
X-Gm-Message-State: AOJu0YzrbaXZeEKw4QzYxoUU51W/43CKUaCmd05MHGxGh//YXKgmyg1b
 bA91CDehoLigGZClBNtTAOO7x2YnV5GGm5Rxr9k23EYsEszsQqmTwvqEOBskJJsnVGbKv7IgMtB
 j6tPyhCnmeGlEp+zdh/Zt/EtCBXkDvt6YxLAOjZG3KDOlpW9iLCcg
X-Received: by 2002:adf:ce83:0:b0:351:ce05:7a33 with SMTP id
 ffacd0b85a97d-35506dc54ffmr6552801f8f.24.1716792593642; 
 Sun, 26 May 2024 23:49:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFwB9K/epghioNOE4vXz8p0+iHbRqyJOBQaGmgBN3FZ3uJPiYRkIF6ry1yNnLb0l4lhArTpqw==
X-Received: by 2002:adf:ce83:0:b0:351:ce05:7a33 with SMTP id
 ffacd0b85a97d-35506dc54ffmr6552785f8f.24.1716792592942; 
 Sun, 26 May 2024 23:49:52 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:342:cd82:9c62:7faf:9d73:ba3f])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35579d7d88esm8143442f8f.19.2024.05.26.23.49.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 May 2024 23:49:52 -0700 (PDT)
Date: Mon, 27 May 2024 02:49:49 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Yi Liu <yi.l.liu@intel.com>
Cc: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 Jason Wang <jasowang@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "Peng, Chao P" <chao.p.peng@intel.com>,
 Yu Zhang <yu.c.zhang@linux.intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: Re: [PATCH] intel_iommu: Use the latest fault reasons defined by spec
Message-ID: <20240527024327-mutt-send-email-mst@kernel.org>
References: <CACGkMEvTomFeC1bM3SfY1zGhQ_5i15r6CY6M3jVzau6niNUf_w@mail.gmail.com>
 <SJ0PR11MB6744AECEAA6F9319259B0DF192E92@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <DS0PR11MB752917B52B66A6EF10C10678C3E92@DS0PR11MB7529.namprd11.prod.outlook.com>
 <CACGkMEt5ofYt12A6uKUj=QLcLbOnrGT=UkMpee=MUxO6Xy3sxg@mail.gmail.com>
 <SJ0PR11MB6744C340AAB1B786D3913F5D92EA2@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <CACGkMEsV05ujKNEL9JSAsfikWGW582yvfSOdHJgRxZC_1cxgEg@mail.gmail.com>
 <SJ0PR11MB67445F7F8B79D2C2B982C1F692F52@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <CACGkMEuO6T-LqcZ=5oRR83LyhZ7oOtZvb70CUksZDAmC1KnsOA@mail.gmail.com>
 <SJ0PR11MB6744135D8C08CEE42460CAF792F02@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <10696888-9d9c-4a09-854d-a923246035a2@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10696888-9d9c-4a09-854d-a923246035a2@intel.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Mon, May 27, 2024 at 02:32:46PM +0800, Yi Liu wrote:
> Folks, looks like it's not necessary to be aligned with spec version.
> e.g. I can see something like below. This is an old machine which is
> not possible to be built according to vt-d spec 4.0. Let me check more
> machines as well to confirm this.

Aligning to a spec version is preferable. We don't *have* to force
users to do it if we don't want to, but you never know what
assumptions will guests make.



>Perhaps virtual VT-d implementation
> can have its own version policy? @Jason, how about your idea?
> 
> cat /sys/class/iommu/dmar0/intel-iommu/version
> 4:0

This is PV, really best avoided if we can.

> > > > > > > Probably, this might be something that could be noticed by the
> > > > > > > management to migration compatibility.
> > > > > > 
> > > > > > Could you elaborate what we need to do for migration compatibility?
> > > > > > I see version is already exported so libvirt can query it, see:
> > > > > > 
> > > > > >      DEFINE_PROP_UINT32("version", IntelIOMMUState, version, 0),
> > > > > 
> > > > > It is the Qemu command line parameters not the version of the vmstate.
> > > > > 
> > > > > For example -device intel-iommu,version=3.0
> > > > > 
> > > > > Qemu then knows it should behave as 3.0.
> > > > 
> > > > So you want to bump vtd_vmstate.version?
> > > 
> > > Well, as I said, it's not a direct bumping.
> > > 
> > > > 
> > > > In fact, this series change intel_iommu property from x-scalable-
> > > mode=["on"|"off"]"
> > > > to x-scalable-mode=["legacy"|"modern"|"off"]".
> > > > 
> > > > My understanding management app should use same qemu cmdline
> > > > in source and destination, so compatibility is already guaranteed even if
> > > > we don't bump vtd_vmstate.version.
> > > 
> > > Exactly, so the point is to
> > > 
> > > vtd=3.0, the device works exactly as vtd spec 3.0.
> > > vtd=3.3, the device works exactly as vtd spec 3.3.
> > 
> > Get your point. But I have some concerns about this:
> > 1.Exact version matching will bring vast of version check in the code,
> >     especially when we support more versions.
> > 2. There are some missed features before we can update version number to 3.0,
> >      i.e., nested translation, Accessed/Dirty (A/D) bits, 5 level page table, etc.
> > 3. Some features are removed in future versions, but we still need to
> >     implement them for intermediate version,
> >     i.e., ExecuteRequested (ER), Advanced Fault Logging, etc.
> 
> Even the hw follows vtd spec 3.0, it is not required to implement all of
> them. So it should be fine to implement part of the capabilities. :)

Yes, that's better.
Specifying version # explicitly is really annoying for both
qemu and management.
I think normally we should just start with capabilities and make
the best decision we can wrt guest support etc.

Being concervative is usually a good idea, if a new version gives no
useful functionality adding that is just churn.
So i.e.  we have a set of capabilities we want and select the earliest version
that supports them.

We can let user override that and I am not sure we need to bother
actually checking it's consistent with capabilities if we do
not want to.


> > > 
> > > When migration to the old qemu, mgmt can specify e.g vtd=3.0 for
> > > backward migration compatibility.
> > 
> > Yes, that makes sense for such migration.
> > But I'm not sure if there is a real scenario migrating to old qemu,
> > why not just update qemu on destination?
> > 
> > Thanks
> > Zhenzhong
> > 
> 
> -- 
> Regards,
> Yi Liu


