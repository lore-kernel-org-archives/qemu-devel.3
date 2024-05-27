Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ABD5C25B74
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 21:20:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBhkX-00079n-Us; Mon, 27 May 2024 17:19:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sBhkW-000796-6H
 for qemu-devel@nongnu.org; Mon, 27 May 2024 17:19:20 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sBhkU-0003cj-H5
 for qemu-devel@nongnu.org; Mon, 27 May 2024 17:19:19 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-6f6911d16b4so102453b3a.3
 for <qemu-devel@nongnu.org>; Mon, 27 May 2024 14:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716844757; x=1717449557; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7IRXqPGSXq5V6/Q9YShs7TCdug/2ZsHle4yh5lb0Poo=;
 b=NAwmZBnyOBkewIEwkTLIO1QRgdA+YQyRKGzT7u291i0BgTfjOsEMicb1+kGKehL7g4
 ro6XWO+a5n9YSb+2eeXXjy6IeBb6XJkFGLwPpdrZs1/A1igz7dWXDCgbV3ClmdaTZ4rT
 EUpdHp5OmU1iugQOR68fHKqgVcobGmjk7/by2K1IvSLym4fXcyIbk/qOsUp48DZRsnjp
 sr5bvtX8ikqiyLA6N7cZZq++V72qJ3dQizZY7SUIP02xin++WvjgqyVjK/pNioxX5tWK
 raRYfR0vkkGuZs32Qv7DC56+9l89qv4I3aRVSFs3Pfyba6d9ew7WcjzF8Q5Z+eUmdCwx
 q4lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716844757; x=1717449557;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7IRXqPGSXq5V6/Q9YShs7TCdug/2ZsHle4yh5lb0Poo=;
 b=FdcJVZxOrJoPce9tQDJbeoZYodQvHDddgPEd01jVeTWgmmlZeR7jW2jKUvdbhCp1ta
 eOZWjzklNXefRzKezhQ8DJCi1bCKwqWmBnU9jmz+vrtnY+mhOgSwFzHDMVl0u/7g5T5F
 Ftes87lfl2C5E4eZ6wMz4r0eD3t+dfnHDMFs/VIPFGENtnVAXMBB9BSseKKrkJ4x8Twr
 QScrr58AafQCSomvDtMYjrciLSGNSf0w4ORufmk5xx/BE7jYStVlrW7ZqiVpf0fNBnJX
 iYGFfoqXpMBlkn5FR/u0jqTXTbFRvnSE7S2u6ybI391kF/qF8eS3bu95BeM61kIihuvO
 +w6A==
X-Gm-Message-State: AOJu0Yzr2cQufylOQ/RRJyTA0dxKQVkeJ4cY3YaX7fGdR52MlqQ73fja
 zpQzVNyyv8S20veHGUNDOO6PYlbu7fHZrlUh3PsQy1h1kBednRu5bYkJNRfojCS9+tWauxlMgKI
 F
X-Google-Smtp-Source: AGHT+IFAfdmvrx/ARtFOzmbkhp3cy7T8MgWWlj52Pg8bwtvvvcvw2dFtWX1IirFEP3ZUsK3MpLDOhA==
X-Received: by 2002:a05:6a00:1c83:b0:6f4:d079:bb2b with SMTP id
 d2e1a72fcca58-6f8f3186614mr11216997b3a.9.1716844757037; 
 Mon, 27 May 2024 14:19:17 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-6f8fd1d4d5fsm5265876b3a.165.2024.05.27.14.19.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 May 2024 14:19:16 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: git@xen0n.name,
	gaosong@loongson.cn
Subject: [PATCH 03/18] tcg/loongarch64: Handle i32 and i64 moves between gr
 and fr
Date: Mon, 27 May 2024 14:18:57 -0700
Message-Id: <20240527211912.14060-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240527211912.14060-1-richard.henderson@linaro.org>
References: <20240527211912.14060-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/loongarch64/tcg-target.c.inc | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index b9078ac793..de5369536e 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -303,11 +303,23 @@ static bool tcg_out_mov(TCGContext *s, TCGType type, TCGReg ret, TCGReg arg)
     switch (type) {
     case TCG_TYPE_I32:
     case TCG_TYPE_I64:
-        /*
-         * Conventional register-register move used in LoongArch is
-         * `or dst, src, zero`.
-         */
-        tcg_out_opc_or(s, ret, arg, TCG_REG_ZERO);
+        if (ret < TCG_REG_V0) {
+            if (arg < TCG_REG_V0) {
+                /*
+                 * Conventional register-register move used in LoongArch is
+                 * `or dst, src, zero`.
+                 */
+                tcg_out_opc_or(s, ret, arg, TCG_REG_ZERO);
+            } else {
+                tcg_out_opc_movfr2gr_d(s, ret, arg);
+            }
+        } else {
+            if (arg < TCG_REG_V0) {
+                tcg_out_opc_movgr2fr_d(s, ret, arg);
+            } else {
+                tcg_out_opc_fmov_d(s, ret, arg);
+            }
+        }
         break;
     case TCG_TYPE_V128:
         tcg_out_opc_vori_b(s, ret, arg, 0);
-- 
2.34.1


