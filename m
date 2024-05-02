Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24C76C4345F
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2024 16:20:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2ZA0-00010P-Td; Thu, 02 May 2024 12:19:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1s2Z9r-0000x5-Fs
 for qemu-devel@nongnu.org; Thu, 02 May 2024 12:19:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1s2Z9n-00071M-E2
 for qemu-devel@nongnu.org; Thu, 02 May 2024 12:19:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714666778;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cpv2ZJTwq22ZI/gO+j8aUWKwEIPzPssLgcK/f3dzPmU=;
 b=PAGonEFKZ3uBDfyWe5lVigOzWTZS+7MFmDslN6D2pqDi63qyhZ3SmdQBZflndZEoDrTvbo
 arhH5CcQxQ80gMsXtM9dOcDHPrit9jKSiFav4vkeHggjUU2pu5FG9DPbbINj212IYI9CFI
 fFdhR67z7mhk3S3GxBcMicjX9hOAXOo=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-6-DUGY2WsdPvKS3Vwa2GKBEQ-1; Thu, 02 May 2024 12:19:37 -0400
X-MC-Unique: DUGY2WsdPvKS3Vwa2GKBEQ-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-69b6e12ea63so30515926d6.1
 for <qemu-devel@nongnu.org>; Thu, 02 May 2024 09:19:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714666777; x=1715271577;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cpv2ZJTwq22ZI/gO+j8aUWKwEIPzPssLgcK/f3dzPmU=;
 b=WnyiN4L7Wo5lbLFMuZWct0yQ9oedYxogR5OBpQWiDxixHz+zrfBJfnOn+/djjarGvP
 x6oXlX4P3OKeFugByFtpvWni3OfPDKgeuoJzOsSAiJtnOB17h2nX8DbRwFUvdbWD2JwH
 iA2DFNSHBR51M5161+7fPTLyTHlZe7FBm7vM69lwg4cU3zP9z8WhCZqw3RywbplaKRJ0
 oL2dC3ruE7GRej/vqvO3mVZSDNsiFxibgOBm0hTVcK8XjhLw0SGtJLZ+qjjARWGazJi0
 dbAh9F+5ax8T+dAQPFHiyJ+pxwLk47pzMSt1IkS6YQX16F9G8D6AeK4D0yqNVRNqRFqk
 mcfQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXVHpOyh3hYx0T7oQCeOb+rhgw4pZoaLPhmbcJc7oFO8fG9/zHvCRFRXxzBk04I0kW9tDHYuHUpBAC3142WODInQgFd2UI=
X-Gm-Message-State: AOJu0YxOcl6n/jcyf9DqyB7NoNJ1Ir/11Y4/9h4Afm+WBYHAjqdkNufI
 +oTkhCqimkVbRxXqmK1oqCuR5o9jj/wQz7HvGHGkqzYr/gzHmd5lH0+jNLnwl5JDVhFYdmGDirm
 INNf4/mx8Jk5n9aPxKCQCaBmK5oiv6lCqS9QwhoaCwYE8kX1RcKkf
X-Received: by 2002:a05:620a:198e:b0:790:afc2:65d6 with SMTP id
 bm14-20020a05620a198e00b00790afc265d6mr5703qkb.6.1714666776292; 
 Thu, 02 May 2024 09:19:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEs6OTT/3gvHXNkQxK6BtgDi0txHh7bqltEBLR4GyUWr1MPS/V1g6D1B6BWsi8M3TIxT0B6tQ==
X-Received: by 2002:a05:620a:198e:b0:790:afc2:65d6 with SMTP id
 bm14-20020a05620a198e00b00790afc265d6mr5664qkb.6.1714666775674; 
 Thu, 02 May 2024 09:19:35 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 m6-20020ae9f206000000b0078f1583f724sm474911qkg.59.2024.05.02.09.19.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 May 2024 09:19:35 -0700 (PDT)
Date: Thu, 2 May 2024 12:19:33 -0400
From: Peter Xu <peterx@redhat.com>
To: Jinpu Wang <jinpu.wang@ionos.com>
Cc: Michael Galaxy <mgalaxy@akamai.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Yu Zhang <yu.zhang@ionos.com>,
 "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>,
 Elmar Gerdes <elmar.gerdes@ionos.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Yuval Shaia <yuval.shaia.ml@gmail.com>, Kevin Wolf <kwolf@redhat.com>,
 Prasanna Kumar Kalever <prasanna.kalever@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Prasanna Kumar Kalever <prasanna4324@gmail.com>,
 "integration@gluster.org" <integration@gluster.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "devel@lists.libvirt.org" <devel@lists.libvirt.org>,
 Hanna Reitz <hreitz@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Eric Blake <eblake@redhat.com>,
 Song Gao <gaosong@loongson.cn>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, arei.gonglei@huawei.com,
 pannengyuan@huawei.com
Subject: Re: [PATCH-for-9.1 v2 2/3] migration: Remove RDMA protocol handling
Message-ID: <ZjO9FQjrV9Ph23vU@x1n>
References: <CAHEcVy7POArt+CmY8dyNTzLJp3XxXgjh3k8=C=9K+_cw1CSJFA@mail.gmail.com>
 <46f5e323-632d-7bda-f2c5-3cfa7b1c6b68@akamai.com>
 <Zi-1OvxA5MIHjklU@x1n> <877cgfe2yw.fsf@pond.sub.org>
 <ZjClMb-6MddpvHqQ@redhat.com> <ZjJgQcPQ29HJsTpY@x1n>
 <ZjJm6rcqS5EhoKgK@redhat.com> <ZjJqwg1H2nZbcekb@x1n>
 <ac86d9a7-02c6-9a07-4135-8327d17aca6b@akamai.com>
 <CAMGffEm-PXOBi-jR3CTe5dwT12EgOAh1h0KKaBH7=1BETCbvWg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMGffEm-PXOBi-jR3CTe5dwT12EgOAh1h0KKaBH7=1BETCbvWg@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.476,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, May 02, 2024 at 03:30:58PM +0200, Jinpu Wang wrote:
> Hi Michael, Hi Peter,
> 
> 
> On Thu, May 2, 2024 at 3:23 PM Michael Galaxy <mgalaxy@akamai.com> wrote:
> >
> > Yu Zhang / Jinpu,
> >
> > Any possibility (at your lesiure, and within the disclosure rules of
> > your company, IONOS) if you could share any of your performance
> > information to educate the group?
> >
> > NICs have indeed changed, but not everybody has 100ge mellanox cards at
> > their disposal. Some people don't.
> Our staging env is with 100 Gb/s IB environment.
> We will have a new setup in the coming months with Ethernet (RoCE), we
> will run some performance
> comparison when we have the environment ready.

Thanks both.  Please keep us posted.

Just to double check, we're comparing "tcp:" v.s. "rdma:", RoCE is not
involved, am I right?

The other note is that the comparison needs to be with multifd enabled for
the "tcp:" case.  I'd suggest we start with 8 threads if it's 100Gbps.

I think I can still fetch some 100Gbps or even 200Gbps nics around our labs
without even waiting for months.  If you want I can try to see how we can
test together.  And btw I don't think we need a cluster, IIUC we simply
need two hosts, 100G nic on both sides?  IOW, it seems to me we only need
two cards just for experiments, systems that can drive the cards, and a
wire supporting 100G?

> 
> >
> > - Michael
> 
> Thx!
> Jinpu
> >
> > On 5/1/24 11:16, Peter Xu wrote:
> > > On Wed, May 01, 2024 at 04:59:38PM +0100, Daniel P. Berrangé wrote:
> > >> On Wed, May 01, 2024 at 11:31:13AM -0400, Peter Xu wrote:
> > >>> What I worry more is whether this is really what we want to keep rdma in
> > >>> qemu, and that's also why I was trying to request for some serious
> > >>> performance measurements comparing rdma v.s. nics.  And here when I said
> > >>> "we" I mean both QEMU community and any company that will support keeping
> > >>> rdma around.
> > >>>
> > >>> The problem is if NICs now are fast enough to perform at least equally
> > >>> against rdma, and if it has a lower cost of overall maintenance, does it
> > >>> mean that rdma migration will only be used by whoever wants to keep them in
> > >>> the products and existed already?  In that case we should simply ask new
> > >>> users to stick with tcp, and rdma users should only drop but not increase.
> > >>>
> > >>> It seems also destined that most new migration features will not support
> > >>> rdma: see how much we drop old features in migration now (which rdma
> > >>> _might_ still leverage, but maybe not), and how much we add mostly multifd
> > >>> relevant which will probably not apply to rdma at all.  So in general what
> > >>> I am worrying is a both-loss condition, if the company might be easier to
> > >>> either stick with an old qemu (depending on whether other new features are
> > >>> requested to be used besides RDMA alone), or do periodic rebase with RDMA
> > >>> downstream only.
> > >> I don't know much about the originals of RDMA support in QEMU and why
> > >> this particular design was taken. It is indeed a huge maint burden to
> > >> have a completely different code flow for RDMA with 4000+ lines of
> > >> custom protocol signalling which is barely understandable.
> > >>
> > >> I would note that /usr/include/rdma/rsocket.h provides a higher level
> > >> API that is a 1-1 match of the normal kernel 'sockets' API. If we had
> > >> leveraged that, then QIOChannelSocket class and the QAPI SocketAddress
> > >> type could almost[1] trivially have supported RDMA. There would have
> > >> been almost no RDMA code required in the migration subsystem, and all
> > >> the modern features like compression, multifd, post-copy, etc would
> > >> "just work".
> > >>
> > >> I guess the 'rsocket.h' shim may well limit some of the possible
> > >> performance gains, but it might still have been a better tradeoff
> > >> to have not quite so good peak performance, but with massively
> > >> less maint burden.
> > > My understanding so far is RDMA is sololy for performance but nothing else,
> > > then it's a question on whether rdma existing users would like to do so if
> > > it will run slower.
> > >
> > > Jinpu mentioned on the explicit usages of ib verbs but I am just mostly
> > > quotting that word as I don't really know such details:
> > >
> > > https://urldefense.com/v3/__https://lore.kernel.org/qemu-devel/CAMGffEm2TWJxOPcNQTQ1Sjytf5395dBzTCMYiKRqfxDzJwSN6A@mail.gmail.com/__;!!GjvTz_vk!W6-HGWM-XkF_52am249DrLIDQeZctVOHg72LvOHGUcwxqQM5mY0GNYYl-yNJslN7A5GfLOew9oW_kg$
> > >
> > > So not sure whether that applies here too, in that having qiochannel
> > > wrapper may not allow direct access to those ib verbs.
> > >
> > > Thanks,
> > >
> > >> With regards,
> > >> Daniel
> > >>
> > >> [1] "almost" trivially, because the poll() integration for rsockets
> > >>      requires a bit more magic sauce since rsockets FDs are not
> > >>      really FDs from the kernel's POV. Still, QIOCHannel likely can
> > >>      abstract that probme.
> > >> --
> > >> |: https://urldefense.com/v3/__https://berrange.com__;!!GjvTz_vk!W6-HGWM-XkF_52am249DrLIDQeZctVOHg72LvOHGUcwxqQM5mY0GNYYl-yNJslN7A5GfLOfyTmFFUQ$       -o-    https://urldefense.com/v3/__https://www.flickr.com/photos/dberrange__;!!GjvTz_vk!W6-HGWM-XkF_52am249DrLIDQeZctVOHg72LvOHGUcwxqQM5mY0GNYYl-yNJslN7A5GfLOf8A5OC0Q$  :|
> > >> |: https://urldefense.com/v3/__https://libvirt.org__;!!GjvTz_vk!W6-HGWM-XkF_52am249DrLIDQeZctVOHg72LvOHGUcwxqQM5mY0GNYYl-yNJslN7A5GfLOf3gffAdg$          -o-            https://urldefense.com/v3/__https://fstop138.berrange.com__;!!GjvTz_vk!W6-HGWM-XkF_52am249DrLIDQeZctVOHg72LvOHGUcwxqQM5mY0GNYYl-yNJslN7A5GfLOfPMofYqw$  :|
> > >> |: https://urldefense.com/v3/__https://entangle-photo.org__;!!GjvTz_vk!W6-HGWM-XkF_52am249DrLIDQeZctVOHg72LvOHGUcwxqQM5mY0GNYYl-yNJslN7A5GfLOeQ5jjAeQ$     -o-    https://urldefense.com/v3/__https://www.instagram.com/dberrange__;!!GjvTz_vk!W6-HGWM-XkF_52am249DrLIDQeZctVOHg72LvOHGUcwxqQM5mY0GNYYl-yNJslN7A5GfLOfhaDF9WA$  :|
> > >>
> 

-- 
Peter Xu


