Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4EB7C54E60
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Mar 2024 19:27:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rj2HH-0000CV-3D; Sat, 09 Mar 2024 14:22:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rj2HF-0000BW-9p
 for qemu-devel@nongnu.org; Sat, 09 Mar 2024 14:22:37 -0500
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rj2HC-0002Si-Vw
 for qemu-devel@nongnu.org; Sat, 09 Mar 2024 14:22:37 -0500
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-a450bedffdfso408583966b.3
 for <qemu-devel@nongnu.org>; Sat, 09 Mar 2024 11:22:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710012153; x=1710616953; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hXABjAaMhxHgVCCn4BlGHy0+qqoq0gDIyiPdTnOnZyc=;
 b=mfsMsTYkDCpgjf2QMCF2eoAcYTW4ZyH08BAH20vmzKCLBsafDfXyM29j4rw9LIXOIp
 Qg4s6KzOEXV6AwBmGF9ZrB2sfT0kPXUVt0KBKkuJLVjvimqXOjnQmACaqfAcIzX8UoHb
 PKNFiK9jVQNKdkHJt9qow0RjOX382GViTFkKUH1nFZLImaTLiGC27cLjZ+R/uVGfQEV6
 Bc1ZsC2wZeENotgdiXhULYMVlPp4rtrHjJ5VFBI4gEMrP04nlAmaVk7B15pGBoNNQmB7
 sy9TexOj/3dLAqhM6YMHgx8/dWaVs5Vt6iVsEcNkD5AKgsLCbR+Qc8HzOoI+AOgT4t9C
 zfgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710012153; x=1710616953;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hXABjAaMhxHgVCCn4BlGHy0+qqoq0gDIyiPdTnOnZyc=;
 b=MhpagmTUNjTxxxwaNfhMlLWxO+RMOhKEqrxCr9nRKOc4W3KtcqtW13c+ECZtpQg54O
 c/+Zu8g8qphQFZaeV4fduMIzGtpL0WDDBsy+IWR4fqbPmvRf9PA61BlnHRO7vHPhvays
 Ji/RHT4VEgN0bYPOYONFO+2gn/2xIjNCb/JES2hKKTYGAuaWVbOOLr2/wfU9BWlJ/C3t
 S1/9hbhSlm9wePExcuyaHDXHMBEoQ4inBn3sLwUaDMXAeZ96ym8SxCWPYf4u/eidiZvA
 gjwAnVU3AF2cn7WYvQGaJwO2HY9KaFQftXmBBpQzUk4WDuzqHdCw6vzifsFZ+ySvLRFe
 4vgg==
X-Gm-Message-State: AOJu0YwXW/a39b9G5l1I8q3rBF7m8N+bTSGCEfIcBexsx3CmuBn2FLjK
 XEOXRSfW9DZ6uxjrQ4a7Syzjo/V2HJDi0Umc7UR5kRryGPsZfgWEPNMnouDd2umjiQyklfyxccu
 h
X-Google-Smtp-Source: AGHT+IG1/vyvQGvmM09S/M6+IuzayHPuZieilQc2Rg23/rY/x2WN2KV9nhRWH7snP7zUoE6gG7SZXw==
X-Received: by 2002:a17:906:4f02:b0:a44:446b:e99e with SMTP id
 t2-20020a1709064f0200b00a44446be99emr1256763eju.31.1710012153357; 
 Sat, 09 Mar 2024 11:22:33 -0800 (PST)
Received: from m1x-phil.lan ([176.176.181.237])
 by smtp.gmail.com with ESMTPSA id
 sd21-20020a170906ce3500b00a45f3524ac3sm1161512ejb.118.2024.03.09.11.22.32
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 09 Mar 2024 11:22:32 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 David Woodhouse <dwmw@amazon.co.uk>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>,
 xen-devel@lists.xenproject.org
Subject: [PULL 03/43] sysemu/xen-mapcache: Check Xen availability with
 CONFIG_XEN_IS_POSSIBLE
Date: Sat,  9 Mar 2024 20:21:30 +0100
Message-ID: <20240309192213.23420-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240309192213.23420-1-philmd@linaro.org>
References: <20240309192213.23420-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

"sysemu/xen.h" defines CONFIG_XEN_IS_POSSIBLE as a target-agnostic
version of CONFIG_XEN accelerator.
Use it in order to use "sysemu/xen-mapcache.h" in target-agnostic files.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
Message-Id: <20231114143816.71079-4-philmd@linaro.org>
---
 include/sysemu/xen-mapcache.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/sysemu/xen-mapcache.h b/include/sysemu/xen-mapcache.h
index c8e7c2f6cf..10c2e3082a 100644
--- a/include/sysemu/xen-mapcache.h
+++ b/include/sysemu/xen-mapcache.h
@@ -10,10 +10,11 @@
 #define XEN_MAPCACHE_H
 
 #include "exec/cpu-common.h"
+#include "sysemu/xen.h"
 
 typedef hwaddr (*phys_offset_to_gaddr_t)(hwaddr phys_offset,
                                          ram_addr_t size);
-#ifdef CONFIG_XEN
+#ifdef CONFIG_XEN_IS_POSSIBLE
 
 void xen_map_cache_init(phys_offset_to_gaddr_t f,
                         void *opaque);
-- 
2.41.0


