Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27210C3ABC3
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 18:22:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEXb6-0002DR-Sj; Mon, 12 May 2025 14:09:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uEXX7-0002c5-Ja
 for qemu-devel@nongnu.org; Mon, 12 May 2025 14:05:47 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uEXX4-0000Am-Qt
 for qemu-devel@nongnu.org; Mon, 12 May 2025 14:05:44 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-23035b3edf1so10957305ad.3
 for <qemu-devel@nongnu.org>; Mon, 12 May 2025 11:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747073140; x=1747677940; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vzXXutq4wGalZELe39I44dxOL/4dV/vBf09UEOe1qt8=;
 b=DMXZHtJX1smv6cvWeys07mWKQu0AqT/H/ALyyNvxb8nuzwkhFHFj8MqlraE/0NK6z8
 FMl9XQz70mRvaLk540OL7p3EW/qa8ptHODm5RgNZzwQoDqB9ymj0Vb1yaFNMKrt91yUK
 uqCnMJi6vRpsPugxatpKSDZks4V+JLYwqdFfzsYr6D2YIB07pL/aFphe8Ho7GK8hH7in
 5F94rm7ZwrLEU7jq+XD5lzAkzIvrRuy3kxGywr9MXw7dG/9iPCx7SC35OCOmN72B7AFe
 brDpDJeeC68FrAFa398SfCC30ploRlo1TFRBz+cpsxWVXkfHULJWB6SxWa2P/ggQlG0q
 RoFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747073140; x=1747677940;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vzXXutq4wGalZELe39I44dxOL/4dV/vBf09UEOe1qt8=;
 b=SG6pqCf723bYJCiKuZGntJXLSC33EmLr0ucti8xVkB2tMoG4nTr1ET8WXCqzXI7RLb
 P3f2k/JYNwS7Xa1DpQ2piC0UhtKhV8c2zSwyCK3OeBEn9f4yi0mAgHkJZJWNvNCSnaeJ
 YYUcUQyBOFP7CrAHrtkhR8RxVS7eEKj1G3nB3dX/L0nSmP89X02RQRHkEM5HOZ5rcmzn
 r4T+XZES2U92/YjTMvPoPuJu2T4D9AbGzMF58QDWFkECY6ozBTvajrFNsCk9HpU9in+8
 frZcGQ1pCuMH+VTG+lcZrwyYuoFCZf4nicp9CixkLHx9csfX3IZPKMs78+BFofQRTtDx
 d7OQ==
X-Gm-Message-State: AOJu0YxWqRmWWkibi7nKIhCJU2NW00DDawsFoyR1lyzPNGLMOnAv1t/y
 F0AHHRBv6rfw5kqIradLJtBzVBnQQBc36X5oNySwhLQbKRSSExMQmOvmy46mdX0SxX+tdOn1eRB
 O
X-Gm-Gg: ASbGncubbxFHywHT55PHLfTitgHk2RbASwspBlt9CpbgO0NCDE4fSY+LuypTCn0+aZQ
 7KKl036F178OzxTyWc4JtcOPzJ7CsagEcuQooa7Gs87IYlSSwBM8KCQHkdAX5GusF2dHDAa/NIt
 66GpfmdjFyyPRkq5vQXazTMis/jHp7Gy0vYYKQFaup8WFB/PtaeAFp1MfklGPKEW6++pH8dmiK9
 c9joVFGxuA3WVqiy2ilpoLfh51aiY//9AZQDI1M/N0OodUlgSUIllOhlHOfBuhyzQUdyZM7UlPg
 0tPsLg4N4ggqW1MgsS6j08y0wcZgKgub5CciKJXv7/+++oUAxIc=
X-Google-Smtp-Source: AGHT+IG0CawLMJdn+wU+zZfg2tvV/EMa4PCPpMg3XKBwK3dfhIPYvIf0gA0Oo+3QqdpakH4hlP6iRg==
X-Received: by 2002:a17:903:2351:b0:21f:136a:a374 with SMTP id
 d9443c01a7336-22fc91a84b6mr225854375ad.43.1747073140323; 
 Mon, 12 May 2025 11:05:40 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22fc82a2e4fsm65792005ad.232.2025.05.12.11.05.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 May 2025 11:05:39 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 kvm@vger.kernel.org, alex.bennee@linaro.org, anjo@rev.ng,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v8 32/48] target/arm/meson: accelerator files are not needed
 in user mode
Date: Mon, 12 May 2025 11:04:46 -0700
Message-ID: <20250512180502.2395029-33-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250512180502.2395029-1-pierrick.bouvier@linaro.org>
References: <20250512180502.2395029-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x631.google.com
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/meson.build | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/target/arm/meson.build b/target/arm/meson.build
index 151184da71c..29a36fb3c5e 100644
--- a/target/arm/meson.build
+++ b/target/arm/meson.build
@@ -5,9 +5,6 @@ arm_ss.add(files(
 ))
 arm_ss.add(zlib)
 
-arm_ss.add(when: 'CONFIG_KVM', if_true: files('hyp_gdbstub.c', 'kvm.c'), if_false: files('kvm-stub.c'))
-arm_ss.add(when: 'CONFIG_HVF', if_true: files('hyp_gdbstub.c'))
-
 arm_ss.add(when: 'TARGET_AARCH64', if_true: files(
   'cpu64.c',
   'gdbstub64.c'))
@@ -18,6 +15,8 @@ arm_system_ss.add(files(
   'arm-qmp-cmds.c',
   'machine.c',
 ))
+arm_system_ss.add(when: 'CONFIG_KVM', if_true: files('hyp_gdbstub.c', 'kvm.c'), if_false: files('kvm-stub.c'))
+arm_system_ss.add(when: 'CONFIG_HVF', if_true: files('hyp_gdbstub.c'))
 
 arm_user_ss = ss.source_set()
 arm_user_ss.add(files('cpu.c'))
-- 
2.47.2


