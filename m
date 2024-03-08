Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E7E4C5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 19:20:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rifkq-0007NO-0j; Fri, 08 Mar 2024 14:19:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rifkp-0007Mn-0s
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 14:19:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rifkm-0008AW-3T
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 14:19:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709925574;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ENLq0lAriYS+/yBGKq8tFVwidQtrEgyQ9rmcXEyDDsc=;
 b=ZwSf70SaEK2RoAtDLgSNEJI3qJB2DnUGpIB3zoVkxv59Jsonrylv8O7krF4DtLMmPv6Yxn
 4aamACiXZ8bEAb0Rrkv/mQE+VtHv2GWnjC0B/XNIlz6W7KSGWPoWNpfy64yM06ouPiO+7E
 9vWH0cVOBuVniVSssFHVG3AP0CqFd40=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-498-CWev980dMXWT4p8HOB6pYQ-1; Fri, 08 Mar 2024 14:19:32 -0500
X-MC-Unique: CWev980dMXWT4p8HOB6pYQ-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-412ae5704f7so15090495e9.1
 for <qemu-devel@nongnu.org>; Fri, 08 Mar 2024 11:19:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709925571; x=1710530371;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ENLq0lAriYS+/yBGKq8tFVwidQtrEgyQ9rmcXEyDDsc=;
 b=ApR2w/I8YYlujSYAbTEUWJ0+aDx0rnwka2MwN9NauA7B9WxpTYMBf+M5MmwPh6qcNq
 dYoPXKyWysMb83FH0ts7m30T6b9s3GJuqmUf/WwxY+ncqqPBYZwph4Tkh2T3QQEse7/a
 kOB7UuHKlIF1pOGVQy5kuML/e220WiuAvPuWg7bqEVrX5rLgkXUf7dSXWWjSVPz9RHX/
 gB1tNsHCDxyFvS996FBJHQWL24vVYTUXN3hbzCEP2/qgxGedyQqw/ClNN8N1cNdFy4kR
 RcKZuSyHrxfjy9+b7cjqN1uSpn0hRx6HAYFVnPbu4rYb3Bz9skmnVjwD1EsQ4Ymq3Il7
 p/SA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU/WpCoo0phZCz5AAE+WItMbF8JZVf0lCtrVx6E++vZeMa25Tk3xVhjexva1qcNtaTsKPxLyDulFMx8YZwMpDMFpNemvBY=
X-Gm-Message-State: AOJu0YyFyN9wvp9FnBeCXbh9pdsFA7oeEMGgVrheoAdgjKwjJ716Cv3B
 zEtuZ0Y9fVzQJqByv1A5JueyjtPTGY2aESwllxQarW7a0iLj2zzdDgaLdVr3O80CWtO61m8wzMW
 ZbfhyL7iVbslYdQPb4Uv/DidedbTfDVgamSat49E6eAQzWoCpCuT5
X-Received: by 2002:a05:600c:1c9f:b0:412:fbc0:506b with SMTP id
 k31-20020a05600c1c9f00b00412fbc0506bmr130627wms.32.1709925571556; 
 Fri, 08 Mar 2024 11:19:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG5p+6M8boh6PzuCEFRByiS7kWJB6JIGmQwlV1+hHB5AXDS8qX6MwUlZvJwcU1LR5ZED0Y80g==
X-Received: by 2002:a05:600c:1c9f:b0:412:fbc0:506b with SMTP id
 k31-20020a05600c1c9f00b00412fbc0506bmr130608wms.32.1709925570980; 
 Fri, 08 Mar 2024 11:19:30 -0800 (PST)
Received: from redhat.com ([2a06:c701:73cd:f300:bc74:daca:b316:492a])
 by smtp.gmail.com with ESMTPSA id
 j27-20020a05600c1c1b00b00412f83e0c11sm6739431wms.22.2024.03.08.11.19.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Mar 2024 11:19:30 -0800 (PST)
Date: Fri, 8 Mar 2024 14:19:27 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jonah Palmer <jonah.palmer@oracle.com>
Cc: Eugenio Perez Martin <eperezma@redhat.com>, qemu-devel@nongnu.org,
 jasowang@redhat.com, si-wei.liu@oracle.com,
 boris.ostrovsky@oracle.com, raphael@enfabrica.net, kwolf@redhat.com,
 hreitz@redhat.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, thuth@redhat.com,
 richard.henderson@linaro.org, david@redhat.com, iii@linux.ibm.com,
 cohuck@redhat.com, pbonzini@redhat.com, fam@euphon.net,
 stefanha@redhat.com, qemu-block@nongnu.org, qemu-s390x@nongnu.org,
 virtio-fs@lists.linux.dev
Subject: Re: [PATCH v1 2/8] virtio-pci: Lock ioeventfd state with
 VIRTIO_F_NOTIFICATION_DATA
Message-ID: <20240308141907-mutt-send-email-mst@kernel.org>
References: <20240304194612.611660-1-jonah.palmer@oracle.com>
 <20240304194612.611660-3-jonah.palmer@oracle.com>
 <20240308115951-mutt-send-email-mst@kernel.org>
 <CAJaqyWcRDjSXbgxMHbdPy_YO4boQthu_4_9zKYX3S5t-G1ju2g@mail.gmail.com>
 <bf6e9625-0fc3-4bbb-9e36-fe6571aca8cb@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bf6e9625-0fc3-4bbb-9e36-fe6571aca8cb@oracle.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.572,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Fri, Mar 08, 2024 at 12:45:13PM -0500, Jonah Palmer wrote:
> 
> 
> On 3/8/24 12:36 PM, Eugenio Perez Martin wrote:
> > On Fri, Mar 8, 2024 at 6: 01 PM Michael S. Tsirkin <mst@ redhat. com>
> > wrote: > > On Mon, Mar 04, 2024 at 02: 46: 06PM -0500, Jonah Palmer
> > wrote: > > Prevent ioeventfd from being enabled/disabled when a
> > virtio-pci > > device
> > ZjQcmQRYFpfptBannerStart
> > This Message Is From an External Sender
> > This message came from outside your organization.
> > Report Suspicious
> > <https://us-phishalarm-ewt.proofpoint.com/EWT/v1/ACWV5N9M2RV99hQ!Op20OCZE8kFi__wOXJ_Z0URZ2e_9fdaYz2tejZvKqiDgOm6ijq_imUptzxsrej_4riwCrBGeKmQ9VKXqnbV1ujbfiOV5-E2e1s3pKqpqUL-gRIuMQLDLygRD1hoX3Q$>
> > ZjQcmQRYFpfptBannerEnd
> > 
> > On Fri, Mar 8, 2024 at 6:01 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > 
> > > On Mon, Mar 04, 2024 at 02:46:06PM -0500, Jonah Palmer wrote:
> > > > Prevent ioeventfd from being enabled/disabled when a virtio-pci
> > > > device has negotiated the VIRTIO_F_NOTIFICATION_DATA transport
> > > > feature.
> > > >
> > > > Due to ioeventfd not being able to carry the extra data associated with
> > > > this feature, the ioeventfd should be left in a disabled state for
> > > > emulated virtio-pci devices using this feature.
> > > >
> > > > Reviewed-by: Eugenio Pérez <eperezma@redhat.com>
> > > > Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
> > > 
> > > I thought hard about this. I propose that for now,
> > > instead of disabling ioevetfd silently we error out unless
> > > user disabled it for us.
> > > WDYT?
> > > 
> > 
> > Yes, error is a better plan than silently disabling it. In the
> > (unlikely?) case we are able to make notification data work with
> > eventfd in the future, it makes the change more evident.
> > 
> 
> Will do in v2. I assume we'll also make this the case for virtio-mmio and
> virtio-ccw?

Guess so. Pls note freeze is imminent.
> > > 
> > > > ---
> > > >  hw/virtio/virtio-pci.c | 6 ++++--
> > > >  1 file changed, 4 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> > > > index d12edc567f..287b8f7720 100644
> > > > --- a/hw/virtio/virtio-pci.c
> > > > +++ b/hw/virtio/virtio-pci.c
> > > > @@ -417,13 +417,15 @@ static void virtio_ioport_write(void *opaque, uint32_t addr, uint32_t val)
> > > >          }
> > > >          break;
> > > >      case VIRTIO_PCI_STATUS:
> > > > -        if (!(val & VIRTIO_CONFIG_S_DRIVER_OK)) {
> > > > +        if (!(val & VIRTIO_CONFIG_S_DRIVER_OK) &&
> > > > +            !virtio_vdev_has_feature(vdev, VIRTIO_F_NOTIFICATION_DATA)) {
> > > >              virtio_pci_stop_ioeventfd(proxy);
> > > >          }
> > > >
> > > >          virtio_set_status(vdev, val & 0xFF);
> > > >
> > > > -        if (val & VIRTIO_CONFIG_S_DRIVER_OK) {
> > > > +        if ((val & VIRTIO_CONFIG_S_DRIVER_OK) &&
> > > > +            !virtio_vdev_has_feature(vdev, VIRTIO_F_NOTIFICATION_DATA)) {
> > > >              virtio_pci_start_ioeventfd(proxy);
> > > >          }
> > > >
> > > > --
> > > > 2.39.3
> > > 
> > 


