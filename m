Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A2AFC10F16
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 15:20:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s407m-00017p-Lo; Mon, 06 May 2024 11:19:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1s407K-00012d-OG
 for qemu-devel@nongnu.org; Mon, 06 May 2024 11:19:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1s407J-0003wb-78
 for qemu-devel@nongnu.org; Mon, 06 May 2024 11:19:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715008740;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5DH2eLQh9nsU8lQj7GQu/H8O+eAi10yYDcbwZEz4dxA=;
 b=BK5CkFFvT350b0Y6KrAQryXv66pLmvIlwk6HF0N5pSRQY+E4EnmVgAgIaYKpNNcKEIbqpL
 Dv5kHlvmw3dyyi69n+P2GgvmAs7McoX0jFHa28jG6MTp+Aj8wLtfOGRsYmz5n5xPnpbI4D
 AcMSVJMbQK4nwbMbqjHjfazHts69WKE=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-TAg5wabKOT-zmuYkwXXtZA-1; Mon, 06 May 2024 11:18:57 -0400
X-MC-Unique: TAg5wabKOT-zmuYkwXXtZA-1
Received: by mail-yb1-f199.google.com with SMTP id
 3f1490d57ef6-de5555a937fso200674276.0
 for <qemu-devel@nongnu.org>; Mon, 06 May 2024 08:18:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715008736; x=1715613536;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5DH2eLQh9nsU8lQj7GQu/H8O+eAi10yYDcbwZEz4dxA=;
 b=a4TrOzL8EZMSP9Mtm0qyDk8TQsWhlj9sKwllcJpguiRwrVHhcQ9srt8QuG9iFSMeKc
 Jr0GHnsq/7OM1MxZolH58J/xJhKUKyrnsO9g+kzLK5aPf9WKVrSbow5W2c8hpguaTlZh
 l3ZrQxZ+2SHUPWD+bJW50D7yG+SJ6FE1dO/g0+2o7NqMnuOy/6o9B+oQo0CCCFgkV1E5
 fh14njoHG6aEWGLqhYbc5hWB0mPAAKI63hJujwGhuDgICUPBc64j7ajpScnPHk+jAHFy
 tpp0uzEQSIWAi3F1hgQngMaMdVsLPY1O7XIaVPSgE6K/+m+DIvBMccDDsjiJame/Ok+Y
 b5cA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWXaDeg5JaiS+hI96rOGk077jHge2v7Vms90LzzsuRqwrv+nL4ZKr0fIL33STyx1FbNt8B7CKy2B0eXFEI2KJcc4jHoMQ4=
X-Gm-Message-State: AOJu0YyhYjvNu+itQ6XSWmjmuXHKdC2tENgz+JqoaqOKqMWbHOmYtwG4
 E09oxj8xYIIIvHVz/5y7oz+mnNq0cXFEfJE7losC9f9/WGBKXZIf+isD8rRK2gQ0pCpiFSnIDUd
 IPR+seGt+T8k6+RJyvBX5eadOdRr0waDAA6DXVpmFJI5mk3BTCJ/GPYVmlrgw
X-Received: by 2002:a25:b11:0:b0:de5:4f72:46bf with SMTP id
 17-20020a250b11000000b00de54f7246bfmr6757470ybl.5.1715008736012; 
 Mon, 06 May 2024 08:18:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE2P8vnSj7o0hOEUWJd0LHTmXMoHwYdn5ZthRZO2Q5HDFjEwyp86vvjFne4G2kBPrnrVCC/bA==
X-Received: by 2002:a05:620a:4448:b0:790:ec9c:e717 with SMTP id
 w8-20020a05620a444800b00790ec9ce717mr13404904qkp.5.1715008713281; 
 Mon, 06 May 2024 08:18:33 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 m4-20020ae9e004000000b00792a33c1c29sm318455qkk.59.2024.05.06.08.18.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 May 2024 08:18:32 -0700 (PDT)
Date: Mon, 6 May 2024 11:18:29 -0400
From: Peter Xu <peterx@redhat.com>
To: "Gonglei (Arei)" <arei.gonglei@huawei.com>
Cc: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
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
Message-ID: <Zjj0xa-3KrFHTK0S@x1n>
References: <082a21b0-d4d1-9f6c-24b5-bee56263008e@fujitsu.com>
 <ZhaY2_cO6CrQFCt3@x1n> <Zhfxoaz9yNTx8Btd@x1n>
 <CAHEcVy7POArt+CmY8dyNTzLJp3XxXgjh3k8=C=9K+_cw1CSJFA@mail.gmail.com>
 <46f5e323-632d-7bda-f2c5-3cfa7b1c6b68@akamai.com>
 <Zi-1OvxA5MIHjklU@x1n> <877cgfe2yw.fsf@pond.sub.org>
 <ZjClMb-6MddpvHqQ@redhat.com> <ZjJgQcPQ29HJsTpY@x1n>
 <7e902e4e576a4e199e36d28f99bd55e5@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7e902e4e576a4e199e36d28f99bd55e5@huawei.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
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

On Mon, May 06, 2024 at 02:06:28AM +0000, Gonglei (Arei) wrote:
> Hi, Peter

Hey, Lei,

Happy to see you around again after years.

> RDMA features high bandwidth, low latency (in non-blocking lossless
> network), and direct remote memory access by bypassing the CPU (As you
> know, CPU resources are expensive for cloud vendors, which is one of the
> reasons why we introduced offload cards.), which TCP does not have.

It's another cost to use offload cards, v.s. preparing more cpu resources?

> In some scenarios where fast live migration is needed (extremely short
> interruption duration and migration duration) is very useful. To this
> end, we have also developed RDMA support for multifd.

Will any of you upstream that work?  I'm curious how intrusive would it be
when adding it to multifd, if it can keep only 5 exported functions like
what rdma.h does right now it'll be pretty nice.  We also want to make sure
it works with arbitrary sized loads and buffers, e.g. vfio is considering
to add IO loads to multifd channels too.

One thing to note that the question here is not about a pure performance
comparison between rdma and nics only.  It's about help us make a decision
on whether to drop rdma, iow, even if rdma performs well, the community
still has the right to drop it if nobody can actively work and maintain it.
It's just that if nics can perform as good it's more a reason to drop,
unless companies can help to provide good support and work together.

Thanks,

-- 
Peter Xu


