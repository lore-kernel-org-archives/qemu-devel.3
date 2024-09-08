Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75D79ECE579
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Sep 2024 02:28:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sn7dW-0003MN-2Z; Sat, 07 Sep 2024 22:26:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sn7dQ-0002v1-IB
 for qemu-devel@nongnu.org; Sat, 07 Sep 2024 22:26:40 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sn7dO-0004yz-8W
 for qemu-devel@nongnu.org; Sat, 07 Sep 2024 22:26:40 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-7d4f85766f0so2617798a12.2
 for <qemu-devel@nongnu.org>; Sat, 07 Sep 2024 19:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725762397; x=1726367197; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N9N2cgqqLVwUjXchNHwMUTNObW7o0Ba49NXy9nXuu1w=;
 b=A3YSkF5LCUtbANmlNWdSzkrxozk0t/9aPzRUop+r7habCs23kqMDXIQ/KjYy/3UnDG
 4BOsjS7aSvZgYuvnHOXZ7Lr0qxLKK2meTW/E4FiBq36FMWM8QjYKPXTDPml8tH7BQWkB
 YAo+pipgS2/lQS3fgAJUbX3WAhvmugjq9bJs472NGLOSn8oDzuqjKm0ts0CkQQKeXRLP
 Fw8Wi0yLiQZRnqWxLrDdQ/X6z6k3KGUdNeYDNdd8ZtdoVFwfC4eo6UwRnsZteUbRaTr/
 uszV1abY+/1dj/pB/hYyCDScVh3G8d25JiDMio/tiKU1X8WLN9O2oYfmirESh0O8ME9J
 2h3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725762397; x=1726367197;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N9N2cgqqLVwUjXchNHwMUTNObW7o0Ba49NXy9nXuu1w=;
 b=FCkDQ8n1a8efRju9wdMv5oFUAfxryI9nentvfQf6uxjEaXVsCqVENK8BS7xDpBDpwf
 hH9GaFAgW1Gcr1N4byOieUPAlyx/DBS8dtYdIftmd8NZLX3f0KPBE/Z19LnIUG6sa+wp
 PxBvMPxnVpJY3/JNZuW9JhPe2nVo6mx8wiGzYrs6B30OvJOVugvyLgv2ZHHLtOKAC4VS
 vvFxL/Syt4+evaxdoEcwYaRQ09D4kHNnQiLfnb/qx3FQw1yc2bVH58qswAledz6hNtNk
 yPw/AXGBlR27V6dfM57pwz4O39TK+wHM7tvO1jq0Kxlb8CGbmhb7Bq/xTqoM+bjZh5Rp
 n6Uw==
X-Gm-Message-State: AOJu0YzScca6AHgPNHk2GO3DJoeWLiXhSM7ULpxr11HW9UPwUAWv6JRo
 YLtP5Nez2LlAwk4If1RYtfiH2LrUD0NrdGXV4X6HR2KZkbtsGRnKQ/DmmtC3vIaB22CXcIRmofd
 2
X-Google-Smtp-Source: AGHT+IEVn1e16lyfZmdOzxxWo89HzA40Sh2xcZsMYkbIHkpK0/0awh42QGPlK3rwhHrRppx1MsFTTw==
X-Received: by 2002:a05:6a20:d510:b0:1ce:d418:a45c with SMTP id
 adf61e73a8af0-1cf2a0fcd7cmr4092480637.50.1725762396531; 
 Sat, 07 Sep 2024 19:26:36 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2dadbfe46d4sm4084019a91.1.2024.09.07.19.26.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Sep 2024 19:26:36 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: zhiwei_liu@linux.alibaba.com, tangtiancheng.ttc@alibaba-inc.com,
 liwei1518@gmail.com, bmeng.cn@gmail.com
Subject: [PATCH 02/12] tcg: Export vec_gen_6
Date: Sat,  7 Sep 2024 19:26:22 -0700
Message-ID: <20240908022632.459477-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240908022632.459477-1-richard.henderson@linaro.org>
References: <20240908022632.459477-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x535.google.com
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

Add declaration to tcg-internal.h, making it available for
use from tcg backend vector expanders.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg-internal.h | 2 ++
 tcg/tcg-op-vec.c   | 4 ++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/tcg/tcg-internal.h b/tcg/tcg-internal.h
index 9b0d982f65..52103f4164 100644
--- a/tcg/tcg-internal.h
+++ b/tcg/tcg-internal.h
@@ -102,5 +102,7 @@ void tcg_gen_op6(TCGOpcode, TCGArg, TCGArg, TCGArg, TCGArg, TCGArg, TCGArg);
 void vec_gen_2(TCGOpcode, TCGType, unsigned, TCGArg, TCGArg);
 void vec_gen_3(TCGOpcode, TCGType, unsigned, TCGArg, TCGArg, TCGArg);
 void vec_gen_4(TCGOpcode, TCGType, unsigned, TCGArg, TCGArg, TCGArg, TCGArg);
+void vec_gen_6(TCGOpcode opc, TCGType type, unsigned vece, TCGArg r,
+               TCGArg a, TCGArg b, TCGArg c, TCGArg d, TCGArg e);
 
 #endif /* TCG_INTERNAL_H */
diff --git a/tcg/tcg-op-vec.c b/tcg/tcg-op-vec.c
index 84af210bc0..d4bb4aee74 100644
--- a/tcg/tcg-op-vec.c
+++ b/tcg/tcg-op-vec.c
@@ -172,8 +172,8 @@ void vec_gen_4(TCGOpcode opc, TCGType type, unsigned vece,
     op->args[3] = c;
 }
 
-static void vec_gen_6(TCGOpcode opc, TCGType type, unsigned vece, TCGArg r,
-                      TCGArg a, TCGArg b, TCGArg c, TCGArg d, TCGArg e)
+void vec_gen_6(TCGOpcode opc, TCGType type, unsigned vece, TCGArg r,
+               TCGArg a, TCGArg b, TCGArg c, TCGArg d, TCGArg e)
 {
     TCGOp *op = tcg_emit_op(opc, 6);
     TCGOP_VECL(op) = type - TCG_TYPE_V64;
-- 
2.43.0


