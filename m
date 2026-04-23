Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79B02F9936A
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 10:04:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFquS-0006w5-VM; Thu, 23 Apr 2026 06:03:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wFqtp-0006Tr-H6
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 06:03:10 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wFqtn-0002BK-Uj
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 06:03:09 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4891e5b9c1fso44928405e9.2
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 03:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776938586; x=1777543386; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=m9X7w7Qrpvujv4YbXbCTTzwgBne1wVOAsA3GWSE5GEE=;
 b=ql6+abs6uCbtH2qXuTGhHTTA4GnlFd7R6vMLGnLvTajluJMLYQF3lP+jL99rEWcija
 35Audua4ge7DJar8Ay59PXi6GFVgVD5ZO9MlGvyDaZVU49hWXHo+m0rAvZRtzURHE++d
 ll1jnlt+eSCu/2TPQrZ9gD6Xy2pcSlK71O7Gp+KYtKOhziWoXqhsfzqZ8yVsA1O9GKUU
 lGED1oWnmm+kDlYwGTabyjmmmwLSh7OTz+DSXFBESHgZXyL+VHXWOzMLNrz7PeTyfVsf
 aLuZ1XFu368PVHeBrYbqtPhe9tVTXXg0wm7kPocK6bShBWsue3PoPRZYcdq9yI2CoNc2
 FhOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776938586; x=1777543386;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=m9X7w7Qrpvujv4YbXbCTTzwgBne1wVOAsA3GWSE5GEE=;
 b=Hl7UESfN72baAdWzSSDciFiuN5trHhqIz0EGJWCLTJbXPYqLoBX2nG4RpPYeQcQNDi
 b0OOQKY015nGUJPH9IamhHjjQ+K27sglgeJjlyVcgxEbmXnyInZvLBeFifJk55R38lQ1
 CPsugon/cKUleWws2ipNmSMajgkfXIPskpFpSJR93hTbsRhD4CzzfO0OmYa8yMOBhgW8
 J1f/ldGUjqKPesTNZZLv62geQCWXGwm7LoQXcv+fdC23LCg92gLCWgzd5ibe4BoWHlym
 yKcJ7xiwdPaBobTK2BlCahpjgbCFNLHjmzkQcRvLjwnln4notqb9wf1WzznduESUmtM0
 UYaA==
X-Gm-Message-State: AOJu0YznKu4FhsrSe+gFPbvMkKaEUO70Vlna4aGVNy6uTXwsUhXp6bvr
 KE33cfaLmS5Yz3QCBiAu2ggTiDwPU4OcQDEXvcHQYindwXw5jCz6V2fmJj7fCZFjTMKb7NI1w6f
 qC2bX
X-Gm-Gg: AeBDietzXK4PQpkBkworbOYJ0lz857wOtJ6v0SEXu5At+s1LVySugThATF80kI8f+qJ
 y7lwa5IfxyqBZ4FT/A2YEmrBGdSMkijUCnf4qf+6UCm95LCTX+GG92cA993g6jURfw3cUSZ17/t
 /qve1zY89RZpSE+2KvcEQnq9E4On13Cg/lC+b8rK74fAZhVaLwxQUMp29mslB9IAymjgTaxJyrr
 V0+ElPnSiZaF0gjJsYPYeAY1k3a+jfgMTbWVYhgCIsf3No0FHmloH6ZVPT+NiIKr7vTP1dyTshV
 GG1unVn8YhDe0JDq9L3GyAuxm7Ii35S302bb46ZbOszv28J1uPq96sFHRDC5ZLp9pp0LtZY3pzb
 NQBlmCXrQOs3TpOdjiElrrUPFsZCeqLbTO0VDk42lJBWkgM3iK+nM9teLGh1oZ5S5ElLQKEN4BH
 Cakh6+2tAWvcUvxhOL3q9OWMfzopyi+YKguQ18u1C9kbvQKBhPN1XcEqPbZ34CNDlmDPibTEHSo
 /S3PDcmNaOnhPcACMyrIe/HqP/r+HOMPO3jwf0rYg==
X-Received: by 2002:a05:600c:a105:b0:486:fb69:4960 with SMTP id
 5b1f17b1804b1-488fb7786e4mr277016645e9.19.1776938586193; 
 Thu, 23 Apr 2026 03:03:06 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4e4eec9sm49323930f8f.34.2026.04.23.03.03.05
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 03:03:05 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 32/59] target/arm: Remove target_ulong use in
 hvf_handle_psci_call()
Date: Thu, 23 Apr 2026 11:02:02 +0100
Message-ID: <20260423100229.2941820-33-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260423100229.2941820-1-peter.maydell@linaro.org>
References: <20260423100229.2941820-1-peter.maydell@linaro.org>
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Similarly to commit 3580aa03547 ("target/arm/tcg/psci.c: make
compilation unit common") which replaced the target_ulong use in
arm_handle_psci_call(), replace the one in hvf_handle_psci_call.

This could be vaddr, because entry is the start pc for the on-lining
cpu, but we prefer uint64_t because this is what we get in param[]
and pass to arm_set_cpu_on().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260410194227.16357-1-philmd@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/hvf/hvf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 5fc8f6bbbd..678afe5c8e 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1418,7 +1418,7 @@ static bool hvf_handle_psci_call(CPUState *cpu, int *excp_ret)
     bool target_aarch64 = true;
     CPUState *target_cpu_state;
     ARMCPU *target_cpu;
-    target_ulong entry;
+    uint64_t entry;
     int target_el = 1;
     int32_t ret = 0;
 
-- 
2.43.0


