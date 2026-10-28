Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F19606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 13:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=SXMIHr9l;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=U+GZa3Yz
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM3dX-0000mA-Jq; Wed, 28 Oct 2026 09:24:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1xM3dR-0000lg-Er
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 09:24:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1xM3dP-0006Rr-6Y
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 09:24:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793193845;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ogdC9DyUdeid9INepHM32zrF8vZgQ08zQhvPfZU0/yc=;
 b=SXMIHr9lZqnNFBnMZJSEhfPrazLzftyAVgTmwtNvmJAiLMMdzvkgXCngfW83Q5FW8OBNYP
 pwsQPvTWdPr6mYbBANeFK5XHSWYqh1nehX57KsAKlePx5R00hI71BpPtyjwjf+NnmFthRD
 GcCZfsvxIuHihidxmdIgn37nEU8axYQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-682-ufHayxfZMnWZzB_WekWosg-1; Wed, 28 Oct 2026 09:24:04 -0400
X-MC-Unique: ufHayxfZMnWZzB_WekWosg-1
X-Mimecast-MFC-AGG-ID: ufHayxfZMnWZzB_WekWosg_1793193843
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-48df730c035so637807f8f.0
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 06:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793193843; x=1793798643; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ogdC9DyUdeid9INepHM32zrF8vZgQ08zQhvPfZU0/yc=;
 b=U+GZa3YzCEOVA43s5GehREDcDAjadwJnMvb1Om41/gTefCDTmSf0x2pxq03CTOGBab
 NB/JOD8w/Vx4nKBA2yjpwgNFZHm9tUKXav7QnplR7Y2QWvSPRjLOa1oNy8GEnS1TKtQh
 ANNIhYd8nDou7lyImWTRFXB2S8OlouDFw6A4D0cVAjql8Y9+Yn2C3jMxhxV5Jw8qqBdu
 qZRPUrjB22rza+PbHYWClmli9cOyJp27yeMYNI9gj0A/A8yBGrlMBil0N2yOD49r+XYa
 ENYgQxzyn37xRGiOd887g9LiRfdUda3tV/zxnZjMHN2TZDaYgR7YZTq31cVSbUGJN6mx
 3fiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793193843; x=1793798643;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ogdC9DyUdeid9INepHM32zrF8vZgQ08zQhvPfZU0/yc=;
 b=0zI+rKjrDEeAsqqxc4soiRXHE0cffokCEzh+AhN5azZNmHiqO3ar6vzAXx0CPeaYbF
 ya8JgCP0UI9MTMrdVm5HfYSSOT3+ePN6a/Me/zUV5SNYdn4Wwg534+mTUaZgNs/7FKyl
 0wQZRuA5ioho+E9mIRLiFE8zQSE5p8GDGy231ZV7Of5Sq6idlAofibPWQmDJr8xe84bb
 8lmWH6GyG/ENv8UiqLIr0LEFvr5ZOsI0HhNqwG0dpdjNkXd3uQrLcYgMGdgh50sQjFKS
 qjK4n/DetDDfyEEO2cFlZEDwRc2z4mraiVTOptcS7nMA+vsZISdmyweWuwvfTO/rHHJi
 q/ZQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByQzq5eKTezWH4Li06LJJTdXOSprIycbcBiRsU501UO8g3jsEzmhLiLn34RjZXExPYZ/tCTLhKR3zio@nongnu.org
X-Gm-Message-State: AFq9FYL7+ckfsLlD6vkrbKp53d4EJHKij5PabbGWeq12VsGSludtHpoI
 H6xmXqStj7TPEcpq5qu7vCeMQtgD0prWpz2d9WZ30TOnnLscAh93VQPBLHgaUNU+yY9UhQHkY0a
 gqilIKUIIihyaLzLakjH4kwrPJ+O44ing1Df+Rub8QNTf6cSPeheLA5KC
X-Gm-Gg: AYBFou1LhxKgNlhEUvj+OvyaYhtB0NhN05tohd81lGhUzeB8e+um85Ms9cwcPWWwojA
 JLLtdYCkdmv6kWSRIIPegULEQ2oJ4bw1YDcJOIynNaq1bJ3arHmTvWRHqUqoBnoaDqLRR8Tfkkl
 Gk6yVXDERu//U+6PLabCtYf8HRFMP5f2D/sNTJSO8V/KNalbK1ZDXLY0lTCYeV0AtSVl+K4BdlL
 JiO4i0FOXZUiZqz/gzPQn03nWY3ySXiRB7XRrkVCU0+a6i/26YQSqhBWFQKw8AyU0pIOTySjA8m
 6Y/wZhb9G6lm3PfbTc1Vnsb27sOaKmbgZqAI2EAUc1IMHeud2iKKzXlC9dP1DdXpXNoJsUPPsXe
 2Ofwffw1Z90Cxgg6VT4EyIAcU8Fco+GNAdGCZxBcu0C00UmzBHtMicA==
X-Received: by 2002:a05:600c:3d05:b0:4a2:1a:a120 with SMTP id
 5b1f17b1804b1-4a9745286cbmr47864605e9.6.1793193843159; 
 Wed, 28 Oct 2026 06:24:03 -0700 (PDT)
X-Received: by 2002:a05:600c:3d05:b0:4a2:1a:a120 with SMTP id
 5b1f17b1804b1-4a9745286cbmr47863965e9.6.1793193842705; 
 Wed, 28 Oct 2026 06:24:02 -0700 (PDT)
Received: from sgarzare-redhat ([81.127.154.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a9797e98a7sm42610525e9.15.2026.10.28.06.24.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 06:24:01 -0700 (PDT)
Date: Wed, 28 Oct 2026 14:23:55 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Tim Pambor <timpambor@gmail.com>, qemu-devel@nongnu.org, 
 "Michael S. Tsirkin" <mst@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>, 
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 Jason Wang <jasowangio@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 qemu-block@nongnu.org, Raphael Norwitz <rnorwitz@nvidia.com>, 
 Brad Smith <brad@comstyle.com>, 
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 David Hildenbrand <david@kernel.org>
Subject: Re: [PATCH 5/8] vhost-user: enable frontends on any POSIX system
Message-ID: <auHzRD3kwZlil74F@sgarzare-redhat>
References: <20261022-vhost-user-posix-v1-0-0bd4d450d23c@gmail.com>
 <20261022-vhost-user-posix-v1-5-0bd4d450d23c@gmail.com>
 <20261027192445.GC933537@shajnocz.csb>
 <auGyOJGAo8Qivhu8@sgarzare-redhat>
 <20261028123346.GA1217203@shajnocz.csb>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20261028123346.GA1217203@shajnocz.csb>
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Oct 28, 2026 at 08:33:46AM -0400, Stefan Hajnoczi wrote:
>On Wed, Oct 28, 2026 at 09:32:05AM +0100, Stefano Garzarella wrote:
>> On Tue, Oct 27, 2026 at 03:24:45PM -0400, Stefan Hajnoczi wrote:
>> > On Thu, Oct 22, 2026 at 03:47:26PM +0200, Tim Pambor wrote:
>> > > diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
>> > > index 6e05c995f1..788913953d 100644
>> > > --- a/hw/net/vhost_net.c
>> > > +++ b/hw/net/vhost_net.c
>> > > @@ -33,7 +33,13 @@
>> > >  #include "standard-headers/linux/virtio_ring.h"
>> > >  #include "hw/virtio/vhost.h"
>> > >  #include "hw/virtio/virtio-bus.h"
>> > > +#if defined(__linux__)
>> > >  #include "linux-headers/linux/vhost.h"
>> > > +#endif
>> > > +
>> > > +#ifndef VHOST_FILE_UNBIND
>> > > +#define VHOST_FILE_UNBIND -1
>> > > +#endif
>> >
>> > This constant is for hw/virtio/vhost.c's vhost_net_set_backend() API. It
>> > should be defined along with that API. Define it alongside
>> > vhost_net_set_backend() in hw/virtio/vhost.h and call it
>> > VHOST_NET_FILE_UNBIND?
>> >
>>
>> That constant is defined by a Linux header (see
>> linux-headers/linux/vhost.h). Are you suggesting to add another constant
>> that is defined with VHOST_FILE_UNBIND on Linux and -1 on other platforms?
>
>Looking again, we should probably just use -1 instead of a constant

Yep, this would be fine too.
I don't remember why I did in this way, maybe to keep the diff smaller 
enough, but I don't have a strong opinion, we can avoid this ifndef and 
use -1 everywhere if you prefer that.

>since include/standard-headers/linux/vhost_types.h doesn't even define a
>constant:
>
>  struct vhost_vring_file {
>  	unsigned int index;
>  	int fd; /* Pass -1 to unbind from file. */
>
>  };
>
>It's strange that VHOST_FILE_UNBIND was defined in <linux/vhost.h>
>instead of <linux/vhost_types.h> where struct vhost_vring_file is
>defined.

Oh, VHOST_FILE_UNBIND was introduced after struct vhost_vring_file, with 
commit 776f395004d8 ("vhost_vdpa: Support config interrupt in vdpa").

But I agree that should be moved to vhost_types.h. BTW <linux/vhost.h> 
already includes <linux/vhost_types.h>, so maybe we can fix it without 
too much trouble.

Thanks,
Stefano


