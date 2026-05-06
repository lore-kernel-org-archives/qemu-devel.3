Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E412FF8855
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 13:58:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKclJ-0007CM-NI; Wed, 06 May 2026 09:58:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKclF-0006y7-P4
 for qemu-devel@nongnu.org; Wed, 06 May 2026 09:58:01 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKclD-0008NC-MP
 for qemu-devel@nongnu.org; Wed, 06 May 2026 09:58:01 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-48334ee0aeaso46411585e9.1
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 06:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778075876; x=1778680676; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=XTYyf/lmPyz+PLU0Y7TEYZKsWWt4PgHM9yxseIT1vDM=;
 b=kIQZvHQIxI3AB+ytnjWywNrka0Xe4/XBDg1abhBm/7gBUa/2OPfu3GM1rglHXhZ/+8
 g49qAgDQuKkXSsn3SUebJArtKjyCSYI+0XQ6bWAyYcsivqG3W6aoieIqqrT0PmJQTtW7
 yRsWj29h9eNNexXgnpukEDELJgYBcjPBW0Ef0wMJmHMVaSmtBaOLDxJ7ijw15lU+ketf
 iPH3VkdVRI3DVuj4sO4gjJReJnterrkCQyinfxklFpsnZHhNO4hslQ2YCghqN8AssiD3
 Gwl6ozkUjOQvKdedNtROFx+f6sN/bQtjbRfsZ7qjK04bWIJmQFLl8tE/GxiyTEMZIgmQ
 Sfaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778075876; x=1778680676;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=XTYyf/lmPyz+PLU0Y7TEYZKsWWt4PgHM9yxseIT1vDM=;
 b=Klc/wkZxzsjDQTO7gR2T43xqYz8HLjB/OfWHlpmLkyHdoe9ZXOJ1lj1d+ywEtjWOBC
 LzmS2C2gxTyHgWsGZoPPZMQ9bz7e9xnmwnm7kEq8RE9H4RziOG++IFTeQ9Wo15Q6j9Zw
 O8o7E+GfXv1WXoayIEMulELeQcfsyhnJ/Jd+eGjmHwHRfJB27oNOcTz9QXE0PMa6M2vA
 kced8vF5iWf3Giou9CPHAh3KRscl7eCL7IBlthFUn4eIDO/ueUC8EJSvkDc9RV38lBA8
 GcQpaYoh6oG+J0MT3BfASGC7kdEvy7Q+kRbD1tEZTuxOmtX62rkmHj+n3zPBINimO2Pb
 +5wg==
X-Gm-Message-State: AOJu0YyPmj1K6BZ8nKJGd2W0E3IY70vi0GqApz87EkWLMAhdd8bNBCAb
 Oe0t/EFJbLuGM1lEviIhLZ2NMmVtB6nLEO6WUJ4E4SUW8IeQr90FTtPQ4YduvdMDJ2ViFErWueS
 Aav5u7/o=
X-Gm-Gg: AeBDieuZnudc/zaBvYoXzhdZSHDyWV29+PaJ7dlPImug9V1sbGhV3UFju7WycXt5kKR
 Dzmkqrkx+XIMsjSjTQIJKwijwn0xhWBqIIsWuJQ34g5w4mpPJRWjE3tQOfJ8FWsyj5PmE0dBPGt
 OYL3ijTBii0VmWzRFd5dePEFx+T6S+DWxL6H0/S3AkcX96xwWxOO0o55h5Vb5MQxBTcTeuESoiL
 S/W+ntuymOSz7xSRMGgEIh4eu6v61dveNUxZ0DX6asIo1rSUGcz2mnyHYHuJdiDISGJYRUdeiyK
 MK2EzmagqIpEx2nuPliNyU6ObmcDuVJsFhli6bx7LfJZZnfDWHzWu/HAKF/j8MQ6iVooKE0mVRL
 x+9F5nkUKuVxln8kBtv3zef5fNCo2ffecdM42nCoIGUSANF8gHV706orTezlu4ijtFXmP50jFR6
 eX4MeaTUp50zYuaBGRGZ+Gk/f31p5c/s+rbIYUXam1+PVNDa57BPVgNfGU+ojksFCeourvSHuTX
 tUnFIH1Lmvu6rkhkuDKmg==
X-Received: by 2002:a05:600c:354b:b0:486:f634:ef1 with SMTP id
 5b1f17b1804b1-48e51f32a7amr63637295e9.17.1778075876480; 
 Wed, 06 May 2026 06:57:56 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e538c4ae1sm47088615e9.12.2026.05.06.06.57.54
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 06 May 2026 06:57:55 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 020/110] target/ppc/mmu: Restrict hash32_load_hpte() helpers
 scope
Date: Wed,  6 May 2026 15:53:52 +0200
Message-ID: <20260506135524.20617-21-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260506135524.20617-1-philmd@linaro.org>
References: <20260506135524.20617-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

hash32_load_hpte() helpers are only used within mmu-hash32.c,
no need to have each file including "mmu-hash32.h" to compile
them. Move their definition to this source file.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Message-Id: <20260319111936.68041-5-philmd@linaro.org>
---
 target/ppc/mmu-hash32.h | 16 ----------------
 target/ppc/mmu-hash32.c | 14 ++++++++++++++
 2 files changed, 14 insertions(+), 16 deletions(-)

diff --git a/target/ppc/mmu-hash32.h b/target/ppc/mmu-hash32.h
index 5705f57935b..bfea03ea872 100644
--- a/target/ppc/mmu-hash32.h
+++ b/target/ppc/mmu-hash32.h
@@ -71,22 +71,6 @@ static inline hwaddr ppc_hash32_hpt_mask(PowerPCCPU *cpu)
     return ((cpu->env.spr[SPR_SDR1] & SDR_32_HTABMASK) << 16) | 0xFFFF;
 }
 
-static inline target_ulong ppc_hash32_load_hpte0(PowerPCCPU *cpu,
-                                                 hwaddr pte_offset)
-{
-    target_ulong base = ppc_hash32_hpt_base(cpu);
-
-    return ldl_phys(CPU(cpu)->as, base + pte_offset);
-}
-
-static inline target_ulong ppc_hash32_load_hpte1(PowerPCCPU *cpu,
-                                                 hwaddr pte_offset)
-{
-    target_ulong base = ppc_hash32_hpt_base(cpu);
-
-    return ldl_phys(CPU(cpu)->as, base + pte_offset + HASH_PTE_SIZE_32 / 2);
-}
-
 static inline hwaddr get_pteg_offset32(PowerPCCPU *cpu, hwaddr hash)
 {
     return (hash * HASH_PTEG_SIZE_32) & ppc_hash32_hpt_mask(cpu);
diff --git a/target/ppc/mmu-hash32.c b/target/ppc/mmu-hash32.c
index 8b980a5aa90..08c9f63a132 100644
--- a/target/ppc/mmu-hash32.c
+++ b/target/ppc/mmu-hash32.c
@@ -201,6 +201,20 @@ static bool ppc_hash32_direct_store(PowerPCCPU *cpu, target_ulong sr,
     return false;
 }
 
+static target_ulong ppc_hash32_load_hpte0(PowerPCCPU *cpu, hwaddr pte_offset)
+{
+    target_ulong base = ppc_hash32_hpt_base(cpu);
+
+    return ldl_phys(CPU(cpu)->as, base + pte_offset);
+}
+
+static target_ulong ppc_hash32_load_hpte1(PowerPCCPU *cpu, hwaddr pte_offset)
+{
+    target_ulong base = ppc_hash32_hpt_base(cpu);
+
+    return ldl_phys(CPU(cpu)->as, base + pte_offset + HASH_PTE_SIZE_32 / 2);
+}
+
 static hwaddr ppc_hash32_pteg_search(PowerPCCPU *cpu, hwaddr pteg_off,
                                      bool secondary, target_ulong ptem,
                                      ppc_hash_pte32_t *pte)
-- 
2.53.0


