Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0E71CA0FF0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 01:07:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ur4d7-0005id-7L; Tue, 26 Aug 2025 21:07:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ur4ca-0004hX-IF
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 21:06:41 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ur4cS-0007OH-Q4
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 21:06:40 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-76e2e6038cfso7071151b3a.0
 for <qemu-devel@nongnu.org>; Tue, 26 Aug 2025 18:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756256788; x=1756861588; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NnJObcpOjvRlTqxumgfn7EMYSWCiYK0hRCRitKjVJyY=;
 b=uZuUrSkJEFzND5GzSBkfWcImi3XEd7zQsQtyD9CWV+aD3zQr4ophw1DS69O0HM3T6z
 3YYoqNTjS0uo5ihry4iUFbpDo3WA4iTmY0Aj6CvS7MQ+nrYyHo8jwOxm2Jj5mlxLFV9E
 9Z5CNQkG+3HKI1G6nqc01y7bpLaAGx8lk4I9gEwRMtpgJJZodWgjtBC8prbgUUDGT7Un
 rlxhi90ioabMmg4qn+RtR6rbbIcC1Eji0A9AnsEVmGrPqsgEMROPZgNEpi03fYo3Vf2l
 LbMx2AhtS4CAX8ZIXrIziOaGx1GAPJr+fCi0Q14fj7Pfiv9uL5mP+v2GhFv3d0qXPaHh
 aAHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756256788; x=1756861588;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NnJObcpOjvRlTqxumgfn7EMYSWCiYK0hRCRitKjVJyY=;
 b=t6CsvhToVzJP5yfsGSNDpdEEx4ZdQbLmljV7ZD1KqzhRTc+n1d3FUP5+N73ZGy+YEK
 aiTopZpp2PdUtXUc7bdkx9gYrvzNTcMitftaF2rzpl4Gv3aNMrg+fh3D5SfrZiifH3dr
 Mt31tcAmaczNuY1nw1IbieFWVvyOnjlvm5Kw9nQ+BYDDoMkwvSxh3RoCEgRPjlj1F91b
 s5Md0VcB+WRexwBZkevyCSZkqt++KRpr0rJhMYbjeHhL77VwS7Fw5rPze78IdSz+ThmI
 6wH9WwhzioyprVkO4xzi1snpgRX/v1IFrWNrvmU2FdXtA81G4ldNGVCL+EMGDoqur5UF
 Snnw==
X-Gm-Message-State: AOJu0YwpSnUGuoUYdQqM/D4FgA+Su9+YGM6QBUN9cD6pUL7ly5ggUBrP
 +qXFkQjuFsCOPGrSaWL4KVLyic5vjkfn41IKy+AHJcPb5H0kAeIyL+6gEVgo7Pi0xE7WqvU/FwC
 wBLzoyXQ=
X-Gm-Gg: ASbGncv9wXOvFCJkMg92slXGa5u31QfOs2X3mAUDqK/BkzPNntHYsRz3kcoBe7bFIsx
 3gV4gFFumFhYrb102pNWO+4Fkm5F9BKmtFcwpu+r9Az0ZJ7UNjJRhmSipEsZVt5eFfujBAcO1Ml
 4jNbC778hyQn4pvxHGUCG+XxLp/aiuz+IZqkZjsOnUA+xeYBpVAbm+wAAxfwBXoyTkjPJUMABoy
 cowDfe3UNAI/OCBiEGaPcL8VmEozKhZjzgRM0w9qk42+fHP5SC/ryFFBlsZHIM2bop6GyF/svGh
 KZ9A/EcTX1nJhtoaaL0THJ8qOJlY9njQxBbFyS7W9i58T4cmSXd/1FPLNyYC9vSKKXIKXK45fXD
 zntVZt8C67MDjqqjm3LQYkQi0gg==
X-Google-Smtp-Source: AGHT+IFYzCUdcUUmuqbdRdNoAzSLptHmSY+K4WeK1W07Tkwgob/UVQ22Li8VUbXMHzvp/0z13dNP+Q==
X-Received: by 2002:a05:6a00:2d90:b0:772:3c9:ce3e with SMTP id
 d2e1a72fcca58-77203c9d114mr2472701b3a.7.1756256788526; 
 Tue, 26 Aug 2025 18:06:28 -0700 (PDT)
Received: from stoup.. ([144.6.121.55]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7720274534esm1419241b3a.47.2025.08.26.18.06.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Aug 2025 18:06:28 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 16/61] target/arm: Rename CP_REG_AA32_NS_{SHIFT,MASK}
Date: Wed, 27 Aug 2025 11:04:07 +1000
Message-ID: <20250827010453.4059782-21-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250827010453.4059782-1-richard.henderson@linaro.org>
References: <20250827010453.4059782-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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

Rename from CP_REG_NS_* to emphasize this is
specific to AArch32.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpregs.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/arm/cpregs.h b/target/arm/cpregs.h
index 3dc4c9927b..7ebe404163 100644
--- a/target/arm/cpregs.h
+++ b/target/arm/cpregs.h
@@ -175,15 +175,15 @@ enum {
  * add a bit to distinguish between secure and non-secure cpregs in the
  * hashtable.
  */
-#define CP_REG_NS_SHIFT 29
-#define CP_REG_NS_MASK (1 << CP_REG_NS_SHIFT)
+#define CP_REG_AA32_NS_SHIFT     29
+#define CP_REG_AA32_NS_MASK      (1 << CP_REG_AA32_NS_SHIFT)
 
 /* Distinguish 32-bit and 64-bit views of AArch32 system registers. */
 #define CP_REG_AA32_64BIT_SHIFT  15
 #define CP_REG_AA32_64BIT_MASK   (1 << CP_REG_AA32_64BIT_SHIFT)
 
 #define ENCODE_CP_REG(cp, is64, ns, crn, crm, opc1, opc2)   \
-    (((ns) << CP_REG_NS_SHIFT) |                            \
+    (((ns) << CP_REG_AA32_NS_SHIFT) |                       \
      ((is64) << CP_REG_AA32_64BIT_SHIFT) |                  \
      ((cp) << 16) | ((crn) << 11) | ((crm) << 7) | ((opc1) << 3) | (opc2))
 
@@ -214,7 +214,7 @@ static inline uint32_t kvm_to_cpreg_id(uint64_t kvmid)
          * KVM is always non-secure so add the NS flag on AArch32 register
          * entries.
          */
-         cpregid |= 1 << CP_REG_NS_SHIFT;
+         cpregid |= CP_REG_AA32_NS_MASK;
     }
     return cpregid;
 }
-- 
2.43.0


