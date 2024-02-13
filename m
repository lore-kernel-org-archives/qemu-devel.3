Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E76EC4829A
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 10:06:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZpff-0002ke-Mn; Tue, 13 Feb 2024 05:05:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rZpfc-0002kS-UX
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 05:05:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rZpfY-0004TB-F8
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 05:05:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707818738;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=j5lG6dnv7Q3RP29o/sKqQkVXeNELsFw+CU9N0/epPzw=;
 b=YvoMiBFiDfiJi4JuTL2OaXEqscHWdJJ3d1L/RWwN5ROq9J/tk9ajvHIpogZbVjFGV110Xo
 Mb4tynb7xvWXnRFLRCH6GWFcKXPFOd9NrG/btAsnTDWccoji35hUgabtWpOBjZ2wkgIjNk
 QhmFiIOyGSy543X06K8rDnYtWO/WGxE=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-371-Z5lURTZzNWi3cGHI6GC_Fw-1; Tue, 13 Feb 2024 05:05:37 -0500
X-MC-Unique: Z5lURTZzNWi3cGHI6GC_Fw-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a2bc664528fso320268166b.3
 for <qemu-devel@nongnu.org>; Tue, 13 Feb 2024 02:05:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707818736; x=1708423536;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j5lG6dnv7Q3RP29o/sKqQkVXeNELsFw+CU9N0/epPzw=;
 b=FF4urgItQt1iANCiAdw+u1B1luOzhFdh/9NVbVjKaqRxm/ApdBVJLUESWAG5el7ruB
 QLiTIU/vnnM1GOapQ4MdxQVbL8HVd8v8zvGaRy5jysi+4MMsPZi1j01MZz+9PQGb5uTL
 UIHpmqgVQhNLEl9FZIAjB2KUzQFGoTHKz9ZbzV91wvs9Tb54zubVYBwhf/uvVsVkQG/j
 tQpcqtfYbmU4jNCYZBSVQ/Ki2jTtO/KpmSnvNyW/zSg4i5mQFhblXCkIuGnOJB1Y0sA+
 pfIacCtk1is4/KivOad5BHKZv+0j9R7fwpszeB/24PZIj4MHGLChJvcf5SGAqYVbAH4y
 3mUQ==
X-Gm-Message-State: AOJu0YxvV9pbg79QKaoM/9EAewHzh7RzUO8kr5mwUtdqLviY+kKBgAyZ
 39V9Q7oSca8Yvr9B2/fj7Bh9dExBoXF9a+iP5g3JLN+XgqhnoEYzn7v3TG3RdFLq5fHE7aGQe1G
 X/j9G9LWXZPDqsh33TvhMOQ2hj0MN+mc5xAc2d7fCYOWDNVbNo3hF
X-Received: by 2002:a17:906:6d5:b0:a3c:11a0:8d10 with SMTP id
 v21-20020a17090606d500b00a3c11a08d10mr7613832ejb.3.1707818735940; 
 Tue, 13 Feb 2024 02:05:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGdEAi9s+eEkR+zapAzcouHuykyW7ecHwfp2bq7x6RmtjeAb1w5yybk7aOVP9gCrxyDDePrkA==
X-Received: by 2002:a17:906:6d5:b0:a3c:11a0:8d10 with SMTP id
 v21-20020a17090606d500b00a3c11a08d10mr7613820ejb.3.1707818735521; 
 Tue, 13 Feb 2024 02:05:35 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCV18qEc2MC0UCzFG8FxFuWkVNamcM9WHBqHYpEB9XJeHS8Iz+RgEfuleExfkcpqOGFmWNm+amhi5c2C5TaVNQGCKE3FKBXvGiB79ILoUtkQPHtGqQEWq0ALuFHXiDClmxq8AklRzBAPb5aS9VVW
Received: from redhat.com ([2.52.146.238]) by smtp.gmail.com with ESMTPSA id
 c19-20020a170906529300b00a3d1580d702sm181008ejm.185.2024.02.13.02.05.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Feb 2024 02:05:34 -0800 (PST)
Date: Tue, 13 Feb 2024 05:05:29 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Hao Chen <chenh@yusur.tech>
Cc: "open list:All patches CC here" <qemu-devel@nongnu.org>,
 huangml@yusur.tech, zy@yusur.tech,
 Maxime Coquelin <maxime.coquelin@redhat.com>
Subject: Re: [PATCH] vhost-user: fix the issue of vhost deadlock in nested
 virtualization
Message-ID: <20240213050258-mutt-send-email-mst@kernel.org>
References: <20240126100737.2509847-1-chenh@yusur.tech>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240126100737.2509847-1-chenh@yusur.tech>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.774,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Fri, Jan 26, 2024 at 06:07:37PM +0800, Hao Chen wrote:
> I run "dpdk-vdpa" and "qemur-L2" in "qemu-L1".
> 
> In a nested virtualization environment, "qemu-L2" vhost-user socket sends
> a "VHOST_USER_IOTLB_MSG" message to "dpdk-vdpa" and blocks waiting for
> "dpdk-vdpa" to process the message.
> If "dpdk-vdpa" doesn't complete the processing of the "VHOST_USER_IOTLB_MSG"
> message and sends a message that needs to be replied in another thread,
> such as "VHOST_USER_SLAVE_VRING_HOST_NOTIFIER_MSG", "dpdk-vdpa" will also
> block and wait for "qemu-L2" to process this message. However, "qemu-L2"
> vhost-user's socket is blocking while waiting for a reply from "dpdk-vdpa"
> after processing the message "VHOSTr_USER_IOTLB_MSG", and
> "VHOST_USER_SLAVE_VRING_HOST_NOTIFIER_MSG" will not be processed.
> In this case, both "dpdk-vdpa" and "qemu-L2" are blocked on the
> vhost read, resulting in a deadlock.
> 
> You can modify "VHOST_USER_SLAVE_VRING_HOST_NOTIFIER_MSG" or
> "VHOST_USER_IOTLB_MSG" to "no need reply" to fix this issue.
> There are too many messages in dpdk that are similar to
> "VHOST_USER_SLAVE_VRING_HOST_NOTIFIER_MSG", and I would prefer the latter.
> 
> Fixes: 24e34754eb78 ("vhost-user: factor out msg head and payload")
> 
> Signed-off-by: Hao Chen <chenh@yusur.tech>

I would be very worried that IOTLB becomes stale and
guest memory is corrupted if we just proceed without waiting.

Maxime what do you think? How would you address the issue?


> ---
>  hw/virtio/vhost-user.c | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
> 
> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> index f214df804b..02caa94b6c 100644
> --- a/hw/virtio/vhost-user.c
> +++ b/hw/virtio/vhost-user.c
> @@ -2371,20 +2371,14 @@ static int vhost_user_net_set_mtu(struct vhost_dev *dev, uint16_t mtu)
>  static int vhost_user_send_device_iotlb_msg(struct vhost_dev *dev,
>                                              struct vhost_iotlb_msg *imsg)
>  {
> -    int ret;
>      VhostUserMsg msg = {
>          .hdr.request = VHOST_USER_IOTLB_MSG,
>          .hdr.size = sizeof(msg.payload.iotlb),
> -        .hdr.flags = VHOST_USER_VERSION | VHOST_USER_NEED_REPLY_MASK,
> +        .hdr.flags = VHOST_USER_VERSION,
>          .payload.iotlb = *imsg,
>      };
>  
> -    ret = vhost_user_write(dev, &msg, NULL, 0);
> -    if (ret < 0) {
> -        return ret;
> -    }
> -
> -    return process_message_reply(dev, &msg);
> +    return vhost_user_write(dev, &msg, NULL, 0);
>  }
>  
>  
> -- 
> 2.27.0


