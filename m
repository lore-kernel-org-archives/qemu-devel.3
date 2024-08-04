Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6047C3DA64
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Aug 2024 13:43:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sabUn-0007C3-1G; Sun, 04 Aug 2024 09:42:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sabUl-0007Ba-T9
 for qemu-devel@nongnu.org; Sun, 04 Aug 2024 09:41:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sabUj-0006e9-Sy
 for qemu-devel@nongnu.org; Sun, 04 Aug 2024 09:41:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722778914;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TwAsjzOudZE7HL1hQzZUrklThlQcE3QMAND0Gx4kKos=;
 b=NcL6/bruV+w6eKnkbmA4UjEXHe3CMZiFt898cfZTXZcfdR/nbj00lGD/Vn0uJZ/jJ/1+7s
 63odKF0yonJ+p3nEhLU2Ni+4V0qS58y60c92Vp9rgULlvw7Ab+snww6vrNBwb46dFECe8R
 yHTteVGnbNANzMeakF61z20co7nq85E=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-640-Q0WHYCVzPoWKrt8Nc1SC_g-1; Sun, 04 Aug 2024 09:41:53 -0400
X-MC-Unique: Q0WHYCVzPoWKrt8Nc1SC_g-1
Received: by mail-ot1-f72.google.com with SMTP id
 46e09a7af769-7094db8ec7dso8709443a34.0
 for <qemu-devel@nongnu.org>; Sun, 04 Aug 2024 06:41:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722778912; x=1723383712;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TwAsjzOudZE7HL1hQzZUrklThlQcE3QMAND0Gx4kKos=;
 b=N9z9ly2+pL1CBLlNFzmFpLGoP+DNJOD3B4jNakbA44KopbCIcwgQo/T5PGt1Ruoihl
 bapB2v3oiIIfCoQgQR0V6SuOoRGzbvOlDxAkvv6PSKSEuFUKopOiXPteTvz+GMpV+CXw
 u9ufwIR379gcvZdtqTU0K0d3ZGchZv9OSeMxA3WAuQEviPJfkdp4VoYn4ILauf0vJybB
 QCk0HwG0TJyMr/qCM3qSItvQcec4S/inUT0Tl+Cy0DM7qpatW7ogfbnk1hwSdnKa9+/z
 FXzBZqHoBeov8pcENXYNA7+oaUjVEr/5LQufY38TCm3WO9/86q+WcPCeBcV1YeHTjAbZ
 /1kw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXra1HvcGIQpSSkxvOMsN2bhiG7xR7bkDUm4axnEB/o4TrVVybg5Y51RFIhwNr2hv2LDrXPj5Dwc9NejcsqnRuk0mPZJp0=
X-Gm-Message-State: AOJu0YyQ1+3akXWrOVtpBSDRwhlfkyf4D497AHdBKHCtMLCosMFb3Sz7
 JHAPVrvrBZqZz6GP2DdcK7j5OPVzbwj6P5OcRTwwK3HlW4XnoJTiUFc7o3gRH4zuj1zrLYMOWq1
 t1sDXXxSDDCkj+KTydwpkD2iMehDGRnxUb03/IQGIiTrBwyNGJZ29
X-Received: by 2002:a05:6830:2808:b0:708:f88a:e3e7 with SMTP id
 46e09a7af769-709b997d85emr12823644a34.34.1722778912219; 
 Sun, 04 Aug 2024 06:41:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFMDG1IdsxRUtggYEupjUFxCMYIl97pgnRbtg33cQiBFUraosxUfhdBS9JvuIMoe0ZSyaF3qw==
X-Received: by 2002:a05:6830:2808:b0:708:f88a:e3e7 with SMTP id
 46e09a7af769-709b997d85emr12823609a34.34.1722778911778; 
 Sun, 04 Aug 2024 06:41:51 -0700 (PDT)
Received: from redhat.com ([2.55.39.202]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5d76261ce82sm1442575eaf.42.2024.08.04.06.41.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Aug 2024 06:41:51 -0700 (PDT)
Date: Sun, 4 Aug 2024 09:41:42 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, dmitry.fleytman@gmail.com,
 jasowang@redhat.com, sriram.yagnaraman@est.tech, sw@weilnetz.de,
 qemu-devel@nongnu.org, yan@daynix.com,
 Fabiano Rosas <farosas@suse.de>, devel@lists.libvirt.org
Subject: Re: [PATCH v2 4/4] virtio-net: Add support for USO features
Message-ID: <20240804094001-mutt-send-email-mst@kernel.org>
References: <Zqk09BGxlpdxMBMx@redhat.com> <Zqk6x2nd3Twz--75@x1n>
 <39a8bb8b-4191-4f41-aaf7-06df24bf3280@daynix.com>
 <ZqumIZcs1tCNTpRE@x1n>
 <b70d09a5-554a-456b-904e-59cec5836ae8@daynix.com>
 <Zqz1vvYqRuIAPnod@x1n>
 <c5ea7a57-fc52-4bb7-bc4c-f3aca8da0574@daynix.com>
 <Zq0IrhV-DgStpJtk@x1n>
 <8ad96f43-83ae-49ae-abc1-1e17ee15f24d@daynix.com>
 <Zq99NcMkDMkDKBLv@x1n>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zq99NcMkDMkDKBLv@x1n>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Sun, Aug 04, 2024 at 09:08:05AM -0400, Peter Xu wrote:
> On Sun, Aug 04, 2024 at 03:49:45PM +0900, Akihiko Odaki wrote:
> > On 2024/08/03 1:26, Peter Xu wrote:
> > > On Sat, Aug 03, 2024 at 12:54:51AM +0900, Akihiko Odaki wrote:
> > > > > > > I'm not sure if I read it right.  Perhaps you meant something more generic
> > > > > > > than -platform but similar?
> > > > > > > 
> > > > > > > For example, "-profile [PROFILE]" qemu cmdline, where PROFILE can be either
> > > > > > > "perf" or "compat", while by default to "compat"?
> > > > > > 
> > > > > > "perf" would cover 4) and "compat" will cover 1). However neither of them
> > > > > > will cover 2) because an enum is not enough to know about all hosts. I
> > > > > > presented a design that will cover 2) in:
> > > > > > https://lore.kernel.org/r/2da4ebcd-2058-49c3-a4ec-8e60536e5cbb@daynix.com
> > > > > 
> > > > > "-merge-platform" shouldn't be a QEMU parameter, but should be something
> > > > > separate.
> > > > 
> > > > Do you mean merging platform dumps should be done with another command? I
> > > > think we will want to know the QOM tree is in use when implementing
> > > > -merge-platform. For example, you cannot define a "platform" when e.g., you
> > > > don't know what netdev backend (e.g., user, vhost-net, vhost-vdpa) is
> > > > connected to virtio-net devices. Of course we can include those information
> > > > in dumps, but we don't do so for VMState.
> > > 
> > > What I was thinking is the generated platform dump shouldn't care about
> > > what is used as backend: it should try to probe whatever is specified in
> > > the qemu cmdline, and it's the user's job to make sure the exact same qemu
> > > cmdline is used in other hosts to dump this information.
> > > 
> > > IOW, the dump will only contain the information that was based on the qemu
> > > cmdline.  E.g., if it doesn't include virtio device at all, and if we only
> > > support such dump for virtio, it should dump nothing.
> > > 
> > > Then the -merge-platform will expect all dumps to look the same too,
> > > merging them with AND on each field.
> > 
> > I think we will still need the QOM tree in that case. I think the platform
> > information will look somewhat similar to VMState, which requires the QOM
> > tree to interpret.
> 
> Ah yes, I assume you meant when multiple devices can report different thing
> even if with the same frontend / device type.  QOM should work, or anything
> that can identify a device, e.g. with id / instance_id attached along with
> the device class.
> 
> One thing that I still don't know how it works is how it interacts with new
> hosts being added.
> 
> This idea is based on the fact that the cluster is known before starting
> any VM.  However in reality I think it can happen when VMs started with a
> small cluster but then cluster extended, when the -merge-platform has been
> done on the smaller set.

This is why I think we (also?) need a way to dump config and then
give it to qemu on destination. To have a simple way to management to
know whether migration has a chance of working.


> > 
> > > 
> > > Said that, I actually am still not clear on how / whether it should work at
> > > last.  At least my previous concern (1) didn't has a good answer yet, on
> > > what we do when profile collisions with qemu cmdlines.  So far I actually
> > > still think it more straightforward that in migration we handshake on these
> > > capabilities if possible.
> > > 
> > > And that's why I was thinking (where I totally agree with you on this) that
> > > whether we should settle a short term plan first to be on the safe side
> > > that we start with migration always being compatible, then we figure the
> > > other approach.  That seems easier to me, and it's also a matter of whether
> > > we want to do something for 9.1, or leaving that for 9.2 for USO*.
> > 
> > I suggest disabling all offload features of virtio-net with 9.2.
> > 
> > I want to keep things consistent so I want to disable all at once. This
> > change will be very uncomfortable for us, who are implementing offload
> > features, but I hope it will motivate us to implement a proper solution.
> > 
> > That said, it will be surely a breaking change so we should wait for 9.1
> > before making such a change.
> 
> Personally I don't worry too much on other offload bits besides USO* so far
> if we have them ON for longer time.  My wish was that they're old good
> kernel features mostly supported everywhere who runs QEMU, then we're good.
> 
> And I definitely worry about future offload features, or any feature that
> may probe host like this and auto-OFF: I hope we can do them on the safe
> side starting from day1.
> 
> So I don't know whether we should do that to USO* only or all.  But I agree
> with you that'll definitely be cleaner.
> 
> On the details of how to turn them off properly..  Taking an example if we
> want to turn off all the offload features by default (or simply we replace
> that with USO-only)..
> 
> Upstream machine type is flexible to all kinds of kernels, so we may not
> want to regress anyone using an existing machine type even on perf,
> especially if we want to turn off all.
> 
> In that case we may need one more knob (I'm assuming this is virtio-net
> specific issue, but maybe not; using it as an example) to make sure the old
> machine types perfs as well, with:
> 
>   - x-virtio-net-offload-enforce
> 
>     When set, the offload features with value ON are enforced, so when
>     the host doesn't support a offload feature it will fail to boot,
>     showing the error that specific offload feature is not supported by the
>     virtio backend.
> 
>     When clear, the offload features with value ON are not enforced, so
>     these features can be automatically turned OFF when it's detected the
>     backend doesn't support them.  This may bring best perf but has the
>     risk of breaking migration.
> 
> With that,
> 
>   - On old machine types (compat properties):
> 
>     - set "x-virtio-net-offload-enforce" OFF
>     - set all offload features ON
> 
>   - On new machine types (the default values):
> 
>     - set "x-virtio-net-offload-enforce" ON
>     - set all offload features OFF
> 
> And yes, we can do that until 9.2, but with above even 9.1 should be safe
> to do.  9.2 might be still easier just to think everything through again,
> after all at least USO was introduced in 8.2 so not a regress in 9.1.
> 
> > 
> > By the way, I am wondering perhaps the "no-cross-migrate" scenario can be
> > implemented relatively easy in a way similar to compatibility properties.
> > The idea is to add the "no-cross-migrate" property to machines. If the
> > property is set to "on", all offload features of virtio-net will be set to
> > "auto". virtio-net will then probe the offload features and enable available
> > offloading features.
> 
> If it'll become a device property, there's still the trick / concern where
> no-cross-migrate could conflict with the other offload feature that was
> selected explicilty by an user (e.g. no-cross-migrate=ON + uso=OFF).
> 
> Thanks,
> 
> -- 
> Peter Xu


