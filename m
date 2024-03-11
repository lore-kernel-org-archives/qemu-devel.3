Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 029D9C54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 15:48:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjhsd-0002ol-1E; Mon, 11 Mar 2024 11:47:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rjhs1-0002es-SD
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 11:47:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rjhry-0000cx-Sf
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 11:47:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710172037;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WjmQZzDFACeoU2oayorDV0oWe9R9owuxVswF22wwuD8=;
 b=ELABB0BdnzQ403xh0OcgN7owg3DRO6QFOy7/UQnZfh5Ky8TDHEbr3cYFmLdDUBBxoLSAmQ
 cB242guo/v9crBCseipbz2DmeQxRUTLQYhmSwEoQo1mRnEmC5bER4FACtSAweCeOYjRAuL
 BloRmSbpb8vyufphnzMLonOBtFLA03U=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-_8MDs-AXNNyDC2gPWICl0Q-1; Mon, 11 Mar 2024 11:47:15 -0400
X-MC-Unique: _8MDs-AXNNyDC2gPWICl0Q-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-412e992444eso19442155e9.3
 for <qemu-devel@nongnu.org>; Mon, 11 Mar 2024 08:47:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710172034; x=1710776834;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WjmQZzDFACeoU2oayorDV0oWe9R9owuxVswF22wwuD8=;
 b=WgEj57Pp6Pt2mirrdirSt47JdV6ufoe4opx6lOY+lNehRuiKvpz2kRznNhm/1ddqsd
 JfalWuMxSg9gXIGTGyrferigbxzjhD4S8P9MV9tXvJhbfZxC/3m6sVGG14m/LsKcoow+
 2PVCsuDxtXDWxAyevoc3RS37OLirK+r8kb0TGB6tB5tg00m5u7+JaSO/KAI8QPKIf+V8
 X3DtqUgAdpTOdG+6p7lwSg8U4CW9W2Za0EvY25U8/MaOmAJVApbqQ4l+uujj96dHoLTY
 XPRrFB2R+0cS+1lToBlzng7O+cDM3Q+baK0Qal58VTqljhU9V5wcSjgZZOfkyY8pfKBF
 KFXA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVbNJltUqdNESipIvQfv85o8dHUBMwjPi54AUGWj2q/v+giJdeg/vW3WlS25g5QuGl2MV5b0HQfQCBFWdPDZI/YRuh0cB0=
X-Gm-Message-State: AOJu0YxicjRJh3AmU34M8Xdty515WAscHbc4F41ZOsa4sL79kSOeejgH
 mJPZFWBuePquNevAu/lFS8qdLswVHsubdu7nQRc+7nIC3mK1FrwS3ufSwxs+PzQgAWC0gx3mXWs
 Dog8Qom4NK0XupOcdHuKmgymC8S/jsBCNlrS1IqAcWd5B6LuwSokP
X-Received: by 2002:a05:600c:5011:b0:413:2bcf:de2c with SMTP id
 n17-20020a05600c501100b004132bcfde2cmr1676881wmr.9.1710172034404; 
 Mon, 11 Mar 2024 08:47:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFjtKXfByZD0Wjo8MO3ViqbZqdmvZNzLButYRAZlxc7X86skDZ2T6f5EBgwbnH1y98ekwc/1w==
X-Received: by 2002:a05:600c:5011:b0:413:2bcf:de2c with SMTP id
 n17-20020a05600c501100b004132bcfde2cmr1676847wmr.9.1710172033837; 
 Mon, 11 Mar 2024 08:47:13 -0700 (PDT)
Received: from redhat.com ([2.52.134.16]) by smtp.gmail.com with ESMTPSA id
 iv17-20020a05600c549100b00413160baa9bsm13204524wmb.10.2024.03.11.08.47.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Mar 2024 08:47:13 -0700 (PDT)
Date: Mon, 11 Mar 2024 11:47:08 -0400
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
Message-ID: <20240311114638-mutt-send-email-mst@kernel.org>
References: <20240304194612.611660-1-jonah.palmer@oracle.com>
 <20240304194612.611660-3-jonah.palmer@oracle.com>
 <20240308115951-mutt-send-email-mst@kernel.org>
 <CAJaqyWcRDjSXbgxMHbdPy_YO4boQthu_4_9zKYX3S5t-G1ju2g@mail.gmail.com>
 <bf6e9625-0fc3-4bbb-9e36-fe6571aca8cb@oracle.com>
 <20240308141907-mutt-send-email-mst@kernel.org>
 <fc09c190-ff37-47a0-96a2-6b364e04d334@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fc09c190-ff37-47a0-96a2-6b364e04d334@oracle.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.029,
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

On Mon, Mar 11, 2024 at 10:53:25AM -0400, Jonah Palmer wrote:
> 
> 
> On 3/8/24 2:19 PM, Michael S. Tsirkin wrote:
> > On Fri, Mar 08, 2024 at 12:45:13PM -0500, Jonah Palmer wrote:
> > > 
> > > 
> > > On 3/8/24 12:36 PM, Eugenio Perez Martin wrote:
> > > > On Fri, Mar 8, 2024 at 6: 01 PM Michael S. Tsirkin <mst@ redhat. com>
> > > > wrote: > > On Mon, Mar 04, 2024 at 02: 46: 06PM -0500, Jonah Palmer
> > > > wrote: > > Prevent ioeventfd from being enabled/disabled when a
> > > > virtio-pci > > device
> > > > ZjQcmQRYFpfptBannerStart
> > > > This Message Is From an External Sender
> > > > This message came from outside your organization.
> > > > Report Suspicious
> > > > <https://us-phishalarm-ewt.proofpoint.com/EWT/v1/ACWV5N9M2RV99hQ!Op20OCZE8kFi__wOXJ_Z0URZ2e_9fdaYz2tejZvKqiDgOm6ijq_imUptzxsrej_4riwCrBGeKmQ9VKXqnbV1ujbfiOV5-E2e1s3pKqpqUL-gRIuMQLDLygRD1hoX3Q$>
> > > > ZjQcmQRYFpfptBannerEnd
> > > > 
> > > > On Fri, Mar 8, 2024 at 6:01 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > > 
> > > > > On Mon, Mar 04, 2024 at 02:46:06PM -0500, Jonah Palmer wrote:
> > > > > > Prevent ioeventfd from being enabled/disabled when a virtio-pci
> > > > > > device has negotiated the VIRTIO_F_NOTIFICATION_DATA transport
> > > > > > feature.
> > > > > > 
> > > > > > Due to ioeventfd not being able to carry the extra data associated with
> > > > > > this feature, the ioeventfd should be left in a disabled state for
> > > > > > emulated virtio-pci devices using this feature.
> > > > > > 
> > > > > > Reviewed-by: Eugenio Pérez <eperezma@redhat.com>
> > > > > > Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
> > > > > 
> > > > > I thought hard about this. I propose that for now,
> > > > > instead of disabling ioevetfd silently we error out unless
> > > > > user disabled it for us.
> > > > > WDYT?
> > > > > 
> > > > 
> > > > Yes, error is a better plan than silently disabling it. In the
> > > > (unlikely?) case we are able to make notification data work with
> > > > eventfd in the future, it makes the change more evident.
> > > > 
> > > 
> > > Will do in v2. I assume we'll also make this the case for virtio-mmio and
> > > virtio-ccw?
> > 
> > Guess so. Pls note freeze is imminent.
> 
> Got it. Also, would you mind elaborating a bit more on "error out"? E.g. do
> we want to prevent the Qemu from starting at all if a device is attempting
> to use both VIRTIO_F_NOTIFICATION_DATA and ioeventfd? Or do you mean
> something like still keep ioeventfd disabled but also log an error message
> unless it was explicitly disabled by the user?


my preference would be to block device instance from being created.

> > > > > 
> > > > > > ---
> > > > > >   hw/virtio/virtio-pci.c | 6 ++++--
> > > > > >   1 file changed, 4 insertions(+), 2 deletions(-)
> > > > > > 
> > > > > > diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> > > > > > index d12edc567f..287b8f7720 100644
> > > > > > --- a/hw/virtio/virtio-pci.c
> > > > > > +++ b/hw/virtio/virtio-pci.c
> > > > > > @@ -417,13 +417,15 @@ static void virtio_ioport_write(void *opaque, uint32_t addr, uint32_t val)
> > > > > >           }
> > > > > >           break;
> > > > > >       case VIRTIO_PCI_STATUS:
> > > > > > -        if (!(val & VIRTIO_CONFIG_S_DRIVER_OK)) {
> > > > > > +        if (!(val & VIRTIO_CONFIG_S_DRIVER_OK) &&
> > > > > > +            !virtio_vdev_has_feature(vdev, VIRTIO_F_NOTIFICATION_DATA)) {
> > > > > >               virtio_pci_stop_ioeventfd(proxy);
> > > > > >           }
> > > > > > 
> > > > > >           virtio_set_status(vdev, val & 0xFF);
> > > > > > 
> > > > > > -        if (val & VIRTIO_CONFIG_S_DRIVER_OK) {
> > > > > > +        if ((val & VIRTIO_CONFIG_S_DRIVER_OK) &&
> > > > > > +            !virtio_vdev_has_feature(vdev, VIRTIO_F_NOTIFICATION_DATA)) {
> > > > > >               virtio_pci_start_ioeventfd(proxy);
> > > > > >           }
> > > > > > 
> > > > > > --
> > > > > > 2.39.3
> > > > > 
> > > > 
> > 


