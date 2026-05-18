Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 210FACD4F4A
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 17:48:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wP24f-0005Tk-Ja; Mon, 18 May 2026 13:48:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wP24X-0005S1-3G
 for qemu-devel@nongnu.org; Mon, 18 May 2026 13:48:09 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wP24K-0003mR-2v
 for qemu-devel@nongnu.org; Mon, 18 May 2026 13:48:03 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2bd2c147abaso15550345ad.3
 for <qemu-devel@nongnu.org>; Mon, 18 May 2026 10:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779126474; x=1779731274; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3naiOUzSW9k2jlFfjxq9fMkZ6HgTIWq3KlJZR85M7GY=;
 b=gZzTOvRNi5RROhTmsP+ZvKHfCE1CD+8mlws0IgQ4jtJFasg5qqU2PFz+/epeT05dv0
 Y5D+XypN9kRvlwXIEv9WnKGHRQ5pqSmp1Cn7FGGOFvAXA+1mM4ziiIhydAsI7x6OE1qp
 tuFXg6uqtuX4xb+80kfyWBhlfQ2d8V7MYGLJ2GeTY5x/dD4BTESzYzsDbUivBgRVqiue
 Mx04zdxdka4IclMTbnCZ9lUTSuAkDQeaUnbW1PzCmcD00lMRPQbq5JtO3jwTrHVtv1jB
 1XtEDi2nOHj5mV/LRK2hAbsPOBvOgMCJF8pLKzpl0t5CiFY3IFAZPybKZN/fXZ4tajTT
 0gJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779126474; x=1779731274;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3naiOUzSW9k2jlFfjxq9fMkZ6HgTIWq3KlJZR85M7GY=;
 b=r83YBoijpLGLHqIvhl9ZHxuJt8T14FSN2iJbtdQ4HWsgVy08QGikywxEomhYFmKmq6
 rwydCx36YGQrou3Rex7aItWKh0nS1objo0VSlBrXgiSOPHsOs5uRDuw2N/+wbF+nF/h9
 56tPTbSHNfLlRkXAymIFrX1bjYx6lvUwBAqHo0D/ZytDkvLrQTkUZ+4ysYyP3qKK0E3e
 sfnAVhG+cWSGBA21tetVF6EdRRDZ9iqC46VgmUtn4EDRw5YvdTNsevQcxokETnABCt8C
 sNqpT5XaXx8+skZrJBYwa+PxoJFboLtWyDp3xnxuIDljjRCcp3tAhd6JEHHlwGDpcyF6
 KSPA==
X-Gm-Message-State: AOJu0YzhAiQ+rgpfDuif/px5owjjQ5ED5kYxwCIr2er1zQcoBquzqszy
 9R4moviU4i1hFAqP51+JUa0t5Gs/Pl++fNOZYO2/LkNaUqWp2JTSgTU2HI/oh5XXjc8MNQeOWV1
 1yHYGpb0=
X-Gm-Gg: Acq92OHjEHcP7wQZ1en2h2WUbjZKmSHqdkqXhb18pxV5/BjQ4/3wiM8Us/ZaTg1bqfR
 GOMMmBissE87pHJ0MGJJyoO6PylqOAnLVLb2WQTFvpN91QnqjiZ6ccJ6Y6vs5IxoD6OjIB0NWW2
 LGAOkggqT9dTPXH66u8Zt0n58NhbyMejtox55el4CKNxqKCxA2jLolxZcUKdkbg4kzjsMigpi+e
 9C4jSS/BWJSYXHXYOpUQ34NlcnqKQ5+ouQCHRH/erJ7Eq5R3BBj+5vROKgPgWvsV5tLCiRW1jj5
 Uzni38Tl5uApmzmYSfPWkKd6e4C9GmH1TkX0G2KVyPH2ozCfQ/HJaRdVYycLO2gttS3N3VPLx+H
 VC6Z5tozFFGe5G5IY2/fXtqoc8Ozip688m0HHEy9aeoLCtlEFuie3Xy1sOa4/4iG0+pMJvvIwRl
 HZ0bRMIqo8MaDfXuqaVpoQdWBou+xm
X-Received: by 2002:a17:902:ca8d:b0:2b9:ff02:a159 with SMTP id
 d9443c01a7336-2bd7e83177emr122483715ad.18.1779126474400; 
 Mon, 18 May 2026 10:47:54 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2bd5d12e38dsm157334905ad.77.2026.05.18.10.47.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2026 10:47:54 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v2 4/4] target/arm: Enable FEAT_CMPBR for -cpu max
Date: Mon, 18 May 2026 10:47:50 -0700
Message-ID: <20260518174750.660258-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260518174750.660258-1-richard.henderson@linaro.org>
References: <20260518174750.660258-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/aarch64/elfload.c  | 1 +
 target/arm/tcg/cpu64.c        | 2 +-
 docs/system/arm/emulation.rst | 1 +
 3 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/linux-user/aarch64/elfload.c b/linux-user/aarch64/elfload.c
index 3af5a37776..cebcf7cea4 100644
--- a/linux-user/aarch64/elfload.c
+++ b/linux-user/aarch64/elfload.c
@@ -170,6 +170,7 @@ abi_ulong get_elf_hwcap(CPUState *cs)
     GET_FEATURE_ID(aa64_rcpc_8_3, ARM_HWCAP_A64_LRCPC);
     GET_FEATURE_ID(aa64_rcpc_8_4, ARM_HWCAP_A64_ILRCPC);
     GET_FEATURE_ID(aa64_gcs, ARM_HWCAP_A64_GCS);
+    GET_FEATURE_ID(aa64_cmpbr, ARM_HWCAP_A64_CMPBR);
 
     return hwcaps;
 }
diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index 649d854a65..0c00074c4f 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1262,7 +1262,7 @@ void aarch64_max_tcg_initfn(Object *obj)
     t = FIELD_DP64(t, ID_AA64ISAR2, MOPS, 1);     /* FEAT_MOPS */
     t = FIELD_DP64(t, ID_AA64ISAR2, BC, 1);       /* FEAT_HBC */
     t = FIELD_DP64(t, ID_AA64ISAR2, WFXT, 2);     /* FEAT_WFxT */
-    t = FIELD_DP64(t, ID_AA64ISAR2, CSSC, 1);     /* FEAT_CSSC */
+    t = FIELD_DP64(t, ID_AA64ISAR2, CSSC, 2);     /* FEAT_CSSC, FEAT_CMPBR */
     t = FIELD_DP64(t, ID_AA64ISAR2, ATS1A, 1);    /* FEAT_ATS1A */
     SET_IDREG(isar, ID_AA64ISAR2, t);
 
diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index 8cd7fe7b00..300ccec7ea 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -35,6 +35,7 @@ the following architecture extensions:
 - FEAT_CCIDX (Extended cache index)
 - FEAT_CHK (Check Feature Status)
 - FEAT_CMOW (Control for cache maintenance permission)
+- FEAT_CMPBR (Compare and Branch instructions)
 - FEAT_CRC32 (CRC32 instructions)
 - FEAT_Crypto (Cryptographic Extension)
 - FEAT_CSSC (Common Short Sequence Compression instructions)
-- 
2.43.0


