Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BF7CCD3427
	for <qemu-devel@archiver.kernel.org>; Sun, 10 May 2026 20:20:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMAcU-0001y8-Nl; Sun, 10 May 2026 16:19:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wMAcT-0001xx-FF
 for qemu-devel@nongnu.org; Sun, 10 May 2026 16:19:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wMAcR-0007TK-Gb
 for qemu-devel@nongnu.org; Sun, 10 May 2026 16:19:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778444357;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EdAlnFz40RGJfP7V6Yaew8z+iOTkh/EpHNqN9bFSCaU=;
 b=AUJXLQgjgQ9yI7tjSdrF8ChxqylpqXiufYLcbcIdnuzo419RXdJk7v91IQTxY8mS7rWP6g
 2MPcO4XFRu7eqRLlYG8gw1pL6+OKLdwg1h9Py5EkwFig/5CCUXAZ39bzEDbHSnl3ZjgX34
 Ia6WhLIJtRB3fP4RaOu14/uJ24v7WRU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-375-9giQpZbxM_GoP9CbXYggqA-1; Sun, 10 May 2026 16:19:16 -0400
X-MC-Unique: 9giQpZbxM_GoP9CbXYggqA-1
X-Mimecast-MFC-AGG-ID: 9giQpZbxM_GoP9CbXYggqA_1778444355
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-48d127eb013so20576665e9.1
 for <qemu-devel@nongnu.org>; Sun, 10 May 2026 13:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1778444355; x=1779049155; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=EdAlnFz40RGJfP7V6Yaew8z+iOTkh/EpHNqN9bFSCaU=;
 b=nkXBlNJWiKh913Li/QB35i+zM7I57rlt6wEuUP0cdy48y0gea1egP0PhvCAVi16YU8
 S129fpMMwfsLAZzYnajtMeP5n3jkknapyQta60UuphCjvCksxLm/BPeKDABkkyTozX0k
 ODYREqby0CcxED40h1S+IA85PndquvVVc73sqKpWSB7mPYJDsxbmA/ENrThgnWarUXyZ
 HfPDKq0CMWV2LFBidex2IBI0XYVxsyBym1rrT/2Hgz//8PgujpNgPAL0tyJ5htwbijLx
 H+FXd3Sp3j4WLy42EaLuQoSUDfetvc9cWNY00q4iP0V9fXYIJDJ1RJTohBpZNA4/5I9R
 gImg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778444355; x=1779049155;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EdAlnFz40RGJfP7V6Yaew8z+iOTkh/EpHNqN9bFSCaU=;
 b=E/E8iWzgn7azMTNnGyo8rDz1Jsknaee62UN7bSGn7BbH47Qny6/WIeNA55SOQ8ND/G
 yOYc+oIqrrhM3hjM+0yvJvddZoLitrI5ljXqqSWaNCdQ5eVG2phzDqQ0sNIJAKIeaaa5
 DItIHKNuwxQVYGKi4E2YbC7QOLG9uDCRqJH1SmWU9Coz+sTYy+icMTQh18pDHKi3lrjT
 BBBMT1hT+7dra/4onYlJc3OCSi6HfPRCKevj0Nm7FawV4TNYVxu7qwtPajt9dYy2sKZ+
 RmXBD5KRAuT1BsSiu2z/v0NTyCFMhaZZETNuoHnHtpHDo1JgIwyqKkLk26eKMzLqbS2D
 ZUtg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8e9+R5iIM3xywrn7LXGuB545/BO9yvv6wH6CQCFGmzKyMXAZlnwaOJ5aV9iWW8EwlckG5HsgAshD65@nongnu.org
X-Gm-Message-State: AOJu0YwHr4r5rzGcNcxg5cqoswrNG9Ishsinz0gqTMpYZc1gorPy8alA
 +K8Uikv5sGcRGTedx6V4WIOs3+gUy/RXnkdnsK1N2AvJz0WPhJv/iZY/CrUuiSdDMzBtcaWU+3i
 U6oOLUoyU2hsQDk5iJREWp4sTwmIDYQVnyUbl6RyfM13QBeMozvi4s/Os
X-Gm-Gg: Acq92OFmOX2221pGyF6ZcEjg+qeGkf+cQYa3M/jNzsx9YL4IbvrCDeAZj81S4nN3oYc
 DzP4F8/baFAzwnzbY8SVVRQr8AV1o7ocgqTxWCEg2WG4wSOwrCNtjefYP+pswEa6VD1JXo1oL6y
 cKS4O1iGrKiSq92uDaxMHsCXO4tOWlVGBnRSGjPAdsRoPmcqGF4V//JSw2pMH9afCEVT9vzMs2n
 CH72z/BH9y84yYTNXLo1zf9AQWOMtEDJx/eI3Xvc8FI5Oqsr8zkpI3sYEaxl/UxsJrCDihjJh8g
 cYXq8I9i5G/4bGCLLMxYLnwdYpsgN8AVykrZYJLlw7xELLIn2Cf8KO2E2IHO4NsPgwm3kNakoV9
 7lgxYbXj8JGj9uZ88kSjjCQV0ozCvmt/yuxvbqLdH
X-Received: by 2002:a05:600c:1e0f:b0:48e:51f5:2764 with SMTP id
 5b1f17b1804b1-48e676c0353mr197016695e9.27.1778444354661; 
 Sun, 10 May 2026 13:19:14 -0700 (PDT)
X-Received: by 2002:a05:600c:1e0f:b0:48e:51f5:2764 with SMTP id
 5b1f17b1804b1-48e676c0353mr197016355e9.27.1778444354217; 
 Sun, 10 May 2026 13:19:14 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-48-7.inter.net.il. [80.230.48.7])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e7040a8f1sm127775815e9.11.2026.05.10.13.19.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 10 May 2026 13:19:13 -0700 (PDT)
Date: Sun, 10 May 2026 16:19:10 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>
Cc: Song Gao <gaosong@loongson.cn>, maobibo@loongson.cn,
 qemu-devel@nongnu.org, lixianglai@loongson.cn,
 chenhuacai@loongson.cn, Avihai Horon <avihaih@nvidia.com>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v2 2/4] linux-headers: Update to Linux v7.1-rc1
Message-ID: <20260510161352-mutt-send-email-mst@kernel.org>
References: <20260507092358.2479135-1-gaosong@loongson.cn>
 <20260507092358.2479135-3-gaosong@loongson.cn>
 <c87311a3-b214-4705-8ed3-7386aea1056e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c87311a3-b214-4705-8ed3-7386aea1056e@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Sun, May 10, 2026 at 10:08:49PM +0200, Cédric Le Goater wrote:
> On 5/7/26 11:23, Song Gao wrote:
> > diff --git a/include/standard-headers/linux/virtio_ring.h b/include/standard-headers/linux/virtio_ring.h
> > index 22f6eb8ca7..7baf1968a3 100644
> > --- a/include/standard-headers/linux/virtio_ring.h
> > +++ b/include/standard-headers/linux/virtio_ring.h
> > @@ -31,7 +31,6 @@
> >    * SUCH DAMAGE.
> >    *
> >    * Copyright Rusty Russell IBM Corporation 2007. */
> > -#include <stdint.h>
> >   #include "standard-headers/linux/types.h"
> >   #include "standard-headers/linux/virtio_types.h"
> > @@ -200,7 +199,7 @@ static inline void vring_init(struct vring *vr, unsigned int num, void *p,
> >   	vr->num = num;
> >   	vr->desc = p;
> >   	vr->avail = (struct vring_avail *)((char *)p + num * sizeof(struct vring_desc));
> > -	vr->used = (void *)(((uintptr_t)&vr->avail->ring[num] + sizeof(__virtio16)
> > +	vr->used = (void *)(((unsigned long)&vr->avail->ring[num] + sizeof(__virtio16)
> >   		+ align-1) & ~(align - 1));
> >   }
> 
> The kernel commit 3c4629b68dbe ("virtio: uapi: avoid usage of
> libc types") changed this virtio header and this breaks the
> build on Windows :
> 
>   https://gitlab.com/legoater/qemu/-/jobs/14297040230
> 
> A fix could be to reintroduce 'uintptr_t' (available through
> osdep.h) by modifying the linux headers update script. Ideas ?
> 
> Thanks,
> 
> C.

Yea sorry ( Just add
#define VIRTIO_RING_NO_LEGACY
somewhere.


-- 
MST


