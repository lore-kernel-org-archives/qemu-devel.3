Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D933F108E1E9
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 11:21:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3BQb-0007pb-Ky; Thu, 19 Mar 2026 07:20:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w3BQa-0007pC-2S
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 07:20:36 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w3BQX-0006Af-IS
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 07:20:35 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-43b40fb7f95so720141f8f.3
 for <qemu-devel@nongnu.org>; Thu, 19 Mar 2026 04:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773919231; x=1774524031; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wofAlcNimL3fKlS85Aya0QNm0cIokcBfl4ew1SrPm3w=;
 b=Tiy91+XugcS8WQs9Ekc7/PPWmz7J9lFchfwP190//LBaX85pMoyKDvO5TcfRS4a2qL
 rIOgeIU7pDZd+qKRnqQ1Oy8HYhWvHQ9d7NXSlg5u3ZhD0BUj6EORhbrgC124uGHcxZ+B
 TzI4lKJ+K8ArgncGL/FhjQ7YZcjWiuk7/Az1VajUxH49+bGmxardwHeMc+D16l2jptmL
 FgCL33LFCDk/FX+vHBpUIwgmhK9o1oFLOP3n8wshtMvTXLKfmHG5TNaUbVC0NBMHoYlj
 3D8BHbK/+5mfE+S8XHbYstbSBjSH0Wrzq6l90sYYLQXMV28Qj7xp2IMWVmzzndDVsVmr
 4/8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773919231; x=1774524031;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wofAlcNimL3fKlS85Aya0QNm0cIokcBfl4ew1SrPm3w=;
 b=PR5rvvfYNg+q7dc4G6PNwvA6muxhCZeNMVdtUorpyVO8VSo3EF7nJnGMlZYszT+Y7H
 BZbbYfiGnZjH6d3NSoM1/vajB+JuCY/7xmsp3fTrXRSkbcRBF2GviLLcA+bviFJS5z28
 wOBPpONYg5a2p1EN+ZYKKRq2tfMnMcsjyW7HBFP3sjmPqsRme/Ox2beh83VnzM4i1qx4
 aStzbhJNp1YFlNPf1Sg1FLCOt4f58Om9CdXi/rGFs15+ssNK0y2N1xM5MODE36fwzbVY
 fB3OmqxbvKc67HL94MkuQvL8rn8wEZbPjDQorGDmz3t0flc8F1FYrDoFBpnQxKSzW9kR
 3g9g==
X-Gm-Message-State: AOJu0Yy9clS0ZSLmzlFhM6x0IRn4bc9IJbivGKplLB9wiM+95QdoWL3z
 OcfbeMb6c8hvAJVmyGkPiahgr3jhCidRjyx0RluqtyrjmwSkGcVTDOfA+cB5DhjFg33orICN8/k
 iIwiEN8c=
X-Gm-Gg: ATEYQzwvRMDkcIwAFGkMvoOsRTf25F4E3ABtaLQOVTVH2MbXjTwGCQhMe8KEz+sv1jz
 lvVi4KytoTF9aSAD5gpBvBlc0nxmmOHr1/SRl/f+/1t2QZIswauAREMZn065YN4SGVgCxrEkFin
 ojxXYUDLeiJdccMdUVPO3h3QFvAEh6ijMTB826NxneLN32ZmJH7j7IfzVUm7hZDpdWKGz3ZeEAY
 Cr0sz++CnfTj4+hLn992cpp5hMXp1cB5tDiaFF4HtU9vrabPhq3fjqRPi0eT9Ho7cUOax2ox31X
 TpZZBE6JRBjElTqidSFWVXI5k61WPbuYoEqOyhuCq9+DnuFBtfs2uPKHq5T4g6vmmdJISRb8Vl4
 LwfUucceqt6KAZv8Yka/s7ySXi9G6to6tS6DV4UMdhtzgzdjSzTvjHeayhx2EnjEMc7FS4pnLiz
 WmsbyZjiGj1aBrW1hFCfeeADsqolDqIRe7M63OnTIfNHprZ/WF6BCeZkzD+Oi8g7R7Fke3ApSM
X-Received: by 2002:a5d:5887:0:b0:43b:4d25:959b with SMTP id
 ffacd0b85a97d-43b527a97a6mr12241121f8f.17.1773919231367; 
 Thu, 19 Mar 2026 04:20:31 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b5184b8b9sm15749126f8f.1.2026.03.19.04.20.30
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Mar 2026 04:20:30 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>, Paolo Bonzini <pbonzini@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, Nicholas Piggin <npiggin@gmail.com>,
 Glenn Miles <milesg@linux.ibm.com>, kvm@vger.kernel.org,
 qemu-ppc@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Chinmay Rath <rathc@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 7/8] hw/ppc/pegasos: Replace legacy ld/st_phys() ->
 address_space_ld/st()
Date: Thu, 19 Mar 2026 12:19:35 +0100
Message-ID: <20260319111936.68041-8-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260319111936.68041-1-philmd@linaro.org>
References: <20260319111936.68041-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

Prefer the address_space_ld/st API over the legacy ld_phys()
because it allow checking for bus access fault.

This code however doesn't check for fault, so we simply inline
the calls (not specifying any memory transaction attribute nor
expecting transation result) per the definition in
"system/memory_ldst_phys_endian.h.inc":

 27 static inline uint32_t LD_PHYS(l)(ARG1_DECL, hwaddr addr)
 28 {
 29     return ADDRESS_SPACE_LD(l)(ARG1, addr, MEMTXATTRS_UNSPECIFIED, NULL);
 30 }

 42 static inline void ST_PHYS(l)(ARG1_DECL, hwaddr addr, uint32_t val)
 43 {
 44     ADDRESS_SPACE_ST(l)(ARG1, addr, val, MEMTXATTRS_UNSPECIFIED, NULL);
 45 }

No logical change intended.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/ppc/pegasos.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/pegasos.c b/hw/ppc/pegasos.c
index 4217af25807..52e35949cc1 100644
--- a/hw/ppc/pegasos.c
+++ b/hw/ppc/pegasos.c
@@ -21,6 +21,7 @@
 #include "hw/ide/pci.h"
 #include "hw/i2c/smbus_eeprom.h"
 #include "hw/core/qdev-properties.h"
+#include "system/memory.h"
 #include "system/reset.h"
 #include "system/runstate.h"
 #include "system/qtest.h"
@@ -593,12 +594,12 @@ enum pegasos2_rtas_tokens {
 
 static uint32_t rtas_ldl(AddressSpace *as, hwaddr addr)
 {
-    return ldl_be_phys(as, addr);
+    return address_space_ldl(as, addr, MEMTXATTRS_UNSPECIFIED, NULL);
 }
 
 static void rtas_stl(AddressSpace *as, hwaddr addr, uint32_t value)
 {
-    stl_be_phys(as, addr, value);
+    address_space_stl(as, addr, value, MEMTXATTRS_UNSPECIFIED, NULL);
 }
 
 static target_ulong pegasos2_rtas(PowerPCCPU *cpu, PegasosMachineState *pm,
-- 
2.53.0


