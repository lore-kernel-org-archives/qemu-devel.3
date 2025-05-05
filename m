Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B976C3ABAC
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 01:56:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBl18-0004Jx-Ml; Sun, 04 May 2025 21:53:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBl0l-0003wA-8g
 for qemu-devel@nongnu.org; Sun, 04 May 2025 21:52:55 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBl0d-0002Wt-MU
 for qemu-devel@nongnu.org; Sun, 04 May 2025 21:52:50 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-73712952e1cso3714271b3a.1
 for <qemu-devel@nongnu.org>; Sun, 04 May 2025 18:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746409962; x=1747014762; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+dY2+B45FTbIh7DFuLp2IDYyX3GgPA0isTzUNUEtsE4=;
 b=HcbC9sPV5Em+Q4914jN1gdCuxpaaCR1HBeka8IxwBpc/lqo64b7FkJAYYOOPO6/9HW
 LiHY54/QuuAwh4fhCsRdwSzCWe4i2ModT7F9Rq8fb3PynH45rTntEPpT9kpqzEwgoTqW
 LinY3VXZLFUV76hqFpDyrKqqwAEyooPQE2XiaW3qz3qYX2TsyHr7tkN1Lk5E16ad2640
 aL1jRWdCS0YhqmWUiDuNcF/vVoXkN/nRtnZqEBcdLU8GPPNOAtC7brv2SXNB2KQd1pxl
 K2r44pYj4OjGJJiuy4a+RzfmWUvLHkyZq9216L/L5pEqQdXfMxHp3/yF2rC21kRITVmu
 STUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746409962; x=1747014762;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+dY2+B45FTbIh7DFuLp2IDYyX3GgPA0isTzUNUEtsE4=;
 b=UuthWi8ofsT384YKQNGAag6l1dDe6rIVi+r1AC989QKBr3Loi9xpl0JpRdw7QPeUYg
 cJnWUPRx94PNTFS1l+pVRPMva8pugkVmb4c85nUGvSGLuw53FHK0CN0BU3tk7Vsqvhd2
 wqO94ittgFhi0fQZMPdiSeGD6RiMaEnLFYcJGLX6gbSNInT9e24iuuTMeFME2C/R0eik
 o6EojRE0fxdK+9JovLXBGPlVDB/i+yrOgUOZHODZ/QzmNnpX5A3eTcxUZ0UKVmCgKQK6
 dW8cwVRVtcR44LG+tTJn4W0oOb3Phft06F1dZ5MxrgB+5k3Am6Ghd/QeLPUFnon8fJD8
 +eSA==
X-Gm-Message-State: AOJu0YyaIlORBN+4mle+iG29forAy3tUviXSXuE6CB8zwnwn+2RD+s4r
 vzR+joRs9YV1MgyU8SgVtBZxd33GFygekFex40RYA3+XT9IxVFKtxQbrz4ecWnR+iZApOFuxsnS
 dxvI=
X-Gm-Gg: ASbGncvoAI2hFFPA2iK/qmjHE+KdV5EVKbghtNKgUR5LGf9kHVAz1llnJu23WvYoMwH
 x54VZbxdv5ifngUx+M0rW01FgG/f5tzupUxtvcayP+cKM+/Il5ZkqOW8UQMXaBPrlGkfBtExX90
 PQSfnhEm1oisvoRGWLRg6uGjxwq3syQNCtVrC7vY/IzVcttJk5y2y08+trS4VsBWVS3nTPJT4ld
 rjh/9GN1DWe+zP2zRa2vULM1uUF5jZInUb51r2xyP4qTHqImiipLlV9cA5oXbfPjkjxb4dowj+f
 sEg8Qwmgb4PVbOnOWVEm4vfpXaDmQtG7wPGohZ46
X-Google-Smtp-Source: AGHT+IGwGPzb6lFi2Op/Qg5QVCFLUtbbcfO9DQX2e8IUchkEKTdytp85tL6CL/OsVBWd1f+gFvvx/Q==
X-Received: by 2002:a05:6a20:3d81:b0:1f5:9208:3ac7 with SMTP id
 adf61e73a8af0-20e97ea6076mr7778420637.41.1746409962540; 
 Sun, 04 May 2025 18:52:42 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b1fb3920074sm4462101a12.11.2025.05.04.18.52.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 May 2025 18:52:42 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 richard.henderson@linaro.org, alex.bennee@linaro.org, kvm@vger.kernel.org,
 Peter Maydell <peter.maydell@linaro.org>, anjo@rev.ng,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v5 16/48] target/arm/helper: use vaddr instead of target_ulong
 for probe_access
Date: Sun,  4 May 2025 18:51:51 -0700
Message-ID: <20250505015223.3895275-17-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250505015223.3895275-1-pierrick.bouvier@linaro.org>
References: <20250505015223.3895275-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42b.google.com
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/helper.h        | 2 +-
 target/arm/tcg/op_helper.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index 95b9211c6f4..0a4fc90fa8b 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -104,7 +104,7 @@ DEF_HELPER_FLAGS_1(rebuild_hflags_a32_newel, TCG_CALL_NO_RWG, void, env)
 DEF_HELPER_FLAGS_2(rebuild_hflags_a32, TCG_CALL_NO_RWG, void, env, int)
 DEF_HELPER_FLAGS_2(rebuild_hflags_a64, TCG_CALL_NO_RWG, void, env, int)
 
-DEF_HELPER_FLAGS_5(probe_access, TCG_CALL_NO_WG, void, env, tl, i32, i32, i32)
+DEF_HELPER_FLAGS_5(probe_access, TCG_CALL_NO_WG, void, env, vaddr, i32, i32, i32)
 
 DEF_HELPER_1(vfp_get_fpscr, i32, env)
 DEF_HELPER_2(vfp_set_fpscr, void, env, i32)
diff --git a/target/arm/tcg/op_helper.c b/target/arm/tcg/op_helper.c
index 38d49cbb9d8..33bc595c992 100644
--- a/target/arm/tcg/op_helper.c
+++ b/target/arm/tcg/op_helper.c
@@ -1222,7 +1222,7 @@ uint32_t HELPER(ror_cc)(CPUARMState *env, uint32_t x, uint32_t i)
     }
 }
 
-void HELPER(probe_access)(CPUARMState *env, target_ulong ptr,
+void HELPER(probe_access)(CPUARMState *env, vaddr ptr,
                           uint32_t access_type, uint32_t mmu_idx,
                           uint32_t size)
 {
-- 
2.47.2


