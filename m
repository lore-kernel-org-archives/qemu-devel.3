Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96D5CCD128A
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2024 13:50:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruYKO-0003X6-Dv; Wed, 10 Apr 2024 09:49:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1ruYKM-0003Vx-5u
 for qemu-devel@nongnu.org; Wed, 10 Apr 2024 09:49:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1ruYKJ-0003y3-HL
 for qemu-devel@nongnu.org; Wed, 10 Apr 2024 09:49:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712756961;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BT5Dkz5bp2rlO5YGzBq+1Pv3yMGWLnPTuyD0ndOH6FA=;
 b=KXpPNe1ZMtQxdqJRw3RxQuF73+4mKui5vDDwFG//oHh8kVIxSvNV7aYvnNEculh6ENWjKg
 vARO4JHj74yYCHXbZdQoKErDkezrFBIDXts13faIotASvTNOY0TacOc6kqf5/2WqDZlv+i
 gBpJP3WIn48df2knhXsQe6znriLHcaM=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-r4RfvsE8NBC_7BdiyGwF6A-1; Wed, 10 Apr 2024 09:49:19 -0400
X-MC-Unique: r4RfvsE8NBC_7BdiyGwF6A-1
Received: by mail-ot1-f71.google.com with SMTP id
 46e09a7af769-6ea11083fbeso855137a34.1
 for <qemu-devel@nongnu.org>; Wed, 10 Apr 2024 06:49:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712756959; x=1713361759;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BT5Dkz5bp2rlO5YGzBq+1Pv3yMGWLnPTuyD0ndOH6FA=;
 b=SOzmc96aKVDd/pcP2NqhL3J2n8h1E4yk8if4qUs/rOvHsWbmPvQ3AOsONNhMzmghlz
 v5rhx0JnPqJQVzJi2Em/POiU00xqf+/cR24ScTJJBn9gjFImDtm79DQSTX7RZO/5mkDj
 T8A43qZGvlZZWspY1b5+fvp7I3Mx4pwIu7gW83CfeShN1RDynSXdfSlJCIs7WvAyxJ3r
 y8RBmAQazJ7Jq5qIeiraRf6i+ka6eZc6qvn8mhZ9+2qvJ4cgtT4y1sJ6OuvbZn40r+aI
 mZyC0RgCyVYzKZ4pxIrfAUpRrPtklKd/+jA0+QGZASlBOZVAOI/nm5Dq0euUVACobfP/
 p7rQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVQ0AeS92tz4lLVxDa2boqax0v6qR6vPChc6Ksgsp6CDFSWFNZ7kOZ9VnJHRhCcff2h+eBoluuggd2RhxtkJnu3WjESH0E=
X-Gm-Message-State: AOJu0YyiL3Q2PTcV+PsDecwVcKal9pugX4rPHRmPB0Eb9kw/i4n/MbhE
 3qhl+t877R4hXbYwDDv967yQ7B9svpbJgxqQtCKaQtuPQZfqq9h0j/Hptt23YWtBnb4mqq7WPYo
 2OJmdec5Fnrb+/Hac6VKP/UIt5qnmpf7TcUBxhHNKhzg+Gf/2c+9X
X-Received: by 2002:a9d:7a4b:0:b0:6ea:1a31:6be7 with SMTP id
 z11-20020a9d7a4b000000b006ea1a316be7mr3126579otm.1.1712756958815; 
 Wed, 10 Apr 2024 06:49:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGO/4tzS8AgY3C9eGfgVkgd8QOvAcWWmTxp+ZGKhQohkI3kz9t6pgk5/xdRD/mDBdGo/fCRAA==
X-Received: by 2002:a9d:7a4b:0:b0:6ea:1a31:6be7 with SMTP id
 z11-20020a9d7a4b000000b006ea1a316be7mr3126531otm.1.1712756958327; 
 Wed, 10 Apr 2024 06:49:18 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 h20-20020a05620a10b400b0078d60973a51sm3766353qkk.75.2024.04.10.06.49.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Apr 2024 06:49:18 -0700 (PDT)
Date: Wed, 10 Apr 2024 09:49:15 -0400
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
 "pannengyuan@huawei.com" <pannengyuan@huawei.com>
Subject: Re: [PATCH-for-9.1 v2 2/3] migration: Remove RDMA protocol handling
Message-ID: <ZhaY2_cO6CrQFCt3@x1n>
References: <7a510fbe-1c27-4f67-93b8-0d9cf01c1c74@fujitsu.com>
 <ef160e75-d4a4-4be0-81f3-77d8b0e76178@linaro.org>
 <9d082daf-acf0-27c5-1758-5a3f2af7ee0f@fujitsu.com>
 <CAHEcVy50AtvDyCjwPa9Hu+x1wiUF6xf5McGOTHL+wdt3WN3pgA@mail.gmail.com>
 <Zgx3brrz8m0V7HS4@x1n>
 <CAMGffE=i+hVCNaX_31h1D1VW7JGJBqoa9T0qEJe2CDcb9BPiAA@mail.gmail.com>
 <ZhQYu3ZnsIGv2qUZ@x1n>
 <CAMGffEm2TWJxOPcNQTQ1Sjytf5395dBzTCMYiKRqfxDzJwSN6A@mail.gmail.com>
 <ZhWa0YeAb9ySVKD1@x1n>
 <082a21b0-d4d1-9f6c-24b5-bee56263008e@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <082a21b0-d4d1-9f6c-24b5-bee56263008e@fujitsu.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.049,
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

On Wed, Apr 10, 2024 at 02:28:59AM +0000, Zhijian Li (Fujitsu) via wrote:
> 
> 
> on 4/10/2024 3:46 AM, Peter Xu wrote:
> 
> >> Is there document/link about the unittest/CI for migration tests, Why
> >> are those tests missing?
> >> Is it hard or very special to set up an environment for that? maybe we
> >> can help in this regards.
> > See tests/qtest/migration-test.c.  We put most of our migration tests
> > there and that's covered in CI.
> >
> > I think one major issue is CI systems don't normally have rdma devices.
> > Can rdma migration test be carried out without a real hardware?
> 
> Yeah,  RXE aka. SOFT-RoCE is able to emulate the RDMA, for example
> $ sudo rdma link add rxe_eth0 type rxe netdev eth0  # on host
> then we can get a new RDMA interface "rxe_eth0".
> This new RDMA interface is able to do the QEMU RDMA migration.
> 
> Also, the loopback(lo) device is able to emulate the RDMA interface 
> "rxe_lo", however when
> I tried(years ago) to do RDMA migration over this 
> interface(rdma:127.0.0.1:3333) , it got something wrong.
> So i gave up enabling the RDMA migration qtest at that time.

Thanks, Zhijian.

I'm not sure adding an emu-link for rdma is doable for CI systems, though.
Maybe someone more familiar with how CI works can chim in.

-- 
Peter Xu


