Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73282606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 11:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BsXFFwO4;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=TqN75z1B
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMOZ1-0004ok-LN; Thu, 29 Oct 2026 07:44:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1xMOYg-0004YX-8E
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 07:44:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1xMOYe-00051J-Ni
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 07:44:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793274276;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uj2IjmZBlm48HBp9FJ1QbkgnUqlFKX2puozJZyWv7H4=;
 b=BsXFFwO4LVtaJczbvhy4fWdz8PtZitiCw/lxvfgWgcBaJ1HmsXxn0jS4RV3QHJ49HkO6Ut
 l5pYtaY+lFIaq0P5iW3/zXz0/bAM3TiWHUE23CXo5Hhb65KK3YYfTNiUn7rW0ruO5iPAx2
 wrfyy8ZLPVyeLVbzu/2lq2lSV0iybDs=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-120-U08a4GvdMzK7Cacc7OMNUg-1; Thu, 29 Oct 2026 07:44:32 -0400
X-MC-Unique: U08a4GvdMzK7Cacc7OMNUg-1
X-Mimecast-MFC-AGG-ID: U08a4GvdMzK7Cacc7OMNUg_1793274271
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-48e0461e040so1588276f8f.0
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 04:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793274271; x=1793879071; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=uj2IjmZBlm48HBp9FJ1QbkgnUqlFKX2puozJZyWv7H4=;
 b=TqN75z1B1UMov+RT3czjtBcLK9Ihi7eLaX+485EdXQ8EcH/d+uNo+SH2/7iDQI7Zky
 YTYAyFnTPJ2DK8a1BRsLnaY7PwsqthqOJz6VgsCUk9I4aS5zvsbpko4R6OWu19ZaFh/o
 ZZd7zgz42+zyYi9gLtcrYE+E35+cy47L+dayJlX8MwdoSFarVfap8Z0nL5AfiqcZ2dEO
 LAdLBljKAjOR1LhdFpxrg4RsB5Vg8+OGLFt+SxLmNIrICQyhEYbFCjdWD6I5HVI/e+Lw
 QH0X5RcGi4vdIU6bMGJYdjf5Q1uKKriEYSAqEjbfE2NOMYKPHPi8NbKD1tyi7SNerKjS
 lJeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793274271; x=1793879071;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=uj2IjmZBlm48HBp9FJ1QbkgnUqlFKX2puozJZyWv7H4=;
 b=j0EYO2xAAOkWexSs2W4FNF0rpYLbfD3TXA6KIbi+QTzcdyECsHPU7Vj2id8tS8pOEZ
 i7rclZTZMmv2OpjVAElNtPlhzHael3XRLRF2xOPPRguJWErnQt9aLdKdGzA/AawqCI09
 ejJ9H1kDOQwCqWutF1zrUOk1b6mHcXESUNmGwO+nuLdUz1MgPC7GrFvQMhh+Gotf2NKN
 PI5c8Zxl0vdIFQZCJJVrmb0QMGOjpH23MkbPnmnrWzrOuWcxXNz478DNjeLdvYqLIbjY
 S4ff12DNFldO4fvuoc6D+x3zBMVRZ9BMsbjPEtnnySajcgcvWDwiOPQK5Lz094ZuAL2O
 EWaw==
X-Gm-Message-State: AFq9FYINaHzR1FBvzMiZFDcwnnmdZ1hsZUuAd8OzxFSovMTp+7dZYwaK
 TBmBhxIyWLyqfR0JFJziwIPk2aqfdoDgnILFG4S7OjN018+DaudMrh+FLIELyQ4M6ziyw/vRgi6
 AZoSBZ/glBENtD1x8Nw/QI79YFfKv94S4tWnaiFLElTMM4SShWfAu69rB
X-Gm-Gg: AYBFou2GD5Wgl90Tdc5d8MA9vW0FPSeVbQJ5F2JfWd1QS+H3XF4v3iPBjw3mNVvUIhI
 lrv+uF9F3mLJWoIp8xfDSoKeM67AqLxHFSkwirEagSe0Fg/h6FlCWvFQxDzOV3y1MpzcrMQolI+
 GxPx6Q+UQhXJ4GFyMuMa3o9BuGGDEskUlgpldE1Q035lu/LIebQjhH8DnmmpwLzDXyh8PfdaMUs
 7k2durUEB0r4bkkx74JUkDkKw/MZvThGxDkfFQZps5/Ro5nn9BmGLOeShe8cbzYzjbIrgLz+Q+x
 uQMXjxDKZTcstyPFyHrKt4HBOwV9D3CUPJ1fRzhHGxNiP3KB0aktoBS/9Vh0OHdaVrJeG+kQohK
 ayuQv4Ksi9Mwx4r8Y2l/8iwjfHsfGr1bdAJu1STh+q1mKebMYmR+geQ==
X-Received: by 2002:a5d:5f45:0:b0:48b:59f:db9c with SMTP id
 ffacd0b85a97d-48e5d56b46dmr11882575f8f.53.1793274271372; 
 Thu, 29 Oct 2026 04:44:31 -0700 (PDT)
X-Received: by 2002:a5d:5f45:0:b0:48b:59f:db9c with SMTP id
 ffacd0b85a97d-48e5d56b46dmr11882526f8f.53.1793274270926; 
 Thu, 29 Oct 2026 04:44:30 -0700 (PDT)
Received: from sgarzare-redhat ([81.127.154.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ebc3cfasm34347361f8f.17.2026.10.29.04.44.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 04:44:30 -0700 (PDT)
Date: Thu, 29 Oct 2026 12:44:18 +0100
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
Subject: Re: [PATCH 8/8] libvhost-user: detect memfd support with a link test
Message-ID: <auMwF2bb4bHLLuwB@sgarzare-redhat>
References: <20261022-vhost-user-posix-v1-0-0bd4d450d23c@gmail.com>
 <20261022-vhost-user-posix-v1-8-0bd4d450d23c@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261022-vhost-user-posix-v1-8-0bd4d450d23c@gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, Oct 22, 2026 at 03:47:29PM +0200, Tim Pambor wrote:
> The inflight fd code is guarded by #ifdef MFD_ALLOW_SEALING, which only
> tells us that the headers define the flag, not that memfd_create() is
> available in the C library. There are environments where the flag is
> defined but the link fails:
> 
>   ld: error: libvhost-user.a(libvhost-user.c.o): undefined symbol: memfd_create
> 
> Probe for memfd_create() with MFD_ALLOW_SEALING in the subproject's
> meson.build, using the same test QEMU's top-level meson.build uses for
> CONFIG_MEMFD, and guard the code with CONFIG_MEMFD instead.
> 
> When memfd is not available, VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD is
> masked out as before, so the frontend never sends
> VHOST_USER_GET_INFLIGHT_FD.
> 
> Signed-off-by: Tim Pambor <timpambor@gmail.com>
> ---
>  subprojects/libvhost-user/libvhost-user.c | 17 ++++++++---------
>  subprojects/libvhost-user/meson.build     | 11 ++++++++++-
>  2 files changed, 18 insertions(+), 10 deletions(-)

Should we move this commit before we enable libvhost-user on any POSIX?

Also, maybe we should do something similar for CONFIG_EVENTFD as I 
pointed out in the other commit.

Thanks,
Stefano


