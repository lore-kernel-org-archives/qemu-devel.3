Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A63DECA5FE1
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Jan 2026 22:10:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhaxh-0001Fu-3h; Sun, 18 Jan 2026 17:09:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vhaxf-00015W-Fh
 for qemu-devel@nongnu.org; Sun, 18 Jan 2026 17:09:31 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vhaxd-0001fo-Ld
 for qemu-devel@nongnu.org; Sun, 18 Jan 2026 17:09:31 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2a0d0788adaso23386235ad.3
 for <qemu-devel@nongnu.org>; Sun, 18 Jan 2026 14:09:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768774168; x=1769378968; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YwA+XxyWFDkORFNBlQmOw9xYRUenABDhu5WGq8pWY6s=;
 b=Zfg0cMHa1yPi2CTMgdR2jOx0X2nSPWRCIXGVoRisxmdot/U6fZR2ExWu6MPJ3LDLpn
 ViddAcTzRmjHGzUG/5Dr/7pcmVDtebPr5iC9+AxzQ4+XEJ/rVsvV3WGqKsDOZaoefPcB
 bX6HRpR+v2ZSRckhn7arOgHGVO+U9CNjkECOKJbAFrq+hYdkdsiNjdOJVPsr/UrHYbYU
 iiAhkkLdnVwZwxMCdLTPq8Fw3xNQHgsHIWdt29gtpOO5H/o0DVEFq1KLE2VUvECC7es1
 BvhAIP1H8TeK5ZHM5cXbAVrAsHhxDVrNIgD4in1RYlAFYMX4dcWOJH5Z3k7hOb3+FGI+
 Ia2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768774168; x=1769378968;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YwA+XxyWFDkORFNBlQmOw9xYRUenABDhu5WGq8pWY6s=;
 b=jK3IsNpX68z8nIWuJCe6jjsvrTIO8DiQmB5ISSM6D2PGRItyIWmZqFUDTRb1CTrVKE
 FHKrm3ecQKYj2dMBEkLieXDtgt57tc5MnHty97z7/cY6UKyD2drC0KCrzW82aZuD2NXx
 Yx3U+AkRr6MOAdxEeRSpOfQQPPDWrrGbNrVwKXFhmVu7fSG9f1nAxK5sB1/pTaEPP5Om
 /GSydwkObqGYdnL+BrqG+cQkfGzJt8m3bDkH4PMz+XCfu/IC5UVw/N11+1UsQX/NXXCU
 0cOi99QdFw/tr+fuZ+2b4j/MOweijBi120fliNFJ0I8k19KIsHySHCUhIAD1fAlTjdvT
 qg9w==
X-Gm-Message-State: AOJu0YyVod1XqPbNGEslXbYq8lvcEW4G2odhPWsanTM320+EsLQkaRiE
 1UXgt754Wg9EgHOPygUuOgvYH92ag2oG2WQqeAfs2kAki2HPUdIWdoXVZKLqDgUGfUYzr+SLjxp
 xg21J8JYhuw==
X-Gm-Gg: AY/fxX5nFRqX7x2X/zvh7KjTkT62Jqa5YD8CXqds0bqpJhoRJt5tyxV4tZlmoTVpxuK
 uwS3fqtZGH2Tjc9w4a9tiCyfELRGODY3w6EtZXVCGcpbOddsy273HApSNkyW0cIiLQVtYrYuTzR
 XG0tGDTnv/FMSumSI75y248gGUxQwWcDoSR8VrHlnE+qiB1LC8d4VWls2022XWDfABT5rQwIM+0
 W6KLMEqABhe/Z8hO2UjxfCsw7aQt6XQhsCAjBFZkVVrlEd/4URmcljUX2pJJ/PIXSoX2fL1xYFb
 t4XYXyajrSY+5HEsEsk/L3Q3YTnmw+CMNry92edFlgk9piS/ZQw+rhrdUuNu/Ddj0wt1mBaTp2X
 kCr8oTliTvPnso6aGZV4vUMJvDbqO0pgETs/EMyOdFcsZyb8EZKY+5YdRJi4IvoKrs0e4a0yVZ4
 w7ehkrqjTPsT+xmNcla0SjelrkLdpZ
X-Received: by 2002:a17:903:41c7:b0:297:f8d9:aad7 with SMTP id
 d9443c01a7336-2a7177dfcb2mr83654925ad.50.1768774168266; 
 Sun, 18 Jan 2026 14:09:28 -0800 (PST)
Received: from stoup.. ([180.233.125.201]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a7190ab921sm73298205ad.8.2026.01.18.14.09.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Jan 2026 14:09:27 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 53/54] meson: Remove CONFIG_ATOMIC64
Date: Mon, 19 Jan 2026 09:04:13 +1100
Message-ID: <20260118220414.8177-54-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260118220414.8177-1-richard.henderson@linaro.org>
References: <20260118220414.8177-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

This config is no longer used.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 meson.build | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/meson.build b/meson.build
index 0189d8fd44..3108f01e88 100644
--- a/meson.build
+++ b/meson.build
@@ -2939,22 +2939,6 @@ config_host_data.set('HAVE_BROKEN_SIZE_MAX', not cc.compiles('''
         return printf("%zu", SIZE_MAX);
     }''', args: ['-Werror']))
 
-# See if 64-bit atomic operations are supported.
-# Note that without __atomic builtins, we can only
-# assume atomic loads/stores max at pointer size.
-config_host_data.set('CONFIG_ATOMIC64', cc.links('''
-  #include <stdint.h>
-  int main(void)
-  {
-    uint64_t x = 0, y = 0;
-    y = __atomic_load_n(&x, __ATOMIC_RELAXED);
-    __atomic_store_n(&x, y, __ATOMIC_RELAXED);
-    __atomic_compare_exchange_n(&x, &y, x, 0, __ATOMIC_RELAXED, __ATOMIC_RELAXED);
-    __atomic_exchange_n(&x, y, __ATOMIC_RELAXED);
-    __atomic_fetch_add(&x, y, __ATOMIC_RELAXED);
-    return 0;
-  }''', args: qemu_isa_flags))
-
 # has_int128_type is set to false on Emscripten to avoid errors by libffi
 # during runtime.
 has_int128_type = host_os != 'emscripten' and cc.compiles('''
-- 
2.43.0


