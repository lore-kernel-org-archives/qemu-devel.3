Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9158ECD8CB9
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 16:22:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXLYm-0003w2-JV; Wed, 10 Jun 2026 12:13:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wXLYk-0003sb-Pm
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 12:13:42 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wXLYj-0006eT-3N
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 12:13:42 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-45fd464d51fso3865913f8f.3
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 09:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781108020; x=1781712820; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=+YtsUEuR5GKlGLLBe3tBqRfFqbJQ+oyTxTM3hrgCUTw=;
 b=dx3jdDqPsxY8zzHMGSFmdKXxYxG1hQFTfNiwxVOX5Vh1aCk45bkRXxhrPF9Ci7sGCn
 aodvZz4jVhcRnCG9aC44MO+4mPYd5w0Sd+uTfC+n0iu6YTBu3uTBQxnhJ6Bn3JSs6wI7
 VqFRyAB4ywO4nzzYmMD1/56XR+45ib/3UudoGkmJxReAhtOxDVw4VQlrNy/tj6Cv/fz8
 gwyZ/wr4kUigF2V7hqB98rijnI1HhmgBgiLGUglLQH29J1a7Bj5IR4mdhY9I0PBiss+J
 utBDVUOraJ0WCUAdUjXOwMq6VF3mtAovHSLm/4mtYjLJ8EngLY9ftkklL9d89ijAYqo6
 TEiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781108020; x=1781712820;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=+YtsUEuR5GKlGLLBe3tBqRfFqbJQ+oyTxTM3hrgCUTw=;
 b=dxgr4LzCy0lfOn1wCDPYl6PsEB7bfXnqz3v5cLxtI8zUtEq5fMJJ+/zLECVHVGwzp0
 WJVmh140W0y9bPEXmozTAPlaAk8DCQsjGA6fH3hYxx9LYONHBkGHyjjkbDOf8mvM22Zd
 8jyguOFvFWrPVugZPNOXZQUZjvUp6CzQ1kKl3HY+vaWSaiSPnAQ9erG3PtlvxUfalfQ5
 Y46IRdXtOFcw4RH7Ti46iSGT2Pb1/4wy9OoUTSkOs5H7xeYU9VK4o+xCGSN6Iif+5QUo
 fqAXKXNyOLbhhnkVCg3Zu6/brDrkShhaqaS86SG2NiEgo/C8dCtPViUk0ZOnA6+1ykfo
 PcPw==
X-Gm-Message-State: AOJu0YySmqwGwqweQi1CEptUIcJ1guA1EmyNBXe47RrT3khHXpz24hKO
 RnSoiKk84f+b9gqeavB4QmgVHFuSzLlQxUDVNxEo8OokIg27umqvM7kMy2XWBmOPiHlmgctRiIN
 JqsWu
X-Gm-Gg: Acq92OH09P3mAGxc2gek6pe1h5bs1vMZ1kwD3Lj51TR/baiD1UGMGQ7m/uD6Ab2uz1E
 7YUWPjZnvQx01aYwycC8usMxzaDg5Ruh8V07lJOn2yulT2l4q/No8N5rO2bLqETthn08uWZuM3B
 g0uxEtiyguguvFwnxw4/g4iygkM8KgBMU95tVACgplUvjM49Wuem/AckCLXLg6VojNlrE+OQ29u
 516V8NvzmTPpCD5/GJ77mm4Nq1PcnwqzRhO06yAFGW9njLmRql6GyjU/pP07kqOtov71Rkdo5Qs
 kRFoiYCevRp5NSvIs4Fn+5i/6RRSpUU4N+Bly5IRRqU1u63LaPzvx4MkmksjtcXhrINeaYl+rgn
 S2eXGLHg36TN5ypAlWMsqCfdl5PaB7002G74MzImGIlHOvNoBqb0MUom6ozrZxCfafmQdq/gbo9
 msMgdnDu8Eb1deyywpwfL51yv+1QTXRT+AWeiX6JrKurf9WPi4vgF7rPla0LhwRisZfSnVrCOhB
 uUnTkWvlzbLdcIX8pvvNG0Sg8GeNta7+HOzllOLPGPxtT3iQ6hGcA==
X-Received: by 2002:a05:6000:b82:b0:460:1301:dec8 with SMTP id
 ffacd0b85a97d-460302dc4a8mr27540315f8f.3.1781108019634; 
 Wed, 10 Jun 2026 09:13:39 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f2dcbe3sm67911360f8f.8.2026.06.10.09.13.38
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 09:13:38 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 70/71] target/arm: Implement FMMLA (FP8 to FP16) for SVE
Date: Wed, 10 Jun 2026 17:12:01 +0100
Message-ID: <20260610161202.2235298-71-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260610161202.2235298-1-peter.maydell@linaro.org>
References: <20260610161202.2235298-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42d.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260609192110.752384-45-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu-features.h      | 5 +++++
 target/arm/tcg/sve.decode      | 1 +
 target/arm/tcg/translate-sve.c | 2 ++
 3 files changed, 8 insertions(+)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index 753799008c..9e70d30964 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -1728,6 +1728,11 @@ static inline bool isar_feature_aa64_sve2_f8mm8(const ARMISARegisters *id)
     return isar_feature_aa64_sve2(id) && isar_feature_aa64_f8mm8(id);
 }
 
+static inline bool isar_feature_aa64_sve2_f8mm4(const ARMISARegisters *id)
+{
+    return isar_feature_aa64_sve2(id) && isar_feature_aa64_f8mm4(id);
+}
+
 static inline bool
 isar_feature_aa64_sme2_or_sve2_faminmax(const ARMISARegisters *id)
 {
diff --git a/target/arm/tcg/sve.decode b/target/arm/tcg/sve.decode
index 6610432528..b53fe6a58f 100644
--- a/target/arm/tcg/sve.decode
+++ b/target/arm/tcg/sve.decode
@@ -1809,6 +1809,7 @@ FMMLA_s         01100100 10 1 ..... 111 001 ..... .....  @rda_rn_rm_ex esz=2
 FMMLA_d         01100100 11 1 ..... 111 001 ..... .....  @rda_rn_rm_ex esz=3
 
 FMMLA_sb        01100100 00 1 ..... 111 000 ..... .....  @rda_rn_rm_ex esz=2
+FMMLA_hb        01100100 01 1 ..... 111 000 ..... .....  @rda_rn_rm_ex esz=1
 
 ### SVE2 Memory Gather Load Group
 
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index f6705ee95d..a85558bdaa 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -8477,3 +8477,5 @@ static bool do_fmmla_fp8(DisasContext *s, arg_rrrr_esz *a,
 
 TRANS_FEAT_NONSTREAMING(FMMLA_sb, aa64_sve2_f8mm8, do_fmmla_fp8, a,
                         gen_helper_gvec_fmmla_sb)
+TRANS_FEAT_NONSTREAMING(FMMLA_hb, aa64_sve2_f8mm4, do_fmmla_fp8, a,
+                        gen_helper_gvec_fmmla_hb)
-- 
2.43.0


