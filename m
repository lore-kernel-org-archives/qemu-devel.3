Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BDF3C3DA63
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 10:57:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWDCT-0005Nz-BL; Tue, 23 Jul 2024 06:56:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sWDCP-00055X-Mf
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 06:56:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sWDCN-0001lL-Rn
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 06:56:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721732211;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g0S4hWSM06AIIIvMLr4s6kHBfIjfxBV9+M5h/WPYNyI=;
 b=KERljwoP6zoUHktrkJH4gK8fqz2ZTv2FwtUV1qFPH1kiamExE8sI02ZSeV9AfvqW4Fa0/Z
 GQPxcTHGCPh76hTZnyEsy0K5mYKfGmrdOdRjeKYBd/hbRDC+a9pcdX5JPehvXYgMw7fGNH
 HZ9WsUEiWFHxdHWK20rVh2l7fPO0PSs=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-qk1FQLxzNgipUY9LWDBprw-1; Tue, 23 Jul 2024 06:56:49 -0400
X-MC-Unique: qk1FQLxzNgipUY9LWDBprw-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-52efc9f2080so2620011e87.3
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 03:56:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721732207; x=1722337007;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=g0S4hWSM06AIIIvMLr4s6kHBfIjfxBV9+M5h/WPYNyI=;
 b=RcDsUooBne3bIUhQU8rKlP1WGIlzyzuCE3BdjXAx8BUEdJAxzq4MGK+jxeN+tbe82w
 OTNpeG+5/DLLKUDzp4oRyaA1asUTmq7xrHQaTnABucEdizp7qmUm+lES6NL7LnLYzEjO
 mzFkrLnCkk2Q2XmiYGg01FZgynAZB7iSGLUvTGoPyyF3bt9GFVFMBZeqviz10fDntNGt
 az4HUzfMudjuWSjKoq3CCR5DQZUlYeQqHIUrllxplQ+CsIHZv7vkHyD24D8gipi5TKzW
 WS7ksp/NQFYN/9rH0WISg9414Yta1A13/a5iN9p2Ku9v19OvYG9FzsOBiZOhh8indpym
 ItYw==
X-Gm-Message-State: AOJu0Yx3RuFdW0Oo9uYFnOBzkO7Dh4Rakt8oUaqLXo/n7E3TUipYW59V
 nwyAMnj24GMc0NFmnX/aDxJsQkfc4yCr823vUVJwgDJ6PRToD96DW6PRFSkGLZuQqn5pU8c8HvD
 mr2v0RHyWP6jW+qls6wnRO8LFuNhJ4h3yiB7Zk+6WLirCBQegfFQAENQa8gnR6R5OFWa2GCbPws
 ik5yVtfIty3t8gKmtXFfx8KovXxLDHhw==
X-Received: by 2002:a05:6512:3d88:b0:52c:e0ce:2d32 with SMTP id
 2adb3069b0e04-52efb830c92mr6113915e87.36.1721732207221; 
 Tue, 23 Jul 2024 03:56:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHc0VxlKxATko0Gnhu0Jn9ExUHt61MMhGDKdijp/QoF4C/PIjqdCNvyv7tdyehsG2ZNWQbznA==
X-Received: by 2002:a05:6512:3d88:b0:52c:e0ce:2d32 with SMTP id
 2adb3069b0e04-52efb830c92mr6113888e87.36.1721732206561; 
 Tue, 23 Jul 2024 03:56:46 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:440:9c9a:ffee:509d:1766:aa7f])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7a9fe99a67sm38047666b.168.2024.07.23.03.56.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jul 2024 03:56:46 -0700 (PDT)
Date: Tue, 23 Jul 2024 06:56:41 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Zheyu Ma <zheyuma97@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PULL v2 17/61] virtio-snd: check for invalid param shift operands
Message-ID: <9b6083465fb8311f2410615f8303a41f580a2a20.1721731723.git.mst@redhat.com>
References: <cover.1721731723.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1721731723.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

When setting the parameters of a PCM stream, we compute the bit flag
with the format and rate values as shift operand to check if they are
set in supported_formats and supported_rates.

If the guest provides a format/rate value which when shifting 1 results
in a value bigger than the number of bits in
supported_formats/supported_rates, we must report an error.

Previously, this ended up triggering the not reached assertions later
when converting to internal QEMU values.

Reported-by: Zheyu Ma <zheyuma97@gmail.com>
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2416
Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Message-Id: <virtio-snd-fuzz-2416-fix-v1-manos.pitsidianakis@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/audio/virtio-snd.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
index e6432ac959..e5196aa4bb 100644
--- a/hw/audio/virtio-snd.c
+++ b/hw/audio/virtio-snd.c
@@ -282,11 +282,13 @@ uint32_t virtio_snd_set_pcm_params(VirtIOSound *s,
         error_report("Number of channels is not supported.");
         return cpu_to_le32(VIRTIO_SND_S_NOT_SUPP);
     }
-    if (!(supported_formats & BIT(params->format))) {
+    if (BIT(params->format) > sizeof(supported_formats) ||
+        !(supported_formats & BIT(params->format))) {
         error_report("Stream format is not supported.");
         return cpu_to_le32(VIRTIO_SND_S_NOT_SUPP);
     }
-    if (!(supported_rates & BIT(params->rate))) {
+    if (BIT(params->rate) > sizeof(supported_rates) ||
+        !(supported_rates & BIT(params->rate))) {
         error_report("Stream rate is not supported.");
         return cpu_to_le32(VIRTIO_SND_S_NOT_SUPP);
     }
-- 
MST


