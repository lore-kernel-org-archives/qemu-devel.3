Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC91BEDE99E
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 15:23:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1so2iA-0006oh-Vy; Tue, 10 Sep 2024 11:23:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1so2i7-0006c4-2G
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 11:23:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1so2i5-0006dd-Kn
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 11:23:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725981796;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JljZTxvmUhp3Nz6zHNFQsCR8keVflmI17TtolXrS5Ks=;
 b=LXYHyUvtJKupr2Y4kpgEFX6d6Twe4nmsdV/8Idk+rNf1Jj7+pRYgshRj32DGOOFZiNnjXq
 YTc7mAvWfIDca+c7mpwJRH2pdq6cNha51kEzEe2vdffzcw1BuHlmFEAnqpaY1Lh8ShlzFK
 +2RIVLR8R04yZBZn8PyZ/YoWFQH8hmc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-600-cEEHzBcBMymVznRtgHdZiA-1; Tue, 10 Sep 2024 11:23:15 -0400
X-MC-Unique: cEEHzBcBMymVznRtgHdZiA-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-374b9a8512dso524440f8f.2
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 08:23:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725981794; x=1726586594;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JljZTxvmUhp3Nz6zHNFQsCR8keVflmI17TtolXrS5Ks=;
 b=dwp+BPN7Hvnz9YaHQOIV2Ey3y26YQShJJgGNPSdYEy4Bjr6zxTccDK/FtH9VHCV3Th
 emN9ljb4EPjVxH8QFw6jwXb/MYWCEsrcT/GXx1KLY5wR1ZDB9T7dqLFTMNnnp35/PW+d
 D64jGBXqX+Z91Sx9QuqnsfG745IT+Bv2MpjlSCGa5KFM051P0tAAutHNgmsEuLBWiw0d
 c4XKBSuFIOGYOh4iWZ8385FYzBbkP74nOYKaZ5TKHPZPnR2bBlAbWN5bxZks/SUP78ap
 yhqQo/VwWezbHyXE5Repwvhfe/NajJd9PNUtHSCjB01TJZJy7f6zIXiGF0/C3vSkIRAd
 bYAQ==
X-Gm-Message-State: AOJu0YzfhMnfHM5Hg9Tg9jg259p7yEUK+h3C82TWO/W3P4SVD4k9R1fC
 K64sCb/ExK21bmt5tvZqhlIU69HtDY9kWYYQqFYPB0tmYzpuWyFi22ic8CdnZJerxXwJs0Yuuci
 z8sIbwbVr/3VCn//3zvCCAB7ge3omvVI4OEF+k/8pw+8+vUM1j+tP
X-Received: by 2002:a5d:5747:0:b0:371:8e8b:39d4 with SMTP id
 ffacd0b85a97d-378b07c2acfmr28647f8f.28.1725981794114; 
 Tue, 10 Sep 2024 08:23:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH7MR+KZ4UXRPHqGJkIobiKBmKHEAsNHsUjBlRPpYhhvF/claXaEzTlxw6H0WgECHbijbOyPg==
X-Received: by 2002:a5d:5747:0:b0:371:8e8b:39d4 with SMTP id
 ffacd0b85a97d-378b07c2acfmr28630f8f.28.1725981793677; 
 Tue, 10 Sep 2024 08:23:13 -0700 (PDT)
Received: from redhat.com ([31.187.78.63]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42caeb81ac0sm117557015e9.34.2024.09.10.08.23.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2024 08:23:13 -0700 (PDT)
Date: Tue, 10 Sep 2024 11:23:08 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: luzhixing12345 <luzhixing12345@gmail.com>
Cc: qemu-devel@nongnu.org, Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH] vhost-user: add NEED_REPLY flag
Message-ID: <20240910112301-mutt-send-email-mst@kernel.org>
References: <20240804154859.28342-1-luzhixing12345@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240804154859.28342-1-luzhixing12345@gmail.com>
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

On Sun, Aug 04, 2024 at 11:48:59PM +0800, luzhixing12345 wrote:
> Front-end message requests which need reply should set NEED_REPLY_MASK
> in flag, and response from slave need clear NEED_REPLY_MASK flag.


neither this.

> ---
>  hw/virtio/vhost-user.c                    | 2 +-
>  subprojects/libvhost-user/libvhost-user.c | 1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> index 00561daa06..edf2271e0a 100644
> --- a/hw/virtio/vhost-user.c
> +++ b/hw/virtio/vhost-user.c
> @@ -1082,7 +1082,7 @@ static int vhost_user_get_u64(struct vhost_dev *dev, int request, uint64_t *u64)
>      int ret;
>      VhostUserMsg msg = {
>          .hdr.request = request,
> -        .hdr.flags = VHOST_USER_VERSION,
> +        .hdr.flags = VHOST_USER_VERSION | VHOST_USER_NEED_REPLY_MASK,
>      };
>  
>      if (vhost_user_per_device_request(request) && dev->vq_index != 0) {
> diff --git a/subprojects/libvhost-user/libvhost-user.c b/subprojects/libvhost-user/libvhost-user.c
> index 9c630c2170..40f665bd7f 100644
> --- a/subprojects/libvhost-user/libvhost-user.c
> +++ b/subprojects/libvhost-user/libvhost-user.c
> @@ -667,6 +667,7 @@ vu_send_reply(VuDev *dev, int conn_fd, VhostUserMsg *vmsg)
>  {
>      /* Set the version in the flags when sending the reply */
>      vmsg->flags &= ~VHOST_USER_VERSION_MASK;
> +    vmsg->flags &= ~VHOST_USER_NEED_REPLY_MASK;
>      vmsg->flags |= VHOST_USER_VERSION;
>      vmsg->flags |= VHOST_USER_REPLY_MASK;
>  
> -- 
> 2.34.1


