Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D937BD31A0D
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Jan 2026 04:52:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfspB-0007je-Em; Tue, 13 Jan 2026 23:49:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1vfsox-0007E2-S3
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 23:49:28 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1vfsow-0004Ci-BO
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 23:49:27 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2a102494058so2248745ad.0
 for <qemu-devel@nongnu.org>; Tue, 13 Jan 2026 20:49:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768366164; x=1768970964; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e4RKJkMMFPN4YQUEajOwFLoOkui52htamyphMm0OHOM=;
 b=HK9h24Y2e38E6A/bwYlPfrKHdsgujDY/k5p6/oInBEtwdnc6AYyPFvGH37qy0w1Jt9
 bYRjqWVn2HajkE+Tce/fb8IrvFeFRNo0uNr9/oQdk4QywilJSrHYrGI/uKdVzRLW297Q
 WjNuieWJl+JWvZUYIr/BFu+BzWfCus1C6bPnBihBOpR0q30x1Engsf7LQHz+FPtMkLOu
 31sz/sa0ndjLEzcyyRP9RvuiC0flLidTCsLFydlD28XR6EQu8u6CMUvInDbitp6xhgdL
 P3Gb81owPk+UNbVWW6CwfbvsoT+61cDz6Hjlzak+ZZgnhkjl1tp4ofTHAJPR+atIllR9
 6L5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768366164; x=1768970964;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=e4RKJkMMFPN4YQUEajOwFLoOkui52htamyphMm0OHOM=;
 b=FGNZxlYb8WgiPZIAaRXVoVx9GjSaW0oyzCkW/rJbDM15+coQedH515Ksutxy4GB1HE
 WL/+XermJsgaqqJ9YewaLhDFjOFD1sbK1yoJNkqCvYdIkrDjBHnmpExHJqCVpovrU/Hk
 1NNGymCkp8E3BfEBkQdfCUwPksoGNnLqrxpj0x0Qn2QP9QkmDdoE/Hhp9CD2U1rIpbaH
 AEni7Z1yLUBXeC+WO2t2VHdyByBtUs4pL6tH5GLJjxW2OLHi0VZTiMlxuhxXLD3MVuC/
 rYyu4v+jomqGcMmSAQ0AlKMMNjzHdsKpiE35e54lp8YLDjoUwl5j+yVkIl+rx5RrTQKp
 XSQw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWbOVkah4JCvKMlQ6wFoMLLqPuEtOtw8VTlcl7fzBlvFK/bQxWegvnM5XRU/0BuCx6tM7NQNu5IAi0+@nongnu.org
X-Gm-Message-State: AOJu0YwvMcrNTw/CkPBJQaRrulj5wPuuZbOmveGRJ0FfwMCDA5UDIAkB
 FlRM75NbPcYV3bTOA9WwRQgOpHGVgNGge53RUrUCaIGArck8XDkkggYd
X-Gm-Gg: AY/fxX5qwF0o4/6jbDVQeaI7r7A3LXTNndeQG5CyCQHwbhR7C7Dz1Efrac/7xWk/hEf
 scc4aTbzSMsnJT1fGwohT95szCUtYUqDnNqpygiB1soONMI2yiEWFz0H06Jm8lp5pPxcVtmusFb
 9UzOHY20QIV4BD21aXRmy2cR5WX9TH6tlGEboPXvqtpyk70fKGOhGK1qJqbcWp8h7NFDl1K5Ntt
 vEDu5f+BTD6qp0odIho7hphj4Qv8lJI9/9ZEh4BbkgBW6xY+mCSgZMaP9FtTWTPtWCj5anlIa9e
 gIcXyNMlmPHPV/epT/fKjyONcwghzGPKOL+Y9bVkBBMWWveuKOB96bhZZs+CB9busONqe4DJwBs
 lli1B6cvOD7+oIlghjr8tH1ACtlCdYvlOemogfXatj2EBSV1c6w54SDD9ueKeqmATkjSvxni1OY
 vN+XBNRQcTVrVLyuM0qfCdHZg1mOQD877qQlcNs374GePVDsIH2rZMy4Fj0SWhcAfyd4Wxsg==
X-Received: by 2002:a17:903:46c4:b0:2a0:b432:4a6 with SMTP id
 d9443c01a7336-2a599df90edmr17867225ad.15.1768366164274; 
 Tue, 13 Jan 2026 20:49:24 -0800 (PST)
Received: from lima-default (123.253.188.110.qld.leaptel.network.
 [123.253.188.110]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a3e3c49037sm216111905ad.36.2026.01.13.20.49.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jan 2026 20:49:23 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, bin.meng@windriver.com,
 vivahavey@gmail.com, Alvin Chang <alvinga@andestech.com>,
 Yu-Ming Chang <yumin686@andestech.com>, Joel Stanley <joel@jms.id.au>
Subject: [RFC PATCH 24/25] target/riscv/debug: Emulate TT Ascalon Sdtrig
Date: Wed, 14 Jan 2026 14:46:57 +1000
Message-ID: <20260114044701.1173347-25-npiggin@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260114044701.1173347-1-npiggin@gmail.com>
References: <20260114044701.1173347-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x632.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This adds initial Tenstorrent Ascalon Sdtrig implementation details.
Ascalon has 9 triggers: 4 mcontrol6 triggers that can match exec access,
4 mcontrol6 triggers that can match load / store access, and 1 icount
trigger.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/riscv/cpu.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index d349457c87..bdc33bb746 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -2972,6 +2972,28 @@ static const RISCVSdtrigConfig default_sdtrig_config = {
     },
 };
 
+#if defined(TARGET_RISCV64)
+static const RISCVSdtrigConfig tt_ascalon_sdtrig_config = {
+    .nr_triggers = 9,
+    .triggers = {
+        [0 ... 3] = {
+            .type_mask = (1 << TRIGGER_TYPE_AD_MATCH6) |
+                         (1 << TRIGGER_TYPE_UNAVAIL),
+            .mcontrol_rwx_mask = 0x4, /* BP */
+        },
+        [4 ... 7] = {
+            .type_mask = (1 << TRIGGER_TYPE_AD_MATCH6) |
+                         (1 << TRIGGER_TYPE_UNAVAIL),
+            .mcontrol_rwx_mask = 0x3, /* WP */
+        },
+        [8]       = {
+            .type_mask = (1 << TRIGGER_TYPE_INST_CNT) |
+                         (1 << TRIGGER_TYPE_UNAVAIL),
+        },
+    },
+};
+#endif
+
 bool riscv_sdtrig_default_implementation(const RISCVSdtrigConfig *config)
 {
     return config == &default_sdtrig_config;
@@ -3166,6 +3188,9 @@ static const TypeInfo riscv_cpu_type_infos[] = {
         .misa_ext = RVG | RVC | RVS | RVU | RVH | RVV,
         .priv_spec = PRIV_VERSION_1_13_0,
         .vext_spec = VEXT_VERSION_1_00_0,
+#if !defined(CONFIG_USER_ONLY)
+        .debug_cfg = &tt_ascalon_sdtrig_config,
+#endif
 
         /* ISA extensions */
         .cfg.mmu = true,
-- 
2.51.0


