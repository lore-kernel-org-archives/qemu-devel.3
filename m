Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80285C28B30
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Mar 2025 22:42:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twTzx-0005z5-RB; Sun, 23 Mar 2025 18:40:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1twTzw-0005yf-N5
 for qemu-devel@nongnu.org; Sun, 23 Mar 2025 18:40:52 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1twTzt-00069x-NA
 for qemu-devel@nongnu.org; Sun, 23 Mar 2025 18:40:52 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-43cf06eabdaso35384315e9.2
 for <qemu-devel@nongnu.org>; Sun, 23 Mar 2025 15:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742769648; x=1743374448; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZmDLsaOdc04ruhix/U5gYX9i3TxolNL0TznRXmkTJYc=;
 b=u8tUT9R/qM4a+5Rmv+ZyQECWIJcNvO+/QgV6U3jUQBP1UxvrQjxcPJOhzOA5tl4Kkj
 euH7QWm8gl9/qLtqKrQmAOdywj2f9Iyp6E9Z8xZNxvHBob/SeiOYJ/lXkEnGu+DuaicE
 OFVElRFF4CZal+ZXtGvCn2HukbbxWqtD+elFIZR43jv5zcsJCWiO/IwqK/Ac00CVtxgW
 +8hfnm4g9DeXN+GVmnmUlH8j4592Cp9wu6l0iR8L9sfDoAhrWz91sbAIVerstCzEsv33
 /dCqyuet4Z/wvdivZoIYy8uVLn6xrRIYcyrvCg7YGmZAufqSI5lTtO2C3/6o4LMvWFjm
 6ZWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742769648; x=1743374448;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZmDLsaOdc04ruhix/U5gYX9i3TxolNL0TznRXmkTJYc=;
 b=A76Xp0rd+wRpWW5KULJgHY2TEIy6BJ5EO0s7jbfk3ISzWFuaIc4cKrc/ZB4bULUvpY
 VqbHc2GIqPDjkA2DpORrs8krOA35mTH4Ngb7aM2U6SDEKrgHlsJzGo0IG/GTkuuAKgpV
 T1SUSu8ctdGB2c0ZP+O//LohC84FSMJf/TNm11SYVbmu2hc1KsI2Go7NawDXjTAQ1+Ze
 se2AoQTNb3yve6eUIjayh3IoiFmHNTSFEivACcglnehv4U7Vo3mpuqK4QeYP+OCOV6mD
 Z9NJnqC09lE2mc0FZmODlFcn+gDeYNxHOWQyXIPjWGqbi+TA9dMBGZuFdLnqszskUqZr
 /nxQ==
X-Gm-Message-State: AOJu0Yz8RBqs4VnQ6TqZyKYkYij0PkgNzf53TB4YtkhpSE3VlP86t5XM
 7mAtsRd65D/a6Ze9rYg+sDEuTvR4zecKXJs8qaiVcEHAvHOBVAsVXpXhsl7764rxHo6XGSF5WrO
 u
X-Gm-Gg: ASbGnctFBNeuXRa5Lfs+Nc9C5OeOp6BQW/Ho/iJbO1/D3U6QYM5XgYqLKI4ZSjOqbmX
 h+lAmRZxV4KbViE10nMafHKfPSk8FtMS5MIRtyknQWGFhaXijiPQ+QtbvyTiBKYfhMjm3dgv3d3
 0XmfmZ+CdgmsCj4P+HUs3n48UAADAUCXEwpT7J4rQ7mjFS8tezVLC8j7XKsaaetl98Ao5yhcxeM
 BstLq7eW9xSlyhpKX8OJg6e4anoNe3WGVexHZa+yeuwCCkNbr8A9KgIMXotoaeQgcvx3XDxm4w3
 q7lVUHcugdU+cUDnY/184Fy16RlPtZ6omfV5WthTxckHzvQ1oIbi51/tlBL+MwFJXQiSlSYlXzN
 5x6M0a38TfGiNXor6kYSailr1
X-Google-Smtp-Source: AGHT+IFvcP7ypu5CUz1neqAdFZu7HYZVYYz35GwT9ZxpgVEhiRaySxRa4am+20mgwMgEDUJ/eQ8i+A==
X-Received: by 2002:a05:600c:4695:b0:43c:f75a:eb54 with SMTP id
 5b1f17b1804b1-43d50a0a023mr93935705e9.13.1742769647766; 
 Sun, 23 Mar 2025 15:40:47 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d43f55c3dsm151982885e9.23.2025.03.23.15.40.46
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 23 Mar 2025 15:40:47 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-s390x@nongnu.org,
 Artyom Tarasenko <atar4qemu@gmail.com>, Thomas Huth <thuth@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-10.1 2/6] target/i386: Register CPUClass:list_cpus
Date: Sun, 23 Mar 2025 23:40:31 +0100
Message-ID: <20250323224035.34698-3-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250323224035.34698-1-philmd@linaro.org>
References: <20250323224035.34698-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

Register x86_cpu_list() as CPUClass:list_cpus callback.
Reduce its scope and remove the cpu_list definition.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/i386/cpu.h | 3 ---
 target/i386/cpu.c | 3 ++-
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 76f24446a55..28011eff0a8 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2367,7 +2367,6 @@ int x86_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
 int x86_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
 void x86_cpu_gdb_init(CPUState *cs);
 
-void x86_cpu_list(void);
 int cpu_x86_support_mca_broadcast(CPUX86State *env);
 
 #ifndef CONFIG_USER_ONLY
@@ -2561,8 +2560,6 @@ uint64_t cpu_get_tsc(CPUX86State *env);
 #define TARGET_DEFAULT_CPU_TYPE X86_CPU_TYPE_NAME("qemu32")
 #endif
 
-#define cpu_list x86_cpu_list
-
 /* MMU modes definitions */
 #define MMU_KSMAP64_IDX    0
 #define MMU_KSMAP32_IDX    1
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 1b64ceaaba4..1f502587c96 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -6305,7 +6305,7 @@ static void x86_cpu_list_entry(gpointer data, gpointer user_data)
 }
 
 /* list available CPU models and flags */
-void x86_cpu_list(void)
+static void x86_cpu_list(void)
 {
     int i, j;
     GSList *list;
@@ -8924,6 +8924,7 @@ static void x86_cpu_common_class_init(ObjectClass *oc, void *data)
     cc->reset_dump_flags = CPU_DUMP_FPU | CPU_DUMP_CCOP;
 
     cc->class_by_name = x86_cpu_class_by_name;
+    cc->list_cpus = x86_cpu_list;
     cc->parse_features = x86_cpu_parse_featurestr;
     cc->mmu_index = x86_cpu_mmu_index;
     cc->dump_state = x86_cpu_dump_state;
-- 
2.47.1


