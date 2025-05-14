Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74BD6C3ABC3
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 01:43:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uF19P-0002Uk-Gr; Tue, 13 May 2025 21:43:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leiyang@redhat.com>)
 id 1uF19N-0002Ua-Ei
 for qemu-devel@nongnu.org; Tue, 13 May 2025 21:43:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leiyang@redhat.com>)
 id 1uF19F-0003xy-0h
 for qemu-devel@nongnu.org; Tue, 13 May 2025 21:43:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747186982;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nmjdMTVETLyOTCibj6FURra4JiSgrtYc3AGrj83wkrI=;
 b=XwxhWeGLFVDo1pah67AjOm6RAd0WbDeTxTF4iCFuOfrgw9YXpn3IJ6G5lb5uLW/H/5a42A
 4ErUve0WBmHJUWUTgmyEbhKCmTOnXB3Hkaq7mrDVgJmeCWyVydntBBY5XophlLZX5MQp8P
 sNiP4e6qLxTxviHp/wRWFYBTFm97+Fo=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-404-nS6Dqrq8OqCe2Dr_1L-DxA-1; Tue, 13 May 2025 21:43:01 -0400
X-MC-Unique: nS6Dqrq8OqCe2Dr_1L-DxA-1
X-Mimecast-MFC-AGG-ID: nS6Dqrq8OqCe2Dr_1L-DxA_1747186980
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-5fc1796ff88so5729979a12.2
 for <qemu-devel@nongnu.org>; Tue, 13 May 2025 18:43:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747186980; x=1747791780;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nmjdMTVETLyOTCibj6FURra4JiSgrtYc3AGrj83wkrI=;
 b=wiS2WDyg7DhTLYsLU32owXfUBaTjg1CQqYAAIL+8Lx9vsr5QIhRrQYLZ2a06bZwWXT
 55y0GyR3btxD7tlXIWL1TBbDpaYSB8YBOHhkzenUUSkyF/4KfU862+Cw0etZWO6y6dKe
 ilYSygp7ALZHqhMYDtJNFv4t2kZi8+pQlnzQ2Cq0YW3Qvpp/NoKn8EzxKl/LVsbgoMpS
 +6gJ+j5iKNUCYRse6x0Mv6h6WpZ+rrMG3RaePvmGO2L+HangcuSPVXKQbZ6t6JiaT+2y
 fMN5zvHYBfwRZU3cyzW9Zbh6ybSC0yQ0zjmJlYs9yLYpTSWLuH5VAABiBe8nAbAVm4Pz
 Yn8A==
X-Gm-Message-State: AOJu0YzyhdBcEIlCdhvYXfoGz3YcmigMYKU/eH/TcCCNbFsu0+RQixfC
 iKX434kyA05apTGu2+4NX0drrl5gVzoA2kwmc31TVn5XyWvLJtkQ59SMI4nokZJ3wVnWzI8SWqj
 UEFT57IAHHXc1DS0XzKJ9NusIZoge7FDuy6n9uoaEeekV2EZFhwPeo3uv2gA2Z/yGv63AnfHNgN
 KWs58uqRZ7oV7W1495qjc6ph8Gp9U=
X-Gm-Gg: ASbGncv2ejzfTIU3pDZ6R3rcU4UXb2ZY9TaG9q45x2WcrCgElI31fCmzr4GdNSiyKpD
 cHvGZqHHz5T+63C+jTVEKxHTgKyx9jy3SDO7OkdE6cBUTX3hnnDJ4noMcUUsAZGQmBnbARQ==
X-Received: by 2002:a05:6402:26d1:b0:5ec:cbf8:ab28 with SMTP id
 4fb4d7f45d1cf-5ff988d4535mr1070044a12.22.1747186980139; 
 Tue, 13 May 2025 18:43:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH/B3P8bmw4vFWMvCZFqZ9/srw3K+bt7DXu3/9AWCmGsd5Q+QR2bjToLvimOn0k1ZQZ+wWCz00gMngb38Dw8Rs=
X-Received: by 2002:a05:6402:26d1:b0:5ec:cbf8:ab28 with SMTP id
 4fb4d7f45d1cf-5ff988d4535mr1070025a12.22.1747186979797; Tue, 13 May 2025
 18:42:59 -0700 (PDT)
MIME-Version: 1.0
References: <20250507184647.15580-1-jonah.palmer@oracle.com>
In-Reply-To: <20250507184647.15580-1-jonah.palmer@oracle.com>
From: Lei Yang <leiyang@redhat.com>
Date: Wed, 14 May 2025 09:42:22 +0800
X-Gm-Features: AX0GCFtDj_FmJIn2Vxf2J6Il3Ydvj1YYLqAOSdk2QCtV4qFvkPE3UnZYe-VHTOo
Message-ID: <CAPpAL=zXoYhqp1J-OmexXA1ftGfCWetCR3J18p_ZWnj7p-M37w@mail.gmail.com>
Subject: Re: [PATCH v4 0/7] Move memory listener register to vhost_vdpa_init
To: Jonah Palmer <jonah.palmer@oracle.com>
Cc: qemu-devel@nongnu.org, eperezma@redhat.com, peterx@redhat.com, 
 mst@redhat.com, jasowang@redhat.com, lvivier@redhat.com, dtatulea@nvidia.com, 
 parav@mellanox.com, sgarzare@redhat.com, si-wei.liu@oracle.com, 
 lingshan.zhu@intel.com, boris.ostrovsky@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=leiyang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.549,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Tested pass with vhost_vdpa device's regression tests.

Tested-by: Lei Yang <leiyang@redhat.com>

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


