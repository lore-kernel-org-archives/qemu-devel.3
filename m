Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7B5CC3ABA9
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 06:24:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uANL1-0005AS-He; Thu, 01 May 2025 02:24:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uANKw-00057c-UN
 for qemu-devel@nongnu.org; Thu, 01 May 2025 02:23:58 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uANKv-000726-6W
 for qemu-devel@nongnu.org; Thu, 01 May 2025 02:23:58 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-73972a54919so658988b3a.3
 for <qemu-devel@nongnu.org>; Wed, 30 Apr 2025 23:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746080636; x=1746685436; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hckfD0sziqBh1sSWGP9c0OUCVTgvBeVKgVHtB7xMeJ4=;
 b=PI1eWdSYtQTl/tMfe0DieAFHLgxVePNHMVDrIeeClAjiLafHmKs5m0TxwTp2P7djMs
 GRn01r6UvtdIYf9xMbZV0I0a4DivZwuG7bIyPN/P8BIAFUC6KjNWmWUZCHMPsvMvxBXu
 wsjmomycHHeHM1wrAukQUV3cq6do1CjcWzeTGO9DKaZX3yPpHexUc+/FsA72SNPS+ier
 OhCCj82DxYSgp0sBY7679UqcM6kTsYOmDOhJWBqVOSSaRV2OtJjSyfZ/C8LmwiTaEzvw
 3g/mn2IV+zujL/gpmueZDStdtK2GHt2QxcVXJ3JtDOGV5B4o+jlHneYIRvSSHqGxerHV
 LPLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746080636; x=1746685436;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hckfD0sziqBh1sSWGP9c0OUCVTgvBeVKgVHtB7xMeJ4=;
 b=XbKlJFaL75pAzztuOiPgaxJvG2L6o7mm9rbv3oXOibDya0/yxYfeghHPAy+Jbkz1nm
 8FnI8Ybz41SszeKx5NLvIUa1buGSEOcjGUXZl0nEN6IqC1RqgTbEIELy7lFmB7r1+iCX
 aNdsgtjb/0aUwwJtamZ3A1ikqUgO+FUuljyhDGylmkDi+tTzw5gx0UiQ7ZO3YhTByATh
 K/0XLwEW1HOHHklKnMOAC3L51OzYZgmTBTdUM9AitZox8Q+wYxIHml7+8H1MAoqJIdXL
 05sGO57diit7ORu2Pim86WLTu1qfbIsBd1vuvVtk2Q2ALkye0AFpcRm+EckpFPoKkIjo
 NivA==
X-Gm-Message-State: AOJu0YwvigE0D4jBXsrr5fQOPf3Sb36uuCD/3GKSl6a4X/x9xaJzt0i+
 uQfCogpq5HYIX3Tui0eV0NITdn/welPrTKxOb/xExSFHqQ0s43ra78UxuCPcBtJL4OXmHphyuuU
 P
X-Gm-Gg: ASbGncthgqCG0F+aNn9mM3x1FpN5jxHrk0WHtXBPxx+MTVoBzX9uhboTjI29qvu/HcU
 MZCZJT7WwNgnor3D78jQBpLSRragQp9QyMj5x8XQ1wBD/pBiZVkgS1aXTGQZBYWpuP8hCD6cxKe
 fRmGnWDI0cS+mbE9RmukET26sFU7qLMj7mUcwF1UDM0UtVO9YlFfyGrrZiqC+P+njHX4ew8ED0t
 gWdFvkztXQix2PtnrsufCIY7U3K2yUrWhST/aOUmKFP9GzQY8d812Y4Orm/UPX01SXtSsNNc+8V
 yb6cTt6AH1HVaL7McEURKlFuP6tGJfTQ7oDkseRD
X-Google-Smtp-Source: AGHT+IG+S56+ZntAoiv1rm9bGFR6phj1Ukrtx0wPUeRdiOa/xEyLOl/9EMgghyX64DBYfvIhG6E49w==
X-Received: by 2002:a05:6a20:d046:b0:1f5:80a3:b003 with SMTP id
 adf61e73a8af0-20bd864a95cmr2230421637.37.1746080635889; 
 Wed, 30 Apr 2025 23:23:55 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7404f9fed21sm108134b3a.93.2025.04.30.23.23.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Apr 2025 23:23:55 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 richard.henderson@linaro.org, alex.bennee@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>, anjo@rev.ng,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 kvm@vger.kernel.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 05/33] target/arm/kvm-stub: add kvm_arm_reset_vcpu stub
Date: Wed, 30 Apr 2025 23:23:16 -0700
Message-ID: <20250501062344.2526061-6-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250501062344.2526061-1-pierrick.bouvier@linaro.org>
References: <20250501062344.2526061-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x429.google.com
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

Needed in target/arm/cpu.c once kvm is possible.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/kvm-stub.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/arm/kvm-stub.c b/target/arm/kvm-stub.c
index 2b73d0598c1..e34d3f5e6b4 100644
--- a/target/arm/kvm-stub.c
+++ b/target/arm/kvm-stub.c
@@ -99,3 +99,8 @@ void kvm_arm_enable_mte(Object *cpuobj, Error **errp)
 {
     g_assert_not_reached();
 }
+
+void kvm_arm_reset_vcpu(ARMCPU *cpu)
+{
+    g_assert_not_reached();
+}
-- 
2.47.2


