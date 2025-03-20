Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F9C4C28B30
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Mar 2025 22:38:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvOSK-0006ZZ-LY; Thu, 20 Mar 2025 18:33:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tvOPd-0002W5-6z
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 18:30:57 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tvOPN-0007BD-Oe
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 18:30:51 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-224191d92e4so26865195ad.3
 for <qemu-devel@nongnu.org>; Thu, 20 Mar 2025 15:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742509832; x=1743114632; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4+5iQ3rOTBSPEFMTgcjt+dky/l4beaGAM9ptuF8lc/c=;
 b=LfhFqAcLPKJ8i89CMAeJ6WnpfFLXUfzZOrrp8wDdMRBqZALrxFUKUBxbaVqT1yZ2+H
 YWZJtdrh3qXBW4VT5gXh8z23IUDXqqIgkL32UPdxid7H46J52qaZLOpPO07Smyl+ce8v
 vN0HMm3khszIfAv8cHt7TkuTOyLgxRzeGELwoEnMM5i+TPmj6UxR+druW5irey5qhJbT
 amkTU6Iv+4cePPUNVJCwYv9eFjja1hrO7hM/mQFXZsFC6ou4C44fvQyErAK4/8wrDaRw
 2tFMwLYKP26icx4AmH20Iq5Ifu/qhFT0zjpLrZQw0olYpkBKKj7Fm2+FK73VLPvRjA+U
 wBkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742509832; x=1743114632;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4+5iQ3rOTBSPEFMTgcjt+dky/l4beaGAM9ptuF8lc/c=;
 b=XeTRZkrTUC4SO91XWeo6ur8k6l7F4BOjQQTpq1XFUTFNxEwAOim34wYQwol6N4EXMm
 HtJaijwpfIkFEXp5hCViKHWm+38GfDq3JudsjUXOmsT0Z/6wKxiYlHrb99LQ+lfB9Aqt
 6YgCL/s4xA/mxIiFsb/PUFXF7gy8BaKZffGRmomscut3k7OpLtzS3iLDaBeecC6RA6sk
 EmmWtSWHK0o2JbbXhSjJucN/XI+pD7lgxJb5I2uUsgPDSnQ7C5XGUGcr5zzVD0YuAcif
 0qKUMIbU3FbzqwMUCo+kWn2aIdvMiuK/uqZdTkNk/3ImBNPwHFj/x0fAq1sDodMbwkEp
 Bjbw==
X-Gm-Message-State: AOJu0YwO26A2p7nJAu0mfBbMeqDBSGYu9jc7GWQLK0Zdwa8zrf2rBpIO
 dR5Jy6+Ce/79ENxCDC7fMtjCUnK6SWWQs2jw8IArKkB0aXVN56Se46BDmT5X0vrlHyZ9stT2TTf
 M
X-Gm-Gg: ASbGncsdDI70dCWqLnRpWa36ZsisMpeX3jC1RqbGOpNyZravwt9rDsNOqEppZJplY/0
 lmuVCAMwl9G+TC7y/K8W2Tp/Tal+xf36QtrbPtSKUtmIbag3HA2uEEAShLUWzMMPkRfgAyipJyM
 LDbz+Q9gU1b6UupnRLchquJKMySg+KIuexxuSjdAz+27SK6PoVW6CuaoRbo3fUuGQA34VEtM1eg
 Zjb5KiMH6j4c07Ziwao+zizTcMw+trD2wHFchBiTeu295qoCOIotVKnANn7jx7YkjjYUy5cOXMv
 CCZOquSy5YKqueYemQT1WBRgTNEe+fp55q3OkUUt9mGG
X-Google-Smtp-Source: AGHT+IFZleVXELavrvrw7HY5fmpI4AcmTcQwLh35eXn6L+ltqmgswJc0Gwxa0tcE3YRrZRjHRWIdoA==
X-Received: by 2002:a17:903:94f:b0:223:5de7:6c81 with SMTP id
 d9443c01a7336-22780db3061mr18350425ad.27.1742509831956; 
 Thu, 20 Mar 2025 15:30:31 -0700 (PDT)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22780f4581csm3370145ad.59.2025.03.20.15.30.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Mar 2025 15:30:31 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 20/30] target/arm/cpu: always define kvm related registers
Date: Thu, 20 Mar 2025 15:29:52 -0700
Message-Id: <20250320223002.2915728-21-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250320223002.2915728-1-pierrick.bouvier@linaro.org>
References: <20250320223002.2915728-1-pierrick.bouvier@linaro.org>
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

This does not hurt, even if they are not used.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/cpu.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index a8a1a8faf6b..ab7412772bc 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -971,7 +971,6 @@ struct ArchCPU {
      */
     uint32_t kvm_target;
 
-#ifdef CONFIG_KVM
     /* KVM init features for this CPU */
     uint32_t kvm_init_features[7];
 
@@ -984,7 +983,6 @@ struct ArchCPU {
 
     /* KVM steal time */
     OnOffAuto kvm_steal_time;
-#endif /* CONFIG_KVM */
 
     /* Uniprocessor system with MP extensions */
     bool mp_is_up;
-- 
2.39.5


