Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02742C2D0CD
	for <qemu-devel@archiver.kernel.org>; Fri, 16 May 2025 01:51:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFkEJ-0004Fh-Aa; Thu, 15 May 2025 21:51:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1uFkEH-0004FC-Js
 for qemu-devel@nongnu.org; Thu, 15 May 2025 21:51:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1uFkEF-0004Iz-DA
 for qemu-devel@nongnu.org; Thu, 15 May 2025 21:51:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747360274;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m/vq544+DNrbSOXrPhh5QTZnZWXhLdBg85kJmijal4c=;
 b=TH0DapQ9y0QWh68HIvi2nwtw+CEW/c4h/F05VGEejPSxtDcjAJJRcDZJJl2MNGK9IInNLI
 JnbYeGw3pSEabcQVhMFyo0OGzj6e0+4ADHoDZo/ZNJ4CS1viqUj+TqJHThnKiTdxba9vA/
 iVBNpI7Mro/yZtXwNy4ShHl5llrNHZc=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-660-QqjpRgTUOhSDj1IcjYWJmg-1; Thu, 15 May 2025 21:51:12 -0400
X-MC-Unique: QqjpRgTUOhSDj1IcjYWJmg-1
X-Mimecast-MFC-AGG-ID: QqjpRgTUOhSDj1IcjYWJmg_1747360272
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-30ab5d34fdbso1729900a91.0
 for <qemu-devel@nongnu.org>; Thu, 15 May 2025 18:51:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747360272; x=1747965072;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=m/vq544+DNrbSOXrPhh5QTZnZWXhLdBg85kJmijal4c=;
 b=AUmE0UZHGotavzaeQdFcgy3yDy+f7FeJg8Mti2/2LN/BuyXc4G+5JQ5mVvH59K7WRv
 Ki6c4gMzjkSjbYHUUepqEIe8BV4GrQH9CfMkQ3D5VXTliHcHzD9URdx0Vyhd7no5Ja7r
 vXgxh0FIZDjeNfpXRs7NaFYnk8/rrOTHEVFnKQLK0MZkjKnsuV4SGxWZzBslkY9ku4kS
 APOlK4yk2GVZmsx3bLi6+sj5oky7JCxnUPxbyQ+SO98H0ZOstCB/FAzwpp0V+ax+tVfj
 hFNEuBkBiQFJZNyjN5hc404xGJFhQj6nIm2Ji/aRgdMHcU4+wQF+ovNCAdg0Vg7aG+FA
 7/jw==
X-Gm-Message-State: AOJu0Yy9jqsJBi9GySIxO2QRe7ELeAluW56evRE/LxUrImKPEXU/Qnqy
 pIFQ9Md/E1XaGWW8BIHyw7Iu8i53fovgEspl922CVZvbnzZ3i6KfDbqonE3ESrrQmWBJQBMkCT3
 ne1mg5mJy9SRVP9cuaRZHG/nrrS4bQS8b29eo0G5NxNJ/YA/NlA3zhyufUvMhjIDHO3OHd+v6os
 8/dyTBMONn/OThwM5DWvwkINt1BcnBjzs=
X-Gm-Gg: ASbGncuPxVudma5ZQvhkeZ5Tzf80MTIIr+E6DT9I+lXOsJrMvZL1Uo4ChT/QnGEGTyS
 p4/uZVYglQxxU2BP0b6zRaJts21v8qE94+8dKTzSsOMxRiCXy4+8MtBhBm1SXELUsCyBcXA==
X-Received: by 2002:a17:90b:51cb:b0:2fe:84d6:cdf9 with SMTP id
 98e67ed59e1d1-30e7d5ac8abmr1733443a91.26.1747360271805; 
 Thu, 15 May 2025 18:51:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG/LrJ5jodo5W9SzHqpku9u48iaJBEZKU2q1+2L3Cpfe7kCxz37DOweJULl5F/TcGp6vSYwj/9O4DjKoit2rWc=
X-Received: by 2002:a17:90b:51cb:b0:2fe:84d6:cdf9 with SMTP id
 98e67ed59e1d1-30e7d5ac8abmr1733421a91.26.1747360271425; Thu, 15 May 2025
 18:51:11 -0700 (PDT)
MIME-Version: 1.0
References: <20250507184647.15580-1-jonah.palmer@oracle.com>
In-Reply-To: <20250507184647.15580-1-jonah.palmer@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 16 May 2025 09:51:00 +0800
X-Gm-Features: AX0GCFtCF3a7xUutYKwc0OtgH7oQY-ihVu4UwVGBMeAQl7TNaPKca0-acx31TZ0
Message-ID: <CACGkMEuD7n8QVpgBvHSXJv7kN-hn4cpXX9J8UO8GUCzB0Ssqaw@mail.gmail.com>
Subject: Re: [PATCH v4 0/7] Move memory listener register to vhost_vdpa_init
To: Jonah Palmer <jonah.palmer@oracle.com>
Cc: qemu-devel@nongnu.org, eperezma@redhat.com, peterx@redhat.com, 
 mst@redhat.com, lvivier@redhat.com, dtatulea@nvidia.com, leiyang@redhat.com, 
 parav@mellanox.com, sgarzare@redhat.com, si-wei.liu@oracle.com, 
 lingshan.zhu@intel.com, boris.ostrovsky@oracle.com, 
 "Armbruster, Markus" <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, May 8, 2025 at 2:47=E2=80=AFAM Jonah Palmer <jonah.palmer@oracle.co=
m> wrote:
>
> Current memory operations like pinning may take a lot of time at the
> destination.  Currently they are done after the source of the migration i=
s
> stopped, and before the workload is resumed at the destination.  This is =
a
> period where neigher traffic can flow, nor the VM workload can continue
> (downtime).
>
> We can do better as we know the memory layout of the guest RAM at the
> destination from the moment that all devices are initializaed.  So
> moving that operation allows QEMU to communicate the kernel the maps
> while the workload is still running in the source, so Linux can start
> mapping them.
>
> As a small drawback, there is a time in the initialization where QEMU
> cannot respond to QMP etc.  By some testing, this time is about
> 0.2seconds.

Adding Markus to see if this is a real problem or not.

(I remember VFIO has some optimization in the speed of the pinning,
could vDPA do the same?)

Thanks

> This may be further reduced (or increased) depending on the
> vdpa driver and the platform hardware, and it is dominated by the cost
> of memory pinning.
>
> This matches the time that we move out of the called downtime window.
> The downtime is measured as checking the trace timestamp from the moment
> the source suspend the device to the moment the destination starts the
> eight and last virtqueue pair.  For a 39G guest, it goes from ~2.2526
> secs to 2.0949.
>
> Future directions on top of this series may include to move more things a=
head
> of the migration time, like set DRIVER_OK or perform actual iterative mig=
ration
> of virtio-net devices.
>
> Comments are welcome.
>
> This series is a different approach of series [1]. As the title does not
> reflect the changes anymore, please refer to the previous one to know the
> series history.
>
> This series is based on [2], it must be applied after it.
>
> [Jonah Palmer]
> This series was rebased after [3] was pulled in, as [3] was a prerequisit=
e
> fix for this series.
>
> v4:
> ---
> * Add memory listener unregistration to vhost_vdpa_reset_device.
> * Remove memory listener unregistration from vhost_vdpa_reset_status.
>
> v3:
> ---
> * Rebase
>
> v2:
> ---
> * Move the memory listener registration to vhost_vdpa_set_owner function.
> * Move the iova_tree allocation to net_vhost_vdpa_init.
>
> v1 at https://lists.gnu.org/archive/html/qemu-devel/2024-01/msg02136.html=
.
>
> [1] https://patchwork.kernel.org/project/qemu-devel/cover/20231215172830.=
2540987-1-eperezma@redhat.com/
> [2] https://lists.gnu.org/archive/html/qemu-devel/2024-01/msg05910.html
> [3] https://lore.kernel.org/qemu-devel/20250217144936.3589907-1-jonah.pal=
mer@oracle.com/
>
> Jonah - note: I'll be on vacation from May 10-19. Will respond to
>               comments when I return.
>
> Eugenio P=C3=A9rez (7):
>   vdpa: check for iova tree initialized at net_client_start
>   vdpa: reorder vhost_vdpa_set_backend_cap
>   vdpa: set backend capabilities at vhost_vdpa_init
>   vdpa: add listener_registered
>   vdpa: reorder listener assignment
>   vdpa: move iova_tree allocation to net_vhost_vdpa_init
>   vdpa: move memory listener register to vhost_vdpa_init
>
>  hw/virtio/vhost-vdpa.c         | 107 +++++++++++++++++++++------------
>  include/hw/virtio/vhost-vdpa.h |  22 ++++++-
>  net/vhost-vdpa.c               |  34 +----------
>  3 files changed, 93 insertions(+), 70 deletions(-)
>
> --
> 2.43.5
>


