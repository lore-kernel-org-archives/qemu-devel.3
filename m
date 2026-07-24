Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95F0BC531FA
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 09:52:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnCZU-0001OP-0W; Fri, 24 Jul 2026 05:52:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wnCZP-0001NR-FH
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 05:51:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wnCZN-0005fS-SA
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 05:51:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784886712;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8xJccMLa4FmRiVUO+x8NEGZ9FoH9xLMn2hB1XoGoPlM=;
 b=O4ucLXRmobnl0SJoc5uJ/CqCB7+lK38Cq8pi5sZeeFBa/+GuXtwajdqouiszfw441qtgsI
 NbMpW9+hsbHeqbEQKknYgKH8WJnXY7uLi/O5N/+/7Nk8R7oJwBGLse7ilFA/w9js6382Xd
 mgUH7rSv71EH9oQpWyLAhWriGaA8xDw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-A0omO4C6OtKuHsy4bAorJQ-1; Fri, 24 Jul 2026 05:51:51 -0400
X-MC-Unique: A0omO4C6OtKuHsy4bAorJQ-1
X-Mimecast-MFC-AGG-ID: A0omO4C6OtKuHsy4bAorJQ_1784886710
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4957287363bso2057435e9.0
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 02:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784886710; x=1785491510; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=8xJccMLa4FmRiVUO+x8NEGZ9FoH9xLMn2hB1XoGoPlM=;
 b=nAkvaYRXDs+3glY57O6EPmKF1QQ+4CDygs/z7FsO4WcozZUZNdk9+IjMjoWGx32Umy
 BNJT8uvro3C/C4Z9vvg1CSccPJLP9O3VtAW4eME7XAA6WJypxrQvTcfV+bubNxsoi0f6
 G8xpMvWgxqNjONJG6Z/l/J/uP9hHj29/zE12JZ8ExDqTGwJ+fQGnIl0ieMz+rfObU4Rk
 5yF43N3bHUxdkwHdiR+ZWavBxy94AfV11mp0fEqw+VJ1ti6ngOLVDH2zlEnknFDZ96ss
 BCu7hYnfaBNLu/Rez2OfL0MZZqdN2/SqklTm0JtSj0NtqMYPu9EgWeGFUts7ditXaSxY
 AoZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784886710; x=1785491510;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8xJccMLa4FmRiVUO+x8NEGZ9FoH9xLMn2hB1XoGoPlM=;
 b=oeY15sreN1putzFaqBSQElqGc8/n6GwDspPaapfhHYhJtgTLZiYOUe/6bWYQRkqHgh
 IWJI/QYCGK8F/Jeh6LR6w2BOCR8iVrODhUtaVQVy9UNDM2GHHm+W55HEPZtDwchbw5I3
 5nvh/y7zxmmPu+ihr3rZzM8AP93ZF/yqjH6XtMJYNCdsOku+D00yPBCga0hwlLgRF86o
 smAHnZEtpPnOBxP1/XerG5qGHIKHaV6gcKsnxywdgW/F3mXBNx0bII/yGjgK0/cYucVI
 KryYpLui0m3dPU8SuMS1VX9K7XWHBaEmfbnxqIF0Iqwc4yUYmmh/VWU+Co8kZ7MJ06Mj
 FWRw==
X-Gm-Message-State: AOJu0Yz5nIGIQHZWaa76QStKwLwaHZXJ5aT0LpgppgUCzquEjDjXF1EL
 Nf2Q+rt2PExWavhx7rUmZnsecJsYw3W7M6Ij9bNj9dBqjDj8+XG9wm/5zFpSkM9pPVdUsNCkFW7
 LLrnKTEygI/doR2BjsatmYwmvyuP4QGbJ1qak65CZDdnvQ60mqYTBCj5A+6xuv/+z
X-Gm-Gg: AR+sD12U58gnj9RTtH8Kh6Wgtu3Htm8DTdWc6nsRnm0kscEUEl/H2H2QKUHBp7SJYfV
 ex27ZbbqxjkHNzTW0IdqK9oV5bQSxyKA9huj4C2SdhIxUg6fGITWK/YxHG4WXBT90voRW8/sNfW
 WtE+DQ1ZLGdRRLLkw+wc5RZFruQe7yyxmqADpXffWbifO9Hv1NOt1QmDD1vJ8s9rkNQWDVI9ihU
 bAUNXJdY2AvZkYHWpgDWq5vSGI866EO3vo2wVrXgyfBQNzQrdS65irIYCveGsWWfMsSsDxgXNWk
 lyl8dAdO1S9Qbm4ljA6BsUR0ejU7SyLRRCXI6lMQvxXRgTZoWGI/Z0fiJBXtQzGfLF9xgE+IMw/
 rolAZYZxfw1eV2CmlsM84pw==
X-Received: by 2002:a05:600c:4ed3:b0:495:7040:c7e9 with SMTP id
 5b1f17b1804b1-49573cc2f21mr74763895e9.6.1784886710084; 
 Fri, 24 Jul 2026 02:51:50 -0700 (PDT)
X-Received: by 2002:a05:600c:4ed3:b0:495:7040:c7e9 with SMTP id
 5b1f17b1804b1-49573cc2f21mr74763525e9.6.1784886709545; 
 Fri, 24 Jul 2026 02:51:49 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-37-66.inter.net.il. [80.230.37.66])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4957f9b8b67sm19819915e9.4.2026.07.24.02.51.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jul 2026 02:51:49 -0700 (PDT)
Date: Fri, 24 Jul 2026 05:51:46 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Weimin Xiong <xiongwm2026@163.com>
Cc: qemu-devel@nongnu.org, jasowang@redhat.com, virtualization@lists.linux.dev,
 Xiong Weimin <xiongweimin@kylinos.cn>
Subject: Re: [PATCH 3/3] hw/virtio: Add error handling for
 vhost_virtqueue_mask failure
Message-ID: <20260724054836-mutt-send-email-mst@kernel.org>
References: <20260724093759.810108-1-xiongwm2026@163.com>
 <20260724093759.810108-2-xiongwm2026@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260724093759.810108-2-xiongwm2026@163.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.951,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Jul 24, 2026 at 05:37:59PM +0800, Weimin Xiong wrote:
> From: Xiong Weimin <xiongweimin@kylinos.cn>
> 
> In vhost_virtqueue_start(), the call to vhost_virtqueue_mask() has a
> TODO comment indicating errors are not handled. Add proper error
> checking and propagate errors to the caller.
> 
> Signed-off-by: Xiong Weimin <xiongweimin@kylinos.cn>

why is this part of this patchset?

> ---
>  hw/virtio/vhost.c | 10 +++++++--
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> index 1234567890ab..fedcba098765 4321006
> --- a/hw/virtio/vhost.c
> +++ b/hw/virtio/vhost.c
> @@ -1467,9 +1467,13 @@ static int vhost_virtqueue_start(struct VirtIODevice *vdev,
>       * will do it later.
>       */
>      if (!vdev->use_guest_notifier_mask) {
> -        /* TODO: check and handle errors. */
> -        vhost_virtqueue_mask(dev, vdev, idx, false);
> +        int r = vhost_virtqueue_mask(dev, vdev, idx, false);
> +        if (r < 0) {
> +            VHOST_OPS_DEBUG(r, "vhost_virtqueue_mask failed");
> +            r = -1;
> +            goto fail;
> +        }


and then what happens?

>      }
>  
>      if (k->query_guest_notifiers &&


