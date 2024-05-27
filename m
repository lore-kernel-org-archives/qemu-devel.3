Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 294C9C25B74
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 14:19:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBbB5-0007G1-ST; Mon, 27 May 2024 10:18:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mvaralar@redhat.com>)
 id 1sBbB4-0007FG-AD
 for qemu-devel@nongnu.org; Mon, 27 May 2024 10:18:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mvaralar@redhat.com>)
 id 1sBbB2-000710-KT
 for qemu-devel@nongnu.org; Mon, 27 May 2024 10:18:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716819495;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LX0EHSEVJhD0lg4/D+XzVCe5VLKa2SwS9nSvAcHA4Gk=;
 b=OSNQ+k5bcQLdcZubnHYhd7iAKssU7E71pkCqnf0L0PP2ZLNt1Si3Z9/Pj7osrCWyYe976+
 Ayx8VC5seExwlL+g4RKJYssgOpW9nkHhqBKxWAcA91tZ+pto8kAKW7C4sD0qwsxM+rJcRK
 xk4Y+ZIpqErs9YwS0Gl8tuiQjL0/F50=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-327-90UCNmMtOla86tTAFzU7vw-1; Mon, 27 May 2024 10:17:02 -0400
X-MC-Unique: 90UCNmMtOla86tTAFzU7vw-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-354fc05816dso2105821f8f.1
 for <qemu-devel@nongnu.org>; Mon, 27 May 2024 07:17:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716819420; x=1717424220;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LX0EHSEVJhD0lg4/D+XzVCe5VLKa2SwS9nSvAcHA4Gk=;
 b=BrdzqBK7co7FZA+zjMXZWp4QmNfcbSxOk7/VBqCDJcoWKUQW9Zm+6b4HDUCcNiTXDT
 ft0PNoJSheca0DmqwasI32/1VG4SLuEsud/gvh3Y1lO6fuBIsYYx/6x+ihDDrsRyH6Uo
 tkE5THcMPv72zb9D1WhV67yTm4Ut/nDfYTPYZ0mNztYmhgEVfV0txNPPoEkN6wjcfM3b
 Kgxk+Ny+9qB6PVuzX8fXR8JTWONxfelZycy6o2PUg8xS5axWrnuHkort7dxnkWAycwaU
 qOMRa6/3Tjx0jmwgiCz16anpsvTMBIjVKOxCvrQxK2mtS4aIN0FQeGAeSVrKIYcYuEhM
 EwHw==
X-Gm-Message-State: AOJu0Yz/lTKGg6reA96Jv2dmuZKOejUOSVq1YqShq4prnE96X+VZtOYv
 FplR5xTGY8w41cxBa3YwjJcnOOAAdgyQtLQ5HfRf71R6UcH6tcvRpfoElIp7aJWgi8Gf833zoLv
 B5qjjcY+7JijhjfOv1GPReQVn5TJBc81Vpxl+iKAL1Ayt8HEpebdZ
X-Received: by 2002:adf:e38a:0:b0:354:f7a1:261a with SMTP id
 ffacd0b85a97d-3552fdfcb54mr5533897f8f.71.1716819420683; 
 Mon, 27 May 2024 07:17:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFixC3YRAO/TjP+RlE+ED3kassFFjU+kGYsHkRtWZlN3pWtVUV/d+zEb27mULmv4T3efl8/fQ==
X-Received: by 2002:adf:e38a:0:b0:354:f7a1:261a with SMTP id
 ffacd0b85a97d-3552fdfcb54mr5533880f8f.71.1716819420256; 
 Mon, 27 May 2024 07:17:00 -0700 (PDT)
Received: from fedora ([2a01:e0a:257:8c60:80f1:cdf8:48d0:b0a1])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3587724c6f4sm4214474f8f.28.2024.05.27.07.16.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 May 2024 07:16:59 -0700 (PDT)
Date: Mon, 27 May 2024 16:16:58 +0200
From: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 1/4] MAINTAINERS: drop audio maintainership
Message-ID: <ZlSV2uSApV7dRe2d@fedora>
References: <20240516120344.531521-1-kraxel@redhat.com>
 <20240516120344.531521-2-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240516120344.531521-2-kraxel@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mvaralar@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.034,
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

On Thu, May 16, 2024 at 02:03:38PM +0200, Gerd Hoffmann wrote:
> Remove myself from audio (both devices and backend) entries.
> Flip status to "Orphan" for entries which have nobody else listed.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  MAINTAINERS | 19 ++++---------------
>  1 file changed, 4 insertions(+), 15 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1b79767d6196..7f52e2912fc3 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1913,8 +1913,7 @@ F: include/hw/xtensa/mx_pic.h
>  Devices
>  -------
>  Overall Audio frontends
> -M: Gerd Hoffmann <kraxel@redhat.com>
> -S: Odd Fixes
> +S: Orphan
>  F: hw/audio/
>  F: include/hw/audio/
>  F: tests/qtest/ac97-test.c
> @@ -2388,7 +2387,6 @@ F: hw/virtio/virtio-mem-pci.c
>  F: include/hw/virtio/virtio-mem.h
>  
>  virtio-snd
> -M: Gerd Hoffmann <kraxel@redhat.com>
>  R: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
>  S: Supported
>  F: hw/audio/virtio-snd.c
> @@ -2767,7 +2765,6 @@ F: include/hw/hyperv/hv-balloon.h

For virtio-snd, I can join as Reviewer if that helps.

Matias


