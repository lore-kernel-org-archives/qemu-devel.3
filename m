Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24B41C48260
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Feb 2024 03:08:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXBmW-0006wb-If; Mon, 05 Feb 2024 22:05:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rXBmU-0006un-Cj
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 22:05:54 -0500
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rXBmQ-0003EM-Ad
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 22:05:54 -0500
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-5dbcfa0eb5dso442241a12.3
 for <qemu-devel@nongnu.org>; Mon, 05 Feb 2024 19:05:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707188738; x=1707793538; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AqRQXC9e1yIrSAcLNE1gvR7WQ2p8XFPS+9BATHPSGv4=;
 b=mAzSzR8QPg97G3Y+N95tjnHJQoY6EiI1KX3esKCT+y0QBXkrnlKRYMPMhdB0IIdfAF
 Hp57b1zl0L7hmkW1Ebt/npDOvkY8YCjgub391hHdoejbk1WQNTrkZVFwxwGUKG4sGwYd
 0V1vEb+ZRdPbvNxW7qRzbyOYqF/3ZaoeaWPpaLM9AcFcTAmeI+xGkxvCDMshLmLCrFEY
 cXPNWDK0Ob/B0C0Ris2ziipU5qxFkipeDLLmTKE2zeOzhvSZUEjSzJx7xmbSpqVyZbx2
 lJubaBamTsVNu0eu+CQxhfepSoA4xhXjr4s3+CYBb5l2K4xWmVpPUKu6ph4J43SsLlWP
 TN5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707188738; x=1707793538;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AqRQXC9e1yIrSAcLNE1gvR7WQ2p8XFPS+9BATHPSGv4=;
 b=QgO4RZVpQCiM7b+BvViL/QDWM/bCg9I2RK16GpgM6uqQ8k6897rOeoSQE6vVp+WWYO
 xms6ka1uiR3I7iiN23ZKrdLngcDq4JluitOIHpg7luE9TtB5CSK34+44BLXUsnu6aIxJ
 uKV6DLFJEx3GQ5Cmg2Y27xEhxeWngUhpMqUeDw9tI9AOfRaspkuL9e45EwlnPKSfj5I5
 jA4v8P2ZUA9EDvbCFeVsMT5eeD4qoSP237SbAUhVbiOn8VgtkemEBCwMA1kKKzcCImVx
 H5UjdEBvrEpM2PzI1Tfn7KGNz9rbCqZKOP3xhV9gwQbKismYUI9RhaXAG18Tx8Zl8/sS
 mmLQ==
X-Gm-Message-State: AOJu0Yz9hhR7lpSCTygO7+GThi8JqHRsORWvvWZSQi73+S8yABVsZizp
 oM9pseyttGs15rZbf8ekCPR6X3iXvisMeHVfx9h1qEtoAmd0dloQ/zSpUfqpqO2NP6+D4jDTdWM
 f+C0=
X-Google-Smtp-Source: AGHT+IF+xZIz24H5/m5NNzK98t572juqzYzNAxlBCebAKeOioTVHcUUloWIWyXlOlzQXOJzMlwv/HA==
X-Received: by 2002:a05:6a20:939d:b0:19c:9ea1:692b with SMTP id
 x29-20020a056a20939d00b0019c9ea1692bmr524716pzh.10.1707188738443; 
 Mon, 05 Feb 2024 19:05:38 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCVyt1Y3IExw8JrgxPhbkw35x8dsDv1Uy4dNgqfJFktsplP9lQgtfPlq/HuYzf3kwqc2Ng3pGZnDPwdvDWOSkM9dm3tmj5z/eUo0JWCUxSaidEMIULQJMsUa3iwGy8ujQowH
Received: from stoup.. ([43.252.112.200]) by smtp.gmail.com with ESMTPSA id
 r14-20020a62e40e000000b006e025030700sm627478pfh.190.2024.02.05.19.05.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Feb 2024 19:05:38 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	gustavo.romero@linaro.org,
	qemu-stable@nongnu.org
Subject: [PATCH v2 2/6] target/arm: Fix nregs computation in do_ld_zpa
Date: Tue,  6 Feb 2024 13:05:23 +1000
Message-Id: <20240206030527.169147-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240206030527.169147-1-richard.henderson@linaro.org>
References: <20240206030527.169147-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

The field is encoded as [0-3], which is convenient for
indexing our array of function pointers, but the true
value is [1-4].  Adjust before calling do_mem_zpa.

Add an assert, and move the comment re passing ZT to
the helper back next to the relevant code.

Cc: qemu-stable@nongnu.org
Fixes: 206adacfb8d ("target/arm: Add mte helpers for sve scalar + int loads")
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-sve.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 296e7d1ce2..f50a426c98 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -4445,11 +4445,7 @@ static void do_mem_zpa(DisasContext *s, int zt, int pg, TCGv_i64 addr,
     TCGv_ptr t_pg;
     int desc = 0;
 
-    /*
-     * For e.g. LD4, there are not enough arguments to pass all 4
-     * registers as pointers, so encode the regno into the data field.
-     * For consistency, do this even for LD1.
-     */
+    assert(mte_n >= 1 && mte_n <= 4);
     if (s->mte_active[0]) {
         int msz = dtype_msz(dtype);
 
@@ -4463,6 +4459,11 @@ static void do_mem_zpa(DisasContext *s, int zt, int pg, TCGv_i64 addr,
         addr = clean_data_tbi(s, addr);
     }
 
+    /*
+     * For e.g. LD4, there are not enough arguments to pass all 4
+     * registers as pointers, so encode the regno into the data field.
+     * For consistency, do this even for LD1.
+     */
     desc = simd_desc(vsz, vsz, zt | desc);
     t_pg = tcg_temp_new_ptr();
 
@@ -4600,7 +4601,7 @@ static void do_ld_zpa(DisasContext *s, int zt, int pg,
      * accessible via the instruction encoding.
      */
     assert(fn != NULL);
-    do_mem_zpa(s, zt, pg, addr, dtype, nreg, false, fn);
+    do_mem_zpa(s, zt, pg, addr, dtype, nreg + 1, false, fn);
 }
 
 static bool trans_LD_zprr(DisasContext *s, arg_rprr_load *a)
-- 
2.34.1


