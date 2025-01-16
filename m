Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FDDFC02180
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 01:19:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYEWL-0006s1-Ed; Wed, 15 Jan 2025 20:18:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1tYEWK-0006rs-2L
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 20:18:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1tYEWH-0005a1-B4
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 20:18:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736990278;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HkYcO31sZRMEMKZ9zponSn4kvS4RoxHPszM/mwbjTWM=;
 b=O1XPRewjMgiRe54+aXsdaKbdS+Ce1Zr7zo2OWN/oeV8Oubzj2mZmUTDW6coUmHbdE/TvRo
 p2AiRocsfjoj2u+9qM/5TUtGtNNB+2U/kscqgLB9iQC6wSjMUjhpBL/ZSBbswUIoUDa/Sf
 klnv+IOgSEj2PEHucD65imcaljuWkz0=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-321-TrsoSM16PcamNvWg9flzYA-1; Wed, 15 Jan 2025 20:17:54 -0500
X-MC-Unique: TrsoSM16PcamNvWg9flzYA-1
X-Mimecast-MFC-AGG-ID: TrsoSM16PcamNvWg9flzYA
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-2ef9e38b0cfso908535a91.0
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2025 17:17:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736990272; x=1737595072;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HkYcO31sZRMEMKZ9zponSn4kvS4RoxHPszM/mwbjTWM=;
 b=FSC+C9V4ae9Q49q9K91ormiHhLyERqcIyA/6kGfiRxtj8Nbir6E8PAhkkALW8c8IpW
 61rDyz+ILxnhfB80gvC8UP2lIYfsLxQRLrjIduc5iGq0myOX9Tf7KJvXGVNwXH8rB9y9
 zyvsBLeGRqtU+EB8qO2oZzaLig7ccDGfqvdDMySLHP8ciMUIzlkvhNkVjPb2kK6SO/Dh
 RmsL4BoAvzlvtgnP4aY9Y0KdXZWvHbaoSvrQm9x6I48SKRyeNJHs3fkVAOD3rus2aCwW
 e0J2/yy7PDTO4J5fuOi4LsauQzvsmNSIoVTQgdPtxUM2sr+PRuozDNX4jVG9nufuxR/S
 TLmQ==
X-Gm-Message-State: AOJu0Yys0LYSzVPDlvwGV/XQIkG5a2UjDNEXFyVe8nWfJtM4recupVsb
 I68PvkgEnGXd1+vGjOMkhHtU9MPso07LJG4hhNBljRH6VTOeT9+W6XEY3keHjBvtnZvJ0nQqeMD
 07dJK2hqsdZ6vg90xWP+rNNiTKAe1Sv2w+rOd/CkNyXQB2PShANU4+juOUwrG7MG5Km5UX5jIq3
 HKMAYzIdAtVuu4t0lh6OkMPW6DVWEJLy/s+oEH3A==
X-Gm-Gg: ASbGncsT7sn8JFzgmxbehsLpk5HvulW48lFa12kY+SEf1leJIvFtDNdxVxnEr16IEvf
 tQrttuxx9J0+PcCJoeIIsNCnx5Msn2KIW1xhskN4=
X-Received: by 2002:a17:90b:2c84:b0:2f4:47fc:7f18 with SMTP id
 98e67ed59e1d1-2f548ebb679mr45923531a91.10.1736990271871; 
 Wed, 15 Jan 2025 17:17:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHcu5eKQXJLuvOptMomlNu0r2JKzjllTDv6S29vZ5l++dDFG1O2mJQIVloZopSrgYLoYwbYTOcnXu6b8sv9cQU=
X-Received: by 2002:a17:90b:2c84:b0:2f4:47fc:7f18 with SMTP id
 98e67ed59e1d1-2f548ebb679mr45923501a91.10.1736990271444; Wed, 15 Jan 2025
 17:17:51 -0800 (PST)
MIME-Version: 1.0
References: <20241008-macvtap-v1-1-2032caa25b6d@daynix.com>
 <CACGkMEvmEsFdLRgF9CLQCEo0jt3dX8wAPLjRC2pNb4ofD8dLNQ@mail.gmail.com>
 <469f9995-9182-43c2-93d7-ab8dbefb9eb9@daynix.com>
 <CACGkMEs2hkX7S3QJK1yLbJjSxW=obiSOYwKA4w2xiJwuOooq4g@mail.gmail.com>
 <74d218be-2119-4977-8d2e-40a51cccde9d@daynix.com>
 <50e784b2-850d-4d1b-9fc8-7fb6076f101e@daynix.com>
 <CACGkMEu6sFRm+xVxEp6X+N_qRH+qcbi_W3onXxX3uRPjS0hiFA@mail.gmail.com>
 <db4deda5-2869-45d2-8d56-9ba390324cd6@daynix.com>
In-Reply-To: <db4deda5-2869-45d2-8d56-9ba390324cd6@daynix.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 16 Jan 2025 09:17:40 +0800
X-Gm-Features: AbW1kvbb7EHNQGXa7O8n9d0vEx7UfqxhSSaENmp2oJcFjNEuYQ0Jzh53hP_jKsA
Message-ID: <CACGkMEv0XwU=P-V6RiRgBFtzZt19En921SPuTj+bNhYFyMSrFQ@mail.gmail.com>
Subject: Re: [PATCH] tap-linux: Open ipvtap and macvtap
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Jan 15, 2025 at 1:17=E2=80=AFPM Akihiko Odaki <akihiko.odaki@daynix=
.com> wrote:
>
> On 2025/01/13 11:59, Jason Wang wrote:
> > On Sat, Jan 11, 2025 at 1:43=E2=80=AFPM Akihiko Odaki <akihiko.odaki@da=
ynix.com> wrote:
> >>
> >> Hi Jason,
> >>
> >> Can you check this patch again?
> >
> > I would like to have this if
> >
> > 1) it would be used by libvirt.
> >
> > or
> >
> > 2) there's no other way to do this
>
> I need this to make QEMU work with macvtap on mkosi, and this patch is
> an effective way to accomplish the goal.

I'm not sure how to define "effective" here.

>
> Requiring to pass a file descriptor is simply less convenient. Most (if
> not all) aspects of QEMU can be configured without file descriptors; I
> don't think there is a reason to make tap exceptional.

TUNSETIFF requires CAP_NET_ADMIN and qemu doesn't want to run with
privilege, so fd is prefered in the case of tuntap.

For macvtap,ipvtap, though open, doesn't require any privilege.
Passing fd via SCM_RIGHTS is still preferable as it eases the
interaction with security facilities (for example, you may want to
whitelist /dev/tapX for Qemu to access etc).

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
> >> On 2024/10/22 13:59, Akihiko Odaki wrote:
> >>> On 2024/10/18 17:10, Jason Wang wrote:
> >>>> On Sat, Oct 12, 2024 at 5:05=E2=80=AFPM Akihiko Odaki
> >>>> <akihiko.odaki@daynix.com> wrote:
> >>>>>
> >>>>> On 2024/10/09 16:41, Jason Wang wrote:
> >>>>>> On Tue, Oct 8, 2024 at 2:52=E2=80=AFPM Akihiko Odaki
> >>>>>> <akihiko.odaki@daynix.com> wrote:
> >>>>>>>
> >>>>>>> ipvtap and macvtap create a file for each interface unlike tuntap=
,
> >>>>>>> which
> >>>>>>> creates one file shared by all interfaces. Try to open a file
> >>>>>>> dedicated
> >>>>>>> to the interface first for ipvtap and macvtap.
> >>>>>>>
> >>>>>>
> >>>>>> Management layers usually pass these fds via SCM_RIGHTS. Is this f=
or
> >>>>>> testing purposes? (Note that we can use something like -netdev
> >>>>>> tap,fd=3D10 10<>/dev/tap0).
> >>>>>
> >>>>> I used this for testing.
> >>>>
> >>>> Anything that prevents you from using fd redirection? If not
> >>>> management interest and we had already had a way for testing, I tend
> >>>> to not introduce new code as it may bring bugs.
> >>>
> >>> I don't know what ifindex the macvtap device has so it's easier to us=
e
> >>> if QEMU can automatically figure out the it.
> >>>
> >>>>
> >>>>>
> >>>>>>
> >>>>>>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> >>>>>>> ---
> >>>>>>>     net/tap-linux.c | 17 ++++++++++++++---
> >>>>>>>     1 file changed, 14 insertions(+), 3 deletions(-)
> >>>>>>>
> >>>>>>> diff --git a/net/tap-linux.c b/net/tap-linux.c
> >>>>>>> index 1226d5fda2d9..22ec2f45d2b7 100644
> >>>>>>> --- a/net/tap-linux.c
> >>>>>>> +++ b/net/tap-linux.c
> >>>>>>> @@ -45,10 +45,21 @@ int tap_open(char *ifname, int ifname_size, i=
nt
> >>>>>>> *vnet_hdr,
> >>>>>>>         int len =3D sizeof(struct virtio_net_hdr);
> >>>>>>>         unsigned int features;
> >>>>>>>
> >>>>>>> -    fd =3D RETRY_ON_EINTR(open(PATH_NET_TUN, O_RDWR));
> >>>>>>> +
> >>>>>>> +    ret =3D if_nametoindex(ifname);
> >>>>>>> +    if (ret) {
> >>>>>>> +        g_autofree char *file =3D g_strdup_printf("/dev/tap%d", =
ret);
> >>>>>>> +        fd =3D open(file, O_RDWR);
> >>>>>>> +    } else {
> >>>>>>> +        fd =3D -1;
> >>>>>>> +    }
> >>>>>>> +
> >>>>>>>         if (fd < 0) {
> >>>>>>> -        error_setg_errno(errp, errno, "could not open %s",
> >>>>>>> PATH_NET_TUN);
> >>>>>>> -        return -1;
> >>>>>>> +        fd =3D RETRY_ON_EINTR(open(PATH_NET_TUN, O_RDWR));
> >>>>>>
> >>>>>> Any reason tuntap were tried after the macvtap/ipvtap?
> >>>>>
> >>>>> If we try tuntap first, we will know that it is not tuntap when cal=
ling
> >>>>> TUNSETIFF. We will need to call TUNGETFEATURES and TUNSETVNETHDRSZ =
again
> >>>>> in such a case because they precede TUNSETIFF. Calling them twice i=
s
> >>>>> troublesome.
> >>>>
> >>>> I may miss something, we are only at the phase of open() not TUNSETI=
FF?
> >>>
> >>> We can tell if it is macvtap/ipvtap just by trying opening the device
> >>> file. That is not possible with tuntap because tuntap uses /dev/net/t=
un,
> >>> a device file common for all tuntap interfaces and its presence does =
not
> >>> tell if the interface is tuntap.
> >>>
> >>>>
> >>>>>
> >>>>> This is also consistent with libvirt. libvirt first checks if
> >>>>> g_strdup_printf("/dev/tap%d", ifindex) exists, and falls back to tu=
ntap
> >>>>> otherwise.
> >>>>
> >>>> This is not what I understand from how layered products work. Libvir=
t
> >>>> should align with Qemu for low level things like TAP, not the revers=
e.
> >>>
> >>> This change is intended for the use case where libvirt is not in use.=
 In
> >>> particular, I use mkosi, which is not a full fledged layering mechani=
sm.
> >>>
> >>> Regards,
> >>> Akihiko Odaki
> >>
> >
>


