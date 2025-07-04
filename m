Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF069C8303D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 14:24:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXhIe-0006KD-Sc; Fri, 04 Jul 2025 10:22:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uXhI0-0004lG-DF
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:21:20 -0400
Received: from mail-oa1-x31.google.com ([2001:4860:4864:20::31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uXhHy-0005E4-89
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:21:20 -0400
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-2f766a60df9so453742fac.0
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 07:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751638876; x=1752243676; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uH1n1AAhtH6sgiTrUxsUntCDDF+ojb2NWa6yE2aObVo=;
 b=HYmBLvUQdwZiUqS9/rpH8/zYJNiDXV0X7VO31VycZZGhCJo6/gdKw2briqvmNRkDX/
 QPIBmSZWX7dmiFxW2/AUKxof57dLoUI99uH+Vqnn67qGa5MPNcKm/kzzvWur9aKB9zT8
 YQyb/cpeX/IoWWYL6/n/xOlYtZnIBo8JxuLA41Teq4c1jQCLzksdV8nRNMA6+J8+1AKO
 sqh4HI+t8kX+Mq1oXq8LWvlJUzyEQSh80te78upSd3/piGtkwFlRnaSF2JOIzBtlCJib
 mulseBCz/a+1tmIwMOziG2j2GhkJ58z4MMPBTAGtvVbaCyQUvwMQ+vNuI60P7rx5TQMd
 9gHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751638876; x=1752243676;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uH1n1AAhtH6sgiTrUxsUntCDDF+ojb2NWa6yE2aObVo=;
 b=MBJA22EduyV0qmt35//EvZOgWChvO2iMW2So3qMh91u7G9aYqTzzgUPgNLSmxg1cDY
 Ra/EYInS0ZO7FPDupTLNVNm6ZhLMAfh1m0KOT6NzIxeLtR9/N76iGqynyugp0DxxJOeK
 gFX4gmEp9B7LdOx2FW3lOi+oITbeKLAJpMEpa3Gno+sylmtAkZ50BeGRzVFNHE16Oeou
 ZJVqfSkPQAsQhtLnho7EltrUNBwgHscpGqxFlkAGC+opkA9p6TlvFE1XqTlcGBnsVX8A
 anPwkAiXyR3Iv36l5HLMvI+bluP+7TGfypeiScacghOyZNCI6ymVbBP/H/QJvseoRWsp
 YQMg==
X-Gm-Message-State: AOJu0YxhxZy02EzOU+/2KG3YtDzyN90Y1GwgH4FD+JtOqRRZiuRf7nWl
 WDbX8SaBvyBQcoGmmGdY4yJhsz5PDfYwXvHzAQEKzg90Z7MxZS7/grPIBczMC2iYhKt8u1+MKhG
 7wFyRnJ0=
X-Gm-Gg: ASbGncs3mY/hIJbF+v0ofN/Strf+c/PfXZlg3zMkHnk+EOUstZ3Q0KObOwwTN3zkKau
 xXodFPGT7Cs9iIVlv+lK3YUUv8gaB9ZLRlsfYeBmq8Moz+Z5EiWlxpdsuovkwbCm3ZizF0Om05Y
 +Mz//Pyzrk38997KCKbH1Af8H2z22le2EaS2GIlW5GOjEmncCDZ7pI6AVPoVwWK9rgBqVDkSzl9
 /+N4MgVDYTSAj9ZCQNU119Jge9fhlv7B5xseJQTeize3pCWYFlc84uMGw67OMfrVwTenKgL97aw
 vdDqPZOhanacyR50ZhDUuf8FoHsmuCyHOgMyZdhfh1oRqgBYLvskjqJXHZ9jtuFg2yYUBSkBg5D
 LaKx9+wwqFsQBDHReUu4A9++Sc+uN8MQ6kDJ4Ui8cKayqDcpc
X-Google-Smtp-Source: AGHT+IF73aTuzKW0uf4pPep6c5O1ATbMU5eLylPbM3FoTlzcHPd06oN4kGjT08FgY371RYSXf75L4A==
X-Received: by 2002:a05:6870:e394:b0:2cc:3603:f05f with SMTP id
 586e51a60fabf-2f796e07cacmr1772449fac.35.1751638876543; 
 Fri, 04 Jul 2025 07:21:16 -0700 (PDT)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2f78ff0471esm528016fac.3.2025.07.04.07.21.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 07:21:16 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	peter.maydell@linaro.org,
	qemu-stable@nongnu.org
Subject: [PATCH v4 002/108] target/arm: Fix sve_access_check for SME
Date: Fri,  4 Jul 2025 08:19:25 -0600
Message-ID: <20250704142112.1018902-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704142112.1018902-1-richard.henderson@linaro.org>
References: <20250704142112.1018902-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::31;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x31.google.com
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

Do not assume SME implies SVE.  Ensure that the non-streaming
check is present along the SME path, since it is not implied
by sme_*_enabled_check.

Cc: qemu-stable@nongnu.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-a64.c | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 5c44a5dece..b0caccca46 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -1381,11 +1381,8 @@ static bool fp_access_check_only(DisasContext *s)
     return true;
 }
 
-static bool fp_access_check(DisasContext *s)
+static bool nonstreaming_check(DisasContext *s)
 {
-    if (!fp_access_check_only(s)) {
-        return false;
-    }
     if (s->sme_trap_nonstreaming && s->is_nonstreaming) {
         gen_exception_insn(s, 0, EXCP_UDEF,
                            syn_smetrap(SME_ET_Streaming, false));
@@ -1394,6 +1391,11 @@ static bool fp_access_check(DisasContext *s)
     return true;
 }
 
+static bool fp_access_check(DisasContext *s)
+{
+    return fp_access_check_only(s) && nonstreaming_check(s);
+}
+
 /*
  * Return <0 for non-supported element sizes, with MO_16 controlled by
  * FEAT_FP16; return 0 for fp disabled; otherwise return >0 for success.
@@ -1444,14 +1446,24 @@ static int fp_access_check_vector_hsd(DisasContext *s, bool is_q, MemOp esz)
  */
 bool sve_access_check(DisasContext *s)
 {
-    if (s->pstate_sm || !dc_isar_feature(aa64_sve, s)) {
+    if (dc_isar_feature(aa64_sme, s)) {
         bool ret;
 
-        assert(dc_isar_feature(aa64_sme, s));
-        ret = sme_sm_enabled_check(s);
+        if (s->pstate_sm) {
+            ret = sme_enabled_check(s);
+        } else if (dc_isar_feature(aa64_sve, s)) {
+            goto continue_sve;
+        } else {
+            ret = sme_sm_enabled_check(s);
+        }
+        if (ret) {
+            ret = nonstreaming_check(s);
+        }
         s->sve_access_checked = (ret ? 1 : -1);
         return ret;
     }
+
+ continue_sve:
     if (s->sve_excp_el) {
         /* Assert that we only raise one exception per instruction. */
         assert(!s->sve_access_checked);
-- 
2.43.0


