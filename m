Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34472C36000
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Mar 2025 09:18:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvC17-0007tp-Oi; Thu, 20 Mar 2025 05:16:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1tvC14-0007tA-3R
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 05:16:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1tvC10-0002GZ-GT
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 05:16:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742462196;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=twYLt/D02dbemoVLtHjSrvb+Fz0HaNTLANTZzbqwjtQ=;
 b=CAvfv0bBYlHmC0sXH/WBCdyPKCVLiY9j56FP48Acc+JjJNCKNrmlF6Vsh6RJB0RoA7HRf/
 URi3esJhpa31tkKXQAsm7xgq9yL2xyrZZ8SU3HC1bGjmPKWcGKk+IDmncCOp+YJoiNqkCe
 Q3Md9LQvo8NCXsVHIkUB9I/mxbJD7M4=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-421-vtYL-fx2PF2iMYa5sK1PZw-1; Thu, 20 Mar 2025 05:15:25 -0400
X-MC-Unique: vtYL-fx2PF2iMYa5sK1PZw-1
X-Mimecast-MFC-AGG-ID: vtYL-fx2PF2iMYa5sK1PZw_1742462124
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-ac3e0c1336dso18590866b.3
 for <qemu-devel@nongnu.org>; Thu, 20 Mar 2025 02:15:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742462124; x=1743066924;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=twYLt/D02dbemoVLtHjSrvb+Fz0HaNTLANTZzbqwjtQ=;
 b=RRalfUQ/sdfemEHPK+cqtxlJ3pV1ntzpDYNNW4/mxxK6Jj/jaYx9GbL6rfIWDm5xyg
 2KLeagZl12Aw5vPOjbXIAbpLwwfYBWkgmZxtG/IdUscWlpUSGHZLgppKMw7adFMG/kK0
 97UGGT1/Ji6T1nkbD8Jj5R2q9QVIYgArHsZWIVpJpv2S6Jqui/22no3J4dKehvATUeW0
 iqLk/Qg+y1SV5uPhvp8qhk/c9UHm2ITmlZ4oF7GTYba4UJPW0YQrjZVOgqYxLQGfnLA+
 BKKG5vxwFCtBnQQK9ZTwp/JXhVQKXuwJzR+BCO9a8RCVc6kMA2NvQV+U15BC1SD8WedM
 yIuA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXzyjPV7qfscp9JC8glc619gSM+a44IcLprw2FJgQ/SBIKgTtFBS9FBSujhxcEQjrrReb7a8nc4o5YQ@nongnu.org
X-Gm-Message-State: AOJu0Yz3k71J5EBfaaIsNvwjAhN6B9gMPXntjTfjJICSpjvZgblVnO12
 yT5t1h1SzxXXCIyMtpD4oXEedIsz2uS/tl+wPcH3uRd1ojnI7Xhn9poXPFpP/XZdSU3J5YYzbGr
 ut++YxCTO8eUaC4XaCus3eIY0prSzktNxNcr3AKR08PAL4FGKZWFhHzFQgzqRSzDs4tQ7JSpk9h
 kWqh0XnUSjWsw8Xb8N3wCodWkDsjw=
X-Gm-Gg: ASbGncuqxg2+Y2q5eJ+BS6nVEj3aOJ/f7fhPaOnTEJ6dW2UxdAKW44pHApWCgjty/kM
 LvEa0UGDnoDrCOry7uGRjz1IWzQFzF+IhE4vdN85p8STvr5TZsMMKtslnhbAPh5kDxDpQ4tm23A
 ==
X-Received: by 2002:a17:907:72c1:b0:ac1:fea1:3b68 with SMTP id
 a640c23a62f3a-ac3b7f1ea26mr624887066b.41.1742462123963; 
 Thu, 20 Mar 2025 02:15:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFljbhH6wmQZHNXDXz441psO/XiWd3/JQkUC8Eu00V3Zt15AUJWqTVCIciCs02e85q3hkr/SRnP32VYYXKFZ4c=
X-Received: by 2002:a17:907:72c1:b0:ac1:fea1:3b68 with SMTP id
 a640c23a62f3a-ac3b7f1ea26mr624884066b.41.1742462123495; Thu, 20 Mar 2025
 02:15:23 -0700 (PDT)
MIME-Version: 1.0
References: <553b11b5-4cc4-4e59-9211-74c8cce51a96@linux.ibm.com>
 <CACGkMEvrOx=jN9iULQ_svJdqKt3guJuZNEOan9-eeLirLk7_=g@mail.gmail.com>
In-Reply-To: <CACGkMEvrOx=jN9iULQ_svJdqKt3guJuZNEOan9-eeLirLk7_=g@mail.gmail.com>
From: Cindy Lu <lulu@redhat.com>
Date: Thu, 20 Mar 2025 17:14:45 +0800
X-Gm-Features: AQ5f1JrG2adWEhAyir1b29i7-AoR_l5t72dVOpdxAzu9ZTGyieHpI6NudFdLsso
Message-ID: <CACLfguW6j30mfDTGTTeZzi7-28EbaKqrx9=KoLUQsh7X=jxTrg@mail.gmail.com>
Subject: Re: VDPA MAC address problem
To: Jason Wang <jasowang@redhat.com>
Cc: Konstantin Shkolnyy <kshk@linux.ibm.com>, qemu-devel@nongnu.org,
 dtatulea@nvidia.com, eperezma <eperezma@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=lulu@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.337,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

Hi Konstantin
yes, we have found this kind of issue in this upstream

So here is a fix for this problem in kernel
https://lore.kernel.org/kvm/CACLfguUYny6-1cYABsGS+qtdzO+MKp3O09t_gt-bMM4Jgd=
pZqA@mail.gmail.com/T/
vdpa: support set mac address from vdpa tool

This tool allows the user to change the MAC address before QEMU loads.
The user should ensure that the VDPA device's MAC address matches the
MAC address in the QEMU command line.

On the QEMU side, we plan to add a new parameter to check the MAC
address. If the MAC address in the QEMU command line does not match
the device's MAC address, the system will fail to boot.
https://patchew.org/QEMU/20241109063241.1039433-1-lulu@redhat.com/

but this patch is not merged in upstream yet, I will rebase and send
it to upstream again
Thanks
Cindy

On Thu, Mar 20, 2025 at 8:59=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> Adding Cindy and Eugenio
>
> On Thu, Mar 20, 2025 at 12:34=E2=80=AFAM Konstantin Shkolnyy <kshk@linux.=
ibm.com> wrote:
> >
> > I=E2=80=99m observing a problem while testing VDPA with Nvidia ConnectX=
-6 (mlx5)
> > on s390.
> >
> > Upon start, virtio_net_device_realize() tries to set a new MAC address
> > by VHOST_VDPA_SET_CONFIG which doesn=E2=80=99t do anything.
> >
> > Later, the VM gets started and learns about the old address from
> > virtio_net_get_config() which returns whatever VHOST_VDPA_GET_CONFIG
> > returns, unless it's "6 zero bytes", in which case it instead returns
> > the desired new address (and the problem is avoided).
> >
> > Then QEMU again tries to set the new address from vhost_net_start(), no=
w
> > by calling vhost_vdpa_net_load_cmd(...,VIRTIO_NET_CTRL_MAC,
> > VIRTIO_NET_CTRL_MAC_ADDR_SET, ...). This time the new address is
> > successfully programmed into the NIC, but the VM doesn't know about it.
>
> Have you enabled shadow virtqueue? If yes, does it work if you don't do t=
hat?
>
> >
> > As the result, the VM now sends packets with a source address on which
> > the NIC doesn=E2=80=99t listen.
> >
> > Upon reading this forum, I see that VHOST_VDPA_SET_CONFIG is
> > =E2=80=9Cdeprecated=E2=80=9D, and so VIRTIO_NET_CTRL_MAC_ADDR_SET must =
be the right
> > method, but it=E2=80=99s apparently called too late.
>
> VHOST_VDPA_SET_CONFIG requires the vDPA parent support which is not
> necessarily there.
> VIRTIO_NET_CTRL_MAC_ADDR_SET requires the shadow virtqueue as well as
> the CTRL_MAC_ADDR support.
>
> Neither of them seems robust.
>
> > Or maybe
> > virtio_net_get_config() needs to always return the desired new address
> > and not the old one from VHOST_VDPA_GET_CONFIG?
> >
> > I=E2=80=99m looking for an opinion/direction from someone who knows thi=
s code.
> >
> > As it is, the only VDPA scenario that's working for me is:
> > 1) Avoid specifying the MAC address in the "vdpa dev add" command (whic=
h
> > will create the "6 zero bytes" condition on the first launch).
> > 2) Keep using the same MAC address for every subsequent VM launch on th=
e
> > same NIC "virtual function" (so that the old and new addresses are the
> > same).
>
> This is the way we currently use it. Is there any limitation of this?
>
> Thanks
>
> >
>


