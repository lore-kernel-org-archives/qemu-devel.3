Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A19EC2BD05
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2024 10:23:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLgqv-000746-9w; Mon, 24 Jun 2024 06:23:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sLgqs-00070n-W0
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 06:23:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sLgqr-00005O-67
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 06:23:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719224587;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dVIZiTR+Qlx7R63DABIwO7Immyiuqt5V5O4QrLSqxwM=;
 b=WX1pplJd8VfCtoRsZxuO2jamuDbvZPLXp4Sz1LmC2crBaKlE2nbSNAr55SEp2djuMauVxD
 EFm+H70Bbq9tOdLR533OcU1K5QvvX/Z4kiJrHeuGnJxmGNbl2hXxP6d15QmmrqYS/Km8Ix
 0t9zI4PITU0T+8/Q4TnhahshKSgjDeE=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-Rqehakn-OYqvOS_hY24o7w-1; Mon, 24 Jun 2024 06:23:06 -0400
X-MC-Unique: Rqehakn-OYqvOS_hY24o7w-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a725eed1cfeso23262866b.3
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2024 03:23:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719224584; x=1719829384;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dVIZiTR+Qlx7R63DABIwO7Immyiuqt5V5O4QrLSqxwM=;
 b=YkLX/xiFePp1lRNyVGx0y3nCo6sKRZVxHpwvdYEui/mjqpXd1t/Iy1/ZwKa+1uX1AN
 LhrAEnauGFpGwQQj092uOQdCj6C3veGL/pdJ1eL3HkW2uikfty9ZImEU39qiQFt7x58z
 EVQ8PTyGR3zyzVMTj50i3U0vawuQB4O8jhZ/oEy1gxlePLnX6IihtWuSzTCFwIJMZTef
 +gGsDuCjPK0CXXNHvTDlg7SxYm7ZmX7Ar0O0wFOpMhWKeS13/uhp0qdHwgPsCrbFq5n8
 88tuk9lkO1wjQ3i3dYydYyCZzvHW1WRba4tHg9PRUKuB0LYf+EJeGx0LqOk3dWNUmsMA
 uAsQ==
X-Gm-Message-State: AOJu0Yy8mhII0ORTfNOTVsj+yrmwAvReYMM569pOo6DyF/Y50AA4qBXp
 HCwCKDuSTnD5Z+4Sgamr7p5+97a5GAz1tNkMdo5rWxXrJVdoWl37ay31YcS1HPnQPpZ8/3G1Y7p
 HB0tFIpVhTWbgj6K1F0/7Ke1WSD8kwlEA8rlCOS6e2Vc9oPwMwv6JsJfUyw6cxio=
X-Received: by 2002:a17:906:99cd:b0:a72:5e95:ad46 with SMTP id
 a640c23a62f3a-a725e95ae70mr78552466b.31.1719224584271; 
 Mon, 24 Jun 2024 03:23:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH01EqJ3vLSAtqjAMtoJ2pr13lRaFFGRKNotzMXwqGJx3UqiQohJpcMC67EeXtqyPzXgP6vYg==
X-Received: by 2002:a17:906:99cd:b0:a72:5e95:ad46 with SMTP id
 a640c23a62f3a-a725e95ae70mr78549566b.31.1719224583480; 
 Mon, 24 Jun 2024 03:23:03 -0700 (PDT)
Received: from redhat.com ([2.52.146.100]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a724fe5d3a8sm133612866b.75.2024.06.24.03.23.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Jun 2024 03:23:02 -0700 (PDT)
Date: Mon, 24 Jun 2024 06:22:53 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: thomas <east.moutain.yang@gmail.com>
Cc: qemu-devel@nongnu.org, jasowang@redhat.com, qemu-stable@nongnu.org
Subject: Re: [PATCH v3] vritio-net: Notify the guest with the latest
 available idx
Message-ID: <20240624061458-mutt-send-email-mst@kernel.org>
References: <20240624081901.38956-1-east.moutain.yang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240624081901.38956-1-east.moutain.yang@gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.149,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

vritio -> virtio?

When I see a typo straight in the subject I get suspicious about
the patch itself.


On Mon, Jun 24, 2024 at 04:19:01PM +0800, thomas wrote:
> Patch 06b12970174 ("virtio-net: fix network stall under load")
> added double-check to test whether the available buffer size
> can satisfy the request or not, in case the guest has added
> some buffers to the avail ring simultaneously after the first
> check.
> 
> It will be lucky if the available buffer size becomes okay
> after the double-check, then the host can send the packet to
> the guest. If the buffer size still can't satisfy the request,
> even if the guest has added some buffers, notify the guest
> with the latest available idx seen by the host, similiar to
> the action taken by the host after the first check.

The action taken there is to enable host notifications.
And this is also what your code does.

Is this some kind of optimization? Bugfix? Can't tell from
commit log.


> Fixes: 06b12970174 ("virtio-net: fix network stall under load")
> Signed-off-by: wencheng Yang <east.moutain.yang@gmail.com>

Is this spelling with lowercase w in wencheng, intentional?


> ---

Add changelog here.


>  hw/net/virtio-net.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index 9c7e85caea..23c6c8c898 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -1654,6 +1654,7 @@ static int virtio_net_has_buffers(VirtIONetQueue *q, int bufsize)
>          if (virtio_queue_empty(q->rx_vq) ||
>              (n->mergeable_rx_bufs &&
>               !virtqueue_avail_bytes(q->rx_vq, bufsize, 0))) {
> +            virtio_queue_set_notification(q->rx_vq, 1);



I don't really understand what is going on here.
Why is the previous virtio_queue_set_notification(q->rx_vq, 1)
insufficient?




>              return 0;
>          }
>      }
> -- 
> 2.39.0


