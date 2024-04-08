Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36243CD128A
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2024 10:09:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtlvm-000150-OE; Mon, 08 Apr 2024 06:08:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rtlvl-00014n-Ii
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 06:08:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rtlvh-0000LD-1f
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 06:08:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712570922;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JvAXyJ4OmiT5wC1nGxnlWXP7bjBe08vkB2uP0Alb3Yg=;
 b=EzpWuSp5/5NcOp6n5TBlwf8Jg/5GnLzlzDJWI5yNABf1sNIjCmrbdiiDXpnGFs0geRBW02
 fnnYHS7zmvANiIr0sIqn2j7C6wZU04M9Ne5MXUpTTdFAZ8wWMjra9Urkh2QzLpqrelUkZY
 teYGohI4TQMO4hTlrEKQSKYPtJ0Cf+M=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-341-m1VChzkCPq-bjC3pB9Y73w-1; Mon, 08 Apr 2024 06:08:40 -0400
X-MC-Unique: m1VChzkCPq-bjC3pB9Y73w-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-41634d6c008so8511775e9.1
 for <qemu-devel@nongnu.org>; Mon, 08 Apr 2024 03:08:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712570920; x=1713175720;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JvAXyJ4OmiT5wC1nGxnlWXP7bjBe08vkB2uP0Alb3Yg=;
 b=kw1cW+s5uD5XAkRwMtu84Fys7g0sFVCKzYv2jSxstowBpd2LhN8rbUtJ7u2cqwXQz5
 vjLv9PsINIGi8yDzx/dUwSs/eQY/CNveDaB3yp0kX1cv2rqdX9ikZag1OtU/2reVKwYy
 MiD5Tx+VKxBaNte0LTi1lRUBSEMwwAwYit0qdmXHjkFr9qd9wt5T2u4djR0AyWer6s0J
 BlTq5jnLiG8HDYDDR6oStf0euroZjJaVOwvVmoJBIA2VM0LFeRD/3KDEmLhdK2C718M0
 LCPts7bJTqegMLGNyGdHoAp9eApOcECQ1IIhL4w0zu0SK7lqQKVgH1PZE9+l6VSRHIWG
 Owig==
X-Gm-Message-State: AOJu0YxKTk06npHRGkFQtGHbklRAXgZ1d58HQyNtG/tbTyvS5CWmtNEb
 VGNOyEDNm+W9tJZ7fySF0TPjyjghW+O3SiGaIl6h8TWYF5sBUGwFsVFbEc0XBju7E2GDBpXQTDj
 jsL+/d5iYIIMD8seeyOI0K0OuzfwkXXxmuYcS2xqohxLbjyBIz4M8
X-Received: by 2002:a05:600c:1d81:b0:416:7b2c:df0f with SMTP id
 p1-20020a05600c1d8100b004167b2cdf0fmr1338176wms.7.1712570919593; 
 Mon, 08 Apr 2024 03:08:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHVef5FfoP8snT1822L3jh1phV9JZnhg+D/MH2sIRHEacEaVNThsXD9bx8IgB77MSr5/jU9vQ==
X-Received: by 2002:a05:600c:1d81:b0:416:7b2c:df0f with SMTP id
 p1-20020a05600c1d8100b004167b2cdf0fmr1338149wms.7.1712570919068; 
 Mon, 08 Apr 2024 03:08:39 -0700 (PDT)
Received: from redhat.com ([2.52.152.188]) by smtp.gmail.com with ESMTPSA id
 h13-20020a05600c260d00b0041691379a84sm138404wma.1.2024.04.08.03.08.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Apr 2024 03:08:38 -0700 (PDT)
Date: Mon, 8 Apr 2024 06:08:35 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 Amit Shah <amit@kernel.org>, Alexander Bulekov <alxndr@bu.edu>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>,
 Mauro Matteo Cascella <mcascell@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-stable@nongnu.org
Subject: Re: [PATCH-for-9.0 3/4] hw/char/virtio-serial-bus: Protect from DMA
 re-entrancy bugs
Message-ID: <20240408060802-mutt-send-email-mst@kernel.org>
References: <20240404191339.5688-1-philmd@linaro.org>
 <20240404191339.5688-4-philmd@linaro.org>
 <942c06fd-fac0-49da-9421-92dc3a357cb3@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <942c06fd-fac0-49da-9421-92dc3a357cb3@linaro.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Mon, Apr 08, 2024 at 09:14:39AM +0200, Philippe Mathieu-Daudé wrote:
> On 4/4/24 21:13, Philippe Mathieu-Daudé wrote:
> > Replace qemu_bh_new_guarded() by virtio_bh_new_guarded()
> > so the bus and device use the same guard. Otherwise the
> > DMA-reentrancy protection can be bypassed.
> > 
> > Cc: qemu-stable@nongnu.org
> > Suggested-by: Alexander Bulekov <alxndr@bu.edu>
> > Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> > ---
> >   hw/char/virtio-serial-bus.c | 3 +--
> >   1 file changed, 1 insertion(+), 2 deletions(-)
> > 
> > diff --git a/hw/char/virtio-serial-bus.c b/hw/char/virtio-serial-bus.c
> > index 016aba6374..cd0e3a11f7 100644
> > --- a/hw/char/virtio-serial-bus.c
> > +++ b/hw/char/virtio-serial-bus.c
> > @@ -985,8 +985,7 @@ static void virtser_port_device_realize(DeviceState *dev, Error **errp)
> >           return;
> >       }
> > -    port->bh = qemu_bh_new_guarded(flush_queued_data_bh, port,
> > -                                   &dev->mem_reentrancy_guard);
> > +    port->bh = virtio_bh_new_guarded(vdev, flush_queued_data_bh, port);
> 
> Missing:
> -- >8 --
> -    port->bh = virtio_bh_new_guarded(vdev, flush_queued_data_bh, port);
> +    port->bh = virtio_bh_new_guarded(VIRTIO_DEVICE(dev),
> +                                     flush_queued_data_bh, port);
> ---

I don't get it. vdev is already the correct type. Why do you need
VIRTIO_DEVICE here?

> >       port->elem = NULL;
> >   }


