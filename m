Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24BE4C25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 11:14:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCHFL-0007GZ-Gq; Wed, 29 May 2024 07:13:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <haris.iqbal@ionos.com>)
 id 1sCHFC-0007Ep-SA
 for qemu-devel@nongnu.org; Wed, 29 May 2024 07:13:22 -0400
Received: from mail-lj1-x234.google.com ([2a00:1450:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <haris.iqbal@ionos.com>)
 id 1sCHF8-0006RO-Es
 for qemu-devel@nongnu.org; Wed, 29 May 2024 07:13:21 -0400
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2e95a74d51fso606921fa.2
 for <qemu-devel@nongnu.org>; Wed, 29 May 2024 04:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ionos.com; s=google; t=1716981191; x=1717585991; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cp7FwyoZGXVo71/jnJJ+Mwe0LKTj87+Ve6G71cZE8Io=;
 b=Ua/sXKlTPE4XcsZsbVXkpYPHr1PH5W05mJRxrY9X0QtdDfdgsG+z934rpbMNSGku80
 4b4uJjyStSXiFfLfLrGDh2tW6aeCoVkz2wrjlLHn3pMYFzEteVfn22Qm0p7oQNlwrrok
 wOsUVV3AkEsPP34UZRtyUlyBoCw26FQEwQYgMgoYmGxdn2xcQN+7GJva/O5t6G8atBUG
 OFeux3KxQ+q3ScZWsara3AbEF4vZWkQyCdSdeKgUtS5CVvsgScZlfa8RzOMgKozK6qGK
 xBK2jdt699jRD297p1v3BDq9GcHxsD/XCx43YhUQQQqE78+XZTj3CCEBfJzldppwses0
 OuqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716981191; x=1717585991;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cp7FwyoZGXVo71/jnJJ+Mwe0LKTj87+Ve6G71cZE8Io=;
 b=GtyX3V9lXYd2PRaBa77I28nSEeYb+ZoL9H7bt1z0lWXG+voHmTfow4655YhEFLEpOD
 s4k59NJuEOTxzzIIe3F4tFuHeTJRayHkynhA1tp+As2KLk1VWGie8jhb7YH4SzZVdetM
 /+XN8yNnZcJLwch4LE+8cp/0qMRiZ0cebVWi+FezBa9xBP30TdRCZotzuAXnd5yo2JHp
 tsfl/jX6Cg9FvzpK+Eim1wqYiQo2nPNdCGzbJyGYcB9gslWjbaLYCog3UpuVygt/F7lj
 YRh9YpykYDX3jcXgcR8xCdmCAT6Q288qm16DMniOVTDEH4fDqEW3ADxCbWxM7gSvE/ba
 TCIw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX3iQ8di1cmqEnUpnGXTup+LEmtWLRTd6r3ldvEQh1wAFqkVxhqKyKQIzDBM6SJBH5XKgt3OVngTyXIIPqqDI9s9FROmy8=
X-Gm-Message-State: AOJu0YxNLxTUbxXfbTCtBMUO3jdSrTzDRBzEV5F2SjeUThzFPCmTWwms
 mxIc4C4B0x+bDNAMveOiq/7FpVI9CaAc2j87nIwlaUMJ3abyMv82lh8bDbiiZtEdHbQXSkvyo2k
 o9jxzOLQPI2yoJdBgmKTXWxaaNms4m3cYhbAMkw==
X-Google-Smtp-Source: AGHT+IH/oUD5Inaeu+o0fI3Za9H1NuIhyJhnk0QSFNQBIW/9hiAhC57rr9W16ylrr2pwHyvL84/OFfeaeDFPgN2U07Y=
X-Received: by 2002:a05:651c:2222:b0:2de:ca7f:c849 with SMTP id
 38308e7fff4ca-2e95b279514mr139412721fa.43.1716981191318; Wed, 29 May 2024
 04:13:11 -0700 (PDT)
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
 <CAEz=LcuNM-j=1txyiL4_A89vZLxTicOFHXLC0=piamvqF4gu0g@mail.gmail.com>
 <e0fa7fc42118407f8731c34f8c192fda@huawei.com>
 <CAMGffEna=8vNm89SkzRknLb7irTit0dBeciuC+_KMp+4U0PtQw@mail.gmail.com>
 <2665934438364f5e9e80ac4564cac2c3@huawei.com>
In-Reply-To: <2665934438364f5e9e80ac4564cac2c3@huawei.com>
From: Haris Iqbal <haris.iqbal@ionos.com>
Date: Wed, 29 May 2024 13:13:00 +0200
Message-ID: <CAJpMwyj_qrj1r1e6SCLzUf_jFn+do+71h08=LmPM-Mv0nFk7nQ@mail.gmail.com>
Subject: Re: [PATCH-for-9.1 v2 2/3] migration: Remove RDMA protocol handling
To: "Gonglei (Arei)" <arei.gonglei@huawei.com>
Cc: Jinpu Wang <jinpu.wang@ionos.com>, Greg Sword <gregsword0@gmail.com>, 
 Peter Xu <peterx@redhat.com>, Yu Zhang <yu.zhang@ionos.com>, 
 Michael Galaxy <mgalaxy@akamai.com>, Elmar Gerdes <elmar.gerdes@ionos.com>, 
 zhengchuan <zhengchuan@huawei.com>,
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
 "shefty@nvidia.com" <shefty@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: permerror client-ip=2a00:1450:4864:20::234;
 envelope-from=haris.iqbal@ionos.com; helo=mail-lj1-x234.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_PERMERROR=0.01 autolearn=unavailable autolearn_force=no
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

Hello,

I am part of the storage kernel team which develops and maintains the
RDMA block storage in IONOS.
We work closely with Jinpu/Yu, and currently I am supporting Jinpu
with this Qemu RDMA work.

On Wed, May 29, 2024 at 11:49=E2=80=AFAM Gonglei (Arei) via
<qemu-devel@nongnu.org> wrote:
>
> Hi,
>
> > -----Original Message-----
> > > >
> > https://lore.kernel.org/qemu-devel/CAMGffEn-DKpMZ4tA71MJYdyemg0Zda
> > > > > > > 15
> > > > > > > > > wVAqk81vXtKzx-LfJQ@mail.gmail.com/
> > > > > > > > >
> > > > > > > > > Appreciate a lot for everyone helping on the testings.
> > > > > > > > >
> > > > > > > > > > InfiniBand controller: Mellanox Technologies MT27800
> > > > > > > > > > Family [ConnectX-5]
> > > > > > > > > >
> > > > > > > > > > which doesn't meet our purpose. I can choose RDMA or TC=
P
> > > > > > > > > > for VM migration. RDMA traffic is through InfiniBand an=
d
> > > > > > > > > > TCP through Ethernet on these two hosts. One is standby
> > > > > > > > > > while the other
> > > > is active.
> > > > > > > > > >
> > > > > > > > > > Now I'll try on a server with more recent Ethernet and
> > > > > > > > > > InfiniBand network adapters. One of them has:
> > > > > > > > > > BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller
> > > > > > > > > > (rev
> > > > > > > > > > 01)
> > > > > > > > > >
> > > > > > > > > > The comparison between RDMA and TCP on the same NIC
> > > > > > > > > > could make more
> > > > > > > > > sense.
> > > > > > > > >
> > > > > > > > > It looks to me NICs are powerful now, but again as I
> > > > > > > > > mentioned I don't think it's a reason we need to deprecat=
e
> > > > > > > > > rdma, especially if QEMU's rdma migration has the chance
> > > > > > > > > to be refactored
> > > > using rsocket.
> > > > > > > > >
> > > > > > > > > Is there anyone who started looking into that direction?
> > > > > > > > > Would it make sense we start some PoC now?
> > > > > > > > >
> > > > > > > >
> > > > > > > > My team has finished the PoC refactoring which works well.
> > > > > > > >
> > > > > > > > Progress:
> > > > > > > > 1.  Implement io/channel-rdma.c, 2.  Add unit test
> > > > > > > > tests/unit/test-io-channel-rdma.c and verifying it is
> > > > > > > > successful, 3.  Remove the original code from migration/rdm=
a.c, 4.
> > > > > > > > Rewrite the rdma_start_outgoing_migration and
> > > > > > > > rdma_start_incoming_migration logic, 5.  Remove all rdma_xx=
x
> > > > > > > > functions from migration/ram.c. (to prevent RDMA live
> > > > > > > > migration from polluting the
> > > > > > > core logic of live migration), 6.  The soft-RoCE implemented
> > > > > > > by software is used to test the RDMA live migration. It's suc=
cessful.
> > > > > > > >
> > > > > > > > We will be submit the patchset later.
> > > > > > >
> > > > > > > That's great news, thank you!
> > > > > > >
> > > > > > > --
> > > > > > > Peter Xu
> > > > > >
> > > > > > For rdma programming, the current mainstream implementation is
> > > > > > to use
> > > > rdma_cm to establish a connection, and then use verbs to transmit d=
ata.
> > > > > >
> > > > > > rdma_cm and ibverbs create two FDs respectively. The two FDs
> > > > > > have different responsibilities. rdma_cm fd is used to notify
> > > > > > connection establishment events, and verbs fd is used to notify
> > > > > > new CQEs. When
> > > > poll/epoll monitoring is directly performed on the rdma_cm fd, only
> > > > a pollin event can be monitored, which means that an rdma_cm event
> > > > occurs. When the verbs fd is directly polled/epolled, only the
> > > > pollin event can be listened, which indicates that a new CQE is gen=
erated.
> > > > > >
> > > > > > Rsocket is a sub-module attached to the rdma_cm library and
> > > > > > provides rdma calls that are completely similar to socket inter=
faces.
> > > > > > However, this library returns only the rdma_cm fd for listening
> > > > > > to link
> > > > setup-related events and does not expose the verbs fd (readable and
> > > > writable events for listening to data). Only the rpoll interface
> > > > provided by the RSocket can be used to listen to related events.
> > > > However, QEMU uses the ppoll interface to listen to the rdma_cm fd
> > (gotten by raccept API).
> > > > > > And cannot listen to the verbs fd event.
> > I'm confused, the rs_poll_arm
> > :https://github.com/linux-rdma/rdma-core/blob/master/librdmacm/rsocket.=
c#
> > L3290
> > For STREAM, rpoll setup fd for both cq fd and cm fd.
> >
>
> Right. But the question is QEMU do not use rpoll but gilb's ppoll. :(

I have a query around this topic. Are the fds used in socket migration
polled through ppoll?
If yes, then can someone point out where; I couldn't find that piece of cod=
e.

I could only find that sendmsg/send and recvmsg/recv is being used.

>
>
> Regards,
> -Gonglei
>

