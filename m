Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FDC5D11196
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Nov 2025 20:27:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOM4I-0006vW-HW; Wed, 26 Nov 2025 15:24:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vOM45-00066f-OZ
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 15:24:41 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vOM3w-0002gp-6E
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 15:24:32 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-47796a837c7so689605e9.0
 for <qemu-devel@nongnu.org>; Wed, 26 Nov 2025 12:24:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764188664; x=1764793464; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o9tf+Vlyc7bstg/QED3bCb6f68dEloCwsPwa0oPQ8Fc=;
 b=imcAImgYuO6EJMZsWnvqdUuVQmQzIjAQhycDU2IEYMvje2tac91sACtDzMntfkuPMr
 TP2q/PHEkNOm2z0Rg9SwSJdeTOoFLNGsXR7vOArWPDdnVs9v8Yhm2+9F+KokYpWIbVJv
 iqNYhvs0aJwM8H6Xco1uVefgChIAW/OvF6lI7dEodnQivCP90DnzQ6sMhv0AuctH0UXB
 Oyk6ag6NhqvG0Vo6yg/g7BggMGSsnnqLbdy/P+orLDDnKYc5HPmPxnFGhjWzZW1O6usW
 tlf280ByOm4z08HAWS8zuLOilb2mmygVpUP51gsU/omh4+0XmuYo14N9s3w9hZZx9Jfq
 33Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764188664; x=1764793464;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=o9tf+Vlyc7bstg/QED3bCb6f68dEloCwsPwa0oPQ8Fc=;
 b=lk2eN4JLldUMWd0KzfgkZKLEJh5SP5E13PsVOCO+jTuar8T/pRI7uM8cPNHnXcWCB4
 M7oa63UWmhp2Ujfe849eQImFl45EhUfPYi7AnxAd2t1B6QQ7sYD/hgVuRD2gfXLSswmO
 3M+wO/HhbWtdXY3GStZL0YxrYRCn6PnB58TVT507Zf4V52Ca7LTA/mitvbj8EV4KNU3V
 OiItYyE0PR+pG/BABGzTakr1FtbUflRl47s9XFcLqs+agUbYUZkvxGRxL5GoiFI4jbnQ
 T6w1iSEJEp48la9LJOP6L73nl+K9Oj/RMBSIWeJ910LWrlMFip2xNmg8G4Zog1odjdt4
 BQCw==
X-Gm-Message-State: AOJu0YxWNj03VesxAww4kjcEr3h38JIyjkX81xIoFE/McAllNEk5ofOk
 l7D7F2XzTTFX/6gZjtgncrcbJ5q0rj9SK9Wx+5aL0H/LXYL1YVohQLplTzz7UB2mzSZSKihEKj0
 +JSyfmMm8WWOB
X-Gm-Gg: ASbGncthqybHRgIUDqYQGUFbg8GAkoRI4Mm1Xs5UyGnp8oeB8xhVhWGd/5ySzNVk84v
 IzlIPcBkzhgPYuQbxmtus8hRNYyDFMwfDw8QilWrBirjrLaHsBedm7UBjSZtEHBIAeYWf521ooW
 z/T9/UIVPvhJGOwDkGZP+zmjZacWZvZdZLYdsH8mqAaR9bCFB/QicjNhrhAe9geQLvzHBFqHxdJ
 /AgTPTjbVflea73LtQqldbeVeWabT5MPCQFEd+RJDXmn1Qo2GnZIKRFQElDARxrLLp+P5gBE08x
 JKKweUJ0Yf9ddesz6uBCn8y3hcrt7x92bYr2T1hIsDtNlrV7KGB3xA+mL9Hj/rk7gLzLEh5V8Ng
 jgPh+MJi0wy5ZUKdO1nHxr0vbb3ykalCaPCh7vLo70L36lEDgUFgsohUyezbWbPQGXdgRbAS/6m
 ArVLHVvYpDFo9vq3FspQKRE1XLA2nWMo99o7JLE13qIfen4h/tFuFqhKM66W5kQfsI+aSYwng=
X-Google-Smtp-Source: AGHT+IGcGEr+fFOaGrNlpMv+KVvmV2UQM6L9RDhmcCglyZs7b1svBTL6r1bqCexrcnWCH1FYVcNeEA==
X-Received: by 2002:a05:600c:4ed2:b0:477:55ce:f3c3 with SMTP id
 5b1f17b1804b1-477c0162dd6mr193876695e9.5.1764188664292; 
 Wed, 26 Nov 2025 12:24:24 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4790adfd181sm61850825e9.14.2025.11.26.12.24.23
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 26 Nov 2025 12:24:23 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>, Chinmay Rath <rathc@linux.ibm.com>
Subject: [PATCH-for-11.0 v3 20/22] target/ppc: Inline cpu_ldl_data_ra() calls
 in ICBI helper
Date: Wed, 26 Nov 2025 21:21:56 +0100
Message-ID: <20251126202200.23100-21-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251126202200.23100-1-philmd@linaro.org>
References: <20251126202200.23100-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Inline the cpu_ldl_data_ra() call in preparation of
removing it. Since the returned value is discarded,
don't bother to set the access endianness.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/ppc/mem_helper.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/target/ppc/mem_helper.c b/target/ppc/mem_helper.c
index a43726d4223..cff385b6020 100644
--- a/target/ppc/mem_helper.c
+++ b/target/ppc/mem_helper.c
@@ -344,14 +344,18 @@ void helper_dcbzl(CPUPPCState *env, target_ulong addr)
 
 void helper_icbi(CPUPPCState *env, target_ulong addr)
 {
+    unsigned mmu_idx = cpu_mmu_index(env_cpu(env), false);
+    MemOpIdx oi = make_memop_idx(MO_UL | MO_UNALN, mmu_idx);
+
     addr &= ~(env->dcache_line_size - 1);
     /*
      * Invalidate one cache line :
      * PowerPC specification says this is to be treated like a load
      * (not a fetch) by the MMU. To be sure it will be so,
-     * do the load "by hand".
+     * do the load "by hand". As the returned data is not consumed,
+     * endianness is irrelevant.
      */
-    cpu_ldl_data_ra(env, addr, GETPC());
+    cpu_ldl_mmu(env, addr, oi, GETPC());
 }
 
 void helper_icbiep(CPUPPCState *env, target_ulong addr)
-- 
2.51.0


