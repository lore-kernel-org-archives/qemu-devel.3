Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BC18CCA476
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Oct 2025 14:19:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v68Qw-00062u-Nt; Tue, 07 Oct 2025 10:12:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v68Qi-0005s2-IR
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 10:12:45 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v68QU-0002NC-Cy
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 10:12:40 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-46f53f88e0bso18543435e9.1
 for <qemu-devel@nongnu.org>; Tue, 07 Oct 2025 07:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759846344; x=1760451144; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=6nKj99KdmBR33nuMOThvE6JAKFc6l5qFA/gSXuXJhag=;
 b=yJ/Z5GDRuLS2J0U2zupXvEj+E/3yosiFZxJcHrdJ0KZ4zeWpu/fClFd8M5vkUr4E0B
 hDTqAqGn/m6MhwjiIwEO/y4POa4va59RMFCa412mR7Tm9FGrwpQteFov3RdH/1+Gxp/d
 CcvhQgFj3rbmfPjVI6pp/Xuvwr7J5U5lp+KECJo6CHRMEGjWjMTaSBmebByDt4BPW437
 tnTC34aCSG1EW+kJEEXSXQlryQJ+BRyrcr0U5HUrdjettaKhIyVK3b3XJgMRS740UJ8N
 6IwFNaiBOhIjTVI+AZkpRbr2sMaze3+Vh+99UqhhR9pV3RMChoVbfPw2n1pdmlzYnkUN
 1YAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759846344; x=1760451144;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6nKj99KdmBR33nuMOThvE6JAKFc6l5qFA/gSXuXJhag=;
 b=m/UNP10HCMyU/FUjxrcBcNQaReEtq48CXwC0/x4Sv03LdYis1SJEMo39hVvZq1n+2H
 jtywOO/DZPDcFCk57CeIse4HhO3yj2rPBYWJqfYKIEuR4GP3CsUFthTd0wWne3XkoiAV
 EhDYO47HtyeEjq98b1BpnDAzIndZ9MLdX8ukmaw44mDLwsANXXrIdI5Pg1P6EMmOeOBL
 D4ayOy5zduGGL8I82Tl7pRW/CkGO1xkNGxiHf9BRbZMzuncHGnJBLNoEMGwKOT6I1HHI
 LKgErT5R/Ir9dHeBE33RGgf4XbNPSGUjYK7te6RolKu3ol3I9PsBivDbrf2Kx3XNkB6y
 vhgQ==
X-Gm-Message-State: AOJu0Yz3Dkh5pudN6PL9wN9EmyCsIqpFeGHk5RYgYL1NRSvNGObpOuQF
 8ELGIkva0ad/nC/bA82TLaCxjo+A18UZsklCM34Z+0IuwCBGCrAKssXGYk4S5ZbGcWK2w9PHYb1
 RSMHK
X-Gm-Gg: ASbGncuBvjLSuRkibsPPdC2iJNoh22gsLgSUCM842FymeperMmeiNW8sRO+sG8t3vIj
 ajEM7MVDR7wlMGJhZ2Skk/iHoCtFwlLwYYJd4sc2zfBbAjIno275IjthoKGdr3vPV9ueAM9Aqqj
 S8HfPUN3EFeDj9SuRr7kskFDGnkdGGk3bf2jz59T5G0MXfk4w4EcAhOjG1sA1hXTvDq79EcxzTI
 DewO9j1gpGwf1AsevC6UIpv2X0GviBs0c0qSRI6BIDM1A5wvXvlHlo4gqVhYk2YCDPKFM9t0mTF
 HNXpXmJmPFzRBR57RTgXXxgoTE8FgC1/L3Nxh78w3QAEeoFkE7rqi+MEg7/1+D0SMIj7EoLNIZ2
 kMOvLjwqct84mYptLzaYhZrU72PQBOmtT4gi6Y4GxTp3V5Gdb1xGvLXn6gBS5DH4TAW0=
X-Google-Smtp-Source: AGHT+IHr14AJZLG8/JQvR8FZxKhzEpsQAPh+tTTsCmLavXFe5lPxntlRuGUJHpNmBRRE4e70tRxzMg==
X-Received: by 2002:a05:600c:a101:b0:46f:a95d:e9e7 with SMTP id
 5b1f17b1804b1-46fa95dec1amr1275735e9.0.1759846343736; 
 Tue, 07 Oct 2025 07:12:23 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e78c5d290sm167037135e9.0.2025.10.07.07.12.22
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Oct 2025 07:12:23 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 53/62] target/arm: Add isar feature test for FEAT_RME_GPC2
Date: Tue,  7 Oct 2025 15:11:13 +0100
Message-ID: <20251007141123.3239867-54-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251007141123.3239867-1-peter.maydell@linaro.org>
References: <20251007141123.3239867-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x335.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-id: 20250926001134.295547-2-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu-features.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index 602f6a88e53..f59c18b6ef6 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -1091,6 +1091,11 @@ static inline bool isar_feature_aa64_rme(const ARMISARegisters *id)
     return FIELD_EX64_IDREG(id, ID_AA64PFR0, RME) != 0;
 }
 
+static inline bool isar_feature_aa64_rme_gpc2(const ARMISARegisters *id)
+{
+    return FIELD_EX64_IDREG(id, ID_AA64PFR0, RME) >= 2;
+}
+
 static inline bool isar_feature_aa64_dit(const ARMISARegisters *id)
 {
     return FIELD_EX64_IDREG(id, ID_AA64PFR0, DIT) != 0;
-- 
2.43.0


