Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62B20CD98E4
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 19:14:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZZCJ-0002SU-Vf; Tue, 16 Jun 2026 15:11:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZZ8W-0004jS-S9
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 15:07:51 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZZ8T-0001Bm-Mg
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 15:07:48 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-490cdae130cso24688915e9.0
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 12:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781636857; x=1782241657; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=gdadH/7yzWF4YFsnZKXvCn1rp8rkx7uY4acc5Pbtdfs=;
 b=JBR4ahYvi+HHQQIpwM4rt2qk+qpY5npnqUbgy03pwC2mvFUJGjDwc2AQwMzhn7gGZo
 D8rW4nbmpl+l+c8yQr96Ps6M9gvNY/sRSAmqYJm3YdQUeqbZWqSXhgR9PUUfx9ZqXtH3
 i56ATiZ7Drf8ikKQ1r5c5V1Tauj17ljhfK2g9ArCuVB9VKMeVauxEYGiGKnfggSlumG7
 7tk4bH5Q9tCFYi+zNuBNoflRmbALRkwjS5dOFUt70JGWuKunfFlyJt/wn94Nf23fuizt
 bc1RjcifqfJN5Rst6N6+5t/SuoM7ceu/PfJyUpvgNumrrzIU5UO5eXiHn0PMCu5GSHA1
 wENg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781636857; x=1782241657;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=gdadH/7yzWF4YFsnZKXvCn1rp8rkx7uY4acc5Pbtdfs=;
 b=LYStPcYjj93HJ4aLq3aKdj/6FLZ1hVU4/Ib6XznLNzHxsZTFw0dN9jjEz0uGvT1m3q
 6vz8WksJrKpYYqCPRSfVoA8Rfws4y7fnCFJcPlC4DGS6QTHLAOQGZEFG6IfBvtEABJfi
 2NcCh4RB48MPxDwiMEulgSYXDpkonHB2u5TtrHSiKqO7MputdtvB1z86/JJPKqrWKDCw
 xyE9HrhBQ5zqA+n8mv1s+Bd8UPAHSY4lnhEpToNqLFcBVSs/4qwzKMmsEsU2VDo9d931
 e2v2lWecqFzW7YeXWmOyzfFFTo4tl44XjNXg/0uacuFmvF/p26xr4T/VpG1d93UTLkkP
 z7IQ==
X-Gm-Message-State: AOJu0YzZZRtGX1g4LN8EY9Y74u4cccukjDYE7ivzqQk8YzUtLzm98mr4
 KuUYyGNm1PCoNIjRxiNVcRTO3JbwEceOpuh7LlGSX26VOru9HHeEanSc+Qo3hA4ehtSHugeiA4F
 tV99A
X-Gm-Gg: Acq92OEdhAvbGip6JwaKIgLnVBpMvsaSN9Gt74g6bYzu3fBtPaqW+cImlj8o3KQdJxc
 F9F0QPjOFyrrGccQ10TKehQ720fvtOgiUTG8zym6cyT3V1EskDL3sUyQfqeBMdyG+MkGzc4YPkI
 HrREvhAeu80sS4/vyniiWPIqw5emixF92MfDY6kIbMfXDzsuOvtNUw24XFVpEukA8IxzMHvjsbM
 itzjST8IR9TdkYhMR+yz4ma7NHiQX1n1eki9PCNKpDhsg+nWPeJXEaEUwNtwLIIJVATPv02kqGb
 VS9LbU3Zp3/Aji5fltkb21F7BO/CrXBylXrziI8F6keFIrqB9dd9ELK6P/KkXbOJj3FXCbtAESE
 ONjEdn3KHv03d9bj/g1PH9/OQmW/zR6rI+BqF5KwNBPNjmDJ3NG5f0NnyMJG5Pc4symFZ53cSxt
 qpSZ24PdN7R3kCZkkH5zS2rCZzICOSLi06J9WjFXFJ0fy9IsURz8fq4FjW1TPaQiVBIe7ZcrQ7/
 7oWrljO27Zt27p6M8SfrCyjXx+t/EpDSe1AJsLaJ6Y=
X-Received: by 2002:a05:600c:e557:20b0:490:e5c1:b8bf with SMTP id
 5b1f17b1804b1-492333bfa01mr10036535e9.13.1781636857166; 
 Tue, 16 Jun 2026 12:07:37 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f2d9becsm45078765f8f.34.2026.06.16.12.07.36
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 12:07:36 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 50/61] target/arm: Implement SVE reverse within elements
 (zeroing)
Date: Tue, 16 Jun 2026 20:06:27 +0100
Message-ID: <20260616190639.3462006-51-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260616190639.3462006-1-peter.maydell@linaro.org>
References: <20260616190639.3462006-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x330.google.com
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

This includes REVB, REVH, REVW, RBIT.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20260604234852.573178-8-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/sve.decode      | 5 +++++
 target/arm/tcg/translate-sve.c | 7 +++++++
 2 files changed, 12 insertions(+)

diff --git a/target/arm/tcg/sve.decode b/target/arm/tcg/sve.decode
index e79b5e84c1..867ae2916e 100644
--- a/target/arm/tcg/sve.decode
+++ b/target/arm/tcg/sve.decode
@@ -730,6 +730,11 @@ REVW_m          00000101 .. 1001 10 100 ... ..... .....         @rd_pg_rn
 RBIT_m          00000101 .. 1001 11 100 ... ..... .....         @rd_pg_rn
 REVD_m          00000101 00 1011 10 100 ... ..... .....         @rd_pg_rn_e0
 
+REVB_z          00000101 .. 1001 00 101 ... ..... .....         @rd_pg_rn
+REVH_z          00000101 .. 1001 01 101 ... ..... .....         @rd_pg_rn
+REVW_z          00000101 .. 1001 10 101 ... ..... .....         @rd_pg_rn
+RBIT_z          00000101 .. 1001 11 101 ... ..... .....         @rd_pg_rn
+
 # SVE vector splice (predicated, destructive)
 SPLICE          00000101 .. 101 100 100 ... ..... .....         @rdn_pg_rm
 
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index d6a1683719..cd1e0e744d 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -836,6 +836,7 @@ static gen_helper_gvec_3 * const sve_rbit_fns[4] = {
     gen_helper_sve_rbit_s, gen_helper_sve_rbit_d,
 };
 TRANS_FEAT(RBIT_m, aa64_sme_or_sve, gen_gvec_ool_arg_zpz, sve_rbit_fns[a->esz], a, 0)
+TRANS_FEAT(RBIT_z, aa64_sme2p2_or_sve2p2, gen_gvec_ool_arg_zpz, sve_rbit_fns[a->esz], a, 1)
 
 static gen_helper_gvec_3 * const sve2p1_orqv_fns[4] = {
     gen_helper_sve2p1_orqv_b, gen_helper_sve2p1_orqv_h,
@@ -3070,15 +3071,21 @@ static gen_helper_gvec_3 * const revb_fns[4] = {
 };
 TRANS_FEAT(REVB_m, aa64_sme_or_sve, gen_gvec_ool_arg_zpz,
            revb_fns[a->esz], a, 0)
+TRANS_FEAT(REVB_z, aa64_sme2p2_or_sve2p2, gen_gvec_ool_arg_zpz,
+           revb_fns[a->esz], a, 1)
 
 static gen_helper_gvec_3 * const revh_fns[4] = {
     NULL, NULL, gen_helper_sve_revh_s, gen_helper_sve_revh_d,
 };
 TRANS_FEAT(REVH_m, aa64_sme_or_sve, gen_gvec_ool_arg_zpz,
            revh_fns[a->esz], a, 0)
+TRANS_FEAT(REVH_z, aa64_sme2p2_or_sve2p2, gen_gvec_ool_arg_zpz,
+           revh_fns[a->esz], a, 1)
 
 TRANS_FEAT(REVW_m, aa64_sme_or_sve, gen_gvec_ool_arg_zpz,
            a->esz == 3 ? gen_helper_sve_revw_d : NULL, a, 0)
+TRANS_FEAT(REVW_z, aa64_sme2p2_or_sve2p2, gen_gvec_ool_arg_zpz,
+           a->esz == 3 ? gen_helper_sve_revw_d : NULL, a, 1)
 
 TRANS_FEAT(REVD_m, aa64_sme_or_sve2p1, gen_gvec_ool_arg_zpz,
            gen_helper_sme_revd_q, a, 0)
-- 
2.43.0


