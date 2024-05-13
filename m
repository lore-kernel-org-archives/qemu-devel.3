Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7242C25B10
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 07:32:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6QAD-0007oD-5t; Mon, 13 May 2024 03:32:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jinpu.wang@ionos.com>)
 id 1s6Q9T-0007kO-AU
 for qemu-devel@nongnu.org; Mon, 13 May 2024 03:31:19 -0400
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jinpu.wang@ionos.com>)
 id 1s6Q9J-0006nU-6c
 for qemu-devel@nongnu.org; Mon, 13 May 2024 03:31:13 -0400
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-522297f91bcso3058658e87.3
 for <qemu-devel@nongnu.org>; Mon, 13 May 2024 00:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ionos.com; s=google; t=1715585461; x=1716190261; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5nn+r8Oy8wn/auwvLpDmklzqo6ERpGj5aLtszGTWePo=;
 b=ClSeVIpf7hogDs2MVHt4udoX7sNH7t4NCuSlqfu+5kbOkyNeccZFXah+Gc3ILMQjT7
 9K7BY34naVNyZYWm0E4Jntvj5DdbH/FFAYLKEOj6276lzcBwRFnWXjb4zPDrAX7Dcxwq
 +9iqPaYa6D/cVuC7YiV20xCtaDm7sJ0501nT/j7BsCfDKD4jLpkbhaEf5zBXGb8gRB5H
 P3SsYXhxnrkQeplcXVRhOP41d10KXC2MtTBG/97r3PnJVrJAdDvP5hvl0dkrdYuYJGu3
 uDSSFkntWwLV4Tt3EDtY1a+Wbda35tKOiBByCBU2S3IO/T3e+kFLHAgYUEHY1fEcCxuf
 5k5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715585461; x=1716190261;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5nn+r8Oy8wn/auwvLpDmklzqo6ERpGj5aLtszGTWePo=;
 b=oM/xRMh0kpehjo3LbEeB7YVsBa5izzBc6jIw789czKinZjabHE9uOz1RQlsoiCrLcq
 3+iznJFuWDef1P2wj2p51L+8OAy39ZAj4zNquJRxyVI/FcfFyMoCLFRjMDiVBmp5fmBJ
 slbkGwJUhCq3GbgWtngoD8cZfRegu6dQnP27cXJ7zeq0bfrSY9vMV4BgrX7i96FexZcg
 NZK+4l9zC4gKSD0HHNgQl/yX7uRC7q9GSbBh6clUoaMQvlZsbzpXMwICg0Mfgdi6uJyg
 Vq5TK426glQ5uwf0oyswqaN96sLIrZD9bNk9kIF7D8bcBFiMubzmzC+oG1N3t1HBn4Ya
 eomw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUrbP07q9TIbFLIbvCBK8NzUKB9aXsTxS+Q2SyxE9i6MMflH+zLCkZ8IOl8mkdE3ssb/jRR9m02rbL3wXNUD+PhnSVEDqs=
X-Gm-Message-State: AOJu0YxPAn6WeBM3iqhfn8SShpJxIgfoIVw65UaCSFhGJ50OUDtn/kkc
 Bxc6AvTRXyA7v0/RvitfpXYJKMj5PXMh9MP+0DwAY/8l4j9kw3sJFs3gtOrJCmOcM08f6YVRsNE
 h+nmVOmcED+FjaTr3/+Im/xpf+DIDzT8TSgoIfw==
X-Google-Smtp-Source: AGHT+IF0pNHpZzO3I6+llHGGXWwJdFhZNiayALGkeBIYGXQ0Q6bMoKmwPcfX72ALXRxAKMKJ0j4Nxty24GsNVGd4Q8Q=
X-Received: by 2002:ac2:55a4:0:b0:521:533d:6367 with SMTP id
 2adb3069b0e04-5221027bad5mr4773009e87.63.1715585460935; Mon, 13 May 2024
 00:31:00 -0700 (PDT)
MIME-Version: 1.0
References: <46f5e323-632d-7bda-f2c5-3cfa7b1c6b68@akamai.com>
 <Zi-1OvxA5MIHjklU@x1n> <877cgfe2yw.fsf@pond.sub.org>
 <ZjClMb-6MddpvHqQ@redhat.com>
 <ZjJgQcPQ29HJsTpY@x1n> <7e902e4e576a4e199e36d28f99bd55e5@huawei.com>
 <Zjj0xa-3KrFHTK0S@x1n> <addaa8d094904315a466533763689ead@huawei.com>
 <ZjpWmG2aUJLkYxJm@x1n> <13ce4f9e-1e7c-24a9-0dc9-c40962979663@huawei.com>
 <ZjzaIAMgUHV8zdNz@x1n>
In-Reply-To: <ZjzaIAMgUHV8zdNz@x1n>
From: Jinpu Wang <jinpu.wang@ionos.com>
Date: Mon, 13 May 2024 09:30:49 +0200
Message-ID: <CAMGffEn-DKpMZ4tA71MJYdyemg0Zda15wVAqk81vXtKzx-LfJQ@mail.gmail.com>
Subject: Re: [PATCH-for-9.1 v2 2/3] migration: Remove RDMA protocol handling
To: Peter Xu <peterx@redhat.com>
Cc: Zheng Chuan <zhengchuan@huawei.com>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, Michael Galaxy <mgalaxy@akamai.com>,
 Yu Zhang <yu.zhang@ionos.com>, 
 "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>,
 Elmar Gerdes <elmar.gerdes@ionos.com>, 
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
 Thomas Huth <thuth@redhat.com>, 
 Eric Blake <eblake@redhat.com>, Song Gao <gaosong@loongson.cn>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, 
 Pannengyuan <pannengyuan@huawei.com>, Xiexiangyou <xiexiangyou@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: permerror client-ip=2a00:1450:4864:20::129;
 envelope-from=jinpu.wang@ionos.com; helo=mail-lf1-x129.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Hi Peter, Hi Chuan,

On Thu, May 9, 2024 at 4:14=E2=80=AFPM Peter Xu <peterx@redhat.com> wrote:
>
> On Thu, May 09, 2024 at 04:58:34PM +0800, Zheng Chuan via wrote:
> > That's a good news to see the socket abstraction for RDMA!
> > When I was developed the series above, the most pain is the RDMA migrat=
ion has no QIOChannel abstraction and i need to take a 'fake channel'
> > for it which is awkward in code implementation.
> > So, as far as I know, we can do this by
> > i. the first thing is that we need to evaluate the rsocket is good enou=
gh to satisfy our QIOChannel fundamental abstraction
> > ii. if it works right, then we will continue to see if it can give us o=
pportunity to hide the detail of rdma protocol
> >     into rsocket by remove most of code in rdma.c and also some hack in=
 migration main process.
> > iii. implement the advanced features like multi-fd and multi-uri for rd=
ma migration.
> >
> > Since I am not familiar with rsocket, I need some times to look at it a=
nd do some quick verify with rdma migration based on rsocket.
> > But, yes, I am willing to involved in this refactor work and to see if =
we can make this migration feature more better:=EF=BC=89
>
> Based on what we have now, it looks like we'd better halt the deprecation
> process a bit, so I think we shouldn't need to rush it at least in 9.1
> then, and we'll need to see how it goes on the refactoring.
>
> It'll be perfect if rsocket works, otherwise supporting multifd with litt=
le
> overhead / exported APIs would also be a good thing in general with
> whatever approach.  And obviously all based on the facts that we can get
> resources from companies to support this feature first.
>
> Note that so far nobody yet compared with rdma v.s. nic perf, so I hope i=
f
> any of us can provide some test results please do so.  Many people are
> saying RDMA is better, but I yet didn't see any numbers comparing it with
> modern TCP networks.  I don't want to have old impressions floating aroun=
d
> even if things might have changed..  When we have consolidated results, w=
e
> should share them out and also reflect that in QEMU's migration docs when=
 a
> rdma document page is ready.
I also did a tests with Mellanox ConnectX-6 100 G RoCE nic, the
results are mixed, for less than 3 streams native ethernet is faster,
and when more than 3 streams rsocket performs better.

root@x4-right:~# iperf -c 1.1.1.16 -P 1
------------------------------------------------------------
Client connecting to 1.1.1.16, TCP port 5001
TCP window size:  325 KByte (default)
------------------------------------------------------------
[  3] local 1.1.1.15 port 44214 connected with 1.1.1.16 port 5001
[ ID] Interval       Transfer     Bandwidth
[  3] 0.0000-10.0000 sec  52.9 GBytes  45.4 Gbits/sec
root@x4-right:~# iperf -c 1.1.1.16 -P 2
[  3] local 1.1.1.15 port 33118 connected with 1.1.1.16 port 5001
[  4] local 1.1.1.15 port 33130 connected with 1.1.1.16 port 5001
------------------------------------------------------------
Client connecting to 1.1.1.16, TCP port 5001
TCP window size: 4.00 MByte (default)
------------------------------------------------------------
[ ID] Interval       Transfer     Bandwidth
[  3] 0.0000-10.0001 sec  45.0 GBytes  38.7 Gbits/sec
[  4] 0.0000-10.0000 sec  43.9 GBytes  37.7 Gbits/sec
[SUM] 0.0000-10.0000 sec  88.9 GBytes  76.4 Gbits/sec
[ CT] final connect times (min/avg/max/stdev) =3D
0.172/0.189/0.205/0.172 ms (tot/err) =3D 2/0
root@x4-right:~# iperf -c 1.1.1.16 -P 4
------------------------------------------------------------
Client connecting to 1.1.1.16, TCP port 5001
TCP window size:  325 KByte (default)
------------------------------------------------------------
[  5] local 1.1.1.15 port 50748 connected with 1.1.1.16 port 5001
[  4] local 1.1.1.15 port 50734 connected with 1.1.1.16 port 5001
[  6] local 1.1.1.15 port 50764 connected with 1.1.1.16 port 5001
[  3] local 1.1.1.15 port 50730 connected with 1.1.1.16 port 5001
[ ID] Interval       Transfer     Bandwidth
[  6] 0.0000-10.0000 sec  24.7 GBytes  21.2 Gbits/sec
[  3] 0.0000-10.0004 sec  23.6 GBytes  20.3 Gbits/sec
[  4] 0.0000-10.0000 sec  27.8 GBytes  23.9 Gbits/sec
[  5] 0.0000-10.0000 sec  28.0 GBytes  24.0 Gbits/sec
[SUM] 0.0000-10.0000 sec   104 GBytes  89.4 Gbits/sec
[ CT] final connect times (min/avg/max/stdev) =3D
0.104/0.156/0.204/0.124 ms (tot/err) =3D 4/0
root@x4-right:~# iperf -c 1.1.1.16 -P 8
[  4] local 1.1.1.15 port 55588 connected with 1.1.1.16 port 5001
[  5] local 1.1.1.15 port 55600 connected with 1.1.1.16 port 5001
------------------------------------------------------------
Client connecting to 1.1.1.16, TCP port 5001
TCP window size:  325 KByte (default)
------------------------------------------------------------
[ 10] local 1.1.1.15 port 55628 connected with 1.1.1.16 port 5001
[ 15] local 1.1.1.15 port 55648 connected with 1.1.1.16 port 5001
[  7] local 1.1.1.15 port 55620 connected with 1.1.1.16 port 5001
[  3] local 1.1.1.15 port 55584 connected with 1.1.1.16 port 5001
[ 14] local 1.1.1.15 port 55644 connected with 1.1.1.16 port 5001
[  6] local 1.1.1.15 port 55610 connected with 1.1.1.16 port 5001
[ ID] Interval       Transfer     Bandwidth
[  6] 0.0000-10.0015 sec  8.47 GBytes  7.27 Gbits/sec
[  4] 0.0000-10.0011 sec  8.62 GBytes  7.40 Gbits/sec
[  7] 0.0000-10.0000 sec  18.1 GBytes  15.5 Gbits/sec
[ 14] 0.0000-10.0000 sec  8.69 GBytes  7.46 Gbits/sec
[  5] 0.0000-10.0006 sec  18.5 GBytes  15.9 Gbits/sec
[ 10] 0.0000-10.0006 sec  16.1 GBytes  13.9 Gbits/sec
[  3] 0.0000-10.0000 sec  17.1 GBytes  14.6 Gbits/sec
[ 15] 0.0000-10.0016 sec  8.54 GBytes  7.34 Gbits/sec
[SUM] 0.0000-10.0017 sec   104 GBytes  89.4 Gbits/sec
[ CT] final connect times (min/avg/max/stdev) =3D
0.049/0.095/0.213/0.062 ms (tot/err) =3D 8/0

root@x4-right:~#
LD_PRELOAD=3D/usr/lib/x86_64-linux-gnu/rsocket/librspreload.so  iperf -c
1.1.1.16 -P 1
------------------------------------------------------------
Client connecting to 1.1.1.16, TCP port 5001
TCP window size:  128 KByte (default)
------------------------------------------------------------
[  3] local 1.1.1.15 port 45596 connected with 1.1.1.16 port 5001
[ ID] Interval       Transfer     Bandwidth
[  3] 0.0000-10.0000 sec  37.8 GBytes  32.5 Gbits/sec
root@x4-right:~#
LD_PRELOAD=3D/usr/lib/x86_64-linux-gnu/rsocket/librspreload.so  iperf -c
1.1.1.16 -P 2
[  4] local 1.1.1.15 port 46782 connected with 1.1.1.16 port 5001
------------------------------------------------------------
Client connecting to 1.1.1.16, TCP port 5001
TCP window size:  128 KByte (default)
------------------------------------------------------------
[  3] local 1.1.1.15 port 43237 connected with 1.1.1.16 port 5001
[ ID] Interval       Transfer     Bandwidth
[  4] 0.0000-10.0000 sec  37.5 GBytes  32.2 Gbits/sec
[  3] 0.0000-10.0000 sec  40.7 GBytes  34.9 Gbits/sec
[SUM] 0.0000-10.0000 sec  78.2 GBytes  67.2 Gbits/sec
[ CT] final connect times (min/avg/max/stdev) =3D
5.819/6.579/7.340/7.340 ms (tot/err) =3D 2/0
root@x4-right:~#
LD_PRELOAD=3D/usr/lib/x86_64-linux-gnu/rsocket/librspreload.so  iperf -c
1.1.1.16 -P 4
[  4] local 1.1.1.15 port 60385 connected with 1.1.1.16 port 5001
[  7] local 1.1.1.15 port 55203 connected with 1.1.1.16 port 5001
[  6] local 1.1.1.15 port 35084 connected with 1.1.1.16 port 5001
------------------------------------------------------------
Client connecting to 1.1.1.16, TCP port 5001
TCP window size:  128 KByte (default)
------------------------------------------------------------
[  3] local 1.1.1.15 port 37253 connected with 1.1.1.16 port 5001
[ ID] Interval       Transfer     Bandwidth
[  6] 0.0000-10.0000 sec  28.4 GBytes  24.4 Gbits/sec
[  4] 0.0000-10.0000 sec  28.3 GBytes  24.3 Gbits/sec
[  7] 0.0000-10.0000 sec  28.4 GBytes  24.4 Gbits/sec
[  3] 0.0000-10.0001 sec  28.2 GBytes  24.3 Gbits/sec
[SUM] 0.0000-10.0001 sec   113 GBytes  97.3 Gbits/sec
[ CT] final connect times (min/avg/max/stdev) =3D
5.311/7.579/10.019/4.165 ms (tot/err) =3D 4/0
root@x4-right:~#
LD_PRELOAD=3D/usr/lib/x86_64-linux-gnu/rsocket/librspreload.so  iperf -c
1.1.1.16 -P 8
[  8] local 1.1.1.15 port 33684 connected with 1.1.1.16 port 5001
[ 10] local 1.1.1.15 port 40620 connected with 1.1.1.16 port 5001
------------------------------------------------------------
Client connecting to 1.1.1.16, TCP port 5001
TCP window size:  128 KByte (default)
------------------------------------------------------------
[  3] local 1.1.1.15 port 56988 connected with 1.1.1.16 port 5001
[  4] local 1.1.1.15 port 51139 connected with 1.1.1.16 port 5001
[ 12] local 1.1.1.15 port 44712 connected with 1.1.1.16 port 5001
[  5] local 1.1.1.15 port 50838 connected with 1.1.1.16 port 5001
[  6] local 1.1.1.15 port 51334 connected with 1.1.1.16 port 5001
[  9] local 1.1.1.15 port 40611 connected with 1.1.1.16 port 5001
[ ID] Interval       Transfer     Bandwidth
[  3] 0.0000-10.0000 sec  13.8 GBytes  11.9 Gbits/sec
[  5] 0.0000-10.0001 sec  13.9 GBytes  11.9 Gbits/sec
[ 12] 0.0000-10.0001 sec  13.8 GBytes  11.9 Gbits/sec
[ 10] 0.0000-10.0001 sec  13.9 GBytes  11.9 Gbits/sec
[  9] 0.0000-10.0000 sec  13.8 GBytes  11.9 Gbits/sec
[  6] 0.0000-10.0000 sec  13.9 GBytes  11.9 Gbits/sec
[  8] 0.0000-10.0000 sec  13.8 GBytes  11.9 Gbits/sec
[  4] 0.0000-10.0001 sec  13.8 GBytes  11.9 Gbits/sec
[SUM] 0.0000-10.0001 sec   111 GBytes  95.1 Gbits/sec
[ CT] final connect times (min/avg/max/stdev) =3D
5.973/10.699/15.943/4.251 ms (tot/err) =3D 8/0
root@x4-right:~#
LD_PRELOAD=3D/usr/lib/x86_64-linux-gnu/rsocket/librspreload.so  iperf -c
1.1.1.16 -P 1
------------------------------------------------------------
Client connecting to 1.1.1.16, TCP port 5001
TCP window size:  128 KByte (default)
------------------------------------------------------------
[  3] local 1.1.1.15 port 36960 connected with 1.1.1.16 port 5001
[ ID] Interval       Transfer     Bandwidth
[  3] 0.0000-10.0000 sec  41.1 GBytes  35.3 Gbits/sec
root@x4-right:~#
LD_PRELOAD=3D/usr/lib/x86_64-linux-gnu/rsocket/librspreload.so  iperf -c
1.1.1.16 -P 2
[  3] local 1.1.1.15 port 32799 connected with 1.1.1.16 port 5001
------------------------------------------------------------
Client connecting to 1.1.1.16, TCP port 5001
TCP window size:  128 KByte (default)
------------------------------------------------------------
[  4] local 1.1.1.15 port 35912 connected with 1.1.1.16 port 5001
[ ID] Interval       Transfer     Bandwidth
[  4] 0.0000-10.0000 sec  36.6 GBytes  31.4 Gbits/sec
[  3] 0.0000-10.0000 sec  36.6 GBytes  31.4 Gbits/sec
[SUM] 0.0000-10.0000 sec  73.2 GBytes  62.9 Gbits/sec
[ CT] final connect times (min/avg/max/stdev) =3D
5.172/5.842/6.512/6.512 ms (tot/err) =3D 2/0
root@x4-right:~#
LD_PRELOAD=3D/usr/lib/x86_64-linux-gnu/rsocket/librspreload.so  iperf -c
1.1.1.16 -P 4
[  4] local 1.1.1.15 port 53311 connected with 1.1.1.16 port 5001
------------------------------------------------------------
Client connecting to 1.1.1.16, TCP port 5001
TCP window size:  128 KByte (default)
------------------------------------------------------------
[  3] local 1.1.1.15 port 37243 connected with 1.1.1.16 port 5001
[  7] local 1.1.1.15 port 60801 connected with 1.1.1.16 port 5001
[  6] local 1.1.1.15 port 49694 connected with 1.1.1.16 port 5001
[ ID] Interval       Transfer     Bandwidth
[  6] 0.0000-10.0000 sec  28.2 GBytes  24.2 Gbits/sec
[  7] 0.0000-10.0000 sec  28.2 GBytes  24.3 Gbits/sec
[  3] 0.0000-10.0000 sec  28.2 GBytes  24.2 Gbits/sec
[  4] 0.0000-10.0000 sec  28.2 GBytes  24.2 Gbits/sec
[SUM] 0.0000-10.0000 sec   113 GBytes  96.9 Gbits/sec
[ CT] final connect times (min/avg/max/stdev) =3D
5.570/7.762/10.045/4.265 ms (tot/err) =3D 4/0
root@x4-right:~#


>
> Chuan, please check the whole thread discussion, it may help to understan=
d
> what we are looking for on rdma migrations [1].  Meanwhile please feel fr=
ee
> to sync with Jinpu's team and see how to move forward with such a project=
.
We are happy to work with community to improve rdma migration.

>
> [1] https://lore.kernel.org/qemu-devel/87frwatp7n.fsf@suse.de/
>
> Thanks,
Regards!
>
> --
> Peter Xu
>

