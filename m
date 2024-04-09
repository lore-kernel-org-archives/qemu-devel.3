Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDC56CD1284
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 11:35:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ru9jv-0000tW-9r; Tue, 09 Apr 2024 07:34:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ru9jt-0000tE-4b
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 07:34:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ru9jq-00028B-Jr
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 07:34:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712662445;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1E7X/j1t2MysXmzu6WTPy1/Ear62N1jqrtH8eo1uiPA=;
 b=YYzN0AMuzhhDTQXZuy111zP9pa0pTMf6ZGeRv0v8Pk2BRGUoDRGAoOxkHBW3zsFKUAt/AT
 Roh2fYrx9z78axEgwnGBhklHvrLcRbgiFuCP8sDG1MgyEfRPbK2nwl0joVk+OFkfc7GUoe
 wold7axPMdnjcxwgvGVqSWCXCeHhRuw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-403-tKcfQpq6PnyqYEc0v4m1Gw-1; Tue, 09 Apr 2024 07:34:03 -0400
X-MC-Unique: tKcfQpq6PnyqYEc0v4m1Gw-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-343d3e1ff1eso3035908f8f.3
 for <qemu-devel@nongnu.org>; Tue, 09 Apr 2024 04:34:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712662442; x=1713267242;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1E7X/j1t2MysXmzu6WTPy1/Ear62N1jqrtH8eo1uiPA=;
 b=Qw9vredEm6DfNeG7+fGK1YlWUq2j7HiTirZES1kW5pNnUCYSmfXVSWrqD8hMTwo89H
 18Q7ahTLbRMLWhsgfcTUPH6Bj8tseqx3GObUQN1UeMSNMDERXztGXOW5+1smovDrix2l
 +1B2inRhV0rvBeEm1B0dxIXpQwZ1PrzbZO8MfIi6vJfM7al1T8Y6uvqSKBW4iBvssaz4
 d2JTEaLRB/TUKFxMtvT28kcUFYhSSQBwaQm3Df3O7EvFy1TMF2OBDMb14kx50RSYZlhk
 ejczijCJPnMjT9bkd8JKsOIzAJdYH1O8nqp3gMLD0GayoMfw0nneXBCldOV5jTt6oV6/
 cxlg==
X-Gm-Message-State: AOJu0Yyt7XxSY/a4j2dp0/vE/pCx/6Pjc8uZ0B4tALWQALb2AAInRDmS
 Mz+ue4XgcI0X/5TGdGOhOnr83QR4TluzerN/SCHW1xfbPEbZNdYhf88hjGO2Ah2MWxaugqoe++R
 wMy9f+lLc7bZ5bPm5YO8FkQcajj5+XXLN7x5HDYpJIrj9KAqZn+nt
X-Received: by 2002:a5d:6946:0:b0:343:8551:8d90 with SMTP id
 r6-20020a5d6946000000b0034385518d90mr10328878wrw.34.1712662442512; 
 Tue, 09 Apr 2024 04:34:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGzUA1yjCWtw3wJzXaQJPinDJoIEpALsrinwM+Rjnw3WkJUUsck4A7NIIDrytYVoPya7x0Frg==
X-Received: by 2002:a5d:6946:0:b0:343:8551:8d90 with SMTP id
 r6-20020a5d6946000000b0034385518d90mr10328854wrw.34.1712662441985; 
 Tue, 09 Apr 2024 04:34:01 -0700 (PDT)
Received: from redhat.com ([2.52.134.26]) by smtp.gmail.com with ESMTPSA id
 jg25-20020a05600ca01900b00416928e239csm4127376wmb.35.2024.04.09.04.34.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Apr 2024 04:34:01 -0700 (PDT)
Date: Tue, 9 Apr 2024 07:33:58 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Amit Shah <amit@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 Laurent Vivier <lvivier@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [PATCH-for-9.0 v2 0/4] hw/virtio: Protect from more DMA
 re-entrancy bugs
Message-ID: <20240409073320-mutt-send-email-mst@kernel.org>
References: <20240409105537.18308-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240409105537.18308-1-philmd@linaro.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.701,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Apr 09, 2024 at 12:55:33PM +0200, Philippe Mathieu-Daudé wrote:
> Fixes for CVE-2024-3446.
> 
> Gerd suggested to use the transport guard to protect the
> device from DMA re-entrancy abuses.
> 
> Since v1:
> - Take a DeviceState argument, not VirtIODevice, so it
>   works seamlessly with CCW devices (actually the original
>   code from Gerd).
> - Build and test :>
> 
> I'll send a PR with these patches later today.

I reviewed these too now

Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

> Regards,
> 
> Phil.
> 
> Philippe Mathieu-Daudé (4):
>   hw/virtio: Introduce virtio_bh_new_guarded() helper
>   hw/display/virtio-gpu: Protect from DMA re-entrancy bugs
>   hw/char/virtio-serial-bus: Protect from DMA re-entrancy bugs
>   hw/virtio/virtio-crypto: Protect from DMA re-entrancy bugs
> 
>  include/hw/virtio/virtio.h  |  7 +++++++
>  hw/char/virtio-serial-bus.c |  3 +--
>  hw/display/virtio-gpu.c     |  6 ++----
>  hw/virtio/virtio-crypto.c   |  4 ++--
>  hw/virtio/virtio.c          | 10 ++++++++++
>  5 files changed, 22 insertions(+), 8 deletions(-)
> 
> -- 
> 2.41.0


