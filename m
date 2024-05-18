Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AFC0C25B74
	for <qemu-devel@archiver.kernel.org>; Sat, 18 May 2024 09:33:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s8GQi-0006T9-3L; Sat, 18 May 2024 05:32:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s8GQe-0006RW-F3; Sat, 18 May 2024 05:32:36 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s8GQb-0005tK-Tw; Sat, 18 May 2024 05:32:36 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1eca195a7c8so31830755ad.2; 
 Sat, 18 May 2024 02:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716024751; x=1716629551; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sYAW5npmFCrDzEP1Z4gIDF6q78kLtYXXiWAxpccYBJI=;
 b=E7mNFO/esd3GybA3nUGL0svf9R97LyspGma3BpfBOlb1+TUi59P/NA+pXFcZSEYk3M
 29v/D5QbPOay86UZjal9wLpT52CCLi0D0SY4oj4VGfdGQoo5cyWB8EaGjzT7kpjpRmrb
 Xv4qdVwIoQG/WdQs1pkvRNp+qJ5ad8O82U1zSywHhdmxKwpbOG4Rmi505reb8SV0WPNr
 joxZTfz6obhrU3pQzBSZpkswSlnsn1QZMzpVQ71MuJqU8CJXf0kcq2buK9wU6pU9jCXw
 v7Zw+VXS5iSp9B/n1hWvwyrOyxizF/rqZAK60kFpii57rorZWCqn8McwOknJX65iNVdV
 7jTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716024751; x=1716629551;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sYAW5npmFCrDzEP1Z4gIDF6q78kLtYXXiWAxpccYBJI=;
 b=mjtj4e4lqztecNSxdibNGLEkkhhwJse8k2L3rzcqCWZeAK9HqUIPBJ3Su9YEpENaK4
 nCHElQbNq+nqZtdB2atUIKE1Zpvj+TvLh6FGX66y4eBbRk1VTNmUXV7DlUTo6psQvWKQ
 5olLV/MfdY0YXFY8YUKJ3veT2HXwG9g3rC//DVm78mTYKXwubhR6X6sChr41KWhUBdAm
 ywrTU00HvZVh/V2O6cahm4pWw6on5nV2dnRHYOrVZrPhLO69jpu1Yfu439GuR/yiZDsq
 vD9139FMrAr1KQCYIK0eycVWdYfRoxVL84IULNzyr48Ub2mgELPlsLWXuplxS9PlfqMb
 XRfw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXjjPJmIN8ZVuuCd3uR6/PPpqTfJVkXccUOwkOVNhcc5rGwuExeePGIThJRWdolYW2nqR0AAXPCQ7RhZCEmDYxJVr+RRtE=
X-Gm-Message-State: AOJu0YzMPXuIGq02QgVTzWtL/WKL8HhzSSNdejnvR0KynFhns+3qX7EP
 jlhjonJxLPcO/XEpJEG+HFHjemujg1RamOdT3tarj/QAgO8aUDV7QtIejA==
X-Google-Smtp-Source: AGHT+IGgr64vNd0lmI6OTtLP84D8Lsd/hb5YeyxaGHkR+5NhcYGLMR2dqQyuIhhF+6J1NIyiswj/aA==
X-Received: by 2002:a17:90a:1282:b0:2bd:68a4:cc88 with SMTP id
 98e67ed59e1d1-2bd68a4cec1mr238843a91.47.1716024751133; 
 Sat, 18 May 2024 02:32:31 -0700 (PDT)
Received: from wheely.local0.net (110-175-65-7.tpgi.com.au. [110.175.65.7])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2b628ea6a05sm18518901a91.52.2024.05.18.02.32.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 May 2024 02:32:30 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Glenn Miles <milesg@linux.vnet.ibm.com>
Subject: [PATCH 07/14] target/ppc: Wire up BookE ATB registers for e500 family
Date: Sat, 18 May 2024 19:31:49 +1000
Message-ID: <20240518093157.407144-8-npiggin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240518093157.407144-1-npiggin@gmail.com>
References: <20240518093157.407144-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62f.google.com
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
index 462246cb7d..e186da5ef1 100644
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


