Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65E15C3DA5D
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 00:18:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVgkB-0004OV-1v; Sun, 21 Jul 2024 20:17:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sVgk9-0004JJ-P9
 for qemu-devel@nongnu.org; Sun, 21 Jul 2024 20:17:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sVgk7-0005lz-UU
 for qemu-devel@nongnu.org; Sun, 21 Jul 2024 20:17:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721607451;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g0S4hWSM06AIIIvMLr4s6kHBfIjfxBV9+M5h/WPYNyI=;
 b=YNP6aoaKCOK+C2Wj3Q6kfahdola9ecE+ahAOU6d5tQTqsVpLJzW06RZYxPOnl/ePAGUyiH
 J7jneUCF8Y0Fu3zlQBw4y0FTqotInI3zpuYMZqmPPIVUcmnEiSLyez8TIZ80n6aWRwmnLu
 2OsBqWz1d5y7ccwNpv5v0wWU+vOkKQQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-466-NgXSa-MrNfSg4Yeq_85D-w-1; Sun, 21 Jul 2024 20:17:28 -0400
X-MC-Unique: NgXSa-MrNfSg4Yeq_85D-w-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-42660bca669so25378775e9.0
 for <qemu-devel@nongnu.org>; Sun, 21 Jul 2024 17:17:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721607447; x=1722212247;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=g0S4hWSM06AIIIvMLr4s6kHBfIjfxBV9+M5h/WPYNyI=;
 b=vuOFc1i96HSux8WVpXQ3gowrk4Or0NdkrwUQVAOTvJ69yg2jGpKMw42iAL6m1d0Uey
 z3Dv8JelzVN9UHdRTyT3jsU9jA31IF4ibzRs3gbWZKBPPS8Hg4EH8Z9Cg5fVmNcbCW3w
 6Ybd/5OTbQhOhIbfg0U5v+IxC21jvtAtKzQreGi3uSRoDZZEdgKvtzTnCkyk9F1SjjoJ
 sGt3VaCzh2Z0OoibJ0SAtZ/jRPBnd4zOBpM2iWSvEc/6SZnBFuT09HmPITImln46L8mK
 zDuFv9sA0hPgzr+uVPcyyOR68tIaUhh/Pf4Qr64wRD8S1552bukOo8jMAMIYToB/lH9s
 kIMw==
X-Gm-Message-State: AOJu0YycUA+cEBZr+cA6cDg7yAxCkl2d8jqQTP0xRmEFib1OZQ3iTuKi
 xAw4i4Ifui3LmDkooidNevTqbIaX4/BgMVk369YqybjBjF1u6caZpzaCxkJlMei1NLo9qBPJ8Vl
 TLMxyAMEkmjcufceA9ld3af6NCdwgSkpspanyq8Xuh9K26d3fumnyGqNvRiEXBNlIAcJJmX2Tcr
 EXHxHeA7RFiNQn9g2vMPfPXzK8Sj3Odw==
X-Received: by 2002:a05:600c:190d:b0:426:66e9:b844 with SMTP id
 5b1f17b1804b1-427dc515427mr37324255e9.8.1721607447028; 
 Sun, 21 Jul 2024 17:17:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHvOb5riDtOVlMPVBcHkq5z28fjXS2hMV8i3Kx8UR/J/hWvBBqkXqNeuu1QvzANlYuQ03P3iA==
X-Received: by 2002:a05:600c:190d:b0:426:66e9:b844 with SMTP id
 5b1f17b1804b1-427dc515427mr37324065e9.8.1721607446515; 
 Sun, 21 Jul 2024 17:17:26 -0700 (PDT)
Received: from redhat.com (mob-5-90-113-158.net.vodafone.it. [5.90.113.158])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d2a94380sm133711655e9.39.2024.07.21.17.17.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 21 Jul 2024 17:17:25 -0700 (PDT)
Date: Sun, 21 Jul 2024 20:17:24 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Zheyu Ma <zheyuma97@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PULL 17/63] virtio-snd: check for invalid param shift operands
Message-ID: <9b6083465fb8311f2410615f8303a41f580a2a20.1721607331.git.mst@redhat.com>
References: <cover.1721607331.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1721607331.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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


