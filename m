Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41157D2A53A
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2024 08:11:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1i4h-0002Qe-KC; Fri, 18 Oct 2024 04:11:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1t1i4g-0002QR-Bp
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 04:11:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1t1i4b-0008IV-Lg
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 04:11:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729239059;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GnYRvdyBruGmbcEzUMOkKVqAqONPPdnQZZu+rgeNj2A=;
 b=SDwN1S21f72oUoxG6AzBF3GPWFqfHebb5igbSx8/kGB+vFUV7iatwEdMnziTFCtaoiXozW
 88l9Qcl1L+lZgF91+GwU09X+MIjFJ5kpjFwIr4JBwflnixomKT2hYDoyUvBoFWEmbgPB1p
 x2/y45tBgBETQVBT3U0xigEEMk4ZqZ4=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-8FFEh56iPBWrbrHsQxu7Jg-1; Fri, 18 Oct 2024 04:10:57 -0400
X-MC-Unique: 8FFEh56iPBWrbrHsQxu7Jg-1
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-7163489149fso1641660a12.3
 for <qemu-devel@nongnu.org>; Fri, 18 Oct 2024 01:10:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729239056; x=1729843856;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GnYRvdyBruGmbcEzUMOkKVqAqONPPdnQZZu+rgeNj2A=;
 b=B1GwuZ4ONwo/X8Z8ur5ltM2u9FQ64L1HPH+Hrh+C9bRBLlYQtO1bZcDGDA63HvSJI5
 oIaWEVZ3g4u+xnL4iVslcxZllmPP0Nm5Ic535IIcigV5Wzr1L+qsO4gVzDagUKwZhj0/
 auvRDhPXrjqZGrO1iVlcG1Zesji0eeX1tclfZc3l94IdOzR2wk3FBsIzKS7Bv3jinsEI
 7zwZs8j4ggXyYXb+KKz+lyiSdKRBmfU4qlSd3F5PJ5GLMfutPnW/JOk7YK/5DFlxCqIV
 HXL+rLN40havAA+fyatC+GtfZ1CgIMJZwoAvIaPwyvk7W4GxtTh+3BKimh8mDd29rDYB
 vjuw==
X-Gm-Message-State: AOJu0Yw66kkH16e5/64a7s+rqO14tsifjYew9VzRki9UU3uhM1gb1NXu
 UonSIugUhEtiFQaKZgBCVMeSiSkbTNkVaiU64t0tgfEKAH6lihUMbmvJPPwBGI4xXJh03MYvukE
 UZiKJHvolXM4oMB4/pOAmWiOM5sUQgJul5PKnhTl4+3Lnz63VSflSUu/228y9IbcuJQXPAOlbLO
 B6XfZZ9HOzIO6bHz8oMZGKuEMCIzg=
X-Received: by 2002:a05:6a20:b58b:b0:1d9:215c:c641 with SMTP id
 adf61e73a8af0-1d92c585edcmr1676297637.48.1729239055853; 
 Fri, 18 Oct 2024 01:10:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFMCFBpa6RiEkA3Axt8bmrowF+pgX55Zp5KEJ/SDJmpQNbZdvQeaGMETWC2TYhhzxGE6cnacXmxol6+5CTKZeI=
X-Received: by 2002:a05:6a20:b58b:b0:1d9:215c:c641 with SMTP id
 adf61e73a8af0-1d92c585edcmr1676278637.48.1729239055381; Fri, 18 Oct 2024
 01:10:55 -0700 (PDT)
MIME-Version: 1.0
References: <20241008-macvtap-v1-1-2032caa25b6d@daynix.com>
 <CACGkMEvmEsFdLRgF9CLQCEo0jt3dX8wAPLjRC2pNb4ofD8dLNQ@mail.gmail.com>
 <469f9995-9182-43c2-93d7-ab8dbefb9eb9@daynix.com>
In-Reply-To: <469f9995-9182-43c2-93d7-ab8dbefb9eb9@daynix.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 18 Oct 2024 16:10:44 +0800
Message-ID: <CACGkMEs2hkX7S3QJK1yLbJjSxW=obiSOYwKA4w2xiJwuOooq4g@mail.gmail.com>
Subject: Re: [PATCH] tap-linux: Open ipvtap and macvtap
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.068,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Sat, Oct 12, 2024 at 5:05=E2=80=AFPM Akihiko Odaki <akihiko.odaki@daynix=
.com> wrote:
>
> On 2024/10/09 16:41, Jason Wang wrote:
> > On Tue, Oct 8, 2024 at 2:52=E2=80=AFPM Akihiko Odaki <akihiko.odaki@day=
nix.com> wrote:
> >>
> >> ipvtap and macvtap create a file for each interface unlike tuntap, whi=
ch
> >> creates one file shared by all interfaces. Try to open a file dedicate=
d
> >> to the interface first for ipvtap and macvtap.
> >>
> >
> > Management layers usually pass these fds via SCM_RIGHTS. Is this for
> > testing purposes? (Note that we can use something like -netdev
> > tap,fd=3D10 10<>/dev/tap0).
>
> I used this for testing.

Anything that prevents you from using fd redirection? If not
management interest and we had already had a way for testing, I tend
to not introduce new code as it may bring bugs.

>
> >
> >> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> >> ---
> >>   net/tap-linux.c | 17 ++++++++++++++---
> >>   1 file changed, 14 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/net/tap-linux.c b/net/tap-linux.c
> >> index 1226d5fda2d9..22ec2f45d2b7 100644
> >> --- a/net/tap-linux.c
> >> +++ b/net/tap-linux.c
> >> @@ -45,10 +45,21 @@ int tap_open(char *ifname, int ifname_size, int *v=
net_hdr,
> >>       int len =3D sizeof(struct virtio_net_hdr);
> >>       unsigned int features;
> >>
> >> -    fd =3D RETRY_ON_EINTR(open(PATH_NET_TUN, O_RDWR));
> >> +
> >> +    ret =3D if_nametoindex(ifname);
> >> +    if (ret) {
> >> +        g_autofree char *file =3D g_strdup_printf("/dev/tap%d", ret);
> >> +        fd =3D open(file, O_RDWR);
> >> +    } else {
> >> +        fd =3D -1;
> >> +    }
> >> +
> >>       if (fd < 0) {
> >> -        error_setg_errno(errp, errno, "could not open %s", PATH_NET_T=
UN);
> >> -        return -1;
> >> +        fd =3D RETRY_ON_EINTR(open(PATH_NET_TUN, O_RDWR));
> >
> > Any reason tuntap were tried after the macvtap/ipvtap?
>
> If we try tuntap first, we will know that it is not tuntap when calling
> TUNSETIFF. We will need to call TUNGETFEATURES and TUNSETVNETHDRSZ again
> in such a case because they precede TUNSETIFF. Calling them twice is
> troublesome.

I may miss something, we are only at the phase of open() not TUNSETIFF?

>
> This is also consistent with libvirt. libvirt first checks if
> g_strdup_printf("/dev/tap%d", ifindex) exists, and falls back to tuntap
> otherwise.

This is not what I understand from how layered products work. Libvirt
should align with Qemu for low level things like TAP, not the reverse.

Thanks

>
> Regards,
> Akihiko Odaki
>
> >
> >> +        if (fd < 0) {
> >> +            error_setg_errno(errp, errno, "could not open %s", PATH_N=
ET_TUN);
> >> +            return -1;
> >> +        }
> >>       }
> >>       memset(&ifr, 0, sizeof(ifr));
> >>       ifr.ifr_flags =3D IFF_TAP | IFF_NO_PI;
> >>
> >> ---
> >> base-commit: 31669121a01a14732f57c49400bc239cf9fd505f
> >> change-id: 20241008-macvtap-b152e5abb457
> >>
> >> Best regards,
> >> --
> >> Akihiko Odaki <akihiko.odaki@daynix.com>
> >
> > Thanks
> >
> >>
> >
>


