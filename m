Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3355606A32F
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 13:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=eziHXdPI
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNsDN-0003lD-O4; Mon, 02 Nov 2026 08:36:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xNsCz-0003Cl-CM
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 08:36:21 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xNsCx-0002I2-Rq
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 08:36:21 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-48afcfc4bf5so3081936f8f.1
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2026 05:36:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793626578; x=1794231378; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=3ZCrWyABTkWjvbI31rH3HXE7ST0Tyt4LZN0ZIFmr5v8=;
 b=eziHXdPIiTa5H5KtQdHEu/IL22qHTW5m5h22T4HcYktf5bRgAewKmjMVsxz3trNMxA
 8MQ5taL0r64rMS+rEZhKtplaFeU4THEFjYS8UUtEZo+obAb0ilJyvwXfOdUPmPeEq/YB
 2yJWWUcPwXvRpACXCc7lArcO0kxft2o8jgTZqN7bDVAn/DigDa+XJ2yr6d1K1P/f+A5o
 6TodwbmIpLbjif5KxUQ62015OOu4cszk+DnS6pPXwjjOOTnm1WXHYbr3SgoUyJ7O0e9w
 eAhlrppLo+5Y/JNf9PgZhG3KgnXoHrGbRN+4DeIBvmjZGOXl5pADwXuYFOrea4MLN5oC
 4blA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793626578; x=1794231378;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=3ZCrWyABTkWjvbI31rH3HXE7ST0Tyt4LZN0ZIFmr5v8=;
 b=HrV1LgjpsdLDEHXhbIajc0pH60FNaQjMU/Jfug0EDMXzyO0P1ErcgHcowHbm5JGa68
 X4lFoBgn2IMCjDheCfza6o+SKyDbUy9q6vGdDuK/LOpQGpimUe8nT1+DjDjVWVsL7zN2
 BAuZNPfbiKwr8jnrRWyk5LV2KmFEorlkT1JwMVD2A3Qaz9k9m+lOXpYwldGkN4f/Xcup
 J4iEAVA47M8zn6Y7sVYhmFnh2+0QZMfVuuP8/t+UjI7AV3+gxSTz15btAC+KDVkbVIcH
 B09sMXCP2J929E7sfW/PbJZtqSZPI6Lj4vp+QRVXOEuljkAgtmrZmmjQkv6Yw4UH1Q0k
 fMlA==
X-Gm-Message-State: APuU4Z8acIGb5OjRXu0rSqecO7ckb3++W9eIHGqDTBsa8clCp3myhG1w
 88IYBnUiygsZryy0E0DL4in35EAwWGCEbNXWqk2MPXUYGZ1vZ8LQ+kdrEWGxHVV88hnCR6erO5j
 Wrkl2uAU=
X-Gm-Gg: AYBFou36f7WQLF/4/eBC5EPyrXGkskQR7eHKfpb/3+v5/93nGipTdoDdQbT3GXoLppR
 Bxkf9qESlK7cy5apK3/uLEd22tOQQbPNI/+fgjbtUQaNw4tPzXhPpCQAT0P54jg/ZVK6m5ZeJIO
 yMTmS/ezK1ZrAq+WLb+sAAk4Hp9lDZPOA6d/UrFtOh/9e8sRYE0rV8Yb90zHvzTQP4RgMUWyM3J
 3/Raz9LPUlwSZcgs2CetDecnYrHWORjBlY9tNLVDuZfGMLRGM4IFoKcp0PLPOpwQ/a7NUX4VVdD
 otczHvS/hHU8F6dstOowHfuKb6gCBlcg7oZCq86Eq84VFAuNbdH4BLz2AkqKolVfycRdiyiW3SH
 05eRFyFd1cFkylq1zQ6z8mJcfIQpcpVsURcDGPnkddPGwLFXpZnEckLd46Wd0cOutE/Jiep9zZ7
 fgxH0E+jsSC3bYC0dQk6rPSX0GMI8NhD6bvrfDzlCKFk1kO9HS7GJbaOftwcOI1ea/i43Y08N0/
 7SnLOjWEit6+IOYO6O5CmnL6u2Cos6I/dB3dZmNxhOKLPgtDcC+jgcmQUWrJsdBb3lKJ9v0cCax
 jIn5ftWnLomlIbDY9crMS9F6XvPQN2b1vMpbwh8du5LBBtue4/DxR4Ng9g1Y2PO0WeG7IzZromn
 MAn39vcchcEMOQ4mG8qNUinTmTqpva4moEA==
X-Received: by 2002:a05:6000:26c1:b0:48e:870:7791 with SMTP id
 ffacd0b85a97d-48e6e30b824mr21153493f8f.26.1793626576889; 
 Mon, 02 Nov 2026 05:36:16 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71a4d3e9sm22556760f8f.6.2026.11.02.05.36.16
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 05:36:16 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 24/47] hvf: arm: advertise ID_AA64PFR0_EL1.GIC
Date: Mon,  2 Nov 2026 13:35:24 +0000
Message-ID: <20261102133547.1375701-25-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261102133547.1375701-1-peter.maydell@linaro.org>
References: <20261102133547.1375701-1-peter.maydell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42e.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Mohamed Mediouni <mohamed@unpredictable.fr>

For the kernel-irqchip=on case, advertise ID_AA64PFR0_EL1.GIC.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20261027120135.53048-4-mohamed@unpredictable.fr
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/hvf/hvf.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 5213842d2d5..acbc257091f 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1230,6 +1230,18 @@ static bool hvf_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
         FIELD_DP64_IDREG(&host_isar, ID_AA64PFR1, SME, 0);
     }
 
+    /*
+     * On HVF, kernel-irqchip implies GICv3.
+     * The kernel-irqchip=off,gic-version=3 legacy case also supports
+     * the host CPU interface but advertising it in ID_AA64PFR0_EL1
+     * is not implemented yet.
+     */
+
+    if (hvf_irqchip_in_kernel()) {
+        /* Advertise the GIC system register interface */
+        FIELD_DP64_IDREG(&host_isar, ID_AA64PFR0, GIC, 1);
+    }
+
     ahcf->isar = host_isar;
 
     /*
-- 
2.43.0


