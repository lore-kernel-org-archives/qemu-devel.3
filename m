Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D42D1CFB42B
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Oct 2024 20:08:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxB2w-0006Uo-7C; Sat, 05 Oct 2024 16:06:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sxB2s-0006UP-Pc
 for qemu-devel@nongnu.org; Sat, 05 Oct 2024 16:06:30 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sxB2h-0001od-Jz
 for qemu-devel@nongnu.org; Sat, 05 Oct 2024 16:06:20 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-20bb39d97d1so28024695ad.2
 for <qemu-devel@nongnu.org>; Sat, 05 Oct 2024 13:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728158778; x=1728763578; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9tqb0TUsQOZF/sRJ8YxWqhKeQa3g/EH2JXyCvd2UdW4=;
 b=Flcb35A3+1e0lsaNuT/iRTYxaoXDAOfgB2fFgVojuYRJl0JK/nazrkzhfd5G+0xgGB
 kyP6gMU3L2r/730jQvXooLHHjn3eFGM8KsNIzWTDWwMFi1jhGpbcDsJhUucNlAjSp/lv
 2zKlp3sK7UcvDkfxaqJyUpzWRi7y4aE7kTVjtrq6Qp7d83zAbhR5zeky4oSfb4wz/W1z
 AFwLYueV5krCqBjJQStqqdk/V7rZwhx6mrIFmnAk9u2zM9Y1LLRZiy0v+8gtIk6WoDRU
 aSy975YaoPawmKJiv7FfxICeeaNEg26RMZbfodfnyfHKZGraZW+ozfnglQo2SLAD6d5G
 aMaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728158778; x=1728763578;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9tqb0TUsQOZF/sRJ8YxWqhKeQa3g/EH2JXyCvd2UdW4=;
 b=YTcVdqw3BJUxXxJJji+70Y38Yp/Vk2hdya+lKQeWBE/PtAYhyRlopD+tJAbHZW/rXe
 9notRDWc/+HqRn1EpwowqDkNJW8k/Ik4hXK79XwMqrXL61d+UJDeH8s2fxT1bnosnzpt
 7P8qP1R2VHzopJt/HwMTyPmivelZFCkja/aSj6d5Ri7GMDlBYip6KrMf1BT0Rrl8lO+F
 LkKOb2g81cPlcyCsn1MA/HipJt7EaOd+29emJGrtOSYYfK8YgfTiS1dbaQO38dV5BABW
 cxlrvWoWR9TJkE58Q6Orksjjb/FZNmnJ79nGot3JV8sBXYm5iJ5UfaHog19bjD57z0pB
 YkHA==
X-Gm-Message-State: AOJu0YysFFUhSZXA+WzypQI49QLTdBm4iVsASElGKSWVbX1ah3BDsRPE
 uaP4o45p9+hgxouY26h4VjqRpUrb/rIJ1TW0PBrMNLk5XhM4HWKis4+0qfzfWYtpEgDzA+cY2S0
 H
X-Google-Smtp-Source: AGHT+IF/QbpbF3vd5RhMGi/uYgncSfdSoTpNoytfe03axosXsTK4sk6Oan6NQUL6chZLVm5cLU1oHQ==
X-Received: by 2002:a17:902:f78f:b0:20b:7731:e3df with SMTP id
 d9443c01a7336-20bff1a5c04mr101016475ad.43.1728158778416; 
 Sat, 05 Oct 2024 13:06:18 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20c13931055sm16493405ad.139.2024.10.05.13.06.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Oct 2024 13:06:18 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@kernel.org, peter.maydell@linaro.org, alex.bennee@linaro.org,
 linux-parisc@vger.kernel.org, qemu-arm@nongnu.org
Subject: [PATCH v2 18/21] target/arm: Pass MemOp to get_phys_addr_lpae
Date: Sat,  5 Oct 2024 13:05:57 -0700
Message-ID: <20241005200600.493604-19-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241005200600.493604-1-richard.henderson@linaro.org>
References: <20241005200600.493604-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

Pass the value through from get_phys_addr_nogpc.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/ptw.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index f1fca086a4..238b2c92a9 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -1684,12 +1684,13 @@ static bool nv_nv1_enabled(CPUARMState *env, S1Translate *ptw)
  * @ptw: Current and next stage parameters for the walk.
  * @address: virtual address to get physical address for
  * @access_type: MMU_DATA_LOAD, MMU_DATA_STORE or MMU_INST_FETCH
+ * @memop: memory operation feeding this access, or 0 for none
  * @result: set on translation success,
  * @fi: set to fault info if the translation fails
  */
 static bool get_phys_addr_lpae(CPUARMState *env, S1Translate *ptw,
                                uint64_t address,
-                               MMUAccessType access_type,
+                               MMUAccessType access_type, MemOp memop,
                                GetPhysAddrResult *result, ARMMMUFaultInfo *fi)
 {
     ARMCPU *cpu = env_archcpu(env);
@@ -3534,7 +3535,8 @@ static bool get_phys_addr_nogpc(CPUARMState *env, S1Translate *ptw,
     }
 
     if (regime_using_lpae_format(env, mmu_idx)) {
-        return get_phys_addr_lpae(env, ptw, address, access_type, result, fi);
+        return get_phys_addr_lpae(env, ptw, address, access_type,
+                                  memop, result, fi);
     } else if (arm_feature(env, ARM_FEATURE_V7) ||
                regime_sctlr(env, mmu_idx) & SCTLR_XP) {
         return get_phys_addr_v6(env, ptw, address, access_type, result, fi);
-- 
2.43.0


