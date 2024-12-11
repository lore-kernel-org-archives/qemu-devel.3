Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5630AE77180
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 14:46:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLNxN-0006u6-3j; Wed, 11 Dec 2024 09:44:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tLNxK-0006sw-TR
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 09:44:50 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tLNxJ-0003sQ-7W
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 09:44:50 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-434a1fe2b43so68507185e9.2
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 06:44:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733928287; x=1734533087; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=M7va31x/VOYddYKA/oiv6RnIYgMyqPQV86yEQWd9Sec=;
 b=oUyz1bKQ2mKbYTyCYyCPSZZL6NZnAG+y/WikCnY1wW9XS3En29v3cmUIVSiW+HkfZW
 PQSGQeIotrcmPDF8vOSbgdPR7Ge0LPDTgSY7ky4LdNrPhownDVDwtvsWLDepY+7emt5z
 XGqcKdmUuzmLLs7hBBaVbleOQCsXIJubcO4bvVle4Iwa8zJgAuxYXjhLAJOGMfoeDB1C
 2UHs4A4oMU6fHZa2d8JShMrspjLXKwe54Zl1IL5e6KONMxpo7/AGRNnkTzRn+wr0frvz
 Na6YHrTo5DWKJfvAkPcdqssn3Av10rSTtvAdnj2EUZo/MrC3Zs9QQGyi4g9ucKWl3AVs
 cavg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733928287; x=1734533087;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=M7va31x/VOYddYKA/oiv6RnIYgMyqPQV86yEQWd9Sec=;
 b=OZQRdj6vcSp5IfmwKbbyeowDd3wlTur/sYuJSyk58weo6r1aEE2EFiThRmlt15ILEh
 Rnsr2gpr0ywZVMjFmbR8ZgudlJnLufd2t0LYcH8NF7Kb9m4iyp950mEkH+cIMD9Es5oq
 2EHfjE88mMDpbLSvqegU1BrV79HWiNtfHCTZpMy/iciF6LoU0urK8FAOJjsTHw0cT3dv
 azcWNtbmPHhBC3QSTnGcSgcpR6nsAXqwvPtkm+3NZFzdYSbfpppMKJJKFElvX1HXWAGv
 vDhFvakG1+YpUqqbFNRrbWvrYZ33EHTb17pT9ROqVzD336QyekWbL9Coc5Hf18jnBHIH
 sgOA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVopPrmdfPluChu7z9V0DHW/17zRI8BZAIdsjfA0IvdM7qpo4q0sGzhVBog1g7iFbkJ6Un08XN7CLgD@nongnu.org
X-Gm-Message-State: AOJu0YwP+rW5Z+p4fHPbrcXGDPm9Vashp03vW61QOdftKGjBFQ2nwtya
 8hLQaxY4ZmIzq1l7HnexVLtPk25MId4VlugN8Wl948A21vieK2KtwecVST/Rh6o4e5bBxgkIEtJ
 2
X-Gm-Gg: ASbGncu4UExUoBCYFoKNF9Xtyo2/Efpc7Eo2ACMb8lKBZQ22PU3sPirMKJOCI3zSDwH
 69dmtH2P6LWRaXxGt/SYuoAYe8ZOL71w1e9KX9FYK9Yo1KBd83XEt/t7hJjKOTjWh/AHAMWdyOs
 B4s6n5ovmoiMMGDLm1zshmk8DhuO9i+sDbUx8ZYZHN4LlYuxI3UkniJ25jWGvi1zJOGYn0+cAIy
 XfqLF7nnxpXnDJRte0Ki1UKzbFeWQVytE3DvVdNRydZ8HWQlV6ZYPjtwKPG
X-Google-Smtp-Source: AGHT+IEJAwcaRDBxa3IX33/WMbtD1mBXdWIlwVvVE5ZC88fjSMX7xesJKfj0QgNoVT7i2br2jXMjYQ==
X-Received: by 2002:a05:600c:4f11:b0:426:647b:1bfc with SMTP id
 5b1f17b1804b1-4361c4485dfmr28057045e9.30.1733928287469; 
 Wed, 11 Dec 2024 06:44:47 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4361e54ef20sm19477685e9.5.2024.12.11.06.44.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 06:44:46 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 5/6] target/arm: Enable FEAT_XS for the max cpu
Date: Wed, 11 Dec 2024 14:44:39 +0000
Message-Id: <20241211144440.2700268-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241211144440.2700268-1-peter.maydell@linaro.org>
References: <20241211144440.2700268-1-peter.maydell@linaro.org>
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

From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

Add FEAT_XS feature report value in max cpu's ID_AA64ISAR1 sys register.

Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
[PMM: Add entry for FEAT_XS to documentation]
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 docs/system/arm/emulation.rst | 1 +
 target/arm/tcg/cpu64.c        | 1 +
 2 files changed, 2 insertions(+)

diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index 38534dcdd32..60176d08597 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -154,6 +154,7 @@ the following architecture extensions:
 - FEAT_VMID16 (16-bit VMID)
 - FEAT_WFxT (WFE and WFI instructions with timeout)
 - FEAT_XNX (Translation table stage 2 Unprivileged Execute-never)
+- FEAT_XS (XS attribute)
 
 For information on the specifics of these extensions, please refer
 to the `Arm Architecture Reference Manual for A-profile architecture
diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index 2963d7510f3..449cec5a626 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1163,6 +1163,7 @@ void aarch64_max_tcg_initfn(Object *obj)
     t = FIELD_DP64(t, ID_AA64ISAR1, BF16, 2);     /* FEAT_BF16, FEAT_EBF16 */
     t = FIELD_DP64(t, ID_AA64ISAR1, DGH, 1);      /* FEAT_DGH */
     t = FIELD_DP64(t, ID_AA64ISAR1, I8MM, 1);     /* FEAT_I8MM */
+    t = FIELD_DP64(t, ID_AA64ISAR1, XS, 1);       /* FEAT_XS */
     cpu->isar.id_aa64isar1 = t;
 
     t = cpu->isar.id_aa64isar2;
-- 
2.34.1


