Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2941BC61CE8
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Jun 2025 22:52:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOOri-00058N-Qq; Sun, 08 Jun 2025 18:51:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1uOOrf-00057U-7G
 for qemu-devel@nongnu.org; Sun, 08 Jun 2025 18:51:43 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1uOOrc-000309-J8
 for qemu-devel@nongnu.org; Sun, 08 Jun 2025 18:51:41 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-3122a63201bso3010341a91.0
 for <qemu-devel@nongnu.org>; Sun, 08 Jun 2025 15:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749423099; x=1750027899; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1ysiNB3jN3pm4xSzw9lWbP2QG1HmR4QbzZmy+B07iUo=;
 b=Mff03rR9YNiOaZ38fYrFVTjmoOR450PIz0tXmQLV4hiFVbfODJqIfLFtJay81D7oCX
 vBOlOZYzJAekoNQ3LTbzBU3WuqrdfPMJJxVALxicjLunZwKUpGfub92mPUWeDpApDYDR
 xpqrHueCLt638nBVI0pZT2Wt6el8hSaxSm16i8t25+2a4nDbJ2VOr0B+/o6HGrKyqIPd
 YPNRb7CyFsfqtJa+DzaFXC+JtzndIK7659KB55UujDK9u7U57xGvpMV5cbeU8N0d6PF7
 QMvhP499a5U2I5tvdq3aRwgJEKtKaPI+txjlMHCnE6jGhLLOdmc9arp0iWjiNVvAAQ8O
 bWBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749423099; x=1750027899;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1ysiNB3jN3pm4xSzw9lWbP2QG1HmR4QbzZmy+B07iUo=;
 b=U5DQ6cfUuXbJEvcuabE4Z7geZ6GyTEwKpNjmhH1iD4MQCuBvtzIbEMPN5vNqHIPswL
 uI/5iGBoSWxQDep5wnpa6S5nh4cIiBqawgApjnoLOdY+6ko1SRO5sH73SacUG8IBi+go
 CownZ1n2mUhT7qoKbxRhMAZrSq0CQmpMkToVxz+3s67Q57Kf/6dOUSpLB9YOaUyCVdQx
 VJGtCBDO0SzUEo1NbnhSuPrSX8gigDsczm4RMYFQ2fzcSG5v0BfAIFKBw7F+zodle6vY
 4xOUmWAWKRx3U+ceTLbihwpPgnaTa4qmkXZ2RkVCfKJGbPKfZlXmY+aPoOOinAvLR61u
 rmAQ==
X-Gm-Message-State: AOJu0YwPMf8SjNagzheWetBu4kdRt+IcGHoBpXaXiOLVsxjMKw8CJkLB
 qDFIOLRoFg01sUgIfriG2OuoalLtt73fMwu2FR017pFAv4oCTj9agfWQF1IwuTi8Cqk=
X-Gm-Gg: ASbGncsW8HUXSlNuTZFjai7gurtEkp4ug+pTP89CecGdIXnlP18M/7YRHCgEeOaraQL
 yHCEcURgQmlI9HBUJHH05FnHAw9jpod9/fDQcHM+x4xfaY+mbxjR2Qd3I/ke/BMpcNlQ+ZfUDwy
 Hltkj4753ViKC+BiSwK7Hk+9yU1l9Zn/UwkQl8RWOpSotAfmf6uEumLCSiu9nO3IC9/ZtJYdcpC
 kGgDbBWmc2zg/3uphSdiaO2hXmEd3CJ6kX+iDQLinOmz8N2JoDqotW0tOHPjLCRJ/TEjbvLtPaX
 LHQxoJj1xK1q9yJGgCwkG12FmEh+mIrWQg6XVXj2o6JgYxDxvSI=
X-Google-Smtp-Source: AGHT+IErVpP7YaBcze7lzkII2h36SlBlCu955KhO1nGI2Svwwj8WL4Yx/zmGM/+Ba+foGtVvWtzw+Q==
X-Received: by 2002:a17:90b:1d87:b0:312:2bb:aa89 with SMTP id
 98e67ed59e1d1-3134740ba49mr15153408a91.20.1749423098855; 
 Sun, 08 Jun 2025 15:51:38 -0700 (PDT)
Received: from shemhazi.lan ([50.46.174.34]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3134b128012sm4395970a91.32.2025.06.08.15.51.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Jun 2025 15:51:38 -0700 (PDT)
From: Rowan Hart <rowanbhart@gmail.com>
To: qemu-devel@nongnu.org
Cc: Yanan Wang <wangyanan55@huawei.com>, Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Zhao Liu <zhao1.liu@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, novafacing <rowanbhart@gmail.com>,
 Julian Ganz <neither@nut.email>
Subject: [PATCH v8 1/9] gdbstub: Expose gdb_write_register function to
 consumers of gdbstub
Date: Sun,  8 Jun 2025 15:51:28 -0700
Message-ID: <20250608225136.3340370-2-rowanbhart@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250608225136.3340370-1-rowanbhart@gmail.com>
References: <20250608225136.3340370-1-rowanbhart@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=rowanbhart@gmail.com; helo=mail-pj1-x1031.google.com
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

From: novafacing <rowanbhart@gmail.com>

This patch exposes the gdb_write_register function from
gdbstub/gdbstub.c via the exec/gdbstub.h header file to support use in
plugins to write register contents.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Julian Ganz <neither@nut.email>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Rowan Hart <rowanbhart@gmail.com>
---
 gdbstub/gdbstub.c      |  2 +-
 include/exec/gdbstub.h | 14 ++++++++++++++
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
index 565f6b33a9..5846e481be 100644
--- a/gdbstub/gdbstub.c
+++ b/gdbstub/gdbstub.c
@@ -534,7 +534,7 @@ int gdb_read_register(CPUState *cpu, GByteArray *buf, int reg)
     return 0;
 }
 
-static int gdb_write_register(CPUState *cpu, uint8_t *mem_buf, int reg)
+int gdb_write_register(CPUState *cpu, uint8_t *mem_buf, int reg)
 {
     GDBRegisterState *r;
 
diff --git a/include/exec/gdbstub.h b/include/exec/gdbstub.h
index 0675b0b646..a16c0051ce 100644
--- a/include/exec/gdbstub.h
+++ b/include/exec/gdbstub.h
@@ -124,6 +124,20 @@ const GDBFeature *gdb_find_static_feature(const char *xmlname);
  */
 int gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
 
+/**
+ * gdb_write_register() - Write a register associated with a CPU.
+ * @cpu: The CPU associated with the register.
+ * @buf: The buffer that the register contents will be set to.
+ * @reg: The register's number returned by gdb_find_feature_register().
+ *
+ * The size of @buf must be at least the size of the register being
+ * written.
+ *
+ * Return: The number of written bytes, or 0 if an error occurred (for
+ * example, an unknown register was provided).
+ */
+int gdb_write_register(CPUState *cpu, uint8_t *mem_buf, int reg);
+
 /**
  * typedef GDBRegDesc - a register description from gdbstub
  */
-- 
2.49.0


