Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 242B8C3ABBF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 23:50:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCoQe-0001ek-UX; Wed, 07 May 2025 19:43:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uCoQ1-0000Qr-DY
 for qemu-devel@nongnu.org; Wed, 07 May 2025 19:43:17 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uCoPz-0002cO-LO
 for qemu-devel@nongnu.org; Wed, 07 May 2025 19:43:17 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-22e8e4423ecso3903645ad.0
 for <qemu-devel@nongnu.org>; Wed, 07 May 2025 16:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746661394; x=1747266194; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iyeC1dYqzIyRbq0U6QJpnfGNVlqEyh7oNHL1QwbMptA=;
 b=LKlVS7WyvtXPh/uQ1m4vuaJEirCQBweOoR+UVWi/wfuD+6CiBixoAmuSfkAON6aWHe
 WrJR9VMl7fBEKsuQVrnFbctq7LUFo5SF22e1OaDEMzCGPdCgQoQhLNKRVGJ3DUwLXPZg
 5baPjby2xTj/VAak9SGmOTp+/6LJIhoEy50Xt0xfgfqqtOj0UQ4+J5S53ahFGZu9LhGT
 VKoF4qy4MlItevXUodVtCwge87qJGXy6RCKLoIZkQyDSJ3e44LPWWjOEqjm8iHEryCHi
 hlqhIUS5NMQvrq4hDoUbQJvsuT26uXJwSsSOTOPsyzFEICKwclqERlrxYcYJQibGJvZ1
 gM9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746661394; x=1747266194;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iyeC1dYqzIyRbq0U6QJpnfGNVlqEyh7oNHL1QwbMptA=;
 b=Olqa/28dscTISbZDvbjEfXCKdmXxTwlyOMdpuY11hBX5Mn7bmrlsg+wLURXKkvTiRO
 QznFuYa/B0j58VVbwFTssRmhtzX6/YrePMmCVfIbrLtyZ2ilThChAPKbd3VYNzFy9Qbc
 qR6+f2M7ngjGrgizK5xQ0enlI7J2KMKcUCO/xgtRaEPC6b22ZcPijElb6GReqMnylZRu
 rAO4KcGS2y98JhMM7fIIpxm6fQM997e8Zl/eV2wOQEEbnNdOPO3C8INUHOrzDe1nrti/
 FRpAqSP6yr/VpfKj0/DLQALW5ZvJHzuO9BjJxnBSTwQFrDCX3p7y6c6zAG+5w0rzhA+b
 bTLQ==
X-Gm-Message-State: AOJu0YxoMt3lnF1XpjPK0DLAaSSFjYj7QNqMjfRGxsnkuOXFTv5y+433
 0qdtDFSi5qeIaThokTW+Z6E0A47AoJj5i3ugWYxeIySTmj96+h32G7VOfU7RbkgeAfegreYMGWV
 PfRCa9g==
X-Gm-Gg: ASbGncso2NbkQgHHK+5uvk3J/Wdg1SljtNIp7F0IucJS/RAOwA9jLe1EpOTa8oYndsB
 0x3lTb9XaWqF1XX4NovhZIDZs4MUYBm5zePzDB14lmohu5teSifg3J5VHsPzpe6DzrIZ5wcmRYq
 X4+1izQHhh1sxpAlaANIm5GgzgLiy8r9xnO8x7uLJ40TTIyQvf1z/e0bJI7IkkTqf/UD+7h3agD
 WaLBu2oM3FNLA0A1YMqpZC6OeTaKQYfBk6r1XHEQsxJ5DK2xFnD/ykaLY1R4fxTRhwBqZ28zy7c
 0gnXr3KNTnMLdo0s8E6FdqnqxzabTFj0/2KmZlSq
X-Google-Smtp-Source: AGHT+IE1Ej9xQIKVi4bEh4Jp4+ngGN9vsmsLRr556ET3roH8UN+f1PsZNybD/JH4J9gY+Vdhv/Zo2g==
X-Received: by 2002:a17:902:d4cc:b0:223:325c:89de with SMTP id
 d9443c01a7336-22e856138c1mr20161595ad.1.1746661394133; 
 Wed, 07 May 2025 16:43:14 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e815806fdsm6491325ad.17.2025.05.07.16.43.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 May 2025 16:43:13 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, anjo@rev.ng, Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, alex.bennee@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v7 36/49] target/arm/machine: remove TARGET_AARCH64 from
 migration state
Date: Wed,  7 May 2025 16:42:27 -0700
Message-ID: <20250507234241.957746-37-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250507234241.957746-1-pierrick.bouvier@linaro.org>
References: <20250507234241.957746-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x635.google.com
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


