Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 822CBE7719E
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2025 03:00:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXAg7-0007m3-RL; Sun, 12 Jan 2025 21:59:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1tXAg6-0007lk-5P
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 21:59:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1tXAg4-0002iQ-Ca
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 21:59:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736737180;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PpOp2x4EWaYNpjfhYpbPpL9+e+B9nEthlTzqDO2LXtg=;
 b=SSMVJC3nJdLEjILTDWqaxcIc2MVLYJkwqrVqv7gnlxpVQQmFr1pNSLByugVfgCig9pf8Ac
 IPBoUYz48FIEhN7bjnokBL4k/oTuVptER/fjNi8+AAAWD4TUO2hNUuBBSo3pUamhQYDO5k
 sH+vT47jg/Pg7+/w10R4uoqcBEL5294=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-KxETCC4JMnaVPPfNALQe3A-1; Sun, 12 Jan 2025 21:59:38 -0500
X-MC-Unique: KxETCC4JMnaVPPfNALQe3A-1
X-Mimecast-MFC-AGG-ID: KxETCC4JMnaVPPfNALQe3A
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-2f2a9f056a8so6905329a91.2
 for <qemu-devel@nongnu.org>; Sun, 12 Jan 2025 18:59:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736737177; x=1737341977;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PpOp2x4EWaYNpjfhYpbPpL9+e+B9nEthlTzqDO2LXtg=;
 b=XniVg0f5X9Dy6c7ypXI+4VhXO4v3tznay90FwDzqaq0torqPrcjt9w/7nwvwtzqXK6
 RNa5dM5Q8hZohGbdx/VvgX2DTyNzlbM4EmBhoiZ2MJCRdpowrXaR90lK4IyeslPcQPGD
 I0x0YnxYUxtQYKgQXQ/Xoj+Exq+dX837l1+XU95lxOAMn5xFpUGa03U9VGUEij3jCxYR
 6xGCtin8CdR3SaPE1YMTdMMNX+iY73P0b1sGWFUGM/4sjbBzFst8dqH7RRpyHO2z1DbU
 Pie7Xep6tTe1LhJkwUfv0qIAmC1WRYjh+vYXn+M5FGy0pqBPCE0NTsbPHf8Z4//3qG0i
 ZyPQ==
X-Gm-Message-State: AOJu0YzprCHtwRWCpKhywg/Q1vR6/HPTCmULsWdG15MLGPmn/dbLlEk5
 jhU/x4Nwfyo8pD+dwbvL0kXsohk/MEfCosQuIpQsSEdacw64djDleKMsDxFvPd9YHrZvdnOwKJY
 zlM8cWrsWlcznWqvP4l9506umnuRAIAJ6wiEkywRc3hYTCTiEDvuEzdyDyR6urtK3dVR+9P/Bnw
 3jwLxfaHq/FHtmEImk8SLsZjy+6Zo=
X-Gm-Gg: ASbGnctnRhK59Tdcxq/dQ0brVvFA7IhlB7cK7oIZcwMM1fcvBrFzJiuT31+D9BD2LRd
 IA8RT93gPsXjnrvs5vvRwke5/ZVmdJkAaFVcJG7g=
X-Received: by 2002:a17:90b:2d48:b0:2ee:b2e6:4275 with SMTP id
 98e67ed59e1d1-2f548f1d790mr23692211a91.26.1736737177629; 
 Sun, 12 Jan 2025 18:59:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEMsietuuyRsdPR3cvbnVTCKHuqLF4Z2UrqrANmAY4M2uQH42kjrihq10HN+LitxdIU727QyUA2En89IErlPQA=
X-Received: by 2002:a17:90b:2d48:b0:2ee:b2e6:4275 with SMTP id
 98e67ed59e1d1-2f548f1d790mr23692195a91.26.1736737177135; Sun, 12 Jan 2025
 18:59:37 -0800 (PST)
MIME-Version: 1.0
References: <20241008-macvtap-v1-1-2032caa25b6d@daynix.com>
 <CACGkMEvmEsFdLRgF9CLQCEo0jt3dX8wAPLjRC2pNb4ofD8dLNQ@mail.gmail.com>
 <469f9995-9182-43c2-93d7-ab8dbefb9eb9@daynix.com>
 <CACGkMEs2hkX7S3QJK1yLbJjSxW=obiSOYwKA4w2xiJwuOooq4g@mail.gmail.com>
 <74d218be-2119-4977-8d2e-40a51cccde9d@daynix.com>
 <50e784b2-850d-4d1b-9fc8-7fb6076f101e@daynix.com>
In-Reply-To: <50e784b2-850d-4d1b-9fc8-7fb6076f101e@daynix.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 13 Jan 2025 10:59:26 +0800
X-Gm-Features: AbW1kvY5qwcc_D4MXY-XrFYN3ej8nKYAbwG7X_gOjBEcQKzyQOqmd-dw8RBsKQA
Message-ID: <CACGkMEu6sFRm+xVxEp6X+N_qRH+qcbi_W3onXxX3uRPjS0hiFA@mail.gmail.com>
Subject: Re: [PATCH] tap-linux: Open ipvtap and macvtap
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.025,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.798,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Sat, Jan 11, 2025 at 1:43=E2=80=AFPM Akihiko Odaki <akihiko.odaki@daynix=
.com> wrote:
>
> Hi Jason,
>
> Can you check this patch again?

I would like to have this if

1) it would be used by libvirt.

or

2) there's no other way to do this

Thanks

>
> Regards,
> Akihiko Odaki
>
> On 2024/10/22 13:59, Akihiko Odaki wrote:
> > On 2024/10/18 17:10, Jason Wang wrote:
> >> On Sat, Oct 12, 2024 at 5:05=E2=80=AFPM Akihiko Odaki
> >> <akihiko.odaki@daynix.com> wrote:
> >>>
> >>> On 2024/10/09 16:41, Jason Wang wrote:
> >>>> On Tue, Oct 8, 2024 at 2:52=E2=80=AFPM Akihiko Odaki
> >>>> <akihiko.odaki@daynix.com> wrote:
> >>>>>
> >>>>> ipvtap and macvtap create a file for each interface unlike tuntap,
> >>>>> which
> >>>>> creates one file shared by all interfaces. Try to open a file
> >>>>> dedicated
> >>>>> to the interface first for ipvtap and macvtap.
> >>>>>
> >>>>
> >>>> Management layers usually pass these fds via SCM_RIGHTS. Is this for
> >>>> testing purposes? (Note that we can use something like -netdev
> >>>> tap,fd=3D10 10<>/dev/tap0).
> >>>
> >>> I used this for testing.
> >>
> >> Anything that prevents you from using fd redirection? If not
> >> management interest and we had already had a way for testing, I tend
> >> to not introduce new code as it may bring bugs.
> >
> > I don't know what ifindex the macvtap device has so it's easier to use
> > if QEMU can automatically figure out the it.
> >
> >>
> >>>
> >>>>
> >>>>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> >>>>> ---
> >>>>>    net/tap-linux.c | 17 ++++++++++++++---
> >>>>>    1 file changed, 14 insertions(+), 3 deletions(-)
> >>>>>
> >>>>> diff --git a/net/tap-linux.c b/net/tap-linux.c
> >>>>> index 1226d5fda2d9..22ec2f45d2b7 100644
> >>>>> --- a/net/tap-linux.c
> >>>>> +++ b/net/tap-linux.c
> >>>>> @@ -45,10 +45,21 @@ int tap_open(char *ifname, int ifname_size, int
> >>>>> *vnet_hdr,
> >>>>>        int len =3D sizeof(struct virtio_net_hdr);
> >>>>>        unsigned int features;
> >>>>>
> >>>>> -    fd =3D RETRY_ON_EINTR(open(PATH_NET_TUN, O_RDWR));
> >>>>> +
> >>>>> +    ret =3D if_nametoindex(ifname);
> >>>>> +    if (ret) {
> >>>>> +        g_autofree char *file =3D g_strdup_printf("/dev/tap%d", re=
t);
> >>>>> +        fd =3D open(file, O_RDWR);
> >>>>> +    } else {
> >>>>> +        fd =3D -1;
> >>>>> +    }
> >>>>> +
> >>>>>        if (fd < 0) {
> >>>>> -        error_setg_errno(errp, errno, "could not open %s",
> >>>>> PATH_NET_TUN);
> >>>>> -        return -1;
> >>>>> +        fd =3D RETRY_ON_EINTR(open(PATH_NET_TUN, O_RDWR));
> >>>>
> >>>> Any reason tuntap were tried after the macvtap/ipvtap?
> >>>
> >>> If we try tuntap first, we will know that it is not tuntap when calli=
ng
> >>> TUNSETIFF. We will need to call TUNGETFEATURES and TUNSETVNETHDRSZ ag=
ain
> >>> in such a case because they precede TUNSETIFF. Calling them twice is
> >>> troublesome.
> >>
> >> I may miss something, we are only at the phase of open() not TUNSETIFF=
?
> >
> > We can tell if it is macvtap/ipvtap just by trying opening the device
> > file. That is not possible with tuntap because tuntap uses /dev/net/tun=
,
> > a device file common for all tuntap interfaces and its presence does no=
t
> > tell if the interface is tuntap.
> >
> >>
> >>>
> >>> This is also consistent with libvirt. libvirt first checks if
> >>> g_strdup_printf("/dev/tap%d", ifindex) exists, and falls back to tunt=
ap
> >>> otherwise.
> >>
> >> This is not what I understand from how layered products work. Libvirt
> >> should align with Qemu for low level things like TAP, not the reverse.
> >
> > This change is intended for the use case where libvirt is not in use. I=
n
> > particular, I use mkosi, which is not a full fledged layering mechanism=
.
> >
> > Regards,
> > Akihiko Odaki
>


