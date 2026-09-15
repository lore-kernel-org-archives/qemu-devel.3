Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FA2DC88E75
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 17:09:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6WdG-0005ON-2L; Tue, 15 Sep 2026 13:07:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x6WdB-0005NC-MA
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 13:07:42 -0400
Received: from mail-wr2-x10.google.com ([2a00:1450:4864:30::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x6WdA-0003TH-0K
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 13:07:41 -0400
Received: by mail-wr2-x10.google.com with SMTP id
 ffacd0b85a97d-48583cc7ab1so1619730f8f.2
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 10:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789492058; x=1790096858; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=g7Q0Llf4E9CzpRVLNV5GuH9fzl8t48pDCWd/wP/k0IY=;
 b=Mwrggn89e4UKMch3TfNQ2omKJ98EPnjgl9pQbNhk13ilUnkMj676/AsTUh5DCNwkY7
 M9Lk1/fMSdApCggjsesHk6oIFmtWy/BwO0AI6e6JhFuUFQnzmgpeFSmjkTd3HYWC3hjX
 HSvuQvAezq/nJ6ON26iu6x3mZG4Wh5Sal93AiwC+shtRS7Es9MDOUNOuTeN5mWpIC9WQ
 QRPPnwirHNy200i0wY0Kz7BQDC7aURLGq2dLkpbvDjr5kwaJgH0jDxCtAjvcKnZsqLPj
 JyGRPD999lKnqvS/CrCb30x8Hw01HsINyL4pte7ZF59uHl4FdDBjnnPSWJ4CzI21Xcyx
 r2Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789492058; x=1790096858;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=g7Q0Llf4E9CzpRVLNV5GuH9fzl8t48pDCWd/wP/k0IY=;
 b=LrGMEWttgw/IuJ6gowkvd1WC1Opp1XhJvVJi/Rvg/fiOfFx7asLf9KDK5riAOEPM+m
 GCBay5vhNfU/u5mZT+hN4/TrCKlwmxIZx2S4fV4Z6V6Pff7r1e+GYVVm2IQhchq61b5+
 0yMw7mTIcI3cMNWJ6I8mQAbgJVm+FPfls07Tjx9PJ8XLKFt0gygvbkGF/P546BbRDOs9
 9YGLgq6QT3MamP8WLVrqJz//oAPqCQeNlG5yZp7Ni61O/aOmltuJtA7bxEtiq8WMWqeY
 m1rUNVMroTSQr+NYpvN9IwxpJNHsmE332DhvumnUqlctlnI/Sx9Fot9A+qBt1dGYZxhC
 RwAg==
X-Gm-Message-State: AFuF++mUPsCevVjOU8sUc1SBtqtY9sLVLPmc3NE4Uno7gmY0IAjCJDLG
 CLz7Y8Gt5JgCEw3vlHRp6CweVSeANNrkWW7IvDH9JJOsR/hSqpNrGNGirf7+j3/5gOe6s5h13j9
 42hQpExQ=
X-Gm-Gg: AYBFou0yRfcg2XuauzORoWAGt402FBCy6WtUa0n1q8w4b5/bx6PM+qJx1BFGJzEcsoK
 /kKSo3d5Mut0mRU/fdxZFNlTALDHPeaMBonv5E0y4c7iOoBJOtrhlhjDgKmw0qk9KWmrw5H452K
 F4r3Zixjy5yib0Sy8OLn6LhuYDH+EDxlDfWu345SOAmST3JMKWHS3sVRJurfe+kWArjknle0nv/
 1rgIvA2Ie54H0a5Xj1/6rnAJ5S5aHlWtvRD2u7XhLPI8yth/qJUmDtFflKMYa5Q7e8UrT/cIK66
 xHr8IbhyRyQD48kIwCWEcBO76IJvoMHfSIOGtQsDTl1EdlTBussCVQp5LyAlv/1ejsyqtLk0sxB
 z8Rskg4kH/5X3wdajaP6Ba25iRMQr+QJN5iIe+V4mWaWuMPg69SVWDbBbwBrxQ50Z6dR15lDPVx
 T1tWAF0IOWdY1i/ie3qEiLLneLiR6ffPju6Fifb9ibWOvRlW1ldug+zYtoIOJPet8gHLZq+aGLr
 /OrTxQF7ZkInqZTVgwKjkqBsjHoGc9SdAsFog2GA+aI4V2+47nwoYPjAG1foUXbWLRQbC5rI60u
 +GbmFf8aHK8T8tc=
X-Received: by 2002:a05:6000:4555:b0:487:463:92d3 with SMTP id
 ffacd0b85a97d-48704639407mr5530033f8f.20.1789492058255; 
 Tue, 15 Sep 2026 10:07:38 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4870bf33e01sm431826f8f.23.2026.09.15.10.07.37
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 10:07:37 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 01/20] target/arm/whpx: Don't try to sync ARM_CP_CONST registers
Date: Tue, 15 Sep 2026 18:07:16 +0100
Message-ID: <20260915170735.425445-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260915170735.425445-1-peter.maydell@linaro.org>
References: <20260915170735.425445-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:30::10;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr2-x10.google.com
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

From: Doug Cook <dcook@microsoft.com>

ARM_CP_CONST registers ignore writes, so readback assertion fails.

Not asserting now because all entries in the whpx_sreg_match table are
invalid. Needs to be fixed now so that we can fix the table entries.

Signed-off-by: Doug Cook <dcook@microsoft.com>
Reviewed-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/whpx/whpx-all.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/target/arm/whpx/whpx-all.c b/target/arm/whpx/whpx-all.c
index 00a5de8cdc1..9a5a575b5e9 100644
--- a/target/arm/whpx/whpx-all.c
+++ b/target/arm/whpx/whpx-all.c
@@ -223,6 +223,8 @@ static struct whpx_sreg_match whpx_sreg_match[] = {
     { WHvArm64RegisterMpidrEl1, ENCODE_AA64_CP_REG(0, 0, 3, 0, 5) },
     { WHvArm64RegisterIdPfr0El1, ENCODE_AA64_CP_REG(0, 4, 3, 0, 0) },
 #endif
+#ifdef SYNC_CONST_ID_REGS
+    /* ID registers are ARM_CP_CONST (writes ignored).  */
     { WHvArm64RegisterIdAa64Pfr1El1, ENCODE_AA64_CP_REG(0, 4, 3, 0, 1), true },
     { WHvArm64RegisterIdAa64Dfr0El1, ENCODE_AA64_CP_REG(0, 5, 3, 0, 0), true },
     { WHvArm64RegisterIdAa64Dfr1El1, ENCODE_AA64_CP_REG(0, 5, 3, 0, 1), true },
@@ -235,6 +237,7 @@ static struct whpx_sreg_match whpx_sreg_match[] = {
     { WHvArm64RegisterIdAa64Mmfr1El1, ENCODE_AA64_CP_REG(0, 7, 3, 0, 1), true },
     { WHvArm64RegisterIdAa64Mmfr2El1, ENCODE_AA64_CP_REG(0, 7, 3, 0, 2), true },
     { WHvArm64RegisterIdAa64Mmfr3El1, ENCODE_AA64_CP_REG(0, 7, 3, 0, 3), true },
+#endif
 
     { WHvArm64RegisterMdscrEl1, ENCODE_AA64_CP_REG(0, 2, 2, 0, 2) },
     { WHvArm64RegisterSctlrEl1, ENCODE_AA64_CP_REG(1, 0, 3, 0, 0) },
@@ -790,7 +793,7 @@ int whpx_init_vcpu(CPUState *cpu)
 
         ri = get_arm_cp_reginfo(arm_cpu->cp_regs, key);
         if (ri) {
-            assert(!(ri->type & ARM_CP_NO_RAW));
+            assert(!(ri->type & (ARM_CP_NO_RAW | ARM_CP_CONST)));
             whpx_sreg_match[i].cp_idx = sregs_cnt;
             arm_cpu->cpreg_indexes[sregs_cnt++] = cpreg_to_kvm_id(key);
         } else {
-- 
2.43.0


