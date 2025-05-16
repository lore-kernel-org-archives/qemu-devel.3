Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15163C3ABD8
	for <qemu-devel@archiver.kernel.org>; Fri, 16 May 2025 10:46:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFsZl-0000UH-1B; Fri, 16 May 2025 06:46:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uFsZN-0000O3-DP
 for qemu-devel@nongnu.org; Fri, 16 May 2025 06:45:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uFsZK-0002pB-D1
 for qemu-devel@nongnu.org; Fri, 16 May 2025 06:45:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747392332;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xq+epTgQ/cpAMspdFHqGG7CMng9XwQ/RW9IVTSa36Ic=;
 b=GKDKgnKzGpaotHuD6YG3smphJydzX5b7jA6n/+Vr3XLZlBZEhDeHicw5wuKi4yw+3PrfXn
 8uUxtO3x34QKnDIm97wQ2xuDYsJnShYkG4c4LiTVf1safF7W87ReO/T29Nii/SIvJD6bW2
 B2Hg2du/Le4UX2zOrgR2RJVQRB6saJ4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-K2jN5GfBPZ-bOQkKkUz96A-1; Fri, 16 May 2025 06:45:31 -0400
X-MC-Unique: K2jN5GfBPZ-bOQkKkUz96A-1
X-Mimecast-MFC-AGG-ID: K2jN5GfBPZ-bOQkKkUz96A_1747392330
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3a34f19c977so959623f8f.0
 for <qemu-devel@nongnu.org>; Fri, 16 May 2025 03:45:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747392330; x=1747997130;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xq+epTgQ/cpAMspdFHqGG7CMng9XwQ/RW9IVTSa36Ic=;
 b=QglEhttdIxmvn/eVmpaXHp/afMuJosol0oME6L71aWt+6Mi+2xM3pndvYoxYnHNJ4H
 s7iY+mwihyGje7+SBfeMVk1aQ5L+gwQ3Gi9ha2VXqCPxkB4b/5igEbzs0BIbKhFntMRn
 fo2tlIvWi0yn2ddc2Ksiyd/dQmJ5vnRKspS7T26CIPLesbZJd14yAeSbY5THkVOSrLxS
 k5hIWeyvdyV1QwVy5DIfCC/QXsH5rMpqt//VdeynSM/F9VzFTsQVimMSRXe/jYbwsjjS
 mh0MGTMOS+05wI9G6VXVaHak6wexK84dE3G6GIgV+X7DVOOixlJvCHykO7jCoQ6Dn6en
 Xwug==
X-Forwarded-Encrypted: i=1;
 AJvYcCUaJaVF87yYVuBUg0vAgEdc8S21dNErOo0njnfP35o+/wdNtw+Li3az+1B+MLoeJsh3PdOit+yB8hYP@nongnu.org
X-Gm-Message-State: AOJu0YyHWnonnGb17T3/6Vxx9R+jHkvSVl8k3nP3E9PrYkT2SF1VB6BN
 q/Z34L8qbxsZlYclm/rp1ZrgDf1/Fq9q64TYiFYy0E9wFsCJgeh6oshjzz2MlblOdEiy9Zz9vRO
 fb3aOi5+bxd4dUPVvCMBg0uUKlcEYe1L8gaB/lHOLX3k7MtuH5iXGjy36
X-Gm-Gg: ASbGncs2wqIti87CXRkAZFfraBVKudo2R4hsx1Zv+2fhjZxFbHSgTRr66ccLAAgF1BP
 6AlBxcm2XZY35Wv53DpygxvckI5nhOyGW5/gg+T6EOrupqVYyvxSW3FREZN5YAkHH3riJO5grt5
 biosZsa/bPLmOpek4uicB4OXupdc0zAe+Q6jNPQ0XjJ5o6ufc/CcY1mEQQQMNALrFBQDth7+JTY
 6ZwSw9cxeWrqZwnYrCdTjKBOvclN0jFx9bD+xM5tKVL0K2Q0NK/9Ha3WIX2cI12s6AvlcDtWO9k
 iM+odw==
X-Received: by 2002:a5d:598b:0:b0:3a0:7c91:4aaf with SMTP id
 ffacd0b85a97d-3a351210062mr6913365f8f.19.1747392329872; 
 Fri, 16 May 2025 03:45:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFQZzeanOQxq64bMmeG/5VNhA4QbdmU6xDO+6nZltEaG5ilZXHOp7S//Xk3k6kA63KhAGaKMQ==
X-Received: by 2002:a5d:598b:0:b0:3a0:7c91:4aaf with SMTP id
 ffacd0b85a97d-3a351210062mr6913330f8f.19.1747392329473; 
 Fri, 16 May 2025 03:45:29 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a35ca5a8cfsm2499672f8f.37.2025.05.16.03.45.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 May 2025 03:45:28 -0700 (PDT)
Date: Fri, 16 May 2025 06:45:25 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Si-Wei Liu <si-wei.liu@oracle.com>
Cc: Eugenio Perez Martin <eperezma@redhat.com>,
 Jonah Palmer <jonah.palmer@oracle.com>, qemu-devel@nongnu.org,
 peterx@redhat.com, jasowang@redhat.com, lvivier@redhat.com,
 dtatulea@nvidia.com, leiyang@redhat.com, parav@mellanox.com,
 sgarzare@redhat.com, lingshan.zhu@intel.com, boris.ostrovsky@oracle.com
Subject: Re: [PATCH v4 0/7] Move memory listener register to vhost_vdpa_init
Message-ID: <20250516064451-mutt-send-email-mst@kernel.org>
References: <20250507184647.15580-1-jonah.palmer@oracle.com>
 <CAJaqyWcOaGKaCeT1sifCE_sau1Ac2g=F62TkD=arntQ8ka4aDQ@mail.gmail.com>
 <8c465eb3-2db9-47ab-b949-e19a176a5fde@oracle.com>
 <20250515014242-mutt-send-email-mst@kernel.org>
 <16aee564-c2a5-418d-a865-935519c870fa@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <16aee564-c2a5-418d-a865-935519c870fa@oracle.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
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

On Thu, May 15, 2025 at 10:41:45AM -0700, Si-Wei Liu wrote:
> 
> 
> On 5/14/2025 10:43 PM, Michael S. Tsirkin wrote:
> > On Wed, May 14, 2025 at 05:17:15PM -0700, Si-Wei Liu wrote:
> > > Hi Eugenio,
> > > 
> > > On 5/14/2025 8:49 AM, Eugenio Perez Martin wrote:
> > > > On Wed, May 7, 2025 at 8:47 PM Jonah Palmer <jonah.palmer@oracle.com> wrote:
> > > > > Current memory operations like pinning may take a lot of time at the
> > > > > destination.  Currently they are done after the source of the migration is
> > > > > stopped, and before the workload is resumed at the destination.  This is a
> > > > > period where neigher traffic can flow, nor the VM workload can continue
> > > > > (downtime).
> > > > > 
> > > > > We can do better as we know the memory layout of the guest RAM at the
> > > > > destination from the moment that all devices are initializaed.  So
> > > > > moving that operation allows QEMU to communicate the kernel the maps
> > > > > while the workload is still running in the source, so Linux can start
> > > > > mapping them.
> > > > > 
> > > > > As a small drawback, there is a time in the initialization where QEMU
> > > > > cannot respond to QMP etc.  By some testing, this time is about
> > > > > 0.2seconds.  This may be further reduced (or increased) depending on the
> > > > > vdpa driver and the platform hardware, and it is dominated by the cost
> > > > > of memory pinning.
> > > > > 
> > > > > This matches the time that we move out of the called downtime window.
> > > > > The downtime is measured as checking the trace timestamp from the moment
> > > > > the source suspend the device to the moment the destination starts the
> > > > > eight and last virtqueue pair.  For a 39G guest, it goes from ~2.2526
> > > > > secs to 2.0949.
> > > > > 
> > > > Hi Jonah,
> > > > 
> > > > Could you update this benchmark? I don't think it changed a lot but
> > > > just to be as updated as possible.
> > > Jonah is off this week and will be back until next Tuesday, but I recall he
> > > indeed did some downtime test with VM with 128GB memory before taking off,
> > > which shows obvious improvement from around 10 seconds to 5.8 seconds after
> > > applying this series. Since this is related to update on the cover letter,
> > > would it be okay for you and Jason to ack now and then proceed to Michael
> > > for upcoming merge?
> > > 
> > > > I think I cannot ack the series as I sent the first revision. Jason or
> > > > Si-Wei, could you ack it?
> > > Sure, I just give my R-b, this series look good to me. Hopefully Jason can
> > > ack on his own.
> > > 
> > > Thanks!
> > > -Siwei
> > I just sent a pull, next one in a week or two, so - no rush.
> All right, should be good to wait. In any case you have to repost a v2 PULL,
> hope this series can be piggy-back'ed as we did extensive tests about it.
> ;-)
> 
> -Siwei

You mean "in case"?

> > 
> > 
> > > > Thanks!
> > > > 
> > > > > Future directions on top of this series may include to move more things ahead
> > > > > of the migration time, like set DRIVER_OK or perform actual iterative migration
> > > > > of virtio-net devices.
> > > > > 
> > > > > Comments are welcome.
> > > > > 
> > > > > This series is a different approach of series [1]. As the title does not
> > > > > reflect the changes anymore, please refer to the previous one to know the
> > > > > series history.
> > > > > 
> > > > > This series is based on [2], it must be applied after it.
> > > > > 
> > > > > [Jonah Palmer]
> > > > > This series was rebased after [3] was pulled in, as [3] was a prerequisite
> > > > > fix for this series.
> > > > > 
> > > > > v4:
> > > > > ---
> > > > > * Add memory listener unregistration to vhost_vdpa_reset_device.
> > > > > * Remove memory listener unregistration from vhost_vdpa_reset_status.
> > > > > 
> > > > > v3:
> > > > > ---
> > > > > * Rebase
> > > > > 
> > > > > v2:
> > > > > ---
> > > > > * Move the memory listener registration to vhost_vdpa_set_owner function.
> > > > > * Move the iova_tree allocation to net_vhost_vdpa_init.
> > > > > 
> > > > > v1 at https://lists.gnu.org/archive/html/qemu-devel/2024-01/msg02136.html.
> > > > > 
> > > > > [1] https://patchwork.kernel.org/project/qemu-devel/cover/20231215172830.2540987-1-eperezma@redhat.com/
> > > > > [2] https://lists.gnu.org/archive/html/qemu-devel/2024-01/msg05910.html
> > > > > [3] https://lore.kernel.org/qemu-devel/20250217144936.3589907-1-jonah.palmer@oracle.com/
> > > > > 
> > > > > Jonah - note: I'll be on vacation from May 10-19. Will respond to
> > > > >                 comments when I return.
> > > > > 
> > > > > Eugenio Pérez (7):
> > > > >     vdpa: check for iova tree initialized at net_client_start
> > > > >     vdpa: reorder vhost_vdpa_set_backend_cap
> > > > >     vdpa: set backend capabilities at vhost_vdpa_init
> > > > >     vdpa: add listener_registered
> > > > >     vdpa: reorder listener assignment
> > > > >     vdpa: move iova_tree allocation to net_vhost_vdpa_init
> > > > >     vdpa: move memory listener register to vhost_vdpa_init
> > > > > 
> > > > >    hw/virtio/vhost-vdpa.c         | 107 +++++++++++++++++++++------------
> > > > >    include/hw/virtio/vhost-vdpa.h |  22 ++++++-
> > > > >    net/vhost-vdpa.c               |  34 +----------
> > > > >    3 files changed, 93 insertions(+), 70 deletions(-)
> > > > > 
> > > > > --
> > > > > 2.43.5
> > > > > 


