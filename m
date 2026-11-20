Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC40606A33D
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 10:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ggKsbHMF
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUM79-0004H8-2G; Fri, 20 Nov 2026 05:45:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mdspan.github@gmail.com>)
 id 1xUM6q-0004F9-CT
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 05:44:49 -0500
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mdspan.github@gmail.com>)
 id 1xUM6o-0007jn-J5
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 05:44:48 -0500
Received: by mail-pf1-x444.google.com with SMTP id
 d2e1a72fcca58-8c700d6cc0bso1091845b3a.1
 for <qemu-devel@nongnu.org>; Fri, 20 Nov 2026 02:44:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795171484; x=1795776284; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=laQ6QZyEtxtQAi/URxEAvnNBijrdZL/IXyuWlqzskR8=;
 b=ggKsbHMFKBeFT/Enm9f1dda3raJDXrYFgRhFxshf4n+bVLVy799mhqqzmL1XIIuJG5
 PHNOAW7ZAXlmuo/fhAt2jR8Rs/MqpJ9J+DquBzwmt+n0O69gAmSFojHdznt0pEC1dzPt
 XO0/govon3JbSKn3X01LG097Z8BdFoCTgAHekz3dHzRHCbGNXSoKJ+PpxExNDr/C5Y5w
 nFNpJuT982QOPOI4MAFbRQBF/klXtk5zqZIeHPSHD+OxW1OU605nAuKWvZ65p8213Sqt
 HX4GL3954qy7PSCSAskQhaunPba/FokddO/Hv8PHFuRGU4mKOyQdUe5b1rkxMgb6BO49
 xNSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795171484; x=1795776284;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=laQ6QZyEtxtQAi/URxEAvnNBijrdZL/IXyuWlqzskR8=;
 b=PNUjD/ESP0b362dTLI328X4EmBiMMaf6LE1/aX5RHbAefBJTdUcwx4jdrIOpkisEKV
 sNDDcYfURNvOJmwHjzOWWh6eIGTylgTBb8gf9A+iw7XE6vRIhzy4INdZuThjUkViTxA7
 0l0FjWwEQBRg+wl8B7e3h2GRaL6adKa3KJdBWMCzkWb2LQD0U3ey8gvdu4hfj2Tix21C
 F4b7SqL4CFWJcdGgnWVxF+y8tsTXyrG2pH1b5Nc5iigVQR12A+kWJx7DO5IUSviBUE1e
 ONWryY2TaI+eTC4XDx1Rwk1JFCZfK5qA/mKxis3CpIwgk8thRoNGC1AilAiz6v1QWYTc
 dlsQ==
X-Gm-Message-State: APuU4Z+TROgOxWYSOeAPHbrkNrnOzf/48lmfd1h3MayZlnRjZrZwxMy7
 k/KI3lnkBs8mGaDlcJ5ewSrnylLtr7lvBsGw/D7cXrFueOeYaR84HWM7tKOQI5U8wy0=
X-Gm-Gg: AYBFou179Vs63Tji2gfhyttmu0Pr5JIKqX5ZOk22ih0nuLH43/zLphm3dCnEjku0DRO
 V1oJV+FnZiPTqthVvmuSFHQ8e1R3Bq4KeP2gKm1nHXEqLq5dqAsIuxhMQkeQwWlxuvwRnVulq2k
 OkeCSBjQLsCF9iRcPCY+scxGoqgE2QgFcLdMOg4Z5CgF2B/PWrLbc/osFmvAfay994NTLh81ZDA
 hatp5fvyKW75LIoB6PGbcu70DB3R/Q4rNzQVSPz4Ige4ujBaVbPD/UB+bPF1aWywqZyQ5acM1wz
 HKj0yXy8numZVUW3zkhRn3IetNrhqBNIE4h2Ai9qFprtDcpzBihcU/LmYUY6eJyj0RPhVgJ6Te3
 OuTRilaSAw395uyypU5hcg/WA4Si5uqrhve5+rxXCev70SuOpumTYgaLL0WEr47fTQ/zonGWgIc
 TfQPL9fb8RsOL6Usk4f9cG3Ljd0NvkpQm9TooDRC+Q474TbO2j9CZSn+nArS5e+576UD9n1JHIl
 2EOHht5Vrwvjc26INg4yjK4KuufbxL8LmewjTDExsV/5TVnM9YQ4zJeKBdlLDMh3LGoqB8kym3R
 SmXB/hBtIBGZ39fnAwPQ91e8CUM82xpwfiT+3Utg/fzaemW9Zv7c
X-Received: by 2002:a05:6a21:328c:b0:3eb:3c15:48f with SMTP id
 adf61e73a8af0-400ae0433afmr3430427637.32.1795171484380; 
 Fri, 20 Nov 2026 02:44:44 -0800 (PST)
Received: from computer ([2604:3d09:98d:800:cd94:7b9e:bb89:3491])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cde6cfc80d4sm1151506a12.6.2026.11.20.02.44.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 02:44:44 -0800 (PST)
From: Tim <mdspan.github@gmail.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, richard.henderson@linaro.org, zhao1.liu@intel.com,
 Tim <mdspan.github@gmail.com>
Subject: [PATCH v2 3/5] target/i386: use separate MMU indexes for instruction
 fetch
Date: Fri, 20 Nov 2026 10:44:29 +0000
Message-ID: <20261120104431.733136-4-mdspan.github@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261120104431.733136-1-mdspan.github@gmail.com>
References: <20261120104431.733136-1-mdspan.github@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::444;
 envelope-from=mdspan.github@gmail.com; helo=mail-pf1-x444.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

x86_cpu_mmu_index() ignores ifetch, so instruction fetches and data
accesses at the same privilege level share a TLB.  Add user and
supervisor fetch indexes, each in 64-bit and 32-bit forms, and return
them for fetches.  Supervisor fetches need no SMAP variant, since SMAP
does not apply to instruction fetches.

This lets the fetch and data translations of a linear address differ,
which LAM needs.

Signed-off-by: Tim <mdspan.github@gmail.com>
---
v2: new patch, as suggested in review of v1.

 target/i386/cpu.h         | 11 ++++++++---
 target/i386/tcg/tcg-cpu.c |  9 ++++++++-
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 3945e903..5bc19d5e 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2838,8 +2838,12 @@ uint64_t cpu_get_tsc(CPUX86State *env);
 #define MMU_USER32_IDX     3
 #define MMU_KNOSMAP64_IDX  4
 #define MMU_KNOSMAP32_IDX  5
-#define MMU_PHYS_IDX       6
-#define MMU_NESTED_IDX     7
+#define MMU_KFETCH64_IDX   6
+#define MMU_KFETCH32_IDX   7
+#define MMU_UFETCH64_IDX   8
+#define MMU_UFETCH32_IDX   9
+#define MMU_PHYS_IDX       10
+#define MMU_NESTED_IDX     11
 
 #ifdef CONFIG_USER_ONLY
 #ifdef TARGET_X86_64
@@ -2856,7 +2860,8 @@ static inline bool is_mmu_index_smap(int mmu_index)
 
 static inline bool is_mmu_index_user(int mmu_index)
 {
-    return (mmu_index & ~1) == MMU_USER64_IDX;
+    return (mmu_index & ~1) == MMU_USER64_IDX ||
+           (mmu_index & ~1) == MMU_UFETCH64_IDX;
 }
 
 static inline bool is_mmu_index_32(int mmu_index)
diff --git a/target/i386/tcg/tcg-cpu.c b/target/i386/tcg/tcg-cpu.c
index 167ff769..b8f20f20 100644
--- a/target/i386/tcg/tcg-cpu.c
+++ b/target/i386/tcg/tcg-cpu.c
@@ -130,7 +130,14 @@ int x86_mmu_index_pl(CPUX86State *env, unsigned pl)
 static int x86_cpu_mmu_index(CPUState *cs, bool ifetch)
 {
     CPUX86State *env = cpu_env(cs);
-    return x86_mmu_index_pl(env, env->hflags & HF_CPL_MASK);
+    unsigned pl = env->hflags & HF_CPL_MASK;
+
+    if (ifetch) {
+        int mmu_index_32 = (env->hflags & HF_CS64_MASK) ? 0 : 1;
+
+        return (pl == 3 ? MMU_UFETCH64_IDX : MMU_KFETCH64_IDX) + mmu_index_32;
+    }
+    return x86_mmu_index_pl(env, pl);
 }
 
 #ifndef CONFIG_USER_ONLY
-- 
2.47.3


