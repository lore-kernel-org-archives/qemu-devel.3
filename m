Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC530F9EDC6
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 13:03:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFXDx-00016X-H2; Wed, 22 Apr 2026 09:02:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wFXDq-00015x-7P
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 09:02:30 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wFXDo-00017K-Lq
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 09:02:29 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-6771d4d33e1so458788a12.1
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2026 06:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776862947; x=1777467747; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kgu1+4lGM6dZXG0uV8Iil1k3pEDxsUz8IH6/W2kJVsY=;
 b=c7X9+e4daHluiv+VW2OLWapSGJWmKy0DgCvxsBmxiZ0SDR1/Z1oP3JxfLobZ3TM3Kw
 p10p95g6b3S+Jl7GucQ5jVfCsn9Rn/P9NypieIPPpxrtDUuQy0eqg7W77vJx6/3N9V8W
 9GtG5UTrEb1H+dRK6f6qAhnqhqxjV8Fb7wWu10QHm0041f+FgaKQbdXCi4XvF7buMfaD
 Y52m5nyDOVgfinRNjBm4Nwv4b4WGug0V0mWMjxqJI8rBrdiH600e/j8tddphEG+CjlV7
 4aYwusv65HIs4W1mPJr0nASsDRQGqDwqW5Rh636blC0JOBX3TGqEXLG5rZvtSXUwpUxs
 EP/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776862947; x=1777467747;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kgu1+4lGM6dZXG0uV8Iil1k3pEDxsUz8IH6/W2kJVsY=;
 b=dfVqiuwrw9pVW8ZIHYzL4jQc9GFW/35BZTu/yh0KGYICHfLDc47kuSJfsrDFjUaPZq
 LZzCsH69IPaNm5liTj7QCg2bHxyLXHb12FtuSJNrvhEyMCJCVBisXDdATKpB9ZqAY+ZB
 CBdfVgMC+FicmwxmjDlx1R15nkHwFXgiLhTmDLDq1Px5/gHkPkHvZ7nOQpnrtxFZtkK0
 maiH7EPSAdunHmrVO9W27XdHRZM6rVMSV/E8SQd3rEDshdHEUbKHTa9DIzb2aX5WWSAj
 UAoimdaUP245t9A0UCjGv8zj4sD9fIg22qJEJGgNraWSueuGsXsybTxpyvR4AOLzK+L7
 HuuQ==
X-Gm-Message-State: AOJu0YxZI82PLq4RJlkpGxFcs6lfBDdhKdmxaMHLUSBXaj989eO+Utbd
 IXTpxCRfKhbUAeniJfnb/z7DD1F07YsO7kIxHFI/hxZNn4bNQdYxMBbWeqiXp4HKh6U=
X-Gm-Gg: AeBDieviu3DlsqUPOm+NUThtay+U3eig6fKz4+qgHzJf9u87/Kf+Plsu35lBgDa6IbZ
 EnYYTaQGyCl753hgGFM26WquVYhSGjtwGF9k1LSaQFMz/AQjGW7XHqGdx6dgCogp68iZ1b5uU54
 9CYoakXLzGgfKXXVH4Vn1AFVnGTZjwBL/bhgChM4p+qKjW07dBJ7mXLYlVR9cgArJggMNMEe84j
 llgFXiKTd/gr9FWpLyE6A7K1UeXUUpmg+QeF47mOvazj2qECQtoeXNhwxrsERaJkTlRxrNzFC/9
 xjlbP7hXvOHPUARXc1aQYtjguMRX5g1UarqzVNXhM5HXiRqTyiLuCJ7goi86JSMEsP61D1fT7nc
 bgjjReA0lKF/xLUklzsBJCNzZGNa5GtqTz2Wutybt94ilUpUjkn1d5Zv10pMRTdjQiRdFcmDCop
 XNwV2ldEDyjkJBgXKp5xbu5C/lNTVenHlDgg==
X-Received: by 2002:a17:907:a60b:b0:b98:40e:f335 with SMTP id
 a640c23a62f3a-ba41adfb10emr1011985966b.34.1776862946614; 
 Wed, 22 Apr 2026 06:02:26 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4e3a7b4sm42442835f8f.22.2026.04.22.06.02.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2026 06:02:25 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 9E238614A1;
 Wed, 22 Apr 2026 13:52:52 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pedro Barbuda <pbarbuda@microsoft.com>, Alexander Graf <agraf@csgraf.de>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>, kvm@vger.kernel.org,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v3 21/32] target/arm: use syndrome helpers to query VNCR bit
Date: Wed, 22 Apr 2026 13:52:38 +0100
Message-ID: <20260422125250.1303100-22-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260422125250.1303100-1-alex.bennee@linaro.org>
References: <20260422125250.1303100-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x536.google.com
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

These are only valid for data abort syndromes.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/arm/tcg/tlb_helper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/tcg/tlb_helper.c b/target/arm/tcg/tlb_helper.c
index c74d8e785a6..bbe1e70bc43 100644
--- a/target/arm/tcg/tlb_helper.c
+++ b/target/arm/tcg/tlb_helper.c
@@ -48,7 +48,7 @@ static inline uint64_t merge_syn_data_abort(uint32_t template_syn,
      * ST64BV, or ST64BV0 insns report syndrome info even for stage-1
      * faults and regardless of the target EL.
      */
-    if (template_syn & ARM_EL_VNCR) {
+    if (FIELD_EX32(template_syn, DABORT_ISS, VNCR)) {
         /*
          * FEAT_NV2 faults on accesses via VNCR_EL2 are a special case:
          * they are always reported as "same EL", even though we are going
@@ -190,7 +190,7 @@ void arm_deliver_fault(ARMCPU *cpu, vaddr addr,
      * because we masked that out in disas_set_insn_syndrome())
      */
     bool is_vncr = (access_type != MMU_INST_FETCH) &&
-        (env->exception.syndrome & ARM_EL_VNCR);
+        FIELD_EX32(env->exception.syndrome, DABORT_ISS, VNCR);
 
     if (is_vncr) {
         /* FEAT_NV2 faults on accesses via VNCR_EL2 go to EL2 */
-- 
2.47.3


