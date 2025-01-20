Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87417C02187
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2025 00:39:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tZfoR-0000on-4r; Sun, 19 Jan 2025 19:38:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1tZfoP-0000oO-Bg
 for qemu-devel@nongnu.org; Sun, 19 Jan 2025 19:38:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1tZfoN-0004aa-JI
 for qemu-devel@nongnu.org; Sun, 19 Jan 2025 19:38:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737333517;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DjWdn8xl/OI5t6Lswmbh/wxUTZQgdGoDKQ7FHZq4m0Q=;
 b=NmHIfzGFkqhxZFvIkZ7MCGUbM6ge4HEKgOH+cxokgrFIoQTN4/5GSN6Itl8HrEBDfPLaUE
 vK7Sr3E2UezgO5TYLsmqI6xmiF6wDQZXe+bP1EWnNLnnPYxji31tQtAqLXOqHdXg319X7F
 p6QqX7vLcC1wqYDEjwuGy6u6Ur8VOOg=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-518-IbwifaPfMoiJ0eGBZtAq4g-1; Sun, 19 Jan 2025 19:38:35 -0500
X-MC-Unique: IbwifaPfMoiJ0eGBZtAq4g-1
X-Mimecast-MFC-AGG-ID: IbwifaPfMoiJ0eGBZtAq4g
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-2f5538a2356so7207711a91.2
 for <qemu-devel@nongnu.org>; Sun, 19 Jan 2025 16:38:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737333514; x=1737938314;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DjWdn8xl/OI5t6Lswmbh/wxUTZQgdGoDKQ7FHZq4m0Q=;
 b=sv1phTeh1VyaOnkVKzprxkmKEWWCVXCOiQI+oMCT5Ut+j5bWIzGUlHzjmHzGatyt6c
 p2kcaXNbVoICfdr3qahYFZZWNU07DHBGlyDDRyEd7wVuT5O5hZFB09swa81c/Bi2i2mu
 it0SycmYUWiDnj1m9Xuz7y1vin3Wb3ZkhI9RTutddyj7WFEFTpMXEgX84MJ0bKqFhLlz
 r+XiSPRVo6rPGozbSr4qhzAMrGbtMoYp0yGjeFaPjiJgofsx27kzGdMy863fQeahRceK
 xC4LSCTPfUwoCWwKJkiL/d9YJnSd6eWJeH+Ww0Rbg9ttqFLHte6HFcjf9cZ7fsqBVS/h
 JRqA==
X-Gm-Message-State: AOJu0YweWI4KTDOIqab/VNFDjwOKqNzmxUcPn9OyYp5TyH37L172cg6M
 blfXtIJmnG73vG6DCQkuRVREXmhoPxTCokqCEIpo8OBWQpQgFMyarT56s5p/IKo/GyH9O0LiB+a
 azz49febh21tHe+sfN+4CjR5DpdLELYqcqxJ5EFSNWoM9bjmTRn7UIpLD7x9lDqd7XpoRWIagsO
 ukAEJ3McitkTfGCR5ZlSX8sGQBzwJWxHvA6cEQZAka
X-Gm-Gg: ASbGncuujUxuEF7kI4L5dtBfPJCg1ttLQ08Cv/wOCNX2waMKIVGn7zRD+TnPOk5SqZ+
 Z2VOgTfxvKYE6BnPNdYDSVtZ91TrErBVU2MarTW/LUNCyjEGQrRTn
X-Received: by 2002:a17:90b:3a46:b0:2ee:ab29:1a63 with SMTP id
 98e67ed59e1d1-2f782c519e2mr14220749a91.3.1737333514235; 
 Sun, 19 Jan 2025 16:38:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGeI8e7xkkppAe8kylSGXaCsTWOQvepF5LeJEypsCvrJtdQ/S4LtJSBV6IdRNedDC5UjvIy4B1Tuyxtdqx6VLI=
X-Received: by 2002:a17:90b:3a46:b0:2ee:ab29:1a63 with SMTP id
 98e67ed59e1d1-2f782c519e2mr14220725a91.3.1737333513744; Sun, 19 Jan 2025
 16:38:33 -0800 (PST)
MIME-Version: 1.0
References: <20241008-macvtap-v1-1-2032caa25b6d@daynix.com>
 <CACGkMEvmEsFdLRgF9CLQCEo0jt3dX8wAPLjRC2pNb4ofD8dLNQ@mail.gmail.com>
 <469f9995-9182-43c2-93d7-ab8dbefb9eb9@daynix.com>
 <CACGkMEs2hkX7S3QJK1yLbJjSxW=obiSOYwKA4w2xiJwuOooq4g@mail.gmail.com>
 <74d218be-2119-4977-8d2e-40a51cccde9d@daynix.com>
 <50e784b2-850d-4d1b-9fc8-7fb6076f101e@daynix.com>
 <CACGkMEu6sFRm+xVxEp6X+N_qRH+qcbi_W3onXxX3uRPjS0hiFA@mail.gmail.com>
 <db4deda5-2869-45d2-8d56-9ba390324cd6@daynix.com>
 <CACGkMEv0XwU=P-V6RiRgBFtzZt19En921SPuTj+bNhYFyMSrFQ@mail.gmail.com>
 <bd84bba9-3aef-4c4e-a88a-566815903599@daynix.com>
In-Reply-To: <bd84bba9-3aef-4c4e-a88a-566815903599@daynix.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 20 Jan 2025 08:38:22 +0800
X-Gm-Features: AbW1kvb_OftQGplZZYC0jczpza1xWQrB48yZW-66s4vwlKVRaFL6819pOpX9jBE
Message-ID: <CACGkMEtRbiBxW5_n_Ja-V33gMVUuyBSynNqLtxXRVQEkigoEwQ@mail.gmail.com>
Subject: Re: [PATCH] tap-linux: Open ipvtap and macvtap
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.024,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Thu, Jan 16, 2025 at 1:27=E2=80=AFPM Akihiko Odaki <akihiko.odaki@daynix=
.com> wrote:
>
> On 2025/01/16 10:17, Jason Wang wrote:
> > On Wed, Jan 15, 2025 at 1:17=E2=80=AFPM Akihiko Odaki <akihiko.odaki@da=
ynix.com> wrote:
> >>
> >> On 2025/01/13 11:59, Jason Wang wrote:
> >>> On Sat, Jan 11, 2025 at 1:43=E2=80=AFPM Akihiko Odaki <akihiko.odaki@=
daynix.com> wrote:
> >>>>
> >>>> Hi Jason,
> >>>>
> >>>> Can you check this patch again?
> >>>
> >>> I would like to have this if
> >>>
> >>> 1) it would be used by libvirt.
> >>>
> >>> or
> >>>
> >>> 2) there's no other way to do this
> >>
> >> I need this to make QEMU work with macvtap on mkosi, and this patch is
> >> an effective way to accomplish the goal.
> >
> > I'm not sure how to define "effective" here.
>
> I just meant it requires me writing less code.
>
> >
> >>
> >> Requiring to pass a file descriptor is simply less convenient. Most (i=
f
> >> not all) aspects of QEMU can be configured without file descriptors; I
> >> don't think there is a reason to make tap exceptional.
> >
> > TUNSETIFF requires CAP_NET_ADMIN and qemu doesn't want to run with
> > privilege, so fd is prefered in the case of tuntap.
> >
> > For macvtap,ipvtap, though open, doesn't require any privilege.
> > Passing fd via SCM_RIGHTS is still preferable as it eases the
> > interaction with security facilities (for example, you may want to
> > whitelist /dev/tapX for Qemu to access etc).
>
> That is true for almost any kind of files, and QEMU provides options to
> specify files with file descriptor for this reason. However, it also
> provides alternative options to specify files with e.g., path for
> convenience.
>
> This patch does not add a entirely-new complex, high-level feature. It
> only pushes the macvtap/ipvtap support to the same level with tuntap and
> other features interacting with files.

Fair enough. I've queued this.

Thanks

>
> Regards,
> Akihiko Odaki
>
> >
> > Thanks
> >
> >>
> >> Regards,
> >> Akihiko Odaki
> >>
> >>>
> >>> Thanks
> >>>
> >>>>
> >>>> Regards,
> >>>> Akihiko Odaki
> >>>>
> >>>> On 2024/10/22 13:59, Akihiko Odaki wrote:
> >>>>> On 2024/10/18 17:10, Jason Wang wrote:
> >>>>>> On Sat, Oct 12, 2024 at 5:05=E2=80=AFPM Akihiko Odaki
> >>>>>> <akihiko.odaki@daynix.com> wrote:
> >>>>>>>
> >>>>>>> On 2024/10/09 16:41, Jason Wang wrote:
> >>>>>>>> On Tue, Oct 8, 2024 at 2:52=E2=80=AFPM Akihiko Odaki
> >>>>>>>> <akihiko.odaki@daynix.com> wrote:
> >>>>>>>>>
> >>>>>>>>> ipvtap and macvtap create a file for each interface unlike tunt=
ap,
> >>>>>>>>> which
> >>>>>>>>> creates one file shared by all interfaces. Try to open a file
> >>>>>>>>> dedicated
> >>>>>>>>> to the interface first for ipvtap and macvtap.
> >>>>>>>>>
> >>>>>>>>
> >>>>>>>> Management layers usually pass these fds via SCM_RIGHTS. Is this=
 for
> >>>>>>>> testing purposes? (Note that we can use something like -netdev
> >>>>>>>> tap,fd=3D10 10<>/dev/tap0).
> >>>>>>>
> >>>>>>> I used this for testing.
> >>>>>>
> >>>>>> Anything that prevents you from using fd redirection? If not
> >>>>>> management interest and we had already had a way for testing, I te=
nd
> >>>>>> to not introduce new code as it may bring bugs.
> >>>>>
> >>>>> I don't know what ifindex the macvtap device has so it's easier to =
use
> >>>>> if QEMU can automatically figure out the it.
> >>>>>
> >>>>>>
> >>>>>>>
> >>>>>>>>
> >>>>>>>>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> >>>>>>>>> ---
> >>>>>>>>>      net/tap-linux.c | 17 ++++++++++++++---
> >>>>>>>>>      1 file changed, 14 insertions(+), 3 deletions(-)
> >>>>>>>>>
> >>>>>>>>> diff --git a/net/tap-linux.c b/net/tap-linux.c
> >>>>>>>>> index 1226d5fda2d9..22ec2f45d2b7 100644
> >>>>>>>>> --- a/net/tap-linux.c
> >>>>>>>>> +++ b/net/tap-linux.c
> >>>>>>>>> @@ -45,10 +45,21 @@ int tap_open(char *ifname, int ifname_size,=
 int
> >>>>>>>>> *vnet_hdr,
> >>>>>>>>>          int len =3D sizeof(struct virtio_net_hdr);
> >>>>>>>>>          unsigned int features;
> >>>>>>>>>
> >>>>>>>>> -    fd =3D RETRY_ON_EINTR(open(PATH_NET_TUN, O_RDWR));
> >>>>>>>>> +
> >>>>>>>>> +    ret =3D if_nametoindex(ifname);
> >>>>>>>>> +    if (ret) {
> >>>>>>>>> +        g_autofree char *file =3D g_strdup_printf("/dev/tap%d"=
, ret);
> >>>>>>>>> +        fd =3D open(file, O_RDWR);
> >>>>>>>>> +    } else {
> >>>>>>>>> +        fd =3D -1;
> >>>>>>>>> +    }
> >>>>>>>>> +
> >>>>>>>>>          if (fd < 0) {
> >>>>>>>>> -        error_setg_errno(errp, errno, "could not open %s",
> >>>>>>>>> PATH_NET_TUN);
> >>>>>>>>> -        return -1;
> >>>>>>>>> +        fd =3D RETRY_ON_EINTR(open(PATH_NET_TUN, O_RDWR));
> >>>>>>>>
> >>>>>>>> Any reason tuntap were tried after the macvtap/ipvtap?
> >>>>>>>
> >>>>>>> If we try tuntap first, we will know that it is not tuntap when c=
alling
> >>>>>>> TUNSETIFF. We will need to call TUNGETFEATURES and TUNSETVNETHDRS=
Z again
> >>>>>>> in such a case because they precede TUNSETIFF. Calling them twice=
 is
> >>>>>>> troublesome.
> >>>>>>
> >>>>>> I may miss something, we are only at the phase of open() not TUNSE=
TIFF?
> >>>>>
> >>>>> We can tell if it is macvtap/ipvtap just by trying opening the devi=
ce
> >>>>> file. That is not possible with tuntap because tuntap uses /dev/net=
/tun,
> >>>>> a device file common for all tuntap interfaces and its presence doe=
s not
> >>>>> tell if the interface is tuntap.
> >>>>>
> >>>>>>
> >>>>>>>
> >>>>>>> This is also consistent with libvirt. libvirt first checks if
> >>>>>>> g_strdup_printf("/dev/tap%d", ifindex) exists, and falls back to =
tuntap
> >>>>>>> otherwise.
> >>>>>>
> >>>>>> This is not what I understand from how layered products work. Libv=
irt
> >>>>>> should align with Qemu for low level things like TAP, not the reve=
rse.
> >>>>>
> >>>>> This change is intended for the use case where libvirt is not in us=
e. In
> >>>>> particular, I use mkosi, which is not a full fledged layering mecha=
nism.
> >>>>>
> >>>>> Regards,
> >>>>> Akihiko Odaki
> >>>>
> >>>
> >>
> >
>


