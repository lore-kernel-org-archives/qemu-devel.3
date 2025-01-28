Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1B37C0218A
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 20:20:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcrxx-0002Em-4P; Tue, 28 Jan 2025 15:13:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tcrxs-0002Bb-2i
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 15:13:40 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tcrxq-0001cN-FA
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 15:13:39 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-436341f575fso68044645e9.1
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2025 12:13:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738095217; x=1738700017; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=pFXB9XVHhGqTyGd3uwpPDAXKLS/4Dx8b8VuhtJe8Qgg=;
 b=SO0Tx7SSB9ZCdFzVuL7t9F4a7OG+wlhe2kSiziCu52s/GF7/7sg6qGZw3cfxXLMENN
 shK6MD1meDvYLmWqKK0oMRVxhtO+tMmHEdcFDRkjxuWy+3XNFsFcum9J3XYDL5WGo2JY
 VM+OOAJDiyORH+QAO1I78z1LTL4VefYNjq/26C+gjTD1DTYrRku4bc3MoOh3hDAqV8OT
 eiXCKdo+lM4FtPabeOxC4R6kZtZ4PKiqOLPb7qq0M2uXT5QmaOn/oAwD9CHBeRbPTHuN
 Qpc9UvUxyVNY7TZgJNNz685+BIZ6lzXktAHzTB36N49XRog1vT/rshFEdoM/HZQF5WFN
 ckIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738095217; x=1738700017;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pFXB9XVHhGqTyGd3uwpPDAXKLS/4Dx8b8VuhtJe8Qgg=;
 b=pxA3LVrMePQ4I06TQHRh9gNOWYuz5ALtkGTSzRcOsroLjVWa96VCFDsM05aTwe6bGK
 IHQsy2x0/S9NB8z2Ehd3kEI1pVeyrw4vrSUslNLVbj/8HPSeR4IkonIs2mB2sH6memgF
 d8lgbjLgyKwMJE/sh0VTYNy0oLLwVuNBmy+VtBUwJX71NKQsqugyBqqHrhfltv1duXcH
 2G4KOFBwxOVq4h7twL4LMQcK0E3ZZ/huKC5cmNetWPr4ocDVOISouOSwjeJoEXn1ijMG
 TgtCTH8ib7/jaDvCNBj6jbyDI95yiIsadkO97knhjOoOaKNid6+RYS0Za6kkpjVkjsEX
 Fozw==
X-Gm-Message-State: AOJu0Yw2S3Q6wqqr6aNQ88hZaAf6WNYKviYWPMYxva6kDwS2kmJ2dTnj
 mROzGphdPxSrNS3NWr6Uy0YcjsLQEu9AqdbnNaQCbesLogWMvYI0TE0eW3/5PshYKpjdpQupOpc
 m
X-Gm-Gg: ASbGnct+Cm4qDZ8QG3mO+36E7o2WO7A6ZE289XztxejSv7sqX0Ay3Nc5QOq3iA1O1n5
 Ghqm4GpboHg9RqXtJk1KuTgHdlC/ux/g+fY2QiMDbBYQoRpPoP6lOW3YKZuW4MQvx/M5nkoIdeC
 uPaoYi7v7Y8AbnwvJeVI/Y4BbfbILxOVyzI++s2A63i9tAHxcavyfzx4k1yvJL9TJyRnAXnbr4v
 ZSBZCxs4x0D/Zk2nLJ5keczKzBZYfyqtp2l8azdxjPDRiyyyi9FKE7sJ093hSytBCV0tq6mXJuN
 e954QabZeC8ILV2oID5BMw==
X-Google-Smtp-Source: AGHT+IHQS+Lh05U69QYESGvU1sNXQHr96yt/sdTSvoN8dtGVYhUE1xyeFr6nE6E3l4WIx5hyMwE5HA==
X-Received: by 2002:a05:600c:458a:b0:434:fbe2:4f with SMTP id
 5b1f17b1804b1-438dc40db94mr2867835e9.23.1738095216950; 
 Tue, 28 Jan 2025 12:13:36 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd4fa3efsm182524105e9.2.2025.01.28.12.13.35
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2025 12:13:36 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 19/36] target/arm: Use fp_status_a64 or fp_status_a32 in
 is_ebf()
Date: Tue, 28 Jan 2025 20:12:57 +0000
Message-Id: <20250128201314.44038-20-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250128201314.44038-1-peter.maydell@linaro.org>
References: <20250128201314.44038-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
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

In is_ebf(), we might be called for A64 or A32, but we have
the CPUARMState* so we can select fp_status_a64 or
fp_status_a32 accordingly.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/vec_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/tcg/vec_helper.c b/target/arm/tcg/vec_helper.c
index 011726a72d4..2ba1f7cb32e 100644
--- a/target/arm/tcg/vec_helper.c
+++ b/target/arm/tcg/vec_helper.c
@@ -2808,7 +2808,7 @@ bool is_ebf(CPUARMState *env, float_status *statusp, float_status *oddstatusp)
      */
     bool ebf = is_a64(env) && env->vfp.fpcr & FPCR_EBF;
 
-    *statusp = env->vfp.fp_status;
+    *statusp = is_a64(env) ? env->vfp.fp_status_a64 : env->vfp.fp_status_a32;
     set_default_nan_mode(true, statusp);
 
     if (ebf) {
-- 
2.34.1


