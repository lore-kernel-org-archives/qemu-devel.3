Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4660AC531F9
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 09:45:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnCSj-0001j6-Hg; Fri, 24 Jul 2026 05:45:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wnCSc-0001hi-Ki
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 05:44:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wnCSV-0004dc-Ne
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 05:44:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784886278;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TL1dpV09gXHXK6xRcsFV3muEnvSe+yt82N35mULst6g=;
 b=UMNlAH/O3LNBcbMekUFM9+zWXQt929awSeN+LOuzCOOHkW7cUbvKvRW+b2tiZEYdr3ho7w
 Jk7PwmU74lZNmjfaSDyOnHbl9VefYP8/eo3FXde3YxSI9tMAULOM0hkV7nxRcDOcq/Dutj
 93mfD0JVhD/YySKt6f0c82O949/PSLs=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-7-MO06fY8tPV2ZzlelFl4L2A-1; Fri, 24 Jul 2026 05:44:37 -0400
X-MC-Unique: MO06fY8tPV2ZzlelFl4L2A-1
X-Mimecast-MFC-AGG-ID: MO06fY8tPV2ZzlelFl4L2A_1784886276
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-474170b59dfso216310f8f.3
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 02:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784886276; x=1785491076; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=TL1dpV09gXHXK6xRcsFV3muEnvSe+yt82N35mULst6g=;
 b=JxfDCCoEjS7xjB1j/UDpE89KddboeMP3Df+PgWD46z2ZM/F8G3Dr+KbRDwSbjb5sAv
 dMX4NEM8x6AnMQzxJ1rqybne2Gi/epCL9yvxNjjGcK2B89/Y5Sh3xmZBSKyGjyuZf7NN
 z0sppetpjESgaOwuNE3pX54JqzhrK7k+Um7LFvSQYAw4Q0osOUl0pQ5Es5saM0rm9TL7
 7xVfReCypmihmioOgkIpJv3ESvmviVyFbxb8SUPam2ccMeDt4TD1SXzLJjz+kPpsCPT+
 zroc29dzRXwd7JOd7fVR2xX9M7Nj7QQffNEGdDBVDWjfnEcCJSeY4pEXFJhOZr3bsfhA
 5CBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784886276; x=1785491076;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=TL1dpV09gXHXK6xRcsFV3muEnvSe+yt82N35mULst6g=;
 b=nCSojSLu6bs1Dn2JcBYDemNCln1nGmde9ONy/uE7a13lUn7PXnWbGin+hJc77Jdayb
 WjfMdmvBq5lZHPYjnDoKN0lzY2GkhHGEFY678lr0G7weDDCS9TAINpJEl9eTztiMn7Dv
 BRw3/RlhD03S86WasF4o4zVfVGGSiHU5uMAgVroPnS8ew/QQDdw4GgMmzrYo4KRAaOY1
 tyiMbNXPRO9nunSFs8/MavcYAKMdsSc8wU3N3NpOWSZQSSk/gVMzyr2cYu92wL/Jk9wb
 X1DUI716cDU3k85T6fqoPhQE04j/rrM5XXXvX8FBfPg7YHADUI9/ffMTRaJjJigny9ys
 S5FQ==
X-Gm-Message-State: AOJu0YwH/M5FeHNOR1kTFITs+QPNcDY0zpxjFMELO2eUWI+xoEV8rLNj
 xMMTZBogDNBD/qvoF/iqyUjuhQ8IUK5REIRk59JCLqdiG59NCCGaSDfSi8CPduXtKKQFntsz703
 itVsTz3IaHA7ZXih51y0VmrrsSaAUTrL+yi3bvfNXUX+VYFsBtHiQG0/s
X-Gm-Gg: AR+sD12/4Wd0WvOZK0lFrx3XBUePTh/l5oyWll/spWT1z+ZxlQM01Et5mVbPWeFFqhA
 nezQp5Krqtmw5/yhExZcXrM9YqK4VdFU1/8dGzyJi0hcK2IjJy+tuvNxX+C35lfgbD0hediEfPC
 YEmm7G8fNegdiMc6CAMU3n39x4TXr0AU+OH2ugofHqVw2jqu3ylgun8n+1mtfqkhgcS4u4WpbAJ
 7Lz+KqZrCb0odLAq3GBJwTn6WedqlDv2z5Q5skqAcA466aelaxgBiLEoY7aBzh5NkOPhGV4P3mH
 MOMMRj2GVAM3hAORfWj0IxO1HmAcidJQGoqwWenBI95lIYfVAYDwHMmM0CL0PaBjJRMX2QT2We3
 a9noxZaVU6iaqyh6l8XfSTw==
X-Received: by 2002:a05:6000:2904:b0:46e:624e:3c2f with SMTP id
 ffacd0b85a97d-47f8dc8565cmr8118747f8f.47.1784886275801; 
 Fri, 24 Jul 2026 02:44:35 -0700 (PDT)
X-Received: by 2002:a05:6000:2904:b0:46e:624e:3c2f with SMTP id
 ffacd0b85a97d-47f8dc8565cmr8118706f8f.47.1784886275279; 
 Fri, 24 Jul 2026 02:44:35 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-37-66.inter.net.il. [80.230.37.66])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f96d4656bsm4931053f8f.21.2026.07.24.02.44.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jul 2026 02:44:34 -0700 (PDT)
Date: Fri, 24 Jul 2026 05:44:32 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Weimin Xiong <xiongwm2026@163.com>
Cc: qemu-devel@nongnu.org, jasowang@redhat.com, virtualization@lists.linux.dev,
 Xiong Weimin <xiongweimin@kylinos.cn>
Subject: Re: [PATCH] hw/net/virtio-net: Remove dangerous cast in receive_header
Message-ID: <20260724054210-mutt-send-email-mst@kernel.org>
References: <20260724093809.810263-1-xiongwm2026@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260724093809.810263-1-xiongwm2026@163.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.951,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Jul 24, 2026 at 05:38:09PM +0800, Weimin Xiong wrote:
> From: Xiong Weimin <xiongweimin@kylinos.cn>
> 
> The receive_header() function contains a "FIXME this cast is evil"
> comment. The code does:
>     void *wbuf = (void *)buf;
> 
> This cast from 'const void *' to 'void *' removes const qualifier which
> could lead to unintended modifications.

... and so you cast to uint8_t * instead, removing const qualifier.

> Instead, use a properly typed
> pointer and pass it correctly to work_around_broken_dhclient().
> 
> Signed-off-by: Xiong Weimin <xiongweimin@kylinos.cn>
> ---
>  hw/net/virtio-net.c | 12 +++++++----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index 1234567890ab..fedcba098765 4321006
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -1716,12 +1716,14 @@ static void receive_header(VirtIONet *n, const struct iovec *iov, int iov_cnt,
>                             const void *buf, size_t size)
>  {
>      if (n->has_vnet_hdr) {
> -        /* FIXME this cast is evil */
> -        void *wbuf = (void *)buf;
> -        work_around_broken_dhclient(wbuf, wbuf + n->host_hdr_len,
> -                                    size - n->host_hdr_len);
> +        const uint8_t *wbuf = buf;
> +        uint8_t *payload = (uint8_t *)(wbuf + n->host_hdr_len);
> +

Forgive me how is this better?
what is properly typed and correctly about casting to uint8_t *?
As far as I can see all you did is remove a comment.

> +        work_around_broken_dhclient(wbuf, payload,
> +                                    size - n->host_hdr_len);
>  
>          if (n->needs_vnet_hdr_swap) {
> -            virtio_net_hdr_swap(VIRTIO_DEVICE(n), wbuf);
> +            virtio_net_hdr_swap(VIRTIO_DEVICE(n), (void *)wbuf);
>          }
>          iov_from_buf(iov, iov_cnt, 0, buf, sizeof(struct virtio_net_hdr));
>      } else {


