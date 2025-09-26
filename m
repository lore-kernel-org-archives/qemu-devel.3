Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A71D9CAC5AE
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 14:27:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v2996-0008M4-IH; Fri, 26 Sep 2025 10:10:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v298k-0007gW-CP
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 10:09:40 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v298O-0005gu-0J
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 10:09:37 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3ee64bc6b90so1460150f8f.0
 for <qemu-devel@nongnu.org>; Fri, 26 Sep 2025 07:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758895746; x=1759500546; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=EvffExaOTzwk+Qku7c6pfTqkaF9GGHtbtWdcKsTMZPs=;
 b=eTorzBIc9Iy1vEclPbvyvxglOlkkXn/FnTQlSBnGFf93ljvhrJ9aoGz6MJN+jqIvcz
 RIHryq6nYbWF/DCqR06Yd883Zr6QwXp5hIVBtN3BR5T+ERMaxf4V4pP8CbxdMJBTv0X3
 WhfFzj1CKmOB27+CDfpPbpM47l83NOBoCHIJvV4KRGu+qRHAyKwweI77UZDnqcipyKBa
 FqGy2zoCcDhZQdVscySPlLPik2DX3o7H3hLRhNXc2mV6wUbIvtdupAUepjRs07pM2qve
 oQKEFuPRLE2GbJ7ub+EjatCbkt9SGYjZp+JLz56gN1yARcUqOIZK3yM2zJm9uGnM+D+o
 0wKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758895746; x=1759500546;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EvffExaOTzwk+Qku7c6pfTqkaF9GGHtbtWdcKsTMZPs=;
 b=Bbai9rAyRU5kruwSGYKq17x+9w4lU4LzyM2sAm9zo4fvftowoAm7RNO4jylnSL/zMh
 I1PALuegZyftDRd1nLK0bugAcCHojOBakFeMdQo20jywLwGkuUQhbybZphQrrbXHkdIF
 nzL8JcZedCoplm1CvcyLjp1ljvCL0W7GXktfhEMlxM5+soitvwt4hyHiSoK2otEQ7YyV
 ilPhndkqMcliwM6QWOpX7D0Pyct1o9JkVpNZ172MycLazqSS1QqmxsWwgtH9hU151KC6
 1/dUHTQ4fqVb0fjwtJb/Gga5fkl5bzkonAKqJSqG1lI6YVT5GAS5M/nIc2qSz2rutE5E
 i15g==
X-Gm-Message-State: AOJu0Yyr1U6ULJQ7He7VquxXls4qzT35xwJXRdfJg3wGOyujTUsWuLId
 jfXNjz2qENZFPMnMLwy3TwhdkLwq7937kVapyui6j6OiZ/agBO/kqlli3TqI93TmJCQ8q1p7Hz0
 BDyG+
X-Gm-Gg: ASbGncvNEhbggMVxzRqPsZ0aZDgQt8JmSka8H9Z7sT7cU+BSbo7PeDuPoe75O9YX0NS
 27YrBmrchsBtc59l/aBHuwBjjAyb3cDkzeHIxnRrevdtdp+rxanc/NQr6iEGFtUEcpEQKWK448q
 Qv4hT6GdmpDxsuSUpfAIUtpOyNg+oUHvYB+qg7jKcmwDve6mHJRsVuqR3PReS4BkX0Eg74/HZ8a
 Q0kQYCDXl5XyAb2CzjBkmLD/Y133D7HpXAccp/EKTunJvg23MHM+M/RAo09kMYPovT32guvdDbx
 DhKtBu6VA71I0I+I8zhCJG8Rb9Jqmll2Fbm2xUC7FM4Iu0qorJagnqFeBQJov77Nx2lvUQyu7lp
 AjHxpmk1gyAl2gjOIWPQlpZrBDH7I
X-Google-Smtp-Source: AGHT+IG2KNcKc/6vVaXmX7wNASfpHoIbsZDlCkb8T4B2MPX03Wsd5iRDZGLKPktfnyNlIlVUOZInVg==
X-Received: by 2002:a05:6000:2484:b0:405:1925:4972 with SMTP id
 ffacd0b85a97d-40e46515005mr6429455f8f.1.1758895746181; 
 Fri, 26 Sep 2025 07:09:06 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-410f2007372sm6338315f8f.16.2025.09.26.07.09.05
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Sep 2025 07:09:05 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 19/44] target/arm: Convert init_cpreg_list to
 g_hash_table_foreach
Date: Fri, 26 Sep 2025 15:08:19 +0100
Message-ID: <20250926140844.1493020-20-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250926140844.1493020-1-peter.maydell@linaro.org>
References: <20250926140844.1493020-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Richard Henderson <richard.henderson@linaro.org>

Adjust count_cpreg and add_cpreg_to_list to be used with
g_hash_table_foreach instead of g_list_foreach.  In this way we have
the ARMCPRegInfo pointer directly rather than having to look it up
from the key.

Delay the sorting of the cpreg_indexes until after add_cpreg_to_list.
This allows us to sort the data that we actually care about,
the kvm id, as computed within add_cpreg_to_list, instead of
having to repeatedly compute the kvm id within cpreg_key_compare.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 54 ++++++++++++++++++---------------------------
 1 file changed, 21 insertions(+), 33 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 26941ecd4f8..27d5ab82920 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -229,11 +229,11 @@ bool write_list_to_cpustate(ARMCPU *cpu)
     return ok;
 }
 
-static void add_cpreg_to_list(gpointer key, gpointer opaque)
+static void add_cpreg_to_list(gpointer key, gpointer value, gpointer opaque)
 {
     ARMCPU *cpu = opaque;
     uint32_t regidx = (uintptr_t)key;
-    const ARMCPRegInfo *ri = get_arm_cp_reginfo(cpu->cp_regs, regidx);
+    const ARMCPRegInfo *ri = value;
 
     if (!(ri->type & (ARM_CP_NO_RAW | ARM_CP_ALIAS))) {
         cpu->cpreg_indexes[cpu->cpreg_array_len] = cpreg_to_kvm_id(regidx);
@@ -242,61 +242,49 @@ static void add_cpreg_to_list(gpointer key, gpointer opaque)
     }
 }
 
-static void count_cpreg(gpointer key, gpointer opaque)
+static void count_cpreg(gpointer key, gpointer value, gpointer opaque)
 {
     ARMCPU *cpu = opaque;
-    const ARMCPRegInfo *ri;
-
-    ri = g_hash_table_lookup(cpu->cp_regs, key);
+    const ARMCPRegInfo *ri = value;
 
     if (!(ri->type & (ARM_CP_NO_RAW | ARM_CP_ALIAS))) {
         cpu->cpreg_array_len++;
     }
 }
 
-static gint cpreg_key_compare(gconstpointer a, gconstpointer b, gpointer d)
-{
-    uint64_t aidx = cpreg_to_kvm_id((uintptr_t)a);
-    uint64_t bidx = cpreg_to_kvm_id((uintptr_t)b);
-
-    if (aidx > bidx) {
-        return 1;
-    }
-    if (aidx < bidx) {
-        return -1;
-    }
-    return 0;
-}
-
 void init_cpreg_list(ARMCPU *cpu)
 {
     /*
      * Initialise the cpreg_tuples[] array based on the cp_regs hash.
      * Note that we require cpreg_tuples[] to be sorted by key ID.
      */
-    GList *keys;
     int arraylen;
 
-    keys = g_hash_table_get_keys(cpu->cp_regs);
-    keys = g_list_sort_with_data(keys, cpreg_key_compare, NULL);
-
     cpu->cpreg_array_len = 0;
-
-    g_list_foreach(keys, count_cpreg, cpu);
+    g_hash_table_foreach(cpu->cp_regs, count_cpreg, cpu);
 
     arraylen = cpu->cpreg_array_len;
-    cpu->cpreg_indexes = g_new(uint64_t, arraylen);
-    cpu->cpreg_values = g_new(uint64_t, arraylen);
-    cpu->cpreg_vmstate_indexes = g_new(uint64_t, arraylen);
-    cpu->cpreg_vmstate_values = g_new(uint64_t, arraylen);
-    cpu->cpreg_vmstate_array_len = cpu->cpreg_array_len;
+    if (arraylen) {
+        cpu->cpreg_indexes = g_new(uint64_t, arraylen);
+        cpu->cpreg_values = g_new(uint64_t, arraylen);
+        cpu->cpreg_vmstate_indexes = g_new(uint64_t, arraylen);
+        cpu->cpreg_vmstate_values = g_new(uint64_t, arraylen);
+    } else {
+        cpu->cpreg_indexes = NULL;
+        cpu->cpreg_values = NULL;
+        cpu->cpreg_vmstate_indexes = NULL;
+        cpu->cpreg_vmstate_values = NULL;
+    }
+    cpu->cpreg_vmstate_array_len = arraylen;
     cpu->cpreg_array_len = 0;
 
-    g_list_foreach(keys, add_cpreg_to_list, cpu);
+    g_hash_table_foreach(cpu->cp_regs, add_cpreg_to_list, cpu);
 
     assert(cpu->cpreg_array_len == arraylen);
 
-    g_list_free(keys);
+    if (arraylen) {
+        qsort(cpu->cpreg_indexes, arraylen, sizeof(uint64_t), compare_u64);
+    }
 }
 
 bool arm_pan_enabled(CPUARMState *env)
-- 
2.43.0


