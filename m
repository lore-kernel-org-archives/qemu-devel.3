Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BB3CC3ABC3
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 18:18:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEXaE-0001Hv-Fp; Mon, 12 May 2025 14:08:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uEXX5-0002Yu-5K
 for qemu-devel@nongnu.org; Mon, 12 May 2025 14:05:47 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uEXX2-00009y-FR
 for qemu-devel@nongnu.org; Mon, 12 May 2025 14:05:42 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-22fbbf9c01bso38122155ad.3
 for <qemu-devel@nongnu.org>; Mon, 12 May 2025 11:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747073138; x=1747677938; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EMEP48GWxCsRSx7QE2iBFebS5MEkI8l2Uk35GcFvWVQ=;
 b=j1DlH9vIBVCc7JnbKlS+AFOKmyjs2NfFSorW9G2h/1fjkMJTQ9L1/8gAaXj1ya7OKC
 VNbvFvcQKBoBV/X89x5s5L5f7pJS5rDmkd4n/2kQwFVazk6oqFeXZdtjPTN6SNrl/98I
 ENUvtYlvqgLnPtWknqmuE6NLYCIrISbArmOg5zSQK6G1JQmkkTz2oqc2g1nj3jZLgRLX
 9uF7epMhBGmbHITz37wxnBs3oBgDqhA3pgvYDbSWCQejLvA4imZ/Qg7d80JyF4UGR2zL
 7cGK2nIra7Gcpq3icxeDk4I4+omoF7EuBMiYpvgOAtCEpvpTwsdySBNSQEjrAkLwAVEz
 Cy8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747073138; x=1747677938;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EMEP48GWxCsRSx7QE2iBFebS5MEkI8l2Uk35GcFvWVQ=;
 b=TYOdYCxTo5xgiec0pfL4qPCTRiNeGRwgb0+PfffTRLkgcT7Jq9ErfwgXq5FcEZ7rN8
 8c/EU9tzjOEiSOVhB7QiVG27baZoMIpBGUnBrdxAQML6wpFms/Orli6ldrRnLItGzaSp
 P4Kn98D71mNCqRiAdQJlPPeNYBvsXLgwbyzF/HhF39LGeD5Wb/RYd6UqfxXqID1HEJTI
 CDd47hBQSvM03HkJVH5q1+tQDsKfFH1AyRSvEXxnRvGKO1pFTGYdBOhLQncHau2N5IIc
 KWbjndqx5o1eIAJ5ZnNyshXFGJZWiwXvimMVDFaZRfRN1nfIVKueJBoDpJoEAU2uGxWv
 o/hA==
X-Gm-Message-State: AOJu0YyQt2WYjcAvzBCC/OMKX1gzubIgvDwj4OUdCt8nE8bbXV5uEuVq
 +wzEtF8je2wwbX/LdUW8HsV2cNTUyoPXvE5cgiU11fhc34xBdRTdR0aKpyd7oYr+qBjBg5dr9eW
 K
X-Gm-Gg: ASbGncsq8p+PfPKQBa3BE/o1/umVOwDR+QzUZDmx9UqLjZlbv+XoloJyRnjTOLCiJmL
 2fiEbbaWztFJWMXXjO64tRZglcXMMv3m7jvMEtparwGLnzAGdbagBwy9worAZyBz9gpMITKMscf
 wrVanwxcJJok+ZK1wDOZlPLuQ+CnPvnvQ9Ns2lyEcgyZyJ7kSJEBX9tXm4wn+eZCMoBm5Bno+fL
 O3bl6BesvIcOw17F803vtgtBorbwlWL8QueaWTlODYcDpKYuSupBn/VUj73jPbs1unQCE6HgHIU
 jYGF9Ju37ouXRygcaET4/gKajDDXF5ndcGs/fN3kvlEJW0wIb0yVTBd5xzBtag==
X-Google-Smtp-Source: AGHT+IGpj+ByGGA6P9uf6PMDolvOaWHxRb5ursUcXrTwGZkqDGtHApsXva51S/fwpSIQmOg1POT4HQ==
X-Received: by 2002:a17:902:ea0c:b0:220:fe50:5b44 with SMTP id
 d9443c01a7336-22fc8c8ec4bmr205601205ad.31.1747073138576; 
 Mon, 12 May 2025 11:05:38 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22fc82a2e4fsm65792005ad.232.2025.05.12.11.05.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 May 2025 11:05:38 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 kvm@vger.kernel.org, alex.bennee@linaro.org, anjo@rev.ng,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v8 30/48] target/arm/ptw: replace TARGET_AARCH64 by
 CONFIG_ATOMIC64 from arm_casq_ptw
Date: Mon, 12 May 2025 11:04:44 -0700
Message-ID: <20250512180502.2395029-31-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250512180502.2395029-1-pierrick.bouvier@linaro.org>
References: <20250512180502.2395029-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62f.google.com
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

This function needs 64 bit compare exchange, so we hide implementation
for hosts not supporting it (some 32 bit target, which don't run 64 bit
guests anyway).

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/ptw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 68ec3f5e755..44170d831cc 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -737,7 +737,7 @@ static uint64_t arm_casq_ptw(CPUARMState *env, uint64_t old_val,
                              uint64_t new_val, S1Translate *ptw,
                              ARMMMUFaultInfo *fi)
 {
-#if defined(TARGET_AARCH64) && defined(CONFIG_TCG)
+#if defined(CONFIG_ATOMIC64) && defined(CONFIG_TCG)
     uint64_t cur_val;
     void *host = ptw->out_host;
 
-- 
2.47.2


