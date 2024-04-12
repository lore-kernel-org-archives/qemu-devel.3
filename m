Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 103F7C00A94
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2024 14:05:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvHVz-000222-4Z; Fri, 12 Apr 2024 10:04:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rvHVy-00021p-4m
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 10:04:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rvHVv-0007SX-VV
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 10:04:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712930663;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zLPXq62KRww5CQ12vH/oVDAiL58c/oGk9QhddVff1AM=;
 b=T9di+LU4YCrw2Ftt9nNoj68C1VmpBDRpEaR37gKL68o/gfg6PzGQf3nfr1pi7ZaTFWvDrM
 TJjs8mZmz3E8akYusM8qJfAFEAfABa40LwnXo0slE2n7Zwgsehoo8xLWIUM+DQZvJP0S6j
 7vWWCb7VKy7EdzzKoL6GY+1+40lU0+Y=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-nx6Qa0jbORqgmBg3-jPhCg-1; Fri, 12 Apr 2024 10:04:21 -0400
X-MC-Unique: nx6Qa0jbORqgmBg3-jPhCg-1
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-434c15e1ea5so2533311cf.1
 for <qemu-devel@nongnu.org>; Fri, 12 Apr 2024 07:04:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712930661; x=1713535461;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zLPXq62KRww5CQ12vH/oVDAiL58c/oGk9QhddVff1AM=;
 b=ItYLYStz60+lDlvaCKqRCZ1W13G2cDUED6W18ov6KVTNmUaOrNcIEhKnoLt2TuIUT8
 emQdBRtHqQBKeucacPsMEe5bpSC7QNNvT3+CcoOVL/hOoRRiu3ZfK8NS8xTfHm3IpQjh
 GYvHfQmv/PFCtBzen/1qX2pIB/0cPKXpbuSirAPnxPiBwWCq7v2uE9BOy5OqXcqYZlID
 yZPitE2ZWNWgXg2LOvkDV/v6LZrleqFLA/6p4IA6inXJgbelVDYG7qzFgITZLUACnoPN
 TIqORYgKq5X6L0JCIseCQ2vuAszCtNZnSIz8I5EVp9s8ImsX3FGySuM8heGzNZLHCX3z
 I6mQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW3BzmCM9NzCwwDPzWFaWukSFcxYG17vs+SodsnniXxj/hX5aXQmTtiZVcJxfxxoxOBoXDwUhWvlEzCVj0DQnXv8Hm3amg=
X-Gm-Message-State: AOJu0YwGK9dvWuSaWJ9qe1pW1wOYEch05UBOolMrVbcAXC2pNkX3n7bT
 bibeFSyEqpglb6aO6MVnUwhC0rfBYAuGEHo/8AQsCTP5jzQ+SdD/G1VDXvmB7q2Jogw6NPMcf2n
 xCoB9h+9kN1yJW9SAcBXc1+2ebUzHs/Oo3zWG7hD1EKT1fhC++OLi
X-Received: by 2002:a05:622a:d1:b0:434:515e:411d with SMTP id
 p17-20020a05622a00d100b00434515e411dmr2787958qtw.1.1712930660861; 
 Fri, 12 Apr 2024 07:04:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGCD9Jeb2LpMZ6nCCbfrs1gZPYqWwDnEGFXl33cWX+Gg+VkEi/nD7EeZF591XMWW2w+hXT4PQ==
X-Received: by 2002:a05:622a:d1:b0:434:515e:411d with SMTP id
 p17-20020a05622a00d100b00434515e411dmr2787889qtw.1.1712930660006; 
 Fri, 12 Apr 2024 07:04:20 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 f14-20020ac8498e000000b0042f04e421d2sm2247361qtq.24.2024.04.12.07.04.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Apr 2024 07:04:19 -0700 (PDT)
Date: Fri, 12 Apr 2024 10:04:17 -0400
From: Peter Xu <peterx@redhat.com>
To: Yu Zhang <yu.zhang@ionos.com>
Cc: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>,
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
Message-ID: <Zhk_YcYZ09Ga9IyV@x1n>
References: <CAHEcVy50AtvDyCjwPa9Hu+x1wiUF6xf5McGOTHL+wdt3WN3pgA@mail.gmail.com>
 <Zgx3brrz8m0V7HS4@x1n>
 <CAMGffE=i+hVCNaX_31h1D1VW7JGJBqoa9T0qEJe2CDcb9BPiAA@mail.gmail.com>
 <ZhQYu3ZnsIGv2qUZ@x1n>
 <CAMGffEm2TWJxOPcNQTQ1Sjytf5395dBzTCMYiKRqfxDzJwSN6A@mail.gmail.com>
 <ZhWa0YeAb9ySVKD1@x1n>
 <082a21b0-d4d1-9f6c-24b5-bee56263008e@fujitsu.com>
 <ZhaY2_cO6CrQFCt3@x1n> <Zhfxoaz9yNTx8Btd@x1n>
 <CAHEcVy7POArt+CmY8dyNTzLJp3XxXgjh3k8=C=9K+_cw1CSJFA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHEcVy7POArt+CmY8dyNTzLJp3XxXgjh3k8=C=9K+_cw1CSJFA@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.103,
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

Yu,

On Thu, Apr 11, 2024 at 06:36:54PM +0200, Yu Zhang wrote:
> > 1) Either a CI test covering at least the major RDMA paths, or at least
> >     periodically tests for each QEMU release will be needed.
> We use a batch of regression test cases for the stack, which covers the
> test for QEMU. I did such test for most of the QEMU releases planned as
> candidates for rollout.

The least I can think of is a few tests in one release.  Definitely too
less if one release can already break..

> 
> The migration test needs a pair of (either physical or virtual) servers with
> InfiniBand network, which makes it difficult to do on a single server. The
> nested VM could be a possible approach, for which we may need virtual
> InfiniBand network. Is SoftRoCE [1] a choice? I will try it and let you know.
> 
> [1]  https://enterprise-support.nvidia.com/s/article/howto-configure-soft-roce

Does it require a kernel driver?  The less host kernel / hardware /
.. dependencies the better.

I am wondering whether there can be a library doing everything in
userspace, translating RDMA into e.g. socket messages (so maybe ultimately
that's something like IP->rdma->IP.. just to cover the "rdma" procedures),
then that'll work for CI reliably.

Please also see my full list, though, especially entry 4).  Thanks already
for looking for solutions on the tests, but I don't want to waste your time
then found that tests are not enough even if ready.  I think we need people
that understand these stuff well enough, have dedicated time and look after
it.

Thanks,

-- 
Peter Xu


