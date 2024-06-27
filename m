Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8C6FC2BD09
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 10:04:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMlxk-0007Mu-7U; Thu, 27 Jun 2024 06:02:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sMlxY-00073c-Oa
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 06:02:33 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sMlxX-0002Db-3g
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 06:02:32 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-70679845d69so3371140b3a.1
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 03:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719482549; x=1720087349; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AnEaxExSxNmbwr/9W4/pvVWPb9oM7FgPkjyis6ytKNc=;
 b=biI5mAMqkRWZaNfd1jCBIwTbacjhZUhpR6QZFwSUaxxo6WHX2v8kVoVtTRl7NstTZd
 gVs9PhFSywjWjIsZ7YFmoocjWFsrGAGPMo7tajPWIXDVFE/hk3vZlZ0OWguQmY1Svbvj
 N1sWsQKPXWvwaBXbr0O8qu7PeL+H5G5/KCB6adzb6crrV9iidQWlCeftolMtsOZBVgOF
 M6zvGJe3GJ2F3IaaXYuBxmPcvaqh00vPJP6sz2AWK9O9RfnViiQ/0DBoSgM+EyJHfqpz
 bYq59I+JTWK0lN6BR0bN5734ke/LJBJPR0K6/GyhsfOLC6hDM33x/KwSrIM1jsuiXiKN
 AgIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719482549; x=1720087349;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AnEaxExSxNmbwr/9W4/pvVWPb9oM7FgPkjyis6ytKNc=;
 b=Pyh5MrdDzQS23exAuAKh2WsYyWABpiNW96PxkMZc9xM+tmny3LEAFLAfRhZnOLgPLE
 sIFQQOjj58M8UI/vQ+KN+cHrEcnFomfWJo0IACnfetOULP2i3q5TYkJSvIVU5BJ0af6O
 vtdzB32VbiXbdzkxnmi9enpW18M6B7ELoEBuDNjVQaWp4lMqQpTzKJOsG5ImzASMSNpE
 aP/pYh9DD8tDTAX3qOZsPuPUaVRNCeGgZo2wLJxsut4miP98dYt+Y5lePTvWhuEwmp/W
 jf7F6WTSHpYJgCGH3WN7pt27TL4RVbZ3k5Nk20QRaxi3Zo6fXD56vQEdUrdcPI19aU+t
 L3Kg==
X-Gm-Message-State: AOJu0YwANfCzHw8gg1iam8QY+Rx9DDSzlrdJxI+2ce3vsU5TdFmwqJmv
 316XgPLpftrWbwyIyfjdTEgKOCF4sZjdVXA0TVe0dT3d3ujL8IPvF8D1ubmH
X-Google-Smtp-Source: AGHT+IHtqf5Txsppm8q8DMszDbNclDzwwb1/Hc2PWeJNHIaTPYrKAIPIU/AD7wgGseGslDKWqnAPOA==
X-Received: by 2002:aa7:8611:0:b0:706:375e:220d with SMTP id
 d2e1a72fcca58-706746fa56cmr12021869b3a.30.1719482549185; 
 Thu, 27 Jun 2024 03:02:29 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-706b4a07326sm932431b3a.111.2024.06.27.03.02.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Jun 2024 03:02:28 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Frank Chang <frank.chang@sifive.com>,
 Jerry Zhang Jian <jerry.zhangjian@sifive.com>,
 Max Chou <max.chou@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PULL 26/32] target/riscv: Add MISA extension implied rules
Date: Thu, 27 Jun 2024 20:00:47 +1000
Message-ID: <20240627100053.150937-27-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240627100053.150937-1-alistair.francis@wdc.com>
References: <20240627100053.150937-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x434.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Frank Chang <frank.chang@sifive.com>

Add MISA extension implied rules to enable the implied extensions
of MISA recursively.

Signed-off-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Jerry Zhang Jian <jerry.zhangjian@sifive.com>
Tested-by: Max Chou <max.chou@sifive.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Message-ID: <20240625114629.27793-4-frank.chang@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 50 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 49 insertions(+), 1 deletion(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 7b071ade04..b463bd8370 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -2250,8 +2250,56 @@ RISCVCPUProfile *riscv_profiles[] = {
     NULL,
 };
 
+static RISCVCPUImpliedExtsRule RVA_IMPLIED = {
+    .is_misa = true,
+    .ext = RVA,
+    .implied_multi_exts = {
+        CPU_CFG_OFFSET(ext_zalrsc), CPU_CFG_OFFSET(ext_zaamo),
+
+        RISCV_IMPLIED_EXTS_RULE_END
+    },
+};
+
+static RISCVCPUImpliedExtsRule RVD_IMPLIED = {
+    .is_misa = true,
+    .ext = RVD,
+    .implied_misa_exts = RVF,
+    .implied_multi_exts = { RISCV_IMPLIED_EXTS_RULE_END },
+};
+
+static RISCVCPUImpliedExtsRule RVF_IMPLIED = {
+    .is_misa = true,
+    .ext = RVF,
+    .implied_multi_exts = {
+        CPU_CFG_OFFSET(ext_zicsr),
+
+        RISCV_IMPLIED_EXTS_RULE_END
+    },
+};
+
+static RISCVCPUImpliedExtsRule RVM_IMPLIED = {
+    .is_misa = true,
+    .ext = RVM,
+    .implied_multi_exts = {
+        CPU_CFG_OFFSET(ext_zmmul),
+
+        RISCV_IMPLIED_EXTS_RULE_END
+    },
+};
+
+static RISCVCPUImpliedExtsRule RVV_IMPLIED = {
+    .is_misa = true,
+    .ext = RVV,
+    .implied_multi_exts = {
+        CPU_CFG_OFFSET(ext_zve64d),
+
+        RISCV_IMPLIED_EXTS_RULE_END
+    },
+};
+
 RISCVCPUImpliedExtsRule *riscv_misa_ext_implied_rules[] = {
-    NULL
+    &RVA_IMPLIED, &RVD_IMPLIED, &RVF_IMPLIED,
+    &RVM_IMPLIED, &RVV_IMPLIED, NULL
 };
 
 RISCVCPUImpliedExtsRule *riscv_multi_ext_implied_rules[] = {
-- 
2.45.2


