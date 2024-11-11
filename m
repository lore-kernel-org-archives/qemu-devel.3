Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D7AED2E9CD
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2024 09:51:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAR4M-0001Ss-Os; Mon, 11 Nov 2024 04:50:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1tAR3O-0001FJ-9W
 for qemu-devel@nongnu.org; Mon, 11 Nov 2024 04:49:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1tAR3M-0001V0-6U
 for qemu-devel@nongnu.org; Mon, 11 Nov 2024 04:49:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731318586;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oKN+hbvRAbjvT0k0w6HxpWZP+nj6j2GUs9fh5TZe3iM=;
 b=VgpretnhVVa0v7bcvBhYOeIJZILYHF+6RsCNUf9Is5+S8nEK5NinnozmRd5ti0rLdX3IhN
 cbi65rkn67ICuc/WaZMfv0pNxvRl2MW5rf926uCTh/1JTWz8za65BWcqiUtx67mkiJi+gO
 CvmfN3Qkih8B93FQMdgqMd7cb9O0KSs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-116-B8ikLfeiO4OUpWf3TapEIw-1; Mon, 11 Nov 2024 04:49:44 -0500
X-MC-Unique: B8ikLfeiO4OUpWf3TapEIw-1
X-Mimecast-MFC-AGG-ID: B8ikLfeiO4OUpWf3TapEIw
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43151a9ea95so27776215e9.1
 for <qemu-devel@nongnu.org>; Mon, 11 Nov 2024 01:49:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731318583; x=1731923383;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oKN+hbvRAbjvT0k0w6HxpWZP+nj6j2GUs9fh5TZe3iM=;
 b=ssnEsrUaTC9RP83hMO/xeaeIcZfQblEn8ZSgCpP+WeO5XZrMnjvl4jXRwndi/TCJb6
 V/bl/e60zt1vncRkTbXiPPM60iY5Mt3M4gvs7mD6f8iCFQUJUnyFd7yJQnt7WrarZcLG
 RRoWcxNo1S3NVOAHMm1FZohUIdZDPL8tnVLqYyEQZKqcfN1ggrSpcwlx5bsTlfSkkF3V
 3vTzFxzecyd7I8QRv2JUzvf/n2leqa7HPQrWbxukUp7qq2RpcsbIVJNy5HIcXiAzy9ym
 1qithxrzK0BRNmyLza974g2SH6yWShR2Uin7AkK4DhNy/CEYjP60X9mI1GpUFplWFzIz
 W4og==
X-Gm-Message-State: AOJu0YyTg2qkV4Rb8rPJZOn9hi1hecr2mK4RUc6z7LelYhhDun5vRFgZ
 m4eB8lGCZk+Wfv6JtEcTRyQPFd20gmRUHXfOlAeqJhrTaqRhCxIPA8FDyMIivPZ+CGopM45UR+b
 r1PXBmuhecx5okuqB4SUeHyZCS9ykOh+E3XGbQrMfFdG4jBbpbgzUkzW44KwjS74bY/1/cwAy4G
 Vlf0QrS5Me4MKO1YZ/Smal3VHKsiE=
X-Received: by 2002:a05:600c:a085:b0:431:559d:4103 with SMTP id
 5b1f17b1804b1-432b747dc59mr99253855e9.7.1731318583389; 
 Mon, 11 Nov 2024 01:49:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF2uUv35Fqd8/9u3uF064kyWXZqmULATbGySPfmtCKeibFtIMOdAL21czz7fLjKBr3j6sGGgBE6tO7IQYymYEU=
X-Received: by 2002:a05:600c:a085:b0:431:559d:4103 with SMTP id
 5b1f17b1804b1-432b747dc59mr99253725e9.7.1731318583101; Mon, 11 Nov 2024
 01:49:43 -0800 (PST)
MIME-Version: 1.0
References: <20241107113247.46532-1-ppandit@redhat.com>
 <CACGkMEu+8fWoSSCdHwVYV9UpqN8FS4f0jVRA0x9CiPhNEKrx=g@mail.gmail.com>
In-Reply-To: <CACGkMEu+8fWoSSCdHwVYV9UpqN8FS4f0jVRA0x9CiPhNEKrx=g@mail.gmail.com>
From: Prasad Pandit <ppandit@redhat.com>
Date: Mon, 11 Nov 2024 15:19:26 +0530
Message-ID: <CAE8KmOwjbCuQt6KZ7MGCYXxKrCQ_CG26BY+Yy7ys=9pQ_1LWEA@mail.gmail.com>
Subject: Re: [PATCH v1] vhost: fail device start if iotlb update fails
To: Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org, Stefano Garzarella <sgarzare@redhat.com>,
 eperezma@redhat.com, mst@redhat.com, Prasad Pandit <pjp@fedoraproject.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.118,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

Hello Jason,

On Mon, 11 Nov 2024 at 07:08, Jason Wang <jasowang@redhat.com> wrote:
> > While starting a vhost device, updating iotlb entries
> > via 'vhost_device_iotlb_miss' may return an error.
> >
> >   qemu-kvm: vhost_device_iotlb_miss:
> >     700871,700871: Fail to update device iotlb
>
> Actually, such updating is a workaround for vhost-net kernel to run.
> I wonder what kind of issue would we get if we don't do this?

* During Postcopy migration, while starting the 'vhost-user' device,
update of its iotlb entries would fail and the guest on the
destination would hang, not finishing the migration. There might be
other such scenarios.

Thank you.
---
  - Prasad


