Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BCB6C3DA4A
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Aug 2024 17:59:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdCq3-0005iC-GM; Sun, 11 Aug 2024 13:58:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sdCq1-0005eI-Eg
 for qemu-devel@nongnu.org; Sun, 11 Aug 2024 13:58:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sdCpw-0002BX-AP
 for qemu-devel@nongnu.org; Sun, 11 Aug 2024 13:58:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723399114;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aGNHOdcshazAF4dMMTr3JrAinoX0PZVqtcOMVlL2htA=;
 b=U1QYUsFIXBdNcF/mrAu/PR/9dKZemtELK+Eps5WfM9h2Zu3z9TMAgsFH43oawwwkj954CR
 u0o9p5Tw4wl/h4Ymn7OXi8hb0hdqqNa5W4Lve2xB3zvRJsMf87oofJNn9Blbl+CDaW4U/N
 PvnBtv6a3Xhc0H1ventzyay7BJ0kXl4=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-M4_vlL-qPYC7qR6BGRT2Wg-1; Sun, 11 Aug 2024 13:58:33 -0400
X-MC-Unique: M4_vlL-qPYC7qR6BGRT2Wg-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2ef205d48ebso32828781fa.3
 for <qemu-devel@nongnu.org>; Sun, 11 Aug 2024 10:58:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723399111; x=1724003911;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aGNHOdcshazAF4dMMTr3JrAinoX0PZVqtcOMVlL2htA=;
 b=Ha2a5JIAqUTKgs1SPAZYfnsTUPL+42drBh2xE6rJIYfdqU3NITu0+efW8fCHMnz+Dx
 mNMl6Ml+cZy4XN2abQXXQfvFfiBu3stWLYYjYgiVdD2Cf6LqgkHWKIM9Ls9QN9n/m7Dn
 PE/RYgsJbzFbBwfL+XrmgijkEvzBt5YC/svy7z/dSzvgqc+saSGfFd/ikjo1pwgtPq4w
 YGjtsAuC23e+vCqj25sSfQGl4ojlnF567/Co4xfffqRD7MsAjbRkIqD5HZXrr3ITjgwP
 G+N31IKPOIk961KLe/OQBqTHLcidixOoUgslMsRV7qPjyEXX1d5Kv/+rrESDJmmqX4Ik
 s8fg==
X-Gm-Message-State: AOJu0Yw16TcHquADfv63Pzs7+jKaQ5wDhbhAElwpcXlhRc8Mu3piGs/Q
 tWhhImg4duo2VuxFG7N7OB3lnOOVHWWH7vvJ0wFJ3FdxVa4ayR4llBonATNgVyYpUPdLvjz3NgN
 vbAdy33AEHQo+lyFi93A0FAD7bfWi2xg0srSYS8qaRY3wh2ISxLma
X-Received: by 2002:a2e:9acd:0:b0:2ef:28ee:944 with SMTP id
 38308e7fff4ca-2f1a6d05dffmr47219951fa.45.1723399111460; 
 Sun, 11 Aug 2024 10:58:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF215Z1kBRuam4Kev5v/ofahSKSI36O/knWmeTq3HzIucseaknXHnRCys7LCjipGyyQl8DjRQ==
X-Received: by 2002:a2e:9acd:0:b0:2ef:28ee:944 with SMTP id
 38308e7fff4ca-2f1a6d05dffmr47219721fa.45.1723399110216; 
 Sun, 11 Aug 2024 10:58:30 -0700 (PDT)
Received: from redhat.com ([2a02:14f:173:d1a0:5d86:9899:95ec:4118])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4290c7a38a6sm159109775e9.42.2024.08.11.10.58.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Aug 2024 10:58:29 -0700 (PDT)
Date: Sun, 11 Aug 2024 13:58:25 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: thomas <east.moutain.yang@gmail.com>
Cc: qemu-devel@nongnu.org, jasowang@redhat.com, qemu-stable@nongnu.org
Subject: Re: [PATCH v2] Update event idx if guest has made extra buffers
 during double check
Message-ID: <20240811135734-mutt-send-email-mst@kernel.org>
References: <20240617054551.20524-1-east.moutain.yang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240617054551.20524-1-east.moutain.yang@gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Mon, Jun 17, 2024 at 01:45:51PM +0800, thomas wrote:
> If guest has made some buffers available during double check,
> but the total buffer size available is lower than @bufsize,
> notify the guest with the latest available idx(event idx)
> seen by the host.
> 
> Fixes: 06b12970174 ("virtio-net: fix network stall under load")
> Signed-off-by: wencheng Yang <east.moutain.yang@gmail.com>
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


This raises a lot of questions, but first of all virtio_queue_set_notification
does not notify guest, it enables guest notifications.

>              return 0;
>          }
>      }
> -- 
> 2.39.0


