Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D9FDC3ABB6
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 23:26:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uC57Q-0006gI-8J; Mon, 05 May 2025 19:21:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uC57F-0006Tj-0M
 for qemu-devel@nongnu.org; Mon, 05 May 2025 19:20:53 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uC57D-0003fi-7y
 for qemu-devel@nongnu.org; Mon, 05 May 2025 19:20:52 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-22435603572so62568885ad.1
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 16:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746487250; x=1747092050; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E27VnLHwdjjgu7+qzkSpdD6sP1u8J5fzfB0GITxze0s=;
 b=oOhQ0VSwECX8CKhLC3cgJR14cRQDOJCZmb6hU/6xXJcKQN2oEqk6WHsMpQJE55E2Xi
 mMm5ZzhzLjZbn9XyD4BT1QgWyw1ffZBMoACutmGptLZ0ugJPmze7YPD7zeJ8Joitd3VW
 8FlyX2md0uSM0b0TdWza22Jr19s1wSpr+M5IaS6M3GiFEcfT54TkNRqCSi5bINlxGHAg
 FTHBYJIlEp9Ffr3pcMfPQwS6Ttsjr3YKIhpY0Gez0Uo4JPcnCkJ/uijG3aVoFxLVDgIK
 bSP4Fgo7kxduHSJwdutpH5eXa8YxQ2G57GWCJKVN0QfE8dmmFFAnroXxmz9KiQlVRqNr
 edXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746487250; x=1747092050;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E27VnLHwdjjgu7+qzkSpdD6sP1u8J5fzfB0GITxze0s=;
 b=NZSDqfvmoqrBA07amnDwyaj+3zQdn8dzrFnFP5vv2fU9pLRX6QGK6+6GzQpTpvimfl
 QE6uLVnjyIP7NTjGg7dPDBc8YHYEEt5N+QljUUg4DC8sXjfejj3c6DLpOAnKIquglrLd
 Uuu0EL3ehu12jymu8/Od7cHgV8cr5GFz+3N+KmDzEOLw2PQTC1xXb8l0IlMA8uSQNtBR
 BUOssglvWiRnUZfGruFuX6YCs/oU/K4AXQQ4uHEvPeJjzR4bxy+M264grSyG0o0Ma9kQ
 cNlHRRcx5dDlwJ7KkXYWU1OjQNcoLnwubvqgq7d3Y+PeB3rcSKnZJJMNGpGA4l2bCSMK
 TpqA==
X-Gm-Message-State: AOJu0YxiHiAMFGxHZubo18s6tfyneTGR8+AAceiPqPBXfMvIrra084X0
 EUBBlnSvzjNj5W8qnZli45TacnYsDLOS5EaRrnaVNWkeLw0ItIYzryW881b+HQmjRAHFP8nPFYH
 Jcw8=
X-Gm-Gg: ASbGncvW3ufI/9pqZpleLo1PnyaAMnGvKjLuBuYPWW0E8fgLdVZ4VCzkcQFRkADw7mp
 tYPkMc0CekonpTHahZtSz7bJPGw58CJFXHKOIa5J9B7cpqzy0wVVi6SCgifMbcMcw9rAS2CWdgM
 aKaBpdzAcfX4CiHD/gm/O2x2DGFLqYEMbwzNlQkj5uqA/T+rpbgGRfOTudnIBzCEM3dgLTPC4RE
 zjuVsvEAs2CtHTsRIgcoAntTeU+Cv294vH/PsWpIYpqQOXQoVS7LRXwkyfk+ZTOZxAEyeF3SRRF
 vlEmVTLnFB0tXxMhi1IPvZEvAVlGRshEtmVcu2f5
X-Google-Smtp-Source: AGHT+IETv5cggtK7g8tYeqBJIFsslayFPnvoIslaVy/AYK+NCIa76R0mH5k9pEhCIh+PzFXX9HxutA==
X-Received: by 2002:a17:903:291:b0:223:2aab:462c with SMTP id
 d9443c01a7336-22e1e8e6848mr130031445ad.15.1746487249736; 
 Mon, 05 May 2025 16:20:49 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e1522917asm60981715ad.201.2025.05.05.16.20.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 May 2025 16:20:49 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, anjo@rev.ng,
 Peter Maydell <peter.maydell@linaro.org>, alex.bennee@linaro.org,
 kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v6 33/50] target/arm/ptw: compile file once (system)
Date: Mon,  5 May 2025 16:19:58 -0700
Message-ID: <20250505232015.130990-34-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250505232015.130990-1-pierrick.bouvier@linaro.org>
References: <20250505232015.130990-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x630.google.com
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/meson.build b/target/arm/meson.build
index 6e0327b6f5b..151184da71c 100644
--- a/target/arm/meson.build
+++ b/target/arm/meson.build
@@ -17,7 +17,6 @@ arm_common_system_ss = ss.source_set()
 arm_system_ss.add(files(
   'arm-qmp-cmds.c',
   'machine.c',
-  'ptw.c',
 ))
 
 arm_user_ss = ss.source_set()
@@ -40,6 +39,7 @@ arm_common_system_ss.add(files(
   'cortex-regs.c',
   'debug_helper.c',
   'helper.c',
+  'ptw.c',
   'vfp_fpscr.c',
 ))
 
-- 
2.47.2


