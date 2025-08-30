Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEB73CA0FFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 16:08:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNxr-0005ew-9w; Sat, 30 Aug 2025 11:58:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1usEQb-0007Fc-Vp
 for qemu-devel@nongnu.org; Sat, 30 Aug 2025 01:47:08 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1usEQW-0004qW-6C
 for qemu-devel@nongnu.org; Sat, 30 Aug 2025 01:47:01 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-b4e84a61055so71317a12.0
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 22:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756532815; x=1757137615; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QZLKbvaJXmVjJqae0cs73+DMl1qe751GQQY47wH+UJk=;
 b=P+ZCJQ7Z/vqqrN502oeGR6ivwkU1B5RlwzwD8B3NJUpcG2wYOx9k9SHifJ47CYuhXb
 +yA1fcY6tlUn5oobF+Z21Qac8DtmShekzYZXus+Br3hK2dHRuyO0ThsbuEFQJSIXopkx
 BqwhOBPNxPUdVOBoLw99BOou5H8prNOMElp+mhqSVqEh1JfkvHxPNosRs5oYPwkNdfBd
 dz5s8vvcur8xaP2A1x0fDC5ImhTld5Omy7/DVCZgOvgf1Sv7S6z8ZtyUBEaJBBl6OlM8
 xqPWxkszoPWv73CGTVIAq9VT07vGH1H+n+L7hx9PLvxdJL90QVFjGcmM7sX/4BEuU24b
 /6Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756532815; x=1757137615;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QZLKbvaJXmVjJqae0cs73+DMl1qe751GQQY47wH+UJk=;
 b=l2b0DJNCevnGMzHZHUn2Zsb8ugXIER59PKX+iTTk+9iY6JEkfosi9wgNhiBTEJt3Xx
 xPST98YiVZ8Bycc7dGyNV5E1WIpJ1U6fFoRZ47I9iz4y8aKjT0L0Ea8DDB0q7QT0io76
 CDK4Gvc59BNNd42plpakftxa73m9qI9rL6fFu7PGRpT0TBnOnX3FDwL5MVMyKqoIpATZ
 gob7nO806zW/jQXJYWgqHQtjqKabNJ+NoE7uqj6AGME9OLPDkjJj+Xgvhw9P9AWzTqxO
 CQt+wlqcnowEi5oRgleVxu261leV4LH7qe6Cbh6SMoM3vW41qQLh8C0Q/OPsSkyVJAFW
 nteA==
X-Gm-Message-State: AOJu0Yxf0Hy1J6bB7+iSaE6F1wkXwyPJXJBVgOZ1Xj3L5HCnnuR9li16
 Y7NOOYuHniSAWTDoRy128b/gLlfilSW2uO0jXHpB5Euz005HPKBKTuxBIkOoWaOg7bxanF4KNth
 NGmNWHS0=
X-Gm-Gg: ASbGncs6v8fN4vq5KzLVyYg0GdO1EIQYybWc8ZleVWe7c8tuxAHAiOG8uBc+yiK8ob/
 zEekmdrOuxOjw2ttNMiaNUVKW0Ga8Ou37quiLvi8GZf/wKvY+5kz+t6Wy6xsJJtVp0umiUWetZz
 /Hh7bu7jD9jpOqQOlGpKjdTDATA1v0MnL9vRsA+5mU8NHBrt/Qdkk0/N3iVhckr6rP9htaEiG+a
 ZNLU6/m6/btEIgXHuaY+4/d4SlIqA/aJGd7qitfTnLD4kZmiOiaH3bZ8bC6mH2yGpHkDLv8GVCK
 VgBRBw/Y8+rCC6nwiOG4zB7UVViKY7A0h7felb9tihsm/TccgiMa6JmPBfhIy3DBmFdniKlLAaV
 NEv92DmcpVjm0xfRdZRKQetUsHhjF7kGB4S1d7egiAlQTzA/FRbCeTtLFtZRr+sY=
X-Google-Smtp-Source: AGHT+IEVNvqMG3+DGDs3rlePUboNFtyM1HZa+e+tI8fBAMOBtmtGPrJV9lbaPkeGHnRlWk3fPMNvqA==
X-Received: by 2002:a17:903:1250:b0:249:1234:9f7c with SMTP id
 d9443c01a7336-24944b23caamr15133335ad.60.1756532815345; 
 Fri, 29 Aug 2025 22:46:55 -0700 (PDT)
Received: from stoup.. (122-150-204-179.dyn.ip.vocus.au. [122.150.204.179])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2490658999fsm40852715ad.112.2025.08.29.22.46.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 22:46:54 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Gustavo Romero <gustavo.romero@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v4 49/84] target/arm: Implement FEAT_CHK
Date: Sat, 30 Aug 2025 15:40:53 +1000
Message-ID: <20250830054128.448363-50-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250830054128.448363-1-richard.henderson@linaro.org>
References: <20250830054128.448363-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52c.google.com
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

This feature contains only the CHKFEAT instruction.  It has
no ID enable, being back-allocated into the hint nop space.

Reviewed-by: Gustavo Romero <gustavo.romero@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-a64.c | 14 ++++++++++++++
 docs/system/arm/emulation.rst  |  1 +
 target/arm/tcg/a64.decode      |  1 +
 3 files changed, 16 insertions(+)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 4139b0345f..8c73f54e9a 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -2124,6 +2124,20 @@ static bool trans_AUTIBSP(DisasContext *s, arg_AUTIBSP *a)
     return true;
 }
 
+static bool trans_CHKFEAT(DisasContext *s, arg_CHKFEAT *a)
+{
+    uint64_t feat_en = 0;
+
+    if (s->gcs_en) {
+        feat_en |= 1 << 0;
+    }
+    if (feat_en) {
+        TCGv_i64 x16 = cpu_reg(s, 16);
+        tcg_gen_andi_i64(x16, x16, ~feat_en);
+    }
+    return true;
+}
+
 static bool trans_CLREX(DisasContext *s, arg_CLREX *a)
 {
     tcg_gen_movi_i64(cpu_exclusive_addr, -1);
diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index 94a6192fa9..4b07af9eac 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -28,6 +28,7 @@ the following architecture extensions:
 - FEAT_BF16 (AArch64 BFloat16 instructions)
 - FEAT_BTI (Branch Target Identification)
 - FEAT_CCIDX (Extended cache index)
+- FEAT_CHK (Check Feature Status)
 - FEAT_CMOW (Control for cache maintenance permission)
 - FEAT_CRC32 (CRC32 instructions)
 - FEAT_Crypto (Cryptographic Extension)
diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 55ff6c504f..8283a9c83d 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -256,6 +256,7 @@ ERETA           1101011 0100 11111 00001 m:1 11111 11111 &reta  # ERETAA, ERETAB
     AUTIASP     1101 0101 0000 0011 0010 0011 101 11111
     AUTIBZ      1101 0101 0000 0011 0010 0011 110 11111
     AUTIBSP     1101 0101 0000 0011 0010 0011 111 11111
+    CHKFEAT     1101 0101 0000 0011 0010 0101 000 11111
   ]
   # The canonical NOP has CRm == op2 == 0, but all of the space
   # that isn't specifically allocated to an instruction must NOP
-- 
2.43.0


