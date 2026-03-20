Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F48D1098784
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2026 13:17:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3Zi8-000686-6P; Fri, 20 Mar 2026 09:16:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1w3Zhs-0005v1-IH
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 09:16:05 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1w3Zhp-0000Lb-A7
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 09:16:03 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-b979d16dd0cso259899566b.1
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2026 06:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774012558; x=1774617358; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ox09lJlrIlX36nSOA8lgaot7ry6qFt0dJt6CN6nPMoA=;
 b=sU4T0j5rQj+oBfkRNHDvtITvBCKkewC10WuPK0PZ8UwtHmGiUtLpKYCpP575Xp4JES
 V6rJ6SCxtFxvJ9rP0moxYYatgkAcKdTrzr+4dG6yKqG6oxHUOscSgg7cImQNXmN0NbYR
 R9fgtwd/nrtK3aTCytvMtCKHVFQyAr/xohL6LJ+D9xEe8MMxDuh/s+DxW+miycjKncc3
 jjnB3Goa7iTT4+lxEnxPkLGLmeAh7ZesoYZHksrmttfrsqQgeBKq0urZbmFJDYCAd+7F
 rtROuEYxgNycP+l3JioXUlB/lx/PfEIrIeStdoirwruh+7+fXq2MDZV/5Uj5Bdj1myVk
 QPEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774012558; x=1774617358;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ox09lJlrIlX36nSOA8lgaot7ry6qFt0dJt6CN6nPMoA=;
 b=QZPoimxV2FVDqEQHpn5ssl8vq7QnBZmzBTWsFSbb3MGo3EW94/rvBku1jaBsYbC+pD
 o6r9f3ua9L5QmWYHMJRul5PfAeqos5THlM7Gd2SBI95uP9IGXBQ9iXbKSRVkvmSSaoui
 WJaBM39Ut0Z54s7E0wiZHk+Am1v/oTydCsaw9DsL3YX9TtEcbtLhHZlBCa0u/1iBKBqI
 Srcap1KQH1VoFqFbxqFGzkPIU3hiCXvRDXE7rDo35dz4KmDeH4P12JiTbkh/apYvKlLU
 nwQml6/CBsEjfoSMMRdfthQB2zFTxXu4EpCnMVGntb9LGkwHFkXIzv81sIPqgbgv+aTk
 94tw==
X-Gm-Message-State: AOJu0Yx32s/zxHwOag1U4f38a3MjL0tBP6uIQKWE0jCzGc0x3u3fMB5h
 txPziToPQXe/prw+sX3g4iR6qaJC2O+pgnFfLoAMTGl7xyt0Obn1NFO7s4m3RdsjIsqoxRATNx5
 Suw8mnv4=
X-Gm-Gg: ATEYQzwYIjfD0245p2AMFLq82Jup8DF0G3ENAx9U6rxyFOviOJFeAS9bmF2vzGLdGTl
 V62PY7B7rgotVeMgDIM1zPE868WivelHzSvILilDNWTutzLH/0EtJ21Syin9EURDcClYXcFU6Ml
 F4tctBdUIByMy+1/1+z+UZG+eJX53LLd021J0lGC1IzjJBv5WnqdlhD1pw0pfmt6Ligt3qSCDCj
 ettIXLVQzLT4+5hcZUxOjLQBCpVVOiN7V/LBRMcE9vIzU+cUzfct/4RimdXtRGyTfWFZozPZmMu
 yerTgAUPbYltlCyCPK+1zseSDMxmA9aSg6o8Yz7eSu9hIFvP5Qysdruui7UfMpeW+/9DyipCcZG
 D5cXYm4PCPa0LgElhbYwFo5jsenWWmo+TokB/xBkJZ/+7QEGK63I4IFC9PCaiGbpJevUS6bApDZ
 HKutRXHBYGKokjXDKdtou7eTQ=
X-Received: by 2002:a17:906:8406:b0:b93:99a8:c366 with SMTP id
 a640c23a62f3a-b982f3df9d1mr182055366b.55.1774012558228; 
 Fri, 20 Mar 2026 06:15:58 -0700 (PDT)
Received: from draig.lan ([185.124.0.237]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b9832f8db2fsm163039866b.23.2026.03.20.06.15.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Mar 2026 06:15:55 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 20F0E5F9E2;
 Fri, 20 Mar 2026 13:06:09 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org, Pedro Barbuda <pbarbuda@microsoft.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [RFC PATCH 18/35] target/arm: make whpx use syndrome helpers for
 decode
Date: Fri, 20 Mar 2026 13:05:49 +0000
Message-ID: <20260320130607.2071996-19-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260320130607.2071996-1-alex.bennee@linaro.org>
References: <20260320130607.2071996-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62c.google.com
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

Rather than open coding a bunch of shifts and masks we can use the
syndrome definitions. While we are at it assert it really is a
EC_DATAABORT.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/arm/whpx/whpx-all.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/target/arm/whpx/whpx-all.c b/target/arm/whpx/whpx-all.c
index 513551bec1b..f5646e7127e 100644
--- a/target/arm/whpx/whpx-all.c
+++ b/target/arm/whpx/whpx-all.c
@@ -356,15 +356,16 @@ static int whpx_handle_mmio(CPUState *cpu, WHV_MEMORY_ACCESS_CONTEXT *ctx)
 {
     uint64_t syndrome = ctx->Syndrome;
 
-    bool isv = syndrome & ARM_EL_ISV;
-    bool iswrite = (syndrome >> 6) & 1;
-    bool sse = (syndrome >> 21) & 1;
-    uint32_t sas = (syndrome >> 22) & 3;
+    bool isv = FIELD_EX32(syndrome, DABORT_ISS, ISV);
+    bool iswrite = FIELD_EX32(syndrome, DABORT_ISS, WNR);
+    bool sse = FIELD_EX32(syndrome, DABORT_ISS, SSE);
+    uint32_t sas = FIELD_EX32(syndrome, DABORT_ISS, SAS);
     uint32_t len = 1 << sas;
-    uint32_t srt = (syndrome >> 16) & 0x1f;
-    uint32_t cm = (syndrome >> 8) & 0x1;
+    uint32_t srt = FIELD_EX32(syndrome, DABORT_ISS, SRT);
+    uint32_t cm = FIELD_EX32(syndrome, DABORT_ISS, CM);
     uint64_t val = 0;
 
+    assert(syn_get_ec(syndrome) == EC_DATAABORT);
     assert(!cm);
     assert(isv);
 
-- 
2.47.3


