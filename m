Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB0C4C4345F
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2024 16:17:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2Cd0-0004uu-Kh; Wed, 01 May 2024 12:16:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1s2Ccu-0004uU-OZ
 for qemu-devel@nongnu.org; Wed, 01 May 2024 12:16:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1s2Ccs-0006G7-7s
 for qemu-devel@nongnu.org; Wed, 01 May 2024 12:16:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714580169;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QpcvQqrhXZR5dneCNKQyIC74rrZ4f1YBymLdaKKnjAE=;
 b=KvKbgSadIyjkb6wiomC+f+YCkYVJZ/qOvPePYMoBwgHi6GJW0uAByXPA084f9sWjzmR3tz
 LmCYkv7A5AoDMt8pnCBZ95I7DjaO2K4aFgIa001IGd768EGwfv0HsBn2UH9cqOv3dv+9VL
 m8GfLOQxdzCgxCfh/8zcakGCgh34SXc=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-nOOmxUijOEiX-2GJSOnptQ-1; Wed, 01 May 2024 12:16:08 -0400
X-MC-Unique: nOOmxUijOEiX-2GJSOnptQ-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-6a0eff9efc1so666466d6.2
 for <qemu-devel@nongnu.org>; Wed, 01 May 2024 09:16:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714580167; x=1715184967;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QpcvQqrhXZR5dneCNKQyIC74rrZ4f1YBymLdaKKnjAE=;
 b=sMlIkWzd+9PJHVWAHTdJ+rDwXWHPPYh3t5Z5VrrMu4eZVZoNmsIKQsTyqwcVfCAOIg
 4VFUSyA+l/ZhK5H7YmDdEeWiPAkhn6Spmd+CMjjyhx0pBiyqongZzRERBHZCgrQcNyao
 yz4+Qv5zzRKzL51NXklRUhfwgx0kyo5p1geQck1ARa5LP9LyuNBPt6HrSlEMndt/iWuA
 gN0tr7UlQvi0zbkrB6rU2hbdgYZ7uEwDKq+wdfmTRfLRhdikUNdHgBdkxlRcAeiUfJmi
 yAv8UljBHFqAZTaM4vHKcu9Gfr4MqE+Ng2K22u/VyYz9IUyhGY06aG9Bvhuz5BJnEkV0
 7FcQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWy+jmFjibakWzIIp91DCvSJDTMpYR5qY1XtAaPYlT/Vs4rYW1lDS85Z8fJBzEh07rEPJEtu5gomBco9HRXrLbvbHKrC4A=
X-Gm-Message-State: AOJu0YzMToo/h8W4hcj6rZqZBch7bRKWBSlg3GFxQO+ylOGFu1fob5VH
 yijIy4wPlH45Ux9cjxSn2lkaFx5Z6OKjnJid1lA9mQ1OJbY6JSU/UXIhtWJ8yZjfTCjkuesnDX8
 PoOJdm1qZStqZ3O8RnPv0qnsuqgsp5Cm61oEPsL/VEiSHeG8YCN3p
X-Received: by 2002:a05:6214:2aa6:b0:696:b235:f39 with SMTP id
 js6-20020a0562142aa600b00696b2350f39mr2991601qvb.6.1714580166993; 
 Wed, 01 May 2024 09:16:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGZCykixyNb4UxxcdrfAFFV++qbnl9TjScutkbfLgAANiNQBpc1pTHXbv+h25DXdN7zkSo6ZA==
X-Received: by 2002:a05:6214:2aa6:b0:696:b235:f39 with SMTP id
 js6-20020a0562142aa600b00696b2350f39mr2991530qvb.6.1714580166153; 
 Wed, 01 May 2024 09:16:06 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 j7-20020a0ce6a7000000b006a0cc19f870sm3176955qvn.9.2024.05.01.09.16.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 May 2024 09:16:05 -0700 (PDT)
Date: Wed, 1 May 2024 12:16:02 -0400
From: Peter Xu <peterx@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>,
 Michael Galaxy <mgalaxy@akamai.com>, Yu Zhang <yu.zhang@ionos.com>,
 "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>,
 Jinpu Wang <jinpu.wang@ionos.com>, Elmar Gerdes <elmar.gerdes@ionos.com>,
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
Message-ID: <ZjJqwg1H2nZbcekb@x1n>
References: <082a21b0-d4d1-9f6c-24b5-bee56263008e@fujitsu.com>
 <ZhaY2_cO6CrQFCt3@x1n> <Zhfxoaz9yNTx8Btd@x1n>
 <CAHEcVy7POArt+CmY8dyNTzLJp3XxXgjh3k8=C=9K+_cw1CSJFA@mail.gmail.com>
 <46f5e323-632d-7bda-f2c5-3cfa7b1c6b68@akamai.com>
 <Zi-1OvxA5MIHjklU@x1n> <877cgfe2yw.fsf@pond.sub.org>
 <ZjClMb-6MddpvHqQ@redhat.com> <ZjJgQcPQ29HJsTpY@x1n>
 <ZjJm6rcqS5EhoKgK@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZjJm6rcqS5EhoKgK@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.897,
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

On Wed, May 01, 2024 at 04:59:38PM +0100, Daniel P. Berrangé wrote:
> On Wed, May 01, 2024 at 11:31:13AM -0400, Peter Xu wrote:
> > What I worry more is whether this is really what we want to keep rdma in
> > qemu, and that's also why I was trying to request for some serious
> > performance measurements comparing rdma v.s. nics.  And here when I said
> > "we" I mean both QEMU community and any company that will support keeping
> > rdma around.
> > 
> > The problem is if NICs now are fast enough to perform at least equally
> > against rdma, and if it has a lower cost of overall maintenance, does it
> > mean that rdma migration will only be used by whoever wants to keep them in
> > the products and existed already?  In that case we should simply ask new
> > users to stick with tcp, and rdma users should only drop but not increase.
> > 
> > It seems also destined that most new migration features will not support
> > rdma: see how much we drop old features in migration now (which rdma
> > _might_ still leverage, but maybe not), and how much we add mostly multifd
> > relevant which will probably not apply to rdma at all.  So in general what
> > I am worrying is a both-loss condition, if the company might be easier to
> > either stick with an old qemu (depending on whether other new features are
> > requested to be used besides RDMA alone), or do periodic rebase with RDMA
> > downstream only.
> 
> I don't know much about the originals of RDMA support in QEMU and why
> this particular design was taken. It is indeed a huge maint burden to
> have a completely different code flow for RDMA with 4000+ lines of
> custom protocol signalling which is barely understandable.
> 
> I would note that /usr/include/rdma/rsocket.h provides a higher level
> API that is a 1-1 match of the normal kernel 'sockets' API. If we had
> leveraged that, then QIOChannelSocket class and the QAPI SocketAddress
> type could almost[1] trivially have supported RDMA. There would have
> been almost no RDMA code required in the migration subsystem, and all
> the modern features like compression, multifd, post-copy, etc would
> "just work".
> 
> I guess the 'rsocket.h' shim may well limit some of the possible
> performance gains, but it might still have been a better tradeoff
> to have not quite so good peak performance, but with massively
> less maint burden.

My understanding so far is RDMA is sololy for performance but nothing else,
then it's a question on whether rdma existing users would like to do so if
it will run slower.

Jinpu mentioned on the explicit usages of ib verbs but I am just mostly
quotting that word as I don't really know such details:

https://lore.kernel.org/qemu-devel/CAMGffEm2TWJxOPcNQTQ1Sjytf5395dBzTCMYiKRqfxDzJwSN6A@mail.gmail.com/

So not sure whether that applies here too, in that having qiochannel
wrapper may not allow direct access to those ib verbs.

Thanks,

> 
> With regards,
> Daniel
> 
> [1] "almost" trivially, because the poll() integration for rsockets
>     requires a bit more magic sauce since rsockets FDs are not
>     really FDs from the kernel's POV. Still, QIOCHannel likely can
>     abstract that probme.
> -- 
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
> 

-- 
Peter Xu


