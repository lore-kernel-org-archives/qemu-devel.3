Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09649606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 11:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Zlx7B/2R;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=nssTaWlZ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMOXs-0003Rd-Ce; Thu, 29 Oct 2026 07:43:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1xMOXo-0003Qz-Uc
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 07:43:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1xMOXn-0004vL-6r
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 07:43:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793274222;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=X1c6EOMU0jwCenpRPNkco53OjHDsz/5pp8j4mdn5FfQ=;
 b=Zlx7B/2RoPFTly6SBFpCiNTIK2t37ztUomZXUo5qlDf1W9VDO/SjfHsofQYNo3D/1t842P
 916CuwhoFi4rPCU7SBjqTgu2jRPN8Kt75Qlo5oXXglKrpZEoA4i3aokQ2mRNxGlJIcF9w4
 pLtQxJVj8sl4MQ5Nl52zozTQejCPhJ0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-52-KmCBEF3yMsaYfVz22uEqZw-1; Thu, 29 Oct 2026 07:43:40 -0400
X-MC-Unique: KmCBEF3yMsaYfVz22uEqZw-1
X-Mimecast-MFC-AGG-ID: KmCBEF3yMsaYfVz22uEqZw_1793274219
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-495689bfcc8so14539975e9.1
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 04:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793274219; x=1793879019; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=X1c6EOMU0jwCenpRPNkco53OjHDsz/5pp8j4mdn5FfQ=;
 b=nssTaWlZtPfVcCs+1HmV2deMqwpyyzapwqF1SY/J6iP+LJkv9gRKIyD5L7w0gGGUa3
 YnhGgiOD5uD+HTv/TR1fmXLvhY87InmMofduoPZ6V/tVH9ZAx5GXMi64CzVPVvGWWztP
 t6BFhnFTRSxvsagv7I8sB7WTDzagtmnz9JZr/y3RIMeouxrT9WcW7hfHCblRJzaR9WQt
 hZrqnAF/Y+EfYN5MH6BflfJntaX/56UOnZJDDEjzggwFzqNZvIkP2q8EQvdYekG5cCTo
 /Iy+jWfzpDvukKyUl7pbe1avphD1kTgg5Aoev5pNde70LfaZ3f3yHm2Kqbf/MGBnuLP1
 6njA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793274219; x=1793879019;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=X1c6EOMU0jwCenpRPNkco53OjHDsz/5pp8j4mdn5FfQ=;
 b=UN4Czkb3duujkraCb65NdthbKaOZecwQMQMZsV8GQmLakjI67kDbMJXEnKaXRhssJQ
 ivnfqX9dn3rgPe8pYkWqP2//7K3y4FoHAkmRhh8RMhAq7wnKJnqZv9n56tSWZxcbdQxp
 /XFrIzGFI05qRZzlk8dAFCCSep6ksTUoV8XXzmk+AX4fRdCZ3rIBrkZaEMbY9xTD/z7P
 NQf1+cvySybCTqh/QKsgEoiOaKvKM3HyKknFC4n2HCAL861QZaGLR22t+huPXvIDIMRz
 VEwYZXNUNbbKXw9TItXwbVwN5UqezXH7LweEW1EeP8kH3L/19gWnQpbPp50Ja8CENTNt
 9BVA==
X-Gm-Message-State: AFq9FYIqv1RzM2jOO04aTfMHwwzfdlbqTDRCaNoV8bF97IT3DVhm1dOt
 1LdaVFQNBbBToGgSmNuM4g0Ox8WFdv62wdUeq1dJqO6moWQC5c7CECLRGfU1BypVhqS5u44nRmc
 DwCE6CUphf+nqenM7JpXHCMhOpFUedEDCCf8zm5uq7iptBJqhm8z477Sd
X-Gm-Gg: AYBFou1RNOv01Mg5VdeQ6HNsjQW97QjwaJwCnGYTWuzTN6SbeYl7TQfblQXL+mk0RWJ
 jHoHJx4CTFbHhR5zeuYIg7As2ILrRSXOceCJK4NlUPPD/5NKruOOpK4XuQuWMp0RYU7B2/BrIkg
 09B21xUB5vOVTvAkxUUf1YkknNDI6u9p/AMCB3gc13YSTzsJZD3Lwtxa2tRslAk0BjPuKiVN2G+
 h+CvBdnJywUyCH6RZA5PFKoB47ZVuwrpAR/sTIWOrnycvaJkLUbg3kW4DGqqB1niPavSa5/lJ85
 TV+NxjUnDYUtErLL9fVfmTFtrghIDgzVpAbz8CTe6PplSGbs9vxvo7veu8kqecHwibhRE8eDOTr
 0TvOi+37RILsOm7wKuEvjNVd6kZqCdvLXzTpaIxg0aCSNFTxmKdf1bA==
X-Received: by 2002:a05:600c:37c9:b0:4a5:26b8:4507 with SMTP id
 5b1f17b1804b1-4a9678c281fmr116338855e9.21.1793274219054; 
 Thu, 29 Oct 2026 04:43:39 -0700 (PDT)
X-Received: by 2002:a05:600c:37c9:b0:4a5:26b8:4507 with SMTP id
 5b1f17b1804b1-4a9678c281fmr116338515e9.21.1793274218598; 
 Thu, 29 Oct 2026 04:43:38 -0700 (PDT)
Received: from sgarzare-redhat ([81.127.154.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4aa7f7f50d3sm88648075e9.8.2026.10.29.04.43.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 04:43:38 -0700 (PDT)
Date: Thu, 29 Oct 2026 12:43:35 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Tim Pambor <timpambor@gmail.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Jason Wang <jasowangio@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 qemu-block@nongnu.org, Raphael Norwitz <rnorwitz@nvidia.com>, 
 Brad Smith <brad@comstyle.com>
Subject: Re: [PATCH 2/8] libvhost-user: self-kick through a library-owned
 notifier
Message-ID: <auMdcyuQHkKhx5sI@sgarzare-redhat>
References: <20261022-vhost-user-posix-v1-0-0bd4d450d23c@gmail.com>
 <20261022-vhost-user-posix-v1-2-0bd4d450d23c@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261022-vhost-user-posix-v1-2-0bd4d450d23c@gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Oct 22, 2026 at 03:47:23PM +0200, Tim Pambor wrote:
> When a ring is started, it may already hold requests: ones the driver
> queued while the back-end was away and ones the previous instance left
> in flight. The spec says front-ends SHOULD send a kick after
> SET_VRING_KICK and back-ends SHOULD NOT rely on it, so libvhost-user
> kicks itself by writing to the kick fd it has received from the
> front-end. With an eventfd that fd is writable, but when pipes are used
> it is the read end and the write fails.

This was something we added to clarify the spec, not sure if it's worth 
to add all of this code for something like that.

That said, what about only setting kick_pending in 
vu_set_vring_kick_exec(), and running the handler of the pending queues 
at the end of vu_dispatch(), after the reply is sent?

> 
> Replace it with a notifier the library owns. vu_init() creates it, the
> embedder watches its read end through set_watch() like a kick fd, and
> the library writes it when a started ring has available entries or
> in-flight requests to resubmit. The watch callback drains it and runs
> the handler of every queue flagged kick_pending. This way the handler
> still runs from the event loop after the reply to SET_VRING_KICK has
> gone out, as with the kick-fd self-kick.
> 
> Signed-off-by: Tim Pambor <timpambor@gmail.com>
> ---
>  subprojects/libvhost-user/libvhost-user.c | 145 +++++++++++++++++++++++++++---
>  subprojects/libvhost-user/libvhost-user.h |  10 +++
>  2 files changed, 141 insertions(+), 14 deletions(-)
> 
> diff --git a/subprojects/libvhost-user/libvhost-user.c b/subprojects/libvhost-user/libvhost-user.c
> index 2fed792e85..e323e32cab 100644
> --- a/subprojects/libvhost-user/libvhost-user.c
> +++ b/subprojects/libvhost-user/libvhost-user.c
> @@ -23,6 +23,7 @@
>  #include <unistd.h>
>  #include <stdarg.h>
>  #include <errno.h>
> +#include <fcntl.h>
>  #include <string.h>
>  #include <assert.h>
>  #include <inttypes.h>
> @@ -40,7 +41,6 @@
>  
>  #if defined(__linux__)
>  #include <sys/syscall.h>
> -#include <fcntl.h>
>  #include <sys/ioctl.h>
>  #include <linux/vhost.h>
>  #include <sys/vfs.h>
> @@ -1305,6 +1305,7 @@ vu_get_vring_base_exec(VuDev *dev, VhostUserMsg *vmsg)
>      vmsg->size = sizeof(vmsg->payload.state);
>  
>      dev->vq[index].started = false;
> +    dev->vq[index].kick_pending = false;
>      if (dev->iface->queue_set_started) {
>          dev->iface->queue_set_started(dev, index, false);
>      }
> @@ -1440,6 +1441,121 @@ vu_check_queue_inflights(VuDev *dev, VuVirtq *vq)
>      return 0;
>  }
>  
> +static bool
> +vu_self_kick_init(VuDev *dev)
> +{
> +#ifdef CONFIG_EVENTFD

Can you check if CONFIG_EVENTFD is defined when building libvhost-user?

IIRC I used it, but now I'm thinking if we really have it defined.

Thanks,
Stefano


