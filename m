Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D125EC27C77
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2024 02:16:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJ1ub-000083-9t; Sun, 16 Jun 2024 22:16:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1sJ1uY-00007p-Tu
 for qemu-devel@nongnu.org; Sun, 16 Jun 2024 22:15:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1sJ1uX-0002AO-5N
 for qemu-devel@nongnu.org; Sun, 16 Jun 2024 22:15:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718590554;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7TN/eUiCgwj3ZhEt2U35zTMZwaCRvnqrwDgnkVbHQqA=;
 b=AHRTuPFUCg7ZPL94HLxMBblIMjEW2UgC4cdZXw4WpBqqBKgdneZIuZcOEw0yMZgiV5hB6X
 /tJL3bSG+GMRsVBksAV1TSg3R/H+aBj1AxHjlnfpkYgd1lX9qU3i5RIIgwCEBHdtMhI9lc
 d4VAMp5iURyrVe+H2G2ynrsGmtCQF34=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-602-MLbYJBTBOBi3-7GY3_fzUw-1; Sun, 16 Jun 2024 22:15:49 -0400
X-MC-Unique: MLbYJBTBOBi3-7GY3_fzUw-1
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-2c2e6321120so3870061a91.3
 for <qemu-devel@nongnu.org>; Sun, 16 Jun 2024 19:15:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718590548; x=1719195348;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7TN/eUiCgwj3ZhEt2U35zTMZwaCRvnqrwDgnkVbHQqA=;
 b=tnAxUdY1rA9s3S5uwQHlLhgnIxIBwe6lRQ2tE4/NKbAxgFA+HuQfedh1tCOPLwPdgK
 o6fIJRWWjKoVok8x5RkVAMQCRCaujpInHNYJf+2hopuqQNcbqe/i2p6+BaYwvs9aIVgi
 +rkcE4MFNe83Pdyln8lqNmfcZIzDQhQMi0QUKCsJ+vtXiafn+WZGBa90Dr5aCODxV4vd
 o0ORiwIv4aeS8pI9PYWPYcnBNdfQFYArt0i0d2FO1RMlUCKFmpAmiMCfY5ZQ9IWq3Zjv
 7sn7KY38GEVTRDHR1GiNM1q+2kkvXfJeq/kaR9AMG4Ep47jig1Csf5Y7r7bUS1GlrsQE
 kV6w==
X-Gm-Message-State: AOJu0YyYaEfHSH9r9DEv3EvIe8xjT01znE55icP1RmFaBzWKj6iJlzrT
 pJel81SCLPPyvNkna/gbuhODiZfsfjm1sHfKRmieA353TKx7Pnk4YOinFS54YfQTPh7RQYw67VN
 0rigtROEdJ0CQ7Ya9nSDYpkq+lp3lj/ZOVz0ziV/WD67ZIM0OSuDv71FYPGjVMTtTW2kn/qaEac
 15NPUVjgWm3cQTRps6HNllYrWAg/s=
X-Received: by 2002:a17:90a:1542:b0:2c0:f62:7b88 with SMTP id
 98e67ed59e1d1-2c4db44b9dfmr7216837a91.25.1718590548250; 
 Sun, 16 Jun 2024 19:15:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHBmvPtRk5XCvXE3otD+pf940DcUuMOYScszVkhWp6rXMWXoNQZVAoNA7nT8j70VhFsgSC7AbKJ+WzARrUUsLY=
X-Received: by 2002:a17:90a:1542:b0:2c0:f62:7b88 with SMTP id
 98e67ed59e1d1-2c4db44b9dfmr7216819a91.25.1718590547544; Sun, 16 Jun 2024
 19:15:47 -0700 (PDT)
MIME-Version: 1.0
References: <20240613022147.5886-1-east.moutain.yang@gmail.com>
In-Reply-To: <20240613022147.5886-1-east.moutain.yang@gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 17 Jun 2024 10:15:36 +0800
Message-ID: <CACGkMEssgrnF5tnJpzjd0NEu-G9qQdcyv7KsDjOmvLhUQkqUAQ@mail.gmail.com>
Subject: Re: [PATCH] Update event idx if guest has made extra buffers during
 double check
To: thomas <east.moutain.yang@gmail.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
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

On Thu, Jun 13, 2024 at 10:22=E2=80=AFAM thomas <east.moutain.yang@gmail.co=
m> wrote:
>
> Fixes: 06b12970174 ("virtio-net: fix network stall under load")
>
> If guest has made some buffers available during double check,
> but the total buffer size available is lower than @bufsize,
> notify the guest with the latest available idx(event idx)
> seen by the host.
> ---
>  hw/net/virtio-net.c | 1 +
>  1 file changed, 1 insertion(+)

Patch looks good to me, but it misses some other stuff for example:

- the sob tag.
- fixes should be placed above sob tag
- need to cc qemu-stable@nongnu.org

Thanks

>
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index 9c7e85caea..23c6c8c898 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -1654,6 +1654,7 @@ static int virtio_net_has_buffers(VirtIONetQueue *q=
, int bufsize)
>          if (virtio_queue_empty(q->rx_vq) ||
>              (n->mergeable_rx_bufs &&
>               !virtqueue_avail_bytes(q->rx_vq, bufsize, 0))) {
> +            virtio_queue_set_notification(q->rx_vq, 1);
>              return 0;
>          }
>      }
> --
> 2.39.0
>


