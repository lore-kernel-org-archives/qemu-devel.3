Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5361AC3600C
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Mar 2025 15:42:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tx6PQ-00044k-Ng; Tue, 25 Mar 2025 11:41:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tx6PO-00043G-Jg
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 11:41:42 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tx6PM-0004Ay-VA
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 11:41:42 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4394345e4d5so37386375e9.0
 for <qemu-devel@nongnu.org>; Tue, 25 Mar 2025 08:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742917299; x=1743522099; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ov0qeNX9YGL0oYdATS3IENK9eMXw/drt5nInE25Olt4=;
 b=c7age1ugoBX/TD72LRxXp+RJIyi9Uhs8lMujeRGzYbnfG82uh0fkEmQzpwex3yIdJV
 TNdwEG37KIQ/hwqHR4mTRWqDwEdpmgat73Oh/648jbBizQnq4V+iyrSpMYA4HHfZ63XB
 Er5I3N1R/Sc7mYF4JoReqnxRia3Vko8bzdc7bmUbwiMVEqLOjhgYHz2o5v/Hgzk/MBNM
 bIdUPPB7l7Ed9nK1dMscPoHNFXk6/5vqN5+MqS8LWXdyUk28tSewCeqwAKQEnLTSz5h3
 KRsFtP+Oga+7LpgTaxlcAFbeuA480MdV/hpKUnUrg66JGQBt6vf77vP1RGAyJ/spGkQx
 F7Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742917299; x=1743522099;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ov0qeNX9YGL0oYdATS3IENK9eMXw/drt5nInE25Olt4=;
 b=EiVrUtea9qGM3uWNGwQ6+MulnzcPCUnTw/sWCLFMeLEhyNylHpGugS4y85tg6YH7Tj
 NDNKghD+3DrfaGmcfALwI0JPeH0G3iVRslO6KelPz1BCZXkbPgAj6hHCcFKupwyr/m9t
 K1DUO7rmsN6bcMgrJ1yLAnjjvtFiKHdDjQkyDefWGQrMfQDJmKAfwrK45rhYvBV4OFm7
 jiZ0AbqnonOhXAG7PgF2wui2A7WMy+90zHBij8OLhHR6SZyED9hCHYNvRfivPWKg57VP
 JideP1/JgzYMd3aiHmbdrEY3Zx8q46+eNLU01NLGX1aWKusFpQgqWTa9xcbINZS4eXY8
 eJeg==
X-Gm-Message-State: AOJu0Yyj7VsU+oDjdCThWmibO+LJRzYNQ5jANDxf+nNs6HOKkpy4DGND
 9iZy8t2f9jrrKf3h+Lxy192u5ytzqYTa7/6+e4ubdrP9SYyJ0eqhpbfNb15REgWUXJijPeE9Gbp
 W
X-Gm-Gg: ASbGnctoiBAe5AeACkcywSl/swOlqz25BZIYXQyd9TCk7nlZMCBJfm245T658DNiKLY
 A3RIpmDc1OVxSuF1UmTLjKzjAHrdiYhAleIyfsU+79SlrVqlYOZFG2/WAS5ZOGmUGW9D78SkMSv
 8ovnTRuD5yR13g4F034HSP+GWbUbH89hBd8HGMsY1+U4kt6cLAwiuftASs5eUlPkIJwSTK3+CFB
 V2lB3aCcNCWOEifxtrD4hRxRtA01HazPstCjb4tBm/5yx73mcARlytYdOsWTmYevR2Hw//Nm9xh
 Sc5cq4r/qInrU81nUZt4mw8apQlGcNUnY1Ucnl62UKdn9awyk/lEJ/5I9Vhvb7YrZudI8XJQyfQ
 1b/WDP3Lee2n9xprLdZc=
X-Google-Smtp-Source: AGHT+IGZeFhP95M3Sl4bGtLhSk1nDaDgb67HgjorV7Q6DLB1InYih+p5AHru6D/Qqwhvxr4jf4TA5Q==
X-Received: by 2002:a05:600c:22d2:b0:43d:7413:cb3f with SMTP id
 5b1f17b1804b1-43d7413cde0mr10246525e9.5.1742917298996; 
 Tue, 25 Mar 2025 08:41:38 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d43f556basm203127755e9.17.2025.03.25.08.41.37
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 25 Mar 2025 08:41:38 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Anton Johansson <anjo@rev.ng>
Subject: [PATCH-for-10.1 8/8] target/mips: Introduce mips_env_64bit_enabled()
 helper
Date: Tue, 25 Mar 2025 16:40:58 +0100
Message-ID: <20250325154058.92735-9-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250325154058.92735-1-philmd@linaro.org>
References: <20250325154058.92735-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

mips_env_64bit_enabled() returns whether the CPU is running
in 32-bit or 64-bit (behavior which might change at runtime).

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/internal.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/mips/internal.h b/target/mips/internal.h
index 28eb28936ba..8107a59b908 100644
--- a/target/mips/internal.h
+++ b/target/mips/internal.h
@@ -225,6 +225,11 @@ static inline void mips_env_set_pc(CPUMIPSState *env, target_ulong value)
     }
 }
 
+static inline bool mips_env_64bit_enabled(CPUMIPSState *env)
+{
+    return env->hflags & MIPS_HFLAG_64;
+}
+
 static inline bool mips_env_is_bigendian(CPUMIPSState *env)
 {
     return extract32(env->CP0_Config0, CP0C0_BE, 1);
-- 
2.47.1


