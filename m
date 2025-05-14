Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6149AC3ABDD
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 16:17:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFEmG-0000MU-LY; Wed, 14 May 2025 12:16:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1uFEN6-000601-VJ
 for qemu-devel@nongnu.org; Wed, 14 May 2025 11:50:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1uFEN4-0003vr-P0
 for qemu-devel@nongnu.org; Wed, 14 May 2025 11:50:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747237811;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EkTX29+Ajze/blrMWIOR1Q1IBk2VHDB5D5YBIXNBaqc=;
 b=VOyTd+SBwrsboKBkVpL80man/5dBiT8Ix5aLxlqOf+NoSMSlfezDci6LE9ETglGvFmic58
 9l9M3s8zeng9NPwCN/wKjD+2UVXXrQonhxdPkoZuJYLBJHCWoZniKGVE76ghaQQjmd+BXs
 V6qw6z4LYNva8NZ7kKHu0kM24pr1y9g=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516-_-7tSZ4jO3CeC2Iv0DfuEg-1; Wed, 14 May 2025 11:50:10 -0400
X-MC-Unique: _-7tSZ4jO3CeC2Iv0DfuEg-1
X-Mimecast-MFC-AGG-ID: _-7tSZ4jO3CeC2Iv0DfuEg_1747237809
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-30c9b0aa4ccso3655764a91.3
 for <qemu-devel@nongnu.org>; Wed, 14 May 2025 08:50:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747237809; x=1747842609;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EkTX29+Ajze/blrMWIOR1Q1IBk2VHDB5D5YBIXNBaqc=;
 b=grgfZHfMRDfWGDQjOuLPi/DZCl9Lr1dMykwpIy2w5eTj7w5Ud55Tsefv5l1mzK2kZw
 zos3qvO3ZAT+7RUrK+a70AqkwUabraHA86alkKMxiF3biqagTVvd5/1HsH8cWw00u5/I
 n4JVSl5DVhJwevgsR18qtTevizcZnCoXve5wnr0svQJ/q04SEilmpYk8DcxHSnt1yOT6
 h6MPJhEIsiXsU6+BTVfqnU9D+iI/Inj+P4HIYcGhT7f4QfKFzUMY1HE73tuph30pQ7Pk
 LHntoZFU9T3qJh7ivRI4IP6xV0m5kDc5gMFPa22wQlf3lxcPQBhWwvQWrPhUQnEYlbZb
 vvmA==
X-Gm-Message-State: AOJu0Yx3FtFPo+dnZu3N0HHM9mPMnxFTAUb6zErUT88l/B6fivogtnd0
 baa4o98tkQ8mB4K7ZFlX6vZSzuWo0r1WwUROKKbSIjwOWUbg+TDONa/kZZduOP4xQrDeqhjWkH3
 W07eaqzq1lPbwn5ERmeXvwmaraiRm8DORjvzAoX7WCuO8fSltO/miO0AZ380jBOb2R63gqhKYE5
 tINhNwHybMaRLjVJqqAs6Qoi6clvc=
X-Gm-Gg: ASbGncsSkUT/qYCT6JS2WZWTMYDxh2RUlIxgwXeD6Vxej+hBukua3JxNB5LLMEvBzfA
 3jxLjrUnk4xmG/Jv5QufvxerKKKXKTvS1gjC/9Ab/VIDXcNCSM3Pz14XV/K9X6FT3/ZpF
X-Received: by 2002:a17:90b:17cb:b0:2f8:b2c:5ef3 with SMTP id
 98e67ed59e1d1-30e2e5ba291mr7422429a91.14.1747237809502; 
 Wed, 14 May 2025 08:50:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFNZcgZhDBEE31sJa3kO13e6hw1JsdiiM7Nf1kY2GZyedHNkJxnzwYTzBPGhm0H+eunSpGW0AOejcMH4+cJt4E=
X-Received: by 2002:a17:90b:17cb:b0:2f8:b2c:5ef3 with SMTP id
 98e67ed59e1d1-30e2e5ba291mr7422377a91.14.1747237809104; Wed, 14 May 2025
 08:50:09 -0700 (PDT)
MIME-Version: 1.0
References: <20250507184647.15580-1-jonah.palmer@oracle.com>
In-Reply-To: <20250507184647.15580-1-jonah.palmer@oracle.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 14 May 2025 17:49:32 +0200
X-Gm-Features: AX0GCFueevwCAJD03TfYwMTsm-mpafyxV_NwP1-xQ1iCM8lG6E20eMuucQfaZIk
Message-ID: <CAJaqyWcOaGKaCeT1sifCE_sau1Ac2g=F62TkD=arntQ8ka4aDQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/7] Move memory listener register to vhost_vdpa_init
To: Jonah Palmer <jonah.palmer@oracle.com>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, mst@redhat.com, 
 jasowang@redhat.com, lvivier@redhat.com, dtatulea@nvidia.com, 
 leiyang@redhat.com, parav@mellanox.com, sgarzare@redhat.com, 
 si-wei.liu@oracle.com, lingshan.zhu@intel.com, boris.ostrovsky@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eperezma@redhat.com;
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

On Wed, May 7, 2025 at 8:47=E2=80=AFPM Jonah Palmer <jonah.palmer@oracle.co=
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
> 0.2seconds.  This may be further reduced (or increased) depending on the
> vdpa driver and the platform hardware, and it is dominated by the cost
> of memory pinning.
>
> This matches the time that we move out of the called downtime window.
> The downtime is measured as checking the trace timestamp from the moment
> the source suspend the device to the moment the destination starts the
> eight and last virtqueue pair.  For a 39G guest, it goes from ~2.2526
> secs to 2.0949.
>

Hi Jonah,

Could you update this benchmark? I don't think it changed a lot but
just to be as updated as possible.

I think I cannot ack the series as I sent the first revision. Jason or
Si-Wei, could you ack it?

Thanks!

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


