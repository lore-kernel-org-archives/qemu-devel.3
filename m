Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59478C3ABAD
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 21:28:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAbPl-0007am-UT; Thu, 01 May 2025 17:25:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAbOq-0004np-WA
 for qemu-devel@nongnu.org; Thu, 01 May 2025 17:24:57 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAbOo-0002Cl-RT
 for qemu-devel@nongnu.org; Thu, 01 May 2025 17:24:56 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-af589091049so1078466a12.1
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 14:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746134693; x=1746739493; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SSbFpFjMPZ364OnkhpeAl/6b8u/xx6/tSoMMKW2aIxw=;
 b=MRr+wVn9Tl8I8uO8Aw57u0lPq2rgojaVKllBsBDrXowEj/4sFTBV7rnygv3lF+X5qO
 K56k1jbv3mIXQUgV3AqU5YVQw3BDJf1/rEZ2xojvNMnZVr7Eq7vAmRxXywRfG5PNa7d6
 xvyTgkE/PBqz/e6QnvMXUkDpEDeFA5K6qAq9OVZ7vUU9KiejgCWQv8ZTrablsAwfCIlF
 VQL6fTEzrw9d3iEfgqcdxzqP09GPzPQ42nZOXPEJ9SRJ67T2jX4kEyallTrO10bEfmLL
 Y1oTvEWjs8hcMPU0mD0ezCNX7Y+Z/gHw170z//MW0SlghpC5UbloU4Amm0Evduvoncn1
 DBiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746134693; x=1746739493;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SSbFpFjMPZ364OnkhpeAl/6b8u/xx6/tSoMMKW2aIxw=;
 b=dJW3NNfL/ANFkLYS1suztdrTWu2RRdTIMMKuJEamL5hFHVkOV9I4PJpAA+bCNuLiCP
 o2GtM96XAmiWIDjMnFKN2SNe6DMXJLdEDHlmBIHnILJpX3YSZrV+J4QqKHS8+rjS/PoE
 LLXalI3JR6eOKY5Z/EF5fk4tDqC8oLdlWF15ZXMVH/4U9ixETFb1dltbvfPXKU+ceRmY
 0ggoZ8rPIzlA5JgmjHQ/SnaVp6w4wn2jtx5VXS0p49oink0O0YPSgb5eJ6Ic55uNlZYZ
 Ky6WQMZMB54sH90NOWOrqYnwwOUSS2d94xd/hB3GbZGKeS+V4EZezc2ghgy05uhjmNs/
 Afsw==
X-Gm-Message-State: AOJu0YwrQ8625GnVdHWW2WrqZU10Pj3JsQEF5EFht57Xgz8WEE3k5HBs
 lP6Vv9Chr4OW/NRoJeQCnQ8LJHPWEoIUQi2SNWxNlazKQtxsacer5M6nzgDEkWBXQZMDZTBYfzy
 a
X-Gm-Gg: ASbGncvnZafs9sj+CFU3bDcNwBNi+A2mSOXk1WgMD6PSgeCqfRHRLaeFkMNqICGT4Z4
 SQQrlfVWlWhWZ19j0JAK+GkWBn6oSCXhQbd1KgYQWLur4lWJGjRgNwyOD522puUnTCKaWSvqbqJ
 T/ys02hQHSQoojm9UT2Z84sxS073pcc59i8yh9Y4vedzKo408f8AfJp8chKeYW1SHKaDY7wkD6l
 CrX5nhzB+8IatCPTZ9FO6FTXYDHcr+cIXvBBQMtdTtXAIvromgFTqC1z13RNx17UeRxS1lsgAYK
 uDPaLvWhM6pqBmrTSGpB6Pl68jwEDuVKbpm7SjtnSq7qJ3Yzeay+wgHIe0vvUy0ZxfiaES/IFHE
 =
X-Google-Smtp-Source: AGHT+IFcuVBoYG5HGRNf6eKJY0gPF7xPhGBG1OQas0wJlPh46gmwzS/URQP25Xrud1qO3eWORYSJdA==
X-Received: by 2002:a05:6a20:2d09:b0:1f3:3ca3:8216 with SMTP id
 adf61e73a8af0-20cde373fb1mr587043637.5.1746134693143; 
 Thu, 01 May 2025 14:24:53 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-740590610desm135897b3a.146.2025.05.01.14.24.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 May 2025 14:24:52 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 49/59] accel/tcg: Move user-only tlb_vaddr_to_host out of line
Date: Thu,  1 May 2025 14:21:03 -0700
Message-ID: <20250501212113.2961531-50-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250501212113.2961531-1-richard.henderson@linaro.org>
References: <20250501212113.2961531-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52a.google.com
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

At the same time, fix a mis-match between user and system
by using vaddr not abi_ptr for the address parameter.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/accel/tcg/cpu-ldst.h | 8 --------
 accel/tcg/user-exec.c        | 6 ++++++
 2 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/include/accel/tcg/cpu-ldst.h b/include/accel/tcg/cpu-ldst.h
index 44a62b54da..00e6419e13 100644
--- a/include/accel/tcg/cpu-ldst.h
+++ b/include/accel/tcg/cpu-ldst.h
@@ -515,15 +515,7 @@ static inline uint64_t cpu_ldq_code(CPUArchState *env, abi_ptr addr)
  * Otherwise (TLB entry is for an I/O access, guest software
  * TLB fill required, etc) return NULL.
  */
-#ifdef CONFIG_USER_ONLY
-static inline void *tlb_vaddr_to_host(CPUArchState *env, abi_ptr addr,
-                                      MMUAccessType access_type, int mmu_idx)
-{
-    return g2h(env_cpu(env), addr);
-}
-#else
 void *tlb_vaddr_to_host(CPUArchState *env, vaddr addr,
                         MMUAccessType access_type, int mmu_idx);
-#endif
 
 #endif /* ACCEL_TCG_CPU_LDST_H */
diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index e1f4c4eacf..adc5296ba5 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -850,6 +850,12 @@ void *probe_access(CPUArchState *env, vaddr addr, int size,
     return size ? g2h(env_cpu(env), addr) : NULL;
 }
 
+void *tlb_vaddr_to_host(CPUArchState *env, vaddr addr,
+                        MMUAccessType access_type, int mmu_idx)
+{
+    return g2h(env_cpu(env), addr);
+}
+
 tb_page_addr_t get_page_addr_code_hostp(CPUArchState *env, vaddr addr,
                                         void **hostp)
 {
-- 
2.43.0


