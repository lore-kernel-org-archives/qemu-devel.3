Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F59EC3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2024 08:25:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sat0e-0007ps-BN; Mon, 05 Aug 2024 04:24:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sat0c-0007of-7Q
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 04:24:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sat0a-0001Q0-D1
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 04:24:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722846238;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nNMNttYYfVprmlt5gv7GcUzumKfOGJyN5wjbkY8akBw=;
 b=cLT+Zb6JJRDKc+xZkg5nFSpkkpezJaTUC9ZWuZI8+gx6VKIuFsrzmV3CRuzlpnfjyHOdWV
 kmWuIve1PjxqGU9eW9XqYC8LWiCj9H9wgpZrAoaSNxo+7kJJ2bjG+NBqlPO4iGUKXhDEs1
 cE2KjcznuIdgxO8pT1soIwTgYIPtRzU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-126-pRxZRvGyM6yhpgPcVfcgSw-1; Mon, 05 Aug 2024 04:23:56 -0400
X-MC-Unique: pRxZRvGyM6yhpgPcVfcgSw-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3686d709f6dso5999631f8f.0
 for <qemu-devel@nongnu.org>; Mon, 05 Aug 2024 01:23:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722846235; x=1723451035;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nNMNttYYfVprmlt5gv7GcUzumKfOGJyN5wjbkY8akBw=;
 b=t1ZFMFPOkD4gjkfVi9qPKOPgmnXvFhmqwYZXj+z2e3YUuY+qZbl4lNmZDDTSApjFpr
 Je19AslrH8lwW0FOlmVM+/c2x2rpDHbs4aodpPplvX42VILVtpu5Nu5XLQt/l/8KwslF
 XDDw+995BsaymPfpBgQsIk42zOGYEpFK6anU94dqOykRcI4wVfk7R8EtwwG/G4shDYb3
 cqs3k01Ao1z8G3q5KzMYYHf3W6PwgvQTqD7qpf73L3fI6k0Ys0rmj7PZtmvj5BWIenNP
 r1oGMvbTUXxWP19y3Eh8yH1a+cwpyEyi+2h4mA/DzItODZPrgmGjRhwnkAvQImhhgsLK
 8V0g==
X-Forwarded-Encrypted: i=1;
 AJvYcCW7fwETzJIfTVBvRTt0tO661fqSeJzcYUQz5gbpyT3V6WMxQsUU7FwbF4uZaLxVv0t3+SOX6CDFlMZ7jhQ+QcMisMzgJDs=
X-Gm-Message-State: AOJu0Yxpz5g2j7OeZ01p4jYuYwaPXrwN3tabE+Jk29iaRdI9aCpKw/GF
 /rd3Y6RwCU/+VY3hIi547sEjp6ul5fEZ3wWKwJldMjYIJWh9Zn9p10vwdOoSiFNCG1I0mDPfVgz
 LQz1KR+TdE4NDDw4T/2rP8zz6gcLKLbvrG49hX4IkhzbQFWkx0Q2+
X-Received: by 2002:a5d:6287:0:b0:368:7f4f:9e95 with SMTP id
 ffacd0b85a97d-36bbc0e5ee5mr5882581f8f.10.1722846235542; 
 Mon, 05 Aug 2024 01:23:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHNd+OSB6y4qg2sVmYeGoDTRk3+T0gJsfc8Fv7G54Lwdin/KoAt0bi5wwME8zFnvo8I0qhYkQ==
X-Received: by 2002:a5d:6287:0:b0:368:7f4f:9e95 with SMTP id
 ffacd0b85a97d-36bbc0e5ee5mr5882542f8f.10.1722846234716; 
 Mon, 05 Aug 2024 01:23:54 -0700 (PDT)
Received: from redhat.com ([2a02:14f:17d:dd95:f049:da1a:7ecb:6d9])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36bbcf1db70sm8935226f8f.32.2024.08.05.01.23.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Aug 2024 01:23:54 -0700 (PDT)
Date: Mon, 5 Aug 2024 04:23:44 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Peter Xu <peterx@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, dmitry.fleytman@gmail.com,
 jasowang@redhat.com, sriram.yagnaraman@est.tech, sw@weilnetz.de,
 qemu-devel@nongnu.org, yan@daynix.com,
 Fabiano Rosas <farosas@suse.de>, devel@lists.libvirt.org
Subject: Re: [PATCH v2 4/4] virtio-net: Add support for USO features
Message-ID: <20240805041650-mutt-send-email-mst@kernel.org>
References: <Zqk6x2nd3Twz--75@x1n>
 <39a8bb8b-4191-4f41-aaf7-06df24bf3280@daynix.com>
 <ZqumIZcs1tCNTpRE@x1n>
 <b70d09a5-554a-456b-904e-59cec5836ae8@daynix.com>
 <Zqz1vvYqRuIAPnod@x1n>
 <c5ea7a57-fc52-4bb7-bc4c-f3aca8da0574@daynix.com>
 <Zq0IrhV-DgStpJtk@x1n>
 <8ad96f43-83ae-49ae-abc1-1e17ee15f24d@daynix.com>
 <20240805032937-mutt-send-email-mst@kernel.org>
 <cb71a6de-eb7a-402b-a58a-89198b4343f5@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cb71a6de-eb7a-402b-a58a-89198b4343f5@daynix.com>
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

On Mon, Aug 05, 2024 at 04:53:52PM +0900, Akihiko Odaki wrote:
> On 2024/08/05 16:30, Michael S. Tsirkin wrote:
> > On Sun, Aug 04, 2024 at 03:49:45PM +0900, Akihiko Odaki wrote:
> > > I suggest disabling all offload features of virtio-net with 9.2.
> > 
> > Yea ... no.
> > 
> > > I want to keep things consistent so I want to disable all at once. This
> > > change will be very uncomfortable for us, who are implementing offload
> > > features, but I hope it will motivate us to implement a proper solution.
> > 
> > It's uncomfortable for users.
> 
> An obvious alternative is to set cross-migrate=off by default (I dropped the
> no- prefix because no-cross-migrate=off is confusing). I don't have a
> particular idea whether cross-migrate should be on or off by default.
> 
> This is a trade-off of safety and performance. In general, I believe safety
> should come first before performance.

There's no actual safety issue here. You can't migrate certain configurations.
So I don't really understand what "cross-migrate" is supposed to do:
fail migration in 100% of cases?

I can see value in getting configuration from source and not starting
qemu on destination if it can not be migrated. This is rather
straight-forward, and seems directly useful for management.
I also see value in getting configuration from destination and starting
on source only if it can be migrated. As a variant of last one, I maybe
see value in getting that info from multiple destinations. Using this
last kind of thing would be trickier because it's not at the libvirt level,
so we would need very good documentation.

> On the other hand, disabling offload features is a breaking change. QEMU
> also has -only-migratable option; it is more consistent to make the
> additional assurance for migration opt-in instead of opt-out. Finally, I see
> migration across hosts as an advanced feature, and perhaps it can be
> justified to make it more like an optional feature.
> 
> Regards,
> Akihiko Odaki

It's already an optional feature.

-- 
MST


