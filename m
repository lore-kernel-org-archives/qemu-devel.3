Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 109E8C54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 18:24:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk6nB-0002MN-Gd; Tue, 12 Mar 2024 14:24:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rk6n3-0002I1-NN
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 14:23:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rk6mv-0006yQ-0z
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 14:23:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710267817;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UidcMh5hnawLan5Q3EwuE26JXJ1TmWs6sbTHjSscXCI=;
 b=OjcNKKKLNpZ9t6VOpLRgfMuhoLuHEzFYFYcO7ceVu+ec7WN8+zn6e0ezsjyUNsIEZqIxV1
 rtCBdQbNgdYrtRJ8UMvJHtvXrXr+Zt+x528+UOGz7wMYRht8J4ZlAtgxQuxwFSgB+Nto0t
 HkmcADz/oNtXZrBZD9173WQHo6/Sj20=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-12-lDOp1yWqMDShBoT8NXeoLw-1; Tue, 12 Mar 2024 14:23:34 -0400
X-MC-Unique: lDOp1yWqMDShBoT8NXeoLw-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-513b13915e7so2773311e87.1
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 11:23:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710267813; x=1710872613;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UidcMh5hnawLan5Q3EwuE26JXJ1TmWs6sbTHjSscXCI=;
 b=IIz2msI5kIp/s/FEH1DhMpaxp68rZjlHoQfO+NuY2KtEHEVz0dz2R8vxy+ld590bdC
 iREibHcSfXPR7TEOndvf/H93w1kP317sqJouUi0beZaNM1nEr9gjsTIIq1wAEyYudcGP
 xAI7lVolyvw0S8ixX1z55M0B/r2lyeHkOHAm+2HnNBcfHxXnbbRCfRvHiOYxGUtoV9VJ
 WuaobgIQKgMwwe3QgCeFxy9PB2F8q/y5FORlxXG2tBWPlTIj3qD3idYfk3f1pRyT5xPx
 wy2TIx2rDoa0swPQhLoX9bjP9jJHpBSDY/3wx4d5KgUEUBIJK35Imr+T+bnW4ZsB1gpI
 nTPw==
X-Gm-Message-State: AOJu0YyRI9k/JVN3qWkOGzBvdriqrOa1BgTag+fhH+tPhEXcXdqTixLH
 KCdfuPULBjIT/OTzghogcv0eoUM+x72XvDZIqn+6cYKZ2Ftkn1nZy+Kc96M46FDHBa2sgaAnAq6
 K1IN2TGQyilFR3aQV1Zxw4q3l5PDe0h+HSqCB0sMs/df6QdFlvVNX
X-Received: by 2002:ac2:4d07:0:b0:513:49f7:70f with SMTP id
 r7-20020ac24d07000000b0051349f7070fmr597372lfi.57.1710267812889; 
 Tue, 12 Mar 2024 11:23:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGv8opshWvBGMhzbQN6xNUNJa2ZW17EnFK12SKpsNijMckfqtqTs3Kdq20F2FYG9eWBZEaEbw==
X-Received: by 2002:ac2:4d07:0:b0:513:49f7:70f with SMTP id
 r7-20020ac24d07000000b0051349f7070fmr597362lfi.57.1710267812433; 
 Tue, 12 Mar 2024 11:23:32 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f0:532c:5ae4:fce6:76e1:fa1a])
 by smtp.gmail.com with ESMTPSA id
 r11-20020a05600c35cb00b004127057d6b9sm19749354wmq.35.2024.03.12.11.23.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 11:23:31 -0700 (PDT)
Date: Tue, 12 Mar 2024 14:23:26 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Albert Esteve <aesteve@redhat.com>
Cc: qemu-devel@nongnu.org, stefanha@gmail.com, alex.bennee@linaro.org,
 philmd@linaro.org, kraxel@redhat.com, marcandre.lureau@gmail.com
Subject: Re: [PATCH v4 0/5] Virtio dmabuf improvements
Message-ID: <20240312142033-mutt-send-email-mst@kernel.org>
References: <20240219143423.272012-1-aesteve@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240219143423.272012-1-aesteve@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Mon, Feb 19, 2024 at 03:34:18PM +0100, Albert Esteve wrote:
> v1: https://www.mail-archive.com/qemu-devel@nongnu.org/msg1005257.html
> v2: https://www.mail-archive.com/qemu-devel@nongnu.org/msg1014615.html
> v3: Virtio dmabuf improvements
> v3 -> v4
>   - Changed GMutex by QemuMutex in virtio-dmabuf
>   - Made the value at VirtioSharedObject an union
>     to make naming more clear
>   - Added some documentation

Dropped everything except patch 1 for now.

> Various improvements for the virtio-dmabuf module.
> This patch includes:
> 
> - Check for ownership before allowing a vhost device
>   to remove an object from the table.
> - Properly cleanup shared resources if a vhost device
>   object gets cleaned up.
> - Rename virtio dmabuf functions to `virtio_dmabuf_*`
> 
> Albert Esteve (5):
>   hw/virtio: check owner for removing objects
>   hw/virtio: document SharedObject structures
>   hw/virtio: change dmabuf mutex to QemuMutex
>   hw/virtio: cleanup shared resources
>   hw/virtio: rename virtio dmabuf API
> 
>  docs/interop/vhost-user.rst       |  4 +-
>  hw/display/virtio-dmabuf.c        | 98 +++++++++++++++++++------------
>  hw/virtio/vhost-user.c            | 31 +++++++---
>  hw/virtio/vhost.c                 |  3 +
>  hw/virtio/virtio.c                |  3 +
>  include/hw/virtio/virtio-dmabuf.h | 73 +++++++++++++++++------
>  tests/unit/test-virtio-dmabuf.c   | 82 +++++++++++++++++++-------
>  7 files changed, 211 insertions(+), 83 deletions(-)
> 
> -- 
> 2.43.1


