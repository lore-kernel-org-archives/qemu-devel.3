Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 375F1C35FFF
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Mar 2025 01:23:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvR6j-0003Qz-Py; Thu, 20 Mar 2025 21:23:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1tvR6h-0003QT-45
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 21:23:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1tvR6e-0007x3-Ig
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 21:23:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742520207;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EbdO/qLz3qQxfQhexe4/3x7QSlw5d7uX+UagPeCsop8=;
 b=Wz/xHmazA+JHOvpsUUFJcZVN8LVRtyIt3q8XpkruWRtv4kuqT+em7jV2zuSdQOBVc3LepX
 YGZ1p7OBD34XWm+WawxbLXdKU3ksnPEhOQEpWuZ+0UEn3hlxwGJPo3c5kO8v6WBv6swmcc
 Xco4XCbWwkoPH/HFzTw6CKEgbwdR2Xg=
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-444-Xl9kB0WlPTqVX0xqku4e2w-1; Thu, 20 Mar 2025 21:23:26 -0400
X-MC-Unique: Xl9kB0WlPTqVX0xqku4e2w-1
X-Mimecast-MFC-AGG-ID: Xl9kB0WlPTqVX0xqku4e2w_1742520205
Received: by mail-ua1-f70.google.com with SMTP id
 a1e0cc1a2514c-8617b6c6d03so284972241.3
 for <qemu-devel@nongnu.org>; Thu, 20 Mar 2025 18:23:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742520205; x=1743125005;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EbdO/qLz3qQxfQhexe4/3x7QSlw5d7uX+UagPeCsop8=;
 b=PciSP+hTiNR2yMk/25dmIeTZFXCKxZerxGALilAJh7NtjIdiZrrUATUWr6HPQCm4jH
 ToJ0XeB4Yt3KOnCk5Av+rdjhcVIHEhKHYxAPnKxWsJt47An5L7RMpZF48GnH0Yrj0o38
 i2CXPUFivFZ0cxUmPfI7hCCKplpqeRvCWUEKzSUKq6W8rW1pE7XBZCxLgIAX07/IdC5w
 JjMp2lRHHrXLTyly1F4ShoNNsYQnD1lByghh/5iNDbd4dMV/TAI/Uvt0oHXrU0xKrh30
 Lms+EXlp2zUOzZ4r7/ruZ+Xltn5S/aeNmIcfXOO5HyISeDw5gcveFCi4rlgY8PHZduCO
 uERw==
X-Gm-Message-State: AOJu0Yw9IQLbF+zk4koNKnEKzbsbZozykgalhpbWvMySqgRUAbw2GLcM
 QWPzGS1U2i9+tdJ6ZxERlyf1SeAv6jB9za1bwxksVI2gfB/xSi0VdtBcfeH5Sz8RxQxGBRrSDl8
 akPJ7DQMcyauDmDG2ZK8AXTrCZS1s5l5yS8UNtUpAgEJ47YQCEMPkcEDe1Hls8fV8v4o64/j2JL
 kFvJwCfJSAplGrkovM9aDWiuQEFQQ=
X-Gm-Gg: ASbGncswwPjfQ1MBlD1/sAkgLhcc2X/aFFv5lweUH/tx0zCsXmGHbUC/8CGXRfNrj3f
 gDvsPkUbrDcFby0oV97tRITVJrT/deYTix/X+1ZSVSIDVf1Zmlxk1MjBz2y8P+WdAZWKK9xdr
X-Received: by 2002:a05:6102:290a:b0:4c4:fdb9:2ea with SMTP id
 ada2fe7eead31-4c50d4bdcfamr1210486137.7.1742520205629; 
 Thu, 20 Mar 2025 18:23:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEkOH4+FLiLK8GLvFueH1rwlEb8q/Zk3fMZbvatQNw1CoqfGIwdqrlxNusQJM5sYAuDS/wlP0NXhlmmIaZZZik=
X-Received: by 2002:a05:6102:290a:b0:4c4:fdb9:2ea with SMTP id
 ada2fe7eead31-4c50d4bdcfamr1210481137.7.1742520205304; Thu, 20 Mar 2025
 18:23:25 -0700 (PDT)
MIME-Version: 1.0
References: <553b11b5-4cc4-4e59-9211-74c8cce51a96@linux.ibm.com>
 <CACGkMEvrOx=jN9iULQ_svJdqKt3guJuZNEOan9-eeLirLk7_=g@mail.gmail.com>
 <2aa3381f-cf89-4634-aac8-3ed5491f0ee8@linux.ibm.com>
In-Reply-To: <2aa3381f-cf89-4634-aac8-3ed5491f0ee8@linux.ibm.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 21 Mar 2025 09:23:12 +0800
X-Gm-Features: AQ5f1JoIM6wjVmrZe1cSd05WA3_ZS9auwd3jAniBL9D0j_jYNFzviTaOlpdQDlo
Message-ID: <CACGkMEsE=bh4f=pZ1_3cjHQqwsipejceuVLAzowkcXeT77XS_Q@mail.gmail.com>
Subject: Re: VDPA MAC address problem
To: Konstantin Shkolnyy <kshk@linux.ibm.com>
Cc: qemu-devel@nongnu.org, dtatulea@nvidia.com, Cindy Lu <lulu@redhat.com>, 
 eperezma <eperezma@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.332,
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

On Thu, Mar 20, 2025 at 10:19=E2=80=AFPM Konstantin Shkolnyy <kshk@linux.ib=
m.com> wrote:
>
> On 3/19/2025 19:58, Jason Wang wrote:
> > Adding Cindy and Eugenio
> >
> > On Thu, Mar 20, 2025 at 12:34=E2=80=AFAM Konstantin Shkolnyy <kshk@linu=
x.ibm.com> wrote:
> >>
> >> I=E2=80=99m observing a problem while testing VDPA with Nvidia Connect=
X-6 (mlx5)
> >> on s390.
> >>
> >> Upon start, virtio_net_device_realize() tries to set a new MAC address
> >> by VHOST_VDPA_SET_CONFIG which doesn=E2=80=99t do anything.
> >>
> >> Later, the VM gets started and learns about the old address from
> >> virtio_net_get_config() which returns whatever VHOST_VDPA_GET_CONFIG
> >> returns, unless it's "6 zero bytes", in which case it instead returns
> >> the desired new address (and the problem is avoided).
> >>
> >> Then QEMU again tries to set the new address from vhost_net_start(), n=
ow
> >> by calling vhost_vdpa_net_load_cmd(...,VIRTIO_NET_CTRL_MAC,
> >> VIRTIO_NET_CTRL_MAC_ADDR_SET, ...). This time the new address is
> >> successfully programmed into the NIC, but the VM doesn't know about it=
.
> >
> > Have you enabled shadow virtqueue? If yes, does it work if you don't do=
 that?
>
> I only run it in the default configuration, which has SVQ enabled.
>
> >> As it is, the only VDPA scenario that's working for me is:
> >> 1) Avoid specifying the MAC address in the "vdpa dev add" command (whi=
ch
> >> will create the "6 zero bytes" condition on the first launch).
> >> 2) Keep using the same MAC address for every subsequent VM launch on t=
he
> >> same NIC "virtual function" (so that the old and new addresses are the
> >> same).
> >
> > This is the way we currently use it. Is there any limitation of this?
>
> To be honest, I don't know how severe this limitation is, because I'm
> not a sysadmin. The problem is that I was searching www for info on how
> to setup VDPA and ended up hitting this bug and investigating it.

Exactly, I think we need to improve the documentation anyhow.

> Because the found info sources are variable and some show the address
> specified in "vdpa dev add".
>

Thanks


