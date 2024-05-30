Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E381C25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2024 07:57:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCaec-0004uh-2L; Thu, 30 May 2024 03:56:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1sCaea-0004uJ-Ix
 for qemu-devel@nongnu.org; Thu, 30 May 2024 03:56:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1sCaeY-0005YV-Lj
 for qemu-devel@nongnu.org; Thu, 30 May 2024 03:56:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717055809;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=X39WmoL0Dz/4uCVVfpdPegDaHcEpyitnZaV4xhRkJPU=;
 b=AI1IcZ61SdFB6uvGHejdOmOuc1Z6yBX/8LjVrBJzUUVjbD/Fb1hmIYu1YRMOXE7g4ypkUG
 tmvr+bBKgp+Off+bH46Ef67HV8TV+aOgkIjcudPkOBe0QtwE0OokZ7wZFPC9MWWmSWpbt+
 nEytTNwt5iw86BZxbGWXFTzLoBneVQk=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-310-8_Z73csRPTG7KOcJWOmcVw-1; Thu, 30 May 2024 03:56:48 -0400
X-MC-Unique: 8_Z73csRPTG7KOcJWOmcVw-1
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-43fb05b2932so5922591cf.1
 for <qemu-devel@nongnu.org>; Thu, 30 May 2024 00:56:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717055807; x=1717660607;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X39WmoL0Dz/4uCVVfpdPegDaHcEpyitnZaV4xhRkJPU=;
 b=KX6a7pi/z9A+R01Si3Iq6EgrWwXRipOsOA2Us34fUlNHRdIH196RbmtJ3ArCOXNHIS
 zTihKpz4xXeumcDgbtxq4mIajkynq4KzEhF6Yq058cz2KUKNMOaTaVjOXRMA5t258K0p
 dGHPKhVosM6lxFqyvj8YPfg0czhU92sySVp0m4VKR+JX7AuCtlW1xQ/gbk6kAbiGl92d
 FKZgBbSzi1BcImFXkLXaVvIoRwCLr+2GSqr/FD8FDWV1QxeXhSaXc96cdqBqKDH/jmfL
 cyFvWz+iNVBz2Vi9LKZ4aoRjmBSR4oOMkCuAAMVJU4M2Lpnt9xlgY7p8gXVLko7NBOUl
 IOBQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXxH+E8ehp6mXR2YcnFbmClj/z7AF3A5NbLYB+CWA9Ojr8hMEbj13gNrrsxLO0Qst/VBiZsfvWRzbbbRy4naVjC0a2hPGM=
X-Gm-Message-State: AOJu0Yzsi8SKUkhGURpFktf58Ti0Jgl92U6M+T2ikfyHNvlFUTCBHszQ
 BmzDUxjCvJzskST/fSkK2xipUmmajfsc+oNWNZFg6/86gsPNbahaJToZxxNC41zOo7IFpxTz1LC
 ef86MBjNKB/RlEjR4T3x8/DfherEJjxaGsAqL5aDiImuUrb6ZU6fa
X-Received: by 2002:a05:622a:48e:b0:43a:ed9c:36f3 with SMTP id
 d75a77b69052e-43fe931d3d4mr16249231cf.42.1717055807465; 
 Thu, 30 May 2024 00:56:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEqF5sfn24xV7uxfXLqXuer8GXUCWTZv4Z461lUtI2xBgCV8tgB/QImxFV38O9Acm/47RFzkg==
X-Received: by 2002:a05:622a:48e:b0:43a:ed9c:36f3 with SMTP id
 d75a77b69052e-43fe931d3d4mr16249121cf.42.1717055806989; 
 Thu, 30 May 2024 00:56:46 -0700 (PDT)
Received: from sgarzare-redhat (host-79-53-30-109.retail.telecomitalia.it.
 [79.53.30.109]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-43fe3772080sm14911561cf.90.2024.05.30.00.56.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 May 2024 00:56:46 -0700 (PDT)
Date: Thu, 30 May 2024 09:56:41 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Halil Pasic <pasic@linux.ibm.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
 Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org,
 Marc Hartmayer <mhartmay@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Boris Fiuczynski <fiuczy@linux.ibm.com>
Subject: Re: [PATCH 1/1] vhost-vsock: add VIRTIO_F_RING_PACKED to feaure_bits
Message-ID: <22qkoy5dtmd2hrsrybc4mpbso5ve3ijg7eguy5qvrik3vvtwil@rhl2znimtl4y>
References: <20240429113334.2454197-1-pasic@linux.ibm.com>
 <ps5dukcjk6yh3an3hlkynr227r7kcln7b5dxgwope62avz5ceo@decy6vkuu56j>
 <20240527132710.4a7c372f.pasic@linux.ibm.com>
 <glq3neyd4vyzu4wgdrlq2a2ws7h4tn35dg2xaw4klc73zfj25k@pwotfsysvgqr>
 <20240529144928.182b34b1.pasic@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20240529144928.182b34b1.pasic@linux.ibm.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.036,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Wed, May 29, 2024 at 02:49:28PM GMT, Halil Pasic wrote:
>On Tue, 28 May 2024 17:32:26 +0200
>Stefano Garzarella <sgarzare@redhat.com> wrote:
>
>> >1) The uses is explicitly asking for a vhost device and giving the user
>> >a non vhost device is not an option.
>>
>> I didn't get this point :-( can you elaborate?
>
>I was thinking along the lines: QEMU gets told what devices to
>provision, and that includes things like what virtio features,
>and what kind of a backend.
>
>In this example, the default for vsock-vhost is no VIRTIO_F_RING_PACKED,
>but if we tell QEMU to create a vsock-vhost device with the feature
>VIRTIO_F_RING_PACKED, things go south in a not nice way.
>
>Given that vhost not supporting VIRTIO_F_RING_PACKED as of today is a
>fact of life we must accept, there are multiple ways how such a situation
>can be handled.
>
>For instance vhost-net is handling this by the device not offering the
>VIRTIO_F_RING_PACKED feature. This is at least what I think I have
>observed, but I would not mind somebody confirming it. But for the sake
>of the argument, let us look at other options.
>
>The straightforward one would be to not realize the device, because we
>can't provide what we have been asked to provide. And this actually
>makes me think about migration! What would happen, were we to
>eventually introduce, packed to vhost and vhost net, and then attempt to
>migrate between a host that has this new feature and host that has not. I
>guess things would pretty much blow up in a very unpleasant way!

Yes, migration with vhost devices implies that the destination host 
supports at least the same features as the source host. We should 
consider how migration between 2 QEMUs and the destination doesn't 
support a required feature, I guess migration can't happen or the device 
has to be removed and then re-added without that feature.

>
>Then for some devices, at least in theory, it might be possible to
>abandon not the feature but the backend. Along the lines we were asked to
>provide the feature X with backend Y but since backend Y does not
>support that feature and backed Z does, we will determistically go
>with backend Z. But IMHO this is a purely theoretical consideration, and
>we shall not go this way.

Yep, I agree!

>
>In any case if we are asked to provide with properties such that we
>can't actually do that, something has to go out of the window: either
>some of the properties, or the entire device.

I see.

Thanks,
Stefano


