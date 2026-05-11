Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEA67CD37BE
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 14:04:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMRDO-0004ML-Cv; Mon, 11 May 2026 10:02:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brookmangabriel@gmail.com>)
 id 1wMRCA-0003xB-V5
 for qemu-devel@nongnu.org; Mon, 11 May 2026 10:01:35 -0400
Received: from mail-ot1-x32a.google.com ([2607:f8b0:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <brookmangabriel@gmail.com>)
 id 1wMRC5-00061i-Ta
 for qemu-devel@nongnu.org; Mon, 11 May 2026 10:01:16 -0400
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-7d55b97f358so3102541a34.3
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 07:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778508067; x=1779112867; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=vi5YnuogD6cXPtMTTKIaqxfua66dFwZmc5GgDLqxixU=;
 b=q2mr9Xwbqipzy6mz1hEtKix4gkZqsyDdoswjzPcm7gBG3D4UKER8gMcmOvN4MG+HPB
 t8R/LIpqyyhMgvTC/DooVuvX8B5r+JuWyLyKvKqbIRIUlBIISfj2pgp49eA9T83hXBH2
 8ADx69LlcxDWXizR0iIhkQnJ4YktZ/k9zNqcZuZOwEf3LK5WADO/kUzgVp1sllh1rCKm
 fRGfsUePLhKrbqxTjU2TXv0sPHfiMNYTjsHlt2zT5EXzrmVbNi5VTSszVmPShGbLtuYu
 YMtiZhGeYcO6l1edUhVntt7BMuMgbBSf/xsnsfR7ATrETsA25o6jhcLcuefnjMKno9uk
 AkJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778508067; x=1779112867;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=vi5YnuogD6cXPtMTTKIaqxfua66dFwZmc5GgDLqxixU=;
 b=AHnXL/JzSuJLbaNXrHxXtjznDe0K6BTvQsinNj3lJMHypy5P0iEtfrJgja/GTaOzHy
 gZr89zBgcycURviEvM2OHDXQsm8DLDcDu/m1rPR5/OCeuck0pgvjTtiEFrM3Cq4OCmP2
 nCg39vhuk/pVNmtMqwwWagxUDLPM05nfu3w6Jh5vf9CLqpkWuAxQ+nGQMoGTHSWf17fw
 3k6+cpMD6xl+R8LPEZH6IEoqpgQq9U4qdtQhtTTn/PP9yezFtVzaSAnLVYw9e0yRfXCH
 8PAj4txAT90Tal6y1CGMAlDL43zjwj7mQsgxXad2UgGWFoUXtW1fZO3Gz3tutFwHX3mD
 VBPQ==
X-Gm-Message-State: AOJu0YyWQq9YJ0E4frjhcHz5RvaX9FmP1Q+PAiP2rv4+OmFxrfEnEN8P
 GN6UU05t1Rd8yA97ArkjnZbUG/a+TsQGsNTuA1X0bBV1RmFenEj3NmvE
X-Gm-Gg: Acq92OElIkB8rJIpSXEAkOgfmrqhinkg3SO1ZQXkU/2rW2e6sTkV25f+fs5dXWG+spg
 iuA831CJ0q9tQRaL/EIJoOTCndvisvgtUEoC4lsGbM9DCPqW3AYjx+K93HFjNHvIvMWgyqn8jXB
 SJUvaEL/mFKoWm29SCdWGh+h8O3HSDEUmVEGaxRUZT01ja8CRTXxegT3y1kk34P5UpnTNSUv6O+
 soXhqRgBOxJse9+lKGOsOyV6zdYqzC2tOhD0Ykke2XuRwiJ07RJRk/d0cdL20O0AE3ePvSRrAGp
 BGbFGq3S1s+F3j1bmeXjEIDXgPRJ6oUT5jESNudtLouyY6kflyQiyu82uw2329ALDTGrdm78nvS
 3eeb2YvdpKj8O0h4BSSkJTIzCn9d2ef85eZoXSSjsvVEs9Pd0J6jO9kUO+CVPPOa8uyAgnke3id
 yWGk5iJ7Tw1Apr3MwJ3lDef0o5BIPwICUR7K7K+VbO
X-Received: by 2002:a05:6830:2b29:b0:7dd:72f:7fb6 with SMTP id
 46e09a7af769-7e1df074314mr14993882a34.17.1778508067174; 
 Mon, 11 May 2026 07:01:07 -0700 (PDT)
Received: from [192.168.1.160] ([2600:4041:54f3:a400:c013:3550:ed5f:a59a])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8bf39c7dd09sm94773756d6.31.2026.05.11.07.01.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2026 07:01:05 -0700 (PDT)
From: Gabriel Brookman <brookmangabriel@gmail.com>
Date: Mon, 11 May 2026 10:00:59 -0400
Subject: [PATCH v6 01/15] target/arm: implement MTE_PERM
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260511-feat-mte4-v6-1-8557cc1313b9@gmail.com>
References: <20260511-feat-mte4-v6-0-8557cc1313b9@gmail.com>
In-Reply-To: <20260511-feat-mte4-v6-0-8557cc1313b9@gmail.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, 
 Gustavo Romero <gustavo.romero@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org, 
 Laurent Vivier <laurent@vivier.eu>, 
 Gabriel Brookman <brookmangabriel@gmail.com>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778508062; l=4753;
 i=brookmangabriel@gmail.com; s=20251009; h=from:subject:message-id;
 bh=cUF7iZCkqYqpL8FP/9DkkMtDVlwBF5CQVxj9BrBVSCA=;
 b=LhIKgJ9lPjj6LKZdzZTejw1mr3lS0i3KWVHCMC5jaBavyOxpvMaTav61KA8tOj+qAsMPImjIT
 tkLm8TTfo6TCDBRsjMnRBKIBDUQqzqNXMrDigYuUOI/R4fW20qMSRqo
X-Developer-Key: i=brookmangabriel@gmail.com; a=ed25519;
 pk=m9TtPDal6WzoHNnQiHHKf8dTrv3DUCPUUTujuo8vNrw=
Received-SPF: pass client-ip=2607:f8b0:4864:20::32a;
 envelope-from=brookmangabriel@gmail.com; helo=mail-ot1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Introduces a new stage 2 memory attribute, NoTagAccess, that raises a
stage 2 data abort on a tag check, tag read, or tag write.

Signed-off-by: Gabriel Brookman <brookmangabriel@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu-features.h   |  5 +++++
 target/arm/ptw.c            | 25 ++++++++++++++++++++++---
 target/arm/tcg/mte_helper.c | 38 ++++++++++++++++++++++++++++++++++++--
 3 files changed, 63 insertions(+), 5 deletions(-)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index 88fe3ed287..adfbdb9da5 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -1157,6 +1157,11 @@ static inline bool isar_feature_aa64_mte3(const ARMISARegisters *id)
     return FIELD_EX64_IDREG(id, ID_AA64PFR1, MTE) >= 3;
 }
 
+static inline bool isar_feature_aa64_mteperm(const ARMISARegisters *id)
+{
+    return FIELD_EX64_IDREG(id, ID_AA64PFR2, MTEPERM) >= 1;
+}
+
 static inline bool isar_feature_aa64_sme(const ARMISARegisters *id)
 {
     return FIELD_EX64_IDREG(id, ID_AA64PFR1, SME) != 0;
diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 316e201cfe..467d815e0d 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -3414,7 +3414,7 @@ static ARMCacheAttrs combine_cacheattrs(uint64_t hcr,
                                         ARMCacheAttrs s1, ARMCacheAttrs s2)
 {
     ARMCacheAttrs ret;
-    bool tagged = false;
+    bool tagged, notagaccess = false;
 
     assert(!s1.is_s2_format);
     ret.is_s2_format = false;
@@ -3424,6 +3424,18 @@ static ARMCacheAttrs combine_cacheattrs(uint64_t hcr,
         s1.attrs = 0xff;
     }
 
+    if (hcr & HCR_FWB) {
+        if (s2.attrs >= 0xe) {
+            notagaccess = true;
+            s2.attrs = 0x7;
+        }
+    } else {
+        if (s2.attrs == 0x4) {
+            notagaccess = true;
+            s2.attrs = 0xf;
+        }
+    }
+
     /* Combine shareability attributes (table D4-43) */
     if (s1.shareability == 2 || s2.shareability == 2) {
         /* if either are outer-shareable, the result is outer-shareable */
@@ -3455,9 +3467,16 @@ static ARMCacheAttrs combine_cacheattrs(uint64_t hcr,
         ret.shareability = 2;
     }
 
-    /* TODO: CombineS1S2Desc does not consider transient, only WB, RWA. */
+    /*
+     * The attr encoding 0xe0 corresponds to Tagged NoTagAccess and is only
+     * valid with FEAT_MTE_PERM (otherwise RESERVED, constrained
+     * unpredictable)). The presence of this feature is checked in
+     * allocation_tag_mem_probe, where Tagged NoTagAccess has its effect. See
+     * J1.3.5.2 EncodePARAttrs.
+     * TODO: CombineS1S2Desc does not consider transient, only WB, RWA.
+     */
     if (tagged && ret.attrs == 0xff) {
-        ret.attrs = 0xf0;
+        ret.attrs = notagaccess ? 0xe0 : 0xf0;
     }
 
     return ret;
diff --git a/target/arm/tcg/mte_helper.c b/target/arm/tcg/mte_helper.c
index a9fb979f63..bf35dc10ce 100644
--- a/target/arm/tcg/mte_helper.c
+++ b/target/arm/tcg/mte_helper.c
@@ -58,6 +58,27 @@ static int choose_nonexcluded_tag(int tag, int offset, uint16_t exclude)
     return tag;
 }
 
+#ifndef CONFIG_USER_ONLY
+/*
+ * Constructs S2 Permission Fault as described in ARM ARM "Stage 2 Memory
+ * Tagging Attributes".
+ */
+static void mte_perm_check_fail(CPUARMState *env, uint64_t dirty_ptr,
+                                uintptr_t ra, bool is_write)
+{
+    uint64_t syn;
+
+    env->exception.vaddress = dirty_ptr;
+
+    syn = syn_data_abort_no_iss(0, 0, 0, 0, 0, is_write, 0);
+
+    syn |= BIT_ULL(41); /* TagAccess is bit 41 */
+
+    raise_exception_ra(env, EXCP_DATA_ABORT, syn, 2, ra);
+    g_assert_not_reached();
+}
+#endif
+
 uint8_t *allocation_tag_mem_probe(CPUARMState *env, int ptr_mmu_idx,
                                   uint64_t ptr, MMUAccessType ptr_access,
                                   int ptr_size, MMUAccessType tag_access,
@@ -117,8 +138,21 @@ uint8_t *allocation_tag_mem_probe(CPUARMState *env, int ptr_mmu_idx,
     }
     assert(!(flags & TLB_INVALID_MASK));
 
-    /* If the virtual page MemAttr != Tagged, access unchecked. */
-    if (full->extra.arm.pte_attrs != 0xf0) {
+    switch (full->extra.arm.pte_attrs) {
+    case 0xf0: /* Tagged */
+        break;
+
+    case 0xe0: /* NoTagAccess */
+        if (cpu_isar_feature(aa64_mteperm, env_archcpu(env))) {
+            if (probe) {
+                return NULL;
+            }
+            assert(ra);
+            mte_perm_check_fail(env, ptr, ra, tag_access == MMU_DATA_STORE);
+        }
+        /* fall through */
+
+    default: /* Not Tagged */
         return NULL;
     }
 

-- 
2.54.0


