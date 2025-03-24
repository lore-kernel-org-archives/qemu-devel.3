Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C6FAC36001
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Mar 2025 04:06:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twZ3m-0007yx-Lq; Mon, 24 Mar 2025 00:05:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1twZ3W-0007ux-Cg
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 00:04:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1twZ3U-0002fi-B8
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 00:04:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742789090;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kx9FKP2OSaeEfv+u80zms3JE0BaYrGhKmfnuGiR6/cE=;
 b=IvXvA6bYiBEr8QnqtMnxWSJsn98TJ12EUqoPuVc1SmnSuTFvtKA84xsxmki/UuTGICZWgm
 SYHzCV7PPbDVpYE3lRR6W9DzaE7MH0gs6DYMHzEHlE/6dd4WQkepwTm30LToTfDhmpnlEM
 fbvPK4rp6dlm2lMKHrTvz5KNJbap3mY=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-373-AEfrOVVjPnyMwIBExAlsCA-1; Mon, 24 Mar 2025 00:04:48 -0400
X-MC-Unique: AEfrOVVjPnyMwIBExAlsCA-1
X-Mimecast-MFC-AGG-ID: AEfrOVVjPnyMwIBExAlsCA_1742789087
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-2ff854a2541so6308858a91.0
 for <qemu-devel@nongnu.org>; Sun, 23 Mar 2025 21:04:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742789087; x=1743393887;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kx9FKP2OSaeEfv+u80zms3JE0BaYrGhKmfnuGiR6/cE=;
 b=NJz0cUEN48ctTZB8ShQd1iZgwVF5dDsEpXq+X6afG3XqeYjypOpIaIBvU4zI9LGDT+
 ndoYhiltOYqQ94dXu2wV62EVyXqW5uTCG8CRufEObhz3ZTHy+oPRhJoDLCyoMxJCq98Q
 NMoaLZ6vYJdAmOFNtMT7nXGJ/p3e/PEQwFqC2z6w771FaJlYOdLUmyaUBRdANnhwCcgT
 KOwLSkmIGKipeniFYP+dpjuVS3EPPPNmkahqm1pbsZHOfHh8Uk/zlNE1bTaf7ctcukWF
 Jh8XsHybSqlsYljVlL4KoN+ebrsgL4eWjj3GBVUej34SeAuZwVxPS9l5Ds874/TnNFTj
 7iXg==
X-Gm-Message-State: AOJu0YyzlKG5hWTPcyYn7mvciSE6bRRLJLBWT5XXdaymX4sXO8SxDdtg
 3FQmFsrPNbpwCT1FyV4c80fqY3I+WjRQ3l27qorfBaLaTAixgvOhHh3k0oojUXIJhTY+jtIgnCw
 FKloDI4lFE1RrnxuzLB4VMCWPIys5c3mQc0oraF4BG5KjIcuvQS4ZiPxvlJOgRVqH2d+yCtE1LM
 8fbbf+Yc0VRX3xxrHUuSKZYUUk22Q=
X-Gm-Gg: ASbGncvUamVrrIQUAtshdP9F+htgP+5cDHZ3kgp1jX5S2THBgyl0CqqlsbMXrDZxgG6
 YkKO9k/D+IpsXOY5lPjVv/1wLBSkXH+Kmxso06XjEpG4kZUcq5bfrXBbHRdYm+aJky8G/TlQ=
X-Received: by 2002:a17:90b:1b0b:b0:2ee:8e75:4aeb with SMTP id
 98e67ed59e1d1-3030feb7a20mr18424852a91.17.1742789087319; 
 Sun, 23 Mar 2025 21:04:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFnbDr63EXlxhsNFX4mXxnypvcDfZ+aP8VINicug2gXKmcOG4cDYH5zzRjvAjUy9hgsCE9r6Xt9/cj3EqvX6dg=
X-Received: by 2002:a17:90b:1b0b:b0:2ee:8e75:4aeb with SMTP id
 98e67ed59e1d1-3030feb7a20mr18424808a91.17.1742789086799; Sun, 23 Mar 2025
 21:04:46 -0700 (PDT)
MIME-Version: 1.0
References: <553b11b5-4cc4-4e59-9211-74c8cce51a96@linux.ibm.com>
 <CACGkMEvrOx=jN9iULQ_svJdqKt3guJuZNEOan9-eeLirLk7_=g@mail.gmail.com>
 <fa821773-225f-4e2b-8642-72d269802d96@linux.ibm.com>
 <CACGkMEsOx5bdpny3y9BfJsefNKbiXk2bG3+TPKtFyr7CWhz1FA@mail.gmail.com>
 <816c6468-9fb4-44d3-9bce-ecdc04f118be@linux.ibm.com>
In-Reply-To: <816c6468-9fb4-44d3-9bce-ecdc04f118be@linux.ibm.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 24 Mar 2025 12:04:35 +0800
X-Gm-Features: AQ5f1Joi-8RtnBRIXJBMRxOz24YnE0u1U-i4a23sD8zgRm7zjR7b1OvZ3-LoLhU
Message-ID: <CACGkMEsK12J6+vrg_rnv9mL6=AGRKsiUvuXcaafEh1BzaFpDPQ@mail.gmail.com>
Subject: Re: VDPA MAC address problem
To: Konstantin Shkolnyy <kshk@linux.ibm.com>
Cc: qemu-devel@nongnu.org, dtatulea@nvidia.com, Cindy Lu <lulu@redhat.com>, 
 eperezma <eperezma@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

On Fri, Mar 21, 2025 at 12:29=E2=80=AFPM Konstantin Shkolnyy <kshk@linux.ib=
m.com> wrote:
>
> On 3/20/2025 20:22, Jason Wang wrote:
> > On Fri, Mar 21, 2025 at 12:45=E2=80=AFAM Konstantin Shkolnyy <kshk@linu=
x.ibm.com> wrote:
> >>
> >> On 3/19/2025 19:58, Jason Wang wrote:
> >>> On Thu, Mar 20, 2025 at 12:34=E2=80=AFAM Konstantin Shkolnyy <kshk@li=
nux.ibm.com> wrote:
> >>>> Upon reading this forum, I see that VHOST_VDPA_SET_CONFIG is
> >>>> =E2=80=9Cdeprecated=E2=80=9D, and so VIRTIO_NET_CTRL_MAC_ADDR_SET mu=
st be the right
> >>>> method, but it=E2=80=99s apparently called too late.
> >>>
> >>> VHOST_VDPA_SET_CONFIG requires the vDPA parent support which is not
> >>> necessarily there.
> >>
> >> The mlx5 driver doesn't do anything for VHOST_VDPA_SET_CONFIG. Intel's
> >> driver, however, apparently stores the configuration. So, it appears,
> >> Intel will avoid the problem... Perhaps mlx5 could do the same so that
> >> QEMU can set the address before it starts the VM (QEMU doesn't have to
> >> later let the VM change the config).
> >
> > The problem is that config space is not allowed to be written, that is
> > why mlx5 doesn't implement the write method.
> >
> >> Conceptually, setting the address
> >> by QEMU cmdline doesn't look different from setting it by "vdpa dev ad=
d".
> >
> > It's kind of different.
> >
> > E.g the device may not even have VIRTIO_NET_F_MAC feature etc.
>
> I'm not sure I understand... This is the MAC address returned by
> VHOST_VDPA_GET_CONFIG. If mlx5 allows it to be set by "vdpa dev add",

This requires privileges where userspace(VM) doesn't necessarily have.

> shouldn't it also allow it to be set by VHOST_VDPA_SET_CONFIG called by
> virtio_net_device_realize(), before the VM exists.
>
> When VM starts running, it queries this MAC address and QEMU fetches it
> by VHOST_VDPA_GET_CONFIG. But, because VHOST_VDPA_SET_CONFIG hasn't
> stored it, it fetches a wrong stale address.

For example, for some reason management wants to forbid mac address
changes from the guest.

Thanks


