Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A08EC25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 13:34:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCJRY-0003Yi-ED; Wed, 29 May 2024 09:34:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gregsword0@gmail.com>)
 id 1sCCRs-00031d-2B; Wed, 29 May 2024 02:06:08 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gregsword0@gmail.com>)
 id 1sCCRp-0003CX-DW; Wed, 29 May 2024 02:06:07 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-6f8ecafd28cso1278445b3a.3; 
 Tue, 28 May 2024 23:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716962763; x=1717567563; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bEgMQmsoY6w77UNCa3Z5qcf9/UXUdDI7rLaVDP7lhWk=;
 b=Iq+QDw4DEeGF2XNQxfSTOqZY7kdfOyZQgLJ2u9UBb9YS8aeknCq8vV0GygxyFCr3A2
 9kjPDmtf/Cnd/+T+J0FXjH8S7tncwtfnzVVgoQzl4B7EfrcGaskfy3BTRydcWuwxEJ37
 lqiFRofJhv9Maz72SP0KtJ9JPH8oQhvMwhj/Ye8+G5UO8Rg+eIGyf7H3bZTGWJr6B+e3
 IQVYJDwfS8BF8kzSPih1Q5XUnLBZuaYnOcPcwtU86ejgEzGpOm6N0IuWVhILtjh5cmgh
 WjghXvMAb7/1LgK9S0iLMzk82v7RxNxeFYwOfqGotKpt6reytr4lZ+hLb4ElpZllcs31
 8+eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716962763; x=1717567563;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bEgMQmsoY6w77UNCa3Z5qcf9/UXUdDI7rLaVDP7lhWk=;
 b=AyQUPEldNGLI7V1CyXGOOfQcBVQ5vuKdkYDx0opmmbKZwr+s8aJssbUecV3jJW73q0
 Zs1L/G2e8gF2NqgQRRiixwXsZIVXRNAfEk2GcnwtjqSPU1Bqzh+M/FR9C/pUs5R/c7Y7
 cuy4OKijW8E83wXaN9v3NhHbro7mudCx1v9HURfi/xtjk1/DlLS1y9WmO8QYIueQoRj/
 pvXE8LXKRoEtl/pQq92RPHQzcVlYOWvBZyc1D7MCKOMGxNaOxp0MqHwVfdyupGaC149I
 biLoHzOD6iRMnT4piEZZcR1Bcs3SjvusfVBJQnfIy6IYGhCoiuoKMZA99WpQ9IXQiHEf
 jeDQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCURf56n4q6xvTnAZV7WsJaDTGIq6GYU3qVic/Mb/easHFRaWkwsRXrPW2i7dsp6wLr8DKYfJoRdZ2hPCB9HjsyJNgjwtJfFVypBcn/Zpip9xaut1cFNFdtbscPfng==
X-Gm-Message-State: AOJu0Yy5iPhIG8iME9hqlmYfiq5lQsbMSvA1SiC0HPaUNpyjQpkMbWUV
 34+gQkpRSwM5CU6MRFtMgY/r+DcKETxqOkkbjrS8Nql08oawqHEVRNQpT7qP9XOoDda3d3y2O2G
 f/9cDweZBV+cyT3mlSJqnyBzDYbE=
X-Google-Smtp-Source: AGHT+IE7LTWSBj8XmYSLzZMgQYYFw3ve7P+UkkueGO919dc1QddwFfptKMgBO6ImETtbEC9BOJvX62jjxJZL7pRYxmg=
X-Received: by 2002:a05:6300:808c:b0:1af:fbab:cf92 with SMTP id
 adf61e73a8af0-1b212f74721mr14358553637.54.1716962763038; Tue, 28 May 2024
 23:06:03 -0700 (PDT)
MIME-Version: 1.0
References: <Zjj0xa-3KrFHTK0S@x1n>
 <addaa8d094904315a466533763689ead@huawei.com>
 <ZjpWmG2aUJLkYxJm@x1n> <13ce4f9e-1e7c-24a9-0dc9-c40962979663@huawei.com>
 <ZjzaIAMgUHV8zdNz@x1n>
 <CAHEcVy48Mcup3d3FgYh_oPtV-M9CZBVr4G_9jyg2K+8Esi0WGA@mail.gmail.com>
 <04769507-ac37-495d-a797-e05084d73e64@akamai.com>
 <CAHEcVy4d7uJENZ1hRx2FBzbw22qN4Qm0TwtxvM5DLw3s81Zp_g@mail.gmail.com>
 <Zk0c51D1Oo6NdIxR@x1n> <2308a8b894244123b638038e40a33990@huawei.com>
 <ZlX-Swq4Hi-0iHeh@x1n> <7bf81ccee4bd4b0e81e3893ef43502a8@huawei.com>
 <CAMGffEmGDDxttMhYWCBWwhb_VmjU+ZeOCzwaJyZOTi=yH_jKRg@mail.gmail.com>
In-Reply-To: <CAMGffEmGDDxttMhYWCBWwhb_VmjU+ZeOCzwaJyZOTi=yH_jKRg@mail.gmail.com>
From: Greg Sword <gregsword0@gmail.com>
Date: Wed, 29 May 2024 14:05:51 +0800
Message-ID: <CAEz=LcuNM-j=1txyiL4_A89vZLxTicOFHXLC0=piamvqF4gu0g@mail.gmail.com>
Subject: Re: [PATCH-for-9.1 v2 2/3] migration: Remove RDMA protocol handling
To: Jinpu Wang <jinpu.wang@ionos.com>
Cc: "Gonglei (Arei)" <arei.gonglei@huawei.com>, Peter Xu <peterx@redhat.com>, 
 Yu Zhang <yu.zhang@ionos.com>, Michael Galaxy <mgalaxy@akamai.com>, 
 Elmar Gerdes <elmar.gerdes@ionos.com>, zhengchuan <zhengchuan@huawei.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>,
 "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>, 
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Yuval Shaia <yuval.shaia.ml@gmail.com>, Kevin Wolf <kwolf@redhat.com>,
 Prasanna Kumar Kalever <prasanna.kalever@redhat.com>, 
 Cornelia Huck <cohuck@redhat.com>, Michael Roth <michael.roth@amd.com>, 
 Prasanna Kumar Kalever <prasanna4324@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "devel@lists.libvirt.org" <devel@lists.libvirt.org>, 
 Hanna Reitz <hreitz@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Thomas Huth <thuth@redhat.com>, 
 Eric Blake <eblake@redhat.com>, Song Gao <gaosong@loongson.cn>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, 
 Pannengyuan <pannengyuan@huawei.com>, Xiexiangyou <xiexiangyou@huawei.com>, 
 Fabiano Rosas <farosas@suse.de>, RDMA mailing list <linux-rdma@vger.kernel.org>,
 shefty@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=gregsword0@gmail.com; helo=mail-pf1-x433.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 29 May 2024 09:34:10 -0400
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

On Wed, May 29, 2024 at 12:33=E2=80=AFPM Jinpu Wang <jinpu.wang@ionos.com> =
wrote:
>
> On Wed, May 29, 2024 at 4:43=E2=80=AFAM Gonglei (Arei) <arei.gonglei@huaw=
ei.com> wrote:
> >
> > Hi,
> >
> > > -----Original Message-----
> > > From: Peter Xu [mailto:peterx@redhat.com]
> > > Sent: Tuesday, May 28, 2024 11:55 PM
> > > > > > Exactly, not so compelling, as I did it first only on servers
> > > > > > widely used for production in our data center. The network
> > > > > > adapters are
> > > > > >
> > > > > > Ethernet controller: Broadcom Inc. and subsidiaries NetXtreme
> > > > > > BCM5720 2-port Gigabit Ethernet PCIe
> > > > >
> > > > > Hmm... I definitely thinks Jinpu's Mellanox ConnectX-6 looks more
> > > reasonable.
> > > > >
> > > > >
> > > https://lore.kernel.org/qemu-devel/CAMGffEn-DKpMZ4tA71MJYdyemg0Zda15
> > > > > wVAqk81vXtKzx-LfJQ@mail.gmail.com/
> > > > >
> > > > > Appreciate a lot for everyone helping on the testings.
> > > > >
> > > > > > InfiniBand controller: Mellanox Technologies MT27800 Family
> > > > > > [ConnectX-5]
> > > > > >
> > > > > > which doesn't meet our purpose. I can choose RDMA or TCP for VM
> > > > > > migration. RDMA traffic is through InfiniBand and TCP through
> > > > > > Ethernet on these two hosts. One is standby while the other is =
active.
> > > > > >
> > > > > > Now I'll try on a server with more recent Ethernet and InfiniBa=
nd
> > > > > > network adapters. One of them has:
> > > > > > BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller (rev 01=
)
> > > > > >
> > > > > > The comparison between RDMA and TCP on the same NIC could make
> > > > > > more
> > > > > sense.
> > > > >
> > > > > It looks to me NICs are powerful now, but again as I mentioned I
> > > > > don't think it's a reason we need to deprecate rdma, especially i=
f
> > > > > QEMU's rdma migration has the chance to be refactored using rsock=
et.
> > > > >
> > > > > Is there anyone who started looking into that direction?  Would i=
t
> > > > > make sense we start some PoC now?
> > > > >
> > > >
> > > > My team has finished the PoC refactoring which works well.
> > > >
> > > > Progress:
> > > > 1.  Implement io/channel-rdma.c,
> > > > 2.  Add unit test tests/unit/test-io-channel-rdma.c and verifying i=
t
> > > > is successful, 3.  Remove the original code from migration/rdma.c, =
4.
> > > > Rewrite the rdma_start_outgoing_migration and
> > > > rdma_start_incoming_migration logic, 5.  Remove all rdma_xxx functi=
ons
> > > > from migration/ram.c. (to prevent RDMA live migration from pollutin=
g the
> > > core logic of live migration), 6.  The soft-RoCE implemented by softw=
are is
> > > used to test the RDMA live migration. It's successful.
> > > >
> > > > We will be submit the patchset later.
> > >
> > > That's great news, thank you!
> > >
> > > --
> > > Peter Xu
> >
> > For rdma programming, the current mainstream implementation is to use r=
dma_cm to establish a connection, and then use verbs to transmit data.
> >
> > rdma_cm and ibverbs create two FDs respectively. The two FDs have diffe=
rent responsibilities. rdma_cm fd is used to notify connection establishmen=
t events,
> > and verbs fd is used to notify new CQEs. When poll/epoll monitoring is =
directly performed on the rdma_cm fd, only a pollin event can be monitored,=
 which means
> > that an rdma_cm event occurs. When the verbs fd is directly polled/epol=
led, only the pollin event can be listened, which indicates that a new CQE =
is generated.
> >
> > Rsocket is a sub-module attached to the rdma_cm library and provides rd=
ma calls that are completely similar to socket interfaces. However, this li=
brary returns
> > only the rdma_cm fd for listening to link setup-related events and does=
 not expose the verbs fd (readable and writable events for listening to dat=
a). Only the rpoll
> > interface provided by the RSocket can be used to listen to related even=
ts. However, QEMU uses the ppoll interface to listen to the rdma_cm fd (got=
ten by raccept API).
> > And cannot listen to the verbs fd event. Only some hacking methods can =
be used to address this problem.
> >
> > Do you guys have any ideas? Thanks.
> +cc linux-rdma

Why include rdma community?

> +cc Sean
>
>
>
> >
> >
> > Regards,
> > -Gonglei
>

