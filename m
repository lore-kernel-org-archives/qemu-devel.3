Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB33ACD1284
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Apr 2024 12:14:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rrd0W-00060n-P4; Tue, 02 Apr 2024 08:12:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rrd0Q-000608-Ms
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 08:12:47 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rrczJ-0003yl-O0
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 08:12:45 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-415523d9824so32262645e9.3
 for <qemu-devel@nongnu.org>; Tue, 02 Apr 2024 05:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712059893; x=1712664693; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BACjPm7ApmC8dr/jTxJ+BIAqI2Do8+8VBU/HRYfAs3A=;
 b=Rd56v34+4UkgkfTJjUKeNrJGOmHuP4E7n+78xAbmVfRFiHcV6qD2qnQKAF2mEC2Adv
 0/rNbQFUI8mNwOl3WKLrXK1d7RALlthq0/cEU2q5CEBBQwrZM0yC+DdaTd9jLWZWLSmT
 vC+btSF6KYITx8Czalo1nEL7GZIHKUljTfG7yqanZcG+JS6HZRkyUYUgU+lDa3YoxwLA
 7N/y9lmFZ8LAxdnOyXI73J4PwzQKrAOr1SQsY7gQFVT3D1V2IM+wNxoUov3oXU8jXJVE
 1tYXVDbASanmFG11GlgDt6bHdQ9/+aBZoXW/BGGPfWIT9+FmOUE56YnKSkKPUDhcZMHK
 FJ9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712059893; x=1712664693;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BACjPm7ApmC8dr/jTxJ+BIAqI2Do8+8VBU/HRYfAs3A=;
 b=OOLhLmfBWQVjSdRl6xih/py8aE0KvJjlaBdqSNMf8eD21SOoprY1l1AF2W9IglPscp
 Sy2JbZ3K2o16azfcagFIU2jmFxv0Pb72Hwrzoa8Hsl+BwBElEES4LdGF/CDnO2URLvrx
 ecA5qwRrEQq43d8O9g3n2Bpqbi+Pa9PYK5d/sBs0GBgWW7/6h/ywrBbXR5cpHQ2Cfd68
 FbzLKsZZPVeHFvAU6208HdZ//cteSr7bKyV6A7nEZeAUIHDAGQTmWeCEEhe4tsSdwCyD
 VYvlXozEEBjHfAWXs+IQbcLkZ9+jhnD3QSjure5YM2oRZOrW41EwKC0hADXLqgU6WHu8
 vuFA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWRjVgpVzDWSrrfNri7mxwv5SoXCKEWFKh6SyCNI9e/vzUsRCYtxH5hdIJ/fooM8AtC96dtqFrb+bRx/kvZapQfULKvViI=
X-Gm-Message-State: AOJu0YwAawmesndaOTtlh6Jvoj/XDhpUFH4hpBB+COyWpHNMLw1jJ5CJ
 ocb8jZ0I59LQwQSmMH8uniFy5m8DA9qs6MZ3bQZ0lxoYCmbVcAP4jdomw7nK3Y0=
X-Google-Smtp-Source: AGHT+IEsxPW+kkcOTrTbYZos52TpmDq3TWIXi+YKb8EGbR/OsdLD6LPh+muu3OGq7knD7tSHna0yOQ==
X-Received: by 2002:adf:e904:0:b0:33e:7a1c:788e with SMTP id
 f4-20020adfe904000000b0033e7a1c788emr1287321wrm.6.1712059893625; 
 Tue, 02 Apr 2024 05:11:33 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.202.91])
 by smtp.gmail.com with ESMTPSA id
 u14-20020a056000038e00b003433e5cab4bsm10377681wrf.103.2024.04.02.05.11.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Apr 2024 05:11:33 -0700 (PDT)
Message-ID: <059cb96a-ac0b-4266-bd6e-8911c387baeb@linaro.org>
Date: Tue, 2 Apr 2024 14:11:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] virtio-net: fix qemu set used ring flag even vhost started
To: Yajun Wu <yajunw@nvidia.com>, qemu-devel@nongnu.org, mst@redhat.com,
 jasowang@redhat.com, maxime.coquelin@redhat.com
Cc: Jiri Pirko <jiri@nvidia.com>
References: <20240402045109.97729-1-yajunw@nvidia.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240402045109.97729-1-yajunw@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Yajun,

On 2/4/24 06:51, Yajun Wu wrote:
> When vhost-user or vhost-kernel is handling virtio net datapath, qemu

"QEMU"

> should not touch used ring.
> 
> But with vhost-user socket reconnect scenario, in a very rare case (has
> pending kick event). VRING_USED_F_NO_NOTIFY is set by qemu in

"QEMU"

> following code path:
> 
> 	#0  virtio_queue_split_set_notification (vq=0x7ff5f4c920a8, enable=0) at ../hw/virtio/virtio.c:511
> 	#1  0x0000559d6dbf033b in virtio_queue_set_notification (vq=0x7ff5f4c920a8, enable=0) at ../hw/virtio/virtio.c:576
> 	#2  0x0000559d6dbbbdbc in virtio_net_handle_tx_bh (vdev=0x559d703a6aa0, vq=0x7ff5f4c920a8) at ../hw/net/virtio-net.c:2801
> 	#3  0x0000559d6dbf4791 in virtio_queue_notify_vq (vq=0x7ff5f4c920a8) at ../hw/virtio/virtio.c:2248
> 	#4  0x0000559d6dbf79da in virtio_queue_host_notifier_read (n=0x7ff5f4c9211c) at ../hw/virtio/virtio.c:3525
> 	#5  0x0000559d6d9a5814 in virtio_bus_cleanup_host_notifier (bus=0x559d703a6a20, n=1) at ../hw/virtio/virtio-bus.c:321
> 	#6  0x0000559d6dbf83c9 in virtio_device_stop_ioeventfd_impl (vdev=0x559d703a6aa0) at ../hw/virtio/virtio.c:3774
> 	#7  0x0000559d6d9a55c8 in virtio_bus_stop_ioeventfd (bus=0x559d703a6a20) at ../hw/virtio/virtio-bus.c:259
> 	#8  0x0000559d6d9a53e8 in virtio_bus_grab_ioeventfd (bus=0x559d703a6a20) at ../hw/virtio/virtio-bus.c:199
> 	#9  0x0000559d6dbf841c in virtio_device_grab_ioeventfd (vdev=0x559d703a6aa0) at ../hw/virtio/virtio.c:3783
> 	#10 0x0000559d6d9bde18 in vhost_dev_enable_notifiers (hdev=0x559d707edd70, vdev=0x559d703a6aa0) at ../hw/virtio/vhost.c:1592
> 	#11 0x0000559d6d89a0b8 in vhost_net_start_one (net=0x559d707edd70, dev=0x559d703a6aa0) at ../hw/net/vhost_net.c:266
> 	#12 0x0000559d6d89a6df in vhost_net_start (dev=0x559d703a6aa0, ncs=0x559d7048d890, data_queue_pairs=31, cvq=0) at ../hw/net/vhost_net.c:412
> 	#13 0x0000559d6dbb5b89 in virtio_net_vhost_status (n=0x559d703a6aa0, status=15 '\017') at ../hw/net/virtio-net.c:311
> 	#14 0x0000559d6dbb5e34 in virtio_net_set_status (vdev=0x559d703a6aa0, status=15 '\017') at ../hw/net/virtio-net.c:392
> 	#15 0x0000559d6dbb60d8 in virtio_net_set_link_status (nc=0x559d7048d890) at ../hw/net/virtio-net.c:455
> 	#16 0x0000559d6da64863 in qmp_set_link (name=0x559d6f0b83d0 "hostnet1", up=true, errp=0x7ffdd76569f0) at ../net/net.c:1459
> 	#17 0x0000559d6da7226e in net_vhost_user_event (opaque=0x559d6f0b83d0, event=CHR_EVENT_OPENED) at ../net/vhost-user.c:301
> 	#18 0x0000559d6ddc7f63 in chr_be_event (s=0x559d6f2ffea0, event=CHR_EVENT_OPENED) at ../chardev/char.c:62
> 	#19 0x0000559d6ddc7fdc in qemu_chr_be_event (s=0x559d6f2ffea0, event=CHR_EVENT_OPENED) at ../chardev/char.c:82
> 
> This issue causes guest kernel stop kicking device and traffic stop.
> 
> Add vhost_started check in virtio_net_handle_tx_bh to fix this wrong
> VRING_USED_F_NO_NOTIFY set.
> 
> Signed-off-by: Yajun Wu <yajunw@nvidia.com>
> Reviewed-by: Jiri Pirko <jiri@nvidia.com>
> ---
>   hw/net/virtio-net.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index a6ff000cd9..8035e01fdf 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -2865,6 +2865,10 @@ static void virtio_net_handle_tx_bh(VirtIODevice *vdev, VirtQueue *vq)
>       VirtIONet *n = VIRTIO_NET(vdev);
>       VirtIONetQueue *q = &n->vqs[vq2q(virtio_get_queue_index(vq))];
>   
> +    if (n->vhost_started) {

Since you mentioned "in a very rare case", maybe use unlikely()?

> +        return;
> +    }
> +
>       if (unlikely((n->status & VIRTIO_NET_S_LINK_UP) == 0)) {
>           virtio_net_drop_tx_queue_data(vdev, vq);
>           return;


