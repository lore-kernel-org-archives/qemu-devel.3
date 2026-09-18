Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B839FC88E75
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 07:36:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7T7x-0005fT-7x; Fri, 18 Sep 2026 03:35:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1x7T7n-0005cN-EP
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 03:35:11 -0400
Received: from mail-wm2-x11.google.com ([2a00:1450:4864:31::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1x7T7k-0007A5-3N
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 03:35:11 -0400
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-49e71cdb22bso3098975e9.2
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2026 00:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789716907; x=1790321707; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=TfWtRMVTGUYok1dnpe7O4lkf1E1YGNiXpJ5wSK2yxSE=;
 b=nB4Y/aTEVi76I6/7faUyrjkjXna/HuXr5Y+7II7mPf18tP+ngcNFHKDD5y+LzrGj6p
 Dc6JbYKfAnjqQ4cTK9YiQKP31PKfeNN/Xe2AkFkwMYA802l7excVGx1yJeLV4Nzs5pD7
 Vmi4g0KvTsG+yoPPtGNlam7ZYcViXtz3IQqq7vm24ekR1fjFvrhdgPREiXMrEgvtjbk5
 0O2XxkCdkC1VdQbGkAFjAK4o2F7EcbLFGvJbcwvGKMk1I5MeXE/p/HoX8OvYPCbGFwd9
 d9Koc+YN6Z/wFnjp0MMG0jsKD/t1+L9sZZh0eJ3TvwShT4TN1/6LGXoyQSt87tguqZn5
 UGjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789716907; x=1790321707;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=TfWtRMVTGUYok1dnpe7O4lkf1E1YGNiXpJ5wSK2yxSE=;
 b=aCuZQRk79LLJ1oBHfTEOA86Jq7tn3zuXA+jkznGDBZ6cWYWKpPtBnb11Ec4ypSPgyJ
 IA7RV6oWldBJONDdHzjKhizHay67sg4rHeJx41xd6RNZCY+9UlB49SdwrQ/rl+hOKpMV
 mfBS4fEYkRkvSyp7fM65sFN7ER9/Zf4vr3GJJ3WPNFH0sdOet/ENhdefFV/Pwqcv5HNV
 LCEtA45oQiIZcrn0VtVdcIeN5JrXm8phmPXv6U6o83Ybo8saOtF3Kk6y79jlJhXbAz3c
 XAT1YcCCwLsDu2E3kvU/JWK923YLyUgYtWHdv1ktTQFQeAjJfGKYQ/syqY5T/sL3SwQl
 M37A==
X-Gm-Message-State: AFuF++mpVIAni77y7F2Pt0rP4XnsZfD/A/9EJbwH3P00ubOQucvludWZ
 YmOKqV9K7lVYwBuO2N4dGYe4jMionBOJ62+vDP1ytuT+j9iGQ/LbpWvcmsI+1KrbjXHC3Pptlsw
 noa3nMcI=
X-Gm-Gg: AYBFou1MIzF7E+nBYsRsmOGHznelIePFfG2i4TakcdtcAwfkEz1PAXzhKCMapMrLIs2
 jXjJIBEb+Q3Xc0KaEGUAyCF/01XUe1xJyRFhDTqIRtFc1SbkwamQayMu3Xja1k2zqCY55PsWzpm
 53xntpmZDLZ7bFJcMiduhbDkOcpSw7OBbj0Qmql0nvYoa/t9+ifQLo0+8+RYBkWwFnSYSfu2cU7
 VFx3et3zOF/K0hq5qRKz/4qJQfXFvI43l64N7K1czEKKoxObUVDFkWbcncUzEwtReZDTK/1+rnw
 kBINFexc/xzfMiYFMj3bTXma4es4H3kpBumykE7sTf2WYeXV2/C5OlhUmHC3AnM5ybFhoGEXn8t
 KnNFHBvsg/F4mrngx4TszJ51SKOu9WcDUrpNPpJqySV2DF5AcNYjVikbpCcCMheGUmT62GmuI9m
 BzkprUzP/QA59b/Rp0VHo+1m/hcRM/DuTVQsdlOw3679IhaIwCneV3xCWvFobDVnpU3ZyGQB4mg
 vccJnpCdwpjiiO9yUeh3RkyrYGGhY3gwsDsQvBR47tBhl/g0CTK3FBf2NcUeriQOkdj2SdZwFTH
 B4E9ftinAWS7Ue0L+AP5BD89ozlj8b23xgTaJGoWSGTMX5F8armYKwPb8tqhcAFouvEp/3n3FVd
 Tl1nqu5geLePVFZKTM9jVQcpYb+1Di6smo1kDeuJ+0qRf
X-Received: by 2002:a05:600c:6308:b0:49c:fa20:cbfd with SMTP id
 5b1f17b1804b1-49fc5728e35mr16994485e9.20.1789716906620; 
 Fri, 18 Sep 2026 00:35:06 -0700 (PDT)
Received: from localhost.localdomain (athedsl-116222.home.otenet.gr.
 [85.75.29.157]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fc471b9a2sm23879825e9.0.2026.09.18.00.35.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2026 00:35:06 -0700 (PDT)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PULL 02/10] hw/audio/virtio-sound: drop unused struct
 VirtIOSoundPCMStream.flushing field
Date: Fri, 18 Sep 2026 10:34:45 +0300
Message-ID: <20260918073502.3265143-3-manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260918073502.3265143-1-manos.pitsidianakis@linaro.org>
References: <20260918073502.3265143-1-manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:31::11;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm2-x11.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>

Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Message-ID: <20260803081159.91981-3-alexander@mihalicyn.com>
Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 include/hw/audio/virtio-snd.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/hw/audio/virtio-snd.h b/include/hw/audio/virtio-snd.h
index f8bb5c95b9..b60b098ccd 100644
--- a/include/hw/audio/virtio-snd.h
+++ b/include/hw/audio/virtio-snd.h
@@ -138,7 +138,6 @@ struct VirtIOSoundPCMStream {
     virtio_snd_pcm_set_params params;
     uint32_t id;
     VirtIOSound *s;
-    bool flushing;
     audsettings as;
     union {
         SWVoiceIn *in;
-- 
γαῖα πυρί μιχθήτω


