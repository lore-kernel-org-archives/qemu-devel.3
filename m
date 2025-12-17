Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85004D66BA6
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Dec 2025 21:23:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVyxO-00009l-4C; Wed, 17 Dec 2025 16:21:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1vVyxL-0008Ut-5j
 for qemu-devel@nongnu.org; Wed, 17 Dec 2025 16:21:11 -0500
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1vVyxJ-0004dO-J3
 for qemu-devel@nongnu.org; Wed, 17 Dec 2025 16:21:10 -0500
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-34c84dc332cso4267185a91.0
 for <qemu-devel@nongnu.org>; Wed, 17 Dec 2025 13:21:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766006467; x=1766611267; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4ANPNEdMCjohC/SqbWuEPORpYMejuUnEzpSC6wthoj4=;
 b=ArkIQO8BcitG1puK5VNVftNQz8GV1GTT4zXgyavZK+RycCCDj1A5GIUfxtYaenX4ja
 EdnE7TVQbGcfmWOdsvYOJ5nYPehBh4Vw/pcJoEkAOAHvLqkV5jyD2pkuAiGBsdp5hZLp
 jEcaO0KkyG86SlufJaU/gd7I7fGOqywzqmGxc7omDjifX1XwGRlLIvf3poS5+3a1LL7g
 W2CvOmzY0a0vRYqlMlawfty0dt8GZIDCFYPSNH8o9h6eGlRzjWOsyp6vKJ9pSCh87ulA
 NaqdXHXJBI/ZytjWCT8kuyHstKnnhwWP5gmurnd4IyU39y6oJk/xEyI8yzMpV9T7GW+i
 o3Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766006467; x=1766611267;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4ANPNEdMCjohC/SqbWuEPORpYMejuUnEzpSC6wthoj4=;
 b=I9yoT8xgIGKH8tiKvQldrpFoBYMoHjiT5BqfOFiO0qhGolejd3eZ0WbVDs1G2ZOiBo
 9qlsEFdwZd/NSl1gnzqfGhvtXHR+L4ZfJwic957DD5mKKfgTyQdbG/NOtT36RdHFdAIj
 ZjDn8Q4H8hdI0AQyKUupNXfpLmgq/VdOLxbrq9ET9F1fYTuZlQrtWcukMPXaoj5LD4OC
 HExbkUgf0j20atp/xkoGbK0YiQb2emv7gHqVlMxk9usr1snTuRBbNYzG41Cn0MXWS1qC
 E8/XYAeELN6pMAZAkFmMJCeeEOLUvn2UkEQJa2RMfsEQHoIYn/5pKncPYDBb11uUNcid
 btXw==
X-Gm-Message-State: AOJu0Yw82WzQ+eCwxqGDH4BZrxnUHEwF1BgPPglKFxqWHqjTYPjfvN+Z
 i2fzfIow5fXvKPRn8gk/yOkdpLtvsWuqXc9gZazlEj90Kc4MOOyg5I7NUFFd5dpoJ58vQq8Rl9z
 UjeCL
X-Gm-Gg: AY/fxX7kPyBrb0bk6/Bd7MvUrwNKR12rHe0hQwrscfJAc+AtROuQ22NKNZSkzPQTynV
 pw3tC698Coaht4++v46Q0fKIuaNQi3dt4cdrgAwjnjUw47Qnb/ITgYp2QcOZcRyj4/Un6zHF+wO
 fX2qjFS1p2RMTR6+ONtk+2x23f0izsEbjFJvh5deIX6hIaD5PTzOS4smHLnux59ev18I9Dcc88t
 t7Rthlplq8hKtamSQOP5szZLs9uodhekwtSAfjYFyB9lGm+esZDfr86w+70tl9nPv1zNksMcGPy
 Iyg96wr3BWgh+XnCUHvjcnC1/cgQSPNqILIqqvDlhEvsbGv6SoBij9r9q7n8IMIgUCRHLkNVfvS
 EG+dXZ8iQS64BQK7c3/TL2d7JD022OyjfWDA8lcvgCO+90O7vq0Tll82hOFy5U9LyAaN20hdQ66
 QnPfVe+bmPI9wWENU=
X-Google-Smtp-Source: AGHT+IEIbgn0/kfIHH+oQnIQi9s/ItN1W3x5eycWesXz/1IC06oQt9pAOmIHYjpqnYNqn3lw4MtG3g==
X-Received: by 2002:a05:7022:7e84:b0:11f:2c69:32 with SMTP id
 a92af1059eb24-11f34bd9069mr13503187c88.7.1766006467089; 
 Wed, 17 Dec 2025 13:21:07 -0800 (PST)
Received: from gromero0.. ([191.8.216.160]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12061ef3383sm1852476c88.0.2025.12.17.13.21.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Dec 2025 13:21:06 -0800 (PST)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org, qemu-arm@nongnu.org, richard.henderson@linaro.org,
 alex.bennee@linaro.org, philmd@linaro.org, peter.maydell@linaro.org
Cc: gustavo.romero@linaro.org
Subject: [PATCH v2 5/6] system/physmem: Add cpu_address_space_init
Date: Wed, 17 Dec 2025 18:20:17 -0300
Message-Id: <20251217212018.93320-6-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251217212018.93320-1-gustavo.romero@linaro.org>
References: <20251217212018.93320-1-gustavo.romero@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pj1-x1029.google.com
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

Add cpu_address_space_init to enforce the invariant that cpu->num_ases
is set exactly once, preventing bypass of the Address Space API.

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
---
 include/exec/cpu-common.h | 19 ++++++++++++++++---
 system/physmem.c          |  8 ++++++++
 2 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index 126f645354..1ab63eac9f 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -101,6 +101,19 @@ int qemu_ram_get_fd(RAMBlock *rb);
 size_t qemu_ram_pagesize(RAMBlock *block);
 size_t qemu_ram_pagesize_largest(void);
 
+
+/**
+ * cpu_address_space_init:
+ * @cpu: CPU to init the number of address space(s)
+ * @num_ases: number of address space(s) in @cpu
+ *
+ * This function must be called before calling cpu_address_space_add and
+ * it sets the total number of address spaces that can be added to @cpu
+ * using cpu_address_space_add.
+ *
+ */
+void cpu_address_space_init(CPUState *cpu, int num_ases);
+
 /**
  * cpu_address_space_add:
  * @cpu: CPU to add this address space to
@@ -114,9 +127,9 @@ size_t qemu_ram_pagesize_largest(void);
  * The target-specific code which registers ASes is responsible
  * for defining what semantics address space 0, 1, 2, etc have.
  *
- * Before the first call to this function, the caller must set
- * cpu->num_ases to the total number of address spaces it needs
- * to support.
+ * Before the first call to this function, the caller must call
+ * cpu_address_space_init to set the total number of address
+ * spaces @cpu can support.
  *
  * Note that with KVM only one address space is supported.
  */
diff --git a/system/physmem.c b/system/physmem.c
index 4a0c1b74f1..2666dbc272 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -775,6 +775,14 @@ hwaddr memory_region_section_get_iotlb(CPUState *cpu,
 
 #endif /* CONFIG_TCG */
 
+void cpu_address_space_init(CPUState *cpu, int num_ases)
+{
+    assert(num_ases > 0);
+    assert(cpu->num_ases == 0);
+
+    cpu->num_ases = num_ases;
+}
+
 void cpu_address_space_add(CPUState *cpu, int asidx,
                            const char *prefix, MemoryRegion *mr)
 {
-- 
2.34.1


