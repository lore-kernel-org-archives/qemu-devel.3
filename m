Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2791C67861
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 19:36:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruHGU-0000ZO-W9; Tue, 09 Apr 2024 15:36:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ruHGT-0000Yk-5N
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 15:36:17 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ruHGR-0004de-FX
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 15:36:16 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1e4149e7695so19667785ad.0
 for <qemu-devel@nongnu.org>; Tue, 09 Apr 2024 12:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712691374; x=1713296174; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RlIBc4Oj7n9g5uv4QxhhxdXhuzA6b3JMjencPErHv6I=;
 b=HcFeQ8EHDy7FfHzk+m+Zbkkfy4RC+p/Pf8rnZphSCTwgbAzNuyljJgolJz9uABlVsH
 xYrPo1mMYc0FuEm26h0gwM+T3g+3l3Hlb6F30kmIOuLoPnM8qJop53YuSmt3ORSRf0Oe
 fbMoRxHG8GBsV7g9LY683xj5hOHtRpiLdWfECa7XEmrBCqxEgH+3EW5j1oNL3Vmy6WQo
 dMzHgez7tOKlGD8Hj4waytvi5/fOVsXZanhnOgGp6ZFDqCuPzpCdc1MlzskrTgm7lY9J
 DxZTPDCSHorkM+X2WT4vgrJ1QA7o6ZKOAaQdquourS/bn1E+a0QHH/mnUOVgpoaG4eji
 VISg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712691374; x=1713296174;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RlIBc4Oj7n9g5uv4QxhhxdXhuzA6b3JMjencPErHv6I=;
 b=WDbOfHAKOVEkMtrUowmYVdWmpRIvONnDf/MQZN96jYqNN1p3lMpv/bkN1ylDuPcmya
 RwSCE+VumXoS2EA4py1pZEhjbkNUNjQkhMfPxAQKsTmDFq4OO6hbGio2/N4a8rkQ6zl1
 3+7BeTe19tp7BCk/OproRbv26ZElLkrqGKbFoTnRXIaee40RYR/jmgaAe0K0PpCfu6eK
 EkKJQJxZg6W1tJIDxdSSMDKtp8UDsSJIgv3Yv8HqQ5krE5jXNSS8nc1dFVlnQl0/0B4v
 7i2GC8vmk/leb6eI2C3yVxA1MT+Xq2P6ZwPZ3aVwtFVz+K7Cc2rnAaA/lDBGdI+xcC6j
 lm8w==
X-Gm-Message-State: AOJu0YxCjPjoRWzREa6e+mw14Wz6DgmfxW+DeVdSiYXK5k/gZZt8RM3c
 kKVpqhmJteGp1Gw9tZb+NAMCYGAdpJTbuORmRJvgv2Cyfi2HDh6l8LmKIuVkFlVJ+nSkI4ilha1
 W
X-Google-Smtp-Source: AGHT+IH7NE0CfJ1qeuezQUAnNPkLVW65pzrDRYKgULBykhbScMO9K1DeZnlEV4MY1g7PrS50sJ4ofw==
X-Received: by 2002:a17:902:efd6:b0:1e4:203d:ab80 with SMTP id
 ja22-20020a170902efd600b001e4203dab80mr691318plb.57.1712691374178; 
 Tue, 09 Apr 2024 12:36:14 -0700 (PDT)
Received: from stoup.. (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 c17-20020a170902d49100b001e1071cf0bbsm6065843plg.302.2024.04.09.12.36.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Apr 2024 12:36:13 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL v2 06/20] target/sh4: Merge mach and macl into a union
Date: Tue,  9 Apr 2024 09:35:49 -1000
Message-Id: <20240409193603.1703216-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240409193603.1703216-1-richard.henderson@linaro.org>
References: <20240409193603.1703216-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

Allow host access to the entire 64-bit accumulator.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sh4/cpu.h | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/target/sh4/cpu.h b/target/sh4/cpu.h
index 9211da6bde..d928bcf006 100644
--- a/target/sh4/cpu.h
+++ b/target/sh4/cpu.h
@@ -155,12 +155,22 @@ typedef struct CPUArchState {
     uint32_t pc;                /* program counter */
     uint32_t delayed_pc;        /* target of delayed branch */
     uint32_t delayed_cond;      /* condition of delayed branch */
-    uint32_t mach;              /* multiply and accumulate high */
-    uint32_t macl;              /* multiply and accumulate low */
     uint32_t pr;                /* procedure register */
     uint32_t fpscr;             /* floating point status/control register */
     uint32_t fpul;              /* floating point communication register */
 
+    /* multiply and accumulate: high, low and combined. */
+    union {
+        uint64_t mac;
+        struct {
+#if HOST_BIG_ENDIAN
+            uint32_t mach, macl;
+#else
+            uint32_t macl, mach;
+#endif
+        };
+    };
+
     /* float point status register */
     float_status fp_status;
 
-- 
2.34.1


