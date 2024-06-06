Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B498C25B75
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2024 14:44:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFEL8-00025S-Tx; Thu, 06 Jun 2024 10:43:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1sFEL8-00025H-3h
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 10:43:42 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1sFEL6-0003DH-Az
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 10:43:41 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4214fe0067fso11398395e9.1
 for <qemu-devel@nongnu.org>; Thu, 06 Jun 2024 07:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=adacore.com; s=google; t=1717685018; x=1718289818; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=HdvBFX7sVfFp4VwD66KEqdg77+YRnOo4LpJGwPEXpAU=;
 b=huluDfMOSEQuFPqFbvK27CiVrL0rzO3gUEMBpxrG9XQdiqTyRYGRPabSkse9fWC9uI
 G2b2/fvAaxxiroKX+sbFUXs1l2e+QDcL+feRDQYds8tdZLqW+X23mSaptK4/wX7/f/G7
 1GCzTwA8vJ4PDfHgr8gnFxTkrFnYX52fG4l9Ai1zIpM+NAMnB9Jw8wiJmJNjP/sWuHlk
 rQveQUmDWKke1EJs+dPgEuyQM5BxmDsAdaOqs/Dl8IPO4XSGz8DGK7vxXjfcpj/vwcGS
 dxor81rHtW8porVujwIlGEdKQSncWXCTE9EHnIo7xVix6gFiA5m/BkvGD+5gEhAiT7BA
 huGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717685018; x=1718289818;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HdvBFX7sVfFp4VwD66KEqdg77+YRnOo4LpJGwPEXpAU=;
 b=TSVNiVKQ78K3nEMqxwsX/PoF5VHHPTQAaVEk8qFm8fr6BfZ08hKrjUUf0txp1aAgbE
 p77/2n+Mb0auSn9czXWpTUneoAtMdIM3DMB2WX4321SECUi6DLSXrdU7TSVTxkoz+51v
 njVjf2sFBiAdc/BmCEhIW7trc7blTpq5io4Wq7NoiSw6GE1YBWTuQzhaoaYx79++2UEU
 8BlfHMezQGbZ+wlwvrxC+TiFqJRTzFs1M27tmvXSQNk56ECQiwkL5tznH3gIH0ibqnSv
 rGFDKCZFWst+dNC4+46oGcRhaYPuPmmhJQtWWakP0RAQAu+NczfD3Jp+c2+bNERdC9MT
 Xdqg==
X-Gm-Message-State: AOJu0YzoLbrpFE4lR+AqnMIGJ6iiZRm27iyqfv8swymYmIuQ0cV4qxay
 Zf2emThOiZjQLIfGT525ffGkuC6VYYRUvTGcSfQOQNQvtwOeMT4mUWZJm5nOt0u4jES1Xfpa5A8
 =
X-Google-Smtp-Source: AGHT+IHlRw4zJAVKiEF48Uu1YZopdv3mhs7/N9kIEHf9ykLWvNklU3kli0xTWiZ31DBtPe7bRFslQA==
X-Received: by 2002:adf:fecb:0:b0:35c:a02a:97d3 with SMTP id
 ffacd0b85a97d-35e98099e48mr3885462f8f.71.1717685017862; 
 Thu, 06 Jun 2024 07:43:37 -0700 (PDT)
Received: from chigot-Dell.home ([2a01:cb15:8123:8100:15bf:b4fa:4108:a8a5])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35ef5d49f72sm1755154f8f.41.2024.06.06.07.43.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Jun 2024 07:43:37 -0700 (PDT)
From: =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
 =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>
Subject: [PATCH] target/sparc: use signed denominator in sdiv helper
Date: Thu,  6 Jun 2024 16:43:31 +0200
Message-Id: <20240606144331.698361-1-chigot@adacore.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=chigot@adacore.com; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The result has to be done with the signed denominator (b32) instead of
the unsigned value passed in argument (b).

Fixes: 1326010322d6 ("target/sparc: Remove CC_OP_DIV")
Signed-off-by: Clément Chigot <chigot@adacore.com>
---
 target/sparc/helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/sparc/helper.c b/target/sparc/helper.c
index 2247e243b5..7846ddd6f6 100644
--- a/target/sparc/helper.c
+++ b/target/sparc/helper.c
@@ -121,7 +121,7 @@ uint64_t helper_sdiv(CPUSPARCState *env, target_ulong a, target_ulong b)
         return (uint32_t)(b32 < 0 ? INT32_MAX : INT32_MIN) | (-1ull << 32);
     }
 
-    a64 /= b;
+    a64 /= b32;
     r = a64;
     if (unlikely(r != a64)) {
         return (uint32_t)(a64 < 0 ? INT32_MIN : INT32_MAX) | (-1ull << 32);
-- 
2.25.1


