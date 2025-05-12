Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C309AC3ABC3
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 18:24:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEXXL-00037F-0N; Mon, 12 May 2025 14:05:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uEXWj-0002KY-Pw
 for qemu-devel@nongnu.org; Mon, 12 May 2025 14:05:22 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uEXWg-0008Rk-3K
 for qemu-devel@nongnu.org; Mon, 12 May 2025 14:05:21 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-22c33677183so42477425ad.2
 for <qemu-devel@nongnu.org>; Mon, 12 May 2025 11:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747073116; x=1747677916; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hckfD0sziqBh1sSWGP9c0OUCVTgvBeVKgVHtB7xMeJ4=;
 b=DXU2Hh0/V9rnYpJslV2krVChwTFYxA2nPdhZQUcdr3nvluTn8Q9E0NMUvHPPufYVXF
 vM1bDzfmjblKzgbsni7dcFx9+x7RQsPTR+DXPky5ZUtb0DuF5YYVi2rlCr3ymE9m+SDE
 1418aAy1jQFRO7kXwYJ6FMA11Yxvpx0ccYDmWr1Mgia34getLteYP7/XAJPrY5ZMRZAJ
 WymGk1K5iBlynuxo+T2kW1UPZVGDFDPIUbc5wJlmjJYViOOU7QH8I+7W9SegFfeWAfVI
 BYpxG3Fa1x+YNNXwlcMw6I/OaSoFhJmVu+WMKELvcyFsuDU3admIsVTYlQUO0ELkX9kd
 7VCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747073116; x=1747677916;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hckfD0sziqBh1sSWGP9c0OUCVTgvBeVKgVHtB7xMeJ4=;
 b=lS9KzD0RkoMH0t5yhLpsz/svww04xw49PiSMUwhLA4bWAQ2+xipHzIrd/V2CcoV2gE
 seAy7it/gfafDTpOjepq66QY+udCNwpspqAaUrQNA8YOz/Z3fl0o7vFToE9We2Dnbs50
 dzmP51uX9krxenmr++BvHIdA7bBpPTywdSo5g2mqjBxy0rso4S+Z293NfsYlakoMMXwR
 rRycliq84megTRqi5sFxqGjG23YoGbaHI/9GPL/KIKxcV+cxfaN8ir1DwrF/aDiwDPap
 +kuv/WHfrjh7u+CgQS3TQ0wVd81g0m/FN72i4dnGrGe5iwLWof9IGwb6yBnxfgqzGJgF
 AVtQ==
X-Gm-Message-State: AOJu0YyhNHLLOyGAt06kL+LHpgiLOG3g99H+k+oGN9vAeyZAf4orC0B3
 oRnKtyQeZg0Hdf7M0PtiQG2CKC25h2HvQjjyUb9PSf1sKhnILoxdgvus1MSSOlJr/DXUv5JCpR6
 Z
X-Gm-Gg: ASbGncvPO/X6pra9RV2D58qNJGEBYpUEcQJgfQdVn4Y/IVIwwe6gMhTm4+ibjLc0iWP
 lIhpt6WYVh4Opkptmx+Fz71Bxu47zc8bNUiE8HDH9BmsCiL4Uh5iiMGxwPrYWxva+aSBrdMRWYs
 Zn4siUfAczTRSY41mh7ZN6404OSE2GRZBhp8iU565qNgrX8bOuXu9dGlyXwpg4KEAifqi6OLVD6
 WjNEm/+hXyTByv/XESCH44upACRobR2vCmH5o0CXVOJ6m7G3U0chodd/Xy69KfLlzW34Iau95z+
 sNlhpmDHlVnPy1C+/OpZaTct57WrdRoBpfQO8YhH9VX/oDEMEIw=
X-Google-Smtp-Source: AGHT+IHV34nofPlHI7j/tovgmgz66yejcHSaMZaqrSu57vJ9NQ3EVTbiO5LssTGmikR7Zmo7cr5jug==
X-Received: by 2002:a17:903:187:b0:224:194c:694c with SMTP id
 d9443c01a7336-22fc8b592c5mr225744135ad.28.1747073116233; 
 Mon, 12 May 2025 11:05:16 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22fc82a2e4fsm65792005ad.232.2025.05.12.11.05.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 May 2025 11:05:15 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 kvm@vger.kernel.org, alex.bennee@linaro.org, anjo@rev.ng,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v8 05/48] target/arm/kvm-stub: add kvm_arm_reset_vcpu stub
Date: Mon, 12 May 2025 11:04:19 -0700
Message-ID: <20250512180502.2395029-6-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250512180502.2395029-1-pierrick.bouvier@linaro.org>
References: <20250512180502.2395029-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62c.google.com
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


