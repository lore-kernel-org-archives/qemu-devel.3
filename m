Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1751CD5BC8
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 14:32:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRsmk-0000xC-Oz; Tue, 26 May 2026 10:29:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wRsmh-0000l8-KW
 for qemu-devel@nongnu.org; Tue, 26 May 2026 10:29:31 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wRsmg-0001NS-7z
 for qemu-devel@nongnu.org; Tue, 26 May 2026 10:29:31 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-441209fb77eso6615674f8f.1
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 07:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779805769; x=1780410569; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Hp2FDximaok2RE+XvcBpnez4vXq0AYf7mVkyPILuhHw=;
 b=ksB68GeM9HGbvPUEh27vK/VC8TrTLWO7blcnPq57WnSHC6Z7p72/q9KEyOyTSF4roz
 LKcVa/i9klNQBA/DkTb5R6qYqjm9j25Vh9weogHtRzIGJRwty3oDu+Q6IyKG0nx73AkU
 BH7J6/tdwPvUc4XNmffFx7v88dZdQ6BAzxLyDi9riM3zEQNVB5DTPKgmd/OM9LdP3Vxi
 tT+wLy3WTDlZhVLKsqVq0qB4uI4Z2kqxluHdFbhrij9sNlHTP5HEKVb3dyGlweeev6Tq
 AocCQBa72dPzt3dsyNhQvkXXDQSo8tWuowfCpIxSnpD9S/K25WWEU9P8ZysFY2RNYklc
 QZeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779805769; x=1780410569;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Hp2FDximaok2RE+XvcBpnez4vXq0AYf7mVkyPILuhHw=;
 b=oeZjXx7qC4wEBzOzR378hDQBx22h3ZfNr0gj7RPSu3C8UrpS6MyelIPtgUxu0GQxR+
 ihxifSrMYqgun+KdzFz4Ppy8A4tOe/ZOWkKwrmIENs9f0h8B/aKNlWW1M8cPup5sr2sT
 TkBokxzcLebJ7ACcbxQCjkWevKaJ30GnD3KjytgwgB6Jlfyl+lLUNNg3A7lFuHvhDVWk
 omjbUQ7orYARHm8KtRWkU4cTvaskk257GHdX+otZ71GGfbsTzG1xvzetfaaVAuOlP6+6
 0hvSzu75Yr9j7iotrXVuWCRUMaHFN1GxqqM48m07gSO70MEuu9hclxuVw19cMomOfde4
 ERUg==
X-Gm-Message-State: AOJu0Yyhk+KfP9YSOXI8RcgDMKJExh7CKQ7d658g+V4f8/XXkcj13B6h
 vrQNU6F/towZu0dtNY68ugX0RO7JF73j6z1JzjU5GisY459J/HsTMxRK+nOKRg8NtubAGrZso6S
 Oy5OY
X-Gm-Gg: Acq92OGrxcVbM1D2UjonHnpqEEVkwPEHBpXVvDC0sdZWJH96gizHYIOKSnhoyoAi/tS
 65oz+jhxbFs1grxbVSdkQeG6zoMS9lNTtga9CMsI5g9xjicgekobogiMPXJKkUqh/Yb1JAfH2Dx
 xloD2avfam8N28hRctfEMckHETReq02sWQnsrh+GYMkOu4BqDWyBl5l0OVB7yNz/+Q0uFrO+hAe
 qfxM7lLLGNvz22FfnI8F2Qohdn2MT/vviTRuYseVXeZjvvvqta3tuwLH19v9Tr3P8r4MRNw2XWx
 p1FbXSzV4OXfsHEQMs58gdy6NMJAEpUSzZXQoe9CoEFvO553ZHuUfjAUtMLKfyAs/xzKaVgdD7B
 bZJaktXdsV/9NNXdBXMdHrQfUrUyqDHFYqm13UGp0rw8yXNFicC0XmylvgYgA+gF/fFqPgOxKS+
 +BCRpa+cr46AzYY6En7uX7AnTY11+r5PbuhXVj/RkNBVF6fngLcagMYIv0U2aqzjZUugXrzwFMv
 rH/J9JDBQJtEFZlZQoKcZrWb64yDK8=
X-Received: by 2002:a05:6000:480f:b0:45e:8a9c:608c with SMTP id
 ffacd0b85a97d-45ea3128da8mr35282270f8f.2.1779805768829; 
 Tue, 26 May 2026 07:29:28 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eb6d70c51sm38325225f8f.36.2026.05.26.07.29.28
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 07:29:28 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 37/54] target/arm: Update SCR bits for Arm ARM M.a.a
Date: Tue, 26 May 2026 15:28:33 +0100
Message-ID: <20260526142850.2326589-38-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260526142850.2326589-1-peter.maydell@linaro.org>
References: <20260526142850.2326589-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x435.google.com
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
Message-id: 20260522220306.235200-7-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 15a13b9292..3c2bf476b2 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1820,6 +1820,17 @@ static inline void xpsr_write(CPUARMState *env, uint32_t val, uint32_t mask)
 #define SCR_AIEN              (1ULL << 46)
 #define SCR_GPF               (1ULL << 48)
 #define SCR_MECEN             (1ULL << 49)
+#define SCR_ENFPM             (1ULL << 50)
+#define SCR_TMEA              (1ULL << 51)
+#define SCR_TWERR             (1ULL << 52)
+#define SCR_PFAREN            (1ULL << 53)
+#define SCR_SRMASKEN          (1ULL << 54)
+#define SCR_ENIDCP128         (1ULL << 55)
+#define SCR_DSE               (1ULL << 57)
+#define SCR_ENDSE             (1ULL << 58)
+#define SCR_FGTEN2            (1ULL << 59)
+#define SCR_HDBSSEN           (1ULL << 60)
+#define SCR_HACDBSEN          (1ULL << 61)
 #define SCR_NSE               (1ULL << 62)
 
 /* GCSCR_ELx fields */
-- 
2.43.0


