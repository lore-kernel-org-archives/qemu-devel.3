Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B325C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2024 22:27:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzObo-00004q-GD; Tue, 23 Apr 2024 18:27:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rzObi-0008WM-9e
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 18:27:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rzObe-0003za-UM
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 18:27:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713911236;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SnpcpFBDm33Lp2bpgvI5FbgopgbkgToHo0zz38Iwv6o=;
 b=fRsp5K74HZAD+2D9WFRnKjvGmO4ikewuXE3AnzCfMWeca3URyGELmOjq6iD972HPlqL1gm
 /x0vW6dyspJKT2zRqv+U1bPnu595TTBRCCxaQ3n0q+Ieme/Ua+KH2TMAmX6ooijboF+gk8
 IbUNvFrwNLafy1uZ6Vn4jPUtrnQuyTs=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-180-mpnPUr02PlCKxVb1cDjWMQ-1; Tue, 23 Apr 2024 18:27:15 -0400
X-MC-Unique: mpnPUr02PlCKxVb1cDjWMQ-1
Received: by mail-oo1-f72.google.com with SMTP id
 006d021491bc7-5aa1b6f6c0fso975529eaf.1
 for <qemu-devel@nongnu.org>; Tue, 23 Apr 2024 15:27:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713911234; x=1714516034;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SnpcpFBDm33Lp2bpgvI5FbgopgbkgToHo0zz38Iwv6o=;
 b=Svm2n6Rgm/4LUvPfFJGQABvRM6o/X0y0cJL3PeCxC/dng5vCWzZE9MFr6akjF+fxRe
 YOuaReCnTMD13iREZ00qYvdv5mpZOIYMPcFyfHrZkzXMcOXHkdfUZQTIZbMc96zR31eF
 YAp1+XLy1/OtTFsS+LZnU90Cb99zdmm1/rk355Oxz3GBU1pcgnKHyzs+ZPI238hhXkUC
 8/pq0+pgeEyQ0+FzG23+jLS8BjrhP5lf0qSbNo+OzFiGL8x5bV8QQ3mxBP3xUe3rRcgx
 74JfYo5MLpoRLVe8nFZ9HPHb8tcWJ8eZjd4sV6lqATFmElXnbROZgfaAM6PlykTvTY4W
 eaeQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXGJKHVy761qIioQgOk7WQguw9Hx0cbHZPULBaNMcSvXvA1hzOSor/1a/mevuieABOxQZ9u2xBxmiZs4Xt5r1OfMQ9ZF24=
X-Gm-Message-State: AOJu0YxC/C51eT7VpJa3ErF0O9/IC1gB83J5SRjCqXi/yJ2te++Nk0yS
 XhmxxE60Bnt35Hfzqs/SCq+WvTJlLHI1nmnCvWNxmWPlr2Hz0kTxdz4kcLSCdx7QY73kNWfZRvR
 X1wWzKFHskhaGLzRhI0ExbMY4B+6pu37mppFg9AtOBxdxVZJaA2nk
X-Received: by 2002:a05:6359:a19:b0:18c:107f:51b1 with SMTP id
 el25-20020a0563590a1900b0018c107f51b1mr555901rwb.3.1713911234403; 
 Tue, 23 Apr 2024 15:27:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFcc+yC6hjuTLQpR/OiKS/bx5kSp2+z0Jv9/fw/QjZY/27b4sm9iucqyOt6fluKuK/GFtodBQ==
X-Received: by 2002:a05:6359:a19:b0:18c:107f:51b1 with SMTP id
 el25-20020a0563590a1900b0018c107f51b1mr555881rwb.3.1713911233716; 
 Tue, 23 Apr 2024 15:27:13 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 o20-20020ac86d14000000b0043842dc662esm4310423qtt.4.2024.04.23.15.27.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Apr 2024 15:27:13 -0700 (PDT)
Date: Tue, 23 Apr 2024 18:27:11 -0400
From: Peter Xu <peterx@redhat.com>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH RFC 00/26] =?utf-8?Q?Multifd_?= =?utf-8?B?8J+UgA==?=
 device state transfer support with VFIO consumer
Message-ID: <Zig1vyC-D7j33yIn@x1n>
References: <cover.1713269378.git.maciej.szmigiero@oracle.com>
 <Zh-KF72Fe9oV6tfT@redhat.com>
 <c0b1dbb1-d353-4832-af90-96895b2129fc@maciej.szmigiero.name>
 <Zh_6W8u3H4FmGS49@redhat.com>
 <71ede5c8-857c-418b-9e37-b8d343ddfa06@maciej.szmigiero.name>
 <ZiD4aLSre6qubuHr@redhat.com>
 <aebcd78e-b8b6-44db-b2be-0bbd5acccf3f@maciej.szmigiero.name>
 <ZiF8aWVfW7kPuOtn@x1n>
 <9fa34f3e-2f65-442b-8872-513565bb335c@maciej.szmigiero.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9fa34f3e-2f65-442b-8872-513565bb335c@maciej.szmigiero.name>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.67,
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

On Tue, Apr 23, 2024 at 06:14:18PM +0200, Maciej S. Szmigiero wrote:
> We don't lose any genericity since by default the transfer is done via
> mixed RAM / device state multifd channels from a shared pool.
> 
> It's only when x-multifd-channels-device-state is set to value > 0 then
> the requested multifd channel counts gets dedicated to device state.
> 
> It could be seen as a fine-tuning option for cases where tests show that
> it provides some benefits to the particular workload - just like many
> other existing migration options are.
> 
> 14% downtime improvement is too much to waste - I'm not sure that's only
> due to avoiding RAM syncs, it's possible that there are other subtle
> performance interactions too.
> 
> For even more genericity this option could be named like
> x-multifd-channels-map and contain an array of channel settings like
> "ram,ram,ram,device-state,device-state".
> Then a possible future other uses of multifd channels wouldn't even need
> a new dedicated option.

Yeah I understand such option would only provide more options.

However as long as such option got introduced, user will start to do their
own "optimizations" on how to provision the multifd channels, and IMHO
it'll be great if we as developer can be crystal clear on why it needs to
be introduced in the first place, rather than making all channels open to
all purposes.

So I don't think I'm strongly against such parameter, but I want to double
check we really understand what's behind this to justify such parameter.
Meanwhile I'd be always be pretty caucious on introducing any migration
parameters, due to the compatibility nightmares.  The less parameter the
better..

> 
> > > 
> > > I think one of the reasons for these results is that mixed (RAM + device
> > > state) multifd channels participate in the RAM sync process
> > > (MULTIFD_FLAG_SYNC) whereas device state dedicated channels don't.
> > 
> > Firstly, I'm wondering whether we can have better names for these new
> > hooks.  Currently (only comment on the async* stuff):
> > 
> >    - complete_precopy_async
> >    - complete_precopy
> >    - complete_precopy_async_wait
> > 
> > But perhaps better:
> > 
> >    - complete_precopy_begin
> >    - complete_precopy
> >    - complete_precopy_end
> > 
> > ?
> > 
> > As I don't see why the device must do something with async in such hook.
> > To me it's more like you're splitting one process into multiple, then
> > begin/end sounds more generic.
> 
> Ack, I will rename these hooks to begin/end.
> 
> > Then, if with that in mind, IIUC we can already split ram_save_complete()
> > into >1 phases too. For example, I would be curious whether the performance
> > will go back to normal if we offloading multifd_send_sync_main() into the
> > complete_precopy_end(), because we really only need one shot of that, and I
> > am quite surprised it already greatly affects VFIO dumping its own things.
> 
> AFAIK there's already just one multifd_send_sync_main() during downtime -
> the one called from save_live_complete_precopy SaveVMHandler.
> 
> In order to truly never interfere with device state transfer the sync would
> need to be ordered after the device state transfer is complete - that is,
> after VFIO complete_precopy_end (complete_precopy_async_wait) handler
> returns.

Do you think it'll be worthwhile give it a shot, even if we can't decide
yet on the order of end()s to be called?

It'll be great if we could look into these issues instead of workarounds,
and figure out what affected the performance behind, and also whether that
can be fixed without such parameter.

Thanks,

-- 
Peter Xu


