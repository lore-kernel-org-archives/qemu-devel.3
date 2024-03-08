Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B755C5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 17:37:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rie9z-0006mA-Sf; Fri, 08 Mar 2024 12:37:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rie9y-0006lt-9B
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 12:37:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rie9v-000897-NA
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 12:37:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709919446;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JW5qJ1RyhGf6smEE2z4UNavrXoakDST/SzLv7Y+wScQ=;
 b=MfiCesyovCbFaJC4s6n5UeiJO4N8oesyYzITtrF6BsUhPwJbthGLORi+QLQVQBMJcCU33O
 HLd0YnCm3ITQtXuZl8CYqM7w2yDD0pR/dv3X1jxlQAZKjxteuhVHshtwmRC9CLw9/XcHxG
 SOBOAou/BOMO0r7tyW4V1iWUfd7PfuQ=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-363-RNHeJ4QQM7-u_k31rox86g-1; Fri, 08 Mar 2024 12:37:24 -0500
X-MC-Unique: RNHeJ4QQM7-u_k31rox86g-1
Received: by mail-yb1-f199.google.com with SMTP id
 3f1490d57ef6-dcdc3db67f0so3805590276.1
 for <qemu-devel@nongnu.org>; Fri, 08 Mar 2024 09:37:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709919444; x=1710524244;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JW5qJ1RyhGf6smEE2z4UNavrXoakDST/SzLv7Y+wScQ=;
 b=veoMYERb99Gq204aMcYDA4REBMMBhOpXGwfECY/IlfD7r+cpUjd/GnkJqDGreNVGcZ
 IREQrKEo/bXsOKsdDpqcn9/4vKD/cKhceCcTXkE3EPOeWHZ3yaIXhB04xSjZwf3wIHoh
 OS7MN8yhRFoRP0wlfbdDiMBAvbtDZIq+W0i8PZ/X5o5Uz6ASsIcI13HKZewT6w227R0c
 nBZEbyA45+NzhEsooQHPNr+Bt6GiQN9CkQAq93Gb+q9z3Tzej6Evhfoe/tkR7pHOy+7d
 PQ1weVb0tkC/DS3EGAR61dp8qakN9ffQwKyPe0bGosQlJIUg1mJePhbOYlZTh+DceSxj
 OBhA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV/pr8F7Z9AD8LCv3YRX9UHSL7sGnnrlyM4oHOYumVUCftv3IxwfwM/NGS82IXsAlUiziLZCroWSLyHTn9ihHheDODfmLw=
X-Gm-Message-State: AOJu0YyN2t6hnLG4b8peNaluAKzi/P8NO16UxIuPcuSSGb+CRAfimu0V
 exAQqrxA20J5zi8RPTKTRqCmQUCWwLJa3zhTgUlQml2OE1nW7Uz2lK+K9JH6uPy7HQ1SjcilGw1
 d//CiLJZCuDjgqKAFGKBv/I1cu8PazbpUL0Oah+rV70kPtYlqGNqOGQjKESJleWm7uGG5GRvAMR
 JZctz4PUIxmq2OMMQ95hXqO0l83Go=
X-Received: by 2002:a25:1089:0:b0:dc6:b1ab:b400 with SMTP id
 131-20020a251089000000b00dc6b1abb400mr897807ybq.18.1709919444121; 
 Fri, 08 Mar 2024 09:37:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGjxyo2NspjIhzdNdSOlqVIgd6XaLIsGI0IssTeiz3u0sZ8aRGWXv699Ktslb564MoaYd0X8iZFtE1CD5aWmXM=
X-Received: by 2002:a25:1089:0:b0:dc6:b1ab:b400 with SMTP id
 131-20020a251089000000b00dc6b1abb400mr897777ybq.18.1709919443836; Fri, 08 Mar
 2024 09:37:23 -0800 (PST)
MIME-Version: 1.0
References: <20240304194612.611660-1-jonah.palmer@oracle.com>
 <20240304194612.611660-3-jonah.palmer@oracle.com>
 <20240308115951-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240308115951-mutt-send-email-mst@kernel.org>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Fri, 8 Mar 2024 18:36:47 +0100
Message-ID: <CAJaqyWcRDjSXbgxMHbdPy_YO4boQthu_4_9zKYX3S5t-G1ju2g@mail.gmail.com>
Subject: Re: [PATCH v1 2/8] virtio-pci: Lock ioeventfd state with
 VIRTIO_F_NOTIFICATION_DATA
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jonah Palmer <jonah.palmer@oracle.com>, qemu-devel@nongnu.org,
 jasowang@redhat.com, 
 si-wei.liu@oracle.com, boris.ostrovsky@oracle.com, raphael@enfabrica.net, 
 kwolf@redhat.com, hreitz@redhat.com, pasic@linux.ibm.com, 
 borntraeger@linux.ibm.com, farman@linux.ibm.com, thuth@redhat.com, 
 richard.henderson@linaro.org, david@redhat.com, iii@linux.ibm.com, 
 cohuck@redhat.com, pbonzini@redhat.com, fam@euphon.net, stefanha@redhat.com, 
 qemu-block@nongnu.org, qemu-s390x@nongnu.org, virtio-fs@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.572,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Fri, Mar 8, 2024 at 6:01=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com> =
wrote:
>
> On Mon, Mar 04, 2024 at 02:46:06PM -0500, Jonah Palmer wrote:
> > Prevent ioeventfd from being enabled/disabled when a virtio-pci
> > device has negotiated the VIRTIO_F_NOTIFICATION_DATA transport
> > feature.
> >
> > Due to ioeventfd not being able to carry the extra data associated with
> > this feature, the ioeventfd should be left in a disabled state for
> > emulated virtio-pci devices using this feature.
> >
> > Reviewed-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
>
> I thought hard about this. I propose that for now,
> instead of disabling ioevetfd silently we error out unless
> user disabled it for us.
> WDYT?
>

Yes, error is a better plan than silently disabling it. In the
(unlikely?) case we are able to make notification data work with
eventfd in the future, it makes the change more evident.

>
> > ---
> >  hw/virtio/virtio-pci.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> > index d12edc567f..287b8f7720 100644
> > --- a/hw/virtio/virtio-pci.c
> > +++ b/hw/virtio/virtio-pci.c
> > @@ -417,13 +417,15 @@ static void virtio_ioport_write(void *opaque, uin=
t32_t addr, uint32_t val)
> >          }
> >          break;
> >      case VIRTIO_PCI_STATUS:
> > -        if (!(val & VIRTIO_CONFIG_S_DRIVER_OK)) {
> > +        if (!(val & VIRTIO_CONFIG_S_DRIVER_OK) &&
> > +            !virtio_vdev_has_feature(vdev, VIRTIO_F_NOTIFICATION_DATA)=
) {
> >              virtio_pci_stop_ioeventfd(proxy);
> >          }
> >
> >          virtio_set_status(vdev, val & 0xFF);
> >
> > -        if (val & VIRTIO_CONFIG_S_DRIVER_OK) {
> > +        if ((val & VIRTIO_CONFIG_S_DRIVER_OK) &&
> > +            !virtio_vdev_has_feature(vdev, VIRTIO_F_NOTIFICATION_DATA)=
) {
> >              virtio_pci_start_ioeventfd(proxy);
> >          }
> >
> > --
> > 2.39.3
>


