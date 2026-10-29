Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A652606A31C
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 09:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NY/k4FYC;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=qxC8YRiE
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMM5d-0002iq-3m; Thu, 29 Oct 2026 05:06:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1xMM5Y-0002hi-6x
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 05:06:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1xMM5W-000496-Bx
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 05:06:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793264780;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Dr72aG+iQSJ2G3MzIqrarg0Agc4Gxox0IUk3vO6vVnQ=;
 b=NY/k4FYCVIjq436t3R8TJWaH+qGoR6/ONcqmVEAtNURBgtQsD8bkGli5yVdrRhYG8Y0tE0
 k5WgBM31pff8nlCJmDD+dg0EkfWl41EIFLIaLZ2t1/lXnTWcfmU1nIdp4m0DTKvsKnhCQ0
 YCiwSHAJHdlGWnl7NeN0YxjPg2IcVKI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-458-DmKV8dopPJ-70nsI3g7AIQ-1; Thu, 29 Oct 2026 05:06:19 -0400
X-MC-Unique: DmKV8dopPJ-70nsI3g7AIQ-1
X-Mimecast-MFC-AGG-ID: DmKV8dopPJ-70nsI3g7AIQ_1793264778
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-48c4445512dso1650318f8f.2
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 02:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793264777; x=1793869577; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Dr72aG+iQSJ2G3MzIqrarg0Agc4Gxox0IUk3vO6vVnQ=;
 b=qxC8YRiE8lFuyJbEiR/+Ktx0LRL6Bn50BXNhBqrjMHWVjUfyTEMM92w2pNLLVeypl/
 uImrCNdwLNka8xgdQq2onwzOekdQrpPQshcGKaQhnJCOUohXEr+AORWThR9HYx/1EnHT
 NsaUZ0usEuSz8zNohheuZ+608rFSZRd4cJxiW1GfVjY6Z4ZCLIyftppwm1iD0LX1TSIL
 qVNlSlGSWROHbSfpVuOPmE6oRdFLi+Z6DxkyVuPl8zySUIFniZtQKrAPRnmE1ipk/A40
 WK+y1MK8/VJSqLp7oGBS8TqM8GXYpIwnUBB6ZCwVIzIjWmiGpKymFW6fcrLhU6VkkP4z
 Hskg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793264778; x=1793869578;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Dr72aG+iQSJ2G3MzIqrarg0Agc4Gxox0IUk3vO6vVnQ=;
 b=cKEI1riULI/hMzNkzz3slV4EIcwGczV37Y8bjnkRO+7siNQUuazZ+PbFfg6F9/xWoR
 vR4CtWMYjbu2rBpGg9GKcnihzJIw6/2mmLGh/CJ9rl1u1T8no+dK846pRohqWlW/gzLy
 lnFtggZTnK7ZgCYr2X8lvsWAxWfmU5HKXC+EBlR5f4DuA333Y7SfeIvKaYtCnDMjVWVx
 4oBKCh74p79sV2SWpfwkqjD76DcbVAZKjGFBuoRYI4SFhkMc9G1LiTvf2+s3jDFOuerZ
 seZJcJmlV6XokHbKZKJzUKrzexnU9ES7CEG/I4XpiYdrlDAdi+rLSaBn50kPjBM3qsec
 QXTw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzvxzfnAxK+qgqAcXGjDhMdWZLH7fTN9l3kASXURZ1Z8cr5e3UkqfVYFf0WHVOWXkWHimRsEpYOkaor@nongnu.org
X-Gm-Message-State: AFq9FYIekUnDmuyJaiXbC2DukcDRfaIW9Uo2F3DvW4zCYw8oB07FjEBp
 ORj5u/wCGI5Qar4hTFQlkQL2cyBa4ZRgEJS96immA5ZkTHSAZF30NiVW1743qFHI0Gb0iwJ6UQZ
 1BCi+hMds1aI1Fri5mRtwaXJ6X7GUI3Ha+GJA/75mxuCQT7FBPr4U+wun
X-Gm-Gg: AYBFou2aYdamf5rD9Cwh+APH/vzrkEm7p66Vh5yarOxtrOvW/PntQLPfQixo184wvm9
 QqXkeL6B2V05psr4RZuYBDdKlqvIxWEuautNYIDyIgf+8hYgUTludXKELgx0j0zntHa9nWIji90
 QydAWJvyegPQyb3A3uXjmXaYsfzCfLp5ieMNGTjV8lDi+rsH5HSUzJ9zEsKHV2TC7XF8dzfXQw4
 oqhjrLleU/20Wegem9suH7qAfvXtprzgjHzjJc2L9e/I0V0iyGs0EyZRicN02ARInE/GeHfLqLW
 +NZoxx8GobwBhYpmwFaoVrmO57EBJOzwpJlbmIfzZ3QPQcYF9nIsXT21FdMsuOaOVBLBEJ+C0HR
 t/PzOLwRVbwe2S5YPZMcI0C549NzEt9uTSm10zUsKvIi7ljYQt7Imdg==
X-Received: by 2002:a5d:64c4:0:b0:48d:f36e:ccc0 with SMTP id
 ffacd0b85a97d-48e5d2c5530mr10985095f8f.0.1793264777187; 
 Thu, 29 Oct 2026 02:06:17 -0700 (PDT)
X-Received: by 2002:a5d:64c4:0:b0:48d:f36e:ccc0 with SMTP id
 ffacd0b85a97d-48e5d2c5530mr10985025f8f.0.1793264776550; 
 Thu, 29 Oct 2026 02:06:16 -0700 (PDT)
Received: from sgarzare-redhat ([81.127.154.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ebc4d76sm33658886f8f.12.2026.10.29.02.06.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 02:06:14 -0700 (PDT)
Date: Thu, 29 Oct 2026 10:05:42 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Tim Pambor <timpambor@gmail.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org, 
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
Message-ID: <auMLJ4rBHJBtCU51@sgarzare-redhat>
References: <20261022-vhost-user-posix-v1-0-0bd4d450d23c@gmail.com>
 <20261022-vhost-user-posix-v1-5-0bd4d450d23c@gmail.com>
 <20261027192445.GC933537@shajnocz.csb>
 <auGyOJGAo8Qivhu8@sgarzare-redhat>
 <20261028123346.GA1217203@shajnocz.csb>
 <auHzRD3kwZlil74F@sgarzare-redhat>
 <20261028184345.GB1305253@shajnocz.csb>
 <CAOX+r5_G66x98G08xG1R-R3wGENOxKjh54KE5pR69DmGahnQDw@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOX+r5_G66x98G08xG1R-R3wGENOxKjh54KE5pR69DmGahnQDw@mail.gmail.com>
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Oct 28, 2026 at 08:33:30PM +0100, Tim Pambor wrote:
>On Wed, Oct 28, 2026 at 7:44 PM Stefan Hajnoczi <stefanha@redhat.com> wrote:
>>
>> On Wed, Oct 28, 2026 at 02:23:55PM +0100, Stefano Garzarella wrote:
>> > On Wed, Oct 28, 2026 at 08:33:46AM -0400, Stefan Hajnoczi wrote:
>> > > On Wed, Oct 28, 2026 at 09:32:05AM +0100, Stefano Garzarella wrote:
>> > > > On Tue, Oct 27, 2026 at 03:24:45PM -0400, Stefan Hajnoczi wrote:
>> > > > > On Thu, Oct 22, 2026 at 03:47:26PM +0200, Tim Pambor wrote:
>> > > > > > diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
>> > > > > > index 6e05c995f1..788913953d 100644
>> > > > > > --- a/hw/net/vhost_net.c
>> > > > > > +++ b/hw/net/vhost_net.c
>> > > > > > @@ -33,7 +33,13 @@
>> > > > > >  #include "standard-headers/linux/virtio_ring.h"
>> > > > > >  #include "hw/virtio/vhost.h"
>> > > > > >  #include "hw/virtio/virtio-bus.h"
>> > > > > > +#if defined(__linux__)
>> > > > > >  #include "linux-headers/linux/vhost.h"
>> > > > > > +#endif
>> > > > > > +
>> > > > > > +#ifndef VHOST_FILE_UNBIND
>> > > > > > +#define VHOST_FILE_UNBIND -1
>> > > > > > +#endif
>> > > > >
>> > > > > This constant is for hw/virtio/vhost.c's vhost_net_set_backend() API. It
>> > > > > should be defined along with that API. Define it alongside
>> > > > > vhost_net_set_backend() in hw/virtio/vhost.h and call it
>> > > > > VHOST_NET_FILE_UNBIND?
>> > > > >
>> > > >
>> > > > That constant is defined by a Linux header (see
>> > > > linux-headers/linux/vhost.h). Are you suggesting to add another constant
>> > > > that is defined with VHOST_FILE_UNBIND on Linux and -1 on other platforms?
>> > >
>> > > Looking again, we should probably just use -1 instead of a constant
>> >
>> > Yep, this would be fine too.
>> > I don't remember why I did in this way, maybe to keep the diff smaller
>> > enough, but I don't have a strong opinion, we can avoid this ifndef and use
>> > -1 everywhere if you prefer that.
>>
>> IMO VHOST_FILE_UNBIND doesn't belong in vhost_net.c, so it would be nice
>> to avoid the #ifndef.
>
>So, for v2, is it ok if I replace the one usage of VHOST_FILE_UNBIND in
>vhost_net.c with -1 and remove the #ifndef?

Yep.

>
>> > > since include/standard-headers/linux/vhost_types.h doesn't even define a
>> > > constant:
>> > >
>> > >  struct vhost_vring_file {
>> > >     unsigned int index;
>> > >     int fd; /* Pass -1 to unbind from file. */
>> > >
>> > >  };
>> > >
>> > > It's strange that VHOST_FILE_UNBIND was defined in <linux/vhost.h>
>> > > instead of <linux/vhost_types.h> where struct vhost_vring_file is
>> > > defined.
>> >
>> > Oh, VHOST_FILE_UNBIND was introduced after struct vhost_vring_file, with
>> > commit 776f395004d8 ("vhost_vdpa: Support config interrupt in vdpa").
>> >
>> > But I agree that should be moved to vhost_types.h. BTW <linux/vhost.h>
>> > already includes <linux/vhost_types.h>, so maybe we can fix it without too
>> > much trouble.
>>
>> Yes, that change seems safe and will improve things in the long term.
>
>Or should I send a patch to linux adding VHOST_FILE_UNBIND to vhost_types.h
>and then drop it from vhost.h and remove the #ifndef?

This is orthogonal, the issue this patch was fixing was to build on 
no-Linux systems, so changing Linux headers will not help.

This is more a cleanup, if you can send also that patch to Linux (which 
is unrelated to this work) would be nice, otherwise let me know and I 
can do that.

Note: files under linux-headers/ are imported from Linux, can't be 
changed here.

Thanks,
Stefano


