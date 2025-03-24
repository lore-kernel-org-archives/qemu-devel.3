Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70BEAC3600C
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Mar 2025 18:59:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twn0p-0000xg-6P; Mon, 24 Mar 2025 14:59:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1twn0n-0000wp-1m
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 14:59:01 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1twn0l-0001Oi-By
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 14:59:00 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3965c995151so2384187f8f.1
 for <qemu-devel@nongnu.org>; Mon, 24 Mar 2025 11:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742842736; x=1743447536; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IeFNeyXdS+DEibAETcGegMoKLdTByvDR+wtJ99heK9k=;
 b=vjYTW2oRb1Y7r6OhqEpWRE3aT2Y+qejzZtUO5xqIv1aGdAaul5tTWcvKNohzkvhvxw
 wHpn45BQQeuytqdl6VdrujTo3x239Cmjw45yWiqqHuZFK0txe5TDu2aSUh43XGBo0QDv
 c7jQnEtt5oh3ggnZ7oAxqzvsk8cLiTPz+tz3WOcNipBHdCR7nA4i5Iv8s/Y8M24HXZFQ
 7K8a/K4hzNCd0iOy+tvicNeESjuJEIycErpXYO2o/fhLlmXFnNWykOzLmAMCYZL2TpqJ
 JKiZWN5wUSbi6kFMY3hvmYsF/IYNHhgKB9q1VxFzWRE+qgF/8AM3hRykk33uHeuehqbS
 IUNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742842736; x=1743447536;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IeFNeyXdS+DEibAETcGegMoKLdTByvDR+wtJ99heK9k=;
 b=RDSRJPZqR7csXk5nD1ivo9E1CWynmIw6dNV5Q9ANqv8+qiKdwveRE8d/CHzkiHHnmV
 tyRgtAY0xgiu4t5/7kqajqBLqfD/huSqyRtumWAI9obusoL6ByTRusJzOcIJpMSCv5D8
 YJcrh642f7/aZ8a3bvwReytPGIVK9aqeKOEg3Lug5DbLWhHz8bLK0jDUc5CAmImwJDPw
 dDR0e2JgAL0xrBk4Js/AXditORB0U9K3OQ+nfLi61T1+Q/aITBltbp5GLq28utTxBF2k
 yXzyllGVCt9MHSd9jRb8II7q+5eAKDB5hJ01VG/WXJPCorbvhVseffp62vH2fDgl37Wx
 WgGQ==
X-Gm-Message-State: AOJu0Yw/Yp4qkjEtFojf3bALuW3cmVLm6w30OK4Rkj3H5CbPJYJoqqa5
 rYf9cXIq3lDR8HUIGofA8OtleSjJub7I75KWcFeAx8/CPZ2tTf8zErMSbbA2Lue100Uk59xeLLG
 9
X-Gm-Gg: ASbGncsCRh2eYmaRuz1shuz3RQBSOKDCwFzI2zInzJKkpFrvUR8tm4gJNGRRNUhPAfi
 yvXQr2hL17XL3sTyKT4XPUbRk5/pSlAhOGIw6QVpXLaU21uR4/Tgea5BvokPg+ZhZDfSDBpCaka
 wfcTuwOk5P6ZDw1Np1uVum2GosGuDlGX/HAB2u34Y+LWmej2qczp9a2blfCRonSEQumxfq57M6g
 NflKKTgJFjFIUIeAm53LLmIViTDVQE6B7df/qj18e1RkpjED4V/Gy5dqqBJRqBsFAFA5eJd5heq
 +qy/FzdQUM/cDusdPhwa4Eg/0jZVcrcx5MNsA3QQZzneDDwouRLjLEAvNhWcU81KBasUedCIRr6
 6WgWPP/KZFgKlaBrAY+RdjAjG
X-Google-Smtp-Source: AGHT+IHH6OWP20eR2YPF0h11jjRUOGX6LjlJ9SD/BfhazvTxxCsHfo0A3tXWGS/b4yWhw3ORPwB6fQ==
X-Received: by 2002:a05:6000:2a1:b0:390:e8e4:7e3e with SMTP id
 ffacd0b85a97d-3997f8f268fmr11833858f8f.6.1742842736525; 
 Mon, 24 Mar 2025 11:58:56 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d43f55750sm183293305e9.21.2025.03.24.11.58.54
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 24 Mar 2025 11:58:55 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Hildenbrand <david@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Eric Farman <farman@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Zhao Liu <zhao1.liu@intel.com>, Eduardo Habkost <eduardo@habkost.net>,
 Yanan Wang <wangyanan55@huawei.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PATCH v3 3/7] target/ppc: Register CPUClass:list_cpus
Date: Mon, 24 Mar 2025 19:58:33 +0100
Message-ID: <20250324185837.46506-4-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250324185837.46506-1-philmd@linaro.org>
References: <20250324185837.46506-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

Register ppc_cpu_list() as CPUClass:list_cpus callback.
Reduce its scope and remove the cpu_list definition.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/ppc/cpu.h      | 4 ----
 target/ppc/cpu_init.c | 3 ++-
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index efab54a0683..0062579ef3e 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1597,8 +1597,6 @@ void ppc_store_dawrx1(CPUPPCState *env, uint32_t value);
 #endif /* !defined(CONFIG_USER_ONLY) */
 void ppc_store_msr(CPUPPCState *env, target_ulong value);
 
-void ppc_cpu_list(void);
-
 /* Time-base and decrementer management */
 uint64_t cpu_ppc_load_tbl(CPUPPCState *env);
 uint32_t cpu_ppc_load_tbu(CPUPPCState *env);
@@ -1660,8 +1658,6 @@ static inline uint64_t ppc_dump_gpr(CPUPPCState *env, int gprn)
 int ppc_dcr_read(ppc_dcr_t *dcr_env, int dcrn, uint32_t *valp);
 int ppc_dcr_write(ppc_dcr_t *dcr_env, int dcrn, uint32_t val);
 
-#define cpu_list ppc_cpu_list
-
 /* MMU modes definitions */
 #define MMU_USER_IDX 0
 static inline int ppc_env_mmu_index(CPUPPCState *env, bool ifetch)
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 8b590e7f17c..0ccb9068c89 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -7184,7 +7184,7 @@ static void ppc_cpu_list_entry(gpointer data, gpointer user_data)
     g_free(name);
 }
 
-void ppc_cpu_list(void)
+static void ppc_cpu_list(void)
 {
     GSList *list;
 
@@ -7525,6 +7525,7 @@ static void ppc_cpu_class_init(ObjectClass *oc, void *data)
                                        &pcc->parent_phases);
 
     cc->class_by_name = ppc_cpu_class_by_name;
+    cc->list_cpus = ppc_cpu_list;
     cc->mmu_index = ppc_cpu_mmu_index;
     cc->dump_state = ppc_cpu_dump_state;
     cc->set_pc = ppc_cpu_set_pc;
-- 
2.47.1


