Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DACDCF3198
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2024 05:54:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svsH3-0005gA-Pp; Wed, 02 Oct 2024 01:51:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1svsGw-0005cz-9J
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 01:51:39 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1svsGt-0004rJ-Rc
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 01:51:37 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-20b5fb2e89dso26945105ad.1
 for <qemu-devel@nongnu.org>; Tue, 01 Oct 2024 22:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727848289; x=1728453089; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5RIOzm4lkzh87fU69aA3iB31/8CVTzFLgwHNOCk9DI4=;
 b=COM+cuIoUoutgHfhS4e2w0s4j4CpaASk5MV+gwiIGl256rabcPQa3gKwS3H/UTCOPh
 lKBtx9vdpPaeksfkHQuz9a+pb1A/IzRVJFcLm4Uexq2nsGGPs2K0RMgaLXe+AmAqmB92
 0j7HP4wXpzCaf7KddX83fopfWZFa+S6mUrHoS7caX6JmJFdMA4VL48BQAlsJBPyEEfvu
 TGPzjZns3chzzdGNl8DXSHXyeIBNoYHhX7lwsuIBfqdcK+PHr+tQJlBRQudwqfmDbLKO
 MXwod4Zs8/VKFnRXfECJPC5pKrWQsXJ8fzGq4FtmuDs/mY2qeTRBBX7XaOZB0zEnRzoj
 VH5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727848289; x=1728453089;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5RIOzm4lkzh87fU69aA3iB31/8CVTzFLgwHNOCk9DI4=;
 b=EITE7IrkjuJOmoiN8vDAcjKys6ZJapNsA63vbkS3jSP+wMS25GjjQfWsy8xtE/niIW
 2R0x4iL0dOrhgrNvgAy6gKG3KIbK1aQVU7DYLR8IoYggRKDcJAiQdgjKwbzZ5qGWCTCD
 aq71ugANW4P13sE4GpB0z9cDfiXM1tZaq/oX9RBX3HDqTf36tCq3bX8jY0HAc489A/Wx
 nxo5rzpLG3G6b/I3qUG9yJRX+b+5j6W7eUP0ky6cmpS9ftDb0CnufQd4FRvfybVZvU/g
 bpvoGcdyB6cwxxfOeMm7inPLZmQZJt3op6Y0py7YKzzDT058FBY5LXTZaZqXharmtlyo
 HGug==
X-Gm-Message-State: AOJu0Yyaw9RIhM7kABvr6vBWioGgfpwFFJnPfynP9dV+LYmlDAgQiSFL
 dsXEKy0L4QGQN220VCTtVo2Xgy+WxhU/dPndVFqVSudAMMpBGlyvhytaCe6z
X-Google-Smtp-Source: AGHT+IHQP/l8BdOp6U5qIaMQmfjdbEzoNw2l1B1s8v7Yh8Fcl+tgNnE11Udue5a1ADlWhbYQoZfInA==
X-Received: by 2002:a17:903:1105:b0:20b:a576:1896 with SMTP id
 d9443c01a7336-20bc5a5dc02mr27688965ad.43.1727848288758; 
 Tue, 01 Oct 2024 22:51:28 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20b37e60c76sm78324235ad.269.2024.10.01.22.51.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Oct 2024 22:51:28 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Maria Klauchek <m.klauchek@syntacore.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v3 10/35] target/riscv/cpu.c: Add 'fcsr' register to QEMU log
 as a part of F extension
Date: Wed,  2 Oct 2024 15:50:23 +1000
Message-ID: <20241002055048.556083-11-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241002055048.556083-1-alistair.francis@wdc.com>
References: <20241002055048.556083-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62c.google.com
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

From: Maria Klauchek <m.klauchek@syntacore.com>

FCSR is a part of F extension. Print it to log if FPU option is enabled.

Signed-off-by: Maria Klauchek <m.klauchek@syntacore.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20240902103433.18424-1-m.klauchek@syntacore.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index a1ca12077f..89bc3955ee 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -823,6 +823,12 @@ static void riscv_cpu_dump_state(CPUState *cs, FILE *f, int flags)
         }
     }
     if (flags & CPU_DUMP_FPU) {
+        target_ulong val = 0;
+        RISCVException res = riscv_csrrw_debug(env, CSR_FCSR, &val, 0, 0);
+        if (res == RISCV_EXCP_NONE) {
+            qemu_fprintf(f, " %-8s " TARGET_FMT_lx "\n",
+                    csr_ops[CSR_FCSR].name, val);
+        }
         for (i = 0; i < 32; i++) {
             qemu_fprintf(f, " %-8s %016" PRIx64,
                          riscv_fpr_regnames[i], env->fpr[i]);
-- 
2.46.2


