Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72E15CF45D7
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 22:50:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfQjB-0000I5-SW; Mon, 12 Jan 2026 17:49:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vfQjA-0000Eu-1B
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 17:49:36 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vfQj8-0002Wq-97
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 17:49:35 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-477a2ab455fso63272885e9.3
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 14:49:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768258172; x=1768862972; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ci3dquOPMQ/HHBU0Txqpd/HrabINq5jamntKmUwIb90=;
 b=hGmWsjRr/rUf0X0O9VLzoFYseBNu5G9Kn91S2vbz7Sl2Zw9bez+7icqwlkoo1AV/z+
 cD49AYNJQMHIZVBVRnHdWJ0CDgJmQfm60r3KlBV8NfDf2Y7MaLiH3nN84xYJWXGgDQz7
 fv7OG8RgzOp31FqiDzTnYkYpeDa8wOsXrbdkG8DOMwX3hKWSdw4ggSWyXeLzmWYeNBSQ
 fNn+HU0JT9VwOBZHKn2mZqpGWKg4dAJUjoF2mV9OCYSfd1mQ0O6g+tcvtUcYF43KhDWN
 23VzD26fpxmkg7sMeTSQHUjU9ynUErctga5SryZ/WNye+jRrqLeEspvb56gQf7s6l4+Q
 ETRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768258172; x=1768862972;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ci3dquOPMQ/HHBU0Txqpd/HrabINq5jamntKmUwIb90=;
 b=gTaa4y1ym0bW7P1CDzNWx8pGdxWd76eGhA/eaZ9rTn67cKDmeFIG8EBq1te2eBq9VL
 CwTms8aHe4yixslp3eTHnlOaD5LdsgtB9WsMCPUUFR3wScMTyvibha4NVnMAryVjZumo
 SBlSsSOVK9rcLlNB3zckFiNRF8HSvhuCwbGdN+iAxnWcdXq40x+ZODWH7syLEJWiDean
 12GG5se1xiX3qkINVgpmgbImMi2zZYxCeFqcc48Ak4i76P4o7gDyJ+vZv2nnKOZKT61L
 KFpErVSazobG0vTcnN+O5fVIXRcXGOl4Cj+aIZey9ZBEVCKlx0N2nNwBB0EZFSCUmJtj
 Z46w==
X-Gm-Message-State: AOJu0Yy+nKsKMboa//obMOkQ+Q76ymArOe0TB2x1UDQJJ6YnVFacFUD5
 jip1D3rCu6uYYax3KR811D+BqP/QvHsEzaXsCqwWYBt3TnWQi5x0wm9+1R0QVufLxVo6usLBD+V
 9v9jTt7Y=
X-Gm-Gg: AY/fxX6583KvwC81Lg92GL+12SFTPxkKM8rqV6aTMvzt+J3SsK396xo9MvSNPjdhd1u
 fPjd/W4jinY4oiHeO22FJSC9cPNkHrksGfaCWJ6lXA5ev8oF0My2WDBF9vllG9GFdOstexlLMmD
 R3kwj+anv0mqbpOb65JDx23l2DZmqAZ3BTUWtDovt1Vw1PKyy2bYvn/DzpZ8tIWAT7DMS7VIgew
 szwvAEHpMpLJ7xSjwhzNy9w2c9KS7BWr8ft4FkMardTt7WiiQivy5qZDn0koi6f1Q0cDtUI/kI1
 32l1mfXC/Rjv/hfp6Sfj3dVYKvpo64cNOiBJCnscApLNlxdpDUlzT/OZaKfNmtvQner6+q2klXd
 WnYkgCfJhZ2WMH0GNPHKvgZsULtN24VSTSpKB1vBT1ykbxieOB3q4/WEi34GfmjfJ3VzcIFVwa3
 3HAOz6ebP0+eOz6VdVr5MDER4ssziBkFPxDCM4eimc54y6W0GrSKHFJuRTZbQ6hW/hgna2A5g=
X-Google-Smtp-Source: AGHT+IF6D3H//sWxLA//ydhwl7+uCayTTQp4qL1D55LlTgx1Lnqep9LkpPA/hm2hHV8hfqXqMLFGIg==
X-Received: by 2002:a05:600c:c093:b0:47d:900e:c646 with SMTP id
 5b1f17b1804b1-47d900ec72bmr125749975e9.8.1768258172320; 
 Mon, 12 Jan 2026 14:49:32 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d7f70bc4fsm372316215e9.15.2026.01.12.14.49.31
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 12 Jan 2026 14:49:31 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 05/61] system/physmem: Inline and remove leul_to_cpu()
Date: Mon, 12 Jan 2026 23:48:00 +0100
Message-ID: <20260112224857.42068-6-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260112224857.42068-1-philmd@linaro.org>
References: <20260112224857.42068-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

leul_to_cpu() is only used within physmem.c: inline it
and remove.
Since @bitmap is of 'unsigned long' type, use its size
with ldn_le_p() instead of using HOST_LONG_BITS.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260109165058.59144-4-philmd@linaro.org>
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
index 0105e88058d..829bf598189 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -1272,7 +1272,8 @@ uint64_t physical_memory_set_dirty_lebitmap(unsigned long *bitmap,
 
             for (k = 0; k < nr; k++) {
                 if (bitmap[k]) {
-                    unsigned long temp = leul_to_cpu(bitmap[k]);
+                    unsigned long temp = ldn_le_p(&bitmap[k],
+                                                  sizeof(bitmap[k]));
 
                     nbits = ctpopl(temp);
                     qatomic_or(&blocks[DIRTY_MEMORY_VGA][idx][offset], temp);
@@ -1319,7 +1320,7 @@ uint64_t physical_memory_set_dirty_lebitmap(unsigned long *bitmap,
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


