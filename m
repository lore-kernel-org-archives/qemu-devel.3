Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36194CA0EDC
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Aug 2025 13:18:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umXgV-0008HG-B0; Thu, 14 Aug 2025 09:07:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1umXgP-0008Dl-De
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 09:07:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1umXgK-0005qj-05
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 09:07:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755176862;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GLj1nQQEEcSjdonhvjhdb+8hgcWqHVO2AEzJvBFfDy8=;
 b=bFeFSo2Kg54qjn9vTcDim1KxxNX2gLgAAdeWgEpZMoXxNulX6RCHgfRSIUr0GRBSe5cDEh
 N+nPwSLeCBjc2iSjwLKvPyDNi19RcAddHD+Paqh+BkRd5YanvCwrBLQ2x7RZC76rWXrz5l
 MlKJKfTK24Wg/YJX2dmhgMQ69VMfBaM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-74-nEcFsDFXNUKxdsB36M8TJA-1; Thu, 14 Aug 2025 09:07:41 -0400
X-MC-Unique: nEcFsDFXNUKxdsB36M8TJA-1
X-Mimecast-MFC-AGG-ID: nEcFsDFXNUKxdsB36M8TJA_1755176855
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3b9edf5b346so525898f8f.3
 for <qemu-devel@nongnu.org>; Thu, 14 Aug 2025 06:07:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755176855; x=1755781655;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GLj1nQQEEcSjdonhvjhdb+8hgcWqHVO2AEzJvBFfDy8=;
 b=c38ckQDYrJnwPdOe33mdxTLm9U40/ZT0Hh+u2UShVstSkps11a4PiF2Zm8S+E4V1OO
 B0hPDGyjYTlWPlI22PRi5HqfveHTvvtCDWghJyN0SKg6UY5t3UEg6wW38jB3XAlFNcst
 lUJ+StIY97UK2HOaFRU/+ilw0v3S+OQAuM0m3bikMeVHy0xj520PdpwaloA1CYwq2BGM
 AERcqC4xhUYQ9DAFapJ47F99uz2ZRl36oVXMZMXpytu4i4VGNwMg+//MZqy9I4FiycrN
 vp0Ea3TBoOA+jgvGifClvXKSqBkGbQ9qCKjXAckMpFw9oLGaVA3+AsjoVi/+veBu1Ik6
 MAkg==
X-Gm-Message-State: AOJu0YxtcFVycZgZus+HJZYr5o3ZHChQWTNBdReBUmh9Kzb/CR1B1H1Q
 +55GdyU2KlMrdgYgQloR4MbMU3r8pR/JZOmDoQDKPKT5+u6RNUnrtmxtNRtUkTVS0rzvMh1hrmV
 5P5LZXwSZ0o651ZOkgY7UGKPi/heOEIE/EGJJUHKDfk+rYENQM9yp3ut9
X-Gm-Gg: ASbGnct2UGcucZUA1HwZrmKjBBusT59WjmxYatim+TDp1a9FhdMLCG2phRugA2DfMGu
 wW1jqfic5BKaTBlDI2Vp6o4JJip5uqn+irgitG9HR3KucNM8Eqkrfy+VdA3jEiHdYTG8KE6vF+r
 6TVp424IsPzNBqDnael9mm5Xxr8019lI/0b64aPNR0PF9PRNHa3f9PcGBIavK3NhUeJmdXmBGNh
 T9suYse6HS5BJsEltDLgWKywYEONztdD5Bd0V53PBowf4fEzNzds8SnZHkAyU9QdT2sPowWzuCD
 53WRN/HYPqz93jPqZhhcNt66mC3sLJHDKvk=
X-Received: by 2002:a05:6000:26d0:b0:3b8:d672:3cf8 with SMTP id
 ffacd0b85a97d-3b9fc36b10cmr2491294f8f.43.1755176855339; 
 Thu, 14 Aug 2025 06:07:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH8nWGrmfDMMbw5aUkZX0JbD7ZF70D1ILjgi3TDGW0ayStGsMyCZOjothuyvo+CakT7v+9LDw==
X-Received: by 2002:a05:6000:26d0:b0:3b8:d672:3cf8 with SMTP id
 ffacd0b85a97d-3b9fc36b10cmr2491270f8f.43.1755176854881; 
 Thu, 14 Aug 2025 06:07:34 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73d6:5500:f926:f5f2:d44c:9bbf])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b911469bffsm9739677f8f.36.2025.08.14.06.07.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Aug 2025 06:07:34 -0700 (PDT)
Date: Thu, 14 Aug 2025 09:07:32 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: gerben@altlinux.org
Cc: qemu-devel@nongnu.org, sdl.qemu@linuxtesting.org
Subject: Re: [PATCH] hw/virtio/virtio-pci: add defensive check for vector_irqfd
Message-ID: <20250814090615-mutt-send-email-mst@kernel.org>
References: <20250814110830.14660-1-gerben@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814110830.14660-1-gerben@altlinux.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Aug 14, 2025 at 02:08:08PM +0300, gerben@altlinux.org wrote:
> From: Denis Rastyogin <gerben@altlinux.org>
> 
> Add a NULL check for proxy->vector_irqfd in
> virtio_pci_one_vector_unmask() before taking the irqfd path.
> This prevents potential access to uninitialized state if
> vector_irqfd is absent.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Reported-by: Alexey Appolonov <alexey@altlinux.org>
> Signed-off-by: Denis Rastyogin <gerben@altlinux.org>


I don't really understand what this description means. defensive against
what?  found in what sense? what is the uninitialized state accessed?
when is the potential for this access?


> ---
>  hw/virtio/virtio-pci.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> index 767216d795..07904f6f9b 100644
> --- a/hw/virtio/virtio-pci.c
> +++ b/hw/virtio/virtio-pci.c
> @@ -1015,7 +1015,11 @@ static int virtio_pci_one_vector_unmask(VirtIOPCIProxy *proxy,
>              event_notifier_set(n);
>          }
>      } else {
> -        ret = kvm_virtio_pci_irqfd_use(proxy, n, vector);
> +        if (proxy->vector_irqfd) {
> +            ret = kvm_virtio_pci_irqfd_use(proxy, n, vector);
> +        } else {
> +            ret = -EFAULT;
> +        }
>      }
>      return ret;
>  }
> -- 
> 2.42.2


