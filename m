Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92661C2BA18
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2024 10:58:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJA4N-000780-UR; Mon, 17 Jun 2024 06:58:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sJA4M-00070p-E6
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 06:58:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sJA4L-0005uU-06
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 06:58:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718621916;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=w9ZEY4Zm57McpSA5gMMj7hz21FwAAHw2tzbtYnspPfk=;
 b=B/WXp7GV21E4ZReWU+mQjQxjCyDNkgM+jDf2XrPHhnwBSez28CdvsLndFXZ9vhK3J3fZPi
 PyjgfRZu1yAmk4acgdCMyXNFEuydNZ4zV4+bZNheAUAOaQ00m7busoGtUJ50LFv2EIFXxB
 7r6l8JwM52qO1IP/uB+4COdYfPRtrcQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-240-IJtBBBK-NcG-Kq2fxghAhA-1; Mon, 17 Jun 2024 06:58:34 -0400
X-MC-Unique: IJtBBBK-NcG-Kq2fxghAhA-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4218447b900so22885875e9.0
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2024 03:58:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718621913; x=1719226713;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w9ZEY4Zm57McpSA5gMMj7hz21FwAAHw2tzbtYnspPfk=;
 b=mIdOg5B9DiAVjwDmOQP2EQiBac7lSgh/Xggk9jDogHwokFMhd+O2BiBJl1SROImlS8
 MT73ktJYkRGwkx3hCUX3+7sP3lx/pdYZrq9IxNts2VVLRhqp13YWi+DjEjM2UFlBQfzB
 tTjPTM6Su/DVg0eeyfHmgYJGsSB5I/E+6Mkjkruhs5GoIPrAu1nQ8Kn2i8PdlUwdCskv
 z+LBA7KuIP9HgzG9vFmMUb9kkgquu5jMYF8ODyrQK5mo2k1FXtMkhS/bDa2bD1NB6w6U
 Oa0iFfDvahgeS1omlhVFuRquL6XH3myu0pUO6iii9iwBJpiSfsVBRL+uahilLnss9NST
 3mGg==
X-Gm-Message-State: AOJu0YyO67T7rDi9ucJ0SQ22UWAB9xXqNRLrzl7x+cL5ZUb/c1PakDoU
 9rA28BOsYUhD9vZ7qFmSf2wlsq3jFBZJ8UH+MRVByALc8Y4NdFjLrn399IFihk+SZcI/kLiYpWN
 gLa5xbfpUGiSTmSNZoKpCmF/vvoI6ZZRsbYhj6wbvolTQeLJyWmh6
X-Received: by 2002:a05:600c:19cf:b0:421:7ab8:59c with SMTP id
 5b1f17b1804b1-42304825ce7mr95571695e9.10.1718621913283; 
 Mon, 17 Jun 2024 03:58:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGWNAQlprCMZ2zyTQPs9+3Vit/mO3H3fVRmjmGcDtVtCKO/Rh3F2H6hN/yKU22+yGZqBY8PbQ==
X-Received: by 2002:a05:600c:19cf:b0:421:7ab8:59c with SMTP id
 5b1f17b1804b1-42304825ce7mr95571465e9.10.1718621912720; 
 Mon, 17 Jun 2024 03:58:32 -0700 (PDT)
Received: from redhat.com ([2a06:c701:741d:ed00:9efe:886c:c2d8:ae8c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-422f5f33c38sm157444095e9.9.2024.06.17.03.58.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Jun 2024 03:58:32 -0700 (PDT)
Date: Mon, 17 Jun 2024 06:58:29 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: thomas <east.moutain.yang@gmail.com>
Cc: qemu-devel@nongnu.org, jasowang@redhat.com
Subject: Re: [PATCH] Update event idx if guest has made extra buffers during
 double check
Message-ID: <20240617065455-mutt-send-email-mst@kernel.org>
References: <20240613022147.5886-1-east.moutain.yang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240613022147.5886-1-east.moutain.yang@gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.148,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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


Thanks for the patch!
Yet something to improve:



subject should list the affected component, and be shorter.

On Thu, Jun 13, 2024 at 10:21:47AM +0800, thomas wrote:
> Fixes: 06b12970174 ("virtio-net: fix network stall under load")

this should come at the end. and what exactly does this
refer to? did this commit cause a regression of some sort?

> If guest has made some buffers available during double check,

what does "double check" refer to?

> but the total buffer size available is lower than @bufsize,
> notify the guest with the latest available idx(event idx)
> seen by the host.

which makes sense why?  And which changes the correct behavious of what
to a new behaviour of what which is better why?

Pls review docs/devel/submitting-a-patch.rst and follow the
process there.



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
>      }
> -- 
> 2.39.0


