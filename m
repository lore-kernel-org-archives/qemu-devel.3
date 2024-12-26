Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 926E0E77192
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Dec 2024 08:29:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQjEK-0002ix-2V; Thu, 26 Dec 2024 03:28:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3mxNtZwgKCrgusfYmrqfemmejc.amkocks-bctcjlmlels.mpe@flex--wuhaotsh.bounces.google.com>)
 id 1tQjE8-0002Da-Jc
 for qemu-devel@nongnu.org; Thu, 26 Dec 2024 03:28:17 -0500
Received: from mail-pj1-x104a.google.com ([2607:f8b0:4864:20::104a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3mxNtZwgKCrgusfYmrqfemmejc.amkocks-bctcjlmlels.mpe@flex--wuhaotsh.bounces.google.com>)
 id 1tQjE7-00019V-2i
 for qemu-devel@nongnu.org; Thu, 26 Dec 2024 03:28:16 -0500
Received: by mail-pj1-x104a.google.com with SMTP id
 98e67ed59e1d1-2ee5668e09bso7870089a91.3
 for <qemu-devel@nongnu.org>; Thu, 26 Dec 2024 00:28:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1735201691; x=1735806491; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=VGy+Nj9c83OW8O8chp58gNtXq2XnteX0cby7ElrxjQo=;
 b=YsGwfEYGQI/ItVd3c/VVXJYqfQDEjZpaVSVtX2tgWDYBcYqieo6taqCRzJ2Jasj95t
 8p7B1uTK6QUBVp2FjIB3CPI3BgEQBrSVtoPrsMTlwVxi4O9jQHM5Gd2jPuGALstzTzBq
 KM6kLWFYpyO3CiAPtcy0YwwuJdp2zaS2tZymsVvvATcCHj4maFX3fxR3WpqSDU1GxUJ3
 PMYJetUuHb2NcOzrQUvO6nOSb614+LjIFDQ0mUKN3N1kBTjtY6H6RNLddtdanWR2IPEN
 r5idH+NTZeIFdb0vo2sAW/zRNwP+kx1i9fiKc7P4C0wOAYO8GAhZBc9hfl/0LpqYVJoH
 u8jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735201691; x=1735806491;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VGy+Nj9c83OW8O8chp58gNtXq2XnteX0cby7ElrxjQo=;
 b=e5Gj6bZZR1NwG+a55ulGIoAQ0zjeeE4H3l2AnF0yA5GIkqUDfJVf9I0emz0Q1BFEGC
 9iHRXnab/Yc9ASMBqhFFibCB2SvsyGhO5msa1aWSyRNLkLd5Zzb85YKn4sx0k+jsuU6R
 rH5j/hssJvO25dnJ82/ZVhvKFnfG4g3+A6QAdwupMuUfDUqncPnLUFisg3UbJU8yT2Ua
 FBjtvIG13KtnbSyaY8kqzUVJ74R++JrmEJY7qoxi2i7H6tcGw3dJAv/sba9r7TonWbo0
 0ctB7SAZVT8bFlE/2G70V/26igsbstL/VMTTICM7P1QHcW4Js9IqZ5E+XorNr8m/Q64T
 7gmg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXbD1WRpK9MTXOOinuUKcGsgCH6N+hqwCnj9xylJghQGoVr+AHcivHU7AR/s3TqSj5Ldqg+JdW3GHro@nongnu.org
X-Gm-Message-State: AOJu0YxT/kx9V/AUaBKJti+Gl90RzZyFPsbUgG2lb98WpB34y7OyUueY
 AEFntIELDc7Dq4SYUgtY8W9SrOVoRna/yRBHupT2Haz3z2QHVTG/hZI9eNijMn9NJ0lIcU+/h/N
 GR3NaZu5V8A==
X-Google-Smtp-Source: AGHT+IH0u3SEk4oFQ7ftwSoVSjUFRzp9bdsVlx0CgqOMIVEkmooDOUOSLyNvBr+QI7IZSpYeR+vec7IrCr3B1w==
X-Received: from pjur6.prod.google.com ([2002:a17:90a:d406:b0:2ea:d2de:f7ca])
 (user=wuhaotsh job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90a:fc48:b0:2ee:8e75:4aeb with SMTP id
 98e67ed59e1d1-2f452e49238mr34728560a91.17.1735201691592; 
 Thu, 26 Dec 2024 00:28:11 -0800 (PST)
Date: Thu, 26 Dec 2024 08:27:45 +0000
In-Reply-To: <20241226082800.2887689-1-wuhaotsh@google.com>
Mime-Version: 1.0
References: <20241226082800.2887689-1-wuhaotsh@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241226082800.2887689-3-wuhaotsh@google.com>
Subject: [PATCH v2 02/17] roms: Update vbootrom to 1287b6e
From: Hao Wu <wuhaotsh@google.com>
To: peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, Avi.Fishman@nuvoton.com, 
 kfting@nuvoton.com, titusr@google.com, mimik-dev@google.com, 
 hskinnemoen@google.com, venture@google.com, pbonzini@redhat.com, 
 jasowang@redhat.com, alistair@alistair23.me, Hao Wu <wuhaotsh@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::104a;
 envelope-from=3mxNtZwgKCrgusfYmrqfemmejc.amkocks-bctcjlmlels.mpe@flex--wuhaotsh.bounces.google.com;
 helo=mail-pj1-x104a.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=unavailable autolearn_force=no
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

This newer vbootrom supports NPCM8xx. Similar to the NPCM7XX one
it supports loading the UBoot from the SPI device and not more.

We updated the npcm7xx bootrom to be compiled from this version.

Signed-off-by: Hao Wu <wuhaotsh@google.com>
---
 pc-bios/npcm7xx_bootrom.bin | Bin 768 -> 768 bytes
 roms/vbootrom               |   2 +-
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/pc-bios/npcm7xx_bootrom.bin b/pc-bios/npcm7xx_bootrom.bin
index 38f89d1b97b0c2e133af2a9fbed0521be132065b..903f126636f9ef5d1100c056656ccfb2b32e5e10 100644
GIT binary patch
delta 90
zcmZo*Yhc^(l+nU*!D9x6DNkDr=09a-2ztoGz`#|*F#jn7L;r()|Np;c0m>C1$z?$0
Ywog`Ma%Vh0Ig_b-VgU<}A_D>d06Rh+WdHyG

delta 69
zcmZo*Yhc^(lu^NO!D9x2$xoRb7CdZGnE#ZCA@Cs+0|QqL!~CZV4E+!GPG)41X52Pe
SmdTy*+~icIZXQJj1ONb5*AzJb

diff --git a/roms/vbootrom b/roms/vbootrom
index 0c37a43527..1287b6e42e 160000
--- a/roms/vbootrom
+++ b/roms/vbootrom
@@ -1 +1 @@
-Subproject commit 0c37a43527f0ee2b9584e7fb2fdc805e902635ac
+Subproject commit 1287b6e42e839ba2ab0f06268c5b53ae60df3537
-- 
2.47.1.613.gc27f4b7a9f-goog


