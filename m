Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27066C10F1A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 04:54:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4CpM-0005yo-1l; Tue, 07 May 2024 00:53:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jinpu.wang@ionos.com>)
 id 1s4CpF-0005xj-R1
 for qemu-devel@nongnu.org; Tue, 07 May 2024 00:53:17 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jinpu.wang@ionos.com>)
 id 1s4Cp7-0000QC-KV
 for qemu-devel@nongnu.org; Tue, 07 May 2024 00:53:08 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a599af16934so644673466b.1
 for <qemu-devel@nongnu.org>; Mon, 06 May 2024 21:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ionos.com; s=google; t=1715057583; x=1715662383; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PL4504PynmJ2lwZFuIy0r3HnphTaq90uGfhKDjOzUYg=;
 b=fqukhcoYcL2AVPlYoCmG5OdAKee682Uo8U5bmaO200huFGVfcXjVFez62h0b/rAHs8
 +eY0JdLZ36iUBcvHk379K8iK5aERts6Zmv9Loq+TAehkKzyB2q1R6TsMPsbqBU1/RAcW
 nN5p6WJIYdSOAKwKCDQFvCz1s4IoE5UEyN0grTRPi6jWF0/4tkTISPrvlsHGFClYN1XJ
 a11XehorkomNt2pQ+Wfo+moI6/m5L6S9Jm8mwLFCBNOebQsZdgxs7M4S24IMK+yGIWi+
 uMv7D/Gl31oXCxp9p+nOOdzjH/F3gOn1b3owLN4M/xPwBEps/cvAKnHsD48JaQTm49YA
 i4jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715057583; x=1715662383;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PL4504PynmJ2lwZFuIy0r3HnphTaq90uGfhKDjOzUYg=;
 b=AjaBaNkHi1NgdMkUp5DSOtnFjlAKZh9fleYqKAWl3dvz4fqfWC3dk1iOnK6sUAMZvP
 l8nvM13NVICDL/ueueOn0KWqah2dcBVcNvGkC2CdcRCbryF9zpsd2DUPivgwKhF2KAPI
 lH+3981+zkWwiE8FZwNdCqyR0cPXyNlGBGp8Ara3Dd+N1a3QduzotqqEucZEsd5DyEco
 Nsn2x2ttmwYh2BYgkxkUJ0n9DqW1EMtP0C+t/VqKWwFMxjMOyUf7pUd3Bdr5PhFdMakC
 fP1GstHHjt8GRHXTnLlyNK3r/srCDL4x9mIuHl/R1/yAQykO0ohLwD1zr3KMyR8ZTFV+
 Qv0A==
X-Forwarded-Encrypted: i=1;
 AJvYcCU8ydt7tuC1IfyLn9JkQLZEtflBUcMboXdoMWbaWZLNYRZUDEUoLqph8jmSOa3VtSeIwdEL1KnaXpMJa6WW11CJoB4KnrE=
X-Gm-Message-State: AOJu0YyFFMRn/ZZ8mVt57iXelfkNK5BEwU+U+rQXYbmwQLTUmCP4YIc5
 4RC4Zt3YvJVboRvD4BbUg8szwAWQzjPmDVx6JWk+WQX52xDdlM13TrRbf4J0St3s9ls+K4a4PgK
 4eOQXbqvbN2tWtVBZQFbxf27i228TYqDuPi7Vhw==
X-Google-Smtp-Source: AGHT+IFCLBzagbQJ8km04anZW5qMJWWVYvlEz0/Xu+bEux/IHdt4Ax+Dyoyxc8DxlIApa2X8Ey/yRTCkG3YvrrapcHg=
X-Received: by 2002:a50:cd93:0:b0:572:4e6b:c31 with SMTP id
 p19-20020a50cd93000000b005724e6b0c31mr8409247edi.34.1715057582793; Mon, 06
 May 2024 21:53:02 -0700 (PDT)
MIME-Version: 1.0
References: <CAHEcVy7POArt+CmY8dyNTzLJp3XxXgjh3k8=C=9K+_cw1CSJFA@mail.gmail.com>
 <46f5e323-632d-7bda-f2c5-3cfa7b1c6b68@akamai.com> <Zi-1OvxA5MIHjklU@x1n>
 <877cgfe2yw.fsf@pond.sub.org> <ZjClMb-6MddpvHqQ@redhat.com>
 <ZjJgQcPQ29HJsTpY@x1n> <ZjJm6rcqS5EhoKgK@redhat.com>
 <CAMGffEnj54q1GAtB84dWGVR0hLPzfR1W8Fa2TeP22y2zTBRNeQ@mail.gmail.com>
 <ZjT1sPh5OaByQmAB@x1n>
 <CAMGffEk8wiKNQmoUYxcaTHGtiEm2dwoCF_W7T0vMcD-i30tUkA@mail.gmail.com>
 <Zjj3GXsaUyCjjUnC@x1n>
In-Reply-To: <Zjj3GXsaUyCjjUnC@x1n>
From: Jinpu Wang <jinpu.wang@ionos.com>
Date: Tue, 7 May 2024 06:52:50 +0200
Message-ID: <CAMGffE=Hcep90DaoJDmKY6ESMtr1fZHehv-UrcHJHA8b2KvjBw@mail.gmail.com>
Subject: Re: [PATCH-for-9.1 v2 2/3] migration: Remove RDMA protocol handling
To: Peter Xu <peterx@redhat.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
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
 Beraldo Leal <bleal@redhat.com>, arei.gonglei@huawei.com, 
 pannengyuan@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: permerror client-ip=2a00:1450:4864:20::631;
 envelope-from=jinpu.wang@ionos.com; helo=mail-ej1-x631.google.com
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

Hi Peter, hi Daniel,
On Mon, May 6, 2024 at 5:29=E2=80=AFPM Peter Xu <peterx@redhat.com> wrote:
>
> On Mon, May 06, 2024 at 12:08:43PM +0200, Jinpu Wang wrote:
> > Hi Peter, hi Daniel,
>
> Hi, Jinpu,
>
> Thanks for sharing this test results.  Sounds like a great news.
>
> What's your plan next?  Would it then be worthwhile / possible moving QEM=
U
> into that direction?  Would that greatly simplify rdma code as Dan
> mentioned?
I'm rather not familiar with QEMU migration yet,  from the test
result, I think it's a possible direction,
just we need to at least based on a rather recent release like
rdma-core v33 with proper 'fork' support.

Maybe Dan or you could give more detail about what you have in mind
for using rsocket as a replacement for the future.
We will also look into the implementation details in the meantime.

Thx!
J

>
> Thanks,
>
> >
> > On Fri, May 3, 2024 at 4:33=E2=80=AFPM Peter Xu <peterx@redhat.com> wro=
te:
> > >
> > > On Fri, May 03, 2024 at 08:40:03AM +0200, Jinpu Wang wrote:
> > > > I had a brief check in the rsocket changelog, there seems some
> > > > improvement over time,
> > > >  might be worth revisiting this. due to socket abstraction, we can'=
t
> > > > use some feature like
> > > >  ODP, it won't be a small and easy task.
> > >
> > > It'll be good to know whether Dan's suggestion would work first, with=
out
> > > rewritting everything yet so far.  Not sure whether some perf test co=
uld
> > > help with the rsocket APIs even without QEMU's involvements (or looki=
ng for
> > > test data supporting / invalidate such conversions).
> > >
> > I did a quick test with iperf on 100 G environment and 40 G
> > environment, in summary rsocket works pretty well.
> >
> > iperf tests between 2 hosts with 40 G (IB),
> > first  a few test with different num. of threads on top of ipoib
> > interface, later with preload rsocket on top of same ipoib interface.
> >
> > jwang@ps401a-914.nst:~$ iperf -p 52000 -c 10.43.3.145
> > ------------------------------------------------------------
> > Client connecting to 10.43.3.145, TCP port 52000
> > TCP window size:  165 KByte (default)
> > ------------------------------------------------------------
> > [  3] local 10.43.3.146 port 55602 connected with 10.43.3.145 port 5200=
0
> > [ ID] Interval       Transfer     Bandwidth
> > [  3] 0.0000-10.0001 sec  2.85 GBytes  2.44 Gbits/sec
> > jwang@ps401a-914.nst:~$ iperf -p 52000 -c 10.43.3.145 -P 2
> > ------------------------------------------------------------
> > Client connecting to 10.43.3.145, TCP port 52000
> > TCP window size:  165 KByte (default)
> > ------------------------------------------------------------
> > [  4] local 10.43.3.146 port 39640 connected with 10.43.3.145 port 5200=
0
> > [  3] local 10.43.3.146 port 39626 connected with 10.43.3.145 port 5200=
0
> > [ ID] Interval       Transfer     Bandwidth
> > [  3] 0.0000-10.0012 sec  2.85 GBytes  2.45 Gbits/sec
> > [  4] 0.0000-10.0026 sec  2.86 GBytes  2.45 Gbits/sec
> > [SUM] 0.0000-10.0026 sec  5.71 GBytes  4.90 Gbits/sec
> > [ CT] final connect times (min/avg/max/stdev) =3D
> > 0.281/0.300/0.318/0.318 ms (tot/err) =3D 2/0
> > jwang@ps401a-914.nst:~$ iperf -p 52000 -c 10.43.3.145 -P 4
> > ------------------------------------------------------------
> > Client connecting to 10.43.3.145, TCP port 52000
> > TCP window size:  165 KByte (default)
> > ------------------------------------------------------------
> > [  4] local 10.43.3.146 port 46956 connected with 10.43.3.145 port 5200=
0
> > [  6] local 10.43.3.146 port 46978 connected with 10.43.3.145 port 5200=
0
> > [  3] local 10.43.3.146 port 46944 connected with 10.43.3.145 port 5200=
0
> > [  5] local 10.43.3.146 port 46962 connected with 10.43.3.145 port 5200=
0
> > [ ID] Interval       Transfer     Bandwidth
> > [  3] 0.0000-10.0017 sec  2.85 GBytes  2.45 Gbits/sec
> > [  4] 0.0000-10.0015 sec  2.85 GBytes  2.45 Gbits/sec
> > [  5] 0.0000-10.0026 sec  2.85 GBytes  2.45 Gbits/sec
> > [  6] 0.0000-10.0005 sec  2.85 GBytes  2.45 Gbits/sec
> > [SUM] 0.0000-10.0005 sec  11.4 GBytes  9.80 Gbits/sec
> > [ CT] final connect times (min/avg/max/stdev) =3D
> > 0.274/0.312/0.360/0.212 ms (tot/err) =3D 4/0
> > jwang@ps401a-914.nst:~$ iperf -p 52000 -c 10.43.3.145 -P 8
> > ------------------------------------------------------------
> > Client connecting to 10.43.3.145, TCP port 52000
> > TCP window size:  165 KByte (default)
> > ------------------------------------------------------------
> > [  7] local 10.43.3.146 port 35062 connected with 10.43.3.145 port 5200=
0
> > [  6] local 10.43.3.146 port 35058 connected with 10.43.3.145 port 5200=
0
> > [  8] local 10.43.3.146 port 35066 connected with 10.43.3.145 port 5200=
0
> > [  9] local 10.43.3.146 port 35074 connected with 10.43.3.145 port 5200=
0
> > [  3] local 10.43.3.146 port 35038 connected with 10.43.3.145 port 5200=
0
> > [ 12] local 10.43.3.146 port 35088 connected with 10.43.3.145 port 5200=
0
> > [  5] local 10.43.3.146 port 35048 connected with 10.43.3.145 port 5200=
0
> > [  4] local 10.43.3.146 port 35050 connected with 10.43.3.145 port 5200=
0
> > [ ID] Interval       Transfer     Bandwidth
> > [  4] 0.0000-10.0005 sec  2.85 GBytes  2.44 Gbits/sec
> > [  8] 0.0000-10.0011 sec  2.85 GBytes  2.45 Gbits/sec
> > [  5] 0.0000-10.0000 sec  2.85 GBytes  2.45 Gbits/sec
> > [ 12] 0.0000-10.0021 sec  2.85 GBytes  2.44 Gbits/sec
> > [  3] 0.0000-10.0003 sec  2.85 GBytes  2.44 Gbits/sec
> > [  7] 0.0000-10.0065 sec  2.50 GBytes  2.14 Gbits/sec
> > [  9] 0.0000-10.0077 sec  2.52 GBytes  2.16 Gbits/sec
> > [  6] 0.0000-10.0003 sec  2.85 GBytes  2.44 Gbits/sec
> > [SUM] 0.0000-10.0003 sec  22.1 GBytes  19.0 Gbits/sec
> > [ CT] final connect times (min/avg/max/stdev) =3D
> > 0.096/0.226/0.339/0.109 ms (tot/err) =3D 8/0
> > jwang@ps401a-914.nst:~$ iperf -p 52000 -c 10.43.3.145 -P 16
> > [  3] local 10.43.3.146 port 49540 connected with 10.43.3.145 port 5200=
0
> > ------------------------------------------------------------
> > Client connecting to 10.43.3.145, TCP port 52000
> > TCP window size:  165 KByte (default)
> > ------------------------------------------------------------
> > [  6] local 10.43.3.146 port 49554 connected with 10.43.3.145 port 5200=
0
> > [  8] local 10.43.3.146 port 49584 connected with 10.43.3.145 port 5200=
0
> > [  5] local 10.43.3.146 port 49552 connected with 10.43.3.145 port 5200=
0
> > [ 20] local 10.43.3.146 port 49626 connected with 10.43.3.145 port 5200=
0
> > [  4] local 10.43.3.146 port 49606 connected with 10.43.3.145 port 5200=
0
> > [  9] local 10.43.3.146 port 49596 connected with 10.43.3.145 port 5200=
0
> > [ 10] local 10.43.3.146 port 49604 connected with 10.43.3.145 port 5200=
0
> > [ 26] local 10.43.3.146 port 49678 connected with 10.43.3.145 port 5200=
0
> > [  7] local 10.43.3.146 port 49556 connected with 10.43.3.145 port 5200=
0
> > [ 25] local 10.43.3.146 port 49662 connected with 10.43.3.145 port 5200=
0
> > [ 22] local 10.43.3.146 port 49636 connected with 10.43.3.145 port 5200=
0
> > [ 11] local 10.43.3.146 port 49612 connected with 10.43.3.145 port 5200=
0
> > [ 13] local 10.43.3.146 port 49618 connected with 10.43.3.145 port 5200=
0
> > [ 23] local 10.43.3.146 port 49646 connected with 10.43.3.145 port 5200=
0
> > [ 15] local 10.43.3.146 port 49688 connected with 10.43.3.145 port 5200=
0
> > [ ID] Interval       Transfer     Bandwidth
> > [ 11] 0.0000-10.0024 sec  2.28 GBytes  1.95 Gbits/sec
> > [ 23] 0.0000-10.0022 sec  2.28 GBytes  1.95 Gbits/sec
> > [ 20] 0.0000-10.0010 sec  2.28 GBytes  1.95 Gbits/sec
> > [  8] 0.0000-10.0032 sec  2.28 GBytes  1.95 Gbits/sec
> > [ 26] 0.0000-10.0038 sec  2.28 GBytes  1.95 Gbits/sec
> > [ 10] 0.0000-10.0002 sec  2.28 GBytes  1.95 Gbits/sec
> > [  7] 0.0000-10.0033 sec  2.28 GBytes  1.95 Gbits/sec
> > [ 15] 0.0000-10.0015 sec  2.27 GBytes  1.95 Gbits/sec
> > [  4] 0.0000-10.0028 sec  2.28 GBytes  1.95 Gbits/sec
> > [  6] 0.0000-10.0012 sec  2.28 GBytes  1.96 Gbits/sec
> > [ 13] 0.0000-10.0030 sec  2.28 GBytes  1.95 Gbits/sec
> > [ 25] 0.0000-10.0051 sec  2.28 GBytes  1.95 Gbits/sec
> > [  5] 0.0000-10.0001 sec  2.28 GBytes  1.96 Gbits/sec
> > [  9] 0.0000-10.0017 sec  2.28 GBytes  1.95 Gbits/sec
> > [ 22] 0.0000-10.0008 sec  2.27 GBytes  1.95 Gbits/sec
> > [  3] 0.0000-10.0033 sec  2.28 GBytes  1.95 Gbits/sec
> > [SUM] 0.0000-10.0034 sec  36.4 GBytes  31.3 Gbits/sec
> > [ CT] final connect times (min/avg/max/stdev) =3D
> > 0.105/0.217/0.401/0.093 ms (tot/err) =3D 16/0
> > jwang@ps401a-914.nst:~$
> > LD_PRELOAD=3D/usr/lib/x86_64-linux-gnu/rsocket/librspreload.so iperf -p
> > 52000 -c 10.43.3.145 -P 16
> > ------------------------------------------------------------
> > Client connecting to 10.43.3.145, TCP port 52000
> > TCP window size:  128 KByte (default)
> > ------------------------------------------------------------
> > [  3] local 10.43.3.146 port 48902 connected with 10.43.3.145 port 5200=
0
> > [  5] local 10.43.3.146 port 52777 connected with 10.43.3.145 port 5200=
0
> > [  9] local 10.43.3.146 port 42911 connected with 10.43.3.145 port 5200=
0
> > [ 11] local 10.43.3.146 port 56354 connected with 10.43.3.145 port 5200=
0
> > [ 15] local 10.43.3.146 port 43325 connected with 10.43.3.145 port 5200=
0
> > [  6] local 10.43.3.146 port 37041 connected with 10.43.3.145 port 5200=
0
> > [  7] local 10.43.3.146 port 58828 connected with 10.43.3.145 port 5200=
0
> > [ 17] local 10.43.3.146 port 48858 connected with 10.43.3.145 port 5200=
0
> > [ 13] local 10.43.3.146 port 49256 connected with 10.43.3.145 port 5200=
0
> > [ 16] local 10.43.3.146 port 35652 connected with 10.43.3.145 port 5200=
0
> > [  8] local 10.43.3.146 port 48567 connected with 10.43.3.145 port 5200=
0
> > [ 18] local 10.43.3.146 port 47394 connected with 10.43.3.145 port 5200=
0
> > [ 19] local 10.43.3.146 port 48065 connected with 10.43.3.145 port 5200=
0
> > [ 10] local 10.43.3.146 port 39788 connected with 10.43.3.145 port 5200=
0
> > [  4] local 10.43.3.146 port 46818 connected with 10.43.3.145 port 5200=
0
> > [ 14] local 10.43.3.146 port 57174 connected with 10.43.3.145 port 5200=
0
> > [ ID] Interval       Transfer     Bandwidth
> > [ 14] 0.0000-10.0002 sec  2.30 GBytes  1.98 Gbits/sec
> > [  6] 0.0000-10.0004 sec  2.31 GBytes  1.98 Gbits/sec
> > [  5] 0.0000-10.0002 sec  2.31 GBytes  1.98 Gbits/sec
> > [  8] 0.0000-10.0001 sec  2.31 GBytes  1.98 Gbits/sec
> > [ 11] 0.0000-10.0003 sec  2.31 GBytes  1.98 Gbits/sec
> > [ 18] 0.0000-10.0003 sec  2.31 GBytes  1.98 Gbits/sec
> > [  3] 0.0000-10.0004 sec  2.31 GBytes  1.98 Gbits/sec
> > [  4] 0.0000-10.0005 sec  2.30 GBytes  1.98 Gbits/sec
> > [ 17] 0.0000-10.0004 sec  2.31 GBytes  1.98 Gbits/sec
> > [ 15] 0.0000-10.0005 sec  2.31 GBytes  1.98 Gbits/sec
> > [ 19] 0.0000-10.0001 sec  2.30 GBytes  1.98 Gbits/sec
> > [  7] 0.0000-10.0004 sec  2.31 GBytes  1.98 Gbits/sec
> > [ 13] 0.0000-10.0005 sec  2.31 GBytes  1.98 Gbits/sec
> > [ 10] 0.0000-10.0003 sec  2.30 GBytes  1.98 Gbits/sec
> > [  9] 0.0000-10.0000 sec  2.31 GBytes  1.98 Gbits/sec
> > [ 16] 0.0000-10.0002 sec  2.31 GBytes  1.98 Gbits/sec
> > [SUM] 0.0000-10.0003 sec  36.9 GBytes  31.7 Gbits/sec
> > [ CT] final connect times (min/avg/max/stdev) =3D
> > 88.398/101.706/114.726/24.755 ms (tot/err) =3D 16/0
> > jwang@ps401a-914.nst:~$
> > LD_PRELOAD=3D/usr/lib/x86_64-linux-gnu/rsocket/librspreload.so iperf -p
> > 52000 -c 10.43.3.145 -P 1
> > ------------------------------------------------------------
> > Client connecting to 10.43.3.145, TCP port 52000
> > TCP window size:  128 KByte (default)
> > ------------------------------------------------------------
> > [  3] local 10.43.3.146 port 49168 connected with 10.43.3.145 port 5200=
0
> > [ ID] Interval       Transfer     Bandwidth
> > [  3] 0.0000-10.0000 sec  34.3 GBytes  29.5 Gbits/sec
> > jwang@ps401a-914.nst:~$
> > LD_PRELOAD=3D/usr/lib/x86_64-linux-gnu/rsocket/librspreload.so iperf -p
> > 52000 -c 10.43.3.145 -P 2
> > ------------------------------------------------------------
> > Client connecting to 10.43.3.145, TCP port 52000
> > TCP window size:  128 KByte (default)
> > ------------------------------------------------------------
> > [  3] local 10.43.3.146 port 42096 connected with 10.43.3.145 port 5200=
0
> > [  4] local 10.43.3.146 port 58667 connected with 10.43.3.145 port 5200=
0
> > [ ID] Interval       Transfer     Bandwidth
> > [  4] 0.0000-10.0001 sec  18.4 GBytes  15.8 Gbits/sec
> > [  3] 0.0000-10.0000 sec  18.5 GBytes  15.9 Gbits/sec
> > [SUM] 0.0000-10.0001 sec  36.9 GBytes  31.7 Gbits/sec
> > [ CT] final connect times (min/avg/max/stdev) =3D
> > 38.155/38.997/39.839/39.839 ms (tot/err) =3D 2/0
> > jwang@ps401a-914.nst:~$
> > LD_PRELOAD=3D/usr/lib/x86_64-linux-gnu/rsocket/librspreload.so iperf -p
> > 52000 -c 10.43.3.145 -P 4
> > ------------------------------------------------------------
> > Client connecting to 10.43.3.145, TCP port 52000
> > TCP window size:  128 KByte (default)
> > ------------------------------------------------------------
> > [  3] local 10.43.3.146 port 36100 connected with 10.43.3.145 port 5200=
0
> > [  5] local 10.43.3.146 port 55108 connected with 10.43.3.145 port 5200=
0
> > [  6] local 10.43.3.146 port 41039 connected with 10.43.3.145 port 5200=
0
> > [  7] local 10.43.3.146 port 34868 connected with 10.43.3.145 port 5200=
0
> > [ ID] Interval       Transfer     Bandwidth
> > [  7] 0.0000-10.0000 sec  9.22 GBytes  7.92 Gbits/sec
> > [  5] 0.0000-10.0000 sec  9.22 GBytes  7.92 Gbits/sec
> > [  3] 0.0000-10.0000 sec  9.22 GBytes  7.92 Gbits/sec
> > [  6] 0.0000-10.0001 sec  9.22 GBytes  7.92 Gbits/sec
> > [SUM] 0.0000-10.0001 sec  36.9 GBytes  31.7 Gbits/sec
> > [ CT] final connect times (min/avg/max/stdev) =3D
> > 51.401/53.644/56.015/30.487 ms (tot/err) =3D 4/0
> >
> > You can see with rsocket it reaches ~ 30 Gb/s with single stream,
> > while ipoib only 2.5 Gb/s (12 X), ipoib scales with more threads until
> >  ~ 32 Gb/s, which is the link limit.
> >
> > With 100 G env, rsocket also out perform ipoib, see below:
> >
> >
> > jwang@ps404a-59.stg:~$
> > LD_PRELOAD=3D/usr/lib/x86_64-linux-gnu/rsocket/librspreload.so iperf -p
> > 52000 -c 10.43.48.58
> > ------------------------------------------------------------
> > Client connecting to 10.43.48.58, TCP port 52000
> > TCP window size:  128 KByte (default)
> > ------------------------------------------------------------
> > [  3] local 10.43.48.59 port 40588 connected with 10.43.48.58 port 5200=
0
> > [ ID] Interval       Transfer     Bandwidth
> > [  3] 0.0000-10.0000 sec  80.7 GBytes  69.4 Gbits/sec
> > jwang@ps404a-59.stg:~$
> > LD_PRELOAD=3D/usr/lib/x86_64-linux-gnu/rsocket/librspreload.so iperf -p
> > 52000 -c 10.43.48.58 -P 2
> > ------------------------------------------------------------
> > Client connecting to 10.43.48.58, TCP port 52000
> > TCP window size:  128 KByte (default)
> > ------------------------------------------------------------
> > [  3] local 10.43.48.59 port 41813 connected with 10.43.48.58 port 5200=
0
> > [  5] local 10.43.48.59 port 60638 connected with 10.43.48.58 port 5200=
0
> > [ ID] Interval       Transfer     Bandwidth
> > [  5] 0.0000-10.0000 sec  48.9 GBytes  42.0 Gbits/sec
> > [  3] 0.0000-10.0000 sec  49.8 GBytes  42.8 Gbits/sec
> > [SUM] 0.0000-10.0000 sec  98.7 GBytes  84.8 Gbits/sec
> > [ CT] final connect times (min/avg/max/stdev) =3D
> > 6.962/7.764/8.567/8.567 ms (tot/err) =3D 2/0
> > jwang@ps404a-59.stg:~$
> > LD_PRELOAD=3D/usr/lib/x86_64-linux-gnu/rsocket/librspreload.so iperf -p
> > 52000 -c 10.43.48.58 -P 4
> > [  6] local 10.43.48.59 port 58086 connected with 10.43.48.58 port 5200=
0
> > [  3] local 10.43.48.59 port 49335 connected with 10.43.48.58 port 5200=
0
> > ------------------------------------------------------------
> > Client connecting to 10.43.48.58, TCP port 52000
> > TCP window size:  128 KByte (default)
> > ------------------------------------------------------------
> > [  4] local 10.43.48.59 port 44593 connected with 10.43.48.58 port 5200=
0
> > [  5] local 10.43.48.59 port 60464 connected with 10.43.48.58 port 5200=
0
> > [ ID] Interval       Transfer     Bandwidth
> > [  5] 0.0000-10.0000 sec  28.0 GBytes  24.0 Gbits/sec
> > [  4] 0.0000-10.0000 sec  28.0 GBytes  24.0 Gbits/sec
> > [  3] 0.0000-10.0000 sec  28.0 GBytes  24.1 Gbits/sec
> > [  6] 0.0000-10.0000 sec  28.0 GBytes  24.1 Gbits/sec
> > [SUM] 0.0000-10.0001 sec   112 GBytes  96.3 Gbits/sec
> > [ CT] final connect times (min/avg/max/stdev) =3D
> > 7.344/9.619/12.199/5.271 ms (tot/err) =3D 4/0
> > jwang@ps404a-59.stg:~$
> > LD_PRELOAD=3D/usr/lib/x86_64-linux-gnu/rsocket/librspreload.so iperf -p
> > 52000 -c 10.43.48.58 -P 8
> > [  3] local 10.43.48.59 port 43020 connected with 10.43.48.58 port 5200=
0
> > [  7] local 10.43.48.59 port 59720 connected with 10.43.48.58 port 5200=
0
> > [  4] local 10.43.48.59 port 52547 connected with 10.43.48.58 port 5200=
0
> > [  8] local 10.43.48.59 port 41712 connected with 10.43.48.58 port 5200=
0
> > [ 10] local 10.43.48.59 port 53126 connected with 10.43.48.58 port 5200=
0
> > ------------------------------------------------------------
> > Client connecting to 10.43.48.58, TCP port 52000
> > TCP window size:  128 KByte (default)
> > ------------------------------------------------------------
> > [  6] local 10.43.48.59 port 60311 connected with 10.43.48.58 port 5200=
0
> > [  5] local 10.43.48.59 port 44103 connected with 10.43.48.58 port 5200=
0
> > [  9] local 10.43.48.59 port 49007 connected with 10.43.48.58 port 5200=
0
> > [ ID] Interval       Transfer     Bandwidth
> > [  9] 0.0000-10.0001 sec  14.0 GBytes  12.0 Gbits/sec
> > [  8] 0.0000-10.0000 sec  14.0 GBytes  12.0 Gbits/sec
> > [  4] 0.0000-10.0001 sec  14.0 GBytes  12.0 Gbits/sec
> > [  6] 0.0000-10.0000 sec  14.0 GBytes  12.0 Gbits/sec
> > [ 10] 0.0000-10.0000 sec  14.0 GBytes  12.0 Gbits/sec
> > [  7] 0.0000-10.0000 sec  14.0 GBytes  12.0 Gbits/sec
> > [  5] 0.0000-10.0001 sec  14.0 GBytes  12.0 Gbits/sec
> > [  3] 0.0000-10.0001 sec  14.0 GBytes  12.0 Gbits/sec
> > [SUM] 0.0000-10.0001 sec   112 GBytes  96.3 Gbits/sec
> > [ CT] final connect times (min/avg/max/stdev) =3D
> > 6.942/12.361/18.109/4.872 ms (tot/err) =3D 8/0
> > jwang@ps404a-59.stg:~$ iperf -p 52000 -c 10.43.48.58 -P 8
> > ------------------------------------------------------------
> > Client connecting to 10.43.48.58, TCP port 52000
> > TCP window size:  165 KByte (default)
> > ------------------------------------------------------------
> > [  4] local 10.43.48.59 port 58176 connected with 10.43.48.58 port 5200=
0
> > [  5] local 10.43.48.59 port 58180 connected with 10.43.48.58 port 5200=
0
> > [  3] local 10.43.48.59 port 58178 connected with 10.43.48.58 port 5200=
0
> > [ 10] local 10.43.48.59 port 58226 connected with 10.43.48.58 port 5200=
0
> > [ 11] local 10.43.48.59 port 58228 connected with 10.43.48.58 port 5200=
0
> > [  9] local 10.43.48.59 port 58212 connected with 10.43.48.58 port 5200=
0
> > [  7] local 10.43.48.59 port 58194 connected with 10.43.48.58 port 5200=
0
> > [  8] local 10.43.48.59 port 58198 connected with 10.43.48.58 port 5200=
0
> > [ ID] Interval       Transfer     Bandwidth
> > [  9] 0.0000-10.0005 sec  15.8 GBytes  13.5 Gbits/sec
> > [  4] 0.0000-10.0002 sec  15.8 GBytes  13.6 Gbits/sec
> > [  3] 0.0000-10.0000 sec  15.8 GBytes  13.6 Gbits/sec
> > [  5] 0.0000-10.0002 sec  15.8 GBytes  13.6 Gbits/sec
> > [  8] 0.0000-10.0005 sec  7.89 GBytes  6.78 Gbits/sec
> > [ 10] 0.0000-10.0000 sec  15.8 GBytes  13.6 Gbits/sec
> > [ 11] 0.0000-10.0014 sec  7.94 GBytes  6.82 Gbits/sec
> > [  7] 0.0000-10.0009 sec  15.8 GBytes  13.6 Gbits/sec
> > [SUM] 0.0000-10.0009 sec   111 GBytes  95.1 Gbits/sec
> > [ CT] final connect times (min/avg/max/stdev) =3D
> > 0.234/0.325/0.406/0.155 ms (tot/err) =3D 8/0
> > jwang@ps404a-59.stg:~$ iperf -p 52000 -c 10.43.48.58 -P 4
> > [  3] local 10.43.48.59 port 42548 connected with 10.43.48.58 port 5200=
0
> > ------------------------------------------------------------
> > Client connecting to 10.43.48.58, TCP port 52000
> > TCP window size:  165 KByte (default)
> > ------------------------------------------------------------
> > [  4] local 10.43.48.59 port 42558 connected with 10.43.48.58 port 5200=
0
> > [  5] local 10.43.48.59 port 42560 connected with 10.43.48.58 port 5200=
0
> > [  6] local 10.43.48.59 port 42562 connected with 10.43.48.58 port 5200=
0
> > [ ID] Interval       Transfer     Bandwidth
> > [  6] 0.0000-10.0000 sec  27.8 GBytes  23.9 Gbits/sec
> > [  5] 0.0000-10.0001 sec  27.3 GBytes  23.5 Gbits/sec
> > [  3] 0.0000-10.0001 sec  27.8 GBytes  23.9 Gbits/sec
> > [  4] 0.0000-10.0001 sec  27.8 GBytes  23.9 Gbits/sec
> > [SUM] 0.0000-10.0001 sec   111 GBytes  95.1 Gbits/sec
> > [ CT] final connect times (min/avg/max/stdev) =3D
> > 0.295/0.340/0.390/0.201 ms (tot/err) =3D 4/0
> > jwang@ps404a-59.stg:~$ iperf -p 52000 -c 10.43.48.58 -P 2
> > ------------------------------------------------------------
> > Client connecting to 10.43.48.58, TCP port 52000
> > TCP window size:  165 KByte (default)
> > ------------------------------------------------------------
> > [  4] local 10.43.48.59 port 44194 connected with 10.43.48.58 port 5200=
0
> > [  3] local 10.43.48.59 port 44186 connected with 10.43.48.58 port 5200=
0
> > [ ID] Interval       Transfer     Bandwidth
> > [  3] 0.0000-10.0000 sec  48.3 GBytes  41.5 Gbits/sec
> > [  4] 0.0000-10.0000 sec  41.3 GBytes  35.5 Gbits/sec
> > [SUM] 0.0000-10.0000 sec  89.7 GBytes  77.0 Gbits/sec
> > [ CT] final connect times (min/avg/max/stdev) =3D
> > 0.227/0.233/0.240/0.240 ms (tot/err) =3D 2/0
> > jwang@ps404a-59.stg:~$ pbkvm list
> >  VM  State  PID  Cores  Mem  VNC  Migration
> > --------------------------------------------
> >
> > Total: 0 VMs, Running: 0
> > jwang@ps404a-59.stg:~$ iperf -p 52000 -c 10.43.48.58 -P 1
> > ------------------------------------------------------------
> > Client connecting to 10.43.48.58, TCP port 52000
> > TCP window size:  165 KByte (default)
> > ------------------------------------------------------------
> > [  3] local 10.43.48.59 port 40364 connected with 10.43.48.58 port 5200=
0
> > [ ID] Interval       Transfer     Bandwidth
> > [  3] 0.0000-10.0000 sec  51.2 GBytes  44.0 Gbits/sec
> >
> > Thanks!
> >
> >
> > > Thanks,
> > >
> > > --
> > > Peter Xu
> > >
> >
>
> --
> Peter Xu
>

