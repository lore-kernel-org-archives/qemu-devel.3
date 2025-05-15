Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4A00C3ABC9
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 10:36:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFVpK-0000rW-T0; Thu, 15 May 2025 06:28:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uFVnh-0005VN-5K
 for qemu-devel@nongnu.org; Thu, 15 May 2025 06:26:53 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uFVnc-0008Gh-Oi
 for qemu-devel@nongnu.org; Thu, 15 May 2025 06:26:52 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-442ea341570so4862945e9.1
 for <qemu-devel@nongnu.org>; Thu, 15 May 2025 03:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747304804; x=1747909604; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=DMmPrEBzw/pNSwsYU/O6mEpqFCBPIG8Om9+uShyE0Pg=;
 b=SEkh6iQ5GCvPSEjRi+F31miNfrNTXZ4ivcEK+IfwWUDPf6BOOVO5X1ar+31vkPSVUb
 Wr7rL/iPAkNU46k+WtmkYU0xTDTLyEQ0NEK/K5L6wWC9If/aZAOtScdTO8LSOfkwB9NG
 hmRtVDAM/fRbyAvyIeFzISGkYUdctGU/Mu+JUf9WYB4SB9N+LDrjh83bdq7yMPNVTUz7
 T0Yw8KL0tkZDn3EQ3f8UyJXLPwex9Fra19yhf3xzPMUB/1qGaAy4MFECcEjsrB9NsOMy
 s5Y6Y0EvOr20x7kQ24zgV9MPuFyoAFjxdFuLws5ltvWfnYrKRzydMk6eUbnLbQuqDDK7
 CNhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747304804; x=1747909604;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DMmPrEBzw/pNSwsYU/O6mEpqFCBPIG8Om9+uShyE0Pg=;
 b=qq00hjWbyVOALTNWTSCx611cMHQ85gLlIWRTkK/wue3dCJD+rNsEQW5Qrcky80aUHs
 ou9fwTfymW9+linBOgTSQxUANc8rDEIeg8ZshDG8bbePrf+AHh4v7XtxTZQNXpOus2lh
 8/e5JA9PONHdp0Vpu04IcYpgbLatQnf+r3oj/G1h7Q5nA2dYGOLEKN6XlSfSyW8HRZ1H
 jTeVXVdSk3cTNGLUgwEUqjeThWCwhW2i5P7WoRokDT8utJ0eXtJhArwjKgD58OY09TAO
 9EvwxOT2k4vi5zNljS1s756XzfCfsVl+n7XEAGPbvuLxrhoRKzYtMWpCqrPm/2ZrhI7N
 Bb5A==
X-Gm-Message-State: AOJu0Yw9CZ0UAmXUeW0D752THQnx4/7JPWxeL/QT0aFFM0Ixz3SGf37A
 UrS8YTwZ1yE6+nZAs3f3UrZQ0SO6gl7dZH+WgW/w2V/v1DrYjUJ3+2mLxkrQZ1Ov68VDThQ+rpC
 wxoc=
X-Gm-Gg: ASbGncsZk6igvdQLZzFaeLVfM0CAJYo2+/XWuxj3aGrdEGi+/BZGO24t5FYxovqq9Nt
 ABtDr9TmA5y17D/tjqIFWsqMIZaeduOnp1IrQYGKN4G3+IhBKkqoYoZU8v7qCpNF/ZU2xl5Wnr3
 14Ej27HX5NP/uqVICkCnk2B3mbkMmvGCrXX1Ctq9HXGQa8AE1VJm+EXqOTj588LdCJ8MCCHEupo
 a+QHZEqpN61xrZKHTYUsxzzIW7IG2fkFDZ/TzxBknC3FkTqEp479ZmbKdZpUPtdmEc11HFpbg2P
 2IXG+WTRxDgdZU8KiFAGGaMKXdAVeSt6DLq/cviS/UkwMysuFuKVjSLlNA==
X-Google-Smtp-Source: AGHT+IEV3TY8Y0GlDESxjmWa5J9Mc/1iI/bgx8PjdHRDNrLvAIPiQla2YFPY+4vWZWK1aCbVWTGWZw==
X-Received: by 2002:a05:600c:3e86:b0:43c:eeee:b706 with SMTP id
 5b1f17b1804b1-442f9706006mr18251145e9.24.1747304804361; 
 Thu, 15 May 2025 03:26:44 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442f396c3a4sm65657855e9.26.2025.05.15.03.26.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 May 2025 03:26:43 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 45/58] target/arm/machine: remove TARGET_AARCH64 from migration
 state
Date: Thu, 15 May 2025 11:25:33 +0100
Message-ID: <20250515102546.2149601-46-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250515102546.2149601-1-peter.maydell@linaro.org>
References: <20250515102546.2149601-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

This exposes two new subsections for arm: vmstate_sve and vmstate_za.
Those sections have a ".needed" callback, which already allow to skip
them when not needed.

vmstate_sve .needed is checking cpu_isar_feature(aa64_sve, cpu).
vmstate_za .needed is checking ZA flag in cpu->env.svcr.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20250512180502.2395029-36-pierrick.bouvier@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/machine.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/target/arm/machine.c b/target/arm/machine.c
index f7956898fa1..868246a98c0 100644
--- a/target/arm/machine.c
+++ b/target/arm/machine.c
@@ -241,7 +241,6 @@ static const VMStateDescription vmstate_iwmmxt = {
     }
 };
 
-#ifdef TARGET_AARCH64
 /* The expression ARM_MAX_VQ - 2 is 0 for pure AArch32 build,
  * and ARMPredicateReg is actively empty.  This triggers errors
  * in the expansion of the VMSTATE macros.
@@ -321,7 +320,6 @@ static const VMStateDescription vmstate_za = {
         VMSTATE_END_OF_LIST()
     }
 };
-#endif /* AARCH64 */
 
 static bool serror_needed(void *opaque)
 {
@@ -1102,10 +1100,8 @@ const VMStateDescription vmstate_arm_cpu = {
         &vmstate_pmsav7,
         &vmstate_pmsav8,
         &vmstate_m_security,
-#ifdef TARGET_AARCH64
         &vmstate_sve,
         &vmstate_za,
-#endif
         &vmstate_serror,
         &vmstate_irq_line_state,
         &vmstate_wfxt_timer,
-- 
2.43.0


