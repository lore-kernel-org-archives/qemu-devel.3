Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46F36108E1EC
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 11:20:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3BQL-0007i8-Gt; Thu, 19 Mar 2026 07:20:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w3BQI-0007fr-Oq
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 07:20:19 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w3BQF-0005Vq-JC
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 07:20:18 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4852e9ca034so7182055e9.2
 for <qemu-devel@nongnu.org>; Thu, 19 Mar 2026 04:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773919210; x=1774524010; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ejOVQiRumOacnIAYVijEgBDEEbKLhlSk8KeBK8nEaas=;
 b=Sx3iuDpG5eXs9OMUeUR42PHbcu6pS2I2tISE23qPHETtj5s9vdlCnEZMq2VNbRySSK
 hXLicPikDAQkJqysebG+ZBgmhsJC1F07SZH2N0xO0qnc4OOoJkVUDtjWSAwpCuMc6tPo
 pcYdNjTGAK5XxNQOlN/uKNMWkLJv1JALl3S8dpf/TeHnJYHWtOFD/d8WiJnKBfBLGMlA
 Hl/cs7s1NehkCMbPNqlPnoF2Y3XKtastnTmNYChNFUiWqZtY7/KG2ALrriAxqf5DxG5n
 WfT4iSP/HuS9L+u6UgX2tBZS5DkUkklQFjIleZyt/L9CV3uqCLqcu0togNZ1BRr5Uvgs
 bJWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773919210; x=1774524010;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ejOVQiRumOacnIAYVijEgBDEEbKLhlSk8KeBK8nEaas=;
 b=owluTaHZxcoSFoK2caD2q3jrwu/E6v+ZThXYQ+hYC//AJsuQVvxJxawU8MELxNr3oh
 /xs+hhMLmxY1cdNdU9427slaQowDKgAhBkMxRCBvi0H4IrtwPC+1amj5lUd14qc/3Zy/
 Xn5icnRk2AvBDHmM/+OatsFS+nwWgWPOqvHg9gbNx+Oic73TigZX5uFaatBG3L3i2Smk
 0tmzyYUxet5IZ4HecKr2IM5QlHyG59PXzW4yCr3Cfoao13JKnjJeOjqPa6cU2ubxIy8c
 AIDFwsuFJa+XBFFz3TZbmX7YrgY6C/WnwPmnsEEbKzO1+LL7Z4g538CD7pR40NtQdEHd
 k0/w==
X-Gm-Message-State: AOJu0YzMm0h8XyFoUndDK83yh2dAsOmD44iSUXslk18ucFxptKqoJvNB
 AcATjTUx6by8Wok/K0kqf3fP+fKtpYIRsHxqaQMt75Gw1j2CkSVCxVjC+zkfKrPx9tVRWR48J+w
 ZhFpn2ZI=
X-Gm-Gg: ATEYQzzebdpSzics2/ihIbzGInCF/Xwdz2K9cb3TAJR7X2DW8lLJCbT9wp3CvDl29nP
 zIdG9huz113ygtRz4cGu6FCEfJLmMql8ih1MrX6fc9+nBzjz7hlTAYkM+FqMuy34eZdgdpi1LeL
 xUe+DyHMud40G3eiedkBBwj4mRGCNxqs28ulkdulpUzevH9aAOtgpvalQe1GPYc5J/JaWuchliU
 qmUqav8cQSHu3+mALcXmTDOPz+225Af5qRuldqciO3Id/6FbfYeoVzOPkxI8Xk+BgFFgwKmFw3u
 DZIGka4Gy2S1XzvG6OC6sxHMDite6hJ46wzWVjNY5KhQTeFVDp+oD+xOVcfYkrLrtZSVkRvELu5
 IBwH/bUD6qkEe6imaZ5FIEh02wMpvjqHmoswucXIzLeCydANmu8uGG7DT9PwZ9J+K39jN/nvQdd
 DVxQFIhEfBP5U6CMPQVmh0zlQ5NxlJIPiM8KcS8SwUJB4XTcOW17Yj2I8SLV+JfA9g9de5zn3r3
 EHDlQmaGBA=
X-Received: by 2002:a05:600c:64c5:b0:486:fcdf:c065 with SMTP id
 5b1f17b1804b1-486fcdfc16dmr11537745e9.27.1773919209867; 
 Thu, 19 Mar 2026 04:20:09 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-486f5e23874sm70980525e9.6.2026.03.19.04.20.08
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Mar 2026 04:20:08 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>, Paolo Bonzini <pbonzini@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, Nicholas Piggin <npiggin@gmail.com>,
 Glenn Miles <milesg@linux.ibm.com>, kvm@vger.kernel.org,
 qemu-ppc@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Chinmay Rath <rathc@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 4/8] target/ppc/mmu: Restrict hash32_load_hpte() helpers scope
Date: Thu, 19 Mar 2026 12:19:32 +0100
Message-ID: <20260319111936.68041-5-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260319111936.68041-1-philmd@linaro.org>
References: <20260319111936.68041-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

hash32_load_hpte() helpers are only used within mmu-hash32.c,
no need to have each file including "mmu-hash32.h" to compile
them. Move their definition to this source file.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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


