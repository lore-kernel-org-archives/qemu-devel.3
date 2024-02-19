Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AD52C48260
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Feb 2024 08:35:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rbz5T-0007ms-LV; Mon, 19 Feb 2024 03:33:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rbz50-0006Fd-OM; Mon, 19 Feb 2024 03:32:52 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rbz4w-0002gZ-Fv; Mon, 19 Feb 2024 03:32:49 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1d94323d547so25675735ad.3; 
 Mon, 19 Feb 2024 00:32:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708331559; x=1708936359; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AqJcwEYF2slviNbCC3uKHS3/EJsPd3jqqt+Z7W2Nd+A=;
 b=BsxffeYOExNDVekFB7jMRCe5r9g1ZoM/VTE2qtM4W+1dYcPP+62zdP1HtwiTxhkwjj
 kHJZrIu8ahu/CD7sIKRGJM60C+UaDOoUv2cBoUipRhjJ9HAw4LX6la1G7jEFszs3CPNr
 CWhZRXnl8Q2uDA40Vb0gCDwYfTp1s58vvEr25mCEpgfPIDOIK2BUFkZFZIQxyT7bhrU5
 SZQMYD2p4Y+ICCoKY8nGdUCplvS6G1Fv17M6sq//CBNL3aJHo128ACp8fLz92XJWpjMC
 QyFL2mvReHE2zAr5unH/k6gl57jIMC/isuk9wiOo8Xc4x1W+B4/X4z60Us9J1ZH6Uelw
 aMuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708331559; x=1708936359;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AqJcwEYF2slviNbCC3uKHS3/EJsPd3jqqt+Z7W2Nd+A=;
 b=fLHFMNeIRpsslx2It2k2OmfD762B+xjg/+E3xz9THMDRcezVlFzWtAhnWAHS0dQKw3
 aH66F8AXsXL+L3TQ30Q5zoCklUYYIcGLQTGhZU/G7NLbivlckA9utgHj/E1SOPsaFvUB
 Dlma76+wzTLvHFARhxzJ08lfLjtD0LRCuTBqw8JH7TRnPI4Pvqd/dnrTV3cJwBYnMV1A
 U3vlHBgwHeBxJhT/aql8CWcBJ2HrwgAA851XQTHdPjx0OzPubRHJYHWJL2pD456PKqTf
 XT5Uuxtp4WRnQ586l9NZW/3PUZoKsbpNatRr3qyHQowKBxx8YoqTXhvkb8bj/14k0kFE
 wK4w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXst7Fitgz6pnT5WtxT3N+tmHboibdf5QsIZ4ZGkmGraAdjzChVYLdGcyiKaEs156F40mObOmVFG9yJmY0KCjLN6y51
X-Gm-Message-State: AOJu0YwQKucsyeDEnz0QwMxTh2B5LuqnnFVsiQINg5V2ISclPpCUa8DP
 2v0DnUTpch/U5qdUwoG97sCQSCgnoszghSD5jeZ+Ocj7PR3w7pmDKEC5CerM
X-Google-Smtp-Source: AGHT+IGi/sjWnmIp1HcP2V7dHwa/DYivLnSSFyDKn4Ur2ATUnBwsdeRjQXxn4dNrul1GdE+E9elgJw==
X-Received: by 2002:a17:902:654a:b0:1d4:e0e6:693 with SMTP id
 d10-20020a170902654a00b001d4e0e60693mr10648989pln.35.1708331558890; 
 Mon, 19 Feb 2024 00:32:38 -0800 (PST)
Received: from wheely.local0.net ([1.146.38.93])
 by smtp.gmail.com with ESMTPSA id
 mo7-20020a1709030a8700b001db5ecd115bsm3838348plb.276.2024.02.19.00.32.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Feb 2024 00:32:38 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 36/49] target/ppc: Rename TBL to TB on 64-bit
Date: Mon, 19 Feb 2024 18:29:25 +1000
Message-ID: <20240219082938.238302-37-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240219082938.238302-1-npiggin@gmail.com>
References: <20240219082938.238302-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x634.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From the earliest PowerPC ISA, TBR (later SPR) 268 has been called TB
and accessed with mftb instruction. The problem is that TB is the name
of the 64-bit register, and 32-bit implementations can only read the
lower half with one instruction, so 268 has also been called TBL and
it does only read TBL on 32-bit.

Change SPR 268 to be called TB on 64-bit implementations.

Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/helper_regs.c  | 4 ++++
 target/ppc/ppc-qmp-cmds.c | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/target/ppc/helper_regs.c b/target/ppc/helper_regs.c
index 8324ff22db..8f5bd1536e 100644
--- a/target/ppc/helper_regs.c
+++ b/target/ppc/helper_regs.c
@@ -460,7 +460,11 @@ void register_generic_sprs(PowerPCCPU *cpu)
     }
 
     /* Time base */
+#if defined(TARGET_PPC64)
+    spr_register(env, SPR_VTBL,  "TB",
+#else
     spr_register(env, SPR_VTBL,  "TBL",
+#endif
                  &spr_read_tbl, SPR_NOACCESS,
                  &spr_read_tbl, SPR_NOACCESS,
                  0x00000000);
diff --git a/target/ppc/ppc-qmp-cmds.c b/target/ppc/ppc-qmp-cmds.c
index c0c137d9d7..ee0b99fce7 100644
--- a/target/ppc/ppc-qmp-cmds.c
+++ b/target/ppc/ppc-qmp-cmds.c
@@ -103,7 +103,11 @@ const MonitorDef monitor_defs[] = {
     { "xer", 0, &monitor_get_xer },
     { "msr", offsetof(CPUPPCState, msr) },
     { "tbu", 0, &monitor_get_tbu, },
+#if defined(TARGET_PPC64)
+    { "tb", 0, &monitor_get_tbl, },
+#else
     { "tbl", 0, &monitor_get_tbl, },
+#endif
     { NULL },
 };
 
-- 
2.42.0


