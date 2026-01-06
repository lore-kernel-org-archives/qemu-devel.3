Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2557BCDC188
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Jan 2026 12:37:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vd6Ix-0002Oy-ET; Tue, 06 Jan 2026 07:36:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vd6ID-00023c-Ke
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 07:36:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vd6IB-00083q-C1
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 07:36:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767702961;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NlIz06HimcRKrcTL59LtIUjVhECwh7CIycf4p26cex0=;
 b=Ru918cJI1UGF3WSqfoWr+Tjp32finSJ/jUtdBvXOlOvQopDIDCRlrNs5K+4kuMRbkGryg3
 xr5z7HSr+kbTt3FCFm34fhKl3IRpLiZyq71Cc8XQ2lD+90LnRcMJPICjgfPXftKg1B5htH
 xXs6akB/vrEx5aGx76Ej/v136vqXkeE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-284-0A1Vyr_dOIOsGpVHqfttUA-1; Tue, 06 Jan 2026 07:36:00 -0500
X-MC-Unique: 0A1Vyr_dOIOsGpVHqfttUA-1
X-Mimecast-MFC-AGG-ID: 0A1Vyr_dOIOsGpVHqfttUA_1767702959
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4775e00b16fso6066555e9.2
 for <qemu-devel@nongnu.org>; Tue, 06 Jan 2026 04:35:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1767702959; x=1768307759; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=NlIz06HimcRKrcTL59LtIUjVhECwh7CIycf4p26cex0=;
 b=iv4NXeQIOaUUXZKYtXAr54+9vJbb9Wh6p1AMT4dJIJSveHa3QKiqDw0xfsb+n/u614
 WdPWlG9v45wMDka5YtbN+FnHMRq5Z/udGy1BFHML0QapBa2OXQwaaov1AUOpprvrZ+ez
 XX5fd8o8Y5H3E4rpemBEQAMO+f0yn5tH3Hav7vwbd2hYq7pXjNKTDWIb/6o0+/Lxao14
 2/G4vCzAgw/CyxDJPz15T+odglkm/VLALmd+FWHJSg690SYzDfkYf8CRnM7fBd/XDOJP
 oWuSt+MmynwDahipVDQyjKe6qOqFKlnZCk2YIrXrTQPRq6VsrGTosTslX5IvSwgsuJ9j
 N/lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767702959; x=1768307759;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NlIz06HimcRKrcTL59LtIUjVhECwh7CIycf4p26cex0=;
 b=DS4NDQku/DgVqlHh4qsgmzmbabzzwGSXneLuwkFDPWGjut52DMlhTbPdkbdjFYC1pQ
 /9ZVigAZtLAvk/N8BDOgWJ878DATD7GhojJoQRPR2XTvCRXA7chtMpux7EQ0Z4q+z3Lg
 4MQVrNhdliL3AKeucrpokxYLJIfVwOG5czu9TlR9OTZy/k8UvfHxQ9iqgR0BGq3AWCyh
 EQibNUj4HOfa4W6XN4wBfS37XrZqVk8m3M0MtQM6CZIv7/3WXmUfBK6quwEexZNSx66s
 NDFo7H/LzinVugcjP6RAxB464J5plmE1gcrJRG4EPS46tC98HNU/GFFOuw8wEmOlvgU7
 hRZQ==
X-Gm-Message-State: AOJu0YzK/6kroupgSYD9hIy1h2JGK7HLdVTMeaY1zpTRY4DuGLLSyJBG
 WdMJ+JTaRjkqtLlY1kmPPI07V7QlFaTrrLDT5WsTdW4pe+pnb2j+KZgb1YRP+HB+BGZCpoCG5SJ
 nVeQVVNVC995etvFYExUAdjrG6DgZmmZg4rXEUOJxD2fJ13bQ4rvqtFOl
X-Gm-Gg: AY/fxX7GFj5vS6YKpe7+tK56FKxBF0JAUMsSahu74gVqUWGWcjWSdWm2z566OCsLObB
 GmYAag1eSI5KpqwrQU1PHqdx2dKMutL3p1Zk4Zr8RxRm7XLA0PfY0VibENlqz2aeLieSLoHxmoA
 4AlFK+KRwL6hmKm2+bP78ruygradbaUVnxXCfgQU8M8LDKGgWoQTbpJz2pTpI0GcomJl/pVB1hD
 lwKe7hfaTeWImckJHHrBXP6MiAllL7QFrpKln+GTeKT8Zg+tIMxz+M6hjdRNnamYllTbSUGnbcU
 VVFE/mcqBIj9PaB6aNHr73Ynldo6dOMdILGuYpN7E/0PFAiEYC+Tvv1XdMVvneSh2xuO0KUxN8D
 saX2QA3mW3SfvJZ1MGU445rB6sugh6bPcsg==
X-Received: by 2002:a05:600c:138f:b0:471:700:f281 with SMTP id
 5b1f17b1804b1-47d7f09ab57mr28571445e9.25.1767702958649; 
 Tue, 06 Jan 2026 04:35:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHfCrkXPywX5t3tgo5jHdzvpn188uxPRCsKOOvDem9Q4wZYtMVglnbBx5ZiZWRSub1NpJoaMg==
X-Received: by 2002:a05:600c:138f:b0:471:700:f281 with SMTP id
 5b1f17b1804b1-47d7f09ab57mr28571095e9.25.1767702957967; 
 Tue, 06 Jan 2026 04:35:57 -0800 (PST)
Received: from redhat.com (IGLD-80-230-31-118.inter.net.il. [80.230.31.118])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd5df90dsm4029383f8f.20.2026.01.06.04.35.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jan 2026 04:35:57 -0800 (PST)
Date: Tue, 6 Jan 2026 07:35:55 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Li Chen <me@linux.beauty>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH] virtio-pmem: ignore empty queue notifications
Message-ID: <20260106073549-mutt-send-email-mst@kernel.org>
References: <20260106083859.380338-1-me@linux.beauty>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260106083859.380338-1-me@linux.beauty>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Jan 06, 2026 at 04:38:59PM +0800, Li Chen wrote:
> From: Li Chen <chenl311@chinatelecom.cn>
> 
> virtio_pmem_flush() treats a NULL return from virtqueue_pop() as a fatal
> error and calls virtio_error(), which puts the device into NEEDS_RESET.
> 
> However, virtqueue handlers can be invoked when no element is available,
> so an empty queue should be handled as a benign no-op.
> 
> With a Linux guest this avoids spurious NEEDS_RESET and the resulting
> -EIO propagation (e.g. EXT4 journal abort and remount-ro).
> 
> Signed-off-by: Li Chen <me@linux.beauty>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  hw/virtio/virtio-pmem.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/hw/virtio/virtio-pmem.c b/hw/virtio/virtio-pmem.c
> index 3416ea1827..cec1072f78 100644
> --- a/hw/virtio/virtio-pmem.c
> +++ b/hw/virtio/virtio-pmem.c
> @@ -74,7 +74,6 @@ static void virtio_pmem_flush(VirtIODevice *vdev, VirtQueue *vq)
>      trace_virtio_pmem_flush_request();
>      req_data = virtqueue_pop(vq, sizeof(VirtIODeviceRequest));
>      if (!req_data) {
> -        virtio_error(vdev, "virtio-pmem missing request data");
>          return;
>      }
>  
> -- 
> 2.52.0


