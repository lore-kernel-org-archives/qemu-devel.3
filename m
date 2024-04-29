Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2887CC4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 14:57:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1SRR-0002Ml-4g; Mon, 29 Apr 2024 10:57:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1s1SRO-0002Kz-Ib
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 10:57:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1s1SRM-0000LC-IV
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 10:57:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714402629;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qK4b3nMBMYdROFOc8wmDagpgfl63KreIleIjeaePmoU=;
 b=RWvzdHdc3plhz6jSjzF+WIUiKmfXtnlVjiu1bAYGXStGg97XWrDE75AajUqbLsnPbaEalL
 ANhPVKpLJ+w1Ao/+KCH9FNWzUCUIEf50X3Xs85fvCNOPcHlOZZXvDScLMtzIkkR7bUSkTt
 5DxB1n+xmA5HgboRVjPPj+w5+/JsvJo=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-249-x1c0EDrKMFul7fmbcx2VPw-1; Mon, 29 Apr 2024 10:57:07 -0400
X-MC-Unique: x1c0EDrKMFul7fmbcx2VPw-1
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-1e44a3f6011so5915815ad.1
 for <qemu-devel@nongnu.org>; Mon, 29 Apr 2024 07:57:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714402626; x=1715007426;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qK4b3nMBMYdROFOc8wmDagpgfl63KreIleIjeaePmoU=;
 b=HG/gPGHB4S3BZr098NScdjj5fyYswK/p8r+aUDb/rUUZ6dp4GK/25/llfVH/QH7gt1
 ZQL9rZAWPwjLz8alt0FR5dDevBdmE4b72Q8DpGPkJjz8S5VPL3CCF1LvFn2Zp8pdFqfo
 UpCvARYMovcSEBqBGqakU/oBtGL6hCEQItS9IrnBEd5sk+zrlLVGeoU73CWfspPeYAAK
 8LfG0Rcr7BYn7Cj6MalvK+rMHxKE72XnlbPtpzrrvnE36kcPRPp6YZP/hOd6IoPNEbB9
 ntwfyRdhWq4nGE7Gb/vzbZxANYCz545KKHbn6Hclvri7I1viraMpMXWEvFUgTEQ1YXlc
 iYPg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUQgBNXZDChxdW71AVwp7Z3PE3599pJh4vupueQP62Hl6XVOUNV7kTBUmRStr53tIo99PVu3BJ5V0q0/3aBHef0UIede60=
X-Gm-Message-State: AOJu0YwWH35ctBcaUKEjHGl/ttGk6W3J62yT3CDYNPCkv9zkjfX0f3YS
 BZdrjiNkrXnwv63IRkyqVxGqYa/sISaxFR/N552JoKOpJEjDgMShHSgSQ35WWxgszOF+l940JbS
 GshEKeRFU8KZyciF/rBunWg6j0j7YgOJhi0D3AcRrlrCza3BLjp6g
X-Received: by 2002:a17:902:ec89:b0:1dc:c28e:2236 with SMTP id
 x9-20020a170902ec8900b001dcc28e2236mr12845607plg.2.1714402626024; 
 Mon, 29 Apr 2024 07:57:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEA+qrNoGaRDcvd5Z4Yi1nE301bw8/WfoQ5tq6xiUgp33FZCmixU62p8LA9sr8j7Kwv6S7N4A==
X-Received: by 2002:a17:902:ec89:b0:1dc:c28e:2236 with SMTP id
 x9-20020a170902ec8900b001dcc28e2236mr12845580plg.2.1714402625281; 
 Mon, 29 Apr 2024 07:57:05 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 f12-20020a170902ce8c00b001e1071cf0bbsm20452221plg.302.2024.04.29.07.57.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Apr 2024 07:57:04 -0700 (PDT)
Date: Mon, 29 Apr 2024 10:56:58 -0400
From: Peter Xu <peterx@redhat.com>
To: Michael Galaxy <mgalaxy@akamai.com>
Cc: Yu Zhang <yu.zhang@ionos.com>,
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
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 "devel@lists.libvirt.org" <devel@lists.libvirt.org>,
 Hanna Reitz <hreitz@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Eric Blake <eblake@redhat.com>,
 Song Gao <gaosong@loongson.cn>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, arei.gonglei@huawei.com,
 pannengyuan@huawei.com
Subject: Re: [PATCH-for-9.1 v2 2/3] migration: Remove RDMA protocol handling
Message-ID: <Zi-1OvxA5MIHjklU@x1n>
References: <Zgx3brrz8m0V7HS4@x1n>
 <CAMGffE=i+hVCNaX_31h1D1VW7JGJBqoa9T0qEJe2CDcb9BPiAA@mail.gmail.com>
 <ZhQYu3ZnsIGv2qUZ@x1n>
 <CAMGffEm2TWJxOPcNQTQ1Sjytf5395dBzTCMYiKRqfxDzJwSN6A@mail.gmail.com>
 <ZhWa0YeAb9ySVKD1@x1n>
 <082a21b0-d4d1-9f6c-24b5-bee56263008e@fujitsu.com>
 <ZhaY2_cO6CrQFCt3@x1n> <Zhfxoaz9yNTx8Btd@x1n>
 <CAHEcVy7POArt+CmY8dyNTzLJp3XxXgjh3k8=C=9K+_cw1CSJFA@mail.gmail.com>
 <46f5e323-632d-7bda-f2c5-3cfa7b1c6b68@akamai.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <46f5e323-632d-7bda-f2c5-3cfa7b1c6b68@akamai.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.987,
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

On Mon, Apr 29, 2024 at 08:08:10AM -0500, Michael Galaxy wrote:
> Hi All (and Peter),

Hi, Michael,

> 
> My name is Michael Galaxy (formerly Hines). Yes, I changed my last name
> (highly irregular for a male) and yes, that's my real last name:
> https://www.linkedin.com/in/mrgalaxy/)
> 
> I'm the original author of the RDMA implementation. I've been discussing
> with Yu Zhang for a little bit about potentially handing over maintainership
> of the codebase to his team.
> 
> I simply have zero access to RoCE or Infiniband hardware at all,
> unfortunately. so I've never been able to run tests or use what I wrote at
> work, and as all of you know, if you don't have a way to test something,
> then you can't maintain it.
> 
> Yu Zhang put a (very kind) proposal forward to me to ask the community if
> they feel comfortable training his team to maintain the codebase (and run
> tests) while they learn about it.

The "while learning" part is fine at least to me.  IMHO the "ownership" to
the code, or say, taking over the responsibility, may or may not need 100%
mastering the code base first.  There should still be some fundamental
confidence to work on the code though as a starting point, then it's about
serious use case to back this up, and careful testings while getting more
familiar with it.

> 
> If you don't mind, I'd like to let him send over his (very detailed)
> proposal,

Yes please, it's exactly the time to share the plan.  The hope is we try to
reach a consensus before or around the middle of this release (9.1).
Normally QEMU has a 3~4 months window for each release and 9.1 schedule is
not yet out, but I think it means we make a decision before or around
middle of June.

Thanks,

> 
> - Michael
> 
> On 4/11/24 11:36, Yu Zhang wrote:
> > > 1) Either a CI test covering at least the major RDMA paths, or at least
> > >      periodically tests for each QEMU release will be needed.
> > We use a batch of regression test cases for the stack, which covers the
> > test for QEMU. I did such test for most of the QEMU releases planned as
> > candidates for rollout.
> > 
> > The migration test needs a pair of (either physical or virtual) servers with
> > InfiniBand network, which makes it difficult to do on a single server. The
> > nested VM could be a possible approach, for which we may need virtual
> > InfiniBand network. Is SoftRoCE [1] a choice? I will try it and let you know.
> > 
> > [1]  https://urldefense.com/v3/__https://enterprise-support.nvidia.com/s/article/howto-configure-soft-roce__;!!GjvTz_vk!VEqNfg3Kdf58Oh1FkGL6ErDLfvUXZXPwMTaXizuIQeIgJiywPzuwbqx8wM0KUsyopw_EYQxWvGHE3ig$
> > 
> > Thanks and best regards!
> > 
> > On Thu, Apr 11, 2024 at 4:20 PM Peter Xu <peterx@redhat.com> wrote:
> > > On Wed, Apr 10, 2024 at 09:49:15AM -0400, Peter Xu wrote:
> > > > On Wed, Apr 10, 2024 at 02:28:59AM +0000, Zhijian Li (Fujitsu) via wrote:
> > > > > 
> > > > > on 4/10/2024 3:46 AM, Peter Xu wrote:
> > > > > 
> > > > > > > Is there document/link about the unittest/CI for migration tests, Why
> > > > > > > are those tests missing?
> > > > > > > Is it hard or very special to set up an environment for that? maybe we
> > > > > > > can help in this regards.
> > > > > > See tests/qtest/migration-test.c.  We put most of our migration tests
> > > > > > there and that's covered in CI.
> > > > > > 
> > > > > > I think one major issue is CI systems don't normally have rdma devices.
> > > > > > Can rdma migration test be carried out without a real hardware?
> > > > > Yeah,  RXE aka. SOFT-RoCE is able to emulate the RDMA, for example
> > > > > $ sudo rdma link add rxe_eth0 type rxe netdev eth0  # on host
> > > > > then we can get a new RDMA interface "rxe_eth0".
> > > > > This new RDMA interface is able to do the QEMU RDMA migration.
> > > > > 
> > > > > Also, the loopback(lo) device is able to emulate the RDMA interface
> > > > > "rxe_lo", however when
> > > > > I tried(years ago) to do RDMA migration over this
> > > > > interface(rdma:127.0.0.1:3333) , it got something wrong.
> > > > > So i gave up enabling the RDMA migration qtest at that time.
> > > > Thanks, Zhijian.
> > > > 
> > > > I'm not sure adding an emu-link for rdma is doable for CI systems, though.
> > > > Maybe someone more familiar with how CI works can chim in.
> > > Some people got dropped on the cc list for unknown reason, I'm adding them
> > > back (Fabiano, Peter Maydell, Phil).  Let's make sure nobody is dropped by
> > > accident.
> > > 
> > > I'll try to summarize what is still missing, and I think these will be
> > > greatly helpful if we don't want to deprecate rdma migration:
> > > 
> > >    1) Either a CI test covering at least the major RDMA paths, or at least
> > >       periodically tests for each QEMU release will be needed.
> > > 
> > >    2) Some performance tests between modern RDMA and NIC devices are
> > >       welcomed.  The current knowledge is modern NIC can work similarly to
> > >       RDMA in performance, then it's debatable why we still maintain so much
> > >       rdma specific code.
> > > 
> > >    3) No need to be soild patchsets for this one, but some plan to improve
> > >       RDMA migration code so that it is not almost isolated from the rest
> > >       protocols.
> > > 
> > >    4) Someone to look after this code for real.
> > > 
> > > For 2) and 3) more info is here:
> > > 
> > > https://urldefense.com/v3/__https://lore.kernel.org/r/ZhWa0YeAb9ySVKD1@x1n__;!!GjvTz_vk!VEqNfg3Kdf58Oh1FkGL6ErDLfvUXZXPwMTaXizuIQeIgJiywPzuwbqx8wM0KUsyopw_EYQxWpIWYBhQ$
> > > 
> > > Here 4) can be the most important as Markus pointed out.  We just didn't
> > > get there yet on the discussions, but maybe Markus is right that we should
> > > talk that first.
> > > 
> > > Thanks,
> > > 
> > > --
> > > Peter Xu
> > > 
> 

-- 
Peter Xu


