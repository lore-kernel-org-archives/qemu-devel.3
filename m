Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1159C3DA41
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2024 13:41:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRXYB-0007q7-LO; Wed, 10 Jul 2024 09:40:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mvaralar@redhat.com>)
 id 1sRXYA-0007pP-5t
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 09:40:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mvaralar@redhat.com>)
 id 1sRXY8-0004ys-7R
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 09:40:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720618798;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KZpjBnZdDTBFXsMwqvvzXi6dNGUCSASdHDEcQwjHk2w=;
 b=KxPHLaFUQ+SOm5wOY4YdkamMBEnfRy6lLJMx/ryZ+soIC9N+44tp6wYLUw9+OdNT1CBTA3
 zZBnVIFIVKRirVGnIedwWGI8bqQvYpR4CtRGq501osCcTyhSCdDTp5Gji1/7vow+zf10Lq
 J85jiVHoUJg2N1OGM9pE3Yy57CB/hwM=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-551-bvsSAzPROQ6L_fFgFNcGQQ-1; Wed, 10 Jul 2024 09:39:57 -0400
X-MC-Unique: bvsSAzPROQ6L_fFgFNcGQQ-1
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-44931fdfd54so24941191cf.1
 for <qemu-devel@nongnu.org>; Wed, 10 Jul 2024 06:39:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720618796; x=1721223596;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KZpjBnZdDTBFXsMwqvvzXi6dNGUCSASdHDEcQwjHk2w=;
 b=sbyL0+ULNZqMii5BdztgOuw2INNUxlcz4tfCHD4oO2DSyqfd+CnxLMEW9brZuzz51u
 I2z3TxHbFnecJeelc9TCvV4pti+7uwvBMWGycdbcgSG2uOF1KHnK/HppkZJ4Mpo+sPbV
 C9/K2IkaH/Dzpyr6cVDX/VhwhIWIxkt6q5j+voZPzjbSl+93+Y2IGUWmCzTn2RItuWAg
 vumFh9r0SwhJy+O0NQhQcGaWx08h/0sGeSEARNGD2DGJ3DHfhTAJ6oCGYgquPWxU4Fh/
 M5hKSKAzGQP1LA2VbFV5U/2Z8Aq52nEE14Hje7J0KQsUkES/bAazMxjGVlF/JjC39UqU
 MuMA==
X-Gm-Message-State: AOJu0Yw8hv0RvnXIGuQ7F1JmprgSKV7ZNge1oH2cY1GOYd7bT0EV7p/k
 cRVBm4gezYMtYrhcpUoSCU47D+gD9zpG17fDVdaYazjWZMaOO1eQcGjNaSTdPGkQ+ux4/H6ZQId
 4WtS94W8JnOLwgCQZAru1mzGqOwYBanpP8FX7ZkRyv9Dod8biAFf4
X-Received: by 2002:ac8:5ac5:0:b0:447:dc01:eb1c with SMTP id
 d75a77b69052e-447fa882d27mr62609871cf.26.1720618795739; 
 Wed, 10 Jul 2024 06:39:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHqdZTNejxTwUYxQrOdUGFfYxuKHIprzBFTUh/FT3LDhK5LOhUV0U5mF+OE7jRg3lpH48yd6w==
X-Received: by 2002:ac8:5ac5:0:b0:447:dc01:eb1c with SMTP id
 d75a77b69052e-447fa882d27mr62609651cf.26.1720618795403; 
 Wed, 10 Jul 2024 06:39:55 -0700 (PDT)
Received: from fedora (193-248-58-176.ftth.fr.orangecustomers.net.
 [193.248.58.176]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-447f9b3c4fdsm20494711cf.32.2024.07.10.06.39.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jul 2024 06:39:55 -0700 (PDT)
Date: Wed, 10 Jul 2024 15:39:52 +0200
From: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
To: Hanna Czenczek <hreitz@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] virtio: Always reset vhost devices
Message-ID: <Zo6PKHFzM0+VLdBg@fedora>
References: <20240710112310.316551-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240710112310.316551-1-hreitz@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mvaralar@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hello Hanna,

On Wed, Jul 10, 2024 at 01:23:10PM +0200, Hanna Czenczek wrote:
> Requiring `vhost_started` to be true for resetting vhost devices in
> `virtio_reset()` seems like the wrong condition: Most importantly, the
> preceding `virtio_set_status(vdev, 0)` call will (for vhost devices) end
> up in `vhost_dev_stop()` (through vhost devices' `.set_status`
> implementations), setting `vdev->vhost_started = false`.  Therefore, the
> gated `vhost_reset_device()` call is unreachable.
> 
> `vhost_started` is not documented, so it is hard to say what exactly it
> is supposed to mean, but judging from the fact that `vhost_dev_start()`
> sets it and `vhost_dev_stop()` clears it, it seems like it indicates
> whether there is a vhost back-end, and whether that back-end is
> currently running and processing virtio requests.
> 
> Making a reset conditional on whether the vhost back-end is processing
> virtio requests seems wrong; in fact, it is probably better to reset it
> only when it is not currently processing requests, which is exactly the
> current order of operations in `virtio_reset()`: First, the back-end is
> stopped through `virtio_set_status(vdev, 0)`, then we want to send a
> reset.
> 
> Therefore, we should drop the `vhost_started` condition, but in its
> stead we then have to verify that we can indeed send a reset to this
> vhost device, by not just checking `k->get_vhost != NULL` (introduced by
> commit 95e1019a4a9), but also that the vhost back-end is connected
> (`hdev = k->get_vhost(); hdev != NULL && hdev->vhost_ops != NULL`).
> 

I am not a native speaker but I think the commit message could be
rephrased to make it clear. This is a minor comment so feel free to
ignore it:

Before `virtio_reset()` is invoked, `virtio_set_status(vdev, 0)` for
vhost devices ends up setting `vhost_stared` to false thus resulting in
`vhost_reset_device()` being never reached during a reset.

`vhost_started` is not documented, however, from `vhost_dev_start()` and
`vhost_dev_stop()`, it seems indicating that there is a vhost back-end
and that the back-end is running and processing virtio requests.
Resetting should not rely on whether the vhost back-end is processing
virtio requests, instead, reset must happen if there is no processing
request. This is what `virtio_reset()` does, it first stops the backend
and then sends the reset.

To trigger a reset, this commit drops the `vhost_started` condition and
checks that the device is running (introduced by 95e1019a4a9) but also
that the vhost back-end is connected so it is possible to send a reset
to the vhost device.

Matias


