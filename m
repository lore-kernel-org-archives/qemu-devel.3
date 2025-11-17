Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ABBECEACEF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Nov 2025 01:42:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vKoF2-0002tu-8s; Sun, 16 Nov 2025 20:41:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brookmangabriel@gmail.com>)
 id 1vKoEf-0002Z5-A3
 for qemu-devel@nongnu.org; Sun, 16 Nov 2025 20:40:55 -0500
Received: from mail-qt1-x830.google.com ([2607:f8b0:4864:20::830])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <brookmangabriel@gmail.com>)
 id 1vKoEd-0005yT-5c
 for qemu-devel@nongnu.org; Sun, 16 Nov 2025 20:40:52 -0500
Received: by mail-qt1-x830.google.com with SMTP id
 d75a77b69052e-4ee1939e70bso8419291cf.3
 for <qemu-devel@nongnu.org>; Sun, 16 Nov 2025 17:40:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1763343647; x=1763948447; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Dnbbf6q1KBWAEN9kQkeNkKZ6PakRiGS6+tTlmd1+/pE=;
 b=QnqAUT4xmBRAkVqJ0TsRdA9HLCsxRnwbkUTipI3w2KO819WGuc/tKlgIQl7UFKcgm1
 LoPXpEjDE10wmIbUj6gpbwFVEdUnXCsOuqHfv8z1vQh0qKZRBnMFPRS4kgqT02S41PRS
 7PamkYfsRhcWLPnxi4G3ak9dIoE6YWw1Cwn6iRMu9RSvxiT3rUgqCOHh5UjceztoCa+o
 4lOh8pSKbP/c5UDecW7sYOUSUORLd7G+7Mc0V/oQVOmqYsaaQoCqEFASFm5IxoTmbkYA
 ZTKeSsijgUQLDv0KIj1zDyeLbXCNScsTTJqy5qQLSvah6ZLsSuFcJv7nyDgjhSyVoN3q
 asNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763343647; x=1763948447;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Dnbbf6q1KBWAEN9kQkeNkKZ6PakRiGS6+tTlmd1+/pE=;
 b=eRhg3Nc8ZYGoTqbKX6mbIW6euItJIOSoZH47g4TJtehPkRELMNqYutfIYOvn/l329v
 FDWQdAmIBxQ0BKSHj+u0NThmSxm24Y3IG//JKc48orWIqRQhPbjmkZNpqqxHkOv9NUzH
 B4wP6uyMA41icwAklE2qlkIeaRyqsHCJQuvHTuvJ+RJk74xSESOcNx6ESLFou9vXcYb8
 UQbYsmEk0EsfQ+1Fk018aft8tTBp/tZfS/NYHtDSzHIHUk2TFGT6woy/OypSpVLx1CJv
 0Wtlqn0q9WU/TB755CuEqgMb/9VOjOSpDF+yXoBYdcuumwFoI1kYdIL+nzkb1rlJCGSQ
 MK6A==
X-Gm-Message-State: AOJu0YyC7beygkS1Sv8RniE3UDyOkQIyuKw/TSwO95ehIDM54CxVJ5gj
 a9B7j7N9V3CnhsgaObCAchwa1P9FRTKovGNmypTXplHruXFXiT+o8y1E
X-Gm-Gg: ASbGncu7LkINQZiukC2lbFgBEuC+6dpiNqNkuRw0Tia7bVf6AUx+JPfUkcMDoOxzL2E
 yDUAo0IEuC5RMNRMrHK/Fll1/9Bsj7gogvuQJYo/5lLmNU6VqvCOtSL4PPPgOTTDP5xFremiJ3e
 Vgn/2CllCHzHWYAtBibwBcBBLVK3loS36ndZgNugJ7gvWbzoHMB1d1Vw6fEp4YVEHDg/RAMHPiW
 fq4HA0Qc6ean3END7xlew3SU2kEOErEGZVqn7dpN2PrWPzyvT+BUiW9UiOuP+YvXMTVaWfgzBpw
 Ei2f088imWljsHqzYNY+ggjYdcJGGvr1Qctox1bATXyonMJ7I3i7/m0moss75b4lRCq7f7Pnkic
 y/0/noBdo3KDdPH9JSVEGMkqAnoBd/PdhC5ClFULs54a0q8SMVlopNBcU2ireI68sXXXGcYZIb+
 WRjd/T0aWR
X-Google-Smtp-Source: AGHT+IGfGfCC6520aEJWYOsOhBFRPDDs/yZTSTasS4u2bpxZrScMeoWGou+IJax+a8HH46HT0V+kdw==
X-Received: by 2002:a05:622a:1343:b0:4ed:43fe:f537 with SMTP id
 d75a77b69052e-4edf215b06amr153393461cf.76.1763343647497; 
 Sun, 16 Nov 2025 17:40:47 -0800 (PST)
Received: from [10.0.0.22] ([185.213.193.149])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4ee1c21ea34sm18246551cf.30.2025.11.16.17.40.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Nov 2025 17:40:46 -0800 (PST)
From: Gabriel Brookman <brookmangabriel@gmail.com>
Date: Sun, 16 Nov 2025 20:40:23 -0500
Subject: [PATCH RFC v2 06/10] target/arm: add canonical and no-address tag
 logic
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251116-feat-mte4-v2-6-9a7122b7fa76@gmail.com>
References: <20251116-feat-mte4-v2-0-9a7122b7fa76@gmail.com>
In-Reply-To: <20251116-feat-mte4-v2-0-9a7122b7fa76@gmail.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, 
 Gustavo Romero <gustavo.romero@linaro.org>, qemu-arm@nongnu.org, 
 Gabriel Brookman <brookmangabriel@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763343639; l=3340;
 i=brookmangabriel@gmail.com; s=20251009; h=from:subject:message-id;
 bh=F2pGZprB8kCYpSFO6b+fLbFMcjK4Pgwg8dscgoUacB0=;
 b=9RGQlL+ym4S7ny7TacHw8tgfdCWLHKD/gKIbmJ2TuIlbqjJfKgDCZdMfdAJT46sZWPENZyfLC
 f6RGirPwaiGA9BrpKUBvfv1BNBwpI+D1mCHuaAiCtVwx9utsCNbNMYY
X-Developer-Key: i=brookmangabriel@gmail.com; a=ed25519;
 pk=m9TtPDal6WzoHNnQiHHKf8dTrv3DUCPUUTujuo8vNrw=
Received-SPF: pass client-ip=2607:f8b0:4864:20::830;
 envelope-from=brookmangabriel@gmail.com; helo=mail-qt1-x830.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

This feature causes tag checks to compare logical address tags against
their canonical form rather than against allocation tags. Described in
the ARM ARM section "Logical Address Tagging".

Signed-off-by: Gabriel Brookman <brookmangabriel@gmail.com>
---
 target/arm/internals.h      | 40 ++++++++++++++++++++++++++++++++++++++++
 target/arm/tcg/mte_helper.c | 12 ++++++++++++
 2 files changed, 52 insertions(+)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 75677945af..5f0bcdaaac 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1633,6 +1633,46 @@ static inline bool tcma_check(uint32_t desc, int bit55, int ptr_tag)
     return tcma && match;
 }
 
+/* Return whether or not the second nibble of a VA matches bit 55.  */
+static inline bool tag_is_canonical(int ptr_tag, int bit55)
+{
+    return ((ptr_tag + bit55) & 0xf) == 0;
+}
+
+/* Return true if mtx bits mean that the access is canonically checked.  */
+static inline bool mtx_check(CPUARMState *env, bool bit55)
+{
+    /*
+     * the MTX bits used in EL0 are those used in whichever EL is used
+     * for the supervisor. The EL that contains the supervisor uses
+     * bits 60 and 61 (MTX0 and MTX1), while the other ELs that aren't
+     * used by the supervisor.
+     */
+    int el = arm_current_el(env);
+    if (el == 0) {
+        if (HCR_E2H & env->cp15.hcr_el2) {
+            return (1l << (60 + bit55)) & env->cp15.tcr_el[2];
+        } else {
+            return (1l << (60 + bit55)) & env->cp15.tcr_el[1];
+        }
+    } else if (el == 1) {
+        if (HCR_E2H & env->cp15.hcr_el2) {
+            g_assert_not_reached();
+        } else {
+            return (1l << (60 + bit55)) & env->cp15.tcr_el[1];
+        }
+    } else if (el == 2) {
+        if (HCR_E2H & env->cp15.hcr_el2) {
+            return (1l << (60 + bit55)) & env->cp15.tcr_el[2];
+        } else {
+            return (1l << 33) & env->cp15.tcr_el[2];
+        }
+    } else if (el == 3) {
+        return (1l << 33) & env->cp15.tcr_el[3];
+    }
+    return false;
+}
+
 /*
  * For TBI, ideally, we would do nothing.  Proper behaviour on fault is
  * for the tag to be present in the FAR_ELx register.  But for user-only
diff --git a/target/arm/tcg/mte_helper.c b/target/arm/tcg/mte_helper.c
index f9fd6fd408..513ee8d6a1 100644
--- a/target/arm/tcg/mte_helper.c
+++ b/target/arm/tcg/mte_helper.c
@@ -799,6 +799,10 @@ static int mte_probe_int(CPUARMState *env, uint32_t desc, uint64_t ptr,
         return 1;
     }
 
+    if (mtx_check(env, bit55)) {
+        return tag_is_canonical(ptr_tag, bit55);
+    }
+
     mmu_idx = FIELD_EX32(desc, MTEDESC, MIDX);
     type = FIELD_EX32(desc, MTEDESC, WRITE) ? MMU_DATA_STORE : MMU_DATA_LOAD;
     sizem1 = FIELD_EX32(desc, MTEDESC, SIZEM1);
@@ -962,6 +966,14 @@ uint64_t HELPER(mte_check_zva)(CPUARMState *env, uint32_t desc, uint64_t ptr)
         goto done;
     }
 
+    if (mtx_check(env, bit55)) {
+        if (tag_is_canonical(ptr_tag, bit55)) {
+            goto done;
+        }
+        mte_check_fail(env, desc, ptr, ra);
+    }
+
+
     /*
      * In arm_cpu_realizefn, we asserted that dcz > LOG2_TAG_GRANULE+1,
      * i.e. 32 bytes, which is an unreasonably small dcz anyway, to make

-- 
2.51.2


