Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18649C3ABB6
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 20:30:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uC2Q7-0006n9-No; Mon, 05 May 2025 16:28:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uC2Pz-0006jd-Ef
 for qemu-devel@nongnu.org; Mon, 05 May 2025 16:28:04 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uC2Pw-0000O9-T7
 for qemu-devel@nongnu.org; Mon, 05 May 2025 16:28:03 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-22e3b069f23so189075ad.2
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 13:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746476879; x=1747081679; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=H0yKlDOkjZzIDpwxCtwHuK2uhBYRx2fgU8VnadXpyy0=;
 b=qmUNV5I20xwh2dVVR8yXWtugVfif0z1CTa0oaaqFkQmviCFwahLij3GTUB9SS/i4t9
 uhZMPdrxumZnck/bVwh5luSaVfGcRlIewlp/NZOcSRZCZ8tunv3uN9Fj5eLFcvdtgoyh
 wls9B0DQIxPecRwobXOttksa6YQbuwoYNJnjk+l+LFimCLAVdFQVCJIBJveo41or+qJ7
 Hykydp1Rdlf0V7eVkln6H6a4X2Ut741Zgj7zDc8QavYN22lXo0pzILi2XAYM+8llTfar
 jdLA3s7S7UnnVIgNOzMNXEZQ/7KZZXp/9zDXEBVPxlVZFGN2BcxPcRUxKb1pr5uu1fJU
 +VTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746476879; x=1747081679;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=H0yKlDOkjZzIDpwxCtwHuK2uhBYRx2fgU8VnadXpyy0=;
 b=u/TBZPOrzfEnZpQTaGQZ4+fClgjwLrkd1i0E2uanal8gyayRtMbi0gu3Bi8uZ+KhjT
 dLhg/bnFakkvA5uaZFKNPG5UTV8iLNYq4lZrChcmfgtZ4uBSrcBH4q5yd8P7pzEUknON
 BCSiisJ4k6FFGdO3BQiELf/A0CVuU4r+NTbVEntcUhyVCfHN5Sv8lfKJaJc7IxX3ZU/V
 CHpqTZRq6GFqj5nECxKuUoN6vw2AHE7VusqtZjVbQHRbiaw0+pKSXex8iGk5LTzm6O/g
 lOmZfN0FDEyb+bSCW3JEkSsp7eFxVOMrjeIKCvOjZP2feeN87+VqEZZ7FC496RXXWhRr
 RO+g==
X-Gm-Message-State: AOJu0YyTZGTthLl7zJEAXjqy5HNOUmrY0xUgskRlitccSkbCLDMZ2A0a
 q8RPvQLdJCB4QF0DdEG5Z3EnjxVYRKulsEbHloApvP2uGxUqZowMGN5+MhBFDYcooYY3VX/UW58
 B
X-Gm-Gg: ASbGnctcAkG4TQJ90ZKFrZsMVz7jTZ4819sFvus4Rrk6Hu+m0d0XPE7SLne162kK0/E
 tShfwV6Gvdre92m+FboGMMWPn84bY619s1+OkvWII/Nl68FJKMiOwnX3ASEfIE9JuRKJSxoCdAZ
 0/lKBjt/dgwYFjY2AcyqXObQGfNaE7aCjHtx3HDyDu2zpnZIAGJAFtNe39oKCd+fHYDbdVcTPDl
 Ym3OAcwVYwd2qNTuDdTcgFkZHO2fTt3rmNMv8JC0S3ZCt5ALyTo0jPYZIohsQA2aLYBWZjfiBSB
 Zy759z35TtgS15HWpN+FwnGytpeBdiA6ZtICMtIB6LfZhe29fojMigqpso1MeRjvRwHWk9dgei8
 =
X-Google-Smtp-Source: AGHT+IHsHD78WjAoShlEePHlfC8i+fEMw6faDvA6k0hRxnM51KfoPrjxlJOCzKtDY3age68E1ucy7g==
X-Received: by 2002:a17:903:244e:b0:21f:617a:f1b2 with SMTP id
 d9443c01a7336-22e3311dba3mr10502795ad.46.1746476879304; 
 Mon, 05 May 2025 13:27:59 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74059021067sm7516485b3a.107.2025.05.05.13.27.58
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 May 2025 13:27:59 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 07/20] tcg/optimize: Build and use z_bits and o_bits in
 fold_nor
Date: Mon,  5 May 2025 13:27:38 -0700
Message-ID: <20250505202751.3510517-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250505202751.3510517-1-richard.henderson@linaro.org>
References: <20250505202751.3510517-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 9721c80943..d5256aa02c 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -2226,16 +2226,22 @@ static bool fold_neg(OptContext *ctx, TCGOp *op)
 
 static bool fold_nor(OptContext *ctx, TCGOp *op)
 {
-    uint64_t s_mask;
+    uint64_t z_mask, o_mask, s_mask;
+    TempOptInfo *t1, *t2;
 
     if (fold_const2_commutative(ctx, op) ||
         fold_xi_to_not(ctx, op, 0)) {
         return true;
     }
 
-    s_mask = arg_info(op->args[1])->s_mask
-           & arg_info(op->args[2])->s_mask;
-    return fold_masks_s(ctx, op, s_mask);
+    t1 = arg_info(op->args[1]);
+    t2 = arg_info(op->args[2]);
+
+    z_mask = ~(t1->o_mask | t2->o_mask);
+    o_mask = ~(t1->z_mask | t2->z_mask);
+    s_mask = t1->s_mask & t2->s_mask;
+
+    return fold_masks_zos(ctx, op, z_mask, o_mask, s_mask);
 }
 
 static bool fold_not(OptContext *ctx, TCGOp *op)
-- 
2.43.0


