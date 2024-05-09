Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65A2DC10F1A
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2024 14:14:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s54XA-0003AC-22; Thu, 09 May 2024 10:14:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1s54X2-000399-LU
 for qemu-devel@nongnu.org; Thu, 09 May 2024 10:14:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1s54X0-0007VL-TH
 for qemu-devel@nongnu.org; Thu, 09 May 2024 10:14:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715264038;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XTRFLcihei5WAImanRiY0l7BIefVx0NSIoAh8V8qGZA=;
 b=Eta0icnr8RRfN9Dtfjzsb4M0YPlxvhDieuWehrZ1spuC8CobFpS3pRPMKMdqp7jG1wVQ5P
 czx9WqXOITRIHTCxgUxeWwrYGV0fQwdAgXb5G7jxDvh7lGE3MTDH87SLiozCS0uAsfhDse
 gAD/OFSnQ8uF0gAGqPsNwdD99HVsb+Y=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-Uj3P7Gd5P7O3wmQgHSpwhA-1; Thu, 09 May 2024 10:13:57 -0400
X-MC-Unique: Uj3P7Gd5P7O3wmQgHSpwhA-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-6a0f87048e6so3822816d6.3
 for <qemu-devel@nongnu.org>; Thu, 09 May 2024 07:13:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715264036; x=1715868836;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XTRFLcihei5WAImanRiY0l7BIefVx0NSIoAh8V8qGZA=;
 b=aEY4ydjwaoPP3gVtsO7FzC9fqQv6Q+BZNT+u8xrLNB8MGNsgmEbH/cr9iBhLLg5U+F
 OF1qbZuYEUdbOR+G6vaRv4qGEIw1zZ58j8kF2nX5/5qFp2NFG4uO8LMB9AqbdGsBJh+B
 jn+bTm8YzuxmJBICXCLLsoiVTF0FIDJZh7tjaTSkeiu0r7LrJafDRGGqVx7GYt9fhRfs
 9G2kfYjKQbnprLfMeNFEWUL3ONAuEK8PUKxfrx6kPpK4WFofTtWWR6mjTmikN8Zt/hCv
 tX0RoPTb7UFlUiLgP9mE3UZlf1qIrN0scHxkNin/ARTLPIdshh2INlvZ+5M5hnoB7YSV
 50fQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXEbBu9fydr0eelvplEbQcfq2EdL5bHGRdt6X4IrzijKolKo1BCWjSULitWW3czCQMaE2yjIHtHjeMD/MQs5NfCoYkpvSI=
X-Gm-Message-State: AOJu0YzEGVckaBjHOAK95uhsbBlAhvfw3tB8VFdiJe3X81gCBBAx6tVL
 sY4TMGiruPjCFta2ObSAkx1n8iDWCmNoyUKupfkr/Dmvp7e6fTHT8rd3MSbYp/j2ONnL4JgUkP5
 dgZFh8Hf2q4MfSfSdwRZg1xrZovashyfWEU7kgkfL6EGBex3DRNbi
X-Received: by 2002:a05:620a:40cb:b0:790:e856:7cc9 with SMTP id
 af79cd13be357-792b2777207mr627708585a.1.1715264036113; 
 Thu, 09 May 2024 07:13:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF+KplhegT8yBXmM+9EAVQM8Smn3vxdX2sGMJNVQkpNW5OgObfHVLnewMoT6GaQw8R0h1o67w==
X-Received: by 2002:a05:620a:40cb:b0:790:e856:7cc9 with SMTP id
 af79cd13be357-792b2777207mr627696185a.1.1715264034815; 
 Thu, 09 May 2024 07:13:54 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-792bf2a3e3esm72355885a.68.2024.05.09.07.13.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 May 2024 07:13:54 -0700 (PDT)
Date: Thu, 9 May 2024 10:13:52 -0400
From: Peter Xu <peterx@redhat.com>
To: Zheng Chuan <zhengchuan@huawei.com>
Cc: "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
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
 Beraldo Leal <bleal@redhat.com>, Pannengyuan <pannengyuan@huawei.com>,
 Xiexiangyou <xiexiangyou@huawei.com>
Subject: Re: [PATCH-for-9.1 v2 2/3] migration: Remove RDMA protocol handling
Message-ID: <ZjzaIAMgUHV8zdNz@x1n>
References: <46f5e323-632d-7bda-f2c5-3cfa7b1c6b68@akamai.com>
 <Zi-1OvxA5MIHjklU@x1n> <877cgfe2yw.fsf@pond.sub.org>
 <ZjClMb-6MddpvHqQ@redhat.com> <ZjJgQcPQ29HJsTpY@x1n>
 <7e902e4e576a4e199e36d28f99bd55e5@huawei.com>
 <Zjj0xa-3KrFHTK0S@x1n>
 <addaa8d094904315a466533763689ead@huawei.com>
 <ZjpWmG2aUJLkYxJm@x1n>
 <13ce4f9e-1e7c-24a9-0dc9-c40962979663@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <13ce4f9e-1e7c-24a9-0dc9-c40962979663@huawei.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Thu, May 09, 2024 at 04:58:34PM +0800, Zheng Chuan via wrote:
> That's a good news to see the socket abstraction for RDMA!
> When I was developed the series above, the most pain is the RDMA migration has no QIOChannel abstraction and i need to take a 'fake channel'
> for it which is awkward in code implementation.
> So, as far as I know, we can do this by
> i. the first thing is that we need to evaluate the rsocket is good enough to satisfy our QIOChannel fundamental abstraction
> ii. if it works right, then we will continue to see if it can give us opportunity to hide the detail of rdma protocol
>     into rsocket by remove most of code in rdma.c and also some hack in migration main process.
> iii. implement the advanced features like multi-fd and multi-uri for rdma migration.
> 
> Since I am not familiar with rsocket, I need some times to look at it and do some quick verify with rdma migration based on rsocket.
> But, yes, I am willing to involved in this refactor work and to see if we can make this migration feature more better:）

Based on what we have now, it looks like we'd better halt the deprecation
process a bit, so I think we shouldn't need to rush it at least in 9.1
then, and we'll need to see how it goes on the refactoring.

It'll be perfect if rsocket works, otherwise supporting multifd with little
overhead / exported APIs would also be a good thing in general with
whatever approach.  And obviously all based on the facts that we can get
resources from companies to support this feature first.

Note that so far nobody yet compared with rdma v.s. nic perf, so I hope if
any of us can provide some test results please do so.  Many people are
saying RDMA is better, but I yet didn't see any numbers comparing it with
modern TCP networks.  I don't want to have old impressions floating around
even if things might have changed..  When we have consolidated results, we
should share them out and also reflect that in QEMU's migration docs when a
rdma document page is ready.

Chuan, please check the whole thread discussion, it may help to understand
what we are looking for on rdma migrations [1].  Meanwhile please feel free
to sync with Jinpu's team and see how to move forward with such a project.

[1] https://lore.kernel.org/qemu-devel/87frwatp7n.fsf@suse.de/

Thanks,

-- 
Peter Xu


