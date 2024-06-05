Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D160C25B76
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 21:19:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEy23-0007ow-3H; Wed, 05 Jun 2024 17:18:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sEy1z-0007nP-8S
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 17:18:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sEy1t-00043R-Q9
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 17:18:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717622324;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0qDrUzD2QsqVidyOnu5RGSYDufCOrzbBQ/FVfAKTwKE=;
 b=VksszJ2D4PExCA9/xE2zs0s64OH+j9oFUfHNuYMFuhnrQLV0whEvmhtx+fYAq21ODjAjMQ
 wwZV03aUKbYYi6yYMP+ncvfGc6UoB98dFPXFfq/TiREszNipZoZK2Kfw8IhGQ0liStbwgB
 57jw/GKCu847M+qCLjRVqTbcFJbxwzY=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-119-7A6sXAoaMdu57JBvUA0rsA-1; Wed, 05 Jun 2024 17:18:42 -0400
X-MC-Unique: 7A6sXAoaMdu57JBvUA0rsA-1
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-43ffb7cebdbso298481cf.1
 for <qemu-devel@nongnu.org>; Wed, 05 Jun 2024 14:18:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717622322; x=1718227122;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0qDrUzD2QsqVidyOnu5RGSYDufCOrzbBQ/FVfAKTwKE=;
 b=OpWA0URIfVhOrnpwPJjjEWaKQmV+D1XdimsoMNJgOmw1yoLFQz0iFkgFjv0t9b06D9
 qzqQFnimlEeTTCavhDFRnnzW917jvT9x2ZnHqAeeB7DTRLzt6qNMXM0o5bTd/ovA/7ry
 A/P/B9sPn4gJ6oEid2Q8MWaocqgnDeRvH2NBqRH8g4ASHKIwXJusEsF820vw8KQd7TSy
 kWpslT//Ywf9cTjS1fXI3wfOY707ccuG9ZX7L17ploN8jRVIHdHXBXVbEQnlTdyjkTZk
 fij6Q7VijOqqLDr9hOl1zc+GaNR2lcisO2R8c9EwZ5Th+V+VuqK4PuY24Dhrd9yo9wU/
 BQ3Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWmPSpBADmuZpRN+oaUYB5pdSz40yje+JPlJDniBBo6h4DAhqWGUVjcZeq0TtJdYRefBbGGT3ldasPvAmYM62Sg9UvZEYo=
X-Gm-Message-State: AOJu0YyD4gxWjmTB84lr8HrA8CWNcE4P77mYcsxvnl/ScjEI+GiDu1P3
 5ip07CyxV6C0n8oJfCUsm0GMkNX3sFXarIydphHwU4nz+XrHP1FVaG0CZlzPnizGxoHLcgK1X2Z
 qJl0fGznpfCdGefHu6cQ/mTuyJc02HLHeVSOSIg4ckuyiceotTTOz
X-Received: by 2002:a05:620a:290b:b0:794:c6a0:258a with SMTP id
 af79cd13be357-79523d97230mr397231885a.4.1717622322062; 
 Wed, 05 Jun 2024 14:18:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGm1wvQdZr+RhwdSCkJIusK9ypevr/zgAzD2oNeBLhHd6Zu8G2fCNRq8exjIgmpTZlWS9vjwQ==
X-Received: by 2002:a05:620a:290b:b0:794:c6a0:258a with SMTP id
 af79cd13be357-79523d97230mr397230285a.4.1717622321457; 
 Wed, 05 Jun 2024 14:18:41 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7952db5fec8sm36278685a.48.2024.06.05.14.18.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jun 2024 14:18:40 -0700 (PDT)
Date: Wed, 5 Jun 2024 17:18:38 -0400
From: Peter Xu <peterx@redhat.com>
To: "Dr. David Alan Gilbert" <dave@treblig.org>
Cc: Michael Galaxy <mgalaxy@akamai.com>, Zheng Chuan <zhengchuan@huawei.com>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Yu Zhang <yu.zhang@ionos.com>,
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
 Beraldo Leal <bleal@redhat.com>, Pannengyuan <pannengyuan@huawei.com>,
 Xiexiangyou <xiexiangyou@huawei.com>
Subject: Re: [PATCH-for-9.1 v2 2/3] migration: Remove RDMA protocol handling
Message-ID: <ZmDWLkBKISvQcA8I@x1n>
References: <ZjJgQcPQ29HJsTpY@x1n>
 <7e902e4e576a4e199e36d28f99bd55e5@huawei.com>
 <Zjj0xa-3KrFHTK0S@x1n>
 <addaa8d094904315a466533763689ead@huawei.com>
 <ZjpWmG2aUJLkYxJm@x1n>
 <13ce4f9e-1e7c-24a9-0dc9-c40962979663@huawei.com>
 <cd93922f-cf58-4a42-854d-0b39c6941905@akamai.com>
 <Zl-x_Az8i4jOwitt@gallifrey> <ZmBx8UDDmO-C1Oqu@x1n>
 <ZmDPHKLkzBO47XRc@gallifrey>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZmDPHKLkzBO47XRc@gallifrey>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Jun 05, 2024 at 08:48:28PM +0000, Dr. David Alan Gilbert wrote:
> > > I just noticed this thread; some random notes from a somewhat
> > > fragmented memory of this:
> > > 
> > >   a) Long long ago, I also tried rsocket; 
> > >       https://lists.gnu.org/archive/html/qemu-devel/2015-01/msg02040.html
> > >      as I remember the library was quite flaky at the time.
> > 
> > Hmm interesting.  There also looks like a thread doing rpoll().
> 
> Yeh, I can't actually remember much more about what I did back then!

Heh, that's understandable and fair. :)

> > I hope Lei and his team has tested >4G mem, otherwise definitely worth
> > checking.  Lei also mentioned there're rsocket bugs they found in the cover
> > letter, but not sure what's that about.
> 
> It would probably be a good idea to keep track of what bugs
> are in flight with it, and try it on a few RDMA cards to see
> what problems get triggered.
> I think I reported a few at the time, but I gave up after
> feeling it was getting very hacky.

Agreed.  Maybe we can have a list of that in the cover letter or even
QEMU's migration/rmda doc page.

Lei, if you think that makes sense please do so in your upcoming posts.
There'll need to have a list of things you encountered in the kernel driver
and it'll be even better if there're further links to read on each problem.

> > > 
> > >   e) Someone made a good suggestion (sorry can't remember who) - that the
> > >      RDMA migration structure was the wrong way around - it should be the
> > >      destination which initiates an RDMA read, rather than the source
> > >      doing a write; then things might become a LOT simpler; you just need
> > >      to send page ranges to the destination and it can pull it.
> > >      That might work nicely for postcopy.
> > 
> > I'm not sure whether it'll still be a problem if rdma recv side is based on
> > zero-copy.  It would be a matter of whether atomicity can be guaranteed so
> > that we don't want the guest vcpus to see a partially copied page during
> > on-flight DMAs.  UFFDIO_COPY (or friend) is currently the only solution for
> > that.
> 
> Yes, but even ignoring that (and the UFFDIO_CONTINUE idea you mention), if
> the destination can issue an RDMA read itself, it doesn't need to send messages
> to the source to ask for a page fetch; it just goes and grabs it itself,
> that's got to be good for latency.

Oh, that's pretty internal stuff of rdma to me and beyond my knowledge..
but from what I can tell it sounds very reasonable indeed!

Thanks!

-- 
Peter Xu


