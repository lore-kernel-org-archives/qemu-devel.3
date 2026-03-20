Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 639651098783
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2026 13:17:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3ZiJ-0006Lq-NO; Fri, 20 Mar 2026 09:16:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1w3Zhv-0005yk-6H
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 09:16:08 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1w3Zhr-0000MM-AL
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 09:16:04 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-b932fe2e1a7so253671366b.1
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2026 06:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774012561; x=1774617361; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D07oMhuWTwLxwANSJgDlzLINm06uozRFFDE1WuQsKhw=;
 b=qOB2SWVn6vWqI+boKVaeQyrdKCRoCMZ4rFIDGZ9MvPIBOljcVDwdOG0/KTNpPTb5lp
 g1SYTne0xMfy7zUKWZP0U7DU34adANindCIQVXFxVd0dXcT6aDWv0pHOdHuyruzkmPsG
 jY3gXWYzgQqLiklrl+1FwYU3yiikR7OhyNCYJh3DAxty+3E1dVuYUEuLkpzpUrD3tjcr
 Rwjk+NeRNCkhXu175OEPiwDB/zK0GVwSyQ6qoLKnLLwEu13fTb30TqZ9NRI5SrRmvi1q
 Cy76fuc4f9oRBFhWGsgGgrGR3H8H104nz3iuw90mOunnGsaZw9JgcVUcP59Sg2akGdP6
 L3Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774012561; x=1774617361;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=D07oMhuWTwLxwANSJgDlzLINm06uozRFFDE1WuQsKhw=;
 b=cHpHIhkEuaHb2LpQEJMufDVE3mcD4+3wIEJWfnNUNkErTTDhIVYvgYNJb1bvgk1dBG
 JkTtuJUF8KDvIW+A1PoQW19RCoPPdS/07xn0+4ekB0mq7SzO3r0JTc4XDPsn8h53RGtP
 KsuCE7WC4kkWsZ7vFTK9mOPrNtcd2nlzO4PJppkWAAeOuKaQ2n4TddkKRF4yRXycXNIt
 11IzMQoAzBkkYxQCkHKtcvUJETf0viRCHwP7qt9KI4OTt/cDmQueigjV0jc5V0Nmq3m3
 hhLui1XYX0sRIJC+gZgEg9ie/h1GlAmBMzL+pROGm4JREg47XTRSrT2VafQN6jyX2Puh
 kQ4Q==
X-Gm-Message-State: AOJu0YzyKBN+K/HQWDV4OTWEzxEBE3v17ywlEiAM6aw8sJykKO5JfsI8
 q0ZWKkUd4rKsBH2vyFInrlsN0ZILFSr27B1wrX2V/en54LxtnWDs73neyJbpGrC7b1I=
X-Gm-Gg: ATEYQzwvS8ODSdvV2OQhCDJqhBXNCVwSDdAPxu6VvowJ9iR+tzGhzFXSD1rJOuDG0Xb
 pBdgcRS4WaYwB7K70ZMj+UgKxDOccJ2Mki1QfTIJHEph9qyOywygwzHYgHTROXJR/qyPsfrqwEl
 mF8Vd6cfHdYGVPLkh1hgTPD8I688A4xqVGCR13umsT00X6dtAo18zDedtWgiJCIEKPIPNxG33/+
 6tuoeP/rAx6i4hTCQSVVHO7OiExJaLrnC1HyYZTm4X1+rxsURxdxsgwgPPw2Gy1h4HdV1JLnf3z
 5BVbocqO7W7oYaTbayP1/PTQi0cQaFGEohd4eL6+wMJQQMgYtBXyQCrgK0LlkLCJH7TzJgTpvN9
 aRO9YQfNaGpBzeFHvlxV3424RdoSFzIsCbUBNcnmEALrSSZMVR9y70UPMP4prI4CgGzUu6tZ4el
 TDIT+GTSO6TQPoo/KnWLcY5zg=
X-Received: by 2002:a17:906:2092:b0:b97:c5dd:c661 with SMTP id
 a640c23a62f3a-b982f3d6e2bmr150366366b.45.1774012560679; 
 Fri, 20 Mar 2026 06:16:00 -0700 (PDT)
Received: from draig.lan ([185.124.0.237]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b9832f8dc51sm157048166b.22.2026.03.20.06.15.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Mar 2026 06:15:58 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 76EFE5FA14;
 Fri, 20 Mar 2026 13:06:09 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org, Pedro Barbuda <pbarbuda@microsoft.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [RFC PATCH 22/35] target/arm: remove old syndrome defines
Date: Fri, 20 Mar 2026 13:05:53 +0000
Message-ID: <20260320130607.2071996-23-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260320130607.2071996-1-alex.bennee@linaro.org>
References: <20260320130607.2071996-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x631.google.com
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

Now everything is defined with registerfields we can drop the old
defines.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/arm/syndrome.h | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/target/arm/syndrome.h b/target/arm/syndrome.h
index 4fbc35ce7b0..1887467b719 100644
--- a/target/arm/syndrome.h
+++ b/target/arm/syndrome.h
@@ -106,16 +106,6 @@ typedef enum {
     GCS_IT_GCSPOPX = 9,
 } GCSInstructionType;
 
-#define ARM_EL_EC_LENGTH 6
-#define ARM_EL_EC_SHIFT 26
-#define ARM_EL_IL_SHIFT 25
-#define ARM_EL_ISV_SHIFT 24
-#define ARM_EL_IL (1 << ARM_EL_IL_SHIFT)
-#define ARM_EL_ISV (1 << ARM_EL_ISV_SHIFT)
-
-/* In the Data Abort syndrome */
-#define ARM_EL_VNCR (1 << 13)
-
 static inline uint32_t syn_get_ec(uint32_t syn)
 {
     return FIELD_EX32(syn, SYNDROME, EC);
-- 
2.47.3


