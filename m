Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBCDBC25B77
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2024 01:32:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9ELK-0007kj-Uq; Mon, 20 May 2024 21:31:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s9ELE-0007hd-Qp; Mon, 20 May 2024 21:31:01 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s9ELD-0005KN-8D; Mon, 20 May 2024 21:31:00 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1ee12baa01cso100637155ad.0; 
 Mon, 20 May 2024 18:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716255057; x=1716859857; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yt1vYtOLZ3aoBsS6/LYMaUEQfiphsblSQKxcObVD0IY=;
 b=fcHSZl/uZ7q6NjuVtbmjmXsEZ529t+zlmQolzVB7x0ZkWPktpz/gOpqN9r14lTt3ui
 04zNca0onHxDDACHyEU0vSLGmoylipnxyk9FdHX4LpBJoVJ4jgrNXvO9GZW3el9OnzJd
 ns75q8WcAI/9k4HN9R6IryvMxJmrTXXLTdk5KH/848v3eeZOgGsErtaLnELg5TBlnG3H
 3cLAu8aDC8S1ASqMe1oTgUCqPGT8p/62wlfoV9+2/3lxMo4+TAu2AYrCI8kdBeKW8Fp5
 rQesQpYrQpZyY+bQ1/8z78KKdmFfeqacQ7547NT+DkyXyU5Eb87oMPjQiU4JEMyioUlt
 hO6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716255057; x=1716859857;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yt1vYtOLZ3aoBsS6/LYMaUEQfiphsblSQKxcObVD0IY=;
 b=VSINcvZ9X36TOdyhnxMAKgz0CeuUJGRMCQuIoOuMnPnLvrULqsYjq3ThkLgC2j39Rc
 sVxkdjlOIcGZ088b2bxvXH7fm9ETalU9YNmfM/sqG1Oo24ETcFg/U7b05vvrfsezoKFz
 K3nhoTtHRCPf0mxvzOfaXOEEmBIRmlfl/65A4GeJGk8hYNxzuHSEZctTUEWpFEDLZxWM
 2wRbi5ZU6tMGSoxaY61QgoKcQlgtt8zFZTUFLoGgiYV++pYHCchwBrnrbTxmLgNE/xjf
 nkCBYPjFITHBXtR6ShQeivBxDKowAWBdM9cL2RDsoZX8/JZ6exelCMRCF4pXgfGcfXGz
 eHcQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWII0cuzS+nNI8YvPptZFSRIYJFYD088h6MdrL3t9+YU0Ar4AOcKYLi5csK/qegLm9847Ws4av4J2S8jlWQvgC5pYBKW28=
X-Gm-Message-State: AOJu0Yz6EU/37Tt5nTnxyFHa7xhmybiaslSdJ6hV7aysMBhrzaLeDgpj
 HPru8IqlxFrbz1+pe346+htYZN5CxWds0ml+En2aqaoe8fjfzM6oB86akA==
X-Google-Smtp-Source: AGHT+IHuusVkxnovyOtIhawZ0Wno0E2ysFn2y61lGOMKr4PgqyIpMftCq5nZWPSlEtFA4McKH7xSiQ==
X-Received: by 2002:a17:90b:4a43:b0:2bd:839f:7f36 with SMTP id
 98e67ed59e1d1-2bd839f7ff7mr3103481a91.10.1716255057358; 
 Mon, 20 May 2024 18:30:57 -0700 (PDT)
Received: from wheely.local0.net (110-175-65-7.tpgi.com.au. [110.175.65.7])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2bd7f0cd400sm2514953a91.31.2024.05.20.18.30.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 May 2024 18:30:57 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Glenn Miles <milesg@linux.vnet.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Chinmay Rath <rathc@linux.ibm.com>
Subject: [PATCH v2 05/12] target/ppc: Wire up BookE ATB registers for e500
 family
Date: Tue, 21 May 2024 11:30:21 +1000
Message-ID: <20240521013029.30082-6-npiggin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240521013029.30082-1-npiggin@gmail.com>
References: <20240521013029.30082-1-npiggin@gmail.com>
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

From the Freescale PowerPC Architecture Primer:

  Alternate time base APU. This APU, implemented on the e500v2, defines
  a 64-bit time base counter that differs from the PowerPC defined time
  base in that it is not writable and counts at a different, and
  typically much higher, frequency. The alternate time base always
  counts up, wrapping when the 64-bit count overflows.

This implementation of ATB uses the same frequency as the TB. The
existing spr_read_atbu/l functions are unused without this patch
to wire them into the SPR.

RTEMS uses this SPR on the e6500, though this hasn't been tested.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/cpu_init.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 927721d49a..892fb6ce02 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -920,6 +920,18 @@ static void register_BookE206_sprs(CPUPPCState *env, uint32_t mas_mask,
 #endif
 }
 
+static void register_atb_sprs(CPUPPCState *env)
+{
+    spr_register(env, SPR_ATBL, "ATBL",
+                 &spr_read_atbl, SPR_NOACCESS,
+                 &spr_read_atbl, SPR_NOACCESS,
+                 0x00000000);
+    spr_register(env, SPR_ATBU, "ATBU",
+                 &spr_read_atbu, SPR_NOACCESS,
+                 &spr_read_atbu, SPR_NOACCESS,
+                 0x00000000);
+}
+
 /* SPR specific to PowerPC 440 implementation */
 static void register_440_sprs(CPUPPCState *env)
 {
@@ -2927,6 +2939,11 @@ static void init_proc_e500(CPUPPCState *env, int version)
     register_BookE206_sprs(env, 0x000000DF, tlbncfg, mmucfg);
     register_usprgh_sprs(env);
 
+    if (version != fsl_e500v1) {
+        /* e500v1 has no support for alternate timebase */
+        register_atb_sprs(env);
+    }
+
     spr_register(env, SPR_HID0, "HID0",
                  SPR_NOACCESS, SPR_NOACCESS,
                  &spr_read_generic, &spr_write_generic,
-- 
2.43.0


