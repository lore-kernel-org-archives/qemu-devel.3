Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DEB7C3ABC3
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 18:23:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEXeV-0006cZ-Lb; Mon, 12 May 2025 14:13:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uEXX9-0002eO-Nd
 for qemu-devel@nongnu.org; Mon, 12 May 2025 14:05:48 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uEXX7-0000CG-9r
 for qemu-devel@nongnu.org; Mon, 12 May 2025 14:05:47 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-22e033a3a07so52650895ad.0
 for <qemu-devel@nongnu.org>; Mon, 12 May 2025 11:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747073143; x=1747677943; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iyeC1dYqzIyRbq0U6QJpnfGNVlqEyh7oNHL1QwbMptA=;
 b=hvhuQQTYSvCPi75N/Z9eSJHatWPqjynrRvxJXclN6iSw5vIBxS29NoZwYNGN16xo51
 mMu3rtP39imnsJuwZ3pwVINwMUdlbIivOWurE+i8RXs9OX12wLYCgqSX3UX0lg+qpPZA
 E6rTkc89owszgceTC8ANgrjVJ4K7kGBCKuZ7V1kTDb+kEShh6N/HUQ5kiG6AWVPWtqu+
 XWb7y5oMNgicS41YpXUGI28m4oFeWrbG9Ya9PQDn8Yz6ReixzSe3tAyhw7uLRy1R46aJ
 7AVvj26YnOcc3sVyNhobJs4OXgyKF4YCZ5gqJnWoNzVLPv+b36qxG9udhyVqAb/TpoQr
 ZttA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747073143; x=1747677943;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iyeC1dYqzIyRbq0U6QJpnfGNVlqEyh7oNHL1QwbMptA=;
 b=cdpBBh+Yy2eSC4wCOFxyYattHto2X6pBlhaNbrUWDVvBhSyrWVPv0KIoQZ9PrdtQGB
 lmaPzluHwnIuTlbzkPHeP7FD7oqz87Xsbt0+pKb7vhDqyFiyx326czchqIHB9xflZqp+
 HUHgVZA/9j11ODIdQ/a2ILTr7rDuFGA+8iLDBt+IuYVVvVa23m0PWLjvU0tKwTWY8CHM
 eAnrgzYjZw4mj3TFSn8FYNJg1tDabfIKlF0Bv/Awwp5tqkju3g1de2x7f+M8l0k/WMUR
 rAmn6gak1ZQ/i4oCdUImP5mpl87XIAMAefpYIQzo/2i6J53MMP6Ka74agIN6J1fo/0EG
 efNg==
X-Gm-Message-State: AOJu0Yxe4GFkIw9PuJZIG6/8H7wpHL3QdTsSjX2R+hPPIVM6JgjHJuwg
 3vIZ1gGEsur5KWjU3C87nv2wyX5kDOPXgrJ+1ndhgthSAFS1w6hHPGKOiH6AzszRC/5I5JofuKO
 c
X-Gm-Gg: ASbGncsOqxwSLGdft4cc7euupU9mJ1D9jj2nWRXY28VbY1BZ++bqegYX2iEzNMWODWA
 pX9sWpLIpIxGsV/loXShirKtmiBMwSD3s+iDIEBgp/lOmKldv9RW5MjPwfuXEpggDVhKpMsAb6j
 EJ8o7dTsAHKA7L6nkLpfZBA42Vp+fLs56H7lCcBNoOSUyrDS5Xll6olacSxZ4fyoUp+AcdrWRl4
 8Mb7FqL+AFGAM2vrlvUMzotWb+22EpTMLNr4eCSBSMpCB2+xkdW4SGjsJQDPWYb5VDQ0TsqEu5x
 6yOfM93sSlom17JRpmimBlqH7Kx1yS9oCGTa9P97YJXK2UDgWP7kZH7Bsx+YBg==
X-Google-Smtp-Source: AGHT+IFT4upvCT13/RFGLduTc6Ungq+/RISUi+LE8T4VFVW3aX9/HV2z1HHE/PfvAyjp7XZNfam/PA==
X-Received: by 2002:a17:902:d48c:b0:220:ea90:191e with SMTP id
 d9443c01a7336-22fc8b1b1b5mr213956255ad.4.1747073143030; 
 Mon, 12 May 2025 11:05:43 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22fc82a2e4fsm65792005ad.232.2025.05.12.11.05.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 May 2025 11:05:42 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 kvm@vger.kernel.org, alex.bennee@linaro.org, anjo@rev.ng,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v8 35/48] target/arm/machine: remove TARGET_AARCH64 from
 migration state
Date: Mon, 12 May 2025 11:04:49 -0700
Message-ID: <20250512180502.2395029-36-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250512180502.2395029-1-pierrick.bouvier@linaro.org>
References: <20250512180502.2395029-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

This exposes two new subsections for arm: vmstate_sve and vmstate_za.
Those sections have a ".needed" callback, which already allow to skip
them when not needed.

vmstate_sve .needed is checking cpu_isar_feature(aa64_sve, cpu).
vmstate_za .needed is checking ZA flag in cpu->env.svcr.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
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
2.47.2


