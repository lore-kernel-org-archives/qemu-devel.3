Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F8A5D7879F
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Dec 2025 16:21:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWdDH-0005zr-L2; Fri, 19 Dec 2025 11:20:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vWdDC-0005vK-59
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 11:20:14 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vWdDA-0005w1-Ma
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 11:20:13 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-47755de027eso11610535e9.0
 for <qemu-devel@nongnu.org>; Fri, 19 Dec 2025 08:20:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766161210; x=1766766010; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hkVIzod7Jlt9VwHGoLmEeZpRAVX+tz7dmFt8d4zgWHg=;
 b=W3VmZHqN1LKARt6uC1reYfwieeVGmPvgihF+0odTAYO6rxU6YfzHZPVYBW99trtIFG
 Y+WbVrDmaRRUXDGjJoLOyAPyck4t41YvHs+xV+c8pIQeKU+Pa3GaOfcWpsd1mGPCKQKg
 dHnPiKVHHbIKVe+f9P+Mxo2VeOZbyKPNTxDNwJL5GXPBmPgsGaSY53jzCH2rSWKrebuZ
 r5jfzsytGMshoh3mhlBMaDayrIo8jz/HlLVAslrZiSCfiAxmA07UFBcLdYTfCUwRrfT6
 iwlZ2ab5Gp99EVY2yHhxDbESVcg+mqor+DdtBa9Z6tN56KTk44fAkCu4mpT/uXekOlyS
 oxCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766161210; x=1766766010;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hkVIzod7Jlt9VwHGoLmEeZpRAVX+tz7dmFt8d4zgWHg=;
 b=e6bkWJIpFVtyKpH6YboYMHlsKUNPGezfOPuP0FxlsulWVHfBZm6xOfMWi5067v/vN2
 MRoba1jx5D5YRoEwYjvDHmuxO3iFYhTyobCVS4VFnF82XlvJOEvd+2eDWB5hLCKCRUTw
 iKf1LtSLizMukXulfCpoUBopPmifJkD3wSsv0OWD6mGsnl8ohcpV/xt4akWSp6n5sw2k
 3Cg3x2efLDsyXWWpzL6VBw4xNC2ivaM345R2s/ewpAw+q94HK4gfb/pZERWVeEYjLW0g
 BniT39mTZK47J4S/D1CGHSYawhznlK6z+FlTEZADE2DXYKaK1+I96juUhexOx9tOH7hW
 NKjQ==
X-Gm-Message-State: AOJu0YyPfRokEUxlOKGE+3eOeuEHKJ94H+XkKKtzTnGRUD76JBzlT58Y
 eJA1H3+y8p9KOSt2DzFNqPKGH6M6keizW3+/RZ+/j+9AzV1lWokjzmFN8ah9bjyMTAs7uQPrOYC
 2Hdi3BZs=
X-Gm-Gg: AY/fxX41qWCwYCk6meifYpFUmfaLJu+KyCHje2+Amyg57/jgXjvVH1mIkcRGozR5Dzt
 OkB7MbeMZY1NCWdxg7tGDiPkYlE4Y4HU0s0YpwAdixX0eSZ9ZZ4GR4/WJIPNtjyZ4uE6PxgdYNU
 SryiqATas8yr3Q3rJQRJ/luJLfPAvlpEDhgIR6hjn+MF2NoCnWL7BMlp2KC9fb/93pnlaWikNyI
 GA1A8Eg9XFaevYpEAOuwqMHeZzN8SWgAMyGIzrA7pU6kY+lL5roNAI5ahls6iw7nhWI1ypfKw87
 D6adAQKx7j7ZFR1Ca6xhE4QhstzRJ2pHjxGh+A4sycysBC0jM6K9aoVcijzGFV7mmsye8R0OOME
 rV0KAWzj4i81TVt/Dkbk1BFskpCU+rzUnUZsRCtan6wlJNaxB6qRewWrfW2ooKOSU5A9sFBRCfL
 xBfg44UilNUSGPtrCE/JEQmUPH2Lu35rCvP5gVSxaXPoL2cbOkBFKJeC5bVm83MjLyUqyr86U=
X-Google-Smtp-Source: AGHT+IEvl/gV+0Z+uP6k/DjufW24In8fAThqZlsMdWmGGnIW3jR1ahwu0gy5qp6NzeGQO3fgww9RcQ==
X-Received: by 2002:a05:600c:4fc6:b0:465:a51d:d4 with SMTP id
 5b1f17b1804b1-47d1953b768mr31689505e9.6.1766161210506; 
 Fri, 19 Dec 2025 08:20:10 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324ea830f3sm5677279f8f.22.2025.12.19.08.20.09
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 19 Dec 2025 08:20:09 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Anton Johansson <anjo@rev.ng>, David Hildenbrand <david@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 02/24] system/physmem: Inline and remove leul_to_cpu()
Date: Fri, 19 Dec 2025 17:19:29 +0100
Message-ID: <20251219161953.72724-3-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251219161953.72724-1-philmd@linaro.org>
References: <20251219161953.72724-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

leul_to_cpu() is only used within physmem.c: inline it
and remove.
Since @bitmap is of 'unsigned long' type, use its size
with ldn_le_p() instead of using HOST_LONG_BITS.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/qemu/bswap.h | 11 -----------
 system/physmem.c     |  5 +++--
 2 files changed, 3 insertions(+), 13 deletions(-)

diff --git a/include/qemu/bswap.h b/include/qemu/bswap.h
index 39ba64046a6..65a1b3634f4 100644
--- a/include/qemu/bswap.h
+++ b/include/qemu/bswap.h
@@ -375,17 +375,6 @@ static inline void stq_be_p(void *ptr, uint64_t v)
     stq_he_p(ptr, be_bswap(v, 64));
 }
 
-static inline unsigned long leul_to_cpu(unsigned long v)
-{
-#if HOST_LONG_BITS == 32
-    return le_bswap(v, 32);
-#elif HOST_LONG_BITS == 64
-    return le_bswap(v, 64);
-#else
-# error Unknown sizeof long
-#endif
-}
-
 /* Store v to p as a sz byte value in host order */
 #define DO_STN_LDN_P(END) \
     static inline void stn_## END ## _p(void *ptr, int sz, uint64_t v)  \
diff --git a/system/physmem.c b/system/physmem.c
index c9869e4049f..1292f49095f 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -1254,7 +1254,8 @@ uint64_t physical_memory_set_dirty_lebitmap(unsigned long *bitmap,
 
             for (k = 0; k < nr; k++) {
                 if (bitmap[k]) {
-                    unsigned long temp = leul_to_cpu(bitmap[k]);
+                    unsigned long temp = ldn_le_p(&bitmap[k],
+                                                  sizeof(bitmap[k]));
 
                     nbits = ctpopl(temp);
                     qatomic_or(&blocks[DIRTY_MEMORY_VGA][idx][offset], temp);
@@ -1301,7 +1302,7 @@ uint64_t physical_memory_set_dirty_lebitmap(unsigned long *bitmap,
          */
         for (i = 0; i < len; i++) {
             if (bitmap[i] != 0) {
-                c = leul_to_cpu(bitmap[i]);
+                c = ldn_le_p(&bitmap[i], sizeof(bitmap[i]));
                 nbits = ctpopl(c);
                 if (unlikely(global_dirty_tracking & GLOBAL_DIRTY_DIRTY_RATE)) {
                     total_dirty_pages += nbits;
-- 
2.52.0


