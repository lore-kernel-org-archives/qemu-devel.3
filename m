Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 031D3C67861
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2024 15:22:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtqo3-000405-Ib; Mon, 08 Apr 2024 11:21:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rtqo2-0003zr-Me
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 11:21:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rtqny-0005Au-HI
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 11:21:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712589665;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kpKxBCA6LusS9GZa7hNR7Q0sriQfXtW12bRmAU6eYYs=;
 b=bWSrF+HWM8opGk1vbUZopx0N70BS5z5UkEEouE+UvF8uHm/2CcuDqAfqk2rkXagItk7Bwj
 FDr0wrbz59/WkTpMQepLIrsk+sZCxmRFcDIWFxg7jHHu53Ego8M556hT+BArQMVxC1KlWt
 rdH4C/XgQIuN0mV7f7zd7gQIKwhXbbA=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-472-mrhQQ3c8NM2jC9cxeNzRPQ-1; Mon, 08 Apr 2024 11:21:03 -0400
X-MC-Unique: mrhQQ3c8NM2jC9cxeNzRPQ-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a51acf7c214so49650566b.1
 for <qemu-devel@nongnu.org>; Mon, 08 Apr 2024 08:21:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712589662; x=1713194462;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kpKxBCA6LusS9GZa7hNR7Q0sriQfXtW12bRmAU6eYYs=;
 b=nUBmpB1Lx7ANTNiArpx2R0hU6pDggQy+cTQoImQV9IR9WwbOeKvce9GHC2R8W6MNJQ
 U5q6zbLhJOz+oT9E/RfRvfVlTg5k5Tv2+eyQB+VkwvO6CUy34oqvVVwETZ19hRFZch8s
 axehZci9MHAHyUa8EPEHL3eo3ewctrzrb9v5Xze1Hgzl1n+M+7kQYjSKahv4LHqi/6ZJ
 wU18trSomA8Pe1icgJO6p6aQcYb9BNCmZANMaNkHUvueTTN/xWlZq0Qb6ZXQWl3iifI+
 Gz9Ws6+JGhnf/KH3oyT6mYnQuCZLhtLvkRiuKlwhr5PLXMDGapPnZAKfWYSqhBfqT+aW
 89tA==
X-Gm-Message-State: AOJu0YxrMEcysZeAhDw1J1cFGvY274NOtIJy2a0ayHtMacu7JWduec2V
 dqM2mze2a9xaz+hVqWnNKl9zMsd8NeHKaHyFZF958BBwz8raMt0+qK9c/RbUkjAF9oXf1LJkl+N
 Evo2ENDglpRc/I61jW3/kCrFlfEQUi+KscRU7MLRSZJxXILlScjcA
X-Received: by 2002:a50:8ad1:0:b0:56b:d1c2:9b42 with SMTP id
 k17-20020a508ad1000000b0056bd1c29b42mr9205846edk.29.1712589662486; 
 Mon, 08 Apr 2024 08:21:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGiaBWfBrnHKqiGr+2N910xCFAB7P/YhSbjT2D7Oz2WfsMmDRxuCTgD7jRTa/zGERvqor1xtg==
X-Received: by 2002:a50:8ad1:0:b0:56b:d1c2:9b42 with SMTP id
 k17-20020a508ad1000000b0056bd1c29b42mr9205806edk.29.1712589662000; 
 Mon, 08 Apr 2024 08:21:02 -0700 (PDT)
Received: from redhat.com ([2.52.152.188]) by smtp.gmail.com with ESMTPSA id
 j7-20020aa7c0c7000000b0056e5306ca11sm2223604edp.53.2024.04.08.08.20.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Apr 2024 08:21:01 -0700 (PDT)
Date: Mon, 8 Apr 2024 11:20:57 -0400
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
Message-ID: <20240408112008-mutt-send-email-mst@kernel.org>
References: <20240404191339.5688-1-philmd@linaro.org>
 <20240404191339.5688-4-philmd@linaro.org>
 <942c06fd-fac0-49da-9421-92dc3a357cb3@linaro.org>
 <20240408060802-mutt-send-email-mst@kernel.org>
 <1daad71b-d1dd-44bf-ba6c-668bc80b99fd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1daad71b-d1dd-44bf-ba6c-668bc80b99fd@linaro.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.494,
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

On Mon, Apr 08, 2024 at 01:04:11PM +0200, Philippe Mathieu-Daudé wrote:
> On 8/4/24 12:08, Michael S. Tsirkin wrote:
> > On Mon, Apr 08, 2024 at 09:14:39AM +0200, Philippe Mathieu-Daudé wrote:
> > > On 4/4/24 21:13, Philippe Mathieu-Daudé wrote:
> > > > Replace qemu_bh_new_guarded() by virtio_bh_new_guarded()
> > > > so the bus and device use the same guard. Otherwise the
> > > > DMA-reentrancy protection can be bypassed.
> > > > 
> > > > Cc: qemu-stable@nongnu.org
> > > > Suggested-by: Alexander Bulekov <alxndr@bu.edu>
> > > > Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> > > > ---
> > > >    hw/char/virtio-serial-bus.c | 3 +--
> > > >    1 file changed, 1 insertion(+), 2 deletions(-)
> > > > 
> > > > diff --git a/hw/char/virtio-serial-bus.c b/hw/char/virtio-serial-bus.c
> > > > index 016aba6374..cd0e3a11f7 100644
> > > > --- a/hw/char/virtio-serial-bus.c
> > > > +++ b/hw/char/virtio-serial-bus.c
> > > > @@ -985,8 +985,7 @@ static void virtser_port_device_realize(DeviceState *dev, Error **errp)
> > > >            return;
> > > >        }
> > > > -    port->bh = qemu_bh_new_guarded(flush_queued_data_bh, port,
> > > > -                                   &dev->mem_reentrancy_guard);
> > > > +    port->bh = virtio_bh_new_guarded(vdev, flush_queued_data_bh, port);
> > > 
> > > Missing:
> > > -- >8 --
> > > -    port->bh = virtio_bh_new_guarded(vdev, flush_queued_data_bh, port);
> > > +    port->bh = virtio_bh_new_guarded(VIRTIO_DEVICE(dev),
> > > +                                     flush_queued_data_bh, port);
> > > ---
> > 
> > I don't get it. vdev is already the correct type. Why do you need
> > VIRTIO_DEVICE here?
> 
> This function doesn't declare vdev.
> 
> > 
> > > >        port->elem = NULL;
> > > >    }
> > 



But it seems clear it wasn't really tested, right?
Philipe here's my ack:

Acked-by: Michael S. Tsirkin <mst@redhat.com>

Feel free to merge these after testing.

-- 
MST


