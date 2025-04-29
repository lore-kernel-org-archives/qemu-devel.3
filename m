Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F293DC369DC
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 13:23:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9kvP-0005EU-DD; Tue, 29 Apr 2025 09:23:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1u9kuk-00056r-03
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 09:22:24 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1u9kue-0005eH-1x
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 09:22:21 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-39c14016868so6066680f8f.1
 for <qemu-devel@nongnu.org>; Tue, 29 Apr 2025 06:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745932927; x=1746537727; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PW9jN2yS/TAOGn5xgs3qpwNb9whA0g2Y1AVjroSf5VQ=;
 b=olAB2tiGjw62DXbVy4Y6nqAvupBwXUTbLrceTOshH9RXmMAnrQ5EpLWCYAsNiNAwE8
 maU4p8+4wa4zaQ/Zmbc9K5rHAmAfa6s/kikpg4PWA2dLwy6SHf1xDIEbi8ifJ5raCh4w
 gJS+WJrLrNVjpOXCBHSYUjmd15jE50NsnUcHkuIWJ5sND6fXI6GcoMItp3FNpWkWzzbB
 svPGD5HIem4K9YHciMIxHuZQfkv7Wkysrw51TaAKGqe6SkRF9RdiCUXhK9Q/H4yd0zBi
 Fubp6lGB2AzOR6rT4LrKFYBsv7FrAWGoArcJqAE0nD9sZLBSQnmG1bAvhbOu6Yrzd4lT
 Wy/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745932927; x=1746537727;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PW9jN2yS/TAOGn5xgs3qpwNb9whA0g2Y1AVjroSf5VQ=;
 b=MCXCSqirtY1xc+PyNIldKjA02F7BNrCfL95al8Y5p6DEm0K4k7sBeelUrZ4p4PUkPT
 sdasbqDuCX6uzMvUoGLl/JjjN/wZj+kN56raCjr43DP8LD6chtsP56dsqbE/5mmIqxEV
 ZSsHPwFlEMzqYPtc/eJC6AbwcM42ZeWy6wHTRsNhsdckVjYyrjmF/wAuA8ZMLoP8/jjN
 BKc+s+6VBmK0v7VfF1PHicNbcV7+fUwrwOkVVsej/pB6vHhXLM01R+T9s1pCjwW1srWW
 hg6aJQ5CkZGqnH5SuML6NeYxiB9Q0QOFuursMI2bPDgK5D8eLpyc1vs69xDdpYJs9GDf
 TqxA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUDnbwMCznNo2RNHTBSJ2jbDeCBKAlnsoS+5qL4VsMYrLtaGCkHx/ti9sxJiCPQ5HkS+dzU06WmRVQr@nongnu.org
X-Gm-Message-State: AOJu0YwknwL/iT0DfB3+kc/Dk+xBNp3D3z6D2hdllFUbEIplqf8xAZMK
 yIG2VBzL7QRgVCG+ciXoJ4WzwAPniFWu5GXHPBv6Ji4NARDAfCrTlJkdkH5L5fU=
X-Gm-Gg: ASbGnculeUVeanXvxb1oiUDMAdRx+0p9qqUDpcgRQq2z2DFU8fPtMfdrSswe87cauD5
 iyjA9l+W6/XiCBv7furYE3I302gQGD+SuRdvfobGIytDngWr9FhRRfcMLLgssy4/zJfk6c/YfYR
 D+NTicHRGcJGpMVjsAejjsLuYAcYejkqbxItHEG2/ZDwni1PyQMVoEAhVHPcUOJEFEZunyK6j7x
 RhHpIK88jnID1eT90Wy9pmnnQVmILnXEI92Ru5ESFOwOfzAU3HpJ2Z61dBP7LJu6drtcD/Bc7nn
 oYwu2QvOtQZyla9OML4fIHy0ekY34742E5YDXurytu+pxRs=
X-Google-Smtp-Source: AGHT+IGBLzwfY7kUX2qxe32GFjWfe+sUuI9s4pXGF+5towfSetKyHvY2YAgyvKDzUjaeVi+8Rv6iHA==
X-Received: by 2002:a05:6000:b4e:b0:39e:cc5e:147 with SMTP id
 ffacd0b85a97d-3a0894a1aa8mr3065452f8f.55.1745932926674; 
 Tue, 29 Apr 2025 06:22:06 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a073ca5219sm13729371f8f.27.2025.04.29.06.22.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Apr 2025 06:22:06 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>
Subject: [PATCH v2 4/7] target/arm: Present AArch64 gdbstub based on
 ARM_FEATURE_AARCH64
Date: Tue, 29 Apr 2025 14:21:57 +0100
Message-ID: <20250429132200.605611-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250429132200.605611-1-peter.maydell@linaro.org>
References: <20250429132200.605611-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x433.google.com
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

Currently we provide an AArch64 gdbstub for CPUs which are
TYPE_AARCH64_CPU, and an AArch32 gdbstub for those which are only
TYPE_ARM_CPU.  This mostly does the right thing, except in the
corner case of KVM with -cpu host,aarch64=off.  That produces a CPU
which is TYPE_AARCH64_CPU but which has ARM_FEATURE_AARCH64 removed
and which to the guest is in AArch32 mode.

Now we have moved all the handling of AArch64-vs-AArch32 gdbstub
behaviour into TYPE_ARM_CPU we can change the condition we use for
whether to select the AArch64 gdbstub to look at ARM_FEATURE_AARCH64.
This will mean that we now correctly provide an AArch32 gdbstub for
aarch64=off CPUs.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/internals.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 4d3d84ffebd..f1c06a3fd89 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1831,7 +1831,7 @@ void aarch64_add_sme_properties(Object *obj);
 /* Return true if the gdbstub is presenting an AArch64 CPU */
 static inline bool arm_gdbstub_is_aarch64(ARMCPU *cpu)
 {
-    return object_dynamic_cast(OBJECT(cpu), TYPE_AARCH64_CPU);
+    return arm_feature(&cpu->env, ARM_FEATURE_AARCH64);
 }
 
 /* Read the CONTROL register as the MRS instruction would. */
-- 
2.43.0


