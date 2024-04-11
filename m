Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37492C001CC
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2024 14:21:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruvIG-0007c8-7k; Thu, 11 Apr 2024 10:20:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1ruvHx-0007ZF-8x
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 10:20:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1ruvHt-00083c-L4
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 10:20:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712845224;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ltHgYjh8TElJnrgtU1kH1jZJRsfXaGVaW8f0nmmHhlM=;
 b=M15MeNU6EjOeTvB8HujvRxO2qY0tqyLABpE6XYNXaEDL2W3hxC9Nn9lq2Q/XCqiIAiUl6P
 yyxXZ5ebhuUlf9U/g9RZfiPFSC9a/hv4ja/6yrIGGmfWzudRlMSxWpihoyn6OSGPghTv2R
 UYQi9WnZjY7p5OnH/DqSqVw0JSZrGS8=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-182-LyBntOd3Nleng78Yctr5xw-1; Thu, 11 Apr 2024 10:20:22 -0400
X-MC-Unique: LyBntOd3Nleng78Yctr5xw-1
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-4311d908f3cso35115461cf.1
 for <qemu-devel@nongnu.org>; Thu, 11 Apr 2024 07:20:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712845222; x=1713450022;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ltHgYjh8TElJnrgtU1kH1jZJRsfXaGVaW8f0nmmHhlM=;
 b=NPt1I+DEmmWQ76Vqj/7psXhpSX1ASl3s3Xo5ewXgpgz1sRSc/nA54nAb+G1ArhzylC
 Qu6pKSDWec0DvOr1YNB2AyPE3WNnHZa8hMjC+NN27CEcxmizO6RcMyCy+F5/2w0+6m6u
 5mHtBA2CoC4CdebMgBjyHjamnSNv7aZdnlpctKabNTEBe6xCSSTjXZ0SQMagM6wASuWa
 hewPucF7lim4GOc5xRiraJnJh3Dzhw2XQZrypWLnqvymz99HkByIC+1Z/akwZZkB7ts3
 t2JxdLD6/QoY/PPW1+flj3Ahu8m8c1bBGl1y29qE2lDsXWhswooWsejJTU7UPUaelZKM
 Xc+w==
X-Forwarded-Encrypted: i=1;
 AJvYcCW5A1C4DN8e38jAFkoOHS5VDDCvX3xMhDOoGua+RsSh1g/BbyNXekmrAt3PIspNTjdi3gMQ68xRUihwA7k5EgX3INOAmiY=
X-Gm-Message-State: AOJu0YyeqBhCsvPM9o9Ni0+x7cielX3CBSt43y5nYgkJFi/9dmZKOwyr
 +zoDLtTjF7bHLpDrIr7ScKgfGRv4y09FTdAJXi6wnBWxaE4C2NboO3KhpMETgKUU00iddJ9avgl
 /PIquVooZHn+uyYNx6fUjzSRlkyGTobbaRVFS7lJ5CKedwvczA822
X-Received: by 2002:a05:6214:3018:b0:699:4a1:e12d with SMTP id
 ke24-20020a056214301800b0069904a1e12dmr6131761qvb.0.1712845221981; 
 Thu, 11 Apr 2024 07:20:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE1jqS77wcJh1QaWbXuNrK3Ta9FT0lwLxRJxWC8ml36KodQCd/vNPl3elds4xexuhBPBcwVug==
X-Received: by 2002:a05:6214:3018:b0:699:4a1:e12d with SMTP id
 ke24-20020a056214301800b0069904a1e12dmr6131719qvb.0.1712845221291; 
 Thu, 11 Apr 2024 07:20:21 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 q4-20020a056214018400b0069b32845235sm989892qvr.85.2024.04.11.07.20.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Apr 2024 07:20:21 -0700 (PDT)
Date: Thu, 11 Apr 2024 10:20:17 -0400
From: Peter Xu <peterx@redhat.com>
To: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
Cc: Jinpu Wang <jinpu.wang@ionos.com>, Yu Zhang <yu.zhang@ionos.com>,
 Elmar Gerdes <elmar.gerdes@ionos.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Yuval Shaia <yuval.shaia.ml@gmail.com>, Kevin Wolf <kwolf@redhat.com>,
 Prasanna Kumar Kalever <prasanna.kalever@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Prasanna Kumar Kalever <prasanna4324@gmail.com>,
 "integration@gluster.org" <integration@gluster.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 "devel@lists.libvirt.org" <devel@lists.libvirt.org>,
 Hanna Reitz <hreitz@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Eric Blake <eblake@redhat.com>,
 Song Gao <gaosong@loongson.cn>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>,
 "arei.gonglei@huawei.com" <arei.gonglei@huawei.com>,
 "pannengyuan@huawei.com" <pannengyuan@huawei.com>,
 Fabiano Rosas <farosas@suse.de>, Peter Maydell <peter.maydell@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH-for-9.1 v2 2/3] migration: Remove RDMA protocol handling
Message-ID: <Zhfxoaz9yNTx8Btd@x1n>
References: <ef160e75-d4a4-4be0-81f3-77d8b0e76178@linaro.org>
 <9d082daf-acf0-27c5-1758-5a3f2af7ee0f@fujitsu.com>
 <CAHEcVy50AtvDyCjwPa9Hu+x1wiUF6xf5McGOTHL+wdt3WN3pgA@mail.gmail.com>
 <Zgx3brrz8m0V7HS4@x1n>
 <CAMGffE=i+hVCNaX_31h1D1VW7JGJBqoa9T0qEJe2CDcb9BPiAA@mail.gmail.com>
 <ZhQYu3ZnsIGv2qUZ@x1n>
 <CAMGffEm2TWJxOPcNQTQ1Sjytf5395dBzTCMYiKRqfxDzJwSN6A@mail.gmail.com>
 <ZhWa0YeAb9ySVKD1@x1n>
 <082a21b0-d4d1-9f6c-24b5-bee56263008e@fujitsu.com>
 <ZhaY2_cO6CrQFCt3@x1n>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZhaY2_cO6CrQFCt3@x1n>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.49,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, Apr 10, 2024 at 09:49:15AM -0400, Peter Xu wrote:
> On Wed, Apr 10, 2024 at 02:28:59AM +0000, Zhijian Li (Fujitsu) via wrote:
> > 
> > 
> > on 4/10/2024 3:46 AM, Peter Xu wrote:
> > 
> > >> Is there document/link about the unittest/CI for migration tests, Why
> > >> are those tests missing?
> > >> Is it hard or very special to set up an environment for that? maybe we
> > >> can help in this regards.
> > > See tests/qtest/migration-test.c.  We put most of our migration tests
> > > there and that's covered in CI.
> > >
> > > I think one major issue is CI systems don't normally have rdma devices.
> > > Can rdma migration test be carried out without a real hardware?
> > 
> > Yeah,  RXE aka. SOFT-RoCE is able to emulate the RDMA, for example
> > $ sudo rdma link add rxe_eth0 type rxe netdev eth0  # on host
> > then we can get a new RDMA interface "rxe_eth0".
> > This new RDMA interface is able to do the QEMU RDMA migration.
> > 
> > Also, the loopback(lo) device is able to emulate the RDMA interface 
> > "rxe_lo", however when
> > I tried(years ago) to do RDMA migration over this 
> > interface(rdma:127.0.0.1:3333) , it got something wrong.
> > So i gave up enabling the RDMA migration qtest at that time.
> 
> Thanks, Zhijian.
> 
> I'm not sure adding an emu-link for rdma is doable for CI systems, though.
> Maybe someone more familiar with how CI works can chim in.

Some people got dropped on the cc list for unknown reason, I'm adding them
back (Fabiano, Peter Maydell, Phil).  Let's make sure nobody is dropped by
accident.

I'll try to summarize what is still missing, and I think these will be
greatly helpful if we don't want to deprecate rdma migration:

  1) Either a CI test covering at least the major RDMA paths, or at least
     periodically tests for each QEMU release will be needed.

  2) Some performance tests between modern RDMA and NIC devices are
     welcomed.  The current knowledge is modern NIC can work similarly to
     RDMA in performance, then it's debatable why we still maintain so much
     rdma specific code.

  3) No need to be soild patchsets for this one, but some plan to improve
     RDMA migration code so that it is not almost isolated from the rest
     protocols.

  4) Someone to look after this code for real.

For 2) and 3) more info is here:

https://lore.kernel.org/r/ZhWa0YeAb9ySVKD1@x1n

Here 4) can be the most important as Markus pointed out.  We just didn't
get there yet on the discussions, but maybe Markus is right that we should
talk that first.

Thanks,

-- 
Peter Xu


