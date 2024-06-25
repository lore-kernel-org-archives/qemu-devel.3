Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D47AC2BBCA
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2024 10:17:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sM3F5-0006Xs-BR; Tue, 25 Jun 2024 06:17:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sM3F3-0006Oq-Hk
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 06:17:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sM3F1-0008Vi-Dr
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 06:17:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719310654;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HjjMZRDpI/TurhAHE3z1bjMsD39H6l6A2bWBNBCwBuE=;
 b=EUydHv/BJl53wAzBas6ByDMTD8+Ee4FdvDKCFBVVwgd21djz7BZakpdZJbzxEieT8/AKZV
 nmfn8MIme7uW8m4ufjLuOTHL7fiiouje6NcQ6HHyCO1gmXsy/LjzoHYvYbIINsxGaxnFVO
 lnNdDF43CuuGQiO4U66BWYfjEa9zX8I=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-330-5yxiQLWEONGgW55B3KG1nA-1; Tue, 25 Jun 2024 06:17:31 -0400
X-MC-Unique: 5yxiQLWEONGgW55B3KG1nA-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2ec68c1bf62so5097991fa.3
 for <qemu-devel@nongnu.org>; Tue, 25 Jun 2024 03:17:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719310650; x=1719915450;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HjjMZRDpI/TurhAHE3z1bjMsD39H6l6A2bWBNBCwBuE=;
 b=XhXou+iw92QL8RU8tY6KsBsUKMo9D4qX9NlJ2dz875E3PmwMjhvaN9B1kyc+ueJLGX
 HvJwbrDRj0FSicClaZpkU1iSyqDeyZcHTMJcKIvBfHUWuLqIunZJD1KgbV6uBmZk/SII
 mnjMU/xM+o6frTEmToDwvjQwdRxABBKT2jsMEKxnXHcVR6dRENDV4atKVBakUe4ec9B4
 DLjben5+48LpbUgxvg+31zCAU7V1c0YYcX+2SKiVAtU1c4etIuUWDn7WJOgynSkwC3Nt
 ZrTj2Ks+qVA9zIpEoPIKXTtCB+bnktlXheIT0JZGk3pcNU5GcPzwqvBGSqJY6Bof6Z8E
 sC3g==
X-Gm-Message-State: AOJu0YzgKn7vKsIzxwy9Ek8iC9nVsykYq6hGFJS2AUnf6bAiq5uUAsdN
 124n/ap5d16noJnhBSMA2V7HQMumMgujBE4WaN0zpcg601ilFfXJxgmBHCY1NbvsmTDNx2jzBel
 cmw9DvlBxkHOK7Zvef3726j7DGxgsQKdS5t3o97eI7W6gzCYepwRH
X-Received: by 2002:a2e:81d4:0:b0:2ec:4f83:750 with SMTP id
 38308e7fff4ca-2ec5b2e9082mr39471661fa.45.1719310650191; 
 Tue, 25 Jun 2024 03:17:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEHByfw2Cmgp2VGYWd5LSlNDDpLRVDR9DwrSKJF/tSDj4D8kMeJ16bj7H/ZI4SyjzVo4tuvow==
X-Received: by 2002:a2e:81d4:0:b0:2ec:4f83:750 with SMTP id
 38308e7fff4ca-2ec5b2e9082mr39471301fa.45.1719310649336; 
 Tue, 25 Jun 2024 03:17:29 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:342:f1b5:a48c:a59a:c1d6:8d0a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4248482f1c4sm152313325e9.10.2024.06.25.03.17.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Jun 2024 03:17:28 -0700 (PDT)
Date: Tue, 25 Jun 2024 06:17:24 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Wencheng Yang <east.moutain.yang@gmail.com>
Cc: qemu-devel@nongnu.org, jasowang@redhat.com, qemu-stable@nongnu.org
Subject: Re: [PATCH v4] virtio-net: Notify the guest with the latest
 available idx
Message-ID: <20240625061013-mutt-send-email-mst@kernel.org>
References: <20240625094851.5252-1-east.moutain.yang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240625094851.5252-1-east.moutain.yang@gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.207,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Jun 25, 2024 at 05:48:51PM +0800, Wencheng Yang wrote:
> From: thomas <east.moutain.yang@gmail.com>
> 
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
> the action taken by the host after the first check, else
> viritio-net would stall at the host side forever.
> 
> The case below can reproduce the stall.
> 
>                                        Guest 0
>                                      +--------+
>                                      | iperf  |
>                     ---------------> | server |
>          Host       |                +--------+
>        +--------+   |                    ...
>        | iperf  |----
>        | client |----                  Guest n
>        +--------+   |                +--------+
>                     |                | iperf  |
>                     ---------------> | server |
>                                      +--------+
> 
> Boot many guests from qemu with virtio network:
>  qemu ... -netdev tap,id=net_x \
>     -device virtio-net-pci-non-transitional,\
>     iommu_platform=on,mac=xx:xx:xx:xx:xx:xx,netdev=net_x
> 
> Each guest acts as iperf server with commands below:
>  iperf3 -s -D -i 10 -p 8001
>  iperf3 -s -D -i 10 -p 8002
> 
> The host as iperf client:
>  iperf3 -c guest_IP -p 8001 -i 30 -w 256k -P 20 -t 40000
>  iperf3 -c guest_IP -p 8002 -i 30 -w 256k -P 20 -t 40000
> 
> After some time, the host loses connection to the guest,
> the guest can send packet to the host, but can't receive
> packet from host.
> 
> It's more likely to happen if SWIOTLB is enabled in the guest,
> allocating and freeing bounce buffer takes some CPU ticks,
> copying from/to bounce buffer takes more CPU ticks, compared
> with that there is no bounce buffer in the guest.
> Once the rate of producing packets from the host approximates
> the rate of receiveing packets in the guest, the guest would
> loop in NAPI.
> 
>          receive packets    ---
>                |             |
>                v             |
>            free buf      virtnet_poll
>                |             |
>                v             |
>      add buf to avail ring  ---
>                |
>                |  need kick the host?
>                |  NAPI continues
>                v
>          receive packets    ---
>                |             |
>                v             |
>            free buf      virtnet_poll
>                |             |
>                v             |
>      add buf to avail ring  ---
>                |
>                v
>               ...           ...
> 
> On the other hand, the host fetches free buf from avail
> ring, if the buf in the avail ring is not enough, the
> host notifies the guest the event by writing the avail
> idx read from avail ring to the event idx of used ring,
> then the host goes to sleep, waiting for the kick signal
> from the guest.
> 
> Once the guest finds the host is waiting for kick singal
> (in virtqueue_kick_prepare_split()), it kicks the host.
> 
> The host may stall forever at the sequences below:
> 
>          Host                        Guest
>      ------------                 -----------
>  fetch buf, send packet           receive packet ---
>          ...                          ...         |
>  fetch buf, send packet             add buf       |
>          ...                        add buf   virtnet_poll
>     buf not enough      avail idx-> add buf       |
>     read avail idx                  add buf       |
>                                     add buf      ---
>                                   receive packet ---
>     write event idx                   ...         |
>     waiting for kick                 add buf   virtnet_poll
>                                       ...         |
>                                                  ---
>                                  no more packet, exit NAPI
> 
> In the first loop of NAPI above, indicated in the range of
> virtnet_poll above, the host is sending packets while the
> guest is receiving packets and adding buf.
>  step 1: The buf is not enough, for example, a big packet
>          needs 5 buf, but the available buf count is 3.
>          The host read current avail idx.
>  step 2: The guest adds some buf, then checks whether the
>          host is waiting for kick signal, not at this time.
>          The used ring is not empty, the guest continues
>          the second loop of NAPI.
>  step 3: The host write the avail idx readed from avail
>          ring to used ring as event idx via
>          virtio_queue_set_notification(q->rx_vq, 1).
>  step 4: At the end of the second loop of NAPI, recheck
>          whether kick is needed, as the event idx in the
>          used ring written by the host is beyound the
>          range of kick condition, the guest will not
>          send kick signal to the host.
> 
> The patch notifies the guest with the latest avail idx seen
> by the host in the double-check, which increases the
> probability of hitting kick condition, but logically
> speaking, it can't resolve the issue. It's kind of
> optimization agianst patch 06b12970174.

So let's try to resolve the issue instead.

> Changelog:
> v4:
> - Correct spelling mistake in the subject
> - Describe the issue that virtio-net is blocked at host side
> 
> v3:
> - Add virtio-net tag in the subject
> - Refine commit log
> 
> v2:
> - Add SOB tag at the end of the commit message
> - Place Fixes tag at the end of the commit message
> 
> v1:
> - Initial patch
> 
> Fixes: 06b12970174 ("virtio-net: fix network stall under load")
> Signed-off-by: Wencheng Yang <east.moutain.yang@gmail.com>
> ---
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
>              return 0;
>          }


Fundamentally, this is why e.g. vhost_enable_notify is a bool
and callers do things like:

                        ... if (unlikely(vhost_enable_notify(&net->dev, vq))) {
                                vhost_disable_notify(&net->dev, vq);
                                continue;
                        }       
                        break;




>      }
> -- 
> 2.39.0


