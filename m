Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21D57C54E5D
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 15:38:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk4Cn-0005Fe-Kn; Tue, 12 Mar 2024 11:38:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rk4Cm-0005Eb-0f
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 11:38:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rk4Ck-0001is-Hy
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 11:38:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710257894;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ahIXFhIHzJ08NkMnyeBLx8/F63eTlvmrRzQgkKxdmlQ=;
 b=H5Bdn3aES3JvFO2dkH91R9EcvsUjuLZ64BBw/BOYinl5QV04S0Tx/sFRQy4FBTPikpIZF+
 fEieEwhdU23fO3WWtjn0DR56xbGlUjT1JPoib4a0ZbzTVi1Wi5PhDwdZVX8URGo67U1y+v
 RVLLCJLDK0S6jpWFWHVQ30X2RIpPd2w=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-102-sBdEZzquNy-8WN3ocNKgag-1; Tue, 12 Mar 2024 11:38:12 -0400
X-MC-Unique: sBdEZzquNy-8WN3ocNKgag-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-40e4478a3afso430015e9.1
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 08:38:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710257891; x=1710862691;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ahIXFhIHzJ08NkMnyeBLx8/F63eTlvmrRzQgkKxdmlQ=;
 b=tCM7HMUv1+RXTSQ4CQOqIQZ5nuE0Hx/dh55wTbuYJJfnk9G+RSwTDdd9Y1hqzy4V+5
 gMa6ySsPEDZ0uM/pTAwHwGOHTs3aaN8OTfUMX9x6sKbL6nlPdAV8kVfiseXeAcyQ3qAZ
 6Kng5ggPE5iIhtaJDRr9A9WS3BVF71ui/3mg/esbRITq8uLsoShDvUL1A3Ca7SZGrRSh
 nURKKoLFsVCSH2nzyy08kbyFCgSW7qfseTgbJRnj6mH5/nkp+5R05HLqms9lsljbLUuF
 wVLtlvT04Y/O7eMjEjKBmlBJYzcwjfN0rjjh3teVUwldBFJmTeHoRE8WzLWjCyJ22CzJ
 Wr2A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWZked7+3t6AxzLnEST4Bh9tro+Q/0WoiFEJ65uNf0YVyxK4D2UaSyoaNUj5fiTpsp0GYQdhkCCdDi3bCICBWuPl4P8Tuw=
X-Gm-Message-State: AOJu0Ywbrt1WjKg9CZuTa2avTOUqy1xlnrLnEZPhHWebLy2MBl2Y+DUH
 Zo329Qelu9kGABKr1QMNl4uG5gvuo3y6gCmfhUTda9MGt0pRQ9GezyJvLOSJoQ/oMuD8V8xEyUz
 dI7dIY5jT8/BrsGGhLv11Y7yBZUd0nBAcrmBPP+uu7n1jKPYYIIF9
X-Received: by 2002:a05:600c:35c8:b0:413:1619:a78 with SMTP id
 r8-20020a05600c35c800b0041316190a78mr9258758wmq.4.1710257891058; 
 Tue, 12 Mar 2024 08:38:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE/OaycOAag861/UDt3DS8HMzFi1/ohYQwJR/KnbsvSlt6yRSFYndFv6ABhUqBy2VmRzZoXLA==
X-Received: by 2002:a05:600c:35c8:b0:413:1619:a78 with SMTP id
 r8-20020a05600c35c800b0041316190a78mr9258715wmq.4.1710257890277; 
 Tue, 12 Mar 2024 08:38:10 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f0:532c:5ae4:fce6:76e1:fa1a])
 by smtp.gmail.com with ESMTPSA id
 fb7-20020a05600c520700b0041328d0440csm8082927wmb.31.2024.03.12.08.38.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 08:38:09 -0700 (PDT)
Date: Tue, 12 Mar 2024 11:38:05 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Volker =?iso-8859-1?Q?R=FCmelin?= <vr_qemu@t-online.de>
Cc: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 qemu-devel@nongnu.org, qemu-stable@nongnu.org
Subject: Re: [PATCH v2 00/11] virtio-sound migration part 1
Message-ID: <20240312113646-mutt-send-email-mst@kernel.org>
References: <a289a081-9a61-4bcb-b693-bf6cd7768c0e@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a289a081-9a61-4bcb-b693-bf6cd7768c0e@t-online.de>
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

On Sun, Feb 18, 2024 at 09:31:02AM +0100, Volker Rümelin wrote:
> Here is the first part of my virtio-sound patches. Most of them are a
> preparation to make migration work. Patch 10/11 enables migration.
> 
> The second part isn't finished yet and will have to do with virtio-sound
> jack and channel maps configuration and migration.
> 
> Patch 01/11 "hw/audio/virtio-sound: return correct command response
> size", patch 02/11 "hw/audio/virtio-sound: fix segmentation fault in
> tx/rx xfer handler" and patch 05/11 "hw/audio/virtio-sound: free all
> stream buffers on reset" are candidates for stable-8.2. Patch 05/11
> either needs patches 03/11 and 04/11 or has to be rewritten for stable-8.2.


So I queued patch 1 since that's a bugfix.
Patch 2 can go in after you address Manos's comment.
Rest - after release.


> v2:
> The patches were reordered to facilitate the backport of 3 patches to
> QEMU stable-8.2.
> 
> Patch 02/11 "fix segmentation fault in tx/rx xfer handler" has been
> completely rewritten.
> 
> Patch 04/11 "hw/audio/virtio-sound: allocate an array of streams" has
> been renamed. The subject and the commit message describe the patch better.
> 
> Patch 05/11 "hw/audio/virtio-sound: free all stream buffers on reset" is
> an additional patch.
> 
> Patch 07/11 "hw/audio/virtio-sound: add stream state variable" resets
> the state variable on reset. Once a stream has been opened, it will only
> be closed after a reset or when QEMU shuts down.
> 
> Patch 10/11 "add missing vmstate fields" resets the inuse variables on
> reset.
> 
> Volker Rümelin (11):
>   hw/audio/virtio-sound: return correct command response size
>   hw/audio/virtio-sound: fix segmentation fault in tx/rx xfer handler
>   hw/audio/virtio-sound: remove command and stream mutexes
>   hw/audio/virtio-sound: allocate an array of streams
>   hw/audio/virtio-sound: free all stream buffers on reset
>   hw/audio/virtio-sound: split out virtio_snd_pcm_start_stop()
>   hw/audio/virtio-sound: add stream state variable
>   hw/audio/virtio-sound: introduce virtio_snd_pcm_open()
>   hw/audio/virtio-sound: introduce virtio_snd_set_active()
>   hw/audio/virtio-sound: add missing vmstate fields
>   hw/audio/virtio-sound: add placeholder for buffer write position
> 
>  hw/audio/trace-events         |   3 +-
>  hw/audio/virtio-snd.c         | 776 ++++++++++++++++++----------------
>  include/hw/audio/virtio-snd.h |  29 +-
>  3 files changed, 427 insertions(+), 381 deletions(-)
> 
> -- 
> 2.35.3


