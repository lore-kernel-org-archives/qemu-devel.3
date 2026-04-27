Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 997C2FF8860
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 12:57:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHLR0-0002wo-O3; Mon, 27 Apr 2026 08:51:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wHLO6-0008CA-Iz
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 08:48:36 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wHLO1-0005kb-OS
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 08:48:33 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-483487335c2so99996955e9.2
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 05:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777294105; x=1777898905; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=MUYJvEqSYHsDFv6xYayb4bJY4ikKhktCVd9QaedXI1A=;
 b=fIsXU42M6LKLhK5hb8Tj4deRlQ8h1rEz8C5eFgSmu2hdKo5HlDFGODY2AKsc5JLDqJ
 do2AofQMNYsw2J4ANqmprK+sYF9eoY2QtZA4p5HNenJ2MPi82ejCMA4+zty1sDCAIqLo
 lK0euFC7+269B7EiM2H/FVQnD4yw6Drvcj3z7348QhfTnEfSGlp3rmDYL5+4jmrcZxVI
 JIsgQjblH2dqUG9UYe62GbjcnvLzYUGZJN8rf2nfdGfak/acbMgqAwBpZN4QXb7JFQTQ
 jyWoU5kJU9wkGMHtUk4ibTZGfEbt//HE46lZO1i/dhYbAEDUosq2M6kNOeTf7BlyAD7F
 kVow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777294105; x=1777898905;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=MUYJvEqSYHsDFv6xYayb4bJY4ikKhktCVd9QaedXI1A=;
 b=tTt8cJlHtcHn2q6jy40WOv+80YNNyEp7YaJqarxWeUXfi7i1kTXCzwidhx2F+hi+qd
 qg8LSsRbQqvVTvuV1aiJAj1idAURjT0sFIuAlquHOc/qKpGdrEvVabrBJv56Bw56VkVW
 a+yMKKU/L9xXqim6SAooosPdFurivja2oMONx4RBcr7+6LFToHjHLgUlWvmLQbbmH6Jh
 yGpLauiF+NTNrflnApQEcciUZexnY7qvj0LIu4WVGf1eJAAEcZQkH789OydWLJJKNX8t
 oBkCJQJYbur+OWGtLw4rKntE5rtDvxeTnQV1Y6JPncvvvxNOI4dYciwBaYLhG5VlMaha
 0kUA==
X-Gm-Message-State: AOJu0YwzYkFQaEnDPD3typtIe+4RV2IcotE0e1fnyhS91phCIGewPO4f
 PBkKkKuJGMZLoRKmzC63KJvc1s1t2Gu7vHh+DCHNWu3Pf5ZZVGGKXug2Gn2Ym8XfXuUT0NACsGN
 hlVmu
X-Gm-Gg: AeBDievDawvvDgGwEDmBDQppTqQ/UFnCtz+sgn3+ZtGHkPmYQhfNqRwkZStBHWImjGT
 olXnPYu9gOt4GP1v9i1MifgyKUu/zLjzCEUK45ho24Kwt/nfmWHas38wRqtlsXgtjbI9uCjBRGT
 HqKDSZxUztCVxb+TYohvgvzQMfNfSc//uAwg8k2PnXIyKNUGRezqj7IJxQq7NXXbH9Hj50Ef5r7
 en9rhikOedsdLOvG3KV+ZhlyIm+7g2eJ0GqdZ5eqfi9kak86BMe/cvKJI4wsiCoTCGNROIjB5Qu
 RjCzCOsAGfxto7LSojbeo4ijfkxpn6NPcBQprFd9OCBj1hfrNBD9lmOLTvVRIr6OG/HE1094BJJ
 s3hOmpah6jjJDqElO0fHXP2/q7vsbnL5MUVb3ar/BXsmE3yeL/jd79XAm/Z2EeQIU6FMjeBwTXP
 q9w9ITWTYxkpJJopslkrFYxZ6Vn16C6+3CFTzfd/4PJ+KZJj2f8STlv30/JZCnmgDQVPXqjSonu
 4Z4CeCYGYAOTEJKWZuTiLcxFgvYyBgzH+b+5H1WNw==
X-Received: by 2002:a05:600c:1d22:b0:48a:6798:52e9 with SMTP id
 5b1f17b1804b1-48a6798548fmr186147055e9.0.1777294105456; 
 Mon, 27 Apr 2026 05:48:25 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488ffc5e3f4sm448974115e9.2.2026.04.27.05.48.24
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2026 05:48:24 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 50/63] target/arm: migrate fault syndromes to registerfields
Date: Mon, 27 Apr 2026 13:47:24 +0100
Message-ID: <20260427124738.966578-51-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260427124738.966578-1-peter.maydell@linaro.org>
References: <20260427124738.966578-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x334.google.com
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

Migrate syn_insn_abort and syn_data_abort_* to the registerfields API.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20260422125250.1303100-11-alex.bennee@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/syndrome.h | 87 ++++++++++++++++++++++++++++++++++++-------
 1 file changed, 74 insertions(+), 13 deletions(-)

diff --git a/target/arm/syndrome.h b/target/arm/syndrome.h
index bc65106c61..2031b3704f 100644
--- a/target/arm/syndrome.h
+++ b/target/arm/syndrome.h
@@ -494,20 +494,64 @@ static inline uint32_t syn_gpc(int s2ptw, int ind, int gpcsc, int vncr,
     return res;
 }
 
+/*
+ * ISS encoding for an exception from an Instruction Abort
+ *
+ * (aka instruction abort)
+ */
+FIELD(IABORT_ISS, IFSC, 0, 6)
+FIELD(IABORT_ISS, S1PTW, 7, 1)
+FIELD(IABORT_ISS, EA, 9, 1)
+FIELD(IABORT_ISS, FnV, 10, 1) /* FAR not Valid */
+FIELD(IABORT_ISS, SET, 11, 2)
+FIELD(IABORT_ISS, PFV, 14, 1)
+FIELD(IABORT_ISS, TopLevel, 21, 1) /* FEAT_THE */
+
 static inline uint32_t syn_insn_abort(int same_el, int ea, int s1ptw, int fsc)
 {
-    return (EC_INSNABORT << ARM_EL_EC_SHIFT) | (same_el << ARM_EL_EC_SHIFT)
-        | ARM_EL_IL | (ea << 9) | (s1ptw << 7) | fsc;
+    uint32_t res = syn_set_ec(0, EC_INSNABORT + same_el);
+    res = FIELD_DP32(res, SYNDROME, IL, 1);
+
+    res = FIELD_DP32(res, IABORT_ISS, EA, ea);
+    res = FIELD_DP32(res, IABORT_ISS, S1PTW, s1ptw);
+    res = FIELD_DP32(res, IABORT_ISS, IFSC, fsc);
+
+    return res;
 }
 
+/*
+ * ISS encoding for an exception from a Data Abort
+ */
+FIELD(DABORT_ISS, DFSC, 0, 6)
+FIELD(DABORT_ISS, WNR, 6, 1)
+FIELD(DABORT_ISS, S1PTW, 7, 1)
+FIELD(DABORT_ISS, CM, 8, 1)
+FIELD(DABORT_ISS, EA, 9, 1)
+FIELD(DABORT_ISS, FnV, 10, 1)
+FIELD(DABORT_ISS, LST, 11, 2)
+FIELD(DABORT_ISS, VNCR, 13, 1)
+FIELD(DABORT_ISS, AR, 14, 1)
+FIELD(DABORT_ISS, SF, 15, 1)
+FIELD(DABORT_ISS, SRT, 16, 5)
+FIELD(DABORT_ISS, SSE, 21, 1)
+FIELD(DABORT_ISS, SAS, 22, 2)
+FIELD(DABORT_ISS, ISV, 24, 1)
+
 static inline uint32_t syn_data_abort_no_iss(int same_el, int fnv,
                                              int ea, int cm, int s1ptw,
                                              int wnr, int fsc)
 {
-    return (EC_DATAABORT << ARM_EL_EC_SHIFT) | (same_el << ARM_EL_EC_SHIFT)
-           | ARM_EL_IL
-           | (fnv << 10) | (ea << 9) | (cm << 8) | (s1ptw << 7)
-           | (wnr << 6) | fsc;
+    uint32_t res = syn_set_ec(0, EC_DATAABORT + same_el);
+    res = FIELD_DP32(res, SYNDROME, IL, 1);
+
+    res = FIELD_DP32(res, DABORT_ISS, FnV, fnv);
+    res = FIELD_DP32(res, DABORT_ISS, EA, ea);
+    res = FIELD_DP32(res, DABORT_ISS, CM, cm);
+    res = FIELD_DP32(res, DABORT_ISS, S1PTW, s1ptw);
+    res = FIELD_DP32(res, DABORT_ISS, WNR, wnr);
+    res = FIELD_DP32(res, DABORT_ISS, DFSC, fsc);
+
+    return res;
 }
 
 static inline uint32_t syn_data_abort_with_iss(int same_el,
@@ -517,11 +561,22 @@ static inline uint32_t syn_data_abort_with_iss(int same_el,
                                                int wnr, int fsc,
                                                bool is_16bit)
 {
-    return (EC_DATAABORT << ARM_EL_EC_SHIFT) | (same_el << ARM_EL_EC_SHIFT)
-           | (is_16bit ? 0 : ARM_EL_IL)
-           | ARM_EL_ISV | (sas << 22) | (sse << 21) | (srt << 16)
-           | (sf << 15) | (ar << 14)
-           | (ea << 9) | (cm << 8) | (s1ptw << 7) | (wnr << 6) | fsc;
+    uint32_t res = syn_set_ec(0, EC_DATAABORT + same_el);
+    res = FIELD_DP32(res, SYNDROME, IL, !is_16bit);
+
+    res = FIELD_DP32(res, DABORT_ISS, ISV, 1);
+    res = FIELD_DP32(res, DABORT_ISS, SAS, sas);
+    res = FIELD_DP32(res, DABORT_ISS, SSE, sse);
+    res = FIELD_DP32(res, DABORT_ISS, SRT, srt);
+    res = FIELD_DP32(res, DABORT_ISS, SF, sf);
+    res = FIELD_DP32(res, DABORT_ISS, AR, ar);
+    res = FIELD_DP32(res, DABORT_ISS, EA, ea);
+    res = FIELD_DP32(res, DABORT_ISS, CM, cm);
+    res = FIELD_DP32(res, DABORT_ISS, S1PTW, s1ptw);
+    res = FIELD_DP32(res, DABORT_ISS, WNR, wnr);
+    res = FIELD_DP32(res, DABORT_ISS, DFSC, fsc);
+
+    return res;
 }
 
 /*
@@ -530,8 +585,14 @@ static inline uint32_t syn_data_abort_with_iss(int same_el,
  */
 static inline uint32_t syn_data_abort_vncr(int ea, int wnr, int fsc)
 {
-    return (EC_DATAABORT << ARM_EL_EC_SHIFT) | (1 << ARM_EL_EC_SHIFT)
-        | ARM_EL_IL | ARM_EL_VNCR | (wnr << 6) | fsc;
+    uint32_t res = syn_set_ec(0, EC_DATAABORT_SAME_EL);
+    res = FIELD_DP32(res, SYNDROME, IL, 1);
+
+    res = FIELD_DP32(res, DABORT_ISS, VNCR, 1);
+    res = FIELD_DP32(res, DABORT_ISS, WNR, wnr);
+    res = FIELD_DP32(res, DABORT_ISS, DFSC, fsc);
+
+    return res;
 }
 
 static inline uint32_t syn_swstep(int same_el, int isv, int ex)
-- 
2.43.0


