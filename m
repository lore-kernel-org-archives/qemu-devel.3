Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7F0CC2D0CD
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 05:43:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFRNI-0000gR-HF; Thu, 15 May 2025 01:43:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uFRNG-0000Vz-2R
 for qemu-devel@nongnu.org; Thu, 15 May 2025 01:43:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uFRND-0008FL-Mx
 for qemu-devel@nongnu.org; Thu, 15 May 2025 01:43:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747287793;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MuLjh3ZKqZtxECtd+grD9rx8twzA4XW/f/FiRHbaGkc=;
 b=CDvrWTGgecJqN1CbvPIYYgtXzHWOiGF7XtWFHt0ltX7TXl1XuqQIIaGwSQBOURtsrybkot
 p002i+OxY/mHNSYtcT8LHx00ONbym8qClDniBYpSkftQVaQZSo3/mI70K/sZwIpWVY8ZoP
 mKtD0sQvcMAvHckOiGA/bRZsr0RfTkE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-sRijCPn8O1yCnherLiCUqA-1; Thu, 15 May 2025 01:43:11 -0400
X-MC-Unique: sRijCPn8O1yCnherLiCUqA-1
X-Mimecast-MFC-AGG-ID: sRijCPn8O1yCnherLiCUqA_1747287790
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43cf44b66f7so2873975e9.1
 for <qemu-devel@nongnu.org>; Wed, 14 May 2025 22:43:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747287790; x=1747892590;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MuLjh3ZKqZtxECtd+grD9rx8twzA4XW/f/FiRHbaGkc=;
 b=viTI0RlWCkt5JNvhTAJ8T8kNrJ0OOKbXsGZ1gBMxw9KBJDwr9dMpjW32YYJW8a7f/R
 ovIfU24aaeod2ec0NNiBVci4ESiE+brszEHTGlJVh9c6RmBXrKa1/tcrRZ5EUHWpR1bJ
 PBb07R4ITALlHHK+2bZdOWma5ROzpi8oolUgYF8ZHgGNxS32i+Po1gr34eRT7BqgYjc0
 75YpNuSGnmheI9zgCd38/+VAERqRnHpzBIjY6JWsyLXJiMWusmZ8GyEWTEn224hB8V/U
 xHIb5+nzzb6pinQrVgM8z6Xdo5O2AQg2KW5QMtO/MUA10YuerZ/Xv2vVstr5QTNvuO6O
 u58g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWwo4sidLagc9PXDba6qfOftg3biXfofsspk+XXVT/YCcP7zIW3mN0R9WhkZ5sqXTCQDIocErtEDBGA@nongnu.org
X-Gm-Message-State: AOJu0Ywad1pWKW2Pq9MM4zUWfdwZxLxLIWZ7CM4TQaOyIhpxah9V3a2e
 4cDFi9YIh01BUWV3+GBqaLonxKogQR746JXB+CH3C5NdEbPMURgNMagprJFfYDB1casve8DKHQr
 SedkmrNMYi5RW5QaP7PHrA0m/RUv7oUAcKHr8n6nZlICc25x+KxPb
X-Gm-Gg: ASbGncv7PftvH8tsSoNhP2S9MZw5RLpd7WZKvTxpD/EWla66qkO71gM9cXckoPW0mmt
 ww1bETVeUjsKcUUz/H/hpXYVJ0Tp9jRlc/OiBGSCzsayyxZVW4bFmAcH/ACwoJCHRaaGL2QoArF
 pbiHExLyHIEN5yyiCiqTI71Zj7nxwOr13fzExjo61RXPHmVdxfpdmw1lGAveOKiOJpuT1PvLdLG
 JQ+HCWCMbSy++Ejmws1/fl7ozh0myHflOhqeaEPyaxKfLwHfHqY3U91q4ubsocsqi4tnd5MrRgQ
 jEPZ6Q==
X-Received: by 2002:a05:600c:609a:b0:43c:e70d:4504 with SMTP id
 5b1f17b1804b1-442f210f700mr52548705e9.19.1747287789937; 
 Wed, 14 May 2025 22:43:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHb5FagGwEBAHbb1TY1wbPUo6NHbqFQg8oj0WI9a5rkuBY7/h9uaFWncD3ojqpJqpslqkEB1g==
X-Received: by 2002:a05:600c:609a:b0:43c:e70d:4504 with SMTP id
 5b1f17b1804b1-442f210f700mr52548545e9.19.1747287789580; 
 Wed, 14 May 2025 22:43:09 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442f397b680sm56572695e9.40.2025.05.14.22.43.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 May 2025 22:43:08 -0700 (PDT)
Date: Thu, 15 May 2025 01:43:06 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Si-Wei Liu <si-wei.liu@oracle.com>
Cc: Eugenio Perez Martin <eperezma@redhat.com>,
 Jonah Palmer <jonah.palmer@oracle.com>, qemu-devel@nongnu.org,
 peterx@redhat.com, jasowang@redhat.com, lvivier@redhat.com,
 dtatulea@nvidia.com, leiyang@redhat.com, parav@mellanox.com,
 sgarzare@redhat.com, lingshan.zhu@intel.com, boris.ostrovsky@oracle.com
Subject: Re: [PATCH v4 0/7] Move memory listener register to vhost_vdpa_init
Message-ID: <20250515014242-mutt-send-email-mst@kernel.org>
References: <20250507184647.15580-1-jonah.palmer@oracle.com>
 <CAJaqyWcOaGKaCeT1sifCE_sau1Ac2g=F62TkD=arntQ8ka4aDQ@mail.gmail.com>
 <8c465eb3-2db9-47ab-b949-e19a176a5fde@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8c465eb3-2db9-47ab-b949-e19a176a5fde@oracle.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
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

On Wed, May 14, 2025 at 05:17:15PM -0700, Si-Wei Liu wrote:
> Hi Eugenio,
> 
> On 5/14/2025 8:49 AM, Eugenio Perez Martin wrote:
> > On Wed, May 7, 2025 at 8:47 PM Jonah Palmer <jonah.palmer@oracle.com> wrote:
> > > Current memory operations like pinning may take a lot of time at the
> > > destination.  Currently they are done after the source of the migration is
> > > stopped, and before the workload is resumed at the destination.  This is a
> > > period where neigher traffic can flow, nor the VM workload can continue
> > > (downtime).
> > > 
> > > We can do better as we know the memory layout of the guest RAM at the
> > > destination from the moment that all devices are initializaed.  So
> > > moving that operation allows QEMU to communicate the kernel the maps
> > > while the workload is still running in the source, so Linux can start
> > > mapping them.
> > > 
> > > As a small drawback, there is a time in the initialization where QEMU
> > > cannot respond to QMP etc.  By some testing, this time is about
> > > 0.2seconds.  This may be further reduced (or increased) depending on the
> > > vdpa driver and the platform hardware, and it is dominated by the cost
> > > of memory pinning.
> > > 
> > > This matches the time that we move out of the called downtime window.
> > > The downtime is measured as checking the trace timestamp from the moment
> > > the source suspend the device to the moment the destination starts the
> > > eight and last virtqueue pair.  For a 39G guest, it goes from ~2.2526
> > > secs to 2.0949.
> > > 
> > Hi Jonah,
> > 
> > Could you update this benchmark? I don't think it changed a lot but
> > just to be as updated as possible.
> Jonah is off this week and will be back until next Tuesday, but I recall he
> indeed did some downtime test with VM with 128GB memory before taking off,
> which shows obvious improvement from around 10 seconds to 5.8 seconds after
> applying this series. Since this is related to update on the cover letter,
> would it be okay for you and Jason to ack now and then proceed to Michael
> for upcoming merge?
> 
> > 
> > I think I cannot ack the series as I sent the first revision. Jason or
> > Si-Wei, could you ack it?
> Sure, I just give my R-b, this series look good to me. Hopefully Jason can
> ack on his own.
> 
> Thanks!
> -Siwei

I just sent a pull, next one in a week or two, so - no rush.


> > 
> > Thanks!
> > 
> > > Future directions on top of this series may include to move more things ahead
> > > of the migration time, like set DRIVER_OK or perform actual iterative migration
> > > of virtio-net devices.
> > > 
> > > Comments are welcome.
> > > 
> > > This series is a different approach of series [1]. As the title does not
> > > reflect the changes anymore, please refer to the previous one to know the
> > > series history.
> > > 
> > > This series is based on [2], it must be applied after it.
> > > 
> > > [Jonah Palmer]
> > > This series was rebased after [3] was pulled in, as [3] was a prerequisite
> > > fix for this series.
> > > 
> > > v4:
> > > ---
> > > * Add memory listener unregistration to vhost_vdpa_reset_device.
> > > * Remove memory listener unregistration from vhost_vdpa_reset_status.
> > > 
> > > v3:
> > > ---
> > > * Rebase
> > > 
> > > v2:
> > > ---
> > > * Move the memory listener registration to vhost_vdpa_set_owner function.
> > > * Move the iova_tree allocation to net_vhost_vdpa_init.
> > > 
> > > v1 at https://lists.gnu.org/archive/html/qemu-devel/2024-01/msg02136.html.
> > > 
> > > [1] https://patchwork.kernel.org/project/qemu-devel/cover/20231215172830.2540987-1-eperezma@redhat.com/
> > > [2] https://lists.gnu.org/archive/html/qemu-devel/2024-01/msg05910.html
> > > [3] https://lore.kernel.org/qemu-devel/20250217144936.3589907-1-jonah.palmer@oracle.com/
> > > 
> > > Jonah - note: I'll be on vacation from May 10-19. Will respond to
> > >                comments when I return.
> > > 
> > > Eugenio Pérez (7):
> > >    vdpa: check for iova tree initialized at net_client_start
> > >    vdpa: reorder vhost_vdpa_set_backend_cap
> > >    vdpa: set backend capabilities at vhost_vdpa_init
> > >    vdpa: add listener_registered
> > >    vdpa: reorder listener assignment
> > >    vdpa: move iova_tree allocation to net_vhost_vdpa_init
> > >    vdpa: move memory listener register to vhost_vdpa_init
> > > 
> > >   hw/virtio/vhost-vdpa.c         | 107 +++++++++++++++++++++------------
> > >   include/hw/virtio/vhost-vdpa.h |  22 ++++++-
> > >   net/vhost-vdpa.c               |  34 +----------
> > >   3 files changed, 93 insertions(+), 70 deletions(-)
> > > 
> > > --
> > > 2.43.5
> > > 


