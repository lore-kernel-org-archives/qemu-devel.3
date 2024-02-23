Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC02CC54E4F
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 16:07:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdY11-0005r6-Hz; Fri, 23 Feb 2024 11:03:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rdXjw-0006Pw-3p; Fri, 23 Feb 2024 10:45:32 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rdXjt-0006dp-1M; Fri, 23 Feb 2024 10:45:31 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1dc1ff697f9so8317315ad.0; 
 Fri, 23 Feb 2024 07:45:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708703124; x=1709307924; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AqJcwEYF2slviNbCC3uKHS3/EJsPd3jqqt+Z7W2Nd+A=;
 b=WvbX7lvjWijBCcHjySJNb6qTYgbXs1hiZv3Q8Wx3NFfOxsm9rRkV400vPYy72R8vNq
 Q6egigVpufq7Zoy0dhHg3QBJTJhplnnXYYyxyy3JFip55nnN1obMwMxNXKNGga1xqBVs
 dpG1Mmjiyqawie1dqm6T4NV4IIS0ufQRQKMMWUt0HVyIE3C2oyR9KSyo2xev0SOEygrP
 6YOsT4+JZ+vf67mUZaSBICyCv3x7/xr9PcMAuE5Z0/5fSkqYRj0dJYf15rI3vEUTJ9ZK
 mVy4WEeEBDv/0Pww/cq/cmf1bC1MtTyjcxTTqA4Lt4GBhzZUQIUD7S0zCbcOnOD4In4w
 eftw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708703124; x=1709307924;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AqJcwEYF2slviNbCC3uKHS3/EJsPd3jqqt+Z7W2Nd+A=;
 b=mGFpzh03ZQQOo0JCsGbmxpneq1k4KxDu3d6YMlfmbtVc8UiL9kCTDRneUYEoI/fBLT
 N3FFskHYpdy+Jtz3m/ClYj4KUyw972VZoD+x3dBjKKlyfMt6G268lRSzL6P1pqGbTbtC
 YXcvD1cIZtpuwBFhDRsDdEFaYEvbnoN+ZbsifVPi8K1AaJHsf22Hsh9TiuITpCexcvb9
 zQZ1jsRiKDwePPRx5vzRsZRLibnfyXxBO/eRz5P36sDTKIWZmFnFq5gP+hLiR8ptkggL
 lPyhkniDdJQvU/1VCrS6nJENyv504qHXWdtlPsPfrhG512mGGU0UeBNrptJdjXaJho4+
 UBYQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXWzLepz/1ceJRDv+05TI3ydgCRKuzeWu9pmAEdLVX2Pzs7Cm5SXeCAL1jgRi+eks8TS//xicjcos0wJIB5pSpehlSE
X-Gm-Message-State: AOJu0Yz20lxIFwvD0THNZZ7AIEjrIDFPge+I+B4wSPR8AAZVlMoQmDI9
 VyCAD/6yqCWxehIxS9dMMyeR83EavVQv05lU9cDkZ2wh9jGmNHlQsXftAGXt
X-Google-Smtp-Source: AGHT+IEaIMOzX1OmpgIIwLVeGBI+ygeJRse3g0jULO7jxBFwqstbKW4XfsaAIleETaU+qk2CLC+INQ==
X-Received: by 2002:a17:903:2343:b0:1db:d256:9327 with SMTP id
 c3-20020a170903234300b001dbd2569327mr241969plh.19.1708703124323; 
 Fri, 23 Feb 2024 07:45:24 -0800 (PST)
Received: from wheely.local0.net (220-235-194-103.tpgi.com.au.
 [220.235.194.103]) by smtp.gmail.com with ESMTPSA id
 h18-20020a170902f2d200b001d913992d8csm11808208plc.242.2024.02.23.07.45.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Feb 2024 07:45:24 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 34/47] target/ppc: Rename TBL to TB on 64-bit
Date: Sat, 24 Feb 2024 01:41:53 +1000
Message-ID: <20240223154211.1001692-35-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240223154211.1001692-1-npiggin@gmail.com>
References: <20240223154211.1001692-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62d.google.com
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


