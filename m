Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A56C3CD4F25
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 10:52:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNq7U-0000m5-Jt; Fri, 15 May 2026 06:50:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wNq7S-0000kr-Ea
 for qemu-devel@nongnu.org; Fri, 15 May 2026 06:50:14 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wNq7Q-0001lB-OG
 for qemu-devel@nongnu.org; Fri, 15 May 2026 06:50:14 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-449d6c68ed8so7921144f8f.0
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 03:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778842211; x=1779447011; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=21OMcW/USRlqcHb+Vjlhk7EQqx1mPVSErf/Qajcja/I=;
 b=Ih79XqcaWLDBs91HOkkfCHGCEYShlefSfbB2rMpkNZ71/gvoGm8vrKmuvyALJQV07D
 5oYAto6V46Mr3wj9Xr8B2zQpurJIuuAkXEKund6OukK1AlsmJlWYy226/4TTgUNfSshD
 DRrAyCeWoPuh1EqSPpOSHEHcxxSFQOjyyO5zM9WV314X5XY32mMkcS8ripx/XZihe77+
 hV5RaSPQBrRO4agC6eh8Ko3Y1TCwiO8eVd6vHSl3PnY/aJid4/Jh6fVTw8C59nzAImyj
 wo+rIZner//AcL1BJexw6KgugZn/MC83CCX54yx9qX3pZoZKMlJ7TtX80gI6iZK4qsuG
 J4LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778842211; x=1779447011;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=21OMcW/USRlqcHb+Vjlhk7EQqx1mPVSErf/Qajcja/I=;
 b=p3Zf8n63rE2TnXnrsb1l78JJ9HK7Km3b+XuRojJrQKulGBndjNP/pYOe00K4DlWLdK
 EBNimLGAON/viIBdjpvvT0nueo9+W2RGgfKEtfxSoPVQZbd4q6GSDLe4qn/TyBMgbSa+
 RMifDati/CdNF8eAaoiJlzlp4pE0U26Dl/R7EeLlaOwqC8F405hZl/GoTxUsU2HhRSua
 LyrBsjNG/WPWLKqeGIP3E24EX49udi/MSFPJvnqFrXWq7IG/GCOBKTRXCH8k20VDz+9E
 l+6ApSMPAyWcdQ9S2Bd0d+0dSYjHbejZVs8LxVxa9d/tYPypew5u8kXwCk+wD/oj7XCh
 OTNw==
X-Gm-Message-State: AOJu0Yyj4RcJZD/xIfXJYEvcPFkARWiP1UZBjOC784kCWIdnFTmoTXZA
 DoI3ciKsiybZmhpkOuZNX/JNJeEQdW0gPPEZDPZTXKPqSZZAOJCgFMZZDqYc9MIfU5dMtDXZwER
 rCVF4
X-Gm-Gg: Acq92OGB96TZTuJiGesp/ALL3PXBUxfGYhqLPjiko+GMfd1on55l95SlCwqvmv28d09
 1Jola1Bt9N34UE90lfVs8MTxsZcOX0vu/jVjtY0p6DLH4HO5BcRvlnZyPhfq+lpdlgNbjl+94q7
 PN15QL0vdC+A4dGJ0BzPmqDMaO4KwZQHxGf7cnQc11gfkP0PUHFgiHsgLm0zUDYOV60EtUSmePW
 SHTULF/INtk3aDBR0ZqzGxl8il18Eq7RWxwGBEFBBQ7Y140bkXE0k3PIxWSLFER8BtxoWKu44AS
 qP4si73aDIq7UAJDVmNaYG+HrcfVJsaHdoDd3wj/pRMb4Pgwqv52om16zsT//zWVKj8xp2fxvF/
 AYC7V5cCyA4UmcfcNY8028Z8Evxxj2yHUkwN6nS9FHZi6R7xAVCgCRjd28xZPDfhf7fPrtT3Nzg
 FvV4rUGFhgNTY0A9bmezJ3e6dZrHOYRxLGEgtQiCtGSlGIx5LZ1lgnm4iNt82WC0m0c7SVVcRSh
 4ZKMP67+FPm8co5Pffe/7o2XhNLFikvshBR8jtUlw==
X-Received: by 2002:a05:600c:4504:b0:48f:d1b8:9a9c with SMTP id
 5b1f17b1804b1-48fe60e14bamr43793315e9.7.1778842211086; 
 Fri, 15 May 2026 03:50:11 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48feaa2949asm18194355e9.1.2026.05.15.03.50.10
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 03:50:10 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 21/23] tests/functional/test_tuxrun: Restrict to TCG
Date: Fri, 15 May 2026 11:49:43 +0100
Message-ID: <20260515104945.4145203-22-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260515104945.4145203-1-peter.maydell@linaro.org>
References: <20260515104945.4145203-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x431.google.com
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

The tuxrun tests specify the cortex-a57 CPU; this doesn't work on a
KVM-only QEMU build, where the default accelerator is KVM but KVM
doesn't support that CPU type.  Restrict the test to TCG, to avoid
failures on KVM-only AArch64 builds:
        Output: qemu-system-aarch64: kvm_init_vcpu: kvm_arch_init_vcpu failed (0): Invalid argument

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260507194728.2034696-7-peter.maydell@linaro.org
---
 tests/functional/aarch64/test_tuxrun.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/functional/aarch64/test_tuxrun.py b/tests/functional/aarch64/test_tuxrun.py
index 75adc8acb8..7dd50c3de1 100755
--- a/tests/functional/aarch64/test_tuxrun.py
+++ b/tests/functional/aarch64/test_tuxrun.py
@@ -25,6 +25,7 @@ class TuxRunAarch64Test(TuxRunBaselineTest):
 
     def test_arm64(self):
         self.set_machine('virt')
+        self.require_accelerator('tcg')
         self.cpu='cortex-a57'
         self.console='ttyAMA0'
         self.wait_for_shutdown=False
@@ -40,6 +41,7 @@ def test_arm64(self):
 
     def test_arm64be(self):
         self.set_machine('virt')
+        self.require_accelerator('tcg')
         self.cpu='cortex-a57'
         self.console='ttyAMA0'
         self.wait_for_shutdown=False
-- 
2.43.0


