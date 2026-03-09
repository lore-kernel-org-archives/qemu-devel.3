Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B4D0FCA198
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 22:02:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vziem-00033A-0f; Mon, 09 Mar 2026 18:00:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brookmangabriel@gmail.com>)
 id 1vziee-00031D-Lz
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 18:00:51 -0400
Received: from mail-yw1-x1134.google.com ([2607:f8b0:4864:20::1134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <brookmangabriel@gmail.com>)
 id 1vziec-0004Vr-U7
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 18:00:48 -0400
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-79860421382so115560077b3.0
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 15:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773093645; x=1773698445; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=saxPVdNzQrCkohNF8gWwgcPyB3i+BYvE2L0q+VhSlxg=;
 b=DGH/Fpopl2ys1b2wxSJO6Aowddnj2SRAY90JLiYyM8y2TmZutngXdakFQ2Fr8pA6oi
 2/B5liK1Qmzh7NEt36z3aDYRgV2fz4LY61Yedc7ZNbtr3f8IcrS0HFl2YV9D3KMptD0I
 v2OVw0wLIpAjpXxhaSn1ij+w7xQ5ChEUHv8UmF4XzHHn4XzGiByVZX9R8mJJT6S7OeN3
 SbUxJoPlUh/s+v8Rn8a28GYgixb+KwBrsV8RdZZZQWuH7KwTCtVh9GrwJ/aA4NuR8CR8
 lHEFJWikFXb2S9hK6NnbMsyQCxB5oZwFHw370kce7ogqecEu4ekhQoh2tp72PRkHuL8E
 BfkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773093645; x=1773698445;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=saxPVdNzQrCkohNF8gWwgcPyB3i+BYvE2L0q+VhSlxg=;
 b=MjLtIqWLUtXw2DPN+eXlySaroMqRzXwhLK8rYjEOXWZGJfvnMaf9MznHpRzqa6oD4M
 t7lUfJsUoNN54CUx/qzo6PiD0sOWJD9HWUylgt/nVTycAFKjiUl9cLBWriQuyX1VsKr/
 +cgTMjCmwtT+4Q67kVoquA/mC/BC0Pi9HKt1VN2sOEAikT7vumYSF2UdJHZeAqqWDpfv
 NdHOF3cygXYOr7/TUSA9y96xlhus36SCoAw8cLD9ZOFbAJ8vxaWXu+HjTyiX3NZr0vC8
 cSOinx36eHITZXg8TxV/z3irzAf1uxM90RisQlVv3VSlvMbkhEYdZxi/nF4lOpzLk6X6
 WXAA==
X-Gm-Message-State: AOJu0Yyniw+k5q0WcIbLpfNA8BMfdbHOyLYi+oNkL7xZd2VxMHKe1pB1
 HC/E1ZbZPIvnnndQnPJ1gzk3Jto9jllMp7TRJ8WQA6Hz2DJmL1GyeCQQ
X-Gm-Gg: ATEYQzwvrvauIDrFhntNqKrtOSNM1sMo8WRpwrEKCGj1/VosfK5caO3VEOPYKtOZ/7e
 0CEiiWbZodVRhXbGdJCY6n7IK8w4tRzABuAzcKjuAEwsB1qYzE/a8eteqhPi2j4azx9lDxETc/W
 627ziipe7QJxl9hPD1PUC5HJ7E4sPXRU1U8cW+lA/BMTsTf3+Nozee7rq5+cS6qEVq/AM2xXITi
 30csCirnsN//4DP83zIlCgU25NsIbyhmaJM6S9OylxlxjyWutgP4i4zhxXrY4171W/ztyfX4sB+
 AJ+HaRNwdRElk/b+1zoUThdXk1kqXTjmT5JViHnvUvJGN2KoeZ+9KbunVy0ZvAcZm1LVB+Sym4W
 gz/GnDyDZxSfU+4Ys+GP5cUGpxM6SDUWN7W1L6x3xa+OXcpqUgBmTS1AVhyvBEIUel70T53YUig
 D95MRCHC3onNvVwURMAlEkZTjD1jOW62MtTH8=
X-Received: by 2002:a05:690c:660e:b0:799:952:3e6f with SMTP id
 00721157ae682-799095253aemr16504277b3.19.1773093644476; 
 Mon, 09 Mar 2026 15:00:44 -0700 (PDT)
Received: from [172.26.74.149] ([185.213.193.97])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-7990a54ba7csm5218437b3.19.2026.03.09.15.00.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 15:00:43 -0700 (PDT)
From: Gabriel Brookman <brookmangabriel@gmail.com>
Date: Mon, 09 Mar 2026 17:59:33 -0400
Subject: [PATCH v4 01/13] target/arm: implement MTE_PERM
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260309-feat-mte4-v4-1-daaf0375620d@gmail.com>
References: <20260309-feat-mte4-v4-0-daaf0375620d@gmail.com>
In-Reply-To: <20260309-feat-mte4-v4-0-daaf0375620d@gmail.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, 
 Gustavo Romero <gustavo.romero@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org, 
 Laurent Vivier <laurent@vivier.eu>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Gabriel Brookman <brookmangabriel@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773093641; l=4593;
 i=brookmangabriel@gmail.com; s=20251009; h=from:subject:message-id;
 bh=EFVy8rM6hzX0gBUkxRsGr/3LIt/4cq55D0ThmN9lXuM=;
 b=+RE/9QXr0zFBlm8rppv0nDYsvtcUXj1GdvqscFuM+G5yMk6TcWgQfw5cWPDzjLNDTIqxbl+Kh
 5rT9XThppgABHWBFV2i1IHjhkmqgPpN+AADbpacqe3zGNguccChq6vG
X-Developer-Key: i=brookmangabriel@gmail.com; a=ed25519;
 pk=m9TtPDal6WzoHNnQiHHKf8dTrv3DUCPUUTujuo8vNrw=
Received-SPF: pass client-ip=2607:f8b0:4864:20::1134;
 envelope-from=brookmangabriel@gmail.com; helo=mail-yw1-x1134.google.com
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
---
 target/arm/cpu-features.h   |  5 +++++
 target/arm/ptw.c            | 25 ++++++++++++++++++++++---
 target/arm/tcg/mte_helper.c | 30 ++++++++++++++++++++++++++++++
 3 files changed, 57 insertions(+), 3 deletions(-)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index b683c9551a..1f09d01713 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -1144,6 +1144,11 @@ static inline bool isar_feature_aa64_mte3(const ARMISARegisters *id)
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
index 8b8dc09e72..d381413ef7 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -3383,7 +3383,7 @@ static ARMCacheAttrs combine_cacheattrs(uint64_t hcr,
                                         ARMCacheAttrs s1, ARMCacheAttrs s2)
 {
     ARMCacheAttrs ret;
-    bool tagged = false;
+    bool tagged, notagaccess = false;
 
     assert(!s1.is_s2_format);
     ret.is_s2_format = false;
@@ -3393,6 +3393,18 @@ static ARMCacheAttrs combine_cacheattrs(uint64_t hcr,
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
@@ -3424,9 +3436,16 @@ static ARMCacheAttrs combine_cacheattrs(uint64_t hcr,
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
index a9fb979f63..4deec80208 100644
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
@@ -117,6 +138,15 @@ uint8_t *allocation_tag_mem_probe(CPUARMState *env, int ptr_mmu_idx,
     }
     assert(!(flags & TLB_INVALID_MASK));
 
+    /*
+     * If the virtual page MemAttr == Tagged NoTagAccess, throw S2 permission
+     * fault (conditional on mteperm being implemented and RA != 0).
+     */
+    if (ra && cpu_isar_feature(aa64_mteperm, env_archcpu(env))
+        && full->extra.arm.pte_attrs == 0xe0) {
+        mte_perm_check_fail(env, ptr, ra, tag_access == MMU_DATA_STORE);
+    }
+
     /* If the virtual page MemAttr != Tagged, access unchecked. */
     if (full->extra.arm.pte_attrs != 0xf0) {
         return NULL;

-- 
2.52.0


