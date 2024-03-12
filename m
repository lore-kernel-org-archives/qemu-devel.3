Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8FEDC54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 14:59:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk3ac-0001Aq-N1; Tue, 12 Mar 2024 10:58:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rk3aQ-00017r-Lk
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 10:58:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rk3aI-0002we-Ey
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 10:58:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710255508;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i0gbQwhqZ9wZ5egl+qhYP/z049ASJoJ8DUDeDqmDK78=;
 b=DqZpunJ5A8R5St/LwGMskSRhBwxHaK1Bn73+hb/xgLCG0f15s3zmgt9kfk2d26ip5idiBC
 ZWjzskcKYjZHF1jbciWF5e7hg0MhtMyWXDp4CqrW6y9XUyYFkZ2M5HtHRlETJYYOb2hAbg
 ICJQ5voa2IXqph2c0mR+bJbVD8BSnk4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-329-KJSZ-O6dNUWihPmx1xR_Jw-1; Tue, 12 Mar 2024 10:58:27 -0400
X-MC-Unique: KJSZ-O6dNUWihPmx1xR_Jw-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-33e7a004058so2548009f8f.2
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 07:58:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710255506; x=1710860306;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=i0gbQwhqZ9wZ5egl+qhYP/z049ASJoJ8DUDeDqmDK78=;
 b=VaxeRs9JUj5ULgSX0GobnF4yUsNNEe0qPMjnBEIftpjgY2lvtEbOF5wjziJ+I8A6kT
 WYOX0rdQRga/SvpMlGXAdapb7mFn5khC3V57FlrkBlcluOJEfnIAhMEL+3FknLEdzj8C
 DIXq1qyKMoG5DP4tSzRF0q2dubO2fDVEBbY2ZrZPblxhfTMs79uaCNMY19qSRKiaNxKn
 4gUUmWcEP8G+3o4qmPuWRvZoI6yv4xZUQqSualNZKxyYZXsPDwZogyztPrFOT1Rm+s9Y
 6Ba2sXgqAopDok0d7x3DKi6JyvCoEWUYFAXvbOODOrazEHOI28iJpRGw+MbF5l4FlAkW
 hqeA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXVY8vXjYwUg57pUguR222TBySsdHmQGaMlD0p9otEuA+sMU3f/wgS7uTPHsD8dO1FKi285xxlMy2zJCokxk8ZoO69ZnEo=
X-Gm-Message-State: AOJu0Ywi0eontTpEMpHKHpyfRIpOzPvoHI3+XyK8us8ibHiwISdcweGi
 0eMlRsS+EjQl2PdqT98PfY7FA0XcyKxSAItLzp8gNE+XMIUZugn8PHOIb1FmNHUJ89uRjio/8f7
 XjsBggz6fJAYDATKw5wn5z/bH+PCL1Iiv5helPU10as0Xdw1frtRt
X-Received: by 2002:a05:600c:1d83:b0:413:25cc:296b with SMTP id
 p3-20020a05600c1d8300b0041325cc296bmr6721420wms.7.1710255505847; 
 Tue, 12 Mar 2024 07:58:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEnfJbNrmWMPAz1s26dAbwYRQEVFi+gBaefk5vjVkNMnfm/To3zr21TrDUjve7CpJdVkakKJw==
X-Received: by 2002:a05:600c:1d83:b0:413:25cc:296b with SMTP id
 p3-20020a05600c1d8300b0041325cc296bmr6721397wms.7.1710255505359; 
 Tue, 12 Mar 2024 07:58:25 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f0:532c:5ae4:fce6:76e1:fa1a])
 by smtp.gmail.com with ESMTPSA id
 m7-20020a05600c4f4700b0041315f221c7sm12558503wmq.16.2024.03.12.07.58.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 07:58:24 -0700 (PDT)
Date: Tue, 12 Mar 2024 10:58:18 -0400
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
Message-ID: <20240312105706-mutt-send-email-mst@kernel.org>
References: <20240304194612.611660-1-jonah.palmer@oracle.com>
 <20240304194612.611660-3-jonah.palmer@oracle.com>
 <20240308115951-mutt-send-email-mst@kernel.org>
 <CAJaqyWcRDjSXbgxMHbdPy_YO4boQthu_4_9zKYX3S5t-G1ju2g@mail.gmail.com>
 <bf6e9625-0fc3-4bbb-9e36-fe6571aca8cb@oracle.com>
 <20240308141907-mutt-send-email-mst@kernel.org>
 <fc09c190-ff37-47a0-96a2-6b364e04d334@oracle.com>
 <20240311114638-mutt-send-email-mst@kernel.org>
 <c7a91e57-04eb-4ed1-8bb4-1d1b05894c8a@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c7a91e57-04eb-4ed1-8bb4-1d1b05894c8a@oracle.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Tue, Mar 12, 2024 at 10:33:51AM -0400, Jonah Palmer wrote:
> 
> 
> On 3/11/24 11:47 AM, Michael S. Tsirkin wrote:
> > On Mon, Mar 11, 2024 at 10:53:25AM -0400, Jonah Palmer wrote:
> > > 
> > > 
> > > On 3/8/24 2:19 PM, Michael S. Tsirkin wrote:
> > > > On Fri, Mar 08, 2024 at 12:45:13PM -0500, Jonah Palmer wrote:
> > > > > 
> > > > > 
> > > > > On 3/8/24 12:36 PM, Eugenio Perez Martin wrote:
> > > > > > On Fri, Mar 8, 2024 at 6: 01 PM Michael S. Tsirkin <mst@ redhat. com>
> > > > > > wrote: > > On Mon, Mar 04, 2024 at 02: 46: 06PM -0500, Jonah Palmer
> > > > > > wrote: > > Prevent ioeventfd from being enabled/disabled when a
> > > > > > virtio-pci > > device
> > > > > > ZjQcmQRYFpfptBannerStart
> > > > > > This Message Is From an External Sender
> > > > > > This message came from outside your organization.
> > > > > > Report Suspicious
> > > > > > <https://us-phishalarm-ewt.proofpoint.com/EWT/v1/ACWV5N9M2RV99hQ!Op20OCZE8kFi__wOXJ_Z0URZ2e_9fdaYz2tejZvKqiDgOm6ijq_imUptzxsrej_4riwCrBGeKmQ9VKXqnbV1ujbfiOV5-E2e1s3pKqpqUL-gRIuMQLDLygRD1hoX3Q$>
> > > > > > ZjQcmQRYFpfptBannerEnd
> > > > > > 
> > > > > > On Fri, Mar 8, 2024 at 6:01 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > > > > 
> > > > > > > On Mon, Mar 04, 2024 at 02:46:06PM -0500, Jonah Palmer wrote:
> > > > > > > > Prevent ioeventfd from being enabled/disabled when a virtio-pci
> > > > > > > > device has negotiated the VIRTIO_F_NOTIFICATION_DATA transport
> > > > > > > > feature.
> > > > > > > > 
> > > > > > > > Due to ioeventfd not being able to carry the extra data associated with
> > > > > > > > this feature, the ioeventfd should be left in a disabled state for
> > > > > > > > emulated virtio-pci devices using this feature.
> > > > > > > > 
> > > > > > > > Reviewed-by: Eugenio Pérez <eperezma@redhat.com>
> > > > > > > > Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
> > > > > > > 
> > > > > > > I thought hard about this. I propose that for now,
> > > > > > > instead of disabling ioevetfd silently we error out unless
> > > > > > > user disabled it for us.
> > > > > > > WDYT?
> > > > > > > 
> > > > > > 
> > > > > > Yes, error is a better plan than silently disabling it. In the
> > > > > > (unlikely?) case we are able to make notification data work with
> > > > > > eventfd in the future, it makes the change more evident.
> > > > > > 
> > > > > 
> > > > > Will do in v2. I assume we'll also make this the case for virtio-mmio and
> > > > > virtio-ccw?
> > > > 
> > > > Guess so. Pls note freeze is imminent.
> > > 
> > > Got it. Also, would you mind elaborating a bit more on "error out"? E.g. do
> > > we want to prevent the Qemu from starting at all if a device is attempting
> > > to use both VIRTIO_F_NOTIFICATION_DATA and ioeventfd? Or do you mean
> > > something like still keep ioeventfd disabled but also log an error message
> > > unless it was explicitly disabled by the user?
> > 
> > 
> > my preference would be to block device instance from being created.
> > 
> 
> I could very well be missing something here, but I was looking to see how I
> could block the device from being created (realized) given the functional
> mismatch between negotiating the VIRTIO_F_NOTIFICATION_DATA feature and
> ioeventfd being enabled.
> 
> However, I realized that feature negotiation only happens after the virtio
> device has been realized and it's one of the last steps before the device
> becomes fully operational. In other words, we don't know if the guest
> (driver) also supports this feature until the feature negotiation phase,
> which is after realization.
> 
> So, during realization (e.g. virtio_device_realize), we know if the virtio
> device (1) intends to negotiate the VIRTIO_F_NOTIFICATION_DATA feature and
> (2) has enabled ioeventfd, however, we don't know if the driver will
> actually support this notification data feature.
> 
> Given this, we could block the device from being created if the device is
> *intending* to use the notification data feature along with ioeventfd, but
> this seems premature since we don't know if the feature will actually be
> successfully negotiated.

Yes this is the option I had in mind. Many devices with this feature
do not actually work if they do not get the extra data
so they fail FEATURES_OK, anyway.


> Another option might be check this during/immediately after feature
> negotiation, and then unrealize the device. However, I'm not sure if by this
> point it's "too late" to unrealize it.
> 
> There's also other options like defaulting to using notification data over
> ioeventfd (since a user would need to explicitly enable it, showing intent
> to actually use the feature), which is what we're doing now, except we could
> add some kind of warning message for the user. Another option could be
> setting the device to broken. However, these options don't align with your
> suggestion of removing the device completely.
> 
> Let me know how you'd like me to proceed with this. Thanks!
> 
> > > > > > > 
> > > > > > > > ---
> > > > > > > >    hw/virtio/virtio-pci.c | 6 ++++--
> > > > > > > >    1 file changed, 4 insertions(+), 2 deletions(-)
> > > > > > > > 
> > > > > > > > diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> > > > > > > > index d12edc567f..287b8f7720 100644
> > > > > > > > --- a/hw/virtio/virtio-pci.c
> > > > > > > > +++ b/hw/virtio/virtio-pci.c
> > > > > > > > @@ -417,13 +417,15 @@ static void virtio_ioport_write(void *opaque, uint32_t addr, uint32_t val)
> > > > > > > >            }
> > > > > > > >            break;
> > > > > > > >        case VIRTIO_PCI_STATUS:
> > > > > > > > -        if (!(val & VIRTIO_CONFIG_S_DRIVER_OK)) {
> > > > > > > > +        if (!(val & VIRTIO_CONFIG_S_DRIVER_OK) &&
> > > > > > > > +            !virtio_vdev_has_feature(vdev, VIRTIO_F_NOTIFICATION_DATA)) {
> > > > > > > >                virtio_pci_stop_ioeventfd(proxy);
> > > > > > > >            }
> > > > > > > > 
> > > > > > > >            virtio_set_status(vdev, val & 0xFF);
> > > > > > > > 
> > > > > > > > -        if (val & VIRTIO_CONFIG_S_DRIVER_OK) {
> > > > > > > > +        if ((val & VIRTIO_CONFIG_S_DRIVER_OK) &&
> > > > > > > > +            !virtio_vdev_has_feature(vdev, VIRTIO_F_NOTIFICATION_DATA)) {
> > > > > > > >                virtio_pci_start_ioeventfd(proxy);
> > > > > > > >            }
> > > > > > > > 
> > > > > > > > --
> > > > > > > > 2.39.3
> > > > > > > 
> > > > > > 
> > > > 
> > 


