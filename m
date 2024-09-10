Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29170ECE564
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 14:43:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1so25T-0000Oy-N1; Tue, 10 Sep 2024 10:43:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1so25S-0000Ga-5B
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 10:43:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1so25Q-0002YL-Mv
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 10:43:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725979399;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iaxymj/5RWEY6MbKbDAOsDczsd5ilYHexuE+AqaYT/k=;
 b=BjSeevzh6LRLN/VmiP41atUbDHVV1GlmcjMT9fJkQWbLYxupdr9fRHzBFIaGoamHDLQCmJ
 ngPf8E69qhTYl7rp+FZH4PJMo81t40hNmV7ejMzOQJowZxfIUaJdJ+gk5q02KcVN1/ioSw
 Ylk55xeQtofpVALc8XTNZ75c4mWD/eE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-292-oFr3vvQyPqKG7C2pCoZnGA-1; Tue, 10 Sep 2024 10:43:18 -0400
X-MC-Unique: oFr3vvQyPqKG7C2pCoZnGA-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-374bb1e931cso3301143f8f.0
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 07:43:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725979397; x=1726584197;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iaxymj/5RWEY6MbKbDAOsDczsd5ilYHexuE+AqaYT/k=;
 b=EVnLn4v3x98v1QBquG6ey+WLg3AF/YU8wVKchAG0kuaGZnQJbY3cdBe5kw9hCVVjZV
 3mps7hjWYpz409gpKfPEW+rCx1Q6+XOxs/m7Ka5wVENvLbmoIM3xR8MHg+P7IC+hV3PN
 tKgpT1m32naFap01KxifKCVOEGKD1bDWFkwYEqQGWvLadnWdtd/7UxqktaoNF7QmEdI6
 XDDRo8TuyLZ4eqagnUeW0jtCUXOR0ifQu9LeMf4xLDf4EUG695nfa4j899E+TqCIsqau
 L6Jp/qhQQ0F3/udCay3VEvwcEFOHzfNynUuB3tp6+nYPcTfnvFdiQitex2Bj7PV6uArF
 pFhA==
X-Gm-Message-State: AOJu0Yw8Dh27e7siZPzcSb1qYAULP2hUMt8odxe6ntSHYE6mutV0um1K
 MtotCGLTtgN1ykuRPrPyWAVtY7mg190wNj+7ZVWUfr0hPg8dIPB9+Qglgdxu7IiL1/CzSeAItlH
 pUf2yiFoMGOkx7LqrbZzZHFAdQg5BQQtBd5Xo/qh/oknu7fHqciIW8duWwN/6
X-Received: by 2002:adf:e9d2:0:b0:374:c613:7c58 with SMTP id
 ffacd0b85a97d-378a8ab1658mr2166705f8f.29.1725979396663; 
 Tue, 10 Sep 2024 07:43:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGmH3YX9rHuUj/0QkTMx3/d8v3sHc6CYpgJjJ/rUT+yjIevlJE7B2J1iaLDp03jgWecM1zAiw==
X-Received: by 2002:adf:e9d2:0:b0:374:c613:7c58 with SMTP id
 ffacd0b85a97d-378a8ab1658mr2166681f8f.29.1725979395722; 
 Tue, 10 Sep 2024 07:43:15 -0700 (PDT)
Received: from redhat.com ([31.187.78.63]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42caeb32318sm113051955e9.17.2024.09.10.07.43.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2024 07:43:15 -0700 (PDT)
Date: Tue, 10 Sep 2024 10:43:11 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: BillXiang <xiangwencheng@dayudpu.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v3] vhost-user: Do not wait for reply for not sent
 VHOST_USER_SET_LOG_BASE
Message-ID: <20240910104133-mutt-send-email-mst@kernel.org>
References: <20240801124540.38774-1-xiangwencheng@dayudpu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240801124540.38774-1-xiangwencheng@dayudpu.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Aug 01, 2024 at 08:45:40PM +0800, BillXiang wrote:
> From: BillXiang <xiangwencheng@dayudpu.com>
> 
> Currently, we have added VHOST_USER_SET_LOG_BASE to 
> vhost_user_per_device_request in commit 7c211eb078c4 
> ("vhost-user: Skip unnecessary duplicated VHOST_USER_SET_LOG_BASE requests"), 
> as a result, VHOST_USER_SET_LOG_BASE will be sent only once 
> when 'vq_index == 0'.
> In this patch we add the check of 'vq_index == 0' before 
> vhost_user_read, such that we do not wait for reply for not
> sent VHOST_USER_SET_LOG_BASE.
> 
> Signed-off-by: BillXiang <xiangwencheng@dayudpu.com>

If you still want this in, pls rewrite the commit log to make
it clear wat is going on: e.g. "cleanup X which does not do
Y with Z, which does" and repost.


> ---
>  hw/virtio/vhost-user.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> index 00561daa06..fd12992d15 100644
> --- a/hw/virtio/vhost-user.c
> +++ b/hw/virtio/vhost-user.c
> @@ -460,7 +460,7 @@ static int vhost_user_set_log_base(struct vhost_dev *dev, uint64_t base,
>          return ret;
>      }
>  
> -    if (shmfd) {
> +    if (shmfd && (dev->vq_index == 0)) {
>          msg.hdr.size = 0;
>          ret = vhost_user_read(dev, &msg);
>          if (ret < 0) {
> -- 
> 2.30.0


