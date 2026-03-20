Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66B5110987A9
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2026 16:52:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3d4B-0006KT-Gh; Fri, 20 Mar 2026 12:51:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w3d49-0006JM-Sl
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 12:51:17 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w3d48-0001sj-3A
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 12:51:17 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-48558d6ef83so7709025e9.3
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2026 09:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774025474; x=1774630274; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e6sBzq3DUz6gocrIces2uqDUPmvpHqt0ZePVNRFGs/E=;
 b=UZrp0hcjJ4S+7aLXKfIdecAYwBfX0Y2O5VYqyuqrS9nAIy6UeC63PnLE5ApB9VVbkA
 BsDjdHxc6QPXVP/IMowVl3sWqLZPgYXOJSZONfg6wHZ1f35+aF9mvxymkzEWKcSanRoU
 qM0q3b3DVouf7iSaFkP7lAlrpHiyxWOAznLNHn+KRedzNtn57uXVPX1TYL2jQWsFyOue
 n6CBuEA59RP2S4cXhnFfXVgF7jKVnwpXXLkLu1tYVRyryA/hgGYChZEgjRvuhZxqUihq
 SM9eLSYJ5zi0zCyVHcrXD3tHXYs336p0jDsh9Gfqlg2xeub6dPfnSlgIlE9pQNCKeMXb
 ydcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774025474; x=1774630274;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=e6sBzq3DUz6gocrIces2uqDUPmvpHqt0ZePVNRFGs/E=;
 b=MJwp+uSMy2dihvLxW0RN9UjIF1nHB/uPG9V4xS8EANTnezDWCqEOetea4UPR/MyN+z
 Ce9SdkLymUSaYVcc+EumkH0j7oACmLidZoR9yJGo0jBDB4DNbIMG4xFClTmOr6AYKF0d
 y2JbhitmGgQ1Xwv8cNytcp5AqVHzt3MP7AxiA7F12dc77Hz+sp1Cng4CtsXmQl7sC3EP
 Pw42tE1uvBufNcsjLx0YJJ0vc0Y91EHLwTuEFoGdAn9fDRLboeto+7NRyEUOsf8S6I+M
 vYnMdkN3bh56P7iJbp5pdiF1gPfHYBXVMOCmyYS0boqWNzkSbMWIET/M6X5IlIgaUT/J
 sWoQ==
X-Gm-Message-State: AOJu0YyotcIIpIYvMRMSxDgORR/YJVgyrQ02Iail/Wpz+kwsvPaHmCek
 ZDkz3DWusDm1Gf6ZZXV5av8kEd2zfPQh+NbkRfoBwD8cVBy6md0SX+IdEXU4MVO36mqeN/Dmfxj
 z3V3bL4s=
X-Gm-Gg: ATEYQzySufC84OOH9eeMDsfjMHe2nHK2HSs+glBOdj//nHD1MmI4KVIWixtGv6JvY4Y
 XS96ARoe1xXymZ3iP/trhivZ6wSXimIPKthmKEUczkuDMatY8MUQUrQs05mOWw7emX/7YUgSWwy
 YwSyvcyB6iSOZZUWzAwEzcIZAD99WE3wUyGJIdvGJ3yUF7i69iPcr8LX/d3xQUAE1y9E45nu3Cg
 ivyxxdMUMLie5o6dLCmfDe0HnkNrjfOBkUqfK/AeoMvcRnRUmD3gn0oEu/+xPH3l7MTqVWuk2pn
 rlIn0aGSNYS34Eort2IcV8amWymOiXUW9UONuJEjuSHbTqYNmWHUZQRdLSLQOtLWtfDHtnT3IuU
 LgnwzU3XN4eL4CWxaTnbuV1gwRpiD+LenTgb0bEgXtQxIduQ0B/7OCYtDtyJaz5ZF04AWe+ZB+/
 lgNAv1Zq4r1K5JZmTSQANx25wX/n6r7X85vm1xEgeAvDhDjiEGua/RP6TeA9vksXlQGMZRJQDl
X-Received: by 2002:a05:600c:8b32:b0:485:4394:b0e with SMTP id
 5b1f17b1804b1-486fedbad16mr51693335e9.12.1774025474277; 
 Fri, 20 Mar 2026 09:51:14 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-486fe8ceebdsm30580915e9.4.2026.03.20.09.51.12
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Mar 2026 09:51:12 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Laurent Vivier <laurent@vivier.eu>,
 Anton Johansson <anjo@rev.ng>, Glenn Miles <milesg@linux.ibm.com>,
 "Dr . David Alan Gilbert" <dave@treblig.org>, qemu-ppc@nongnu.org,
 Max Filippov <jcmvbkbc@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Chinmay Rath <rathc@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-11.1 v2 7/7] target/xtensa: Rename dump_mmu() ->
 xtensa_monitor_dump_mmu()
Date: Fri, 20 Mar 2026 17:50:20 +0100
Message-ID: <20260320165021.39521-8-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260320165021.39521-1-philmd@linaro.org>
References: <20260320165021.39521-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

Rename dump_mmu() to avoid a name clash with other targets:

  $ git grep -w dump_mmu master | fgrep .h
  target/m68k/cpu.h:610:void dump_mmu(CPUM68KState *env);
  target/ppc/cpu.h:3083:void dump_mmu(CPUPPCState *env);
  target/sparc/cpu.h:603:void dump_mmu(CPUSPARCState *env);
  target/xtensa/cpu.h:697:void dump_mmu(CPUXtensaState *env);

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/xtensa/cpu.h        | 2 +-
 target/xtensa/mmu_helper.c | 2 +-
 target/xtensa/monitor.c    | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/xtensa/cpu.h b/target/xtensa/cpu.h
index caec22bb742..095b4ced45f 100644
--- a/target/xtensa/cpu.h
+++ b/target/xtensa/cpu.h
@@ -693,7 +693,7 @@ int xtensa_get_physical_addr(CPUXtensaState *env, bool update_tlb,
         uint32_t vaddr, int is_write, int mmu_idx,
         uint32_t *paddr, uint32_t *page_size, unsigned *access);
 void reset_mmu(CPUXtensaState *env);
-void dump_mmu(Monitor *mon, CPUXtensaState *env);
+void xtensa_monitor_dump_mmu(Monitor *mon, CPUXtensaState *env);
 
 static inline MemoryRegion *xtensa_get_er_region(CPUXtensaState *env)
 {
diff --git a/target/xtensa/mmu_helper.c b/target/xtensa/mmu_helper.c
index 48e1d64a3d7..766fe60e2eb 100644
--- a/target/xtensa/mmu_helper.c
+++ b/target/xtensa/mmu_helper.c
@@ -1198,7 +1198,7 @@ static void dump_mpu(Monitor *mon, CPUXtensaState *env,
     }
 }
 
-void dump_mmu(Monitor *mon, CPUXtensaState *env)
+void xtensa_monitor_dump_mmu(Monitor *mon, CPUXtensaState *env)
 {
     if (xtensa_option_bits_enabled(env->config,
                 XTENSA_OPTION_BIT(XTENSA_OPTION_REGION_PROTECTION) |
diff --git a/target/xtensa/monitor.c b/target/xtensa/monitor.c
index 2761735f112..80ebba5acbd 100644
--- a/target/xtensa/monitor.c
+++ b/target/xtensa/monitor.c
@@ -34,5 +34,5 @@ void hmp_info_tlb(Monitor *mon, const QDict *qdict)
         monitor_printf(mon, "No CPU available\n");
         return;
     }
-    dump_mmu(mon, env1);
+    xtensa_monitor_dump_mmu(mon, env1);
 }
-- 
2.53.0


