Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D24E7FF8860
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 12:58:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHLW8-0003NP-Da; Mon, 27 Apr 2026 08:56:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wHLO4-0008BP-TA
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 08:48:35 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wHLNy-0005kQ-PW
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 08:48:31 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4891e5b9c1fso86375545e9.2
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 05:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777294104; x=1777898904; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=4VCNxcfPSepY5zbr/MmlLHQMN69/N0gZhxZj3FQ2tKs=;
 b=zmxXA5ekCjE+vcEw4wAauv5EeLpccBRrxFrLoA718XTNCPJz7LOSeFuWBDpZJ8bUKF
 hn1JlLD4QDuv8b28MJPexnIZLFrg+/6YZvheIBzwQEwXX+dGsG1sdiKEnQozE2mOGQHR
 7un2bYY+O+DTjDilnP9PkDsR0dDnnmdW6bvRtt2tbRF0LPsZBqPTgSF4c4ckYFyYYEdh
 G4/fmoCqXbCz1BK7yR9ww1vRk0Xd7fubmONNhusjbNeyBl6yLbGiA2XCO7eCKVq/fY7V
 2iN+bj6WXk6oy6cG/jX8vPIQVXDcuybra8NXL77acgmEivOwz1zlJFpOnJ4plyrMET+8
 eMYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777294104; x=1777898904;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=4VCNxcfPSepY5zbr/MmlLHQMN69/N0gZhxZj3FQ2tKs=;
 b=MNk+SsERfYOQyAjUrR4bj9nZ36/iCOWcpFTy9YxgFtFs3ScsEWjMfO6ypi1Uu0ODPN
 guVvHJBDeUFsegzVTaI7PSXlB1SJ4hsJubp9AHbRHedk1N/D2fcbMgGpoYMBNSHijsx/
 Ogxf9yWVZVxyQeZ9vEWAcLxeNlBWF/eDQYE7AfeDoOGcD9dnTBmSLqAi9nfIH0tXmMZ0
 2lOF07mDCEpwbLg0trNNoj79VL66k5Ki2Nc2ZPc+m7xX6GX/w1KgCC07mft5Fzq5gBPA
 6pdap625uNyGn5mqdgCwvBroi95wSxRFI+TrAu72muSV+PEClXrUZK1ZXvAtq/888sp8
 6Q4Q==
X-Gm-Message-State: AOJu0YzX/W0hzIYd7Gnk4irPcuepl8A8NGgadnWn1R3xYxFvdVtykzr1
 kIlWzATqZKpdGVkmIgc4nYgqnNny3JNB1EMJPTIP75tJ2eMPTzmn+ujPFh7Xs8jV6nJUe7HHfbI
 NQpLG
X-Gm-Gg: AeBDies/QwhrvpbqICpEt7eOG/pQb1HQp5YEAjJlIHeYvqLPeewU0/CqnKWAiuX21H6
 uVxSo1DOcqKkiArVQMQtwduis9eUyW+usZp5YFT0l1j7qdo9hk2Vj6E/5jqs827tlDd5V581NOB
 kfexfSuyjIP4c9nekKZfMMB9CEn7Bid3tiUQ3vQuSPC5XpAaEQNKW2PMfqOiaFj70AlEE4vMb2X
 //nn+DOu2GBpaQrMtdBOINCJLdKorcZI4UQZifCteG/9+zHFog1Sa+gBvhwPRjFwoat7v5ES6b+
 X4rZaOzPX7P0c+LkAi50xG/y0snpvniGZYl7GUGzkrGQ1WtAgj4eithWFOv8OztUoBn38emeb8F
 2vCqlP+lYmRMaZ6C47InMZvNChpV5pbhXjFSsZ8CLVX8iOOIMqEhMOddMZq7M7Uds5A5KAIHuxJ
 BlJnQELrmAAH0IlOlY8h6/Eg2HrJyivafIbwrgeT2/N6jlo0oZcTcm2RdWRA9Cj0Vw4Gftv3lEc
 +7cpSjOabKuDdP1ELf3DcO2z75zOLTtgmLL9IgfS5vobrF/Xqpr
X-Received: by 2002:a05:600c:8207:b0:485:3193:6ddb with SMTP id
 5b1f17b1804b1-488fb73cf74mr684950455e9.3.1777294104565; 
 Mon, 27 Apr 2026 05:48:24 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488ffc5e3f4sm448974115e9.2.2026.04.27.05.48.23
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2026 05:48:23 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 49/63] target/arm: migrate Granule Protection traps to
 registerfields
Date: Mon, 27 Apr 2026 13:47:23 +0100
Message-ID: <20260427124738.966578-50-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260427124738.966578-1-peter.maydell@linaro.org>
References: <20260427124738.966578-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x332.google.com
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

From: Alex Bennée <alex.bennee@linaro.org>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-id: 20260422125250.1303100-10-alex.bennee@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/syndrome.h | 30 +++++++++++++++++++++++++++---
 1 file changed, 27 insertions(+), 3 deletions(-)

diff --git a/target/arm/syndrome.h b/target/arm/syndrome.h
index 6fcf0ac757..bc65106c61 100644
--- a/target/arm/syndrome.h
+++ b/target/arm/syndrome.h
@@ -462,12 +462,36 @@ static inline uint32_t syn_bxjtrap(int cv, int cond, int rm)
     return res;
 }
 
+/*
+ * ISS encoding for a Granule Protection Check exception
+ *
+ * These are only reported to EL3
+ */
+FIELD(GPC_ISS, xFSC, 0, 6)
+FIELD(GPC_ISS, WnR, 6, 1) /* Write not Read */
+FIELD(GPC_ISS, S1PTW, 7, 1)
+FIELD(GPC_ISS, CM, 8, 1)
+FIELD(GPC_ISS, VNCR, 13, 1)
+FIELD(GPC_ISS, GPCSC, 14, 6)
+FIELD(GPC_ISS, InD, 20, 1) /* Instruction not Data access */
+FIELD(GPC_ISS, S2PTW, 21, 1)
+
 static inline uint32_t syn_gpc(int s2ptw, int ind, int gpcsc, int vncr,
                                int cm, int s1ptw, int wnr, int fsc)
 {
-    return (EC_GPC << ARM_EL_EC_SHIFT) | ARM_EL_IL | (s2ptw << 21)
-        | (ind << 20) | (gpcsc << 14) | (vncr << 13) | (cm << 8)
-        | (s1ptw << 7) | (wnr << 6) | fsc;
+    uint32_t res = syn_set_ec(0, EC_GPC);
+    res = FIELD_DP32(res, SYNDROME, IL, 1);
+
+    res = FIELD_DP32(res, GPC_ISS, S2PTW, s2ptw);
+    res = FIELD_DP32(res, GPC_ISS, InD, ind);
+    res = FIELD_DP32(res, GPC_ISS, GPCSC, gpcsc);
+    res = FIELD_DP32(res, GPC_ISS, VNCR, vncr);
+    res = FIELD_DP32(res, GPC_ISS, CM, cm);
+    res = FIELD_DP32(res, GPC_ISS, S1PTW, s1ptw);
+    res = FIELD_DP32(res, GPC_ISS, WnR, wnr);
+    res = FIELD_DP32(res, GPC_ISS, xFSC, fsc);
+
+    return res;
 }
 
 static inline uint32_t syn_insn_abort(int same_el, int ea, int s1ptw, int fsc)
-- 
2.43.0


