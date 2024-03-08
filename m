Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEBC8C5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 11:18:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riYAh-0001kI-Hg; Fri, 08 Mar 2024 06:13:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1riYAb-0001eL-J4
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 06:13:45 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1riYAY-0001mC-Rz
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 06:13:44 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1dbae7b8ff2so15998775ad.3
 for <qemu-devel@nongnu.org>; Fri, 08 Mar 2024 03:13:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709896421; x=1710501221; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bh/6AzQ4OeYtq4I0+tZwzjGwPibMust5JQYvZ3OUI6s=;
 b=KBNeLbCGFL/MQrrGX3EGeQ0quLQjO5FY8/5IhdB1jeqwWHMQlNz1dlmbtKgcmK0+xC
 lbyJrf0//NZepQTnm2dXxxBonLilVp86YP/Q2Lo3UvsO683M81YUpeQ0i2/SoM1dO7dH
 YfPHr5EtkQlS6sJxy/X4HuIqXVWjYjxmLwFnquZFke130FX0ytYCwHXiCNLLV+jaSba4
 wlIdSQfWbZXvu5HjEaXJMPcTZCse/otdAmu8qoJWYZo06fbe5W9OdmBBM6QdE7JoQxti
 A8orozFBAVC9CTSEcokQdVaFpI03hWsKd9SzVaV0zywf+/T0nYwP2j+xgA4MSzEOoBQx
 Af4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709896421; x=1710501221;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bh/6AzQ4OeYtq4I0+tZwzjGwPibMust5JQYvZ3OUI6s=;
 b=m81JPxsDM8Zm4CtMQ4LPF6+BOk+6uTfa3GuroyjlNKkW6+qF53lTBbO4+m/GVqsACf
 l5HTGgosc+L28B6EIdnw+oF2g9E/djROLueVqLJ1ci76WZiZ+aEiLkNxzbfUu7ukjkJe
 NtiCiruLvhBzLcbZbEsXBhceSxnLbUAOGoS3123MBdmNoYKeq95tqXpBuiqYQEfJoYN9
 d1VqLIdj/UnV0DFcfCNhTyLT+sQL+r0jBkm7FlTOG0fA6lDYbmcnHOEtlvAOzr8RTAF5
 tmFVnu1o0RsMNvy9Uv82402U4ZIvHbRde6H2QCRZ5VOtUOVVUKXJKfdE5jQqEWtVyK/S
 rbcA==
X-Gm-Message-State: AOJu0YzZNGCn4tpqcc+tLmBQq+Mk/VhrATuojRGioyH1X6gWEk9EgT5a
 TVC38NO4YKVBkEi/6K/M7Av9QxabpvoG8vK7CekSo2d5pxKFj0K3kLBO/jCOEpBJ4A==
X-Google-Smtp-Source: AGHT+IEACvL29ZwVSChfx0CYK/rrWyhJ5tufbPIpSjUNIRNIoXSzmKERxDAUF8Cw+0JRFxaNIP3LoQ==
X-Received: by 2002:a17:902:b702:b0:1dd:6404:8f8a with SMTP id
 d2-20020a170902b70200b001dd64048f8amr2327877pls.36.1709896421101; 
 Fri, 08 Mar 2024 03:13:41 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 a6-20020a170902ecc600b001dcfbbb1ca5sm12006468plh.35.2024.03.08.03.13.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Mar 2024 03:13:40 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, "demin.han" <demin.han@starfivetech.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 30/34] target/riscv: Fix shift count overflow
Date: Fri,  8 Mar 2024 21:11:48 +1000
Message-ID: <20240308111152.2856137-31-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240308111152.2856137-1-alistair.francis@wdc.com>
References: <20240308111152.2856137-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x634.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: "demin.han" <demin.han@starfivetech.com>

The result of (8 - 3 - vlmul) is negative when vlmul >= 6,
and results in wrong vill.

Signed-off-by: demin.han <demin.han@starfivetech.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Message-ID: <20240225174114.5298-1-demin.han@starfivetech.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/vector_helper.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 84cec73eb2..fe56c007d5 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -44,6 +44,7 @@ target_ulong HELPER(vsetvl)(CPURISCVState *env, target_ulong s1,
     target_ulong reserved = s2 &
                             MAKE_64BIT_MASK(R_VTYPE_RESERVED_SHIFT,
                                             xlen - 1 - R_VTYPE_RESERVED_SHIFT);
+    uint16_t vlen = cpu->cfg.vlenb << 3;
     int8_t lmul;
 
     if (vlmul & 4) {
@@ -53,10 +54,8 @@ target_ulong HELPER(vsetvl)(CPURISCVState *env, target_ulong s1,
          * VLEN * LMUL >= SEW
          * VLEN >> (8 - lmul) >= sew
          * (vlenb << 3) >> (8 - lmul) >= sew
-         * vlenb >> (8 - 3 - lmul) >= sew
          */
-        if (vlmul == 4 ||
-            cpu->cfg.vlenb >> (8 - 3 - vlmul) < sew) {
+        if (vlmul == 4 || (vlen >> (8 - vlmul)) < sew) {
             vill = true;
         }
     }
-- 
2.44.0


